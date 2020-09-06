Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DF925ED45
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgIFHwH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHwG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:52:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC8C061573;
        Sun,  6 Sep 2020 00:52:05 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh1so3038539plb.12;
        Sun, 06 Sep 2020 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=YFjd+HTSz6raCDdy5XvT4J9i6sD2sdLHRKRDVnjCL4Y1WGQrTTF00s8vKPNjBWivsp
         xGD6BQE9UWaPw3yLgVNnV81fPTaM9RXH6w9uL8/eKne7auworWDacgrAjGrKiz6mp6rv
         QL+tHU4pZTxHim+oR5UQFbAPzTDfMX5wRR2XZbUrVMS1ourpVyaSAFI5GPXPqyhGeISc
         YPsVx20udk4dHLIjZDwy8UD+9WaSF6goVMDvtaJwqKGhC7+E4wI6xhbtDlmkIhm+b2+k
         Uj9UP1BrCSWghOpWIewyDGWtLkINQf7WdClgckmjJk8j7TsBwN8K7Z7QV2eTkiKHs0VJ
         aHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=UZvX9981uWeMQSR3VLs6aMCCxcQ3JUGEhjErIQPQFJi2fDQydrUhUXhMPKcqnX6gvY
         9eHoIuE91DS0Pv3mPtfxgOa6bgVtYhvbApeKW6krSr5xn2h5AktLhjOJqJBaI9EPv7rC
         HNZtFagHYdhPZNsWvqsSi0oFRtiGsqWaLHZoHskAU/T/AEo1A0u1gOUfclBDakWL0Frm
         qNaQWjsX3zzGjjTTZ2kcXmmu8jwy/j941//MpXaNawfH6xP78lNgIVtTtjpBR/zR6659
         mUkKPCt5+cagCg1skCmvCEugFAMURziV2bl9fGZRgh8P93M0zAYC0qVs65bEbbCFq8eY
         7Stw==
X-Gm-Message-State: AOAM530gU2cLICOR1yEomzkiG08SzVE82RZJE1yyWoJN4nPbn4kPmwc1
        bBtIBvNZDtZT7RoTgPjmrClYVjOidcw=
X-Google-Smtp-Source: ABdhPJx7HtV0DF+cz3hk5GNGTkaZ0+qLQa46gn5/nhufSJPq7lev0O1/vfNs6t5mWdB17BYSjCT5tg==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr15251313plr.185.1599378724602;
        Sun, 06 Sep 2020 00:52:04 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id 67sm11799041pfv.173.2020.09.06.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:52:03 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v3 2/4] scsi: sg: implement BLKSSZGET
Date:   Sun,  6 Sep 2020 15:51:50 +0800
Message-Id: <20200906075152.2927-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906075152.2927-1-tom.ty89@gmail.com>
References: <CAGnHSEmos_vznm40WfnX0XC-kdOKz9CNdW9thWzepkgS2eEDCw@mail.gmail.com>
 <20200906075152.2927-1-tom.ty89@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Provide an ioctl to get the logical sector size so that the maximum
bytes per request can be derived.

Follow-up of the BLKSECTGET fix.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 drivers/scsi/sg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index e57831910228..0e3f084141a3 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1118,6 +1118,8 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		max_sectors = min_t(unsigned int, USHRT_MAX,
 				    queue_max_sectors(sdp->device->request_queue));
 		return put_user(max_sectors, ip);
+	case BLKSSZGET:
+		return put_user(queue_logical_block_size(sdp->device->request_queue), ip);
 	case BLKTRACESETUP:
 		return blk_trace_setup(sdp->device->request_queue,
 				       sdp->disk->disk_name,
-- 
2.28.0

