Return-Path: <linux-api+bounces-3301-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF65A42897
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 18:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6663AF811
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF2265CA3;
	Mon, 24 Feb 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUFrNSqU"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D50C264FBC
	for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416181; cv=none; b=CyymHp7l1l9olxfzjTrewssPdJWToiEYdSSXSIwcLS6g1w2vc2efmUAqD1KAdtDrgGRWE8iXjUKLv5sQ7q+iQl8YcrDw6RzuVuo2fPnqPwGwnI9waW7g4d8CVzIdOPM8NGp9n5a8mO1ZqM03CJA3GeDEQbFJkGRBG7P/OgbvcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416181; c=relaxed/simple;
	bh=jCFgdCkbqHJ9MbrS7XN0TCcs0JBnjj+yrJRy9PI9wEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjZDV1pVKTbdBB5DALzorrtMslYbOcy0dS6Y5PWRYD386913GMO2Gm8Wy91hD81PNNcyguIsM0oRvQuOHpmDTHLDoBGA6FdNs4p033ndSy/ue+6KDYHSc2JRpkMX+FFVoSD4U8uDPld+o3h4syW6JSl3AIWDv42LytDGeaXMvWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUFrNSqU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9Kk0sDLIOZEo9TGeBWuftLWUgUisx0QoodxZudqT8w=;
	b=GUFrNSqUsiT69fUQf+fECNE0yCzGRR4/XN9TUZQUpwOxawNz/Q8uF60Rq9jyd0bCqwjc43
	xUzgyJFGFBkt2JtIfN5QOw8RRdG/ukgR43gir+d8GvIsjQ0sWvOj28eRbMJkE4ZshNHnmI
	PzWh57NOjCNTclvYQig+EdYOHbVV+wM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-fc-kbGN4NzuWD35LQZH2aQ-1; Mon, 24 Feb 2025 11:56:17 -0500
X-MC-Unique: fc-kbGN4NzuWD35LQZH2aQ-1
X-Mimecast-MFC-AGG-ID: fc-kbGN4NzuWD35LQZH2aQ_1740416176
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4399d2a1331so22851405e9.1
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 08:56:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416176; x=1741020976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9Kk0sDLIOZEo9TGeBWuftLWUgUisx0QoodxZudqT8w=;
        b=PXm5yxEfDZRfZwF1cqJ8t6R7bbUQ1y+FIrSImoj+IwNg1Bh/G8p+VFvxf9vru9X5F7
         XgK/5sgfAoVJ4Gf38AxkUX79GTccbx6ULSWwdczp112zoEDGFY+ocFI1JCWHsWGfNCTk
         IJOfMCoNZq6ubc7NEN/OR5x3EmEidpNDBVymKEO7C+ssYNQGGK/0IxdfEX8JFBeyrzAY
         EteSKFPLbWpznKQr6ssrXGUTEW27yof3xZgCVQW+WvQ8JujWJE6lz8RJI5Gzotxv+Kne
         u50aiNe+lJ0HFBMyKt3oWK5qlxY/vpdKlZmI5vlM7VuCV5UYmxhLbjBXe0zyhCFiOUNC
         XNLg==
X-Forwarded-Encrypted: i=1; AJvYcCV3z2ujcsD4JO9kR4tUvDpzbblAilPq88Ta1uyUEAnNDYQgaZssWAsFJgsuPFpSmsDnpxsVU5D+188=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDvgMXNFCzJzvwqlzHYtPr9lz79fq5fS9HXfBT8ZxhfKufbJ2/
	lxvri1k9YI0ObqrrXyS5b/LZw3hhU3ei7ldyiwRBBqwzJkqQZoYLR3VD22tGMZXQtoJioTAE/XL
	eMoYZNwCkpLRGUobcSYMrNBUdZSOx8iT3d6Z8Aa4LJm5ySkXFl8nQIqB27w==
X-Gm-Gg: ASbGncvEeVYsGemdPZdm2hTT844lP/QTdiYP84UodnYV31kfCJQ5x8WkR4Ww+wr+XVq
	OAWW7UswssHxReKz+mOa3NHk4UHHYOt0U0fqtULSe2hBc/KjLon3LgeF72HkedA+S/eXQBvaXF+
	I+tPE07+9L+lij/XWi9ZQYYfZuwaZ6UxfRgt+SDFTDdnwmdrsWLnxU3qxNLYysrNgsA9u9DCjKK
	CYDmo9xYF/FpEHkwqcdBYIRKaOgM8rhe6Zg4GGQxfpslTlprq7GHcNR5t3t90/NYkdIpJeDR0AY
	e20GqNi5fOPDHSgtGJ/CjNajOqP+vYI1C8w5fHDFPA==
X-Received: by 2002:a05:600c:5949:b0:439:8345:17a6 with SMTP id 5b1f17b1804b1-439a30d38e9mr130585585e9.12.1740416176150;
        Mon, 24 Feb 2025 08:56:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy0+PSAOTGdTFyYGF1ZzYS11kOEi6LhvuqHcevrUwSSRUG4LJeLXU4Rq4oj/c975sX5HkQ4A==
X-Received: by 2002:a05:600c:5949:b0:439:8345:17a6 with SMTP id 5b1f17b1804b1-439a30d38e9mr130585275e9.12.1740416175731;
        Mon, 24 Feb 2025 08:56:15 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b02ce404sm113163905e9.7.2025.02.24.08.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:15 -0800 (PST)
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
Subject: [PATCH v2 05/20] mm: move _pincount in folio to page[2] on 32bit
Date: Mon, 24 Feb 2025 17:55:47 +0100
Message-ID: <20250224165603.1434404-6-david@redhat.com>
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

Let's free up some space on 32bit in page[1] by moving the _pincount to
page[2].

For order-1 folios (never anon folios!) on 32bit, we will now also use the
GUP_PIN_COUNTING_BIAS approach. A fully-mapped order-1 folio requires
2 references. With GUP_PIN_COUNTING_BIAS being 1024, we'd detect such
folios as "maybe pinned" with 512 full mappings, instead of 1024 for
order-0. As anon folios are out of the picture (which are the most relevant
users of checking for pinnings on *mapped* pages) and we are talking about
32bit, this is not expected to cause any trouble.

In __dump_page(), copy one additional folio page if we detect a folio
with an order > 1, so we can dump the pincount on order > 1 folios
reliably.

Note that THPs on 32bit are not particularly common (and we don't care
too much about performance), but we want to keep it working reliably,
because likely we want to use large folios there as well in the future,
independent of PMD leaf support.

Once we dynamically allocate "struct folio", fortunately the 32bit
specifics will likely go away again; even small folios could then have a
pincount and folio_has_pincount() would essentially always return
"true".

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 11 +++++++++--
 include/linux/mm_types.h |  5 +++++
 mm/debug.c               | 10 +++++++++-
 mm/gup.c                 |  8 ++++----
 mm/internal.h            |  3 ++-
 mm/page_alloc.c          | 14 +++++++++++---
 6 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6b6373a864dd..1a4ee028a851e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2004,6 +2004,13 @@ static inline struct folio *pfn_folio(unsigned long pfn)
 	return page_folio(pfn_to_page(pfn));
 }
 
+static inline bool folio_has_pincount(const struct folio *folio)
+{
+	if (IS_ENABLED(CONFIG_64BIT))
+		return folio_test_large(folio);
+	return folio_order(folio) > 1;
+}
+
 /**
  * folio_maybe_dma_pinned - Report if a folio may be pinned for DMA.
  * @folio: The folio.
@@ -2020,7 +2027,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  * get that many refcounts, and b) all the callers of this routine are
  * expected to be able to deal gracefully with a false positive.
  *
- * For large folios, the result will be exactly correct. That's because
+ * For most large folios, the result will be exactly correct. That's because
  * we have more tracking data available: the _pincount field is used
  * instead of the GUP_PIN_COUNTING_BIAS scheme.
  *
@@ -2031,7 +2038,7 @@ static inline struct folio *pfn_folio(unsigned long pfn)
  */
 static inline bool folio_maybe_dma_pinned(struct folio *folio)
 {
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		return atomic_read(&folio->_pincount) > 0;
 
 	/*
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 1d9c68c551d42..31f466d8485bc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -387,7 +387,9 @@ struct folio {
 					atomic_t _large_mapcount;
 					atomic_t _entire_mapcount;
 					atomic_t _nr_pages_mapped;
+#ifdef CONFIG_64BIT
 					atomic_t _pincount;
+#endif /* CONFIG_64BIT */
 				};
 				unsigned long _usable_1[4];
 			};
@@ -406,6 +408,9 @@ struct folio {
 			unsigned long _head_2;
 	/* public: */
 			struct list_head _deferred_list;
+#ifndef CONFIG_64BIT
+			atomic_t _pincount;
+#endif /* !CONFIG_64BIT */
 	/* private: the union with struct page is transitional */
 		};
 		struct page __page_2;
diff --git a/mm/debug.c b/mm/debug.c
index 2d1bd67d957bc..83ef3bd0ccd32 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -79,12 +79,17 @@ static void __dump_folio(struct folio *folio, struct page *page,
 			folio_ref_count(folio), mapcount, mapping,
 			folio->index + idx, pfn);
 	if (folio_test_large(folio)) {
+		int pincount = 0;
+
+		if (folio_has_pincount(folio))
+			pincount = atomic_read(&folio->_pincount);
+
 		pr_warn("head: order:%u mapcount:%d entire_mapcount:%d nr_pages_mapped:%d pincount:%d\n",
 				folio_order(folio),
 				folio_mapcount(folio),
 				folio_entire_mapcount(folio),
 				folio_nr_pages_mapped(folio),
-				atomic_read(&folio->_pincount));
+				pincount);
 	}
 
 #ifdef CONFIG_MEMCG
@@ -146,6 +151,9 @@ static void __dump_page(const struct page *page)
 	if (idx < MAX_FOLIO_NR_PAGES) {
 		memcpy(&folio, foliop, 2 * sizeof(struct page));
 		nr_pages = folio_nr_pages(&folio);
+		if (nr_pages > 1)
+			memcpy(&folio.__page_2, &foliop->__page_2,
+			       sizeof(struct page));
 		foliop = &folio;
 	}
 
diff --git a/mm/gup.c b/mm/gup.c
index e5040657870ea..2944fe8cf3174 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -109,7 +109,7 @@ static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
 		if (is_zero_folio(folio))
 			return;
 		node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
-		if (folio_test_large(folio))
+		if (folio_has_pincount(folio))
 			atomic_sub(refs, &folio->_pincount);
 		else
 			refs *= GUP_PIN_COUNTING_BIAS;
@@ -164,7 +164,7 @@ int __must_check try_grab_folio(struct folio *folio, int refs,
 		 * Increment the normal page refcount field at least once,
 		 * so that the page really is pinned.
 		 */
-		if (folio_test_large(folio)) {
+		if (folio_has_pincount(folio)) {
 			folio_ref_add(folio, refs);
 			atomic_add(refs, &folio->_pincount);
 		} else {
@@ -223,7 +223,7 @@ void folio_add_pin(struct folio *folio)
 	 * page refcount field at least once, so that the page really is
 	 * pinned.
 	 */
-	if (folio_test_large(folio)) {
+	if (folio_has_pincount(folio)) {
 		WARN_ON_ONCE(atomic_read(&folio->_pincount) < 1);
 		folio_ref_inc(folio);
 		atomic_inc(&folio->_pincount);
@@ -575,7 +575,7 @@ static struct folio *try_grab_folio_fast(struct page *page, int refs,
 	 * is pinned.  That's why the refcount from the earlier
 	 * try_get_folio() is left intact.
 	 */
-	if (folio_test_large(folio))
+	if (folio_has_pincount(folio))
 		atomic_add(refs, &folio->_pincount);
 	else
 		folio_ref_add(folio,
diff --git a/mm/internal.h b/mm/internal.h
index 7f6d5def00fa0..d33db24c8b17b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -723,7 +723,8 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_large_mapcount, -1);
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
-	atomic_set(&folio->_pincount, 0);
+	if (IS_ENABLED(CONFIG_64BIT) || order > 1)
+		atomic_set(&folio->_pincount, 0);
 	if (order > 1)
 		INIT_LIST_HEAD(&folio->_deferred_list);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 05a2a9492cdb0..3dff99cc54161 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -959,9 +959,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "nonzero nr_pages_mapped");
 			goto out;
 		}
-		if (unlikely(atomic_read(&folio->_pincount))) {
-			bad_page(page, "nonzero pincount");
-			goto out;
+		if (IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
 		}
 		break;
 	case 2:
@@ -970,6 +972,12 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			bad_page(page, "on deferred list");
 			goto out;
 		}
+		if (!IS_ENABLED(CONFIG_64BIT)) {
+			if (unlikely(atomic_read(&folio->_pincount))) {
+				bad_page(page, "nonzero pincount");
+				goto out;
+			}
+		}
 		break;
 	case 3:
 		/* the third tail page: hugetlb specifics overlap ->mappings */
-- 
2.48.1


