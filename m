Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B415909DD
	for <lists+linux-api@lfdr.de>; Fri, 12 Aug 2022 03:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiHLB32 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Aug 2022 21:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiHLB31 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Aug 2022 21:29:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2959BB5E
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o18-20020a17090aac1200b001f3252af009so3410891pjq.7
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=RVtVc/Q31VYSDn8MAH51vQ3bFIExJir+5Zy91p6nuDw=;
        b=TY4jAax87b3zjZpPf+jQPiSGY6QPuavJUWU28TfknIvpYVmgJXPgFhirJ43+qSnNLU
         HsWrZ2VADS8incOBAX6cdNEekibbs3arocCjSUK2/wIu7yad9Qa+Co314iwcMY119O48
         5YV2OHD6Bv8hHUrYZqFrslbMy5gTcCwnO1B6kc7Ssz+QuHjW/hYy579iBdhGCMVV7UBr
         c5XTD8wfKg0xTqZkVCa1HhFVB+bCRcZaFprrMHwfd3tSGgsSTvTk6RBO9rDMPTKUkWyR
         fP1g7NJtgImk2L1FMXsQqT0njr2LbqHTLcxEhQXK5zSYyAZkyKmvZUwPbFJlsHoknyB4
         e1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=RVtVc/Q31VYSDn8MAH51vQ3bFIExJir+5Zy91p6nuDw=;
        b=OleF6pwU3Y2KnwkMApaSUvTd4x531/vmzcHoNvQRREl1JbEQBAsuf/6UV0dRHs5Jw4
         GOd9jlj7TDbCQw+xqaoy3l6FyHUG/HdhOawEceT+BBIdXStwfC9Sqp/kTkcVZILEu00O
         Jg/VrvoGVq5kILjMriaSgSlsdjR+0Z86ieNBmSdARvClZKHoRr0R3V32fyD1hZ256+Mn
         lGHZIja8PX7Yio8VlwOWkwdBbNukTaXMc5OhUhWS/rjv5JzvbgmOLw28zWhWGtUK+wua
         vqI2w9kCsTLcWUhUN+HkY5cI5QAtBZpJI5B2I8fUbLhbtKgsdgxxBmmg4rRsMUZvmp5u
         yDbw==
X-Gm-Message-State: ACgBeo0vXh/+Af0j3q7aexD9GVKBwqbWAuAMc84LWhHK25nON9tA/iRG
        oK36ZTt57niMwJEisjaJBIi30NSCz+Vm
X-Google-Smtp-Source: AA6agR7vEB44V/o6aGlWJzStLtm8bABtqErnkkcysrD0VWoJb1WqNMEQOjTiBJnPinJbrUwP/fFpaE8E36Lj
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:1688:b0:517:cf7b:9293 with SMTP
 id k8-20020a056a00168800b00517cf7b9293mr1771731pfc.7.1660267765263; Thu, 11
 Aug 2022 18:29:25 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:28:43 -0700
In-Reply-To: <20220812012843.3948330-1-zokeefe@google.com>
Message-Id: <20220812012843.3948330-10-zokeefe@google.com>
Mime-Version: 1.0
References: <20220812012843.3948330-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH mm-unstable 9/9] selftests/vm: add selftest for MADV_COLLAPSE
 of uffd-minor memory
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

Add :collapse mod to userfaultfd selftest.  Currently this mod is
only valid for "shmem" test type, but could be used for other test
types.

When provided, memory allocated by ->allocate_area() will be
hugepage-aligned enforced to be hugepage-sized.  userfaultf_minor_test,
after the UFFD-registered mapping has been populated by UUFD minor
fault handler, attempt to MADV_COLLAPSE the UFFD-registered mapping to
collapse the memory into a pmd-mapped THP.

This test is meant to be a functional test of what occurs during
UFFD-driven live migration of VMs backed by huge tmpfs where, after
a hugepage-sized region has been successfully migrated (in native
page-sized chunks, to avoid latency of fetched a hugepage over the
network), we want to reclaim previous VM performance by remapping it
at the PMD level.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/vm/Makefile      |   1 +
 tools/testing/selftests/vm/userfaultfd.c | 171 ++++++++++++++++++-----
 2 files changed, 134 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 33716ba4d63b..42c7030d793f 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -101,6 +101,7 @@ $(OUTPUT)/khugepaged: vm_util.c
 $(OUTPUT)/madv_populate: vm_util.c
 $(OUTPUT)/soft-dirty: vm_util.c
 $(OUTPUT)/split_huge_page_test: vm_util.c
+$(OUTPUT)/userfaultfd: vm_util.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index cae72867c173..65fb05de850a 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -61,10 +61,11 @@
 #include <sys/random.h>
 
 #include "../kselftest.h"
+#include "vm_util.h"
 
 #ifdef __NR_userfaultfd
 
-static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
+static unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size, hpage_size;
 
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
@@ -79,6 +80,8 @@ static int test_type;
 
 #define UFFD_FLAGS	(O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY)
 
+#define BASE_PMD_ADDR ((void *)(1UL << 30))
+
 /* test using /dev/userfaultfd, instead of userfaultfd(2) */
 static bool test_dev_userfaultfd;
 
@@ -97,9 +100,10 @@ static int huge_fd;
 static unsigned long long *count_verify;
 static int uffd = -1;
 static int uffd_flags, finished, *pipefd;
-static char *area_src, *area_src_alias, *area_dst, *area_dst_alias;
+static char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
 static char *zeropage;
 pthread_attr_t attr;
+static bool test_collapse;
 
 /* Userfaultfd test statistics */
 struct uffd_stats {
@@ -127,6 +131,8 @@ struct uffd_stats {
 #define swap(a, b) \
 	do { typeof(a) __tmp = (a); (a) = (b); (b) = __tmp; } while (0)
 
+#define factor_of_2(x) ((x) ^ ((x) & ((x) - 1)))
+
 const char *examples =
     "# Run anonymous memory test on 100MiB region with 99999 bounces:\n"
     "./userfaultfd anon 100 99999\n\n"
@@ -152,6 +158,8 @@ static void usage(void)
 		"Supported mods:\n");
 	fprintf(stderr, "\tsyscall - Use userfaultfd(2) (default)\n");
 	fprintf(stderr, "\tdev - Use /dev/userfaultfd instead of userfaultfd(2)\n");
+	fprintf(stderr, "\tcollapse - Test MADV_COLLAPSE of UFFDIO_REGISTER_MODE_MINOR\n"
+		"memory\n");
 	fprintf(stderr, "\nExample test mod usage:\n");
 	fprintf(stderr, "# Run anonymous memory test with /dev/userfaultfd:\n");
 	fprintf(stderr, "./userfaultfd anon:dev 100 99999\n\n");
@@ -229,12 +237,10 @@ static void anon_release_pages(char *rel_area)
 		err("madvise(MADV_DONTNEED) failed");
 }
 
-static void anon_allocate_area(void **alloc_area)
+static void anon_allocate_area(void **alloc_area, bool is_src)
 {
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (*alloc_area == MAP_FAILED)
-		err("mmap of anonymous memory failed");
 }
 
 static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -252,7 +258,7 @@ static void hugetlb_release_pages(char *rel_area)
 	}
 }
 
-static void hugetlb_allocate_area(void **alloc_area)
+static void hugetlb_allocate_area(void **alloc_area, bool is_src)
 {
 	void *area_alias = NULL;
 	char **alloc_area_alias;
@@ -262,7 +268,7 @@ static void hugetlb_allocate_area(void **alloc_area)
 			nr_pages * page_size,
 			PROT_READ | PROT_WRITE,
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB |
-				(*alloc_area == area_src ? 0 : MAP_NORESERVE),
+				(is_src ? 0 : MAP_NORESERVE),
 			-1,
 			0);
 	else
@@ -270,9 +276,9 @@ static void hugetlb_allocate_area(void **alloc_area)
 			nr_pages * page_size,
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED |
-				(*alloc_area == area_src ? 0 : MAP_NORESERVE),
+				(is_src ? 0 : MAP_NORESERVE),
 			huge_fd,
-			*alloc_area == area_src ? 0 : nr_pages * page_size);
+			is_src ? 0 : nr_pages * page_size);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of hugetlbfs file failed");
 
@@ -282,12 +288,12 @@ static void hugetlb_allocate_area(void **alloc_area)
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED,
 			huge_fd,
-			*alloc_area == area_src ? 0 : nr_pages * page_size);
+			is_src ? 0 : nr_pages * page_size);
 		if (area_alias == MAP_FAILED)
 			err("mmap of hugetlb file alias failed");
 	}
 
-	if (*alloc_area == area_src) {
+	if (is_src) {
 		alloc_area_alias = &area_src_alias;
 	} else {
 		alloc_area_alias = &area_dst_alias;
@@ -310,21 +316,36 @@ static void shmem_release_pages(char *rel_area)
 		err("madvise(MADV_REMOVE) failed");
 }
 
-static void shmem_allocate_area(void **alloc_area)
+static void shmem_allocate_area(void **alloc_area, bool is_src)
 {
 	void *area_alias = NULL;
-	bool is_src = alloc_area == (void **)&area_src;
-	unsigned long offset = is_src ? 0 : nr_pages * page_size;
+	size_t bytes = nr_pages * page_size;
+	unsigned long offset = is_src ? 0 : bytes;
+	char *p = NULL, *p_alias = NULL;
+
+	if (test_collapse) {
+		p = BASE_PMD_ADDR;
+		if (!is_src)
+			/* src map + alias + interleaved hpages */
+			p += 2 * (bytes + hpage_size);
+		p_alias = p;
+		p_alias += bytes;
+		p_alias += hpage_size;  /* Prevent src/dst VMA merge */
+	}
 
-	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   MAP_SHARED, shm_fd, offset);
+	*alloc_area = mmap(p, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+			   shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
+	if (test_collapse && *alloc_area != p)
+		err("mmap of memfd failed at %p", p);
 
-	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			  MAP_SHARED, shm_fd, offset);
+	area_alias = mmap(p_alias, bytes, PROT_READ | PROT_WRITE, MAP_SHARED,
+			  shm_fd, offset);
 	if (area_alias == MAP_FAILED)
 		err("mmap of memfd alias failed");
+	if (test_collapse && area_alias != p_alias)
+		err("mmap of anonymous memory failed at %p", p_alias);
 
 	if (is_src)
 		area_src_alias = area_alias;
@@ -337,28 +358,39 @@ static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 	*start = (unsigned long)area_dst_alias + offset;
 }
 
+static void shmem_check_pmd_mapping(void *p, int expect_nr_hpages)
+{
+	if (!check_huge_shmem(area_dst_alias, expect_nr_hpages, hpage_size))
+		err("Did not find expected %d number of hugepages",
+		    expect_nr_hpages);
+}
+
 struct uffd_test_ops {
-	void (*allocate_area)(void **alloc_area);
+	void (*allocate_area)(void **alloc_area, bool is_src);
 	void (*release_pages)(char *rel_area);
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
+	void (*check_pmd_mapping)(void *p, int expect_nr_hpages);
 };
 
 static struct uffd_test_ops anon_uffd_test_ops = {
 	.allocate_area	= anon_allocate_area,
 	.release_pages	= anon_release_pages,
 	.alias_mapping = noop_alias_mapping,
+	.check_pmd_mapping = NULL,
 };
 
 static struct uffd_test_ops shmem_uffd_test_ops = {
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
 	.alias_mapping = shmem_alias_mapping,
+	.check_pmd_mapping = shmem_check_pmd_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
+	.check_pmd_mapping = NULL,
 };
 
 static struct uffd_test_ops *uffd_test_ops;
@@ -473,6 +505,7 @@ static void uffd_test_ctx_clear(void)
 	munmap_area((void **)&area_src_alias);
 	munmap_area((void **)&area_dst);
 	munmap_area((void **)&area_dst_alias);
+	munmap_area((void **)&area_remap);
 }
 
 static void uffd_test_ctx_init(uint64_t features)
@@ -481,8 +514,8 @@ static void uffd_test_ctx_init(uint64_t features)
 
 	uffd_test_ctx_clear();
 
-	uffd_test_ops->allocate_area((void **)&area_src);
-	uffd_test_ops->allocate_area((void **)&area_dst);
+	uffd_test_ops->allocate_area((void **)&area_src, true);
+	uffd_test_ops->allocate_area((void **)&area_dst, false);
 
 	userfaultfd_open(&features);
 
@@ -799,6 +832,7 @@ static void *uffd_poll_thread(void *arg)
 				err("remove failure");
 			break;
 		case UFFD_EVENT_REMAP:
+			area_remap = area_dst;  /* save for later unmap */
 			area_dst = (char *)(unsigned long)msg.arg.remap.to;
 			break;
 		}
@@ -1251,13 +1285,30 @@ static int userfaultfd_sig_test(void)
 	return userfaults != 0;
 }
 
+void check_memory_contents(char *p)
+{
+	unsigned long i;
+	uint8_t expected_byte;
+	void *expected_page;
+
+	if (posix_memalign(&expected_page, page_size, page_size))
+		err("out of memory");
+
+	for (i = 0; i < nr_pages; ++i) {
+		expected_byte = ~((uint8_t)(i % ((uint8_t)-1)));
+		memset(expected_page, expected_byte, page_size);
+		if (my_bcmp(expected_page, p + (i * page_size), page_size))
+			err("unexpected page contents after minor fault");
+	}
+
+	free(expected_page);
+}
+
 static int userfaultfd_minor_test(void)
 {
-	struct uffdio_register uffdio_register;
 	unsigned long p;
+	struct uffdio_register uffdio_register;
 	pthread_t uffd_mon;
-	uint8_t expected_byte;
-	void *expected_page;
 	char c;
 	struct uffd_stats stats = { 0 };
 
@@ -1296,17 +1347,7 @@ static int userfaultfd_minor_test(void)
 	 * fault. uffd_poll_thread will resolve the fault by bit-flipping the
 	 * page's contents, and then issuing a CONTINUE ioctl.
 	 */
-
-	if (posix_memalign(&expected_page, page_size, page_size))
-		err("out of memory");
-
-	for (p = 0; p < nr_pages; ++p) {
-		expected_byte = ~((uint8_t)(p % ((uint8_t)-1)));
-		memset(expected_page, expected_byte, page_size);
-		if (my_bcmp(expected_page, area_dst_alias + (p * page_size),
-			    page_size))
-			err("unexpected page contents after minor fault");
-	}
+	check_memory_contents(area_dst_alias);
 
 	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
 		err("pipe write");
@@ -1315,6 +1356,23 @@ static int userfaultfd_minor_test(void)
 
 	uffd_stats_report(&stats, 1);
 
+	if (test_collapse) {
+		printf("testing collapse of uffd memory into PMD-mapped THPs:");
+		if (madvise(area_dst_alias, nr_pages * page_size,
+			    MADV_COLLAPSE))
+			err("madvise(MADV_COLLAPSE)");
+
+		uffd_test_ops->check_pmd_mapping(area_dst,
+						 nr_pages * page_size /
+						 hpage_size);
+		/*
+		 * This won't cause uffd-fault - it purely just makes sure there
+		 * was no corruption.
+		 */
+		check_memory_contents(area_dst_alias);
+		printf(" done.\n");
+	}
+
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
 }
 
@@ -1651,6 +1709,8 @@ static void parse_test_type_arg(const char *raw_type)
 			test_dev_userfaultfd = true;
 		else if (!strcmp(token, "syscall"))
 			test_dev_userfaultfd = false;
+		else if (!strcmp(token, "collapse"))
+			test_collapse = true;
 		else
 			err("unrecognized test mod '%s'", token);
 	}
@@ -1658,8 +1718,11 @@ static void parse_test_type_arg(const char *raw_type)
 	if (!test_type)
 		err("failed to parse test type argument: '%s'", raw_type);
 
+	if (test_collapse && test_type != TEST_SHMEM)
+		err("Unsupported test: %s", raw_type);
+
 	if (test_type == TEST_HUGETLB)
-		page_size = default_huge_page_size();
+		page_size = hpage_size;
 	else
 		page_size = sysconf(_SC_PAGE_SIZE);
 
@@ -1697,6 +1760,8 @@ static void sigalrm(int sig)
 
 int main(int argc, char **argv)
 {
+	size_t bytes;
+
 	if (argc < 4)
 		usage();
 
@@ -1704,11 +1769,41 @@ int main(int argc, char **argv)
 		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
+	hpage_size = default_huge_page_size();
 	parse_test_type_arg(argv[1]);
+	bytes = atol(argv[2]) * 1024 * 1024;
+
+	if (test_collapse && bytes & (hpage_size - 1))
+		err("MiB must be multiple of %lu if :collapse mod set",
+		    hpage_size >> 20);
 
 	nr_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
-		nr_cpus;
+
+	if (test_collapse) {
+		/* nr_cpus must divide (bytes / page_size), otherwise,
+		 * area allocations of (nr_pages * paze_size) won't be a
+		 * multiple of hpage_size, even if bytes is a multiple of
+		 * hpage_size.
+		 *
+		 * This means that nr_cpus must divide (N * (2 << (H-P))
+		 * where:
+		 *	bytes = hpage_size * N
+		 *	hpage_size = 2 << H
+		 *	page_size = 2 << P
+		 *
+		 * And we want to chose nr_cpus to be the largest value
+		 * satisfying this constraint, not larger than the number
+		 * of online CPUs. Unfortunately, prime factorization of
+		 * N and nr_cpus may be arbitrary, so have to search for it.
+		 * Instead, just use the highest power of 2 dividing both
+		 * nr_cpus and (bytes / page_size).
+		 */
+		int x = factor_of_2(nr_cpus);
+		int y = factor_of_2(bytes / page_size);
+
+		nr_cpus = x < y ? x : y;
+	}
+	nr_pages_per_cpu = bytes / page_size / nr_cpus;
 	if (!nr_pages_per_cpu) {
 		_err("invalid MiB");
 		usage();
-- 
2.37.1.559.g78731f0fdb-goog

