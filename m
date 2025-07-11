Return-Path: <linux-api+bounces-4152-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79AB01AF0
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 13:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C213ACAE4
	for <lists+linux-api@lfdr.de>; Fri, 11 Jul 2025 11:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B762C031B;
	Fri, 11 Jul 2025 11:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/8Xg16w"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DB22BE7B0;
	Fri, 11 Jul 2025 11:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234178; cv=none; b=SMXFc58alN1Im3tEHl0kGwBmc41r422mgzbyOPViwNyric/8XAhHivnwf9Cgqs9JFq6Yeg/3lmJGpIQIDgXFAzZPR5HyFDlMU9pJk5iKTjZIfMo0UqWs+JIZkbdfDB8xxKzX/PevGw2YOFNDOsxjH6JceYCvAl681lMb0W3RV54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234178; c=relaxed/simple;
	bh=3kHblUKEizjlTCP43dYfKwHvEr2G5UZmIOsyHK/Iavs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFMIDK8tY90VPb7+TL7jc88Iw0uTqlsFs3HHWsBsU8GT+AEQMjj8wBLUdE5E+Kqfg/0zhMdS2IdYfT8ejfSCVilLVnM8qd8qMqSz73fBD14XKbTJ5E0p1HeUsZIjp2ayJiYb86/AAAtlcK+VQkztrB0hrNZJGonRWxHRgseWUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/8Xg16w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C226C4CEF5;
	Fri, 11 Jul 2025 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752234177;
	bh=3kHblUKEizjlTCP43dYfKwHvEr2G5UZmIOsyHK/Iavs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d/8Xg16wQ0QOwyPTaO8jAGC4fV2mQ2ZBoiW94VH1arsCEzaKncMX7ezPe5caLbbF9
	 hOB1Y7NifkrCxDrjOUdgZasUAWJdLisEKnA87DTMBVVCubzsWQoFLsL2Wgpok7zTnj
	 fdVw6DAP342VZSygXOmLocZstMO9j64o2lM6sdFV7XgY+pq9Nw15GQV4YpluL+o3vJ
	 O0KHik8uOBWC81bo9zyIuMzyQiU9bvAqBW8p91QubZQI8EC62kOOsZEL6Gwk6YJiot
	 UW9vLR5U4nrDn7OpAJCy3Fg33jX7QGF7kowfaPmFZhKdX9/We33Si6spCGmclBeb8X
	 Nulj3whSwVmaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v3 3/4] mm/mlock: add API specification for mlock
Date: Fri, 11 Jul 2025 07:42:47 -0400
Message-Id: <20250711114248.2288591-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250711114248.2288591-1-sashal@kernel.org>
References: <20250711114248.2288591-1-sashal@kernel.org>
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
 mm/mlock.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 3cb72b579ffd3..06e260da5aba6 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -658,6 +658,91 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
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
+ * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
+ * param-type: start, KAPI_TYPE_UINT
+ * param-flags: start, KAPI_PARAM_IN
+ * param-constraint-type: start, KAPI_CONSTRAINT_NONE
+ * param-constraint: start, Rounded down to page boundary
+ * param-type: len, KAPI_TYPE_UINT
+ * param-flags: len, KAPI_PARAM_IN
+ * param-constraint-type: len, KAPI_CONSTRAINT_RANGE
+ * param-range: len, 0, LONG_MAX
+ * param-constraint: len, Rounded up to page boundary
+ * return-type: KAPI_TYPE_INT
+ * return-check-type: KAPI_RETURN_ERROR_CHECK
+ * return-success: 0
+ * error-code: -ENOMEM, ENOMEM, Address range issue,
+ *   Some of the specified range is not mapped, has unmapped gaps,
+ *   or the lock would cause the number of mapped regions to exceed the limit.
+ * error-code: -EPERM, EPERM, Insufficient privileges,
+ *   The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.
+ * error-code: -EINVAL, EINVAL, Address overflow,
+ *   The result of the addition start+len was less than start (arithmetic overflow).
+ * error-code: -EAGAIN, EAGAIN, Some or all memory could not be locked,
+ *   Some or all of the specified address range could not be locked.
+ * error-code: -EINTR, EINTR, Interrupted by signal,
+ *   The operation was interrupted by a fatal signal before completion.
+ * error-code: -EFAULT, EFAULT, Bad address,
+ *   The specified address range contains invalid addresses that cannot be accessed.
+ * since-version: 2.0
+ * lock: mmap_lock, KAPI_LOCK_RWLOCK
+ * lock-acquired: true
+ * lock-released: true
+ * lock-desc: Process memory map write lock
+ * signal: FATAL
+ * signal-direction: KAPI_SIGNAL_RECEIVE
+ * signal-action: KAPI_SIGNAL_ACTION_RETURN
+ * signal-condition: Fatal signal pending
+ * signal-desc: Fatal signals (SIGKILL) can interrupt the operation at two points:
+ *   when acquiring mmap_write_lock_killable() and during page population
+ *   in __mm_populate(). Returns -EINTR. Non-fatal signals do NOT interrupt
+ *   mlock - the operation continues even if SIGINT/SIGTERM are received.
+ * signal-error: -EINTR
+ * signal-timing: KAPI_SIGNAL_TIME_DURING
+ * signal-priority: 0
+ * signal-interruptible: yes
+ * signal-state-req: KAPI_SIGNAL_STATE_RUNNING
+ * examples: mlock(addr, 4096);  // Lock one page
+ *   mlock(addr, len);   // Lock range of pages
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
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, process memory, Locks pages into physical memory, preventing swapping, reversible=yes
+ * side-effect: KAPI_EFFECT_MODIFY_STATE, mm->locked_vm, Increases process locked memory counter, reversible=yes
+ * side-effect: KAPI_EFFECT_ALLOC_MEMORY, physical pages, May allocate and populate page table entries, condition=Pages not already present, reversible=yes
+ * side-effect: KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY, page faults, Triggers page faults to bring pages into memory, condition=Pages not already resident
+ * side-effect: KAPI_EFFECT_MODIFY_STATE, VMA splitting, May split existing VMAs at lock boundaries, condition=Lock range partially overlaps existing VMA
+ * state-trans: memory pages, swappable, locked in RAM, Pages become non-swappable and pinned in physical memory
+ * state-trans: VMA flags, unlocked, VM_LOCKED set, Virtual memory area marked as locked
+ * capability: CAP_IPC_LOCK, KAPI_CAP_BYPASS_CHECK, CAP_IPC_LOCK capability
+ * capability-allows: Lock unlimited amount of memory (no RLIMIT_MEMLOCK enforcement)
+ * capability-without: Must respect RLIMIT_MEMLOCK resource limit
+ * capability-condition: Checked when RLIMIT_MEMLOCK is 0 or locking would exceed limit
+ * capability-priority: 0
+ * constraint: RLIMIT_MEMLOCK Resource Limit, The RLIMIT_MEMLOCK soft resource limit specifies the maximum bytes of memory that may be locked into RAM. Unprivileged processes are restricted to this limit. CAP_IPC_LOCK capability allows bypassing this limit entirely. The limit is enforced per-process, not per-user.
+ * constraint-expr: RLIMIT_MEMLOCK Resource Limit, locked_memory + request_size <= RLIMIT_MEMLOCK || CAP_IPC_LOCK
+ * constraint: Memory Pressure and OOM, Locking large amounts of memory can cause system-wide memory pressure and potentially trigger the OOM killer. The kernel does not prevent locking memory that would destabilize the system.
+ * constraint: Special Memory Areas, Some memory types cannot be locked or are silently skipped: VM_IO/VM_PFNMAP areas (device mappings) are skipped; Hugetlb pages are inherently pinned and skipped; DAX mappings are always present in memory and skipped; Secret memory (memfd_secret) mappings are skipped; VM_DROPPABLE memory cannot be locked and is skipped; Gate VMA (kernel entry point) is skipped; VM_LOCKED areas are already locked. These special areas are silently excluded without error.
+ *
+ * Context: Process context. May sleep. Takes mmap_lock for write.
+ */
 SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 {
 	return do_mlock(start, len, VM_LOCKED);
-- 
2.39.5


