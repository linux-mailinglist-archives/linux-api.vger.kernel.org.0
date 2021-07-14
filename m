Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA43C7E04
	for <lists+linux-api@lfdr.de>; Wed, 14 Jul 2021 07:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhGNFpB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 01:45:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48642 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237911AbhGNFpB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jul 2021 01:45:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2C8042025A;
        Wed, 14 Jul 2021 05:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626241324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJc53/NgI/MlkbNakLnrrlenQJNQiPmdp8kUnW8IcSg=;
        b=MrQch05yattnZKPVWPPfFWxprgXPmSvsPBIoQZPuD58TLWruhJyiJl0s9rjP5HX6cw0OXc
        tnHGa55wElsvGucb+NjpBt5bdQS0zMsfeeVG8GuXNquiu+r6vfyYfdOG98bVOxZMKwyMt3
        KCn0SQRKom9sow7kWP8mDbfcyRdGTHQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 39CE3A3B81;
        Wed, 14 Jul 2021 05:42:03 +0000 (UTC)
Date:   Wed, 14 Jul 2021 07:41:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-ID: <YO55FCfsjalGicMo@dhcp22.suse.cz>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
 <CAE=gft7Qd3NSnoFYaXv=FkP0=Je85mNOKojuW5rhg6HkS=usLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft7Qd3NSnoFYaXv=FkP0=Je85mNOKojuW5rhg6HkS=usLA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 12-07-21 14:32:05, Evan Green wrote:
> On Mon, Jul 12, 2021 at 12:03 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > [Cc linux-api]
> >
> > On Fri 09-07-21 10:50:48, Evan Green wrote:
> > > Currently it's not possible to enable hibernation without also enabling
> > > generic swap for a given swap area. These two use cases are not the
> > > same. For example there may be users who want to enable hibernation,
> > > but whose drives don't have the write endurance for generic swap
> > > activities.
> > >
> > > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > > generic swapping to it. This region can still be wired up for use in
> > > suspend-to-disk activities, but will never have regular pages swapped to
> > > it.
> >
> > Could you expand some more on why a strict exclusion is really
> > necessary? I do understand that one might not want to have swap storage
> > available all the time but considering that swapon is really a light
> > operation so something like the following should be a reasonable
> > workaround, no?
> >         swapon storage/file
> >         s2disk
> >         swapoff storage
> 
> Broadly, it seemed like a reasonable thing for the kernel to be able
> to do. The workaround you suggest does work for some use cases, but it
> seems like a gap the kernel could more naturally fill.
> 
> Without getting too off into the weeds, there a handful of factors
> that make this change particularly useful to me:
> 
>  * Slicing off part of your SSD to be SLC (single level cell) is
> expensive. From what I understand you gain endurance and speed at the
> cost of 3-4x capacity. In other words for every 1GB of SLC space you
> need for swap, it costs you 3-4GB of storage space out of the primary
> namespace. So I'm incentivized to size this region as small as
> possible. Hibernate's speed/endurance requirements are not quite as
> harsh as regular swap. Steering them separately gives me the ability
> to put the hibernate image in regular storage, and not be forced to
> oversize expensive/fast swap space.

OK, this is likely true but it doesn't really explain/justify a
dedicated swap storage for hibernation.

>  * Even with the workaround, swap can end up in the hibernate region.
> Hibernate starts by allocating its giant 50%-of-memory region, which
> is often the forcing function for pushing things into swap. With the
> workaround, even if my hibernate region is in last priority, there's
> still a reasonable chance I'll end up swapping into it.

Right there is no guarantee but why does that matter at all. From the
kernel point of view it doesn't really makes much difference what was
the source of the swapout.

> If I have
> different security designs for swap space and hibernate, then even a
> chance of some swap leaking into this region is a problem.

Could you expand some more about the this part please?

>  * I also want to limit the online attack surface that swap presents.
> I can make headway here by disallowing open() calls on active swap
> regions (via an LSM), and permanently disabling swapon/swapoff system
> calls after early init. The workaround isn't great for me because I
> want to set everything up at early init time and then not touch it. By
> suspend time, on my system I no longer have the ability to make
> swapon/swapoff calls.

This is clearly a policy call.

All that being said, I am still missing any justification for the
dedicated swap storage. This is an ABI thing so the reasoning should be
really solid.
-- 
Michal Hocko
SUSE Labs
