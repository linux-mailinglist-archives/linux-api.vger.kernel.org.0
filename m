Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35F233921A
	for <lists+linux-api@lfdr.de>; Fri, 12 Mar 2021 16:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhCLPpk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Mar 2021 10:45:40 -0500
Received: from mx4.veeam.com ([104.41.138.86]:49948 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232583AbhCLPpV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 12 Mar 2021 10:45:21 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id C04F1114A90;
        Fri, 12 Mar 2021 18:45:17 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1615563917; bh=E7vklZS3KQKvlQW65s1wvDn6+2dH/1XjVlF3nm5Ihtk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=SdtDNGUABLkZFqgXedaW5RLH3FOTjPK8hBnQe3Hc/iMoyHErKJ+DD1rc8rjM7ouV6
         TFcQ5frFhf4IULEwLTohxz51zG0cgCtZ35Jvvm8aHkszbiLwOhfPvPtrcDdBRUsPOy
         D9QdwhbxiQlJXnBSgkTajzEienrF87YoWlr/Qu8A=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Fri, 12 Mar 2021 16:45:15 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        <dm-devel@redhat.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH v7 1/3] block: add blk_mq_is_queue_frozen()
Date:   Fri, 12 Mar 2021 18:44:53 +0300
Message-ID: <1615563895-28565-2-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
References: <1615563895-28565-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B58627366
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

blk_mq_is_queue_frozen() allow to assert that the queue is frozen.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 block/blk-mq.c         | 13 +++++++++++++
 include/linux/blk-mq.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..2f188a865024 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -161,6 +161,19 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait_timeout);
 
+bool blk_mq_is_queue_frozen(struct request_queue *q)
+{
+	bool frozen;
+
+	mutex_lock(&q->mq_freeze_lock);
+	frozen = percpu_ref_is_dying(&q->q_usage_counter) &&
+		 percpu_ref_is_zero(&q->q_usage_counter);
+	mutex_unlock(&q->mq_freeze_lock);
+
+	return frozen;
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

