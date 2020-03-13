Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7A8184A73
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2020 16:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgCMPTk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Mar 2020 11:19:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgCMPTk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Mar 2020 11:19:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 98C4DAE61;
        Fri, 13 Mar 2020 15:19:37 +0000 (UTC)
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
To:     Jaewon Kim <jaewon31.kim@samsung.com>, adobriyan@gmail.com,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Linux API <linux-api@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
 <20200311034441.23243-1-jaewon31.kim@samsung.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <af4ace34-0db2-dd17-351f-eaa806f0a6ac@suse.cz>
Date:   Fri, 13 Mar 2020 16:19:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311034441.23243-1-jaewon31.kim@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+CC linux-api, please include in future versions as well

On 3/11/20 4:44 AM, Jaewon Kim wrote:
> /proc/meminfo or show_free_areas does not show full system wide memory
> usage status. There seems to be huge hidden memory especially on
> embedded Android system. Because it usually have some HW IP which do not
> have internal memory and use common DRAM memory.
> 
> In Android system, most of those hidden memory seems to be vmalloc pages
> , ion system heap memory, graphics memory, and memory for DRAM based
> compressed swap storage. They may be shown in other node but it seems to
> useful if /proc/meminfo shows all those extra memory information. And
> show_mem also need to print the info in oom situation.
> 
> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
> 
> Memory usage of specific driver can be various so that showing the usage
> through upstream meminfo.c is not easy. To print the extra memory usage
> of a driver, introduce following APIs. Each driver needs to count as
> atomic_long_t.
> 
> int register_extra_meminfo(atomic_long_t *val, int shift,
> 			   const char *name);
> int unregister_extra_meminfo(atomic_long_t *val);
> 
> Currently register ION system heap allocator and zsmalloc pages.
> Additionally tested on local graphics driver.
> 
> i.e) cat /proc/meminfo | tail -3
> IonSystemHeap:    242620 kB
> ZsPages:          203860 kB
> GraphicDriver:    196576 kB
> 
> i.e.) show_mem on oom
> <6>[  420.856428]  Mem-Info:
> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0

I like the idea and the dynamic nature of this, so that drivers not present
wouldn't add lots of useless zeroes to the output.
It also makes simpler the decisions of "what is important enough to need its own
meminfo entry".

The suggestion for hunting per-driver /sys files would only work if there was a
common name to such files so once can find(1) them easily.
It also doesn't work for the oom/failed alloc warning output.

I think a new meminfo_extra file is a reasonable compromise, as there might be
tools periodically reading /proc/meminfo and thus we would limit the overhead of
that.

> Jaewon Kim (3):
>   proc/meminfo: introduce extra meminfo
>   mm: zsmalloc: include zs page size in proc/meminfo
>   android: ion: include system heap size in proc/meminfo
> 
>  drivers/staging/android/ion/ion.c             |   2 +
>  drivers/staging/android/ion/ion.h             |   1 +
>  drivers/staging/android/ion/ion_system_heap.c |   2 +
>  fs/proc/meminfo.c                             | 103 ++++++++++++++++++++++++++
>  include/linux/mm.h                            |   4 +
>  lib/show_mem.c                                |   1 +
>  mm/zsmalloc.c                                 |   2 +
>  7 files changed, 115 insertions(+)
> 

