Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D450581DD
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 13:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfF0LyQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 07:54:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46138 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfF0LyQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 07:54:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id 81so1101450pfy.13;
        Thu, 27 Jun 2019 04:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uBobCJvUi1gowBXqDw03EU0Ml7quxJ1JQosDRG7xm1o=;
        b=Ia1UX23bxS0nM3Tx5wUheW7ibikUb3hh5/mcXpIwpGEKCl6/3rOs7+ZDR0nCL2mhdV
         dWuWamXIghUeQacGKDXTcrpb7h1srGz9hjVDUzswI4iMlshlLHx2ilxDORSgkBFibKzC
         WsxkUNukp0rZvv67oGG49chJtS96I8X4KVsJO3lASvIufo2BXIQPk/IKBTVABv66g9/b
         BMn7ujUhPRf1xx8TSDeiT7ze7KsqQEJdGwVZ+tEFaHF/+h5H3Ao6Eh2E4UQziZ/RcJpi
         OwncinVaDpjVuHit6CWNx8SCfGd0OeTPZzzbrSBEO8x5bxHcK8QOCLNLAcbmnlk5JKdN
         LOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uBobCJvUi1gowBXqDw03EU0Ml7quxJ1JQosDRG7xm1o=;
        b=B/soYa3lRVEpg3gjUeSKsob+FPlVekCrylbIBD7zvlLTmpv88y3QycY8SUt75OubVY
         e5OUC+QebvVtajMRFuPNLjTTh5hld9ijM3hn/GpJgHaS8Wpct0Kf7ABKt2vDebAto+9o
         lfiMeIwS3MJsS1SLo6g9tpAyt+qalPyolk6kGjuDeiWVqyJ8YagD5tiUfGvifzIHMyXT
         XRXaCxcV2JDShvmD/RgB+KjJlSODGrmZLesWM24Vqhq/pTdrAa8DQ/85MbmlOFs6G1Ts
         sCoDrEBhRDYJHNF/HNVoznxXq+KPNGyq6HSBzhBwRscmf7XelZZM+rop9xG5JxFPI/3w
         rF4A==
X-Gm-Message-State: APjAAAXhFzq9VSnCsZV3CpF+AjnCbRWCQ63bilAXjG7bHQIJW21lBJOX
        TgDmz3BZ2ptAbmnwjD32ZMbbS4ro
X-Google-Smtp-Source: APXvYqy4QMow2C4473WHef5Gt5kQIBXHZ0K2Uj+3vgkLBrPlaZ4/gN3yLt674ez0KnWu0GcQIXRbBA==
X-Received: by 2002:a65:6656:: with SMTP id z22mr3291953pgv.197.1561636454835;
        Thu, 27 Jun 2019 04:54:14 -0700 (PDT)
Received: from bbox-1.seo.corp.google.com ([2401:fa00:d:0:d988:f0f2:984f:445b])
        by smtp.gmail.com with ESMTPSA id x14sm3241419pfq.158.2019.06.27.04.54.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 04:54:13 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Date:   Thu, 27 Jun 2019 20:54:00 +0900
Message-Id: <20190627115405.255259-1-minchan@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch is part of previous series:
https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.org/T/#u
Originally, it was created for external madvise hinting feature.

https://lkml.org/lkml/2019/5/31/463
Michal wanted to separte the discussion from external hinting interface
so this patchset includes only first part of my entire patchset

  - introduce MADV_COLD and MADV_PAGEOUT hint to madvise.

However, I keep entire description for others for easier understanding
why this kinds of hint was born.

Thanks.

This patchset is against on next-20190530.

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

Minchan Kim (5):
  mm: introduce MADV_COLD
  mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
  mm: account nr_isolated_xxx in [isolate|putback]_lru_page
  mm: introduce MADV_PAGEOUT
  mm: factor out pmd young/dirty bit handling and THP split

 include/linux/huge_mm.h                |   3 -
 include/linux/swap.h                   |   2 +
 include/uapi/asm-generic/mman-common.h |   2 +
 mm/compaction.c                        |   2 -
 mm/gup.c                               |   7 +-
 mm/huge_memory.c                       |  74 -----
 mm/internal.h                          |   2 +-
 mm/khugepaged.c                        |   3 -
 mm/madvise.c                           | 438 ++++++++++++++++++++++++-
 mm/memory-failure.c                    |   3 -
 mm/memory_hotplug.c                    |   4 -
 mm/mempolicy.c                         |   6 +-
 mm/migrate.c                           |  37 +--
 mm/oom_kill.c                          |   2 +-
 mm/swap.c                              |  42 +++
 mm/vmscan.c                            |  86 ++++-
 16 files changed, 566 insertions(+), 147 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

