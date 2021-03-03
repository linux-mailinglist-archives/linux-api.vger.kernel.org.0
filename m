Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9365332C673
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349440AbhCDA2x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:28:53 -0500
Received: from mx2.veeam.com ([64.129.123.6]:55744 "EHLO mx2.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358367AbhCCNB4 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 3 Mar 2021 08:01:56 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 42C0E41501;
        Wed,  3 Mar 2021 07:30:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx2;
        t=1614774638; bh=9UO+0TRDaYLGApIoEWyRHalqxcm04zGOsOOw64BwIcE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=XMT6SbIqMH9aXWanq8Gd6dEC4dR3Iyc3Qz78Xobcs4aj4rlpUOj0a6Wq8PzwNwidh
         2aTdd7EIDsDeHflPS565JGQPuoOPvL7VS3n2+JmENV31pZnxB48IdLkW96T/nLnjpg
         LQFGkeYUDeeJSkjU+cEbAneE6V7nKcFpxwHjiH2M=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 3 Mar 2021 13:30:36 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <snitzer@redhat.com>, <agk@redhat.com>, <hare@suse.de>,
        <song@kernel.org>, <axboe@kernel.dk>, <dm-devel@redhat.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-raid@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v6 1/4] block: add blk_mq_is_queue_frozen()
Date:   Wed, 3 Mar 2021 15:30:15 +0300
Message-ID: <1614774618-22410-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
References: <1614774618-22410-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D265637363
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

blk_mq_is_queue_frozen() allow to assert that the queue is frozen.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/blk-mq.c         | 12 ++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..d5e7122789fc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,6 +161,18 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
 
+bool blk_mq_is_queue_frozen(struct request_queue *q)
+{
+	bool ret;
+
+	mutex_lock(&q->mq_freeze_lock);
+	ret = percpu_ref_is_dying(&q->q_usage_counter) && percpu_ref_is_zero(&q->q_usage_counter);
+	mutex_unlock(&q->mq_freeze_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_mq_is_queue_frozen);
+
 /*
  * Guarantee no request is in use, so we can change any data structure of
  * the queue afterward.
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2c473c9b8990..6f01971abf7b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -533,6 +533,7 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+bool blk_mq_is_queue_frozen(struct request_queue *q);
 
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.20.1

