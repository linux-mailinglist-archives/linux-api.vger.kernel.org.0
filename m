Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D008446F4D
	for <lists+linux-api@lfdr.de>; Sat,  6 Nov 2021 18:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhKFRWb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 6 Nov 2021 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhKFRWb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 6 Nov 2021 13:22:31 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72A5C061570;
        Sat,  6 Nov 2021 10:19:49 -0700 (PDT)
Date:   Sun, 7 Nov 2021 01:20:26 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1636219186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMmhs9HYhNcGgQ65VphvZRVIvAdwsAifoT5Xiz9YzPo=;
        b=gcXkaPyby+FXI8KETJ5qGraTykKZH6YXSiFsHLqtJ3Xv528zpUisCBfyGFglMTVL6FWOPT
        gUzrN+hHi/CBchqgxFh1QGzQ6ZiIfbkhhMPtbDz39EjUuS2KYELg2Rkv6mJVp32TYmW3uF
        ubdvRSbonJ8tGxOrXP4Niobp7BWOolM=
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
Subject: Re: [PATCH v0.8 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YYa5WjXTrhYKmoze@geo.homenetwork>
References: <20211104195804.83240-1-posk@google.com>
 <20211104195804.83240-4-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104195804.83240-4-posk@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: tao.zhou@linux.dev
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

On Thu, Nov 04, 2021 at 12:58:01PM -0700, Peter Oskolkov wrote:

> +/**
> + * umcg_update_state: atomically update umcg_task.state_ts, set new timestamp.
> + * @state_ts   - points to the state_ts member of struct umcg_task to update;
> + * @expected   - the expected value of state_ts, including the timestamp;
> + * @desired    - the desired value of state_ts, state part only;
> + * @may_fault  - whether to use normal or _nofault cmpxchg.
> + *
> + * The function is basically cmpxchg(state_ts, expected, desired), with extra
> + * code to set the timestamp in @desired.
> + */
> +static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
> +				bool may_fault)
> +{
> +	u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> +	u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
> +
> +	/* Cut higher order bits. */
> +	next_ts &= UMCG_TASK_STATE_MASK_FULL;

next_ts &= (1 << UMCG_STATE_TIMESTAMP_BITS) - 1; or am I wrong.

> +	if (next_ts == curr_ts)
> +		++next_ts;
> +
> +	/* Remove an old timestamp, if any. */
> +	desired &= UMCG_TASK_STATE_MASK_FULL;
> +
> +	/* Set the new timestamp. */
> +	desired |= (next_ts << (64 - UMCG_STATE_TIMESTAMP_BITS));
> +
> +	if (may_fault)
> +		return cmpxchg_user_64(state_ts, expected, desired);
> +
> +	return cmpxchg_user_64_nofault(state_ts, expected, desired);
> +}
> +
> +/**
> + * sys_umcg_ctl: (un)register the current task as a UMCG task.
> + * @flags:       ORed values from enum umcg_ctl_flag; see below;
> + * @self:        a pointer to struct umcg_task that describes this
> + *               task and governs the behavior of sys_umcg_wait if
> + *               registering; must be NULL if unregistering.
> + *
> + * @flags & UMCG_CTL_REGISTER: register a UMCG task:
> + *         UMCG workers:
> + *              - @flags & UMCG_CTL_WORKER
> + *              - self->state must be UMCG_TASK_BLOCKED
> + *         UMCG servers:
> + *              - !(@flags & UMCG_CTL_WORKER)
> + *              - self->state must be UMCG_TASK_RUNNING
> + *
> + *         All tasks:
> + *              - self->next_tid must be zero
> + *
> + *         If the conditions above are met, sys_umcg_ctl() immediately returns
> + *         if the registered task is a server; a worker will be added to
> + *         idle_workers_ptr, and the worker put to sleep; an idle server
> + *         from idle_server_tid_ptr will be woken, if present.
> + *
> + * @flags == UMCG_CTL_UNREGISTER: unregister a UMCG task. If the current task
> + *           is a UMCG worker, the userspace is responsible for waking its
> + *           server (before or after calling sys_umcg_ctl).
> + *
> + * Return:
> + * 0                - success
> + * -EFAULT          - failed to read @self
> + * -EINVAL          - some other error occurred
> + */
> +SYSCALL_DEFINE2(umcg_ctl, u32, flags, struct umcg_task __user *, self)
> +{
> +	struct umcg_task ut;
> +
> +	if (flags == UMCG_CTL_UNREGISTER) {
> +		if (self || !current->umcg_task)
> +			return -EINVAL;
> +
> +		if (current->flags & PF_UMCG_WORKER)
> +			umcg_handle_exiting_worker();
> +		else
> +			umcg_clear_task(current);
> +
> +		return 0;
> +	}
> +
> +	if (!(flags & UMCG_CTL_REGISTER))
> +		return -EINVAL;
> +
> +	flags &= ~UMCG_CTL_REGISTER;
> +	if (flags && flags != UMCG_CTL_WORKER)
> +		return -EINVAL;
> +
> +	if (current->umcg_task || !self)
> +		return -EINVAL;
> +
> +	if (copy_from_user(&ut, self, sizeof(ut)))
> +		return -EFAULT;
> +
> +	if (ut.next_tid)
> +		return -EINVAL;
> +
> +	if (flags == UMCG_CTL_WORKER) {
> +		if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_BLOCKED)

Or use UMCG_TASK_STATE_MASK that is enough.

> +			return -EINVAL;
> +
> +		WRITE_ONCE(current->umcg_task, self);
> +		current->flags |= PF_UMCG_WORKER;
> +
> +		/* Trigger umcg_handle_resuming_worker() */
> +		set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
> +	} else {
> +		if ((ut.state_ts & UMCG_TASK_STATE_MASK_FULL) != UMCG_TASK_RUNNING)

The same here.

> +			return -EINVAL;
> +
> +		WRITE_ONCE(current->umcg_task, self);
> +	}
> +
> +	return 0;
> +}
> +


Thanks,
Tao
