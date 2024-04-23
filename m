Return-Path: <linux-api+bounces-1342-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002CB8AE345
	for <lists+linux-api@lfdr.de>; Tue, 23 Apr 2024 13:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5B81F220CC
	for <lists+linux-api@lfdr.de>; Tue, 23 Apr 2024 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7777E579;
	Tue, 23 Apr 2024 11:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Sc5uDBKC"
X-Original-To: linux-api@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6F18645;
	Tue, 23 Apr 2024 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870138; cv=none; b=faQCzTpq93ynvb2GId3Kwt+c73gm9KopEEKsEhZ3IZi8IP38ioso4QO03qa4PAXugpwyeJsTXbA2duxOWmvovUJbqEFGkU4JFz7IQbrOpXO1jeF+Owh5IarA3ZpmpOSOi+IuB3t/6npbl3yC8MslWyibtt4664vWIXIeRx1mg1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870138; c=relaxed/simple;
	bh=+OSMikil93STCKOPtNMLQAgzOlKbqGJFnnhDVohp4t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gphDoiW1KBB0yU2FMLVTRthcBmM2fmtJ0M02pjvG2sxvCAzVi20SLkUYF5BwOQovXNiyalbYQsbcLWSP1egEeZbMsykpDuA3SMQR00afzCkffr0uK2Zsnt9ARhsCzbGhIjKxk5eL10Fa0CQk08OEQ2K1rNaVUTsEc3mzw+W4b5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Sc5uDBKC; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:141d:0:640:ccff:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id C6ABC608ED;
	Tue, 23 Apr 2024 14:02:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 22IG0mHOiCg0-EVUKjbfs;
	Tue, 23 Apr 2024 14:02:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1713870125; bh=ehiAOGcVzI3bx2ma+GbYdge1RWRGLiGOpmC8xlK5PQE=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=Sc5uDBKCFa0aCCpaCJ7m5o55s7tpS/fxd7gCye2O2S26K7T4dCPTwvOYdK2XEazkA
	 HXceo8DR5PVrs4q39L6iez1Lia5aZytyTNG6TutlEsg/pQwzFrtgiRkjU0kQKTteY1
	 wCqTX1wcLFikklwgcrn4hdU9W4VqQap2q5096GiM=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/2] openat2: add OA2_INHERIT_CRED flag
Date: Tue, 23 Apr 2024 14:01:48 +0300
Message-ID: <20240423110148.13114-3-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423110148.13114-1-stsp2@yandex.ru>
References: <20240423110148.13114-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This flag performs the open operation with the credentials that
were in effect when dir_fd was opened.
This allows the process to pre-open some directories and then
change eUID (and all other UIDs/GIDs) to a less-privileged user,
retaining the ability to open/create files within these directories.

Design goal:
The idea is to provide a very light-weight sandboxing, where the
process, without the use of any heavy-weight techniques like chroot
within namespaces, can restrict the access to the set of pre-opened
directories.
This patch is just a first step to such sandboxing. If things go
well, in the future the same extension can be added to more syscalls.
These should include at least unlinkat(), renameat2() and the
not-yet-upstreamed setxattrat().

Security considerations:
To avoid sandboxing escape, this patch makes sure the restricted
lookup modes are used. Namely, RESOLVE_BENEATH or RESOLVE_IN_ROOT.
To avoid leaking creds across exec, this patch requires O_CLOEXEC
flag on a directory.

Use cases:
Virtual machines that deal with untrusted code, can use that
instead of a more heavy-weighted approaches.
Currently the approach is being tested on a dosemu2 VM.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Stefan Metzmacher <metze@samba.org>
CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Andy Lutomirski <luto@kernel.org>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Aring <alex.aring@gmail.com>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christian Göttsche <cgzones@googlemail.com>
---
 fs/internal.h                |  2 +-
 fs/namei.c                   | 30 ++++++++++++++++++++++++++++--
 fs/open.c                    |  2 +-
 include/linux/fcntl.h        |  2 ++
 include/uapi/linux/openat2.h |  3 +++
 5 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 7ca738904e34..692b53b19aad 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -169,7 +169,7 @@ static inline void sb_end_ro_state_change(struct super_block *sb)
  * open.c
  */
 struct open_flags {
-	int open_flag;
+	u64 open_flag;
 	umode_t mode;
 	int acc_mode;
 	int intent;
diff --git a/fs/namei.c b/fs/namei.c
index 2fde2c320ae9..0e0f2e32ef02 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -586,6 +586,7 @@ struct nameidata {
 	int		dfd;
 	vfsuid_t	dir_vfsuid;
 	umode_t		dir_mode;
+	const struct cred *dir_open_cred;
 } __randomize_layout;
 
 #define ND_ROOT_PRESET 1
@@ -695,6 +696,7 @@ static void terminate_walk(struct nameidata *nd)
 	nd->depth = 0;
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
+	put_cred(nd->dir_open_cred);
 }
 
 /* path_put is needed afterwards regardless of success or failure */
@@ -2414,6 +2416,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			get_fs_pwd(current->fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		nd->dir_open_cred = get_current_cred();
 	} else {
 		/* Caller must check execute permissions on the starting path component */
 		struct fd f = fdget_raw(nd->dfd);
@@ -2437,6 +2440,7 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			path_get(&nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		nd->dir_open_cred = get_cred(f.file->f_cred);
 		fdput(f);
 	}
 
@@ -3794,8 +3798,28 @@ static struct file *path_openat(struct nameidata *nd,
 		error = do_o_path(nd, flags, file);
 	} else {
 		const char *s = path_init(nd, flags);
-		file = alloc_empty_file(op->open_flag, current_cred());
-		error = PTR_ERR_OR_ZERO(file);
+		const struct cred *old_cred = NULL;
+
+		error = 0;
+		if (op->open_flag & OA2_INHERIT_CRED) {
+			/* Make sure to work only with restricted
+			 * look-up modes.
+			 */
+			if (!(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
+				error = -EPERM;
+			/* Only work with O_CLOEXEC dirs. */
+			if (!get_close_on_exec(nd->dfd))
+				error = -EPERM;
+
+			if (!error)
+				old_cred = override_creds(nd->dir_open_cred);
+		}
+		if (!error) {
+			file = alloc_empty_file(op->open_flag, current_cred());
+			error = PTR_ERR_OR_ZERO(file);
+		} else {
+			file = ERR_PTR(error);
+		}
 		if (!error) {
 			while (!(error = link_path_walk(s, nd)) &&
 			       (s = open_last_lookups(nd, file, op)) != NULL)
@@ -3803,6 +3827,8 @@ static struct file *path_openat(struct nameidata *nd,
 		}
 		if (!error)
 			error = do_open(nd, file, op);
+		if (old_cred)
+			revert_creds(old_cred);
 		terminate_walk(nd);
 		if (IS_ERR(file))
 			return file;
diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..6be013182a35 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1225,7 +1225,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..b71f8b162102 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OA2_INHERIT_CRED)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..cdd676a10b62 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -40,4 +40,7 @@ struct open_how {
 					return -EAGAIN if that's not
 					possible. */
 
+/* openat2-specific flags go to upper 4 bytes. */
+#define OA2_INHERIT_CRED		(1ULL << 32)
+
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.44.0


