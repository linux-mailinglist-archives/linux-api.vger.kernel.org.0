Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A796A25ED49
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIFHwN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgIFHwM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:52:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0784BC061573;
        Sun,  6 Sep 2020 00:52:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so3058554pll.6;
        Sun, 06 Sep 2020 00:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I9t8W0xVBTzwntMqKUpY1JXn7OO0PXlgWGrbZCcekzk=;
        b=QCWiMBSXxOiFqPRm/S3oHCU1UwC6vISk97TuwUqHGKbRhgz09bIOyBGgaxVcUzKLSZ
         2oILRokktUQWBa19hIXHYGRYbKpFrAUunjGQezHw61xxBZEYObDElBNyzVrDzq4CG4K2
         kP/3qF2knW4/yVK2MluGtKZqYzMTM1wddX8aUsoGHp5TPLatd0rHVvLvzQN6qXO/xAfW
         mlwcyfc2/3Oufm6hFTtwzXyCH0tLgADGVUoRiDlP/647NTZHbKkgCzYEdMkmh0sV9F0i
         ISIzjVFNE73qqrqgZBRuvnxd57NB+S82ihclZeZQk7KkGRkfPfzMmyFQscGcEHx7n9VG
         L8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I9t8W0xVBTzwntMqKUpY1JXn7OO0PXlgWGrbZCcekzk=;
        b=dRTxJstVIkkHcSFRMTxpwOiNPWDRpe6pEep8zI0idnPtu1NW7F1i4AAqPuS2L4yrqt
         LNAjPwgJ8iUi2goBgF7xpf1edqPoqwMs3rOnjy7AQ21J1/Jg6gWbaOdt2vAEsdkbKZo1
         pt4tcxm48QCIiaIYBRBgqE7IsbnOfc5z2BIi7DrPBXvKS8N7LU3kSh1KEt+JNmOydVks
         aUyfDYEtteYhHU9EH/FV10DgPSZn2OjpFwW2cbD0O/yoyZfDdRBvs9PfAsyR/cXAhsDp
         USk/JRCvXPZJ80/kM+49ft07Rqj1hN6eUUbhrLlvJ5g+aKuTEWbHX/lOAi0+AaM525jG
         H3Qw==
X-Gm-Message-State: AOAM531z8zLiKFnRH0KjQb9g+M7J6v9ta25Jw1qWgC0ebcEMQcX05rdD
        sw8rpavdlvwK7drUB2PdtXaNtk8wNCc=
X-Google-Smtp-Source: ABdhPJyOBLQESxnGoxA9oMoaqKyYfQ1sfeaIaA5R0C2j+A4Qjdxc4NcKH9EtQnCFzDqk1WeeSVyjkg==
X-Received: by 2002:a17:90a:c288:: with SMTP id f8mr4029734pjt.123.1599378731213;
        Sun, 06 Sep 2020 00:52:11 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id 67sm11799041pfv.173.2020.09.06.00.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:52:10 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v3 4/4] block/scsi_ioctl.c: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 15:51:52 +0800
Message-Id: <20200906075152.2927-4-tom.ty89@gmail.com>
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

Logical sector size was never / is no longer necessarily 512.

Programatically speaking it may not be necessary for us to clamp
max_sectors to USHRT_MAX here, but since such clamping is used in
BLKSECTGET, it's probably a good idea to have it here too, so that
what the function returns is consistent to what the ioctl reports.

Alternatively we can clamp (max_sectors * logical_block_size) to
INT_MAX instead, or maybe even not clamping it at all.

P.S. sg_reserved_size is initially set to INT_MAX by
blk_mq_init_allocated_queue().

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
---
 block/scsi_ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f04f88a..ae6aae40a8b6 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -73,10 +73,11 @@ static int sg_set_timeout(struct request_queue *q, int __user *p)
 static int max_sectors_bytes(struct request_queue *q)
 {
 	unsigned int max_sectors = queue_max_sectors(q);
+	unsigned int logical_block_size = queue_logical_block_size(q);
 
-	max_sectors = min_t(unsigned int, max_sectors, INT_MAX >> 9);
+	max_sectors = min_t(unsigned int, max_sectors, USHRT_MAX);
 
-	return max_sectors << 9;
+	return max_sectors * logical_block_size;
 }
 
 static int sg_get_reserved_size(struct request_queue *q, int __user *p)
-- 
2.28.0

