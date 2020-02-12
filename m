Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2359315B4F0
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgBLXkE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:40:04 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40500 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgBLXkD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:40:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id 12so1551966pjb.5;
        Wed, 12 Feb 2020 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXU0e7YyFS/VUMYPbADn6DLwQaySKSAu7t+ONiQoTpg=;
        b=Vzb3l8tkR4YbxU66SZ9n9nBxwBBBt3Hb7W8USVfds/HSLFN5fliwziScWU/0DUU5u7
         P1akVLwV7GzSWcQ6oucwCOZhQaJljjR5vveLA/FERFd3Dr6X8i0OyADhtbvtXCrOUIXC
         G3mHqB80cTp79sAh0e+KI56k+GeAp2Ruixvd52hxGSas6+WO67LnF/e9VmYldCqDAv1D
         kNTDeNcgTqr4P+NkFB052cowzeBEWuR0GcccOrR0IoK5Osec1hs4sQZLnhrnUhu+mZUi
         C+coPGSDtJaW3TYnkOzl6mmlVLkonabbog7rKg6Hw5C6Lk9UAC6RBUVyKZG3GHBFnpWn
         Gn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AXU0e7YyFS/VUMYPbADn6DLwQaySKSAu7t+ONiQoTpg=;
        b=T7Rz6PbLSQrMhvyssZtr7yN9C4lDDPEAxx+knlMVswOtFc40j/cb3mtCMnyyDtiY4d
         eXIVVy8xt9PhlPZIfdXwhn+MGvIBxK4DvL2afxjP/+1tumUeyQ0ObJWIaTwL3ZQPUBgD
         xzoKw8l0HkyOoDJ7BkwSGjOAgQt9ov+ESBvtEaEH8OqwKLDOX6iVieCqwjWHDaMVp1Fo
         GVL5JurFa70QYaiCFB7En9a8yOCaGe9oMb56SXq/P8nk6iKhwcJ10uqMQdBVC2VRCBw5
         VybfoqBBeQi3s1lBaRQAdhI90aoHaoC0xv1R27/+xJ6MalcS3Mabpd7hYSv6dd7LMSgW
         7juA==
X-Gm-Message-State: APjAAAULArzZIfzKu9Wx+0zMm+/ZOJxPCFBfN15L9uwVdGrI26D7mrBp
        5NyYShKG+t1EULXe4c2RLJQ=
X-Google-Smtp-Source: APXvYqwD/pMWtWK6l2LA9FEXSKZnFfQWBoMzwuldcspK6qD6assD8dbx8pK1RFbqi/vyXacz06EMUw==
X-Received: by 2002:a17:902:8341:: with SMTP id z1mr24836376pln.178.1581550803112;
        Wed, 12 Feb 2020 15:40:03 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:40:02 -0800 (PST)
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
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 6/8] mm/madvise: allow KSM hints for remote API
Date:   Wed, 12 Feb 2020 15:39:44 -0800
Message-Id: <20200212233946.246210-7-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212233946.246210-1-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
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

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 71f0ba199ae8..b1237466657e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1002,6 +1002,10 @@ process_madvise_behavior_valid(int behavior)
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
2.25.0.225.g125e21ebc7-goog

