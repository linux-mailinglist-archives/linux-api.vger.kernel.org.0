Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A351C3D3F0B
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 19:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhGWRC7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 13:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGWRC5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 13:02:57 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A005BC061575
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 10:43:29 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id 185so3473537iou.10
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 10:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m10Puhi8U7Xm+Z+23EuZE31Pfmuoew3URKG5OlVrqjA=;
        b=OyVt8d/ykK/727qMSO7qe3FOozmecngeGg5/kJVSAZEmGR9GutIjhVYvMHftZSeQFX
         XbOmzyO/qwS25YuNggANk3VWTpwL2sD7ndSL+M/l4YUmy/ltGuLHBQac4XHwZQH9/TlD
         QDgqehXJgHLURduXI2BeiRkDCBeevLJTdAoSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m10Puhi8U7Xm+Z+23EuZE31Pfmuoew3URKG5OlVrqjA=;
        b=OnSPf83TlsmkP8QgnIvNanHecrLuSqfRcU9GIC1aRFCjvRBT0Sitw9Pq588XuYPxAO
         B1iY/pLBU7SR68IdWSS91bQpBFTyJhI0a7yfctkKC4QDx08kdUS2sV7LqphyRdzhuP3I
         Zm6+sskiby18bkH2J8SJwmSzo56VQI6eqB+f7fphWHGSyYgQWUQUbu/v2AdPzW2/wshy
         rD8oQNwUG6xjOzEcZ/KCt+1XYwaqCN6mf12jHyED39CF9E0RnMdWGNHwAgZWYjBp9SIa
         WOAIAsLtZW94z52CIzU6QaKVvZWRVdZ/tbTgXtUPZTvYsBAE2C3clDXeWfc7la8x09Cg
         4T8A==
X-Gm-Message-State: AOAM530CzVABR4qF3XYl8Ex23ifwAE0sZtlPX7ElDfNJUTP3Wjrsu1VC
        zd64lTMvhaeVVgAnCUIPcQEt+dBvNCs4Mg==
X-Google-Smtp-Source: ABdhPJw90oKNqMWc7sP+DZMboE6YhxcK9adS6OV5CyMvrqXU7majicL9HetK+6MlDSF2oHxxpG2xmw==
X-Received: by 2002:a5e:9917:: with SMTP id t23mr4928498ioj.158.1627062209033;
        Fri, 23 Jul 2021 10:43:29 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id k10sm18743264ion.38.2021.07.23.10.43.27
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 10:43:28 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id q18so2262497ile.9
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 10:43:27 -0700 (PDT)
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr4246414ilj.308.1627062207416;
 Fri, 23 Jul 2021 10:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <dd405f78-ac37-18d4-23f1-7d43507edee6@redhat.com> <CAE=gft7eY0scobDwQGq-OuFk4Ec2APFQF-4K6UVkTN-TOGwETw@mail.gmail.com>
 <3c46df04-abf4-4bcb-b9cf-430bb1d15b07@redhat.com>
In-Reply-To: <3c46df04-abf4-4bcb-b9cf-430bb1d15b07@redhat.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 23 Jul 2021 10:42:51 -0700
X-Gmail-Original-Message-ID: <CAE=gft4+tw2Lh_aVm1-K0P12Lb5byh4Nv8nGk_qQVQ8MAiTnRw@mail.gmail.com>
Message-ID: <CAE=gft4+tw2Lh_aVm1-K0P12Lb5byh4Nv8nGk_qQVQ8MAiTnRw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Enable suspend-only swap spaces
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jul 22, 2021 at 11:58 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 22.07.21 20:00, Evan Green wrote:
> > On Thu, Jul 22, 2021 at 12:12 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 21.07.21 23:40, Evan Green wrote:
> >>> Currently it's not possible to enable hibernation without also enabling
> >>> generic swap for a given swap area. These two use cases are not the
> >>> same. For example there may be users who want to enable hibernation,
> >>> but whose drives don't have the write endurance for generic swap
> >>> activities. Swap and hibernate also have different security/integrity
> >>> requirements, prompting folks to possibly set up something like block-level
> >>> integrity for swap and image-level integrity for hibernate. Keeping swap
> >>> and hibernate separate in these cases becomes not just a matter of
> >>> preference, but correctness.
> >>>
> >>> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> >>> generic swapping to it. This region can still be wired up for use in
> >>> suspend-to-disk activities, but will never have regular pages swapped to
> >>> it. This flag will be passed in by utilities like swapon(8), usage would
> >>> probably look something like: swapon -o noswap /dev/sda2.
> >>
> >> Just a minor comment, I'd call it rather SWAP_FLAG_HIBERNATE_ONLY and
> >> SWAP_FLAG_HIBERNATE_ONLY -- that calls the child by its name.
> >
> > I went back and forth on this too. It seemed pretty close to toss-up
> > to me. I went with NOSWAP ultimately because it seemed more closely
> > tied to what the flag was actually doing, rather than building in my
> > one expected use case into the name. In some world years from now
> > where either hibernate has diverged, been deleted, or maybe some new
> > usage has been invented for swap space, the NOSWAP name felt like it
> > had a better chance of holding up. The argument is weak though, as
> > these features are pretty well cast in stone, and the likelihood of
> > any of those outcomes seems low. I can change it if you feel strongly,
> > but would probably keep it as-is otherwise.
>
> Just imagine technology Z popping up and using also the swap
> infrastructure. What would be the semantics of NOSWAP? With
> HIBERNATE_ONLY it's clear -- enable that device only for hibernation,
> nothing else.
>
> But you raise a good point: if hibernation isn't even possible in a
> configuration (e.g., not configured into the kernel), we should simply
> reject that flag. So if hibernation would vanish at some point
> completely from the system, it would all be handled accordingly.
>
> That would result in quite a consistent definition of
> SWAP_FLAG_HIBERNATE_ONLY IMHO.
>
> Makes sense?

Ok, I'll change the name, and reject the flag if hibernation is not enabled.

>
> >
> >>
> >> I think some other flags might not apply with that new flag set, right?
> >> For example, does SWAP_FLAG_DISCARD_ONCE or SWP_AREA_DISCARD still have
> >> any meaning with the new flag being set?
> >>
> >> We should most probably disallow enabling any flag that doesn't make any
> >> sense in combination.
> >
> > Good point, I can send a followup patch for that. From my reading
>
> I'd actually enjoy if we'd have that logic in the introducing patch.

Ok.

>
> > SWAP_FLAG_DISCARD and SWAP_FLAG_DISCARD_ONCE are still valid, since
> > the discard can be run at swapon() time. SWAP_FLAG_PREFER (specifying
> > the priority) doesn't make sense, and SWAP_FLAG_DISCARD_PAGES never
> > kicks in because it's called at the cluster level. Hm, that sort of
> > seems like a bug that freed hibernate swap doesn't get discarded. I
> > can disallow it now as unsupported, but might send a patch to fix it
> > later.
>
> Might be worth fixing, indeed.
>
> >
> >>
> >> Apart from that, I'd love to see a comment in here why the workaround
> >> suggested by Michal isn't feasible -- essentially a summary of what we
> >> discussed.
> >
> > Ah sorry, I had tried to clarify that in the commit text, but didn't
> > explicitly address the workaround. To summarize, the workaround keeps
> > generic swap out of your hibernate region... until hibernate time. But
> > once hibernate starts, a lot of swapping tends to happen when the
> > hiber-image is allocated. At this point the hibernate region is
> > eligible for general swap even with the workaround. The reasons I gave
> > for wanting to exclusively steer swap and hibernate are SSD write
> > wearing, different integrity solutions for swap vs hibernate, and our
> > own security changes that no-op out the swapon/swapoff syscalls after
> > init.
> >
>
> That would be nice to have in the patch description :)

Sure, I'll add that as well and send out a v4 shortly.
-Evan
