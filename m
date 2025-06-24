Return-Path: <linux-api+bounces-3970-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BEAE6E2D
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A5F164B4A
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543BD2EAD0A;
	Tue, 24 Jun 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Foxah1lp"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E042EACF2;
	Tue, 24 Jun 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788473; cv=none; b=KSHdmHHwptmmqPP0jA3MEge96SVPJM6ce7vaPZnuulrKVds3CyJYq0jb9x9j2x0VKW0gtQ2SYcnh2tU4uOuiiqNcNp4VtmFg5k59TR1Sytd6fqdaPZu+11jipvoZX81odPPbqLX/aOuChg9ivID/OzCJdD65Jvi47Fqnjs6rsok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788473; c=relaxed/simple;
	bh=FlpFm5Z8M83hYAPEckHasT1rA9RTyiHDYWVP3DBH6AM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utAps2LDlFpXfvtjksG1JeO526R2EAC6QeWMCOXHXhO7dmZEIRdeISYzddB7SWrehHMODlTMDbT4mW4Y66W/c74ouMdxEfAIoCsifRbnLjl4NXpigK4yQFBe+qhQUEYl/sqJCiL77XOq3167whCTe3/WdzKBJ+wKHor8uRhJNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Foxah1lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716B2C4CEF6;
	Tue, 24 Jun 2025 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788472;
	bh=FlpFm5Z8M83hYAPEckHasT1rA9RTyiHDYWVP3DBH6AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Foxah1lp6vvuKwzcoTDtiJr/RvTTBsYVJNuOYMeohiHT2UT2WhFgT/WuMu7NmT1yX
	 K9+2CL8rYcSY8YqQt4C6HlZouTCR4nqLoS3QJ6HukJgvTsN/RIHTTOHCHKn0xhM++K
	 /umUD6HopQ2iyR0kczBhpsHR0YO6E9SUX8pyPRP2HhvsobWGbSo6sd5a7A+bGn0KvG
	 Qax1XfTy5Gck0fChvb/S13bJArXpOizIzassUmL2wmOHk5K/OCp47qm1kxhycQCmEt
	 QuZeL1HfjETbl0/a0oUc58CZNjpTcOwr+EMg9gPlj/je0kUNeqqfBQDd11Ac5OSGzG
	 7ROEJ5PQC7/sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 10/22] mm/mlock: add API specification for mlock
Date: Tue, 24 Jun 2025 14:07:30 -0400
Message-Id: <20250624180742.5795-11-sashal@kernel.org>
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

Add kernel API specification for the mlock() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 3cb72b579ffd3..b97768b1cfa60 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/syscall_api_spec.h>
 
 #include "internal.h"
 
@@ -658,6 +659,147 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	return 0;
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_mlock)
+	KAPI_DESCRIPTION("Lock pages in memory")
+	KAPI_LONG_DESC("Locks pages in the specified address range into RAM, "
+		       "preventing them from being paged to swap. Requires "
+		       "CAP_IPC_LOCK capability or RLIMIT_MEMLOCK resource limit.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	KAPI_PARAM(0, "start", "unsigned long", "Starting address of memory range to lock")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Rounded down to page boundary")
+	KAPI_PARAM_END
+	KAPI_PARAM(1, "len", "size_t", "Length of memory range to lock in bytes")
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, LONG_MAX)
+		KAPI_PARAM_CONSTRAINT("Rounded up to page boundary")
+	KAPI_PARAM_END
+
+	KAPI_RETURN("long", "0 on success, negative error code on failure")
+		KAPI_RETURN_TYPE(KAPI_TYPE_INT)
+		KAPI_RETURN_CHECK_TYPE(KAPI_RETURN_ERROR_CHECK)
+		KAPI_RETURN_SUCCESS(0)
+	KAPI_RETURN_END
+
+	KAPI_ERROR(0, -ENOMEM, "ENOMEM", "Address range issue",
+		   "Some of the specified range is not mapped, has unmapped gaps, "
+		   "or the lock would cause the number of mapped regions to exceed the limit.")
+	KAPI_ERROR(1, -EPERM, "EPERM", "Insufficient privileges",
+		   "The caller is not privileged (no CAP_IPC_LOCK) and RLIMIT_MEMLOCK is 0.")
+	KAPI_ERROR(2, -EINVAL, "EINVAL", "Address overflow",
+		   "The result of the addition start+len was less than start (arithmetic overflow).")
+	KAPI_ERROR(3, -EAGAIN, "EAGAIN", "Some or all memory could not be locked",
+		   "Some or all of the specified address range could not be locked.")
+	KAPI_ERROR(4, -EINTR, "EINTR", "Interrupted by signal",
+		   "The operation was interrupted by a fatal signal before completion.")
+
+	KAPI_ERROR_COUNT(5)
+	KAPI_PARAM_COUNT(2)
+	KAPI_SINCE_VERSION("2.0")
+
+	KAPI_LOCK(0, "mmap_lock", KAPI_LOCK_RWLOCK)
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Process memory map write lock")
+	KAPI_LOCK_END
+
+	KAPI_LOCK_COUNT(1)
+
+	/* Signal specifications */
+	KAPI_SIGNAL_COUNT(1)
+
+	/* Fatal signals can interrupt mmap_write_lock_killable */
+	KAPI_SIGNAL(0, 0, "FATAL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Fatal signal pending")
+		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, etc.) can interrupt the operation "
+				 "when acquiring mmap_write_lock_killable(), causing -EINTR return")
+	KAPI_SIGNAL_END
+
+	KAPI_EXAMPLES("mlock(addr, 4096);  // Lock one page\n"
+		      "mlock(addr, len);   // Lock range of pages")
+	KAPI_NOTES("Memory locks do not stack - multiple calls on the same range can be "
+		   "undone by a single munlock. Locks are not inherited by child processes. "
+		   "Pages are locked on whole page boundaries. Commonly used by real-time "
+		   "applications to prevent page faults during time-critical operations. "
+		   "Also used for security to prevent sensitive data (e.g., cryptographic keys) "
+		   "from being written to swap. Note: locked pages may still be saved to "
+		   "swap during system suspend/hibernate.")
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE | KAPI_EFFECT_ALLOC_MEMORY,
+			 "process memory",
+			 "Locks pages into physical memory, preventing swapping")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE,
+			 "mm->locked_vm",
+			 "Increases process locked memory counter")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_ALLOC_MEMORY,
+			 "physical pages",
+			 "May allocate and populate page table entries")
+		KAPI_EFFECT_CONDITION("Pages not already present")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT_COUNT(3)
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "memory pages", "swappable", "locked in RAM",
+			 "Pages become non-swappable and pinned in physical memory")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "VMA flags", "unlocked", "VM_LOCKED set",
+			 "Virtual memory area marked as locked")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS_COUNT(2)
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
+	/* Additional constraints */
+	KAPI_CONSTRAINT(0, "RLIMIT_MEMLOCK Resource Limit",
+			"The RLIMIT_MEMLOCK soft resource limit specifies the maximum bytes "
+			"of memory that may be locked into RAM. Unprivileged processes are "
+			"restricted to this limit. CAP_IPC_LOCK capability allows bypassing "
+			"this limit entirely. The limit is enforced per-process, not per-user.")
+		KAPI_CONSTRAINT_EXPR("locked_memory + request_size <= RLIMIT_MEMLOCK || CAP_IPC_LOCK")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(1, "Memory Pressure and OOM",
+			"Locking large amounts of memory can cause system-wide memory pressure "
+			"and potentially trigger the OOM killer. The kernel does not prevent "
+			"locking memory that would destabilize the system.")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT(2, "Special Memory Areas",
+			"Some memory types cannot be locked or behave specially: "
+			"VM_IO/VM_PFNMAP areas fail with EINVAL; "
+			"Hugetlb pages are inherently pinned; "
+			"DAX mappings are always present in memory; "
+			"VM_LOCKED areas are already locked.")
+	KAPI_CONSTRAINT_END
+
+	KAPI_CONSTRAINT_COUNT(3)
+
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 {
 	return do_mlock(start, len, VM_LOCKED);
-- 
2.39.5


