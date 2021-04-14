Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD335EC99
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 07:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbhDNFzT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 01:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348074AbhDNFzR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 01:55:17 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDB4C061574;
        Tue, 13 Apr 2021 22:54:57 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c2so2041311plz.0;
        Tue, 13 Apr 2021 22:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJ8lWwNyXx9PWCXUgzt7/FGjnnOaq/O9YNHNgroeZ4o=;
        b=WsKgemy+ukJyCmAw3Yd3cAwHxmtGjxgWSZ3D/uye7rAJMGB3JOSUjGSRgvc/xvmr1U
         YuVpPoHdLfAfUVNXQJc79Xi4cOWooBD8iaBeCdRvLmfWqNOiTzNfKOnY+XWoKD/s131N
         IM/379vDhOPVbUABd5zwL+0vNBypYh0zEGUdJQ2gjEpaXPzAziSv3+tsDH8vk1ZRsmbs
         0ZR44CwqPy0e4vkdCNuMlq+TXph8bfvP0pe3hcmU+kFX06RM6JmE3LpOzsM0LbZHDgvM
         JYT1CHMQ6IAWYkzkwHDcY0Myq3TL/7IRlGr1o9UKQq0ng0qGmKxaWXF7VP222jc+dXUS
         M4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XJ8lWwNyXx9PWCXUgzt7/FGjnnOaq/O9YNHNgroeZ4o=;
        b=gcnue4rnlUgvhJBuWu/V0zrp6CRbQICNwlyPsOrU2no5xwCngxTNriB6l4m4lY4QRL
         BIj81buM2Pz5PYmwjxzfosCzZm4vxsAjvT6cOHbKksxhGSW0xU9LKp0IseHO4g5JzHzs
         LX1lCqtvnTWssAxgPoUIZfPpLrUf+fqUHhPF+MT3I7jopUBuLFIOP/NiJXyVyfs4+pGw
         /IeFg4utB45v/RAZ3zVCBOqKH00u/6nsXdkUm5Y5fF4W4zznMtZ5S3mHAwvihXglqKkd
         wDyLh016W2tkPGuOpuBaUHvQbAhUh64JYZNxDfyH8gTMbzIYF5t556TGoSLWOM+TE87H
         Ongw==
X-Gm-Message-State: AOAM531P4R5RwjMF8lVS15jbmvWBaFgTtdzfoaBUo6JyuvUyi40dx/Iz
        pQRFYaFZvvE8hiQGsTDh6++BKqUv3HIKUz+b
X-Google-Smtp-Source: ABdhPJzoWE/W3Cq6E+3Orhp+wyrlvAWba8a2G7KxAP+xq3Ca/t+ccDfPs9n7f6DQTJMYR83M3hSkTg==
X-Received: by 2002:a17:90a:1f49:: with SMTP id y9mr1771959pjy.69.1618379696125;
        Tue, 13 Apr 2021 22:54:56 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id u17sm13728969pfm.113.2021.04.13.22.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 22:54:55 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Date:   Tue, 13 Apr 2021 22:52:15 -0700
Message-Id: <20210414055217.543246-3-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This change introduces the new system call:
process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
		siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)

process_vm_exec allows to execute the current process in an address
space of another process.

process_vm_exec swaps the current address space with an address space of
a specified process, sets a state from sigcontex and resumes the process.
When a process receives a signal or calls a system call,
process_vm_exec saves the process state back to sigcontext, restores the
origin address space, restores the origin process state, and returns to
userspace.

If it was interrupted by a signal and the signal is in the user_mask,
the signal is dequeued and information about it is saved in uinfo.
If process_vm_exec is interrupted by a system call, a synthetic siginfo
for the SIGSYS signal is generated.

The behavior of this system call is similar to PTRACE_SYSEMU but
everything is happing in the context of one process, so
process_vm_exec shows a better performance.

PTRACE_SYSEMU is primarily used to implement sandboxes (application
kernels) like User-mode Linux or gVisor. These type of sandboxes
intercepts applications system calls and acts as the guest kernel.
A simple benchmark, where a "tracee" process executes systems calls in a
loop and a "tracer" process traps syscalls and handles them just
incrementing the tracee instruction pointer to skip the syscall
instruction shows that process_vm_exec works more than 5 times faster
than PTRACE_SYSEMU.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/Kconfig                           |  15 +++
 arch/x86/Kconfig                       |   1 +
 arch/x86/entry/common.c                |  16 +++
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 arch/x86/include/asm/sigcontext.h      |   2 +
 arch/x86/kernel/Makefile               |   1 +
 arch/x86/kernel/process_vm_exec.c      | 133 +++++++++++++++++++++++++
 arch/x86/kernel/signal.c               |  47 +++++++++
 include/linux/process_vm_exec.h        |  15 +++
 include/linux/sched.h                  |   7 ++
 include/linux/syscalls.h               |   6 ++
 include/uapi/asm-generic/unistd.h      |   4 +-
 kernel/fork.c                          |   9 ++
 kernel/sys_ni.c                        |   2 +
 14 files changed, 258 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kernel/process_vm_exec.c
 create mode 100644 include/linux/process_vm_exec.h

diff --git a/arch/Kconfig b/arch/Kconfig
index ba4e966484ab..3ed9b8fb1727 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -514,6 +514,21 @@ config SECCOMP_FILTER
 
 	  See Documentation/userspace-api/seccomp_filter.rst for details.
 
+config HAVE_ARCH_PROCESS_VM_EXEC
+	bool
+	help
+	  An arch should select this symbol to support the process_vm_exec system call.
+
+config PROCESS_VM_EXEC
+	prompt "Enable the process_vm_exec syscall"
+	def_bool y
+	depends on HAVE_ARCH_PROCESS_VM_EXEC
+	help
+	  process_vm_exec allows executing code and system calls in a specified
+	  address space.
+
+	  If unsure, say Y.
+
 config HAVE_ARCH_STACKLEAK
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fbf26e0f7a6a..1c7ebb58865e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -27,6 +27,7 @@ config X86_64
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_SOFT_DIRTY
+	select HAVE_ARCH_PROCESS_VM_EXEC
 	select MODULES_USE_ELF_RELA
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 870efeec8bda..42eac459b25b 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/process_vm_exec.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -38,6 +39,21 @@
 #ifdef CONFIG_X86_64
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
+#ifdef CONFIG_PROCESS_VM_EXEC
+	if (current->exec_mm && current->exec_mm->ctx) {
+		kernel_siginfo_t info = {
+			.si_signo = SIGSYS,
+			.si_call_addr = (void __user *)KSTK_EIP(current),
+			.si_arch = syscall_get_arch(current),
+			.si_syscall = nr,
+		};
+		restore_vm_exec_context(regs);
+		regs->ax = copy_siginfo_to_user(current->exec_mm->siginfo, &info);
+		syscall_exit_to_user_mode(regs);
+		return;
+	}
+#endif
+
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 379819244b91..2a8e27b2d87e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -362,6 +362,7 @@
 438	common	pidfd_getfd		sys_pidfd_getfd
 439	common	faccessat2		sys_faccessat2
 440	common	process_madvise		sys_process_madvise
+441	64	process_vm_exec		sys_process_vm_exec
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/arch/x86/include/asm/sigcontext.h b/arch/x86/include/asm/sigcontext.h
index 140d890c2c98..e390410cc3e9 100644
--- a/arch/x86/include/asm/sigcontext.h
+++ b/arch/x86/include/asm/sigcontext.h
@@ -6,4 +6,6 @@
 
 #include <uapi/asm/sigcontext.h>
 
+extern long swap_vm_exec_context(struct sigcontext __user *uctx);
+
 #endif /* _ASM_X86_SIGCONTEXT_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 68608bd892c0..d053289fd19e 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -163,3 +163,4 @@ ifeq ($(CONFIG_X86_64),y)
 endif
 
 obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
+obj-$(CONFIG_PROCESS_VM_EXEC)	+= process_vm_exec.o
diff --git a/arch/x86/kernel/process_vm_exec.c b/arch/x86/kernel/process_vm_exec.c
new file mode 100644
index 000000000000..28b32330f744
--- /dev/null
+++ b/arch/x86/kernel/process_vm_exec.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <asm/syscall.h>
+#include <asm/sigframe.h>
+#include <asm/signal.h>
+#include <asm/mmu_context.h>
+#include <asm/sigcontext.h>
+
+#include <linux/types.h>
+#include <linux/mm.h>
+#include <linux/sched/mm.h>
+#include <linux/syscalls.h>
+#include <linux/vmacache.h>
+#include <linux/process_vm_exec.h>
+
+static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
+{
+	struct task_struct *tsk = current;
+	struct mm_struct *active_mm;
+
+	task_lock(tsk);
+	/* Hold off tlb flush IPIs while switching mm's */
+	local_irq_disable();
+
+	sync_mm_rss(prev_mm);
+
+	vmacache_flush(tsk);
+
+	active_mm = tsk->active_mm;
+	if (active_mm != target_mm) {
+		mmgrab(target_mm);
+		tsk->active_mm = target_mm;
+	}
+	tsk->mm = target_mm;
+	switch_mm_irqs_off(active_mm, target_mm, tsk);
+	local_irq_enable();
+	task_unlock(tsk);
+#ifdef finish_arch_post_lock_switch
+	finish_arch_post_lock_switch();
+#endif
+
+	if (active_mm != target_mm)
+		mmdrop(active_mm);
+}
+
+void restore_vm_exec_context(struct pt_regs *regs)
+{
+	struct sigcontext __user *uctx;
+	struct mm_struct *prev_mm, *target_mm;
+
+	uctx = current->exec_mm->ctx;
+	current->exec_mm->ctx = NULL;
+
+	target_mm = current->exec_mm->mm;
+	current->exec_mm->mm = NULL;
+	prev_mm = current->mm;
+
+	swap_mm(prev_mm, target_mm);
+
+	mmput(prev_mm);
+	mmdrop(target_mm);
+
+	swap_vm_exec_context(uctx);
+}
+
+SYSCALL_DEFINE6(process_vm_exec, pid_t, pid, struct sigcontext __user *, uctx,
+		unsigned long, flags, siginfo_t __user *, uinfo,
+		sigset_t __user *, user_mask, size_t, sizemask)
+{
+	struct mm_struct *prev_mm, *mm;
+	struct task_struct *tsk;
+	long ret = -ESRCH;
+
+	sigset_t mask;
+
+	if (flags)
+		return -EINVAL;
+
+	if (sizemask != sizeof(sigset_t))
+		return -EINVAL;
+	if (copy_from_user(&mask, user_mask, sizeof(mask)))
+		return -EFAULT;
+
+	sigdelsetmask(&mask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+	signotset(&mask);
+
+	tsk = find_get_task_by_vpid(pid);
+	if (!tsk) {
+		ret = -ESRCH;
+		goto err;
+	}
+	mm = mm_access(tsk, PTRACE_MODE_ATTACH_REALCREDS);
+	put_task_struct(tsk);
+	if (!mm || IS_ERR(mm)) {
+		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+		goto err;
+	}
+
+	current_pt_regs()->ax = 0;
+	ret = swap_vm_exec_context(uctx);
+	if (ret < 0)
+		goto err_mm_put;
+
+	if (!current->exec_mm) {
+		ret = -ENOMEM;
+		current->exec_mm = kmalloc(sizeof(*current->exec_mm), GFP_KERNEL);
+		if (current->exec_mm == NULL)
+			goto err_mm_put;
+	}
+	current->exec_mm->ctx = uctx;
+	current->exec_mm->mm = current->mm;
+	current->exec_mm->flags = flags;
+	current->exec_mm->sigmask = mask;
+	current->exec_mm->siginfo = uinfo;
+	prev_mm = current->mm;
+
+	mmgrab(prev_mm);
+	swap_mm(prev_mm, mm);
+
+	ret = current_pt_regs()->ax;
+
+	return ret;
+err_mm_put:
+	mmput(mm);
+err:
+	return ret;
+}
+
+void free_exec_mm_struct(struct task_struct *p)
+{
+	kfree(p->exec_mm);
+	p->exec_mm = NULL;
+}
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index cc269a20dd5f..51286c79062b 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -27,6 +27,7 @@
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
 #include <linux/syscalls.h>
+#include <linux/process_vm_exec.h>
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
@@ -816,6 +817,23 @@ void arch_do_signal(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 
+#ifdef CONFIG_PROCESS_VM_EXEC
+	if (current->exec_mm && current->exec_mm->ctx) {
+		kernel_siginfo_t info;
+		int ret;
+
+		restore_vm_exec_context(current_pt_regs());
+
+		spin_lock_irq(&current->sighand->siglock);
+		ret = dequeue_signal(current, &current->exec_mm->sigmask, &info);
+		spin_unlock_irq(&current->sighand->siglock);
+
+		if (ret > 0)
+			ret = copy_siginfo_to_user(current->exec_mm->siginfo, &info);
+		regs->ax = ret;
+	}
+#endif
+
 	if (get_signal(&ksig)) {
 		/* Whee! Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
@@ -896,3 +914,32 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 	return 0;
 }
 #endif
+
+#ifdef CONFIG_PROCESS_VM_EXEC
+long swap_vm_exec_context(struct sigcontext __user *uctx)
+{
+	struct sigcontext ctx = {};
+	sigset_t set = {};
+
+
+	if (copy_from_user(&ctx, uctx, CONTEXT_COPY_SIZE))
+		return -EFAULT;
+	/* A floating point state is managed from user-space. */
+	if (ctx.fpstate != 0)
+		return -EINVAL;
+	if (!user_access_begin(uctx, sizeof(*uctx)))
+		return -EFAULT;
+	unsafe_put_sigcontext(uctx, NULL, current_pt_regs(), (&set), Efault);
+	user_access_end();
+
+	if (__restore_sigcontext(current_pt_regs(), &ctx, 0))
+		goto badframe;
+
+	return 0;
+Efault:
+	user_access_end();
+badframe:
+	signal_fault(current_pt_regs(), uctx, "swap_vm_exec_context");
+	return -EFAULT;
+}
+#endif
diff --git a/include/linux/process_vm_exec.h b/include/linux/process_vm_exec.h
new file mode 100644
index 000000000000..a02535fbd5c8
--- /dev/null
+++ b/include/linux/process_vm_exec.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PROCESS_VM_EXEC_H
+#define _LINUX_PROCESS_VM_EXEC_H
+
+struct exec_mm {
+	struct sigcontext *ctx;
+	struct mm_struct *mm;
+	unsigned long flags;
+	sigset_t sigmask;
+	siginfo_t __user *siginfo;
+};
+
+void free_exec_mm_struct(struct task_struct *tsk);
+
+#endif
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 76cd21fa5501..864a8fdd0ed7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -64,6 +64,7 @@ struct signal_struct;
 struct task_delay_info;
 struct task_group;
 struct io_uring_task;
+struct exec_mm;
 
 /*
  * Task state bitmask. NOTE! These bits are also
@@ -637,6 +638,8 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct exec_mm;
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -757,6 +760,10 @@ struct task_struct {
 	struct mm_struct		*mm;
 	struct mm_struct		*active_mm;
 
+#ifdef CONFIG_PROCESS_VM_EXEC
+	struct exec_mm			*exec_mm;
+#endif
+
 	/* Per-thread vma caching: */
 	struct vmacache			vmacache;
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 37bea07c12f2..bdea75a14975 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1347,4 +1347,10 @@ int __sys_getsockopt(int fd, int level, int optname, char __user *optval,
 		int __user *optlen);
 int __sys_setsockopt(int fd, int level, int optname, char __user *optval,
 		int optlen);
+
+#ifdef CONFIG_PROCESS_VM_EXEC
+void restore_vm_exec_context(struct pt_regs *regs);
+#else
+static inline void restore_vm_exec_context(struct pt_regs *regs) {}
+#endif
 #endif
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 2056318988f7..60acbd9cf511 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -859,9 +859,11 @@ __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
+#define __NR_process_madvise 441
+__SYSCALL(__NR_process_vm_exec, sys_process_vm_exec)
 
 #undef __NR_syscalls
-#define __NR_syscalls 441
+#define __NR_syscalls 442
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/fork.c b/kernel/fork.c
index 6d266388d380..61ca7a4a1130 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -96,6 +96,7 @@
 #include <linux/kasan.h>
 #include <linux/scs.h>
 #include <linux/io_uring.h>
+#include <linux/process_vm_exec.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -461,6 +462,9 @@ void free_task(struct task_struct *tsk)
 	arch_release_task_struct(tsk);
 	if (tsk->flags & PF_KTHREAD)
 		free_kthread_struct(tsk);
+#ifdef CONFIG_PROCESS_VM_EXEC
+	free_exec_mm_struct(tsk);
+#endif
 	free_task_struct(tsk);
 }
 EXPORT_SYMBOL(free_task);
@@ -943,6 +947,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
+
+#ifdef CONFIG_PROCESS_VM_EXEC
+	tsk->exec_mm = NULL;
+#endif
+
 	return tsk;
 
 free_stack:
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index f27ac94d5fa7..2545a409bb07 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -350,6 +350,8 @@ COND_SYSCALL(pkey_mprotect);
 COND_SYSCALL(pkey_alloc);
 COND_SYSCALL(pkey_free);
 
+/* execute in another address space */
+COND_SYSCALL(process_vm_exec);
 
 /*
  * Architecture specific weak syscall entries.
-- 
2.29.2

