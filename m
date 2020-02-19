Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCCFD16398A
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2020 02:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgBSBpB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 20:45:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39261 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbgBSBoo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 20:44:44 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so8870169plp.6;
        Tue, 18 Feb 2020 17:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3jgjNejCBb9X6M77zvWpmzx347WGq75tEtMqAj/+Ok=;
        b=AL4pzbixVHKxDcp2U71m+QJepOHq30WmQqf7j+F+x7wQi2XW7iI96LNeCD/OaKmSF+
         Kve/u7Jsgl64NPcQA1Q4Qoh9LhX2XTblwdrSs5djpew5yaRJI1bFsKtlOWuCFnwUaFC7
         PUBYTat0BVIXGik0ytrSqhntDQW2DMum1kRT7n1JY+RN2WKKabSbQTNwJ9tJTg0u7bs9
         UF0+ceWRbv4U/sfMLJ7xIMf+LxzCPc+1fjNzY6GEciumm3pfJfHaxZjMFYlp/HP07Cr5
         Vd6Qi3/S+dHt1BorH7jfFvA6ii9OFJFR602lgfgvGUtoLmQFZ8eEFKp4dsmsTjBeAFnc
         1gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=c3jgjNejCBb9X6M77zvWpmzx347WGq75tEtMqAj/+Ok=;
        b=CENyJ47CnY8qro14B6OSIsCxBJrB9u2ujg7BP/vfUHWQaY82YEbLE0/BJDYycCfqvp
         f+yn6ZP8dmeBwDvIR3QbnN5ctacY/kPVPWpyrOd3a93L90sdVEkoAaXmfPCzQenK1mfT
         lK3BumDBGJp0G189EI53bTjj99kvCQ4ufin3k8m2MU4DD198SZ6oFpNeqTldiQRHiIfY
         OIJWvAXZazJJff8s2uPF619et5B9RzZxTPVfzQA3A2lfFjpgMo2HhXxSEYKFgwAgC/yZ
         KjWkA0/JnO6B5scpuOJ+zIky/3RZ7iTktcIqP1vMETn8zD2gfF/ofewHEDUw9+tlo72/
         yfeQ==
X-Gm-Message-State: APjAAAVjln9BK+yysJr+rRuQLBTVKcpern28kiVSkSW77TIUq1/z+BRi
        hXNeb6dTR40MAvcru1S5g0Uz6zWO
X-Google-Smtp-Source: APXvYqygDJwDS7PyVA1yTqfgxMw2cPIblIFGAm8JUg/EszRSRLPi2m3lE8zcfv8RlWVvwMYMaTWAbQ==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr23358861pll.136.1582076682761;
        Tue, 18 Feb 2020 17:44:42 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t186sm221192pgd.26.2020.02.18.17.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 17:44:41 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v6 3/7] mm: check fatal signal pending of target process
Date:   Tue, 18 Feb 2020 17:44:29 -0800
Message-Id: <20200219014433.88424-4-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200219014433.88424-1-minchan@kernel.org>
References: <20200219014433.88424-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Bail out to prevent unnecessary CPU overhead if target process has
pending fatal signal during (MADV_COLD|MADV_PAGEOUT) operation.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f29155b8185d..def1507c2030 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -36,6 +36,7 @@
 struct madvise_walk_private {
 	struct mmu_gather *tlb;
 	bool pageout;
+	struct task_struct *target_task;
 };
 
 /*
@@ -316,6 +317,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	if (private->target_task &&
+			fatal_signal_pending(private->target_task))
+		return -EINTR;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		pmd_t orig_pmd;
@@ -471,12 +476,14 @@ static const struct mm_walk_ops cold_walk_ops = {
 };
 
 static void madvise_cold_page_range(struct mmu_gather *tlb,
+			     struct task_struct *task,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end)
 {
 	struct madvise_walk_private walk_private = {
 		.pageout = false,
 		.tlb = tlb,
+		.target_task = task,
 	};
 
 	tlb_start_vma(tlb, vma);
@@ -484,7 +491,8 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-static long madvise_cold(struct vm_area_struct *vma,
+static long madvise_cold(struct task_struct *task,
+			struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
 {
@@ -497,19 +505,21 @@ static long madvise_cold(struct vm_area_struct *vma,
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
-	madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
+	madvise_cold_page_range(&tlb, task, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb, start_addr, end_addr);
 
 	return 0;
 }
 
 static void madvise_pageout_page_range(struct mmu_gather *tlb,
+			     struct task_struct *task,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end)
 {
 	struct madvise_walk_private walk_private = {
 		.pageout = true,
 		.tlb = tlb,
+		.target_task = task,
 	};
 
 	tlb_start_vma(tlb, vma);
@@ -533,7 +543,8 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
 }
 
-static long madvise_pageout(struct vm_area_struct *vma,
+static long madvise_pageout(struct task_struct *task,
+			struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
 {
@@ -549,7 +560,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
-	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
+	madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb, start_addr, end_addr);
 
 	return 0;
@@ -929,7 +940,8 @@ static int madvise_inject_error(int behavior,
 #endif
 
 static long
-madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
+madvise_vma(struct task_struct *task, struct vm_area_struct *vma,
+		struct vm_area_struct **prev,
 		unsigned long start, unsigned long end, int behavior)
 {
 	switch (behavior) {
@@ -938,9 +950,9 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 	case MADV_WILLNEED:
 		return madvise_willneed(vma, prev, start, end);
 	case MADV_COLD:
-		return madvise_cold(vma, prev, start, end);
+		return madvise_cold(task, vma, prev, start, end);
 	case MADV_PAGEOUT:
-		return madvise_pageout(vma, prev, start, end);
+		return madvise_pageout(task, vma, prev, start, end);
 	case MADV_FREE:
 	case MADV_DONTNEED:
 		return madvise_dontneed_free(vma, prev, start, end, behavior);
@@ -1140,7 +1152,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, tmp, behavior);
+		error = madvise_vma(target_task, vma, &prev,
+					start, tmp, behavior);
 		if (error)
 			goto out;
 		start = tmp;
-- 
2.25.0.265.gbab2e86ba0-goog

