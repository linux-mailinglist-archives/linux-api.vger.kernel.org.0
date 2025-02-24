Return-Path: <linux-api+bounces-3299-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 780A8A4287D
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 17:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDE01662EB
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC69A264F9C;
	Mon, 24 Feb 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JjBqgzZm"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B438D264A7A
	for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416177; cv=none; b=M1BgzpquiP6BoZFgzOHa1lQK28+alkYOGIVMWfC837VrfncyKheGSm/zcZPsDlNPx7OkiViRF4lcc+xqCvErjkIoRFs08B3JLBkBRpvFDWZ4hjZz3tCLpMDQU32cnjkNsoNc/WvaBGDaBNmBWQBRnCgZbndKccKifg0wjs8tLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416177; c=relaxed/simple;
	bh=5WP1H6l1SRHf+A6AVEl6PPcHjhpjv5kvsrxnZBwuLrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOuYCGEbMjd2UbYPBltNafA0lcTRobU/6QaG+gDdriA57bbEx+MmyqGtBIV6QkSBT7Op+zpAZTfKk/wJz3hdRX1iCZKcKF8oqmb5mjDJK8LkEHVCvJwyHEjwGoEHZs+lZO7Kq6wHxc37SrA/kyBFq+bgvF+3qCeDA0oH0gYq+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JjBqgzZm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Z/i7SxHkRJm72w2k3iTqc1vo3DynQo4UiIchyZFPhI=;
	b=JjBqgzZmd+rGbSFEW7fxe2AVXSbjZp+IKWsU0WbINjUkksGhgys+hmcVVI63CcXZzClCJi
	H14NO9QakbsPdKmB9xiD5pl/qwgnElckqnAsf+rdcEwPCERkAsPEIAH0xc/molvJMG7Wh3
	3df4ypRKEU6dSdwqz/YVabE2qWIFP5o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-yD_2FO9zOAuc523E9_Zinw-1; Mon, 24 Feb 2025 11:56:13 -0500
X-MC-Unique: yD_2FO9zOAuc523E9_Zinw-1
X-Mimecast-MFC-AGG-ID: yD_2FO9zOAuc523E9_Zinw_1740416172
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so22851075e9.1
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 08:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416172; x=1741020972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z/i7SxHkRJm72w2k3iTqc1vo3DynQo4UiIchyZFPhI=;
        b=XRA+bE8/a56gm12XokZms9Liu23eBtT4juasKU+UWcqCalFIBM9YNC/LBzvDqsqec6
         9uh8m2qt2+VM5n3vS/+AnSgKJ9UwFg5LuYPUSGwwGiVgwhckDfHJbhVROl5McEjFOHzz
         oSiFDqI0xNVvNZ5//vHH693rSt6n2Ihi+YBIvEL0Qq3z2b724sPAMiH66f02AkCMkkix
         5xlWe4ZDLDKml1Ipdd5HesGffUA+6YpgIfu4uWAswqH0GAZgfCyFoSJUic4Ahrx54z3b
         MNp0tmAgIm8KZUIMEZTjbgocaPI9no7A9WBHw06dEmCykPt9/+d68NjEMoxfoWch6kTK
         BBxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6bV5JMrzyCt0GU/W5gdysnfeKrVca+kLM1zzhLupoDd95WJX0krAjwUMNQDRHaoylyCyb/Lponss=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx87jqdD2YL+R+DHOR3lZmfPYz83h3CnYueghjdlshEjZdLA2AO
	A0ztbpCtJBqnlo5Z+KM0eZTWwN3lMG/maAPCvtwzT6Cu8q9nnSJIMr8hQJc+UHH3c1I+TMAv5Sr
	hW6h8GNnw/0uihdV0woPkTgDbPij3hNAL+xMK4LpWpQlmgF6TxS+jtni0MA==
X-Gm-Gg: ASbGnct3zjfP4Tc62h3B/qxqhgHHt1HgZzVrQnGDutkwS6LYe/iW+XoZYefJ3d6Af4w
	SSyGy60/ADn9LXOZiEL3X6MCQ/qgzS6pTBX3uUbbRm5UkX1BIEfTURP5dWb+hvessQXotazE3eN
	RMyyeGAy6lsO+wXQJiaLgvK8t1QtMGXSCqaW6SGPar3g1VDrCWCeX0sdHL3uJbvRF6C9FRcBb0n
	BhnLC9B9Pfvl9dmHws152Jo9W5vYwMYXdmOiEkRtqrjPHN8yLgVmzRH/8jOR75aefz7vi3Q4ajR
	4XVL1VIzHD9hNZd8gxaWmnWyuqn18SNaNjJHv0ToJg==
X-Received: by 2002:a05:600c:1c85:b0:439:968b:6669 with SMTP id 5b1f17b1804b1-439ae2d254bmr112029185e9.1.1740416171885;
        Mon, 24 Feb 2025 08:56:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPiVGKd002kgHq/C+YhiMRT6ZEt5tkRc6eny1qWEWThiWAlrLvHc+EEKxBr1Q0DjH+goSmcg==
X-Received: by 2002:a05:600c:1c85:b0:439:968b:6669 with SMTP id 5b1f17b1804b1-439ae2d254bmr112028725e9.1.1740416171409;
        Mon, 24 Feb 2025 08:56:11 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b0371b7bsm112170735e9.33.2025.02.24.08.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:10 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 03/20] mm: let _folio_nr_pages overlay memcg_data in first tail page
Date: Mon, 24 Feb 2025 17:55:45 +0100
Message-ID: <20250224165603.1434404-4-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's free up some more of the "unconditionally available on 64BIT"
space in order-1 folios by letting _folio_nr_pages overlay memcg_data in
the first tail page (second folio page). Consequently, we have the
optimization now whenever we have CONFIG_MEMCG, independent of 64BIT.

We have to make sure that page->memcg on tail pages does not return
"surprises". page_memcg_check() already properly refuses PageTail().
Let's do that earlier in print_page_owner_memcg() to avoid printing
wrong "Slab cache page" information. No other code should touch that
field on tail pages of compound pages.

Reset the "_nr_pages" to 0 when splitting folios, or when freeing them
back to the buddy (to avoid false page->memcg_data "bad page" reports).

Note that in __split_huge_page(), folio_nr_pages() would stop working
already as soon as we start messing with the subpages.

Most kernel configs should have at least CONFIG_MEMCG enabled, even if
disabled at runtime. 64byte "struct memmap" is what we usually have
on 64BIT.

While at it, rename "_folio_nr_pages" to "_nr_pages".

Hopefully memdescs / dynamically allocating "strut folio" in the future
will further clean this up, e.g., making _nr_pages available in all
configs and maybe even in small folios. Doing that should be fairly easy
on top of this change.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       |  4 ++--
 include/linux/mm_types.h | 30 ++++++++++++++++++++++--------
 mm/huge_memory.c         | 16 +++++++++++++---
 mm/internal.h            |  4 ++--
 mm/page_alloc.c          |  6 +++++-
 mm/page_owner.c          |  2 +-
 6 files changed, 45 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c5a8fd29cfcd..f6b6373a864dd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1199,10 +1199,10 @@ static inline unsigned int folio_large_order(const struct folio *folio)
 	return folio->_flags_1 & 0xff;
 }
 
-#ifdef CONFIG_64BIT
+#ifdef NR_PAGES_IN_LARGE_FOLIO
 static inline long folio_large_nr_pages(const struct folio *folio)
 {
-	return folio->_folio_nr_pages;
+	return folio->_nr_pages;
 }
 #else
 static inline long folio_large_nr_pages(const struct folio *folio)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 689b2a7461892..e81be20bbabc6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -287,6 +287,11 @@ typedef struct {
 	unsigned long val;
 } swp_entry_t;
 
+#if defined(CONFIG_MEMCG) || defined(CONFIG_SLAB_OBJ_EXT)
+/* We have some extra room after the refcount in tail pages. */
+#define NR_PAGES_IN_LARGE_FOLIO
+#endif
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
@@ -312,7 +317,7 @@ typedef struct {
  * @_large_mapcount: Do not use directly, call folio_mapcount().
  * @_nr_pages_mapped: Do not use outside of rmap and debug code.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
- * @_folio_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_nr_pages: Do not use directly, call folio_nr_pages().
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
@@ -377,13 +382,20 @@ struct folio {
 			unsigned long _flags_1;
 			unsigned long _head_1;
 	/* public: */
-			atomic_t _large_mapcount;
-			atomic_t _entire_mapcount;
-			atomic_t _nr_pages_mapped;
-			atomic_t _pincount;
-#ifdef CONFIG_64BIT
-			unsigned int _folio_nr_pages;
-#endif
+			union {
+				struct {
+					atomic_t _large_mapcount;
+					atomic_t _entire_mapcount;
+					atomic_t _nr_pages_mapped;
+					atomic_t _pincount;
+				};
+				unsigned long _usable_1[4];
+			};
+			atomic_t _mapcount_1;
+			atomic_t _refcount_1;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+			unsigned int _nr_pages;
+#endif /* NR_PAGES_IN_LARGE_FOLIO */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_1;
@@ -435,6 +447,8 @@ FOLIO_MATCH(_last_cpupid, _last_cpupid);
 			offsetof(struct page, pg) + sizeof(struct page))
 FOLIO_MATCH(flags, _flags_1);
 FOLIO_MATCH(compound_head, _head_1);
+FOLIO_MATCH(_mapcount, _mapcount_1);
+FOLIO_MATCH(_refcount, _refcount_1);
 #undef FOLIO_MATCH
 #define FOLIO_MATCH(pg, fl)						\
 	static_assert(offsetof(struct folio, fl) ==			\
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e45064046a0f..13152313e77ce 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3307,9 +3307,10 @@ bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins)
  * It splits @folio into @new_order folios and copies the @folio metadata to
  * all the resulting folios.
  */
-static void __split_folio_to_order(struct folio *folio, int new_order)
+static void __split_folio_to_order(struct folio *folio, int old_order,
+		int new_order)
 {
-	long nr_pages = folio_nr_pages(folio);
+	long nr_pages = 1 << old_order;
 	long new_nr_pages = 1 << new_order;
 	long index;
 
@@ -3529,12 +3530,21 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
 			}
 		}
 
+		/*
+		 * Reset any memcg data overlay in the tail pages.
+		 * folio_nr_pages() is unreliable until prep_compound_page()
+		 * was called again.
+		 */
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+		folio->_nr_pages = 0;
+#endif
+
 		/* complete memcg works before add pages to LRU */
 		split_page_memcg(&folio->page, old_order, split_order);
 		split_page_owner(&folio->page, old_order, split_order);
 		pgalloc_tag_split(folio, old_order, split_order);
 
-		__split_folio_to_order(folio, split_order);
+		__split_folio_to_order(folio, old_order, split_order);
 
 after_split:
 		/*
diff --git a/mm/internal.h b/mm/internal.h
index b07550db2bfd1..7f6d5def00fa0 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -684,8 +684,8 @@ static inline void folio_set_order(struct folio *folio, unsigned int order)
 		return;
 
 	folio->_flags_1 = (folio->_flags_1 & ~0xffUL) | order;
-#ifdef CONFIG_64BIT
-	folio->_folio_nr_pages = 1U << order;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+	folio->_nr_pages = 1U << order;
 #endif
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 16dfcf7ade74a..bdfc954dab9aa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1174,8 +1174,12 @@ __always_inline bool free_pages_prepare(struct page *page,
 	if (unlikely(order)) {
 		int i;
 
-		if (compound)
+		if (compound) {
 			page[1].flags &= ~PAGE_FLAGS_SECOND;
+#ifdef NR_PAGES_IN_LARGE_FOLIO
+			folio->_nr_pages = 0;
+#endif
+		}
 		for (i = 1; i < (1 << order); i++) {
 			if (compound)
 				bad += free_tail_page_prepare(page, page + i);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d6360eaccbb6..a409e2561a8fd 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -507,7 +507,7 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 
 	rcu_read_lock();
 	memcg_data = READ_ONCE(page->memcg_data);
-	if (!memcg_data)
+	if (!memcg_data || PageTail(page))
 		goto out_unlock;
 
 	if (memcg_data & MEMCG_DATA_OBJEXTS)
-- 
2.48.1


