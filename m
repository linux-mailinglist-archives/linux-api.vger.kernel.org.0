Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C98524F6C
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfEUM5M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 08:57:12 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40617 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfEUM5M (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 08:57:12 -0400
Received: by mail-yw1-f67.google.com with SMTP id 18so7253401ywe.7
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 05:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/AHbGrbWFUhevOXCGpUGCgyop6Di8UfE0ud1RTG1ps=;
        b=akTuLbwyJU5RN+ZX+1XrhOSjd4MciXH7phKiqrpcWAfdgPdU7zImpJSRTClYg+LnD8
         f72NWpwZAcJEJWW1W6buISDdzYyEyDIrp3SR3YVvwuoBzzqiLJ9PEwNNgqHybiKQNlMJ
         2iG330vUDmL9jD5pERSkZpkiDcA8RywSlF0+wux3E+aw+YbeSJtlt4GB0itIQzksJcGg
         Ox4p2HDQsBtjjFQFbP2hmcPMJ6riI3suMWoQIGSBSXyT4sy107pII8ukRM5RFzlrR0H7
         IR44iZACqmT/AbXbIN0ZY4HXhfvGYsyfHLNXmBvTIPjUwP/LNaI4afQeK3TCCWZpsHCl
         1cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/AHbGrbWFUhevOXCGpUGCgyop6Di8UfE0ud1RTG1ps=;
        b=n3FWejhR7OJLdjE9wwzyGlKaD8dU5OavMVfFheR0G567NcgXkobPAylHbxlE+xeB5m
         6ImKLkUipEE8liNfPDiQFW2QN5H1BJYDbeUrog6z6/brLuCcztzjFnX0zfu7z1zHYcq5
         PXgN/oDiVcE41eNveZsCvcy0TVt3X/QeYYmJkjBJZHQYWWINlRxPhdivVrdpycyZO7Y1
         R2um3zfO+JhBQfRb26jbVseiSz57VsrCZspclMMNr7OmdEg3F8OPqV6qUYz5XvEazxYL
         rHKMgHkck2jzI2x6Zj3bRzLH7vjOnZBAl2K8uZmi+gRS2qfmLMwC/gg4PcWHkqGH/Bip
         JXxg==
X-Gm-Message-State: APjAAAVrWh6+gkgdcHqQFs6Awj3fPa51NUd0Pig/zehQ39KO2tT2ZcPw
        h6gjfDTWXgcia9qk2EsPjHAUStforNfZP4FFGULQnQ==
X-Google-Smtp-Source: APXvYqw2hO53tPry9V/J/vvYsaoh0I6dNYkejzO13Jx59B3H/C01BT/91Z/hSGJB2ngnVnWoIhnH/4HGgY7h5wywf4c=
X-Received: by 2002:a81:5ec3:: with SMTP id s186mr39737429ywb.308.1558443430631;
 Tue, 21 May 2019 05:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <dbe801f0-4bbe-5f6e-9053-4b7deb38e235@arm.com>
 <CAEe=Sxka3Q3vX+7aWUJGKicM+a9Px0rrusyL+5bB1w4ywF6N4Q@mail.gmail.com> <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
In-Reply-To: <1754d0ef-6756-d88b-f728-17b1fe5d5b07@arm.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 May 2019 05:56:59 -0700
Message-ID: <CALvZod6ioRxSi7tHB-uSTxN1-hsxD+8O3mfFAjaqdsimjUVmcw@mail.gmail.com>
Subject: Re: [RFC 0/7] introduce memory hinting API for external process
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 7:55 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 05/20/2019 10:29 PM, Tim Murray wrote:
> > On Sun, May 19, 2019 at 11:37 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> Or Is the objective here is reduce the number of processes which get killed by
> >> lmkd by triggering swapping for the unused memory (user hinted) sooner so that
> >> they dont get picked by lmkd. Under utilization for zram hardware is a concern
> >> here as well ?
> >
> > The objective is to avoid some instances of memory pressure by
> > proactively swapping pages that userspace knows to be cold before
> > those pages reach the end of the LRUs, which in turn can prevent some
> > apps from being killed by lmk/lmkd. As soon as Android userspace knows
> > that an application is not being used and is only resident to improve
> > performance if the user returns to that app, we can kick off
> > process_madvise on that process's pages (or some portion of those
> > pages) in a power-efficient way to reduce memory pressure long before
> > the system hits the free page watermark. This allows the system more
> > time to put pages into zram versus waiting for the watermark to
> > trigger kswapd, which decreases the likelihood that later memory
> > allocations will cause enough pressure to trigger a kill of one of
> > these apps.
>
> So this opens up bit of LRU management to user space hints. Also because the app
> in itself wont know about the memory situation of the entire system, new system
> call needs to be called from an external process.
>
> >
> >> Swapping out memory into zram wont increase the latency for a hot start ? Or
> >> is it because as it will prevent a fresh cold start which anyway will be slower
> >> than a slow hot start. Just being curious.
> >
> > First, not all swapped pages will be reloaded immediately once an app
> > is resumed. We've found that an app's working set post-process_madvise
> > is significantly smaller than what an app allocates when it first
> > launches (see the delta between pswpin and pswpout in Minchan's
> > results). Presumably because of this, faulting to fetch from zram does
>
> pswpin      417613    1392647     975034     233.00
> pswpout    1274224    2661731    1387507     108.00
>
> IIUC the swap-in ratio is way higher in comparison to that of swap out. Is that
> always the case ? Or it tend to swap out from an active area of the working set
> which faulted back again.
>
> > not seem to introduce a noticeable hot start penalty, not does it
> > cause an increase in performance problems later in the app's
> > lifecycle. I've measured with and without process_madvise, and the
> > differences are within our noise bounds. Second, because we're not
>
> That is assuming that post process_madvise() working set for the application is
> always smaller. There is another challenge. The external process should ideally
> have the knowledge of active areas of the working set for an application in
> question for it to invoke process_madvise() correctly to prevent such scenarios.
>
> > preemptively evicting file pages and only making them more likely to
> > be evicted when there's already memory pressure, we avoid the case
> > where we process_madvise an app then immediately return to the app and
> > reload all file pages in the working set even though there was no
> > intervening memory pressure. Our initial version of this work evicted
>
> That would be the worst case scenario which should be avoided. Memory pressure
> must be a parameter before actually doing the swap out. But pages if know to be
> inactive/cold can be marked high priority to be swapped out.
>
> > file pages preemptively and did cause a noticeable slowdown (~15%) for
> > that case; this patch set avoids that slowdown. Finally, the benefit
> > from avoiding cold starts is huge. The performance improvement from
> > having a hot start instead of a cold start ranges from 3x for very
> > small apps to 50x+ for larger apps like high-fidelity games.
>
> Is there any other real world scenario apart from this app based ecosystem where
> user hinted LRU management might be helpful ? Just being curious. Thanks for the
> detailed explanation. I will continue looking into this series.

Chrome OS is another real world use-case for this user hinted LRU
management approach by proactively reclaiming reclaim from tabs not
accessed by the user for some time.
