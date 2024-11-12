Return-Path: <linux-api+bounces-2715-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A061E9C52D0
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 11:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31B3B1F229FF
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284E61F26E3;
	Tue, 12 Nov 2024 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcgVA0mc"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105420D51D
	for <linux-api@vger.kernel.org>; Tue, 12 Nov 2024 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731406214; cv=none; b=YlNwk8JmYAzYpIlbRmGK+d19UbIb15SOiLW0C2KCnbjn792rsb+xUNJGiPDxAzAs6Vm2QNAQZJtdZC/CQc4WKMYNqXt8KQ/vTI2fOc/ofFgTzOX8iRH6fUlu5MwO9Ca3kFnQiWXhBKkexfVW3ntDH+hzGjp3MmUAcy6GWTbE20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731406214; c=relaxed/simple;
	bh=3CqMRoAUQ/VZkOxVTn2tOWqNGD9JA7YdHG+Hw1NNfE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myQeiX8rbJLs+nS60x9110Cg2i+X1EEKLbLq0UOqoTQr9K6hEhrk+soScvIE18uYgJXB4gJjISbQ/5mh58suNvzG9+LSynnWgVbFtDDGY1e1LjW10e3b7I7UGNodjfC/BHJNnFDofGmtzguMrm8K3J8G72+HxRRn0xlulgbwiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcgVA0mc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731406211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nn4qiEJZ+ap7x5uz1e04QMgEzTquaDZxiT0D5O7PuY4=;
	b=ZcgVA0mcMpS2NQc3Bbx8ZRC7zR18C3MEWQT8uG59ytXP2DlBKb0z17QoxRAKPeIPEI352A
	3HLp3hQxSvAnQQODxsRaAZJBLATW9yAXG79Z/d58yKtqOVVtHdou3o1THDvN1VfyufY72/
	5X1BnfjvNp5vLiWV31IGNmMC6HxkGMQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-ZuApJ_YmM362v1Hnkb8Tog-1; Tue, 12 Nov 2024 05:10:09 -0500
X-MC-Unique: ZuApJ_YmM362v1Hnkb8Tog-1
X-Mimecast-MFC-AGG-ID: ZuApJ_YmM362v1Hnkb8Tog
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d462b64e3so2897391f8f.3
        for <linux-api@vger.kernel.org>; Tue, 12 Nov 2024 02:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731406208; x=1732011008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nn4qiEJZ+ap7x5uz1e04QMgEzTquaDZxiT0D5O7PuY4=;
        b=ujFhdcSFZG5NouxJR83xaHE+KvoBkpQ9C7JCcYBH1ouVptJbyn7fbNnkddGscMpSde
         kWNft0Pak0+Cvl4gWhijRWGzYPktBY2K9p6hpKCxl066qRqaBU4j3G3XA+MDzKz2oLkZ
         k3YCNFj0IGlX3vikSY8wUti47EmHho689/52VyB1vz2XehYWwS8kancrsN+bD85clB9X
         Gd4gjxWl9UtlgTO0ITPf4FsQmxwznHzOwq+n0knKBP3em3MvFzYuXTtJCrjKKC8jGR8X
         2V01N7OleVeACqs4uqFPzm7x53m54qR7Pvowf/4aYo5Q6w4azxN2zJo6pTG7Ds2Uzo56
         AYpA==
X-Gm-Message-State: AOJu0Yyiclvdo5pYSvnb597g/6qsIULh1Z2GxIL5KkRF+FAAYijxAWo8
	zOpiKTuokOcNvi/lOCqYpdUQO171UkJQUxnCtSP1HYg3+wDL830A2fgrJzwLHESy/FRM1V2dfMc
	Z9XVVz/22xisozjP/d7C0HdPTN3Xz1PXOAYeIznBPAdfNwOsMJ4qvNTZ21bhkQiXqzQ==
X-Received: by 2002:a5d:5850:0:b0:381:cde6:4ced with SMTP id ffacd0b85a97d-381f1880662mr12419981f8f.45.1731406208061;
        Tue, 12 Nov 2024 02:10:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWiamj90WZFzxDicuPiKeuDO26e0ElLoop/KUBpyDmAXiQTDVLWZDGpnLfUjUzDZ6TLXCz4A==
X-Received: by 2002:a5d:5850:0:b0:381:cde6:4ced with SMTP id ffacd0b85a97d-381f1880662mr12419961f8f.45.1731406207659;
        Tue, 12 Nov 2024 02:10:07 -0800 (PST)
Received: from maszat.piliscsaba.szeredi.hu (193-226-245-233.pool.digikabel.hu. [193.226.245.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970729sm14929937f8f.15.2024.11.12.02.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:10:07 -0800 (PST)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	Karel Zak <kzak@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] statmount: add flag to retrieve unescaped options
Date: Tue, 12 Nov 2024 11:10:04 +0100
Message-ID: <20241112101006.30715-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Filesystem options can be retrieved with STATMOUNT_MNT_OPTS, which
returns a string of comma separated options, where some characters are
escaped using the \OOO notation.

Add a new flag, STATMOUNT_OPT_ARRAY, which instead returns the raw
option values separated with '\0' charaters.

Since escaped charaters are rare, this inteface is preferable for
non-libmount users which likley don't want to deal with option
de-escaping.

Example code:

	if (st->mask & STATMOUNT_OPT_ARRAY) {
		const char *opt = st->str + st->opt_array;

		for (unsigned int i = 0; i < st->opt_num; i++) {
			printf("opt_array[%i]: <%s>\n", i, opt);
			opt += strlen(opt) + 1;
		}
	}

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namespace.c             | 42 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/mount.h |  7 +++++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9a4ab1bc8b94..a16f75011610 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5074,6 +5074,41 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
+{
+	struct vfsmount *mnt = s->mnt;
+	struct super_block *sb = mnt->mnt_sb;
+	size_t start = seq->count;
+	u32 count = 0;
+	char *p, *end, *next, *u = seq->buf + start;
+	int err;
+
+       if (!sb->s_op->show_options)
+               return 0;
+
+       err = sb->s_op->show_options(seq, mnt->mnt_root);
+       if (err)
+	       return err;
+
+       if (unlikely(seq_has_overflowed(seq)))
+	       return -EAGAIN;
+
+       end = seq->buf + seq->count;
+       *end = '\0';
+       for (p = u + 1; p < end; p = next + 1) {
+               next = strchrnul(p, ',');
+               *next = '\0';
+               u += string_unescape(p, u, 0, UNESCAPE_OCTAL) + 1;
+	       count++;
+	       if (!count)
+		       return -EOVERFLOW;
+       }
+       seq->count = u - 1 - seq->buf;
+       s->sm.opt_num = count;
+
+       return 0;
+}
+
 static int statmount_string(struct kstatmount *s, u64 flag)
 {
 	int ret = 0;
@@ -5099,6 +5134,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->mnt_opts = start;
 		ret = statmount_mnt_opts(s, seq);
 		break;
+	case STATMOUNT_OPT_ARRAY:
+		sm->opt_array = start;
+		ret = statmount_opt_array(s, seq);
+		break;
 	case STATMOUNT_FS_SUBTYPE:
 		sm->fs_subtype = start;
 		statmount_fs_subtype(s, seq);
@@ -5252,6 +5291,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_MNT_OPTS)
 		err = statmount_string(s, STATMOUNT_MNT_OPTS);
 
+	if (!err && s->mask & STATMOUNT_OPT_ARRAY)
+		err = statmount_string(s, STATMOUNT_OPT_ARRAY);
+
 	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
 		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
 
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index 2b49e9131d77..c0fda4604187 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -154,7 +154,7 @@ struct mount_attr {
  */
 struct statmount {
 	__u32 size;		/* Total size, including strings */
-	__u32 mnt_opts;		/* [str] Mount options of the mount */
+	__u32 mnt_opts;		/* [str] Options (comma separated, escaped) */
 	__u64 mask;		/* What results were written */
 	__u32 sb_dev_major;	/* Device ID */
 	__u32 sb_dev_minor;
@@ -175,7 +175,9 @@ struct statmount {
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
 	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
 	__u32 sb_source;	/* [str] Source string of the mount */
-	__u64 __spare2[48];
+	__u32 opt_num;		/* Number of fs options */
+	__u32 opt_array;	/* [str] Array of nul terminated fs options */
+	__u64 __spare2[47];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -211,6 +213,7 @@ struct mnt_id_req {
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
 #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
+#define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
 
 /*
  * Special @mnt_id values that can be passed to listmount
-- 
2.47.0


