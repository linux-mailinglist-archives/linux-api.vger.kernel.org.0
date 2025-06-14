Return-Path: <linux-api+bounces-3917-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9148EAD9D21
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29D43B80EA
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532102E7F23;
	Sat, 14 Jun 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k58zgvBL"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286332E7F1A;
	Sat, 14 Jun 2025 13:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908952; cv=none; b=ZCpjvbLvsJHlZblW7YI0g9hi5wDr6RB+wxTuZsIdsIlxD9WXJUvnau2ut125+ExLC9hPmmlOdO4Di2wE6OyUFhU9r0AyJVcTI5oPBGrxIHipQOTnB6gPK2FEphS1GwVErp7/CZbc2r/nrSlDYk096iy0x0o/3OvuWj/XXPyA0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908952; c=relaxed/simple;
	bh=zS8ZFG4HpWsJFM53jLyQzCNYlIU54deOx6WKkgpE/6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbE98vsPaSKzq4QagMECsaNzRapsiZ/V99Wno3LvCbbmmGgLWuLFLS8ptcMhhgJdj/GwogHJFo0iplaG4Dwx9EZdG4fTOk598jMxV+81AuQtDTTJsk9WnvrvIyt+KQlA0yaJKSOUdaQEql2vJ4HGi2UqxbmWlMuYRmruUC8PDeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k58zgvBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B13C4CEEE;
	Sat, 14 Jun 2025 13:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908952;
	bh=zS8ZFG4HpWsJFM53jLyQzCNYlIU54deOx6WKkgpE/6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k58zgvBLLy0GEluPrFS97RLZTXqYzyMII1P2FBtNLubbBpcLo6eDz037z66PqhQWq
	 c5WR6OMwXXrx21oJbG2Ygwf8wjTqheqhSt3uJ4MZIbYq9l/pUABWNUxWMyd6otiJt6
	 NfvW/8KdkxUyEw727dM9gz5VtQZ1czcJr4IDxEVgwbaGZW5hTAlf+yLa0EZh/7topF
	 QpdjGgn5gvq2lut7ivNMLaqZp5KTwrN9021R1lN/wKMsXeMHUtcBhilRTz85fTwwfD
	 aIBH8OC5ATf0f0iepRflqRNO+sVkG4U58QiuvRlUAGC61raQEvyAun/6/BBq8yUODQ
	 fCgcoHJXiIwhw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 12/19] mm/mlock: add API specification for mlockall
Date: Sat, 14 Jun 2025 09:48:51 -0400
Message-Id: <20250614134858.790460-13-sashal@kernel.org>
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

Add kernel API specification for the mlockall() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 144 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index af2ab78acc226..95ee707c5922f 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -997,6 +997,150 @@ static int apply_mlockall_flags(int flags)
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
+		.type = KAPI_TYPE_INT,
+		.constraint_type = KAPI_CONSTRAINT_MASK,
+		.valid_mask = MCL_CURRENT | MCL_FUTURE | MCL_ONFAULT,
+		.constraints = "Must specify MCL_CURRENT and/or MCL_FUTURE; MCL_ONFAULT can be OR'd",
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
+	.error_count = 5,
+	.param_count = 1,
+	.since_version = "2.0",
+	.signal_count = 2,
+	.side_effect_count = 6,
+	.state_trans_count = 5,
+	.lock_count = 2,
+	.examples = "mlockall(MCL_CURRENT);                    // Lock current mappings\n"
+		    "mlockall(MCL_CURRENT | MCL_FUTURE);       // Lock current and future\n"
+		    "mlockall(MCL_CURRENT | MCL_ONFAULT);      // Lock current on fault",
+	.notes = "Affects all current VMAs and optionally future mappings via mm->def_flags",
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE1(mlockall, int, flags)
 {
 	unsigned long lock_limit;
-- 
2.39.5


