Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E6825EC03
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgIFBZm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgIFBZj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:25:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576E4C061573;
        Sat,  5 Sep 2020 18:25:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u3so1525245pjr.3;
        Sat, 05 Sep 2020 18:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=Enq4iPbG8/ACEw9m66GlXeAjWiJ0CPBHnob6ri6jjW8mOiGH0UGCOXqOI5sF8388QL
         YBFIJgE18+zpPPQ34agqn0VwdV8LVo6zT1YU4KD+cloz3MzHJhCt3h3uBLgqP0fTSzWU
         hYhxo+uZh8aMCox7EcV84s/znr9iLbbTRX5z1iaT0AzYMufhJfd7R76CJZRwV3P6yt8O
         JYBXJX0WgUdkBgaKOj6ctse2fDeN/egafBhWpIgdb4x46YrgDs35QDJAVHR+VlMo2Xb+
         MQLdFdoH4Vli3pfVo/k1taj6RSWDlJMSPedSELkhws5TCptSy/7o9OPaMKgoW1nAyVzT
         WK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcapTIGFf+31wVMqsHZgBSE+2BUv5P+WBgtFpuHKTB4=;
        b=JuvZCDvOkjMsQgaHIrcTNu4FUCiwLsLbDTEv74CEDTJQXc4uge08DeKuWVbMp0/2H7
         hDwy7v+p4VsxMDoT84Ys4ar7Gw/Y90JTpUE6JQMECRln4GCblwtDN70D29BpURqnkzkO
         SS42BC7RuteER+BEOlfD1UlHoSr2ja54526i8SgMTZ48Tfk+PVEONM94BDMTDx3Gnxqu
         ETGb+slbHQX/dgXIQ6PH8gPnCCa7gC+9/5AMRF/0bO3vNle7rojUt3+S3a0sMwVFqrL2
         3UJFUBQLUc1OaQZCgz4IUa8HOGf5pVXoFLJX8RMSkyEJ0ss3PmqVd9CFzwxBOgrSRWmW
         R3Zg==
X-Gm-Message-State: AOAM533gTeFbALnPPTz6qE753V4aAGMQhd9f/J3wj2WWUsBflMFY8gcq
        Nb4L23GDjzHUmjXmeV0PT/2oF4IJg9E=
X-Google-Smtp-Source: ABdhPJyzQya9BgMxlhxu6sSwZcA9D8WzGaZnNzbpxeOiVENy0OPxEDXDH5di5cCObQses/Q/zeVmUQ==
X-Received: by 2002:a17:90a:bf8c:: with SMTP id d12mr13611265pjs.157.1599355538477;
        Sat, 05 Sep 2020 18:25:38 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id w206sm3070386pfc.1.2020.09.05.18.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:25:37 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu.com, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 2/4] scsi: sg: implement BLKSSZGET
Date:   Sun,  6 Sep 2020 09:25:10 +0800
Message-Id: <20200906012512.1428-2-tom.ty89@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200906012512.1428-1-tom.ty89@gmail.com>
References: <CAGnHSE=bhpL4REG5PXST6dF3gSWeewg1Eqr+sLw_9rtqL-ToFQ@mail.gmail.com>
 <20200906012512.1428-1-tom.ty89@gmail.com>
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

