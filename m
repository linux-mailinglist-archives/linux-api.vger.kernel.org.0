Return-Path: <linux-api+bounces-3972-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F0FAE6E3A
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4AA87B12FF
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17572E7181;
	Tue, 24 Jun 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaHIVcI2"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699DC2EB5B9;
	Tue, 24 Jun 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788473; cv=none; b=HHpH98Gv4ON5nzu2H30LciRVgDkiznPMDsVN9r7uCHBv5FdTY8BqlRb627ZEdyKAy4si/dMLB4RrgJhPiNZ3N+9lJcbpzvyAZRLfXls2pEXFuYlbarPjjKt73T+lmThvgoRjjl0qIgGsWElWJ/AzCpi1DIlwn1EO2KN6XHkVRVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788473; c=relaxed/simple;
	bh=JOT8BR4Z+AaDNYtFON2tEwQmuCgraDOHfzAKgrc0JVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDsRvuk0NjQpjBZhsqHgn1rF8bq3svsAXsMCiwd/+bcF971HhmaCCdHxf7/j60wnHAyX50ur8uT/RPLP+5Ci1p3Vzj0iMRnc9Y2Ifu6witTq3V6Q8gzs9tSc8Pv1uVCh2TQsR6/pC2AyZfYNelSanut+cPnBLiyc2H+3PzDMwNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaHIVcI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED49BC4CEEF;
	Tue, 24 Jun 2025 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788473;
	bh=JOT8BR4Z+AaDNYtFON2tEwQmuCgraDOHfzAKgrc0JVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaHIVcI2z4EECq2hD3kLpkRhrOhFO8sqVBW+iNZl8NwlntpaVGYIAVhRA60LxeCsG
	 BTX6/AiUrqXNnJSFA/XRrCLAuja765z0soDe4EZpE6pifbY421eutzJ77Px7ySDJcx
	 3+jDHX4+z56iDUg5yxvePv4lyRvOcMSiSHTgWeu8yPAa/4qQx+C7ztlnd7kFbH5MTP
	 GM8+e0ahAd1ydLAsA+48kZm8z2bekAy7RlNZUouZZTyBSS9Ag0rZekZkJ5QTUPnUWq
	 DsHMcqA+QAcmPbaEzokVFn4TEDEP/tdy8oGfHSkR7PGnuyMibG0kA/zoRXKRL0+jVx
	 6RAxz23bO6A4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 11/22] mm/mlock: add API specification for mlock2
Date: Tue, 24 Jun 2025 14:07:31 -0400
Message-Id: <20250624180742.5795-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624180742.5795-1-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kernel API specification for the mlock2() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index b97768b1cfa60..869c6ba0a7ec8 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -805,6 +805,169 @@ SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 	return do_mlock(start, len, VM_LOCKED);
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_mlock2)
+	KAPI_DESCRIPTION("Lock pages in memory with flags")
+	KAPI_LONG_DESC("Enhanced version of mlock() that supports flags. "
+		       "MLOCK_ONFAULT flag allows locking pages on fault rather than immediately.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "start", "unsigned long", "Starting address of memory range to lock")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Rounded down to page boundary")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "len", "size_t", "Length of memory range to lock in bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, LONG_MAX)
+		KAPI_PARAM_CONSTRAINT("Rounded up to page boundary")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "flags", "int", "Flags controlling lock behavior")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_MASK)
+		KAPI_PARAM_VALID_MASK(MLOCK_ONFAULT)
+		KAPI_PARAM_CONSTRAINT("Only MLOCK_ONFAULT flag is currently supported")
+	KAPI_PARAM_END
+
+	/* Return specification */
+	KAPI_RETURN("long", "0 on success, negative error code on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.success_value = 0,
+	KAPI_RETURN_END
+
+	/* Error codes */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid flags", "Unknown flags were specified (flags & ~MLOCK_ONFAULT).")
+	KAPI_ERROR(1, -ENOMEM, "ENOMEM", "Address range issue", "Some of the specified range is not mapped, has unmapped gaps, or the lock would cause the number of mapped regions to exceed the limit.")
+	KAPI_ERROR(2, -EPERM, "EPERM", "Insufficient privileges", "The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.")
+	KAPI_ERROR(3, -EAGAIN, "EAGAIN", "Some or all memory could not be locked", "Some or all of the specified address range could not be locked.")
+	KAPI_ERROR(4, -EINTR, "EINTR", "Interrupted by signal", "The operation was interrupted by a fatal signal before completion.")
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Fatal signal pending during mmap_write_lock_killable")
+		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, SIGTERM, etc.) can interrupt the operation when acquiring mmap_write_lock_killable(), causing -EINTR return")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	KAPI_SIGNAL(1, SIGBUS, "SIGBUS", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_DEFAULT)
+		KAPI_SIGNAL_TARGET("Current process")
+		KAPI_SIGNAL_CONDITION("Memory access to locked page fails")
+		KAPI_SIGNAL_DESC("Can be generated if accessing a locked page that cannot be brought into memory (e.g., truncated file mapping)")
+	KAPI_SIGNAL_END
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY,
+			 "process memory",
+			 "Locks pages into physical memory, preventing swapping")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("Pages become resident in RAM")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE,
+			 "mm->locked_vm",
+			 "Increases process locked memory counter")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("Counted against RLIMIT_MEMLOCK")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_ALLOC_MEMORY,
+			 "page tables",
+			 "May allocate and populate page table entries")
+		KAPI_EFFECT_CONDITION("Pages not already present")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_MODIFY_STATE,
+			 "VMA flags",
+			 "Sets VM_LOCKED and optionally VM_LOCKONFAULT on affected VMAs")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_FILESYSTEM,
+			 "page fault behavior",
+			 "With MLOCK_ONFAULT, changes how future page faults are handled")
+		KAPI_EFFECT_CONDITION("MLOCK_ONFAULT flag specified")
+	KAPI_SIDE_EFFECT_END
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "memory pages",
+			 "swappable", "locked in RAM",
+			 "Pages become non-swappable and pinned in physical memory")
+		KAPI_STATE_TRANS_COND("Without MLOCK_ONFAULT")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "VMA flags",
+			 "unlocked", "VM_LOCKED set",
+			 "Virtual memory area marked as locked")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "VMA flags",
+			 "normal fault", "VM_LOCKONFAULT set",
+			 "VMA marked to lock pages on future faults")
+		KAPI_STATE_TRANS_COND("MLOCK_ONFAULT flag specified")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "page residency",
+			 "may be swapped", "resident in memory",
+			 "Pages brought into RAM and kept there")
+		KAPI_STATE_TRANS_COND("Without MLOCK_ONFAULT")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(4, "process statistics",
+			 "normal memory accounting", "locked memory accounting",
+			 "Memory counted against RLIMIT_MEMLOCK")
+	KAPI_STATE_TRANS_END
+
+	/* Locking information */
+	KAPI_LOCK(0, "mmap_lock", KAPI_LOCK_RWLOCK)
+		KAPI_LOCK_DESC("Process memory map write lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects VMA modifications during lock operation")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "lru_lock", KAPI_LOCK_SPINLOCK)
+		KAPI_LOCK_DESC("Per-memcg LRU list lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Taken when moving pages to unevictable list when locking pages")
+	KAPI_LOCK_END
+
+	KAPI_ERROR_COUNT(5)
+	KAPI_PARAM_COUNT(3)
+	KAPI_SINCE_VERSION("4.4")
+	KAPI_SIGNAL_COUNT(2)
+	KAPI_SIDE_EFFECT_COUNT(5)
+	KAPI_STATE_TRANS_COUNT(5)
+	KAPI_LOCK_COUNT(2)
+
+	/* Capability specifications */
+	KAPI_CAPABILITY(0, CAP_IPC_LOCK, "CAP_IPC_LOCK", KAPI_CAP_BYPASS_CHECK)
+		KAPI_CAP_ALLOWS("Lock unlimited amount of memory (no RLIMIT_MEMLOCK enforcement)")
+		KAPI_CAP_WITHOUT("Must respect RLIMIT_MEMLOCK resource limit")
+		KAPI_CAP_CONDITION("Checked when RLIMIT_MEMLOCK is 0 or locking would exceed limit")
+		KAPI_CAP_PRIORITY(0)
+	KAPI_CAPABILITY_END
+
+	KAPI_CAPABILITY_COUNT(1)
+
+	KAPI_EXAMPLES("mlock2(addr, len, 0);            // Same as mlock()\n"
+		      "mlock2(addr, len, MLOCK_ONFAULT); // Lock on fault")
+	KAPI_NOTES("MLOCK_ONFAULT flag defers actual page locking until pages are accessed. "
+		   "Memory locks do not stack. Locks are not inherited by child processes. "
+		   "Commonly used by real-time applications to prevent page faults. Also used "
+		   "for security to prevent sensitive data (e.g., cryptographic keys) from being "
+		   "written to swap. Note: locked pages may still be saved to swap during "
+		   "system suspend/hibernate.")
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 {
 	vm_flags_t vm_flags = VM_LOCKED;
-- 
2.39.5


