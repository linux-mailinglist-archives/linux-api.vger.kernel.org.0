Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C859E1A02C
	for <lists+linux-api@lfdr.de>; Fri, 10 May 2019 17:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfEJP2p (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 May 2019 11:28:45 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60628 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfEJP2p (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 May 2019 11:28:45 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4A49472CCD1;
        Fri, 10 May 2019 18:28:42 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 3CB5B7CCE09; Fri, 10 May 2019 18:28:42 +0300 (MSK)
Date:   Fri, 10 May 2019 18:28:42 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Elvira Khabirova <lineprinter@altlinux.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        linux-api@vger.kernel.org, strace-devel@lists.strace.io,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 6/7] ptrace: add PTRACE_GET_SYSCALL_INFO request
Message-ID: <20190510152842.GF28558@altlinux.org>
References: <20190510152640.GA28529@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510152640.GA28529@altlinux.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Elvira Khabirova <lineprinter@altlinux.org>

PTRACE_GET_SYSCALL_INFO is a generic ptrace API that lets ptracer obtain
details of the syscall the tracee is blocked in.

There are two reasons for a special syscall-related ptrace request.

Firstly, with the current ptrace API there are cases when ptracer cannot
retrieve necessary information about syscalls.  Some examples include:
* The notorious int-0x80-from-64-bit-task issue.  See [1] for details.
In short, if a 64-bit task performs a syscall through int 0x80, its tracer
has no reliable means to find out that the syscall was, in fact,
a compat syscall, and misidentifies it.
* Syscall-enter-stop and syscall-exit-stop look the same for the tracer.
Common practice is to keep track of the sequence of ptrace-stops in order
not to mix the two syscall-stops up.  But it is not as simple as it looks;
for example, strace had a (just recently fixed) long-standing bug where
attaching strace to a tracee that is performing the execve system call
led to the tracer identifying the following syscall-exit-stop as
syscall-enter-stop, which messed up all the state tracking.
* Since the introduction of commit 84d77d3f06e7e8dea057d10e8ec77ad71f721be3
("ptrace: Don't allow accessing an undumpable mm"), both PTRACE_PEEKDATA
and process_vm_readv become unavailable when the process dumpable flag
is cleared.  On such architectures as ia64 this results in all syscall
arguments being unavailable for the tracer.

Secondly, ptracers also have to support a lot of arch-specific code for
obtaining information about the tracee.  For some architectures, this
requires a ptrace(PTRACE_PEEKUSER, ...) invocation for every syscall
argument and return value.

ptrace(2) man page:

long ptrace(enum __ptrace_request request, pid_t pid,
            void *addr, void *data);
...
PTRACE_GET_SYSCALL_INFO
       Retrieve information about the syscall that caused the stop.
       The information is placed into the buffer pointed by "data"
       argument, which should be a pointer to a buffer of type
       "struct ptrace_syscall_info".
       The "addr" argument contains the size of the buffer pointed to
       by "data" argument (i.e., sizeof(struct ptrace_syscall_info)).
       The return value contains the number of bytes available
       to be written by the kernel.
       If the size of data to be written by the kernel exceeds the size
       specified by "addr" argument, the output is truncated.

Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-api@vger.kernel.org
Cc: strace-devel@lists.strace.io
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v11: unchanged
    
    v10: unchanged
    
    v9:
    * Rebased to linux-next again due to syscall_get_arguments() signature change.
    
    v8:
    * Rebased to linux-next.
    * Moved ptrace_get_syscall_info code under #ifdef CONFIG_HAVE_ARCH_TRACEHOOK,
      narrowing down the set of architectures supported by this implementation
      back to those 19 that enable CONFIG_HAVE_ARCH_TRACEHOOK because
      I failed to get all syscall_get_*(), instruction_pointer(),
      and user_stack_pointer() functions implemented on some niche
      architectures.  This leaves the following architectures out:
      alpha, h8300, m68k, microblaze, and unicore32.
    
    v7: unchanged
    
    v6:
    * Changed PTRACE_GET_SYSCALL_INFO return code after discussion with Oleg:
      do not take trailing paddings into account, use the end of the last field
      of the structure being written.
    * Changed struct ptrace_syscall_info after discussion in lkml:
      * removed .frame_pointer field, is is not needed and not portable;
      * made .arch field explicitly aligned, removed no longer needed
        padding before .arch field;
      * removed trailing pads, they are no longer needed.
    * Added Reviewed-by
      from https://lore.kernel.org/lkml/20181210141107.GB4177@redhat.com/
      and https://lore.kernel.org/lkml/CAGXu5j+t1LqRC7KCHkdYhv6icgf01Lk6v=fAhPWGys=1g49=Qg@mail.gmail.com/
    
    v5:
    * Changed PTRACE_EVENTMSG_SYSCALL_{ENTRY,EXIT} values as requested by Oleg.
    * Changed struct ptrace_syscall_info: generalized instruction_pointer,
      stack_pointer, and frame_pointer fields by moving them from
      ptrace_syscall_info.{entry,seccomp} substructures to ptrace_syscall_info
      and initializing them for all stops.
    * Added PTRACE_SYSCALL_INFO_NONE, set it when not in a syscall stop,
      so e.g. "strace -i" could use PTRACE_SYSCALL_INFO_SECCOMP to obtain
      instruction_pointer when the tracee is in a signal stop.
    * Made available for all architectures: do not conditionalize on
      CONFIG_HAVE_ARCH_TRACEHOOK since all syscall_get_* functions
      are implemented on all architectures.
    
    v4:
    * Revisited PTRACE_EVENT_SECCOMP support:
      do not introduce task_struct.ptrace_event, use child->last_siginfo->si_code instead.
    * Implemented PTRACE_SYSCALL_INFO_SECCOMP and ptrace_syscall_info.seccomp
      support along with PTRACE_SYSCALL_INFO_{ENTRY,EXIT} and
      ptrace_syscall_info.{entry,exit}.
    
    v3:
    * Changed struct ptrace_syscall_info.
    * Added PTRACE_EVENT_SECCOMP support by adding ptrace_event to task_struct.
    * Added proper defines for ptrace_syscall_info.op values.
    * Renamed PT_SYSCALL_IS_ENTERING and PT_SYSCALL_IS_EXITING to
      PTRACE_EVENTMSG_SYSCALL_ENTRY and PTRACE_EVENTMSG_SYSCALL_EXIT
      and moved them to uapi.
    
    v2:
    * Stopped using task->ptrace.
    * Replaced entry_info.is_compat with entry_info.arch, used syscall_get_arch().
    * Used addr argument of sys_ptrace to get expected size of the struct;
      return full size of the struct.

 include/linux/tracehook.h   |   9 ++--
 include/uapi/linux/ptrace.h |  35 +++++++++++++
 kernel/ptrace.c             | 101 +++++++++++++++++++++++++++++++++++-
 3 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index df20f8bdbfa3..6bc7a3d58e2f 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -57,13 +57,15 @@ struct linux_binprm;
 /*
  * ptrace report for syscall entry and exit looks identical.
  */
-static inline int ptrace_report_syscall(struct pt_regs *regs)
+static inline int ptrace_report_syscall(struct pt_regs *regs,
+					unsigned long message)
 {
 	int ptrace = current->ptrace;
 
 	if (!(ptrace & PT_PTRACED))
 		return 0;
 
+	current->ptrace_message = message;
 	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
@@ -76,6 +78,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
 		current->exit_code = 0;
 	}
 
+	current->ptrace_message = 0;
 	return fatal_signal_pending(current);
 }
 
@@ -101,7 +104,7 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
 static inline __must_check int tracehook_report_syscall_entry(
 	struct pt_regs *regs)
 {
-	return ptrace_report_syscall(regs);
+	return ptrace_report_syscall(regs, PTRACE_EVENTMSG_SYSCALL_ENTRY);
 }
 
 /**
@@ -126,7 +129,7 @@ static inline void tracehook_report_syscall_exit(struct pt_regs *regs, int step)
 	if (step)
 		user_single_step_report(regs);
 	else
-		ptrace_report_syscall(regs);
+		ptrace_report_syscall(regs, PTRACE_EVENTMSG_SYSCALL_EXIT);
 }
 
 /**
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index d5a1b8a492b9..a71b6e3b03eb 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -73,6 +73,41 @@ struct seccomp_metadata {
 	__u64 flags;		/* Output: filter's flags */
 };
 
+#define PTRACE_GET_SYSCALL_INFO		0x420e
+#define PTRACE_SYSCALL_INFO_NONE	0
+#define PTRACE_SYSCALL_INFO_ENTRY	1
+#define PTRACE_SYSCALL_INFO_EXIT	2
+#define PTRACE_SYSCALL_INFO_SECCOMP	3
+
+struct ptrace_syscall_info {
+	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
+	__u32 arch __attribute__((__aligned__(sizeof(__u32))));
+	__u64 instruction_pointer;
+	__u64 stack_pointer;
+	union {
+		struct {
+			__u64 nr;
+			__u64 args[6];
+		} entry;
+		struct {
+			__s64 rval;
+			__u8 is_error;
+		} exit;
+		struct {
+			__u64 nr;
+			__u64 args[6];
+			__u32 ret_data;
+		} seccomp;
+	};
+};
+
+/*
+ * These values are stored in task->ptrace_message
+ * by tracehook_report_syscall_* to describe the current syscall-stop.
+ */
+#define PTRACE_EVENTMSG_SYSCALL_ENTRY	1
+#define PTRACE_EVENTMSG_SYSCALL_EXIT	2
+
 /* Read signals from a shared (process wide) queue */
 #define PTRACE_PEEKSIGINFO_SHARED	(1 << 0)
 
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 6f357f4fc859..de3817de6327 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -31,6 +31,8 @@
 #include <linux/compat.h>
 #include <linux/sched/signal.h>
 
+#include <asm/syscall.h>	/* for syscall_get_* */
+
 /*
  * Access another process' address space via ptrace.
  * Source/target buffer must be kernel space,
@@ -879,7 +881,100 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
  * to ensure no machine forgets it.
  */
 EXPORT_SYMBOL_GPL(task_user_regset_view);
-#endif
+
+static unsigned long
+ptrace_get_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
+			      struct ptrace_syscall_info *info)
+{
+	unsigned long args[ARRAY_SIZE(info->entry.args)];
+	int i;
+
+	info->op = PTRACE_SYSCALL_INFO_ENTRY;
+	info->entry.nr = syscall_get_nr(child, regs);
+	syscall_get_arguments(child, regs, args);
+	for (i = 0; i < ARRAY_SIZE(args); i++)
+		info->entry.args[i] = args[i];
+
+	/* args is the last field in struct ptrace_syscall_info.entry */
+	return offsetofend(struct ptrace_syscall_info, entry.args);
+}
+
+static unsigned long
+ptrace_get_syscall_info_seccomp(struct task_struct *child, struct pt_regs *regs,
+				struct ptrace_syscall_info *info)
+{
+	/*
+	 * As struct ptrace_syscall_info.entry is currently a subset
+	 * of struct ptrace_syscall_info.seccomp, it makes sense to
+	 * initialize that subset using ptrace_get_syscall_info_entry().
+	 * This can be reconsidered in the future if these structures
+	 * diverge significantly enough.
+	 */
+	ptrace_get_syscall_info_entry(child, regs, info);
+	info->op = PTRACE_SYSCALL_INFO_SECCOMP;
+	info->seccomp.ret_data = child->ptrace_message;
+
+	/* ret_data is the last field in struct ptrace_syscall_info.seccomp */
+	return offsetofend(struct ptrace_syscall_info, seccomp.ret_data);
+}
+
+static unsigned long
+ptrace_get_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
+			     struct ptrace_syscall_info *info)
+{
+	info->op = PTRACE_SYSCALL_INFO_EXIT;
+	info->exit.rval = syscall_get_error(child, regs);
+	info->exit.is_error = !!info->exit.rval;
+	if (!info->exit.is_error)
+		info->exit.rval = syscall_get_return_value(child, regs);
+
+	/* is_error is the last field in struct ptrace_syscall_info.exit */
+	return offsetofend(struct ptrace_syscall_info, exit.is_error);
+}
+
+static int
+ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
+			void __user *datavp)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+	struct ptrace_syscall_info info = {
+		.op = PTRACE_SYSCALL_INFO_NONE,
+		.arch = syscall_get_arch(child),
+		.instruction_pointer = instruction_pointer(regs),
+		.stack_pointer = user_stack_pointer(regs),
+	};
+	unsigned long actual_size = offsetof(struct ptrace_syscall_info, entry);
+	unsigned long write_size;
+
+	/*
+	 * This does not need lock_task_sighand() to access
+	 * child->last_siginfo because ptrace_freeze_traced()
+	 * called earlier by ptrace_check_attach() ensures that
+	 * the tracee cannot go away and clear its last_siginfo.
+	 */
+	switch (child->last_siginfo ? child->last_siginfo->si_code : 0) {
+	case SIGTRAP | 0x80:
+		switch (child->ptrace_message) {
+		case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+			actual_size = ptrace_get_syscall_info_entry(child, regs,
+								    &info);
+			break;
+		case PTRACE_EVENTMSG_SYSCALL_EXIT:
+			actual_size = ptrace_get_syscall_info_exit(child, regs,
+								   &info);
+			break;
+		}
+		break;
+	case SIGTRAP | (PTRACE_EVENT_SECCOMP << 8):
+		actual_size = ptrace_get_syscall_info_seccomp(child, regs,
+							      &info);
+		break;
+	}
+
+	write_size = min(actual_size, user_size);
+	return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual_size;
+}
+#endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 int ptrace_request(struct task_struct *child, long request,
 		   unsigned long addr, unsigned long data)
@@ -1096,6 +1191,10 @@ int ptrace_request(struct task_struct *child, long request,
 			ret = __put_user(kiov.iov_len, &uiov->iov_len);
 		break;
 	}
+
+	case PTRACE_GET_SYSCALL_INFO:
+		ret = ptrace_get_syscall_info(child, addr, datavp);
+		break;
 #endif
 
 	case PTRACE_SECCOMP_GET_FILTER:
-- 
ldv
