Return-Path: <linux-api+bounces-4109-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 010E6AF05E3
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 23:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4251C081BD
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 21:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598E2701B8;
	Tue,  1 Jul 2025 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="cTLDmv+s"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A262222A6;
	Tue,  1 Jul 2025 21:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406215; cv=none; b=dPahywrQCQU5g9unOfIYGB5Yx9eoi23kPGrFzXrLd6yAMtQrtgEXFI6I9IspRYFq5FAF0e2ys66u9EEiUtsnmP0Y8PP22thzi56Zb28C7Y2ZeBEzTieJ41bJkJn4dg1BNn4OI7SNbKLlJVlN+jbRd5wQQcXn5Ad6HRpQC2q5CJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406215; c=relaxed/simple;
	bh=aeOh9xtWgA7oa3iTsan3O3K18WkBC72uMcLaKz0UIlI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cw5Gw6Iq40QHRiMEXbGFPsYqhRA/p/AGfxFBMsSVYxmaRhe9br1heBM4AsV6R8gQb9SGhTgvoblCH7aLtIYc/LVUmYF9KG2SGjFWg7TaAAq9vX1mHd+sWCkV8hwsHGLEfjvbqMthduNqfGiAhamqV2ZhE45Yl05/8iiH013DnrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=cTLDmv+s; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 81304406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751406213; bh=JuLF2FYQoeAzXVgQja1F0ZGiLduFD0LBY43clBEjRbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cTLDmv+skNxIurMqg41YyPIIdm5zpJ7xw7y+53SlXPWHAM5XSQB/9qLLNa0OdUklk
	 jWqAKZLJc0sy/aVbOasPy4HDbwRKBrKPviqfHuWfkbx8no+DpknUBJGb3pqPNlV3gL
	 NEB0snr/hu9tLSVcNGlmSoB7mavkAvf1y93ALKpNivfTJCIrFisgZGKtsfUfW0j8AJ
	 pj8t/kzXzGQf/ArCB/I9ajV+AUCFXRrWY74Alsi0XEFFPEv45ApOm8Yxc0wKwqndlG
	 DqOEjWTf6nD3xqhRflX8ostg0rTiGg9meAH7B0s+rgYaqPfMDVwnu8VySSE3pKziF2
	 PEksMpUUJsuEg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 81304406FC;
	Tue,  1 Jul 2025 21:43:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org, workflows@vger.kernel.org, tools@kernel.org,
 Kate Stewart <kstewart@linuxfoundation.org>, Gabriele Paoloni
 <gpaoloni@redhat.com>, Chuck Wolber <chuckwolber@gmail.com>
Subject: Re: [RFC v2 01/22] kernel/api: introduce kernel API specification
 framework
In-Reply-To: <aGRKIuR6hgW0YLc_@lappy>
References: <20250624180742.5795-1-sashal@kernel.org>
 <20250624180742.5795-2-sashal@kernel.org> <874ivxuht8.fsf@trenco.lwn.net>
 <20250701002058.1cae5a7e@foz.lan> <aGPvR-Mj6aR4Y8B5@lappy>
 <8734bfspko.fsf@trenco.lwn.net> <aGRKIuR6hgW0YLc_@lappy>
Date: Tue, 01 Jul 2025 15:43:32 -0600
Message-ID: <87v7obpoxn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> So I have a proof of concept which during the build process creates
> .apispec.h which are generated from kerneldoc and contain macros
> identical to the ones in my RFC.
>
> Here's an example of sys_mlock() spec:

So I'm getting ahead of the game, but I have to ask some questions...

> /**
>   * sys_mlock - Lock pages in memory
>   * @start: Starting address of memory range to lock
>   * @len: Length of memory range to lock in bytes
>   *
>   * Locks pages in the specified address range into RAM, preventing them from
>   * being paged to swap. Requires CAP_IPC_LOCK capability or RLIMIT_MEMLOCK
>   * resource limit.
>   *
>   * long-desc: Locks pages in the specified address range into RAM, preventing
>   *   them from being paged to swap. Requires CAP_IPC_LOCK capability
>   *   or RLIMIT_MEMLOCK resource limit.

Why duplicate the long description?

>   * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
>   * param-type: start, KAPI_TYPE_UINT

This is something I wondered before; rather than a bunch of lengthy
KAPI_* symbols, why not just say __u64 (or some other familiar type)
here?

>   * param-flags: start, KAPI_PARAM_IN
>   * param-constraint-type: start, KAPI_CONSTRAINT_NONE
>   * param-constraint: start, Rounded down to page boundary
>   * param-type: len, KAPI_TYPE_UINT
>   * param-flags: len, KAPI_PARAM_IN
>   * param-constraint-type: len, KAPI_CONSTRAINT_RANGE
>   * param-range: len, 0, LONG_MAX
>   * param-constraint: len, Rounded up to page boundary
>   * return-type: KAPI_TYPE_INT
>   * return-check-type: KAPI_RETURN_ERROR_CHECK
>   * return-success: 0
>   * error-code: -ENOMEM, ENOMEM, Address range issue,
>   *   Some of the specified range is not mapped, has unmapped gaps,
>   *   or the lock would cause the number of mapped regions to exceed the limit.
>   * error-code: -EPERM, EPERM, Insufficient privileges,
>   *   The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.
>   * error-code: -EINVAL, EINVAL, Address overflow,
>   *   The result of the addition start+len was less than start (arithmetic overflow).
>   * error-code: -EAGAIN, EAGAIN, Some or all memory could not be locked,
>   *   Some or all of the specified address range could not be locked.
>   * error-code: -EINTR, EINTR, Interrupted by signal,
>   *   The operation was interrupted by a fatal signal before completion.
>   * error-code: -EFAULT, EFAULT, Bad address,
>   *   The specified address range contains invalid addresses that cannot be accessed.
>   * since-version: 2.0
>   * lock: mmap_lock, KAPI_LOCK_RWLOCK
>   * lock-acquired: true
>   * lock-released: true
>   * lock-desc: Process memory map write lock
>   * signal: FATAL
>   * signal-direction: KAPI_SIGNAL_RECEIVE
>   * signal-action: KAPI_SIGNAL_ACTION_RETURN
>   * signal-condition: Fatal signal pending
>   * signal-desc: Fatal signals (SIGKILL) can interrupt the operation at two points:
>   *   when acquiring mmap_write_lock_killable() and during page population
>   *   in __mm_populate(). Returns -EINTR. Non-fatal signals do NOT interrupt
>   *   mlock - the operation continues even if SIGINT/SIGTERM are received.
>   * signal-error: -EINTR
>   * signal-timing: KAPI_SIGNAL_TIME_DURING
>   * signal-priority: 0
>   * signal-interruptible: yes
>   * signal-state-req: KAPI_SIGNAL_STATE_RUNNING
>   * examples: mlock(addr, 4096);  // Lock one page
>   *   mlock(addr, len);   // Lock range of pages
>   * notes: Memory locks do not stack - multiple calls on the same range can be
>   *   undone by a single munlock. Locks are not inherited by child processes.
>   *   Pages are locked on whole page boundaries. Commonly used by real-time
>   *   applications to prevent page faults during time-critical operations.
>   *   Also used for security to prevent sensitive data (e.g., cryptographic keys)
>   *   from being written to swap. Note: locked pages may still be saved to
>   *   swap during system suspend/hibernate.
>   *
>   *   Tagged addresses are automatically handled via untagged_addr(). The operation
>   *   occurs in two phases: first VMAs are marked with VM_LOCKED, then pages are
>   *   populated into memory. When checking RLIMIT_MEMLOCK, the kernel optimizes
>   *   by recounting locked memory to avoid double-counting overlapping regions.
>   * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, process memory, Locks pages into physical memory, preventing swapping, reversible=yes

I hope the really long lines starting here aren't the intended way to go...:)

>   * side-effect: KAPI_EFFECT_MODIFY_STATE, mm->locked_vm, Increases process locked memory counter, reversible=yes
>   * side-effect: KAPI_EFFECT_ALLOC_MEMORY, physical pages, May allocate and populate page table entries, condition=Pages not already present, reversible=yes
>   * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, page faults, Triggers page faults to bring pages into memory, condition=Pages not already resident
>   * side-effect: KAPI_EFFECT_MODIFY_STATE, VMA splitting, May split existing VMAs at lock boundaries, condition=Lock range partially overlaps existing VMA
>   * state-trans: memory pages, swappable, locked in RAM, Pages become non-swappable and pinned in physical memory
>   * state-trans: VMA flags, unlocked, VM_LOCKED set, Virtual memory area marked as locked
>   * capability: CAP_IPC_LOCK, KAPI_CAP_BYPASS_CHECK, CAP_IPC_LOCK capability
>   * capability-allows: Lock unlimited amount of memory (no RLIMIT_MEMLOCK enforcement)
>   * capability-without: Must respect RLIMIT_MEMLOCK resource limit
>   * capability-condition: Checked when RLIMIT_MEMLOCK is 0 or locking would exceed limit
>   * capability-priority: 0
>   * constraint: RLIMIT_MEMLOCK Resource Limit, The RLIMIT_MEMLOCK soft resource limit specifies the maximum bytes of memory that may be locked into RAM. Unprivileged processes are restricted to this limit. CAP_IPC_LOCK capability allows bypassing this limit entirely. The limit is enforced per-process, not per-user.
>   * constraint-expr: RLIMIT_MEMLOCK Resource Limit, locked_memory + request_size <= RLIMIT_MEMLOCK || CAP_IPC_LOCK
>   * constraint: Memory Pressure and OOM, Locking large amounts of memory can cause system-wide memory pressure and potentially trigger the OOM killer. The kernel does not prevent locking memory that would destabilize the system.
>   * constraint: Special Memory Areas, Some memory types cannot be locked or are silently skipped: VM_IO/VM_PFNMAP areas (device mappings) are skipped; Hugetlb pages are inherently pinned and skipped; DAX mappings are always present in memory and skipped; Secret memory (memfd_secret) mappings are skipped; VM_DROPPABLE memory cannot be locked and is skipped; Gate VMA (kernel entry point) is skipped; VM_LOCKED areas are already locked. These special areas are silently excluded without error.
>   *
>   * Context: Process context. May sleep. Takes mmap_lock for write.
>   *
>   * Return: 0 on success, negative error code on failure

Both of these, of course, are much less informative versions of the data
you have put up above; it would be nice to unify them somehow.

Thanks,

jon

