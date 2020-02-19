Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE8FD163986
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgBSBov (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:44:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34626 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgBSBou (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:44:50 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so11656831pfc.1;
        Tue, 18 Feb 2020 17:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1scw6AX0QdFLv3QhbE20elC6cFG9ULuE6N92X44brJw=;
        b=H6fLGsg2j4PmTw3SItfmAmcqvkvaIG3s5xSjQFvJtLfGEss07bBJGio+X/KLry8eDb
         3of397TcAuTYOfo72or2nw1YG+7ZRabRZNJpup3S4vrdMouvHDJOTAv6Pxc7GfNR0Bwe
         blIMw1KBPy7QVkpINhoirPf72oM2gT3KRqDJ4YFwQtsaY0WYzYeZ2i6ro5LfpAfsbXPj
         osVnUSsQr/acQmJOrN/DtYiXzUJDqzDhSUt2tc3mJLCPD3K4QUzagSsD/XXGVNUtMVp+
         hXXTA2+BOdSzcH+RoGXH7VosRcAp00hFbxtoGwNnyTeNo8o0XKOhn0m58Z/P6g33gfXW
         B/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=1scw6AX0QdFLv3QhbE20elC6cFG9ULuE6N92X44brJw=;
        b=EA4B+v5SJ/GZpTSrNjY8vlpg6WkYGlj8PmpA9+V9/30h/MTrqBSD/Rayx6hFj9+Pwf
         mjFWMIR94Z4SRRhJqIIndFQbmYr1jl6Eh+f6YpQ9TKqgTQaDuBB6n1ZWte4wvvUodVFk
         jz7a96ZIZ7jrRKGFAsgwHYd86lO9i1a5kfPzjWAdKAEiovgoivWR8KHZGmnhn/RKbzTL
         1XUZEAdcoeFlf0L6wGMIApcWZypNIy83pkZJUo1Grw4AniKddzPURLOJ4Cdqr4jDIXKc
         odWIgEVpaJNdG6FrixXUtQ6WzQPRidZhvpFYNHH7omDNDISx5ElWddVXpZScPl1Tjuxd
         FhUg==
X-Gm-Message-State: APjAAAUEgsCq/XZJYiCEogssgISH0wYzVG2bBVhvrMTXlyfvVZb+UHwM
        zHB3DjxnWsTHoX0DfxEgxxU=
X-Google-Smtp-Source: APXvYqyz3X7WGwptvOEiJxwSNXqqwTYv3ZYeA8KT5pni5GmwVfEADCKS6SJfoeyphY2Axu5WL8Tqpg==
X-Received: by 2002:a63:5818:: with SMTP id m24mr25869925pgb.358.1582076690066;
        Tue, 18 Feb 2020 17:44:50 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm221192pgd.26.2020.02.18.17.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:44:48 -0800 (PST)
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
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Minchan Kim <minchan@kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v6 7/7] mm/madvise: allow KSM hints for remote API
Date:   Tue, 18 Feb 2020 17:44:33 -0800
Message-Id: <20200219014433.88424-8-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200219014433.88424-1-minchan@kernel.org>
References: <20200219014433.88424-1-minchan@kernel.org>
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
index c55a18fe71f9..b97c7e1a5cab 100644
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

