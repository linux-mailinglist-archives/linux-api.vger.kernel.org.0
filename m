Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D425ED3B
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgIFHkb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHka (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:40:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6763C061573;
        Sun,  6 Sep 2020 00:40:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so5157368pjb.4;
        Sun, 06 Sep 2020 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=IohpRBUSjpKYerGmxviqQ2AOFnyqoDZrqXiBIggLrX3WkU1AatImH+tf9g5CLN5dcZ
         I2oh+Jm+JCF5rS1ei/EMkPk63YWn07A5Cpw93XKzSYn720bkiuAfzprkN2P3AzmEAh8d
         ykicYd0urFPifbLW/y9AjoxzFwcC4Dd6tPzhkluFuQebBX1S095+ZcI2lRmkqf9/zHeX
         0EDp9SY9EIYqeIsdcCKJ7L4xH79IZm2MXEpshfwYw47uiuo2plXgMwHyHippLH/M0SAz
         yue1et+gYVXLahYzNjxYzKd2qmFX/oP6AMwwFeTEjoulamlPFa/Prcz711fIWMcZ0p8R
         KEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=cnKYPVuEkp2WSY2pdhsQTUbgoiNMkiOlzI03d3C2YVKET/fQ4m737dTAUrhQauwBek
         NfDIiQka65LGGYbftIqMMvEUJxJQ7ONT2CeibGk1ehHPdMhsNc8r88yB7yiXxZps2d32
         Q33yxeEtdL12twC4xw0OHnVI9WjL7FaSbauk5aWoC+R3Wo+dXipyrvX/na7NlFzMF+cT
         qg/u1A3JpBgjzDOQOB/vVgnxoKFevX8zY+or7XXPbVXyI/QctCmcSNOfav0v9AffUhoN
         YHM1nsx16MAPukLeOjf+UmPMcDRwQpBBtq8txTjkmiKv3AZY1XIuC20a+jGF0TAiWYr3
         XAow==
X-Gm-Message-State: AOAM533Lo1Gyev5EU34q++Z6bWgVJ7X2Y9I6kdgPuDXWs5mr9M8BQ+N0
        OVZML9mBc0IKkv8TuvEgJzyQpZorw/0=
X-Google-Smtp-Source: ABdhPJwdG+z97JBo7a5OGlRBcgyEe2Ft55o0W8p1ezDgaFRP07eCmTWEcTzi510thMVSbSS0HDbmag==
X-Received: by 2002:a17:902:bd06:: with SMTP id p6mr15330599pls.255.1599378029657;
        Sun, 06 Sep 2020 00:40:29 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id f28sm11634243pfq.191.2020.09.06.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:40:29 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v2 2/4] scsi: sg: implement BLKSSZGET
Date:   Sun,  6 Sep 2020 15:40:16 +0800
Message-Id: <20200906074018.2370-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906074018.2370-1-tom.ty89@gmail.com>
References: <CAGnHSEmos_vznm40WfnX0XC-kdOKz9CNdW9thWzepkgS2eEDCw@mail.gmail.com>
 <20200906074018.2370-1-tom.ty89@gmail.com>
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

