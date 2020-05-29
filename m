Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCFD1E71D0
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2020 02:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438167AbgE2Azj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 20:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438212AbgE2Azh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 May 2020 20:55:37 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF5FC08C5C7
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 17:55:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q2so455822ljm.10
        for <linux-api@vger.kernel.org>; Thu, 28 May 2020 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nitingupta.dev; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUE+Kgr61UsTE5bnt2/uDqF89IqriBTI/I4RUKTjWYY=;
        b=dPkfSwSDZ3gLUdiYx2RfPaPXx3H92unDba68v4CdK8Au2YwLggppxIiJ44Uff7amdP
         D7Jm95g3tohD1kWlFJU8ZRKeHr8J2qf5CMv6osN8MyZVBWh9vx5Y9BLyl/L811sRPqa1
         CtcEvczXWzcoE2GO7JxhqtLkkKk1mA0b92UllGcNzvfqtqVbGW1IaCLfbvaorN77x4WI
         YpZ89etJZeJMJLRBbPwgkb7vl9xzPDvby1lMj0L013EgoSRCEJJOzBaVTlRpUDrieoQ9
         RvkGbxg81lNNbGXXwvGZBsy8vA1T4FmVGPyqE5dONSDYmkIquzpcawvMOKix8Mx1sTaY
         owTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUE+Kgr61UsTE5bnt2/uDqF89IqriBTI/I4RUKTjWYY=;
        b=K4J4AjZAmWFxo2g9lhUbGqWjRMyxZl3BPvsPDN47NHO+gMhCQ0vQWNhhBn7n99UBxA
         5DeVizH1/NhdI9XPwmxheFBfk72Pk2LKrkeTzIzE7j0cIuC43/0XHXu2r6z56/LeTFHB
         bRH/NEeMrNtBr0/HHa+tqhWCC5ndNeFZCEnFqK45V+q9JCdO2b8ui0oykHqBBP6VBg29
         nK+nx8aIs+MEsIfQySzZ1BE7joMdvcJsskCPh/xUauV2XdG2M4Cch9l5L65kXAVyMaY+
         BuvCIoRaOLtwIucYJTOOPMWCR0hy6mCsLJzyowOnp2efCw/fmqUQmT3wN5g0hyM59XOx
         0hnA==
X-Gm-Message-State: AOAM533MMChsQ4/h9PnWR9aadh3urcw1NqxZoXAfbjK61YubkKCoBzcf
        I1rXQmrI116QufPwpA86NlRCqBKjQaHoPsqBoxTwvA==
X-Google-Smtp-Source: ABdhPJxqPCwhIDakbWhcF91gfAO4i25wh73Fk87ERST1h2p0yV9LshcCqvGnmgNoTXIWFYZJaNqWTaoin0QuSKcPZyo=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr2714185ljj.189.1590713733999;
 Thu, 28 May 2020 17:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200518181446.25759-1-nigupta@nvidia.com> <a83a4df1dc2ed76aa497be3454c67ee4437d2883.camel@oracle.com>
In-Reply-To: <a83a4df1dc2ed76aa497be3454c67ee4437d2883.camel@oracle.com>
From:   Nitin Gupta <ngupta@nitingupta.dev>
Date:   Thu, 28 May 2020 17:55:22 -0700
Message-ID: <CAB6CXpDjOFP-GCRk6ukU4SbeutfeBaTV6nH=JA-nTkKifSNQzA@mail.gmail.com>
Subject: Re: [PATCH v5] mm: Proactive compaction
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Nitin Gupta <nigupta@nvidia.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 28, 2020 at 4:32 PM Khalid Aziz <khalid.aziz@oracle.com> wrote:
>
> This looks good to me. I like the idea overall of controlling
> aggressiveness of compaction with a single tunable for the whole
> system. I wonder how an end user could arrive at what a reasonable
> value would be for this based upon their workload. More comments below.
>

Tunables like the one this patch introduces, and similar ones like 'swappiness'
will always require some experimentations from the user.


> On Mon, 2020-05-18 at 11:14 -0700, Nitin Gupta wrote:
> > For some applications, we need to allocate almost all memory as
> > hugepages. However, on a running system, higher-order allocations can
> > fail if the memory is fragmented. Linux kernel currently does on-
> > demand
> > compaction as we request more hugepages, but this style of compaction
> > incurs very high latency. Experiments with one-time full memory
> > compaction (followed by hugepage allocations) show that kernel is
> > able
> > to restore a highly fragmented memory state to a fairly compacted
> > memory
> > state within <1 sec for a 32G system. Such data suggests that a more
> > proactive compaction can help us allocate a large fraction of memory
> > as
> > hugepages keeping allocation latencies low.
> >
> > For a more proactive compaction, the approach taken here is to define
> > a new tunable called 'proactiveness' which dictates bounds for
> > external
> > fragmentation wrt HUGETLB_PAGE_ORDER order which kcompactd tries to
> > maintain.
> >
> > The tunable is exposed through sysctl:
> >   /proc/sys/vm/compaction_proactiveness
> >
> > It takes value in range [0, 100], with a default of 20.
>
> Looking at the code, setting this to 100 would mean system would
> continuously strive to drive level of fragmentation down to 0 which can
> not be reasonable and would bog the system down. A cap lower than 100
> might be a good idea to keep kcompactd from dragging system down.
>

Yes, I understand that a value of 100 would be a continuous compaction
storm but I still don't want to artificially cap the tunable. The interpretation
of this tunable can change in future, and a range of [0, 100] seems
more intuitive than, say [0, 90]. Still, I think a word of caution should
be added to its documentation (admin-guide/sysctl/vm.rst).


> >

> > Total 2M hugepages allocated = 383859 (749G worth of hugepages out of
> > 762G total free => 98% of free memory could be allocated as
> > hugepages)
> >
> > - With 5.6.0-rc3 + this patch, with proactiveness=20
> >
> > echo 20 | sudo tee /sys/kernel/mm/compaction/node-*/proactiveness
>
> Should be "echo 20 | sudo tee /proc/sys/vm/compaction_proactiveness"
>

oops... I forgot to update the patch description. This is from the v4 patch
which used sysfs but v5 switched to using sysctl.


> >

> > diff --git a/Documentation/admin-guide/sysctl/vm.rst
> > b/Documentation/admin-guide/sysctl/vm.rst
> > index 0329a4d3fa9e..e5d88cabe980 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -119,6 +119,19 @@ all zones are compacted such that free memory is
> > available in contiguous
> >  blocks where possible. This can be important for example in the
> > allocation of
> >  huge pages although processes will also directly compact memory as
> > required.
> >
> > +compaction_proactiveness
> > +========================
> > +
> > +This tunable takes a value in the range [0, 100] with a default
> > value of
> > +20. This tunable determines how aggressively compaction is done in
> > the
> > +background. Setting it to 0 disables proactive compaction.
> > +
> > +Note that compaction has a non-trivial system-wide impact as pages
> > +belonging to different processes are moved around, which could also
> > lead
> > +to latency spikes in unsuspecting applications. The kernel employs
> > +various heuristics to avoid wasting CPU cycles if it detects that
> > +proactive compaction is not being effective.
> > +
>
> Value of 100 would cause kcompactd to try to bring fragmentation down
> to 0. If hugepages are being consumed and released continuously by the
> workload, it is possible that kcompactd keeps making progress (and
> hence passes the test "proactive_defer = score < prev_score ?")
> continuously but can not reach a fragmentation score of 0 and hence
> gets stuck in compact_zone() for a long time. Page migration for
> compaction is not inexpensive. Maybe either cap the value to something
> less than 100 or set a floor for wmark_low above 0.
>
> Some more guidance regarding the value for this tunable might be
> helpful here, something along the lines of what does a value of 100
> mean in terms of how kcompactd will behave. It can then give end user a
> better idea of what they are getting at what cost. You touch upon the
> cost above. Just add some more details so an end user can get a better
> idea of size of the cost for higher values of this tunable.
>

I like the idea of capping wmark_low to say, 5 to prevent admins from
overloading the system. Similarly, wmark_high should be capped at
say, 95 to allow tunable values below 10 to have any effect: currently
such low tunable values would give wmark_high=100 which would
cause proactive compaction to never get triggered.

Finally, I see your concern about lack of guidance on extreme values
of the tunable. I will address this in the next (v6) iteration.

Thanks,
Nitin
