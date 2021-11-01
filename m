Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AE944213B
	for <lists+linux-api@lfdr.de>; Mon,  1 Nov 2021 21:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhKAUCk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Nov 2021 16:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAUCj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Nov 2021 16:02:39 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6152BC061714
        for <linux-api@vger.kernel.org>; Mon,  1 Nov 2021 13:00:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s3so14081543ybs.9
        for <linux-api@vger.kernel.org>; Mon, 01 Nov 2021 13:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIiikhiKANm16gJ3zgFho5/Ja/cA/584/loqdnT20mg=;
        b=mLGfJvKpxQcN5+1bgKSbhr3CHnyK9Dv9MIU6eTvJOMcjxJ6TtQmw1KCpU9NLyLAZVu
         oM8SJNjWglOkujwTODQqHVHHRuQZG8YysvfDKgOm+QZGhOxwvUk5l5cUqnLp6+oDBnVv
         c5fqH52azYDTueOFKLAoi3HKoVJ/52QBi5Zm8IeJzBzlVA7pcb6yKvmNn1Bs7Qy0ZeFL
         sfOq9v28z0b4N91opwk1CbmLK+heKbmf161m/HU62X+PKykdp+KU0uKwPAiv3I8xAtko
         jKAXX/YYMRnNzKgzSW7c83HnxxqAMeXjYff/YxfAdcwjFNJ0aGXYfV1Hw153/RjQSTzA
         MItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIiikhiKANm16gJ3zgFho5/Ja/cA/584/loqdnT20mg=;
        b=X7iaiUbpgZI8lcq64MJcIqaWEGPJp9PM5uLd0AmFJNzu35bqyMtHr3zZsxSnxPLgvp
         ph0zZ9pRHyleQEUfAdO1aCDCtBMmUzVVc9+XAoKoLPTgBvfIixZneslL+LhCH2gxHcY5
         Kt+F6K7imJVIXErAGztBvil735V61jwz49m8zRCuhDpW9KljFob7kDvg3JYm3D9oq8rG
         RtHve1bga6ZeCWS1BXjXa22tNwYftYxGTMpgMgTpfijtwVypv82s+23WV3bF+WmV5Wwl
         TobV5YK66HP/3CkmtTHYuKOIDJHdM+YCZA6VaSr4lkFCzmxtedkUsGi5+FuXliuBxcwX
         h74w==
X-Gm-Message-State: AOAM532JsZMh2z512NJPhrK5kcnClzmZMFttObA2RL6AYMfoLonAwjaw
        oBy+xn6jQeZLNF6rjlAUTeDoyR5O+f6p811UYmPfyw==
X-Google-Smtp-Source: ABdhPJy9YUocfasSw70FNO/svv5wulusp1+kDqDhT223oXWC6yRkNWKoM+3TyDkuuF9r8ipCnxwJivDO8jiIMO0U7kg=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr39312732ybu.161.1635796804356;
 Mon, 01 Nov 2021 13:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz> <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz> <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
In-Reply-To: <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 1 Nov 2021 12:59:53 -0700
Message-ID: <CAJuCfpGgi49C6fT7D8yV7evmzFVqZS2qvSQRHZkvNruc43ZmFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 1, 2021 at 8:44 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Nov 1, 2021 at 1:37 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 29-10-21 09:07:39, Suren Baghdasaryan wrote:
> > > On Fri, Oct 29, 2021 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > Well, I still do not see why that is a problem. This syscall is meant to
> > > > release the address space not to do it fast.
> > >
> > > It's the same problem for a userspace memory reaper as for the
> > > oom-reaper. The goal is to release the memory of the victim and to
> > > quickly move on to the next one if needed.
> >
> > The purpose of the oom_reaper is to _guarantee_ a forward progress. It
> > doesn't have to be quick or optimized for speed.
>
> Fair enough. Then the same guarantees should apply to userspace memory
> reapers. I think you clarified that well in your replies in
> https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz:
>
> Because there is no _guarantee_ that the final __mmput will release
> the memory in finite time. And we cannot guarantee that longterm.
> ...
> __mmput calls into exit_aio and that can wait for completion and there
> is no way to guarantee this will finish in finite time.
>
> >
> > [...]
> >
> > > > Btw. the above code will not really tell you much on a larger machine
> > > > unless you manage to trigger mmap_sem contection. Otherwise you are
> > > > measuring the mmap_sem writelock fast path and that should be really
> > > > within a noise comparing to the whole address space destruction time. If
> > > > that is not the case then we have a real problem with the locking...
> > >
> > > My understanding of that discussion is that the concern was that even
> > > taking uncontended mmap_sem writelock would regress the exit path.
> > > That was what I wanted to confirm. Am I misreading it?
> >
> > No, your reading match my recollection. I just think that code
> > robustness in exchange of a rw semaphore write lock fast path is a
> > reasonable price to pay even if that has some effect on micro
> > benchmarks.
>
> I'm with you on this one, that's why I wanted to measure the price we
> would pay. Below are the test results:
>
> Test: https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/
> Compiled: gcc -O2 -static test.c -o test
> Test machine: 128 core / 256 thread 2x AMD EPYC 7B12 64-Core Processor
> (family 17h)
>
> baseline (Linus master, f31531e55495ca3746fb895ffdf73586be8259fa)
> p50 (median)   87412
> p95                  168210
> p99                  190058
> average           97843.8
> stdev               29.85%
>
> unconditional mmap_write_lock in exit_mmap (last column is the change
> from the baseline)
> p50 (median)   88312     +1.03%
> p95                  170797   +1.54%
> p99                  191813   +0.92%
> average           97659.5  -0.19%
> stdev               32.41%
>
> unconditional mmap_write_lock in exit_mmap + Matthew's patch (last
> column is the change from the baseline)
> p50 (median)   88807      +1.60%
> p95                  167783     -0.25%
> p99                  187853     -1.16%
> average           97491.4    -0.36%
> stdev               30.61%
>
> stdev is quite high in all cases, so the test is very noisy.

Need to clarify that what I called here "stdev" is actually stdev /
average in %.

> The impact seems quite low IMHO. WDYT?
>
> > --
> > Michal Hocko
> > SUSE Labs
