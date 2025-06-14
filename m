Return-Path: <linux-api+bounces-3918-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5F1AD9D25
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8543A1893125
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386D42E888C;
	Sat, 14 Jun 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtjS/DWg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5212E8880;
	Sat, 14 Jun 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908953; cv=none; b=Bm6zeeD8GVFhOx0lNwZwsWG5VaTQczTU5Svw9XhxJGY9etjiQAmP1zPq4s+PAl7cEGhIluDs+CC+e8G4t5MgwPX/fpdYCdbPIf+vqq9aXE0gb2Wok0cfY3FRh6IvebHAFDVvvk7ZByi2fuPq0/1+8N577xd51KbcFv6njI736Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908953; c=relaxed/simple;
	bh=BBnacI0/ivtpQYx1QHbF8Tz/qIcLNSNB7FFd9e1Kogo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WuMZ1RC3xwns2izw6QPn4GFSvKSi1fXTTdy1Oy/oWn73umr9RWEH+88REOLwNBUN4QLZLZhJwVZDwnT2lCgCe2oEUHGmoKO5EXx20EPmgqPTPNNqnYlkdQFsP+9Mmz+Z9XnB0vAkfn9QJ6t8Bp2yoUWXvFZ2+Ckz239jPfqFcBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtjS/DWg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEA7C4CEF3;
	Sat, 14 Jun 2025 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908952;
	bh=BBnacI0/ivtpQYx1QHbF8Tz/qIcLNSNB7FFd9e1Kogo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XtjS/DWgFsmlX8+54GimlnqYnkKtkFWUgKzaVjsEBsnG8y1MR0tf4EHO8Fb/ork9v
	 N5lqjSV+RJAnxoLe1kG3WyqmtZN9HbWTbOfXuBB0Ww+Co1BWa+okFXxDjC25fX5q3R
	 uN3OsI1tpEH9S/nLpX1tJMmDgX3+D6oG1KbLhEVX+oGcmLfFhce+kVfL+Hnl51Q/M7
	 h5e/QJ5GIDbpQsiQZVE74CoEjxPmbMBnBtYfCB3KptVihKIypd7HNfHj64V/VzT6SG
	 mJ6vGgVrxtI31h8FEc+H8QnAlSQ06Xp8AM1QMUiXKK5r1O2U8NysHeLgVS8ObOnbNP
	 aHXUFRaUUnF2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 13/19] mm/mlock: add API specification for munlock
Date: Sat, 14 Jun 2025 09:48:52 -0400
Message-Id: <20250614134858.790460-14-sashal@kernel.org>
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

Add kernel API specification for the munlock() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 95ee707c5922f..ef691adc78ad7 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -929,6 +929,135 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
 	return do_mlock(start, len, vm_flags);
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_munlock)
+	KAPI_DESCRIPTION("Unlock pages in memory")
+	KAPI_LONG_DESC("Unlocks pages in the specified address range, allowing them "
+		       "to be paged out to swap if needed.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* Parameters */
+	KAPI_PARAM(0, "start", "unsigned long", "Starting address of memory range to unlock")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "Rounded down to page boundary",
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "len", "size_t", "Length of memory range to unlock in bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.type = KAPI_TYPE_UINT,
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		KAPI_PARAM_RANGE(0, LONG_MAX)
+		.constraints = "Rounded up to page boundary",
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
+	KAPI_ERROR(0, -ENOMEM, "ENOMEM", "Memory range not mapped", "(Linux 2.6.9 and later) Some of the specified address range does not correspond to mapped pages in the process address space.")
+	KAPI_ERROR(1, -EINTR, "EINTR", "Interrupted by signal", "The operation was interrupted by a signal before completion.")
+	KAPI_ERROR(2, -EINVAL, "EINVAL", "Address overflow", "The result of the addition start+len was less than start (arithmetic overflow).")
+
+	/* Signal specifications */
+	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Fatal signal pending during mmap_write_lock_killable")
+		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, SIGTERM, etc.) can interrupt the operation when acquiring mmap_write_lock_killable(), causing -EINTR return")
+		KAPI_SIGNAL_RESTARTABLE
+	KAPI_SIGNAL_END
+
+	/* Side effects */
+	KAPI_SIDE_EFFECT(0, KAPI_EFFECT_MODIFY_STATE,
+			 "process memory",
+			 "Unlocks pages, making them eligible for swapping")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("Pages were previously locked")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE,
+			 "mm->locked_vm",
+			 "Decreases process locked memory counter")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("Pages were counted in locked_vm")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_MODIFY_STATE,
+			 "VMA flags",
+			 "Clears VM_LOCKED and VM_LOCKONFAULT from affected VMAs")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_MODIFY_STATE,
+			 "page flags",
+			 "Clears PG_mlocked flag from unlocked pages")
+		KAPI_EFFECT_CONDITION("Pages had PG_mlocked set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_MODIFY_STATE,
+			 "LRU lists",
+			 "Moves pages from unevictable to appropriate LRU list")
+		KAPI_EFFECT_CONDITION("Pages were on unevictable list")
+	KAPI_SIDE_EFFECT_END
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "memory pages",
+			 "locked in RAM", "swappable",
+			 "Pages become eligible for swap out")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "VMA flags",
+			 "VM_LOCKED set", "VM_LOCKED cleared",
+			 "Virtual memory areas no longer marked as locked")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "page residency",
+			 "guaranteed resident", "may be swapped",
+			 "Pages can now be evicted under memory pressure")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "process statistics",
+			 "locked memory accounted", "normal memory accounting",
+			 "Memory no longer counted against RLIMIT_MEMLOCK")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(4, "page LRU status",
+			 "unevictable list", "active/inactive list",
+			 "Pages moved to normal LRU lists for reclaim")
+		KAPI_STATE_TRANS_COND("Pages were mlocked")
+	KAPI_STATE_TRANS_END
+
+	/* Locking information */
+	KAPI_LOCK(0, "mmap_lock", KAPI_LOCK_RWLOCK)
+		KAPI_LOCK_DESC("Process memory map write lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects VMA modifications during unlock operation")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "lru_lock", KAPI_LOCK_SPINLOCK)
+		KAPI_LOCK_DESC("Per-memcg LRU list lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Taken when moving pages from unevictable to normal LRU lists")
+	KAPI_LOCK_END
+
+	.error_count = 3,
+	.param_count = 2,
+	.since_version = "2.0",
+	.signal_count = 1,
+	.side_effect_count = 5,
+	.state_trans_count = 5,
+	.lock_count = 2,
+	.examples = "munlock(addr, 4096);  // Unlock one page\n"
+		    "munlock(addr, len);   // Unlock range of pages",
+	.notes = "No special permissions required to unlock memory",
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
-- 
2.39.5


