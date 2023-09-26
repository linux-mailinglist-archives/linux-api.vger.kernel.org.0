Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3779B7AF7FD
	for <lists+linux-api@lfdr.de>; Wed, 27 Sep 2023 04:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjI0CKS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Sep 2023 22:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbjI0CIR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Sep 2023 22:08:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA51BDC
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 16:49:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53317e29b00so9411a12.0
        for <linux-api@vger.kernel.org>; Tue, 26 Sep 2023 16:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695772186; x=1696376986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CyUv2CwxL0D3uncmLeA2shMf/k2ZFJQLjIGEBW4JFSg=;
        b=PjcA7+iS7y0OOpfZYpL0dvjysWlrP4+d3gPeIB0Isn+cTg9/f7rBPx/VgTP2LO8x/J
         zFWmQlqvO3A5lSgfS5GOhB/v3N+cU62tY30V2pSHyr3q2ndGdZeDHJDjnm8r/JPzZIVH
         6+pozDsZRZglLSVldxI2EmbEZbqrQSNyoEkskOJN2wxKdlKvNddH1mYd496mxreQ3K1y
         2ZDjXeCAb1O+QPVFREyVuSqIWaxZ9NaFbHgQ6LGWZiWFqHfYxErTm3YqkTvBmJSZSYq5
         UPL77OFKfefyxJw2KAuqMvakdYqs+o6sDlYaC41W6TlM5S3/BXACLjR17XHUTgxs5Tnv
         ZAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695772186; x=1696376986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CyUv2CwxL0D3uncmLeA2shMf/k2ZFJQLjIGEBW4JFSg=;
        b=Ed3+WwC5wuAUuiWIZXX2zGhEgBdjX8IZLFB6z17VazLkkYDUfHojfHyP+KRWNfJ+jA
         X5qeKqtNaKeIdu5hl19eLCToICVtBCt7bsjmXTSo/6x9eFOkaFAFHqMfvalrgg1/+LlL
         g6qi6ns7ENlKUVVl+i1mp4rbJaROnPlTyJMXzLbOenhdLoL89TjpvIYHrQofw/VNC9BI
         pyr9cwXajSv/OIVg0Ek21IhFf/OSF7fhWrfqwrJmdjrwRzTlQ2W9tItEpkNiqYxZdTau
         1Xq2RbD3GPTANwOvXQVIiDiRVrnbYA1iWKqA/OtorKShvu90vUB47I3hrcYsTEef5+sb
         daMQ==
X-Gm-Message-State: AOJu0Yxp562l82GTSrhKhmvGF1Be03SRFNWv6zZHWWgfaJ/FH9srViNI
        PqckUq9BHUerXpxUQuS52Ks1C00KqoYNvaNkt7fZOw==
X-Google-Smtp-Source: AGHT+IHB12s2y9vwNSt1yArp3bop0uYzyGr5UPRNNf5oL2/QSqlpY1YC3FrO8XjSV9wJ9cbqEGIL6xJ3bK34u/sk8Jo=
X-Received: by 2002:a50:d08c:0:b0:52f:3376:8d7 with SMTP id
 v12-20020a50d08c000000b0052f337608d7mr167719edd.5.1695772185565; Tue, 26 Sep
 2023 16:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <2c421e36-a749-7dc3-3562-7a8cf256df3c@efficios.com> <20230926205215.472650-1-dvyukov@google.com>
In-Reply-To: <20230926205215.472650-1-dvyukov@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Sep 2023 16:49:32 -0700
Message-ID: <CACT4Y+beLh1qnHF9bxhMUcva8KyuvZs7Mg_31SGK5xSoR=3m1A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
To:     mathieu.desnoyers@efficios.com
Cc:     David.Laight@aculab.com, alexander@mihalicyn.com,
        andrealmeid@igalia.com, boqun.feng@gmail.com, brauner@kernel.org,
        carlos@redhat.com, ckennelly@google.com, corbet@lwn.net,
        dave@stgolabs.net, dvhart@infradead.org, fweimer@redhat.com,
        goldstein.w.n@gmail.com, hpa@zytor.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, pjt@google.com, posk@posk.io,
        rostedt@goodmis.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 26 Sept 2023 at 13:52, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> >> I don't see why we can't stick this directly into struct rseq because
> >> it's all public anyway.
> >
> > The motivation for moving this to a different cache line is to handle
> > the prior comment from Boqun, who is concerned that busy-waiting
> > repeatedly loading a field from struct rseq will cause false-sharing and
> > make other stores to that cache line slower, especially stores to
> > rseq_cs to begin rseq critical sections, thus slightly increasing the
> > overhead of rseq critical sections taken while mutexes are held.
> >
> > If we want to embed this field into struct rseq with its own cache line,
> > then we need to add a lot of padding, which is inconvenient.
> >
> > That being said, perhaps this is premature optimization, what do you think ?
>
> Hi Mathieu, Florian,
>
> This is exciting!
>
> I thought the motivation for moving rseq_sched_state out of struct rseq
> is lifetime management problem. I assume when a thread locks a mutex,
> it stores pointer to rseq_sched_state in the mutex state for other
> threads to poll. So the waiting thread would do something along the following
> lines:
>
> rseq_sched_state* state = __atomic_load_n(mutex->sched_state, __ATOMIC_RELAXED);
> if (state && !(state->state & RSEQ_SCHED_STATE_FLAG_ON_CPU))
>         futex_wait();
>
> Now if the state is struct rseq, which is stored in TLS,
> then the owning thread can unlock the mutex, exit and unmap TLS in between.
> Consequently, load of state->state will cause a paging fault.
>
> And we do want rseq in TLS to save 1 indirection.
>
> If rseq_sched_state is separated from struct rseq, then it can be allocated
> in type stable memory that is never unmapped.
>
> What am I missing here?
>
> However, if we can store this state in struct rseq, then an alternative
> interface would for the kernel to do:
>
> rseq->cpu_id = -1;
>
> to denote that the thread is not running on any CPU.
> I think it kinda makes sense, rseq->cpu_id is the thread's current CPU,
> and -1 naturally means "not running at all". And we already store -1
> right after init, so it shouldn't be a surprising value.

As you may know we experimented with "virtual CPUs" in tcmalloc. The
extension allows kernel to assign dense virtual CPU numbers to running
threads instead of real sparse CPU numbers:

https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/linux_syscall_support.h#L30-L41

Recently I added another change that [ab]uses rseq in an interesting
way. We want to get notifications about thread re-scheduling. A bit
simplified version of this is as follows:
we don't use rseq.cpu_id_start for its original purpose, so instead we
store something else there with a high bit set. Real CPU numbers don't
have a high bit set (at least while you have less than 2B CPUs :)).
This allows us to distinguish the value we stored in rseq.cpu_id_start
from real CPU id stored by the kernel.
Inside of rseq critical section we check if rseq.cpu_id_start has high
bit set, and if not, then we know that we were just rescheduled, so we
can do some additional work and update rseq.cpu_id_start to have high
bit set.

In reality it's a bit more involved since the field is actually 8
bytes and only partially overlaps with rseq.cpu_id_start (it's an
8-byte pointer with high 4 bytes overlap rseq.cpu_id_start):

https://github.com/google/tcmalloc/blob/229908285e216cca8b844c1781bf16b838128d1b/tcmalloc/internal/percpu.h#L101-L165

I am thinking if we could extend the current proposed interface in a
way that would be more flexible and would satisfy all of these use
cases (spinlocks, and possibility of using virtual CPUs and
rescheduling notifications). In the end they all need a very similar
thing: kernel writing some value at some user address when a thread is
de-scheduled.

The minimal support we need for tcmalloc is an 8-byte user address +
kernel writing 0 at that address when a thread is descheduled.

The most flexible option to support multiple users
(malloc/spinlocks/something else) would be as follows:

User-space passes an array of structs with address + size (1/2/4/8
bytes) + value.
Kernel intereates over the array when the thread is de-scheduled and
writes the specified value at the provided address/size.
Something along the following lines (pseudo-code):

struct rseq {
    ...
    struct rseq_desched_notif_t* desched_notifs;
    int desched_notif_count;
};

struct rseq_desched_notif_t {
    void* addr;
    uint64_t value;
    int size;
};

static inline void rseq_preempt(struct task_struct *t)
{
    ...
    for (int i = 0; i < t->rseq->desched_notif_count; i++) {
        switch (t->rseq->desched_notifs[i].size) {
        case 1: put_user1(t->rseq->desched_notifs[i].addr,
t->rseq->desched_notifs[i].value);
        case 2: put_user2(t->rseq->desched_notifs[i].addr,
t->rseq->desched_notifs[i].value);
        case 4: put_user4(t->rseq->desched_notifs[i].addr,
t->rseq->desched_notifs[i].value);
        case 8: put_user8(t->rseq->desched_notifs[i].addr,
t->rseq->desched_notifs[i].value);
        }
    }
}
