Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB5E8473DB
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 10:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfFPI6v (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 04:58:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38464 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfFPI6r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 04:58:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so6689887wrs.5
        for <linux-api@vger.kernel.org>; Sun, 16 Jun 2019 01:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hjjZi7hVawe1O5sE3agHwwCxgHKG18ng7v/8qT0V/18=;
        b=OMhQBesJrtegX9Yi/1CU1qAPPPA+1bPyzVS2Ye4d2CIWs7alhtay6l2knIodid+Xyn
         XiyqfnSDuSl5NNEl7fEYM62KH0vA8IV4pyranGlXQcCqhtQvRzooOo+bOMyeF/JrZXQ4
         J3awK/nPGnpPRYTB1FJk3HI4GYnZ48/DwN5kZ1/UICHqEJxkBmA06pjG6TTsd7dEkl3Z
         RkfCXQglKru9DvUIT+5FdiF4QndUYqpEbQPcS5rvEkQfuqiUoa2HwZhcJSVQZAhMMGA3
         mSjRK1awWfnNchldJaFG4zjRG1eXbTC+IbaYCNOnX1EkX9ZG7HT7oM9g8La+91RPGtFR
         ValQ==
X-Gm-Message-State: APjAAAWGIjWUY1TGl6hX2lWJAlJLPb8z4NPl04cUT2NzKnPmZf0fLzUY
        xnnrqjPlktRG5Ubw0SE4bjpgzw==
X-Google-Smtp-Source: APXvYqwgBJiVgM4KiEAb/iF54vFPB8O+3Ztpe60o0gwS8ulqjH0TmG0LsqfT6UfUPJQvqxzCje57FA==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr56928115wrw.26.1560675525088;
        Sun, 16 Jun 2019 01:58:45 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c4sm3173448wrb.68.2019.06.16.01.58.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 01:58:44 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH NOTFORMERGE 5/5] mm/madvise: allow KSM hints for remote API
Date:   Sun, 16 Jun 2019 10:58:35 +0200
Message-Id: <20190616085835.953-6-oleksandr@redhat.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616085835.953-1-oleksandr@redhat.com>
References: <20190616085835.953-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

It all began with the fact that KSM works only on memory that is marked
by madvise(). And the only way to get around that is to either:

  * use LD_PRELOAD; or
  * patch the kernel with something like UKSM or PKSM.

(i skip ptrace can of worms here intentionally)

To overcome this restriction, lets employ a new remote madvise API. This
can be used by some small userspace helper daemon that will do auto-KSM
job for us.

I think of two major consumers of remote KSM hints:

  * hosts, that run containers, especially similar ones and especially in
    a trusted environment, sharing the same runtime like Node.js;

  * heavy applications, that can be run in multiple instances, not
    limited to opensource ones like Firefox, but also those that cannot be
    modified since they are binary-only and, maybe, statically linked.

Speaking of statistics, more numbers can be found in the very first
submission, that is related to this one [1]. For my current setup with
two Firefox instances I get 100 to 200 MiB saved for the second instance
depending on the amount of tabs.

1 FF instance with 15 tabs:

   $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
   410

2 FF instances, second one has 12 tabs (all the tabs are different):

   $ echo "$(cat /sys/kernel/mm/ksm/pages_sharing) * 4 / 1024" | bc
   592

At the very moment I do not have specific numbers for containerised
workload, but those should be comparable in case the containers share
similar/same runtime.

[1] https://lore.kernel.org/patchwork/patch/1012142/

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 mm/madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 84f899b1b6da..e8f9c49794a3 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -991,6 +991,8 @@ process_madvise_behavior_valid(int behavior)
 	switch (behavior) {
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
 		return true;
 
 	default:
-- 
2.22.0

