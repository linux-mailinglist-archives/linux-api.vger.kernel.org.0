Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4565447AB7
	for <lists+linux-api@lfdr.de>; Mon,  8 Nov 2021 08:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbhKHHOP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 8 Nov 2021 02:14:15 -0500
Received: from out0.migadu.com ([94.23.1.103]:64755 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236151AbhKHHON (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 8 Nov 2021 02:14:13 -0500
Date:   Mon, 8 Nov 2021 15:12:07 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636355487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xtDYLmAkngfEINMYcDuGTVquk3Snzoag54C0UVglbe8=;
        b=UYrvWVdrKmC1WALCunaBtO4e9zlipfuBQ2YaIEI6AUI7EBB6LUJzctbLvDi+RndBrOBZZm
        rB4rw3H95xIkEDuszfyURNweKMW9cAf4+tA/QOmKZu8oFL3gie/+E94t/bcKbopOrKMLje
        DxYXU4HStsMqwkt51JHAT+Mr/KhaHBY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Oskolkov <posk@posk.io>
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
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v0.8 4/6] sched/umcg, lib/umcg: implement libumcg
Message-ID: <YYjNx2dTBRh/jJl4@geo.homenetwork>
References: <20211104195804.83240-1-posk@google.com>
 <20211104195804.83240-5-posk@google.com>
 <YYf/+LC77VUduuxD@geo.homenetwork>
 <CAFTs51X3s1zMVczUk_yHzLmLj5O+KaGmBy9go0EaVhphdNH_zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51X3s1zMVczUk_yHzLmLj5O+KaGmBy9go0EaVhphdNH_zg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Nov 07, 2021 at 10:27:02AM -0800, Peter Oskolkov wrote:
> On Sun, Nov 7, 2021 at 8:33 AM Tao Zhou <tao.zhou@linux.dev> wrote:
> >
> > On Thu, Nov 04, 2021 at 12:58:02PM -0700, Peter Oskolkov wrote:
> >
> > > +/* Update the state variable, set new timestamp. */
> > > +static bool umcg_update_state(uint64_t *state, uint64_t *prev, uint64_t next)
> > > +{
> > > +     uint64_t prev_ts = (*prev) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> > > +     struct timespec now;
> > > +     uint64_t next_ts;
> > > +     int res;
> > > +
> > > +     /*
> > > +      * clock_gettime(CLOCK_MONOTONIC, ...) takes less than 20ns on a
> > > +      * typical Intel processor on average, even when run concurrently,
> > > +      * so the overhead is low enough for most applications.
> > > +      *
> > > +      * If this is still too high, `next_ts = prev_ts + 1` should work
> > > +      * as well. The only real requirement is that the "timestamps" are
> > > +      * uniqueue per thread within a reasonable time frame.
> > > +      */
> > > +     res = clock_gettime(CLOCK_MONOTONIC, &now);
> > > +     assert(!res);
> > > +     next_ts = (now.tv_sec * NSEC_PER_SEC + now.tv_nsec) >>
> > > +             UMCG_STATE_TIMESTAMP_GRANULARITY;
> > > +
> > > +     /* Cut higher order bits. */
> > > +     next_ts &= ((1ULL << UMCG_STATE_TIMESTAMP_BITS) - 1);
> >
> > This is the right cut.. The same to the kernel side.
> 
> Yes, thanks!
> 
> >
> > > +
> > > +     if (next_ts == prev_ts)
> > > +             ++next_ts;
> > > +
> > > +#ifndef NDEBUG
> > > +     if (prev_ts > next_ts) {
> > > +             fprintf(stderr, "%s: time goes back: prev_ts: %lu "
> > > +                             "next_ts: %lu diff: %lu\n", __func__,
> > > +                             prev_ts, next_ts, prev_ts - next_ts);
> > > +     }
> > > +#endif
> > > +
> > > +     /* Remove old timestamp, if any. */
> > > +     next &= ((1ULL << (64 - UMCG_STATE_TIMESTAMP_BITS)) - 1);
> > > +
> > > +     /* Set the new timestamp. */
> > > +     next |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
> > > +
> > > +     /*
> > > +      * TODO: review whether memory order below can be weakened to
> > > +      * memory_order_acq_rel for success and memory_order_acquire for
> > > +      * failure.
> > > +      */
> > > +     return atomic_compare_exchange_strong_explicit(state, prev, next,
> > > +                     memory_order_seq_cst, memory_order_seq_cst);
> > > +}
> > > +
> >
> > > +static void task_unlock(struct umcg_task_tls *task, uint64_t expected_state,
> > > +             uint64_t new_state)
> > > +{
> > > +     bool ok;
> > > +     uint64_t next;
> > > +     uint64_t prev = atomic_load_explicit(&task->umcg_task.state_ts,
> > > +                                     memory_order_acquire);
> > > +
> > > +     next = ((prev & ~UMCG_TASK_STATE_MASK_FULL) | new_state) & ~UMCG_TF_LOCKED;
> >
> > Use UMCG_TASK_STATE_MASK instead and the other state flag can be checked.
> 
> Why? We want to clear the TF_LOCKED flag and keep every other bit of
> state, including other state flags (but excluding timestamp).

This one is different because the task state flag is also masked by
UMCG_TASK_STATE_MASK_FULL. But no effect I think. Document says that

  '
  PREEMPTED: the userspace indicates it wants the worker to be preempted;
  there are no situations when both LOCKED and PREEMPTED flags are set at
  the same time.
  '

The task state flag this time only have UMCG_TF_LOCKED be set even if we
cleared the task state flag. 
> 
> 
> >
> > All others places that use UMCG_TASK_STATE_MASK_FULL to mask to check
> > the task state may seems reasonable if the state flag not allowed to
> > be set when we check that task state, otherwise use UMCG_TASK_STATE_MASK
> > will be enough.
> >
> > Not sure.
> >
> >
> > Thanks,
> > Tao
> > > +     assert(next != prev);
> > > +     assert((prev & UMCG_TASK_STATE_MASK_FULL & ~UMCG_TF_LOCKED) == expected_state);
> > > +
> > > +     ok = umcg_update_state(&task->umcg_task.state_ts, &prev, next);
> > > +     assert(ok);
> > > +}
