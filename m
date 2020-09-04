Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74F425D79F
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 13:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgIDLlc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 07:41:32 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49556 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729797AbgIDLlV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 07:41:21 -0400
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
        by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id 9B813307C934;
        Fri,  4 Sep 2020 14:31:07 +0300 (EEST)
Received: from localhost.localdomain (unknown [195.189.155.252])
        by smtp.bitdefender.com (Postfix) with ESMTPSA id D31BB3072785;
        Fri,  4 Sep 2020 14:31:06 +0300 (EEST)
From:   =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To:     linux-mm@kvack.org
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RESEND RFC PATCH 3/5] mm/mmu_notifier: remove lockdep map, allow mmu notifier to be used in nested scenarios
Date:   Fri,  4 Sep 2020 14:31:14 +0300
Message-Id: <20200904113116.20648-4-alazar@bitdefender.com>
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mircea Cirjaliu <mcirjaliu@bitdefender.com>

The combination of remote mapping + KVM causes nested range invalidations,
which reports lockdep warnings.

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 include/linux/mmu_notifier.h |  5 +----
 mm/mmu_notifier.c            | 19 -------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 736f6918335e..81ea457d41be 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -440,12 +440,10 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
 	might_sleep();
 
-	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	if (mm_has_notifiers(range->mm)) {
 		range->flags |= MMU_NOTIFIER_RANGE_BLOCKABLE;
 		__mmu_notifier_invalidate_range_start(range);
 	}
-	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
 static inline int
@@ -453,12 +451,11 @@ mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 {
 	int ret = 0;
 
-	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	if (mm_has_notifiers(range->mm)) {
 		range->flags &= ~MMU_NOTIFIER_RANGE_BLOCKABLE;
 		ret = __mmu_notifier_invalidate_range_start(range);
 	}
-	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
 	return ret;
 }
 
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 06852b896fa6..928751bd8630 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -22,12 +22,6 @@
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
-#ifdef CONFIG_LOCKDEP
-struct lockdep_map __mmu_notifier_invalidate_range_start_map = {
-	.name = "mmu_notifier_invalidate_range_start"
-};
-#endif
-
 /*
  * The mmu_notifier_subscriptions structure is allocated and installed in
  * mm->notifier_subscriptions inside the mm_take_all_locks() protected
@@ -242,8 +236,6 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
 	 * will always clear the below sleep in some reasonable time as
 	 * subscriptions->invalidate_seq is even in the idle state.
 	 */
-	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
-	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 	if (is_invalidating)
 		wait_event(subscriptions->wq,
 			   READ_ONCE(subscriptions->invalidate_seq) != seq);
@@ -572,13 +564,11 @@ void __mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range,
 	struct mmu_notifier_subscriptions *subscriptions =
 		range->mm->notifier_subscriptions;
 
-	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	if (subscriptions->has_itree)
 		mn_itree_inv_end(subscriptions);
 
 	if (!hlist_empty(&subscriptions->list))
 		mn_hlist_invalidate_end(subscriptions, range, only_end);
-	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 }
 
 void __mmu_notifier_invalidate_range(struct mm_struct *mm,
@@ -612,13 +602,6 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 	lockdep_assert_held_write(&mm->mmap_sem);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
-	if (IS_ENABLED(CONFIG_LOCKDEP)) {
-		fs_reclaim_acquire(GFP_KERNEL);
-		lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
-		lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-		fs_reclaim_release(GFP_KERNEL);
-	}
-
 	if (!mm->notifier_subscriptions) {
 		/*
 		 * kmalloc cannot be called under mm_take_all_locks(), but we
@@ -1062,8 +1045,6 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 	 * The possible sleep on progress in the invalidation requires the
 	 * caller not hold any locks held by invalidation callbacks.
 	 */
-	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
-	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 	if (seq)
 		wait_event(subscriptions->wq,
 			   READ_ONCE(subscriptions->invalidate_seq) != seq);
