Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7565D4473D7
	for <lists+linux-api@lfdr.de>; Sun,  7 Nov 2021 17:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbhKGQgE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Nov 2021 11:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhKGQgE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Nov 2021 11:36:04 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E43C061570;
        Sun,  7 Nov 2021 08:33:21 -0800 (PST)
Date:   Mon, 8 Nov 2021 00:34:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636302799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RS/Nz/UG56GlGiRm7O/muf8wz5uSzD19AWx+yQ3NlEo=;
        b=G8+4iXdmP/uX9z5jnC2n5GBIzfBb+e/KpFD9HAleCwzk6ibUcXgsIj2a6HgqhU0YTDoi9U
        BYRRYTKTJBzN6G+gZ/ZwHnDh1MHVb5cX144Hvoa/14Pv1Bog9CWmp8FdYGnQoduqeg1EgN
        aW1XXWa/2iIafq4PyJ4LLPHtX1NKKG4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Tao Zhou <tao.zhou@linux.dev>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Tao Zhou <tao.zhou@linux.dev>
Subject: Re: [PATCH v0.8 4/6] sched/umcg, lib/umcg: implement libumcg
Message-ID: <YYf/+LC77VUduuxD@geo.homenetwork>
References: <20211104195804.83240-1-posk@google.com>
 <20211104195804.83240-5-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104195804.83240-5-posk@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 04, 2021 at 12:58:02PM -0700, Peter Oskolkov wrote:

> +/* Update the state variable, set new timestamp. */
> +static bool umcg_update_state(uint64_t *state, uint64_t *prev, uint64_t next)
> +{
> +	uint64_t prev_ts = (*prev) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> +	struct timespec now;
> +	uint64_t next_ts;
> +	int res;
> +
> +	/*
> +	 * clock_gettime(CLOCK_MONOTONIC, ...) takes less than 20ns on a
> +	 * typical Intel processor on average, even when run concurrently,
> +	 * so the overhead is low enough for most applications.
> +	 *
> +	 * If this is still too high, `next_ts = prev_ts + 1` should work
> +	 * as well. The only real requirement is that the "timestamps" are
> +	 * uniqueue per thread within a reasonable time frame.
> +	 */
> +	res = clock_gettime(CLOCK_MONOTONIC, &now);
> +	assert(!res);
> +	next_ts = (now.tv_sec * NSEC_PER_SEC + now.tv_nsec) >>
> +		UMCG_STATE_TIMESTAMP_GRANULARITY;
> +
> +	/* Cut higher order bits. */
> +	next_ts &= ((1ULL << UMCG_STATE_TIMESTAMP_BITS) - 1);

This is the right cut.. The same to the kernel side.

> +
> +	if (next_ts == prev_ts)
> +		++next_ts;
> +
> +#ifndef NDEBUG
> +	if (prev_ts > next_ts) {
> +		fprintf(stderr, "%s: time goes back: prev_ts: %lu "
> +				"next_ts: %lu diff: %lu\n", __func__,
> +				prev_ts, next_ts, prev_ts - next_ts);
> +	}
> +#endif
> +
> +	/* Remove old timestamp, if any. */
> +	next &= ((1ULL << (64 - UMCG_STATE_TIMESTAMP_BITS)) - 1);
> +
> +	/* Set the new timestamp. */
> +	next |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
> +
> +	/*
> +	 * TODO: review whether memory order below can be weakened to
> +	 * memory_order_acq_rel for success and memory_order_acquire for
> +	 * failure.
> +	 */
> +	return atomic_compare_exchange_strong_explicit(state, prev, next,
> +			memory_order_seq_cst, memory_order_seq_cst);
> +}
> +

> +static void task_unlock(struct umcg_task_tls *task, uint64_t expected_state,
> +		uint64_t new_state)
> +{
> +	bool ok;
> +	uint64_t next;
> +	uint64_t prev = atomic_load_explicit(&task->umcg_task.state_ts,
> +					memory_order_acquire);
> +
> +	next = ((prev & ~UMCG_TASK_STATE_MASK_FULL) | new_state) & ~UMCG_TF_LOCKED;

Use UMCG_TASK_STATE_MASK instead and the other state flag can be checked.

All others places that use UMCG_TASK_STATE_MASK_FULL to mask to check
the task state may seems reasonable if the state flag not allowed to
be set when we check that task state, otherwise use UMCG_TASK_STATE_MASK
will be enough.

Not sure.


Thanks,
Tao
> +	assert(next != prev);
> +	assert((prev & UMCG_TASK_STATE_MASK_FULL & ~UMCG_TF_LOCKED) == expected_state);
> +
> +	ok = umcg_update_state(&task->umcg_task.state_ts, &prev, next);
> +	assert(ok);
> +}
