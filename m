Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443711F7D2C
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2020 20:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFLSva (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Jun 2020 14:51:30 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37958 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSv3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Jun 2020 14:51:29 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 563A92A57E5
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org
Subject: [RFC 1/4] futex2: Add new futex interface
Date:   Fri, 12 Jun 2020 15:51:19 -0300
Message-Id: <20200612185122.327860-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200612185122.327860-1-andrealmeid@collabora.com>
References: <20200612185122.327860-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a new futex interface into the kernel, namely futex2. This first
piece of work just introduces the new interface without new feature for
now, using all mechanisms of the old interface in order to work. This
way we can properly formalize the expectations around the new design,
while being able to expand the code as we need and even in parallel
efforts if possible.

This new interface is able just to wait and wake on a 32-bit user futex.
The wait operation supports timeout with absolute values only, using
time_t/ktime_t (aka u64), in monotonic or realtime mode in a nsec
resolution. The code can be found in my git tree[1].

The design of this syscall was based on the discussion following the
"futex: Implement mechanism to wait on any of several futexes" patch[2].

In order to test the code, the glibc low level futex code was
modified to use the new syscall. It's possible to find the code here[3].
After running the tests of glibc (`make check subdir=nptl`), only 26
tests of 370 didn't passed, and since they are all related to FUTEX_PI,
which isn't implemented in the new interface, those failures were expected.

[1] https://gitlab.collabora.com/tonyk/linux/-/commits/futex2
[2] https://lore.kernel.org/patchwork/patch/1194339/
[3] https://gitlab.collabora.com/tonyk/glibc/-/commits/futex2

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 MAINTAINERS                            |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl |  2 +
 arch/x86/entry/syscalls/syscall_64.tbl |  2 +
 include/linux/syscalls.h               |  9 +++
 include/uapi/asm-generic/unistd.h      |  7 +-
 include/uapi/linux/futex.h             | 10 +++
 init/Kconfig                           |  7 ++
 kernel/Makefile                        |  1 +
 kernel/futex2.c                        | 97 ++++++++++++++++++++++++++
 kernel/sys_ni.c                        |  5 ++
 10 files changed, 140 insertions(+), 2 deletions(-)
 create mode 100644 kernel/futex2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..9da4f9e9c750 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7024,7 +7024,7 @@ F:	Documentation/*futex*
 F:	include/asm-generic/futex.h
 F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h
-F:	kernel/futex.c
+F:	kernel/futex*
 F:	tools/perf/bench/futex*
 F:	tools/testing/selftests/futex/
 
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 54581ac671b4..785c91467c23 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -442,3 +442,5 @@
 435	i386	clone3			sys_clone3
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
+439	i386	futex_wait		sys_futex_wait_time32
+440	i386	futex_wake		sys_futex_wake
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 37b844f839bc..b61f07ca401b 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -359,6 +359,8 @@
 435	common	clone3			sys_clone3
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
+439	common	futex_wait		sys_futex_wait
+440	common	futex_wake		sys_futex_wake
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 1815065d52f3..84c82eb410c2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -586,6 +586,15 @@ asmlinkage long sys_get_robust_list(int pid,
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+/* kernel/futex2.c */
+asmlinkage long sys_futex_wait(void __user *uaddr, unsigned long val,
+			       unsigned long flags, ktime_t __user *timo);
+asmlinkage long sys_futex_wait_time32(void __user *uaddr, unsigned long val,
+				      unsigned long flags,
+				      old_time32_t __user *timo);
+asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long nr_wake,
+			       unsigned long flags);
+
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 3a3201e4618e..e050b9669fc3 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -320,6 +320,8 @@ __SYSCALL(__NR_unshare, sys_unshare)
 #if defined(__ARCH_WANT_TIME32_SYSCALLS) || __BITS_PER_LONG != 32
 #define __NR_futex 98
 __SC_3264(__NR_futex, sys_futex_time32, sys_futex)
+#define __NR_futex_wait 439
+__SC_3264(__NR_futex_wait, sys_futex_wait_time32, sys_futex_wait)
 #endif
 #define __NR_set_robust_list 99
 __SC_COMP(__NR_set_robust_list, sys_set_robust_list, \
@@ -856,8 +858,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 #define __NR_pidfd_getfd 438
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 
+#define __NR_futex_wake 440
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
+
 #undef __NR_syscalls
-#define __NR_syscalls 439
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
index a89eb0accd5e..1e67778690eb 100644
--- a/include/uapi/linux/futex.h
+++ b/include/uapi/linux/futex.h
@@ -41,6 +41,16 @@
 #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
 
+/* Size argument to futex2 syscall */
+#define FUTEX_8		0
+#define FUTEX_16	1
+#define FUTEX_32	2
+#if __BITS_PER_LONG == 64 || defined(__x86_64__)
+# define FUTEX_64	3
+#endif
+
+#define FUTEX_SIZE_MASK	0x3
+
 /*
  * Support for robust futexes: the kernel cleans up held futexes at
  * thread exit time.
diff --git a/init/Kconfig b/init/Kconfig
index 74a5ac65644f..24806a672958 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1456,6 +1456,13 @@ config FUTEX
 	  support for "fast userspace mutexes".  The resulting kernel may not
 	  run glibc-based applications correctly.
 
+config FUTEX2
+	bool "Enable futex2 support" if EXPERT
+	depends on FUTEX
+	default n
+	help
+	  Experimental support for futex2 interface.
+
 config FUTEX_PI
 	bool
 	depends on FUTEX && RT_MUTEXES
diff --git a/kernel/Makefile b/kernel/Makefile
index 4cb4130ced32..3c74d0b4b125 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
 obj-$(CONFIG_FUTEX) += futex.o
+obj-$(CONFIG_FUTEX2) += futex2.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += smp.o
 ifneq ($(CONFIG_SMP),y)
diff --git a/kernel/futex2.c b/kernel/futex2.c
new file mode 100644
index 000000000000..427c58916dd6
--- /dev/null
+++ b/kernel/futex2.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * futex2 system call interface by André Almeida <andrealmeid@collabora.com>
+ *
+ * Copyright 2020 Collabora Ltd.
+ */
+
+#include <linux/syscalls.h>
+
+#include <asm/futex.h>
+
+/*
+ * Set of flags that futex2 operates. If we got something that is not in this
+ * set, it can be a unsupported futex1 operation like BITSET or PI, so we
+ * refuse to accept
+ */
+#define FUTEX2_MASK (FUTEX_SIZE_MASK | FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
+
+SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, unsigned long, val,
+		unsigned long, flags, ktime_t __user *, timo)
+{
+	int op = FUTEX_WAIT | (flags & (FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME));
+	unsigned int size = flags & FUTEX_SIZE_MASK;
+	ktime_t *kt = NULL;
+	ktime_t aux = 0;
+
+	if (flags & ~FUTEX2_MASK)
+		return -EINVAL;
+
+	if (size != FUTEX_32)
+		return -EINVAL;
+
+	if (timo) {
+		if (copy_from_user(&aux, timo, sizeof(*timo)) != 0)
+			return -EINVAL;
+		kt = &aux;
+	}
+
+	return do_futex(uaddr, op, val, kt, NULL, 0, 0);
+}
+
+/*
+ * The timeout of compat syscall implementation doesn't worked properly, given
+ * that i386 ABI apps uses time_t as int32_t. 32 bits is not enough to hold all
+ * nanoseconds since epoch nowadays. Given that, those are the solutions that I
+ * could think of:
+ *
+ * * Use timespec, as in old futex. This will be enough to get both ABIs working
+ *
+ * * Instead of using a nanosecond resolution, use everything as seconds, to
+ *   time32_t will be enough to keep working until y2038. Additionally, a flag
+ *   FUTEX_NSEC_FLAG can be added to archs that support 64 bits sized time_t to
+ *   make available for waiters that wants nsec resolution.
+ *
+ * * Just implement sys_futex_wait_time64 for i386 ABI, and i386 apps will need
+ *   to wait until glibc solves the y2038 dilemma, or need to implement time64_t
+ *   by themselves.
+ */
+#ifdef CONFIG_COMPAT_32BIT_TIME
+SYSCALL_DEFINE4(futex_wait_time32, void __user *, uaddr, unsigned long, val,
+		unsigned long, flags, old_time32_t __user *, timo)
+{
+	int op = FUTEX_WAIT | (flags & (FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME));
+	unsigned int size = flags & FUTEX_SIZE_MASK;
+	ktime_t *kt = NULL;
+	__kernel_old_time_t aux = 0;
+
+	if (flags & ~FUTEX2_MASK)
+		return -EINVAL;
+
+	if (size != FUTEX_32)
+		return -EINVAL;
+
+	if (timo) {
+		if (copy_from_user(&aux, timo, sizeof(*timo)) != 0)
+			return -EINVAL;
+		kt = (ktime_t *)&aux;
+	}
+
+	return do_futex(uaddr, op, val, kt, NULL, 0, 0);
+}
+#endif /* CONFIG_COMPAT_32BIT_TIME */
+
+SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
+		unsigned long, flags)
+{
+	int op = FUTEX_WAKE | (flags & (FUTEX_PRIVATE_FLAG));
+	unsigned int size = flags & FUTEX_SIZE_MASK;
+
+	if (flags & ~FUTEX2_MASK)
+		return -EINVAL;
+
+	if (size != FUTEX_32)
+		return -EINVAL;
+
+	return do_futex(uaddr, op, nr_wake, NULL, NULL, 0, 0);
+}
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 3b69a560a7ac..6291eacf9f28 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -148,6 +148,11 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 
+/* kernel/futex2.c */
+COND_SYSCALL(futex_wait);
+COND_SYSCALL(futex_wait_time32);
+COND_SYSCALL(futex_wake);
+
 /* kernel/hrtimer.c */
 
 /* kernel/itimer.c */
-- 
2.27.0

