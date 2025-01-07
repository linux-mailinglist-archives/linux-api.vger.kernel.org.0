Return-Path: <linux-api+bounces-2959-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA8FA04D22
	for <lists+linux-api@lfdr.de>; Wed,  8 Jan 2025 00:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 452C93A5BB7
	for <lists+linux-api@lfdr.de>; Tue,  7 Jan 2025 23:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E291E493C;
	Tue,  7 Jan 2025 23:04:59 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B698B1E105E;
	Tue,  7 Jan 2025 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736291099; cv=none; b=hf01U/CPxp0/j15GMFtuhf7PJOiC6n9ugqp0d83QJLUBJOCOC5wFd6pBu+Ia7HwCimhBwHeAe3rZ5mewc2iEIKDC8EAV6GQ/GP5vgaoOlJUfVwTnkcENKcDrQleIrRM5A6f42DK6ejOApzlSbk8Y1LxS1yPjPNHLQn4NRRJxhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736291099; c=relaxed/simple;
	bh=+G3IisoxA6JNZOJ5hIvIm1oaWXo3nppHiQC5QYthmYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FZN/GieK93wLj1oQWd9rT72qiluS3L60sP+i3COe3+RaSBLJbv2FIRl0ki7lfgmYyUWLM3fBuEDKVtVRxEL+jfsTEjgGjTcUas/agFjWwNh6vFK7cHfth+oQs6LbQ9XdIcKNOv9NStphmYotyZjeh7kiYY0bqWY/FyT60sBEps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 90A9972C97D;
	Wed,  8 Jan 2025 02:04:56 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 7D7417CCB3A; Wed,  8 Jan 2025 01:04:56 +0200 (IST)
Date: Wed, 8 Jan 2025 01:04:56 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250107230456.GE30633@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107230153.GA30560@strace.io>

PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
system calls the tracee is blocked in.

This API allows ptracers to obtain and modify system call details
in a straightforward and architecture-agnostic way.

Current implementation supports changing only those bits of system call
information that are used by strace, namely, syscall number, syscall
arguments, and syscall return value.

Support of changing additional details returned by PTRACE_GET_SYSCALL_INFO,
such as instruction pointer and stack pointer, could be added later
if needed, by re-using struct ptrace_syscall_info.reserved to specify
the additional details that should be set.  Currently, the reserved
field of struct ptrace_syscall_info must be initialized with zeroes;
arch, instruction_pointer, and stack_pointer fields are ignored.

PTRACE_SET_SYSCALL_INFO currently supports only PTRACE_SYSCALL_INFO_ENTRY,
PTRACE_SYSCALL_INFO_EXIT, and PTRACE_SYSCALL_INFO_SECCOMP operations.
Other operations could be added later if needed.

Ideally, PTRACE_SET_SYSCALL_INFO should have been introduced along with
PTRACE_GET_SYSCALL_INFO, but it didn't happen.  The last straw that
convinced me to implement PTRACE_SET_SYSCALL_INFO was apparent failure
to provide an API of changing the first system call argument on riscv
architecture.

ptrace(2) man page:

long ptrace(enum __ptrace_request request, pid_t pid, void *addr, void *data);
...
PTRACE_SET_SYSCALL_INFO
       Modify information about the system call that caused the stop.
       The "data" argument is a pointer to struct ptrace_syscall_info
       that specifies the system call information to be set.
       The "addr" argument should be set to sizeof(struct ptrace_syscall_info)).

Link: https://lore.kernel.org/all/59505464-c84a-403d-972f-d4b2055eeaac@gmail.com/
Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 include/linux/ptrace.h      |   3 ++
 include/uapi/linux/ptrace.h |   3 +-
 kernel/ptrace.c             | 102 ++++++++++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 90507d4afcd6..c8dbf1e498bf 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -17,6 +17,9 @@ struct syscall_info {
 	struct seccomp_data	data;
 };
 
+/* sizeof() the first published struct ptrace_syscall_info */
+#define PTRACE_SYSCALL_INFO_SIZE_VER0	84
+
 extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 			    void *buf, int len, unsigned int gup_flags);
 
diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 72c038fc71d0..231b8bf7eeff 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -74,6 +74,7 @@ struct seccomp_metadata {
 };
 
 #define PTRACE_GET_SYSCALL_INFO		0x420e
+#define PTRACE_SET_SYSCALL_INFO		0x4212
 #define PTRACE_SYSCALL_INFO_NONE	0
 #define PTRACE_SYSCALL_INFO_ENTRY	1
 #define PTRACE_SYSCALL_INFO_EXIT	2
@@ -81,7 +82,7 @@ struct seccomp_metadata {
 
 struct ptrace_syscall_info {
 	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
-	__u8 pad[3];
+	__u8 reserved[3];
 	__u32 arch;
 	__u64 instruction_pointer;
 	__u64 stack_pointer;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index e7e0003cc8e0..52377653743d 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1018,6 +1018,104 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
 	write_size = min(actual_size, user_size);
 	return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual_size;
 }
+
+static unsigned long
+ptrace_set_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
+			      struct ptrace_syscall_info *info)
+{
+	unsigned long args[ARRAY_SIZE(info->entry.args)];
+	int nr = info->entry.nr;
+	int i;
+
+	if (nr != info->entry.nr)
+		return -ERANGE;
+
+	for (i = 0; i < ARRAY_SIZE(args); i++) {
+		args[i] = info->entry.args[i];
+		if (args[i] != info->entry.args[i])
+			return -ERANGE;
+	}
+
+	syscall_set_nr(child, regs, nr);
+	syscall_set_arguments(child, regs, args);
+	if (nr == -1) {
+		/*
+		 * When the syscall number is set to -1, the syscall will be
+		 * skipped.  In this case also set the syscall return value to
+		 * -ENOSYS, otherwise on some architectures the corresponding
+		 * struct pt_regs field will remain unchanged.
+		 *
+		 * Note that on some architectures syscall_set_return_value()
+		 * modifies one of the struct pt_regs fields also modified by
+		 * syscall_set_arguments(), so the former should be called
+		 * after the latter.
+		 */
+		syscall_set_return_value(child, regs, -ENOSYS, 0);
+	}
+
+	return 0;
+}
+
+static unsigned long
+ptrace_set_syscall_info_seccomp(struct task_struct *child, struct pt_regs *regs,
+				struct ptrace_syscall_info *info)
+{
+	/*
+	 * info->entry is currently a subset of info->seccomp,
+	 * info->seccomp.ret_data is currently ignored.
+	 */
+	return ptrace_set_syscall_info_entry(child, regs, info);
+}
+
+static unsigned long
+ptrace_set_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
+			     struct ptrace_syscall_info *info)
+{
+	if (info->exit.is_error)
+		syscall_set_return_value(child, regs, info->exit.rval, 0);
+	else
+		syscall_set_return_value(child, regs, 0, info->exit.rval);
+
+	return 0;
+}
+
+static int
+ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
+			void __user *datavp)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+	struct ptrace_syscall_info info;
+	int error;
+
+	BUILD_BUG_ON(sizeof(struct ptrace_syscall_info) < PTRACE_SYSCALL_INFO_SIZE_VER0);
+
+	if (user_size < PTRACE_SYSCALL_INFO_SIZE_VER0 || user_size > PAGE_SIZE)
+		return -EINVAL;
+
+	error = copy_struct_from_user(&info, sizeof(info), datavp, user_size);
+	if (error)
+		return error;
+
+	/* Reserved for future use. */
+	if (memchr_inv(info.reserved, 0, sizeof(info.reserved)))
+		return -EINVAL;
+
+	/* Changing the type of the system call stop is not supported. */
+	if (ptrace_get_syscall_info_op(child) != info.op)
+		return -EINVAL;
+
+	switch (info.op) {
+	case PTRACE_SYSCALL_INFO_ENTRY:
+		return ptrace_set_syscall_info_entry(child, regs, &info);
+	case PTRACE_SYSCALL_INFO_EXIT:
+		return ptrace_set_syscall_info_exit(child, regs, &info);
+	case PTRACE_SYSCALL_INFO_SECCOMP:
+		return ptrace_set_syscall_info_seccomp(child, regs, &info);
+	default:
+		/* Other types of system call stops are not supported. */
+		return -EINVAL;
+	}
+}
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 int ptrace_request(struct task_struct *child, long request,
@@ -1236,6 +1334,10 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_GET_SYSCALL_INFO:
 		ret = ptrace_get_syscall_info(child, addr, datavp);
 		break;
+
+	case PTRACE_SET_SYSCALL_INFO:
+		ret = ptrace_set_syscall_info(child, addr, datavp);
+		break;
 #endif
 
 	case PTRACE_SECCOMP_GET_FILTER:

-- 
ldv

