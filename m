Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085DE2C59D
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 13:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfE1LnB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 07:43:01 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42405 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1LnA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 07:43:00 -0400
Received: by mail-ua1-f66.google.com with SMTP id e9so7677197uar.9
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 04:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gmF/MjZR30MUZnp5xpEZAXbIkiTvDuZ5uonAoWGSVI0=;
        b=hlDW9jPSp+Zbp5gHMYiybd+exCPEPCxNejShzWmQtQboUqXn2NyzXiKthdzcnC/KGv
         NC+lMlsvUobu5t8d92IzghMfsBLj4J9wEvm2lJNgh7U0f25F8QH1ktixuiqijW+nyb+1
         9A1qxf5vlCfNwqhErg/re/ZoKu6xzxdcM2/a73qTvu+MpL2E/QRt1iy1KoddOjj85Q5J
         YIDmDuYb3+tsCmvCUWoVk93+zXRkWy+rIr2TtUBpSMmgo3JGmcrzeF/C5dZq3YaFUcGl
         75Hud1H9paC2qUBkzZ/DKOjMh+Y4Lx+PxJglgVpehWRLTUO5y9+r4cSKvheGlpWNduOP
         3bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gmF/MjZR30MUZnp5xpEZAXbIkiTvDuZ5uonAoWGSVI0=;
        b=IGvJWX81NNpBuvK0qjgbGSiC9g50T6B5cI5s9dAF7wG/rjFy3vM6wtFSrVQOVMNfEv
         UB3UjcJZgEzr6UcB6sCNYMnnW6MnInkyeyz7q2LUWOPFDBOYkP4BA55lcSMFhqSNJu+W
         igt9ccXaGxb41fKVgI3aYpU36PecE7mXuu3nL38llZnrLU+ayhKPOA0z2K071SVw0gGg
         KG6CY3igV2U31oS5BV7LRyimC4Xzytw9bPnF0QAK2BA17d+tJy+k9EtawZGjrSAqW3Ib
         2d1Q+f/bgPIsGCQOtG485fjS1lZZTlkeK4SHSp9gtEquuF6ZUtCHpAs8hwW5Hl2CKkCt
         ZWKA==
X-Gm-Message-State: APjAAAVMn7EfWrbbe26UDG1ZbHH8rqhmJZaZVNQbnnRbS0MSHogAZOKP
        ShpA4CWoG6UUs9QtD1SoAwvY5uQ6L7EuoBG1kEWP2g==
X-Google-Smtp-Source: APXvYqyiNr7P2DjlbLU9A4NNhpmBOKWSjQk2Y7tSLL6dWBbAVxeNAYgXEWOY1g8aEtm+2Vm9om7Y96HxIiS3+0AuAA0=
X-Received: by 2002:ab0:1407:: with SMTP id b7mr41595946uae.112.1559043779267;
 Tue, 28 May 2019 04:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190527124411.GC1658@dhcp22.suse.cz> <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz> <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com> <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com> <20190528104117.GW1658@dhcp22.suse.cz>
 <20190528111208.GA30365@google.com> <20190528112840.GY1658@dhcp22.suse.cz>
In-Reply-To: <20190528112840.GY1658@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 28 May 2019 04:42:47 -0700
Message-ID: <CAKOZuesCSrE0esqDDbo8x5u5rM-Uv_81jjBt1QRXFKNOUJu0aw@mail.gmail.com>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>,
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

On Tue, May 28, 2019 at 4:28 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 28-05-19 20:12:08, Minchan Kim wrote:
> > On Tue, May 28, 2019 at 12:41:17PM +0200, Michal Hocko wrote:
> > > On Tue 28-05-19 19:32:56, Minchan Kim wrote:
> > > > On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> > > > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > > > >
> > > > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > > > so map_anon wouldn't be helpful.
> > > > > > >
> > > > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > > > memory map information out of processes.  Some single-system-call
> > > > > > > method for retrieving a binary snapshot of a process's address space
> > > > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > > > reduce complexity and increase performance in a variety of areas,
> > > > > > > e.g., Android memory map debugging commands.
> > > > > >
> > > > > > I agree it's the best we can get *generally*.
> > > > > > Michal, any opinion?
> > > > >
> > > > > I am not really sure this is directly related. I think the primary
> > > > > question that we have to sort out first is whether we want to have
> > > > > the remote madvise call process or vma fd based. This is an important
> > > > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > > > so far unfortunately.
> > > >
> > > > With current usecase, it's per-process API with distinguishable anon/file
> > > > but thought it could be easily extended later for each address range
> > > > operation as userspace getting smarter with more information.
> > >
> > > Never design user API based on a single usecase, please. The "easily
> > > extended" part is by far not clear to me TBH. As I've already mentioned
> > > several times, the synchronization model has to be thought through
> > > carefuly before a remote process address range operation can be
> > > implemented.
> >
> > I agree with you that we shouldn't design API on single usecase but what
> > you are concerning is actually not our usecase because we are resilient
> > with the race since MADV_COLD|PAGEOUT is not destruptive.
> > Actually, many hints are already racy in that the upcoming pattern would
> > be different with the behavior you thought at the moment.
>
> How come they are racy wrt address ranges? You would have to be in
> multithreaded environment and then the onus of synchronization is on
> threads. That model is quite clear. But we are talking about separate
> processes and some of them might be even not aware of an external entity
> tweaking their address space.

I don't think the difference between a thread and a process matters in
this context. Threads race on address space operations all the time
--- in the sense that multiple threads modify a process's address
space without synchronization. The main reasons that these races
hasn't been a problem are: 1) threads mostly "mind their own business"
and modify different parts of the address space or use locks to ensure
that they don't stop on each other (e.g., the malloc heap lock), and
2) POSIX mmap atomic-replacement semantics make certain classes of
operation (like "magic ring buffer" setup) safe even in the presence
of other threads stomping over an address space.

The thing that's new in this discussion from a synchronization point
of view isn't that the VM operation we're talking about is coming from
outside the process, but that we want to do a read-decide-modify-ish
thing. We want to affect (using various hints) classes of pages like
"all file pages" or "all anonymous pages" or "some pages referring to
graphics buffers up to 100MB" (to pick an example off the top of my
head of a policy that might make sense). From a synchronization point
of view, it doesn't really matter whether it's a thread within the
target process or a thread outside the target process that does the
address space manipulation. What's new is the inspection of the
address space before performing an operation.

Minchan started this thread by proposing some flags that would
implement a few of the filtering policies I used as examples above.
Personally, instead of providing a few pre-built policies as flags,
I'd rather push the page manipulation policy to userspace as much as
possible and just have the kernel provide a mechanism that *in
general* makes these read-decide-modify operations efficient and
robust. I still think there's way to achieve this goal very
inexpensively without compromising on flexibility.
