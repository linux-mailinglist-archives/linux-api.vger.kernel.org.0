Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B1C5A31AE
	for <lists+linux-api@lfdr.de>; Sat, 27 Aug 2022 00:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbiHZWDu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Aug 2022 18:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbiHZWDs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Aug 2022 18:03:48 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069ADAEE4
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:46 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id e1-20020a17090a7c4100b001fd7e8c4eb1so421892pjl.1
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=SA4EsaTZqY0IlFita6xWsKi+cqf5BrYgP41FGTx/jhA=;
        b=Mk+xdkIgST81hI5zDyI8cnHB311zEaBY29I8ts9wT8SpLM+eRHYQTJHZnUYsJpM7TV
         qsUQOykSW+PZrqTT6l5x4D0VIC3Vlksfe1gmBnLNWLUv/vTSMwjgntG/aRYLXpQpp82W
         HA73jsA+fA+Xv9wpfesSmJsrIOv+sAW7w9FNSA0yYnKy9jR7i58by6Wcm9S/LWvhribQ
         rbgW62xE7Cn0qNfQ84WP5oW2NfgadvQ1yRf3X/mOtbktAa7wQnn7MTnVRDLTOwBncXHD
         aZZJIcrg2CyxmWagPzfZeBDN0+HI2AEWa6MmaMi4nl05re3c5uZ6qv+pMCJTBHH3y3EN
         1cyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=SA4EsaTZqY0IlFita6xWsKi+cqf5BrYgP41FGTx/jhA=;
        b=6ZwiNwfF5r+rUrFZzvgtbKKC5I3tOhACuQGRnkiW2ErKfKDxsSegp0Odfm4f2Hg9Bl
         05fpBnBJ/p+BKxyj7o9Fun8cDi5HuhLawf26c4gfz01mNg30V1RNTvxW5TayHPjjWCB8
         lUry8OpvGtStNxBFIRSlAIe2PjJ/uCiDvaavmK/YY+eHelSuV8idBsDFlg9eMrTjbMUv
         YR89MWA9gRcGOw2qHSJ8R0FR/3z0F5J1P3wZnBEajR9MXifRe3xRKl+1OEztgafN5Xds
         FVeCitJd6pj2owR/a/AC8ONaK2apjwd7Df+Cut2eR77nNdkyQgnXtzwh1lbK/WnQMmeH
         a3lw==
X-Gm-Message-State: ACgBeo1e1HjGzal03DSNvJx0/EehsOaFDdq4uDHMfHE3YqPlBaovH6f0
        NPCeA1VOxDOVZel73TGoP2sgVMyc8pu9
X-Google-Smtp-Source: AA6agR6LBD1baw4tUiBtVLkpQ6n0ht28zCCttHPtegt5ptFISpaxs55mCE195gWLKyG6QW0EFKjI5hWxwODS
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:da84:b0:173:195:5401 with SMTP id
 j4-20020a170902da8400b0017301955401mr5499128plx.28.1661551425995; Fri, 26 Aug
 2022 15:03:45 -0700 (PDT)
Date:   Fri, 26 Aug 2022 15:03:26 -0700
In-Reply-To: <20220826220329.1495407-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826220329.1495407-8-zokeefe@google.com>
Subject: [PATCH mm-unstable v2 7/9] selftests/vm: add thp collapse file and
 tmpfs testing
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

Add memory operations for file-backed and tmpfs memory.  Call existing
tests with these new memory operations to test collapse functionality
of khugepaged and MADV_COLLAPSE on file-backed and tmpfs memory.  Not all
tests are reusable; for example, collapse_swapin_single_pte() which
checks swap usage.

Refactor test arguments.  Usage is now:

Usage: ./khugepaged <test type> [dir]

        <test type>     : <context>:<mem_type>
        <context>       : [all|khugepaged|madvise]
        <mem_type>      : [all|anon|file]

        "file,all" mem_type requires [dir] argument

        "file,all" mem_type requires kernel built with
        CONFIG_READ_ONLY_THP_FOR_FS=y

        if [dir] is a (sub)directory of a tmpfs mount, tmpfs must be
        mounted with huge=madvise option for khugepaged tests to work

Refactor calling tests to make it clear what collapse context / memory
operations they support, but only invoke tests requested by user. Also log
what test is being ran, and with what context / memory, to make test logs
more human readable.

A new test file is created and deleted for every test to ensure no pages
remain in the page cache between tests.  Also, disable read_ahead_kb so
that pages don't find their way into the page cache without the tests
faulting them in.

Add file and shmem wrappers to vm_utils check for file and shmem
hugepages in smaps.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/vm/khugepaged.c | 401 ++++++++++++++++++++----
 tools/testing/selftests/vm/vm_util.c    |  10 +
 tools/testing/selftests/vm/vm_util.h    |   2 +
 3 files changed, 357 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index b4b1709507a5..0ddfffb87411 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -1,6 +1,7 @@
 #define _GNU_SOURCE
 #include <fcntl.h>
 #include <limits.h>
+#include <dirent.h>
 #include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -10,12 +11,20 @@
 
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+
+#include "linux/magic.h"
 
 #include "vm_util.h"
 
 #ifndef MADV_PAGEOUT
 #define MADV_PAGEOUT 21
 #endif
+#ifndef MADV_POPULATE_READ
+#define MADV_POPULATE_READ 22
+#endif
 #ifndef MADV_COLLAPSE
 #define MADV_COLLAPSE 25
 #endif
@@ -26,21 +35,48 @@ static unsigned long page_size;
 static int hpage_pmd_nr;
 
 #define THP_SYSFS "/sys/kernel/mm/transparent_hugepage/"
+#define READ_AHEAD_SYSFS "/sys/block/sda/queue/read_ahead_kb"
 #define PID_SMAPS "/proc/self/smaps"
+#define TEST_FILE "collapse_test_file"
+
+#define MAX_LINE_LENGTH 500
+
+enum vma_type {
+	VMA_ANON,
+	VMA_FILE,
+	VMA_SHMEM,
+};
 
 struct mem_ops {
 	void *(*setup_area)(int nr_hpages);
 	void (*cleanup_area)(void *p, unsigned long size);
 	void (*fault)(void *p, unsigned long start, unsigned long end);
 	bool (*check_huge)(void *addr, int nr_hpages);
+	const char *name;
 };
 
+static struct mem_ops *file_ops;
+static struct mem_ops *anon_ops;
+
 struct collapse_context {
 	void (*collapse)(const char *msg, char *p, int nr_hpages,
 			 struct mem_ops *ops, bool expect);
 	bool enforce_pte_scan_limits;
+	const char *name;
+};
+
+static struct collapse_context *khugepaged_context;
+static struct collapse_context *madvise_context;
+
+struct file_info {
+	const char *dir;
+	char path[MAX_LINE_LENGTH];
+	enum vma_type type;
+	int fd;
 };
 
+static struct file_info finfo;
+
 enum thp_enabled {
 	THP_ALWAYS,
 	THP_MADVISE,
@@ -106,6 +142,7 @@ struct settings {
 	enum shmem_enabled shmem_enabled;
 	bool use_zero_page;
 	struct khugepaged_settings khugepaged;
+	unsigned long read_ahead_kb;
 };
 
 static struct settings saved_settings;
@@ -124,6 +161,11 @@ static void fail(const char *msg)
 	exit_status++;
 }
 
+static void skip(const char *msg)
+{
+	printf(" \e[33m%s\e[0m\n", msg);
+}
+
 static int read_file(const char *path, char *buf, size_t buflen)
 {
 	int fd;
@@ -151,13 +193,19 @@ static int write_file(const char *path, const char *buf, size_t buflen)
 	ssize_t numwritten;
 
 	fd = open(path, O_WRONLY);
-	if (fd == -1)
+	if (fd == -1) {
+		printf("open(%s)\n", path);
+		exit(EXIT_FAILURE);
 		return 0;
+	}
 
 	numwritten = write(fd, buf, buflen - 1);
 	close(fd);
-	if (numwritten < 1)
+	if (numwritten < 1) {
+		printf("write(%s)\n", buf);
+		exit(EXIT_FAILURE);
 		return 0;
+	}
 
 	return (unsigned int) numwritten;
 }
@@ -224,20 +272,11 @@ static void write_string(const char *name, const char *val)
 	}
 }
 
-static const unsigned long read_num(const char *name)
+static const unsigned long _read_num(const char *path)
 {
-	char path[PATH_MAX];
 	char buf[21];
-	int ret;
-
-	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
-	if (ret >= PATH_MAX) {
-		printf("%s: Pathname is too long\n", __func__);
-		exit(EXIT_FAILURE);
-	}
 
-	ret = read_file(path, buf, sizeof(buf));
-	if (ret < 0) {
+	if (read_file(path, buf, sizeof(buf)) < 0) {
 		perror("read_file(read_num)");
 		exit(EXIT_FAILURE);
 	}
@@ -245,10 +284,9 @@ static const unsigned long read_num(const char *name)
 	return strtoul(buf, NULL, 10);
 }
 
-static void write_num(const char *name, unsigned long num)
+static const unsigned long read_num(const char *name)
 {
 	char path[PATH_MAX];
-	char buf[21];
 	int ret;
 
 	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
@@ -256,6 +294,12 @@ static void write_num(const char *name, unsigned long num)
 		printf("%s: Pathname is too long\n", __func__);
 		exit(EXIT_FAILURE);
 	}
+	return _read_num(path);
+}
+
+static void _write_num(const char *path, unsigned long num)
+{
+	char buf[21];
 
 	sprintf(buf, "%ld", num);
 	if (!write_file(path, buf, strlen(buf) + 1)) {
@@ -264,6 +308,19 @@ static void write_num(const char *name, unsigned long num)
 	}
 }
 
+static void write_num(const char *name, unsigned long num)
+{
+	char path[PATH_MAX];
+	int ret;
+
+	ret = snprintf(path, PATH_MAX, THP_SYSFS "%s", name);
+	if (ret >= PATH_MAX) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+	_write_num(path, num);
+}
+
 static void write_settings(struct settings *settings)
 {
 	struct khugepaged_settings *khugepaged = &settings->khugepaged;
@@ -283,6 +340,8 @@ static void write_settings(struct settings *settings)
 	write_num("khugepaged/max_ptes_swap", khugepaged->max_ptes_swap);
 	write_num("khugepaged/max_ptes_shared", khugepaged->max_ptes_shared);
 	write_num("khugepaged/pages_to_scan", khugepaged->pages_to_scan);
+
+	_write_num(READ_AHEAD_SYSFS, settings->read_ahead_kb);
 }
 
 #define MAX_SETTINGS_DEPTH 4
@@ -341,6 +400,7 @@ static void save_settings(void)
 		.shmem_enabled =
 			read_string("shmem_enabled", shmem_enabled_strings),
 		.use_zero_page = read_num("use_zero_page"),
+		.read_ahead_kb = _read_num(READ_AHEAD_SYSFS),
 	};
 	saved_settings.khugepaged = (struct khugepaged_settings) {
 		.defrag = read_num("khugepaged/defrag"),
@@ -361,7 +421,6 @@ static void save_settings(void)
 	signal(SIGQUIT, restore_settings);
 }
 
-#define MAX_LINE_LENGTH 500
 static bool check_swap(void *addr, unsigned long size)
 {
 	bool swap = false;
@@ -489,11 +548,109 @@ static bool anon_check_huge(void *addr, int nr_hpages)
 	return check_huge_anon(addr, nr_hpages, hpage_pmd_size);
 }
 
-static struct mem_ops anon_ops = {
+static void *file_setup_area(int nr_hpages)
+{
+	struct stat path_stat;
+	struct statfs fs;
+	int fd;
+	void *p;
+	unsigned long size;
+
+	stat(finfo.dir, &path_stat);
+	if (!S_ISDIR(path_stat.st_mode)) {
+		printf("%s: Not a directory (%s)\n", __func__, finfo.dir);
+		exit(EXIT_FAILURE);
+	}
+	if (snprintf(finfo.path, sizeof(finfo.path), "%s/" TEST_FILE,
+		     finfo.dir) >= sizeof(finfo.path)) {
+		printf("%s: Pathname is too long\n", __func__);
+		exit(EXIT_FAILURE);
+	}
+	if (statfs(finfo.dir, &fs)) {
+		perror("statfs()");
+		exit(EXIT_FAILURE);
+	}
+	finfo.type = fs.f_type == TMPFS_MAGIC ? VMA_SHMEM : VMA_FILE;
+
+	unlink(finfo.path);  /* Cleanup from previous failed tests */
+	printf("Creating %s for collapse%s...", finfo.path,
+	       finfo.type == VMA_SHMEM ? " (tmpfs)" : "");
+	fd = open(finfo.path, O_DSYNC | O_CREAT | O_RDWR | O_TRUNC | O_EXCL,
+		  777);
+	if (fd < 0) {
+		perror("open()");
+		exit(EXIT_FAILURE);
+	}
+
+	size = nr_hpages * hpage_pmd_size;
+	p = alloc_mapping(nr_hpages);
+	fill_memory(p, 0, size);
+	write(fd, p, size);
+	close(fd);
+	munmap(p, size);
+	success("OK");
+
+	printf("Opening %s read only for collapse...", finfo.path);
+	finfo.fd = open(finfo.path, O_RDONLY, 777);
+	if (finfo.fd < 0) {
+		perror("open()");
+		exit(EXIT_FAILURE);
+	}
+	p = mmap(BASE_ADDR, size, PROT_READ | PROT_EXEC,
+		 MAP_PRIVATE, finfo.fd, 0);
+	if (p == MAP_FAILED || p != BASE_ADDR) {
+		perror("mmap()");
+		exit(EXIT_FAILURE);
+	}
+
+	/* Drop page cache */
+	write_file("/proc/sys/vm/drop_caches", "3", 2);
+	success("OK");
+	return p;
+}
+
+static void file_cleanup_area(void *p, unsigned long size)
+{
+	munmap(p, size);
+	close(finfo.fd);
+	unlink(finfo.path);
+}
+
+static void file_fault(void *p, unsigned long start, unsigned long end)
+{
+	if (madvise(((char *)p) + start, end - start, MADV_POPULATE_READ)) {
+		perror("madvise(MADV_POPULATE_READ");
+		exit(EXIT_FAILURE);
+	}
+}
+
+static bool file_check_huge(void *addr, int nr_hpages)
+{
+	switch (finfo.type) {
+	case VMA_FILE:
+		return check_huge_file(addr, nr_hpages, hpage_pmd_size);
+	case VMA_SHMEM:
+		return check_huge_shmem(addr, nr_hpages, hpage_pmd_size);
+	default:
+		exit(EXIT_FAILURE);
+		return false;
+	}
+}
+
+static struct mem_ops __anon_ops = {
 	.setup_area = &anon_setup_area,
 	.cleanup_area = &anon_cleanup_area,
 	.fault = &anon_fault,
 	.check_huge = &anon_check_huge,
+	.name = "anon",
+};
+
+static struct mem_ops __file_ops = {
+	.setup_area = &file_setup_area,
+	.cleanup_area = &file_cleanup_area,
+	.fault = &file_fault,
+	.check_huge = &file_check_huge,
+	.name = "file",
 };
 
 static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
@@ -509,6 +666,7 @@ static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
 	 * ignores /sys/kernel/mm/transparent_hugepage/enabled
 	 */
 	settings.thp_enabled = THP_NEVER;
+	settings.shmem_enabled = SHMEM_NEVER;
 	push_settings(&settings);
 
 	/* Clear VM_NOHUGEPAGE */
@@ -580,12 +738,37 @@ static void khugepaged_collapse(const char *msg, char *p, int nr_hpages,
 		return;
 	}
 
+	/*
+	 * For file and shmem memory, khugepaged only retracts pte entries after
+	 * putting the new hugepage in the page cache. The hugepage must be
+	 * subsequently refaulted to install the pmd mapping for the mm.
+	 */
+	if (ops != &__anon_ops)
+		ops->fault(p, 0, nr_hpages * hpage_pmd_size);
+
 	if (ops->check_huge(p, expect ? nr_hpages : 0))
 		success("OK");
 	else
 		fail("Fail");
 }
 
+static struct collapse_context __khugepaged_context = {
+	.collapse = &khugepaged_collapse,
+	.enforce_pte_scan_limits = true,
+	.name = "khugepaged",
+};
+
+static struct collapse_context __madvise_context = {
+	.collapse = &madvise_collapse,
+	.enforce_pte_scan_limits = false,
+	.name = "madvise",
+};
+
+static bool is_tmpfs(struct mem_ops *ops)
+{
+	return ops == &__file_ops && finfo.type == VMA_SHMEM;
+}
+
 static void alloc_at_fault(void)
 {
 	struct settings settings = *current_settings();
@@ -658,6 +841,13 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
 
 	p = ops->setup_area(1);
 
+	if (is_tmpfs(ops)) {
+		/* shmem pages always in the page cache */
+		printf("tmpfs...");
+		skip("Skip");
+		goto skip;
+	}
+
 	ops->fault(p, 0, (hpage_pmd_nr - max_ptes_none - 1) * page_size);
 	c->collapse("Maybe collapse with max_ptes_none exceeded", p, 1,
 		    ops, !c->enforce_pte_scan_limits);
@@ -670,6 +860,7 @@ static void collapse_max_ptes_none(struct collapse_context *c, struct mem_ops *o
 		validate_memory(p, 0,
 				(hpage_pmd_nr - max_ptes_none) * page_size);
 	}
+skip:
 	ops->cleanup_area(p, hpage_pmd_size);
 	pop_settings();
 }
@@ -753,6 +944,13 @@ static void collapse_single_pte_entry_compound(struct collapse_context *c, struc
 
 	p = alloc_hpage(ops);
 
+	if (is_tmpfs(ops)) {
+		/* MADV_DONTNEED won't evict tmpfs pages */
+		printf("tmpfs...");
+		skip("Skip");
+		goto skip;
+	}
+
 	madvise(p, hpage_pmd_size, MADV_NOHUGEPAGE);
 	printf("Split huge page leaving single PTE mapping compound page...");
 	madvise(p + page_size, hpage_pmd_size - page_size, MADV_DONTNEED);
@@ -764,6 +962,7 @@ static void collapse_single_pte_entry_compound(struct collapse_context *c, struc
 	c->collapse("Collapse PTE table with single PTE mapping compound page",
 		    p, 1, ops, true);
 	validate_memory(p, 0, page_size);
+skip:
 	ops->cleanup_area(p, hpage_pmd_size);
 }
 
@@ -1010,9 +1209,72 @@ static void madvise_collapse_existing_thps(struct collapse_context *c,
 	ops->cleanup_area(p, hpage_pmd_size);
 }
 
+static void usage(void)
+{
+	fprintf(stderr, "\nUsage: ./khugepaged <test type> [dir]\n\n");
+	fprintf(stderr, "\t<test type>\t: <context>:<mem_type>\n");
+	fprintf(stderr, "\t<context>\t: [all|khugepaged|madvise]\n");
+	fprintf(stderr, "\t<mem_type>\t: [all|anon|file]\n");
+	fprintf(stderr, "\n\t\"file,all\" mem_type requires [dir] argument\n");
+	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
+	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
+	fprintf(stderr, "\n\tif [dir] is a (sub)directory of a tmpfs mount, tmpfs must be\n");
+	fprintf(stderr,	"\tmounted with huge=madvise option for khugepaged tests to work\n");
+	exit(1);
+}
+
+static void parse_test_type(int argc, const char **argv)
+{
+	char *buf;
+	const char *token;
+
+	if (argc == 1) {
+		/* Backwards compatibility */
+		khugepaged_context =  &__khugepaged_context;
+		madvise_context =  &__madvise_context;
+		anon_ops = &__anon_ops;
+		return;
+	}
+
+	buf = strdup(argv[1]);
+	token = strsep(&buf, ":");
+
+	if (!strcmp(token, "all")) {
+		khugepaged_context =  &__khugepaged_context;
+		madvise_context =  &__madvise_context;
+	} else if (!strcmp(token, "khugepaged")) {
+		khugepaged_context =  &__khugepaged_context;
+	} else if (!strcmp(token, "madvise")) {
+		madvise_context =  &__madvise_context;
+	} else {
+		usage();
+	}
+
+	if (!buf)
+		usage();
+
+	if (!strcmp(buf, "all")) {
+		file_ops =  &__file_ops;
+		anon_ops = &__anon_ops;
+	} else if (!strcmp(buf, "anon")) {
+		anon_ops = &__anon_ops;
+	} else if (!strcmp(buf, "file")) {
+		file_ops =  &__file_ops;
+	} else {
+		usage();
+	}
+
+	if (!file_ops)
+		return;
+
+	if (argc != 3)
+		usage();
+
+	finfo.dir = argv[2];
+}
+
 int main(int argc, const char **argv)
 {
-	struct collapse_context c;
 	struct settings default_settings = {
 		.thp_enabled = THP_MADVISE,
 		.thp_defrag = THP_DEFRAG_ALWAYS,
@@ -1023,8 +1285,17 @@ int main(int argc, const char **argv)
 			.alloc_sleep_millisecs = 10,
 			.scan_sleep_millisecs = 10,
 		},
+		/*
+		 * When testing file-backed memory, the collapse path
+		 * looks at how many pages are found in the page cache, not
+		 * what pages are mapped. Disable read ahead optimization so
+		 * pages don't find their way into the page cache unless
+		 * we mem_ops->fault() them in.
+		 */
+		.read_ahead_kb = 0,
 	};
-	const char *tests = argc == 1 ? "all" : argv[1];
+
+	parse_test_type(argc, argv);
 
 	setbuf(stdout, NULL);
 
@@ -1042,43 +1313,61 @@ int main(int argc, const char **argv)
 
 	alloc_at_fault();
 
-	if (!strcmp(tests, "khugepaged") || !strcmp(tests, "all")) {
-		printf("\n*** Testing context: khugepaged ***\n");
-		c.collapse = &khugepaged_collapse;
-		c.enforce_pte_scan_limits = true;
-
-		collapse_full(&c, &anon_ops);
-		collapse_empty(&c, &anon_ops);
-		collapse_single_pte_entry(&c, &anon_ops);
-		collapse_max_ptes_none(&c, &anon_ops);
-		collapse_swapin_single_pte(&c, &anon_ops);
-		collapse_max_ptes_swap(&c, &anon_ops);
-		collapse_single_pte_entry_compound(&c, &anon_ops);
-		collapse_full_of_compound(&c, &anon_ops);
-		collapse_compound_extreme(&c, &anon_ops);
-		collapse_fork(&c, &anon_ops);
-		collapse_fork_compound(&c, &anon_ops);
-		collapse_max_ptes_shared(&c, &anon_ops);
-	}
-	if (!strcmp(tests, "madvise") || !strcmp(tests, "all")) {
-		printf("\n*** Testing context: madvise ***\n");
-		c.collapse = &madvise_collapse;
-		c.enforce_pte_scan_limits = false;
-
-		collapse_full(&c, &anon_ops);
-		collapse_empty(&c, &anon_ops);
-		collapse_single_pte_entry(&c, &anon_ops);
-		collapse_max_ptes_none(&c, &anon_ops);
-		collapse_swapin_single_pte(&c, &anon_ops);
-		collapse_max_ptes_swap(&c, &anon_ops);
-		collapse_single_pte_entry_compound(&c, &anon_ops);
-		collapse_full_of_compound(&c, &anon_ops);
-		collapse_compound_extreme(&c, &anon_ops);
-		collapse_fork(&c, &anon_ops);
-		collapse_fork_compound(&c, &anon_ops);
-		collapse_max_ptes_shared(&c, &anon_ops);
-		madvise_collapse_existing_thps(&c, &anon_ops);
-	}
+#define TEST(t, c, o) do { \
+	if (c && o) { \
+		printf("\nRun test: " #t " (%s:%s)\n", c->name, o->name); \
+		t(c, o); \
+	} \
+	} while (0)
+
+	TEST(collapse_full, khugepaged_context, anon_ops);
+	TEST(collapse_full, khugepaged_context, file_ops);
+	TEST(collapse_full, madvise_context, anon_ops);
+	TEST(collapse_full, madvise_context, file_ops);
+
+	TEST(collapse_empty, khugepaged_context, anon_ops);
+	TEST(collapse_empty, madvise_context, anon_ops);
+
+	TEST(collapse_single_pte_entry, khugepaged_context, anon_ops);
+	TEST(collapse_single_pte_entry, khugepaged_context, file_ops);
+	TEST(collapse_single_pte_entry, madvise_context, anon_ops);
+	TEST(collapse_single_pte_entry, madvise_context, file_ops);
+
+	TEST(collapse_max_ptes_none, khugepaged_context, anon_ops);
+	TEST(collapse_max_ptes_none, khugepaged_context, file_ops);
+	TEST(collapse_max_ptes_none, madvise_context, anon_ops);
+	TEST(collapse_max_ptes_none, madvise_context, file_ops);
+
+	TEST(collapse_single_pte_entry_compound, khugepaged_context, anon_ops);
+	TEST(collapse_single_pte_entry_compound, khugepaged_context, file_ops);
+	TEST(collapse_single_pte_entry_compound, madvise_context, anon_ops);
+	TEST(collapse_single_pte_entry_compound, madvise_context, file_ops);
+
+	TEST(collapse_full_of_compound, khugepaged_context, anon_ops);
+	TEST(collapse_full_of_compound, khugepaged_context, file_ops);
+	TEST(collapse_full_of_compound, madvise_context, anon_ops);
+	TEST(collapse_full_of_compound, madvise_context, file_ops);
+
+	TEST(collapse_compound_extreme, khugepaged_context, anon_ops);
+	TEST(collapse_compound_extreme, madvise_context, anon_ops);
+
+	TEST(collapse_swapin_single_pte, khugepaged_context, anon_ops);
+	TEST(collapse_swapin_single_pte, madvise_context, anon_ops);
+
+	TEST(collapse_max_ptes_swap, khugepaged_context, anon_ops);
+	TEST(collapse_max_ptes_swap, madvise_context, anon_ops);
+
+	TEST(collapse_fork, khugepaged_context, anon_ops);
+	TEST(collapse_fork, madvise_context, anon_ops);
+
+	TEST(collapse_fork_compound, khugepaged_context, anon_ops);
+	TEST(collapse_fork_compound, madvise_context, anon_ops);
+
+	TEST(collapse_max_ptes_shared, khugepaged_context, anon_ops);
+	TEST(collapse_max_ptes_shared, madvise_context, anon_ops);
+
+	TEST(madvise_collapse_existing_thps, madvise_context, anon_ops);
+	TEST(madvise_collapse_existing_thps, madvise_context, file_ops);
 
 	restore_settings(0);
 }
diff --git a/tools/testing/selftests/vm/vm_util.c b/tools/testing/selftests/vm/vm_util.c
index 9dae51b8219f..f11f8adda521 100644
--- a/tools/testing/selftests/vm/vm_util.c
+++ b/tools/testing/selftests/vm/vm_util.c
@@ -114,3 +114,13 @@ bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size)
 {
 	return __check_huge(addr, "AnonHugePages: ", nr_hpages, hpage_size);
 }
+
+bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size)
+{
+	return __check_huge(addr, "FilePmdMapped:", nr_hpages, hpage_size);
+}
+
+bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size)
+{
+	return __check_huge(addr, "ShmemPmdMapped:", nr_hpages, hpage_size);
+}
diff --git a/tools/testing/selftests/vm/vm_util.h b/tools/testing/selftests/vm/vm_util.h
index 8434ea0c95cd..5c35de454e08 100644
--- a/tools/testing/selftests/vm/vm_util.h
+++ b/tools/testing/selftests/vm/vm_util.h
@@ -8,3 +8,5 @@ void clear_softdirty(void);
 bool check_for_pattern(FILE *fp, const char *pattern, char *buf, size_t len);
 uint64_t read_pmd_pagesize(void);
 bool check_huge_anon(void *addr, int nr_hpages, uint64_t hpage_size);
+bool check_huge_file(void *addr, int nr_hpages, uint64_t hpage_size);
+bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
-- 
2.37.2.672.g94769d06f0-goog

