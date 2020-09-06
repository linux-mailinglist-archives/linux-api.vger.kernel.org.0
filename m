Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DE125EC0D
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgIFB1c (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgIFB1b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:27:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C33C061573;
        Sat,  5 Sep 2020 18:27:31 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b17so2616347pji.1;
        Sat, 05 Sep 2020 18:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH3vO2zorCGfPUvIZzkKisvrCrW3Qnmk8aOiUtht/RM=;
        b=Lx9SlxI0Tg96CwHFeg946IVwM7dxn1aIbviLj4xiQXvff5cJsBmF9CxYOAtsgqn4Ya
         W0DsIiEpL6uVUvn9vV0MENbbfldlFigjuU3R9oKGzNz0LiMvYfmNGAEetihDNaWjAnTb
         Zw+0/Cv+5WcvJf+kVaiJ8IUoYnDuokBGAm04NhVLmpNXSXaMSnAhz9Q2HLnTQr+c6Ezu
         ifvWyyXLmbaVp797MbVooCN4QcL+sNBLeM0Ti+rXcaTMtMyOtJGzznz8Htiaeynb2ESM
         cezia2hTYAeSOPbsjQnO+mGM78LQU1PaF/EsWrtbQjes7Te6GMwB76uRN2BPdqcFIfgX
         bk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH3vO2zorCGfPUvIZzkKisvrCrW3Qnmk8aOiUtht/RM=;
        b=eagl+DJM2Aiy8FmyMEKvzCsHM5uc1xUAZbHMkEy2PEZqSa3C8iOdETlsw1eEE0wfC2
         a88vb5smU4Xf5Vj5tgaD8ZqymYajLu1Ig0LoLZ8SZi9f05edD7UgFOmWeQonNAF85c0Q
         qpW2OuKo1hc+aQ668TSxHEeAo6TtyxZ7pG8b5MZ61vwdX5Omo4bIP12ceGVWWSMnxYGs
         s3YODb/F5XRHrCi+A19tbdsBT5A61q0Q55vkS3O/nMdQ0OEaKFfOlT7JGbtMu/Y9YACa
         xgTbmJDOWSmtIPYq7kzPS7mQukFCj1xwSARBbIX5U4J+2oipW4mgxi7VxS7pSWasyHn8
         o8QQ==
X-Gm-Message-State: AOAM531cJXsiiYA0iaqrlPc+4qkbPXXXg5bFtVYpod2NT+u+xSLRyUc5
        ZHPY2Z90i4e+WpAxG71g98uo1ngb8CU=
X-Google-Smtp-Source: ABdhPJz2GG2b673zx7JzWVN5kDxxZJC4o+yy8Rls0BDtfVO25hh67iEAMLJCmGBVRh1H1fljP9hjLQ==
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr14471221pjr.13.1599355650713;
        Sat, 05 Sep 2020 18:27:30 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id gx5sm8462072pjb.57.2020.09.05.18.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:27:30 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 3/4] scsi: sg: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 09:27:15 +0800
Message-Id: <20200906012716.1553-3-tom.ty89@gmail.com>
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

