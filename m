Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46A02E17FD
	for <lists+linux-api@lfdr.de>; Wed, 23 Dec 2020 05:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgLWEKJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Dec 2020 23:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLWEKJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Dec 2020 23:10:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12FBC0613D3
        for <linux-api@vger.kernel.org>; Tue, 22 Dec 2020 20:09:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e25so4964095wme.0
        for <linux-api@vger.kernel.org>; Tue, 22 Dec 2020 20:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEKgkwouOKYZHcH4n91a1kSOJQB4OjAj1Ym6t3oLUZg=;
        b=GCyHsTtMvVF+o0PPsA9JOPc3Tnap8ECvAQEXYjF1qfaHhpND1UDgZGZY54wH3DSJF9
         rWvR5SZg28KD8mt7NHlrhrqiRwCvOF3vWW3jo7RjGssZseK0AouuXu6+RVP4L+SuYKWZ
         VwOonhik47uTNWOY9g5gfYlYGlbWKunaKQHPKC8Mbv3JpuHIIoBpZaDwBxYYOhsXhDOI
         zlFxpJ9p1pcGczqiEmYv+1EceIPb+YuY3YEuoUjdlZ9/elsrOxTQP+PPC9m+ha1ARkki
         tFNJQvtfsq6BAF6GjPP59m139vYLQMPjbS0zyg2Hqp3AV7VEglVdijZYENSyzPnMzQvn
         GO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEKgkwouOKYZHcH4n91a1kSOJQB4OjAj1Ym6t3oLUZg=;
        b=AWQ7u9Vo9TrN2wOKBFoBBfIqn6v74R7juNV4Wo5gA7Vel42IbHJWk9+EudUrnXjj+S
         IOKBI6KO17Kq6THyWGtFJ1wPy5kOZD7EOV1TFTVMI/yAB8LbYtgGIz5YuJD/78zcsw6J
         o9HG65/VxUl0FsdRr6uPIXLeVh1+hJ2l5QpW0VYArwmeH1kAkyAPNpYvnoZiCl5OHrrl
         ME6gwz+y4S6NZgg1P6HZBowJCyFqKKVeDrnBnzI4mlbWpjSJ4x7oHfJBCjC4Sk22OVfQ
         R0EqxuPeW0aREzvI2uNi8evi7s0XhpGZRd/NWK9lnljYpyCMwCkVBq6vGuCB9a3vq8Kk
         Jreg==
X-Gm-Message-State: AOAM531284rjKmMnzDcAMuUREdGTFIWJbDh6y6y1RAOtIzy1eA+WOafD
        m623VhSR/+bRz99M5kLxXIv7epa8vwHDDhkdpfoBdw==
X-Google-Smtp-Source: ABdhPJxPVdCgx7+QCZCFCNYd3eHZZxJkjYTnkoaSbYlibmLYDpD+CjFqTDwkRlBahO8dCv8H6X9PKIFxzwatSmNQQEk=
X-Received: by 2002:a1c:bc57:: with SMTP id m84mr24633253wmf.163.1608696567336;
 Tue, 22 Dec 2020 20:09:27 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com> <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
 <20201222134438.GA7170@infradead.org> <CAJuCfpGiVS69kznSrAdosxnRd-zgXPJd8MXou=gd8K8j7xLMjA@mail.gmail.com>
In-Reply-To: <CAJuCfpGiVS69kznSrAdosxnRd-zgXPJd8MXou=gd8K8j7xLMjA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Dec 2020 20:09:16 -0800
Message-ID: <CAJuCfpEpmSxmq+wBa5ZTa22TmA9ew3ueJmavrX=DujMVHLLADw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 22, 2020 at 9:48 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Tue, Dec 22, 2020 at 5:44 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Fri, Dec 11, 2020 at 09:27:46PM +0100, Jann Horn wrote:
> > > > Can we just use one element in iovec to indicate entire address rather
> > > > than using up the reserved flags?
> > > >
> > > >         struct iovec {
> > > >                 .iov_base = NULL,
> > > >                 .iov_len = (~(size_t)0),
> > > >         };
> > >
> > > In addition to Suren's objections, I think it's also worth considering
> > > how this looks in terms of compat API. If a compat process does
> > > process_madvise() on another compat process, it would be specifying
> > > the maximum 32-bit number, rather than the maximum 64-bit number, so
> > > you'd need special code to catch that case, which would be ugly.
> > >
> > > And when a compat process uses this API on a non-compat process, it
> > > semantically gets really weird: The actual address range covered would
> > > be larger than the address range specified.
> > >
> > > And if we want different access checks for the two flavors in the
> > > future, gating that different behavior on special values in the iovec
> > > would feel too magical to me.
> > >
> > > And the length value SIZE_MAX doesn't really make sense anyway because
> > > the length of the whole address space would be SIZE_MAX+1, which you
> > > can't express.
> > >
> > > So I'm in favor of a new flag, and strongly against using SIZE_MAX as
> > > a magic number here.
> >
> > Yes, using SIZE_MAX is a horrible interface in this case.  I'm not
> > a huge fan of a flag either.  What is the use case for the madvise
> > to all of a processes address space anyway?
>
> Thanks for the feedback! The use case is userspace memory reaping
> similar to oom-reaper. Detailed justification is here:
> https://lore.kernel.org/linux-mm/20201124053943.1684874-1-surenb@google.com

Actually this post in the most informative and includes test results:
https://lore.kernel.org/linux-api/CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com/
