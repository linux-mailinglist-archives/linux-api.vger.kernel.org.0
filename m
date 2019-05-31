Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED031193
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 17:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEaPtN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 11:49:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40689 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfEaPtN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 11:49:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so6445452pfn.7
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUFtp2yOlfQq1CKiEF9tMKsKqyXjNbP4nir3ck8sFaE=;
        b=GhRpfx2A5bxND9pas2Gk+Vdmrk2F/pXrfRMH0ecWkCkA8JZ3hSvXhkBVcDnQHmN8PB
         ITmxk4tJ8dqEYWINfudSzwLTJrucAkYYaawM8P2s0bJ2xU3V2adfUY8LuZfNbBu6BioV
         fFVXURHP/e4drwXX+jAAM0tPncLDWYozgC1lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lUFtp2yOlfQq1CKiEF9tMKsKqyXjNbP4nir3ck8sFaE=;
        b=Wouk15ypgdIO25aoXTdyNGB0TrcAI19GDAloDAYqd8IB3hDVXBWDVG0fmJjN0NICWO
         ubcFb96gog5o/wUyhv9bL7k3Ei0L98Wh62Jc4cPljjueFqCnJrZ4ZLyErpp/T7J+aLTo
         8VJX9rMCCMMujFgqBDKUIztu5JTWwNZUnboT7c7/xxNwfie66W289DdaGw3g5DF8ll9f
         TuH8S1Xq+SytK918heqjuHEW4+TrDJN8I22xZz+kVlHzgJpSD+p7FNUIyxNeVbuo+sGX
         d5Osg4K7O+CQesn4YooKoiI7KaGg1VrN3B1NG1opzH8xuK+2GYHbRFPVYGzy/eogxYmu
         LdMw==
X-Gm-Message-State: APjAAAUall1f3UORS+bHo+PMIwkvCPhF5mCbAX6aP+Y0tal1xaRmimoD
        Wnz+vyNQc+uStwlVrWnFi0pHww==
X-Google-Smtp-Source: APXvYqz6ur5HqPd6uxOkgbZFaVWa+IJqvEKWFNcRchWcH8iA4hDtSasywAKZwQnFBxhrX6Tz7WF2XA==
X-Received: by 2002:a17:90b:d8c:: with SMTP id bg12mr10399048pjb.70.1559317752008;
        Fri, 31 May 2019 08:49:12 -0700 (PDT)
Received: from luigi2.mtv.corp.google.com ([2620:15c:202:1:2c30:5512:25f8:631d])
        by smtp.gmail.com with ESMTPSA id e127sm2916716pfe.98.2019.05.31.08.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 08:49:10 -0700 (PDT)
From:   semenzato@chromium.org
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     sonnyrao@chromium.org, linux-api@vger.kernel.org,
        Luigi Semenzato <semenzato@chromium.org>,
        Yu Zhao <yuzhao@chromium.org>
Subject: [PATCH v3 1/1] mm: smaps: split PSS into components
Date:   Fri, 31 May 2019 08:46:45 -0700
Message-Id: <20190531154645.39365-1-semenzato@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Luigi Semenzato <semenzato@chromium.org>

Report separate components (anon, file, and shmem)
for PSS in smaps_rollup.

This helps understand and tune the memory manager behavior
in consumer devices, particularly mobile devices.  Many of
them (e.g. chromebooks and Android-based devices) use zram
for anon memory, and perform disk reads for discarded file
pages.  The difference in latency is large (e.g. reading
a single page from SSD is 30 times slower than decompressing
a zram page on one popular device), thus it is useful to know
how much of the PSS is anon vs. file.

This patch also removes a small code duplication in smaps_account,
which would have gotten worse otherwise.

Also added missing entry for smaps_rollup in
Documentation/filesystems/proc.txt.

Acked-by: Yu Zhao <yuzhao@chromium.org>
Signed-off-by: Luigi Semenzato <semenzato@chromium.org>
---
 Documentation/filesystems/proc.txt |  6 +-
 fs/proc/task_mmu.c                 | 91 ++++++++++++++++++++----------
 2 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..b48e85e19877 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -153,9 +153,11 @@ Table 1-1: Process specific entries in /proc
 		symbol the task is blocked in - or "0" if not blocked.
  pagemap	Page table
  stack		Report full stack trace, enable via CONFIG_STACKTRACE
- smaps		an extension based on maps, showing the memory consumption of
+ smaps		An extension based on maps, showing the memory consumption of
 		each mapping and flags associated with it
- numa_maps	an extension based on maps, showing the memory locality and
+ smaps_rollup	Accumulated smaps stats for all mappings of the process.  This
+		can be derived from smaps, but is faster and more convenient
+ numa_maps	An extension based on maps, showing the memory locality and
 		binding policy as well as mem usage (in pages) of each mapping.
 ..............................................................................
 
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 01d4eb0e6bd1..ed3b952f0d30 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -417,17 +417,53 @@ struct mem_size_stats {
 	unsigned long shared_hugetlb;
 	unsigned long private_hugetlb;
 	u64 pss;
+	u64 pss_anon;
+	u64 pss_file;
+	u64 pss_shmem;
 	u64 pss_locked;
 	u64 swap_pss;
 	bool check_shmem_swap;
 };
 
+static void smaps_page_accumulate(struct mem_size_stats *mss,
+		struct page *page, unsigned long size, unsigned long pss,
+		bool dirty, bool locked, bool private)
+{
+	mss->pss += pss;
+
+	if (PageAnon(page))
+		mss->pss_anon += pss;
+	else if (PageSwapBacked(page))
+		mss->pss_shmem += pss;
+	else
+		mss->pss_file += pss;
+
+	if (locked)
+		mss->pss_locked += pss;
+
+	if (dirty || PageDirty(page)) {
+		if (private)
+			mss->private_dirty += size;
+		else
+			mss->shared_dirty += size;
+	} else {
+		if (private)
+			mss->private_clean += size;
+		else
+			mss->shared_clean += size;
+	}
+}
+
 static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		bool compound, bool young, bool dirty, bool locked)
 {
 	int i, nr = compound ? 1 << compound_order(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
 
+	/*
+	 * First accumulate quantities that depend only on |size| and the type
+	 * of the compound page.
+	 */
 	if (PageAnon(page)) {
 		mss->anonymous += size;
 		if (!PageSwapBacked(page) && !dirty && !PageDirty(page))
@@ -440,42 +476,24 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 		mss->referenced += size;
 
 	/*
+	 * Then accumulate quantities that may depend on sharing, or that may
+	 * differ page-by-page.
+	 *
 	 * page_count(page) == 1 guarantees the page is mapped exactly once.
 	 * If any subpage of the compound page mapped with PTE it would elevate
 	 * page_count().
 	 */
 	if (page_count(page) == 1) {
-		if (dirty || PageDirty(page))
-			mss->private_dirty += size;
-		else
-			mss->private_clean += size;
-		mss->pss += (u64)size << PSS_SHIFT;
-		if (locked)
-			mss->pss_locked += (u64)size << PSS_SHIFT;
+		smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
+			locked, true);
 		return;
 	}
-
 	for (i = 0; i < nr; i++, page++) {
 		int mapcount = page_mapcount(page);
-		unsigned long pss = (PAGE_SIZE << PSS_SHIFT);
-
-		if (mapcount >= 2) {
-			if (dirty || PageDirty(page))
-				mss->shared_dirty += PAGE_SIZE;
-			else
-				mss->shared_clean += PAGE_SIZE;
-			mss->pss += pss / mapcount;
-			if (locked)
-				mss->pss_locked += pss / mapcount;
-		} else {
-			if (dirty || PageDirty(page))
-				mss->private_dirty += PAGE_SIZE;
-			else
-				mss->private_clean += PAGE_SIZE;
-			mss->pss += pss;
-			if (locked)
-				mss->pss_locked += pss;
-		}
+		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
+
+		smaps_page_accumulate(mss, page, PAGE_SIZE, pss / mapcount,
+			dirty, locked, mapcount < 2);
 	}
 }
 
@@ -754,10 +772,23 @@ static void smap_gather_stats(struct vm_area_struct *vma,
 		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
 
 /* Show the contents common for smaps and smaps_rollup */
-static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss)
+static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
+	bool rollup_mode)
 {
 	SEQ_PUT_DEC("Rss:            ", mss->resident);
 	SEQ_PUT_DEC(" kB\nPss:            ", mss->pss >> PSS_SHIFT);
+	if (rollup_mode) {
+		/*
+		 * These are meaningful only for smaps_rollup, otherwise two of
+		 * them are zero, and the other one is the same as Pss.
+		 */
+		SEQ_PUT_DEC(" kB\nPss_Anon:       ",
+			mss->pss_anon >> PSS_SHIFT);
+		SEQ_PUT_DEC(" kB\nPss_File:       ",
+			mss->pss_file >> PSS_SHIFT);
+		SEQ_PUT_DEC(" kB\nPss_Shmem:      ",
+			mss->pss_shmem >> PSS_SHIFT);
+	}
 	SEQ_PUT_DEC(" kB\nShared_Clean:   ", mss->shared_clean);
 	SEQ_PUT_DEC(" kB\nShared_Dirty:   ", mss->shared_dirty);
 	SEQ_PUT_DEC(" kB\nPrivate_Clean:  ", mss->private_clean);
@@ -794,7 +825,7 @@ static int show_smap(struct seq_file *m, void *v)
 	SEQ_PUT_DEC(" kB\nMMUPageSize:    ", vma_mmu_pagesize(vma));
 	seq_puts(m, " kB\n");
 
-	__show_smap(m, &mss);
+	__show_smap(m, &mss, false);
 
 	seq_printf(m, "THPeligible:    %d\n", transparent_hugepage_enabled(vma));
 
@@ -841,7 +872,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
 
-	__show_smap(m, &mss);
+	__show_smap(m, &mss, true);
 
 	release_task_mempolicy(priv);
 	up_read(&mm->mmap_sem);
-- 
2.22.0.rc1.257.g3120a18244-goog

