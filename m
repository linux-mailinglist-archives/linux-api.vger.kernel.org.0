Return-Path: <linux-api+bounces-1594-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 865888CDB48
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 22:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00912B2131D
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08284D34;
	Thu, 23 May 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="umfVpYwE"
X-Original-To: linux-api@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5884D26;
	Thu, 23 May 2024 20:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495585; cv=none; b=twb7SWH2HkU4ge63Vm77mvCCHxXrCHEBmk7Tw8Ts+Sbf9nEzNypkzGGEB2NnatzmbDPf+gQPzU6Mr1ym+VB08UcMnXFMZcRa0zNhNkwSiDh9u6hJtJ6hsg9s8HLcFUOcjszAEOPp5httliSfGVTe+LDhf/W+XfHREReKG43RO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495585; c=relaxed/simple;
	bh=DmtE3NmDfeuWXwvfKTneK6k7HMV4HXj51KzM63yhWco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDQJW9dIaVCohDCE4VS7g/rWoeV+2shO7IeLMwAwLmYu6IWLo/qlSJpzhj88DyEVhimN/+pwIfJ41Bd0/GQVntciqUdtlFa64uU+qYFhZ5dws2Wjr6MuGViEQ1mXc9Gs4SI4zDxLND05iYq2gjE8a1WO6v0BhHuuogG5ZeoIy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=umfVpYwE; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1716495581;
	bh=DmtE3NmDfeuWXwvfKTneK6k7HMV4HXj51KzM63yhWco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=umfVpYwE4XiDyWL8dEt2yo1JMis6pngumarv4ZxNgvohxA0ncOapHILTr2ADJnA1Y
	 II052msbqiMz3jrhE2WiNsx1h5trLVtbd3trxAOw3ZRY1B3gnJil5L1ICOl/XNe9TT
	 pYHed4mPQ9GRRJPYgxC0alZ9SaYmF9MG/t8fktfaYH9HryxK9jLH53rz9mURFwJhiD
	 VE9KZQS8BmJQmCTzt5m9u4UYnFEKmiKZji9HWszPg3fTfl4mfsbSy8OHyHnfdVt5Ky
	 CDIQteUZudFjkx7iTmfJ4VnAS6hil0pnyvEfqaXHsT1EQbIoThIiwQedzGgepbuTSo
	 tV7xpgx0LphGQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4VlffP05fSz116k;
	Thu, 23 May 2024 16:19:40 -0400 (EDT)
Message-ID: <62825712-36bc-483c-9bca-db3d9233b0d2@efficios.com>
Date: Thu, 23 May 2024 16:20:16 -0400
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] futex: Add FUTEX_SPIN operation
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
 linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
 carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Chris Kennelly <ckennelly@google.com>, Ingo Molnar <mingo@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>,
 Jonathan Corbet <corbet@lwn.net>, Noah Goldstein <goldstein.w.n@gmail.com>,
 Daniel Colascione <dancol@google.com>, longman@redhat.com,
 kernel-dev@igalia.com
References: <20240523200704.281514-1-andrealmeid@igalia.com>
 <20240523200704.281514-2-andrealmeid@igalia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240523200704.281514-2-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-23 16:07, André Almeida wrote:
> Add a new mode for futex wait, the futex spin.
> 
> Given the FUTEX2_SPIN flag, parse the futex value as the TID of the lock
> owner. Then, before going to the normal wait path, spins while the lock
> owner is running in a different CPU, to avoid the whole context switch
> operation and to quickly return to userspace. If the lock owner is not
> running, just sleep as the normal futex wait path.
> 
> The user value is masked with FUTEX_TID_MASK, to allow some bits for
> future use.
> 
> The check for the owner to be running or not is important to avoid
> spinning for something that won't be released quickly. Userspace is
> responsible on providing the proper TID, the kernel does a basic check.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---

[...]

> +
> +static int futex_spin(struct futex_hash_bucket *hb, struct futex_q *q,
> +		       struct hrtimer_sleeper *timeout, u32 uval)
> +{
> +	struct task_struct *p;
> +	pid_t pid = uval & FUTEX_TID_MASK;
> +
> +	p = find_get_task_by_vpid(pid);
> +
> +	/* no task found, maybe it already exited */
> +	if (!p) {
> +		futex_q_unlock(hb);
> +		return -EAGAIN;
> +	}
> +
> +	/* can't spin in a kernel task */
> +	if (unlikely(p->flags & PF_KTHREAD)) {
> +		put_task_struct(p);
> +		futex_q_unlock(hb);
> +		return -EPERM;
> +	}
> +
> +	futex_queue(q, hb);
> +
> +	if (timeout)
> +		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
> +
> +	while (1) {

Infinite loops in other kernel/futex/ files appear to use "for (;;) {"
instead.

> +		if (likely(!plist_node_empty(&q->list))) {
> +			if (timeout && !timeout->task)
> +				goto exit;
> +
> +			if (task_on_cpu(p)) {
> +				/* spin */

You may want to add a "cpu_relax();" here to lessen the
power consumption of this busy-loop.

> +				continue;
> +			} else {
> +				/* task is not running, sleep */
> +				break;
> +			}
> +		} else {
> +			goto exit;
> +		}
> +	}
> +
> +	/* spinning didn't work, go to the normal path */
> +	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);

I wonder if flipping the order between:

         set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
         futex_queue(q, hb);

as done in futex_wait_queue() and what is done here matters ?
Does it introduce a race where a wakeup could be missed ?

If it's an issue, then setting the current state could be done
before invoking futex_queue(), and whenever the spin exits,
set it back to TASK_RUNNING.


> +
> +	if (likely(!plist_node_empty(&q->list))) {
> +		if (!timeout || timeout->task)
> +			schedule();
> +	}
> +
> +	__set_current_state(TASK_RUNNING);
> +
> +exit:
> +	put_task_struct(p);
> +	return 0;
> +}
> +
>   /**
>    * futex_unqueue_multiple - Remove various futexes from their hash bucket
>    * @v:	   The list of futexes to unqueue
> @@ -665,8 +732,15 @@ int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
>   	if (ret)
>   		return ret;
>   
> -	/* futex_queue and wait for wakeup, timeout, or a signal. */
> -	futex_wait_queue(hb, &q, to);
> +	if (flags & FLAGS_SPIN) {
> +		ret = futex_spin(hb, &q, to, val);
The empty line below could be removed.

Thanks,

Mathieu

> +
> +		if (ret)
> +			return ret;
> +	} else {
> +		/* futex_queue and wait for wakeup, timeout, or a signal. */
> +		futex_wait_queue(hb, &q, to);
> +	}
>   
>   	/* If we were woken (and unqueued), we succeeded, whatever. */
>   	if (!futex_unqueue(&q))

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


