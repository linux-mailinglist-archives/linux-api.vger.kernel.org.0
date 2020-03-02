Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97EBB17641B
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 20:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgCBTgv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 14:36:51 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:55199 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbgCBTgr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Mar 2020 14:36:47 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so231758pjb.4;
        Mon, 02 Mar 2020 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2zELO0pXNHVNnEg0MBIPznZHBtLOycXK0nlVtImdKo=;
        b=PAzwG+yhEbaBhr9u+SnVfypO8PjkR7/DXaWSeTqBeJJDqlGyx4HdAjzmvBYKvWjTyM
         62APTEt8o7mpnHqGpm5hQRK73twpZHbU6te9ZtekGqY/K6cFYoW+91EEsObzhFLEewvA
         94H/BotmZyp5Wvfe1TG6y/SsNb2eeRbTlbTuoVOrASVtzsPPiZ7G0arlCirm0Fmlvd08
         PR6goKzXlelvQjgxe0Xl6avWaqL72hY6n6D7q3t6VhKB7JNZTXSrIOLK5qtEHrTEvb94
         DgCCieWO2QVrMMeYMzRg1HJhUy/4jXDasVw7xvLJ9W35CKZwyHyMY13wi/VYkj4Bl+eG
         PRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=s2zELO0pXNHVNnEg0MBIPznZHBtLOycXK0nlVtImdKo=;
        b=ntDTeCCNSuxMjeoOpBL7kuuZeNu5VWuwLEiKbuy3x8YFxA9/jl9/e5DBhi/8FKVDaa
         70C31KOVqsElsPTRsW52UHv5HisDeJEYrd9HQ68pI5P8jAMufZQOk0P6eGSrWS5ravBP
         tFV+EOml14kFJLnlwCs79QIMhiAD+vVP08Ac2d3OiXoDnX1LwbQrTpFuZ3XoYKGkrbvg
         qXug1oGfvArqZOvPcM4BJg1mVhOW7L5rZq4myLJZSGNgdskU71ihPNpFtDEfuJModLHw
         Bq6vo0GnZsshnGloA0yiWhzRZWsd0/P39vsp7K4xx0/97/VPmsd8JUHHt1uFeCCd1VrM
         JwyQ==
X-Gm-Message-State: ANhLgQ2lzrMbzW/D7u5OZxUwCOMiS9/04kxk/fGANSaUdl3lNdmr3GCf
        M1G1N7L8tX+/CbiEZbwwm14=
X-Google-Smtp-Source: ADFU+vuCN+hZoW3eWaVKy2lfwyQyeXd2iNvJdu5DasPNMIZzpt5ghLScTJBTDyNimuUZlbB+XdRxzQ==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr623488plp.252.1583177805961;
        Mon, 02 Mar 2020 11:36:45 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id hg6sm35441pjb.22.2020.03.02.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 11:36:44 -0800 (PST)
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
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v7 3/7] mm: check fatal signal pending of target process
Date:   Mon,  2 Mar 2020 11:36:26 -0800
Message-Id: <20200302193630.68771-4-minchan@kernel.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200302193630.68771-1-minchan@kernel.org>
References: <20200302193630.68771-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Bail out to prevent unnecessary CPU overhead if target process has
pending fatal signal during (MADV_COLD|MADV_PAGEOUT) operation.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 349473fc6683..6543f2bfc3d8 100644
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

