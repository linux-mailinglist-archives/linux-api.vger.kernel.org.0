Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B6114C7C2
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 09:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgA2I6w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 03:58:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33019 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgA2I6v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 03:58:51 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so8509902pgk.0
        for <linux-api@vger.kernel.org>; Wed, 29 Jan 2020 00:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=reRZ27o860Jv4T3ywX/rAzqX7TYE/u2uK3SOSUVyejw=;
        b=e3gWiJ2LWpZU0w65uPMol9V/3tTRPOo3YHr7X0gh9BUnZ0a8WNiuj54YrgBIABRPDp
         7nJNfU3JBzkoHtZMuq12dl8y/DifisJpBnqDf7rCGrqecqO4eGe6EaoheG4cJCOeVNYh
         cmgaoeaErviSStu8trxn9jCb2GWx3UWfHBGP00fQhRbSATh05pEo0TY4zp/Lsnyn496H
         hAM1fjQg3+Gz/gdVr3Gy3gBtnedSFtqZrcfgjWiFThe0zK58Lpi1KLK3vTYyfTbMsEXC
         Ut3TtbuMRn0UuRbxJGoY4ixDK4xRNVgBDbkjNSMXYuyx40dRzACvo6FQOP6Ccg1DV62B
         BQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=reRZ27o860Jv4T3ywX/rAzqX7TYE/u2uK3SOSUVyejw=;
        b=IzVSlM3XFhKxa9vLi1KCRoJj6mW6zFJZWpcXBMrEKG7xr3xfJjjY1RryLZgdc4foXq
         H3VLXn6B8hYVEW52YKlhTq8QnLYJv4vYoaDWxteEj7tk61wlYI12W4HBdkBCVqqoND4D
         7317fK3JxIyGPcokUs8w92U9nUdJIstyGRttCjQLm0TuCsJUCTWjLaQ7zyyvOXjtwGR6
         oSgLW8/3SCTksOEI0Vb5AqEhCG27DiR/LaZKMvEEVlgo1rQrWKYuTrv4rkar8XscwiOV
         urL5xnpjukoAo28sAgxsXxuN+irodlzDxykBaRg6A0qqJARbxDP7oc/+Tj0+0xe8olHE
         Jw0w==
X-Gm-Message-State: APjAAAVkShd7Q1PLra+eayxng7YoLvvpvg+wxX1OEdwn1mBZZijiraOj
        GuVUs/Schi52UdRIZ+ZQyylb8g==
X-Google-Smtp-Source: APXvYqySrkrEow/ydQXLctB5z0jkLcdnlvdfudAWHqB5KZWJfySgHEoAy9nDfAd4zDudLTtYV/uOCg==
X-Received: by 2002:aa7:8d8f:: with SMTP id i15mr8191344pfr.220.1580288330902;
        Wed, 29 Jan 2020 00:58:50 -0800 (PST)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s131sm1935932pfs.135.2020.01.29.00.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 00:58:50 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Cc:     kernel-team@fb.com, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Xi Wang <xi@cs.washington.edu>
Subject: [RFC PATCH v4 3/4] Btrfs: fix inode reference count leak in btrfs_link() error path
Date:   Wed, 29 Jan 2020 00:58:33 -0800
Message-Id: <885829e37b0cdf75e26f4605e34110a7b23fe162.1580251857.git.osandov@fb.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580251857.git.osandov@fb.com>
References: <cover.1580251857.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

If btrfs_update_inode() or btrfs_orphan_del() fails in btrfs_link(),
then we don't drop the reference we got with ihold(). This results in
the "VFS: Busy inodes after unmount" crash.

The reference is needed for the new dentry, so get it right before we
instantiate the dentry.

Fixes: 79787eaab461 ("btrfs: replace many BUG_ONs with proper error handling")
[Although d_instantiate() was moved further from ihold() before that, in
commit 08c422c27f85 ("Btrfs: call d_instantiate after all ops are setup")]
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bc7709c4f6eb..8c9a114f48f6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6801,7 +6801,6 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 	inc_nlink(inode);
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
-	ihold(inode);
 	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 
 	err = btrfs_add_nondir(trans, BTRFS_I(dir), dentry, BTRFS_I(inode),
@@ -6825,6 +6824,7 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 			if (err)
 				goto fail;
 		}
+		ihold(inode);
 		d_instantiate(dentry, inode);
 		ret = btrfs_log_new_name(trans, BTRFS_I(inode), NULL, parent,
 					 true, NULL);
@@ -6837,10 +6837,8 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
 fail:
 	if (trans)
 		btrfs_end_transaction(trans);
-	if (drop_inode) {
+	if (drop_inode)
 		inode_dec_link_count(inode);
-		iput(inode);
-	}
 	btrfs_btree_balance_dirty(fs_info);
 	return err;
 }
-- 
2.25.0

