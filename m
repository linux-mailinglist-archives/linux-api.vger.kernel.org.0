Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA06B12FA66
	for <lists+linux-api@lfdr.de>; Fri,  3 Jan 2020 17:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgACQ37 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jan 2020 11:29:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46935 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgACQ3t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jan 2020 11:29:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id y8so19206332pll.13
        for <linux-api@vger.kernel.org>; Fri, 03 Jan 2020 08:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UWSFU4rM9RHMIspmvrVtm6e/ADZJ6PqmZ45gyV6IOQ=;
        b=V8eOLp8BDObzV26eoZrEdBQZEzBuImB4+Z+tWLdN/l/qev4BkyyacRnxkSzj/dB57m
         UHN666/MBNIBdoYLe8Zs9dU8nj2aNVSS8SsSI6tjoCn5PD0ZQu+86FXhA7cehBqWfRvM
         ykpgbBXIwOpzybn1mUXwUBE007Wqj8lSq5CuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UWSFU4rM9RHMIspmvrVtm6e/ADZJ6PqmZ45gyV6IOQ=;
        b=s93BFXgueCaI9nPoqzF0mmwZlQMOMariiXO+zuHVOMimbwa+sc86mkKPVhSSCVc/9L
         mBKZlIU/wfDVdRCC8LkRJ4Os78DppEeuMLcbC6BvEAUbDWwOmsUMS16lXb1MfH3f20Vn
         KaoBJRG4rO1WEEDMpdLCV5fH3pupQCpnLj/UDAgy23wWVsZKy0wvxn7cEGcZHeEA9Xde
         jIvsGZq8R8oho23JAss80xKeqtuJnTk/CYLdh/bXTFK1PgEQC6W4YYlC1v6FgrMvegC8
         dfp6vdOLi8Mob603VrV0VrlQOgoG89WgvIFFZ5geOjkVLILJiuyrLj+OBpYDOommKo/G
         LktA==
X-Gm-Message-State: APjAAAX+bwPQndnHVULoyoqXDjxrdwKlPv8rq89hPY/hVcwJcEcqVOEW
        IUKk7BphmgocAimt1nmwRJA9uw==
X-Google-Smtp-Source: APXvYqyZIaFZcs9dEMyXy2lyIdgkwVt9N2wc1FpKhwmAVBa0PPYO2KAkESVOKR1zMSOpHZVhMm32gQ==
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr91395329plz.264.1578068987396;
        Fri, 03 Jan 2020 08:29:47 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m22sm67373970pgn.8.2020.01.03.08.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 08:29:46 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, tycho@tycho.ws,
        jannh@google.com, cyphar@cyphar.com, christian.brauner@ubuntu.com,
        oleg@redhat.com, luto@amacapital.net, viro@zeniv.linux.org.uk,
        gpascutto@mozilla.com, ealvarez@mozilla.com, fweimer@redhat.com,
        jld@mozilla.com, arnd@arndb.de
Subject: [PATCH v8 2/3] pid: Introduce pidfd_getfd syscall
Date:   Fri,  3 Jan 2020 08:29:27 -0800
Message-Id: <20200103162928.5271-3-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200103162928.5271-1-sargun@sargun.me>
References: <20200103162928.5271-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This syscall allows for the retrieval of file descriptors from other
processes, based on their pidfd. This is possible using ptrace, and
injection of parasitic code to inject code which leverages SCM_RIGHTS
to move file descriptors between a tracee and a tracer. Unfortunately,
ptrace comes with a high cost of requiring the process to be stopped,
and breaks debuggers. This does not require stopping the process under
manipulation.

One reason to use this is to allow sandboxers to take actions on file
descriptors on the behalf of another process. For example, this can be
combined with seccomp-bpf's user notification to do on-demand fd
extraction and take privileged actions. One such privileged action
is binding a socket to a privileged port.

This also adds the syscall to all architectures at the same time.

/* prototype */
  /* flags is currently reserved and should be set to 0 */
  int sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);

/* testing */
Ran self-test suite on x86_64

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  1 +
 arch/arm/tools/syscall.tbl                  |  1 +
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           |  2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       |  1 +
 arch/microblaze/kernel/syscalls/syscall.tbl |  1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  1 +
 arch/parisc/kernel/syscalls/syscall.tbl     |  1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  1 +
 arch/s390/kernel/syscalls/syscall.tbl       |  1 +
 arch/sh/kernel/syscalls/syscall.tbl         |  1 +
 arch/sparc/kernel/syscalls/syscall.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_32.tbl      |  1 +
 arch/x86/entry/syscalls/syscall_64.tbl      |  1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     |  1 +
 include/linux/syscalls.h                    |  1 +
 include/uapi/asm-generic/unistd.h           |  4 +-
 kernel/pid.c                                | 90 +++++++++++++++++++++
 21 files changed, 113 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 8e13b0b2928d..82301080f5e7 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 543	common	fspick				sys_fspick
 544	common	pidfd_open			sys_pidfd_open
 # 545 reserved for clone3
+548	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 6da7dc4d79cc..ba045e2f3a60 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -449,3 +449,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 2629a68b8724..b722e47377a5 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -38,7 +38,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		436
+#define __NR_compat_syscalls		439
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 94ab29cf4f00..a8da97a2de41 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -879,6 +879,8 @@ __SYSCALL(__NR_fspick, sys_fspick)
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
+#define __NR_pidfd_getfd 438
+__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 36d5faf4c86c..2b11adfc860c 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -356,3 +356,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index a88a285a0e5f..44e879e98459 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -435,3 +435,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 09b0cd7dab0a..7afa00125cc4 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index e7c5ab38e403..856d5ba34461 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -374,3 +374,4 @@
 433	n32	fspick				sys_fspick
 434	n32	pidfd_open			sys_pidfd_open
 435	n32	clone3				__sys_clone3
+438	n32	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 13cd66581f3b..2db6075352f3 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -350,3 +350,4 @@
 433	n64	fspick				sys_fspick
 434	n64	pidfd_open			sys_pidfd_open
 435	n64	clone3				__sys_clone3
+438	n64	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 353539ea4140..e9f9d4a9b105 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -423,3 +423,4 @@
 433	o32	fspick				sys_fspick
 434	o32	pidfd_open			sys_pidfd_open
 435	o32	clone3				__sys_clone3
+438	o32	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 285ff516150c..c58c7eb144ca 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -433,3 +433,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3_wrapper
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 43f736ed47f2..707609bfe3ea 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	nospu	clone3				ppc_clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 3054e9c035a3..185cd624face 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433  common	fspick			sys_fspick			sys_fspick
 434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
 435  common	clone3			sys_clone3			sys_clone3
+438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index b5ed26c4c005..88f90895aad8 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -438,3 +438,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8c8cc7537fb2..218df6a2326e 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -481,3 +481,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 # 435 reserved for clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 15908eb9b17e..9c3101b65e0f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -440,3 +440,4 @@
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
 434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
 435	i386	clone3			sys_clone3			__ia32_sys_clone3
+438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index c29976eca4a8..cef85db75a62 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -357,6 +357,7 @@
 433	common	fspick			__x64_sys_fspick
 434	common	pidfd_open		__x64_sys_pidfd_open
 435	common	clone3			__x64_sys_clone3/ptregs
+438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 25f4de729a6d..ae15183def12 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -406,3 +406,4 @@
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
 435	common	clone3				sys_clone3
+438	common	pidfd_getfd			sys_pidfd_getfd
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2960dedcfde8..5edbc31af51f 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1000,6 +1000,7 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
+asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1fc8faa6e973..d36ec3d645bd 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -850,9 +850,11 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
 #endif
+#define __NR_pidfd_getfd 438
+__SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 
 #undef __NR_syscalls
-#define __NR_syscalls 436
+#define __NR_syscalls 439
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/pid.c b/kernel/pid.c
index 2278e249141d..0f4ecb57214c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -578,3 +578,93 @@ void __init pid_idr_init(void)
 	init_pid_ns.pid_cachep = KMEM_CACHE(pid,
 			SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 }
+
+static struct file *__pidfd_fget(struct task_struct *task, int fd)
+{
+	struct file *file;
+	int ret;
+
+	ret = mutex_lock_killable(&task->signal->cred_guard_mutex);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS))
+		file = fget_task(task, fd);
+	else
+		file = ERR_PTR(-EPERM);
+
+	mutex_unlock(&task->signal->cred_guard_mutex);
+
+	return file ?: ERR_PTR(-EBADF);
+}
+
+static int pidfd_getfd(struct pid *pid, int fd)
+{
+	struct task_struct *task;
+	struct file *file;
+	int ret;
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
+
+	file = __pidfd_fget(task, fd);
+	put_task_struct(task);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	ret = security_file_receive(file);
+	if (ret) {
+		fput(file);
+		return ret;
+	}
+
+	ret = get_unused_fd_flags(O_CLOEXEC);
+	if (ret < 0)
+		fput(file);
+	else
+		fd_install(ret, file);
+
+	return ret;
+}
+
+/**
+ * sys_pidfd_getfd() - Get a file descriptor from another process
+ *
+ * @pidfd:	the pidfd file descriptor of the process
+ * @fd:		the file descriptor number to get
+ * @flags:	flags on how to get the fd (reserved)
+ *
+ * This syscall gets a copy of a file descriptor from another process
+ * based on the pidfd, and file descriptor number. It requires that
+ * the calling process has the ability to ptrace the process represented
+ * by the pidfd. The process which is having its file descriptor copied
+ * is otherwise unaffected.
+ *
+ * Return: On success, a cloexec file descriptor is returned.
+ *         On error, a negative errno number will be returned.
+ */
+SYSCALL_DEFINE3(pidfd_getfd, int, pidfd, int, fd,
+		unsigned int, flags)
+{
+	struct pid *pid;
+	struct fd f;
+	int ret;
+
+	/* flags is currently unused - make sure it's unset */
+	if (flags)
+		return -EINVAL;
+
+	f = fdget(pidfd);
+	if (!f.file)
+		return -EBADF;
+
+	pid = pidfd_pid(f.file);
+	if (IS_ERR(pid))
+		ret = PTR_ERR(pid);
+	else
+		ret = pidfd_getfd(pid, fd);
+
+	fdput(f);
+	return ret;
+}
-- 
2.20.1

