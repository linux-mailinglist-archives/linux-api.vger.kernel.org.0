Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D6415E951
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2020 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394487AbgBNRGQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Feb 2020 12:06:16 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33387 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389048AbgBNRGQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Feb 2020 12:06:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id ay11so3962174plb.0;
        Fri, 14 Feb 2020 09:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6O9W6E1G75ixyJ8UyGK5wFctz4OpO1Qs9ZxeNViXQcw=;
        b=fJSfsGyC407k83sWyG04J1cZ5klu0v6fArOiL05DGBT/mDIowCmGclgtwynM9GsMWV
         GojNIdYdoVHdVvWV6RKNJ5XkR1rRdI958VtKnYBRNlT6v8zyUyN+KSKoHtEz1jblIxfK
         m15PLqaDSmHFUMj6vokz97v9OGjB9GqZPpJnlziFqAuCcBaajX+Fk/ZyQvYUAit8/dtl
         QV8QJeXu6U6z2uId7L3VOkviLHd1Rg3qfF6ZTt/0pzckKFT4T7e7K2oo68vo5mM9TsHA
         Uj/2a4C9nJCcOgxA82BwmXtxpb2nryOdfO3qNPgrKuRE6MQfhlZksKKlv6YIPpQbSFdI
         0/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6O9W6E1G75ixyJ8UyGK5wFctz4OpO1Qs9ZxeNViXQcw=;
        b=CDS6MSAw1fb29pVY17Jkb4EsDOOtaAC6XVRfl7HCKbD+t7YwAKPU05fvYptuqXwasd
         KRsDPFTdOWPAAsQtbyTe7D1KDUasXhkJOSCUAalpu9ms8Pbk6FslPSSTSxND9b/dKKYF
         fj383+vrflazrxVGSXWJiMPzONRAqcxsKf8Av90zZY0w8/gxLKiRy11MrcbVO1PKH0oO
         dJMRFXDfphAm9tGENHwiaoqfIjDqekfrlEntJ8OXmYKk0snx60pE6bJcyplPDf8f0lTs
         KwI6uulf2dlx6bl9VTbdR0x1N0ksqTqg7vlSMGJRgPlQlSUsH7qunNK6xNnrViiw2/Y3
         02pA==
X-Gm-Message-State: APjAAAWS9G40f6uEUOVz+9F0GOM6q7Leh1HWu2m7A0ctemJKM5gcUEDv
        AqYPIF8IADdEmRIaOqm5/3M=
X-Google-Smtp-Source: APXvYqxf5zE4iH5O+upXaWZUjVzDrEgNkGr2eak0SnNRXweSahgmncbHlkn17pa7YUG4jUsWitWu4w==
X-Received: by 2002:a17:90a:20c4:: with SMTP id f62mr4957285pjg.70.1581699975081;
        Fri, 14 Feb 2020 09:06:15 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a13sm7662924pfg.65.2020.02.14.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 09:06:11 -0800 (PST)
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
Subject: [PATCH v5 3/7] mm: check fatal signal pending of target process
Date:   Fri, 14 Feb 2020 09:05:16 -0800
Message-Id: <20200214170520.160271-4-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200214170520.160271-1-minchan@kernel.org>
References: <20200214170520.160271-1-minchan@kernel.org>
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
index fadc8d758a46..fca3a9e9bd39 100644
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
@@ -929,7 +939,8 @@ static int madvise_inject_error(int behavior,
 #endif
 
 static long
-madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
+madvise_vma(struct task_struct *task, struct vm_area_struct *vma,
+		struct vm_area_struct **prev,
 		unsigned long start, unsigned long end, int behavior)
 {
 	switch (behavior) {
@@ -938,9 +949,9 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
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
@@ -1140,7 +1151,7 @@ int do_madvise(struct task_struct *task, struct mm_struct *mm,
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, tmp, behavior);
+		error = madvise_vma(task, vma, &prev, start, tmp, behavior);
 		if (error)
 			goto out;
 		start = tmp;
-- 
2.25.0.265.gbab2e86ba0-goog

