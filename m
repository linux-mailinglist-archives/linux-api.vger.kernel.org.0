Return-Path: <linux-api+bounces-3361-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C9A4C814
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB6DD7A2EDF
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8788924F5A9;
	Mon,  3 Mar 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSa65h/K"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFBAF24DFF5
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019451; cv=none; b=NTpwNuwxuYZJSuhLHxn1qddGgQsa2t0dxCPL7cN4KWrgMoeGsNy22wgc657i6Nd8UywYX16yV82PMz/T7CgH6p5oQ6BDKVwQyq9R+RMVGcZKfGUz5AjXXsCBk3Q9ycLNlHpa4EcIte0HjnIhBu1KJNqGOVZ2/TLvwnFCUbWpg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019451; c=relaxed/simple;
	bh=jBMc/6KfiUuhsqx8U3JCMjpv5FKb+tGdfD4lU0RajKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKJFL3CrA7uChdlaGf4RR7zuLH4qZQg74mFqNziGGrRJdUgc38KxQxMgPtuueS/cw0xJyu+I3uUxAhKCCEQMAdpgtIBQoKz+bWZlPFIoFcuNCwFmURHAcU37kyd2UtHCFCjR42zd8dsMaNITYF2bFwXoy8HAWaYamO3QCM3s3U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSa65h/K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
	b=TSa65h/KOfmX2yvRc2Q7tXT2xciU/JKKIfzSp5MgNfy3z/I32ve4UqUcKiBMu3UeW08zK9
	G1g495jtuTuU0V3+9uBBl0geCQ7QvHR+XlkxcpzvdHqRUFQ2iVkElCc542XMvJ+UK0bhbz
	FNKsS2iipYq6Z1FfvfhkgT8m+AD0lQw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-kVEsb9R-N9uYucnNAukG-g-1; Mon, 03 Mar 2025 11:30:36 -0500
X-MC-Unique: kVEsb9R-N9uYucnNAukG-g-1
X-Mimecast-MFC-AGG-ID: kVEsb9R-N9uYucnNAukG-g_1741019436
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43aafafe6b7so33248145e9.1
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019436; x=1741624236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWnUBbJbNal4OtQP6KylSC1HMhJkWgV+LTGJMK3tR3E=;
        b=niLiPQ771kTUUiADS4xr0SXsA/RyUhU4Lzor27ulMoSqu+2FKEvu70j0N/vzUvSWOX
         g4bRrHU8pPrHfw9K7AtwqWBxD3bo1dBaKGketDW6cJEUhl1n1YhHJ7Nr13C6L58WawBV
         BABzSxZZuJNpHHUV8vt20IOK06iiurOjv+TCg2Sn8rseWGd+FGFl80vxPBvDps3E3MuQ
         qpa3Lr/iIzRBvNFHtHMhzGyBz9A23GkKbosdfMf5zhemV8884EgTL3Rdg2JbNaki9ogd
         F7p+7u0nvXeBYB3KdxkwGyEmyv+8CjkAETaq3ieI1MPgFEyk/s3rvsFzw61Ovsxq8TkD
         kHag==
X-Forwarded-Encrypted: i=1; AJvYcCWg4rjxakiwJ9ozex3kVsxdKiN2EbvU2IW4qOVHLmjIFPRnMF3xjUiA90kySq0okG5y85uwyMWU65w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEt1SxuqEQJDdkJR8OocQGKtlWFLnvjJiT1MF0t4mc57p2mKQ5
	7H5CUZV0zx9S3Q6P+WEhCr1Et+aIskFy4iF0REXPzqYd5/j6Q46T0JgFVlawT1sQFB6QfeU2gpM
	HYi7UnHRpCRtMRzRaz4oAdvJT1l/KSJ36HV33JwwPzjZcx2kdveV7XPPHQTAx2SVfQL7I
X-Gm-Gg: ASbGncsspbB9JlAnGiB3klaA7mxvsapqcH0ALtyUP0AqEIk3vaOD4D2hFjixQYaKNvC
	95qxsQlpL1hFcfxMl3lZHWVmgUQtQGrDsXc94Q1WnvJ0YDWkVW+wa0sL7O+RrtacHe/DGkPUyO2
	CBCgVR3VJ2gL9b3+RHKSc2kXJwt3GoX0+sIdwiNWKkKUZDnKNuT6ZbWD3AN/ZVogNYOeNXLb3FS
	yZx9nvANT2ncfFxotr2dDAK3IueDaEDgJUauXf+ZBTMGtOKwdIWPvG7zetijiQwm0LTj40y2SuP
	3WADu0zqZAWzru4tCnHonaAlo76eVb7FjrsFGhiC346GhczkPHVZVO6GsCsCkI5TqyHpIYFl/rK
	Y
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-43ba6710a51mr128366365e9.17.1741019435402;
        Mon, 03 Mar 2025 08:30:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHH2uqcGG6+HqLvILt026VDKtCx0hMTXydneDmvGOTb2RHDZET1RLo/ABtW5TIvoZEd6mWJw==
X-Received: by 2002:a05:600c:19c7:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-43ba6710a51mr128365725e9.17.1741019434989;
        Mon, 03 Mar 2025 08:30:34 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc63877desm18077035e9.1.2025.03.03.08.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:33 -0800 (PST)
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
Subject: [PATCH v3 08/20] mm/rmap: pass vma to __folio_add_rmap()
Date: Mon,  3 Mar 2025 17:30:01 +0100
Message-ID: <20250303163014.1128035-9-david@redhat.com>
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

We'll need access to the destination MM when modifying the mapcount
large folios next. So pass in the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/rmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index bcec8677f68df..8a7d023b02e0c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1242,8 +1242,8 @@ int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 }
 
 static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
-		struct page *page, int nr_pages, enum rmap_level level,
-		int *nr_pmdmapped)
+		struct page *page, int nr_pages, struct vm_area_struct *vma,
+		enum rmap_level level, int *nr_pmdmapped)
 {
 	atomic_t *mapped = &folio->_nr_pages_mapped;
 	const int orig_nr_pages = nr_pages;
@@ -1411,7 +1411,7 @@ static __always_inline void __folio_add_anon_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 
 	if (likely(!folio_test_ksm(folio)))
 		__page_check_anon_rmap(folio, page, vma, address);
@@ -1582,7 +1582,7 @@ static __always_inline void __folio_add_file_rmap(struct folio *folio,
 
 	VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
 
-	nr = __folio_add_rmap(folio, page, nr_pages, level, &nr_pmdmapped);
+	nr = __folio_add_rmap(folio, page, nr_pages, vma, level, &nr_pmdmapped);
 	__folio_mod_stat(folio, nr, nr_pmdmapped);
 
 	/* See comments in folio_add_anon_rmap_*() */
-- 
2.48.1


