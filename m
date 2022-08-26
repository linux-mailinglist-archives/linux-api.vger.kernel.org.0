Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91655A31B0
	for <lists+linux-api@lfdr.de>; Sat, 27 Aug 2022 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344556AbiHZWDs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Aug 2022 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiHZWDo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Aug 2022 18:03:44 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47FDAA07
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:42 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id by13-20020a056a00400d00b0052ec5a1cd4dso1408312pfb.21
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=ypxTHNVpiViV9TzEO3UL176EnYI7CLR/iAxfbuDOups=;
        b=AUtfQRjWHoDpgzCdBqy7l2Y7Vj6Xkc0nvuswd2bV3mcvbcYHjtITTbg8HxWH0VaCdk
         d0gl47aDzjPpETHFYiIT8Kf6IP/wvMLtdn2HP+pEdmRrAtK89goWZFCBaTiabRH7jf39
         zbYTlx3QxOOeIEAwYWCsVGA2a2MjJjziLHeVtzm4TYS0iD38xdikn+wUNVPhRyVxSZJg
         4pYkQSgf6ZWm7RnjRNAszwV8boUN/SKvZ/Oa34nrlZpQ44VlQ6bQ4i4h+wi3L7ayhpyU
         ip11QJlbH5LUyKxYeN3FPncqL9JdpI7X48ad0UYFX4zmD7DEQOHNdaoMb8FBIFEG1Ulk
         e1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ypxTHNVpiViV9TzEO3UL176EnYI7CLR/iAxfbuDOups=;
        b=jBa9ocfkdq3L6lBLCxT/EbJ5hKIu1WaPE9ge3yTFJF1Gvuos9YlE2D5UbJL2AzYvxp
         90IReONfcrkO/O9mr+zirpn6B7ykBDomLLILN7976UjoJTM8EWksJ1PaeN+FIJHETIbS
         gJBsW9FHS9aePvD2YI3cJbAVaHa4l5OToyMaVrNMYMa2oV8lWTzdspBE7I29dZEqoFX/
         tvmNESA/L20g8j+n3XxxCXGcrAIDz8YTFHqj/YBMNMi4F7ajO+RJM6lXibVJDQyEFagI
         e4pUVOTEqy020NxAnBXZtsjqK0Jz/TVb7FRRSaMV4auuTj0b36/CKDZGgW/WCwIecwF0
         +RKg==
X-Gm-Message-State: ACgBeo0Dnlj4epAv67adWfnSfz6xB4mJdModeCTgpuNFP9lzboihBPKY
        fjgWFlTiLKQSm6kh7g8VlS0r6O1fiLxt
X-Google-Smtp-Source: AA6agR6x8mdlHUPn/e4fV1q+4K1YyA9frHBiedudmcioyMRfDa5nr3+BNWQrsw3WOmYMGiUTdzG++7Hy/pV+
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr349692pje.0.1661551422097; Fri, 26 Aug
 2022 15:03:42 -0700 (PDT)
Date:   Fri, 26 Aug 2022 15:03:24 -0700
In-Reply-To: <20220826220329.1495407-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826220329.1495407-6-zokeefe@google.com>
Subject: [PATCH mm-unstable v2 5/9] selftests/vm: dedup THP helpers
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

These files:

tools/testing/selftests/vm/vm_util.c
tools/testing/selftests/vm/khugepaged.c

Both contain logic to:

1) Determine hugepage size on current system
2) Read /proc/self/smaps to determine number of THPs at an address

Refactor selftests/vm/khugepaged.c to use the vm_util common helpers
and add it as a build dependency.

Since selftests/vm/khugepaged.c is the largest user of check_huge(),
change the signature of check_huge() to match
selftests/vm/khugepaged.c's useage: take an expected number of
hugepages, and return a bool indicating if the correct number of
hugepages were found.  Add a wrapper, check_huge_anon(), in anticipation
of checking smaps for file and shmem hugepages.

Update existing callsites to use the new pattern / function.

Likewise, check_for_pattern() was duplicated, and it's a general enough
helper to include in vm_util helpers as well.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/vm/Makefile           |  1 +
 tools/testing/selftests/vm/khugepaged.c       | 64 ++-----------------
 tools/testing/selftests/vm/soft-dirty.c       |  2 +-
 .../selftests/vm/split_huge_page_test.c       | 12 ++--
 tools/testing/selftests/vm/vm_util.c          | 26 +++++---
 tools/testing/selftests/vm/vm_util.h          |  3 +-
 6 files changed, 32 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index b52f2cc51482..df4fa77febca 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -97,6 +97,7 @@ TEST_FILES += va_128TBswitch.sh
 
 include ../lib.mk
 
+$(OUTPUT)/khugepaged: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index b77b1e28cdb3..e5c602f7a18b 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -11,6 +11,8 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 
+#include "vm_util.h"
+
 #ifndef MADV_PAGEOUT
 #define MADV_PAGEOUT 21
 #endif
@@ -351,64 +353,12 @@ static void save_settings(void)
 	signal(SIGQUIT, restore_settings);
 }
 
-#define MAX_LINE_LENGTH 500
-
-static bool check_for_pattern(FILE *fp, char *pattern, char *buf)
-{
-	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
-		if (!strncmp(buf, pattern, strlen(pattern)))
-			return true;
-	}
-	return false;
-}
-
 static bool check_huge(void *addr, int nr_hpages)
 {
-	bool thp = false;
-	int ret;
-	FILE *fp;
-	char buffer[MAX_LINE_LENGTH];
-	char addr_pattern[MAX_LINE_LENGTH];
-
-	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "%08lx-",
-		       (unsigned long) addr);
-	if (ret >= MAX_LINE_LENGTH) {
-		printf("%s: Pattern is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-
-
-	fp = fopen(PID_SMAPS, "r");
-	if (!fp) {
-		printf("%s: Failed to open file %s\n", __func__, PID_SMAPS);
-		exit(EXIT_FAILURE);
-	}
-	if (!check_for_pattern(fp, addr_pattern, buffer))
-		goto err_out;
-
-	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "AnonHugePages:%10ld kB",
-		       nr_hpages * (hpage_pmd_size >> 10));
-	if (ret >= MAX_LINE_LENGTH) {
-		printf("%s: Pattern is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
-	/*
-	 * Fetch the AnonHugePages: in the same block and check whether it got
-	 * the expected number of hugeepages next.
-	 */
-	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
-		goto err_out;
-
-	if (strncmp(buffer, addr_pattern, strlen(addr_pattern)))
-		goto err_out;
-
-	thp = true;
-err_out:
-	fclose(fp);
-	return thp;
+	return check_huge_anon(addr, nr_hpages, hpage_pmd_size);
 }
 
-
+#define MAX_LINE_LENGTH 500
 static bool check_swap(void *addr, unsigned long size)
 {
 	bool swap = false;
@@ -430,7 +380,7 @@ static bool check_swap(void *addr, unsigned long size)
 		printf("%s: Failed to open file %s\n", __func__, PID_SMAPS);
 		exit(EXIT_FAILURE);
 	}
-	if (!check_for_pattern(fp, addr_pattern, buffer))
+	if (!check_for_pattern(fp, addr_pattern, buffer, sizeof(buffer)))
 		goto err_out;
 
 	ret = snprintf(addr_pattern, MAX_LINE_LENGTH, "Swap:%19ld kB",
@@ -443,7 +393,7 @@ static bool check_swap(void *addr, unsigned long size)
 	 * Fetch the Swap: in the same block and check whether it got
 	 * the expected number of hugeepages next.
 	 */
-	if (!check_for_pattern(fp, "Swap:", buffer))
+	if (!check_for_pattern(fp, "Swap:", buffer, sizeof(buffer)))
 		goto err_out;
 
 	if (strncmp(buffer, addr_pattern, strlen(addr_pattern)))
@@ -1045,7 +995,7 @@ int main(int argc, const char **argv)
 	setbuf(stdout, NULL);
 
 	page_size = getpagesize();
-	hpage_pmd_size = read_num("hpage_pmd_size");
+	hpage_pmd_size = read_pmd_pagesize();
 	hpage_pmd_nr = hpage_pmd_size / page_size;
 
 	default_settings.khugepaged.max_ptes_none = hpage_pmd_nr - 1;
diff --git a/tools/testing/selftests/vm/soft-dirty.c b/tools/testing/selftests/vm/soft-dirty.c
index e3a43f5d4fa2..21d8830c5f24 100644
--- a/tools/testing/selftests/vm/soft-dirty.c
+++ b/tools/testing/selftests/vm/soft-dirty.c
@@ -91,7 +91,7 @@ static void test_hugepage(int pagemap_fd, int pagesize)
 	for (i = 0; i < hpage_len; i++)
 		map[i] = (char)i;
 
-	if (check_huge(map)) {
+	if (check_huge_anon(map, 1, hpage_len)) {
 		ksft_test_result_pass("Test %s huge page allocation\n", __func__);
 
 		clear_softdirty();
diff --git a/tools/testing/selftests/vm/split_huge_page_test.c b/tools/testing/selftests/vm/split_huge_page_test.c
index 6aa2b8253aed..76e1c36dd9e5 100644
--- a/tools/testing/selftests/vm/split_huge_page_test.c
+++ b/tools/testing/selftests/vm/split_huge_page_test.c
@@ -92,7 +92,6 @@ void split_pmd_thp(void)
 {
 	char *one_page;
 	size_t len = 4 * pmd_pagesize;
-	uint64_t thp_size;
 	size_t i;
 
 	one_page = memalign(pmd_pagesize, len);
@@ -107,8 +106,7 @@ void split_pmd_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	thp_size = check_huge(one_page);
-	if (!thp_size) {
+	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
@@ -124,9 +122,8 @@ void split_pmd_thp(void)
 		}
 
 
-	thp_size = check_huge(one_page);
-	if (thp_size) {
-		printf("Still %ld kB AnonHugePages not split\n", thp_size);
+	if (check_huge_anon(one_page, 0, pmd_pagesize)) {
+		printf("Still AnonHugePages not split\n");
 		exit(EXIT_FAILURE);
 	}
 
@@ -172,8 +169,7 @@ void split_pte_mapped_thp(void)
 	for (i = 0; i < len; i++)
 		one_page[i] = (char)i;
 
-	thp_size = check_huge(one_page);
-	if (!thp_size) {
+	if (!check_huge_anon(one_page, 1, pmd_pagesize)) {
 		printf("No THP is allocated\n");
 		exit(EXIT_FAILURE);
 	}
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
index b58ab11a7a30..9dae51b8219f 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -42,9 +42,9 @@ void clear_softdirty(void)
 		ksft_exit_fail_msg("writing clear_refs failed\n");
 }
 
-static bool check_for_pattern(FILE *fp, const char *pattern, char *buf)
+bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len)
 {
-	while (fgets(buf, MAX_LINE_LENGTH, fp) != NULL) {
+	while (fgets(buf, len, fp)) {
 		if (!strncmp(buf, pattern, strlen(pattern)))
 			return true;
 	}
@@ -72,9 +72,10 @@ uint64_t read_pmd_pagesize(void)
 	return strtoul(buf, NULL, 10);
 }
 
-uint64_t check_huge(void *addr)
+bool __check_huge(void *addr, char *pattern, int nr_hpages,
+		  uint64_t hpage_size)
 {
-	uint64_t thp = 0;
+	uint64_t thp = -1;
 	int ret;
 	FILE *fp;
 	char buffer[MAX_LINE_LENGTH];
@@ -89,20 +90,27 @@ uint64_t check_huge(void *addr)
 	if (!fp)
 		ksft_exit_fail_msg("%s: Failed to open file %s\n", __func__, SMAP_FILE_PATH);
 
-	if (!check_for_pattern(fp, addr_pattern, buffer))
+	if (!check_for_pattern(fp, addr_pattern, buffer, sizeof(buffer)))
 		goto err_out;
 
 	/*
-	 * Fetch the AnonHugePages: in the same block and check the number of
+	 * Fetch the pattern in the same block and check the number of
 	 * hugepages.
 	 */
-	if (!check_for_pattern(fp, "AnonHugePages:", buffer))
+	if (!check_for_pattern(fp, pattern, buffer, sizeof(buffer)))
 		goto err_out;
 
-	if (sscanf(buffer, "AnonHugePages:%10ld kB", &thp) != 1)
+	snprintf(addr_pattern, MAX_LINE_LENGTH, "%s%%9ld kB", pattern);
+
+	if (sscanf(buffer, addr_pattern, &thp) != 1)
 		ksft_exit_fail_msg("Reading smap error\n");
 
 err_out:
 	fclose(fp);
-	return thp;
+	return thp == (nr_hpages * (hpage_size >> 10));
+}
+
+bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size)
+{
+	return __check_huge(addr, "AnonHugePages: ", nr_hpages, hpage_size);
 }
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
index 2e512bd57ae1..8434ea0c95cd 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -5,5 +5,6 @@
 uint64_t pagemap_get_entry(int fd, char *start);
 bool pagemap_is_softdirty(int fd, char *start);
 void clear_softdirty(void);
+bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
-uint64_t check_huge(void *addr);
+bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
-- 
2.37.2.672.g94769d06f0-goog

