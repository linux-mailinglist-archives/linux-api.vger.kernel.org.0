Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E33C66F8
	for <lists+linux-api@lfdr.de>; Tue, 13 Jul 2021 01:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhGLXeF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 19:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhGLXeF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 19:34:05 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3969C0613DD
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 16:31:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u13so7398227lfs.11
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 16:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SmD9wC6S6HXd90fnEsiBq1bDT4eXjAjdn3ifAXDkVWs=;
        b=hAIpmKdW1W518cHLzs+EPkLneVA07sONS0itbFu5sbRK2QvQXjhr0rHy5VHDsPnXhm
         vGLKnJKHjXAYIeWzh1rCbEzEQSKOHfgd8/o3f9cjimvzqRobAlBf99RNyRXMMv0GxBFm
         LbGMXQ+A1Lew8FgNm53lP//G1/SkXGaeFT5IP7JdVIYSV66VaSCxyb7lDWbOelWAUK0H
         pAjZcsaSxnzHmVgEICXC9winWzETj6hLcLcobtWkNTtuYDxKl8dsWCy6P7gw3CHHmujm
         PWZQNqPEHXALYDjkcCIJ82BtZPL8HWd23PTyz+DTXPmwcD1Wcmzi0RanPccynm65l+iE
         QpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SmD9wC6S6HXd90fnEsiBq1bDT4eXjAjdn3ifAXDkVWs=;
        b=r1M58iNkw4AS7QVjDWL1yJLKy7E4RF5xqFGvHkdl4KrJ6QiljnnTFyOPmsFZL5DnCt
         y6Fq/JYyd2YfYIvUQx4fZAB9apYlUhp1KTmWnakE+Dj4IBUGOfngaLcG43jy4tEZdtRX
         VFYUqP20AkJJ1/hWhOKHqwD4I1tgo695JCcp4cNQ6y3Kb7EiP68Kqoj2CuDqMP+ypEjo
         oGoSfWaMn3mQNlgenEsO/0eMwzRQYETpBGU3siJfKgSZy1ksrlL8RgcM1vIPGnF9Vszh
         VquX/B/zPYIBfNRq0VbWlmEpWSiJfunH6v/a8noADDfjfb7rFfc9rQNlYvQEntDspc3D
         Tf2g==
X-Gm-Message-State: AOAM532x7iulSNjByxrAq9+nosAX7wrreVga1ofDHI5e2zVNPAZuRwEu
        e27bmgfmoVZJmYYxKmxDTHrYxPw+4/JQ6qa3NzvITg==
X-Google-Smtp-Source: ABdhPJzawrnH2EMmks7QDs/Pc4YJ5ewMCCSLedNnOcA5Y95fOx9YAK5PGJ7tBsWIXNFWnQsvh8k32i/RiPpXTob5++I=
X-Received: by 2002:a19:c508:: with SMTP id w8mr977965lfe.446.1626132672755;
 Mon, 12 Jul 2021 16:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPNVh5f3H7Gor-Dph7=2jAdme-4mRfCCb0gv=wjgHQtd7Cad=Q@mail.gmail.com>
 <acad5960-30b2-3693-9117-e0b054ee97a7@uwaterloo.ca>
In-Reply-To: <acad5960-30b2-3693-9117-e0b054ee97a7@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 12 Jul 2021 16:31:01 -0700
Message-ID: <CAPNVh5cm9LhLEi1Td3rbOWtWH5oCvZTTMRd+p5bu75Epr3mqwA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3 v0.2] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     avagin@google.com, bsegall@google.com, jannh@google.com,
        jnewsome@torproject.org, joel@joelfernandes.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, mkarsten@uwaterloo.ca, pabuhr@uwaterloo.ca,
        peterz@infradead.org, pjt@google.com, posk@posk.io,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 12, 2021 at 2:44 PM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  > sys_umcg_wait without next_tid puts the task in UMCG_IDLE state; wake
>  > wakes it. These are standard sched operations. If they are emulated
>  > via futexes, fast context switching will require something like
>  > FUTEX_SWAP that was NACKed last year.
>
> I understand these wait and wake semantics and the need for the fast
> context-switch(swap). As I see it, you need 3 operations:
>
> - SWAP: context-switch directly to a different thread, no scheduler involved
> - WAIT: block current thread, go back to server thread
> - WAKE: unblock target thread, add it to scheduler, e.g. through
>          idle_workers_ptr
>
> There is no existing syscalls to handle SWAP, so I agree sys_umcg_wait is
> needed for this to work.
>
> However, there already exists sys_futex to handle WAIT and WAKE. When a
> worker
> calls either sys_futex WAIT or sys_umcg_wait next_tid == NULL, in both case
> the worker will block, SWAP to the server and wait for FUTEX_WAKE,
> UMCG_WAIT_WAKE_ONLY respectively. It's not obvious to me that there
> would be
> performance difference and the semantics seem to be the same to me.
>
> So what I am asking is: is UMCG_WAIT_WAKE_ONLY needed?

Because the approach you described has been tried last year and was NACKed:
https://lore.kernel.org/lkml/20200722234538.166697-1-posk@posk.io/

In short, futex maintainers do not want to touch the existing futex
code at all other than for bugfixes. No new futex functionality,
period. See e.g. futex2 efforts:
https://lore.kernel.org/lkml/20210603195924.361327-1-andrealmeid@collabora.com/

> Is the idea to support workers directly context-switching among each other,
> without involving server threads and without going through idle_servers_ptr?

Yes.

> If so, can you explain some of the intended state transitions in this case.

Cooperative scheduling: workers can yield to each other (i.e. swap).
This allows building very fast concurrency primitives (mutexes,
producer-consumer queues, etc.). For example: a producer-consumer
queue: a producer: prepare an item, contex-switch to a consumer on CPU
synchronously: this can be done much faster than waking the consumer
asynchronously; helps a lot to reduce latency (throughput? not so
much)

>
>
>  > > However, I do not understand how the userspace is expected to use
> it. I also
>  > > do not understand if these link fields form a stack or a queue and
> where is
>  > > the head.
>  >
>  > When a server has nothing to do (no work to run), it is put into IDLE
>  > state and added to the list. The kernel wakes an IDLE server if a
>  > blocked worker unblocks.
>
>  From the code in umcg_wq_worker_running (Step 3), I am guessing users are
> expected to provide a global head somewhere in memory and
> umcg_task.idle_servers_ptr points to the head of the list for all workers.
> Servers are then added in user space using atomic_stack_push_user. Is this
> correct? I did not find any documentation on the list head.

This is going to change somewhat. I'll post a new patchset soon-ish
(later this week?)

>
> I like the idea that each worker thread points to a given list, it
> allows the
> possibility for separate containers with their own independent servers,
> workers
> and scheduling. However, it seems that the list itself could be implemented
> using existing kernel APIs, for example a futex or an event fd. Like so:
>
> struct umcg_task {
>       [...]
>
>       /**
>        * @idle_futex_ptr: pointer to a futex user for idle server threads.
>        *
>        * When waking a worker, the kernel decrements the pointed to
> futex value
>        * if it is non-zero and wakes a server if the decrement occurred.
>        *
>        * Server threads that have no work to do should increment the futex
>        * value and FUTEX_WAIT
>        */
>       uint64_t    idle_futex_ptr;    /* r/w */
>
>       [...]
> } __attribute__((packed, aligned(8 * sizeof(__u64))));
>
> I believe the futex approach, like the list, has the advantage that when
> there
> are no idle servers, checking the list requires no locking. I don't know if
> that can be achieved with eventfd.

As mentioned above, a futex-based solution was rejected by
maintainers. Believe me, I tried. Not only tried, we have a working
userspace scheduling stack on top of FUTEX_SWAP deployed internally at
Google, with some actual usage (mostly testing/debugging workloads). I
suggest we stop discussing futexes in this context - I do not see the
maintainers changing their position. And the approach used in this
patchset seems to work (and I actually like how the code is shaping
up).
