Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F4B3F0229
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 13:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhHRLBf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 07:01:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39702 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbhHRLBf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 07:01:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629284458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0jkaBF9ICggO+H1xa0h+M8KCLUt8o7vM3H3sSYR5nc=;
        b=Fy1NoJ7cMlsftXYIcUcUqkShv5P/Qzj/wR/BSer0KbG1UxSKQ0B4PfSP7d4rIbyVI5vvpQ
        Ll9Q02IQ7HXOsc0ElcBBDz1bgZGqBfBoqnKJQPWuaOvco/+F2tgU0IU8nXbBr9NR3USYsv
        DYa7/RVdhaMz/rAHNopnVBixzlre8zYDnCCTHL4He1wZCI6rYn5RDA75fz6oXob1UddeGM
        h8KpAgPFuY/Ao6fCOqm4i1DmN/QuQ5kP6IO19OBWBgzqim2xlgT1ijIUwP2sqX666hVteE
        8YDFxtVZ6gYxRlVGwsxKlqVRvvin+sX8K0oV3wCF/McxN4ns8gs2wzaDjoUpFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629284458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0jkaBF9ICggO+H1xa0h+M8KCLUt8o7vM3H3sSYR5nc=;
        b=vjVdPnwPmYB32i+OMdUw596cYvFQCAIdiDs9Vd7hyXt9INkiU/I+pBcJtuoznYYjh0aem6
        4R+a/EdeTU4VjxDQ==
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [PATCH 2/4] futex2: Implement vectorized wait
In-Reply-To: <20210805190405.59110-3-andrealmeid@collabora.com>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
 <20210805190405.59110-3-andrealmeid@collabora.com>
Date:   Wed, 18 Aug 2021 13:00:57 +0200
Message-ID: <87v94310gm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andre,

On Thu, Aug 05 2021 at 16:04, Andr=C3=A9 Almeida wrote:
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  include/linux/compat.h                 |   9 ++
>  include/linux/futex.h                  |  15 ++
>  include/uapi/asm-generic/unistd.h      |   5 +-
>  include/uapi/linux/futex.h             |  17 +++
>  init/Kconfig                           |   7 +
>  kernel/Makefile                        |   1 +
>  kernel/futex.c                         | 182 +++++++++++++++++++++++
>  kernel/futex2.c                        | 192 +++++++++++++++++++++++++
>  kernel/sys_ni.c                        |   4 +

please split this in implementation and enabling on x86.=20

> index c270124e4402..0c38adfc40a2 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -368,6 +368,12 @@ struct compat_robust_list_head {
>  	compat_uptr_t			list_op_pending;
>  };
>=20=20
> +struct compat_futex_waitv {
> +	compat_u64 val;

Why do we need a u64 here? u32 is what futexes are based on.

> +/**
> + * struct futex_vector - Auxiliary struct for futex_waitv()
> + * @w: Userspace provided data
> + * @q: Kernel side data
> + *
> + * Struct used to build an array with all data need for futex_waitv()
> + */
> +struct futex_vector {
> +	struct futex_waitv w;
> +	struct futex_q q;
> +};

No point in exposing this globaly.

> diff --git a/include/uapi/linux/futex.h b/include/uapi/linux/futex.h
> index 235e5b2facaa..daa135bdedda 100644
> --- a/include/uapi/linux/futex.h
> +++ b/include/uapi/linux/futex.h
> @@ -42,6 +42,23 @@
>  					 FUTEX_PRIVATE_FLAG)
>  #define FUTEX_CMP_REQUEUE_PI_PRIVATE	(FUTEX_CMP_REQUEUE_PI | \
>  					 FUTEX_PRIVATE_FLAG)
> +#define FUTEX_32	2
> +#define FUTEX_SHARED_FLAG 8
> +#define FUTEX_SIZE_MASK	0x3
> +
> +#define FUTEX_WAITV_MAX 128

Style nitpick. All the defines above this are layed out tabular. Please
keep that.

Aside of that these constants look like random numbers and lack any form
of explanation.

Plus I don't see a reason why this new stuff wants FUTEX_SHARED_FLAG
which is the opposite of the FUTEX_PRIVATE_FLAG for the existing futex
interface. Can we please make this stuff consistent instead of creating
more confusion?

> +
> +/**
> + * struct futex_waitv - A waiter for vectorized wait
> + * @val:   Expected value at uaddr
> + * @uaddr: User address to wait on
> + * @flags: Flags for this waiter
> + */
> +struct futex_waitv {
> +	__u64 val;

Again. Why u64?

> +	void __user *uaddr;
> +	unsigned int flags;
> +};
>=20=20
> +/**
> + * unqueue_multiple() - Remove various futexes from their futex_hash_buc=
ket

s/()// and what are the underscores in futex_hash_bucket for?

> +/**
> + * futex_wait_multiple_setup() - Prepare to wait and enqueue multiple fu=
texes
> + * @vs:		The corresponding futex list

To what is this corresponding?

> + * @count:	The size of the list
> + * @awaken:	Index of the last awoken futex (return parameter)

What's the purpose of this?

> +static int futex_wait_multiple_setup(struct futex_vector *vs, int count,=
 int *awaken)
> +{
> +	struct futex_hash_bucket *hb;
> +	int ret, i;
> +	u32 uval;
> +
> +	/*
> +	 * Enqueuing multiple futexes is tricky, because we need to
> +	 * enqueue each futex in the list before dealing with the next
> +	 * one to avoid deadlocking on the hash bucket.  But, before
> +	 * enqueuing, we need to make sure that current->state is
> +	 * TASK_INTERRUPTIBLE, so we don't absorb any awake events, which
> +	 * cannot be done before the get_futex_key of the next key,
> +	 * because it calls get_user_pages, which can sleep.  Thus, we
> +	 * fetch the list of futexes keys in two steps, by first pinning
> +	 * all the memory keys in the futex key, and only then we read
> +	 * each key and queue the corresponding futex.
> +	 */
> +retry:
> +	for (i =3D 0; i < count; i++) {
> +		ret =3D get_futex_key(vs[i].w.uaddr,
> +				    vs[i].w.flags & FUTEX_SHARED_FLAG,
> +				    &vs[i].q.key, FUTEX_READ);
> +		if (unlikely(ret))
> +			return ret;
> +	}
> +
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	for (i =3D 0; i < count; i++) {
> +		struct futex_q *q =3D &vs[i].q;
> +		struct futex_waitv *waitv =3D &vs[i].w;

Please order them reverse.

> +
> +		hb =3D queue_lock(q);
> +		ret =3D get_futex_value_locked(&uval, waitv->uaddr);
> +		if (ret) {
> +			/*
> +			 * We need to try to handle the fault, which
> +			 * cannot be done without sleep, so we need to
> +			 * undo all the work already done, to make sure
> +			 * we don't miss any wake ups.  Therefore, clean
> +			 * up, handle the fault and retry from the
> +			 * beginning.
> +			 */
> +			queue_unlock(hb);
> +			__set_current_state(TASK_RUNNING);
> +
> +			*awaken =3D unqueue_multiple(vs, i);
> +			if (*awaken >=3D 0)
> +				return 1;
> +
> +			if (get_user(uval, (u32 __user *)waitv->uaddr))

This type cast is horrible.

> +				return -EINVAL;

-EFAULT

> +
> +			goto retry;

Why a full retry if the futexes are private?

> +		}
> +
> +		if (uval !=3D waitv->val) {

Comparison between u32 and u64 ...

> +			queue_unlock(hb);
> +			__set_current_state(TASK_RUNNING);
> +
> +			/*
> +			 * If something was already awaken, we can
> +			 * safely ignore the error and succeed.
> +			 */
> +			*awaken =3D unqueue_multiple(vs, i);
> +			if (*awaken >=3D 0)
> +				return 1;
> +
> +			return -EWOULDBLOCK;
> +		}
> +
> +		/*
> +		 * The bucket lock can't be held while dealing with the
> +		 * next futex. Queue each futex at this moment so hb can
> +		 * be unlocked.
> +		 */
> +		queue_me(&vs[i].q, hb);

So the two error pathes are doing both

> +			queue_unlock(hb);
> +			__set_current_state(TASK_RUNNING);
> +
> +			*awaken =3D unqueue_multiple(vs, i);
> +			if (*awaken >=3D 0)
> +				return 1;

This can be consolidated into:

	if (!ret && uval =3D=3D waitv->val) {
        	queue_me();
                continue;
        }
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
	queue_unlock(hb);
	__set_current_state(TASK_RUNNING);
	*awaken =3D unqueue_multiple(vs, i);
	if (*awaken >=3D 0)
		return 1;

        if (uval !=3D waitv->val)
        	return -EWOULDBLOCK;
        ....

> +	}
> +	return 0;
> +}
> +
> +/**
> + * futex_wait_multiple() - Prepare to wait on and enqueue several futexes
> + * @vs:		The list of futexes to wait on
> + * @count:	The number of objects
> + * @to:		Timeout before giving up and returning to userspace
> + *
> + * Entry point for the FUTEX_WAIT_MULTIPLE futex operation, this function
> + * sleeps on a group of futexes and returns on the first futex that
> + * triggered, or after the timeout has elapsed.

futexes can't trigger.

> + * Return:
> + *  - >=3D0 - Hint to the futex that was awoken
> + *  - <0  - On error
> + */
> +int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
> +			struct hrtimer_sleeper *to)
> +{
> +	int ret, hint =3D 0;
> +	unsigned int i;
> +
> +	while (1) {
> +		ret =3D futex_wait_multiple_setup(vs, count, &hint);
> +		if (ret) {
> +			if (ret > 0) {
> +				/* A futex was awaken during setup */
> +				ret =3D hint;
> +			}
> +			return ret;
> +		}
> +
> +		if (to)
> +			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);

hrtimer_sleeper_start_expires() and also why is this inside of the loop?

> +
> +		/*
> +		 * Avoid sleeping if another thread already tried to
> +		 * wake us.
> +		 */
> +		for (i =3D 0; i < count; i++) {
> +			if (plist_node_empty(&vs[i].q.list))
> +				break;
> +		}
> +
> +		if (i =3D=3D count && (!to || to->task))
> +			freezable_schedule();

TBH, this sleeping condition along with the loop above is
unreadable. It can be nicely split out:

static void futex_sleep_multiple(struct futex_vector *vs, unsigned int coun=
t,
				 struct hrtimer_sleeper *to)
{
	if (to && !to->task)
        	return;
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
	for (; count; count--, vs++) {
		if (!READ_ONCE(vs->q.lock_ptr))
			return;
	}

	freezable_schedule();
}

> +
> +		__set_current_state(TASK_RUNNING);
> +
> +		ret =3D unqueue_multiple(vs, count);
> +		if (ret >=3D 0)
> +			return ret;
> +		if (to && !to->task)
> +			return -ETIMEDOUT;
> +		else if (signal_pending(current))
> +			return -ERESTARTSYS;
> +		/*
> +		 * The final case is a spurious wakeup, for
> +		 * which just retry.
> +		 */
> +	}
> +}
> +

>  /**
>   * futex_wait_setup() - Prepare to wait on a futex
>   * @uaddr:	the futex userspace address
> diff --git a/kernel/futex2.c b/kernel/futex2.c
> new file mode 100644
> index 000000000000..19bbd4bf7187
> --- /dev/null
> +++ b/kernel/futex2.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * futex2 system call interface by Andr=C3=A9 Almeida <andrealmeid@colla=
bora.com>

I don't see a futex2 system call anywhere

> + * Copyright 2021 Collabora Ltd.
> + */
> +
> +#include <asm/futex.h>
> +
> +#include <linux/freezer.h>
> +#include <linux/syscalls.h>
> +
> +/* Mask for each futex in futex_waitv list */
> +#define FUTEXV_WAITER_MASK (FUTEX_SIZE_MASK | FUTEX_SHARED_FLAG)

This piggy packs on the existing futex code, so what is this size thing
going to help?

> +/* Mask for sys_futex_waitv flag */
> +#define FUTEXV_MASK (FUTEX_CLOCK_REALTIME)
> +
> +#ifdef CONFIG_COMPAT
> +/**
> + * compat_futex_parse_waitv - Parse a waitv array from userspace
> + * @futexv:	Kernel side list of waiters to be filled
> + * @uwaitv:     Userspace list to be parsed
> + * @nr_futexes: Length of futexv
> + *
> + * Return: Error code on failure, pointer to a prepared futexv otherwise

The int return value becomes magically a pointer ?

> + */
> +static int compat_futex_parse_waitv(struct futex_vector *futexv,
> +				    struct compat_futex_waitv __user *uwaitv,
> +				    unsigned int nr_futexes)
> +{
> +	struct compat_futex_waitv aux;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < nr_futexes; i++) {
> +		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
> +			return -EFAULT;
> +
> +		if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
> +		    (aux.flags & FUTEX_SIZE_MASK) !=3D FUTEX_32)
> +			return -EINVAL;
> +
> +		futexv[i].w.flags =3D aux.flags;
> +		futexv[i].w.val =3D aux.val;
> +		futexv[i].w.uaddr =3D compat_ptr(aux.uaddr);
> +		futexv[i].q =3D futex_q_init;
> +	}
> +
> +	return 0;
> +}
> +
> +COMPAT_SYSCALL_DEFINE4(futex_waitv, struct compat_futex_waitv __user *, =
waiters,
> +		       unsigned int, nr_futexes, unsigned int, flags,
> +		       struct __kernel_timespec __user *, timo)
> +{
> +	struct hrtimer_sleeper to;
> +	struct futex_vector *futexv;
> +	struct timespec64 ts;
> +	ktime_t time;
> +	int ret;
> +
> +	if (flags & ~FUTEXV_MASK)
> +		return -EINVAL;
> +
> +	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
> +		return -EINVAL;
> +
> +	if (timo) {
> +		int flag_clkid =3D 0;
> +
> +		if (get_timespec64(&ts, timo))
> +			return -EFAULT;
> +
> +		if (!timespec64_valid(&ts))
> +			return -EINVAL;
> +
> +		if (flags & FUTEX_CLOCK_REALTIME)
> +			flag_clkid =3D FLAGS_CLOCKRT;
> +
> +		time =3D timespec64_to_ktime(ts);

What's the point of open coding futex_init_timeout() and thereby failing to
do the namespace adjustment for CLOCK_MONOTONIC?

> +		futex_setup_timer(&time, &to, flag_clkid, 0);
> +	}
> +
> +	futexv =3D kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
> +	if (!futexv)
> +		return -ENOMEM;
> +
> +	ret =3D compat_futex_parse_waitv(futexv, waiters, nr_futexes);
> +	if (!ret)
> +		ret =3D futex_wait_multiple(futexv, nr_futexes, timo ? &to : NULL);
> +
> +	if (timo) {
> +		hrtimer_cancel(&to.timer);
> +		destroy_hrtimer_on_stack(&to.timer);
> +	}
> +
> +	kfree(futexv);
> +	return ret;
> +}
> +#endif
> +
> +static int futex_parse_waitv(struct futex_vector *futexv,
> +			     struct futex_waitv __user *uwaitv,
> +			     unsigned int nr_futexes)
> +{
> +	struct futex_waitv aux;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < nr_futexes; i++) {
> +		if (copy_from_user(&aux, &uwaitv[i], sizeof(aux)))
> +			return -EFAULT;
> +
> +		if ((aux.flags & ~FUTEXV_WAITER_MASK) ||
> +		    (aux.flags & FUTEX_SIZE_MASK) !=3D FUTEX_32)
> +			return -EINVAL;
> +
> +		futexv[i].w.flags =3D aux.flags;
> +		futexv[i].w.val =3D aux.val;
> +		futexv[i].w.uaddr =3D aux.uaddr;
> +		futexv[i].q =3D futex_q_init;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * sys_futex_waitv - Wait on a list of futexes
> + * @waiters:    List of futexes to wait on
> + * @nr_futexes: Length of futexv
> + * @flags:      Flag for timeout (monotonic/realtime)
> + * @timo:	Optional absolute timeout.
> + *
> + * Given an array of `struct futex_waitv`, wait on each uaddr. The threa=
d wakes
> + * if a futex_wake() is performed at any uaddr. The syscall returns imme=
diately
> + * if any waiter has *uaddr !=3D val. *timo is an optional timeout value=
 for the
> + * operation. Each waiter has individual flags. The `flags` argument for=
 the
> + * syscall should be used solely for specifying the timeout as realtime,=
 if
> + * needed. Flags for shared futexes, sizes, etc. should be used on the
> + * individual flags of each waiter.
> + *
> + * Returns the array index of one of the awaken futexes. There's no given
> + * information of how many were awakened, or any particular attribute of=
 it (if
> + * it's the first awakened, if it is of the smaller index...).
> + */
> +SYSCALL_DEFINE4(futex_waitv, struct futex_waitv __user *, waiters,
> +		unsigned int, nr_futexes, unsigned int, flags,
> +		struct __kernel_timespec __user *, timo)
> +{
> +	struct hrtimer_sleeper to;
> +	struct futex_vector *futexv;
> +	struct timespec64 ts;
> +	ktime_t time;
> +	int ret;
> +
> +	if (flags & ~FUTEXV_MASK)
> +		return -EINVAL;
> +
> +	if (!nr_futexes || nr_futexes > FUTEX_WAITV_MAX || !waiters)
> +		return -EINVAL;
> +
> +	if (timo) {
> +		int flag_clkid =3D 0;
> +
> +		if (get_timespec64(&ts, timo))
> +			return -EFAULT;
> +
> +		if (!timespec64_valid(&ts))
> +			return -EINVAL;
> +
> +		if (flags & FUTEX_CLOCK_REALTIME)
> +			flag_clkid =3D FLAGS_CLOCKRT;
> +
> +		time =3D timespec64_to_ktime(ts);
> +		futex_setup_timer(&time, &to, flag_clkid, 0);

And of course we need a copy of the same here again.

> +	}
> +
> +	futexv =3D kcalloc(nr_futexes, sizeof(*futexv), GFP_KERNEL);
> +	if (!futexv)
> +		return -ENOMEM;
> +
> +	ret =3D futex_parse_waitv(futexv, waiters, nr_futexes);
> +	if (!ret)
> +		ret =3D futex_wait_multiple(futexv, nr_futexes, timo ? &to : NULL);
> +
> +	if (timo) {
> +		hrtimer_cancel(&to.timer);
> +		destroy_hrtimer_on_stack(&to.timer);
> +	}
> +
> +	kfree(futexv);
> +	return ret;

So the only difference of the compat code and the non compat version is
the pointer size in struct futex_waitv.

struct futex_waitv {
       __u32	val;
       __u32	flags;
       __u64	uaddr;
};

which gets rid of all the code duplication and special casing of compat.

Thanks,

        tglx
=20=20=20=20
