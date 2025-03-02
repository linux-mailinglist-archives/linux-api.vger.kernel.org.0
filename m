Return-Path: <linux-api+bounces-3371-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB49BA4C800
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02CE3A22DC
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DB425D1E0;
	Mon,  3 Mar 2025 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9kF+BQf"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C9D255E32
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019470; cv=none; b=flsfRRlKud3DNLhLTXqMId0PYsdEB2nk+CTTglKPuZ9aS3v/QLPgGkRhAVbtjGyWyYlg4IsKVEOWpSYkaCZBwftitKN/02BZe8BlJsZbaKV/saBFILg8TSoiR0yvR8WrpC49xXKMNVPQrvt3SHvSunbyG34Fto6Fl347XMDDbRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019470; c=relaxed/simple;
	bh=4dKqZTo7HvrZS2LxTB3uv/AvaRzWkQnYjToguRx68cY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UW+b6S3Qh64ZPtLCgJo3VSUb/tkbueT8zlMQWpdRdhH7d1gLmUJ+VhzvOeI7Z0hSGmoB6Jm4mNQHTPoljbf9IJD0bxee1SHwjgfUHT4KZMH54EF4YidL/Dlz6B5xOdbUO2StvFwfXEC5Eelc4bEl7EAv93iAc/o8LJEQnnxigFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J9kF+BQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YlS6X8Uew29SCA4ywjbEdY/YLTwcEHUkyCcmw2xO2pk=;
	b=J9kF+BQf7OQ3dmnL+jfexTgz8ijf2a2laY9Qd6/qvEeBf0G14kMBa8V7qfWw4JC0Cbs573
	aYfiGGEodcTL298ENiUQcypNUSG9Xrwb4n5UhfdfAy2Zg/3tm4KjE4RwZm+2v9XwnV2Jgm
	vfjzQE4XkYAsby7vWZXs3EujKZaCXQU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Tabr5DJHOIqiLSHROHDriw-1; Mon, 03 Mar 2025 11:31:03 -0500
X-MC-Unique: Tabr5DJHOIqiLSHROHDriw-1
X-Mimecast-MFC-AGG-ID: Tabr5DJHOIqiLSHROHDriw_1741019463
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3910034500eso766092f8f.1
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019462; x=1741624262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YlS6X8Uew29SCA4ywjbEdY/YLTwcEHUkyCcmw2xO2pk=;
        b=N+5k8ZxdVWNcA8M9PNKFzJbW/lhCqugP8A17qAwLQnc5hamW/LVGnU33KHPxyoGmVv
         4I/ssMt/F06zWM6dYgv/yxwVVAJxi8hHzJTnPJ5wtgjMz5OqlEnF37R8e8lm5S+m4POn
         husvN4oX1eR3bxU8GjI8RuTMSvWurbv0sd/jBXuNsSQBAdPVomT6WV/eCwHMiXchao8u
         3+iL2AA8RI2msDJ2coSmZc0kryTHJY8hKnfgDmiPjFAMwNN6lipnsQUrflow6exNT76s
         GmCT0hUbEH/HATU/akE2c5u42IKUsky78OcLF1DgDnPdM5jsolJicDXS3OmMzNPNxBc4
         +Ojg==
X-Forwarded-Encrypted: i=1; AJvYcCUpvPrVxks6KJYNCuhGqlhVk5ufqF1NdScv238T3oGMiEeruqVWAnXobvADLXVW9JkUS8umQAeRreU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIkMrphTGI6KR0sVKoer0PSlXorH1TIH0Podz+eA0teGFVL2sQ
	FDAJ25HSYwQTUkqyzCLh0uoM38S5M05vVK9RkvoiGgxKWFt+mem6C4Z7gwbY5jU25yA1Zz7rs3k
	qfJ/T61IMY6gNOcaz/2qeJo/mpCctFBnVogVmwnUazjO3Vda8xzKhTtBIZw==
X-Gm-Gg: ASbGncvlRMyuwgwDoAhkRf/vMQu8kECDmstRjqw/HnQgAppix+1I3CpDd/laMs9J73n
	s4bftXPezdlP86UdsepCN4tTUqIVQup1WsWEpYZg3qUSuTrBkhNcCb1RrnCPnYWF4lekHv7Yvo5
	mT5Nb9ABuTeUJNVTWt+Nhmf0UJ7G2PIhEH1UF3PrLJYQuTSmA32rrmDvVzfppAI4ErD91oDXcyO
	AG9VKebg8bmCBNl+MdtaiiGuZ4UExwIjEmhmACHOm0IXJJflORhDOzzPiKZKvNuqHW/ush+6mBy
	cNIe/isy/Jre9Nolo1XHtOQPYM/V1XwjYAeYVLc4wJpY4UaatGL078GYkMvw4ERFJJa7VyGVasw
	o
X-Received: by 2002:a05:6000:2102:b0:390:d777:6505 with SMTP id ffacd0b85a97d-390ec7cebb6mr8484125f8f.19.1741019462311;
        Mon, 03 Mar 2025 08:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4Wm1Nrswdi59UkfQX4E0Mp6V76OD2ctdPYdeeFY/isIJhyYJQe8UFw7Y7ah5xkjWGZGxEPQ==
X-Received: by 2002:a05:6000:2102:b0:390:d777:6505 with SMTP id ffacd0b85a97d-390ec7cebb6mr8484079f8f.19.1741019461762;
        Mon, 03 Mar 2025 08:31:01 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485df22sm15178083f8f.97.2025.03.03.08.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:31:01 -0800 (PST)
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
Subject: [PATCH v3 20/20] mm: stop maintaining the per-page mapcount of large folios (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon,  3 Mar 2025 17:30:13 +0100
Message-ID: <20250303163014.1128035-21-david@redhat.com>
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

Everything is in place to stop using the per-page mapcounts in large
folios: the mapcount of tail pages will always be logically 0 (-1 value),
just like it currently is for hugetlb folios already, and the page
mapcount of the head page is either 0 (-1 value) or contains a page type
(e.g., hugetlb).

Maintaining _nr_pages_mapped without per-page mapcounts is impossible,
so that one also has to go with CONFIG_NO_PAGE_MAPCOUNT.

There are two remaining implications:

(1) Per-node, per-cgroup and per-lruvec stats of "NR_ANON_MAPPED"
    ("mapped anonymous memory") and "NR_FILE_MAPPED"
    ("mapped file memory"):

    As soon as any page of the folio is mapped -- folio_mapped() -- we
    now account the complete folio as mapped. Once the last page is
    unmapped -- !folio_mapped() -- we account the complete folio as
    unmapped.

    This implies that ...

    * "AnonPages" and "Mapped" in /proc/meminfo and
      /sys/devices/system/node/*/meminfo
    * cgroup v2: "anon" and "file_mapped" in "memory.stat" and
      "memory.numa_stat"
    * cgroup v1: "rss" and "mapped_file" in "memory.stat" and
      "memory.numa_stat

    ... can now appear higher than before. But note that these folios do
    consume that memory, simply not all pages are actually currently
    mapped.

    It's worth nothing that other accounting in the kernel (esp. cgroup
    charging on allocation) is not affected by this change.

    [why oh why is "anon" called "rss" in cgroup v1]

 (2) Detecting partial mappings

     Detecting whether anon THPs are partially mapped gets a bit more
     unreliable. As long as a single MM maps such a large folio
     ("exclusively mapped"), we can reliably detect it. Especially before
     fork() / after a short-lived child process quit, we will detect
     partial mappings reliably, which is the common case.

     In essence, if the average per-page mapcount in an anon THP is < 1,
     we know for sure that we have a partial mapping.

     However, as soon as multiple MMs are involved, we might miss detecting
     partial mappings: this might be relevant with long-lived child
     processes. If we have a fully-mapped anon folio before fork(), once
     our child processes and our parent all unmap (zap/COW) the same pages
     (but not the complete folio), we might not detect the partial mapping.
     However, once the child processes quit we would detect the partial
     mapping.

     How relevant this case is in practice remains to be seen.
     Swapout/migration will likely mitigate this.

     In the future, RMAP walkers could check for that for that case
     (e.g., when collecting access bits during reclaim) and simply flag
     them for deferred-splitting.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../admin-guide/cgroup-v1/memory.rst          |  4 +
 Documentation/admin-guide/cgroup-v2.rst       | 10 ++-
 Documentation/filesystems/proc.rst            | 10 ++-
 Documentation/mm/transhuge.rst                | 31 +++++--
 include/linux/rmap.h                          | 35 ++++++--
 mm/internal.h                                 |  5 +-
 mm/page_alloc.c                               |  3 +-
 mm/rmap.c                                     | 80 +++++++++++++++++--
 8 files changed, 150 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 286d16fc22ebb..53cf081b22e81 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -609,6 +609,10 @@ memory.stat file includes following statistics:
 
 	'rss + mapped_file" will give you resident set size of cgroup.
 
+	Note that some kernel configurations might account complete larger
+	allocations (e.g., THP) towards 'rss' and 'mapped_file', even if
+	only some, but not all that memory is mapped.
+
 	(Note: file and shmem may be shared among other cgroups. In that case,
 	mapped_file is accounted only when the memory cgroup is owner of page
 	cache.)
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 175e9435ad5c1..53ada5c2620a7 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1448,7 +1448,10 @@ The following nested keys are defined.
 
 	  anon
 		Amount of memory used in anonymous mappings such as
-		brk(), sbrk(), and mmap(MAP_ANONYMOUS)
+		brk(), sbrk(), and mmap(MAP_ANONYMOUS). Note that
+		some kernel configurations might account complete larger
+		allocations (e.g., THP) if only some, but not all the
+		memory of such an allocation is mapped anymore.
 
 	  file
 		Amount of memory used to cache filesystem data,
@@ -1491,7 +1494,10 @@ The following nested keys are defined.
 		Amount of application memory swapped out to zswap.
 
 	  file_mapped
-		Amount of cached filesystem data mapped with mmap()
+		Amount of cached filesystem data mapped with mmap(). Note
+		that some kernel configurations might account complete
+		larger allocations (e.g., THP) if only some, but not
+		not all the memory of such an allocation is mapped.
 
 	  file_dirty
 		Amount of cached filesystem data that was modified but
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index c9e62e8e0685e..3c37b248fc4f1 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1153,9 +1153,15 @@ Dirty
 Writeback
               Memory which is actively being written back to the disk
 AnonPages
-              Non-file backed pages mapped into userspace page tables
+              Non-file backed pages mapped into userspace page tables. Note that
+              some kernel configurations might consider all pages part of a
+              larger allocation (e.g., THP) as "mapped", as soon as a single
+              page is mapped.
 Mapped
-              files which have been mmapped, such as libraries
+              files which have been mmapped, such as libraries. Note that some
+              kernel configurations might consider all pages part of a larger
+              allocation (e.g., THP) as "mapped", as soon as a single page is
+              mapped.
 Shmem
               Total memory used by shared memory (shmem) and tmpfs
 KReclaimable
diff --git a/Documentation/mm/transhuge.rst b/Documentation/mm/transhuge.rst
index baa17d718a762..0e7f8e4cd2e33 100644
--- a/Documentation/mm/transhuge.rst
+++ b/Documentation/mm/transhuge.rst
@@ -116,23 +116,28 @@ pages:
     succeeds on tail pages.
 
   - map/unmap of a PMD entry for the whole THP increment/decrement
-    folio->_entire_mapcount, increment/decrement folio->_large_mapcount
-    and also increment/decrement folio->_nr_pages_mapped by ENTIRELY_MAPPED
-    when _entire_mapcount goes from -1 to 0 or 0 to -1.
+    folio->_entire_mapcount and folio->_large_mapcount.
 
     We also maintain the two slots for tracking MM owners (MM ID and
     corresponding mapcount), and the current status ("maybe mapped shared" vs.
     "mapped exclusively").
 
+    With CONFIG_PAGE_MAPCOUNT, we also increment/decrement
+    folio->_nr_pages_mapped by ENTIRELY_MAPPED when _entire_mapcount goes
+    from -1 to 0 or 0 to -1.
+
   - map/unmap of individual pages with PTE entry increment/decrement
-    page->_mapcount, increment/decrement folio->_large_mapcount and also
-    increment/decrement folio->_nr_pages_mapped when page->_mapcount goes
-    from -1 to 0 or 0 to -1 as this counts the number of pages mapped by PTE.
+    folio->_large_mapcount.
 
     We also maintain the two slots for tracking MM owners (MM ID and
     corresponding mapcount), and the current status ("maybe mapped shared" vs.
     "mapped exclusively").
 
+    With CONFIG_PAGE_MAPCOUNT, we also increment/decrement
+    page->_mapcount and increment/decrement folio->_nr_pages_mapped when
+    page->_mapcount goes from -1 to 0 or 0 to -1 as this counts the number
+    of pages mapped by PTE.
+
 split_huge_page internally has to distribute the refcounts in the head
 page to the tail pages before clearing all PG_head/tail bits from the page
 structures. It can be done easily for refcounts taken by page table
@@ -159,8 +164,8 @@ clear where references should go after split: it will stay on the head page.
 Note that split_huge_pmd() doesn't have any limitations on refcounting:
 pmd can be split at any point and never fails.
 
-Partial unmap and deferred_split_folio()
-========================================
+Partial unmap and deferred_split_folio() (anon THP only)
+========================================================
 
 Unmapping part of THP (with munmap() or other way) is not going to free
 memory immediately. Instead, we detect that a subpage of THP is not in use
@@ -175,3 +180,13 @@ a THP crosses a VMA boundary.
 The function deferred_split_folio() is used to queue a folio for splitting.
 The splitting itself will happen when we get memory pressure via shrinker
 interface.
+
+With CONFIG_PAGE_MAPCOUNT, we reliably detect partial mappings based on
+folio->_nr_pages_mapped.
+
+With CONFIG_NO_PAGE_MAPCOUNT, we detect partial mappings based on the
+average per-page mapcount in a THP: if the average is < 1, an anon THP is
+certainly partially mapped. As long as only a single process maps a THP,
+this detection is reliable. With long-running child processes, there can
+be scenarios where partial mappings can currently not be detected, and
+might need asynchronous detection during memory reclaim in the future.
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index c131b0efff0fa..6b82b618846ee 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -240,7 +240,7 @@ static __always_inline void folio_set_large_mapcount(struct folio *folio,
 	folio_set_mm_id(folio, 0, vma->vm_mm->mm_id);
 }
 
-static __always_inline void folio_add_large_mapcount(struct folio *folio,
+static __always_inline int folio_add_return_large_mapcount(struct folio *folio,
 		int diff, struct vm_area_struct *vma)
 {
 	const mm_id_t mm_id = vma->vm_mm->mm_id;
@@ -286,9 +286,11 @@ static __always_inline void folio_add_large_mapcount(struct folio *folio,
 		folio->_mm_ids |= FOLIO_MM_IDS_SHARED_BIT;
 	}
 	folio_unlock_large_mapcount(folio);
+	return new_mapcount_val + 1;
 }
+#define folio_add_large_mapcount folio_add_return_large_mapcount
 
-static __always_inline void folio_sub_large_mapcount(struct folio *folio,
+static __always_inline int folio_sub_return_large_mapcount(struct folio *folio,
 		int diff, struct vm_area_struct *vma)
 {
 	const mm_id_t mm_id = vma->vm_mm->mm_id;
@@ -331,7 +333,9 @@ static __always_inline void folio_sub_large_mapcount(struct folio *folio,
 		folio->_mm_ids &= ~FOLIO_MM_IDS_SHARED_BIT;
 out:
 	folio_unlock_large_mapcount(folio);
+	return new_mapcount_val + 1;
 }
+#define folio_sub_large_mapcount folio_sub_return_large_mapcount
 #else /* !CONFIG_MM_ID */
 /*
  * See __folio_rmap_sanity_checks(), we might map large folios even without
@@ -350,17 +354,33 @@ static inline void folio_add_large_mapcount(struct folio *folio,
 	atomic_add(diff, &folio->_large_mapcount);
 }
 
+static inline int folio_add_return_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	BUILD_BUG();
+}
+
 static inline void folio_sub_large_mapcount(struct folio *folio,
 		int diff, struct vm_area_struct *vma)
 {
 	atomic_sub(diff, &folio->_large_mapcount);
 }
+
+static inline int folio_sub_return_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	BUILD_BUG();
+}
 #endif /* CONFIG_MM_ID */
 
 #define folio_inc_large_mapcount(folio, vma) \
 	folio_add_large_mapcount(folio, 1, vma)
+#define folio_inc_return_large_mapcount(folio, vma) \
+	folio_add_return_large_mapcount(folio, 1, vma)
 #define folio_dec_large_mapcount(folio, vma) \
 	folio_sub_large_mapcount(folio, 1, vma)
+#define folio_dec_return_large_mapcount(folio, vma) \
+	folio_sub_return_large_mapcount(folio, 1, vma)
 
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
@@ -538,9 +558,11 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 			break;
 		}
 
-		do {
-			atomic_inc(&page->_mapcount);
-		} while (page++, --nr_pages > 0);
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
+			do {
+				atomic_inc(&page->_mapcount);
+			} while (page++, --nr_pages > 0);
+		}
 		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
@@ -638,7 +660,8 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 		do {
 			if (PageAnonExclusive(page))
 				ClearPageAnonExclusive(page);
-			atomic_inc(&page->_mapcount);
+			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+				atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
 		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
diff --git a/mm/internal.h b/mm/internal.h
index e33a1fc5ed667..bbedb49f18230 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -84,6 +84,8 @@ void page_writeback_init(void);
  */
 static inline int folio_nr_pages_mapped(const struct folio *folio)
 {
+	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT))
+		return -1;
 	return atomic_read(&folio->_nr_pages_mapped) & FOLIO_PAGES_MAPPED;
 }
 
@@ -719,7 +721,8 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 
 	folio_set_order(folio, order);
 	atomic_set(&folio->_large_mapcount, -1);
-	atomic_set(&folio->_nr_pages_mapped, 0);
+	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+		atomic_set(&folio->_nr_pages_mapped, 0);
 	if (IS_ENABLED(CONFIG_MM_ID)) {
 		folio->_mm_ids = 0;
 		folio->_mm_id_mapcount[0] = -1;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e3b8bfdd0b756..bd65ff649c115 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -955,7 +955,8 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero large_mapcount");
 			goto out;
 		}
-		if (unlikely(atomic_read(&folio->_nr_pages_mapped))) {
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT) &&
+		    unlikely(atomic_read(&folio->_nr_pages_mapped))) {
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 8de415157bc8d..67bb273dfb80d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1258,6 +1258,16 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 			break;
 		}
 
+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
+			nr = folio_add_return_large_mapcount(folio, orig_nr_pages, vma);
+			if (nr == orig_nr_pages)
+				/* Was completely unmapped. */
+				nr = folio_large_nr_pages(folio);
+			else
+				nr = 0;
+			break;
+		}
+
 		do {
 			first += atomic_inc_and_test(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
@@ -1271,6 +1281,18 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
 		first = atomic_inc_and_test(&folio->_entire_mapcount);
+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
+			if (level == RMAP_LEVEL_PMD && first)
+				*nr_pmdmapped = folio_large_nr_pages(folio);
+			nr = folio_inc_return_large_mapcount(folio, vma);
+			if (nr == 1)
+				/* Was completely unmapped. */
+				nr = folio_large_nr_pages(folio);
+			else
+				nr = 0;
+			break;
+		}
+
 		if (first) {
 			nr = atomic_add_return_relaxed(ENTIRELY_MAPPED, mapped);
 			if (likely(nr < ENTIRELY_MAPPED + ENTIRELY_MAPPED)) {
@@ -1436,13 +1458,23 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 			break;
 		}
 	}
+
+	VM_WARN_ON_FOLIO(!folio_test_large(folio) && PageAnonExclusive(page) &&
+			 atomic_read(&folio->_mapcount) > 0, folio);
 	for (i = 0; i < nr_pages; i++) {
 		struct page *cur_page = page + i;
 
-		/* While PTE-mapping a THP we have a PMD and a PTE mapping. */
-		VM_WARN_ON_FOLIO((atomic_read(&cur_page->_mapcount) > 0 ||
-				  (folio_test_large(folio) &&
-				   folio_entire_mapcount(folio) > 1)) &&
+		VM_WARN_ON_FOLIO(folio_test_large(folio) &&
+				 folio_entire_mapcount(folio) > 1 &&
+				 PageAnonExclusive(cur_page), folio);
+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT))
+			continue;
+
+		/*
+		 * While PTE-mapping a THP we have a PMD and a PTE
+		 * mapping.
+		 */
+		VM_WARN_ON_FOLIO(atomic_read(&cur_page->_mapcount) > 0 &&
 				 PageAnonExclusive(cur_page), folio);
 	}
 
@@ -1548,20 +1580,23 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 		for (i = 0; i < nr; i++) {
 			struct page *page = folio_page(folio, i);
 
-			/* increment count (starts at -1) */
-			atomic_set(&page->_mapcount, 0);
+			if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+				/* increment count (starts at -1) */
+				atomic_set(&page->_mapcount, 0);
 			if (exclusive)
 				SetPageAnonExclusive(page);
 		}
 
 		folio_set_large_mapcount(folio, nr, vma);
-		atomic_set(&folio->_nr_pages_mapped, nr);
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+			atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
 		nr = folio_large_nr_pages(folio);
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
 		folio_set_large_mapcount(folio, 1, vma);
-		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+			atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
 		nr_pmdmapped = nr;
@@ -1665,6 +1700,19 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
+			nr = folio_sub_return_large_mapcount(folio, nr_pages, vma);
+			if (!nr) {
+				/* Now completely unmapped. */
+				nr = folio_nr_pages(folio);
+			} else {
+				partially_mapped = nr < folio_large_nr_pages(folio) &&
+						   !folio_entire_mapcount(folio);
+				nr = 0;
+			}
+			break;
+		}
+
 		folio_sub_large_mapcount(folio, nr_pages, vma);
 		do {
 			last += atomic_add_negative(-1, &page->_mapcount);
@@ -1678,6 +1726,22 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
+		if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
+			last = atomic_add_negative(-1, &folio->_entire_mapcount);
+			if (level == RMAP_LEVEL_PMD && last)
+				nr_pmdmapped = folio_large_nr_pages(folio);
+			nr = folio_dec_return_large_mapcount(folio, vma);
+			if (!nr) {
+				/* Now completely unmapped. */
+				nr = folio_large_nr_pages(folio);
+			} else {
+				partially_mapped = last &&
+						   nr < folio_large_nr_pages(folio);
+				nr = 0;
+			}
+			break;
+		}
+
 		folio_dec_large_mapcount(folio, vma);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
-- 
2.48.1


