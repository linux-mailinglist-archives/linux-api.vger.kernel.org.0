Return-Path: <linux-api+bounces-3362-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB63A4C7AF
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88735188632F
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8132500DF;
	Mon,  3 Mar 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hc5GU7L4"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A4B24E4CF
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019453; cv=none; b=O3v8tdbnSl3fVtQO6WFNMACWQIJqhcr5v7ChKBxN7l59ZzpEZU/7UybVir/MPf/d0Lc85eYqEneoZMJ/T/BUV1oRCq6mYxskQjVKmg4fjrPsPIldP37kpSjPYiap1qYvj+3RiH5rEqmG9sUkXN2vPIvh45YbbNITQLoe5jdpJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019453; c=relaxed/simple;
	bh=02Xdg2rkGPtCOeGUCnvp6kwlwub3xR5UDzHXfcHWX3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkfTKYZEvpOCs8ka8G9vAMvouUrj71MCQyXAsjy+loBiURaGGDDKSrT2h2HNcYZmSWRkW7mEQ/VF88L6OZFSX/gj59Z7w99CEny7wfBiAqLgssJpb2nZQiTOjHG7EwBoQdpvaPwXsPhYu8z9ZVy1weiKbCWmOIcwzkpzPapy+Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hc5GU7L4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L4FvEMzbdPGmsETJ2MBrv3sRxLuQ35ROZ1b2dyZFsHo=;
	b=Hc5GU7L4HyeRVYJ1Etnl4y4bojLmHkC0wRysMVywXmymBlXjl5Snrl/vjcxt8OlIUiNWO2
	4lguPfG/hf0A5DxvU6c2RT3Kg/HfeM8Gxu8JAVdxxHKbGA14nWkufJKwJ/CGmeLo8cGwHO
	sviZ8K/ax4+j+2NLDm5qkXHd7czfWj8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-c-Ma_Vi0NWmLPSnnjHTLEA-1; Mon, 03 Mar 2025 11:30:49 -0500
X-MC-Unique: c-Ma_Vi0NWmLPSnnjHTLEA-1
X-Mimecast-MFC-AGG-ID: c-Ma_Vi0NWmLPSnnjHTLEA_1741019448
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390f365274dso1237028f8f.0
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019447; x=1741624247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4FvEMzbdPGmsETJ2MBrv3sRxLuQ35ROZ1b2dyZFsHo=;
        b=P+a3C+H52EeoLPRou04COQmmvIx8csZNOKg9iqSA29dX5QM/kb49BuAAjHD0318o+r
         ohn161CH3fkiOrx7xORYMLBUh18ciFwHFzw6dBSQEcu4cFfBshQoIqa9RP2MikwfXn9r
         ZCQMDiRbGjq4WB68EM6FTZevuSGsacYIBWVZvftgCFV2OjKb6HS7ygceq21nP7wdamRI
         SSrjPnV2TRiz6KHDtGgHuemFox3ALl8GJcq2v+JfR/xdGmcd6FnefjLIj8fYNtBly15b
         vOc67b3c8KMbxRNuFCSkC/pmuiCJlQwzLHGQP6vOnG4p3WIXnq5Bt6TXqHj68hhUZBl8
         bapg==
X-Forwarded-Encrypted: i=1; AJvYcCWHsaoxEh0Qz21IXD3ABs3csHX3TpZj0ZunOE7G3yxe3xrXtDTpfUPSvElcM/K1CzmUZebqlWrRj9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDqv6b8aVXurr8572In9o5vMAJQiDW3hS++nkYrUTN8QGD3Xp
	Msnlg4BwPtUj8UFFXzVJSSDg+38ljzFUVyLOjlxifC8ZC8w8d7006rDbsq5Df3GZfRLoiMiGVCZ
	06/9H6q+7pkZtzRL6GJEnjnR0dmNZa63N62+L/9cljfJGcjRsnxQ/jUjNZQ==
X-Gm-Gg: ASbGnct5pj+ZDjgP+nNTytoVBBHz0Tf4jKVFcw25gx0I+UmzDpOkawyjOe7CM23ibzg
	ArcCAbga9vppFIz2qzZXbywKfCOcBdpxrXVjITT5TGQCNtGmC4SDlbhl0DxbSSLtJrCMC/9kSA9
	aDkb1/GuGtz5+L2U5RtDFpfcB5IE3hSLctGZtEwL7MX9rYQOjICVU4qf0P+f67em3G6E2Sr9RVQ
	9uz8jbfW5OZ+OJLqjseL6E2y0uUlgiYvqzQmRGhnR7T7XbWBXCOygkKXxQpF/TfdjyCZF/uqqnu
	CsSXBAddSt5LpDUzvMd8tMuGZWOFOSZpp2N5tjvopukVFEnS4NMVP+9wRtt6fqfO5mfTJ2ie7DW
	M
X-Received: by 2002:a05:6000:1563:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-390e9e062d6mr13290386f8f.1.1741019447592;
        Mon, 03 Mar 2025 08:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZ9qLz9Zew7W+f+EXmCL5po72v+Q03kK3/3MSwVL/z8h10XiTsQrbDI7Khsstadj0a/aIAmA==
X-Received: by 2002:a05:6000:1563:b0:390:e9e0:5cc6 with SMTP id ffacd0b85a97d-390e9e062d6mr13290341f8f.1.1741019447204;
        Mon, 03 Mar 2025 08:30:47 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e4795d1asm14736287f8f.4.2025.03.03.08.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:46 -0800 (PST)
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
Subject: [PATCH v3 13/20] mm: Copy-on-Write (COW) reuse support for PTE-mapped THP
Date: Mon,  3 Mar 2025 17:30:06 +0100
Message-ID: <20250303163014.1128035-14-david@redhat.com>
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

Currently, we never end up reusing PTE-mapped THPs after fork. This
wasn't really a problem with PMD-sized THPs, because they would have to
be PTE-mapped first, but it's getting a problem with smaller THP
sizes that are effectively always PTE-mapped.

With our new "mapped exclusively" vs "maybe mapped shared" logic for
large folios, implementing CoW reuse for PTE-mapped THPs is straight
forward: if exclusively mapped, make sure that all references are
from these (our) mappings. Add some helpful comments to explain the
details.

CONFIG_TRANSPARENT_HUGEPAGE selects CONFIG_MM_ID. If we spot an anon
large folio without CONFIG_TRANSPARENT_HUGEPAGE in that code, something
is seriously messed up.

There are plenty of things we can optimize in the future: For example, we
could remember that the folio is fully exclusive so we could speedup
the next fault further. Also, we could try "faulting around", turning
surrounding PTEs that map the same folio writable. But especially the
latter might increase COW latency, so it would need further
investigation.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 8 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 73b783c7d7d51..bb245a8fe04bc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3729,19 +3729,86 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf, struct folio *folio)
 	return ret;
 }
 
-static bool wp_can_reuse_anon_folio(struct folio *folio,
-				    struct vm_area_struct *vma)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
+		struct vm_area_struct *vma)
 {
+	bool exclusive = false;
+
+	/* Let's just free up a large folio if only a single page is mapped. */
+	if (folio_large_mapcount(folio) <= 1)
+		return false;
+
 	/*
-	 * We could currently only reuse a subpage of a large folio if no
-	 * other subpages of the large folios are still mapped. However,
-	 * let's just consistently not reuse subpages even if we could
-	 * reuse in that scenario, and give back a large folio a bit
-	 * sooner.
+	 * The assumption for anonymous folios is that each page can only get
+	 * mapped once into each MM. The only exception are KSM folios, which
+	 * are always small.
+	 *
+	 * Each taken mapcount must be paired with exactly one taken reference,
+	 * whereby the refcount must be incremented before the mapcount when
+	 * mapping a page, and the refcount must be decremented after the
+	 * mapcount when unmapping a page.
+	 *
+	 * If all folio references are from mappings, and all mappings are in
+	 * the page tables of this MM, then this folio is exclusive to this MM.
 	 */
-	if (folio_test_large(folio))
+	if (folio_test_large_maybe_mapped_shared(folio))
+		return false;
+
+	VM_WARN_ON_ONCE(folio_test_ksm(folio));
+	VM_WARN_ON_ONCE(folio_mapcount(folio) > folio_nr_pages(folio));
+	VM_WARN_ON_ONCE(folio_entire_mapcount(folio));
+
+	if (unlikely(folio_test_swapcache(folio))) {
+		/*
+		 * Note: freeing up the swapcache will fail if some PTEs are
+		 * still swap entries.
+		 */
+		if (!folio_trylock(folio))
+			return false;
+		folio_free_swap(folio);
+		folio_unlock(folio);
+	}
+
+	if (folio_large_mapcount(folio) != folio_ref_count(folio))
 		return false;
 
+	/* Stabilize the mapcount vs. refcount and recheck. */
+	folio_lock_large_mapcount(folio);
+	VM_WARN_ON_ONCE(folio_large_mapcount(folio) < folio_ref_count(folio));
+
+	if (folio_test_large_maybe_mapped_shared(folio))
+		goto unlock;
+	if (folio_large_mapcount(folio) != folio_ref_count(folio))
+		goto unlock;
+
+	VM_WARN_ON_ONCE(folio_mm_id(folio, 0) != vma->vm_mm->mm_id &&
+			folio_mm_id(folio, 1) != vma->vm_mm->mm_id);
+
+	/*
+	 * Do we need the folio lock? Likely not. If there would have been
+	 * references from page migration/swapout, we would have detected
+	 * an additional folio reference and never ended up here.
+	 */
+	exclusive = true;
+unlock:
+	folio_unlock_large_mapcount(folio);
+	return exclusive;
+}
+#else /* !CONFIG_TRANSPARENT_HUGEPAGE */
+static bool __wp_can_reuse_large_anon_folio(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	BUILD_BUG();
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static bool wp_can_reuse_anon_folio(struct folio *folio,
+				    struct vm_area_struct *vma)
+{
+	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_large(folio))
+		return __wp_can_reuse_large_anon_folio(folio, vma);
+
 	/*
 	 * We have to verify under folio lock: these early checks are
 	 * just an optimization to avoid locking the folio and freeing
-- 
2.48.1


