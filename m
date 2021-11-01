Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC5441D8E
	for <lists+linux-api@lfdr.de>; Mon,  1 Nov 2021 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhKAPru (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Nov 2021 11:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhKAPru (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Nov 2021 11:47:50 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40FBC061766
        for <linux-api@vger.kernel.org>; Mon,  1 Nov 2021 08:45:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 131so34101150ybc.7
        for <linux-api@vger.kernel.org>; Mon, 01 Nov 2021 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZolZYi1Z2qAq+BdRoisdf3B03ivIqQVmB8Zw09nzu/A=;
        b=QO56lhV56aUSXb5cp5vwYlnjJuQqx0rZxic/SzMXvbF1nWztHVKxodvJXVy1AoROHk
         Cl3ep7m2UwaJ39Y/IGbfUJ2gor11hX8Ilimaw+ly07DUufwbpsjfOE0K9eD+wGMUU7mJ
         BXfB52ihVoEKPyX8MuJrHcP6tdepZkqFE9yQY9WAY8t3j5oRhJCWfRVxFF0qRVAAe9gI
         c/2ht1FMS+3Be+6eun16zvnn5nBp50PwzTMkvfs1yOGGs2QbT9tegBC/KR/rmLis0XMI
         NJHEuMO9SSgfacSyYAz860rC+vlmp/hG4MkOXligVzYPPz6yYxIarv9WgjmZf52HqW/W
         zLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZolZYi1Z2qAq+BdRoisdf3B03ivIqQVmB8Zw09nzu/A=;
        b=mf4jrVC0Y3aEQTZ+4fHZGnfvrd2wbC5zFxQ9Ddm3qSqOfBETmX3VhhilKtoGcivosG
         KFCDYN3lFgNGUpgrnmdWROuT2zwzgOLJGM9nYGMrKIYnJP9VqSm/9YJWtu7mWuOcDN3d
         yYXEnWZ4/a/UO2A5e276MF3roOWxy3vP+NL8bIQoxmcJ24Hx3hhiDlDSj2uAEhCBZ6J7
         anDtRAUv/c3VLlKYAFls/B7NOxSecDQBInCsXO78LvRIga3Oaha0CDMV26TGuS/3s5ei
         2gKTiKMSLHZBYWPK2m609rBLPUCEdi7+ivuwl9q3DnRyXGm2KIydFrsvyztRx8a6IU/b
         TOoQ==
X-Gm-Message-State: AOAM530Gh2H9k1gxfNOvsmoeCw2Mg0CgR76ZItFVdM70vd0VhjwysrMy
        Y67DZLGgMy5xnLAwdIj3X7b5BW+tDj8u9Df3OYV/qw==
X-Google-Smtp-Source: ABdhPJy7Y2xviMqGlKunRSE1bYGIzhMjrRr9qPYvk8vGlzZTFvMRzKzHep+EnxjFd74GwRZBeyfOPrds+hz4ErGZTUE=
X-Received: by 2002:a25:ae12:: with SMTP id a18mr10895832ybj.412.1635781510066;
 Mon, 01 Nov 2021 08:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXvxBSzA2YIxbwVC@dhcp22.suse.cz> <CAJuCfpHBoMGPOUvB2ZWQ=TxbFuWBRF++UaKJZDCrQV4mzb5kMA@mail.gmail.com>
 <YX+nYGlZBOAljoeF@dhcp22.suse.cz>
In-Reply-To: <YX+nYGlZBOAljoeF@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 1 Nov 2021 08:44:58 -0700
Message-ID: <CAJuCfpGC9-c9P40x7oy=jy5SphMcd0o0G_6U1-+JAziGKG6dGA@mail.gmail.com>
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

On Mon, Nov 1, 2021 at 1:37 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 29-10-21 09:07:39, Suren Baghdasaryan wrote:
> > On Fri, Oct 29, 2021 at 6:03 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Well, I still do not see why that is a problem. This syscall is meant to
> > > release the address space not to do it fast.
> >
> > It's the same problem for a userspace memory reaper as for the
> > oom-reaper. The goal is to release the memory of the victim and to
> > quickly move on to the next one if needed.
>
> The purpose of the oom_reaper is to _guarantee_ a forward progress. It
> doesn't have to be quick or optimized for speed.

Fair enough. Then the same guarantees should apply to userspace memory
reapers. I think you clarified that well in your replies in
https://lore.kernel.org/all/20170725154514.GN26723@dhcp22.suse.cz:

Because there is no _guarantee_ that the final __mmput will release
the memory in finite time. And we cannot guarantee that longterm.
...
__mmput calls into exit_aio and that can wait for completion and there
is no way to guarantee this will finish in finite time.

>
> [...]
>
> > > Btw. the above code will not really tell you much on a larger machine
> > > unless you manage to trigger mmap_sem contection. Otherwise you are
> > > measuring the mmap_sem writelock fast path and that should be really
> > > within a noise comparing to the whole address space destruction time. If
> > > that is not the case then we have a real problem with the locking...
> >
> > My understanding of that discussion is that the concern was that even
> > taking uncontended mmap_sem writelock would regress the exit path.
> > That was what I wanted to confirm. Am I misreading it?
>
> No, your reading match my recollection. I just think that code
> robustness in exchange of a rw semaphore write lock fast path is a
> reasonable price to pay even if that has some effect on micro
> benchmarks.

I'm with you on this one, that's why I wanted to measure the price we
would pay. Below are the test results:

Test: https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/
Compiled: gcc -O2 -static test.c -o test
Test machine: 128 core / 256 thread 2x AMD EPYC 7B12 64-Core Processor
(family 17h)

baseline (Linus master, f31531e55495ca3746fb895ffdf73586be8259fa)
p50 (median)   87412
p95                  168210
p99                  190058
average           97843.8
stdev               29.85%

unconditional mmap_write_lock in exit_mmap (last column is the change
from the baseline)
p50 (median)   88312     +1.03%
p95                  170797   +1.54%
p99                  191813   +0.92%
average           97659.5  -0.19%
stdev               32.41%

unconditional mmap_write_lock in exit_mmap + Matthew's patch (last
column is the change from the baseline)
p50 (median)   88807      +1.60%
p95                  167783     -0.25%
p99                  187853     -1.16%
average           97491.4    -0.36%
stdev               30.61%

stdev is quite high in all cases, so the test is very noisy.
The impact seems quite low IMHO. WDYT?

> --
> Michal Hocko
> SUSE Labs
