Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C064725ED47
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgIFHwK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgIFHwI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:52:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C23C061573;
        Sun,  6 Sep 2020 00:52:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z15so3057485plo.7;
        Sun, 06 Sep 2020 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qj4opLuq3e/N7o34LR+3zc1SZci2d/YmQKRZk0FXSNg=;
        b=AZUF4Nrr+Db/5US5Ly8GMIzCt/6nLXu2iVEHdaeUqWAdwMaLg7bJGkU2mCO/HaeHIi
         53yWJk/hO7EyiSoaScNy0BLhFn5zzcLr8VjhQegyByDq+FuaA9AC4Dt/v0URAB/L5cgC
         V/1SmYoM0FeiMpleYi0jlCmqLCCu/3F1n+4SCrUNg2R7PEzN6qSnBcNBYyfs+LiorEoK
         Djom2bvDzrZVA+w5KdKkkw6ZgtsU0klrLuAp1LrYrvmP3CbJhIU9YxThEqAJS0hlbkI7
         3QJZ3sNtHd9GYtqKZ35pXAyEjEP3FGxvpghg8H4T6MtVtRXUPUJphi4YXmnCUByMv+QA
         Q2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qj4opLuq3e/N7o34LR+3zc1SZci2d/YmQKRZk0FXSNg=;
        b=c0i+VhuySrBI9GbBI1/ImTfanDRpxSv6Tm5joRjow4kRN6Ng9bGQnsdXhZno6UJq3s
         pSY5Ex9/OcMa/SJ+L99jcBV8iuM2JvK7Z6rTZKnrXFo5bHeQSAQFsGLjPL9S16EzPZzz
         s1AQyz9fdWahHjaC8u6qjvPM9J6QbzbZRcMDYCfoAsO0Jh0CF7/d+6yOg/q/MGhzu/kh
         yoHmM0WFHaJ9YZdTSvRBMd8RrQz32JQOYUnNGb3THgumF3SUtd9zR/XSJMjBpOSxpJAv
         cEKqgYjeRzXypT8Ji7Nco61olXNmYCZ5HjxZ4B0/nhaH6YSrXcTRcWl8hAv9325DN4AV
         jWQA==
X-Gm-Message-State: AOAM533IsCiAMR4auMYa7bJchg7wY1ag1vaBgh6muJDsirXSqo52yP0W
        vnX1B6FpQY5wozEzAwp9vYY3IC9wr5w=
X-Google-Smtp-Source: ABdhPJw7i17kqk54QUPxW800mGhk7g/kiOjMhfIM7L9QmAQ/VpQaUgOOQWok8HBmb0g6yxD+WFS8+w==
X-Received: by 2002:a17:902:a982:: with SMTP id bh2mr15066452plb.182.1599378727745;
        Sun, 06 Sep 2020 00:52:07 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id 67sm11799041pfv.173.2020.09.06.00.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:52:07 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v3 3/4] scsi: sg: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 15:51:51 +0800
Message-Id: <20200906075152.2927-3-tom.ty89@gmail.com>
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
 drivers/scsi/sg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 0e3f084141a3..deeab4855172 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -848,10 +848,11 @@ static int srp_done(Sg_fd *sfp, Sg_request *srp)
 static int max_sectors_bytes(struct request_queue *q)
 {
 	unsigned int max_sectors = queue_max_sectors(q);
+	unsigned int logical_block_size = queue_logical_block_size(q);
 
-	max_sectors = min_t(unsigned int, max_sectors, INT_MAX >> 9);
+	max_sectors = min_t(unsigned int, max_sectors, USHRT_MAX);
 
-	return max_sectors << 9;
+	return max_sectors * logical_block_size;
 }
 
 static void
-- 
2.28.0

