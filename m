Return-Path: <linux-api+bounces-166-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D5F7FBEDD
	for <lists+linux-api@lfdr.de>; Tue, 28 Nov 2023 17:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC50E282839
	for <lists+linux-api@lfdr.de>; Tue, 28 Nov 2023 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B01E4BF;
	Tue, 28 Nov 2023 16:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CmIYHWfL"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A2DDA
	for <linux-api@vger.kernel.org>; Tue, 28 Nov 2023 08:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=omywh3uYUA+OP9xtT6bY+D59biyAwUJXDod3WOPdRWc=;
	b=CmIYHWfLx+LfhtCmpoBGVsAlWG8/jnlH0Sp2TKzQWmLVHHL9+qaDXyWDGgz3TZ9Y5ohvX9
	gdDOLX1qrPpU4/0iQEQ28bR6xctYvlEZJv6JNA9JLE8T+hCuO79mdhcb6M+k79fcLtheeB
	Y37c7I/G2zUnRlK9HNtrjz8PONd0DJQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-jE0vHrKkMz2FUAOACA5p6w-1; Tue, 28 Nov 2023 11:03:51 -0500
X-MC-Unique: jE0vHrKkMz2FUAOACA5p6w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-333112c1e72so429422f8f.0
        for <linux-api@vger.kernel.org>; Tue, 28 Nov 2023 08:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187429; x=1701792229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omywh3uYUA+OP9xtT6bY+D59biyAwUJXDod3WOPdRWc=;
        b=Fwqqd6W0e5d4FTrEAAzk7Qcm9FHEDs7jIkmMibmFs+bsCaQAgAznhPvuvrw4edsGG2
         2c7t4/nlGaa6OdyZWY4Z986m3oetLTgBA3O/5UDE6odphRaPJieKCMDo0KLbbQS8K8K/
         4nWyZfznJuM+DRd6ZRzgDGOO3vUB4Z4iBcvzKnNxuaP3LWNPZrB7ZscPHJZjnmlPyZQC
         yndIl2WovnF3S/dOzRonJnlK40rD2gTd0h8TIZEXPWowZBEeMWTDVHzXYJkZDh4iZCPD
         0rkymYRbpqQyTHN82406OqtErTgRSLVdN86W0DywSXA0iwRmY0egeZFjmCcZBJ776nA+
         a15g==
X-Gm-Message-State: AOJu0YzctBhAO7cTSjAuaveYg/y4ji6yqecDrqxquz9ISX7HzDD2xDK4
	IRLLS/iX2l3geFAetgcKRaDXssmQiHr33ri0V0d37tDnlqb49Jm+vd/Djg+ry7TrNrFQ6n5sGM4
	55UFKys3mhBszwAjeCSxF
X-Received: by 2002:adf:f1c1:0:b0:333:57:52dc with SMTP id z1-20020adff1c1000000b00333005752dcmr6968616wro.28.1701187429395;
        Tue, 28 Nov 2023 08:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjBXrvjTmUnqUbvz6X5Z6wicgMGQwKTpwouHd6eOg+ohVwquafvdjG1qDYQ2HQi5uGrlK3bQ==
X-Received: by 2002:adf:f1c1:0:b0:333:57:52dc with SMTP id z1-20020adff1c1000000b00333005752dcmr6968581wro.28.1701187429027;
        Tue, 28 Nov 2023 08:03:49 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:47 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: linux-api@vger.kernel.org,
	linux-man@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/4] listmount: small changes in semantics
Date: Tue, 28 Nov 2023 17:03:34 +0100
Message-ID: <20231128160337.29094-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128160337.29094-1-mszeredi@redhat.com>
References: <20231128160337.29094-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

1) Make permission checking consistent with statmount(2): fail if mount is
unreachable from current root.  Previously it failed if mount was
unreachable from root->mnt->mnt_root.

2) List all submounts, even if unreachable from current root.  This is
safe, since 1) will prevent listing unreachable mounts for unprivileged
users.

3) LSMT_ROOT is unchaged, it lists mounts under current root.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ad62cf7ee334..10cd651175b5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5004,37 +5004,26 @@ static struct mount *listmnt_next(struct mount *curr)
 	return node_to_mount(rb_next(&curr->mnt_node));
 }
 
-static ssize_t do_listmount(struct mount *first, struct vfsmount *mnt,
+static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
 			    u64 __user *buf, size_t bufsize,
 			    const struct path *root)
 {
-	struct mount *r, *m = real_mount(mnt);
-	struct path rootmnt = {
-		.mnt = root->mnt,
-		.dentry = root->mnt->mnt_root
-	};
-	struct path orig;
+	struct mount *r;
 	ssize_t ctr;
 	int err;
 
-	if (!is_path_reachable(m, mnt->mnt_root, &rootmnt))
-		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
+	if (!capable(CAP_SYS_ADMIN) &&
+	    !is_path_reachable(real_mount(orig->mnt), orig->dentry, root))
+		return -EPERM;
 
-	err = security_sb_statfs(mnt->mnt_root);
+	err = security_sb_statfs(orig->dentry);
 	if (err)
 		return err;
 
-	if (root->mnt == mnt) {
-		orig = *root;
-	} else {
-		orig.mnt = mnt;
-		orig.dentry = mnt->mnt_root;
-	}
-
 	for (ctr = 0, r = first; r; r = listmnt_next(r)) {
-		if (r == m)
+		if (r->mnt_id_unique == mnt_id)
 			continue;
-		if (!is_path_reachable(r, r->mnt.mnt_root, &orig))
+		if (!is_path_reachable(r, r->mnt.mnt_root, orig))
 			continue;
 
 		if (ctr >= bufsize)
@@ -5053,9 +5042,8 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 {
 	struct mnt_namespace *ns = current->nsproxy->mnt_ns;
 	struct mnt_id_req kreq;
-	struct vfsmount *mnt;
 	struct mount *first;
-	struct path root;
+	struct path root, orig;
 	u64 mnt_id;
 	ssize_t ret;
 
@@ -5071,16 +5059,17 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	down_read(&namespace_sem);
 	get_fs_root(current->fs, &root);
 	if (mnt_id == LSMT_ROOT) {
-		mnt = root.mnt;
+		orig = root;
 	} else {
 		ret = -ENOENT;
-		mnt  = lookup_mnt_in_ns(mnt_id, ns);
-		if (!mnt)
+		orig.mnt  = lookup_mnt_in_ns(mnt_id, ns);
+		if (!orig.mnt)
 			goto err;
+		orig.dentry = orig.mnt->mnt_root;
 	}
 	first = node_to_mount(rb_first(&ns->mounts));
 
-	ret = do_listmount(first, mnt, buf, bufsize, &root);
+	ret = do_listmount(first, &orig, mnt_id, buf, bufsize, &root);
 err:
 	path_put(&root);
 	up_read(&namespace_sem);
-- 
2.41.0


