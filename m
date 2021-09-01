Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6463FE0BB
	for <lists+linux-api@lfdr.de>; Wed,  1 Sep 2021 19:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345682AbhIARCv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Sep 2021 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbhIARCs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Sep 2021 13:02:48 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8296C0613D9
        for <linux-api@vger.kernel.org>; Wed,  1 Sep 2021 10:01:51 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t1so76616pgv.3
        for <linux-api@vger.kernel.org>; Wed, 01 Sep 2021 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uln2HVGAQYqVfchTpLKMoAipwuM7tlLjazsvAWo2m9E=;
        b=Kuf6yfFRpXAnuJEQTU1+YH+WjEDHNNKPKABTHYeCW+sm8D9rCJfd4NSoFSfXOjfK0C
         vTBcAH0ty6U7uh/8t8sPH9P7xc2NJn7JZXItAiBpNzhouWU07QQHjvVvzofCnmi+JASR
         ckSYEoHXOwSM6apmW5WNzFbTC4YMVNuYITdirI/+NSgoQGUHC5NLHoHVbpdP71ijUYU8
         VMYEbx4LRx4tGiY/FSXWm5i3TIZlz7HRDhjYniSRfqCJJcJqAXw8DOigWg1hjmAfU7iP
         I2nhba7QjKIYKdNPADvYYFG7wfMppMpFStDjoA1xho/nNXl6RqYzdUpxmzzL4xfigIqt
         xoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uln2HVGAQYqVfchTpLKMoAipwuM7tlLjazsvAWo2m9E=;
        b=aaW1rVodT7jmTWLhea47T/CoBuDbz59DdhwGlme2vu96li63BuDayEQlaDR8p5EIcN
         6fEHggOe+by0t16gcwY1cVoNmUldjzeDqtqKxurw3YduxbyyWKSZH5E4C9HEToo/27Rt
         3ZMED/31WNs6flJbTQG2Cxwn6lPrP7sr5wLVH2BDAMUUWf7O7IllOXmEGVlZBhz5qk/8
         58FUZJqofrS4im6OqP4OPs4B1kWsyqsTsUyxdoBxGZZiVeteecg+z9BF3iGSXWiz5iOG
         5UKtFozfiz9ICRHZd2QKduXjd+oXh39WVr8NkBbx+NovjQWgGZrsP2BBBIpa8KL4Evqb
         Q60g==
X-Gm-Message-State: AOAM5321hhTxlamxJdcbe2XUmFF1kf2b7ry5Qtnb2UaV6acb50a0PUj6
        8sktCMMoQHDqPayXfYgToTPhMw==
X-Google-Smtp-Source: ABdhPJzFtAnewtQI57YgBYsbiYSAQLLZbLy/4YfYZ7s+jeUlku3e7gkfS9k+6pk+4+qocnbOdhusOQ==
X-Received: by 2002:a65:62c1:: with SMTP id m1mr63421pgv.339.1630515711182;
        Wed, 01 Sep 2021 10:01:51 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:50 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 01/10] btrfs-progs: receive: support v2 send stream larger tlv_len
Date:   Wed,  1 Sep 2021 10:01:10 -0700
Message-Id: <8729477d23b83c368a76c4f39b5f73a483a3ad14.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Boris Burkov <borisb@fb.com>

An encoded extent can be up to 128K in length, which exceeds the largest
value expressible by the current send stream format's 16 bit tlv_len
field. Since encoded writes cannot be split into multiple writes by
btrfs send, the send stream format must change to accommodate encoded
writes.

Supporting this changed format requires retooling how we store the
commands we have processed. Since we can no longer use btrfs_tlv_header
to describe every attribute, we define a new struct btrfs_send_attribute
which has a 32 bit length field, and use that to store the attribute
information needed for receive processing. This is transparent to users
of the various TLV_GET macros.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/send-stream.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/common/send-stream.c b/common/send-stream.c
index a0c52f79..cd5aa311 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -24,13 +24,23 @@
 #include "crypto/crc32c.h"
 #include "common/utils.h"
 
+struct btrfs_send_attribute {
+	u16 tlv_type;
+	/*
+	 * Note: in btrfs_tlv_header, this is __le16, but we need 32 bits for
+	 * attributes with file data as of version 2 of the send stream format
+	 */
+	u32 tlv_len;
+	char *data;
+};
+
 struct btrfs_send_stream {
 	char read_buf[BTRFS_SEND_BUF_SIZE];
 	int fd;
 
 	int cmd;
 	struct btrfs_cmd_header *cmd_hdr;
-	struct btrfs_tlv_header *cmd_attrs[BTRFS_SEND_A_MAX + 1];
+	struct btrfs_send_attribute cmd_attrs[BTRFS_SEND_A_MAX + 1];
 	u32 version;
 
 	/*
@@ -152,6 +162,7 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 		struct btrfs_tlv_header *tlv_hdr;
 		u16 tlv_type;
 		u16 tlv_len;
+		struct btrfs_send_attribute *send_attr;
 
 		tlv_hdr = (struct btrfs_tlv_header *)data;
 		tlv_type = le16_to_cpu(tlv_hdr->tlv_type);
@@ -164,10 +175,15 @@ static int read_cmd(struct btrfs_send_stream *sctx)
 			goto out;
 		}
 
-		sctx->cmd_attrs[tlv_type] = tlv_hdr;
+		send_attr = &sctx->cmd_attrs[tlv_type];
+		send_attr->tlv_type = tlv_type;
+		send_attr->tlv_len = tlv_len;
+		pos += sizeof(*tlv_hdr);
+		data += sizeof(*tlv_hdr);
 
-		data += sizeof(*tlv_hdr) + tlv_len;
-		pos += sizeof(*tlv_hdr) + tlv_len;
+		send_attr->data = data;
+		pos += send_attr->tlv_len;
+		data += send_attr->tlv_len;
 	}
 
 	sctx->cmd = cmd;
@@ -180,7 +196,7 @@ out:
 static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *len)
 {
 	int ret;
-	struct btrfs_tlv_header *hdr;
+	struct btrfs_send_attribute *send_attr;
 
 	if (attr <= 0 || attr > BTRFS_SEND_A_MAX) {
 		error("invalid attribute requested, attr = %d", attr);
@@ -188,15 +204,15 @@ static int tlv_get(struct btrfs_send_stream *sctx, int attr, void **data, int *l
 		goto out;
 	}
 
-	hdr = sctx->cmd_attrs[attr];
-	if (!hdr) {
+	send_attr = &sctx->cmd_attrs[attr];
+	if (!send_attr->data) {
 		error("attribute %d requested but not present", attr);
 		ret = -ENOENT;
 		goto out;
 	}
 
-	*len = le16_to_cpu(hdr->tlv_len);
-	*data = hdr + 1;
+	*len = send_attr->tlv_len;
+	*data = send_attr->data;
 
 	ret = 0;
 
-- 
2.33.0

