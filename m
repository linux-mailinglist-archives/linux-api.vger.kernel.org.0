Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7621277DA3
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 03:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgIYB2o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 24 Sep 2020 21:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbgIYB2l (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 24 Sep 2020 21:28:41 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B072083B;
        Fri, 25 Sep 2020 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600997320;
        bh=RTSrivTd6OMf4V1bDzbMTqfScOTrO/ODyL9xIDVOP5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyMWIQR6AVkox/VeNcte3tjcqq4VRWrsQIbYYgiI0qy9ziwWb0pWPeboWVh7mmp+Y
         Eoiav98dqPsynOoisKvda+ZRVhtlLNo5Fh61Rq0ODiArmNS9LyMwdiAhevATzh7bGQ
         bLF36rj7pxTGQlY3rOefGPJXz7f+SaCgcqpjFaoI=
From:   Keith Busch <kbusch@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, hch@lst.de,
        Keith Busch <kbusch@kernel.org>, linux-api@vger.kernel.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCHv4 1/3] block: add zone specific block statuses
Date:   Thu, 24 Sep 2020 18:28:36 -0700
Message-Id: <20200925012838.4043473-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200925012838.4043473-1-kbusch@kernel.org>
References: <20200925012838.4043473-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A zoned device with limited resources to open or activate zones may
return an error when the host exceeds those limits. The same command may
be successful if retried later, but the host needs to wait for specific
zone states before it should expect a retry to succeed. Have the block
layer provide an appropriate status for these conditions so applications
can distinuguish this error for special handling.

Cc: linux-api@vger.kernel.org
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/block/queue-sysfs.rst |  8 ++++++++
 block/blk-core.c                    |  4 ++++
 include/linux/blk_types.h           | 18 ++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/Documentation/block/queue-sysfs.rst b/Documentation/block/queue-sysfs.rst
index f261a5c84170..2638d3446b79 100644
--- a/Documentation/block/queue-sysfs.rst
+++ b/Documentation/block/queue-sysfs.rst
@@ -124,6 +124,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
 EXPLICIT OPEN, IMPLICIT OPEN or CLOSED, is limited by this value.
 If this value is 0, there is no limit.
 
+If the host attempts to exceed this limit, the driver should report this error
+with BLK_STS_ZONE_ACTIVE_RESOURCE, which user space may see as the EOVERFLOW
+errno.
+
 max_open_zones (RO)
 -------------------
 For zoned block devices (zoned attribute indicating "host-managed" or
@@ -131,6 +135,10 @@ For zoned block devices (zoned attribute indicating "host-managed" or
 EXPLICIT OPEN or IMPLICIT OPEN, is limited by this value.
 If this value is 0, there is no limit.
 
+If the host attempts to exceed this limit, the driver should report this error
+with BLK_STS_ZONE_OPEN_RESOURCE, which user space may see as the ETOOMANYREFS
+errno.
+
 max_sectors_kb (RW)
 -------------------
 This is the maximum number of kilobytes that the block layer will allow
diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..8bffc7732e37 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -186,6 +186,10 @@ static const struct {
 	/* device mapper special case, should not leak out: */
 	[BLK_STS_DM_REQUEUE]	= { -EREMCHG, "dm internal retry" },
 
+	/* zone device specific errors */
+	[BLK_STS_ZONE_OPEN_RESOURCE]	= { -ETOOMANYREFS, "open zones exceeded" },
+	[BLK_STS_ZONE_ACTIVE_RESOURCE]	= { -EOVERFLOW, "active zones exceeded" },
+
 	/* everything else not covered above: */
 	[BLK_STS_IOERR]		= { -EIO,	"I/O" },
 };
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f..8603fc5f86a3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -103,6 +103,24 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_ZONE_RESOURCE	((__force blk_status_t)14)
 
+/*
+ * BLK_STS_ZONE_OPEN_RESOURCE is returned from the driver in the completion
+ * path if the device returns a status indicating that too many zone resources
+ * are currently open. The same command should be successful if resubmitted
+ * after the number of open zones decreases below the device's limits, which is
+ * reported in the request_queue's max_open_zones.
+ */
+#define BLK_STS_ZONE_OPEN_RESOURCE	((__force blk_status_t)15)
+
+/*
+ * BLK_STS_ZONE_ACTIVE_RESOURCE is returned from the driver in the completion
+ * path if the device returns a status indicating that too many zone resources
+ * are currently active. The same command should be successful if resubmitted
+ * after the number of active zones decreases below the device's limits, which
+ * is reported in the request_queue's max_active_zones.
+ */
+#define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
-- 
2.24.1

