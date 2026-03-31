Return-Path: <linux-api+bounces-6047-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK8HJzkKzGn+NQYAu9opvQ
	(envelope-from <linux-api+bounces-6047-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 19:54:01 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3E36F741
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 19:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A236313209A
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2026 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195C345CBE;
	Tue, 31 Mar 2026 17:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oylyme5g"
X-Original-To: linux-api@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A07345753
	for <linux-api@vger.kernel.org>; Tue, 31 Mar 2026 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774977689; cv=none; b=Wdh2AS97MxdoNkodA9QNlydPvxCrzBp4Lk3yZsljGH3pN6UcwW5/DkrFiJmfgWQ9fWzrGHpPxhLL2rnzo+p7JYuDXBdQHd4F/p8Im5fXJrp1gkk+fbKOJ7qzHTYlRfvxZVRVHc6DqVFKLT6/eaE4EqyeyRs131qX+iVeG+s/vt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774977689; c=relaxed/simple;
	bh=yWQgdgRhZbv2l7+Ro7qNBtP2xSE0vb5n5/JP2mfl/+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6mh1ZuR8QiqKonOirXfJx6P14UXVxrOgimfr1jxwLKBRLrLw86JYc9nKs7rrr+MVv4QCB6o4RoHkgF1qtCC4EaNqLvHWCCDNatEWSQjdqQjqZb+eJpVWh1kXsFcuYUMEhj0zcPUicNJ8oBYHR80u42ZkDNzOEWFl3cNTz4mnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oylyme5g; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: e41bc105-2d25-11f1-bea5-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e41bc105-2d25-11f1-bea5-005056992ed3;
	Tue, 31 Mar 2026 19:20:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=R8axV3zrGCR8LJlu0OosxCPVJsIb2s3wxLdTHN9HNfs=;
	b=oylyme5gUdOycP1i4/B3srC+vbVwh/GgRfJ5is0ImO70jvMbB9EmnAHUalR5tDlHBuVGaTRwBoGYF
	 IfMjtyhvIiSDU/6305uGLevty4qBBnCyPup6MEN28pGKFSoWgYDkqWr9eZBceWN5O3UXsxyKYi+B3Q
	 IM0yCpJk36Yp3AeS7ePQnMpJy9EQv7U4LTQgKqau4feqLgP/ILmi/l33fZ/TEgXPaUBajy42mPw5Fk
	 YINjhjnosgm5yvM4pItsURKfeiwaIgZebvYtI2wqx6paXPkePXhzt3kHJm4FaTW4ZcUGPT1FDE5amS
	 +yY66969218gVp+2eruq7fjvfV40NKg==
X-KPN-MID: 33|E+oMIFqNqCiE4l2kkzmIREhn0jNvfbd5HtdsBoKJlJtYl6UMqHxfksVtxQu3h4a
 S1l/vKYh5kODQ0fVPu6NrAqTCqTdBWcGeVQFguoybViY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oK00dgZQze3kacwmaEU7YrVnVXYLTTTiqkBii5XgtPLNjONTvUlor+wDZ5NSIjp
 HloufzgZAlY5Cchja9QZN0g==
Received: from daedalus.home (unknown [178.227.25.158])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id e3a32562-2d25-11f1-86d5-005056998788;
	Tue, 31 Mar 2026 19:20:18 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jan Kara <jack@suse.cz>,
	Alexander Aring <alex.aring@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	cmirabil@redhat.com,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [RFC PATCH 1/2] vfs: syscalls: add mkdirat_fd()
Date: Tue, 31 Mar 2026 19:19:58 +0200
Message-ID: <20260331172011.3512876-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
References: <20260331172011.3512876-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,efficios.com,linutronix.de,cyphar.com,vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-6047-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zeniv.linux.org.uk,oracle.com,arndb.de,linuxfoundation.org,zytor.com,suse.cz,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid]
X-Rspamd-Queue-Id: 45E3E36F741
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
but difficult to get right. Hence, mkdirat_fd() that creates a directory
and returns an O_DIRECTORY fd is useful.

This feature idea (and description) is taken from the UAPI group:
https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 fs/internal.h                          |  1 +
 fs/namei.c                             | 26 ++++++++++++++++++++++++--
 include/linux/fcntl.h                  |  2 ++
 include/linux/syscalls.h               |  2 ++
 include/uapi/asm-generic/fcntl.h       |  3 +++
 include/uapi/asm-generic/unistd.h      |  5 ++++-
 scripts/syscall.tbl                    |  1 +
 8 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..dda920c26941 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,6 +396,7 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
+472	common	mkdirat_fd		sys_mkdirat_fd
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..2885a3e4ebdd 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,6 +58,7 @@ int filename_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct mnt_idmap *idmap, const struct path *link);
 int filename_renameat2(int olddfd, struct filename *oldname, int newdfd,
 		 struct filename *newname, unsigned int flags);
+int filename_mkdirat_fd(int dfd, struct filename *name, umode_t mode, unsigned int flags);
 int filename_mkdirat(int dfd, struct filename *name, umode_t mode);
 int filename_mknodat(int dfd, struct filename *name, umode_t mode, unsigned int dev);
 int filename_symlinkat(struct filename *from, int newdfd, struct filename *to);
diff --git a/fs/namei.c b/fs/namei.c
index 1eb9db055292..93252937983e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -5256,6 +5256,11 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 EXPORT_SYMBOL(vfs_mkdir);
 
 int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
+{
+	return filename_mkdirat_fd(dfd, name, mode, 0);
+}
+
+int filename_mkdirat_fd(int dfd, struct filename *name, umode_t mode, unsigned int flags)
 {
 	struct dentry *dentry;
 	struct path path;
@@ -5263,7 +5268,7 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
 	struct delegated_inode delegated_inode = { };
 
-retry:
+start:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
@@ -5276,7 +5281,6 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 		if (IS_ERR(dentry))
 			error = PTR_ERR(dentry);
 	}
-	end_creating_path(&path, dentry);
 	if (is_delegated(&delegated_inode)) {
 		error = break_deleg_wait(&delegated_inode);
 		if (!error)
@@ -5286,7 +5290,25 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
 		lookup_flags |= LOOKUP_REVAL;
 		goto retry;
 	}
+
+	if (!error && (flags & MKDIRAT_FD_NEED_FD)) {
+		struct path new_path = { .mnt = path.mnt, .dentry = dentry };
+		error = FD_ADD(0, dentry_open(&new_path, O_DIRECTORY, current_cred()));
+	}
+	end_creating_path(&path, dentry);
 	return error;
+retry:
+	end_creating_path(&path, dentry);
+	goto start;
+}
+
+SYSCALL_DEFINE4(mkdirat_fd, int, dfd, const char __user *, pathname, umode_t, mode,
+		unsigned int, flags)
+{
+	CLASS(filename, name)(pathname);
+	if (flags & ~VALID_MKDIRAT_FD_FLAGS)
+		return -EINVAL;
+	return filename_mkdirat_fd(dfd, name, mode, flags | MKDIRAT_FD_NEED_FD);
 }
 
 SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..d2f0fdb82847 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -25,6 +25,8 @@
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
 #endif
 
+#define VALID_MKDIRAT_FD_FLAGS	(MKDIRAT_FD_NEED_FD)
+
 #if BITS_PER_LONG == 32
 #define IS_GETLK32(cmd)		((cmd) == F_GETLK)
 #define IS_SETLK32(cmd)		((cmd) == F_SETLK)
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 02bd6ddb6278..52e7f09d5525 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -999,6 +999,8 @@ asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx __user *
 asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx __user *ctx,
 				      u32 size, u32 flags);
 asmlinkage long sys_lsm_list_modules(u64 __user *ids, u32 __user *size, u32 flags);
+asmlinkage long sys_mkdirat_fd(int dfd, const char __user *pathname, umode_t mode,
+				     unsigned int flags)
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..621458bf1fbf 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -95,6 +95,9 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+/* Flags for mkdirat_fd */
+#define MKDIRAT_FD_NEED_FD	0x01
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..5bae1029f5d9 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,11 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+#define __NR_mkdirat_fd 472
+__SYSCALL(__NR_mkdirat_fd, sys_mkdirat_fd)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 473
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..db3bd97d4a1a 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mkdirat_fd			sys_mkdirat_fd
-- 
2.53.0


