Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2335476227
	for <lists+linux-api@lfdr.de>; Wed, 15 Dec 2021 20:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhLOTuF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Dec 2021 14:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbhLOTuF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Dec 2021 14:50:05 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C5FC06173E
        for <linux-api@vger.kernel.org>; Wed, 15 Dec 2021 11:50:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id a18so40103757wrn.6
        for <linux-api@vger.kernel.org>; Wed, 15 Dec 2021 11:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JBKbYwsshu8iSqfD9517s+vo2UdPMxMRdjnHJCVbj4=;
        b=sRpMqDyx/cpoXSV6aAdR8pC8t21f+shsV3RNJFBReQFIZpIbxX8XFW5H67QMW0z346
         Lekq/JbkSFs51zuPMhiN0N0FmNxeywvGIGPfhxJDZZofM4xWFPq0IS3+6Rvo7fDqNzxc
         PGw+mxtOId3D+aoqyi66teuR1yQOjpHnqg93ocrcCQXlft1OJnBtrV45BXQ+6+ubz+D+
         sj7ViNnzisl3y2LXbEwh46ph0/9DAQCR2Z+rt2KrrtuhvQi0eAP55ThtvQ4MHEw0TiNG
         jV/giEUSPIvvfBTzfQQZsGYR5mRR/SmMOiBHkn59tZJB5m/FOku52D7kWqUAl9ZuMy30
         bNWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JBKbYwsshu8iSqfD9517s+vo2UdPMxMRdjnHJCVbj4=;
        b=OVD6aIswDImo2DkKyWdp20MX+nnL8d0P4FIMZC/nNg5mZop82cV8UX80sU8E3JlFY2
         gHK/7Mi7sorIjVRVawL6hQqwGMcwN6lF1cHEffas5EHwicPL8omyWPzPWcpq/sfqQdY4
         BDjZHfx/XtBjNkFgQcQGVF3FzG9lwJdY83iF9aRvJ50dE8sWa5CAf4oW79u/kG0Em6rU
         VSdygoi6LOVqwz0qGWd5pLqXAgMhwCckaASfEcDnoK6e8nJW8VFwf0PyuSGqrn8zLWt7
         vhQfdqJ/sYZFr0b4LIPYy2XONyJDy5haYhxJtrWJpIB5fQGlAFCo6MpY5AuQ2nhDQ6wZ
         LvXQ==
X-Gm-Message-State: AOAM530Eq0J5iHHINfjpL4mxToH/Z7FpnqfmNywQsVXn+3XeGuHPSS02
        nPwZ4iXhUVylME06kUNwnhqYi6x3nK8vFGW7qjkueg==
X-Google-Smtp-Source: ABdhPJzZJskrySYWuhv/jOhIkWrdH0hLSZsgVg63d25D6HdWDBjBSiU7oA1n3Gu5cZ6AIZETV2PYLONoFpL3NUpS76c=
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr5996811wrb.148.1639597802997;
 Wed, 15 Dec 2021 11:50:02 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net> <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
 <YboxjUM+D9Kg52mO@hirez.programming.kicks-ass.net>
In-Reply-To: <YboxjUM+D9Kg52mO@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 15 Dec 2021 11:49:51 -0800
Message-ID: <CAPNVh5cJy2y+sTx0cPA1BPSAg=GjXC8XGT7fLzHwzvXH2=xjmw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Andrei Vagin <avagin@google.com>,
        Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 15, 2021 at 10:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Dec 15, 2021 at 09:56:06AM -0800, Peter Oskolkov wrote:
>
> > > Right, so the problem I'm having is that a single idle server ptr like
> > > before can trivially miss waking annother idle server.
> >
> > I believe the approach I used in my patchset, suggested by Thierry
> > Delisle, works.
> >
> > In short, there is a single idle server ptr for the kernel to work
> > with. The userspace maintains a list of idle servers. If the ptr is
> > NULL, the list is empty. When the kernel wakes the idle server it
> > sees, the server reaps the runnable worker list and wakes another idle
> > server from the userspace list, if available. This newly woken idle
> > server repoints the ptr to itself, checks the runnable worker list, to
> > avoid missing a woken worker, then goes to sleep.
> >
> > Why do you think this approach is not OK?
>
> Suppose at least 4 servers, 2 idle, 2 working.
>
> Now, the first of the working servers (lets call it S0) gets a wakeup
> (say Ta), it finds the idle server (say S3) and consumes it, sticking Ta
> on S3 and kicking it alive.

TL;DR: our models are different here. In your model a single server
can have a bunch of workers interacting with it; in my model only a
single RUNNING worker is assigned to a server, which it wakes when it
blocks.

More details:

"Working servers" cannot get wakeups, because a "working server" has a
single RUNNING worker attached to it. When a worker blocks, it wakes
its attached server and becomes a detached blocked worker (same is
true if the worker is "preempted": it blocks and wakes its assigned
server).

Blocked workers upon wakeup do this, in order:

- always add themselves to the runnable worker list (the list is
shared among ALL servers, it is NOT per server);
- wake a server pointed to by idle_server_ptr, if not NULL;
- sleep, waiting for a wakeup from a server;

Server S, upon becoming IDLE (no worker to run, or woken on idle
server list) does this, in order, in userspace (simplified, see
umcg_get_idle_worker() in
https://lore.kernel.org/lkml/20211122211327.5931-5-posk@google.com/):
- take a userspace (spin) lock (so the steps below are all within a
single critical section):
- compare_xchg(idle_server_ptr, NULL, S);
  - if failed, there is another server in idle_server_ptr, so S adds
itself to the userspace idle server list, releases the lock, goes to
sleep;
  - if succeeded:
    - check the runnable worker list;
        - if empty, release the lock, sleep;
        - if not empty:
           - get the list
           - xchg(idle_server_ptr, NULL) (either S removes itself, or
a worker in the kernel does it first, does not matter);
           - release the lock;
           - wake server S1 on idle server list. S1 goes through all
of these steps.

The protocol above serializes the userspace dealing with the idle
server ptr/list. Wakeups in the kernel will be caught if there are
idle servers. Yes, the protocol in the userspace is complicated (more
complicated than outlined above, as the reaped idle/runnable worker
list from the kernel is added to the userspace idle/runnable worker
list), but the kernel side is very simple. I've tested this
interaction extensively, I'm reasonably sure that no worker wakeups
are lost.

>
> Concurrently and loosing the race the other working server (S1) gets a
> wake-up from Tb, like said, it lost, no idle server, so Tb goes on the
> queue of S1.
>
> So then S3 wakes, finds Ta and they live happily ever after.
>
> While S2 and Tb fail to meet one another and both linger in sadness.
>
