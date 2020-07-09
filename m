Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450F021A680
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgGISAq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 14:00:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60978 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbgGISAq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 14:00:46 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E84ED2A65F0
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org, arnd@arndb.de
Subject: [RFC v2 1/4] futex2: Add new futex interface
Date:   Thu,  9 Jul 2020 14:59:18 -0300
Message-Id: <20200709175921.211387-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200709175921.211387-1-andrealmeid@collabora.com>
References: <20200709175921.211387-1-andrealmeid@collabora.com>
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

This new interface is able just to wait and wake on a 32 bits user futex.
The wait operation supports timeout with absolute values only, using
timespec64, in monotonic or realtime mode. This syscall is not compatible
with ABIs that have timesize as 32 bits, only the ones that support 64
bits timesize. The code can be found in my git tree[1].

The design of this syscall was based on the discussion following the
"futex: Implement mechanism to wait on any of several futexes" patch[2].

In order to test the code, the glibc 2.31 low level futex code was
modified to use the new syscall. It's possible to find the code here[3].
After running the tests of glibc (`make check subdir=nptl`), only 26
tests of 370 didn't passed, and since they are all related to FUTEX_PI,
which isn't implemented in the new interface, those failures were expected.
All kernel selftests were successful.

[1] https://gitlab.collabora.com/tonyk/linux/-/commits/futex2
[2] https://lore.kernel.org/patchwork/patch/1194339/
[3] https://gitlab.collabora.com/tonyk/glibc/-/commits/futex2

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 MAINTAINERS                            |  2 +-
 arch/x86/entry/syscalls/syscall_32.tbl |  2 +
 arch/x86/entry/syscalls/syscall_64.tbl |  2 +
 include/linux/syscalls.h               |  7 +++
 include/uapi/asm-generic/unistd.h      |  8 ++-
 include/uapi/linux/futex.h             | 10 ++++
 init/Kconfig                           |  7 +++
 kernel/Makefile                        |  1 +
 kernel/futex2.c                        | 73 ++++++++++++++++++++++++++
 kernel/sys_ni.c                        |  4 ++
 10 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 kernel/futex2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 68f21d46614c..b4f60532317b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7104,7 +7104,7 @@ F:	Documentation/locking/*futex*
 F:	include/asm-generic/futex.h
 F:	include/linux/futex.h
 F:	include/uapi/linux/futex.h
-F:	kernel/futex.c
+F:	kernel/futex*
 F:	tools/perf/bench/futex*
 F:	Documentation/locking/*futex*
 
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index d8f8a1a69ed1..f7a263f1ca98 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,5 @@
 437	i386	openat2			sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd
 439	i386	faccessat2		sys_faccessat2
+440	i386	futex_wait		sys_futex_wait
+441	i386	futex_wake		sys_futex_wake
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 78847b32e137..310eb1fd9a1e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,8 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
+440	common	futex_wait		sys_futex_wait
+441	common	futex_wake		sys_futex_wake
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 7c354c2955f5..04fe9f20f522 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -588,6 +588,13 @@ asmlinkage long sys_get_robust_list(int pid,
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+/* kernel/futex2.c */
+asmlinkage long sys_futex_wait(void __user *uaddr, unsigned long val,
+			       unsigned long flags,
+			       struct __kernel_timespec __user __user *timo);
+asmlinkage long sys_futex_wake(void __user *uaddr, unsigned long nr_wake,
+			       unsigned long flags);
+
 /* kernel/hrtimer.c */
 asmlinkage long sys_nanosleep(struct __kernel_timespec __user *rqtp,
 			      struct __kernel_timespec __user *rmtp);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index f4a01305d9a6..e3e03350ae76 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -858,8 +858,14 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_faccessat2 439
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 
+#define __NR_futex_wait 440
+__SYSCALL(__NR_futex_wait, sys_futex_wait)
+
+#define __NR_futex_wake 441
+__SYSCALL(__NR_futex_wake, sys_futex_wake)
+
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 442
 
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
index a46aa8f3174d..166dec71dae4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1493,6 +1493,13 @@ config FUTEX
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
index f3218bc5ec69..7698187de0b0 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_PROFILING) += profile.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-y += time/
 obj-$(CONFIG_FUTEX) += futex.o
+obj-$(CONFIG_FUTEX2) += futex2.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += smp.o
 ifneq ($(CONFIG_SMP),y)
diff --git a/kernel/futex2.c b/kernel/futex2.c
new file mode 100644
index 000000000000..b87a10ba7c01
--- /dev/null
+++ b/kernel/futex2.c
@@ -0,0 +1,73 @@
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
+/**
+ * sys_futex_wait: Wait on a futex address if (*uaddr) == val
+ * @uaddr: User address of futex
+ * @val:   Expected value of futex
+ * @flags: Checks if futex is private, the size of futex and the clockid
+ * @timo:  Optional absolute timeout. Supports only 64bit time.
+ */
+SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, unsigned long, val,
+		unsigned long, flags, struct __kernel_timespec __user *, timo)
+{
+	int op = FUTEX_WAIT | (flags & (FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME));
+	unsigned int size = flags & FUTEX_SIZE_MASK;
+	struct timespec64 ts;
+	ktime_t aux, *kt = NULL;
+
+	if (flags & ~FUTEX2_MASK)
+		return -EINVAL;
+
+	if (size != FUTEX_32)
+		return -EINVAL;
+
+	if (timo) {
+		if (get_timespec64(&ts, timo))
+			return -EFAULT;
+
+		if (!timespec64_valid(&ts))
+			return -EINVAL;
+
+		aux = timespec64_to_ktime(ts);
+		kt = &aux;
+	}
+
+	return do_futex(uaddr, op, val, kt, NULL, 0, 0);
+}
+
+/**
+ * sys_futex_wake: Wake a number of futexes waiting in an address
+ * @uaddr:   Address of futex to be woken up
+ * @nr_wake: Number of futexes to be woken up
+ * @flags:   Checks if futex is private and the size of futex
+ */
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
index 3b69a560a7ac..f04965322a2e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -148,6 +148,10 @@ COND_SYSCALL_COMPAT(set_robust_list);
 COND_SYSCALL(get_robust_list);
 COND_SYSCALL_COMPAT(get_robust_list);
 
+/* kernel/futex2.c */
+COND_SYSCALL(futex_wait);
+COND_SYSCALL(futex_wake);
+
 /* kernel/hrtimer.c */
 
 /* kernel/itimer.c */
-- 
2.27.0

