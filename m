Return-Path: <linux-api+bounces-5885-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEejK5rtoWlDxQQAu9opvQ
	(envelope-from <linux-api+bounces-5885-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 20:16:42 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DADC1BC915
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 20:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A78F303C863
	for <lists+linux-api@lfdr.de>; Fri, 27 Feb 2026 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD393859CB;
	Fri, 27 Feb 2026 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OY4MjKHV"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD4D239E7E;
	Fri, 27 Feb 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219800; cv=none; b=ITEWh2LjYA3vElhIrpZc5XkghqscOcMgOGIJxY6zVP+8poBHN6dFGFTrmvPZT9XAI+ExTG1Fp5MRQ3iPgsHmczBodMvyfB1bVWpyKM8YeKBxNUf90Bm1h//dhVLzIZRYigzsI/MXtqud7WKYvwY/HXOv7YJqOL7HYRzyTGEli24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219800; c=relaxed/simple;
	bh=daP7VedXjrOgI5+8lvvS95ywsxFoS3f3PbWc2edX+Uo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6nLxUo23qegFXMsgocfMeWNB1TfdZP3NBSQpjscS6ktJgWN6shs0IqlgW7LGXgfjRVRROkUeRsv/HxeKMsGjNQ40xGM6e+fLlVOrCl95tLM9k7ccvpTApNwvs4FDG7gbI7Hx0ROwXomjy+pm5e0DBNLgAJmmpV2NpiH5I6JAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OY4MjKHV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7wda5wBgqdEnKdcSow2bj2kMbFP34eBRCmg/fPTPwpI=; b=OY4MjKHVilQ+NDR7Y68h+hSkWB
	rMsD86Ex91yCQeqGjVXQFK/zlsR0umtCqCNfAiJUli2Mz4J2F9xM/QZp3BH+4Ndk2FOuEhV9/FVrf
	Z62VTkjtPsRWa28saOq8C8+/xgPjXoYRUngM5LctrX30XaFG1wPK9WyzkDRj5pMD6Ur5iEWLEUff2
	FHjAxT0QAe8oUnIs9ZRULBogv5pGrk9f/6D0C/6j4caaWxuxY12qrjsx1Nd/ZLQpEMAhpUJ+MBXS1
	jmLJ6ibe7wb7mjBS/FDT8NdRsnknlNm0Q3DlarSg3gw11TONsjLqyaF+hFjJeFgGe6qj1WP9zfr7F
	D+treAeQ==;
Received: from [177.172.125.177] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vw3KB-006eav-My; Fri, 27 Feb 2026 20:16:31 +0100
Message-ID: <ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
Date: Fri, 27 Feb 2026 16:16:23 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: kernel-dev@igalia.com, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-api@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Torvald Riegel <triegel@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rich Felker
 <dalias@aerifal.cx>, Carlos O'Donell <carlos@redhat.com>,
 Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 libc-alpha <libc-alpha@sourceware.org>, Arnd Bergmann <arnd@arndb.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
 <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
 <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.64 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5885-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	DKIM_TRACE(0.00)[igalia.com:-];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,igalia.com:mid,sourceware.org:url]
X-Rspamd-Queue-Id: 2DADC1BC915
X-Rspamd-Action: no action

Hi Mathieu,

Em 20/02/2026 20:17, Mathieu Desnoyers escreveu:
> On 2026-02-20 17:41, Mathieu Desnoyers wrote:
>> On 2026-02-20 16:42, Mathieu Desnoyers wrote:
>>> +CC libc-alpha.
>>>
>>> On 2026-02-20 15:26, André Almeida wrote:
>>>> During LPC 2025, I presented a session about creating a new syscall for
>>>> robust_list[0][1]. However, most of the session discussion wasn't 
>>>> much related
>>>> to the new syscall itself, but much more related to an old bug that 
>>>> exists in
>>>> the current robust_list mechanism.
>>>>
>>>> Since at least 2012, there's an open bug reporting a race condition, as
>>>> Carlos O'Donell pointed out:
>>>>
>>>>    "File corruption race condition in robust mutex unlocking"
>>>>    https://sourceware.org/bugzilla/show_bug.cgi?id=14485
>>>>
>>>> To help understand the bug, I've created a reproducer (patch 1/2) and a
>>>> companion kernel hack (patch 2/2) that helps to make the race condition
>>>> more likely. When the bug happens, the reproducer shows a message
>>>> comparing the original memory with the corrupted one:
>>>>
>>>>    "Memory was corrupted by the kernel: 8001fe8d8001fe8d vs 
>>>> 8001fe8dc0000000"
>>>>
>>>> I'm not sure yet what would be the appropriated approach to fix it, 
>>>> so I
>>>> decided to reach the community before moving forward in some direction.
>>>> One suggestion from Peter[2] resolves around serializing the mmap() 
>>>> and the
>>>> robust list exit path, which might cause overheads for the common case,
>>>> where list_op_pending is empty.
>>>>
>>>> However, giving that there's a new interface being prepared, this could
>>>> also give the opportunity to rethink how list_op_pending works, and get
>>>> rid of the race condition by design.
>>>>
>>>> Feedback is very much welcome.
>>>
>>> Looking at this bug, one thing I'm starting to consider is that it
>>> appears to be an issue inherent to lack of synchronization between
>>> pthread_mutex_destroy(3) and the per-thread list_op_pending fields
>>> and not so much a kernel issue.
>>>
>>> Here is why I think the issue is purely userspace:
>>>
>>> Let's suppose we have a shared memory area across Processes 1 and 
>>> Process 2,
>>> which internally have its own custom memory allocator in userspace to
>>> allocate/free space within that shared memory.
>>>
>>> Process 1, Thread A stumbles through the scenario highlighted by this 
>>> bug, and
>>> basically gets preempted at this FIXME in libc 
>>> __pthread_mutex_unlock_full():
>>>
>>>        if (__glibc_unlikely ((atomic_exchange_release (&mutex- 
>>>  >__data.__lock, 0)
>>>                               & FUTEX_WAITERS) != 0))
>>>          futex_wake ((unsigned int *) &mutex->__data.__lock, 1, 
>>> private);
>>>
>>>        /* We must clear op_pending after we release the mutex.
>>>           FIXME However, this violates the mutex destruction 
>>> requirements
>>>           because another thread could acquire the mutex, destroy it, 
>>> and
>>>           reuse the memory for something else; then, if this thread 
>>> crashes,
>>>           and the memory happens to have a value equal to the TID, 
>>> the kernel
>>>           will believe it is still related to the mutex (which has been
>>>           destroyed already) and will modify some other random 
>>> object.  */
>>>        __asm ("" ::: "memory");
>>>        THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
>>>
>>> Then Process 1, Thread B runs, grabs the lock, releases it, and based on
>>> program state it knows it can pthread_mutex_destroy() this lock, free 
>>> its
>>> associated memory through the custom shared memory allocator, and 
>>> allocate
>>> it for other purposes. Then we get to the point where Process 1 is
>>> killed, and where the robust futex kernel code corrupts data in shared
>>> memory because of the dangling list_op_pending pointer.
>>>
>>> That shared memory data is still observable by Process B, which will 
>>> get a
>>> corrupted state.
>>>
>>> Notice how this all happens without any munmap(2)/mmap(2) in the 
>>> sequence ?
>>> This is why I think this is purely a userspace issue rather than an 
>>> issue
>>> we can solve by adding extra synchronization in the kernel.
>>>
>>> The one point we have in that sequence where I think we can add 
>>> synchronization
>>> is pthread_mutex_destroy(3) in libc. One possible "big hammer" 
>>> solution would be
>>> to make pthread_mutex_destroy iterate on all other threads 
>>> list_op_pending
>>> and busy-wait if it finds that the mutex address is in use. It would 
>>> of course
>>> only have to do that for robust futexes.
>>>
>>> If that big hammer solution is not fast enough for many-threaded use- 
>>> cases,
>>> then we can think of other approaches such as adding a reference counter
>>> in the mutex structure, or introducing hazard pointers in userspace 
>>> to reduce
>>> synchronization iteration from nr_threads to nr_cpus (or even down to 
>>> max
>>> rseq mm_cid).
>>
>> To make matters even worse, the pthread_mutex_destroy(3) and reallocation
>> could happen from Process 2 rather than Process 1. So iterating on a
>> threads from Process 1 is not sufficient. We'd need to synchronize
>> pthread_mutex_destroy on something within the mutex structure which is
>> observable from all processes using the lock, for instance a reference 
>> count.
> Trying to find a backward compatible way to solve this may be tricky.
> Here is one possible approach I have in mind: Introduce a new syscall,
> e.g. sys_cleanup_robust_list(void *addr)
> 
> This system call would be invoked on pthread_mutex_destroy(3) of
> robust mutexes, and do the following:
> 
> - Calculate the offset of @addr within its mapping,
> - Iterate on all processes which map the backing store which contain
>    the lock address @addr.
>    - Iterate on each thread sibling within each of those processes,
>      - If the thread has a robust list, and its list_op_pending points
>        to the same offset within the backing store mapping, clear the
>        list_op_pending pointer.
> 
> The overhead would be added specifically to pthread_mutex_destroy(3),
> and only for robust mutexes.
> 
> Thoughts ?
> 

Right, your explanation makes sense to me. I think the only difference 
between alloc/free and map/munmap is that ""freeing" memory does not 
actually return it to the operating system for other applications to 
use"[1], so I don't know if this custom allocator is violating some 
memory rules.

About the system call, we would call sys_cleanup_robust_list() before 
freeing/unmapping the robust mutex. To guarantee that we check every 
process that shares the memory region, would we need to check *every* 
single process? I don't think there's a way find a way to find such maps 
without checking them all.

I'm trying to explore the idea about the reference counter. Would the 
mummap() be blocked till the refcount goes to zero or something like 
that? I've also tried to find more examples of a memory region that's 
shared between one or more process and the kernel at the same time to 
get some inspiration, but it seems robust_list is a quite unique design 
on its own regarding this memory sharing problem.

[1] https://sourceware.org/glibc/wiki/MallocInternals


