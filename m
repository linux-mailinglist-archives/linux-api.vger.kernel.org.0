Return-Path: <linux-api+bounces-3973-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004C0AE6E30
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAA35A58CE
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60B42ECE8F;
	Tue, 24 Jun 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRW5i5Vs"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B32ECD14;
	Tue, 24 Jun 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788474; cv=none; b=YjjtlMsoJL5XC16vrrMOvXWZ2Mlj5MCW+y1hM8qBK3fYywLkIBsfxxvr/DypL51ujkAPxTM+JS4usJOF/j4g+tt0m3AxGGyI6W6SG0MGp50BiU5gTquqW/o+nr7uYXS4O2w0uMpwXzRQLdIl2ocRofeLP18sFLHQUAccwpeoKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788474; c=relaxed/simple;
	bh=tb0t2RtQTvxQyrPmAgT/oVQQRDa/EkNuRubt5v5StfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQPu6ZIOmXjNzEJdWZH4uNLlFCSMf9S8bsKUf3/6v/28cZuDotDnPEfbFYfYp0KRwcCQ9FrS/8jMfCbwggOZ4aKKhB+8InJtWWeyAcKnrJNThgkurZpdte6qTuQ/OUF8XLR1jLJlcB19b8ftO4kkTvi87gK2wyoBB2qQtK1ogVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRW5i5Vs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0055DC4CEF0;
	Tue, 24 Jun 2025 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788474;
	bh=tb0t2RtQTvxQyrPmAgT/oVQQRDa/EkNuRubt5v5StfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QRW5i5Vsqd47U5nSO8K1l0Oya8252UaVxfmT7+EyWv5U7CcE5xfeLk9noi45RbM26
	 1iRNalHl0CLGra9HikdMxm/nOmVXicqFL155W7IM29gss7g7E3tX6GnX55YgwGwE0Q
	 0x6oSS1Egvx6NlLInuyD5FV7rBbzm9HoS52CqchHC31lyMxZDwRcgQ1swWm1+C14Iu
	 hv+HbbLmOrj57ny3oGAflUGd3Vg8VH1H9dLSsSzSjU5dsWoW1tIVYo/5+Uxp8qMT6H
	 /dkD1xmcF+J6LdV8Kx8n1vh8i/t2vYq5oMk9G2qHL6Iju7wxR0pqbZW8VKNIgXjqOG
	 pxAGhnyOEZ+zw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 13/22] mm/mlock: add API specification for munlock
Date: Tue, 24 Jun 2025 14:07:33 -0400
Message-Id: <20250624180742.5795-14-sashal@kernel.org>
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

Add kernel API specification for the munlock() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 8f24a31ac5934..1c9328ec8485c 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -981,6 +981,136 @@ SYSCALL_DEFINE3(mlock2, unsigned long, start, size_t, len, int, flags)
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
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_NONE)
+		KAPI_PARAM_CONSTRAINT("Rounded down to page boundary")
+	KAPI_PARAM_END
+
+	KAPI_PARAM(1, "len", "size_t", "Length of memory range to unlock in bytes")
+		KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
+		KAPI_PARAM_TYPE(KAPI_TYPE_UINT)
+		KAPI_PARAM_CONSTRAINT_TYPE(KAPI_CONSTRAINT_RANGE)
+		KAPI_PARAM_RANGE(0, LONG_MAX)
+		KAPI_PARAM_CONSTRAINT("Rounded up to page boundary")
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
+	KAPI_ERROR_COUNT(3)
+	KAPI_PARAM_COUNT(2)
+	KAPI_SINCE_VERSION("2.0")
+	KAPI_SIGNAL_COUNT(1)
+	KAPI_SIDE_EFFECT_COUNT(5)
+	KAPI_STATE_TRANS_COUNT(5)
+	KAPI_LOCK_COUNT(2)
+	KAPI_EXAMPLES("munlock(addr, 4096);  // Unlock one page\n"
+		      "munlock(addr, len);   // Unlock range of pages")
+	KAPI_NOTES("No special permissions required to unlock memory. A single munlock() "
+		   "can undo multiple mlock() calls on the same range since locks don't stack.")
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, len)
 {
 	int ret;
-- 
2.39.5


