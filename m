Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AEE5A31B1
	for <lists+linux-api@lfdr.de>; Sat, 27 Aug 2022 00:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344447AbiHZWDv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Aug 2022 18:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239360AbiHZWDt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Aug 2022 18:03:49 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08689DAEEF
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:48 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 196-20020a6301cd000000b0041b0f053fd1so1405018pgb.6
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=r4w9NufzePdVztPtjIIPVWCK5v6Iu7NS+jmAu51qoDw=;
        b=RD3ae8mUYCndIuqcrdUkWwnIpI9D1rlw5mF0SzhiW9XVckzCuWjmXvSx2o5O+VU4cm
         miGqjOdGoyM4FbdYZrvstvmWyvSdMGYBtdnJFmS4/RQwRjfR70+Q/JrzqZHt6l1swgNd
         9tydce9hRCJEqf0RNRZehspPi8BEqKqgDJvCP/H16t4WIyCR6/tS90cS6qdRPgYEwpbG
         ZX3TIEpXzmSBjQjkOoOZRrtpUv7Z/l/i1iezQGWpzmZJ3PJSMMF27Ra6Q3LdMD7heEbL
         xj9d7j/yWXy+fp2tZDmW3RSDUC9Mpul6VKqBgQI1NKekD42Zeok6Uu8K20IuHQqnnImW
         dKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=r4w9NufzePdVztPtjIIPVWCK5v6Iu7NS+jmAu51qoDw=;
        b=6AJB02jOcpUWwxnSZDAoZZfYvdWaVEnH6CF1ViQIlOEmz9wycwijTgp9vid4AlLK4P
         Y/p101fIAXWoAFs/3E+ffexIps3O57u2ET4lrqQDifh+zxR3MxSqN8srWRlq6wc+HLdj
         5Q5ILxIzXGJIr+fqUURTwZCc40ysrYBi/7e6KU5l2yVBZvTKrsHD2XEluK5n3I7sH6qo
         LgiXtoromzeL98b+YBh/hReKmxM6bsBhXkSc2Q/Rk2ESKC2kvrRAhU3egR63QjAsMlXk
         0Jtijv8jhIrrZYWvxNDUXcA1nXRqHBrCAvBLn1vKHjPkCqnjp5G/DaJHrMELQopfBT38
         QcJg==
X-Gm-Message-State: ACgBeo36ybICN6Xe3fkX3ZxXiR684c9vjkKwdhBe1Po+pXBONRAr1rYZ
        Wrg5GavVkJiFtFA+GEIehOyUWxlncnyX
X-Google-Smtp-Source: AA6agR5fKWqmc4//Mf+ya0Ipgzwg+b/hNRW14y/vb3H4wC+X2DjoL7SQ+EHvqRR7b5TCSZOWdplrYeLWm8m3
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:21c2:b0:52b:ff44:6680 with SMTP
 id t2-20020a056a0021c200b0052bff446680mr5780390pfj.57.1661551427588; Fri, 26
 Aug 2022 15:03:47 -0700 (PDT)
Date:   Fri, 26 Aug 2022 15:03:27 -0700
In-Reply-To: <20220826220329.1495407-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826220329.1495407-9-zokeefe@google.com>
Subject: [PATCH mm-unstable v2 8/9] selftests/vm: add thp collapse shmem testing
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

Add memory operations for shmem (memfd) memory, and reuse
existing tests with the new memory operations.

Shmem tests can be called with "shmem" mem_type, and shmem tests
are ran with "all" mem_type as well.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/vm/khugepaged.c | 57 ++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 0ddfffb87411..9a136f65d43a 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -57,6 +57,7 @@ struct mem_ops {
 
 static struct mem_ops *file_ops;
 static struct mem_ops *anon_ops;
+static struct mem_ops *shmem_ops;
 
 struct collapse_context {
 	void (*collapse)(const char *msg, char *p, int nr_hpages,
@@ -637,6 +638,40 @@ static bool file_check_huge(void *addr, int nr_hpages)
 	}
 }
 
+static void *shmem_setup_area(int nr_hpages)
+{
+	void *p;
+	unsigned long size = nr_hpages * hpage_pmd_size;
+
+	finfo.fd = memfd_create("khugepaged-selftest-collapse-shmem", 0);
+	if (finfo.fd < 0)  {
+		perror("memfd_create()");
+		exit(EXIT_FAILURE);
+	}
+	if (ftruncate(finfo.fd, size)) {
+		perror("ftruncate()");
+		exit(EXIT_FAILURE);
+	}
+	p = mmap(BASE_ADDR, size, PROT_READ | PROT_WRITE, MAP_SHARED, finfo.fd,
+		 0);
+	if (p != BASE_ADDR) {
+		perror("mmap()");
+		exit(EXIT_FAILURE);
+	}
+	return p;
+}
+
+static void shmem_cleanup_area(void *p, unsigned long size)
+{
+	munmap(p, size);
+	close(finfo.fd);
+}
+
+static bool shmem_check_huge(void *addr, int nr_hpages)
+{
+	return check_huge_shmem(addr, nr_hpages, hpage_pmd_size);
+}
+
 static struct mem_ops __anon_ops = {
 	.setup_area = &anon_setup_area,
 	.cleanup_area = &anon_cleanup_area,
@@ -653,6 +688,14 @@ static struct mem_ops __file_ops = {
 	.name = "file",
 };
 
+static struct mem_ops __shmem_ops = {
+	.setup_area = &shmem_setup_area,
+	.cleanup_area = &shmem_cleanup_area,
+	.fault = &anon_fault,
+	.check_huge = &shmem_check_huge,
+	.name = "shmem",
+};
+
 static void __madvise_collapse(const char *msg, char *p, int nr_hpages,
 			       struct mem_ops *ops, bool expect)
 {
@@ -1214,7 +1257,7 @@ static void usage(void)
 	fprintf(stderr, "\nUsage: ./khugepaged <test type> [dir]\n\n");
 	fprintf(stderr, "\t<test type>\t: <context>:<mem_type>\n");
 	fprintf(stderr, "\t<context>\t: [all|khugepaged|madvise]\n");
-	fprintf(stderr, "\t<mem_type>\t: [all|anon|file]\n");
+	fprintf(stderr, "\t<mem_type>\t: [all|anon|file|shmem]\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires [dir] argument\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
 	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
@@ -1256,10 +1299,13 @@ static void parse_test_type(int argc, const char **argv)
 	if (!strcmp(buf, "all")) {
 		file_ops =  &__file_ops;
 		anon_ops = &__anon_ops;
+		shmem_ops = &__shmem_ops;
 	} else if (!strcmp(buf, "anon")) {
 		anon_ops = &__anon_ops;
 	} else if (!strcmp(buf, "file")) {
 		file_ops =  &__file_ops;
+	} else if (!strcmp(buf, "shmem")) {
+		shmem_ops = &__shmem_ops;
 	} else {
 		usage();
 	}
@@ -1278,7 +1324,7 @@ int main(int argc, const char **argv)
 	struct settings default_settings = {
 		.thp_enabled = THP_MADVISE,
 		.thp_defrag = THP_DEFRAG_ALWAYS,
-		.shmem_enabled = SHMEM_NEVER,
+		.shmem_enabled = SHMEM_ADVISE,
 		.use_zero_page = 0,
 		.khugepaged = {
 			.defrag = 1,
@@ -1322,16 +1368,20 @@ int main(int argc, const char **argv)
 
 	TEST(collapse_full, khugepaged_context, anon_ops);
 	TEST(collapse_full, khugepaged_context, file_ops);
+	TEST(collapse_full, khugepaged_context, shmem_ops);
 	TEST(collapse_full, madvise_context, anon_ops);
 	TEST(collapse_full, madvise_context, file_ops);
+	TEST(collapse_full, madvise_context, shmem_ops);
 
 	TEST(collapse_empty, khugepaged_context, anon_ops);
 	TEST(collapse_empty, madvise_context, anon_ops);
 
 	TEST(collapse_single_pte_entry, khugepaged_context, anon_ops);
 	TEST(collapse_single_pte_entry, khugepaged_context, file_ops);
+	TEST(collapse_single_pte_entry, khugepaged_context, shmem_ops);
 	TEST(collapse_single_pte_entry, madvise_context, anon_ops);
 	TEST(collapse_single_pte_entry, madvise_context, file_ops);
+	TEST(collapse_single_pte_entry, madvise_context, shmem_ops);
 
 	TEST(collapse_max_ptes_none, khugepaged_context, anon_ops);
 	TEST(collapse_max_ptes_none, khugepaged_context, file_ops);
@@ -1345,8 +1395,10 @@ int main(int argc, const char **argv)
 
 	TEST(collapse_full_of_compound, khugepaged_context, anon_ops);
 	TEST(collapse_full_of_compound, khugepaged_context, file_ops);
+	TEST(collapse_full_of_compound, khugepaged_context, shmem_ops);
 	TEST(collapse_full_of_compound, madvise_context, anon_ops);
 	TEST(collapse_full_of_compound, madvise_context, file_ops);
+	TEST(collapse_full_of_compound, madvise_context, shmem_ops);
 
 	TEST(collapse_compound_extreme, khugepaged_context, anon_ops);
 	TEST(collapse_compound_extreme, madvise_context, anon_ops);
@@ -1368,6 +1420,7 @@ int main(int argc, const char **argv)
 
 	TEST(madvise_collapse_existing_thps, madvise_context, anon_ops);
 	TEST(madvise_collapse_existing_thps, madvise_context, file_ops);
+	TEST(madvise_collapse_existing_thps, madvise_context, shmem_ops);
 
 	restore_settings(0);
 }
-- 
2.37.2.672.g94769d06f0-goog

