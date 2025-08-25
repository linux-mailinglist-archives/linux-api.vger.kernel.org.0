Return-Path: <linux-api+bounces-4584-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D2DB349F1
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 20:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 808867A7D8F
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC19A310782;
	Mon, 25 Aug 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfwOrZ3I"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7BD31065B;
	Mon, 25 Aug 2025 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145681; cv=none; b=OdBGtESC+/zjk4uakXmowBKvvqCbGpcPSEf8xRveDt3lChzC+UYEAvJuZ8xzvpmH+eUEsyQc6QlL/k+4qByEW0tEtFRpAVopUCxK7ROk3e7iiBxCqRWF6BXwPqWTHuRBGTCeYe7IqT9cQoOwSbEvl3C2+IVSqK0WPrVGGA8TpFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145681; c=relaxed/simple;
	bh=3IqAu0mswHEy7g0Wmqiy+rMEn3vYAFW5qqbnp2djWl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBIHDa9Fl1bTxeSAjQl3GSSyPGo3DhNeterkn3Xw3/PsI8smFkZvJrPIO4YGdTTG+ZYRpdkVI0y13vy9Cxzvb0tn617kUVkr37VO3j6aGMQXDHmhlkDp4QaoaekALes//K5HMavERqwjrkXNyyTY2Ebn3BfHg0G7vacSdRP3YqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfwOrZ3I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD91C19421;
	Mon, 25 Aug 2025 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145681;
	bh=3IqAu0mswHEy7g0Wmqiy+rMEn3vYAFW5qqbnp2djWl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hfwOrZ3IBduNHmv0bdBkwVVPwi/CgD7N8WeMMVjXcR09MJ8Mni6IELk3dlU4CYYdz
	 TQ738v7D8YBTA01ZmkMrwqfkES358va5DA4/wV/agFTIyDd2yNe7C7u49BBZIjUwIo
	 AWFwtnm4ol9/zjP6uc9zPqovW+Mc/6KNENVVwgMi4YXO+OxXG7P+ARmI7nUhj/gEJh
	 krbPqa5PnijhY4wHxvy+8eIprSCTt2a08dnaZ7qV/45E2R60l0z4yglJtXW45OWn5f
	 hEjuiWX2vVGCI2KitOPi8j4+WHtTcVyF73/HujZYaqtNznd9kAQHDIwvJbC8gOYlWF
	 HuMwDB6qkXqvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tools@kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH v4 5/7] mm/mlock: add API specification for mlock
Date: Mon, 25 Aug 2025 14:14:32 -0400
Message-ID: <20250825181434.3340805-6-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825181434.3340805-1-sashal@kernel.org>
References: <20250825181434.3340805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel API specification for the mlock() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index a1d93ad33c6d..36eac7fec17d 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -656,6 +656,140 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	return 0;
 }
 
+/**
+ * sys_mlock - Lock pages in memory
+ * @start: Starting address of memory range to lock
+ * @len: Length of memory range to lock in bytes
+ *
+ * long-desc: Locks pages in the specified address range into RAM, preventing
+ *   them from being paged to swap. Requires CAP_IPC_LOCK capability
+ *   or RLIMIT_MEMLOCK resource limit.
+ *
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ *
+ * param: start, KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_NONE
+ *   constraint: Automatically page-aligned down by kernel (PAGE_ALIGN_DOWN)
+ *
+ * param: len, KAPI_TYPE_UINT
+ *   flags: KAPI_PARAM_IN
+ *   constraint-type: KAPI_CONSTRAINT_RANGE
+ *   range: 0, LONG_MAX
+ *   constraint: Automatically page-aligned up by kernel (PAGE_ALIGN)
+ *
+ * return:
+ *   type: KAPI_TYPE_INT
+ *   check-type: KAPI_RETURN_ERROR_CHECK
+ *   success: 0
+ *
+ * error: ENOMEM, Address range issue
+ *   desc: Some of the specified range is not mapped, has unmapped gaps,
+ *   or the lock would cause the number of mapped regions to exceed the limit.
+ *
+ * error: EPERM, Insufficient privileges
+ *   desc: The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.
+ *
+ * error: EINVAL, Address overflow
+ *   desc: The result of the addition start+len was less than start (arithmetic overflow).
+ *
+ * error: EAGAIN, Some or all memory could not be locked
+ *   desc: Some or all of the specified address range could not be locked.
+ *
+ * error: EINTR, Interrupted by signal
+ *   desc: The operation was interrupted by a fatal signal before completion.
+ *
+ * error: EFAULT, Bad address
+ *   desc: The specified address range contains invalid addresses that cannot be accessed.
+ *
+ * since-version: 2.0
+ *
+ * lock: mmap_lock, KAPI_LOCK_RWLOCK
+ *   acquired: true
+ *   released: true
+ *   desc: Process memory map write lock
+ *
+ * signal: FATAL
+ *   direction: KAPI_SIGNAL_RECEIVE
+ *   action: KAPI_SIGNAL_ACTION_RETURN
+ *   condition: Fatal signal pending
+ *   desc: Fatal signals (SIGKILL) can interrupt the operation at two points:
+ *   when acquiring mmap_write_lock_killable() and during page population
+ *   in __mm_populate(). Returns -EINTR. Non-fatal signals do NOT interrupt
+ *   mlock - the operation continues even if SIGINT/SIGTERM are received.
+ *   error: -EINTR
+ *   timing: KAPI_SIGNAL_TIME_DURING
+ *   priority: 0
+ *   interruptible: yes
+ *   state-req: KAPI_SIGNAL_STATE_RUNNING
+ *
+ * examples: mlock(addr, 4096);  // Lock one page
+ *   mlock(addr, len);   // Lock range of pages
+ *
+ * notes: Memory locks do not stack - multiple calls on the same range can be
+ *   undone by a single munlock. Locks are not inherited by child processes.
+ *   Pages are locked on whole page boundaries. Commonly used by real-time
+ *   applications to prevent page faults during time-critical operations.
+ *   Also used for security to prevent sensitive data (e.g., cryptographic keys)
+ *   from being written to swap. Note: locked pages may still be saved to
+ *   swap during system suspend/hibernate.
+ *
+ *   Tagged addresses are automatically handled via untagged_addr(). The operation
+ *   occurs in two phases: first VMAs are marked with VM_LOCKED, then pages are
+ *   populated into memory. When checking RLIMIT_MEMLOCK, the kernel optimizes
+ *   by recounting locked memory to avoid double-counting overlapping regions.
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY
+ *   target: process memory
+ *   desc: Locks pages into physical memory, preventing swapping
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: mm->locked_vm
+ *   desc: Increases process locked memory counter
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_ALLOC_MEMORY
+ *   target: physical pages
+ *   desc: May allocate and populate page table entries
+ *   condition: Pages not already present
+ *   reversible: yes
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY
+ *   target: page faults
+ *   desc: Triggers page faults to bring pages into memory
+ *   condition: Pages not already resident
+ *
+ * side-effect: KAPI_EFFECT_MODIFY_STATE
+ *   target: VMA splitting
+ *   desc: May split existing VMAs at lock boundaries
+ *   condition: Lock range partially overlaps existing VMA
+ *
+ * state-trans: memory pages
+ *   from: swappable
+ *   to: locked in RAM
+ *   desc: Pages become non-swappable and pinned in physical memory
+ *
+ * state-trans: VMA flags
+ *   from: unlocked
+ *   to: VM_LOCKED set
+ *   desc: Virtual memory area marked as locked
+ *
+ * capability: CAP_IPC_LOCK, KAPI_CAP_BYPASS_CHECK, CAP_IPC_LOCK capability
+ *   allows: Lock unlimited amount of memory (no RLIMIT_MEMLOCK enforcement)
+ *   without: Must respect RLIMIT_MEMLOCK resource limit
+ *   condition: Checked when RLIMIT_MEMLOCK is 0 or locking would exceed limit
+ *   priority: 0
+ *
+ * constraint: RLIMIT_MEMLOCK Resource Limit
+ *   desc: The RLIMIT_MEMLOCK soft resource limit specifies the maximum bytes of memory that may be locked into RAM. Unprivileged processes are restricted to this limit. CAP_IPC_LOCK capability allows bypassing this limit entirely. The limit is enforced per-process, not per-user.
+ *   expr: locked_memory + request_size <= RLIMIT_MEMLOCK || CAP_IPC_LOCK
+ *
+ * constraint: Memory Pressure and OOM
+ *   desc: Locking large amounts of memory can cause system-wide memory pressure and potentially trigger the OOM killer. The kernel does not prevent locking memory that would destabilize the system.
+ *
+ * constraint: Special Memory Areas
+ *   desc: Some memory types cannot be locked or are silently skipped: VM_IO/VM_PFNMAP areas (device mappings) are skipped; Hugetlb pages are inherently pinned and skipped; DAX mappings are always present in memory and skipped; Secret memory (memfd_secret) mappings are skipped; VM_DROPPABLE memory cannot be locked and is skipped; Gate VMA (kernel entry point) is skipped; VM_LOCKED areas are already locked. These special areas are silently excluded without error.
+ */
 SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 {
 	return do_mlock(start, len, VM_LOCKED);
-- 
2.50.1


