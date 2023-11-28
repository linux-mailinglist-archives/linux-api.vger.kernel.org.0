Return-Path: <linux-api+bounces-167-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B628F7FBEE0
	for <lists+linux-api@lfdr.de>; Tue, 28 Nov 2023 17:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40AE6B215C0
	for <lists+linux-api@lfdr.de>; Tue, 28 Nov 2023 16:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A7B59B74;
	Tue, 28 Nov 2023 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f02JtWPW"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFF9D51
	for <linux-api@vger.kernel.org>; Tue, 28 Nov 2023 08:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701187435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4m6tDkdqSaR0d8GaO2j1yGeRlQK9+QqRyo5nT9BhDIE=;
	b=f02JtWPWEKgCA8GmNTKRReexbfNgAZzAmt6TvezknO5lzt1M0+u60WFtNBte2rKzWLtygB
	qGQLXZZCdzOgh675S8jl43lK3xM8A06E+6CRMiKsw/x9bHK4Sp+OMajbOJC5OA9fw4GuI6
	LBfwzKqtmQnAoVVECjUwGUvckKbr8hI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-UVim76qbN0eYARiyGSJoiA-1; Tue, 28 Nov 2023 11:03:53 -0500
X-MC-Unique: UVim76qbN0eYARiyGSJoiA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332f6a7c8b1so2234842f8f.2
        for <linux-api@vger.kernel.org>; Tue, 28 Nov 2023 08:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187432; x=1701792232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4m6tDkdqSaR0d8GaO2j1yGeRlQK9+QqRyo5nT9BhDIE=;
        b=TEKbW/RQOgaaL3Svshu8tQtgajWIv+wBwlGX1leUYUR+8LLT4Om/oKImjf44zfBaPZ
         14OFTBSKkQR/gW6jhRR9EZHwcKfD9iU/EcQBNtaAJ2WBcvDxmMWYVrpjjWXCcLaCi5b6
         cQFTAALI4JjOJyECJJvuFm8I/JrUeQKFkPH6+E0eZZac6wJqQUpJNayUYWLQE1I8Dksd
         ZJdcCcTw9OVb6/hCcnr7E5XaE+EIWwk5c455g1hPhMRmdhbygBs3eW2HR1SkFkQpsFZE
         UBRBjJl+V1LJ9gBu8oWq2zdTQ2Fl7czOk1iSTVet7jEFEaBDcEXTqQDidiFwuqdbcC1S
         1stQ==
X-Gm-Message-State: AOJu0Yy7FdfxcH2gB0tyWXh+dbTEuLwumoyp5cZutMvmLQGsfT2Q/1yd
	oiM4kmGH+BMEynYm1wttEXxP33zLsVk2K12FG/ttCRLu0oiz5oHNSxEElBmf9WwXmbDZPqUkqM1
	pQZpLAnh8K7BbLOOvziG4
X-Received: by 2002:a5d:424a:0:b0:32f:7c4d:8746 with SMTP id s10-20020a5d424a000000b0032f7c4d8746mr10709419wrr.12.1701187432771;
        Tue, 28 Nov 2023 08:03:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSw+uqLHp4posNurAQ3xZ86X68JibS7pcphfK76/nFWMAGed6YOaHy9YzICF60bQ7CfXQuxg==
X-Received: by 2002:a5d:424a:0:b0:32f:7c4d:8746 with SMTP id s10-20020a5d424a000000b0032f7c4d8746mr10709402wrr.12.1701187432494;
        Tue, 28 Nov 2023 08:03:52 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (89-148-117-163.pool.digikabel.hu. [89.148.117.163])
        by smtp.gmail.com with ESMTPSA id w27-20020adf8bdb000000b00332e5624a31sm14745352wra.84.2023.11.28.08.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:03:49 -0800 (PST)
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
Subject: [PATCH 4/4] listmount: allow continuing
Date: Tue, 28 Nov 2023 17:03:35 +0100
Message-ID: <20231128160337.29094-5-mszeredi@redhat.com>
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

Rename mnt_id_req.request_mask to .param to allow using it for listmount(2)
as well.

1) If the buffer is full don't return EOVERFLOW, instead return the buffer
size.  This still allows detecting a full buffer.

2) listing is continued after the ID contained in .param.  This allows
listing the mount IDs in multiple listmount() invocations without having to
resize buffer.  If .param is zero, then the listing is started from the
beginning, just like previously.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 17 ++++++++---------
 include/uapi/linux/mount.h |  9 ++++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 10cd651175b5..5c1455c4b53b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4942,7 +4942,7 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 		return -EFAULT;
 
 	*ks = (struct kstatmount){
-		.mask		= kreq->request_mask,
+		.mask		= kreq->param,
 		.buf		= buf,
 		.bufsize	= bufsize,
 		.seq = {
@@ -5020,14 +5020,11 @@ static ssize_t do_listmount(struct mount *first, struct path *orig, u64 mnt_id,
 	if (err)
 		return err;
 
-	for (ctr = 0, r = first; r; r = listmnt_next(r)) {
+	for (ctr = 0, r = first; r && ctr < bufsize; r = listmnt_next(r)) {
 		if (r->mnt_id_unique == mnt_id)
 			continue;
 		if (!is_path_reachable(r, r->mnt.mnt_root, orig))
 			continue;
-
-		if (ctr >= bufsize)
-			return -EOVERFLOW;
 		ctr = array_index_nospec(ctr, bufsize);
 		if (put_user(r->mnt_id_unique, buf + ctr))
 			return -EFAULT;
@@ -5044,7 +5041,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	struct mnt_id_req kreq;
 	struct mount *first;
 	struct path root, orig;
-	u64 mnt_id;
+	u64 mnt_id, last_mnt_id;
 	ssize_t ret;
 
 	if (flags)
@@ -5052,9 +5049,8 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 
 	if (copy_from_user(&kreq, req, sizeof(kreq)))
 		return -EFAULT;
-	if (kreq.request_mask != 0)
-		return -EINVAL;
 	mnt_id = kreq.mnt_id;
+	last_mnt_id = kreq.param;
 
 	down_read(&namespace_sem);
 	get_fs_root(current->fs, &root);
@@ -5067,7 +5063,10 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 			goto err;
 		orig.dentry = orig.mnt->mnt_root;
 	}
-	first = node_to_mount(rb_first(&ns->mounts));
+	if (!last_mnt_id)
+		first = node_to_mount(rb_first(&ns->mounts));
+	else
+		first = mnt_find_id_at(ns, last_mnt_id + 1);
 
 	ret = do_listmount(first, &orig, mnt_id, buf, bufsize, &root);
 err:
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index f6b35a15b7dd..dc9a0112d819 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -176,9 +176,16 @@ struct statmount {
 	char str[];		/* Variable size part containing strings */
 };
 
+/*
+ * Structure for passing mount ID and miscellaneous parameters to statmount(2)
+ * and listmount(2).
+ *
+ * For statmount(2) @param represents the request mask.
+ * For listmount(2) @param represents the last listed mount id (or zero).
+ */
 struct mnt_id_req {
 	__u64 mnt_id;
-	__u64 request_mask;
+	__u64 param;
 };
 
 /*
-- 
2.41.0


