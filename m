Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8508F25EC09
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgIFB11 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgIFB1Z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:27:25 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BCCC061573;
        Sat,  5 Sep 2020 18:27:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so2592322plz.5;
        Sat, 05 Sep 2020 18:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTiZOrUEwCVKpqxE/AFo1ktXq/+qAF9fLESFNSzH6aE=;
        b=RORyzFdnPw8rzwXfdX8BenHMboLNmmQH/WJxBIsEvRCXhcPCo7xF1SfNLn+wtK7/p9
         iHrU2JUh/F2ygpPz57jSyiMPnkSrHvxweZJLJmS8muxz7bWJLsvFbwGuy6IMiol/E/IT
         yKhh/BLf2J3MF/XR8bLw0ST3zOjS3XuBAy+Qvkh+zD86Cp/cRSmTJe5bFeqw8LzqenB+
         7ud+FOq/gwXS79BtCEkG1g4fPEvCIq+pZefIPFacNrV2GF0TZYm1vl/kNnENRAFfpJ79
         AI6vpZKRhRVE27qlU9d5GM9I2PyW912qQdbgbiZUUY7XVbonTUN4YfhE0enKj1lexReZ
         SeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTiZOrUEwCVKpqxE/AFo1ktXq/+qAF9fLESFNSzH6aE=;
        b=TE9IWQ0m5zmbDg4LJqk58Lu7dO1ganb95JI5FDBuX84U9JgFctwDvk2+N8HX0xvoeb
         /r36Znz/48UTdr0iIQIE6lGt0ybDtAREIVPgSFCcG1VuGEc+3YggEiP1UM3urPxl84GI
         FqLheCiGy5lc2zpg2sALdPDjisb0HAtJ9uHSZOM9yaYJ4A4NWpH770wkinAsR6iYAU3L
         UBFuVwyrDVZPFDUZzk9IBYVyi+UsDahNpB+10+PR2+ibyKZalKqMD8jWmPVDO5lOk+fv
         7QrA60hounRnZxZHnaGCqG/5Uq+vYXxeRMbdVDrVcgeAnAgHC/FAnmcQm66CHNivK6g2
         PhrA==
X-Gm-Message-State: AOAM531wdksmlCYtN/TDBLacglB31M/r5NLMQcygAElaVOaDc0kudkmF
        467ImHNXarkBtjAyaCw1N+CVnQCdF0Q=
X-Google-Smtp-Source: ABdhPJxHCkLOIo7Y8EK4Hc6Cy1ZGSSzTV+kB9ypMQ0HnkpMQIheEyxFf/UqP46ubj8YqWg4VrbEX2Q==
X-Received: by 2002:a17:90b:80f:: with SMTP id bk15mr14574357pjb.36.1599355644115;
        Sat, 05 Sep 2020 18:27:24 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id gx5sm8462072pjb.57.2020.09.05.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:27:23 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 1/4] scsi: sg: fix BLKSECTGET ioctl
Date:   Sun,  6 Sep 2020 09:27:13 +0800
Message-Id: <20200906012716.1553-1-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It should give out the maximum number of sectors per request
instead of maximum number of bytes.

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
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

