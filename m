Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C194474F3
	for <lists+linux-api@lfdr.de>; Sun,  7 Nov 2021 19:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbhKGS35 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Nov 2021 13:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhKGS34 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Nov 2021 13:29:56 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F1C061570
        for <linux-api@vger.kernel.org>; Sun,  7 Nov 2021 10:27:13 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id t13so12044255uad.9
        for <linux-api@vger.kernel.org>; Sun, 07 Nov 2021 10:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6qDJwFCEM31eDxN9rlVQlXj0fTGNQbXIopORuPZmxY=;
        b=HHq08N71FdqLDSBMmVrSxi2iRW5U0RuXPfXSZK2+ZlbELTTKuD4Rvcgmwo8as/5req
         wZn7JWk2/g4Af0dGyxzXFj1MKwdmqx/PG36+X9A0R3LayClasbxWh1eSztu4IX3dwHSY
         OwtiJZIIKVG6p11SIa6kjJJv9QkuQsg8GyISsBXFIQG05pmAimsRoGb65PwbVbxcaGbL
         a3xN9lwMeQ/Xcesx2/Rmtlyyxawge79NNKtRn3xxigZp3stme19KtIjBux+kQEltm0ef
         gW65S/uUvFg8/zd4ijjMn0ySUfygvg2eDwB7wikDjFJdrMHuKtLUtO2eA8vEq5It6DXy
         vLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6qDJwFCEM31eDxN9rlVQlXj0fTGNQbXIopORuPZmxY=;
        b=xCiurFdpl/VwqmsDInjOhQfXHH9GAFJFDVisZBAkmZ/Zpy/yT8o8fA1+g1Sq1sRJXg
         ElK+ZwXg3Kj/5PQyc2FInJheNqXNv2a+eKRVeW98sx7KaCTv/bUkY1sImcBZXb+0iEjt
         +ANIsYtKFZthDJVjOL2YBOJT9Ip7P2p6rbwCFkYHwpReIVl5zeJUCthSBBTzuvqNAU8W
         p764cFw+TEFLMNlGBbNbSQcqrbIbDoXN/7DJF1dZVrEMCjSw4pAEfmH5u3SjINmhxhyH
         Ys6xG0DmGagXRQ7kAYw2iklTOTCg1yK+Do7kTA1bAMIxljhbch+cJ5Mnvne+2zQoK+WQ
         jfaQ==
X-Gm-Message-State: AOAM533u1vCI4HoHFfibHIG6bfRlTgCSR/66o6/Y7AtdHnn4Ze4ukZK1
        BOXckjmQ8/k6jy6yIwRZoiaH1nUhfpUmyfh+qoJTnw==
X-Google-Smtp-Source: ABdhPJza9YuGM/kdbE744obc3oIb52ZoQIrUfYxUCfUyaGjbBE002Y7XSzSzXpb08vt4RJoxXRg988EmASpBI8MOAIM=
X-Received: by 2002:a67:fa0f:: with SMTP id i15mr1303407vsq.16.1636309632812;
 Sun, 07 Nov 2021 10:27:12 -0800 (PST)
MIME-Version: 1.0
References: <20211104195804.83240-1-posk@google.com> <20211104195804.83240-5-posk@google.com>
 <YYf/+LC77VUduuxD@geo.homenetwork>
In-Reply-To: <YYf/+LC77VUduuxD@geo.homenetwork>
From:   Peter Oskolkov <posk@posk.io>
Date:   Sun, 7 Nov 2021 10:27:02 -0800
Message-ID: <CAFTs51X3s1zMVczUk_yHzLmLj5O+KaGmBy9go0EaVhphdNH_zg@mail.gmail.com>
Subject: Re: [PATCH v0.8 4/6] sched/umcg, lib/umcg: implement libumcg
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
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

On Sun, Nov 7, 2021 at 8:33 AM Tao Zhou <tao.zhou@linux.dev> wrote:
>
> On Thu, Nov 04, 2021 at 12:58:02PM -0700, Peter Oskolkov wrote:
>
> > +/* Update the state variable, set new timestamp. */
> > +static bool umcg_update_state(uint64_t *state, uint64_t *prev, uint64_t next)
> > +{
> > +     uint64_t prev_ts = (*prev) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> > +     struct timespec now;
> > +     uint64_t next_ts;
> > +     int res;
> > +
> > +     /*
> > +      * clock_gettime(CLOCK_MONOTONIC, ...) takes less than 20ns on a
> > +      * typical Intel processor on average, even when run concurrently,
> > +      * so the overhead is low enough for most applications.
> > +      *
> > +      * If this is still too high, `next_ts = prev_ts + 1` should work
> > +      * as well. The only real requirement is that the "timestamps" are
> > +      * uniqueue per thread within a reasonable time frame.
> > +      */
> > +     res = clock_gettime(CLOCK_MONOTONIC, &now);
> > +     assert(!res);
> > +     next_ts = (now.tv_sec * NSEC_PER_SEC + now.tv_nsec) >>
> > +             UMCG_STATE_TIMESTAMP_GRANULARITY;
> > +
> > +     /* Cut higher order bits. */
> > +     next_ts &= ((1ULL << UMCG_STATE_TIMESTAMP_BITS) - 1);
>
> This is the right cut.. The same to the kernel side.

Yes, thanks!

>
> > +
> > +     if (next_ts == prev_ts)
> > +             ++next_ts;
> > +
> > +#ifndef NDEBUG
> > +     if (prev_ts > next_ts) {
> > +             fprintf(stderr, "%s: time goes back: prev_ts: %lu "
> > +                             "next_ts: %lu diff: %lu\n", __func__,
> > +                             prev_ts, next_ts, prev_ts - next_ts);
> > +     }
> > +#endif
> > +
> > +     /* Remove old timestamp, if any. */
> > +     next &= ((1ULL << (64 - UMCG_STATE_TIMESTAMP_BITS)) - 1);
> > +
> > +     /* Set the new timestamp. */
> > +     next |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
> > +
> > +     /*
> > +      * TODO: review whether memory order below can be weakened to
> > +      * memory_order_acq_rel for success and memory_order_acquire for
> > +      * failure.
> > +      */
> > +     return atomic_compare_exchange_strong_explicit(state, prev, next,
> > +                     memory_order_seq_cst, memory_order_seq_cst);
> > +}
> > +
>
> > +static void task_unlock(struct umcg_task_tls *task, uint64_t expected_state,
> > +             uint64_t new_state)
> > +{
> > +     bool ok;
> > +     uint64_t next;
> > +     uint64_t prev = atomic_load_explicit(&task->umcg_task.state_ts,
> > +                                     memory_order_acquire);
> > +
> > +     next = ((prev & ~UMCG_TASK_STATE_MASK_FULL) | new_state) & ~UMCG_TF_LOCKED;
>
> Use UMCG_TASK_STATE_MASK instead and the other state flag can be checked.

Why? We want to clear the TF_LOCKED flag and keep every other bit of
state, including other state flags (but excluding timestamp).


>
> All others places that use UMCG_TASK_STATE_MASK_FULL to mask to check
> the task state may seems reasonable if the state flag not allowed to
> be set when we check that task state, otherwise use UMCG_TASK_STATE_MASK
> will be enough.
>
> Not sure.
>
>
> Thanks,
> Tao
> > +     assert(next != prev);
> > +     assert((prev & UMCG_TASK_STATE_MASK_FULL & ~UMCG_TF_LOCKED) == expected_state);
> > +
> > +     ok = umcg_update_state(&task->umcg_task.state_ts, &prev, next);
> > +     assert(ok);
> > +}
