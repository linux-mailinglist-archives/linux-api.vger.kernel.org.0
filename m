Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04B745F630
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbhKZVTk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 16:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241310AbhKZVRj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 16:17:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06239C061379;
        Fri, 26 Nov 2021 13:08:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637960895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6VUv4Z18iiVkYNnHOfhYKc+DQU8mlJLl1Ev8ZazBU0=;
        b=DU2kSHhLtGnX5Fg26OQwu7y/i8DrtEnvezQfnAeUGVSMr7tG8SmqRbFi6laxe6J1393G0i
        daMgBCVSJ72QK5MH8iZPI2Da2hBLeGngGM9FHYo9NgkVjqwdM1tnfrI6gMVylsweu8+yWZ
        32cg4FavROT6Rz47R0ppjPM4zDZZ9p1k1Jq8kh0yHiPVrexA2J0adb54AsdjqjUV/knSLb
        nScQ89Nk+60yNfIkTT9Y1paTTvlusCSj0biO5paVLXKRkGFmxD+nJs8RTP3Pyx86qanVNm
        I1p9T9oXRkq2UxcoXsnHOrO3Nyrzf0TzOAV+NvcUifdQWi+/QA2N4VwL281gIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637960895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6VUv4Z18iiVkYNnHOfhYKc+DQU8mlJLl1Ev8ZazBU0=;
        b=vYDvWMO+6QFlanuZcOzyQH1Qg2pXZJYikz93JSFQCQTmUNkeqYUQnXCEQDMcYMK4WIGB1l
        HJN8zF2MfU7nTKDQ==
To:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
In-Reply-To: <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
Date:   Fri, 26 Nov 2021 22:08:14 +0100
Message-ID: <87a6hqhbgh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26 2021 at 18:09, Peter Zijlstra wrote:
> +
> +	if (timo) {
> +		hrtimer_init_sleeper_on_stack(&timeout, tsk->umcg_clock,
> +					      HRTIMER_MODE_ABS);
> +		hrtimer_set_expires_range_ns(&timeout.timer, (s64)timo,
> +					     tsk->timer_slack_ns);
> +	}
> +
> +	for (;;) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		ret = -EINTR;
> +		if (signal_pending(current))
> +			break;
> +
> +		/*
> +		 * Faults can block and scribble our wait state.
> +		 */
> +		pagefault_disable();
> +		if (get_user(state, &self->state)) {
> +			pagefault_enable();
> +
> +			ret = -EFAULT;
> +			if (page) {
> +				unpin_user_page(page);
> +				page = NULL;
> +				break;
> +			}
> +
> +			if (pin_user_pages_fast((unsigned long)self, 1, 0, &page) != 1) {
> +				page = NULL;
> +				break;
> +			}
> +
> +			continue;
> +		}
> +
> +		if (page) {
> +			unpin_user_page(page);
> +			page = NULL;
> +		}
> +		pagefault_enable();
> +
> +		state &= UMCG_TASK_MASK;
> +		if (state != UMCG_TASK_RUNNABLE) {
> +			ret = 0;
> +			if (state == UMCG_TASK_RUNNING)
> +				break;
> +
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		if (timo)
> +			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
> +
> +		freezable_schedule();

You can replace the whole hrtimer foo with

                if (!schedule_hrtimeout_range_clock(timo ? &timo : NULL,
                                                    tsk->timer_slack_ns,
                                                    HRTIMER_MODE_ABS,
                                                    tsk->umcg_clock)) {
                	ret = -ETIMEOUT;
                        break;
                }

Thanks,

        tglx
