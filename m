Return-Path: <linux-api+bounces-3359-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F5A4C7ED
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EAF27AD960
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01923247DF0;
	Mon,  3 Mar 2025 16:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HbjVFLID"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD3A24395E
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019445; cv=none; b=K0S/uzI9mzUmWh6koNsEa9fhZPV4oav+YhJDvAQo8pQr1dn1zRp0wz4sElmKBao4A4bV4t1rdM3hOsho/uk49iJQYAmwwPCeT91gv/oX0wVSpu6En7ZYFrTmvhAMQHxYiUBB1gnBNX9aaaOZoiSDCrVB2k5TyD9+l/prNXo4/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019445; c=relaxed/simple;
	bh=8JZSTfKBKXDMVjBypXt5216219IvKwBRt9fqFMOGvw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsR4/oHUar6S5cRJkJhhwQlNdDxmE98eqctmVd0rw+YU74joa5SKxWrdYq4Ii6Sv+OBNUYkoR3Thsg5y+WBuY94SQhGLCGJMxYF4Q3H4QePYt34vQ/p+1EDZM2ujexq8jV3yiNMmvOEeAx3E8fZ4ZI/2pav682Kw4woPbP+ixjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HbjVFLID; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CNQID9OyUlmGzlaLMJyJN9WCGZqSjZdKvQcCGQkCwE=;
	b=HbjVFLID8O/IONFsfqLHpRhqPZHuDZeO/EyE0Q57dplUmWGSCYDaSaoBeWQQ9Tws/xHg3A
	oIzFEgqVTBInFug+GNbkq7U9hdGfy9ou+ge9WgP3oMfjCWJXpHJsVkYG3/qlPyc8AvhZq4
	e11KlWZl/4N/ARG+4L7hkOsXS8v26o8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-kLJiytxWO3qLLeviUpzESA-1; Mon, 03 Mar 2025 11:30:31 -0500
X-MC-Unique: kLJiytxWO3qLLeviUpzESA-1
X-Mimecast-MFC-AGG-ID: kLJiytxWO3qLLeviUpzESA_1741019430
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bc97e6360so2141175e9.3
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:30:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019430; x=1741624230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CNQID9OyUlmGzlaLMJyJN9WCGZqSjZdKvQcCGQkCwE=;
        b=GIRefP+pz+pbpCD8sEDQN4mlmCDUVk1oVPJ5NhGcX4FMFTQBzWmBLTaSOkWrtWHKY0
         KNa59IOjdCiA7mXNW6SXm/nL22b/jUwhrSSvcQ8f3KkpCv7elcWsg8s0Ubr6Z1kvI5J1
         9RipvbjTGl4SRQVH3cSgZ8xmHiarvC8UF6yqdwmAUi0cQ9c1IQJqtHu5UM6oaByb2ynL
         dtZNyRqBIEzSbT+NJkDp6TQEUArVceHY+wIcR6/U6s4/W3ba+vyqEIUXBBkN/cK+y8P+
         ZN4EZEqQxJnZmG4MUyDNPbH+eHPr8uCNe0fjS+f/ZcqTucARFugBioJ/mHsqgl6B1SLs
         4GNA==
X-Forwarded-Encrypted: i=1; AJvYcCVQAOIKFkMnAoOOhM9kM6sowYcK47ROJ5XWpiWMiV6nNQ6mGwEKjKSwU8oUSOrlC1tWbrxgTx0c7qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3VMP4ahinkmSUNSkpm0JN7A2Km7PENR2DHsM3Wl9Efgu/0FTP
	5hixeiDAtV3TXkwR0Ad28bHAu7RV74RA+GRJJ2aRCXdR6phmzlNjGAGDlDwzEIY8tSvM+u/9C70
	lw9pmmkOgQwjucwtDSVT2GKE7ZuQvpnvtH4orCLyNwjqvfRYSKTWCVJXS6g==
X-Gm-Gg: ASbGncuTgKwBuL0IMeYO8dVuVmPngR7LQSCey/FED7fb/Rrf3sgPCRuEq3b5AKXjFRX
	GY2IRAeA1wRA9l7esjvxl8qWOCxjCkEhcyZd/6Ll4dr0cR0Altkl5p3UHGTya+druOS4JOUnALF
	SEliNwABDfvDsXcWaabxMDmsZEf+FjEWF8gDgZckmj91Ap2HU2OwJ2aJP/lekRMe4FEN+k7vds6
	PS0CCWW1E6PUfk236/VNUxy0qKKYn3PhT7x1r2hCsF8sWz+PsbAxkaRhJvr/A7sKSq+Hfy8S3tk
	qK4ySQgR8kwL03rCXPhh1T4Qd/w75p3QJZRSFmrht54iEosI+HBhulYZatdxsNLsZLiNMNxAsCJ
	6
X-Received: by 2002:a5d:6da3:0:b0:38d:e48b:1766 with SMTP id ffacd0b85a97d-390ec7c67c4mr11859514f8f.6.1741019430362;
        Mon, 03 Mar 2025 08:30:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRquSNZRyjpwgx3Bpqn4SKjwIglVAovJ799aL6PA2lqrvYWWUmjvtNcaSqxs0FHQnHdYBh0w==
X-Received: by 2002:a5d:6da3:0:b0:38d:e48b:1766 with SMTP id ffacd0b85a97d-390ec7c67c4mr11859482f8f.6.1741019430024;
        Mon, 03 Mar 2025 08:30:30 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc4478f70sm23988695e9.0.2025.03.03.08.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:29 -0800 (PST)
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
Subject: [PATCH v3 06/20] mm: move _entire_mapcount in folio to page[2] on 32bit
Date: Mon,  3 Mar 2025 17:29:59 +0100
Message-ID: <20250303163014.1128035-7-david@redhat.com>
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

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

Ordinary folios only use the entire mapcount with PMD mappings, so
order-1 folios don't apply. Similarly, hugetlb folios are always larger
than order-1, turning the entire mapcount essentially unused for all
order-1 folios. Moving it to order-1 folios will not change anything.

On 32bit, simply check in folio_entire_mapcount() whether we have an
order-1 folio, and return 0 in that case.

Note that THPs on 32bit are not particularly common (and we don't care
too much about performance), but we want to keep it working reliably,
because likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", the 32bit specifics will go
away again; even small folios could then have a pincount.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       |  2 ++
 include/linux/mm_types.h |  3 ++-
 mm/internal.h            |  5 +++--
 mm/page_alloc.c          | 12 ++++++++----
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c1414491c0de2..53dd4f99fdabc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1333,6 +1333,8 @@ static inline int is_vmalloc_or_module_addr(const void *x)
 static inline int folio_entire_mapcount(const struct folio *folio)
 {
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	if (!IS_ENABLED(CONFIG_64BIT) && unlikely(folio_large_order(folio) == 1))
+		return 0;
 	return atomic_read(&folio->_entire_mapcount) + 1;
 }
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 31f466d8485bc..c83dd2f1ee25e 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -385,9 +385,9 @@ struct folio {
 			union {
 				struct {
 					atomic_t _large_mapcount;
-					atomic_t _entire_mapcount;
 					atomic_t _nr_pages_mapped;
 #ifdef CONFIG_64BIT
+					atomic_t _entire_mapcount;
 					atomic_t _pincount;
 #endif /* CONFIG_64BIT */
 				};
@@ -409,6 +409,7 @@ struct folio {
 	/* public: */
 			struct list_head _deferred_list;
 #ifndef CONFIG_64BIT
+			atomic_t _entire_mapcount;
 			atomic_t _pincount;
 #endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
diff --git a/mm/internal.h b/mm/internal.h
index 378464246f259..9860e65ffc945 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -719,10 +719,11 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 
 	folio_set_order(folio, order);
 	atomic_set(&folio->_large_mapcount, -1);
-	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1) {
 		atomic_set(&folio->_pincount, 0);
+		atomic_set(&folio->_entire_mapcount, -1);
+	}
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 594a552c735cd..b0739baf7b07f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -951,10 +951,6 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 	switch (page - head_page) {
 	case 1:
 		/* the first tail page: these may be in place of ->mapping */
-		if (unlikely(folio_entire_mapcount(folio))) {
-			bad_page(page, "nonzero entire_mapcount");
-			goto out;
-		}
 		if (unlikely(folio_large_mapcount(folio))) {
 			bad_page(page, "nonzero large_mapcount");
 			goto out;
@@ -964,6 +960,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		if (IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
+				bad_page(page, "nonzero entire_mapcount");
+				goto out;
+			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;
@@ -977,6 +977,10 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		if (!IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_entire_mapcount) + 1)) {
+				bad_page(page, "nonzero entire_mapcount");
+				goto out;
+			}
 			if (unlikely(atomic_read(&folio->_pincount))) {
 				bad_page(page, "nonzero pincount");
 				goto out;
-- 
2.48.1


