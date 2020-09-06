Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901EC25EC0F
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgIFB1g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgIFB1e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:27:34 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04E7C061573;
        Sat,  5 Sep 2020 18:27:34 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n3so6332435pjq.1;
        Sat, 05 Sep 2020 18:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bg1T/4Ha1GXOocbDAQsf5gtGn1bi3WAb271zUVCosk8=;
        b=OmkEN5sAudh66UEkXdATHHM7c6WY8B9mwx5twLEEC60AHeUOsNvhPXwvN128tXhgqH
         R4DuE/hcchGRyPb58ULw70zj1Ji/EsqcriXEbUT+YhW0aPKvCqE1tiI4A3PDxoTldgx+
         XDtUmZQIRTMcBX365GyEEIxS1aB139jubdy49YuZrpg9q2Snu0Pgtc05TcpP+IHBsWzD
         XPgIqeEaetqS2GwJJXlECqGz+ferjsy1j6FzhBu4tidOyIusuNphW8SnKWzT5MxSQ9+z
         j0E7fS/WMKlbOnRT1eAJHEGy6hLU90C1fT8yuFUJS4RWooq7MNopSkGz2ukAp8uo2df5
         to1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bg1T/4Ha1GXOocbDAQsf5gtGn1bi3WAb271zUVCosk8=;
        b=XadPKBN6M65FAuhIEW8YlbRjynLtQgKzcQ9lYvc91U2AS1EGNg38Eh2VAhwZ+Up1nF
         Qwv4XtI7s/nMJ6gvyr3zFZVg81f6h+bEnzQm3dWQ9ef3UmhQWWU8cDVJktZS0gyA1oGg
         UOFJTy/+qnClWEpRRTlGsizSj5iW89YLU/2mFcbUX1mYb7Os/A27+n5nXBTj4XX49PSh
         cSWeP6faPYkzF9G8Ig+1P5goiLfL5abLhGIFJy+ZHVyQSG8kLNTsnimnHpk4fGZg0U8s
         WwQj7NTlaGK47gbwTMzzAIlGaNIPjA2by+WxyW09LRiEAIeI9MssKgmqad/QX/978bjI
         sEHw==
X-Gm-Message-State: AOAM533G8lAB998WKUoF+waHSHf0ItOvi/hD1nSfAqO/cPbLoHahDnj/
        emcjH8vZ2HNTAiX5unGK5AWfd1AKZ+c=
X-Google-Smtp-Source: ABdhPJwiaQljkH2yb6ew2rqB3WdgihEEr7+c61XfZC6uMMrm4jSC7pK2Ukv7Dx/kOE70Ae8nHjfVRA==
X-Received: by 2002:a17:902:fe15:: with SMTP id g21mr14454297plj.22.1599355653759;
        Sat, 05 Sep 2020 18:27:33 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id gx5sm8462072pjb.57.2020.09.05.18.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:27:33 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 4/4] block/scsi_ioctl.c: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 09:27:16 +0800
Message-Id: <20200906012716.1553-4-tom.ty89@gmail.com>
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

