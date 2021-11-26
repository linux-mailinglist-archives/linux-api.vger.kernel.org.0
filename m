Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8772C45F66B
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 22:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbhKZVbx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 16:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbhKZV3v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 16:29:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B26C06175B;
        Fri, 26 Nov 2021 13:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 720DDB827EB;
        Fri, 26 Nov 2021 21:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DC0C53FC1;
        Fri, 26 Nov 2021 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637961995;
        bh=M0sQRTxbyS0q3abkpmgvNfkIhDxP38RRMZpip4Rf994=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m+aIAdJuL/oiUoZOFA/8hBijcbRxtxIG3ZiMYjorJW5A2WDLt3404QrFNSt8JVPo+
         IFxwo05D3y0u4cibqR9EL6Kx77VJ4AvCWlwOBbocr6pUgzqZh8yUgsIQ4uTsProkdt
         iXwIroCNj/p/qrUcrlmkaw/63Q0pUv2+v9Rje1CaM9w2JiHuddHKyMY7BUhLDSFXEM
         ssiBin8hGNQTd4OC29ib88RYQj++tGqdontkNUFjd20iKi2veCoyl7kDqWe5BQJbK1
         aeg8ilfmNXlKRa0e2ckkfKr2Q168yq3EFgnCUY/DqeB+qbFoy38by4Z1KisE5dDFC2
         yDuLqBR+2eyvQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 2/3] block: don't delete queue kobject before its children
Date:   Fri, 26 Nov 2021 13:25:13 -0800
Message-Id: <20211126212514.173334-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211126212514.173334-1-ebiggers@kernel.org>
References: <20211126212514.173334-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

kobjects aren't supposed to be deleted before their child kobjects are
deleted.  Apparently this is usually benign; however, a WARN will be
triggered if one of the child kobjects has a named attribute group:

    sysfs group 'modes' not found for kobject 'crypto'
    WARNING: CPU: 0 PID: 1 at fs/sysfs/group.c:278 sysfs_remove_group+0x72/0x80
    ...
    Call Trace:
      sysfs_remove_groups+0x29/0x40 fs/sysfs/group.c:312
      __kobject_del+0x20/0x80 lib/kobject.c:611
      kobject_cleanup+0xa4/0x140 lib/kobject.c:696
      kobject_release lib/kobject.c:736 [inline]
      kref_put include/linux/kref.h:65 [inline]
      kobject_put+0x53/0x70 lib/kobject.c:753
      blk_crypto_sysfs_unregister+0x10/0x20 block/blk-crypto-sysfs.c:159
      blk_unregister_queue+0xb0/0x110 block/blk-sysfs.c:962
      del_gendisk+0x117/0x250 block/genhd.c:610

Fix this by moving the kobject_del() and the corresponding
kobject_uevent() to the correct place.

Fixes: 2c2086afc2b8 ("block: Protect less code with sysfs_lock in blk_{un,}register_queue()")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 91d3805a6ec6b..1368dfe3ee500 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -951,15 +951,17 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	if (queue_is_mq(q))
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
-
-	kobject_uevent(&q->kobj, KOBJ_REMOVE);
-	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
 	elv_unregister_queue(q);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
+
+	/* Now that all child objects were deleted, the queue can be deleted. */
+	kobject_uevent(&q->kobj, KOBJ_REMOVE);
+	kobject_del(&q->kobj);
+
 	mutex_unlock(&q->sysfs_dir_lock);
 
 	kobject_put(&disk_to_dev(disk)->kobj);
-- 
2.34.1

