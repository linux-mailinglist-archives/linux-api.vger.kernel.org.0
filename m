Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55067184DE9
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2020 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgCMRsf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Mar 2020 13:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbgCMRsf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 13 Mar 2020 13:48:35 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD81D206E9;
        Fri, 13 Mar 2020 17:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584121714;
        bh=RTV73rV9tbgZdgxhjVpHf5cbOgrjF4jkzZeN0BW3HjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rTBDRlbNcvDK/M91AaxB/KKnHxKNQs5wEAymm0R3zmKwmKgdJygpE4ZsGPQ9coL9N
         OYVFjHI3f6jp625auhfZc1YBPcOjdbUwuqBfrp6tAIUn89ZPdKMAFrRhzWScGBrRKX
         LQ2mB2q61tTaRHFX3muuqAdvw4OuG3GM3e94uy3U=
Date:   Fri, 13 Mar 2020 19:48:27 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, adobriyan@gmail.com,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] meminfo: introduce extra meminfo
Message-ID: <20200313174827.GA67638@unreal>
References: <CGME20200311034454epcas1p2ef0c0081971dd82282583559398e58b2@epcas1p2.samsung.com>
 <20200311034441.23243-1-jaewon31.kim@samsung.com>
 <af4ace34-0db2-dd17-351f-eaa806f0a6ac@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af4ace34-0db2-dd17-351f-eaa806f0a6ac@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 13, 2020 at 04:19:36PM +0100, Vlastimil Babka wrote:
> +CC linux-api, please include in future versions as well
>
> On 3/11/20 4:44 AM, Jaewon Kim wrote:
> > /proc/meminfo or show_free_areas does not show full system wide memory
> > usage status. There seems to be huge hidden memory especially on
> > embedded Android system. Because it usually have some HW IP which do not
> > have internal memory and use common DRAM memory.
> >
> > In Android system, most of those hidden memory seems to be vmalloc pages
> > , ion system heap memory, graphics memory, and memory for DRAM based
> > compressed swap storage. They may be shown in other node but it seems to
> > useful if /proc/meminfo shows all those extra memory information. And
> > show_mem also need to print the info in oom situation.
> >
> > Fortunately vmalloc pages is alread shown by commit 97105f0ab7b8
> > ("mm: vmalloc: show number of vmalloc pages in /proc/meminfo"). Swap
> > memory using zsmalloc can be seen through vmstat by commit 91537fee0013
> > ("mm: add NR_ZSMALLOC to vmstat") but not on /proc/meminfo.
> >
> > Memory usage of specific driver can be various so that showing the usage
> > through upstream meminfo.c is not easy. To print the extra memory usage
> > of a driver, introduce following APIs. Each driver needs to count as
> > atomic_long_t.
> >
> > int register_extra_meminfo(atomic_long_t *val, int shift,
> > 			   const char *name);
> > int unregister_extra_meminfo(atomic_long_t *val);
> >
> > Currently register ION system heap allocator and zsmalloc pages.
> > Additionally tested on local graphics driver.
> >
> > i.e) cat /proc/meminfo | tail -3
> > IonSystemHeap:    242620 kB
> > ZsPages:          203860 kB
> > GraphicDriver:    196576 kB
> >
> > i.e.) show_mem on oom
> > <6>[  420.856428]  Mem-Info:
> > <6>[  420.856433]  IonSystemHeap:32813kB ZsPages:44114kB GraphicDriver::13091kB
> > <6>[  420.856450]  active_anon:957205 inactive_anon:159383 isolated_anon:0
>
> I like the idea and the dynamic nature of this, so that drivers not present
> wouldn't add lots of useless zeroes to the output.
> It also makes simpler the decisions of "what is important enough to need its own
> meminfo entry".
>
> The suggestion for hunting per-driver /sys files would only work if there was a
> common name to such files so once can find(1) them easily.
> It also doesn't work for the oom/failed alloc warning output.

Of course there is a need to have a stable name for such an output, this
is why driver/core should be responsible for that and not drivers authors.

The use case which I had in mind slightly different than to look after OOM.

I'm interested to optimize our drivers in their memory footprint to
allow better scale in SR-IOV mode where one device creates many separate
copies of itself. Those copies easily can take gigabytes of RAM due to
the need to optimize for high-performance networking. Sometimes the
amount of memory and not HW is actually limits the scale factor.

So I would imagine this feature being used as an aid for the driver
developers and not for the runtime decisions.

My 2-cents.

Thanks
