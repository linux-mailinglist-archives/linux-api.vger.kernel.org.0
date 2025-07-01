Return-Path: <linux-api+bounces-4108-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F674AF057C
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 23:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3031BC7364
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 21:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28581302055;
	Tue,  1 Jul 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djIUcdPn"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E873B281531;
	Tue,  1 Jul 2025 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404369; cv=none; b=XpT6cuBcjZkJslZ+wtCVsN9kHWQoCQU6ZQfscyp3qiya4e/xC4xJhRUkCSvjhPZTftvOckK2Wya4oVGRwZpKAApuiuD6sTrUgqfvbd53wy9hPtF9EGCt8Vrhk3u2T8LQPuRmykT1MFDcuIWTwBlwIpGPUmhUjejCkGs2mH7k8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404369; c=relaxed/simple;
	bh=2VQNHtAFW203Lh7ygCI+rqhuOSRLMZnXZaMW/rALbxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/EEgOOZnPy/Xl1Sbnm+DpSL4VInDw+JINeJ+TDJC6SnmDy0Ixmin31gBJK0K8GD//ytgqZePay3ys94/yMMiEYXK/Rnp0psYNacAIfMS7CFwONBwcZ55+M5sUkSuFsnLtalGSugEngFIVpEcaN77SDu4+evgMzvNCABo/psd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djIUcdPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8612C4CEEB;
	Tue,  1 Jul 2025 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751404368;
	bh=2VQNHtAFW203Lh7ygCI+rqhuOSRLMZnXZaMW/rALbxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djIUcdPnTWv6WkqOHsMBAycrGrqMBKFDjdQP0A5+yjKVE5tf0e2aCM20zMqgUpf3g
	 20btQlGOgkau6hGF3EPKOHqXfKz4iUPrGPoCwKx3Q5YrOB3sbRO8pfTRUN+UioFekj
	 pQjv5Lhn0mlepVORCVZNDCwojAHSduKAdtSFrKWsZUBPQeUZO/adLJ239n5DR+8IUu
	 Mho4ncuy9e25FvXorp03/4i8EwraAlnjCn3h3RVtFXCdiep1ZG+6lVXt6roLzO4ByL
	 2Ke+9BMbzsu0jOmPlyP2j2lfL4xEQh/KXvfXWl6G1feOX0qbDBmiFNGX63XNLEJ0Uv
	 S3wURF5CNy37w==
Date: Tue, 1 Jul 2025 16:50:42 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org, Kate Stewart <kstewart@linuxfoundation.org>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Chuck Wolber <chuckwolber@gmail.com>
Subject: Re: [RFC v2 01/22] kernel/api: introduce kernel API specification
 framework
Message-ID: <aGRKIuR6hgW0YLc_@lappy>
References: <20250624180742.5795-1-sashal@kernel.org>
 <20250624180742.5795-2-sashal@kernel.org>
 <874ivxuht8.fsf@trenco.lwn.net>
 <20250701002058.1cae5a7e@foz.lan>
 <aGPvR-Mj6aR4Y8B5@lappy>
 <8734bfspko.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8734bfspko.fsf@trenco.lwn.net>

On Tue, Jul 01, 2025 at 01:01:27PM -0600, Jonathan Corbet wrote:
>[Adding some of the ELISA folks, who are working in a related area and
>might have thoughts on this.  You can find the patch series under
>discussion at:
>
>  https://lore.kernel.org/all/20250624180742.5795-1-sashal@kernel.org

Yup, we all met at OSS and reached the conclusion that we should lean
towards a machine readable spec, which we thought was closer to my
proposal than the kerneldoc work.

However, with your suggestion, I think it makes more sense to go back to
kerneldoc as that can be made machine readable.

>> In theory, all of that will let us have something like the following in
>> kerneldoc:
>>
>> - @api-type: syscall
>> - @api-version: 1
>> - @context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
>> - @param-type: family, KAPI_TYPE_INT
>> - @param-flags: family, KAPI_PARAM_IN
>> - @param-range: family, 0, 45
>> - @param-mask: type, SOCK_TYPE_MASK | SOCK_CLOEXEC | SOCK_NONBLOCK
>> - @error-code: -EAFNOSUPPORT, "Address family not supported"
>> - @error-condition: -EAFNOSUPPORT, "family < 0 || family >= NPROTO"
>> - @capability: CAP_NET_RAW, KAPI_CAP_GRANT_PERMISSION
>> - @capability-allows: CAP_NET_RAW, "Create SOCK_RAW sockets"
>> - @since: 2.0
>> - @return-type: KAPI_TYPE_FD
>> - @return-check: KAPI_RETURN_ERROR_CHECK
>>
>> How does it sound? I'm pretty excited about the possiblity to align this
>> with kerneldoc. Please poke holes in the plan :)
>
>I think we could do it without all the @signs.  We'd also want to see
>how well we could integrate that information with the minimal structure
>we already have: getting the return-value information into the Returns:
>section, for example, and tying the parameter constraints to the
>parameter descriptions we already have.

Right!

So I have a proof of concept which during the build process creates
.apispec.h which are generated from kerneldoc and contain macros
identical to the ones in my RFC.

Here's an example of sys_mlock() spec:

/**
  * sys_mlock - Lock pages in memory
  * @start: Starting address of memory range to lock
  * @len: Length of memory range to lock in bytes
  *
  * Locks pages in the specified address range into RAM, preventing them from
  * being paged to swap. Requires CAP_IPC_LOCK capability or RLIMIT_MEMLOCK
  * resource limit.
  *
  * long-desc: Locks pages in the specified address range into RAM, preventing
  *   them from being paged to swap. Requires CAP_IPC_LOCK capability
  *   or RLIMIT_MEMLOCK resource limit.
  * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
  * param-type: start, KAPI_TYPE_UINT
  * param-flags: start, KAPI_PARAM_IN
  * param-constraint-type: start, KAPI_CONSTRAINT_NONE
  * param-constraint: start, Rounded down to page boundary
  * param-type: len, KAPI_TYPE_UINT
  * param-flags: len, KAPI_PARAM_IN
  * param-constraint-type: len, KAPI_CONSTRAINT_RANGE
  * param-range: len, 0, LONG_MAX
  * param-constraint: len, Rounded up to page boundary
  * return-type: KAPI_TYPE_INT
  * return-check-type: KAPI_RETURN_ERROR_CHECK
  * return-success: 0
  * error-code: -ENOMEM, ENOMEM, Address range issue,
  *   Some of the specified range is not mapped, has unmapped gaps,
  *   or the lock would cause the number of mapped regions to exceed the limit.
  * error-code: -EPERM, EPERM, Insufficient privileges,
  *   The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.
  * error-code: -EINVAL, EINVAL, Address overflow,
  *   The result of the addition start+len was less than start (arithmetic overflow).
  * error-code: -EAGAIN, EAGAIN, Some or all memory could not be locked,
  *   Some or all of the specified address range could not be locked.
  * error-code: -EINTR, EINTR, Interrupted by signal,
  *   The operation was interrupted by a fatal signal before completion.
  * error-code: -EFAULT, EFAULT, Bad address,
  *   The specified address range contains invalid addresses that cannot be accessed.
  * since-version: 2.0
  * lock: mmap_lock, KAPI_LOCK_RWLOCK
  * lock-acquired: true
  * lock-released: true
  * lock-desc: Process memory map write lock
  * signal: FATAL
  * signal-direction: KAPI_SIGNAL_RECEIVE
  * signal-action: KAPI_SIGNAL_ACTION_RETURN
  * signal-condition: Fatal signal pending
  * signal-desc: Fatal signals (SIGKILL) can interrupt the operation at two points:
  *   when acquiring mmap_write_lock_killable() and during page population
  *   in __mm_populate(). Returns -EINTR. Non-fatal signals do NOT interrupt
  *   mlock - the operation continues even if SIGINT/SIGTERM are received.
  * signal-error: -EINTR
  * signal-timing: KAPI_SIGNAL_TIME_DURING
  * signal-priority: 0
  * signal-interruptible: yes
  * signal-state-req: KAPI_SIGNAL_STATE_RUNNING
  * examples: mlock(addr, 4096);  // Lock one page
  *   mlock(addr, len);   // Lock range of pages
  * notes: Memory locks do not stack - multiple calls on the same range can be
  *   undone by a single munlock. Locks are not inherited by child processes.
  *   Pages are locked on whole page boundaries. Commonly used by real-time
  *   applications to prevent page faults during time-critical operations.
  *   Also used for security to prevent sensitive data (e.g., cryptographic keys)
  *   from being written to swap. Note: locked pages may still be saved to
  *   swap during system suspend/hibernate.
  *
  *   Tagged addresses are automatically handled via untagged_addr(). The operation
  *   occurs in two phases: first VMAs are marked with VM_LOCKED, then pages are
  *   populated into memory. When checking RLIMIT_MEMLOCK, the kernel optimizes
  *   by recounting locked memory to avoid double-counting overlapping regions.
  * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, process memory, Locks pages into physical memory, preventing swapping, reversible=yes
  * side-effect: KAPI_EFFECT_MODIFY_STATE, mm->locked_vm, Increases process locked memory counter, reversible=yes
  * side-effect: KAPI_EFFECT_ALLOC_MEMORY, physical pages, May allocate and populate page table entries, condition=Pages not already present, reversible=yes
  * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, page faults, Triggers page faults to bring pages into memory, condition=Pages not already resident
  * side-effect: KAPI_EFFECT_MODIFY_STATE, VMA splitting, May split existing VMAs at lock boundaries, condition=Lock range partially overlaps existing VMA
  * state-trans: memory pages, swappable, locked in RAM, Pages become non-swappable and pinned in physical memory
  * state-trans: VMA flags, unlocked, VM_LOCKED set, Virtual memory area marked as locked
  * capability: CAP_IPC_LOCK, KAPI_CAP_BYPASS_CHECK, CAP_IPC_LOCK capability
  * capability-allows: Lock unlimited amount of memory (no RLIMIT_MEMLOCK enforcement)
  * capability-without: Must respect RLIMIT_MEMLOCK resource limit
  * capability-condition: Checked when RLIMIT_MEMLOCK is 0 or locking would exceed limit
  * capability-priority: 0
  * constraint: RLIMIT_MEMLOCK Resource Limit, The RLIMIT_MEMLOCK soft resource limit specifies the maximum bytes of memory that may be locked into RAM. Unprivileged processes are restricted to this limit. CAP_IPC_LOCK capability allows bypassing this limit entirely. The limit is enforced per-process, not per-user.
  * constraint-expr: RLIMIT_MEMLOCK Resource Limit, locked_memory + request_size <= RLIMIT_MEMLOCK || CAP_IPC_LOCK
  * constraint: Memory Pressure and OOM, Locking large amounts of memory can cause system-wide memory pressure and potentially trigger the OOM killer. The kernel does not prevent locking memory that would destabilize the system.
  * constraint: Special Memory Areas, Some memory types cannot be locked or are silently skipped: VM_IO/VM_PFNMAP areas (device mappings) are skipped; Hugetlb pages are inherently pinned and skipped; DAX mappings are always present in memory and skipped; Secret memory (memfd_secret) mappings are skipped; VM_DROPPABLE memory cannot be locked and is skipped; Gate VMA (kernel entry point) is skipped; VM_LOCKED areas are already locked. These special areas are silently excluded without error.
  *
  * Context: Process context. May sleep. Takes mmap_lock for write.
  *
  * Return: 0 on success, negative error code on failure
  */

>The other thing I would really like to see, to the extent we can, is
>that a bunch of patches adding all this data to the source will actually
>be accepted by the relevant maintainers.  It would be a shame to get all
>this infrastructure into place, then have things stall out due to
>maintainer pushback.  Maybe you should start by annotating the
>scheduler-related system calls; if that works the rest should be a piece
>of cake :)

In the RFC I've sent out I've specced out API from different subsystems
to solicit some feedback on those, but so fair it's been quiet.

I'll resend a "lean" RFC v3 with just the base macro spec infra +
kerneldoc support + "tricker" sched API + "trickier" mm API.

I'm thinking that if it's still quiet in a month or two I'll propose a
talk at LPC around it, or maybe try and feedback/consensus during
maintainer's summit.

But yes, it doesn't make sense to take it in until we have an ack from a
few larger subsystems.

-- 
Thanks,
Sasha

