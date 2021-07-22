Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F093D2BA4
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhGVRVD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jul 2021 13:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhGVRU7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jul 2021 13:20:59 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751B5C061575
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 11:01:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z9so7375285iob.8
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 11:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCe9Px5IbYx9WoehfjTAmfQBvNYKzF4HFGZVPEMv3Dw=;
        b=bTcBVSLQGMhrpoZxQ5uU5iBAxtON1Fb8TJYSzfATlcDOrA52tzAbADe6fEnjQ4M1t4
         vtIxTuWPNU6xUPZTCnBBpPdhpSyNLdQuBeYti8gELBuBnp+9OMVxMLmuCnqpY94Z7hoy
         4wioJg6a8kbT5fXAJhoUuorTKFv2ViM5xfS7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCe9Px5IbYx9WoehfjTAmfQBvNYKzF4HFGZVPEMv3Dw=;
        b=RMRAnHX4wfFf56Zy1St7D3qh/Uppu63dwQ/s3HEK0NM5ElCCdGyHcwBLl6XjzUoXJd
         oRSqPbNk9X3SQ1yeUsatOcROyKEHo685M/XNk62hHpgDezRUZtjw3cqcIeThe/xrAy39
         kYarbG6S4rzXyqUi73ZwnkqnDrNr41Ee7gWn8j7QF8NM6toW+aJDO/65+lne6P5f2tb8
         PHtq5pPKdjk7NLvNzEIrNS2xBFN7wptGLZ92yrGY4OJhYHlOvITwtCsA08nspfecNe+i
         akXTrCBz4FPki64T3Vs51kThRd+YHB1szcSq6NCmsl/XfvR29g9zYmtzuwfy1f9hCpXE
         ckKw==
X-Gm-Message-State: AOAM530doWfU7JAmvGGjxSpBib28sZckubzxha/wdJPvuRQ1iVYApar6
        AGAy+Q4uuFmv9ZgbyGViBlt7wzjfj+rGdg==
X-Google-Smtp-Source: ABdhPJyFvpQS8leFbQiytndME5aRfBFvhPwA4mSw/moskbVLksQM5jcmk8VWqbTh4fIWhAqQJVGuSw==
X-Received: by 2002:a05:6638:144e:: with SMTP id l14mr651573jad.69.1626976893786;
        Thu, 22 Jul 2021 11:01:33 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id e14sm14839688ile.2.2021.07.22.11.01.33
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 11:01:33 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id r16so6159413ilt.11
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 11:01:33 -0700 (PDT)
X-Received: by 2002:a05:6e02:1aa2:: with SMTP id l2mr662668ilv.224.1626976892898;
 Thu, 22 Jul 2021 11:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <dd405f78-ac37-18d4-23f1-7d43507edee6@redhat.com>
In-Reply-To: <dd405f78-ac37-18d4-23f1-7d43507edee6@redhat.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 22 Jul 2021 11:00:56 -0700
X-Gmail-Original-Message-ID: <CAE=gft7eY0scobDwQGq-OuFk4Ec2APFQF-4K6UVkTN-TOGwETw@mail.gmail.com>
Message-ID: <CAE=gft7eY0scobDwQGq-OuFk4Ec2APFQF-4K6UVkTN-TOGwETw@mail.gmail.com>
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

On Thu, Jul 22, 2021 at 12:12 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 21.07.21 23:40, Evan Green wrote:
> > Currently it's not possible to enable hibernation without also enabling
> > generic swap for a given swap area. These two use cases are not the
> > same. For example there may be users who want to enable hibernation,
> > but whose drives don't have the write endurance for generic swap
> > activities. Swap and hibernate also have different security/integrity
> > requirements, prompting folks to possibly set up something like block-level
> > integrity for swap and image-level integrity for hibernate. Keeping swap
> > and hibernate separate in these cases becomes not just a matter of
> > preference, but correctness.
> >
> > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > generic swapping to it. This region can still be wired up for use in
> > suspend-to-disk activities, but will never have regular pages swapped to
> > it. This flag will be passed in by utilities like swapon(8), usage would
> > probably look something like: swapon -o noswap /dev/sda2.
>
> Just a minor comment, I'd call it rather SWAP_FLAG_HIBERNATE_ONLY and
> SWAP_FLAG_HIBERNATE_ONLY -- that calls the child by its name.

I went back and forth on this too. It seemed pretty close to toss-up
to me. I went with NOSWAP ultimately because it seemed more closely
tied to what the flag was actually doing, rather than building in my
one expected use case into the name. In some world years from now
where either hibernate has diverged, been deleted, or maybe some new
usage has been invented for swap space, the NOSWAP name felt like it
had a better chance of holding up. The argument is weak though, as
these features are pretty well cast in stone, and the likelihood of
any of those outcomes seems low. I can change it if you feel strongly,
but would probably keep it as-is otherwise.

>
> I think some other flags might not apply with that new flag set, right?
> For example, does SWAP_FLAG_DISCARD_ONCE or SWP_AREA_DISCARD still have
> any meaning with the new flag being set?
>
> We should most probably disallow enabling any flag that doesn't make any
> sense in combination.

Good point, I can send a followup patch for that. From my reading
SWAP_FLAG_DISCARD and SWAP_FLAG_DISCARD_ONCE are still valid, since
the discard can be run at swapon() time. SWAP_FLAG_PREFER (specifying
the priority) doesn't make sense, and SWAP_FLAG_DISCARD_PAGES never
kicks in because it's called at the cluster level. Hm, that sort of
seems like a bug that freed hibernate swap doesn't get discarded. I
can disallow it now as unsupported, but might send a patch to fix it
later.

>
> Apart from that, I'd love to see a comment in here why the workaround
> suggested by Michal isn't feasible -- essentially a summary of what we
> discussed.

Ah sorry, I had tried to clarify that in the commit text, but didn't
explicitly address the workaround. To summarize, the workaround keeps
generic swap out of your hibernate region... until hibernate time. But
once hibernate starts, a lot of swapping tends to happen when the
hiber-image is allocated. At this point the hibernate region is
eligible for general swap even with the workaround. The reasons I gave
for wanting to exclusively steer swap and hibernate are SSD write
wearing, different integrity solutions for swap vs hibernate, and our
own security changes that no-op out the swapon/swapoff syscalls after
init.

>
> I had a quick glimpse and nothing jumed at me, no mm/swapfile.c expert,
> though :)

Thanks David!
-Evan

>
>
>
> --
> Thanks,
>
> David / dhildenb
>
