Return-Path: <linux-api+bounces-5434-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1E3C7D8F1
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA9C04E16F8
	for <lists+linux-api@lfdr.de>; Sat, 22 Nov 2025 22:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDBD2E0916;
	Sat, 22 Nov 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HScPZ3NE"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93771C6B4
	for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850264; cv=none; b=LLpjxidJunc5hn8+yz8l0dXXU9YHy9e1xqjMgpTRJ0PLWh/Ui8d9TUTtFq5Z8DF8BeBLZRZEpeD7kA4nA07KvV3jj3tQGiTxIW3SispVVzigvw0JHqvRaD2zcWoTY7jUiW5NJWisH8sw7gZV+qJTq06naGJ6DSubeV9LMLyh3Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850264; c=relaxed/simple;
	bh=cV6ayUY0cd5cthn+5O2DyMdENfG+D5eByWYgHRliMyA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQyUwHZp7IebAoYpsxEgAZwURRDBUbSd7NGsmgcu5mVkPFEwnwMvrRlndZfZ/aor5ZPMT9y/fhjw4qUFVnQ8ngym4bNnXBgPYcU4C7/xAPxzXwgBW6UUx11Lvd7pD59nUVreoKbjbgI9FSwt2XlV4OfbLBvIiI1Kk9EY7r7VInc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HScPZ3NE; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64308342458so806378d50.0
        for <linux-api@vger.kernel.org>; Sat, 22 Nov 2025 14:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850261; x=1764455061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3+3x59DbFWdBPdmdih5ENuDC3ZjNMKrWdUeGoJeNo7E=;
        b=HScPZ3NEKZwt7blLAousjMuqCBILyYAhjd7MiMhHJgDzj1HcFn/1KoEHw8jqBuPHYY
         Bl0XBqTl6iLCVqc7OQZoFuAR9O3rUa8aIhWzSR7Gxd/3k4SmnbvChslsJZrwXV92YnRX
         OxKY33rox5nPfmVMvDhstWwTW7SK8BpGAOzaWThOctNUDRl+0a9rQwL+ZO3EO8ABfZyl
         EbAgutSOFlvto3g7icuAEdFEs6d3f4Aralf7CZHf2a2qB2FpxsVC1uQpDGZ47qHiaOtS
         Khz3ogqv+mHOAQUPQe+bInIjdoPl8bIaO/kADbyRcU0giU+CxqbH39NbEDbAO7ZgNBry
         yyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850261; x=1764455061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+3x59DbFWdBPdmdih5ENuDC3ZjNMKrWdUeGoJeNo7E=;
        b=L+T9byt7QHuqvCq3qVBSktguFVMixF0sKaPhyQcvX1OHUD1vyswEc+Urf0mXmCjQsQ
         t74bmiEaaR0KfrS9w4bBFEYTnemf8l17u/FD90ztg0DaSyaG+7x7WtKkO+yRj04ZV78e
         HwrxGGBPvPDXbbWf9H7AgzwsobTzCFU5w21VEQWgI9OuR4QjYJXQSn31dkFbSSnhOR7+
         UOFOdKvFrqiZhiL4dO+5kmXfjqmiPgWCS7IddlOSHeBvIkv0Cmf3snS7lcL9ptmf6H1F
         oViT1vRTv1wYpSTs/wmuEvoIHCdEdYaKRBuPwlD9+Gw1oR80DpS5rRNu+dvQvQE32kBX
         /vcA==
X-Forwarded-Encrypted: i=1; AJvYcCU6M6VnF/eW563r7D2qXxQIpp6wsnCm+T+FV2gQ4bc14X1ugEwTtUMJ/Mjrea6xcCkkxYYHOGMNd7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuP7k0nHzPuyBpFKNyfUojFD2PFDhf/KN06GR+Lt65x3CkUjB8
	WqOSTIRb23ElqF5BUMIHIP07CFj9nsrIVk3S3m3PDvGr5InD2Z5xKPh25ODvcyuG6NM=
X-Gm-Gg: ASbGnctlMMZKsgXB7ClnOwBNMUGwhVmGnXjQ1Atk95fkipqq7G+ONZIbM+kNNF1Y1gR
	YvFuRu/lOlCJhmqny6pHo2MsPl0hvkrCxgfu5H99WRwmvp4wnAJxuNrtPHSshsxqyWuzPaYHXHn
	peJ7PaEZKc8fRjn5ktuO12kmRAHbmdWmoUK6iUNogAgzTkTM/FUz4FkxPlkpyMw3lER2RL7IShz
	BCklUnf4/B4H6zskn8BLj7I+VTluPoJlxtW+CbS1vnililESVz5Qyw3WtHyP9kBpYHzgHkuZZed
	9EigOR9iMKvxquzTzSeAVNpbixJ/uKkV/GXYaUNmXZDeiDIyWp/qj0ori3F0gwLI6j81IP1pA7s
	rGO8ZS8uoxaDHZYZs2M7PGrwmdwzPC/S/x3Y/5balYhLMLpA06rvZjyVGfn5+rP9W0glivzlNAW
	2v715t4n8U2G1YpBSA3dIvC2TkqqEH0TdrWPbSmk3VnZRBdKDi+g2YDNcByRqjRUSRX4Z/yU0dM
	WWXuWU=
X-Google-Smtp-Source: AGHT+IHLBVEUSrsRTAR569f2nmbBoHdToiAZD4CXjMMgQTOgrYNyCyqBuS6WcJxB+UmOJcCfJHKxnQ==
X-Received: by 2002:a53:acd3:0:10b0:63f:55de:63cc with SMTP id 956f58d0204a3-64302ab185bmr3797706d50.31.1763850260775;
        Sat, 22 Nov 2025 14:24:20 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:20 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
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
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v7 12/22] mm: shmem: export some functions to internal.h
Date: Sat, 22 Nov 2025 17:23:39 -0500
Message-ID: <20251122222351.1059049-13-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
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
functionality will be used by memfd LUO integration.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/internal.h |  6 ++++++
 mm/shmem.c    | 10 +++++-----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1561fc2ff5b8..4ba155524f80 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1562,6 +1562,12 @@ void __meminit __init_page_from_nid(unsigned long pfn, int nid);
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
index cb74a5d202ac..b9cd7f8d50fa 100644
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
@@ -861,9 +861,9 @@ static void shmem_update_stats(struct folio *folio, int nr_pages)
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
2.52.0.rc2.455.g230fcf2819-goog


