Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CC25EC01
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgIFBZi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgIFBZi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:25:38 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17320C061573;
        Sat,  5 Sep 2020 18:25:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m8so990908pgi.3;
        Sat, 05 Sep 2020 18:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTiZOrUEwCVKpqxE/AFo1ktXq/+qAF9fLESFNSzH6aE=;
        b=CyHQQY39mVD5MdQkmOEu4m1Lfsa7Yfo1+uFrp6vvolj/HATw9iuXQUZS03eSyyZfUg
         Giha01eTNrSeDmEERlQ40Fu7LHtUj2Sj4j8JG+bFusqaPGu5mu/nlRi4I1uZFp5TB4av
         WxQZ73LhDceREPFoFYxQvLxi0QcmkLDYc64jis3TpbrY33dBlJzXAthDzmzLlSgplGVd
         Akmia9r73rZA/Atf45qgtAmIpq6xh+ryokp28WUH0PwJUeqKWLmRD9jLjN45K1AYWYgk
         0aYdng+vkNrQsvaSBBGoH6K2JqqReYApqhtkIZlL9FKJuJBhig8QSA0L0ZbLn3g/y49C
         DRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTiZOrUEwCVKpqxE/AFo1ktXq/+qAF9fLESFNSzH6aE=;
        b=skQ8CepWK2RBXEOLHFluiBar0F7o2Y9IsZcQMNMEDRoUIOnS2AfYC7pH3Yk48b36FT
         L32Uw6yGE8XwYbgtPETmqmWq6Rd+pF8gacmj3z+3eMSh1yA0iaIE+ChFlwYa9WV0MEF9
         YHBb6tWHEWbUJNvNkjnxZkV4FH60TarqVh16wj2bc4nu8LXW/a9JNTE3ALnnEj8XG13s
         ITwmqFl78ijKobIX4cogSoAL8nWi237717BBtItjHw00llzxBp+RL+twyEeMdiye0Blh
         vJ1gMa1zbHfo4vrBTrdD7WMUBQcnK0sp9TbkjU0ru9qCc3PL4/ZcLqBKG6eYVhObcJo+
         +ZIQ==
X-Gm-Message-State: AOAM533qaR61KWfhdNtr9eX+7omQ2Kgn8tHQJj6mUHFhiGhu5S0Pd0Jz
        nx5fsRumalJPi/E7BPuPN5bPVv+Fudc=
X-Google-Smtp-Source: ABdhPJyAas0c1rm+JxxgA7N8e5Q/XIm7noVCHFHdk/B7mnOyXua7RyPhrtaWcw3zRTTDFHdzv+XRfQ==
X-Received: by 2002:a63:f606:: with SMTP id m6mr3821621pgh.193.1599355534940;
        Sat, 05 Sep 2020 18:25:34 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id w206sm3070386pfc.1.2020.09.05.18.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:25:34 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu.com, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 1/4] scsi: sg: fix BLKSECTGET ioctl
Date:   Sun,  6 Sep 2020 09:25:09 +0800
Message-Id: <20200906012512.1428-1-tom.ty89@gmail.com>
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

