Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0F12C5D2
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfE1LwH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 07:52:07 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35048 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfE1LwH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 07:52:07 -0400
Received: by mail-vs1-f65.google.com with SMTP id q13so12579462vso.2
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 04:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1aTFeYdC8ihQzpvWtoviM3ZNZ2tyKMHAXg6yp7ic20=;
        b=PosD1hmuB27HZrO906sYy0hewh4Vct55iIo0ByAp5WPqAr20vF5v6fG5Uxip/NrYLY
         QjNnEufZ8cZ02hvqUlK+kE3rzkvD77a6u2RqFou/IyqQ/DUV5A8SEpapg7REnhCFXf8f
         u9vjOMgPCoIbg724+0XcflX2NkQmUJFCsD+SMjVGC6JLL5Sstt5s7We8VUgj8MRjdTP7
         7LmPrujpPcmv4jaTkhKrCAJkq3XSFukprMN1b7c8kCdwOZ1tnM/O9Di7jnoUHqdDlfk1
         d/uI/EnpyQ1PHBBvLQ3TCqurKIo2lqu05a0yHDeZjxhFgubelY7FKKvZEfDq3rfs0RSv
         LrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1aTFeYdC8ihQzpvWtoviM3ZNZ2tyKMHAXg6yp7ic20=;
        b=uY5e3aHwcBvBcn/6lcK9kobyk/xnjYxSw2Co3d9aleGdKseyCSKDMqCThU52+CwfHH
         3K0UJtdDxyCHp9qkjJZZjMsxoZnrnGIE1d4L7yrJwxN8Fe8WcuwQCfD2PIYx5477zOi9
         EcEcfAuIIIx87rSPXPwdRcdroU9tZrGy8LF2phgDFPAjtbxFSmXZe+8eSn4a6V0uSudS
         yeqYUvHi0K84U5SmG9D2wQFHEV+4Vf/npUURbOT6nxVwFr3MyE6F/5Nea0YMpZ2F0HHQ
         8uXpUP99YOJ+fGB89JythMRxObG1aE/kWKb4eWqCZ5KnegbmVcj0Y3+rwqYwiYRUWioV
         fb9g==
X-Gm-Message-State: APjAAAVxGQ93Adfc0qABOMJweGzIFBU48pVWYBcbVvxyjvZn+kChpFe4
        jB2DJWwHYuXaAM8zZAuxVlj7vWXC8R9H57OHRt0RoA==
X-Google-Smtp-Source: APXvYqziveOhM5aNGo++tqUxS5XQXmXAHH/ek/mb/jgasaqofdw7uSl7LyXM4Lvz7mZ8iIPG7/VXfBvYqhiTJAbga5g=
X-Received: by 2002:a67:1485:: with SMTP id 127mr43387796vsu.77.1559044326244;
 Tue, 28 May 2019 04:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190528032632.GF6879@google.com> <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com> <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com> <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com> <20190528104117.GW1658@dhcp22.suse.cz>
 <20190528111208.GA30365@google.com> <20190528112840.GY1658@dhcp22.suse.cz> <20190528114436.GB30365@google.com>
In-Reply-To: <20190528114436.GB30365@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 28 May 2019 04:51:54 -0700
Message-ID: <CAKOZueu7ayjDoV904gFPRQu84_toxWAN5hBBe17x=g-MOBJ7uQ@mail.gmail.com>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 4:44 AM Minchan Kim <minchan@kernel.org> wrote:
>
> On Tue, May 28, 2019 at 01:28:40PM +0200, Michal Hocko wrote:
> > On Tue 28-05-19 20:12:08, Minchan Kim wrote:
> > > On Tue, May 28, 2019 at 12:41:17PM +0200, Michal Hocko wrote:
> > > > On Tue 28-05-19 19:32:56, Minchan Kim wrote:
> > > > > On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> > > > > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > > > > >
> > > > > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > > > > so map_anon wouldn't be helpful.
> > > > > > > >
> > > > > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > > > > memory map information out of processes.  Some single-system-call
> > > > > > > > method for retrieving a binary snapshot of a process's address space
> > > > > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > > > > reduce complexity and increase performance in a variety of areas,
> > > > > > > > e.g., Android memory map debugging commands.
> > > > > > >
> > > > > > > I agree it's the best we can get *generally*.
> > > > > > > Michal, any opinion?
> > > > > >
> > > > > > I am not really sure this is directly related. I think the primary
> > > > > > question that we have to sort out first is whether we want to have
> > > > > > the remote madvise call process or vma fd based. This is an important
> > > > > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > > > > so far unfortunately.
> > > > >
> > > > > With current usecase, it's per-process API with distinguishable anon/file
> > > > > but thought it could be easily extended later for each address range
> > > > > operation as userspace getting smarter with more information.
> > > >
> > > > Never design user API based on a single usecase, please. The "easily
> > > > extended" part is by far not clear to me TBH. As I've already mentioned
> > > > several times, the synchronization model has to be thought through
> > > > carefuly before a remote process address range operation can be
> > > > implemented.
> > >
> > > I agree with you that we shouldn't design API on single usecase but what
> > > you are concerning is actually not our usecase because we are resilient
> > > with the race since MADV_COLD|PAGEOUT is not destruptive.
> > > Actually, many hints are already racy in that the upcoming pattern would
> > > be different with the behavior you thought at the moment.
> >
> > How come they are racy wrt address ranges? You would have to be in
> > multithreaded environment and then the onus of synchronization is on
> > threads. That model is quite clear. But we are talking about separate
>
> Think about MADV_FREE. Allocator would think the chunk is worth to mark
> "freeable" but soon, user of the allocator asked the chunk - ie, it's not
> freeable any longer once user start to use it.
>
> My point is that kinds of *hints* are always racy so any synchronization
> couldn't help a lot. That's why I want to restrict hints process_madvise
> supports as such kinds of non-destruptive one at next respin.

I think it's more natural for process_madvise to be a superset of
regular madvise. What's the harm? There are no security implications,
since anyone who could process_madvise could just ptrace anyway. I
also don't think limiting the hinting to non-destructive operations
guarantees safety (in a broad sense) either, since operating on the
wrong memory range can still cause unexpected system performance
issues even if there's no data loss.

More broadly, what I want to see is a family of process_* APIs that
provide a superset of the functionality that the existing intraprocess
APIs provide. I think this approach is elegant and generalizes easily.
I'm worried about prematurely limiting the interprocess memory APIs
and creating limitations that will last a long time in order to avoid
having to consider issues like VMA synchronization.
