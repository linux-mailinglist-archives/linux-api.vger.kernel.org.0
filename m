Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97FF45F66C
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 22:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbhKZVbv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 16:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbhKZV3v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 16:29:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB2EC06175A;
        Fri, 26 Nov 2021 13:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48B92B8290C;
        Fri, 26 Nov 2021 21:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980F4C53FBF;
        Fri, 26 Nov 2021 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637961994;
        bh=a1liu2Lo3sMfRhCcP9f3gWfgoXAydt5G60CI7Sx/zkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjhnbOIX09KK/ltgx5Gl1PWxSHgBOaG82oBbV9EpaHs++VdQHGttHZrwbaW11h8WQ
         TC3RWvVqDN3JhWLl3SF951PF2myJ6wERsjP8QYWSPFMH7nK9rDtrVLFTjeKMScJf4A
         LPV/TSgoEqW+7tW+15SxqyvyMZ4NqmszbDwGMBJKmfuicdmouyEkdPhX12J1v1u9U2
         vwgYH6SzR7n0NMNMcEs+VWBdTtE2m4H8EQ3Nwodqq+2utEZ9MsAg/zvrnnIApK86zb
         KOROdDn+HkJOI925U4UG7aMjJvLcED6A8C7Oes4MGPN+uLGxMlgA3SIKzHIs8Vb8ck
         OHQeD43uqbB3g==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH 1/3] block: simplify calling convention of elv_unregister_queue()
Date:   Fri, 26 Nov 2021 13:25:12 -0800
Message-Id: <20211126212514.173334-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211126212514.173334-1-ebiggers@kernel.org>
References: <20211126212514.173334-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make elv_unregister_queue() a no-op if q->elevator is NULL or is not
registered.

This simplifies the existing callers, as well as the future caller in
the error path of blk_register_queue().

Also don't bother checking whether q is NULL, since it never is.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-sysfs.c | 3 +--
 block/elevator.c  | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4622da4bb9927..91d3805a6ec6b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -957,8 +957,7 @@ void blk_unregister_queue(struct gendisk *disk)
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
 	mutex_lock(&q->sysfs_lock);
-	if (q->elevator)
-		elv_unregister_queue(q);
+	elv_unregister_queue(q);
 	disk_unregister_independent_access_ranges(disk);
 	mutex_unlock(&q->sysfs_lock);
 	mutex_unlock(&q->sysfs_dir_lock);
diff --git a/block/elevator.c b/block/elevator.c
index ec98aed39c4f5..b062c5bc10b9a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -516,9 +516,11 @@ int elv_register_queue(struct request_queue *q, bool uevent)
 
 void elv_unregister_queue(struct request_queue *q)
 {
+	struct elevator_queue *e = q->elevator;
+
 	lockdep_assert_held(&q->sysfs_lock);
 
-	if (q) {
+	if (e && e->registered) {
 		struct elevator_queue *e = q->elevator;
 
 		kobject_uevent(&e->kobj, KOBJ_REMOVE);
@@ -593,9 +595,7 @@ int elevator_switch_mq(struct request_queue *q,
 	lockdep_assert_held(&q->sysfs_lock);
 
 	if (q->elevator) {
-		if (q->elevator->registered)
-			elv_unregister_queue(q);
-
+		elv_unregister_queue(q);
 		ioc_clear_queue(q);
 		blk_mq_sched_free_rqs(q);
 		elevator_exit(q);
-- 
2.34.1

