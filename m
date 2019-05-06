Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC189151FA
	for <lists+linux-api@lfdr.de>; Mon,  6 May 2019 18:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfEFQzf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 May 2019 12:55:35 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:57802 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfEFQze (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 6 May 2019 12:55:34 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id CA424A019E;
        Mon,  6 May 2019 18:55:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id rkY7VObg7gfm; Mon,  6 May 2019 18:55:17 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v6 1/6] namei: split out nd->dfd handling to dirfd_path_init
Date:   Tue,  7 May 2019 02:54:34 +1000
Message-Id: <20190506165439.9155-2-cyphar@cyphar.com>
In-Reply-To: <20190506165439.9155-1-cyphar@cyphar.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Previously, path_init's handling of *at(dfd, ...) was only done once,
but with O_BENEATH (and O_THISROOT) we have to parse the initial
nd->path at different times (before or after absolute path handling)
depending on whether we have been asked to scope resolution within a
root.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c | 103 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 44 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5ebd64b21970..2a91b72aa5e9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2166,9 +2166,59 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	}
 }
 
+/*
+ * Configure nd->path based on the nd->dfd. This is only used as part of
+ * path_init().
+ */
+static inline int dirfd_path_init(struct nameidata *nd)
+{
+	if (nd->dfd == AT_FDCWD) {
+		if (nd->flags & LOOKUP_RCU) {
+			struct fs_struct *fs = current->fs;
+			unsigned seq;
+
+			do {
+				seq = read_seqcount_begin(&fs->seq);
+				nd->path = fs->pwd;
+				nd->inode = nd->path.dentry->d_inode;
+				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
+			} while (read_seqcount_retry(&fs->seq, seq));
+		} else {
+			get_fs_pwd(current->fs, &nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+	} else {
+		/* Caller must check execute permissions on the starting path component */
+		struct fd f = fdget_raw(nd->dfd);
+		struct dentry *dentry;
+
+		if (!f.file)
+			return -EBADF;
+
+		dentry = f.file->f_path.dentry;
+
+		if (*nd->name->name && unlikely(!d_can_lookup(dentry))) {
+			fdput(f);
+			return -ENOTDIR;
+		}
+
+		nd->path = f.file->f_path;
+		if (nd->flags & LOOKUP_RCU) {
+			nd->inode = nd->path.dentry->d_inode;
+			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
+		} else {
+			path_get(&nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+		fdput(f);
+	}
+	return 0;
+}
+
 /* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
+	int error;
 	const char *s = nd->name->name;
 
 	if (!*s)
@@ -2202,52 +2252,17 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->m_seq = read_seqbegin(&mount_lock);
 	if (*s == '/') {
-		set_root(nd);
-		if (likely(!nd_jump_root(nd)))
-			return s;
-		return ERR_PTR(-ECHILD);
-	} else if (nd->dfd == AT_FDCWD) {
-		if (flags & LOOKUP_RCU) {
-			struct fs_struct *fs = current->fs;
-			unsigned seq;
-
-			do {
-				seq = read_seqcount_begin(&fs->seq);
-				nd->path = fs->pwd;
-				nd->inode = nd->path.dentry->d_inode;
-				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
-			} while (read_seqcount_retry(&fs->seq, seq));
-		} else {
-			get_fs_pwd(current->fs, &nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		return s;
-	} else {
-		/* Caller must check execute permissions on the starting path component */
-		struct fd f = fdget_raw(nd->dfd);
-		struct dentry *dentry;
-
-		if (!f.file)
-			return ERR_PTR(-EBADF);
-
-		dentry = f.file->f_path.dentry;
-
-		if (*s && unlikely(!d_can_lookup(dentry))) {
-			fdput(f);
-			return ERR_PTR(-ENOTDIR);
-		}
-
-		nd->path = f.file->f_path;
-		if (flags & LOOKUP_RCU) {
-			nd->inode = nd->path.dentry->d_inode;
-			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
-		} else {
-			path_get(&nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		fdput(f);
+		if (likely(!nd->root.mnt))
+			set_root(nd);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			s = ERR_PTR(error);
 		return s;
 	}
+	error = dirfd_path_init(nd);
+	if (unlikely(error))
+		return ERR_PTR(error);
+	return s;
 }
 
 static const char *trailing_symlink(struct nameidata *nd)
-- 
2.21.0

