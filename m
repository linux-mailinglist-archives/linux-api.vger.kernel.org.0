Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64E625ED3F
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIFHkk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHki (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:40:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B18EC061573;
        Sun,  6 Sep 2020 00:40:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o68so6955236pfg.2;
        Sun, 06 Sep 2020 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ayb3Up2Q6+b+eLmNUc0tgAqbzpNo/tgv5jEUsoMm/U4=;
        b=BSlDNWvMtF3qqwSlDIoXIljkIOF60ZUstGi3KbbbT3ib8XqseezF7QEiuVJkVKq8tZ
         mrbgV4f03TWbqUcMPgCo326rr2KwSzb2Nwnuj2PnTyCHOACykiUvWDdCkHBRs88vhHU0
         57spo2yBQyyT7xhmpUbfjZzvIPeuM9UBwQZEXgADur8oqX2au1ZIU7KIFI+lCE7MPZWn
         Pw3LnwnS5ezLUyyKBKGyBgz+eAY1/vRJSipHWzzFml3m4bOiHWIwy+ShT8M3oM2TqKLa
         h0rcMDwp5jx7QiwgWtm372VQ2lHIT6DK0UbabZ3tLWN4b3/PRNs/Dn0QEnlQ6Zxb4ych
         W1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ayb3Up2Q6+b+eLmNUc0tgAqbzpNo/tgv5jEUsoMm/U4=;
        b=MlCU8Ex6cL5xkEUXrs75jNrQ3M4Z2LDfCJcWRf60221YfhSQjAgeuX7wBT15zMfAIr
         fNO5kHyEDMY7M4RUAPiEbMCeOFT93QpGKJ6hhm8E1jvSoflwEemQHax0kK1Zvvf8jwx3
         odKSwSVROI1CEjS4/+4sDypYfAydkprjfxI44FIMx24e0M9cet3aNZWjf95D6t1rWnjF
         BzJgZb9+PqQPQaHOTC1tjcXY9oWrSvEwUpJkrGW9x4MuqcVD5Xap1+/pgdYzJ4WNQoQ/
         2Jqbt6tONU3x/WoQfK/T73HEL6hOQLMKqf9sZyPWuHD1m30NluAnJs6RZR3GVv/lu8W8
         5y5g==
X-Gm-Message-State: AOAM53098uVMdG8EC1GaamAVgBS7Yn/geqygJS2n3cGpOwjXOMLvmfBu
        3EvqSlyywBVTpjXLEu9vS+Sag0TAdEY=
X-Google-Smtp-Source: ABdhPJy/+qBXn7/I6RjmouOt15BBXWpX1lP/qCQd0RXbUSttMoAoIqh0KltfvVu4tjVGD0mkZzGBzQ==
X-Received: by 2002:a63:5c5c:: with SMTP id n28mr12804595pgm.198.1599378036669;
        Sun, 06 Sep 2020 00:40:36 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id f28sm11634243pfq.191.2020.09.06.00.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:40:36 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v2 4/4] block/scsi_ioctl.c: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 15:40:18 +0800
Message-Id: <20200906074018.2370-4-tom.ty89@gmail.com>
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

