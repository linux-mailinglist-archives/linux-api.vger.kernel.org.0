Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B85A31B2
	for <lists+linux-api@lfdr.de>; Sat, 27 Aug 2022 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbiHZWDx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Aug 2022 18:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbiHZWDw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Aug 2022 18:03:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2787ED347E
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:50 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id a13-20020a170902eccd00b001730da9d40fso1804083plh.10
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=o1HiHhcgm+W3HuMNDGlnkIBz4rFIRMLbuSwnYzNvFPQ=;
        b=JwW2pBoQPFlXfauNwVUxiZ2o4ALsKhAL747JGaghWcDO+sZWY+/7SDty4j0dtOxOa5
         EbuKMYjHtPy0RnPAGi2g4v37ESPY3in9hAGPY6xbiyfhXqzFkPBoD3FPWST+2jGttpEx
         O+8yZ4zGpNheM8ivI/ZWoUycd/wm9Ufw8RQgUFCDKGa+SFsrXAK6lxrNLaPsTQ+NjV4j
         a9DBdnjWbXtokA6DRpl4tH4Z7U8/G8EKMLBM7w4Cd5dwFwpdRTYrMjbB1UhSncgus4XH
         7gGqlEfhtGGDVcVA/jLVh64N8BBAtpBqDGiy65/qv4TlFl0PJ46ACV1EOcwuEhv3f2IM
         q/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=o1HiHhcgm+W3HuMNDGlnkIBz4rFIRMLbuSwnYzNvFPQ=;
        b=3N44MI1DqwF1MqoPwb+cOZmLMPH90m522wMCe+/n8932/fgpTlx7jVmVKKucS/kGPf
         gC7nndmxgLRWjVVDkT/pP0siOKFqS7A7tAvMIo9m7zPJCTGt9CAFMYCMZXO3i+j4ntCE
         mdYS7GqxkzobwPc9SI6+ZHWq4iGzPhuAUAvQ/2DRnttafi9erSeqLHa5+dil/T3Ms+fb
         uDvOy8iJgPg2tDKSk58vq3Bm/ekDePfNfEp7xHZX0MLCwGSG7OQQypsay7ScnsUqsvsP
         J9tDRGS17+3VsLS9ZoIC/BQqlT1X44W6S4Bfw7snVcSc8Q+f1BWEp+T/ue7XMesR25KP
         jIKg==
X-Gm-Message-State: ACgBeo00thIz8cunKa+w1UBzCFtPW/GuVC4SVWhFKOfC+/+GyAJyZhFR
        o9wjMoYoCMJQEH0OZJzI64UWLbUo5+2i
X-Google-Smtp-Source: AA6agR6qle/tLBsvXrx5H51ZNf2Npd3TNiOZVroYTJKJB8o4WyWIPxnakyEMUC8rQVG8dqiJW/bcnt1QcLVA
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP id
 ei24-20020a17090ae55800b001fbc4b71a24mr349477pjb.1.1661551429096; Fri, 26 Aug
 2022 15:03:49 -0700 (PDT)
Date:   Fri, 26 Aug 2022 15:03:28 -0700
In-Reply-To: <20220826220329.1495407-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826220329.1495407-10-zokeefe@google.com>
Subject: [PATCH mm-unstable v2 9/9] selftests/vm: add selftest for
 MADV_COLLAPSE of uffd-minor memory
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
index df4fa77febca..c22b5b613296 100644
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
index 7be709d9eed0..74babdbc02e5 100644
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
@@ -478,6 +510,7 @@ static void uffd_test_ctx_clear(void)
 	munmap_area((void **)&area_src_alias);
 	munmap_area((void **)&area_dst);
 	munmap_area((void **)&area_dst_alias);
+	munmap_area((void **)&area_remap);
 }
 
 static void uffd_test_ctx_init(uint64_t features)
@@ -486,8 +519,8 @@ static void uffd_test_ctx_init(uint64_t features)
 
 	uffd_test_ctx_clear();
 
-	uffd_test_ops->allocate_area((void **)&area_src);
-	uffd_test_ops->allocate_area((void **)&area_dst);
+	uffd_test_ops->allocate_area((void **)&area_src, true);
+	uffd_test_ops->allocate_area((void **)&area_dst, false);
 
 	userfaultfd_open(&features);
 
@@ -804,6 +837,7 @@ static void *uffd_poll_thread(void *arg)
 				err("remove failure");
 			break;
 		case UFFD_EVENT_REMAP:
+			area_remap = area_dst;  /* save for later unmap */
 			area_dst = (char *)(unsigned long)msg.arg.remap.to;
 			break;
 		}
@@ -1256,13 +1290,30 @@ static int userfaultfd_sig_test(void)
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
 
@@ -1301,17 +1352,7 @@ static int userfaultfd_minor_test(void)
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
@@ -1320,6 +1361,23 @@ static int userfaultfd_minor_test(void)
 
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
 
@@ -1656,6 +1714,8 @@ static void parse_test_type_arg(const char *raw_type)
 			test_dev_userfaultfd = true;
 		else if (!strcmp(token, "syscall"))
 			test_dev_userfaultfd = false;
+		else if (!strcmp(token, "collapse"))
+			test_collapse = true;
 		else
 			err("unrecognized test mod '%s'", token);
 	}
@@ -1663,8 +1723,11 @@ static void parse_test_type_arg(const char *raw_type)
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
 
@@ -1702,6 +1765,8 @@ static void sigalrm(int sig)
 
 int main(int argc, char **argv)
 {
+	size_t bytes;
+
 	if (argc < 4)
 		usage();
 
@@ -1709,11 +1774,41 @@ int main(int argc, char **argv)
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
2.37.2.672.g94769d06f0-goog

