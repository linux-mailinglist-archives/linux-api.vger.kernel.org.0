Return-Path: <linux-api+bounces-3974-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F7FAE6E36
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 20:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FA11888FD9
	for <lists+linux-api@lfdr.de>; Tue, 24 Jun 2025 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286042ED163;
	Tue, 24 Jun 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp63og/U"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41282ED147;
	Tue, 24 Jun 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750788475; cv=none; b=nhOSDc9y5BbIjTHte0/JOT9uT0aZ6BjsTmMQ1KwvxOHfT2XZQpoZAVCZZkNiIW2O6BZqouMStqZ2Wx/4KJvRlhKpa+vvvBJ28wAbPwXkd/jhkDs/hYjTDTHNsJ+BGTsF25+4Y9QidbtmHel4BDX4swyZeJfAvc/s4V4haqH+DoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750788475; c=relaxed/simple;
	bh=DnAfvdXvvOEg7uDU4+AfB5r4JGJwdKeFkqm1mGmES5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dk03nKHAgGgqzE4w+NH0zQnNdQFm5pcsMLVUGnab2/UbTDjV6Z96Vid2J6fj9vweDGfJvQTr5YlHqhVB+bJBz2P3abdCtJNkWJ7JwSX5HBBDjNQuSTVsWLGb9oh9GMnXyI8snAJDQXg54ZAmag5hgm4o+VoVbfjCsCz62xQncPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp63og/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E800C4CEF2;
	Tue, 24 Jun 2025 18:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750788474;
	bh=DnAfvdXvvOEg7uDU4+AfB5r4JGJwdKeFkqm1mGmES5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hp63og/URlFQYL6hPNNkl4X/qAF4qJvLTV+6axEYiEHcmBtSToIoYYnrTny49sC5B
	 y06D/jIVElESZhCFv3yF3JjCm6GBhnhbHrnsgiAvmPLntARci2f3/pulbr8vVALRef
	 J4VJbQNdYVNugjFprho8Lma73zLHQdy2ufDEJheB9PTvdvMEJ2UjNpsgOhcyQCq4xy
	 cTBav1Fz8EY9Ro3qVFa8U57ICrm8Q7kE9QIip/56a1OdrH+otP/y2CxVhcIH9g2Nh0
	 nsIqwFWe3KTc/B+ihpcEfwYtKlByq/9ZsQBUVE5yEfTE0OFANeaXT4INNpgoh7Qmvm
	 /WcicGwy4GrwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC v2 14/22] mm/mlock: add API specification for munlockall
Date: Tue, 24 Jun 2025 14:07:34 -0400
Message-Id: <20250624180742.5795-15-sashal@kernel.org>
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

Add kernel API specification for the munlockall() system call.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mlock.c | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/mm/mlock.c b/mm/mlock.c
index 1c9328ec8485c..cf537103ebbc6 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -719,6 +719,12 @@ DEFINE_KERNEL_API_SPEC(sys_mlock)
 		KAPI_SIGNAL_CONDITION("Fatal signal pending")
 		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, etc.) can interrupt the operation "
 				 "when acquiring mmap_write_lock_killable(), causing -EINTR return")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ENTRY)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING | KAPI_SIGNAL_STATE_SLEEPING)
+		KAPI_SIGNAL_RESTARTABLE
 	KAPI_SIGNAL_END
 
 	KAPI_EXAMPLES("mlock(addr, 4096);  // Lock one page\n"
@@ -854,6 +860,11 @@ DEFINE_KERNEL_API_SPEC(sys_mlock2)
 	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
 		KAPI_SIGNAL_CONDITION("Fatal signal pending during mmap_write_lock_killable")
 		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, SIGTERM, etc.) can interrupt the operation when acquiring mmap_write_lock_killable(), causing -EINTR return")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ENTRY)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING | KAPI_SIGNAL_STATE_SLEEPING)
 		KAPI_SIGNAL_RESTARTABLE
 	KAPI_SIGNAL_END
 
@@ -861,6 +872,9 @@ DEFINE_KERNEL_API_SPEC(sys_mlock2)
 		KAPI_SIGNAL_TARGET("Current process")
 		KAPI_SIGNAL_CONDITION("Memory access to locked page fails")
 		KAPI_SIGNAL_DESC("Can be generated if accessing a locked page that cannot be brought into memory (e.g., truncated file mapping)")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_SA_FLAGS_REQ(SA_SIGINFO)
 	KAPI_SIGNAL_END
 
 	/* Side effects */
@@ -1020,6 +1034,11 @@ DEFINE_KERNEL_API_SPEC(sys_munlock)
 	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
 		KAPI_SIGNAL_CONDITION("Fatal signal pending during mmap_write_lock_killable")
 		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, SIGTERM, etc.) can interrupt the operation when acquiring mmap_write_lock_killable(), causing -EINTR return")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ENTRY)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING | KAPI_SIGNAL_STATE_SLEEPING)
 		KAPI_SIGNAL_RESTARTABLE
 	KAPI_SIGNAL_END
 
@@ -1214,6 +1233,11 @@ DEFINE_KERNEL_API_SPEC(sys_mlockall)
 	KAPI_SIGNAL(0, 0, "FATAL_SIGNALS", KAPI_SIGNAL_RECEIVE, KAPI_SIGNAL_ACTION_RETURN)
 		KAPI_SIGNAL_CONDITION("Fatal signal pending during mmap_write_lock_killable")
 		KAPI_SIGNAL_DESC("Fatal signals (SIGKILL, SIGTERM, etc.) can interrupt the operation when acquiring mmap_write_lock_killable(), causing -EINTR return")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ENTRY)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING | KAPI_SIGNAL_STATE_SLEEPING)
 		KAPI_SIGNAL_RESTARTABLE
 	KAPI_SIGNAL_END
 
@@ -1221,6 +1245,9 @@ DEFINE_KERNEL_API_SPEC(sys_mlockall)
 		KAPI_SIGNAL_TARGET("Current process")
 		KAPI_SIGNAL_CONDITION("Memory access to locked page fails")
 		KAPI_SIGNAL_DESC("Can be generated later if accessing a locked page that cannot be brought into memory (e.g., truncated file mapping)")
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ANYTIME)
+		KAPI_SIGNAL_PRIORITY(1)
+		KAPI_SIGNAL_SA_FLAGS_REQ(SA_SIGINFO)
 	KAPI_SIGNAL_END
 
 	/* Side effects */
@@ -1394,6 +1421,132 @@ SYSCALL_DEFINE1(mlockall, int, flags)
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
+		KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_ENTRY)
+		KAPI_SIGNAL_PRIORITY(0)
+		KAPI_SIGNAL_INTERRUPTIBLE
+		KAPI_SIGNAL_ERROR(-EINTR)
+		KAPI_SIGNAL_STATE_REQ(KAPI_SIGNAL_STATE_RUNNING | KAPI_SIGNAL_STATE_SLEEPING)
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
+	KAPI_ERROR_COUNT(2)
+	KAPI_SINCE_VERSION("2.0")
+	KAPI_SIGNAL_COUNT(1)
+	KAPI_SIDE_EFFECT_COUNT(6)
+	KAPI_STATE_TRANS_COUNT(5)
+	KAPI_LOCK_COUNT(2)
+	KAPI_EXAMPLES("munlockall();  // Unlock all pages")
+	KAPI_NOTES("Clears VM_LOCKED and VM_LOCKONFAULT from all VMAs and mm->def_flags. "
+		   "A single munlockall() can undo multiple mlockall() calls since locks don't stack.")
+KAPI_END_SPEC;
+
 SYSCALL_DEFINE0(munlockall)
 {
 	int ret;
-- 
2.39.5


