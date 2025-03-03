Return-Path: <linux-api+bounces-3373-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0BEA4C7F6
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB32173DF5
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177D125DB18;
	Mon,  3 Mar 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2RU8Unv"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AB25D8FA
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019474; cv=none; b=H4+mHRcMFW+ExkSQ9hTbg5wiqx4fhQa0fehjTToBL/aAsqG/RIFlvC00DGy808Zzm9tL7cMORcl0ELPM3C7nO2JwTO4jB64I7nFeaZurT6BS48E46cgjDy6oBbfq0G5YfJseo5PynbVpuW/0R+Fu3Nq74jh+XL26WXZdjhUvARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019474; c=relaxed/simple;
	bh=67PK8pUQYPqYlMZHYSLo+XzRkAgj9tRIuRjTWNQ3VlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCwqza6Vg80UsD8rmRQZfTUI2u3olumCl1m89TnuHPk1OuCup6ND/aqeNm3RlPu/W5zqFyShND7f/M6zh1m1fPXOJREmyBQFzCaoQrOhwfmEKe2U+9j34vm0mwaVDLUhQCxJyiPWEyEvb1eZQXocuQfIwemrP21FpiPnfH+KLSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2RU8Unv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Ha8UZDq7Lu61upXZpfKkXckZhfouMk5cB7+X6dnx8Y=;
	b=T2RU8UnvUOxg0tTo+r0dgQExuDDjIFriNtWF4DF+UYC+4hMTBvznE7Lb61Wz0zIajCXahK
	7cSoIjGIiou4mOTLDaUhroUOsJIgzS8wPnPO+GkvCDsFECzFpP2Zl3wpfGjJGdg6Uckqk7
	jpaYuHftKwtdBmYSKayrWhlBV0xxYmw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-EjItAnQsP8C7mI8T-vWVCA-1; Mon, 03 Mar 2025 11:31:00 -0500
X-MC-Unique: EjItAnQsP8C7mI8T-vWVCA-1
X-Mimecast-MFC-AGG-ID: EjItAnQsP8C7mI8T-vWVCA_1741019456
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390f9d00750so1344832f8f.3
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:30:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019456; x=1741624256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Ha8UZDq7Lu61upXZpfKkXckZhfouMk5cB7+X6dnx8Y=;
        b=Hx7QTqJC+FfuhFARgZpbuGodfvgMifXq3+NCA9vIugrWpEWhG0OFO54Y29VbSHI4ae
         9INxazCIaAbCttnoLSJr9dKAu1C3AT2imot5Xd+fymVB/eo5TfAqU4OrUlWh6k+/+7Dw
         0bRaYuovaqX/pbmC8pXpKtDT+vc+S4vfDoZtRxckXDnLDgQyFQtfcghu+gDMgGSg/h2f
         RwVN9iINCOy1oh68sNsxoT4eJFUKCYWaw70LBsJd4JdgWsGBGdACeiH7PAIkGrfTEWoP
         uRr8Ua5qAU2wh5pNT8VzmJr9YgqwVuXpwkuB2bxx4dE5XRTdaI7R8NqDA+L+Xxq7n/1P
         yJpg==
X-Forwarded-Encrypted: i=1; AJvYcCU3Jr/osq/cZ6uKGm+aw2Do0vnV5VD1yl3Y1dH/IVHzv2krmFXpks3iFJ8hx293/K1ILvBWWt6vkbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzximubAfVQPDsEHeYBiy/gdQH04kb8IUXTfvVDt9JAusQAge8W
	e+Y5cFK2Q8ifsKwy1l5WJ3O35b0FYY/Z0liOqhHJs2X134TxjYtnszeg80yDOsheSiB6vKxQ16s
	l1pKuRVaDKjtTgodOX2GmiUYrX+/mDy/pFztQ8UYQc78bPwuJh5lsS7dj+w==
X-Gm-Gg: ASbGncsLu1lbzC+75Q0fwxbtTB2HQMWcyiGIvrbW5U6v3fD5UhTTorrgPXvJa5VbGMF
	RGajC/eZW8DR0W0yriF8Ix7DN2+C/ePEQO0zVpfrScqa+RGcyPr3FBfPqZsuT6O48pKnTO/A8O4
	8GeFcJ7lwrcjnchpkVsApSv21A1Ne9kxC4OvNKqFbtHg5pLHXrE+WoCx5XlAgsXPvIrkHGzf6YW
	4byZ7HnQIIIy3V9fslkD/WCx+kTuyYbF99U484I4f5uz07SZJZiZ1rYsk0SQCV2WfXQk74elD1O
	jmhgjq2jLq0eIBaRd70jiezx8mFRMaJp6sjCzvSpGoP8JsCFSbDPBEcLlSBakbfiA7uATJy2/sX
	z
X-Received: by 2002:a5d:64cf:0:b0:390:df6c:591f with SMTP id ffacd0b85a97d-390ec7cd2ddmr9512454f8f.17.1741019455903;
        Mon, 03 Mar 2025 08:30:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU1cXWjWugfmabLrmr0XJAbs+GQI7107y37ij+zO9LNUtV9tqHS/ZXKWHCRmLlaLTb16eXbQ==
X-Received: by 2002:a5d:64cf:0:b0:390:df6c:591f with SMTP id ffacd0b85a97d-390ec7cd2ddmr9512425f8f.17.1741019455528;
        Mon, 03 Mar 2025 08:30:55 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485ddd1sm15052695f8f.94.2025.03.03.08.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:55 -0800 (PST)
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
Subject: [PATCH v3 17/20] fs/proc/task_mmu: remove per-page mapcount dependency for PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon,  3 Mar 2025 17:30:10 +0100
Message-ID: <20250303163014.1128035-18-david@redhat.com>
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

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

PM_MMAP_EXCLUSIVE will now be set if folio_likely_mapped_shared() is
true -- when the folio is considered "mapped shared", including when
it once was "mapped shared" but no longer is, as documented.

This might result in and under-indication of "exclusively mapped", which
is considered better than over-indicating it: under-estimating the USS
(Unique Set Size) is better than over-estimating it.

As an alternative, we could simply remove that flag with
CONFIG_NO_PAGE_MAPCOUNT completely, but there might be value to it. So,
let's keep it like that and document the behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 11 +++++++++++
 fs/proc/task_mmu.c                       | 11 +++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index d6647daca9122..afce291649dd6 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -38,6 +38,17 @@ There are four components to pagemap:
    precisely which pages are mapped (or in swap) and comparing mapped
    pages between processes.
 
+   Traditionally, bit 56 indicates that a page is mapped exactly once and bit
+   56 is clear when a page is mapped multiple times, even when mapped in the
+   same process multiple times. In some kernel configurations, the semantics
+   for pages part of a larger allocation (e.g., THP) can differ: bit 56 is set
+   if all pages part of the corresponding large allocation are *certainly*
+   mapped in the same process, even if the page is mapped multiple times in that
+   process. Bit 56 is clear when any page page of the larger allocation
+   is *maybe* mapped in a different process. In some cases, a large allocation
+   might be treated as "maybe mapped by multiple processes" even though this
+   is no longer the case.
+
    Efficient users of this interface will use ``/proc/pid/maps`` to
    determine which areas of memory are actually mapped and llseek to
    skip over unmapped regions.
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1162f0e72df2e..f937c2df7b3f4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1652,6 +1652,13 @@ static int add_to_pagemap(pagemap_entry_t *pme, struct pagemapread *pm)
 	return 0;
 }
 
+static bool __folio_page_mapped_exclusively(struct folio *folio, struct page *page)
+{
+	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+		return folio_precise_page_mapcount(folio, page) == 1;
+	return !folio_maybe_mapped_shared(folio);
+}
+
 static int pagemap_pte_hole(unsigned long start, unsigned long end,
 			    __always_unused int depth, struct mm_walk *walk)
 {
@@ -1742,7 +1749,7 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (!folio_test_anon(folio))
 			flags |= PM_FILE;
 		if ((flags & PM_PRESENT) &&
-		    folio_precise_page_mapcount(folio, page) == 1)
+		    __folio_page_mapped_exclusively(folio, page))
 			flags |= PM_MMAP_EXCLUSIVE;
 	}
 	if (vma->vm_flags & VM_SOFTDIRTY)
@@ -1817,7 +1824,7 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 			pagemap_entry_t pme;
 
 			if (folio && (flags & PM_PRESENT) &&
-			    folio_precise_page_mapcount(folio, page + idx) == 1)
+			    __folio_page_mapped_exclusively(folio, page))
 				cur_flags |= PM_MMAP_EXCLUSIVE;
 
 			pme = make_pme(frame, cur_flags);
-- 
2.48.1


