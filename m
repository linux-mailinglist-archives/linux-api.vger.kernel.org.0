Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07663681A2
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 01:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfGNXeM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Jul 2019 19:34:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36362 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfGNXeM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Jul 2019 19:34:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so6561541pfl.3;
        Sun, 14 Jul 2019 16:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZvDmUghJGtIcoH1lAHyVM001UDDabPCfyEnhJcDGzTM=;
        b=T2Wy+WQirnIETDVwa5I7Np0AMEW+cV8L1e7Ij5LicL7Qhvsdij85agQZ5e4+gSLhlO
         u8U4gowMTiXquKCqEqj9IwSdDaJNFdyMb9ZKNYq5ETKBBtsqBgSsStyMcxexqtpJBUus
         Z/RHkYpBbpD64NZ2jwEzpHc2FsMwqEi8/V6rRg5ntZj5t1WGPL4bD/KNs0ylQYGrgK0D
         kLgTrpOJ79uGEbJWnJkh8o6T/2OEkANymRkPHA877tCKQB6Qz8mJSYl4DTGIILZE3y51
         w+uW8OrZ5hy2Oufr301FAVaWrOxaVNsG0syPeH5oIGyHn909rrLANBhIsP2ejgqdcqyU
         sqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ZvDmUghJGtIcoH1lAHyVM001UDDabPCfyEnhJcDGzTM=;
        b=ukW1wbl3MOZcRD/Gyb/HyeW2O3B83hEANeJvAjXJ1xpRQ9KQ27v3/t4PcslrLWbC1Y
         mOdkjr7GgbvkGu63uof7IN6/A9wn+2oBJxR8T3BSxaRCpYWor6N7EbMIbKo2m1q8rNSC
         ot0a++yzPKDQGGU8BFuHF/lNevRIDZ9IiJZMJWZbzWVFxFH8yE3ycxke2+3YzySNHfQk
         qU2URSOUa3qan35F+TgkiPot5Ky1c/12PPErqLit3k35wzyhPGrhh2KxAwISpnCi+0L1
         UKpUkB5PrfQHmtBevOmTnOFTApQ8ZL9Ey0fYpBbz/E9FF7TZxP4za1qFsmW4OAbsiyCD
         w6PQ==
X-Gm-Message-State: APjAAAUEIh7JaijndS3FJ3bXUTW96OXtoTApQwWWkkSr4F6I7MyNGroz
        0YX4T3faXF2owuoG7ayHjKo=
X-Google-Smtp-Source: APXvYqxPNd56Ruj4+d9gaHMgq8nm67VzpKr7zPEFJR/Ph1orc5zxtioAdeFX1yd3HNSoyZ8td1Fc3Q==
X-Received: by 2002:a63:3f48:: with SMTP id m69mr23329517pga.17.1563147250578;
        Sun, 14 Jul 2019 16:34:10 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id n26sm16256923pfa.83.2019.07.14.16.34.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 16:34:09 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v5 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Date:   Mon, 15 Jul 2019 08:33:55 +0900
Message-Id: <20190714233401.36909-1-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch is part of previous series:
https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.org/
Originally, it was created for external madvise hinting feature.

https://lkml.org/lkml/2019/5/31/463
Michal wanted to separte the discussion from external hinting interface
so this patchset includes only first part of my entire patchset

  - introduce MADV_COLD and MADV_PAGEOUT hint to madvise.

However, I keep entire description for others for easier understanding
why this kinds of hint was born.

Thanks.

This patchset is against on next-20190712.

Below is description of previous entire patchset.

================= &< =====================

- Background

The Android terminology used for forking a new process and starting an app
from scratch is a cold start, while resuming an existing app is a hot start.
While we continually try to improve the performance of cold starts, hot
starts will always be significantly less power hungry as well as faster so
we are trying to make hot start more likely than cold start.

To increase hot start, Android userspace manages the order that apps should
be killed in a process called ActivityManagerService. ActivityManagerService
tracks every Android app or service that the user could be interacting with
at any time and translates that into a ranked list for lmkd(low memory
killer daemon). They are likely to be killed by lmkd if the system has to
reclaim memory. In that sense they are similar to entries in any other cache.
Those apps are kept alive for opportunistic performance improvements but
those performance improvements will vary based on the memory requirements of
individual workloads.

- Problem

Naturally, cached apps were dominant consumers of memory on the system.
However, they were not significant consumers of swap even though they are
good candidate for swap. Under investigation, swapping out only begins
once the low zone watermark is hit and kswapd wakes up, but the overall
allocation rate in the system might trip lmkd thresholds and cause a cached
process to be killed(we measured performance swapping out vs. zapping the
memory by killing a process. Unsurprisingly, zapping is 10x times faster
even though we use zram which is much faster than real storage) so kill
from lmkd will often satisfy the high zone watermark, resulting in very
few pages actually being moved to swap.

- Approach

The approach we chose was to use a new interface to allow userspace to
proactively reclaim entire processes by leveraging platform information.
This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
that are known to be cold from userspace and to avoid races with lmkd
by reclaiming apps as soon as they entered the cached state. Additionally,
it could provide many chances for platform to use much information to
optimize memory efficiency.

To achieve the goal, the patchset introduce two new options for madvise.
One is MADV_COLD which will deactivate activated pages and the other is
MADV_PAGEOUT which will reclaim private pages instantly. These new options
complement MADV_DONTNEED and MADV_FREE by adding non-destructive ways to
gain some free memory space. MADV_PAGEOUT is similar to MADV_DONTNEED in a way
that it hints the kernel that memory region is not currently needed and
should be reclaimed immediately; MADV_COLD is similar to MADV_FREE in a way
that it hints the kernel that memory region is not currently needed and
should be reclaimed when memory pressure rises.

* v4 - http://lore.kernel.org/lkml/20190711012528.176050-1-minchan@kernel.org/
* v3 - http://lore.kernel.org/lkml/20190627115405.255259-1-minchan@kernel.org
* v2 - http://lore.kernel.org/lkml/20190610111252.239156-1-minchan@kernel.org
* v1 - http://lore.kernel.org/lkml/20190603053655.127730-1-minchan@kernel.org

Minchan Kim (5):
  mm: introduce MADV_COLD
  mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
  mm: account nr_isolated_xxx in [isolate|putback]_lru_page
  mm: introduce MADV_PAGEOUT
  mm: factor out common parts between MADV_COLD and MADV_PAGEOUT

 include/linux/swap.h                   |   2 +
 include/uapi/asm-generic/mman-common.h |   2 +
 mm/compaction.c                        |   2 -
 mm/gup.c                               |   7 +-
 mm/internal.h                          |   2 +-
 mm/khugepaged.c                        |   3 -
 mm/madvise.c                           | 274 ++++++++++++++++++++++++-
 mm/memory-failure.c                    |   3 -
 mm/memory_hotplug.c                    |   4 -
 mm/mempolicy.c                         |   6 +-
 mm/migrate.c                           |  37 +---
 mm/oom_kill.c                          |   2 +-
 mm/swap.c                              |  42 ++++
 mm/vmscan.c                            |  83 +++++++-
 14 files changed, 404 insertions(+), 65 deletions(-)

-- 
2.22.0.510.g264f2c817a-goog

