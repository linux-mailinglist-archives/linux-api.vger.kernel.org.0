Return-Path: <linux-api+bounces-1595-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B3C8CDB78
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49AC1C2112F
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 20:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F9C84DF9;
	Thu, 23 May 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="t+wTssY6"
X-Original-To: linux-api@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7D84DF4;
	Thu, 23 May 2024 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716496740; cv=none; b=FoBdQhMxCxG/QcjSzCusJa3mLXeLcjqvz3R9/4BITXUU4wgYAytTjJL/z2yh7XtKMsQbwUHYtj4kjEaOuci/8kIxtKAjSLhj2gwM6EpRbiMdwnEQHc7Uh7fEniMiQP2+ziUsDMuA/ExjFS2XhM/1VGPcHf4r9rcy0fCMBChdYd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716496740; c=relaxed/simple;
	bh=boIZfxh8E99Yr4LDyD87A58BERRdGEHApGNbwW5KdbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQfyAkEli2j3c+yPc5P1BC924+Rbma0BVymANPApzLH0gKEoLl2MqUDuQAjSWIYjIGufgsV00Q5IEiZI0/HDp4ZEMIfNxsCPChjW4RoECieufiexZ3tjOvmvzQChjZhB5RS9LsPnXWsfjxUXHLESTpENxzbMun9vYjLd+q8yHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=t+wTssY6; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1716496737;
	bh=boIZfxh8E99Yr4LDyD87A58BERRdGEHApGNbwW5KdbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t+wTssY60KYJxr7EopwBqhHV9gb1dMIB7fYQsRiHjKY/pkBPfND/jp5llYbIEYlXg
	 AO7YnFSUZNN60xsUgjQXmJc5sfDPYBnBQ/eXhxJFlYPoU8+jVK58JZRQmHpZHahU0f
	 1puIA6BhDvmc/mNbJCo8EJQsrXWqk3Ut9ktsQy6kWjK2MpPsb8njYfNjO9kmLJieJf
	 xJgYQZhUxWsKzcJSbYS28/97MsBgDQYGly1+aACxVURgpbeRmYbbIT2XZsp0h+LuD3
	 O5XkGA0GnSq1jg++pO9CND771uwcUGLBfqouhLL4zZPHPM345lcAPZkzMKVYRLrBFo
	 VHgQPK8LF+TxA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vlg4d2qQVz10dh;
	Thu, 23 May 2024 16:38:57 -0400 (EDT)
Message-ID: <156dc43f-fdcf-4643-83d9-b374452b0929@efficios.com>
Date: Thu, 23 May 2024 16:39:33 -0400
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Add FUTEX_SPIN operation
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
 longman@redhat.com, kernel-dev@igalia.com
References: <20240523200704.281514-1-andrealmeid@igalia.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240523200704.281514-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-05-23 16:07, André Almeida wrote:
> Hi,
> 
> In the last LPC, Mathieu Desnoyers and I presented[0] a proposal to extend the
> rseq interface to be able to implement spin locks in userspace correctly. Thomas
> Gleixner agreed that this is something that Linux could improve, but asked for
> an alternative proposal first: a futex operation that allows to spin a user
> lock inside the kernel. This patchset implements a prototype of this idea for
> further discussion.
> 
> With FUTEX2_SPIN flag set during a futex_wait(), the futex value is expected to
> be the TID of the lock owner. Then, the kernel gets the task_struct of the
> corresponding TID, and checks if it's running. It spins until the futex
> is awaken, the task is scheduled out or if a timeout happens.  If the lock owner
> is scheduled out at any time, then the syscall follows the normal path of
> sleeping as usual. The user input is masked with FUTEX_TID_MASK so we have some
> bits to play.
> 
> If the futex is awaken and we are spinning, we can return to userspace quickly,
> avoid the scheduling out and in again to wake from a futex_wait(), thus
> speeding up the wait operation. The user input is masked with FUTEX_TID_MASK so
> we have some bits to play.
> 
> Christian Brauner suggested using pidfd to avoid race conditions, and I will
> implement that in the next patch iteration. I benchmarked the implementation
> measuring the time required to wait for a futex for a simple loop using the code
> at [2]. In my setup, the total wait time for 1000 futexes using the spin method
> was almost 10% lower than just using the normal futex wait:
> 
> 	Testing with FUTEX2_SPIN | FUTEX_WAIT
> 	Total wait time: 8650089 usecs
> 
> 	Testing with FUTEX_WAIT
> 	Total wait time: 9447291 usecs
> 
> However, as I played with how long the lock owner would be busy, the
> benchmark results of spinning vs no spinning would match, showing that the
> spinning will be effective for some specific scheduling scenarios, but depending
> on the wait time, there's no big difference either spinning or not.
> 
> [0] https://lpc.events/event/17/contributions/1481/
> 
> You can find a small snippet to play with this interface here:
> 
> [1] https://gist.github.com/andrealmeid/f0b8c93a3c7a5c50458247c47f7078e1

What exactly are you trying to benchmark here ? I've looked at this toy
program, and I suspect that most of the delay you observe is due to
initial scheduling of a newly cloned thread, because this is what is
repeatedly being done in the delay you measure.

I would recommend to change this benchmark program to measure something
meaningful, e.g.:

- N threads repeatedly contending on a lock, until a "stop" flag is set,
- run for "duration" seconds, after which main() sets a "stop" flag.
- delay loop of "work_delay" us within the lock critical section,
- delay loop of "inactive_delay" us between locking attempts,
- measure the time it takes to grab the lock, report stats on this,
- measure the total number of operations done within the given
   "duration".
- report statistics on the number of operations per thread to see
   the impact on fairness,

The run the program with the following constraints:

- Pin one thread per core, with nb thread <= nb cores. This should
   be a best case scenario for spinning.
- Pin all threads to a single core. when nb threads > nb cores, this
   should be the worse scenario for spinning.
- Groups things between those two extremes to see how things evolve.

I would not be surprised that if you measure relevant delays, you will
observe much better speedups than what you currently have.

Thanks,

Mathieu

> 
> Changelog:
> 
> v1: - s/PID/TID
>      - masked user input with FUTEX_TID_MASK
>      - add benchmark tool to the cover letter
>      - dropped debug prints
>      - added missing put_task_struct()
> 
> André Almeida (1):
>    futex: Add FUTEX_SPIN operation
> 
>   include/uapi/linux/futex.h |  2 +-
>   kernel/futex/futex.h       |  6 ++-
>   kernel/futex/waitwake.c    | 78 +++++++++++++++++++++++++++++++++++++-
>   3 files changed, 82 insertions(+), 4 deletions(-)
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


