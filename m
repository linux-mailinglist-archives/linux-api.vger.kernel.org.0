Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB323C5F73
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 17:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhGLPni (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 11:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhGLPni (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 11:43:38 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA8C0613DD
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 08:40:49 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a18so24923943ljk.6
        for <linux-api@vger.kernel.org>; Mon, 12 Jul 2021 08:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sx2IKaIgugKwjbZh4RK43caAuNdf4BXBJqmTld2/qA0=;
        b=NEWvAFhouQ4e7j5ggnmprP9PikemmsFblqPRXXAHQZV2IEIy9r/NIHTZHWwR3+w77y
         vytETyqX23fY+KxY7hbkIW7ORnFbbomjiXm0CyBp5YoOi9dNBaU6aUVX2eTtAvoaiJpx
         88pP7V9XkV+SohNlwuz01hbF1qLbIHmyj6WUFPWI77r8LDVuhnT6p041rK4ltWjCS0nq
         DXM2Ykt0fnh9y3KnlZ10Mh/jnN2aG0C3JSDjAgqWoAxmI7nsT8R8YMrVBounYpCSVSgs
         ztiUoIhd6z0DW/FxaNp7+ewQWz7vmPmJUaE/BvdIOIaV0ZvOzYBkDBVlxCdDxgvu9kTF
         2ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sx2IKaIgugKwjbZh4RK43caAuNdf4BXBJqmTld2/qA0=;
        b=tGXCdbgLpUT1dMVtJMUJNDyjrZVL+bvQ+VpmCCbt3ZABV7NzpsyAb5eGGJ2fQvD+ZN
         ysZnw0i0p9E7Hluc6nGw6LHywwZOSOOAaX+q3oaNpNMxl74X6wW8Hjzb9XGtAyjtCHhO
         Opc1hCS4+d+P1lyDA6BQw0LccWgXLiSAYx4c/Lt9AK3qPXMlqFhQmkxSnbl+xm+tiYvR
         5aT3aVET1ExEOnjyPbcAb/VZj2n/qrf+Yv33+dEBvHQPGGmGvCfDiDsg5iqnwwAIsMbg
         A5Ve1TKh5GhJb1cEqe0yutXt67AGGcO67cL88ZmhVixR4GdeelNApLP7TYtlNvFd3GhP
         WZDA==
X-Gm-Message-State: AOAM530k4lZ+l+kPbO1IAaZoSrn/E2SpZvT6kWpkGxz6n/crmVtMT5OP
        vJb1dufPJcCRrYvXiqZV4dZ8MuO983DsAK0N7/Cr1Q==
X-Google-Smtp-Source: ABdhPJx7ptjXxjNKzZ0q3xfM3GMwdaBnal/nB7DdO8AnH1LjuIVERQ2StOYIo3Yb7v9EfaXpMrpJ4b6ar3kDLpO6qG0=
X-Received: by 2002:a05:651c:1684:: with SMTP id bd4mr26670952ljb.287.1626104447709;
 Mon, 12 Jul 2021 08:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210708194638.128950-4-posk@google.com> <bb30216c-4339-2703-9d87-9326af86a7b0@uwaterloo.ca>
In-Reply-To: <bb30216c-4339-2703-9d87-9326af86a7b0@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 12 Jul 2021 08:40:36 -0700
Message-ID: <CAPNVh5f3H7Gor-Dph7=2jAdme-4mRfCCb0gv=wjgHQtd7Cad=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3 v0.2] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     posk@posk.io, avagin@google.com, bsegall@google.com,
        jannh@google.com, jnewsome@torproject.org, joel@joelfernandes.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        tglx@linutronix.de, Peter Buhr <pabuhr@uwaterloo.ca>,
        Martin Karsten <mkarsten@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Jul 11, 2021 at 11:29 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  > Let's move the discussion to the new thread.
>
> I'm happy to start a new thread. I'm re-responding to my last post
> because many
> of my questions are still unanswered.
>
>  > + * State transitions:
>  > + *
>  > + * RUNNING => IDLE:   the current RUNNING task becomes IDLE by calling
>  > + *                    sys_umcg_wait();
>  >
>  > [...]
>  >
>  > +/**
>  > + * enum umcg_wait_flag - flags to pass to sys_umcg_wait
>  > + * @UMCG_WAIT_WAKE_ONLY: wake @self->next_tid, don't put @self to sleep;
>  > + * @UMCG_WF_CURRENT_CPU: wake @self->next_tid on the current CPU
>  > + *                       (use WF_CURRENT_CPU); @UMCG_WAIT_WAKE_ONLY
> must be set.
>  > + */
>  > +enum umcg_wait_flag {
>  > +    UMCG_WAIT_WAKE_ONLY = 1,
>  > +    UMCG_WF_CURRENT_CPU = 2,
>  > +};
>
> What is the purpose of using sys_umcg_wait without next_tid or with
> UMCG_WAIT_WAKE_ONLY? It looks like Java's park/unpark semantics to me,
> that is
> worker threads can use this for synchronization and mutual exclusion. In
> this
> case, how do these compare to using FUTEX_WAIT/FUTEX_WAKE?

sys_umcg_wait without next_tid puts the task in UMCG_IDLE state; wake
wakes it. These are standard sched operations. If they are emulated
via futexes, fast context switching will require something like
FUTEX_SWAP that was NACKed last year.

>
>
>  > +struct umcg_task {
>  > [...]
>  > +    /**
>  > +     * @server_tid: the TID of the server UMCG task that should be
>  > +     *              woken when this WORKER becomes BLOCKED. Can be zero.
>  > +     *
>  > +     *              If this is a UMCG server, @server_tid should
>  > +     *              contain the TID of @self - it will be used to find
>  > +     *              the task_struct to wake when pulled from
>  > +     *              @idle_servers.
>  > +     *
>  > +     * Read-only for the kernel, read/write for the userspace.
>  > +     */
>  > +    uint32_t    server_tid;        /* r   */
>  > [...]
>  > +    /**
>  > +     * @idle_servers_ptr: a single-linked list pointing to the list
>  > +     *                    of idle servers. Can be NULL.
>  > +     *
>  > +     * Readable/writable by both the kernel and the userspace: the
>  > +     * userspace adds items to the list, the kernel removes them.
>  > +     *
>  > +     * TODO: describe how the list works.
>  > +     */
>  > +    uint64_t    idle_servers_ptr;    /* r/w */
>  > [...]
>  > +} __attribute__((packed, aligned(8 * sizeof(__u64))));
>
>  From the comments and by elimination, I'm guessing that idle_servers_ptr is
> somehow used by servers to block until some worker threads become idle.
> However,
> I do not understand how the userspace is expected to use it. I also do not
> understand if these link fields form a stack or a queue and where is the
> head.

When a server has nothing to do (no work to run), it is put into IDLE
state and added to the list. The kernel wakes an IDLE server if a
blocked worker unblocks.

>
>
>  > +/**
>  > + * sys_umcg_ctl: (un)register a task as a UMCG task.
>  > + * @flags:       ORed values from enum umcg_ctl_flag; see below;
>  > + * @self:        a pointer to struct umcg_task that describes this
>  > + *               task and governs the behavior of sys_umcg_wait if
>  > + *               registering; must be NULL if unregistering.
>  > + *
>  > + * @flags & UMCG_CTL_REGISTER: register a UMCG task:
>  > + *         UMCG workers:
>  > + *              - self->state must be UMCG_TASK_IDLE
>  > + *              - @flags & UMCG_CTL_WORKER
>  > + *
>  > + *         If the conditions above are met, sys_umcg_ctl()
> immediately returns
>  > + *         if the registered task is a RUNNING server or basic task;
> an IDLE
>  > + *         worker will be added to idle_workers_ptr, and the worker
> put to
>  > + *         sleep; an idle server from idle_servers_ptr will be
> woken, if any.
>
> This approach to creating UMCG workers concerns me a little. My
> understanding
> is that in general, the number of servers controls the amount of parallelism
> in the program. But in the case of creating new UMCG workers, the new
> threads
> only respect the M:N threading model after sys_umcg_ctl has blocked.
> What does
> this mean for applications that create thousands of short lived tasks? Are
> users expcted to create pools of reusable UMCG workers?

Yes: task/thread creation is not as lightweight as just posting work
items onto a preexisting pool of workers.

>
>
> I would suggest adding at least one uint64_t field to the struct
> umcg_task that
> is left as-is by the kernel. This allows implementers of user-space
> schedulers to add scheduler specific data structures to the threads without
> needing some kind of table on the side.

This is usually achieved by embedding the kernel struct into a larger
userspace/TLS struct. For example:

struct umcg_task_user {
  struct umcg_task umcg_task;
  extra_user_data d1;
  extra_user_ptr p1;
  /* etc. */
} __aligned(...);
