Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28D3EFF11
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 10:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhHRIXG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 04:23:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239585AbhHRIXE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 04:23:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629274949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIKylyUWkupQ9je6VYA0DlcPMd0VOEOkiwD0SYFuUcA=;
        b=t708+qM/V0hDY6Z7CG8nDlJf+wvq+3GsYL3OoqC48q84J9Y7TXN+mzFgfYFpWVeSwwn5GQ
        +/fN0sEIKcU/tnjkGyWFMK2QPhHdOHRQnN11TrfWOB67CCjmvx7IV1L84tazavRDYb1bge
        9cPcQZ4SoeJZRwydnWmB8O8C6S7130Gez07TbC/6/vxvEhHS3hBWTUvKy0tDMJ+24C7NMw
        isW7pN5w41mXpj9+8066Yopp9PAH2bBmfSEye2ePb6vazMXvY8aHWqu/EHhBuYfCNwuWsG
        yJcceAmOflCQxR/fPg7oRzzAHsi2IsaHZbbmfBlhTC3peBuR1WBSJl+b5v2ldg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629274949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIKylyUWkupQ9je6VYA0DlcPMd0VOEOkiwD0SYFuUcA=;
        b=tX6dAZ/rxVw5b6rSz44n9KJ3ScmG2XosRTrnEGrJEDRxbzi05kpGRtIfPWWsc6W0DYnHBT
        x6nwRmV17FzxesBw==
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
Subject: Re: [PATCH 1/4] futex: Prepare for futex_wait_multiple()
In-Reply-To: <20210805190405.59110-2-andrealmeid@collabora.com>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
 <20210805190405.59110-2-andrealmeid@collabora.com>
Date:   Wed, 18 Aug 2021 10:22:28 +0200
Message-ID: <8735r72md7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Andre,

On Thu, Aug 05 2021 at 16:04, Andr=C3=A9 Almeida wrote:
> +/*
> + * Futex flags used to encode options to functions and preserve them acr=
oss
> + * restarts.
> + */
> +#ifdef CONFIG_MMU
> +# define FLAGS_SHARED		0x01
> +#else
> +/*
> + * NOMMU does not have per process address space. Let the compiler optim=
ize
> + * code away.
> + */
> +# define FLAGS_SHARED		0x00
> +#endif
> +#define FLAGS_CLOCKRT		0x02
> +#define FLAGS_HAS_TIMEOUT	0x04
> +
>  /*
>   * Futexes are matched on equal values of this key.
>   * The key type depends on whether it's a shared or private mapping.
> @@ -50,8 +66,52 @@ union futex_key {
>  	} both;
>  };
>=20=20
> +/**
> + * struct futex_q - The hashed futex queue entry, one per waiting task
> + * @list:		priority-sorted list of tasks waiting on this futex
> + * @task:		the task waiting on the futex
> + * @lock_ptr:		the hash bucket lock
> + * @key:		the key the futex is hashed on
> + * @pi_state:		optional priority inheritance state
> + * @rt_waiter:		rt_waiter storage for use with requeue_pi
> + * @requeue_pi_key:	the requeue_pi target futex key
> + * @bitset:		bitset for the optional bitmasked wakeup
> + *
> + * We use this hashed waitqueue, instead of a normal wait_queue_entry_t,=
 so
> + * we can wake only the relevant ones (hashed queues may be shared).
> + *
> + * A futex_q has a woken state, just like tasks have TASK_RUNNING.
> + * It is considered woken when plist_node_empty(&q->list) || q->lock_ptr=
 =3D=3D 0.
> + * The order of wakeup is always to make the first condition true, then
> + * the second.
> + *
> + * PI futexes are typically woken before they are removed from the hash =
list via
> + * the rt_mutex code. See unqueue_me_pi().
> + */
> +struct futex_q {
> +	struct plist_node list;
> +
> +	struct task_struct *task;
> +	spinlock_t *lock_ptr;
> +	union futex_key key;
> +	struct futex_pi_state *pi_state;
> +	struct rt_mutex_waiter *rt_waiter;
> +	union futex_key *requeue_pi_key;
> +	u32 bitset;
> +} __randomize_layout;
> +
>  #define FUTEX_KEY_INIT (union futex_key) { .both =3D { .ptr =3D 0ULL } }
>=20=20
> +static const struct futex_q futex_q_init =3D {
> +	/* list gets initialized in queue_me()*/
> +	.key =3D FUTEX_KEY_INIT,
> +	.bitset =3D FUTEX_BITSET_MATCH_ANY
> +};
> +
> +inline struct hrtimer_sleeper *
> +futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
> +		  int flags, u64 range_ns);
> +

None of these things belong into the global header. Please move them to
kernel/futex.h.

Thanks,

        tglx
