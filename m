Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 974E615B4E7
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgBLXkF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:40:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgBLXkC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:40:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id d9so1543515plo.11;
        Wed, 12 Feb 2020 15:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tK/qyDb2GX3eOsQv+8LykkGI1WZNv+AWZfoVVRiylFw=;
        b=ugnk4mbCpyLdbSnvSLG+4LE+l7uQjSspFTFdoXumnT9VtWq0fApfN4PwLFAP90qoof
         my+fCb7um1UNKkVcQdS2Fy2CxJIvpngIkgvSrCwcCeP+rS9OAZOpRZjv+YLq/FZj+YU6
         p3hj4WL+PtezT3ZPgcOlwn9B3TR3+L4h0YclrXkhWtBMF46MqTSO7Nwuji88u0C9Ys9I
         Victfq0Q7S8GZ3z/WzMRtXU0sMlhPBiNmTzTa96CahdBEIyJw/QeiUCPOtn1bxydOGgY
         TBqqxdcWMBLx95yG//Tr7q3kXPK7/xDqjdZ7j+UaU3pTyktPWgY6/MvqDY5EfO60bb3s
         Bx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tK/qyDb2GX3eOsQv+8LykkGI1WZNv+AWZfoVVRiylFw=;
        b=sWVeSmLXg5CaIoHzitNDCOzzN+Nu3u4ekeVag35uibdzdDI5IE5vD31FjEbo9E3MqB
         JomfNHVnljJ12pnnfisX1wvfw6m5zSvQBd+tMpon4K1twB0x/reK7u/M29jZBvacuoYP
         pPx/nCfnpxIF5OPamAoq+kMPa2C5WaOr0OWsGRY7TLMtp1cqGVSA6+zzSStN2Yn7bTAN
         MLRuznga+xUciFI1X7+Z9cyTc9s7gmOlaV5bSzeOHcwcmS0DelmjwcZIkGPSSMwX6OjP
         9DGnmAJRmQ52crXrgU5Is37T6s0sYRCNG1x11/LT7Ibe9u6s+2CDhCQcrcgKcm0kJ9oC
         0qLA==
X-Gm-Message-State: APjAAAXXmWB41Cj6mh9WLvpt80JJ155s41GkKgRBj1bT7FIstY447fh7
        NrL+Y9g6E3hUoup4sh2A4O0fkDEB
X-Google-Smtp-Source: APXvYqzEB9/J7b1QjW8h1fUyP6Qmptb0s33s1keuBeCMZm1l7u56kP5ukjXfiNoaeQnUfZEkSg508w==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr10844147plo.279.1581550799359;
        Wed, 12 Feb 2020 15:39:59 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id k5sm296664pju.29.2020.02.12.15.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:39:58 -0800 (PST)
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
        Joel Fernandes <joel@joelfernandes.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 4/8] mm: check fatal signal pending of target process
Date:   Wed, 12 Feb 2020 15:39:42 -0800
Message-Id: <20200212233946.246210-5-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
In-Reply-To: <20200212233946.246210-1-minchan@kernel.org>
References: <20200212233946.246210-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Bail out to prevent unnecessary CPU overhead if target process ha
pending fatal signal during MADV_COLD| MADV_PAGEOUT operation.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index bb04c7897eb9..276b9d81c1dd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -36,6 +36,7 @@
 struct madvise_walk_private {
 	struct mmu_gather *tlb;
 	bool pageout;
+	struct task_struct *task;
 };
 
 /*
@@ -316,6 +317,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	if (fatal_signal_pending(private->task))
+		return -EINTR;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		pmd_t orig_pmd;
@@ -471,12 +475,14 @@ static const struct mm_walk_ops cold_walk_ops = {
 };
 
 static void madvise_cold_page_range(struct mmu_gather *tlb,
+			     struct task_struct *task,
 			     struct vm_area_struct *vma,
 			     unsigned long addr, unsigned long end)
 {
 	struct madvise_walk_private walk_private = {
 		.pageout = false,
 		.tlb = tlb,
+		.task = task,
 	};
 
 	tlb_start_vma(tlb, vma);
@@ -484,7 +490,8 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-static long madvise_cold(struct vm_area_struct *vma,
+static long madvise_cold(struct task_struct *task,
+			struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
 {
@@ -497,19 +504,21 @@ static long madvise_cold(struct vm_area_struct *vma,
 
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
+		.task = task,
 	};
 
 	tlb_start_vma(tlb, vma);
@@ -533,7 +542,8 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
 }
 
-static long madvise_pageout(struct vm_area_struct *vma,
+static long madvise_pageout(struct task_struct *task,
+			struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
 {
@@ -549,7 +559,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
-	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
+	madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb, start_addr, end_addr);
 
 	return 0;
@@ -927,7 +937,8 @@ static int madvise_inject_error(int behavior,
 #endif
 
 static long
-madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
+madvise_vma(struct task_struct *task, struct vm_area_struct *vma,
+		struct vm_area_struct **prev,
 		unsigned long start, unsigned long end, int behavior)
 {
 	switch (behavior) {
@@ -936,9 +947,9 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
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
@@ -1143,7 +1154,7 @@ int do_madvise(struct task_struct *task, unsigned long start,
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, tmp, behavior);
+		error = madvise_vma(task, vma, &prev, start, tmp, behavior);
 		if (error)
 			goto out;
 		start = tmp;
-- 
2.25.0.225.g125e21ebc7-goog

