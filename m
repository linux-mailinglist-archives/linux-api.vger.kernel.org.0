Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164F435EC9A
	for <lists+linux-api@lfdr.de>; Wed, 14 Apr 2021 07:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbhDNFzU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Apr 2021 01:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhDNFzS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Apr 2021 01:55:18 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188E7C061574;
        Tue, 13 Apr 2021 22:54:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m18so7276055plc.13;
        Tue, 13 Apr 2021 22:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibaxQvwScvMe/CiZZSjPkJNeX1y3W7Bhso/qXj/qB90=;
        b=MOrwxOXe/0XoAmyAK6btSrreOHIl0SqV6QiXimCFtiNOhXMa9pu/dWEi0/N5qpNcoP
         5pG9pkE1FP4DsvLEPLSPrHlXvOpD9Y/AnKd5H/u1ZXQjjndeQn1HjBbYSYaqsTDIFlMN
         FmRVHfKluzlJQP4ROSbj+Hjf/wbID+Gds4H7T9quLcLI6a+1rgUMkNYecC8h1LYpsbY4
         WCnl4kvPIaR7a0TeWgQaXk+zd/vI0gIe/r4obsIffPyg3A4it97BeVjjyC/v2PYt2TuW
         0ryTonYQ5huEAnH2yFm2XgrnEgtmHCTsGKUVOAqsIzFfeapIVVzg3tJvmzm8f3OILru7
         jFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibaxQvwScvMe/CiZZSjPkJNeX1y3W7Bhso/qXj/qB90=;
        b=XT/4ELH6xEfYkPrtoOMr/3fjcRYtkpmce1m7eo2rwVF4BwFB4qlEoIJ7EGIXi9tab0
         zVetkBdmzExb78NgjGh4U4jTPLvG9J5LEnMwpW1LNadruurW9c769K2nhCrDrzWp25h7
         ZHilFjOpeZgYVFR4h+8DEtKqJUNmY7Vn1EHfq/nt+5swTil5z6EOlWw0bMtQMWnL3v91
         NHtQBU4EmoD2IT3ywTfCID4ecJobo1KiYBAO/Ti6RHdCtGAujr3GzpEfA5SieyPqVRE2
         ilp9KuRF/c/rnM69rCrjaAisVxH1pvVhMIl4/yQaQ69zLnaw6Lj9iEb7H6ab8XRelDIW
         4n2g==
X-Gm-Message-State: AOAM532G6rI6qyjY9+dsd+5yu6IgErngBL5jt589t2+S8s6SFNNp6gcT
        +hPAB3RQZsqrTUIPTOzviB249M5MSngWULge
X-Google-Smtp-Source: ABdhPJxpXr+9kvOWkJm3FpqJONqVZKXY00M04fJn78qBiUwY40YERVsxpyNFxFdsykpDnZPQ1/IJSA==
X-Received: by 2002:a17:90b:368b:: with SMTP id mj11mr1682948pjb.217.1618379697341;
        Tue, 13 Apr 2021 22:54:57 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id u17sm13728969pfm.113.2021.04.13.22.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 22:54:56 -0700 (PDT)
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
Subject: [PATCH 3/4] arch/x86: allow to execute syscalls via process_vm_exec
Date:   Tue, 13 Apr 2021 22:52:16 -0700
Message-Id: <20210414055217.543246-4-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210414055217.543246-1-avagin@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_vm_exec allows to execute code in an address space of another
process. It changes the current address space to the target address
space and resume the current process with registers from sigcontex that
is passed in the arguments.

This changes adds the PROCESS_VM_EXEC_SYSCALL flag and if it is set
process_vm_exec will execute a system call with arguments from sigcontext.

process_vm_exec retuns 0 if the system call has been executed and an error
code in other cases.

A return code of the system call can be found in a proper register in
sigcontext.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/x86/entry/common.c              |  5 ++++-
 arch/x86/kernel/process_vm_exec.c    | 29 +++++++++++++++++++++++++++-
 include/linux/entry-common.h         |  2 ++
 include/linux/process_vm_exec.h      |  2 ++
 include/uapi/linux/process_vm_exec.h |  8 ++++++++
 kernel/entry/common.c                |  2 +-
 6 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/process_vm_exec.h

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 42eac459b25b..8de02ca19aca 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -40,7 +40,10 @@
 __visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 {
 #ifdef CONFIG_PROCESS_VM_EXEC
-	if (current->exec_mm && current->exec_mm->ctx) {
+	struct exec_mm *exec_mm = current->exec_mm;
+
+	if (exec_mm && exec_mm->ctx &&
+	    !(exec_mm->flags & PROCESS_VM_EXEC_SYSCALL)) {
 		kernel_siginfo_t info = {
 			.si_signo = SIGSYS,
 			.si_call_addr = (void __user *)KSTK_EIP(current),
diff --git a/arch/x86/kernel/process_vm_exec.c b/arch/x86/kernel/process_vm_exec.c
index 28b32330f744..9124b23f1e9b 100644
--- a/arch/x86/kernel/process_vm_exec.c
+++ b/arch/x86/kernel/process_vm_exec.c
@@ -11,6 +11,7 @@
 #include <linux/sched/mm.h>
 #include <linux/syscalls.h>
 #include <linux/vmacache.h>
+#include <linux/entry-common.h>
 #include <linux/process_vm_exec.h>
 
 static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
@@ -73,7 +74,7 @@ SYSCALL_DEFINE6(process_vm_exec, pid_t, pid, struct sigcontext __user *, uctx,
 
 	sigset_t mask;
 
-	if (flags)
+	if (flags & ~PROCESS_VM_EXEC_SYSCALL)
 		return -EINVAL;
 
 	if (sizemask != sizeof(sigset_t))
@@ -97,6 +98,9 @@ SYSCALL_DEFINE6(process_vm_exec, pid_t, pid, struct sigcontext __user *, uctx,
 	}
 
 	current_pt_regs()->ax = 0;
+	if (flags & PROCESS_VM_EXEC_SYSCALL)
+		syscall_exit_to_user_mode_prepare(current_pt_regs());
+
 	ret = swap_vm_exec_context(uctx);
 	if (ret < 0)
 		goto err_mm_put;
@@ -117,6 +121,29 @@ SYSCALL_DEFINE6(process_vm_exec, pid_t, pid, struct sigcontext __user *, uctx,
 	mmgrab(prev_mm);
 	swap_mm(prev_mm, mm);
 
+	if (flags & PROCESS_VM_EXEC_SYSCALL) {
+		struct pt_regs *regs = current_pt_regs();
+		kernel_siginfo_t info;
+		int sysno;
+
+		regs->orig_ax = regs->ax;
+		regs->ax = -ENOSYS;
+		sysno = syscall_get_nr(current, regs);
+
+		do_syscall_64(sysno, regs);
+
+		restore_vm_exec_context(regs);
+		info.si_signo = SIGSYS;
+		info.si_call_addr = (void __user *)KSTK_EIP(current);
+		info.si_arch = syscall_get_arch(current);
+		info.si_syscall = sysno;
+		ret = copy_siginfo_to_user(current->exec_mm->siginfo, &info);
+		current_pt_regs()->orig_ax = __NR_process_vm_exec;
+		current_pt_regs()->ax = -ENOSYS;
+		syscall_enter_from_user_mode_work(current_pt_regs(), current_pt_regs()->orig_ax);
+		return ret;
+	}
+
 	ret = current_pt_regs()->ax;
 
 	return ret;
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 474f29638d2c..d0ebbe9ca9e4 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -285,6 +285,8 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
 }
 #endif
 
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs);
+
 /**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
diff --git a/include/linux/process_vm_exec.h b/include/linux/process_vm_exec.h
index a02535fbd5c8..2e04b4875a92 100644
--- a/include/linux/process_vm_exec.h
+++ b/include/linux/process_vm_exec.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_PROCESS_VM_EXEC_H
 #define _LINUX_PROCESS_VM_EXEC_H
 
+#include <uapi/linux/process_vm_exec.h>
+
 struct exec_mm {
 	struct sigcontext *ctx;
 	struct mm_struct *mm;
diff --git a/include/uapi/linux/process_vm_exec.h b/include/uapi/linux/process_vm_exec.h
new file mode 100644
index 000000000000..35465b5d3ebf
--- /dev/null
+++ b/include/uapi/linux/process_vm_exec.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+
+#ifndef _UAPI_LINUX_PROCESS_VM_EXEC_H
+#define _UAPI_LINUX_PROCESS_VM_EXEC_H
+
+#define PROCESS_VM_EXEC_SYSCALL 0x1UL
+
+#endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e9e2df3f3f9e..c325a2e5ecf4 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -235,7 +235,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work)
  * Syscall specific exit to user mode preparation. Runs with interrupts
  * enabled.
  */
-static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
+void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 {
 	u32 cached_flags = READ_ONCE(current_thread_info()->flags);
 	unsigned long nr = syscall_get_nr(current, regs);
-- 
2.29.2

