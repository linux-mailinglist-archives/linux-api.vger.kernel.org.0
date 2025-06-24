Return-Path: <linux-api+bounces-3975-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD13AE6E39
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D25A165D5C
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4E2ED84C;
	Tue, 24 Jun 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwa71qeH"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312532ED15B;
	Tue, 24 Jun 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788475; cv=none; b=Xj69jrm9teUG+Ygbg+i7kMovJrRLyP9+8z5umWUuG3eqsrs4IdOkq8ydG6A+KzHoXtwnrVeyqcojiGJyjSdIFJqQJKBz1+Gqxp5n26/uF9NVBZqygWyXSFzZ/MBWx6h1TjzSaO8I9RzsKo28T98ulj5slgnTW6i6DnSiXZvOieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788475; c=relaxed/simple;
	bh=xWQs53GMEwZHWoFSHG6xO1nMyP+NHdUWJ/L5T1gs5rI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mSWnazcBcLodqC+lvngD0Bb/tAPX26Xr1xWFkZs3nCC8KSQ9cyOEuoLrIWtddhh9gIh4y5e5Kv0kKneDJSSENNcCow9FH1cpTghl/9tfV31JxOtIeO1707MzWFaQPH3B2s02EwIcMuPu4GU0CWmnocePTEDKzo/Uvd3u34Z7L3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwa71qeH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7491AC4CEF3;
	Tue, 24 Jun 2025 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788473;
	bh=xWQs53GMEwZHWoFSHG6xO1nMyP+NHdUWJ/L5T1gs5rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwa71qeHSG3+g36Jce+SeAIse1Q6n4RzgBvsynbkEW4jKMMbi3svjyzgrwxvOj0hM
	 5CsMe2hUB+Cx/r6TNZFKlPWtEnQZh4xWMI9DSusW+5Z7WxqWu1DE3A28kxul0HURiL
	 LD5YuG+Fhd39k0PXc0igdmV7m9CWRlUobzAdITx49lxVDZ4dbCWgzlCYm2YOgPEHlQ
	 dwIdpBZsy4oSOtsXIKbqMKY848ZvnhtIPwnij/HY9+WKAz6tt5SXZ+hEFh0nZPd7BE
	 1PhjRMK5uphBieMj1AN5leNI/C2Z+OZG0aY0+t61CS7h2dxv0K28XDym/NM+gLpceG
	 wrpyO+w28Q93w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 12/22] mm/mlock: add API specification for mlockall
Date: Tue, 24 Jun 2025 14:07:32 -0400
Message-Id: <20250624180742.5795-13-sashal@kernel.org>
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

Add kernel API specification for the mlockall() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 186 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 186 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 869c6ba0a7ec8..8f24a31ac5934 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -1049,6 +1049,192 @@ static int apply_mlockall_flags(int flags)
 	return 0;
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_mlockall)
+	KAPI_DESCRIPTION("Lock all process pages in memory")
+	KAPI_LONG_DESC("Locks all pages mapped into the process address space. "
+		       "MCL_CURRENT locks current pages, MCL_FUTURE locks future mappings, "
+		       "MCL_ONFAULT defers locking until page fault.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "flags", "int", "Flags controlling which pages to lock")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_INT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_MASK)
+		.valid_mask = MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT,
+		KAPI_PARAM_CONSTRAINT("Must specify MCL_CURRENT and/or MCL_FUTURE; MCL_ONFAULT can be OR'd")
+	KAPI_PARAM_END
+
+	/* Return specification */
+	KAPI_RETURN("long", "0 on success, negative error code on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.success_value = 0,
+	KAPI_RETURN_END
+
+	/* Error codes */
+	KAPI_ERROR(0, -EINVAL, "EINVAL", "Invalid flags", "Invalid combination of flags specified, or no flags set, or only MCL_ONFAULT without MCL_CURRENT or MCL_FUTURE.")
+	KAPI_ERROR(1, -EPERM, "EPERM", "Insufficient privileges", "The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.")
+	KAPI_ERROR(2, -ENOMEM, "ENOMEM", "Insufficient resources", "MCL_CURRENT is set and total VM size exceeds RLIMIT_MEMLOCK and caller lacks CAP_IPC_LOCK.")
+	KAPI_ERROR(3, -EINTR, "EINTR", "Interrupted by signal", "The operation was interrupted by a signal before completion.")
+	KAPI_ERROR(4, -EAGAIN, "EAGAIN", "Some memory could not be locked", "Some pages could not be locked, possibly due to memory pressure.")
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
+		KAPI_SIGNAL_DESC("Can be generated later if accessing a locked page that cannot be brought into memory (e.g., truncated file mapping)")
+	KAPI_SIGNAL_END
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY,
+			 "all process memory",
+			 "Locks all current pages into physical memory, preventing swapping")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("MCL_CURRENT flag set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE,
+			 "mm->def_flags",
+			 "Sets VM_LOCKED in default flags for future mappings")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("MCL_FUTURE flag set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_MODIFY_STATE,
+			 "mm->locked_vm",
+			 "Increases process locked memory counter for entire address space")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("MCL_CURRENT flag set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_ALLOC_MEMORY,
+			 "page tables",
+			 "May allocate and populate page table entries for all mappings")
+		KAPI_EFFECT_CONDITION("MCL_CURRENT without MCL_ONFAULT")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_MODIFY_STATE,
+			 "VMA flags",
+			 "Sets VM_LOCKED on all existing VMAs")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("MCL_CURRENT flag set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(5, KAPI_EFFECT_SCHEDULE,
+			 "mm_populate",
+			 "Triggers population of entire address space")
+		KAPI_EFFECT_CONDITION("MCL_CURRENT without MCL_ONFAULT")
+	KAPI_SIDE_EFFECT_END
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "all memory pages",
+			 "swappable", "locked in RAM",
+			 "All pages in process become non-swappable")
+		KAPI_STATE_TRANS_COND("MCL_CURRENT flag set")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "future mappings",
+			 "normal", "auto-locked",
+			 "New mappings will be automatically locked")
+		KAPI_STATE_TRANS_COND("MCL_FUTURE flag set")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "VMA flags",
+			 "varied", "all VM_LOCKED",
+			 "All virtual memory areas marked as locked")
+		KAPI_STATE_TRANS_COND("MCL_CURRENT flag set")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "page fault behavior",
+			 "normal faulting", "lock on fault",
+			 "Pages locked when faulted in rather than immediately")
+		KAPI_STATE_TRANS_COND("MCL_ONFAULT flag set")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(4, "process statistics",
+			 "partial locked memory", "all memory locked",
+			 "Entire VM size counted against RLIMIT_MEMLOCK")
+		KAPI_STATE_TRANS_COND("MCL_CURRENT flag set")
+	KAPI_STATE_TRANS_END
+
+	/* Locking information */
+	KAPI_LOCK(0, "mmap_lock", KAPI_LOCK_RWLOCK)
+		KAPI_LOCK_DESC("Process memory map write lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects VMA modifications during mlockall operation")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "lru_lock", KAPI_LOCK_SPINLOCK)
+		KAPI_LOCK_DESC("Per-memcg LRU list lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Taken when moving pages to unevictable list for all locked pages")
+	KAPI_LOCK_END
+
+	KAPI_ERROR_COUNT(5)
+	KAPI_PARAM_COUNT(1)
+	KAPI_SINCE_VERSION("2.0")
+	KAPI_SIGNAL_COUNT(2)
+	KAPI_SIDE_EFFECT_COUNT(6)
+	KAPI_STATE_TRANS_COUNT(5)
+	KAPI_LOCK_COUNT(2)
+
+	/* Capability specifications */
+	KAPI_CAPABILITY(0, CAP_IPC_LOCK, "CAP_IPC_LOCK", KAPI_CAP_BYPASS_CHECK)
+		KAPI_CAP_ALLOWS("Lock entire process memory exceeding RLIMIT_MEMLOCK")
+		KAPI_CAP_WITHOUT("Total VM size must not exceed RLIMIT_MEMLOCK when MCL_CURRENT is set")
+		KAPI_CAP_CONDITION("Checked when MCL_CURRENT is set and total VM size exceeds RLIMIT_MEMLOCK")
+		KAPI_CAP_PRIORITY(0)
+	KAPI_CAPABILITY_END
+
+	KAPI_CAPABILITY_COUNT(1)
+
+	KAPI_EXAMPLES("mlockall(MCL_CURRENT);                    // Lock current mappings\n"
+		      "mlockall(MCL_CURRENT | MCL_FUTURE);       // Lock current and future\n"
+		      "mlockall(MCL_CURRENT | MCL_ONFAULT);      // Lock current on fault")
+	KAPI_NOTES("Affects all current VMAs and optionally future mappings via mm->def_flags. "
+		   "Memory locks are not inherited by child processes after fork(). Commonly used "
+		   "by real-time applications to prevent page faults. Also used for security to "
+		   "prevent sensitive data (e.g., cryptographic keys) from being written to swap. "
+		   "Note: locked pages may still be saved to swap during system suspend/hibernate.")
+
+	/* Additional constraints */
+	KAPI_CONSTRAINT(0, "MCL_FUTURE Persistence",
+			"The MCL_FUTURE flag persists across execve() calls by setting "
+			"mm->def_flags. This means all future memory mappings in the new "
+			"program will be locked. Care must be taken as this can cause "
+			"unexpected memory exhaustion in executed programs.")
+		KAPI_CONSTRAINT_EXPR("MCL_FUTURE => mm->def_flags |= VM_LOCKED")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(1, "Total VM Size Limit",
+			"When MCL_CURRENT is set, the total virtual memory size of the "
+			"process is checked against RLIMIT_MEMLOCK. This differs from "
+			"mlock() which only counts actually locked pages. CAP_IPC_LOCK "
+			"bypasses this check entirely.")
+		KAPI_CONSTRAINT_EXPR("(flags & MCL_CURRENT) => total_vm <= RLIMIT_MEMLOCK || CAP_IPC_LOCK")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(2, "Memory Accounting",
+			"mlockall() with MCL_CURRENT can lock significantly more memory "
+			"than expected, including all shared libraries, heap, stack, and "
+			"mapped files. This can easily exhaust memory limits or cause "
+			"system-wide memory pressure.")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT_COUNT(3)
+
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE1(mlockall, int, flags)
 {
 	unsigned long lock_limit;
-- 
2.39.5


