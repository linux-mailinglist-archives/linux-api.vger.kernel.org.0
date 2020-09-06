Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2721A25EC05
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgIFBZo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728742AbgIFBZn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:25:43 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133A6C061573;
        Sat,  5 Sep 2020 18:25:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so6288260pgl.2;
        Sat, 05 Sep 2020 18:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH3vO2zorCGfPUvIZzkKisvrCrW3Qnmk8aOiUtht/RM=;
        b=EYr8OBzz0mcmFJU3cfOzg/dnRfqpURym5gmJB+meJLEi+o0eamV6xGIDrLwjzAwABz
         haf3vdwHpIVfBz5xshnBnqApxEZDXp+0vt4SkhK0iNtovNEZj1P/XJm5jRvmobdGSB/R
         kanD6uFMEMQNXwtKglQ+t450wijeNLF4M7XnIt+MuTPLedZ42mfXSnq9AU9HhIGnHiUK
         Bt0/rc3BR7vuPqE9lfNY7BHKINFiMRctA1NUYvput6QRsW2m0pEUhvi23LyS8tS6laJ/
         Nl+V1tisItPvKZEP7dqUUG9i5577KDGlGA/hc2u/mpJ7+qKFVIBtwvdxdeOgeRMwOkSr
         /EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH3vO2zorCGfPUvIZzkKisvrCrW3Qnmk8aOiUtht/RM=;
        b=DqJ5QLfGfIrgNKV/ILb+TrIc93zvflT0TAb4P4P7VZNCP8tOoB55bxYruNEL5mIbV+
         4D0YldgGIilsxPVOVfHLk/Dn+VLMtCq/EV+GbHYJ7bWmZv1ygDBafhHwVErD0FH617tw
         fc01YwKf8FdFMSKy30YMudyHcTDFx0CKMB+ge2VAai1l7lLFolL45hJ2qjA6YVHpblfB
         8xCBgLLzI5sGxar1F/At9ECkTY7Ux7WoThMRFRemX2a8qxeipJnbEB2xlPd5xtV7P+jh
         SxZANk+6nHkI3EBHBilD9PkUaCJJ0/GNM4I40W3K4TbwZPQEdp9w14D0G3o8u/DdU+oy
         voDg==
X-Gm-Message-State: AOAM531WcN3uKZaLW54Hyqpkg2a3oQKHlvftWvAfc4vbQMdDQDWCPbv0
        Kgi930nvgH0VDsCJN0k67zvNnY+1x+g=
X-Google-Smtp-Source: ABdhPJz7w/K6g1YaY8UKnfWgP6HNAKBGMiBxObbrFL8lMbxAe7zeW4gMme+pbeWCy30LWAsuNFbh8A==
X-Received: by 2002:a63:e22:: with SMTP id d34mr12802208pgl.120.1599355542280;
        Sat, 05 Sep 2020 18:25:42 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id w206sm3070386pfc.1.2020.09.05.18.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:25:41 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu.com, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 3/4] scsi: sg: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 09:25:11 +0800
Message-Id: <20200906012512.1428-3-tom.ty89@gmail.com>
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

