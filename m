Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD0429981
	for <lists+linux-api@lfdr.de>; Tue, 12 Oct 2021 00:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233272AbhJKWrt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Oct 2021 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJKWrs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Oct 2021 18:47:48 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCB5C061570
        for <linux-api@vger.kernel.org>; Mon, 11 Oct 2021 15:45:48 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id i8so15631016uae.7
        for <linux-api@vger.kernel.org>; Mon, 11 Oct 2021 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+F7mbCRUVIAd5+FarZoaSUIAm/NRPRaqoitjHUAk/CY=;
        b=LdRWzX87yafLKh5rG+nJLozEgMBzBfZOwRq0iZYO7pBUujGAfc+4up+udWikXfY6KZ
         hZLapqKfV+4JeGhaBwsQAcJSNckPuWK5xG/vr8S7xCGXFoBNzLBmKhU5p0Khz9D28Ste
         mxW6bDcLg6QlS8Tv9dDjEcZxh3TFEM69BTUp+9cqoUg+/VprmXiNAR/v7Zt/AwlRvvJn
         tMD84x4JYHWids3F7LCalEml1oK3Bxel+lZvYVCEoG6e5sEz805yZacx7BuQRkpatC3e
         w/gKEzaBtA61cMuFlSdQsNGNvn1RnjQEEbOvEBdrS9Zk6ITrb3nbun+2se0iJalRqpO4
         0Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+F7mbCRUVIAd5+FarZoaSUIAm/NRPRaqoitjHUAk/CY=;
        b=Q53Cm+N0VmnGDrWcXEmq/ZHRpvPkYR7VQGdQSVb6WKpsVqkzC9t5/1d6zsGJTYpInN
         1c6zsL+DNSykq7MAJSFgy1LyTE23pDMMdAE5wuL6UNJYy4wudzhVRDJVrdiMO8JswOT3
         8kqSewjSXjSf5IqKI4x42Ix+KLjQ34+NuMuBQZEfb+vdurXYECN/6K9U1HwMosjkFRaR
         EFpEWdgpMLkzSpcSMRKkkb/1ft1OFsyZgCmSu5GiOT40fKBbGQ+guN/1GFirr+DJylqF
         4uohWRWJOnZBOPEwLvGzbiTHQRjNviwmauaTleNvI8lgdtipqZGXuEn6S1ohDrub6GQt
         Tz2Q==
X-Gm-Message-State: AOAM531YCvk8yV2YIjJfDMaJ7cKWu1EKqaq1r24l/hqJMXbnCntN/BuH
        kASsE2UhgK0W1NAhjhadAWCVvRw1Bq5S0ifJgQMlCw==
X-Google-Smtp-Source: ABdhPJzVVPdR4DP73VKGuQiecj7yDMIBF8hL25OwiQSohQYG9orfm3O7WMGfKA4wsIle29LnHWO67wZyVf9Gek2YfOY=
X-Received: by 2002:ab0:1623:: with SMTP id k32mr18245214uae.71.1633992347458;
 Mon, 11 Oct 2021 15:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210917180323.278250-1-posk@google.com> <20210917180323.278250-6-posk@google.com>
 <12eb2300-4a78-9e93-30a3-8e2ddba4693f@uwaterloo.ca>
In-Reply-To: <12eb2300-4a78-9e93-30a3-8e2ddba4693f@uwaterloo.ca>
From:   Peter Oskolkov <posk@posk.io>
Date:   Mon, 11 Oct 2021 15:45:36 -0700
Message-ID: <CAFTs51W6ZHrGaoXEbXNCkVKLxe7_S2raYcXMBzypC7VUDMrU-w@mail.gmail.com>
Subject: Re: [PATCH 5/5 v0.6] sched/umcg: add Documentation/userspace-api/umcg.txt
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thierry,

sorry for the delayed reply - I'm finally going through the
documentation patches in preparation for the upcoming next version
patchset mail-out.

On Wed, Sep 22, 2021 at 11:39 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
> On 2021-09-17 2:03 p.m., Peter Oskolkov wrote:
>  > [...]
>  > +SYS_UMCG_WAIT()
>  > +
>  > +int sys_umcg_wait(uint32_t flags, uint64_t abs_timeout) operates on
>  > +registered UMCG servers and workers: struct umcg_task *self provided to
>  > +sys_umcg_ctl() when registering the current task is consulted in
> addition
>  > +to flags and abs_timeout parameters.
>  > +
>  > +The function can be used to perform one of the three operations:
>  > +
>  > +* wait: if self->next_tid is zero, sys_umcg_wait() puts the current
>  > +  server or worker to sleep;
>
> I believe this description is misleading but I might be wrong.
>  From the example
>      * worker to server context switch (worker "yields"):
>        S:IDLE+W:RUNNING => +S:RUNNING+W:IDLE
>
> It seems to me that when a worker goes from running to idle, it should
> *not* set the next_tid to 0, it should preserve the next_tid as-is,
> which is expected to point to its current server. This is consistent
> with my understanding of the umcg_wait implementation. This operation
> is effectively a direct context-switch to the server.

The documentation here outlines what sys_umcg_wait does, and it does
put the current task to sleep without context switching if next_tid is
zero. The question of whether this behavior is or is not appropriate
for a worker wishing to yield/park itself is at a "policy" level, if
you wish, and this "policy" level is described in "state transitions"
section later in the document. sys_umcg_wait() does not enforce this
"policy" directly, in order to make it simpler and easier to describe
and reason about.

>
> With that said, I'm a little confused by the usage of "yields" in that
> example. I would expect workers yielding to behave like kernel threads
> calling sched_yield(), i.e., context switch to the server but also be
> immediately added to the idle_workers_ptr.
>
>  From my understanding of the umcg_wait call, "worker to server context
> switch" does not have analogous behaviour to sched_yield. Am I correct?
> If so, I suggest using "park" instead of "yield" in the description
> of that example. I believe the naming of wait/wake as park/unpark is
> consistent with Java[1] and Rust[2], but I don't know if that naming
> is used in contexts closer to the linux kernel.
>
> [1]
> https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/locks/LockSupport.html
> [2] https://doc.rust-lang.org/std/thread/fn.park.html

I'm not a fan of arguing about how to name things. If the maintainers
ask me to rename wait/wake to park/unpark, I'll do that. But it seems
they are OK with this terminology, I believe because wait/wake is a
relatively well understood pair of verbs in the kernel context;
futexes, for example, have wait/wake operations. A higher level
library in the userspace may later expose park/unpark functions that
at the lower level call sys_umcg_wait...
