Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18033C9402
	for <lists+linux-api@lfdr.de>; Thu, 15 Jul 2021 00:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhGNWud (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 18:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhGNWub (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jul 2021 18:50:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76947C06175F
        for <linux-api@vger.kernel.org>; Wed, 14 Jul 2021 15:47:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s18so4042671pgq.3
        for <linux-api@vger.kernel.org>; Wed, 14 Jul 2021 15:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R4folDUDICkUURmaxRdd97kJ1DDYqeb4hdwNbT+pwyY=;
        b=c+/78aYldlz56IMFQTUGpvtOXrSnRqfxRP0K69s+NUewdaICOTLcGuSFhnKZO3Vwni
         FijSkmYS82HMZLcPRGgiFL2lEIeh//BeVwGuAdYDy+c79cY5Jo34eMPHQuZ9jdp5kbb3
         Zjl3GPk5Ets/VJQJmE/ZSqd03xVhXNILf5Gaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R4folDUDICkUURmaxRdd97kJ1DDYqeb4hdwNbT+pwyY=;
        b=KS6mfyDt4WpoQn2WZIt+cNr9pRyC5yl2UU/3kGTiix/hl/f3LM6QOl8q/+P6fywNFH
         ux/DMJwZrFmWkNeGGyNa/Wfjmiu1mK3CEBGQtxsc7Wp94exnu2KQLrr+GwMhfAaCwmEq
         pu8w1l2W2DtzdgJpI4oP2EMfGmiSUgT+UQCFgQ9iK2QxWvbY8Y52/p/eSXoBJWndkdf9
         rt7T+uC3K237Wgfrm2DRkjd6/gdFAx9GD8uvu3VDrpXjvvOXu6fSPPY8SMDSC1y5DXLe
         jilbS5HCwrmJNGPjBamfUQ6dWk30vtbnoC16a+7eJtvjbKI+XOwxTdyHcX0IS8MhZjIf
         nfEA==
X-Gm-Message-State: AOAM530npAjfFMnDGKIMnNQqkdsT7duzk/5r1uVGNflPKu+c6R724nV8
        L5nKGKO9wvdKJyVygekv7tBVi5c5K3xZJg==
X-Google-Smtp-Source: ABdhPJxY64YbxX4zP9FtJGiWE0MGipkn4B5svg38HgA6O5AwUMN1xQNDF0s8SaIi0pIE4JJzy+jsTg==
X-Received: by 2002:a65:6497:: with SMTP id e23mr352867pgv.43.1626302857698;
        Wed, 14 Jul 2021 15:47:37 -0700 (PDT)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com. [209.85.215.181])
        by smtp.gmail.com with ESMTPSA id 1sm4119091pfv.138.2021.07.14.15.47.37
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 15:47:37 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id w15so3997967pgk.13
        for <linux-api@vger.kernel.org>; Wed, 14 Jul 2021 15:47:37 -0700 (PDT)
X-Received: by 2002:a6b:7719:: with SMTP id n25mr313562iom.37.1626302401031;
 Wed, 14 Jul 2021 15:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz> <CAE=gft7Qd3NSnoFYaXv=FkP0=Je85mNOKojuW5rhg6HkS=usLA@mail.gmail.com>
 <YO55FCfsjalGicMo@dhcp22.suse.cz>
In-Reply-To: <YO55FCfsjalGicMo@dhcp22.suse.cz>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 14 Jul 2021 15:39:25 -0700
X-Gmail-Original-Message-ID: <CAE=gft5L062V_xE+Nj5UqNrjK9ET6PPtekJpnurzPGobWjpeUQ@mail.gmail.com>
Message-ID: <CAE=gft5L062V_xE+Nj5UqNrjK9ET6PPtekJpnurzPGobWjpeUQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Michal Hocko <mhocko@suse.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jul 13, 2021 at 10:42 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 12-07-21 14:32:05, Evan Green wrote:
> > On Mon, Jul 12, 2021 at 12:03 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > [Cc linux-api]
> > >
> > > On Fri 09-07-21 10:50:48, Evan Green wrote:
> > > > Currently it's not possible to enable hibernation without also enabling
> > > > generic swap for a given swap area. These two use cases are not the
> > > > same. For example there may be users who want to enable hibernation,
> > > > but whose drives don't have the write endurance for generic swap
> > > > activities.
> > > >
> > > > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > > > generic swapping to it. This region can still be wired up for use in
> > > > suspend-to-disk activities, but will never have regular pages swapped to
> > > > it.
> > >
> > > Could you expand some more on why a strict exclusion is really
> > > necessary? I do understand that one might not want to have swap storage
> > > available all the time but considering that swapon is really a light
> > > operation so something like the following should be a reasonable
> > > workaround, no?
> > >         swapon storage/file
> > >         s2disk
> > >         swapoff storage
> >
> > Broadly, it seemed like a reasonable thing for the kernel to be able
> > to do. The workaround you suggest does work for some use cases, but it
> > seems like a gap the kernel could more naturally fill.
> >
> > Without getting too off into the weeds, there a handful of factors
> > that make this change particularly useful to me:
> >
> >  * Slicing off part of your SSD to be SLC (single level cell) is
> > expensive. From what I understand you gain endurance and speed at the
> > cost of 3-4x capacity. In other words for every 1GB of SLC space you
> > need for swap, it costs you 3-4GB of storage space out of the primary
> > namespace. So I'm incentivized to size this region as small as
> > possible. Hibernate's speed/endurance requirements are not quite as
> > harsh as regular swap. Steering them separately gives me the ability
> > to put the hibernate image in regular storage, and not be forced to
> > oversize expensive/fast swap space.
>
> OK, this is likely true but it doesn't really explain/justify a
> dedicated swap storage for hibernation.

Wait, yes it does. Hibernation has less stringent write endurance and
speed requirements than swap, so it makes sense to point it at storage
that doesn't pay the 3x capacity penalty, and save the fancy fast
stuff for swap. The exclusivity makes sense since you're trying not to
wear out your higher capacity storage with unnecessary writes. I'd
argue the API addition is worth it for this reason by itself. Usermode
has valid reasons for wanting to disentangle these.

>
> >  * Even with the workaround, swap can end up in the hibernate region.
> > Hibernate starts by allocating its giant 50%-of-memory region, which
> > is often the forcing function for pushing things into swap. With the
> > workaround, even if my hibernate region is in last priority, there's
> > still a reasonable chance I'll end up swapping into it.
>
> Right there is no guarantee but why does that matter at all. From the
> kernel point of view it doesn't really makes much difference what was
> the source of the swapout.
>
> > If I have
> > different security designs for swap space and hibernate, then even a
> > chance of some swap leaking into this region is a problem.
>
> Could you expand some more about the this part please?

Offline attacks (ie manipulating storage from underneath the machine)
are a major concern when enabling both swap and hibernate. But the
approach of adding integrity to mitigate offline attacks may differ
between swap and hibernate in the interest of performance. Swap for
instance essentially needs a per-page dictionary of hashes for
integrity, since pages can be added and removed arbitrarily. Hibernate
however just needs a single hash across the entire image to provide
integrity. If you have swap leaking onto a region where you don't have
integrity enabled (because say you handled integrity at the image
level for hibernate, and at the block layer for swap), your swap
integrity story is compromised.

There's a (likely defunct) series from Matthew Garrett that expounds a
bit on some of this, though it's also partially tangential:
https://lore.kernel.org/lkml/20210220013255.1083202-1-matthewgarrett@google.com/

>
> >  * I also want to limit the online attack surface that swap presents.
> > I can make headway here by disallowing open() calls on active swap
> > regions (via an LSM), and permanently disabling swapon/swapoff system
> > calls after early init. The workaround isn't great for me because I
> > want to set everything up at early init time and then not touch it. By
> > suspend time, on my system I no longer have the ability to make
> > swapon/swapoff calls.
>
> This is clearly a policy call.

The goal was to show examples of why the workaround was insufficient.
Yes, the response to any particular example could be "just don't
choose to do that", but I'm hoping to show examples from several
different angles of how the flag is a valuable knob for usermode to
have.

>
> All that being said, I am still missing any justification for the
> dedicated swap storage. This is an ABI thing so the reasoning should be
> really solid.

I'm hoping it is. I sympathize with the awkwardness of "swapon, but
don't swap!". But from what I can there is no other route that
wouldn't be hugely disruptive and risk breaking compatibility for
folks who want to continue to combine their hibernate and swap
regions.

I don't think this digs the design hole deeper. Yes, the ship on this
design has long ago sailed. But if we ever did try to dig ourselves
out of the swap/hibernate hole by providing new APIs to handle them
separately, this flag would serve as a good cutover to divert out of
the swap code and into the new shiny hibernate-only code. The APIs are
never going to be totally disentangled, so a clean cutover opportunity
is the best one can hope for.

-Evan
