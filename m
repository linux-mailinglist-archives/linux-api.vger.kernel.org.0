Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBF925ED39
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgIFHk3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHk2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:40:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642FCC061573;
        Sun,  6 Sep 2020 00:40:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s2so4967833pjr.4;
        Sun, 06 Sep 2020 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+V027+/ctA7JUz0jifuXRcZVHBqu+BrNTXODX6KOBU=;
        b=SpcZs44dUnM0I6Ex0rGS3paRaq9yUGuIdh5VeZOM3HyO3SE7pRi6DHXXgEkOLIHkHD
         0U2yTuRaLdDvg1IRVVgKbFlTxoGYFPR1ieitntNSCyvMzKGC8Y2BZD7jhdYeHBzIux+w
         7QrfFovjY981ZVQYavI8rKKI6QkBh+5l4eUMGDRuymh0uAR/W0PhZTaAXDa+WhtFo74S
         TJS1GbWRXRWQsLByw1KXhvl1RmYS4bIOjLAlWiCIimA4ReCoaIIKniX8syKOxLe82JwS
         NZ4J3O1llkDvoURsUyQtrJPEf0QnXU7AOH29mWytGK1AC9nRcwCR+n1loVOzH3+n1iMc
         /2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+V027+/ctA7JUz0jifuXRcZVHBqu+BrNTXODX6KOBU=;
        b=eM2QRGezq498VtL9rcA5LsAeczwwpoO+9WYjFcJT/1G6gq6j9yJ5R4xIDEWVij41H6
         ZQUU9203zbwXo8L71tyUOq6BDocUd6vmnqICE4P1B9qLAex0ZxvPXWHVJLaT3VaXB7c7
         WYgUF2egM/vc0lxqwsXROHwHIjiyaWgjjZXDvcPbo2Tq3b1Wqf0U7I514FE1ES4N12AM
         ljRZh5cFfHw6RTbwXXstt8Z4a9RlhXphyZrdLmdP4FXZ0zfk7GvmJnoUWbRrETDyeBa2
         PxVlY3LsjencIn+mDTrUqwD+B6XLq8+NgXw/WQcw7OmiUfCrqFsM34q15ZvxFtHPYcMB
         fgRw==
X-Gm-Message-State: AOAM530e9EG/uRwdE/nG1x+Fvf/EWbmLJYQ8cKKymISYAgwyFn8NRhv9
        d4fR7EDWFf7Cp2Ke7hLh92WUAd6a0wM=
X-Google-Smtp-Source: ABdhPJzs9EboHcdDk/UxTT3SAtB6NhBJDGphm0tfGYiV/kmmv3uvbN0b/ngmsCkP92qlGJ89lNrzzQ==
X-Received: by 2002:a17:902:a581:b029:cf:9367:8d9d with SMTP id az1-20020a170902a581b02900cf93678d9dmr13784746plb.0.1599378026083;
        Sun, 06 Sep 2020 00:40:26 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id f28sm11634243pfq.191.2020.09.06.00.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:40:25 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v2 1/4] scsi: sg: fix BLKSECTGET ioctl
Date:   Sun,  6 Sep 2020 15:40:15 +0800
Message-Id: <20200906074018.2370-1-tom.ty89@gmail.com>
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

