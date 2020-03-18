Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E276189A12
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2020 11:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgCRK6V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Mar 2020 06:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgCRK6U (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 18 Mar 2020 06:58:20 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEF6520768;
        Wed, 18 Mar 2020 10:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584529099;
        bh=MkDsN2Eq2l8VIZO5CKor3u0iTn/XfXUIR6VH4pbo2VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABGGj5t1ki/X3Ld4aDl0EVAb5f3hFnHX3kNMM2/faz3vwQmNZJGbLUZtj/rrT+pzB
         wnO9PlaYuaMngKaY3fHIiq9yPccg5QmVmjyNzug+WtgcNHARXLIU3COndGKK56+vf3
         8lc7xAs7Qf+niJz+XfsivFYzEC+feoutPzG5ZRNA=
Date:   Wed, 18 Mar 2020 12:58:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     Jaewon Kim <jaewon31.kim@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, adobriyan@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
Message-ID: <20200318105815.GV3351@unreal>
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
 <20200311034441.23243-1-jaewon31.kim@samsung.com>
 <af4ace34-0db2-dd17-351f-eaa806f0a6ac@suse.cz>
 <20200313174827.GA67638@unreal>
 <5E6EFB6C.7050105@samsung.com>
 <20200316083154.GF8510@unreal>
 <CAJrd-UvttDDSL=q1RXC6Z+jvZAGsN2iM8C8xOSrpJFdLb0e-3g@mail.gmail.com>
 <20200317143715.GI3351@unreal>
 <5E71E2CB.4030704@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5E71E2CB.4030704@samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 18, 2020 at 05:58:51PM +0900, Jaewon Kim wrote:
>
>
> On 2020년 03월 17일 23:37, Leon Romanovsky wrote:
> > On Tue, Mar 17, 2020 at 12:04:46PM +0900, Jaewon Kim wrote:
> >> 2020년 3월 16일 (월) 오후 5:32, Leon Romanovsky <leon@kernel.org>님이 작성:
> >>> On Mon, Mar 16, 2020 at 01:07:08PM +0900, Jaewon Kim wrote:
> >>>>
> >>>> On 2020년 03월 14일 02:48, Leon Romanovsky wrote:
> >>>>> On Fri, Mar 13, 2020 at 04:19:36PM +0100, Vlastimil Babka wrote:
> >>>>>> +CC linux-api, please include in future versions as well
> >>>>>>
> >>>>>> On 3/11/20 4:44 AM, Jaewon Kim wrote:
> >>>>>>> /proc/meminfo or show_free_areas does not show full system wide memory
> >>>>>>> usage status. There seems to be huge hidden memory especially on
> >>>>>>> embedded Android system. Because it usually have some HW IP which do not
> >>>>>>> have internal memory and use common DRAM memory.
> >>>>>>>
> >>>>>>> In Android system, most of those hidden memory seems to be vmalloc pages
> >>>>>>> , ion system heap memory, graphics memory, and memory for DRAM based
> >>>>>>> compressed swap storage. They may be shown in other node but it seems to
> >>>>>>> useful if /proc/meminfo shows all those extra memory information. And
> >>>>>>> show_mem also need to print the info in oom situation.
> >>>>>>>
> >>>>>>> Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
> >>>>>>> ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
> >>>>>>> memory using zsmalloc can be seen through vmstat by commit 91537fee0013
> >>>>>>> ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
> >>>>>>>
> >>>>>>> Memory usage of specific driver can be various so that showing the usage
> >>>>>>> through upstream meminfo.c is not easy. To print the extra memory usage
> >>>>>>> of a driver, introduce following APIs. Each driver needs to count as
> >>>>>>> atomic_long_t.
> >>>>>>>
> >>>>>>> int register_extra_meminfo(atomic_long_t *val, int shift,
> >>>>>>>                      const char *name);
> >>>>>>> int unregister_extra_meminfo(atomic_long_t *val);
> >>>>>>>
> >>>>>>> Currently register ION system heap allocator and zsmalloc pages.
> >>>>>>> Additionally tested on local graphics driver.
> >>>>>>>
> >>>>>>> i.e) cat /proc/meminfo | tail -3
> >>>>>>> IonSystemHeap:    242620 kB
> >>>>>>> ZsPages:          203860 kB
> >>>>>>> GraphicDriver:    196576 kB
> >>>>>>>
> >>>>>>> i.e.) show_mem on oom
> >>>>>>> <6>[  420.856428]  Mem-Info:
> >>>>>>> <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
> >>>>>>> <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
> >>>>>> I like the idea and the dynamic nature of this, so that drivers not present
> >>>>>> wouldn't add lots of useless zeroes to the output.
> >>>>>> It also makes simpler the decisions of "what is important enough to need its own
> >>>>>> meminfo entry".
> >>>>>>
> >>>>>> The suggestion for hunting per-driver /sys files would only work if there was a
> >>>>>> common name to such files so once can find(1) them easily.
> >>>>>> It also doesn't work for the oom/failed alloc warning output.
> >>>>> Of course there is a need to have a stable name for such an output, this
> >>>>> is why driver/core should be responsible for that and not drivers authors.
> >>>>>
> >>>>> The use case which I had in mind slightly different than to look after OOM.
> >>>>>
> >>>>> I'm interested to optimize our drivers in their memory footprint to
> >>>>> allow better scale in SR-IOV mode where one device creates many separate
> >>>>> copies of itself. Those copies easily can take gigabytes of RAM due to
> >>>>> the need to optimize for high-performance networking. Sometimes the
> >>>>> amount of memory and not HW is actually limits the scale factor.
> >>>>>
> >>>>> So I would imagine this feature being used as an aid for the driver
> >>>>> developers and not for the runtime decisions.
> >>>>>
> >>>>> My 2-cents.
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>
> >>>> Thank you for your comment.
> >>>> My idea, I think, may be able to help each driver developer to see their memory usage.
> >>>> But I'd like to see overall memory usage through the one node.
> >>> It is more than enough :).
> >>>
> >>>> Let me know if you have more comment.
> >>>> I am planning to move my logic to be shown on a new node, /proc/meminfo_extra at v2.
> >>> Can you please help me to understand how that file will look like once
> >>> many drivers will start to use this interface? Will I see multiple
> >>> lines?
> >>>
> >>> Something like:
> >>> driver1 ....
> >>> driver2 ....
> >>> driver3 ....
> >>> ...
> >>> driver1000 ....
> >>>
> >>> How can we extend it to support subsystems core code?
> >> I do not have a plan to support subsystem core.
> > Fair enough.
> >
> >> I just want the /proc/meminfo_extra to show size of alloc_pages APIs
> >> rather than slub size. It is to show hidden huge memory.
> >> I think most of drivers do not need to register its size to
> >> /proc/meminfo_extra because
> >> drivers usually use slub APIs and rather than alloc_pages APIs.
> >> /proc/slabinfo helps for slub size in detail.
> > The problem with this statement that the drivers that consuming memory
> > are the ones who are interested in this interface. I can be not accurate
> > here, but I think that all RDMA and major NICs will want to get this
> > information.
> >
> > On my machine, it is something like 6 devices.
> >
> >> As a candidate of /proc/meminfo_extra, I hope only few drivers using
> >> huge memory like over 100 MB got from alloc_pages APIs.
> >>
> >> As you say, if there is a static node on /sys for each driver, it may
> >> be used for all the drivers.
> >> I think sysfs class way may be better to show categorized sum size.
> >> But /proc/meminfo_extra can be another way to show those hidden huge memory.
> >> I mean your idea and my idea is not exclusive.
> > It is just better to have one interface.
> Sorry about that one interface.
>
> If we need to create a-meminfo_extra-like node on /sysfs, then
> I think further discussion with more people is needed.
> If there is no logical problem on creating /proc/meminfo_extra,
> I'd like to prepare v2 patch and get more comment on that v2
> patch. Please help again for further discussion.

No problem, but can you please the summary of that discussion in the
cover letter of v2 and add Greg KH as the driver/core maintainer?

It will save from us to go in circles.

Thanks

>
> Thank you
> >
> >> Thank you
> >>> Thanks
> >>>
> >>>> Thank you
> >>>> Jaewon Kim
> >
>
