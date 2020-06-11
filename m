Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D586E1F6EA0
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgFKUTV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jun 2020 16:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgFKUTV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jun 2020 16:19:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4EC08C5C2
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 13:19:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h95so2835832pje.4
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OYMFBRcTPutTHTvgpu8BMSfasdSwxRRU+uc+x0ojfyk=;
        b=E67sDstbjTuM+G+67o+vBoZb1ejJmkmYkWtOZhvOTk4g16eLvIGUx3cAxR+m1dNEI5
         ULvOg3UZKRzMWBppCKIOkfcVFWQxBVKf7wl/LHHsZBN6b9FGBlR6tmWxx188TyyrdCAt
         anp+b7uTE9+YIwTwiKhkZ1MhKM9wDzZRCHQkAlDNPsWwpxWnmvmBf1wOJaPPeGNGqOOw
         8W/pfSzLu6kpZ0bQRYok/81ay55CQFD2PgqB2hZ5Rf0CLZ3KRVKwUPwZTUvBuQJFzoLf
         3WxSVnxDqRa4i8aCQlnI4ZuoWSz7keY7HCBDQ9LfaVrpfY5aox4O1+yDFQv0J3ThPULJ
         2dIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OYMFBRcTPutTHTvgpu8BMSfasdSwxRRU+uc+x0ojfyk=;
        b=DzdPHWq2Wle0QBwldPbO08+vOZtSH6u0Uq8wIDWsFlHZk7oKeDALuyX2xigw5NoOIF
         kQaYrCG2SzKSnFeZxfy8s2Caexnxm/dfUGXwqjt16gCQIZSf9LF8V9dZs2u8BnCHhrcc
         hVaBGpop6H81xfeabhJSVG1AFl2/wWvq2lOW6nLsOIuU7wNUNUubcgDfrJODQR68/GlQ
         HHygj+N+xgErOxRqV5wwkFU6xATg1sXWa+pP1hVDS8MsFy+IKm47Z2UhxQ6XJeuy0/b2
         Su5T7B6uLkYCe2sNdNvzAHKD9PVGKVAE/hnkqUv8d8pT7W6RYkblID2mXwu1TvCiCOtk
         +w+g==
X-Gm-Message-State: AOAM531DU20InFWZ2EvoiU5vb+/psy5eodZ/c+3wpNP/nVYMvPjMczwk
        u5UXdGBJ5HddzmK+KlFhHdc4AO/sc4EX1Q==
X-Google-Smtp-Source: ABdhPJwrZ0AMzLer+lWtUsgHnd7jhrTGzDkIvgXrAzkRAKRSrmd0VYQtK1e4ovQxQdD92ZimozaYjg==
X-Received: by 2002:a17:902:599a:: with SMTP id p26mr8919841pli.322.1591906759232;
        Thu, 11 Jun 2020 13:19:19 -0700 (PDT)
Received: from ngvpn01-169-241.dyn.scz.us.nvidia.com ([2601:646:9302:1050:d15f:1664:9a78:aa08])
        by smtp.gmail.com with ESMTPSA id o1sm3473095pja.49.2020.06.11.13.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 13:19:18 -0700 (PDT)
Subject: Re: [PATCH v6] mm: Proactive compaction
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20200601194822.30252-1-nigupta@nvidia.com>
 <af90a0fac442c241b8d4f5e3c598e3de811c97a8.camel@oracle.com>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Message-ID: <76d21140-f86e-a414-769d-57c13a426fb1@nitingupta.dev>
Date:   Thu, 11 Jun 2020 13:19:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <af90a0fac442c241b8d4f5e3c598e3de811c97a8.camel@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/9/20 12:23 PM, Khalid Aziz wrote:
> On Mon, 2020-06-01 at 12:48 -0700, Nitin Gupta wrote:
>> For some applications, we need to allocate almost all memory as
>> hugepages. However, on a running system, higher-order allocations can
>> fail if the memory is fragmented. Linux kernel currently does on-
>> demand
>> compaction as we request more hugepages, but this style of compaction
>> incurs very high latency. Experiments with one-time full memory
>> compaction (followed by hugepage allocations) show that kernel is
>> able
>> to restore a highly fragmented memory state to a fairly compacted
>> memory
>> state within <1 sec for a 32G system. Such data suggests that a more
>> proactive compaction can help us allocate a large fraction of memory
>> as
>> hugepages keeping allocation latencies low.
>>
>> For a more proactive compaction, the approach taken here is to define
>> a
>> new sysctl called 'vm.compaction_proactiveness' which dictates bounds
>> for external fragmentation which kcompactd tries to maintain.
>>
>> The tunable takes a value in range [0, 100], with a default of 20.
>>
>> Note that a previous version of this patch [1] was found to introduce
>> too many tunables (per-order extfrag{low, high}), but this one
>> reduces
>> them to just one sysctl. Also, the new tunable is an opaque value
>> instead of asking for specific bounds of "external fragmentation",
>> which
>> would have been difficult to estimate. The internal interpretation of
>> this opaque value allows for future fine-tuning.
>>
>> Currently, we use a simple translation from this tunable to [low,
>> high]
>> "fragmentation score" thresholds (low=100-proactiveness,
>> high=low+10%).
>> The score for a node is defined as weighted mean of per-zone external
>> fragmentation. A zone's present_pages determines its weight.
>>
>> To periodically check per-node score, we reuse per-node kcompactd
>> threads, which are woken up every 500 milliseconds to check the same.
>> If
>> a node's score exceeds its high threshold (as derived from user-
>> provided
>> proactiveness value), proactive compaction is started until its score
>> reaches its low threshold value. By default, proactiveness is set to
>> 20,
>> which implies threshold values of low=80 and high=90.
>>
>> This patch is largely based on ideas from Michal Hocko [2]. See also
>> the
>> LWN article [3].
>>
>> Performance data
>> ================
>>
>> System: x64_64, 1T RAM, 80 CPU threads.
>> Kernel: 5.6.0-rc3 + this patch
>>
>> echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
>> echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/defrag
>>
>> Before starting the driver, the system was fragmented from a
>> userspace
>> program that allocates all memory and then for each 2M aligned
>> section,
>> frees 3/4 of base pages using munmap. The workload is mainly
>> anonymous
>> userspace pages, which are easy to move around. I intentionally
>> avoided
>> unmovable pages in this test to see how much latency we incur when
>> hugepage allocations hit direct compaction.
>>
>> 1. Kernel hugepage allocation latencies
>>
>> With the system in such a fragmented state, a kernel driver then
>> allocates as many hugepages as possible and measures allocation
>> latency:
>>
>> (all latency values are in microseconds)
>>
>> - With vanilla 5.6.0-rc3
>>
>>   percentile latency
>>   –––––––––– –––––––
>> 	   5    7894
>> 	  10    9496
>> 	  25   12561
>> 	  30   15295
>> 	  40   18244
>> 	  50   21229
>> 	  60   27556
>> 	  75   30147
>> 	  80   31047
>> 	  90   32859
>> 	  95   33799
>>
>> Total 2M hugepages allocated = 383859 (749G worth of hugepages out of
>> 762G total free => 98% of free memory could be allocated as
>> hugepages)
>>
>> - With 5.6.0-rc3 + this patch, with proactiveness=20
>>
>> sysctl -w vm.compaction_proactiveness=20
>>
>>   percentile latency
>>   –––––––––– –––––––
>> 	   5       2
>> 	  10       2
>> 	  25       3
>> 	  30       3
>> 	  40       3
>> 	  50       4
>> 	  60       4
>> 	  75       4
>> 	  80       4
>> 	  90       5
>> 	  95     429
>>
>> Total 2M hugepages allocated = 384105 (750G worth of hugepages out of
>> 762G total free => 98% of free memory could be allocated as
>> hugepages)
>>
>> 2. JAVA heap allocation
>>
>> In this test, we first fragment memory using the same method as for
>> (1).
>>
>> Then, we start a Java process with a heap size set to 700G and
>> request
>> the heap to be allocated with THP hugepages. We also set THP to
>> madvise
>> to allow hugepage backing of this heap.
>>
>> /usr/bin/time
>>  java -Xms700G -Xmx700G -XX:+UseTransparentHugePages
>> -XX:+AlwaysPreTouch
>>
>> The above command allocates 700G of Java heap using hugepages.
>>
>> - With vanilla 5.6.0-rc3
>>
>> 17.39user 1666.48system 27:37.89elapsed
>>
>> - With 5.6.0-rc3 + this patch, with proactiveness=20
>>
>> 8.35user 194.58system 3:19.62elapsed
>>
>> Elapsed time remains around 3:15, as proactiveness is further
>> increased.
>>
>> Note that proactive compaction happens throughout the runtime of
>> these
>> workloads. The situation of one-time compaction, sufficient to supply
>> hugepages for following allocation stream, can probably happen for
>> more
>> extreme proactiveness values, like 80 or 90.
>>
>> In the above Java workload, proactiveness is set to 20. The test
>> starts
>> with a node's score of 80 or higher, depending on the delay between
>> the
>> fragmentation step and starting the benchmark, which gives more-or-
>> less
>> time for the initial round of compaction. As t	he benchmark
>> consumes
>> hugepages, node's score quickly rises above the high threshold (90)
>> and
>> proactive compaction starts again, which brings down the score to the
>> low threshold level (80).  Repeat.
>>
>> bpftrace also confirms proactive compaction running 20+ times during
>> the
>> runtime of this Java benchmark. kcompactd threads consume 100% of one
>> of
>> the CPUs while it tries to bring a node's score within thresholds.
>>
>> Backoff behavior
>> ================
>>
>> Above workloads produce a memory state which is easy to compact.
>> However, if memory is filled with unmovable pages, proactive
>> compaction
>> should essentially back off. To test this aspect:
>>
>> - Created a kernel driver that allocates almost all memory as
>> hugepages
>>   followed by freeing first 3/4 of each hugepage.
>> - Set proactiveness=40
>> - Note that proactive_compact_node() is deferred maximum number of
>> times
>>   with HPAGE_FRAG_CHECK_INTERVAL_MSEC of wait between each check
>>   (=> ~30 seconds between retries).
>>
>> [1] https://patchwork.kernel.org/patch/11098289/
>> [2] 
>> https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/
>> [3] https://lwn.net/Articles/817905/
>>
>> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>> To: Mel Gorman <mgorman@techsingularity.net>
>> To: Michal Hocko <mhocko@suse.com>
>> To: Vlastimil Babka <vbabka@suse.cz>
>> CC: Matthew Wilcox <willy@infradead.org>
>> CC: Andrew Morton <akpm@linux-foundation.org>
>> CC: Mike Kravetz <mike.kravetz@oracle.com>
>> CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>> CC: David Rientjes <rientjes@google.com>
>> CC: Nitin Gupta <ngupta@nitingupta.dev>
>> CC: linux-kernel <linux-kernel@vger.kernel.org>
>> CC: linux-mm <linux-mm@kvack.org>
>> CC: Linux API <linux-api@vger.kernel.org>
>>
>> ---
>> Changelog v6 vs v5:
>>  - Fallback to HUGETLB_PAGE_ORDER if HPAGE_PMD_ORDER is not defined,
>> and
>>    some cleanups (Vlastimil)
>>  - Cap min threshold to avoid excess compaction load in case user
>> sets
>>    extreme values like 100 for `vm.compaction_proactiveness` sysctl
>> (Khalid)
>>  - Add some more explanation about the effect of tunable on
>> compaction
>>    behavior in user guide (Khalid)
>>
>> Changelog v5 vs v4:
>>  - Change tunable from sysfs to sysctl (Vlastimil)
>>  - Replace HUGETLB_PAGE_ORDER with HPAGE_PMD_ORDER (Vlastimil)
>>  - Minor cleanups (remove redundant initializations, ...)
>>
>> Changelog v4 vs v3:
>>  - Document various functions.
>>  - Added admin-guide for the new tunable `proactiveness`.
>>  - Rename proactive_compaction_score to fragmentation_score for
>> clarity.
>>
>> Changelog v3 vs v2:
>>  - Make proactiveness a global tunable and not per-node. Also
>> upadated
>> the
>>    patch description to reflect the same (Vlastimil Babka).
>>  - Don't start proactive compaction if kswapd is running (Vlastimil
>> Babka).
>>  - Clarified in the description that compaction runs in parallel with
>>    the workload, instead of a one-time compaction followed by a
>> stream
>> of
>>    hugepage allocations.
>>
>> Changelog v2 vs v1:
>>  - Introduce per-node and per-zone "proactive compaction score". This
>>    score is compared against watermarks which are set according to
>>    user provided proactiveness value.
>>  - Separate code-paths for proactive compaction from targeted
>> compaction
>>    i.e. where pgdat->kcompactd_max_order is non-zero.
>>  - Renamed hpage_compaction_effort -> proactiveness. In future we may
>>    use more than extfrag wrt hugepage size to determine proactive
>>    compaction score.
>> ---
>>  Documentation/admin-guide/sysctl/vm.rst |  15 ++
>>  include/linux/compaction.h              |   2 +
>>  kernel/sysctl.c                         |   9 ++
>>  mm/compaction.c                         | 183
>> +++++++++++++++++++++++-
>>  mm/internal.h                           |   1 +
>>  mm/vmstat.c                             |  18 +++
>>  6 files changed, 223 insertions(+), 5 deletions(-)
> 
> 
> Looks good to me.
> 
> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> 
> 


Thanks Khalid.

Andrew, this patch now has two 'Reviewed-by' (Vlastimil and Khalid).
Can this be considered for 5.8 merge now?

Thanks,
Nitin
