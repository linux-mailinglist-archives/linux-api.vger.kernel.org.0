Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C85B0757
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiIGOp5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiIGOpr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3C5A165
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id n11-20020a17090ade8b00b00200ab47f82fso2164464pjv.4
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=xrQ4TrYfD+lFwNA3Es7xRM040CtuMf3VRQk/6f94mag=;
        b=eXipDcN/+aDTnvLaUBfW0QgaIrp/VFKb7gr5EMTWx9fa1GLfNKR/V3T3RLrevtevne
         1rMxt9Ny7/gmux5c0lpbE99D00nG6Si7HuiNpV1bDW8JLTUF3dOS4JhZmIFYoYZSslTC
         gax9Aj9JpuiFOUcLXkPdM0fwH5jLpShsn/QEJMeor47WiEbL3mbXHX7Szzda8Hf3XDHc
         Yvtm4NnjUAb9MLsBFpJh7ADl8mZZv4+gXnjNjNzRTUKbRnJ49wBb4SK5FrqHj3rHywgF
         lE6Nr+KH/N+9V0IshbvKpPtOFX8RVT7e6Q1sDkQ/TmsJwW+XOf1Tvtyn9i4Y3l7257pz
         RPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=xrQ4TrYfD+lFwNA3Es7xRM040CtuMf3VRQk/6f94mag=;
        b=gOsX4o34iiJif6ADzHAhZdIKN1CD9cTNMARCSCXKE0O1a2WZegf/KJg0BK0K2ISH31
         k2Gjh7BKXefvCGSyqfUlhIzCMJ9Z8uLYl3olrma4EcgXL2WjbCvPRkXQ2I6dZy3O2Hq1
         ILcfEuUDaOppsh8Um+mtrkIe6wVSNYoXhlcL15DHkcZPjZc2/ulzAuXT/SGJcRt+z1l8
         eAc3mMCKn7n47zeLgxNmZtHxPZIyz8WDR9HeWSXNwzeu7wPieBT+F9dJNg/PA73B/uMV
         wjWqn/XAFNCm0/z5txQNX3iIHzf5uIKMzurjrY7kezP2VZT26evA2LdRZ36UGS+IjQjA
         ILWA==
X-Gm-Message-State: ACgBeo2ydUu2IV0pZD+mwYl6+5zmwMwD2Y+0NAxkEBLShD+cdJnTc+KN
        Vj5t5fis2Tg9uL5i2+mOwac7EtgN4Akh
X-Google-Smtp-Source: AA6agR5FxQyMetjLiD4XV1qK31nkJnVXjwZ5eQsYSpWqpkvS2IgyLr4NgvHWk3+Xk5JgUdMsInmCz96AG9dX
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:16d6:b0:53b:3e58:1c6f with SMTP
 id l22-20020a056a0016d600b0053b3e581c6fmr4194206pfc.7.1662561944629; Wed, 07
 Sep 2022 07:45:44 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:17 -0700
In-Reply-To: <20220907144521.3115321-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-7-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 06/10] selftests/vm: modularize thp collapse
 memory operations
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Modularize operations to setup, cleanup, fault, and check for huge
pages, for a given memory type.  This allows reusing existing tests
with additional memory types by defining new memory operations.
Following patches will add file and shmem memory types.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/vm/khugepaged.c | 366 +++++++++++++-----------
 1 file changed, 200 insertions(+), 166 deletions(-)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index e5c602f7a18b..b4b1709507a5 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -28,8 +28,16 @@ static int hpage_pmd_nr;
 #define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
 #define PID_SMAPS "/proc/self/smaps"
 
+struct mem_ops {
+	void *(*setup_area)(int nr_hpages);
+	void (*cleanup_area)(void *p, unsigned long size);
+	void (*fault)(void *p, unsigned long start, unsigned long end);
+	bool (*check_huge)(void *addr, int nr_hpages);
+};
+
 struct collapse_context {
-	void (*collapse)(const char *msg, char *p, int nr_hpages, bool expect);
+	void (*collapse)(const char *msg, char *p, int nr_hpages,
+			 struct mem_ops *ops, bool expect);
 	bool enforce_pte_scan_limits;
 };
 
@@ -353,11 +361,6 @@ static void save_settings(void)
 	signal(SIGQUIT, restore_settings);
 }
 
-static bool check_huge(void *addr, int nr_hpages)
-{
-	return check_huge_anon(addr, nr_hpages, hpage_pmd_size);
-}
-
 #define MAX_LINE_LENGTH 500
 static bool check_swap(void *addr, unsigned long size)
 {
@@ -431,18 +434,25 @@ static void fill_memory(int *p, unsigned long start, unsigned long end)
  * Returns pmd-mapped hugepage in VMA marked VM_HUGEPAGE, filled with
  * validate_memory()'able contents.
  */
-static void *alloc_hpage(void)
+static void *alloc_hpage(struct mem_ops *ops)
 {
-	void *p;
+	void *p = ops->setup_area(1);
 
-	p = alloc_mapping(1);
+	ops->fault(p, 0, hpage_pmd_size);
+	if (madvise(p, hpage_pmd_size, MADV_HUGEPAGE)) {
+		perror("madvise(MADV_HUGEPAGE)");
+		exit(EXIT_FAILURE);
+	}
 	printf("Allocate huge page...");
-	madvise(p, hpage_pmd_size, MADV_HUGEPAGE);
-	fill_memory(p, 0, hpage_pmd_size);
-	if (check_huge(p, 1))
-		success("OK");
-	else
-		fail("Fail");
+	if (madvise(p, hpage_pmd_size, MADV_COLLAPSE)) {
+		perror("madvise(MADV_COLLAPSE)");
+		exit(EXIT_FAILURE);
+	}
+	if (!ops->check_huge(p, 1)) {
+		perror("madvise(MADV_COLLAPSE)");
+		exit(EXIT_FAILURE);
+	}
+	success("OK");
 	return p;
 }
 
@@ -459,18 +469,40 @@ static void validate_memory(int *p, unsigned long start, unsigned long end)
 	}
 }
 
-static void madvise_collapse(const char *msg, char *p, int nr_hpages,
-			     bool expect)
+static void *anon_setup_area(int nr_hpages)
+{
+	return alloc_mapping(nr_hpages);
+}
+
+static void anon_cleanup_area(void *p, unsigned long size)
+{
+	munmap(p, size);
+}
+
+static void anon_fault(void *p, unsigned long start, unsigned long end)
+{
+	fill_memory(p, start, end);
+}
+
+static bool anon_check_huge(void *addr, int nr_hpages)
+{
+	return check_huge_anon(addr, nr_hpages, hpage_pmd_size);
+}
+
+static struct mem_ops anon_ops = {
+	.setup_area = &anon_setup_area,
+	.cleanup_area = &anon_cleanup_area,
+	.fault = &anon_fault,
+	.check_huge = &anon_check_huge,
+};
+
+static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
+			       struct mem_ops *ops, bool expect)
 {
 	int ret;
 	struct settings settings = *current_settings();
 
 	printf("%s...", msg);
-	/* Sanity check */
-	if (!check_huge(p, 0)) {
-		printf("Unexpected huge page\n");
-		exit(EXIT_FAILURE);
-	}
 
 	/*
 	 * Prevent khugepaged interference and tests that MADV_COLLAPSE
@@ -482,9 +514,10 @@ static void madvise_collapse(const char *msg, char *p, int nr_hpages,
 	/* Clear VM_NOHUGEPAGE */
 	madvise(p, nr_hpages * hpage_pmd_size, MADV_HUGEPAGE);
 	ret = madvise(p, nr_hpages * hpage_pmd_size, MADV_COLLAPSE);
+
 	if (((bool)ret) == expect)
 		fail("Fail: Bad return value");
-	else if (check_huge(p, nr_hpages) != expect)
+	else if (!ops->check_huge(p, expect ? nr_hpages : 0))
 		fail("Fail: check_huge()");
 	else
 		success("OK");
@@ -492,14 +525,26 @@ static void madvise_collapse(const char *msg, char *p, int nr_hpages,
 	pop_settings();
 }
 
+static void madvise_collapse(const char *msg, char *p, int nr_hpages,
+			     struct mem_ops *ops, bool expect)
+{
+	/* Sanity check */
+	if (!ops->check_huge(p, 0)) {
+		printf("Unexpected huge page\n");
+		exit(EXIT_FAILURE);
+	}
+	__madvise_collapse(msg, p, nr_hpages, ops, expect);
+}
+
 #define TICK 500000
-static bool wait_for_scan(const char *msg, char *p, int nr_hpages)
+static bool wait_for_scan(const char *msg, char *p, int nr_hpages,
+			  struct mem_ops *ops)
 {
 	int full_scans;
 	int timeout = 6; /* 3 seconds */
 
 	/* Sanity check */
-	if (!check_huge(p, 0)) {
+	if (!ops->check_huge(p, 0)) {
 		printf("Unexpected huge page\n");
 		exit(EXIT_FAILURE);
 	}
@@ -511,7 +556,7 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages)
 
 	printf("%s...", msg);
 	while (timeout--) {
-		if (check_huge(p, nr_hpages))
+		if (ops->check_huge(p, nr_hpages))
 			break;
 		if (read_num("khugepaged/full_scans") >= full_scans)
 			break;
@@ -525,19 +570,20 @@ static bool wait_for_scan(const char *msg, char *p, int nr_hpages)
 }
 
 static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
-				bool expect)
+				struct mem_ops *ops, bool expect)
 {
-	if (wait_for_scan(msg, p, nr_hpages)) {
+	if (wait_for_scan(msg, p, nr_hpages, ops)) {
 		if (expect)
 			fail("Timeout");
 		else
 			success("OK");
 		return;
-	} else if (check_huge(p, nr_hpages) == expect) {
+	}
+
+	if (ops->check_huge(p, expect ? nr_hpages : 0))
 		success("OK");
-	} else {
+	else
 		fail("Fail");
-	}
 }
 
 static void alloc_at_fault(void)
@@ -551,7 +597,7 @@ static void alloc_at_fault(void)
 	p = alloc_mapping(1);
 	*p = 1;
 	printf("Allocate huge page on fault...");
-	if (check_huge(p, 1))
+	if (check_huge_anon(p, 1, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
@@ -560,49 +606,48 @@ static void alloc_at_fault(void)
 
 	madvise(p, page_size, MADV_DONTNEED);
 	printf("Split huge PMD on MADV_DONTNEED...");
-	if (check_huge(p, 0))
+	if (check_huge_anon(p, 0, hpage_pmd_size))
 		success("OK");
 	else
 		fail("Fail");
 	munmap(p, hpage_pmd_size);
 }
 
-static void collapse_full(struct collapse_context *c)
+static void collapse_full(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;
 	int nr_hpages = 4;
 	unsigned long size = nr_hpages * hpage_pmd_size;
 
-	p = alloc_mapping(nr_hpages);
-	fill_memory(p, 0, size);
+	p = ops->setup_area(nr_hpages);
+	ops->fault(p, 0, size);
 	c->collapse("Collapse multiple fully populated PTE table", p, nr_hpages,
-		    true);
+		    ops, true);
 	validate_memory(p, 0, size);
-	munmap(p, size);
+	ops->cleanup_area(p, size);
 }
 
-static void collapse_empty(struct collapse_context *c)
+static void collapse_empty(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;
 
-	p = alloc_mapping(1);
-	c->collapse("Do not collapse empty PTE table", p, 1, false);
-	munmap(p, hpage_pmd_size);
+	p = ops->setup_area(1);
+	c->collapse("Do not collapse empty PTE table", p, 1, ops, false);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_single_pte_entry(struct collapse_context *c)
+static void collapse_single_pte_entry(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;
 
-	p = alloc_mapping(1);
-	fill_memory(p, 0, page_size);
+	p = ops->setup_area(1);
+	ops->fault(p, 0, page_size);
 	c->collapse("Collapse PTE table with single PTE entry present", p,
-		    1, true);
-	validate_memory(p, 0, page_size);
-	munmap(p, hpage_pmd_size);
+		    1, ops, true);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_max_ptes_none(struct collapse_context *c)
+static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *ops)
 {
 	int max_ptes_none = hpage_pmd_nr / 2;
 	struct settings settings = *current_settings();
@@ -611,30 +656,30 @@ static void collapse_max_ptes_none(struct collapse_context *c)
 	settings.khugepaged.max_ptes_none = max_ptes_none;
 	push_settings(&settings);
 
-	p = alloc_mapping(1);
+	p = ops->setup_area(1);
 
-	fill_memory(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
+	ops->fault(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
 	c->collapse("Maybe collapse with max_ptes_none exceeded", p, 1,
-		    !c->enforce_pte_scan_limits);
+		    ops, !c->enforce_pte_scan_limits);
 	validate_memory(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
 
 	if (c->enforce_pte_scan_limits) {
-		fill_memory(p, 0, (hpage_pmd_nr - max_ptes_none) * page_size);
-		c->collapse("Collapse with max_ptes_none PTEs empty", p, 1,
+		ops->fault(p, 0, (hpage_pmd_nr - max_ptes_none) * page_size);
+		c->collapse("Collapse with max_ptes_none PTEs empty", p, 1, ops,
 			    true);
 		validate_memory(p, 0,
 				(hpage_pmd_nr - max_ptes_none) * page_size);
 	}
-
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 	pop_settings();
 }
 
-static void collapse_swapin_single_pte(struct collapse_context *c)
+static void collapse_swapin_single_pte(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;
-	p = alloc_mapping(1);
-	fill_memory(p, 0, hpage_pmd_size);
+
+	p = ops->setup_area(1);
+	ops->fault(p, 0, hpage_pmd_size);
 
 	printf("Swapout one page...");
 	if (madvise(p, page_size, MADV_PAGEOUT)) {
@@ -648,20 +693,21 @@ static void collapse_swapin_single_pte(struct collapse_context *c)
 		goto out;
 	}
 
-	c->collapse("Collapse with swapping in single PTE entry", p, 1, true);
+	c->collapse("Collapse with swapping in single PTE entry", p, 1, ops,
+		    true);
 	validate_memory(p, 0, hpage_pmd_size);
 out:
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_max_ptes_swap(struct collapse_context *c)
+static void collapse_max_ptes_swap(struct collapse_context *c, struct mem_ops *ops)
 {
 	int max_ptes_swap = read_num("khugepaged/max_ptes_swap");
 	void *p;
 
-	p = alloc_mapping(1);
+	p = ops->setup_area(1);
+	ops->fault(p, 0, hpage_pmd_size);
 
-	fill_memory(p, 0, hpage_pmd_size);
 	printf("Swapout %d of %d pages...", max_ptes_swap + 1, hpage_pmd_nr);
 	if (madvise(p, (max_ptes_swap + 1) * page_size, MADV_PAGEOUT)) {
 		perror("madvise(MADV_PAGEOUT)");
@@ -674,12 +720,12 @@ static void collapse_max_ptes_swap(struct collapse_context *c)
 		goto out;
 	}
 
-	c->collapse("Maybe collapse with max_ptes_swap exceeded", p, 1,
+	c->collapse("Maybe collapse with max_ptes_swap exceeded", p, 1, ops,
 		    !c->enforce_pte_scan_limits);
 	validate_memory(p, 0, hpage_pmd_size);
 
 	if (c->enforce_pte_scan_limits) {
-		fill_memory(p, 0, hpage_pmd_size);
+		ops->fault(p, 0, hpage_pmd_size);
 		printf("Swapout %d of %d pages...", max_ptes_swap,
 		       hpage_pmd_nr);
 		if (madvise(p, max_ptes_swap * page_size, MADV_PAGEOUT)) {
@@ -694,63 +740,65 @@ static void collapse_max_ptes_swap(struct collapse_context *c)
 		}
 
 		c->collapse("Collapse with max_ptes_swap pages swapped out", p,
-			    1, true);
+			    1, ops, true);
 		validate_memory(p, 0, hpage_pmd_size);
 	}
 out:
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_single_pte_entry_compound(struct collapse_context *c)
+static void collapse_single_pte_entry_compound(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;
 
-	p = alloc_hpage();
+	p = alloc_hpage(ops);
+
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 	printf("Split huge page leaving single PTE mapping compound page...");
 	madvise(p + page_size, hpage_pmd_size - page_size, MADV_DONTNEED);
-	if (check_huge(p, 0))
+	if (ops->check_huge(p, 0))
 		success("OK");
 	else
 		fail("Fail");
 
 	c->collapse("Collapse PTE table with single PTE mapping compound page",
-		    p, 1, true);
+		    p, 1, ops, true);
 	validate_memory(p, 0, page_size);
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_full_of_compound(struct collapse_context *c)
+static void collapse_full_of_compound(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;
 
-	p = alloc_hpage();
+	p = alloc_hpage(ops);
 	printf("Split huge page leaving single PTE page table full of compound pages...");
 	madvise(p, page_size, MADV_NOHUGEPAGE);
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
-	if (check_huge(p, 0))
+	if (ops->check_huge(p, 0))
 		success("OK");
 	else
 		fail("Fail");
 
-	c->collapse("Collapse PTE table full of compound pages", p, 1, true);
+	c->collapse("Collapse PTE table full of compound pages", p, 1, ops,
+		    true);
 	validate_memory(p, 0, hpage_pmd_size);
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_compound_extreme(struct collapse_context *c)
+static void collapse_compound_extreme(struct collapse_context *c, struct mem_ops *ops)
 {
 	void *p;
 	int i;
 
-	p = alloc_mapping(1);
+	p = ops->setup_area(1);
 	for (i = 0; i < hpage_pmd_nr; i++) {
 		printf("\rConstruct PTE page table full of different PTE-mapped compound pages %3d/%d...",
 				i + 1, hpage_pmd_nr);
 
 		madvise(BASE_ADDR, hpage_pmd_size, MADV_HUGEPAGE);
-		fill_memory(BASE_ADDR, 0, hpage_pmd_size);
-		if (!check_huge(BASE_ADDR, 1)) {
+		ops->fault(BASE_ADDR, 0, hpage_pmd_size);
+		if (!ops->check_huge(BASE_ADDR, 1)) {
 			printf("Failed to allocate huge page\n");
 			exit(EXIT_FAILURE);
 		}
@@ -777,30 +825,30 @@ static void collapse_compound_extreme(struct collapse_context *c)
 		}
 	}
 
-	munmap(BASE_ADDR, hpage_pmd_size);
-	fill_memory(p, 0, hpage_pmd_size);
-	if (check_huge(p, 0))
+	ops->cleanup_area(BASE_ADDR, hpage_pmd_size);
+	ops->fault(p, 0, hpage_pmd_size);
+	if (!ops->check_huge(p, 1))
 		success("OK");
 	else
 		fail("Fail");
 
 	c->collapse("Collapse PTE table full of different compound pages", p, 1,
-		    true);
+		    ops, true);
 
 	validate_memory(p, 0, hpage_pmd_size);
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_fork(struct collapse_context *c)
+static void collapse_fork(struct collapse_context *c, struct mem_ops *ops)
 {
 	int wstatus;
 	void *p;
 
-	p = alloc_mapping(1);
+	p = ops->setup_area(1);
 
 	printf("Allocate small page...");
-	fill_memory(p, 0, page_size);
-	if (check_huge(p, 0))
+	ops->fault(p, 0, page_size);
+	if (ops->check_huge(p, 0))
 		success("OK");
 	else
 		fail("Fail");
@@ -811,17 +859,17 @@ static void collapse_fork(struct collapse_context *c)
 		skip_settings_restore = true;
 		exit_status = 0;
 
-		if (check_huge(p, 0))
+		if (ops->check_huge(p, 0))
 			success("OK");
 		else
 			fail("Fail");
 
-		fill_memory(p, page_size, 2 * page_size);
+		ops->fault(p, page_size, 2 * page_size);
 		c->collapse("Collapse PTE table with single page shared with parent process",
-			    p, 1, true);
+			    p, 1, ops, true);
 
 		validate_memory(p, 0, page_size);
-		munmap(p, hpage_pmd_size);
+		ops->cleanup_area(p, hpage_pmd_size);
 		exit(exit_status);
 	}
 
@@ -829,27 +877,27 @@ static void collapse_fork(struct collapse_context *c)
 	exit_status += WEXITSTATUS(wstatus);
 
 	printf("Check if parent still has small page...");
-	if (check_huge(p, 0))
+	if (ops->check_huge(p, 0))
 		success("OK");
 	else
 		fail("Fail");
 	validate_memory(p, 0, page_size);
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_fork_compound(struct collapse_context *c)
+static void collapse_fork_compound(struct collapse_context *c, struct mem_ops *ops)
 {
 	int wstatus;
 	void *p;
 
-	p = alloc_hpage();
+	p = alloc_hpage(ops);
 	printf("Share huge page over fork()...");
 	if (!fork()) {
 		/* Do not touch settings on child exit */
 		skip_settings_restore = true;
 		exit_status = 0;
 
-		if (check_huge(p, 1))
+		if (ops->check_huge(p, 1))
 			success("OK");
 		else
 			fail("Fail");
@@ -857,20 +905,20 @@ static void collapse_fork_compound(struct collapse_context *c)
 		printf("Split huge page PMD in child process...");
 		madvise(p, page_size, MADV_NOHUGEPAGE);
 		madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
-		if (check_huge(p, 0))
+		if (ops->check_huge(p, 0))
 			success("OK");
 		else
 			fail("Fail");
-		fill_memory(p, 0, page_size);
+		ops->fault(p, 0, page_size);
 
 		write_num("khugepaged/max_ptes_shared", hpage_pmd_nr - 1);
 		c->collapse("Collapse PTE table full of compound pages in child",
-			    p, 1, true);
+			    p, 1, ops, true);
 		write_num("khugepaged/max_ptes_shared",
 			  current_settings()->khugepaged.max_ptes_shared);
 
 		validate_memory(p, 0, hpage_pmd_size);
-		munmap(p, hpage_pmd_size);
+		ops->cleanup_area(p, hpage_pmd_size);
 		exit(exit_status);
 	}
 
@@ -878,59 +926,59 @@ static void collapse_fork_compound(struct collapse_context *c)
 	exit_status += WEXITSTATUS(wstatus);
 
 	printf("Check if parent still has huge page...");
-	if (check_huge(p, 1))
+	if (ops->check_huge(p, 1))
 		success("OK");
 	else
 		fail("Fail");
 	validate_memory(p, 0, hpage_pmd_size);
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void collapse_max_ptes_shared(struct collapse_context *c)
+static void collapse_max_ptes_shared(struct collapse_context *c, struct mem_ops *ops)
 {
 	int max_ptes_shared = read_num("khugepaged/max_ptes_shared");
 	int wstatus;
 	void *p;
 
-	p = alloc_hpage();
+	p = alloc_hpage(ops);
 	printf("Share huge page over fork()...");
 	if (!fork()) {
 		/* Do not touch settings on child exit */
 		skip_settings_restore = true;
 		exit_status = 0;
 
-		if (check_huge(p, 1))
+		if (ops->check_huge(p, 1))
 			success("OK");
 		else
 			fail("Fail");
 
 		printf("Trigger CoW on page %d of %d...",
 				hpage_pmd_nr - max_ptes_shared - 1, hpage_pmd_nr);
-		fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) * page_size);
-		if (check_huge(p, 0))
+		ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared - 1) * page_size);
+		if (ops->check_huge(p, 0))
 			success("OK");
 		else
 			fail("Fail");
 
 		c->collapse("Maybe collapse with max_ptes_shared exceeded", p,
-			    1, !c->enforce_pte_scan_limits);
+			    1, ops, !c->enforce_pte_scan_limits);
 
 		if (c->enforce_pte_scan_limits) {
 			printf("Trigger CoW on page %d of %d...",
 			       hpage_pmd_nr - max_ptes_shared, hpage_pmd_nr);
-			fill_memory(p, 0, (hpage_pmd_nr - max_ptes_shared) *
+			ops->fault(p, 0, (hpage_pmd_nr - max_ptes_shared) *
 				    page_size);
-			if (check_huge(p, 0))
+			if (ops->check_huge(p, 0))
 				success("OK");
 			else
 				fail("Fail");
 
 			c->collapse("Collapse with max_ptes_shared PTEs shared",
-				    p, 1,  true);
+				    p, 1, ops, true);
 		}
 
 		validate_memory(p, 0, hpage_pmd_size);
-		munmap(p, hpage_pmd_size);
+		ops->cleanup_area(p, hpage_pmd_size);
 		exit(exit_status);
 	}
 
@@ -938,42 +986,28 @@ static void collapse_max_ptes_shared(struct collapse_context *c)
 	exit_status += WEXITSTATUS(wstatus);
 
 	printf("Check if parent still has huge page...");
-	if (check_huge(p, 1))
+	if (ops->check_huge(p, 1))
 		success("OK");
 	else
 		fail("Fail");
 	validate_memory(p, 0, hpage_pmd_size);
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
-static void madvise_collapse_existing_thps(void)
+static void madvise_collapse_existing_thps(struct collapse_context *c,
+					   struct mem_ops *ops)
 {
 	void *p;
-	int err;
 
-	p = alloc_mapping(1);
-	fill_memory(p, 0, hpage_pmd_size);
+	p = ops->setup_area(1);
+	ops->fault(p, 0, hpage_pmd_size);
+	c->collapse("Collapse fully populated PTE table...", p, 1, ops, true);
+	validate_memory(p, 0, hpage_pmd_size);
 
-	printf("Collapse fully populated PTE table...");
-	/*
-	 * Note that we don't set MADV_HUGEPAGE here, which
-	 * also tests that VM_HUGEPAGE isn't required for
-	 * MADV_COLLAPSE in "madvise" mode.
-	 */
-	err = madvise(p, hpage_pmd_size, MADV_COLLAPSE);
-	if (err == 0 && check_huge(p, 1)) {
-		success("OK");
-		printf("Re-collapse PMD-mapped hugepage");
-		err = madvise(p, hpage_pmd_size, MADV_COLLAPSE);
-		if (err == 0 && check_huge(p, 1))
-			success("OK");
-		else
-			fail("Fail");
-	} else {
-		fail("Fail");
-	}
+	/* c->collapse() will find a hugepage and complain - call directly. */
+	__madvise_collapse("Re-collapse PMD-mapped hugepage", p, 1, ops, true);
 	validate_memory(p, 0, hpage_pmd_size);
-	munmap(p, hpage_pmd_size);
+	ops->cleanup_area(p, hpage_pmd_size);
 }
 
 int main(int argc, const char **argv)
@@ -1013,37 +1047,37 @@ int main(int argc, const char **argv)
 		c.collapse = &khugepaged_collapse;
 		c.enforce_pte_scan_limits = true;
 
-		collapse_full(&c);
-		collapse_empty(&c);
-		collapse_single_pte_entry(&c);
-		collapse_max_ptes_none(&c);
-		collapse_swapin_single_pte(&c);
-		collapse_max_ptes_swap(&c);
-		collapse_single_pte_entry_compound(&c);
-		collapse_full_of_compound(&c);
-		collapse_compound_extreme(&c);
-		collapse_fork(&c);
-		collapse_fork_compound(&c);
-		collapse_max_ptes_shared(&c);
+		collapse_full(&c, &anon_ops);
+		collapse_empty(&c, &anon_ops);
+		collapse_single_pte_entry(&c, &anon_ops);
+		collapse_max_ptes_none(&c, &anon_ops);
+		collapse_swapin_single_pte(&c, &anon_ops);
+		collapse_max_ptes_swap(&c, &anon_ops);
+		collapse_single_pte_entry_compound(&c, &anon_ops);
+		collapse_full_of_compound(&c, &anon_ops);
+		collapse_compound_extreme(&c, &anon_ops);
+		collapse_fork(&c, &anon_ops);
+		collapse_fork_compound(&c, &anon_ops);
+		collapse_max_ptes_shared(&c, &anon_ops);
 	}
 	if (!strcmp(tests, "madvise") || !strcmp(tests, "all")) {
 		printf("\n*** Testing context: madvise ***\n");
 		c.collapse = &madvise_collapse;
 		c.enforce_pte_scan_limits = false;
 
-		collapse_full(&c);
-		collapse_empty(&c);
-		collapse_single_pte_entry(&c);
-		collapse_max_ptes_none(&c);
-		collapse_swapin_single_pte(&c);
-		collapse_max_ptes_swap(&c);
-		collapse_single_pte_entry_compound(&c);
-		collapse_full_of_compound(&c);
-		collapse_compound_extreme(&c);
-		collapse_fork(&c);
-		collapse_fork_compound(&c);
-		collapse_max_ptes_shared(&c);
-		madvise_collapse_existing_thps();
+		collapse_full(&c, &anon_ops);
+		collapse_empty(&c, &anon_ops);
+		collapse_single_pte_entry(&c, &anon_ops);
+		collapse_max_ptes_none(&c, &anon_ops);
+		collapse_swapin_single_pte(&c, &anon_ops);
+		collapse_max_ptes_swap(&c, &anon_ops);
+		collapse_single_pte_entry_compound(&c, &anon_ops);
+		collapse_full_of_compound(&c, &anon_ops);
+		collapse_compound_extreme(&c, &anon_ops);
+		collapse_fork(&c, &anon_ops);
+		collapse_fork_compound(&c, &anon_ops);
+		collapse_max_ptes_shared(&c, &anon_ops);
+		madvise_collapse_existing_thps(&c, &anon_ops);
 	}
 
 	restore_settings(0);
-- 
2.37.2.789.g6183377224-goog

