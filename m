Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940D440CA10
	for <lists+linux-api@lfdr.de>; Wed, 15 Sep 2021 18:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229467AbhIOQa7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Sep 2021 12:30:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42962 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIOQa7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Sep 2021 12:30:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A42F91F43794
Message-ID: <cbf1dbc3-6c38-0b53-8eb9-69530c8220b9@collabora.com>
Date:   Wed, 15 Sep 2021 13:29:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 16/20] futex: Implement sys_futex_waitv()
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        bigeasy@linutronix.de, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mingo@redhat.com, rostedt@goodmis.org, dvhart@infradead.org,
        mtk.manpages@gmail.com, dave@stgolabs.net, arnd@arndb.de,
        tglx@linutronix.de
References: <20210915140710.596174479@infradead.org>
 <20210915141525.621568509@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20210915141525.621568509@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 11:07 de 15/09/21, Peter Zijlstra escreveu:
> From: André Almeida <andrealmeid@collabora.com>
> 
> Add support to wait on multiple futexes. This is the interface
> implemented by this syscall:
> 
> futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
> 	    unsigned int flags, struct timespec *timo)
> 
> +/**
> + * futex_wait_multiple_setup - Prepare to wait and enqueue multiple futexes
> + * @vs:		The futex list to wait on
> + * @count:	The size of the list
> + * @awaken:	Index of the last awoken futex, if any. Used to notify the
> + *		caller that it can return this index to userspace (return parameter)
> + *
> + * Prepare multiple futexes in a single step and enqueue them. This may fail if
> + * the futex list is invalid or if any futex was already awoken. On success the
> + * task is ready to interruptible sleep.
> + *
> + * Return:
> + *  -  1 - One of the futexes was awaken by another thread
> + *  -  0 - Success
> + *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
> + */
> +static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *awaken)
> +{
> +	struct futex_hash_bucket *hb;
> +	bool retry = false;
> +	int ret, i;
> +	u32 uval;
> +
> +	/*
> +	 * Enqueuing multiple futexes is tricky, because we need to enqueue
> +	 * each futex in the list before dealing with the next one to avoid
> +	 * deadlocking on the hash bucket. But, before enqueuing, we need to
> +	 * make sure that current->state is TASK_INTERRUPTIBLE, so we don't
> +	 * absorb any awake events, which cannot be done before the
> +	 * get_futex_key of the next key, because it calls get_user_pages,
> +	 * which can sleep. Thus, we fetch the list of futexes keys in two
> +	 * steps, by first pinning all the memory keys in the futex key, and
> +	 * only then we read each key and queue the corresponding futex.
> +	 *
> +	 * Private futexes doesn't need to recalculate hash in retry, so skip
> +	 * get_futex_key() when retrying.
> +	 */
> +retry:
> +	for (i = 0; i < count; i++) {
> +		if ((vs[i].w.flags & FUTEX_PRIVATE_FLAG) && retry)
> +			continue;
> +
> +		ret = get_futex_key(u64_to_user_ptr(vs[i].w.uaddr),
> +				    !(vs[i].w.flags & FUTEX_PRIVATE_FLAG),
> +				    &vs[i].q.key, FUTEX_READ);
> +
> +		if (unlikely(ret))
> +			return ret;
> +	}
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	for (i = 0; i < count; i++) {
> +		u32 __user *uaddr = (u32 __user *)(unsigned long)vs[i].w.uaddr;
> +		struct futex_q *q = &vs[i].q;
> +		u32 val = (u32)vs[i].w.val;
> +
> +		hb = futex_q_lock(q);
> +		ret = futex_get_value_locked(&uval, uaddr);
> +
> +		if (!ret && uval == val) {
> +			/*
> +			 * The bucket lock can't be held while dealing with the
> +			 * next futex. Queue each futex at this moment so hb can
> +			 * be unlocked.
> +			 */
> +			futex_queue(q, hb);
> +			continue;
> +		}
> +
> +		futex_q_unlock(hb);
> +		__set_current_state(TASK_RUNNING);
> +
> +		/*
> +		 * Even if something went wrong, if we find out that a futex
> +		 * was awaken, we don't return error and return this index to
> +		 * userspace
> +		 */
> +		*awaken = unqueue_multiple(vs, i);
> +		if (*awaken >= 0)
> +			return 1;
> +
> +		if (uval != val)
> +			return -EWOULDBLOCK;
> +
> +		if (ret) {
> +			/*
> +			 * If we need to handle a page fault, we need to do so
> +			 * without any lock and any enqueued futex (otherwise
> +			 * we could lose some wakeup). So we do it here, after
> +			 * undoing all the work done so far. In success, we
> +			 * retry all the work.
> +			 */
> +			if (get_user(uval, uaddr))
> +				return -EFAULT;
> +
> +			retry = true;
> +			goto retry;
> +		}

My bad again: the last two if's should be in the reserve order. If ret
!= 0, the user copy didn't succeed and the value wasn't copied to uval,
thus the comparison (uval != val) should happen only if ret == 0.


> +	}
> +
> +	return 0;
> +}

	
