Return-Path: <linux-api+bounces-3916-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3CAD9D20
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDE43B80E8
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F632E7F07;
	Sat, 14 Jun 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBRH/LRE"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44B2E7F00;
	Sat, 14 Jun 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908951; cv=none; b=KTMeDrVNo5Jti+Telzyi45RZZJ5f9rtnYWhcxMelP6Ts8OZ0c76Exmt8U0IBQFT7FAecC0u6Sj9gYlpoM4YQg5rwk32BxQeXme7FVokH/xTPw/jn6jequ2HF8il+nzhV83szyS3ND7KeHanCVSfs/9O2jxK2/rtTU4lkRX2KC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908951; c=relaxed/simple;
	bh=ibJSxGhn2sy6Pn+cpIBXMz0mb1TNNGHU2JUEIbkLD1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGa3rWwr2ngu9Ml3HGX/CKVzXjkMsQ7R/cqZN4WIKu61Mz63j+suo/1y0kqf82zNVTiutiOC+SusHL9w/bSxtwPTGmJMr1jIMzx6R6WwEWT+pcAd7Izhg/Tng8way31PfJ9lIgg54H/UFwgXRyTq8nMO9CIlWq0N4wLQXGysBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBRH/LRE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C966C4AF0D;
	Sat, 14 Jun 2025 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908951;
	bh=ibJSxGhn2sy6Pn+cpIBXMz0mb1TNNGHU2JUEIbkLD1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBRH/LREvhPgizuyQuBDGiMMBTIqbwq9Lhv2Rul0dlMPCKmj+aLlehwm35hroE+ws
	 Qgq9BZjAkIU95QmHziCfPFO2B0y9w0/KLJgzSizwHHzXFPRjK6cIA1/u+dsKg7/q2R
	 /xLCEuBtJr/sr+pWsYo2KiooY/kq3sJy3ot1uXhqrc8MN53MtWgCgQPFV0OPX971w9
	 BJvhhqekig9Nb7EZ/SzfOk9xktVpDzrCNXjD2n7fCSPQkbR9Kp5uVd6uj3i5dsA3LY
	 YNPevAmvOThRpejPizMm1bMrPE9bo6hfNFNie9LzQOXnjp69WG/KxsV9ZNn7XD0jqh
	 Xv+m9J//tom6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 11/19] mm/mlock: add API specification for mlock2
Date: Sat, 14 Jun 2025 09:48:50 -0400
Message-Id: <20250614134858.790460-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614134858.790460-1-sashal@kernel.org>
References: <20250614134858.790460-1-sashal@kernel.org>
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
 mm/mlock.c | 148 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index a37102df54b01..af2ab78acc226 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -768,6 +768,154 @@ SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
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
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "Rounded down to page boundary",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "len", "size_t", "Length of memory range to lock in bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		KAPI_PARAM_RANGE(0, LONG_MAX)
+		.constraints = "Rounded up to page boundary",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(2, "flags", "int", "Flags controlling lock behavior")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_INT,
+		.constraint_type = KAPI_CONSTRAINT_MASK,
+		.valid_mask = MLOCK_ONFAULT,
+		.constraints = "Only MLOCK_ONFAULT flag is currently supported",
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
+	.error_count = 5,
+	.param_count = 3,
+	.since_version = "4.4",
+	.signal_count = 2,
+	.side_effect_count = 5,
+	.state_trans_count = 5,
+	.lock_count = 2,
+	.examples = "mlock2(addr, len, 0);            // Same as mlock()\n"
+		    "mlock2(addr, len, MLOCK_ONFAULT); // Lock on fault",
+	.notes = "MLOCK_ONFAULT flag defers actual page locking until pages are accessed. "
+		 "Memory locks do not stack. Locks are not inherited by child processes.",
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 {
 	vm_flags_t vm_flags = VM_LOCKED;
-- 
2.39.5


