Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24A2C54E
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfE1LWA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 07:22:00 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:41200 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfE1LV5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 07:21:57 -0400
Received: by mail-vs1-f68.google.com with SMTP id w19so12509394vsw.8
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PDuFfWfADQYlVhXy+17dLFypWmYPH1IcELfasjjhB/Q=;
        b=VLoUpTyNlV3VW+ZBKjhY4F2iodWLKJkOJWCcnc1iQ3S6WqX2wNz+wYGdlBAly2YEJf
         uwwLyvZqMg/jMKAB/tZPQ+2ICrRKbnVTNJGETNRLZynk2zIaOTfaj6IYsHDG7sHXEAfi
         tf1lTm9Esb49Q5xEnb/dkGnz8h1X3NMxdt78DC7CR2HhkStWlDts8NuCGFygXnmv115s
         1lI+m9MnaSbZGLyglKlPWyaQXYqrNsj78LAV6rWH3ZAsxyADaY5fvGCYOsgiKEqtbkS1
         npJ+IvL+NybFjMFW6KyJ/WEeI/+43OlTrvJYhB4hS0bN9U9HZTO31mqcjksbO57yPbPS
         lRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PDuFfWfADQYlVhXy+17dLFypWmYPH1IcELfasjjhB/Q=;
        b=LuI2K4TKcAU/7LTJ1AftJU++nAJOqKvEup7aGY8dYGKSlLzezvu5eyoePysMV3ewyu
         /WXFAXhSWwrziT7AOEXd4dzF5eF65RS99e6A8n6fyqbQZpASmjYuNpQC0GG1pIDczzL0
         bzaWT7xgU4zMrjo0SMSlszyEYSzeJuDDh9YLd9+t//VLAXMhqlcy6keaC0hgMQgfr1S5
         ltPX3zf1J3YxjM9h0xOvCQPCGviBgeuVquzYrgsvIUfAej5137sKdkwjRaA80TMYPmBx
         2rUdTYGwYDj8iiblFV9Mx8Qd4ozfNWV4CvdIYqiUGIupoWzVnH7fsym9/nhjAzuYG1dK
         QtKw==
X-Gm-Message-State: APjAAAUHGf7cejoa5Hts9vzF8uj+hrwr1CWXnmndp9bE8HA4I0ZlL/jm
        KZkllMowOfxVVUgS7JqJ6p7m9+3EmljPx2Qie/e7VA==
X-Google-Smtp-Source: APXvYqweDq6pHRU4KDEZMJzO0GXUt0BWVFUr4wVrB+W7bnd4u/MvUMdhC5GOTz54S4XddsCNZCC189kI32ioA3U9q/0=
X-Received: by 2002:a67:dd8e:: with SMTP id i14mr30354365vsk.149.1559042515604;
 Tue, 28 May 2019 04:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190521062628.GE32329@dhcp22.suse.cz> <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz> <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz> <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com> <20190528090821.GU1658@dhcp22.suse.cz>
 <CAKOZueux3T4_dMOUK6R=ZHhCFaSSstOCPh_KSwSMCW_yp=jdSg@mail.gmail.com> <20190528103312.GV1658@dhcp22.suse.cz>
In-Reply-To: <20190528103312.GV1658@dhcp22.suse.cz>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 28 May 2019 04:21:44 -0700
Message-ID: <CAKOZueuRAtps+YZ1g2SOevBrDwE6tWsTuONJu1NLgvW7cpA-ug@mail.gmail.com>
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

On Tue, May 28, 2019 at 3:33 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 28-05-19 02:39:03, Daniel Colascione wrote:
> > On Tue, May 28, 2019 at 2:08 AM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > >
> > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > so map_anon wouldn't be helpful.
> > > > >
> > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > memory map information out of processes.  Some single-system-call
> > > > > method for retrieving a binary snapshot of a process's address space
> > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > reduce complexity and increase performance in a variety of areas,
> > > > > e.g., Android memory map debugging commands.
> > > >
> > > > I agree it's the best we can get *generally*.
> > > > Michal, any opinion?
> > >
> > > I am not really sure this is directly related. I think the primary
> > > question that we have to sort out first is whether we want to have
> > > the remote madvise call process or vma fd based. This is an important
> > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > so far unfortunately.
> >
> > I don't think the vma fd approach is viable. We have some processes
> > with a *lot* of VMAs --- system_server had 4204 when I checked just
> > now (and that's typical) --- and an FD operation per VMA would be
> > excessive.
>
> What do you mean by excessive here? Do you expect the process to have
> them open all at once?

Minchan's already done timing. More broadly, in an era with various
speculative execution mitigations, making a system call is pretty
expensive. If we have two options for remote VMA manipulation, one
that requires thousands of system calls (with the count proportional
to the address space size of the process) and one that requires only a
few system calls no matter how large the target process is, the latter
ought to start off with more points than the former under any kind of
design scoring.

> > VMAs also come and go pretty easily depending on changes in
> > protections and various faults.
>
> Is this really too much different from /proc/<pid>/map_files?

It's very different. See below.

> > > An interface to query address range information is a separate but
> > > although a related topic. We have /proc/<pid>/[s]maps for that right
> > > now and I understand it is not a general win for all usecases because
> > > it tends to be slow for some. I can see how /proc/<pid>/map_anons could
> > > provide per vma information in a binary form via a fd based interface.
> > > But I would rather not conflate those two discussions much - well except
> > > if it could give one of the approaches more justification but let's
> > > focus on the madvise part first.
> >
> > I don't think it's a good idea to focus on one feature in a
> > multi-feature change when the interactions between features can be
> > very important for overall design of the multi-feature system and the
> > design of each feature.
> >
> > Here's my thinking on the high-level design:
> >
> > I'm imagining an address-range system that would work like this: we'd
> > create some kind of process_vm_getinfo(2) system call [1] that would
> > accept a statx-like attribute map and a pid/fd parameter as input and
> > return, on output, two things: 1) an array [2] of VMA descriptors
> > containing the requested information, and 2) a VMA configuration
> > sequence number. We'd then have process_madvise() and other
> > cross-process VM interfaces accept both address ranges and this
> > sequence number; they'd succeed only if the VMA configuration sequence
> > number is still current, i.e., the target process hasn't changed its
> > VMA configuration (implicitly or explicitly) since the call to
> > process_vm_getinfo().
>
> The sequence number is essentially a cookie that is transparent to the
> userspace right? If yes, how does it differ from a fd (returned from
> /proc/<pid>/map_{anons,files}/range) which is a cookie itself and it can

If you want to operate on N VMAs simultaneously under an FD-per-VMA
model, you'd need to have those N FDs all open at the same time *and*
add some kind of system call that accepted those N FDs and an
operation to perform. The sequence number I'm proposing also applies
to the whole address space, not just one VMA. Even if you did have
these N FDs open all at once and supplied them all to some batch
operation, you couldn't guarantee via the FD mechanism that some *new*
VMA didn't appear in the address range you want to manipulate. A
global sequence number would catch this case. I still think supplying
a list of address ranges (like we already do for scatter-gather IO) is
less error-prone, less resource-intensive, more consistent with
existing practice, and equally flexible, especially if we start
supporting destructive cross-process memory operations, which may be
useful for things like checkpointing and optimizing process startup.

Besides: process_vm_readv and process_vm_writev already work on
address ranges. Why should other cross-process memory APIs use a very
different model for naming memory regions?

> be used to revalidate when the operation is requested and fail if
> something has changed. Moreover we already do have a fd based madvise
> syscall so there shouldn't be really a large need to add a new set of
> syscalls.

We have various system calls that provide hints for open files, but
the memory operations are distinct. Modeling anonymous memory as a
kind of file-backed memory for purposes of VMA manipulation would also
be a departure from existing practice. Can you help me understand why
you seem to favor the FD-per-VMA approach so heavily? I don't see any
arguments *for* an FD-per-VMA model for remove memory manipulation and
I see a lot of arguments against it. Is there some compelling
advantage I'm missing?

> > Or maybe the whole sequence number thing is overkill and we don't need
> > atomicity? But if there's a concern  that A shouldn't operate on B's
> > memory without knowing what it's operating on, then the scheme I've
> > proposed above solves this knowledge problem in a pretty lightweight
> > way.
>
> This is the main question here. Do we really want to enforce an external
> synchronization between the two processes to make sure that they are
> both operating on the same range - aka protect from the range going away
> and being reused for a different purpose. Right now it wouldn't be fatal
> because both operations are non destructive but I can imagine that there
> will be more madvise operations to follow (including those that are
> destructive) because people will simply find usecases for that. This
> should be reflected in the proposed API.

A sequence number gives us this synchronization at very low cost and
adds safety. It's also a general-purpose mechanism that would
safeguard *any* cross-process VM operation, not just the VM operations
we're discussing right now.
