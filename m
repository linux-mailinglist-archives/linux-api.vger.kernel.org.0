Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB13DF444
	for <lists+linux-api@lfdr.de>; Tue,  3 Aug 2021 20:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbhHCSBn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Aug 2021 14:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhHCSBl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Aug 2021 14:01:41 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643A9C06175F
        for <linux-api@vger.kernel.org>; Tue,  3 Aug 2021 11:01:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n19so25354086ioz.0
        for <linux-api@vger.kernel.org>; Tue, 03 Aug 2021 11:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XSgoZaAM9VgXcC1Hrs8ckrp1k3/7KUr3SiJsCaEXetc=;
        b=Z4v4AiDHaHTqqraFKHHLdvrPsRbBG9F7ytf00tCteaLiZOuNknNYMPJzznS18Bm+Pr
         460vDxF+9logldqTlDGpzQNbpMC5RqWLbOkmBquRDPqywa1NK9sGFE16blXlA4ZdRZxp
         Uj5ALHXj0kVNy1adYB+GWPYeiIbyRHDMxUGh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XSgoZaAM9VgXcC1Hrs8ckrp1k3/7KUr3SiJsCaEXetc=;
        b=RCPJiok2kqgTze7Xd0PPUEiyerFODBbvuPOO8Pt++DRBzYXL5Zaw6d3u4RCDM1yl+7
         ahWs9LS+Gpn3kXZZPfxm7cWhWkXexR/ExKUnAKDRRQ6K8dtXNdTf41Edl7iSxCNN5DVX
         h5Pwbm03zizrOe7GzCMseLxzRHydaJgV+zoXf52/Ts548tZrFTQbOz0trzhI335so370
         NQniAR+VgvsqIGoKi7RePlg5U5x3Hr+bwTrpkw59ptXWB0rr2ctqvzCdkdSoyIvHA1dV
         5rhM4q+xNMtLzOAMwdJPStbs2N2nflNUBHGwEHDcR4pMiP5rH1rIHa/5KomREDgaPJTC
         qUaQ==
X-Gm-Message-State: AOAM532TG/i1rEfEemw1/mAQZBQROp6BDfg5rc4aWPXMvE9wFgoHeTss
        qFzGvD/rKbmh3EMjtWsVNzv2Ga8Zl96Znw==
X-Google-Smtp-Source: ABdhPJwzs9iiuwDEH/SLsa+w6vPM7/er+ph5KzWikA54cG0DYGtsH97atujmPNKmbIMIctopcJe15w==
X-Received: by 2002:a05:6602:20c9:: with SMTP id 9mr574424ioz.34.1628013689691;
        Tue, 03 Aug 2021 11:01:29 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id w1sm7307756ilv.59.2021.08.03.11.01.27
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 11:01:28 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id n19so25353958ioz.0
        for <linux-api@vger.kernel.org>; Tue, 03 Aug 2021 11:01:27 -0700 (PDT)
X-Received: by 2002:a05:6638:cba:: with SMTP id x26mr16380694jad.98.1628013687178;
 Tue, 03 Aug 2021 11:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <d6668437-5c3b-2dff-bb95-4e3132d13711@redhat.com> <6ff28cfe-1107-347b-0327-ad36e256141b@redhat.com>
 <CAE=gft7567-2Lq7raJKrOpQ8UAvXTFWwPci=_GCRPET3nS=9SA@mail.gmail.com> <20210727141832.86695e7181eb10c6e8fd0191@linux-foundation.org>
In-Reply-To: <20210727141832.86695e7181eb10c6e8fd0191@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 3 Aug 2021 11:00:51 -0700
X-Gmail-Original-Message-ID: <CAE=gft6LmTKx2JHAj7GBmph_1BrioXhmtn_xQEHtRhK+tPa6qw@mail.gmail.com>
Message-ID: <CAE=gft6LmTKx2JHAj7GBmph_1BrioXhmtn_xQEHtRhK+tPa6qw@mail.gmail.com>
Subject: Re: [PATCH v4] mm: Enable suspend-only swap spaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        linux-api@vger.kernel.org, Alex Shi <alexs@kernel.org>,
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

On Tue, Jul 27, 2021 at 2:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 27 Jul 2021 09:31:33 -0700 Evan Green <evgreen@chromium.org> wrote:
>
> > > Pavel just mentioned uswsusp, and I wonder if it would be a possible
> > > alternative to this patch.
> >
> > I think you're right that it would be possible to isolate the
> > hibernate image with uswsusp if you avoid using the SNAPSHOT_*SWAP*
> > ioctls. But I'd expect performance to suffer noticeably, since now
> > every page is making a round trip out to usermode and back. I'd still
> > very much use the HIBERNATE_ONLY flag if it were accepted, I think
> > there's value to it.
>
> The uswsusp option makes your patch a performance optimization rather
> than a feature-add.  And we do like to see quantitative testing results
> when considering a performance optimization.  Especially when the
> performance optimization is a bit icky, putting special-case testing
> all over the place, maintenance cost, additional testing effort, etc.
>
> I do think that diligence demands that we quantify the difference.  Is
> this a thing you can help with?

I'm wrong about the performance. Uswsusp is just as fast, and possibly
faster in my use case than kernel-driven hibernate. What's more,
uswsusp also helps me solve several additional problems I hadn't
tackled yet that were looming in front of me. Thanks all for your
patience and thoughtful review on this.

Patch withdrawn.
-Evan
