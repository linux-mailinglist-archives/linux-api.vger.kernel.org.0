Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557D045DFEF
	for <lists+linux-api@lfdr.de>; Thu, 25 Nov 2021 18:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347782AbhKYRqk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Nov 2021 12:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236265AbhKYRoj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Nov 2021 12:44:39 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6074C061A29
        for <linux-api@vger.kernel.org>; Thu, 25 Nov 2021 09:29:00 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id t13so13711123uad.9
        for <linux-api@vger.kernel.org>; Thu, 25 Nov 2021 09:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IBEhpObGolU+4iX425jtNXgHUPZE0af1hS/Di57iqGg=;
        b=VpD4zBOm32koE2rSOjnPeQlqduvJvx2XL4+eWuL0MEtVlhKsiAsvCCKAhR0VUn9nLN
         AaIvXd/yfN3QcYIPZNx+RzfpZL7bZorzathuzF6Az0M/yB/zdNoCq9lyIomAqcuICGMQ
         DcOY3QreN28RCyyJIew5yWArmHaaZbg1UFZbbqClOatUTu39mwIqhmQc4oygx/bF2zpD
         HSmuIm1uA7/I3fKucnDqPLGexa9YIXdaS73bRUgG4/sz2TSagiglx875frKiicUw5Jaq
         4DpctpHMhm8SOxcI6Ho5EF3UY5HkksBS6HfJxpod6XSwdjNBxAbH9DJuzGofR1KCiMYv
         tfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IBEhpObGolU+4iX425jtNXgHUPZE0af1hS/Di57iqGg=;
        b=48iXJMh6rU0jJcG8PDWg5Kbh0s8kERbsQX6LPkzgs7VOjXWjZgIsAXzxR5qFQrVygS
         IcW/XD5uLafKy6ll6iFEwbHvw72+S8cuyLwOsAmSXo5d0z2AWjYa0sOscW1GU+OPJCA+
         NG1wqF2BbHnzSi8x6GpxFxRA4sQYCmCHhlCMQyQ8gUm6QSydKGSRawDoaT6pO7rQ/b43
         1NHBRP9EIS1PlRFzFthcV6Q/Y8MdKl/KvMYuXhicz9sEABdb9EN9eEcWMCmMls5t41XM
         753NJbNdEWlOTIYQn12wKn7JVWsvTnXOuF8hwwGFF/DaAQlR4rMF8xd/4+wvnI1Ygdc3
         Y6sg==
X-Gm-Message-State: AOAM532mDxp1gPeK8UUzIBiT2ty0loA+N+9ve/JrKeJUEC5J7sDwIg2a
        V6zmK3g/EJK9NULmcmpUCfp429Zr6y+ZH59VAkDlfw==
X-Google-Smtp-Source: ABdhPJzuLRYrRCP8uns6IAySz1dNEKf0WKtd4iu5aTRnogqI8B4oQPNKXVSuIYW162s/1xr+kyIDby8hCr6rYJsVYh4=
X-Received: by 2002:a67:bb19:: with SMTP id m25mr11744019vsn.47.1637861339950;
 Thu, 25 Nov 2021 09:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20211122211327.5931-1-posk@google.com> <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
In-Reply-To: <20211124200822.GF721624@worktop.programming.kicks-ass.net>
From:   Peter Oskolkov <posk@posk.io>
Date:   Thu, 25 Nov 2021 09:28:49 -0800
Message-ID: <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks, Peter, for the review!

Some of your comments, like ratelimiting pr_warn and removing gotos,
are obvious in how to address them, so I'll just do that and won't
mention them here. Some comments are less clear re: what should be
done about them, so I have them below with my own comments/questions.

At a higher level, I get that the uaccess patch is bad and needs
serious changes. But based on your comments on this main patch so far,
it looks like the overall approach did not raise many objections - is
it so? Have you finished reviewing the patch?

Please also look at my questions/comments below.

Thanks,
Peter

[...]
> > +struct umcg_task {
[...]

>
> The thing is; I really don't see how this is supposed to be used. Where
> did the blocked and runnable list go ?
>
> I also don't see why the kernel cares about idle workers at all; that
> seems something userspace can sort itself just fine.
>
> The whole next_tid thing seems confused too, how can it be the next task
> when it must be the server? Also, what if there isn't an idle server?
>
> This just all isn't making any sense to me.

Based on your later comments I assume it is clearer now. The doc patch
5 has a lot of extra explanations and examples. Please let me know if
something is still unclear here.

> I'm still very hesitant to use ktime (fear the HPET); but I suppose it
> makes sense to use a time base that's accessible to userspace. Was
> MONOTONIC_RAW considered?

I believe it was considered. I'll re-consider it, and add a comment if
the new consideration arrives at the same conclusion.

> Using CLOCK_REALTIME timers while the rest of the thing runs off of
> CLOCK_MONOTONIC doesn't seem to make sense to me. Why would you want to
> have timeouts subject to DST shifts and crap like that?

Yes, these should be the same if at all possible. I'll definitely
reconsider what clock to use in both timeouts and state timestamps.

> Oooh, someone made things super confusing by doing s/runnable/idle/ on
> the whole thing :-( That only took me most of the day to figure out.
> Naming is important, don't mess about with stuff like this.

I clearly remember I had four states: blocked, pending, runnable,
running (I still believe that four states better reflect what is going
on here). The current blocked/idle/running is the result of an early
discussion. Something along the lines of:

<start of a recollection>
pending workers (=unblocked workers that the userspace still thinks
are blocked) are better named as idle; also the kernel does not really
care about what userspace thinks, so idle workers and runnable workers
are the same from the kernel point of view, so let's have one state
for these workers, not two.
<end of the recollection>

Please let me know if you want me to change anything here. I'll gladly
name workers on the idle worker list as idle (or whatever you prefer),
and workers that the userspace took out of the list as "runnable".
Just as a FYI, workers blocked in umcg_wait() will also be called
"runnable" then, as they are sitting in umcg_idle_loop() and can be
woken or swapped into.
