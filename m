Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C5125EC07
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 03:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgIFBZs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 21:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgIFBZq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 21:25:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD5C061573;
        Sat,  5 Sep 2020 18:25:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so401465plt.9;
        Sat, 05 Sep 2020 18:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bg1T/4Ha1GXOocbDAQsf5gtGn1bi3WAb271zUVCosk8=;
        b=Cs36XKaosndj0je9wMduaWoGlITk1K/eHiK6esmzM1HbqLeDW42axltpMHvN8r79oW
         DVtmGBJth4jHdvaC3F9h46E2iR+0FWRn+tFwTa+ynDpECQieE5vHy0B8K9SkxW4n0/0/
         JH8QdXxjz2fKhyb/QLxnJb69X2PZxNxTg1/VDFKuCkF3h8dAju7X5tnUGR1DKZpYw4Vc
         n7X9VeUpcPUdmYCbmpuEWIi2EbIGjmuQ4BwS/ygdK/wteqU7j3z6hyrLITDah6zYPLWq
         duTQ3Uljg0WkVK98C/fUvMK5X8Zz/KQ5fmvqwLBfvwl2OYE/XiuESixn2jh3QbU2Oupe
         UnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bg1T/4Ha1GXOocbDAQsf5gtGn1bi3WAb271zUVCosk8=;
        b=XRxsoNL406TD3Qnp6uK1LoSW/3b/R5W+90uz1NUo4ufwGzVjWKnyAeam+0BwKJSxbb
         7/aOSZJgXqPMfqbC8w84AvqglAv/ZVx7r7GJi/jkStu0QLTsGNO5OHVxClJ2UMyo//wq
         ZSkSr4V489nPyQpjMxaJRlD+oWjsC4CPD8lDQ3WmIWDdoQv6DvKAicFTopmzFlF2vAve
         zIruUQl3Q7ZwcPzc6VoDa0yF9n5uwb01bv5e4aDwDu27cyA714IbRse0AxtHZ2zQbynX
         u1n6TQiN5ROUPdaE2Nx5yiTzJELselR7uU/jJeeudnw3wfx0R4ZqB4wDEsIsByaIIJF3
         fFow==
X-Gm-Message-State: AOAM533RfPVgq5ofvd3z93MLtJXwktLAc+AFmsco3bTmCqMhGGqwdpdF
        VG21VRDi9gcgAERYLQMcY/zmYbx9ZC4=
X-Google-Smtp-Source: ABdhPJxCefCM8KwY51syKb7wP0I1D+yMIEtjywI5+IPhcrYgf9V7792TumUy6HTZinsbpKdohLJilQ==
X-Received: by 2002:a17:902:a581:b029:cf:9367:8d9d with SMTP id az1-20020a170902a581b02900cf93678d9dmr12989758plb.0.1599355545304;
        Sat, 05 Sep 2020 18:25:45 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id w206sm3070386pfc.1.2020.09.05.18.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 18:25:44 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org
Cc:     stern@rowland.harvard.edu.com, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH RESEND 4/4] block/scsi_ioctl.c: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 09:25:12 +0800
Message-Id: <20200906012512.1428-4-tom.ty89@gmail.com>
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

