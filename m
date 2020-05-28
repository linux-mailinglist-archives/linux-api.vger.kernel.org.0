Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34331E6D9E
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2020 23:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436538AbgE1V3e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 17:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436558AbgE1V3d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 May 2020 17:29:33 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABB3C08C5C7
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 14:29:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so12915ljn.2
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 14:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zPqTHE9/GR4vnPWlpx0DWBIe+snFB77Ea5UmCJzaQQ=;
        b=b7pZg1HZHPd8lKCyUU+4ZGAIkifZLZR1tifL9J5Q8iepSEwxgiN4HVR2+wzUd1f7CP
         tzzOmMj01zz1E8WUxbMnb5COaMNs5l7tG0eW5+OR99VnqinRCue3d/4F+B8tGvxwR0Ec
         QDKSphXqq1vJOpiZ9rfo+eQBy3RmvEqUrfgKn4HSZsQSrbYUzzejGUCFmf7dYsqEMkrc
         +hNAk+vRR+CtTAz5JLMZPXycdV/1TvmjZX4ZBjuhRl3YjAe9/M71LEpghSJPeepo0+bT
         SQkb0mgIY/BKKBZ20hIFtAew8rJyZZPb3JE6pn3NJX9pGCFM1UbnAa7csRTsbgJAixis
         GZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zPqTHE9/GR4vnPWlpx0DWBIe+snFB77Ea5UmCJzaQQ=;
        b=KKJezSA6vhQZ5bqTI8842ZDkEz5YXdYcT7eE89JRXXF6c67utB3dhFaE7p8O81I/EN
         hcF7hhf1dMvESv5nfn1bMuZ7XnQC2uxEenVyz4cSm89V9s9gLdQl+1JV2t/6SxfUvzIP
         P13ixSah1AEA1ktt8pFXXL/SntoDUSBJiIQm0fUsNEuqX+XvXVONertCHpOhwf+hCTYw
         UN/H7Y4QgajtQamlbMCuncBaMHab6CVWerY1dmENY7SS2ey+udGgY0/jKVAoTKfdKz8W
         1t7PWHlijen8RGkziid1zjCcQwuEyNWwoPq55q4lsTgKq9xvFUdDwSxYEVtEswGwjL/f
         laMQ==
X-Gm-Message-State: AOAM530B6/SiZITMkf+DSuJ7xMkcKFRh3dspzQ5j6wf/vrTWX5A2SHds
        pW4JO8hXFuGQsQEsJpjWIiGLETpjjbabdgMq51AhrA==
X-Google-Smtp-Source: ABdhPJze9E0inrUh1tCIGF1gWJDBe8jI4g8bIebz9vtnQ84+7qqRlV8uWA2z5sUQa/5/PbhpZBHOOO0APCkHU3JRE7c=
X-Received: by 2002:a2e:9d5:: with SMTP id 204mr2372202ljj.168.1590701370219;
 Thu, 28 May 2020 14:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200518181446.25759-1-nigupta@nvidia.com> <6515aac4-9024-3cbf-94b5-9a85e5953756@suse.cz>
In-Reply-To: <6515aac4-9024-3cbf-94b5-9a85e5953756@suse.cz>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Date:   Thu, 28 May 2020 14:29:19 -0700
Message-ID: <CAB6CXpApnNdHRVAwdm2GAqoLURvQ5VLFM6bogrRFubGZUt-60Q@mail.gmail.com>
Subject: Re: [PATCH v5] mm: Proactive compaction
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 27, 2020 at 3:18 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 5/18/20 8:14 PM, Nitin Gupta wrote:
> > For some applications, we need to allocate almost all memory as
> > hugepages. However, on a running system, higher-order allocations can
> > fail if the memory is fragmented. Linux kernel currently does on-demand
> > compaction as we request more hugepages, but this style of compaction
> > incurs very high latency. Experiments with one-time full memory
> > compaction (followed by hugepage allocations) show that kernel is able
> > to restore a highly fragmented memory state to a fairly compacted memory
> > state within <1 sec for a 32G system. Such data suggests that a more
> > proactive compaction can help us allocate a large fraction of memory as
> > hugepages keeping allocation latencies low.
> >
> > For a more proactive compaction, the approach taken here is to define
> > a new tunable called 'proactiveness' which dictates bounds for external
> > fragmentation wrt HUGETLB_PAGE_ORDER order which kcompactd tries to
>
> HPAGE_PMD_ORDER
>

Since HPAGE_PMD_ORDER is not always defined, and thus we may have
to fallback to HUGETLB_PAGE_ORDER or even PMD_ORDER, I think
I should remove references to the order in the patch description entirely.

I also need to change the tunable name from 'proactiveness' to
'vm.compaction_proactiveness' sysctl.

modified description:
===
For a more proactive compaction, the approach taken here is to define
a new sysctl called 'vm.compaction_proactiveness' which dictates
bounds for external fragmentation which kcompactd tries to ...
===


> >
> > The tunable is exposed through sysctl:
> >   /proc/sys/vm/compaction_proactiveness
> >
> > It takes value in range [0, 100], with a default of 20.
> >


> >
> > This patch is largely based on ideas from Michal Hocko posted here:
> > https://lore.kernel.org/linux-mm/20161230131412.GI13301@dhcp22.suse.cz/
>
> Make this link a [2] reference? I would also add: "See also the LWN article
> [3]." where [3] is https://lwn.net/Articles/817905/
>
>

Sounds good. I will turn these into [2] and [3] references.



>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

> With some smaller nitpicks below.
>
> But as we are adding a new API, I would really appreciate others comment about
> the approach at least.
>



> > +/*
> > + * A zone's fragmentation score is the external fragmentation wrt to the
> > + * HUGETLB_PAGE_ORDER scaled by the zone's size. It returns a value in the
>
> HPAGE_PMD_ORDER
>

Maybe just remove reference to the order as I mentioned above?



> > +/*
> > + * Tunable for proactive compaction. It determines how
> > + * aggressively the kernel should compact memory in the
> > + * background. It takes values in the range [0, 100].
> > + */
> > +int sysctl_compaction_proactiveness = 20;
>
> These are usually __read_mostly
>

Ok.


> > +
> >  /*
> >   * This is the entry point for compacting all nodes via
> >   * /proc/sys/vm/compact_memory
> > @@ -2637,6 +2769,7 @@ static int kcompactd(void *p)
> >  {
> >       pg_data_t *pgdat = (pg_data_t*)p;
> >       struct task_struct *tsk = current;
> > +     unsigned int proactive_defer = 0;
> >
> >       const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> >
> > @@ -2652,12 +2785,34 @@ static int kcompactd(void *p)
> >               unsigned long pflags;
> >
> >               trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
> > -             wait_event_freezable(pgdat->kcompactd_wait,
> > -                             kcompactd_work_requested(pgdat));
> > +             if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
> > +                     kcompactd_work_requested(pgdat),
> > +                     msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
>
> Hmm perhaps the wakeups should also backoff if there's nothing to do?


Perhaps. For now, I just wanted to keep it simple and waking a thread to do a
quick calculation didn't seem expensive to me, so I prefer this simplistic
approach for now.


> > +/*
> > + * Calculates external fragmentation within a zone wrt the given order.
> > + * It is defined as the percentage of pages found in blocks of size
> > + * less than 1 << order. It returns values in range [0, 100].
> > + */
> > +int extfrag_for_order(struct zone *zone, unsigned int order)
> > +{
> > +     struct contig_page_info info;
> > +
> > +     fill_contig_page_info(zone, order, &info);
> > +     if (info.free_pages == 0)
> > +             return 0;
> > +
> > +     return (info.free_pages - (info.free_blocks_suitable << order)) * 100
> > +                                                     / info.free_pages;
>
> I guess this should also use div_u64() like __fragmentation_index() does.
>

Ok.


> > +}
> > +
> >  /* Same as __fragmentation index but allocs contig_page_info on stack */
> >  int fragmentation_index(struct zone *zone, unsigned int order)
> >  {
> >
>


Thanks,
Nitin
