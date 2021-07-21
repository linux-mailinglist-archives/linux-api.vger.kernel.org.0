Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D993D1952
	for <lists+linux-api@lfdr.de>; Wed, 21 Jul 2021 23:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhGUVAT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 21 Jul 2021 17:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhGUVAS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 21 Jul 2021 17:00:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F58BC061575
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 14:40:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id y3so2152328plp.4
        for <linux-api@vger.kernel.org>; Wed, 21 Jul 2021 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEXADD/tGzUEc0+8M2o1tj24YNoqKRkImkzyq/62Yyo=;
        b=ALkBIWxv3Noo8dZYk/VOkEAwKWM3UfpZYZnmCAi/RR1MBIvlAAGbSX7JQwfJYdZBlC
         gPpGTGwRY6nIEdd1+8wP40n0ZlZbD+8dLjg/PNf/LWlPov9QthQSERLteFZex4c3yRMJ
         0dQDuu4VDS3zA/0Vlxb2s1wAVULC0OmsYMvnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vEXADD/tGzUEc0+8M2o1tj24YNoqKRkImkzyq/62Yyo=;
        b=UqxPlKaxS2KoVoD74U7sssTwmr/fZ7W6KHHYXV/Xe2EMvC7jNE3aFuke5DuSKjIJqk
         yf3gZjWHoA76zizmJgwiwLHShHzyhNF9+F4lMzDd+rnSGm54Dvr+OElNw3T/IdNp2jXZ
         b197dkQdeFKeW48S5dqvgXzI5Qu9PX+YE7rnnDJBkrTseUEoNDxdenP0HFnLFoZ37kuS
         XSciSIR5gU1sjJIg7dq5vLC8Ypw0t6/l7LW2Lr3OL4oslzuhcSpLeiVXmEayCP/gDVfb
         9Wt9Q9MXoD2UTaFz3FKiE3GOnGXTHTYBqgl+tQYKU51P7pCQTrq+iuKD58aRO22e6Ed9
         EBFw==
X-Gm-Message-State: AOAM532Jar+pbq4HI6yFk14s93EXySCMfvaXXaiR7shL9cywb896YZ5H
        ApUdqTnx9nsqZqeCMmIHzov0/g==
X-Google-Smtp-Source: ABdhPJzV7V30j6/gnbfF/vS88cIdAE59iTHu3DlnFAc4Hnj59p7aXxt+iId45PbClk2sm6u6qQQqLw==
X-Received: by 2002:a17:90a:ce04:: with SMTP id f4mr37397906pju.1.1626903653607;
        Wed, 21 Jul 2021 14:40:53 -0700 (PDT)
Received: from evgreen-glaptop.lan ([2601:646:c780:5ba8:8d9e:c2fc:c9ad:9c22])
        by smtp.gmail.com with ESMTPSA id o184sm31435306pga.18.2021.07.21.14.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 14:40:53 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        Evan Green <evgreen@chromium.org>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v3] mm: Enable suspend-only swap spaces
Date:   Wed, 21 Jul 2021 14:40:28 -0700
Message-Id: <20210721143946.v3.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Currently it's not possible to enable hibernation without also enabling
generic swap for a given swap area. These two use cases are not the
same. For example there may be users who want to enable hibernation,
but whose drives don't have the write endurance for generic swap
activities. Swap and hibernate also have different security/integrity
requirements, prompting folks to possibly set up something like block-level
integrity for swap and image-level integrity for hibernate. Keeping swap
and hibernate separate in these cases becomes not just a matter of
preference, but correctness.

Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
generic swapping to it. This region can still be wired up for use in
suspend-to-disk activities, but will never have regular pages swapped to
it. This flag will be passed in by utilities like swapon(8), usage would
probably look something like: swapon -o noswap /dev/sda2.

Swap regions with SWAP_FLAG_NOSWAP set will not appear in /proc/meminfo
under SwapTotal and SwapFree, since they are not usable as general swap.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v3:
 - Updated commit message with additional explanation [Andrew]

Changes in v2:
 - NOSWAP regions should not contribute to Swap stats in /proc/meminfo.
   [David]
 - Adjusted comment of SWAP_FLAG_NOSWAP [Pavel]
 - Note: Opted not to take Pavel's tag since enough has changed in this
   revision to warrant another look.
 - Call swap_entry_free() in swap_free to avoid NOSWAP leaks back into
   the general pool via swap_slots_cache [me].

 include/linux/swap.h |  4 +++-
 mm/swapfile.c        | 52 +++++++++++++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index cdf0957a88a49a..5e1d80be84bb02 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -28,10 +28,11 @@ struct pagevec;
 #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */
 #define SWAP_FLAG_DISCARD_ONCE	0x20000 /* discard swap area at swapon-time */
 #define SWAP_FLAG_DISCARD_PAGES 0x40000 /* discard page-clusters after use */
+#define SWAP_FLAG_NOSWAP	0x80000 /* use only for hibernate, not swap */
 
 #define SWAP_FLAGS_VALID	(SWAP_FLAG_PRIO_MASK | SWAP_FLAG_PREFER | \
 				 SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | \
-				 SWAP_FLAG_DISCARD_PAGES)
+				 SWAP_FLAG_DISCARD_PAGES | SWAP_FLAG_NOSWAP)
 #define SWAP_BATCH 64
 
 static inline int current_is_kswapd(void)
@@ -182,6 +183,7 @@ enum {
 	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
 	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
+	SWP_NOSWAP	= (1 << 13),	/* use only for suspend, not swap */
 					/* add others here before... */
 	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
 };
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3dcaeecc50f54..ca0e5e5d1f3074 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -697,7 +697,8 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 	if (si->inuse_pages == si->pages) {
 		si->lowest_bit = si->max;
 		si->highest_bit = 0;
-		del_from_avail_list(si);
+		if (!(si->flags & SWP_NOSWAP))
+			del_from_avail_list(si);
 	}
 }
 
@@ -726,10 +727,12 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		bool was_full = !si->highest_bit;
 
 		WRITE_ONCE(si->highest_bit, end);
-		if (was_full && (si->flags & SWP_WRITEOK))
+		if (was_full &&
+		    ((si->flags & (SWP_WRITEOK | SWP_NOSWAP)) == SWP_WRITEOK))
 			add_to_avail_list(si);
 	}
-	atomic_long_add(nr_entries, &nr_swap_pages);
+	if (!(si->flags & SWP_NOSWAP))
+		atomic_long_add(nr_entries, &nr_swap_pages);
 	si->inuse_pages -= nr_entries;
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1078,6 +1081,9 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			WARN(!(si->flags & SWP_WRITEOK),
 			     "swap_info %d in list but !SWP_WRITEOK\n",
 			     si->type);
+			WARN((si->flags & SWP_NOSWAP),
+			     "swap_info %d in list but SWP_NOSWAP\n",
+			     si->type);
 			__del_from_avail_list(si);
 			spin_unlock(&si->lock);
 			goto nextsi;
@@ -1338,8 +1344,12 @@ void swap_free(swp_entry_t entry)
 	struct swap_info_struct *p;
 
 	p = _swap_info_get(entry);
-	if (p)
-		__swap_entry_free(p, entry);
+	if (p) {
+		if (p->flags & SWP_NOSWAP)
+			swap_entry_free(p, entry);
+		else
+			__swap_entry_free(p, entry);
+	}
 }
 
 /*
@@ -1783,8 +1793,10 @@ swp_entry_t get_swap_page_of_type(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	spin_lock(&si->lock);
-	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
-		atomic_long_dec(&nr_swap_pages);
+	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry)) {
+		if (!(si->flags & SWP_NOSWAP))
+			atomic_long_dec(&nr_swap_pages);
+	}
 	spin_unlock(&si->lock);
 fail:
 	return entry;
@@ -2454,8 +2466,6 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
 static void _enable_swap_info(struct swap_info_struct *p)
 {
 	p->flags |= SWP_WRITEOK;
-	atomic_long_add(p->pages, &nr_swap_pages);
-	total_swap_pages += p->pages;
 
 	assert_spin_locked(&swap_lock);
 	/*
@@ -2469,7 +2479,11 @@ static void _enable_swap_info(struct swap_info_struct *p)
 	 * swap_info_struct.
 	 */
 	plist_add(&p->list, &swap_active_head);
-	add_to_avail_list(p);
+	if (!(p->flags & SWP_NOSWAP)) {
+		atomic_long_add(p->pages, &nr_swap_pages);
+		total_swap_pages += p->pages;
+		add_to_avail_list(p);
+	}
 }
 
 static void enable_swap_info(struct swap_info_struct *p, int prio,
@@ -2564,7 +2578,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
-	del_from_avail_list(p);
+	if (!(p->flags & SWP_NOSWAP))
+		del_from_avail_list(p);
+
 	spin_lock(&p->lock);
 	if (p->prio < 0) {
 		struct swap_info_struct *si = p;
@@ -2581,8 +2597,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		least_priority++;
 	}
 	plist_del(&p->list, &swap_active_head);
-	atomic_long_sub(p->pages, &nr_swap_pages);
-	total_swap_pages -= p->pages;
+	if (!(p->flags & SWP_NOSWAP)) {
+		atomic_long_sub(p->pages, &nr_swap_pages);
+		total_swap_pages -= p->pages;
+	}
 	p->flags &= ~SWP_WRITEOK;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
@@ -3335,16 +3353,20 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio =
 		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
+
+	if (swap_flags & SWAP_FLAG_NOSWAP)
+		p->flags |= SWP_NOSWAP;
 	enable_swap_info(p, prio, swap_map, cluster_info, frontswap_map);
 
-	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s\n",
+	pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%lluk %s%s%s%s%s%s\n",
 		p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
 		nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
 		(p->flags & SWP_SOLIDSTATE) ? "SS" : "",
 		(p->flags & SWP_DISCARDABLE) ? "D" : "",
 		(p->flags & SWP_AREA_DISCARD) ? "s" : "",
 		(p->flags & SWP_PAGE_DISCARD) ? "c" : "",
-		(frontswap_map) ? "FS" : "");
+		(frontswap_map) ? "FS" : "",
+		(p->flags & SWP_NOSWAP) ? "N" : "");
 
 	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
-- 
2.31.0

