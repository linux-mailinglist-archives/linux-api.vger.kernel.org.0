Return-Path: <linux-api+bounces-3364-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BA9A4C7FB
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3557A40C3
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259E52505D3;
	Mon,  3 Mar 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIB5zV6C"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF721CC74
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019454; cv=none; b=PiD6ELsyiiY8mu++6ITeyBkggLJt7/fQZcH8jE86HY0IpvR0P1avUkfWQTMPd7famqbuZUtPaKTQTSXFi7jaGHk1xO8tpc+TY23W9LZlrCj1ACal3LrMPhCAXyYr917JJ98Unj2AyhMEpJGIJHAr5oOYd366gszn6vWcoGVNnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019454; c=relaxed/simple;
	bh=eLFe26DopqB763zT78eiNQu7nUyXlOR9btcKFdRhzQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/4E+GaEt21obHS+VewQe9R1zBZSI6cAf4dQbsayammqiMv8qV7SPEu+mhpIybjj1JLGZTXi2vFsE4pUKJq5QhVc1dyWzhtvNv3LpEACMMN1OhpuyZsYnOxZD+egUsNVHqyjfqFicUygEM3yQgiwqgO8ddU0RF/8zrwdAPPv71U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIB5zV6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ght3iO8/lkNOzwmnKtw9vXpGviqp6AJbx3c5inxt3jw=;
	b=WIB5zV6CNVFd5hpIDorUXfan+HMmC415hQUuNnk25UIL3rQI8wCZvr6YmuPXoqySp2EAEb
	fYmBpdFuCF2oJn3OLipj5aS8P/b7lJcMn0/DiwGso4/MZR/VHkN1yASOAXlpiIIqWy8wiI
	JENqffqz9WKTyLnb9zh/PF9YoRSMyc0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-DioAYgCLOUCPERBsvkx4Vw-1; Mon, 03 Mar 2025 11:30:47 -0500
X-MC-Unique: DioAYgCLOUCPERBsvkx4Vw-1
X-Mimecast-MFC-AGG-ID: DioAYgCLOUCPERBsvkx4Vw_1741019446
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390e27150dbso4385312f8f.3
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:30:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019446; x=1741624246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ght3iO8/lkNOzwmnKtw9vXpGviqp6AJbx3c5inxt3jw=;
        b=u8xXCMJJAwx8kQ5/wVG3YI90EvXFoNt0Le+WRNqD6lz6zYWSvmm0Agzw6ImiLK+0Mj
         rxtghWs0V1gsVLrwdr6LDRJORcJCgrl0kR11BZQIhzVusrv68SZbXfCPwqTzAgwyPDXH
         SdckH6h80gbXZQKGyXd/PKCUA/XA+SOphA+BQVapSp86SoCyCS36pahy4sneThUNoCNF
         HuY0kVWPaSW0co3EmbnvLIkeeSO8INfx4SoYUytlt+0mgtZminVPrMAXq/NFAA/ZDMez
         Qv9KY2pf2CiaX6csmO/CqRr04g2GRpBG7gF8DAWHaN4DNKPxqRgibD5pAY8D+XkNnl68
         lP/A==
X-Forwarded-Encrypted: i=1; AJvYcCUVAxWewu0yE0cKi7mcBSdgaKQcUPJWVUd25yyvYRY159N+JOjf5mVrv8nSh7J2Tafl9Z/Fbgzf0+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEn6xI5Z+fg56ueM40tMLz7agPSu8adxinm8mGdLw/6u3S2sd
	D/q7V19L/N0tnFj1p7d93ht0tffvaeE1JoqU70f8ZYu4Re2M6KG52nD8xtKv1HbW30lebGPb0Dn
	1p7+OOGCVztBdIuyXvzm4RqrfUaYScSu/lIxlGrpdqt/Y4eD3m7bTGaQFTA==
X-Gm-Gg: ASbGncs9P5Pkr1nzbPVODeg5bjKlnAnVow9BRvm21BNyksp0YDMzgFqtuE2EJnDC4J1
	fvOc41uIr68nAIMqN8mBw6LVd+kzlAs2Gf4JtT8bg/9tZ791WPpTkp52iTFzC3N6vlxsl0KPzz1
	JWx1MYbowOeskudV+Rn9cnaAUqyDCNVm/xojYrHH1SNeIOmP8yp2+MxxNN1w69ubeKF20bO0Ka4
	FtXAkWOFx352/XqP03vUX2egSAiuE3gQFzovROAX7w+LZ1eqU1ouMfAAO2Cj1ajOkkrYLGEMFM1
	wPYrHNBz2p5uvZZ8EdDdSdo2SRPJFgQsA2w0xgFevmvtkju+3koffkZRxboF/uG/q3AkrD+IzPe
	V
X-Received: by 2002:a5d:6d0e:0:b0:390:ff25:79c8 with SMTP id ffacd0b85a97d-390ff257cccmr5482804f8f.20.1741019445787;
        Mon, 03 Mar 2025 08:30:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmOzbyVhjQHnOiNa5KjVt0NLNOpFtZnZeHlUY2sgZnsiw2i9l5pVj5IO3A736y2GBbWD/9gw==
X-Received: by 2002:a5d:6d0e:0:b0:390:ff25:79c8 with SMTP id ffacd0b85a97d-390ff257cccmr5482733f8f.20.1741019445180;
        Mon, 03 Mar 2025 08:30:45 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba5870e7sm199192765e9.35.2025.03.03.08.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:44 -0800 (PST)
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
	Jann Horn <jannh@google.com>
Subject: [PATCH v3 12/20] mm/rmap: basic MM owner tracking for large folios (!hugetlb)
Date: Mon,  3 Mar 2025 17:30:05 +0100
Message-ID: <20250303163014.1128035-13-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For small folios, we traditionally use the mapcount to decide
whether it was "certainly mapped exclusively" by a single MM
(mapcount == 1) or whether it "maybe mapped shared" by multiple MMs
(mapcount > 1). For PMD-sized folios that were PMD-mapped, we were able
to use a similar mechanism (single PMD mapping), but for PTE-mapped folios
and in the future folios that span multiple PMDs, this does not work.

So we need a different mechanism to handle large folios. Let's add a new
mechanism to detect whether a large folio is "certainly mapped
exclusively", or whether it is "maybe mapped shared".

We'll use this information next to optimize CoW reuse for PTE-mapped
anonymous THP, and to convert folio_likely_mapped_shared() to
folio_maybe_mapped_shared(), independent of per-page mapcounts.

For each large folio, we'll have two slots, whereby a slot stores:
 (1) an MM id: unique id assigned to each MM
 (2) a per-MM mapcount

If a slot is unoccupied, it can be taken by the next MM that maps folio
page.

In addition, we'll remember the current state -- "mapped exclusively" vs.
"maybe mapped shared" -- and use a bit spinlock to sync on updates and
to reduce the total number of atomic accesses on updates. In the
future, it might be possible to squeeze a proper spinlock into "struct
folio". For now, keep it simple, as we require the whole thing with THP
only, that is incompatible with RT.

As we have to squeeze this information into the "struct folio" of even
folios of order-1 (2 pages), and we generally want to reduce the required
metadata, we'll assign each MM a unique ID that can fit into an int. In
total, we can squeeze everything into 4x int (2x long) on 64bit.

32bit support is a bit challenging, because we only have 2x long == 2x
int in order-1 folios. But we can make it work for now, because we neither
expect many MMs nor very large folios on 32bit.

We will reliably detect folios as "mapped exclusively" vs. "mapped shared"
as long as only two MMs map pages of a folio at one point in time -- for
example with fork() and short-lived child processes, or with apps that
hand over state from one instance to another.

As soon as three MMs are involved at the same time, we might detect
"maybe mapped shared" although the folio is "mapped exclusively".

Example 1:

(1) App1 faults in a (shmem/file-backed) folio page -> Tracked as MM0
(2) App2 faults in a folio page -> Tracked as MM1
(4) App1 unmaps all folio pages

 -> We will detect "mapped exclusively".

Example 2:

(1) App1 faults in a (shmem/file-backed) folio page -> Tracked as MM0
(2) App2 faults in a folio page -> Tracked as MM1
(3) App3 faults in a folio page -> No slot available, tracked as "unknown"
(4) App1 and App2 unmap all folio pages

 -> We will detect "maybe mapped shared".

Make use of __always_inline to keep possible performance degradation
when (un)mapping large folios to a minimum.

Note: by squeezing the two flags into the "unsigned long" that stores
the MM ids, we can use non-atomic __bit_spin_unlock() and
non-atomic setting/clearing of the "maybe mapped shared" bit,
effectively not adding any new atomics on the hot path when updating the
large mapcount + new metadata, which further helps reduce the runtime
overhead in micro-benchmarks.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/mm/transhuge.rst |   8 ++
 include/linux/mm_types.h       |  49 ++++++++++
 include/linux/page-flags.h     |   4 +
 include/linux/rmap.h           | 165 +++++++++++++++++++++++++++++++++
 kernel/fork.c                  |  36 +++++++
 mm/Kconfig                     |   4 +
 mm/internal.h                  |   5 +
 mm/page_alloc.c                |  10 ++
 8 files changed, 281 insertions(+)

diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index a2cd8800d5279..baa17d718a762 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -120,11 +120,19 @@ pages:
     and also increment/decrement folio->_nr_pages_mapped by ENTIRELY_MAPPED
     when _entire_mapcount goes from -1 to 0 or 0 to -1.
 
+    We also maintain the two slots for tracking MM owners (MM ID and
+    corresponding mapcount), and the current status ("maybe mapped shared" vs.
+    "mapped exclusively").
+
   - map/unmap of individual pages with PTE entry increment/decrement
     page->_mapcount, increment/decrement folio->_large_mapcount and also
     increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
     from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
 
+    We also maintain the two slots for tracking MM owners (MM ID and
+    corresponding mapcount), and the current status ("maybe mapped shared" vs.
+    "mapped exclusively").
+
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
 structures. It can be done easily for refcounts taken by page table
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index c83dd2f1ee25e..2d657ac8e9b0c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -292,6 +292,44 @@ typedef struct {
 #define NR_PAGES_IN_LARGE_FOLIO
 #endif
 
+/*
+ * On 32bit, we can cut the required metadata in half, because:
+ * (a) PID_MAX_LIMIT implicitly limits the number of MMs we could ever have,
+ *     so we can limit MM IDs to 15 bit (32767).
+ * (b) We don't expect folios where even a single complete PTE mapping by
+ *     one MM would exceed 15 bits (order-15).
+ */
+#ifdef CONFIG_64BIT
+typedef int mm_id_mapcount_t;
+#define MM_ID_MAPCOUNT_MAX		INT_MAX
+typedef unsigned int mm_id_t;
+#else /* !CONFIG_64BIT */
+typedef short mm_id_mapcount_t;
+#define MM_ID_MAPCOUNT_MAX		SHRT_MAX
+typedef unsigned short mm_id_t;
+#endif /* CONFIG_64BIT */
+
+/* We implicitly use the dummy ID for init-mm etc. where we never rmap pages. */
+#define MM_ID_DUMMY			0
+#define MM_ID_MIN			(MM_ID_DUMMY + 1)
+
+/*
+ * We leave the highest bit of each MM id unused, so we can store a flag
+ * in the highest bit of each folio->_mm_id[].
+ */
+#define MM_ID_BITS			((sizeof(mm_id_t) * BITS_PER_BYTE) - 1)
+#define MM_ID_MASK			((1U << MM_ID_BITS) - 1)
+#define MM_ID_MAX			MM_ID_MASK
+
+/*
+ * In order to use bit_spin_lock(), which requires an unsigned long, we
+ * operate on folio->_mm_ids when working on flags.
+ */
+#define FOLIO_MM_IDS_LOCK_BITNUM	MM_ID_BITS
+#define FOLIO_MM_IDS_LOCK_BIT		BIT(FOLIO_MM_IDS_LOCK_BITNUM)
+#define FOLIO_MM_IDS_SHARED_BITNUM	(2 * MM_ID_BITS + 1)
+#define FOLIO_MM_IDS_SHARED_BIT		BIT(FOLIO_MM_IDS_SHARED_BITNUM)
+
 /**
  * struct folio - Represents a contiguous set of bytes.
  * @flags: Identical to the page flags.
@@ -318,6 +356,9 @@ typedef struct {
  * @_nr_pages_mapped: Do not use outside of rmap and debug code.
  * @_pincount: Do not use directly, call folio_maybe_dma_pinned().
  * @_nr_pages: Do not use directly, call folio_nr_pages().
+ * @_mm_id: Do not use outside of rmap code.
+ * @_mm_ids: Do not use outside of rmap code.
+ * @_mm_id_mapcount: Do not use outside of rmap code.
  * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
  * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
  * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
@@ -390,6 +431,11 @@ struct folio {
 					atomic_t _entire_mapcount;
 					atomic_t _pincount;
 #endif /* CONFIG_64BIT */
+					mm_id_mapcount_t _mm_id_mapcount[2];
+					union {
+						mm_id_t _mm_id[2];
+						unsigned long _mm_ids;
+					};
 				};
 				unsigned long _usable_1[4];
 			};
@@ -1111,6 +1157,9 @@ struct mm_struct {
 #endif
 		} lru_gen;
 #endif /* CONFIG_LRU_GEN_WALKS_MMU */
+#ifdef CONFIG_MM_ID
+		mm_id_t mm_id;
+#endif /* CONFIG_MM_ID */
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 30fe3eb62b90c..01716710066df 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1222,6 +1222,10 @@ static inline int folio_has_private(const struct folio *folio)
 	return !!(folio->flags & PAGE_FLAGS_PRIVATE);
 }
 
+static inline bool folio_test_large_maybe_mapped_shared(const struct folio *folio)
+{
+	return test_bit(FOLIO_MM_IDS_SHARED_BITNUM, &folio->_mm_ids);
+}
 #undef PF_ANY
 #undef PF_HEAD
 #undef PF_NO_TAIL
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index d1e888cc97a58..c131b0efff0fa 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -13,6 +13,7 @@
 #include <linux/highmem.h>
 #include <linux/pagemap.h>
 #include <linux/memremap.h>
+#include <linux/bit_spinlock.h>
 
 /*
  * The anon_vma heads a list of private "related" vmas, to scan if
@@ -173,6 +174,169 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
 
+#ifdef CONFIG_MM_ID
+static __always_inline void folio_lock_large_mapcount(struct folio *folio)
+{
+	bit_spin_lock(FOLIO_MM_IDS_LOCK_BITNUM, &folio->_mm_ids);
+}
+
+static __always_inline void folio_unlock_large_mapcount(struct folio *folio)
+{
+	__bit_spin_unlock(FOLIO_MM_IDS_LOCK_BITNUM, &folio->_mm_ids);
+}
+
+static inline unsigned int folio_mm_id(const struct folio *folio, int idx)
+{
+	VM_WARN_ON_ONCE(idx != 0 && idx != 1);
+	return folio->_mm_id[idx] & MM_ID_MASK;
+}
+
+static inline void folio_set_mm_id(struct folio *folio, int idx, mm_id_t id)
+{
+	VM_WARN_ON_ONCE(idx != 0 && idx != 1);
+	folio->_mm_id[idx] &= ~MM_ID_MASK;
+	folio->_mm_id[idx] |= id;
+}
+
+static inline void __folio_large_mapcount_sanity_checks(const struct folio *folio,
+		int diff, mm_id_t mm_id)
+{
+	VM_WARN_ON_ONCE(!folio_test_large(folio) || folio_test_hugetlb(folio));
+	VM_WARN_ON_ONCE(diff <= 0);
+	VM_WARN_ON_ONCE(mm_id < MM_ID_MIN || mm_id > MM_ID_MAX);
+
+	/*
+	 * Make sure we can detect at least one complete PTE mapping of the
+	 * folio in a single MM as "exclusively mapped". This is primarily
+	 * a check on 32bit, where we currently reduce the size of the per-MM
+	 * mapcount to a short.
+	 */
+	VM_WARN_ON_ONCE(diff > folio_large_nr_pages(folio));
+	VM_WARN_ON_ONCE(folio_large_nr_pages(folio) - 1 > MM_ID_MAPCOUNT_MAX);
+
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) == MM_ID_DUMMY &&
+			folio->_mm_id_mapcount[0] != -1);
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) != MM_ID_DUMMY &&
+			folio->_mm_id_mapcount[0] < 0);
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 1) == MM_ID_DUMMY &&
+			folio->_mm_id_mapcount[1] != -1);
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 1) != MM_ID_DUMMY &&
+			folio->_mm_id_mapcount[1] < 0);
+	VM_WARN_ON_ONCE(!folio_mapped(folio) &&
+			folio_test_large_maybe_mapped_shared(folio));
+}
+
+static __always_inline void folio_set_large_mapcount(struct folio *folio,
+		int mapcount, struct vm_area_struct *vma)
+{
+	__folio_large_mapcount_sanity_checks(folio, mapcount, vma->vm_mm->mm_id);
+
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) != MM_ID_DUMMY);
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 1) != MM_ID_DUMMY);
+
+	/* Note: mapcounts start at -1. */
+	atomic_set(&folio->_large_mapcount, mapcount - 1);
+	folio->_mm_id_mapcount[0] = mapcount - 1;
+	folio_set_mm_id(folio, 0, vma->vm_mm->mm_id);
+}
+
+static __always_inline void folio_add_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	const mm_id_t mm_id = vma->vm_mm->mm_id;
+	int new_mapcount_val;
+
+	folio_lock_large_mapcount(folio);
+	__folio_large_mapcount_sanity_checks(folio, diff, mm_id);
+
+	new_mapcount_val = atomic_read(&folio->_large_mapcount) + diff;
+	atomic_set(&folio->_large_mapcount, new_mapcount_val);
+
+	/*
+	 * If a folio is mapped more than once into an MM on 32bit, we
+	 * can in theory overflow the per-MM mapcount (although only for
+	 * fairly large folios), turning it negative. In that case, just
+	 * free up the slot and mark the folio "mapped shared", otherwise
+	 * we might be in trouble when unmapping pages later.
+	 */
+	if (folio_mm_id(folio, 0) == mm_id) {
+		folio->_mm_id_mapcount[0] += diff;
+		if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio->_mm_id_mapcount[0] < 0)) {
+			folio->_mm_id_mapcount[0] = -1;
+			folio_set_mm_id(folio, 0, MM_ID_DUMMY);
+			folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
+		}
+	} else if (folio_mm_id(folio, 1) == mm_id) {
+		folio->_mm_id_mapcount[1] += diff;
+		if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio->_mm_id_mapcount[1] < 0)) {
+			folio->_mm_id_mapcount[1] = -1;
+			folio_set_mm_id(folio, 1, MM_ID_DUMMY);
+			folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
+		}
+	} else if (folio_mm_id(folio, 0) == MM_ID_DUMMY) {
+		folio_set_mm_id(folio, 0, mm_id);
+		folio->_mm_id_mapcount[0] = diff - 1;
+		/* We might have other mappings already. */
+		if (new_mapcount_val != diff - 1)
+			folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
+	} else if (folio_mm_id(folio, 1) == MM_ID_DUMMY) {
+		folio_set_mm_id(folio, 1, mm_id);
+		folio->_mm_id_mapcount[1] = diff - 1;
+		/* Slot 0 certainly has mappings as well. */
+		folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
+	}
+	folio_unlock_large_mapcount(folio);
+}
+
+static __always_inline void folio_sub_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	const mm_id_t mm_id = vma->vm_mm->mm_id;
+	int new_mapcount_val;
+
+	folio_lock_large_mapcount(folio);
+	__folio_large_mapcount_sanity_checks(folio, diff, mm_id);
+
+	new_mapcount_val = atomic_read(&folio->_large_mapcount) - diff;
+	atomic_set(&folio->_large_mapcount, new_mapcount_val);
+
+	/*
+	 * There are valid corner cases where we might underflow a per-MM
+	 * mapcount (some mappings added when no slot was free, some mappings
+	 * added once a slot was free), so we always set it to -1 once we go
+	 * negative.
+	 */
+	if (folio_mm_id(folio, 0) == mm_id) {
+		folio->_mm_id_mapcount[0] -= diff;
+		if (folio->_mm_id_mapcount[0] >= 0)
+			goto out;
+		folio->_mm_id_mapcount[0] = -1;
+		folio_set_mm_id(folio, 0, MM_ID_DUMMY);
+	} else if (folio_mm_id(folio, 1) == mm_id) {
+		folio->_mm_id_mapcount[1] -= diff;
+		if (folio->_mm_id_mapcount[1] >= 0)
+			goto out;
+		folio->_mm_id_mapcount[1] = -1;
+		folio_set_mm_id(folio, 1, MM_ID_DUMMY);
+	}
+
+	/*
+	 * If one MM slot owns all mappings, the folio is mapped exclusively.
+	 * Note that if the folio is now unmapped (new_mapcount_val == -1), both
+	 * slots must be free (mapcount == -1), and we'll also mark it as
+	 * exclusive.
+	 */
+	if (folio->_mm_id_mapcount[0] == new_mapcount_val ||
+	    folio->_mm_id_mapcount[1] == new_mapcount_val)
+		folio->_mm_ids &= ~FOLIO_MM_IDS_SHARED_BIT;
+out:
+	folio_unlock_large_mapcount(folio);
+}
+#else /* !CONFIG_MM_ID */
+/*
+ * See __folio_rmap_sanity_checks(), we might map large folios even without
+ * CONFIG_TRANSPARENT_HUGEPAGE. We'll keep that working for now.
+ */
 static inline void folio_set_large_mapcount(struct folio *folio, int mapcount,
 		struct vm_area_struct *vma)
 {
@@ -191,6 +355,7 @@ static inline void folio_sub_large_mapcount(struct folio *folio,
 {
 	atomic_sub(diff, &folio->_large_mapcount);
 }
+#endif /* CONFIG_MM_ID */
 
 #define folio_inc_large_mapcount(folio, vma) \
 	folio_add_large_mapcount(folio, 1, vma)
diff --git a/kernel/fork.c b/kernel/fork.c
index 364b2d4fd3efa..f9cf0f056eb6f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -802,6 +802,36 @@ static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
 
+#ifdef CONFIG_MM_ID
+static DEFINE_IDA(mm_ida);
+
+static inline int mm_alloc_id(struct mm_struct *mm)
+{
+	int ret;
+
+	ret = ida_alloc_range(&mm_ida, MM_ID_MIN, MM_ID_MAX, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
+	mm->mm_id = ret;
+	return 0;
+}
+
+static inline void mm_free_id(struct mm_struct *mm)
+{
+	const mm_id_t id = mm->mm_id;
+
+	mm->mm_id = MM_ID_DUMMY;
+	if (id == MM_ID_DUMMY)
+		return;
+	if (WARN_ON_ONCE(id < MM_ID_MIN || id > MM_ID_MAX))
+		return;
+	ida_free(&mm_ida, id);
+}
+#else /* !CONFIG_MM_ID */
+static inline int mm_alloc_id(struct mm_struct *mm) { return 0; }
+static inline void mm_free_id(struct mm_struct *mm) {}
+#endif /* CONFIG_MM_ID */
+
 static void check_mm(struct mm_struct *mm)
 {
 	int i;
@@ -905,6 +935,7 @@ void __mmdrop(struct mm_struct *mm)
 
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
+	mm_free_id(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
@@ -1289,6 +1320,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
 
+	if (mm_alloc_id(mm))
+		goto fail_noid;
+
 	if (init_new_context(p, mm))
 		goto fail_nocontext;
 
@@ -1308,6 +1342,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 fail_cid:
 	destroy_context(mm);
 fail_nocontext:
+	mm_free_id(mm);
+fail_noid:
 	mm_free_pgd(mm);
 fail_nopgd:
 	free_mm(mm);
diff --git a/mm/Kconfig b/mm/Kconfig
index fba9757e58147..4034a0441f650 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -809,11 +809,15 @@ config ARCH_WANT_GENERAL_HUGETLB
 config ARCH_WANTS_THP_SWAP
 	def_bool n
 
+config MM_ID
+	def_bool n
+
 menuconfig TRANSPARENT_HUGEPAGE
 	bool "Transparent Hugepage Support"
 	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
 	select COMPACTION
 	select XARRAY_MULTI
+	select MM_ID
 	help
 	  Transparent Hugepages allows the kernel to use huge pages and
 	  huge tlb transparently to the applications whenever possible.
diff --git a/mm/internal.h b/mm/internal.h
index 9860e65ffc945..e33a1fc5ed667 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -720,6 +720,11 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	folio_set_order(folio, order);
 	atomic_set(&folio->_large_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
+	if (IS_ENABLED(CONFIG_MM_ID)) {
+		folio->_mm_ids = 0;
+		folio->_mm_id_mapcount[0] = -1;
+		folio->_mm_id_mapcount[1] = -1;
+	}
 	if (IS_ENABLED(CONFIG_64BIT) || order > 1) {
 		atomic_set(&folio->_pincount, 0);
 		atomic_set(&folio->_entire_mapcount, -1);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b0739baf7b07f..e3b8bfdd0b756 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -959,6 +959,16 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
 		}
+		if (IS_ENABLED(CONFIG_MM_ID)) {
+			if (unlikely(folio->_mm_id_mapcount[0] != -1)) {
+				bad_page(page, "nonzero mm mapcount 0");
+				goto out;
+			}
+			if (unlikely(folio->_mm_id_mapcount[1] != -1)) {
+				bad_page(page, "nonzero mm mapcount 1");
+				goto out;
+			}
+		}
 		if (IS_ENABLED(CONFIG_64BIT)) {
 			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
 				bad_page(page, "nonzero entire_mapcount");
-- 
2.48.1


