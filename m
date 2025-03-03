Return-Path: <linux-api+bounces-3376-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5283AA4EB45
	for <lists+linux-api@lfdr.de>; Tue,  4 Mar 2025 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5C7189A020
	for <lists+linux-api@lfdr.de>; Tue,  4 Mar 2025 18:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42640294EC2;
	Tue,  4 Mar 2025 18:02:13 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9B225DCEC
	for <linux-api@vger.kernel.org>; Tue,  4 Mar 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111333; cv=pass; b=iD3vFg4KE6EwZly+1yRZm8JRwEFHh3y9VY0aJ+o1Qz9TZtu5sZMUWdFKZVuP1nQ0XSIQShrOM/DiL6jRChw7blvQCR3WMOOLrI/eH/VxWL/PYIHm9u4OxGZTZRgd/r6o4Imkr3mAbMvPVgOxBjAzVpE5OfF8RCp9M+IjNVFCld4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111333; c=relaxed/simple;
	bh=i/mv86q/EEkpO+5vvH8tZGjrQa/WXUHTfjDzQ+Vh+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SlIdDJPYh6Rz6n3jdmEda82qczSWcjZlOOn8deBCPQRlBdf0DH19jRHbIBtwVPKp0OEtG22Q9PSSjAVA6R2+Bfbe97f0xgGPVQBnve5uma17wZ7xEI0+zAmFt5euWwQ+VUFAP5kX3ac64IhXZdPNVakRbKwN7AxxsK9Gd86l48s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=194.107.17.57; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 6AAFB40CFBBE
	for <linux-api@vger.kernel.org>; Tue,  4 Mar 2025 21:02:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g7c0PWfzG1Kn
	for <linux-api@vger.kernel.org>; Tue,  4 Mar 2025 18:48:12 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 409E342723; Tue,  4 Mar 2025 18:48:04 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541567-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 946AB4214A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:33:21 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 2BD853063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:33:11 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 532863BC30B
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624941F75A6;
	Mon,  3 Mar 2025 11:20:50 +0000 (UTC)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E801F3D49;
	Mon,  3 Mar 2025 11:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000847; cv=none; b=U9VY9mMQy1Tu/s7dGgzNH4MYlv1fzZjdzEPb3eMj9Rs8uN24K6HhQWfAttx2AXGevtrHzYd99e5SYC5isngNqdc9BEUnlfodxU3D+gOfal9HWBVWHgsaiTxPBGF2iSRTelEP6JeyY8EfW0xAq4EBgzSXv4lXqf5bRvP1GPYA3e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000847; c=relaxed/simple;
	bh=i/mv86q/EEkpO+5vvH8tZGjrQa/WXUHTfjDzQ+Vh+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oKrsqinWmTuhisupsVLMGnlfobaAG2tEiSMLDrw64JuEHgBh+W23YFbEuJGqhKhkDZCpffGIXlQgIGdBeoeTDv6hswPhPAeItmM7v4ca5aKQpGok4issJwuvFpLLPhiD84nLWSnqms2nUIqAkhTCVudxS6ivUmV0+YmSPgqFfXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 83B3972C980;
	Mon,  3 Mar 2025 14:20:44 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 70B307CCB3A; Mon,  3 Mar 2025 13:20:44 +0200 (IST)
Date: Mon, 3 Mar 2025 13:20:44 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH v7 5/6] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250303112044.GF24170@strace.io>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303111910.GA24170@strace.io>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g7c0PWfzG1Kn
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741715995.29736@5mOfBrgOl5pE7GAjkJIW8w
X-ITU-MailScanner-SpamCheck: not spam

PTRACE_SET_SYSCALL_INFO is a generic ptrace API that complements
PTRACE_GET_SYSCALL_INFO by letting the ptracer modify details of
system calls the tracee is blocked in.

This API allows ptracers to obtain and modify system call details in a
straightforward and architecture-agnostic way, providing a consistent way
of manipulating the system call number and arguments across architectures.

As in case of PTRACE_GET_SYSCALL_INFO, PTRACE_SET_SYSCALL_INFO also
does not aim to address numerous architecture-specific system call ABI
peculiarities, like differences in the number of system call arguments
for such system calls as pread64 and preadv.

The current implementation supports changing only those bits of system call
information that are used by strace system call tampering, namely, syscall
number, syscall arguments, and syscall return value.

Support of changing additional details returned by PTRACE_GET_SYSCALL_INFO,
such as instruction pointer and stack pointer, could be added later if
needed, by using struct ptrace_syscall_info.flags to specify the additional
details that should be set.  Currently, "flags" and "reserved" fields of
struct ptrace_syscall_info must be initialized with zeroes; "arch",
"instruction_pointer", and "stack_pointer" fields are currently ignored.

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
Reviewed-by: Alexey Gladkov <legion@kernel.org>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Eugene Syromiatnikov <esyr@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
 include/uapi/linux/ptrace.h |   7 ++-
 kernel/ptrace.c             | 121 +++++++++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
index 72c038fc71d0..5f8ef6156752 100644
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
@@ -98,6 +100,7 @@ struct ptrace_syscall_info {
 			__u64 nr;
 			__u64 args[6];
 			__u32 ret_data;
+			__u32 reserved2;
 		} seccomp;
 	};
 };
@@ -142,6 +145,8 @@ struct ptrace_sud_config {
 	__u64 len;
 };
 
+/* 0x4212 is PTRACE_SET_SYSCALL_INFO */
+
 /*
  * These values are stored in task->ptrace_message
  * by ptrace_stop to describe the current syscall-stop.
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 22e7d74cf4cd..75a84efad40f 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -944,7 +944,10 @@ ptrace_get_syscall_info_seccomp(struct task_struct *child, struct pt_regs *regs,
 	ptrace_get_syscall_info_entry(child, regs, info);
 	info->seccomp.ret_data = child->ptrace_message;
 
-	/* ret_data is the last field in struct ptrace_syscall_info.seccomp */
+	/*
+	 * ret_data is the last non-reserved field
+	 * in struct ptrace_syscall_info.seccomp
+	 */
 	return offsetofend(struct ptrace_syscall_info, seccomp.ret_data);
 }
 
@@ -1016,6 +1019,118 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
 	write_size = min(actual_size, user_size);
 	return copy_to_user(datavp, &info, write_size) ? -EFAULT : actual_size;
 }
+
+static int
+ptrace_set_syscall_info_entry(struct task_struct *child, struct pt_regs *regs,
+			      struct ptrace_syscall_info *info)
+{
+	unsigned long args[ARRAY_SIZE(info->entry.args)];
+	int nr = info->entry.nr;
+	int i;
+
+	/*
+	 * Check that the syscall number specified in info->entry.nr
+	 * is either a value of type "int" or a sign-extended value
+	 * of type "int".
+	 */
+	if (nr != info->entry.nr)
+		return -ERANGE;
+
+	for (i = 0; i < ARRAY_SIZE(args); i++) {
+		args[i] = info->entry.args[i];
+		/*
+		 * Check that the syscall argument specified in
+		 * info->entry.args[i] is either a value of type
+		 * "unsigned long" or a sign-extended value of type "long".
+		 */
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
+static int
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
+static int
+ptrace_set_syscall_info_exit(struct task_struct *child, struct pt_regs *regs,
+			     struct ptrace_syscall_info *info)
+{
+	long rval = info->exit.rval;
+
+	/*
+	 * Check that the return value specified in info->exit.rval
+	 * is either a value of type "long" or a sign-extended value
+	 * of type "long".
+	 */
+	if (rval != info->exit.rval)
+		return -ERANGE;
+
+	if (info->exit.is_error)
+		syscall_set_return_value(child, regs, rval, 0);
+	else
+		syscall_set_return_value(child, regs, 0, rval);
+
+	return 0;
+}
+
+static int
+ptrace_set_syscall_info(struct task_struct *child, unsigned long user_size,
+			const void __user *datavp)
+{
+	struct pt_regs *regs = task_pt_regs(child);
+	struct ptrace_syscall_info info;
+
+	if (user_size < sizeof(info))
+		return -EINVAL;
+
+	/*
+	 * The compatibility is tracked by info.op and info.flags: if user-space
+	 * does not instruct us to use unknown extra bits from future versions
+	 * of ptrace_syscall_info, we are not going to read them either.
+	 */
+	if (copy_from_user(&info, datavp, sizeof(info)))
+		return -EFAULT;
+
+	/* Reserved for future use. */
+	if (info.flags || info.reserved)
+		return -EINVAL;
+
+	/* Changing the type of the system call stop is not supported yet. */
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
+		/* Other types of system call stops are not supported yet. */
+		return -EINVAL;
+	}
+}
 #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
 
 int ptrace_request(struct task_struct *child, long request,
@@ -1234,6 +1349,10 @@ int ptrace_request(struct task_struct *child, long request,
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


