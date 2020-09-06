Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1B225ED43
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725497AbgIFHwD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHwC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:52:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D48C061573;
        Sun,  6 Sep 2020 00:52:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v15so6519726pgh.6;
        Sun, 06 Sep 2020 00:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7hGBsOfVo5X/7XA6pc2U0kl3lXbMQ3BKQNeoxFE7fQ=;
        b=aNwMmcx7pQM+tiCu11lAmsLkmC9wDVMPlLj94UZykCj442RefBlcbBofzR8QW+fLq4
         hOdCNyyPWp2pKY78WSRTp+UZNXf0ZJZNIDJllyZ2vZvgy+rpVXf5qMu7UHoKc5IowPah
         P6Ic0MRhDHtMLz8dkeUgua3pxyckkuA1NyheihdDV6f6CU2mKjw6Fio425p/HSPiqBm3
         OuWGiYiDgLMQVjokxNB+DMQHUijIaZiEtDOfwl2/HvgkGg/A63DqY6jyK1bCQXKWTKsm
         jwnm8K36FvBQ+oLoBa3rvLnaXk4/Ziv4iiI1Uxqe3vrKB+c4+X6P5sAkt9v7gbjDvj39
         9yiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7hGBsOfVo5X/7XA6pc2U0kl3lXbMQ3BKQNeoxFE7fQ=;
        b=KovfgqqN46D16LBPc6B3WDMoYgMKRZQq6Z5dz9a7KwhYPKcttjMFIZ4tBasRXswfZd
         oy6l7dvzRYDGkzXuHOTnwqY3e85nMjsVopVdb7oa3DGXbwovhtdp0uQ/aYOzNKy8OwK6
         B5l6aVf70FDG5nSZz8KVyTAVJXOGeqVlSNCQUzbfObMwAsioNFf/ErcJJSE7/WKrMtLx
         0p9aP8g3mKa+YEmH5M4PKLhbRN66eTCM28jLb/CyoFlqIOzMnrNJZqaef+v9D5xwSl8W
         7cvO4r5xIqV/GvXE6OkNYCl1SOqkEuzlAoyybSfLg0noJY4OTXWSdxZyxqSjzIXLOvrw
         uZNA==
X-Gm-Message-State: AOAM53348HSZtEf+qPgeQpjmeEz9p1XqM99KRqRPyVlVdQwUbPtBwsyn
        LUnYM8Y+eDm+zaOjfZ8e2C8MDW3Jb9E=
X-Google-Smtp-Source: ABdhPJxomWPcRasSHTQSD45V/CFcrv4rTL9dILEpEpCJ7HvW9/fm0v5JZbg6U0iOgTgpACNF5w0nmQ==
X-Received: by 2002:a63:d918:: with SMTP id r24mr12683465pgg.158.1599378720676;
        Sun, 06 Sep 2020 00:52:00 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id 67sm11799041pfv.173.2020.09.06.00.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:52:00 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v3 1/4] scsi: sg: fix BLKSECTGET ioctl
Date:   Sun,  6 Sep 2020 15:51:49 +0800
Message-Id: <20200906075152.2927-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAGnHSEmos_vznm40WfnX0XC-kdOKz9CNdW9thWzepkgS2eEDCw@mail.gmail.com>
References: <CAGnHSEmos_vznm40WfnX0XC-kdOKz9CNdW9thWzepkgS2eEDCw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It should give out the maximum number of sectors per request
instead of maximum number of bytes, as that is what its equivalence
in the block layer does (that is also the reason for the USHRT_MAX
clamp; they should always have identical behaviour when possbile).

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
v2: add more details in commit messages
v3: add a missed line back to the commit message of the last patch
 drivers/scsi/sg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 20472aaaf630..e57831910228 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -922,6 +922,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 	int result, val, read_only;
 	Sg_request *srp;
 	unsigned long iflags;
+	unsigned int max_sectors;
 
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp,
 				   "sg_ioctl: cmd=0x%x\n", (int) cmd_in));
@@ -1114,8 +1115,9 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		sdp->sgdebug = (char) val;
 		return 0;
 	case BLKSECTGET:
-		return put_user(max_sectors_bytes(sdp->device->request_queue),
-				ip);
+		max_sectors = min_t(unsigned int, USHRT_MAX,
+				    queue_max_sectors(sdp->device->request_queue));
+		return put_user(max_sectors, ip);
 	case BLKTRACESETUP:
 		return blk_trace_setup(sdp->device->request_queue,
 				       sdp->disk->disk_name,
-- 
2.28.0

