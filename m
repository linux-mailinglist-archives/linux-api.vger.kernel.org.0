Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2A5E6FD9
	for <lists+linux-api@lfdr.de>; Fri, 23 Sep 2022 00:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiIVWlK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Sep 2022 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIVWlH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Sep 2022 18:41:07 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA28102539
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:41:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id my9-20020a17090b4c8900b002027721b2b0so2294489pjb.6
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=P0VJ6zxKB3GbTh5oZqe1dUT4NE74SChYC1EfGCnujzg=;
        b=pEVeQtHD/RiUPS6BQVDmVSO6d9cqux3HNIsbS+o17OlMomJfw/3FK6FEGcyv+kdBgZ
         W5dPHuLzknWPBIs+SQwV0Gl0t106M30Y5wGgBXlZF/6iKDOG62eT34vDrOE/Smpn8PjY
         kOlK0P/Qce0O0TA/eNRZvKAg6ihwPu4iHg8MmgFvXaNCshhyTLVBtsEcmtXT3Fa6gLOb
         C3wQGrDBbT9a3E98huUZ40sPyPYoEj9t5i5Gwvk8ZuXyYQGxu+gOcvlLnt7fHVhhwNrZ
         4CucWN/dEqe34ED6jl192tLV6NrEXN/ijiEIg9xsacsoCEqQTiqGkIimE6++73cJbiDK
         XA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=P0VJ6zxKB3GbTh5oZqe1dUT4NE74SChYC1EfGCnujzg=;
        b=yo+98VdOGjuTGm0Rp5dSvYDk44t1Fd3yAVxySJQuh4HG2d3XRe/7+EsXEJH60mL5TX
         mUPxvVM7OsDn6H0+QIERWC5IjNhn3k34bG22wT9eavVf6kH3GihmA3UID8XMgpWbbSJW
         FGNOkAkW+je5cfgLxTV0wEGPYqnTgosTskrs3ypGqpawvr+qJgq+RxtZ1M3iSROD373k
         ctxa0vxnJBeMbfVEJfOJKVVKpNbGsz0qGvkKbmq2i7ssRGP+2Z6g1m4gcRAKrsmN2REd
         LDfkWY6ts6rZmyLBEQGrE2MVDRubpFrwwfSXxzBCBZkxaVZGAAXJEx1zDRfKnfXJBIj4
         8r2g==
X-Gm-Message-State: ACrzQf1fY8pJvmxNOaaPedEogQPCgySWeXm4MuXuWtvtvMWkuh3Wc6Nq
        4d4ZIUcpxF+bwV5O/GGxSPKuI277D/cM
X-Google-Smtp-Source: AMsMyM4KYG2nJJhfmLexvDlcN2rPrDHcskX9T39zGlXNxRgoqkufi3Y4qMcSojpUmf5+5BpufdkZ6xF6MTVs
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:114c:b0:528:2c7a:630e with SMTP
 id b12-20020a056a00114c00b005282c7a630emr5840136pfm.86.1663886462491; Thu, 22
 Sep 2022 15:41:02 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:40:44 -0700
In-Reply-To: <20220922224046.1143204-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922224046.1143204-9-zokeefe@google.com>
Subject: [PATCH mm-unstable v4 08/10] selftests/vm: add thp collapse shmem testing
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
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
        Patrick Xia <patrickx@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add memory operations for shmem (memfd) memory, and reuse existing tests
with the new memory operations.

Shmem tests can be called with "shmem" mem_type, and shmem tests are ran
with "all" mem_type as well.

Link: https://lkml.kernel.org/r/20220907144521.3115321-9-zokeefe@google.com
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Chris Kennelly <ckennelly@google.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yang Shi <shy828301@gmail.com>
---
 tools/testing/selftests/vm/khugepaged.c | 57 ++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 08de6141c2af..eabbd2710096 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -59,6 +59,7 @@ struct mem_ops {
 
 static struct mem_ops *file_ops;
 static struct mem_ops *anon_ops;
+static struct mem_ops *shmem_ops;
 
 struct collapse_context {
 	void (*collapse)(const char *msg, char *p, int nr_hpages,
@@ -739,6 +740,40 @@ static bool file_check_huge(void *addr, int nr_hpages)
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
@@ -755,6 +790,14 @@ static struct mem_ops __file_ops = {
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
@@ -1315,7 +1358,7 @@ static void usage(void)
 	fprintf(stderr, "\nUsage: ./khugepaged <test type> [dir]\n\n");
 	fprintf(stderr, "\t<test type>\t: <context>:<mem_type>\n");
 	fprintf(stderr, "\t<context>\t: [all|khugepaged|madvise]\n");
-	fprintf(stderr, "\t<mem_type>\t: [all|anon|file]\n");
+	fprintf(stderr, "\t<mem_type>\t: [all|anon|file|shmem]\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires [dir] argument\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
 	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
@@ -1357,10 +1400,13 @@ static void parse_test_type(int argc, const char **argv)
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
@@ -1377,7 +1423,7 @@ int main(int argc, const char **argv)
 	struct settings default_settings = {
 		.thp_enabled = THP_MADVISE,
 		.thp_defrag = THP_DEFRAG_ALWAYS,
-		.shmem_enabled = SHMEM_NEVER,
+		.shmem_enabled = SHMEM_ADVISE,
 		.use_zero_page = 0,
 		.khugepaged = {
 			.defrag = 1,
@@ -1424,16 +1470,20 @@ int main(int argc, const char **argv)
 
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
@@ -1447,8 +1497,10 @@ int main(int argc, const char **argv)
 
 	TEST(collapse_full_of_compound, khugepaged_context, anon_ops);
 	TEST(collapse_full_of_compound, khugepaged_context, file_ops);
+	TEST(collapse_full_of_compound, khugepaged_context, shmem_ops);
 	TEST(collapse_full_of_compound, madvise_context, anon_ops);
 	TEST(collapse_full_of_compound, madvise_context, file_ops);
+	TEST(collapse_full_of_compound, madvise_context, shmem_ops);
 
 	TEST(collapse_compound_extreme, khugepaged_context, anon_ops);
 	TEST(collapse_compound_extreme, madvise_context, anon_ops);
@@ -1470,6 +1522,7 @@ int main(int argc, const char **argv)
 
 	TEST(madvise_collapse_existing_thps, madvise_context, anon_ops);
 	TEST(madvise_collapse_existing_thps, madvise_context, file_ops);
+	TEST(madvise_collapse_existing_thps, madvise_context, shmem_ops);
 
 	restore_settings(0);
 }
-- 
2.37.3.998.g577e59143f-goog

