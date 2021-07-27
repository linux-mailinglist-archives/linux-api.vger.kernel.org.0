Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 881283D6ACC
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 02:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhGZXcm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 19:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbhGZXcm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 19:32:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC3C061760
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 17:13:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c11so13636162plg.11
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 17:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fn5WmgFWIqAgCXgSVUjkUylrpQ1sjjoq4+n+Cyyonsw=;
        b=c2BA8cvoaiefHDm57uLGsx0fgT7tdjmEkGw1wCNEkrrRoo+qPRZjAesO8s51sFtWj0
         GjFtiJKn2G9RBIHMPryD/koEPFsTKTiqOdoJgSq8D8Fvk/NpUz8k1G+JbHQjrn4t31oU
         3kqU46k4yf1lxklMSIE81ogv7LG/+pF/WfoDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fn5WmgFWIqAgCXgSVUjkUylrpQ1sjjoq4+n+Cyyonsw=;
        b=HJJBOxCyj0/i/fQEihS3/Ux3wQ8sMJfYTqcqNRBliSz1NYItTH61YCkb/0JFe7x/4L
         WL8LBBHZWV1HfXBCHdcvPVutsoBwhZ9YUayNZzU4N2k+BY1yfmlTx9zPX87rLzhDpXuv
         Xz6BAaDua3IuQxYTiALlrSQhsIHUvglhqROpOkVoj4Yfue68vHhRkecvVN6IGFwmKXml
         jpwCz4AnNc8jqp81Z92kYHUjxONfdwi6goGoCUfW8F6abq+o3KX/OXsQ4YE/3BYBvybh
         qSkTFGNgU4RUHC+Vx6QW23DlL+Wxc5rrLw48jfboX+TQiskfiS9OxL0WgvRp0NxgOcSa
         5IgQ==
X-Gm-Message-State: AOAM530B44oS1U1uh6zXt8PnjNmhiomu7GX9fSFmpbmv+V012atx7+3u
        J4dDmrBOyiJgJnziixE/gB8GCg==
X-Google-Smtp-Source: ABdhPJwjfhDK86YwlPvW4G9tFeQNDFiXMofUrN+41LYmS6iDeAaoIo5B22jX28w3iA6AIKh2VuOqDA==
X-Received: by 2002:a17:902:fe87:b029:12a:ef40:57a2 with SMTP id x7-20020a170902fe87b029012aef4057a2mr16461751plm.81.1627344788313;
        Mon, 26 Jul 2021 17:13:08 -0700 (PDT)
Received: from evgreen-glaptop.lan ([2601:646:c780:5ba8:3dc2:47c5:3edb:2f95])
        by smtp.gmail.com with ESMTPSA id i1sm1208764pfo.37.2021.07.26.17.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 17:13:07 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
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
Subject: [PATCH v4] mm: Enable suspend-only swap spaces
Date:   Mon, 26 Jul 2021 17:12:46 -0700
Message-Id: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a new SWAP_FLAG_HIBERNATE_ONLY that adds a swap region but refuses
to allow generic swapping to it. This region can still be wired up for
use in suspend-to-disk activities, but will never have regular pages
swapped to it. This flag will be passed in by utilities like swapon(8),
usage would probably look something like: swapon -o hibernate /dev/sda2.

Currently it's not possible to enable hibernation without also enabling
generic swap for a given area. One semi-workaround for this is to delay
the call to swapon() until just before attempting to hibernate, and then
call swapoff() just after hibernate completes. This is somewhat kludgy,
and also doesn't really work to keep swap out of the hibernate region.
When hibernate begins, it starts by allocating a large chunk of memory
for itself. This often ends up forcing a lot of data out into swap. By
this time the hibernate region is eligible for generic swap, so swap
ends up leaking into the hibernate region even with the workaround.

There are a few reasons why usermode might want to be able to
exclusively steer swap and hibernate. One reason relates to SSD wearing.
Hibernate's endurance and speed requirements are different from swap.
It may for instance be advantageous to keep hibernate in primary
storage, but put swap in an SLC namespace. These namespaces are faster
and have better endurance, but cost 3-4x in terms of capacity.
Exclusively steering hibernate and swap enables system designers to
accurately partition their storage without either wearing out their
primary storage, or overprovisioning their fast swap area.

Another reason to allow exclusive steering has to do with security.
The requirements for designing systems with resilience against
offline attacks are different between swap and hibernate. Swap
effectively requires a dictionary of hashes, as pages can be added and
removed arbitrarily, whereas hibernate only needs a single hash for the
entire image. If you've set up block-level integrity for swap and
image-level integrity for hibernate, then allowing swap blocks to
possibly leak out to the hibernate region is problematic, since it
creates swap pages not protected by any integrity.

Swap regions with SWAP_FLAG_HIBERNATE_ONLY set will not appear in
/proc/meminfo under SwapTotal and SwapFree, since they are not usable as
general swap. These regions do still appear in /proc/swaps.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

Changes in v4:
 - Rework commit message to summarize workaround discussion [David]
 - Rename flag from SWAP_FLAG_SWAPON to SWAP_FLAG_HIBERNATE_ONLY [David]
 - Reject invalid flags when HIBERNATE_ONLY is set. [David]
 - Reject HIBERNATE_ONLY if CONFIG_HIBERNATION is not set. [David]
 - Relax VM_BUG_ON() since HIBERNATE_ONLY regions may directly free
   pages. [Evan]

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

 include/linux/swap.h | 10 ++++++-
 mm/swapfile.c        | 67 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index cdf0957a88a49a..0d922daac94cd6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -28,10 +28,17 @@ struct pagevec;
 #define SWAP_FLAG_DISCARD	0x10000 /* enable discard for swap */
 #define SWAP_FLAG_DISCARD_ONCE	0x20000 /* discard swap area at swapon-time */
 #define SWAP_FLAG_DISCARD_PAGES 0x40000 /* discard page-clusters after use */
+#define SWAP_FLAG_HIBERNATE_ONLY 0x80000 /* use only for hibernate, not swap */
 
 #define SWAP_FLAGS_VALID	(SWAP_FLAG_PRIO_MASK | SWAP_FLAG_PREFER | \
 				 SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | \
-				 SWAP_FLAG_DISCARD_PAGES)
+				 SWAP_FLAG_DISCARD_PAGES | \
+				 SWAP_FLAG_HIBERNATE_ONLY)
+
+/* Valid flags when SWAP_FLAG_HIBERNATE_ONLY is set */
+#define SWAP_HIBERNATE_ONLY_VALID_FLAGS \
+	(SWAP_FLAG_HIBERNATE_ONLY | SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE)
+
 #define SWAP_BATCH 64
 
 static inline int current_is_kswapd(void)
@@ -182,6 +189,7 @@ enum {
 	SWP_PAGE_DISCARD = (1 << 10),	/* freed swap page-cluster discards */
 	SWP_STABLE_WRITES = (1 << 11),	/* no overwrite PG_writeback pages */
 	SWP_SYNCHRONOUS_IO = (1 << 12),	/* synchronous IO is efficient */
+	SWP_HIBERNATE_ONLY = (1 << 13),	/* use only for hibernate, not swap */
 					/* add others here before... */
 	SWP_SCANNING	= (1 << 14),	/* refcount in scan_swap_map */
 };
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e3dcaeecc50f54..0c782e12328d25 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -697,7 +697,8 @@ static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
 	if (si->inuse_pages == si->pages) {
 		si->lowest_bit = si->max;
 		si->highest_bit = 0;
-		del_from_avail_list(si);
+		if (!(si->flags & SWP_HIBERNATE_ONLY))
+			del_from_avail_list(si);
 	}
 }
 
@@ -726,10 +727,13 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 		bool was_full = !si->highest_bit;
 
 		WRITE_ONCE(si->highest_bit, end);
-		if (was_full && (si->flags & SWP_WRITEOK))
+		if (was_full &&
+		    ((si->flags & (SWP_WRITEOK | SWP_HIBERNATE_ONLY)) ==
+		     SWP_WRITEOK))
 			add_to_avail_list(si);
 	}
-	atomic_long_add(nr_entries, &nr_swap_pages);
+	if (!(si->flags & SWP_HIBERNATE_ONLY))
+		atomic_long_add(nr_entries, &nr_swap_pages);
 	si->inuse_pages -= nr_entries;
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1078,6 +1082,9 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			WARN(!(si->flags & SWP_WRITEOK),
 			     "swap_info %d in list but !SWP_WRITEOK\n",
 			     si->type);
+			WARN((si->flags & SWP_HIBERNATE_ONLY),
+			     "swap_info %d in list but SWP_HIBERNATE_ONLY\n",
+			     si->type);
 			__del_from_avail_list(si);
 			spin_unlock(&si->lock);
 			goto nextsi;
@@ -1320,7 +1327,9 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 
 	ci = lock_cluster(p, offset);
 	count = p->swap_map[offset];
-	VM_BUG_ON(count != SWAP_HAS_CACHE);
+	/* Pages are only freed by the cache or directly by hibernate. */
+	VM_BUG_ON((count != SWAP_HAS_CACHE) &&
+		  !((p->flags & SWP_HIBERNATE_ONLY) && (count == 1)));
 	p->swap_map[offset] = 0;
 	dec_cluster_info_page(p, p->cluster_info, offset);
 	unlock_cluster(ci);
@@ -1338,8 +1347,12 @@ void swap_free(swp_entry_t entry)
 	struct swap_info_struct *p;
 
 	p = _swap_info_get(entry);
-	if (p)
-		__swap_entry_free(p, entry);
+	if (p) {
+		if (p->flags & SWP_HIBERNATE_ONLY)
+			swap_entry_free(p, entry);
+		else
+			__swap_entry_free(p, entry);
+	}
 }
 
 /*
@@ -1783,8 +1796,10 @@ swp_entry_t get_swap_page_of_type(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	spin_lock(&si->lock);
-	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry))
-		atomic_long_dec(&nr_swap_pages);
+	if ((si->flags & SWP_WRITEOK) && scan_swap_map_slots(si, 1, 1, &entry)) {
+		if (!(si->flags & SWP_HIBERNATE_ONLY))
+			atomic_long_dec(&nr_swap_pages);
+	}
 	spin_unlock(&si->lock);
 fail:
 	return entry;
@@ -2454,8 +2469,6 @@ static void setup_swap_info(struct swap_info_struct *p, int prio,
 static void _enable_swap_info(struct swap_info_struct *p)
 {
 	p->flags |= SWP_WRITEOK;
-	atomic_long_add(p->pages, &nr_swap_pages);
-	total_swap_pages += p->pages;
 
 	assert_spin_locked(&swap_lock);
 	/*
@@ -2469,7 +2482,11 @@ static void _enable_swap_info(struct swap_info_struct *p)
 	 * swap_info_struct.
 	 */
 	plist_add(&p->list, &swap_active_head);
-	add_to_avail_list(p);
+	if (!(p->flags & SWP_HIBERNATE_ONLY)) {
+		atomic_long_add(p->pages, &nr_swap_pages);
+		total_swap_pages += p->pages;
+		add_to_avail_list(p);
+	}
 }
 
 static void enable_swap_info(struct swap_info_struct *p, int prio,
@@ -2564,7 +2581,9 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		spin_unlock(&swap_lock);
 		goto out_dput;
 	}
-	del_from_avail_list(p);
+	if (!(p->flags & SWP_HIBERNATE_ONLY))
+		del_from_avail_list(p);
+
 	spin_lock(&p->lock);
 	if (p->prio < 0) {
 		struct swap_info_struct *si = p;
@@ -2581,8 +2600,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 		least_priority++;
 	}
 	plist_del(&p->list, &swap_active_head);
-	atomic_long_sub(p->pages, &nr_swap_pages);
-	total_swap_pages -= p->pages;
+	if (!(p->flags & SWP_HIBERNATE_ONLY)) {
+		atomic_long_sub(p->pages, &nr_swap_pages);
+		total_swap_pages -= p->pages;
+	}
 	p->flags &= ~SWP_WRITEOK;
 	spin_unlock(&p->lock);
 	spin_unlock(&swap_lock);
@@ -3147,6 +3168,16 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (swap_flags & ~SWAP_FLAGS_VALID)
 		return -EINVAL;
 
+	if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY) {
+		if (IS_ENABLED(CONFIG_HIBERNATION)) {
+			if (swap_flags & ~SWAP_HIBERNATE_ONLY_VALID_FLAGS)
+				return -EINVAL;
+
+		} else {
+			return -EINVAL;
+		}
+	}
+
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
@@ -3335,16 +3366,20 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (swap_flags & SWAP_FLAG_PREFER)
 		prio =
 		  (swap_flags & SWAP_FLAG_PRIO_MASK) >> SWAP_FLAG_PRIO_SHIFT;
+
+	if (swap_flags & SWAP_FLAG_HIBERNATE_ONLY)
+		p->flags |= SWP_HIBERNATE_ONLY;
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
+		(p->flags & SWP_HIBERNATE_ONLY) ? "H" : "");
 
 	mutex_unlock(&swapon_mutex);
 	atomic_inc(&proc_poll_event);
-- 
2.31.0

