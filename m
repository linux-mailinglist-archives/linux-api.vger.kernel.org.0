Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392233D2AFA
	for <lists+linux-api@lfdr.de>; Thu, 22 Jul 2021 19:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGVQgX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Jul 2021 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhGVQgW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Jul 2021 12:36:22 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AE4C061575
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 10:16:57 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z1so6116875ils.0
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEFq+AoRTm11R6uCVQcmvnevcQX1q6Q/z0Ka5ymSSsI=;
        b=PxC+1qAM+LiGC9/AqtUM9wFshgBXJ7k34p5t9jtIY6MU7Gz56O3Ews8ITNFwZPwuQV
         rrymVFx3fLPqJ9YttbM1AavDvQ7ibkE1EBE2qOUR5iw+Tzgej9OhLlDrjVEiTGU7BswJ
         ic45iKRQyyPrQ0+6VsrwaCgcGigcAf1WMlm3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEFq+AoRTm11R6uCVQcmvnevcQX1q6Q/z0Ka5ymSSsI=;
        b=FjRaf0COS/sUGP4PCyl41gyqWCPzqsSpXqb/7DMF92OPI7Mfa/zQ0+I6/7jeWtTANV
         8dxplX1hFHxNLKYxreKy7mJ4cGtWQBZYnPBRaKfSyiE1looNrZhr81Q6o686UyHfHB+a
         yzzd6bo2VrzyrqGeyQyK3ya+GF+oASfT6cmo/lpyT7X5Ob4QaFowZH46L87bG7uiM46j
         1sRiaelNMc8xxtCSGd6UO2iAYHSEkax07IdhTcloYvQ6PrNEsTGp1zAyulF3UHiqSGlG
         9GFE3ASOdyeCF+1rNDYFD0QaL/SGojWgbt3ygQQV4GHi43vo1W0GkenqUMrNNktMLCLg
         wnYw==
X-Gm-Message-State: AOAM530CQGgOdD7EYHOeH78nYAaR39OyrVXJ3Gc0y066lNrjNQ8djWUe
        SEZN73LIslYgLVHzB6UP4Y4FhGAY0iSrVg==
X-Google-Smtp-Source: ABdhPJypfN0nHdSPkrumInoAm3VGNtWPxLc3vvwpkZzd2PR4akdi7HCFgffYidREl2dPuJq/pprZlA==
X-Received: by 2002:a05:6e02:84:: with SMTP id l4mr595977ilm.66.1626974216914;
        Thu, 22 Jul 2021 10:16:56 -0700 (PDT)
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com. [209.85.166.46])
        by smtp.gmail.com with ESMTPSA id a9sm10972101ila.23.2021.07.22.10.16.55
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 10:16:55 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id k16so7196102ios.10
        for <linux-api@vger.kernel.org>; Thu, 22 Jul 2021 10:16:55 -0700 (PDT)
X-Received: by 2002:a02:6d5d:: with SMTP id e29mr526246jaf.44.1626974215148;
 Thu, 22 Jul 2021 10:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <20210721150926.ce56fb8b5fa733d9727bd37e@linux-foundation.org>
In-Reply-To: <20210721150926.ce56fb8b5fa733d9727bd37e@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 22 Jul 2021 10:16:19 -0700
X-Gmail-Original-Message-ID: <CAE=gft783EmL=vZuLC6Zr-hW08ij-Xn=n_6Vt2RX_HX0r-K6Uw@mail.gmail.com>
Message-ID: <CAE=gft783EmL=vZuLC6Zr-hW08ij-Xn=n_6Vt2RX_HX0r-K6Uw@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Enable suspend-only swap spaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Alex Shi <alexs@kernel.org>,
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

On Wed, Jul 21, 2021 at 3:09 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Jul 2021 14:40:28 -0700 Evan Green <evgreen@chromium.org> wrote:
>
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
> Will patches to swapon and its manpage be prepared?

Yes, I'll work on that today. Thanks Andrew!
-Evan
