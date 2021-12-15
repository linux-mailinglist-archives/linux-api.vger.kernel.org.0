Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138D7475FFD
	for <lists+linux-api@lfdr.de>; Wed, 15 Dec 2021 18:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239324AbhLOR4S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Dec 2021 12:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhLOR4S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Dec 2021 12:56:18 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BD6C06173E
        for <linux-api@vger.kernel.org>; Wed, 15 Dec 2021 09:56:18 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id u40so9238037uad.1
        for <linux-api@vger.kernel.org>; Wed, 15 Dec 2021 09:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ys3rZNuX7+z7pA4D/KdILKC/mW3vMwpvwDb3wE/01Rk=;
        b=WW/hDoEwCR1rjxM+F7Yqu7cbwjS2D1bqvjEDmHgeoNa4PpqzkK/Wtz52xdZLCWaYoc
         6Pn5GlBJr1vQSqOPG7HIqznF6eHy8RNiaB8KcPFORAnkybihRPqcWot4wmmdx/Sn7giF
         6ksUoQLeqZS/6NQfhsRKADgceL1NH3EXpvitsHQ11ncUc0WYkenrnitfsLgT+xhwx0EQ
         QIifb4vEkoZCZJk1L8dL5YNogD1RSRGVUVAizVq+NA4A9xM0nkT9E2qmYtgGtDazpxWK
         2K0Fb65gE2iQADFX90bH5+pnqPBE9urVbakB+se5A8QEswecS3Mhbr29o5Nd67CNKEqq
         wbXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ys3rZNuX7+z7pA4D/KdILKC/mW3vMwpvwDb3wE/01Rk=;
        b=7hYQ5YxShE+PtAiduzmyET4ArYNsoAS6ND2OKmoIpKotpJMOWTBLlay2fdUtgfDBUF
         gFm/HUDMCCetX+fhcer9u3Th6TOGlPIo4yjS2vmqabCC95EDHdXjC7XxMMDV2WtDUpb5
         PAyqp7nD457d9PhefYkB+AB7a4GBknf+IJv+ANNhdtQwJQJe4DXmzmtJyGhyRQ1dp/NI
         9eLDM2m7osERVpMbg1HCL3sr8OFOZ95PL/Y5pfr8aEvRCCgfFcUL2izVrOX6zosfbz9c
         zr4M+pm87DUWq+E/vFtv89ccSC8Hzr3vaNfxlYo+QpGt1Qravc9OMkK9T4mCTAvoe+Zf
         jNHg==
X-Gm-Message-State: AOAM533TG1F8y1ZnQLIYdzSOS4w3GEFn2S1QUqTkzg8HOfLlnth6XUi/
        9ZXr9AbsY4/CgypesgjpSRkPeEIpK+S//1xVhp/QIg==
X-Google-Smtp-Source: ABdhPJy+0ibS31bqjUgXJDh5pEyKbSWrcOOg1QLNTZcvBmNYNGL0ZuDRxO8hqcH3gGNI1DLlIUcWmmw2XfEKcGTSo/Q=
X-Received: by 2002:a9f:218c:: with SMTP id 12mr10203394uac.71.1639590977230;
 Wed, 15 Dec 2021 09:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20211214204445.665580974@infradead.org> <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
In-Reply-To: <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Wed, 15 Dec 2021 09:56:06 -0800
Message-ID: <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Dec 15, 2021 at 2:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Dec 14, 2021 at 07:46:25PM -0800, Peter Oskolkov wrote:
> > On Tue, Dec 14, 2021 at 12:55 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > Hi,
> > >
> > > This is actually tested code; but still missing the SMP wake-to-idle machinery.
> > > I still need to think about that.
> >
> > Thanks, Peter!
> >
> > At a first glance, your main patch does not look much smaller than
> > mine, and I thought the whole point of re-doing it was to throw away
> > extra features and make things smaller/simpler...
>
> Well, simpler was the goal. I didn't really focus on size much. It isn't
> really big to begin with.
>
> But yes, it has 5 hooks now, 3 syscalls and lots of comments and all
> that under 900 lines, not bad I'd say.

My patchset had three hooks and two syscalls, and fewer new fields
added to task_struct... And similarly around 900 lines on the kernel
side in the main patch. So I am not sure why you believe that your
approach is simpler, unless there was something fundamentally wrong
with my approach. But tglx@ looked into it, and his remarks were more
about comments and the commit message and smaller things at a function
level, like an unneeded goto, than about the overall design...

>
> Also I think you wanted something like this? I'm not sure of the LAZY
> name, but I can't seem to come up with anything saner atm.
>
[...]
>  /*
> + * Enqueue tsk to it's server's runnable list and wake the server for pickup if
> + * so desired. Notable LAZY workers will not wake the server and rely on the
> + * server to do pickup whenever it naturally runs next.

No, I never suggested we needed per-server runnable queues: in all my
patchsets I had a single list of idle (runnable) workers.

[...]

From another message:

>> Anyway, I'll test your patchset over the next week or so and let you
>> know if anything really needed is missing (other than waking an idle
>> server if there is one on a worker wakeup; this piece is definitely
> needed).

> Right, so the problem I'm having is that a single idle server ptr like
> before can trivially miss waking annother idle server.

I believe the approach I used in my patchset, suggested by Thierry
Delisle, works.

In short, there is a single idle server ptr for the kernel to work
with. The userspace maintains a list of idle servers. If the ptr is
NULL, the list is empty. When the kernel wakes the idle server it
sees, the server reaps the runnable worker list and wakes another idle
server from the userspace list, if available. This newly woken idle
server repoints the ptr to itself, checks the runnable worker list, to
avoid missing a woken worker, then goes to sleep.

Why do you think this approach is not OK?
