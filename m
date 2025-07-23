Return-Path: <linux-api+bounces-4221-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4B9B0F628
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73287AF45D
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065A301151;
	Wed, 23 Jul 2025 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="q7fICFX0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6795E2F5C5E
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282074; cv=none; b=CIAKtR+CxnDnK+0mdLIqquyhF/CjS48DL8CzgLUOjqom46W+a+7fWFtb9cCTzixomJUVzFRq2np75oaT/Y7FYHrf9NveaS9CY/0i2yWSE5bm1dpvojPwfXHC3wYRZrhmjMy9XILiScW29FHBVyKLlDO+mKMov8t0d5cl7UBSho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282074; c=relaxed/simple;
	bh=JpDjGN5akNkgXqHHoeTKMcxNwFHTNgIwpzw2mOBo7i8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8imNyJdIddn7BJRCbmNjA0gghDmn4SnQ3OApAzgM+pjVjzqzFnKevIGDWK8RxttzArSqCBA5X5V7OBHleaJpXMbk6O4yTvMGnaGggnPv7GE5uWg6rMyoMsGv/U875fxABlrJu41ooypQYAPK3D8yU67/6SjuiFySitGh+8kL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=q7fICFX0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7170344c100so58959167b3.0
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753282070; x=1753886870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a7cc+J8nsCZ/iRindbQQ/niSVeH9iE0nAvoyR2/FgGA=;
        b=q7fICFX01pEWSwL+H88zCuDfRF0cHPDrOOL+wgkjl8GB6aLUHyAioY8txya8u2mShO
         5N55i69V2ZISXDHMiOMdnCl3gABIRlPtGQZweu2HOAWs+nAGWodRIkOmHWJfleMS+E0y
         +62SyJzazulBVwHlD/N813PZUV4EYJDoVpP22Y0IM1MxyufosanUgddwGswO7d9vCE9s
         VrbY9QLpnojVQNTJrOiDcv7T3GUvr85ODe0B2HEFjXdXYM3f+TJtNpTKbKnxiCchm28Y
         hJFen//G7lX8TxZEVCp0MK/PqcZIPtwBA5GXd+QHewArgJYK/2iQzgea27+0uTOHKn5t
         0Sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282070; x=1753886870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7cc+J8nsCZ/iRindbQQ/niSVeH9iE0nAvoyR2/FgGA=;
        b=nh13w5P8ATkf6decYOHhjL8tiP5NT4Kvr2nqcgNCp3jSWnbdzRcuvdN+rphDllnFkS
         a4rFB/DGp7zV5HpRpH8oYAPoDRK9W1YYTXBC000vbAqHCt0Gp8gOezglvABcndLrvflK
         Or0/VGkbFVhK1cUObldar5jJtrzbooDwYy9Wd0xVHPcxie0m85PeSD4Obu3bNlVsER2x
         Nvpt3mesNt2nMYJhaLrAE2yJx+SHT2yiOI6oxfhhnXubglnrExTCw0Ax0uzYDwzo0B+R
         t+Xp61w/MDeCCNpGmhlBcFGn872rie0v+i7f5aCvFgFyVTqtmYBg3vQpIfcoxYUl6Wlz
         Jc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUTNgsf8N3Z/jbXNcflnpYwLvt3Aw58/dYja6mCURWiuteA6qMODwzFIwJ8tesdkg53wXv2Utt2P4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPL4hUYPs8tXvNb+3GsO6DYpEBPyjZR8vhMr++4U6HGAuf14Oc
	hDRWvwTrrANos8dVyu5c4IAqGSs7whLEvczWDBNr+PX71RQ8/MlxYkN1tpsulGK5Uf8=
X-Gm-Gg: ASbGncuqt0uxV3dzXp3UxdgJ/7D9bpxbAc7CGdZsoVVdc3i1y+pJUDE1yThfvVxwPTK
	YQPbvgr7juMRZPKYtdobQ1GNIlR6F0S5C4EwAVdLxQ/IaOco3sschi57YSr6ivxPZPfjcR2RI9t
	rOsMPv7q56QyLXib9HlkEz8NrCxTtd0YliXq019balJ/w/jUF4HcxRsQdnlLLXd2EzIWGhu+89f
	D/WWddGHKmGo/IRESkYudA2bqSXQ89glHyKCZrapZVrAlne0fhINuzGdywMbMfg+0uoipj1cUVV
	ELEi+oxJELy1ACnkJlbkqJNj7CzmtQYlefeFL5AAWxKKRU1Yc2QXD4r5YW94uVoza1pLpyj05Lf
	h12qptykjKIU9o64ny7k29iCYf27k7fzSC0gXgOKUu2am09aHQCnwmpOeWeP0xyYkJuYy1Q3ocw
	p6RLFHlTpBz7n26A==
X-Google-Smtp-Source: AGHT+IE5VwnfY3W/9KIKWadyQ8YmwEe7nfICAnpKXhV+FZKxq742FfGNPYd0VcNoWXlFXd9fHhIFIQ==
X-Received: by 2002:a05:690c:92:b0:719:57a5:fde3 with SMTP id 00721157ae682-719b4149efcmr44710187b3.3.1753282069966;
        Wed, 23 Jul 2025 07:47:49 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm30482117b3.72.2025.07.23.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:47:49 -0700 (PDT)
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
Subject: [PATCH v2 27/32] mm: shmem: export some functions to internal.h
Date: Wed, 23 Jul 2025 14:46:40 +0000
Message-ID: <20250723144649.1696299-28-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
References: <20250723144649.1696299-1-pasha.tatashin@soleen.com>
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
index 6b8ed2017743..991917a8ae23 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1535,6 +1535,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
 			  int priority);
 
+int shmem_add_to_page_cache(struct folio *folio,
+			    struct address_space *mapping,
+			    pgoff_t index, void *expected, gfp_t gfp);
+int shmem_inode_acct_blocks(struct inode *inode, long pages);
+void shmem_recalc_inode(struct inode *inode, long alloced, long swapped);
+
 #ifdef CONFIG_SHRINKER_DEBUG
 static inline __printf(2, 0) int shrinker_debugfs_name_alloc(
 			struct shrinker *shrinker, const char *fmt, va_list ap)
diff --git a/mm/shmem.c b/mm/shmem.c
index d1e74f59cdba..4a616fe595e2 100644
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
@@ -433,7 +433,7 @@ static void shmem_free_inode(struct super_block *sb, size_t freed_ispace)
  * But normally   info->alloced == inode->i_mapping->nrpages + info->swapped
  * So mm freed is info->alloced - (inode->i_mapping->nrpages + info->swapped)
  */
-static void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
+void shmem_recalc_inode(struct inode *inode, long alloced, long swapped)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	long freed;
@@ -879,9 +879,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
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
 	long nr = folio_nr_pages(folio);
-- 
2.50.0.727.gbf7dc18ff4-goog


