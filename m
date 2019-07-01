Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A10815B5C9
	for <lists+linux-api@lfdr.de>; Mon,  1 Jul 2019 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfGAHi5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jul 2019 03:38:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46433 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfGAHi4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Jul 2019 03:38:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so6116628pfy.13;
        Mon, 01 Jul 2019 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oLH1OncNHxs8jMVlyqKzbM2LmgvaD0Lm4DDU5l+6xuE=;
        b=nKCbXIFP0qhCB9TYyiIPTDswXVswW8CR9y8Csly4Id5HAH94lfYeljtiMc58SdKPxU
         pwXoZijwnVSxsgPzAl/R9CvVncgvHBxXeEPQjkY4CQ8CorFmkIN4zMiIIIPXaZnYuAlC
         EgFuUgMnbYFoKaRigKTPbD01B9cpVCfV9RQlcIfFEvpIDBFKQSXxa5K34RKkqnG3WDtl
         RlKK4bi/fAYaN5APqWQ5PddFXT4IxjihNUz0gk9JwBzVjc3J7bNX4EFXYc/QEtpKlwzC
         9OYZmZCQ5TKdl/FwhtRPjD9UCuuSdguZGdKBLGBEBouIwzY4SpU5ZzNaJZQxfJmHZWsK
         6oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oLH1OncNHxs8jMVlyqKzbM2LmgvaD0Lm4DDU5l+6xuE=;
        b=a37euXlUgZDBcImqEfUrToapxsHe+5owQo3x9kiSgDQtwAF88AILIV8b8zpo6Ee+fY
         t08P41MHJaBm3mike6kkIQubUGv7bCBBRH1vZtBMKhNjm/ze2FF99VNoJr6DMGFW0rz/
         x7JeU7sR+MdOJ9sOYW3iNrBNlmVOFOlCN5SCWmgitqmDZ6MsfZMb2baK4Wi6fAXJTVZ4
         zxLqempm5XAzosgohCkVU1WhzNWSf39IIgCScPV/7OahTVt6GYHYlNr5bp/af0G9biht
         cO/NqSi3LP7yplyTKlcG96bUhwJn+1+IuIJ1Ns1qqF5sn20HWDCtLtB42t8VfvWvbtYN
         t/qQ==
X-Gm-Message-State: APjAAAUnbW3htuVSQWBL0+Mb9pGRXx0gTN5DL3tUZ7XUzCLMopW5zFWj
        mONngMF5p8HJv+dH8iGnX1c=
X-Google-Smtp-Source: APXvYqyCp/N10OoZuyoBqCG1Owt7owZdT4mU1H00JSac3imof61OnjmhaWbc9E9JZ9rjSsi/ctXplw==
X-Received: by 2002:a63:2cd1:: with SMTP id s200mr23505101pgs.439.1561966735773;
        Mon, 01 Jul 2019 00:38:55 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z4sm9658756pfa.142.2019.07.01.00.38.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 00:38:54 -0700 (PDT)
Date:   Mon, 1 Jul 2019 16:38:48 +0900
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
Subject: Re: [PATCH v3 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190701073848.GB136163@google.com>
References: <20190627115405.255259-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627115405.255259-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Hi Folks,

Do you guys have comments? I think it would be long enough to be
pending. If there is no further comments, I want to ask to merge.

Thanks.

On Thu, Jun 27, 2019 at 08:54:00PM +0900, Minchan Kim wrote:
> This patch is part of previous series:
> https://lore.kernel.org/lkml/20190531064313.193437-1-minchan@kernel.org/T/#u
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
> This patchset is against on next-20190530.
> 
> Below is description of previous entire patchset.
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
> Minchan Kim (5):
>   mm: introduce MADV_COLD
>   mm: change PAGEREF_RECLAIM_CLEAN with PAGE_REFRECLAIM
>   mm: account nr_isolated_xxx in [isolate|putback]_lru_page
>   mm: introduce MADV_PAGEOUT
>   mm: factor out pmd young/dirty bit handling and THP split
> 
>  include/linux/huge_mm.h                |   3 -
>  include/linux/swap.h                   |   2 +
>  include/uapi/asm-generic/mman-common.h |   2 +
>  mm/compaction.c                        |   2 -
>  mm/gup.c                               |   7 +-
>  mm/huge_memory.c                       |  74 -----
>  mm/internal.h                          |   2 +-
>  mm/khugepaged.c                        |   3 -
>  mm/madvise.c                           | 438 ++++++++++++++++++++++++-
>  mm/memory-failure.c                    |   3 -
>  mm/memory_hotplug.c                    |   4 -
>  mm/mempolicy.c                         |   6 +-
>  mm/migrate.c                           |  37 +--
>  mm/oom_kill.c                          |   2 +-
>  mm/swap.c                              |  42 +++
>  mm/vmscan.c                            |  86 ++++-
>  16 files changed, 566 insertions(+), 147 deletions(-)
> 
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 
