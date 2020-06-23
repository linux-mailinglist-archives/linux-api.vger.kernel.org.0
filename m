Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917E9204A18
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2020 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbgFWGmX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jun 2020 02:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731202AbgFWGmU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Jun 2020 02:42:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C2C061573
        for <linux-api@vger.kernel.org>; Mon, 22 Jun 2020 23:42:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so9629984pfd.6
        for <linux-api@vger.kernel.org>; Mon, 22 Jun 2020 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KBdtjn/eUP0KCyYSVUTxmPmnPLxzRk9ZjyIeGHC8krs=;
        b=XggkRuH89w9WM7UUI0gtFUXmBpJJeiQ8HhmnKGIC62ASIzzvLjcPdXZM8gXGzpDR9T
         Dghdu5HhwG05iIK1nZjtzDpKv9flcjL8dL+QwNuGXUcHpgV9Z97aZN/hO8zkhLs1EjLO
         gWXYep04tm8y7Obgvs+yzLsBGyy9k1RYu2/MOJ+efIbL07OL1Gny5bqUMkBcq7cA9Y2T
         nEPcza5AW78SuMzFJd6KSOS0GCJ7UHN0hUIEVsXL85n3e2t6Jq90IsGUcNQfCTC7QzEY
         RNyeHHJWHuK9750anxAjvkpHqdcWHE6M0oZ8lsxu8afng1X1k4+yKXlYgmxFEqFap0LE
         Y5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KBdtjn/eUP0KCyYSVUTxmPmnPLxzRk9ZjyIeGHC8krs=;
        b=EZsRbVgyW+IQSOQF+tyee8cWXZd8G4Cr22RHGgJZDm/3/11bED/gusvaUeCQUsttN3
         oWnvC3sSm30GEwfMp4ZA2YG5wca6fJeT8iw9OkkERcxsxApEOqds0Unyxx65EWKdmIxT
         xNco7U6mulbc6Famlzoj34kdJRV34nQqathCSk6CnR8k/UUjVLnaX5gcOB1vSYtYIr0l
         gAF0t7szketTXk39lsE8VYI73e2s+EOikEQMsuCYo3Shxg0xxLIKSF2NsGoxcjHimkb3
         OCyXPKQIW8cafy9BYIjPZqbrEz9rhneJp6ZyxwvRq50w4YYkSO1DRt3ORLCyfNBV9CGk
         VA0A==
X-Gm-Message-State: AOAM532qHoi5ITv/ckrPp8zmCqZOW0UVLInDQYns/Rcvtm6hTutZFlhI
        kVBa7yQAnLag56pLZ4bh50hxFg==
X-Google-Smtp-Source: ABdhPJzmtXuO9HplM4wbDlDxbABG1JX3QHBgxJPV2IcoQBTa5BZ/+goHRNwAJPJI+GVw43lV0gugOg==
X-Received: by 2002:a62:a110:: with SMTP id b16mr16711905pff.102.1592894539267;
        Mon, 22 Jun 2020 23:42:19 -0700 (PDT)
Received: from ngvpn01-170-51.dyn.scz.us.nvidia.com ([2601:646:9302:1050:d88e:a8a0:b827:da35])
        by smtp.gmail.com with ESMTPSA id ca6sm1357851pjb.46.2020.06.22.23.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:42:18 -0700 (PDT)
Subject: Re: [PATCH v8] mm: Proactive compaction
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nitin Gupta <nigupta@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mips@vger.kernel.org
References: <20200616204527.19185-1-nigupta@nvidia.com>
 <20200623022636.GA1051134@ubuntu-n2-xlarge-x86>
 <d51d4db4-31b6-8db8-b4b7-62d3080ad001@nitingupta.dev>
 <20200623045740.GA2912137@ubuntu-n2-xlarge-x86>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Message-ID: <4d6b4822-f692-9cad-54c9-d6ef087a3947@nitingupta.dev>
Date:   Mon, 22 Jun 2020 23:42:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200623045740.GA2912137@ubuntu-n2-xlarge-x86>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/22/20 9:57 PM, Nathan Chancellor wrote:
> On Mon, Jun 22, 2020 at 09:32:12PM -0700, Nitin Gupta wrote:
>> On 6/22/20 7:26 PM, Nathan Chancellor wrote:
>>> On Tue, Jun 16, 2020 at 01:45:27PM -0700, Nitin Gupta wrote:
>>>> For some applications, we need to allocate almost all memory as
>>>> hugepages. However, on a running system, higher-order allocations can
>>>> fail if the memory is fragmented. Linux kernel currently does on-demand
>>>> compaction as we request more hugepages, but this style of compaction
>>>> incurs very high latency. Experiments with one-time full memory
>>>> compaction (followed by hugepage allocations) show that kernel is able
>>>> to restore a highly fragmented memory state to a fairly compacted memory
>>>> state within <1 sec for a 32G system. Such data suggests that a more
>>>> proactive compaction can help us allocate a large fraction of memory as
>>>> hugepages keeping allocation latencies low.
>>>>
>>>> For a more proactive compaction, the approach taken here is to define a
>>>> new sysctl called 'vm.compaction_proactiveness' which dictates bounds
>>>> for external fragmentation which kcompactd tries to maintain.
>>>>
>>>> The tunable takes a value in range [0, 100], with a default of 20.
>>>>
>>>> Note that a previous version of this patch [1] was found to introduce
>>>> too many tunables (per-order extfrag{low, high}), but this one reduces
>>>> them to just one sysctl. Also, the new tunable is an opaque value
>>>> instead of asking for specific bounds of "external fragmentation", which
>>>> would have been difficult to estimate. The internal interpretation of
>>>> this opaque value allows for future fine-tuning.
>>>>
>>>> Currently, we use a simple translation from this tunable to [low, high]
>>>> "fragmentation score" thresholds (low=100-proactiveness, high=low+10%).
>>>> The score for a node is defined as weighted mean of per-zone external
>>>> fragmentation. A zone's present_pages determines its weight.
>>>>
>>>> To periodically check per-node score, we reuse per-node kcompactd
>>>> threads, which are woken up every 500 milliseconds to check the same. If
>>>> a node's score exceeds its high threshold (as derived from user-provided
>>>> proactiveness value), proactive compaction is started until its score
>>>> reaches its low threshold value. By default, proactiveness is set to 20,
>>>> which implies threshold values of low=80 and high=90.
>>>>
>>>> This patch is largely based on ideas from Michal Hocko [2]. See also the
>>>> LWN article [3].
>>>>
>>>> Performance data
>>>> ================
>>>>
>>>> System: x64_64, 1T RAM, 80 CPU threads.
>>>> Kernel: 5.6.0-rc3 + this patch
>>>>
>>>> echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
>>>> echo madvise | sudo tee /sys/kernel/mm/transparent_hugepage/defrag
>>>>
>>>> Before starting the driver, the system was fragmented from a userspace
>>>> program that allocates all memory and then for each 2M aligned section,
>>>> frees 3/4 of base pages using munmap. The workload is mainly anonymous
>>>> userspace pages, which are easy to move around. I intentionally avoided
>>>> unmovable pages in this test to see how much latency we incur when
>>>> hugepage allocations hit direct compaction.
>>>>
>>>> 1. Kernel hugepage allocation latencies
>>>>
>>>> With the system in such a fragmented state, a kernel driver then
>>>> allocates as many hugepages as possible and measures allocation
>>>> latency:
>>>>
>>>> (all latency values are in microseconds)
>>>>
>>>> - With vanilla 5.6.0-rc3
>>>>
>>>>   percentile latency
>>>>   –––––––––– –––––––
>>>> 	   5    7894
>>>> 	  10    9496
>>>> 	  25   12561
>>>> 	  30   15295
>>>> 	  40   18244
>>>> 	  50   21229
>>>> 	  60   27556
>>>> 	  75   30147
>>>> 	  80   31047
>>>> 	  90   32859
>>>> 	  95   33799
>>>>
>>>> Total 2M hugepages allocated = 383859 (749G worth of hugepages out of
>>>> 762G total free => 98% of free memory could be allocated as hugepages)
>>>>
>>>> - With 5.6.0-rc3 + this patch, with proactiveness=20
>>>>
>>>> sysctl -w vm.compaction_proactiveness=20
>>>>
>>>>   percentile latency
>>>>   –––––––––– –––––––
>>>> 	   5       2
>>>> 	  10       2
>>>> 	  25       3
>>>> 	  30       3
>>>> 	  40       3
>>>> 	  50       4
>>>> 	  60       4
>>>> 	  75       4
>>>> 	  80       4
>>>> 	  90       5
>>>> 	  95     429
>>>>
>>>> Total 2M hugepages allocated = 384105 (750G worth of hugepages out of
>>>> 762G total free => 98% of free memory could be allocated as hugepages)
>>>>
>>>> 2. JAVA heap allocation
>>>>
>>>> In this test, we first fragment memory using the same method as for (1).
>>>>
>>>> Then, we start a Java process with a heap size set to 700G and request
>>>> the heap to be allocated with THP hugepages. We also set THP to madvise
>>>> to allow hugepage backing of this heap.
>>>>
>>>> /usr/bin/time
>>>>  java -Xms700G -Xmx700G -XX:+UseTransparentHugePages -XX:+AlwaysPreTouch
>>>>
>>>> The above command allocates 700G of Java heap using hugepages.
>>>>
>>>> - With vanilla 5.6.0-rc3
>>>>
>>>> 17.39user 1666.48system 27:37.89elapsed
>>>>
>>>> - With 5.6.0-rc3 + this patch, with proactiveness=20
>>>>
>>>> 8.35user 194.58system 3:19.62elapsed
>>>>
>>>> Elapsed time remains around 3:15, as proactiveness is further increased.
>>>>
>>>> Note that proactive compaction happens throughout the runtime of these
>>>> workloads. The situation of one-time compaction, sufficient to supply
>>>> hugepages for following allocation stream, can probably happen for more
>>>> extreme proactiveness values, like 80 or 90.
>>>>
>>>> In the above Java workload, proactiveness is set to 20. The test starts
>>>> with a node's score of 80 or higher, depending on the delay between the
>>>> fragmentation step and starting the benchmark, which gives more-or-less
>>>> time for the initial round of compaction. As t	he benchmark consumes
>>>> hugepages, node's score quickly rises above the high threshold (90) and
>>>> proactive compaction starts again, which brings down the score to the
>>>> low threshold level (80).  Repeat.
>>>>
>>>> bpftrace also confirms proactive compaction running 20+ times during the
>>>> runtime of this Java benchmark. kcompactd threads consume 100% of one of
>>>> the CPUs while it tries to bring a node's score within thresholds.
>>>>
>>>> Backoff behavior
>>>> ================
>>>>
>>>> Above workloads produce a memory state which is easy to compact.
>>>> However, if memory is filled with unmovable pages, proactive compaction
>>>> should essentially back off. To test this aspect:
>>>>
>>>> - Created a kernel driver that allocates almost all memory as hugepages
>>>>   followed by freeing first 3/4 of each hugepage.
>>>> - Set proactiveness=40
>>>> - Note that proactive_compact_node() is deferred maximum number of times
>>>>   with HPAGE_FRAG_CHECK_INTERVAL_MSEC of wait between each check
>>>>   (=> ~30 seconds between retries).
>>>>
>>>> [1] https://patchwork.kernel.org/patch/11098289/
>>>> [2] https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/
>>>> [3] https://lwn.net/Articles/817905/
>>>>
>>>> Signed-off-by: Nitin Gupta <nigupta@nvidia.com>
>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>>>> Reviewed-by: Oleksandr Natalenko <oleksandr@redhat.com>
>>>> Tested-by: Oleksandr Natalenko <oleksandr@redhat.com>
>>>> To: Andrew Morton <akpm@linux-foundation.org>
>>>> CC: Vlastimil Babka <vbabka@suse.cz>
>>>> CC: Khalid Aziz <khalid.aziz@oracle.com>
>>>> CC: Michal Hocko <mhocko@suse.com>
>>>> CC: Mel Gorman <mgorman@techsingularity.net>
>>>> CC: Matthew Wilcox <willy@infradead.org>
>>>> CC: Mike Kravetz <mike.kravetz@oracle.com>
>>>> CC: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>>>> CC: David Rientjes <rientjes@google.com>
>>>> CC: Nitin Gupta <ngupta@nitingupta.dev>
>>>> CC: Oleksandr Natalenko <oleksandr@redhat.com>
>>>> CC: linux-kernel <linux-kernel@vger.kernel.org>
>>>> CC: linux-mm <linux-mm@kvack.org>
>>>> CC: Linux API <linux-api@vger.kernel.org>
>>>
>>> This is now in -next and causes the following build failure:
>>>
>>> $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mipsel-linux- O=out/mipsel distclean malta_kvm_guest_defconfig mm/compaction.o
>>> In file included from include/linux/dev_printk.h:14,
>>>                  from include/linux/device.h:15,
>>>                  from include/linux/node.h:18,
>>>                  from include/linux/cpu.h:17,
>>>                  from mm/compaction.c:11:
>>> In function 'fragmentation_score_zone',
>>>     inlined from '__compact_finished' at mm/compaction.c:1982:11,
>>>     inlined from 'compact_zone' at mm/compaction.c:2062:8:
>>> include/linux/compiler.h:339:38: error: call to '__compiletime_assert_301' declared with attribute error: BUILD_BUG failed
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |                                      ^
>>> include/linux/compiler.h:320:4: note: in definition of macro '__compiletime_assert'
>>>   320 |    prefix ## suffix();    \
>>>       |    ^~~~~~
>>> include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |  ^~~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>       |                                     ^~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>>       |                     ^~~~~~~~~~~~~~~~
>>> arch/mips/include/asm/page.h:70:30: note: in expansion of macro 'BUILD_BUG'
>>>    70 | #define HUGETLB_PAGE_ORDER ({BUILD_BUG(); 0; })
>>>       |                              ^~~~~~~~~
>>> mm/compaction.c:66:32: note: in expansion of macro 'HUGETLB_PAGE_ORDER'
>>>    66 | #define COMPACTION_HPAGE_ORDER HUGETLB_PAGE_ORDER
>>>       |                                ^~~~~~~~~~~~~~~~~~
>>> mm/compaction.c:1898:28: note: in expansion of macro 'COMPACTION_HPAGE_ORDER'
>>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>>> In function 'fragmentation_score_zone',
>>>     inlined from 'kcompactd' at mm/compaction.c:1918:12:
>>> include/linux/compiler.h:339:38: error: call to '__compiletime_assert_301' declared with attribute error: BUILD_BUG failed
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |                                      ^
>>> include/linux/compiler.h:320:4: note: in definition of macro '__compiletime_assert'
>>>   320 |    prefix ## suffix();    \
>>>       |    ^~~~~~
>>> include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |  ^~~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>       |                                     ^~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>>       |                     ^~~~~~~~~~~~~~~~
>>> arch/mips/include/asm/page.h:70:30: note: in expansion of macro 'BUILD_BUG'
>>>    70 | #define HUGETLB_PAGE_ORDER ({BUILD_BUG(); 0; })
>>>       |                              ^~~~~~~~~
>>> mm/compaction.c:66:32: note: in expansion of macro 'HUGETLB_PAGE_ORDER'
>>>    66 | #define COMPACTION_HPAGE_ORDER HUGETLB_PAGE_ORDER
>>>       |                                ^~~~~~~~~~~~~~~~~~
>>> mm/compaction.c:1898:28: note: in expansion of macro 'COMPACTION_HPAGE_ORDER'
>>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>>> In function 'fragmentation_score_zone',
>>>     inlined from 'kcompactd' at mm/compaction.c:1918:12:
>>> include/linux/compiler.h:339:38: error: call to '__compiletime_assert_301' declared with attribute error: BUILD_BUG failed
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |                                      ^
>>> include/linux/compiler.h:320:4: note: in definition of macro '__compiletime_assert'
>>>   320 |    prefix ## suffix();    \
>>>       |    ^~~~~~
>>> include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |  ^~~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>       |                                     ^~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>>       |                     ^~~~~~~~~~~~~~~~
>>> arch/mips/include/asm/page.h:70:30: note: in expansion of macro 'BUILD_BUG'
>>>    70 | #define HUGETLB_PAGE_ORDER ({BUILD_BUG(); 0; })
>>>       |                              ^~~~~~~~~
>>> mm/compaction.c:66:32: note: in expansion of macro 'HUGETLB_PAGE_ORDER'
>>>    66 | #define COMPACTION_HPAGE_ORDER HUGETLB_PAGE_ORDER
>>>       |                                ^~~~~~~~~~~~~~~~~~
>>> mm/compaction.c:1898:28: note: in expansion of macro 'COMPACTION_HPAGE_ORDER'
>>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>>> In function 'fragmentation_score_zone',
>>>     inlined from 'kcompactd' at mm/compaction.c:1918:12:
>>> include/linux/compiler.h:339:38: error: call to '__compiletime_assert_301' declared with attribute error: BUILD_BUG failed
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |                                      ^
>>> include/linux/compiler.h:320:4: note: in definition of macro '__compiletime_assert'
>>>   320 |    prefix ## suffix();    \
>>>       |    ^~~~~~
>>> include/linux/compiler.h:339:2: note: in expansion of macro '_compiletime_assert'
>>>   339 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>>>       |  ^~~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
>>>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>>>       |                                     ^~~~~~~~~~~~~~~~~~
>>> include/linux/build_bug.h:59:21: note: in expansion of macro 'BUILD_BUG_ON_MSG'
>>>    59 | #define BUILD_BUG() BUILD_BUG_ON_MSG(1, "BUILD_BUG failed")
>>>       |                     ^~~~~~~~~~~~~~~~
>>> arch/mips/include/asm/page.h:70:30: note: in expansion of macro 'BUILD_BUG'
>>>    70 | #define HUGETLB_PAGE_ORDER ({BUILD_BUG(); 0; })
>>>       |                              ^~~~~~~~~
>>> mm/compaction.c:66:32: note: in expansion of macro 'HUGETLB_PAGE_ORDER'
>>>    66 | #define COMPACTION_HPAGE_ORDER HUGETLB_PAGE_ORDER
>>>       |                                ^~~~~~~~~~~~~~~~~~
>>> mm/compaction.c:1898:28: note: in expansion of macro 'COMPACTION_HPAGE_ORDER'
>>>  1898 |    extfrag_for_order(zone, COMPACTION_HPAGE_ORDER);
>>>       |                            ^~~~~~~~~~~~~~~~~~~~~~
>>> make[3]: *** [scripts/Makefile.build:281: mm/compaction.o] Error 1
>>> make[3]: Target '__build' not remade because of errors.
>>> make[2]: *** [Makefile:1765: mm] Error 2
>>> make[2]: Target 'mm/compaction.o' not remade because of errors.
>>> make[1]: *** [Makefile:336: __build_one_by_one] Error 2
>>> make[1]: Target 'distclean' not remade because of errors.
>>> make[1]: Target 'malta_kvm_guest_defconfig' not remade because of errors.
>>> make[1]: Target 'mm/compaction.o' not remade because of errors.
>>> make: *** [Makefile:185: __sub-make] Error 2
>>> make: Target 'distclean' not remade because of errors.
>>> make: Target 'malta_kvm_guest_defconfig' not remade because of errors.
>>> make: Target 'mm/compaction.o' not remade because of errors.
>>>
>>> I am not sure why MIPS is special with its handling of hugepage support
>>> but I am far from a MIPS expert :)
>>>
>>
>> Can you check if this patch fixes the compile error:
>>
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 45fd24a0ea0b..02963ffb9e70 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -62,7 +62,7 @@ static const unsigned int
>> HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
>>   */
>>  #if defined CONFIG_TRANSPARENT_HUGEPAGE
>>  #define COMPACTION_HPAGE_ORDER HPAGE_PMD_ORDER
>> -#elif defined HUGETLB_PAGE_ORDER
>> +#elif defined CONFIG_HUGETLBFS
>>  #define COMPACTION_HPAGE_ORDER HUGETLB_PAGE_ORDER
>>  #else
>>  #define COMPACTION_HPAGE_ORDER (PMD_SHIFT - PAGE_SHIFT)
>>
>>
>>
>>
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com> # build
> 

Thanks. I will send out a patch with this fix soon.

Nitin

