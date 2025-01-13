Return-Path: <linux-api+bounces-2979-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 817CAA0BEA3
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2025 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA94169D2F
	for <lists+linux-api@lfdr.de>; Mon, 13 Jan 2025 17:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AD2229808;
	Mon, 13 Jan 2025 17:12:11 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769201BD9C1;
	Mon, 13 Jan 2025 17:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788331; cv=none; b=ip/exc7e4p0gz/izS87iAAdL8i2U4LFlZTNt+0mlpsQzH/gHZOJfRggz+gFwmfWDYk5uTjpx22akAREW3yqFFU8Uk6LFC1u/shRW7S2t6Eg3y7Z+C/aVJv9bIzPlNJZVnrGVz8y8L9vGkwH5Vc7aqzITVf6TRRjhk+t3QAVSuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788331; c=relaxed/simple;
	bh=euQ06lpunO0QPEVLc2YX/s+5IuJ+yl7oKilFf2/Xj9c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s9Usr5dnL1hr/uiSdXGjVZ0kqztP6MJgRJdHQr2VTUVa8DpLFArZI0rgxYNFeUpb/X6Ji5qs00U5KmmkKgcr+Xb9mgRpOa+JlLDhibNqTHrMkh1k6XeOx/NGa+Lv50U0uNtJhAt29AwQFZQbxDsVR1r0bUyDG7Vwyh5qEwFEipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 88C5772C8CC;
	Mon, 13 Jan 2025 20:12:08 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 7C1C57CCB3A; Mon, 13 Jan 2025 19:12:08 +0200 (IST)
Date: Mon, 13 Jan 2025 19:12:08 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250113171208.GF589@strace.io>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113170925.GA392@strace.io>

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
if needed, by using struct ptrace_syscall_info.flags to specify
the additional details that should be set.  Currently, flags and reserved
fields of struct ptrace_syscall_info must be initialized with zeroes;
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
 include/linux/ptrace.h      |  3 ++
 include/uapi/linux/ptrace.h |  4 +-
 kernel/ptrace.c             | 95 +++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

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
index 72c038fc71d0..ca75b3ab5d22 100644
--- a/include/uapi/linux/ptrace.h
+++ b/include/uapi/linux/ptrace.h
@@ -74,6 +74,7 @@ struct seccomp_metadata {
 };
 
 #define PTRACE_GET_SYSCALL_INFO		0x420e
+#define PTRACE_SET_SYSCALL_INFO		0x4212
 #define PTRACE_SYSCALL_INFO_NONE	0
 #define PTRACE_SYSCALL_INFO_ENTRY	1
 #define PTRACE_SYSCALL_INFO_EXIT	2
@@ -81,7 +82,8 @@ struct seccomp_metadata {
 
 struct ptrace_syscall_info {
 	__u8 op;	/* PTRACE_SYSCALL_INFO_* */
-	__u8 pad[3];
+	__u8 reserved;
+	__u16 flags;
 	__u32 arch;
 	__u64 instruction_pointer;
 	__u64 stack_pointer;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 22e7d74cf4cd..41d37cb8f74a 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1016,6 +1016,97 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
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
+	/*
+	 * If the syscall number is set to -1, setting syscall arguments is not
+	 * just pointless, it would also clobber the syscall return value on
+	 * those architectures that share the same register both for the first
+	 * argument of syscall and its return value.
+	 */
+	if (nr != -1)
+		syscall_set_arguments(child, regs, args);
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
+	if (info.flags || info.reserved)
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
@@ -1234,6 +1325,10 @@ int ptrace_request(struct task_struct *child, long request,
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

