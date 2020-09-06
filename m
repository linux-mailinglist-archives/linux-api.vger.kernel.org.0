Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A325EC0B
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgIFB1a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgIFB12 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:27:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521FAC061573;
        Sat,  5 Sep 2020 18:27:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm21so4934304pjb.4;
        Sat, 05 Sep 2020 18:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=XVkGvuJ7HP2sZez2I9DMGX5mHm+XHqvqSLW35Gd43qB4iTHIrBbgpNH+G3fZt5CmGY
         VpI2esHqqYEMZ+iTwJ8wagFX5OO90+EQxsBWljZFEZAAMGqv60r3K4NkyQU3ta0JdSss
         E9s5tYldKdsmst2hOC2mEpuQrm9Bdf7HOPARKquWrHh8jZLBQFEAWCMvMK3PAsPcuuLb
         ZiWKJDgpQCUx7x3oAD5zGa99i9PYii+0iX8Nh6hxDn5StrWlWqH6dJg6/nzIOUsZTtX9
         PFwNRz1uIzbQSA07YozkZ8AsoLraI+DgYtFcVpt5O+U5gRK571lE3Dw1A31FkfGiN2j+
         3TGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=rEbTFyJZw9NtLzcnsQu1Uacq9Oj26bW734En57wFpuVU2j0VABIXJoHAzdKcnw5xp+
         Yo2Jj85LnCa4VFfTzQ4+fZ7F2ntG3IwKIf7Q7LQgZs+5ZNMzM+6wzm0LEOgIY9YtmjdK
         Z2A4+r9CEuWI7b0+cGptrq7/O3ZEgl4JVvM9eVI2zw8nEq324jUo03+sNhPvVZIsSOsH
         6baE97+9sca0Odn0iuJ5X27abBb6ZsQAe8gWPp5wfCTmf7nbkLp7mS553ni8QUZ9egzG
         /tW4O4cu/1pAMiaes0g+h77Uv2AD3tOULOB4dMAE5sm/1DDjnZmH5DbwbPhX+L+Z3utP
         o1qQ==
X-Gm-Message-State: AOAM533++hCu517fxSRnIOiy8ojzn0ERJ1jrb84cLlAB3pxmlyeGxOxS
        bkE68NyU8RfaMRPfqQZmNFEskam/bdY=
X-Google-Smtp-Source: ABdhPJxiZgNRLuDB5tAwzb8DOXAO2RFYF4y39+dYnebw1HM5wCZUamDO66vWRurY/iac4ynpfFdr8Q==
X-Received: by 2002:a17:90a:d703:: with SMTP id y3mr14650797pju.183.1599355647554;
        Sat, 05 Sep 2020 18:27:27 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id gx5sm8462072pjb.57.2020.09.05.18.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:27:26 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
Date:   Sun,  6 Sep 2020 09:27:14 +0800
Message-Id: <20200906012716.1553-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906012716.1553-1-tom.ty89@gmail.com>
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012716.1553-1-tom.ty89@gmail.com>
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

