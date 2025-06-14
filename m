Return-Path: <linux-api+bounces-3915-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4516AD9D1C
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150513B80B9
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ACE2E7636;
	Sat, 14 Jun 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BX5Fmk0q"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877162E7627;
	Sat, 14 Jun 2025 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908950; cv=none; b=Ox56176m/eK3nb4IUwJnL6ktrwfrM9GM2gf1ysXX6naUWc1q2nWMlfvMJfA7yihvWGke9/BlyvbIIe9kaBsZJce9o7fAC4u0psZAMVyEKq5T9p60b+zYL7psdsj4oQ7R7p6ZhyuwjDBL/cDlAnOQHhuiOQjiKrPD2IAKd5hNrsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908950; c=relaxed/simple;
	bh=IX6FdEJxog+IYJ7fUmLO8O0E0nHfZo6I9ZqvL4mp2Ps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EU6Al7Eq9VwsZmecEXf0q3yj190D+vUP7slJZZzb/z8K2sjIf/Q00h1wLZn7Lg8Wjr/QlHsjmltMK1EFyDoc4fm9wBR9DzmQqnwcHKknnEZqpqTHHJjLEgQp7TYIItfJKde51yEjw7t7NjHyEoET+LMz2eIbejirNS1oYClHonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BX5Fmk0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 912E9C4CEEB;
	Sat, 14 Jun 2025 13:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908950;
	bh=IX6FdEJxog+IYJ7fUmLO8O0E0nHfZo6I9ZqvL4mp2Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX5Fmk0qQ4LF++jbcrWQctzE3oCtNiAB4xol8dHhRUVO4BZtsaXsFVMBt54dy0H6g
	 16oQjJ/+uaacYKNNz8AoyZK5XWfwgGB0Y4advlCh5bYBEP1oU6O8tofNtojP2tP4kL
	 f5Qaa3Je1GIt5XonmsuwIshmZX+s0IJoL8LdLBBUzdYp6EEq6I4Opv7h1fGe9h1b+G
	 diCcQRNhenagkgfl7iCp+2o2CAHrbdBivq/3iOuoOXyMbgW23arHg8jATgbW8mlB6s
	 rwS1cNbKFTTHd6joUddfoq+oecyuz8QxfoKgIL976a7HI05/7LuftVi05fxCcpCxDD
	 DO92pPrktXfMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 10/19] mm/mlock: add API specification for mlock
Date: Sat, 14 Jun 2025 09:48:49 -0400
Message-Id: <20250614134858.790460-11-sashal@kernel.org>
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

Add kernel API specification for the mlock() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 3cb72b579ffd3..a37102df54b01 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/syscall_api_spec.h>
 
 #include "internal.h"
 
@@ -658,6 +659,110 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
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
+		.type = KAPI_TYPE_UINT,
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.constraint_type = KAPI_CONSTRAINT_NONE,
+		.constraints = "Rounded down to page boundary",
+	KAPI_PARAM_END
+	KAPI_PARAM(1, "len", "size_t", "Length of memory range to lock in bytes")
+		.type = KAPI_TYPE_UINT,
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		.constraint_type = KAPI_CONSTRAINT_RANGE,
+		KAPI_PARAM_RANGE(0, LONG_MAX)
+		.constraints = "Rounded up to page boundary",
+	KAPI_PARAM_END
+
+	.return_spec = {
+		.type_name = "long",
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.success_value = 0,
+		.description = "0 on success, negative error code on failure",
+	},
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
+	.error_count = 5,
+	.param_count = 2,
+	.since_version = "2.0",
+
+	.locks[0] = {
+		.lock_name = "mmap_lock",
+		.lock_type = KAPI_LOCK_RWLOCK,
+		.acquired = true,
+		.released = true,
+		.description = "Process memory map write lock",
+	},
+	.lock_count = 1,
+
+	/* Signal specifications */
+	.signal_count = 1,
+
+	/* Fatal signals can interrupt mmap_write_lock_killable */
+	KAPI_SIGNAL(0, 0, "FATAL", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
+		KAPI_SIGNAL_CONDITION("Fatal signal pending")
+		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, etc.) can interrupt the operation "
+				 "when acquiring mmap_write_lock_killable(), causing -EINTR return")
+	KAPI_SIGNAL_END
+
+	.examples = "mlock(addr, 4096);  // Lock one page\n"
+		    "mlock(addr, len);   // Lock range of pages",
+	.notes = "Memory locks do not stack - multiple calls on the same range can be "
+		 "undone by a single munlock. Locks are not inherited by child processes. "
+		 "Pages are locked on whole page boundaries.",
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
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE2(mlock, unsigned long, start, size_t, len)
 {
 	return do_mlock(start, len, VM_LOCKED);
-- 
2.39.5


