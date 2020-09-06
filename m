Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C130125ED3E
	for <lists+linux-api@lfdr.de>; Sun,  6 Sep 2020 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgIFHkh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 6 Sep 2020 03:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgIFHkf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 6 Sep 2020 03:40:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF9C061573;
        Sun,  6 Sep 2020 00:40:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b17so2830492pji.1;
        Sun, 06 Sep 2020 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qj4opLuq3e/N7o34LR+3zc1SZci2d/YmQKRZk0FXSNg=;
        b=MpAs3l0w1+wcX7e0Gaqvv8jXvighKbG5rSnwmXEeOooDUiZJMNmz6afh8PAI+rCdZX
         j3wdxS29KwxtMp8Lw3/ORNsSif6DmYTjy0kChfdJ6Xwl5w9lSa99pi7ug1nYrh+EDoz4
         0aiXfTsgs+iRh+Q2jCd4UsMrBznD+BDPI+JVNxDgH3lLU4NGMn7uSgYc+azTQKbeq4q8
         nC4BvJfiF4bymlhw4SzQsc8xp1VmCDPyaE3Vo5IsFmol4uqCFFB4m5lvo2V2SCL6IljU
         qITOQSWeZ9ErYExN1GRRdbs1+CmdxQDnfWLzePEdzyRgkMTEu6zdY42ArMPGOqhVva6p
         FAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qj4opLuq3e/N7o34LR+3zc1SZci2d/YmQKRZk0FXSNg=;
        b=M/1k6iIVripwLt8Rwn1KIq4o7NHJahDueOU4iezaL8BlW89sC3utvPxNz6213gTL5h
         KV9aGhoBwsrxBdnbyEWi7CMvNk/hxh6767PZB29GcIwRJJOu1ItePsqsbMcX4slfJNRC
         +Kkv/ItkcjzFsVY46Hwvf9pc0Oo1GEKqkuSmH5js2UXemA8soswDNW/naQOfpxOFumNq
         1g8eOfzg1icBl8q66k6JaboSP6Uf8GJfFotGOYdJJ1AiIWWXvxeumTnZ8+rVUwNSvc1Y
         rbAUsSCZeNFueX3BG3EUertP0AoPU+xCM1OONMdb/tsuPQZRuWZ6+cjmUITplVBl5qyL
         AIZw==
X-Gm-Message-State: AOAM530GvLfVeqI9ExFL282SMhNr+GoeJ8TmMBZHS6CsHhMmJ9+WEkBc
        tA5Q2/fJaf8Amd64ZC6z3v1uwm3Iaso=
X-Google-Smtp-Source: ABdhPJxESf1OLMoAjgaIBGPG/SKXTIXL82JgyfvIoyooDsbw1amrYne3wKSsG2jgBPnCiZqk++LuRQ==
X-Received: by 2002:a17:90b:360a:: with SMTP id ml10mr14889917pjb.198.1599378033460;
        Sun, 06 Sep 2020 00:40:33 -0700 (PDT)
Received: from localhost.localdomain ([161.81.62.213])
        by smtp.gmail.com with ESMTPSA id f28sm11634243pfq.191.2020.09.06.00.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 00:40:32 -0700 (PDT)
From:   Tom Yan <tom.ty89@gmail.com>
To:     linux-scsi@vger.kernel.org, dgilbert@interlog.com,
        bvanassche@acm.org, gregkh@linuxfoundation.org
Cc:     stern@rowland.harvard.edu, akinobu.mita@gmail.com, hch@lst.de,
        linux-api@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v2 3/4] scsi: sg: use queue_logical_sector_size() in max_sectors_bytes()
Date:   Sun,  6 Sep 2020 15:40:17 +0800
Message-Id: <20200906074018.2370-3-tom.ty89@gmail.com>
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

