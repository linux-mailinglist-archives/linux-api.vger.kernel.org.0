Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B0175D22
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 04:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfGZCmi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jul 2019 22:42:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46116 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGZCmi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jul 2019 22:42:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id c3so586554pfa.13;
        Thu, 25 Jul 2019 19:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Sw8V9bDn7QTKMld9EYLdEeoC4y9pSS5VgcZuqisuwyo=;
        b=bTVjRsdMvx6I6p695BSxtsIrspfsdgKJAIPjsX2KdorpIuM2cpKeHRrzcV+z9YZy0/
         4lCEeSW6pC99wy9ByeHaZvvo1R6RXkH5DSdQY+HBDz1qJTDLV/C1jxXbrYU8dN15Bgqq
         wX/w/LHhkWAiZdYtFuxKWXnkULtBCnlDEwUnWEfh42gfoIQxwp7W/dZuw4fe+yiQOCQ5
         f+5PksssOh17UeARnHPOEYEPlzCPAO9KJLFqVYZPhLp77PpvMBy0d247PmB1Odlnbhj6
         Q7BFuYloZfpnnOD3BRABQA6P1AFUCCff9iOLmDCo8NXO7qFPfPjb+bKneMKrGIfaBC0W
         HSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Sw8V9bDn7QTKMld9EYLdEeoC4y9pSS5VgcZuqisuwyo=;
        b=g5ZU+1IzqfYJATHnWPntKNRuFhqfSz53rEE7B/SAW+1bW2z0uBasuTXkRxN796dtam
         pbdes+/EtaaTEPTVh49Dn7OHsBLhwyrWUvunHALY194d5k9SsQkWC3YCTUPTLRBdHIl4
         r32hfzmoto3v0mm4A5MjINN3bkdbmsK4lJ4Cr3akS/CUmAjqSJ1NRej0a0V/5XjB0gBO
         3vh0Id2szxKxw1urAKBPYfplQsAHzIZhfGFpMk1cGG8pJnecy/C2CMhv5bay7y/slrAB
         BdQf7X0z/cki4H8aB8jAja6OaK2SjfzkvX9K9Q1Yd3M7UR+rlGopvdhR5fMQj1HSPHBo
         eByw==
X-Gm-Message-State: APjAAAUqm+CiaPT4T+HuBC891rL/Jh7G5CVqfr/tapjlXisFd39hh6EK
        8HhkWmWm9cw4M2yfVFAn6vI=
X-Google-Smtp-Source: APXvYqzZVWllWaYWh6ED7e60CUOsZLsTeByVz38ebxeCXI+kX7Glzvo1aB92EO2v3XVcEeYwmmRnLA==
X-Received: by 2002:a17:90a:ac14:: with SMTP id o20mr96850971pjq.114.1564108957648;
        Thu, 25 Jul 2019 19:42:37 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id q22sm46283450pgh.49.2019.07.25.19.42.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 19:42:36 -0700 (PDT)
Date:   Fri, 26 Jul 2019 11:42:30 +0900
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v7 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190726024230.GA216222@google.com>
References: <20190726023435.214162-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190726023435.214162-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrew,

It's the resend with fixing build errors kbuildbot reported.
Please take it this version to get more test coverage.

Thanks.

On Fri, Jul 26, 2019 at 11:34:30AM +0900, Minchan Kim wrote:
> This patch is part of previous series:
> https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.org/
> Originally, it was created for external madvise hinting feature.
> 
> https://lkml.org/lkml/2019/5/31/463
> Michal wanted to separte the discussion from external hinting interface
> so this patchset includes only first part of my entire patchset
> 
>   - introduce MADV_COLD and MADV_PAGEOUT hint to madvise.
> 
> However, I keep entire description for others for easier understanding
> why this kinds of hint was born.
> 
> Thanks.
> 
> This patchset is against on mmotm-mmotm-2019-07-24-21-39.
> 
> Below is description of previous entire patchset.
> 
> ================= &< =====================
> 
> - Background
> 
> The Android terminology used for forking a new process and starting an app
> from scratch is a cold start, while resuming an existing app is a hot start.
> While we continually try to improve the performance of cold starts, hot
> starts will always be significantly less power hungry as well as faster so
> we are trying to make hot start more likely than cold start.
> 
> To increase hot start, Android userspace manages the order that apps should
> be killed in a process called ActivityManagerService. ActivityManagerService
> tracks every Android app or service that the user could be interacting with
> at any time and translates that into a ranked list for lmkd(low memory
> killer daemon). They are likely to be killed by lmkd if the system has to
> reclaim memory. In that sense they are similar to entries in any other cache.
> Those apps are kept alive for opportunistic performance improvements but
> those performance improvements will vary based on the memory requirements of
> individual workloads.
> 
> - Problem
> 
> Naturally, cached apps were dominant consumers of memory on the system.
> However, they were not significant consumers of swap even though they are
> good candidate for swap. Under investigation, swapping out only begins
> once the low zone watermark is hit and kswapd wakes up, but the overall
> allocation rate in the system might trip lmkd thresholds and cause a cached
> process to be killed(we measured performance swapping out vs. zapping the
> memory by killing a process. Unsurprisingly, zapping is 10x times faster
> even though we use zram which is much faster than real storage) so kill
> from lmkd will often satisfy the high zone watermark, resulting in very
> few pages actually being moved to swap.
> 
> - Approach
> 
> The approach we chose was to use a new interface to allow userspace to
> proactively reclaim entire processes by leveraging platform information.
> This allowed us to bypass the inaccuracy of the kernel’s LRUs for pages
> that are known to be cold from userspace and to avoid races with lmkd
> by reclaiming apps as soon as they entered the cached state. Additionally,
> it could provide many chances for platform to use much information to
> optimize memory efficiency.
> 
> To achieve the goal, the patchset introduce two new options for madvise.
> One is MADV_COLD which will deactivate activated pages and the other is
> MADV_PAGEOUT which will reclaim private pages instantly. These new options
> complement MADV_DONTNEED and MADV_FREE by adding non-destructive ways to
> gain some free memory space. MADV_PAGEOUT is similar to MADV_DONTNEED in a way
> that it hints the kernel that memory region is not currently needed and
> should be reclaimed immediately; MADV_COLD is similar to MADV_FREE in a way
> that it hints the kernel that memory region is not currently needed and
> should be reclaimed when memory pressure rises.
> 
> * v6 - http://lore.kernel.org/lkml/20190723062539.198697-1-minchan@kernel.org
> * v5 - http://lore.kernel.org/lkml/20190714233401.36909-1-minchan@kernel.org
> * v4 - http://lore.kernel.org/lkml/20190711012528.176050-1-minchan@kernel.org
> * v3 - http://lore.kernel.org/lkml/20190627115405.255259-1-minchan@kernel.org
> * v2 - http://lore.kernel.org/lkml/20190610111252.239156-1-minchan@kernel.org
> * v1 - http://lore.kernel.org/lkml/20190603053655.127730-1-minchan@kernel.org
> 
> Minchan Kim (5):
>   mm: introduce MADV_COLD
>   mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
>   mm: account nr_isolated_xxx in [isolate|putback]_lru_page
>   mm: introduce MADV_PAGEOUT
>   mm: factor out common parts between MADV_COLD and MADV_PAGEOUT
> 
>  arch/alpha/include/uapi/asm/mman.h     |   3 +
>  arch/mips/include/uapi/asm/mman.h      |   3 +
>  arch/parisc/include/uapi/asm/mman.h    |   3 +
>  arch/xtensa/include/uapi/asm/mman.h    |   3 +
>  include/linux/swap.h                   |   2 +
>  include/uapi/asm-generic/mman-common.h |   3 +
>  mm/compaction.c                        |   2 -
>  mm/gup.c                               |   7 +-
>  mm/internal.h                          |   2 +-
>  mm/khugepaged.c                        |   3 -
>  mm/madvise.c                           | 274 ++++++++++++++++++++++++-
>  mm/memory-failure.c                    |   3 -
>  mm/memory_hotplug.c                    |   4 -
>  mm/mempolicy.c                         |   3 -
>  mm/migrate.c                           |  37 +---
>  mm/oom_kill.c                          |   2 +-
>  mm/swap.c                              |  42 ++++
>  mm/vmscan.c                            |  83 +++++++-
>  18 files changed, 416 insertions(+), 63 deletions(-)
> 
> -- 
> 2.22.0.709.g102302147b-goog
> 
