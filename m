Return-Path: <linux-api+bounces-6083-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PhkEX2k22ldEgkAu9opvQ
	(envelope-from <linux-api+bounces-6083-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 15:56:13 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5B03E4140
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 15:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D0563004F1B
	for <lists+linux-api@lfdr.de>; Sun, 12 Apr 2026 13:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EDD2FD681;
	Sun, 12 Apr 2026 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="WGAo5L2N"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1F2F549F
	for <linux-api@vger.kernel.org>; Sun, 12 Apr 2026 13:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776002165; cv=none; b=hqaNRF+/q7iLHep6BS4uZoJKa5dkmw0y5EbTLBREhrHuqNi1xBkx+zzILoJf6nhLz3ISlTyo0piEhVDJWfcx17B+6Pv1wIa2OJjgTGhghEgxNyuS/BIxkDcvSjHuAgwe4tMX8d8saU95eElX5y7uKcoE5HNoMg6+peiqVQFQwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776002165; c=relaxed/simple;
	bh=HA3cp/fK8r6wIrZOIwq8J/sQ0rt5XJP/8kmJozHMB68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdOe4gVHZuI1Fet/Dfm+NJaUKvkIfFpxbn6x6/8uLGBtqSfTimfaVGlS2GdzZrFQv3AhUonEbMPQgy4hwrW1kKUcxIFAZNneKAlQMRF+CzZR+iJh8YNCAmViYTMrGZrCU9Jyz99KLeQEbPVx2/OC4bcxsKwogl4BpYsWxA0FWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=WGAo5L2N; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 2f87c6cd-3677-11f1-969c-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2f87c6cd-3677-11f1-969c-005056abbe64;
	Sun, 12 Apr 2026 15:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=7bDjgNj+zMTzKDlAca9h5TpEEGIaCs8P4OrewU9NHJo=;
	b=WGAo5L2N/XiESjR3v1I+3YA8QludQx49GMae7F/ufSL04f8KczxRUWHByqWyPng6xFmW+xGQRZACn
	 ZQUCY0ZQOBULlETGcoeQ53gbUgTbExgtE7rkAY9L8BLEqz3Vg89F/e+e1qseP2RqgFpsXMAtNQiJ79
	 PCfanhs9MbAaj3dye8obF6ePYzQuG1doNl2w98cbzEscvW2MNmoAhE0CV7upTM9D26hpMdOYT6Dfra
	 J2zfvCo5E8vS+HxY/7OS/BQBrbZpdwr0uw/Du9wsX2Edo/sdjl2Dy9gLJaY38lm9sVWPCLvjG+rpVF
	 Zo65N7u7e+l3/msF889lkZ8qyfAXhJQ==
X-KPN-MID: 33|nss8aZGJpXdReaZkUd70hJO9JSWv25nY8ZSboxeaYQJtyJR3GJMHyo1J2IOOTQf
 Rhk4r8tBYsg3p80Wk8UUdn/wlF1srQ4YOF+E+LlvfT9Q=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|SUUJ0h/FlK7C91OW+lILLbqmA3c778tV2oPR5+HsCaSqdePeLZl9bsElYDZcfkn
 ohmtO57h9aj0a/l8/rU11WQ==
Received: from daedalus.home (unknown [178.230.185.145])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2f2139df-3677-11f1-8011-005056ab7447;
	Sun, 12 Apr 2026 15:54:55 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	cmirabil@redhat.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an O_DIRECTORY fd
Date: Sun, 12 Apr 2026 15:54:33 +0200
Message-ID: <20260412135434.3095416-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FREEMAIL_CC(0.00)[zytor.com,suse.cz,infradead.org,redhat.com,kernel.org,xs4all.nl,linutronix.de,efficios.com,cyphar.com,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-6083-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA5B03E4140
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently there is no way to race-freely create and open a directory.
For regular files we have open(O_CREAT) for creating a new file inode,
and returning a pinning fd to it. The lack of such functionality for
directories means that when populating a directory tree there's always
a race involved: the inodes first need to be created, and then opened
to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
but in the time window between the creation and the opening they might
be replaced by something else.

Addressing this race without proper APIs is possible (by immediately
fstat()ing what was opened, to verify that it has the right inode type),
but difficult to get right. Hence, mkdirat2() that creates a directory
and returns an O_DIRECTORY fd is useful.

This feature idea (and description) is taken from the UAPI group:
https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/internal.h                          |  2 ++
 fs/namei.c                             | 44 +++++++++++++++++++++++---
 include/linux/syscalls.h               |  2 ++
 include/uapi/asm-generic/unistd.h      |  5 ++-
 scripts/syscall.tbl                    |  1 +
 6 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..e200ca2067a4 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,6 +396,7 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
+472	common	mkdirat2		sys_mkdirat2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..c6a79afadacf 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -59,6 +59,8 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link);
 int filename_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
 int filename_mkdirat(int dfd, struct filename *name, umode_t mode);
+struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
+		unsigned int flags, bool open);
 int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int dev);
 int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
 int filename_linkat(int olddfd, struct filename *old, int newdfd,
diff --git a/fs/namei.c b/fs/namei.c
index a880454a6415..6451e96dc225 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5255,18 +5255,36 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 }
 EXPORT_SYMBOL(vfs_mkdir);
 
-int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
+static int mkdirat_lookup_flags(unsigned int flags)
+{
+	int lookup_flags = LOOKUP_DIRECTORY;
+
+	if (!(flags & AT_SYMLINK_NOFOLLOW))
+		lookup_flags |= LOOKUP_FOLLOW;
+	if (!(flags & AT_NO_AUTOMOUNT))
+		lookup_flags |= LOOKUP_AUTOMOUNT;
+
+	return lookup_flags;
+}
+
+int filename_mkdirat(int dfd, struct filename *name, umode_t mode) {
+	return PTR_ERR_OR_ZERO(do_file_mkdirat(dfd, name, mode, 0, false));
+}
+
+struct file *do_file_mkdirat(int dfd, struct filename *name, umode_t mode,
+		unsigned int flags, bool open)
 {
 	struct dentry *dentry;
 	struct path path;
 	int error;
-	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	struct file *filp = NULL;
+	unsigned int lookup_flags = mkdirat_lookup_flags(flags);
 	struct delegated_inode delegated_inode = { };
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
 	if (IS_ERR(dentry))
-		return PTR_ERR(dentry);
+		return ERR_CAST(dentry);
 
 	error = security_path_mkdir(&path, dentry,
 			mode_strip_umask(path.dentry->d_inode, mode));
@@ -5276,6 +5294,10 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
+	if (open && !error && !is_delegated(&delegated_inode)) {
+		const struct path new_path = { .mnt = path.mnt, .dentry = dentry };
+		filp = dentry_open(&new_path, O_DIRECTORY, current_cred());
+	}
 	end_creating_path(&path, dentry);
 	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
@@ -5286,7 +5308,21 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
-	return error;
+	if (error)
+		return ERR_PTR(error);
+	return filp;
+}
+
+#define VALID_MKDIRAT2_FLAGS (AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT)
+
+SYSCALL_DEFINE4(mkdirat2, int, dfd, const char __user *, pathname, umode_t, mode,
+		unsigned int, flags)
+{
+	CLASS(filename, name)(pathname);
+	if (flags & ~VALID_MKDIRAT2_FLAGS)
+		return -EINVAL;
+
+	return FD_ADD(O_CLOEXEC, do_file_mkdirat(dfd, name, mode, flags, true));
 }
 
 SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 02bd6ddb6278..b3b4ae26dbdd 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -999,6 +999,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
 				      u32 size, u32 flags);
 asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
+asmlinkage long sys_mkdirat2(int dfd, const char __user *pathname, umode_t mode,
+				     unsigned int flags)
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..6efc21779b62 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,11 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+#define __NR_mkdirat2 472
+__SYSCALL(__NR_mkdirat2, sys_mkdirat2)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..9d86f29762ae 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mkdirat2			sys_mkdirat2
-- 
2.53.0


