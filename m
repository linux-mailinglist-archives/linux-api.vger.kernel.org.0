Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D11204061
	for <lists+linux-api@lfdr.de>; Mon, 22 Jun 2020 21:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgFVT3d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jun 2020 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgFVT3X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Jun 2020 15:29:23 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F67C061573;
        Mon, 22 Jun 2020 12:29:23 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b5so8653309pgm.8;
        Mon, 22 Jun 2020 12:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Ul/VyioCZgSyOOWRzsGy5FBJiYJTcxPpaUmWpPopUw=;
        b=aSwM6DsYB1/dpxaO1GdMEYGz5So4Bsx1gHNxIcRQmwSHWyd2LDIyy526R7Dm3vg/U0
         hPW8FovOHjF3ncjzSwNS49l65o4mEwt+stfbXxbXTtabuP9VzJKt5kNpsKqf8gWbm7e8
         Jy7KLq/Oa8nWPd65hZpHq6atvB/hDkCkGB5hzYKgwST5ssIXtMTaX607CWH2DAsebuZc
         TknY4iL3TlMu7nX6yjVZb1gWo1BmzG1feeMDspM9plW9Ecx/qLNW1DSCzw3r6Hp5ot3y
         5HWMB02qByZbhRTIdJ8xnRPm+YzVrRE+zMT+QXXnuQNRfRXjGlzZvKk1PtjLFbK8TCW7
         Zqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8Ul/VyioCZgSyOOWRzsGy5FBJiYJTcxPpaUmWpPopUw=;
        b=tizh9Qd0OK37FJWAgfKljBC95Ijjiw8oKgWCjVSfGUDJFuOpjc3nc11Lg9JxlqdTDJ
         uoyUOFcSv1rfgC1C+n1StKCJ3807mFHHRZZVzaFJ5jiiy1QYtOZrOEw+h/VshX2Nh/Yy
         vawH70gORfmVcS8fgGv+XclBgyC3mNg8VMIa5c97/cO8YTnHLOXpEkPXvsGgNacC+/9z
         1++UAdzWcQlmP2dYwLdAuDJzrFXB4opxTNat3F47Jx9xDOTMXC/rMcpb0jmks3/1Bn3h
         Fa0MPnXC7e1PKJMPNekh65GJhgugeKQLgyJSjX+77zcwFL77tVlNfbO23XkFY68jvLMc
         pN9A==
X-Gm-Message-State: AOAM5317J7vIKpPmmWHRdgpd1GVJ97/6iXR+2YBev1MKOBI3gFwkhUiO
        NGgE49GND1o8GmNI0Pj3aJj0J/XD
X-Google-Smtp-Source: ABdhPJw2WQbvHFWoo0cnD9rBNEULjMl/Sezb/fUY29hFdcN9wqV/dwQmcM+u/jI25YdJul3DpG7Ejg==
X-Received: by 2002:a63:cd4d:: with SMTP id a13mr14285541pgj.49.1592854163147;
        Mon, 22 Jun 2020 12:29:23 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id mu17sm264603pjb.53.2020.06.22.12.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:29:21 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
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
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: [PATCH v8 4/4] mm/madvise: check fatal signal pending of target process
Date:   Mon, 22 Jun 2020 12:29:00 -0700
Message-Id: <20200622192900.22757-5-minchan@kernel.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200622192900.22757-1-minchan@kernel.org>
References: <20200622192900.22757-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Bail out to prevent unnecessary CPU overhead if target process has pending
fatal signal during (MADV_COLD|MADV_PAGEOUT) operation.

Link: http://lkml.kernel.org/r/20200302193630.68771-4-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Daniel Colascione <dancol@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Dias <joaodias@google.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: <linux-man@vger.kernel.org>
---
 mm/madvise.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 23abca3f93fa..a16dba21cdf6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -39,6 +39,7 @@
 struct madvise_walk_private {
 	struct mmu_gather *tlb;
 	bool pageout;
+	struct task_struct *target_task;
 };
 
 /*
@@ -319,6 +320,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 	if (fatal_signal_pending(current))
 		return -EINTR;
 
+	if (private->target_task &&
+			fatal_signal_pending(private->target_task))
+		return -EINTR;
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	if (pmd_trans_huge(*pmd)) {
 		pmd_t orig_pmd;
@@ -480,12 +485,14 @@ static const struct mm_walk_ops cold_walk_ops = {
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
@@ -493,7 +500,8 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 	tlb_end_vma(tlb, vma);
 }
 
-static long madvise_cold(struct vm_area_struct *vma,
+static long madvise_cold(struct task_struct *task,
+			struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
 {
@@ -506,19 +514,21 @@ static long madvise_cold(struct vm_area_struct *vma,
 
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
@@ -542,7 +552,8 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
 		inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
 }
 
-static long madvise_pageout(struct vm_area_struct *vma,
+static long madvise_pageout(struct task_struct *task,
+			struct vm_area_struct *vma,
 			struct vm_area_struct **prev,
 			unsigned long start_addr, unsigned long end_addr)
 {
@@ -558,7 +569,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
-	madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
+	madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);
 	tlb_finish_mmu(&tlb, start_addr, end_addr);
 
 	return 0;
@@ -938,7 +949,8 @@ static int madvise_inject_error(int behavior,
 #endif
 
 static long
-madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
+madvise_vma(struct task_struct *task, struct vm_area_struct *vma,
+		struct vm_area_struct **prev,
 		unsigned long start, unsigned long end, int behavior)
 {
 	switch (behavior) {
@@ -947,9 +959,9 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
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
@@ -1166,7 +1178,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
 			tmp = end;
 
 		/* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
-		error = madvise_vma(vma, &prev, start, tmp, behavior);
+		error = madvise_vma(target_task, vma, &prev,
+					start, tmp, behavior);
 		if (error)
 			goto out;
 		start = tmp;
-- 
2.27.0.111.gc72c7da667-goog

