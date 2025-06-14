Return-Path: <linux-api+bounces-3919-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F5FAD9D26
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 15:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FA67A42AF
	for <lists+linux-api@lfdr.de>; Sat, 14 Jun 2025 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B992E92A9;
	Sat, 14 Jun 2025 13:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZdXN6dy"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817E2E88BD;
	Sat, 14 Jun 2025 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749908954; cv=none; b=Xw2oMvAk9CjXcec8S/MI2sN4Scuaz8VN+4ojJqqa5RpqQ4cgljed1Xqh/4KxAn6NnVCOA7AjK3o1601z+7lgRPOCtttZ723ZhW1O+IIOGrHtRP/yB8iYN/juFgvwHYpOckDAQyBlzbgx2aka9rR6VCuIkuGBLl+WvtbntpjCm1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749908954; c=relaxed/simple;
	bh=X6Vv2g/1CFZ/HVdEzZ2DI37QD2R1mWa+3vYCt/c6zM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ldfCRDPQEkvZqr3tNojMp4NkrF1UBw5TEyvlwub+8e+uH8qKHBoZ55IQctnYdgH6o5tF+rQ8clFJYPmAVm7EGq9fET0EbjxKjsyUPS0tzD2rPd/7X8/qWRAju4rIWDrtI3UAHsg7bauY8Tf7Vo9Zu2VAy8qlL4POE+h9VSa7DT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZdXN6dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37024C4CEF0;
	Sat, 14 Jun 2025 13:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749908953;
	bh=X6Vv2g/1CFZ/HVdEzZ2DI37QD2R1mWa+3vYCt/c6zM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZdXN6dyBaCOC/zOYipLnpKw1Y2J0Iz4hFXODov+4FN9AM+s19eF6kZVRCFMuRcls
	 ZWMfV/xT9yGg11g9GxH2Ba4qjZJ2U7PsxttaFq5AOB6mwZNuulYxtlpEPH8OyS16uf
	 SnY0SlbvZoZvqJyBK+Wc403Xt3Tb5J+oHtvhuIupt2803WMvlZksw3qgfhkzoZ/vc4
	 Fa6aLYyWQ6ptyentM0hn/RCtY+7VX2tv9Tdds6T8Uv/FSERkfc+nuNAxGdxrNzdLh6
	 fxMT/kPNC03m6W0Pr1bLFugiG9+r3WVKj+dib2jmH4qXZtdvwQTRIx4kFTHMNO84a9
	 T+51Tt2i8AxYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC 14/19] mm/mlock: add API specification for munlockall
Date: Sat, 14 Jun 2025 09:48:53 -0400
Message-Id: <20250614134858.790460-15-sashal@kernel.org>
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

Add kernel API specification for the munlockall() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index ef691adc78ad7..80f51e932aa95 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -1299,6 +1299,126 @@ SYSCALL_DEFINE1(mlockall, int, flags)
 	return ret;
 }
 
+
+DEFINE_KERNEL_API_SPEC(sys_munlockall)
+	KAPI_DESCRIPTION("Unlock all process pages")
+	KAPI_LONG_DESC("Unlocks all pages mapped into the process address space and "
+		       "clears the MCL_FUTURE flag if set.")
+	KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
+
+	/* No parameters - this is a SYSCALL_DEFINE0 */
+	.param_count = 0,
+
+	/* Return specification */
+	KAPI_RETURN("long", "0 on success, negative error code on failure")
+		.type = KAPI_TYPE_INT,
+		.check_type = KAPI_RETURN_ERROR_CHECK,
+		.success_value = 0,
+	KAPI_RETURN_END
+
+	/* Error codes */
+	KAPI_ERROR(0, -EINTR, "EINTR", "Interrupted by signal", "The operation was interrupted by a signal before completion.")
+	KAPI_ERROR(1, -ENOMEM, "ENOMEM", "Memory operation failed", "Failed to modify memory mappings (should not normally occur).")
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
+			 "all process memory",
+			 "Unlocks all pages, making entire address space swappable")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("Process had locked pages")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(1, KAPI_EFFECT_MODIFY_STATE,
+			 "mm->def_flags",
+			 "Clears VM_LOCKED from default flags for future mappings")
+		KAPI_EFFECT_REVERSIBLE
+		KAPI_EFFECT_CONDITION("MCL_FUTURE was previously set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(2, KAPI_EFFECT_MODIFY_STATE,
+			 "mm->locked_vm",
+			 "Resets process locked memory counter to zero")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(3, KAPI_EFFECT_MODIFY_STATE,
+			 "all VMA flags",
+			 "Clears VM_LOCKED and VM_LOCKONFAULT from all VMAs")
+		KAPI_EFFECT_REVERSIBLE
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(4, KAPI_EFFECT_MODIFY_STATE,
+			 "page flags",
+			 "Clears PG_mlocked flag from all locked pages")
+		KAPI_EFFECT_CONDITION("Pages had PG_mlocked set")
+	KAPI_SIDE_EFFECT_END
+
+	KAPI_SIDE_EFFECT(5, KAPI_EFFECT_MODIFY_STATE,
+			 "LRU lists",
+			 "Moves all pages from unevictable to normal LRU lists")
+		KAPI_EFFECT_CONDITION("Pages were on unevictable list")
+	KAPI_SIDE_EFFECT_END
+
+	/* State transitions */
+	KAPI_STATE_TRANS(0, "all memory pages",
+			 "locked in RAM", "swappable",
+			 "All pages in process become eligible for swap out")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(1, "future mappings",
+			 "auto-locked", "normal",
+			 "New mappings will no longer be automatically locked")
+		KAPI_STATE_TRANS_COND("MCL_FUTURE was set")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(2, "all VMA flags",
+			 "VM_LOCKED set", "VM_LOCKED cleared",
+			 "All virtual memory areas no longer marked as locked")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(3, "process statistics",
+			 "all memory locked", "no memory locked",
+			 "Entire locked memory accounting reset to zero")
+	KAPI_STATE_TRANS_END
+
+	KAPI_STATE_TRANS(4, "page LRU status",
+			 "unevictable list", "active/inactive list",
+			 "All pages moved to normal LRU lists for reclaim")
+		KAPI_STATE_TRANS_COND("Pages were mlocked")
+	KAPI_STATE_TRANS_END
+
+	/* Locking information */
+	KAPI_LOCK(0, "mmap_lock", KAPI_LOCK_RWLOCK)
+		KAPI_LOCK_DESC("Process memory map write lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Protects VMA modifications during munlockall operation")
+	KAPI_LOCK_END
+
+	KAPI_LOCK(1, "lru_lock", KAPI_LOCK_SPINLOCK)
+		KAPI_LOCK_DESC("Per-memcg LRU list lock")
+		KAPI_LOCK_ACQUIRED
+		KAPI_LOCK_RELEASED
+		KAPI_LOCK_DESC("Taken when moving all pages from unevictable to normal LRU lists")
+	KAPI_LOCK_END
+
+	.error_count = 2,
+	.since_version = "2.0",
+	.signal_count = 1,
+	.side_effect_count = 6,
+	.state_trans_count = 5,
+	.lock_count = 2,
+	.examples = "munlockall();  // Unlock all pages",
+	.notes = "Clears VM_LOCKED and VM_LOCKONFAULT from all VMAs and mm->def_flags",
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE0(munlockall)
 {
 	int ret;
-- 
2.39.5


