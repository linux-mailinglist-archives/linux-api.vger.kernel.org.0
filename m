Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA553AD8E1
	for <lists+linux-api@lfdr.de>; Sat, 19 Jun 2021 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhFSJXE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 19 Jun 2021 05:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbhFSJXD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 19 Jun 2021 05:23:03 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63254C061574
        for <linux-api@vger.kernel.org>; Sat, 19 Jun 2021 02:20:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i17so137185ilj.11
        for <linux-api@vger.kernel.org>; Sat, 19 Jun 2021 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sDVZ3c/xTpZGtI9erkQPxbYx9+iJ9vOpXLUpVMNI/1E=;
        b=iHMdMmyEQsXFGONPsrbXeEqTaxCjYY+Hxsr/rW3fMWm9fmLa0dddqDGpxFSGsyqNGo
         UnnNULKgqQTqPE+3pDD8mO6+L1jPBQ/i8QtZiVGibEXD8enghkDVYBJ9bL/BqIZRE8HJ
         7cf7RYJ4aZFwZ1nUpBIX1ZL6Js4uxBtJAh3AS5xjbOHIZLm8A67mlB6WLRqPW5Z7dcm9
         y8F3Pv1PozB9Q7LktRb/mRluF1Kw5Tl3kP3Lq6jIIFFvIiNT5B7mUqzPokZAqckBTCPL
         wl37rREtww+9/IDpoB/pPty7BOwtLg2IoWaAHdGKgv62c3MSfOGxkbAZ+hEjzeWygxUx
         xGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sDVZ3c/xTpZGtI9erkQPxbYx9+iJ9vOpXLUpVMNI/1E=;
        b=cTxASqK46cQyC7ndDxS7VCPtzaQJrth/+9ZqT+eul9FPD9vHRedthdncqlISA2sshG
         k6EZg2w+0cuFPv7FzmS2D5AIWKlAh7/1itdN9gR0bpF1l3Dvn0el8KWL8iw6o4EX1uZF
         ppmt1H4bgL21vwxONCYkKySZUutletBFY306tN42FU4eI8FJlFkvHk5SSQkBQ42x7m8o
         PbB6NJKJPaX408IVdGEje6Sr12qZIF0vRKhl/2EkjF6HcJFduq/LpWnyrBWjjfJPzA5k
         4y9k/yk7co7WvM9iYQYSzN5JeMm/m3N+OPq7y2NXvzrjVG/Cr5WBB8zAOKSRVt/d8qg0
         SfrA==
X-Gm-Message-State: AOAM531wWBk4gp5ETQD1FYE9N1o1zH49Mb58VfxKMYiNSPSYskfmIE0+
        3e1PwwBxaQkwl4lFTEIrX73mVoWu1lytZJfAOzITtA==
X-Google-Smtp-Source: ABdhPJwC/gS2gEWwdpnbyJ8UJU65AE8I+o9uIFLn0OHwp2dbho65Kx5LceLdZla0C3j9jz2Xmz9m+m6Ai/Rn9FTODU4=
X-Received: by 2002:a05:6e02:10c3:: with SMTP id s3mr10298743ilj.37.1624094451650;
 Sat, 19 Jun 2021 02:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200814213310.42170-1-pcc@google.com> <c2f7efa7-0b52-b92f-79bc-a0cc26b0d92c@nvidia.com>
 <20200818030021.GM17456@casper.infradead.org> <2ce2125f-5424-63d5-16a2-a4e1da76053e@nvidia.com>
In-Reply-To: <2ce2125f-5424-63d5-16a2-a4e1da76053e@nvidia.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Sat, 19 Jun 2021 02:20:40 -0700
Message-ID: <CAMn1gO7ggssTJKdjtfDWsmWDV_ShgQjH+gOx=7H7DmFRQKXupw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: introduce reference pages
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Apologies for the delay in getting back to you; other work ended up
taking priority and now I'm back to looking at this.]

On Tue, Aug 18, 2020 at 11:25 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/17/20 8:00 PM, Matthew Wilcox wrote:
> > On Mon, Aug 17, 2020 at 07:31:39PM -0700, John Hubbard wrote:
> >>>             Real time (s)    Max RSS (KiB)
> >>> anon        2.237081         107088
> >>> memset      2.252241         112180
> >>> refpage     2.243786         107128
> >>>
> >>> We can see that RSS for refpage is almost the same as anon, and real
> >>> time overhead is 44% that of memset.
> >>>
> >>
> >> Are some of the numbers stale, maybe? Try as I might, I cannot combine
> >> anything above to come up with 44%. :)
> >
> > You're not trying hard enough ;-)
> >
> > (2.252241 - 2.237081) / 2.237081 = .00677668801442594166
> > (2.243786 - 2.237081) / 2.237081 = .00299720930981041812
> > .00299720930981041812 / .00677668801442594166 = .44228232189973614648
> >
> > tadaa!
>
> haha, OK then! :) Next time I may try harder, but on the other hand my
> interpretation of the results is still "this is a small effect", even
> if there is a way to make it sound large by comparing the 3rd significant
> digits of the results...
>
> >
> > As I said last time this was posted, I'm just not excited by this.  We go
> > from having a 0.68% time overhead down to an 0.30% overhead, which just
> > doesn't move the needle for me.  Maybe there's a better benchmark than
> > this to show benefits from this patchset.
> >
>

Remember that this is a "realistic" benchmark, so it's doing plenty of
other work besides faulting pages. So I don't think we should expect
to see a massive improvement here.

I ran the pdfium benchmark again but I couldn't see the same
improvements that I got last time. This seems to be because pdfium has
since switched to its own allocator, bypassing the system allocator. I
think the gains should be larger with the memset optimization that
I've implemented, but I'm still in the process of finding a suitable
realistic benchmark that uses the system allocator.

But I would find a 0.4% perf improvement convincing enough,
personally, given that the workload is realistic. Consider a certain
large company which spends $billions annually on data centers. In that
environment a 0.4% performance improvement on realistic workloads can
translate to $millions of savings. And that's not taking into account
the memory savings which are important both in mobile environments and
in data centers.

> Yes, I wonder if there is an artificial workload that just uses refpages
> really extensively, maybe we can get some good solid improvements shown
> with that? Otherwise, it seems like we've just learned that memset is
> actually pretty good in this case. :)

Yes, it's possible to see the performance improvement here more
clearly with a microbenchmark. I've updated the commit message in v4
to include a microbenchmark program and some performance numbers from
it.

Peter
