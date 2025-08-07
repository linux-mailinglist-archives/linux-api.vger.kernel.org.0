Return-Path: <linux-api+bounces-4362-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2820B1D09A
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 03:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C81727ACA33
	for <lists+linux-api@lfdr.de>; Thu,  7 Aug 2025 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF97274B52;
	Thu,  7 Aug 2025 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fGlUAjou"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48726B0BC
	for <linux-api@vger.kernel.org>; Thu,  7 Aug 2025 01:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531133; cv=none; b=Y6V+1mqnmRDfjZlmLyRTQ49sZVF9P15zVypYTJip9+ehLFoCh55dVApyuUvVJsv3sP2/gaBSR6fHAptWA5wuaYHgR8qiqVH6p3f8PaY9QZ9Y9ppH0ozKIndqmV+GZqSLHTeW/tms0cixUYWg96BsaDN4sIMFRQuu1eaVfTBB2mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531133; c=relaxed/simple;
	bh=QBZ+QExF2IQaP6/YZb4gORsOYwd34GE+7HN7nommpfA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI/2c3MCfYmcPgopiMt7GTobrxfh7phikpj0dGCWdyQ+J3v3kuHwJd00R7xfAx1MZuK3/DxcS/1s9X4kbL/fMGFLPq7c4uY/NN/tM8Co0vPpiSFOzAr3P9kYnBfDRxZm1hgcBS04BuxQGN5rrl+7JSOf+jcUb6Ql7K7nHgmwe8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fGlUAjou; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7074bad053bso7678416d6.0
        for <linux-api@vger.kernel.org>; Wed, 06 Aug 2025 18:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531128; x=1755135928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNpjHXepLLwpraPv0r0ol85rEMD4xKPLfeNr8R2KnmQ=;
        b=fGlUAjouwpG06vj9mauIjy7LRI5bRlzIjIsZgiSCCVorFI42a+/UKrLiGsvb/0JUpi
         7xf6OfYZGJQTSWDILVbRQRDuWAH8KxG/zqeursycfjoJZjudQeZGlLFBxuGoGeTTjG0h
         W0w4UJgK+kPOhJ1+nNUdt5nS8ioOApOmCHXI9guQd4iVLD48VRtje8bzAyWK9qTdDSak
         KXKzbg8i3DE3C6e/jsOAnzRyacOpOGYbclWd8jE4xrK7SWxfBnHSxJEQkgqUlcIGcJiQ
         H2Ib/wmqlgZ0AAxlwNsoXyKWR0OovfJj1UIDHLNL/49XK6rm0pv4B0Rn9gDDqe+KD2Gl
         j1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531128; x=1755135928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNpjHXepLLwpraPv0r0ol85rEMD4xKPLfeNr8R2KnmQ=;
        b=UdBWEvfQOBsFF1cOLxDSVUjGNOi1e/JSpP6UKK4pm34viLbqWkKkQMO91vp0fw58ma
         laymrVRAT2HJ0QY2CF3Rsit7sHhfdrRGf1G0u2bitAY/Nbok9lWByhjP/mFHbp7FrfSi
         VLQO7NlsW+G8iMSZx0HvBSUifo5WIjXobH9zhcneMzcCfbUp09+Urz/YZke0Obkd/vT4
         MwhANSnS7sU6TPpcL/bw9oygAp/jV1SRK8AhRB5lamyEGP8n/muBoaqpQzYfrkZrAj55
         5EFzbrCFdLwu0AnlQ9ymT2dW1wUI5GHNu3P3BcXsqlBzQgUl3tito1RPbS76T2CYT9/L
         EHrg==
X-Forwarded-Encrypted: i=1; AJvYcCWF+TWPqKBVeuBDrFEYMnuw26ly+PQ3zBPYZ7czGtBFEuQQ46xyWZ8gXy/l+XDJXqYH07hiyLrGpKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybgVYScn1hDbiEKynMnq8mQ9Q38522zKMxLZ76zRyiWHO9gBE1
	MPm0ZsgQYaJLKf8/6nkFdeI14CoYntudd+yoQcWNbZCN7psfnhfVOZ2TIjkDp700a1Q=
X-Gm-Gg: ASbGncvDKoXaxYaJLKyXO0O01/dpDgdMcSIgQcmVP1z3wyn0GSzJSB1i7oaq1WpaaiW
	ia4VtUoE1mI6PJpm7EGgLoNthncWMq4wDOZBXRN08yiqg3SiS5TuJb92zCf+zOictN2dviVKksm
	trxPq2Yxcilp4od9QK50SZ/9bh4EkZbfVB/0XjeEObqChj14RdAl8IEfO2YoddTDHNn85zWS55+
	BRPbHa3cNeMiuamKhVWgtgtAzgENYnTl5YnMb6SiGmKrLMsI/hoZdhQkYMkKqFrM7EK9vn7jAM4
	vGfIhpUkphYwmTrC5OhDgxIrbmfqBOM5hbPOASS89ZCEc2W7SDOg/vUv4inj4mIYnUjyPoXtMye
	+cbzBfioJRCGW1gSqUPRtfUalhkv9wl5aTzU6s9HVvEciIUTcjiJ3UmoIwgviiXipzOFmU4LFak
	oQqZ85hX03c+RQu8zdTsZMvpE=
X-Google-Smtp-Source: AGHT+IE5gyxbiCqCqrXVqnuWA1mkhz9OocyomyZ6jSXE5mTuz1p3dbFY4IvWv4kGZUKx4DkAznRCTg==
X-Received: by 2002:a05:6214:76d:b0:707:6977:aa77 with SMTP id 6a1803df08f44-7097969f103mr61593626d6.33.1754531128252;
        Wed, 06 Aug 2025 18:45:28 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:45:27 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 28/30] mm: shmem: export some functions to internal.h
Date: Thu,  7 Aug 2025 01:44:34 +0000
Message-ID: <20250807014442.3829950-29-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

shmem_inode_acct_blocks(), shmem_recalc_inode(), and
shmem_add_to_page_cache() are used by shmem_alloc_and_add_folio(). This
functionality will also be used in the future by Live Update
Orchestrator (LUO) to recreate memfd files after a live update.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 mm/internal.h |  6 ++++++
 mm/shmem.c    | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 45b725c3dc03..5cf487ee6f83 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1566,6 +1566,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp);
+int shmem_inode_acct_blocks(struct inode *inode, long pages);
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped);
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/shmem.c b/mm/shmem.c
index ef57e2649a41..eea2e8ca205f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -219,7 +219,7 @@ static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
-static int shmem_inode_acct_blocks(struct inode *inode, long pages)
+int shmem_inode_acct_blocks(struct inode *inode, long pages)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
@@ -435,7 +435,7 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
  *
  * Return: true if swapped was incremented from 0, for shmem_writeout().
  */
-static bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
+bool shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	bool first_swapped = false;
@@ -898,9 +898,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
 /*
  * Somewhat like filemap_add_folio, but error if expected item has gone.
  */
-static int shmem_add_to_page_cache(struct folio *folio,
-				   struct address_space *mapping,
-				   pgoff_t index, void *expected, gfp_t gfp)
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	unsigned long nr = folio_nr_pages(folio);
-- 
2.50.1.565.gc32cd1483b-goog


