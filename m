Return-Path: <linux-api+bounces-4110-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D483AF0678
	for <lists+linux-api@lfdr.de>; Wed,  2 Jul 2025 00:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C053F16BA1B
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 22:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1A1283FF6;
	Tue,  1 Jul 2025 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeIjGmx/"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B5266560;
	Tue,  1 Jul 2025 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408175; cv=none; b=Tt7mT979GvrTZhdKQcHD44swHzfzeT9FUMCqA3gBHojaDYtZWunoojvwNmtlcTePdkSEanK2bpE5PHi78p94tyj2LOiDbgVKdNf914IK2Y009YVYbICFSEQh3p7VaOZ0//JTV3OD2jM2+CZStdgPtzFA17Y2jqRicZsX0R68heA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408175; c=relaxed/simple;
	bh=KfnSrmI/dKnhXkqIVKSpgD5rdZOaahBffr0vrf9OsTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr86S6L0cBw4tHBykvT153xZ23nGnmFwSPKDqhkVODnxDBkHuFT3nmQkeJIDAvHSW1JshBrniKUmBRxk0ZYywDj74oCkAJlGWFNj9Ajr9Z1FKP7qfeQgILe9i0exGO+4DWg+biRpsydm1Xme0MpxGjYFSDiMyy4Rb23XP30KvXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeIjGmx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B732C4CEEB;
	Tue,  1 Jul 2025 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408175;
	bh=KfnSrmI/dKnhXkqIVKSpgD5rdZOaahBffr0vrf9OsTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WeIjGmx/v3dLOkhNfqcvO1zi1iuwS6SVGjzNcldz3vvgCd1NXrpcGzuwQmyPQn1P9
	 NVEAJBbmQkvLL3HCtUdU7u0uFJCR+VfrEHlzCoDwgJWcOqreKOPuQuambJSGQN47my
	 fN9QkvqrRcnZlWLLGK5nDFQWHDO0Rrmocdgl2HvSqjSFVTdULFWzyQc3TdEfPunaQG
	 N7iuwFBMJen2k5TcIC/ThYBOR03tCuPMJPjCtiPj3yIyRaFA7zUYyDrFlLju+Xv0On
	 kZy+jNH6NBcjZc5/ywV9nMCzzGGA3YQMTTQBZSXORD74afTEhgNUx4iNUGWfVR4CgN
	 7blk7uOX0B6oA==
Date: Tue, 1 Jul 2025 18:16:13 -0400
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
Message-ID: <aGReLaCleEjzu-nt@lappy>
References: <20250624180742.5795-1-sashal@kernel.org>
 <20250624180742.5795-2-sashal@kernel.org>
 <874ivxuht8.fsf@trenco.lwn.net>
 <20250701002058.1cae5a7e@foz.lan>
 <aGPvR-Mj6aR4Y8B5@lappy>
 <8734bfspko.fsf@trenco.lwn.net>
 <aGRKIuR6hgW0YLc_@lappy>
 <87v7obpoxn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87v7obpoxn.fsf@trenco.lwn.net>

On Tue, Jul 01, 2025 at 03:43:32PM -0600, Jonathan Corbet wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> So I have a proof of concept which during the build process creates
>> .apispec.h which are generated from kerneldoc and contain macros
>> identical to the ones in my RFC.
>>
>> Here's an example of sys_mlock() spec:
>
>So I'm getting ahead of the game, but I have to ask some questions...
>
>> /**
>>   * sys_mlock - Lock pages in memory
>>   * @start: Starting address of memory range to lock
>>   * @len: Length of memory range to lock in bytes
>>   *
>>   * Locks pages in the specified address range into RAM, preventing them from
>>   * being paged to swap. Requires CAP_IPC_LOCK capability or RLIMIT_MEMLOCK
>>   * resource limit.
>>   *
>>   * long-desc: Locks pages in the specified address range into RAM, preventing
>>   *   them from being paged to swap. Requires CAP_IPC_LOCK capability
>>   *   or RLIMIT_MEMLOCK resource limit.
>
>Why duplicate the long description?

Will fix.

>>   * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
>>   * param-type: start, KAPI_TYPE_UINT
>
>This is something I wondered before; rather than a bunch of lengthy
>KAPI_* symbols, why not just say __u64 (or some other familiar type)
>here?

I think it gets tricky when we got to more complex types. For example,
how do we represent a FD or a (struct sockaddr *)?

With macros, KAPI_TYPE_FD or KAPI_TYPE_SOCKADDR make sense, but
__sockaddr will be a bit confusing (I think).

>>   * param-flags: start, KAPI_PARAM_IN
>>   * param-constraint-type: start, KAPI_CONSTRAINT_NONE
>>   * param-constraint: start, Rounded down to page boundary
>>   * param-type: len, KAPI_TYPE_UINT
>>   * param-flags: len, KAPI_PARAM_IN
>>   * param-constraint-type: len, KAPI_CONSTRAINT_RANGE
>>   * param-range: len, 0, LONG_MAX
>>   * param-constraint: len, Rounded up to page boundary
>>   * return-type: KAPI_TYPE_INT
>>   * return-check-type: KAPI_RETURN_ERROR_CHECK
>>   * return-success: 0
>>   * error-code: -ENOMEM, ENOMEM, Address range issue,
>>   *   Some of the specified range is not mapped, has unmapped gaps,
>>   *   or the lock would cause the number of mapped regions to exceed the limit.
>>   * error-code: -EPERM, EPERM, Insufficient privileges,
>>   *   The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.
>>   * error-code: -EINVAL, EINVAL, Address overflow,
>>   *   The result of the addition start+len was less than start (arithmetic overflow).
>>   * error-code: -EAGAIN, EAGAIN, Some or all memory could not be locked,
>>   *   Some or all of the specified address range could not be locked.
>>   * error-code: -EINTR, EINTR, Interrupted by signal,
>>   *   The operation was interrupted by a fatal signal before completion.
>>   * error-code: -EFAULT, EFAULT, Bad address,
>>   *   The specified address range contains invalid addresses that cannot be accessed.
>>   * since-version: 2.0
>>   * lock: mmap_lock, KAPI_LOCK_RWLOCK
>>   * lock-acquired: true
>>   * lock-released: true
>>   * lock-desc: Process memory map write lock
>>   * signal: FATAL
>>   * signal-direction: KAPI_SIGNAL_RECEIVE
>>   * signal-action: KAPI_SIGNAL_ACTION_RETURN
>>   * signal-condition: Fatal signal pending
>>   * signal-desc: Fatal signals (SIGKILL) can interrupt the operation at two points:
>>   *   when acquiring mmap_write_lock_killable() and during page population
>>   *   in __mm_populate(). Returns -EINTR. Non-fatal signals do NOT interrupt
>>   *   mlock - the operation continues even if SIGINT/SIGTERM are received.
>>   * signal-error: -EINTR
>>   * signal-timing: KAPI_SIGNAL_TIME_DURING
>>   * signal-priority: 0
>>   * signal-interruptible: yes
>>   * signal-state-req: KAPI_SIGNAL_STATE_RUNNING
>>   * examples: mlock(addr, 4096);  // Lock one page
>>   *   mlock(addr, len);   // Lock range of pages
>>   * notes: Memory locks do not stack - multiple calls on the same range can be
>>   *   undone by a single munlock. Locks are not inherited by child processes.
>>   *   Pages are locked on whole page boundaries. Commonly used by real-time
>>   *   applications to prevent page faults during time-critical operations.
>>   *   Also used for security to prevent sensitive data (e.g., cryptographic keys)
>>   *   from being written to swap. Note: locked pages may still be saved to
>>   *   swap during system suspend/hibernate.
>>   *
>>   *   Tagged addresses are automatically handled via untagged_addr(). The operation
>>   *   occurs in two phases: first VMAs are marked with VM_LOCKED, then pages are
>>   *   populated into memory. When checking RLIMIT_MEMLOCK, the kernel optimizes
>>   *   by recounting locked memory to avoid double-counting overlapping regions.
>>   * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, process memory, Locks pages into physical memory, preventing swapping, reversible=yes
>
>I hope the really long lines starting here aren't the intended way to go...:)

I guess that we have two options around more complex blocks like these.

One, the longer lines you've pointed out. They are indeed long and
difficult to read, but they present a relatively static and "not too
interesting" information which users are likely to gloss over.

The other one would look something like:

side-effect: KAPI_EFFECT_MODIFY_STATE
side-effect-type: KAPI_EFFECT_MODIFY_STATE
side-effect-target: mm->locked_vm
side-effect-description: Increases process locked memory counter
side-effect-reversible: yes

Which isn't as long, but it occupies a bunch of vertical real estate
while not being too interesting for most of the readers.

>>   * side-effect: KAPI_EFFECT_MODIFY_STATE, mm->locked_vm, Increases process locked memory counter, reversible=yes
>>   * side-effect: KAPI_EFFECT_ALLOC_MEMORY, physical pages, May allocate and populate page table entries, condition=Pages not already present, reversible=yes
>>   * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, page faults, Triggers page faults to bring pages into memory, condition=Pages not already resident
>>   * side-effect: KAPI_EFFECT_MODIFY_STATE, VMA splitting, May split existing VMAs at lock boundaries, condition=Lock range partially overlaps existing VMA
>>   * state-trans: memory pages, swappable, locked in RAM, Pages become non-swappable and pinned in physical memory
>>   * state-trans: VMA flags, unlocked, VM_LOCKED set, Virtual memory area marked as locked
>>   * capability: CAP_IPC_LOCK, KAPI_CAP_BYPASS_CHECK, CAP_IPC_LOCK capability
>>   * capability-allows: Lock unlimited amount of memory (no RLIMIT_MEMLOCK enforcement)
>>   * capability-without: Must respect RLIMIT_MEMLOCK resource limit
>>   * capability-condition: Checked when RLIMIT_MEMLOCK is 0 or locking would exceed limit
>>   * capability-priority: 0
>>   * constraint: RLIMIT_MEMLOCK Resource Limit, The RLIMIT_MEMLOCK soft resource limit specifies the maximum bytes of memory that may be locked into RAM. Unprivileged processes are restricted to this limit. CAP_IPC_LOCK capability allows bypassing this limit entirely. The limit is enforced per-process, not per-user.
>>   * constraint-expr: RLIMIT_MEMLOCK Resource Limit, locked_memory + request_size <= RLIMIT_MEMLOCK || CAP_IPC_LOCK
>>   * constraint: Memory Pressure and OOM, Locking large amounts of memory can cause system-wide memory pressure and potentially trigger the OOM killer. The kernel does not prevent locking memory that would destabilize the system.
>>   * constraint: Special Memory Areas, Some memory types cannot be locked or are silently skipped: VM_IO/VM_PFNMAP areas (device mappings) are skipped; Hugetlb pages are inherently pinned and skipped; DAX mappings are always present in memory and skipped; Secret memory (memfd_secret) mappings are skipped; VM_DROPPABLE memory cannot be locked and is skipped; Gate VMA (kernel entry point) is skipped; VM_LOCKED areas are already locked. These special areas are silently excluded without error.
>>   *
>>   * Context: Process context. May sleep. Takes mmap_lock for write.
>>   *
>>   * Return: 0 on success, negative error code on failure
>
>Both of these, of course, are much less informative versions of the data
>you have put up above; it would be nice to unify them somehow.

Ack

-- 
Thanks,
Sasha

