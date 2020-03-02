Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B7D17641E
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 20:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCBTiJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 14:38:09 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35669 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgCBTgz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 14:36:55 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so230615pjq.0;
        Mon, 02 Mar 2020 11:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu70DJRDEBMY5udogCEqxqr5nIzNXb/ZVa6ak+DAEGE=;
        b=bGAzt2bRUsm7cgwQ5RTZVf/S93SfPOeYEhBXNLGRwQ8/ecMiHe74IFmLVYWe7mhP76
         SkKnx+8xM0l1+Vo/1ldCceHC4pVNU92FOdKXVZJ/cpPs57m6I33Ct0SvcF7+6hTz060z
         MhCQVL3cDoV7wDT1XD8fjiEpgPtQbwYq6kTsTvmWXZGI//EB+u3f/rPb0yrxA2BEZSbR
         QO+6mFAIfwPr9yxjr0Uxm9mb9irEnCMdcctTP5mItZtb+FUOpOcV1/oiVX8I4x26JXxW
         xOyDuld8jCL3RnQS04e9azPeVX+QUDh9ni+5UwrMD74gFWVbXqmdeGTAJmCHdydrtIQw
         4vwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Mu70DJRDEBMY5udogCEqxqr5nIzNXb/ZVa6ak+DAEGE=;
        b=bpbKuDVleoCS4wxfp3dOHpE6BweDC/EHiZjG5rCnPoZOBS6DPPJQ20nBRiIC5wSiu+
         yeeR+gx+lo+C2OQfY3eeMrFISV7Tmas05J+liOZgHntiGo95rj6OWhk/F/4HD8MiOM/e
         brTD0ImvW/1leaRPE4/myvDLS0uZvHVftalILG7CwBfSk7xi3EOKAORujiKFdfqcjl0X
         cytZgvEnyWhDC4PoVa57QWisae7BcOMi27PZFhU66dX7kh4OjkCaEhrrF0GNBjo/ZEc6
         MkQBbNgxMrtm0oLDIgiQY1+/abUib/1F8yv7S/5W/+9OgNF/mf+QzvuwpstVQc44rAsj
         quBg==
X-Gm-Message-State: ANhLgQ1NOQ2BCVrlKzYdNvXoxPObO8Bz800eqNXnHDJUhCCkBAzglNgR
        BhB7BzD8QTgauBaGwP5gGdWknfD9
X-Google-Smtp-Source: ADFU+vtcLKKSg3LAVPMvkZQMOIZdKtFP4hQNOw94oXNyYV8OY5PcR4U8eitUv3IIaT8DAv+7edpk4A==
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr19528pjn.127.1583177813686;
        Mon, 02 Mar 2020 11:36:53 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id hg6sm35441pjb.22.2020.03.02.11.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:36:52 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Minchan Kim <minchan@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v7 7/7] mm/madvise: allow KSM hints for remote API
Date:   Mon,  2 Mar 2020 11:36:30 -0800
Message-Id: <20200302193630.68771-8-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302193630.68771-1-minchan@kernel.org>
References: <20200302193630.68771-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Oleksandr Natalenko <oleksandr@redhat.com>

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

Reviewed-by: SeongJae Park <sjpark@amazon.de>
Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index e77c6c1fad34..f4fa962ee74d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1005,6 +1005,10 @@ process_madvise_behavior_valid(int behavior)
 	switch (behavior) {
 	case MADV_COLD:
 	case MADV_PAGEOUT:
+#ifdef CONFIG_KSM
+	case MADV_MERGEABLE:
+	case MADV_UNMERGEABLE:
+#endif
 		return true;
 	default:
 		return false;
-- 
2.25.0.265.gbab2e86ba0-goog

