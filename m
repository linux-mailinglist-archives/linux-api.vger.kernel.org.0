Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC75B0759
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiIGOqF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiIGOpt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:49 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3197331D
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:48 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id t18-20020a17090ad51200b00200aaa66422so2243144pju.0
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=eptMqZsXfthc4Fo3nDS8AoWTbJT6CSImKGcX5IRPq98=;
        b=TTssvBqf26eSJ/3HRBZ7OIpS4VLeSLyfUOmqi+jI4iXPNHD8PZ9Z+NRWzCX+P/3jCO
         NrJpBd6jgC0D8arkaOmU4/P3ReDlD0qVYnDQqsa0pA4utInPlpmkqQfBLX4pvtHwLrR/
         PFr15plil+THMXoA5H0Wy7HOAP/rkDUaKEeivNJerHL7Lskxs58nl47f9b9SSnoJhdhV
         Kh4NPp5dLgEFJCV9MFwhtbrwBhY7kSgVBtsq+Mi0D+umwk642dhwnxi+OkkHxiQWg+CD
         nfkWkea6IuJTBZKEVnLfjO6YCPhEY677uqPBhsmPAoD8/OvyldbJT/qGUGPA+dq7+Cin
         xxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=eptMqZsXfthc4Fo3nDS8AoWTbJT6CSImKGcX5IRPq98=;
        b=iImAmzl+o2XtFFTXoLUxakNYoQBiSYx8bn0DOt13d/LMrdmmhig0JyARJ5x+vhbnpq
         ZRO77lkXKzJzi5Z4uFSCwxac6QKpqXQCmE/xz9rpNfFRjDcAg+TlqxACqrIIDg9yENhK
         uGGt106gENbVYZMngS/vw6eWpvUQCcu3OyxJnNX1nrle4TCuONiyVZqGaeU7SgLcSR+i
         g0iEy29ztsj6vtHUNjkGJO0jeGLkxjrIYJ/NLPo2W7/Fj3bBXaQ/LEgvXrZQzxKedRnf
         aGQUGG2xf9X3iB3PfXoMWhUICYYAw6NpjMLVdedtwdYPzEfTB/0zIQDorrd2DtmnkVG/
         UM6Q==
X-Gm-Message-State: ACgBeo3x1CNtEm4VVyYAKBwrO6OGtxHCZO4afPlyBNwWajtHznNxNnhj
        1V6V7OTEYkiOZVG8PsDMQGSG8NlQIhi7
X-Google-Smtp-Source: AA6agR5PUIpjR65xaT9rRH0ZEW/PyWeAVTl4DMB7WjwcrnUcJyP+cZuGbCU/W8amXtmaFZ89TEMrqxw5WRWj
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr19770pje.0.1662561947963; Wed, 07 Sep
 2022 07:45:47 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:19 -0700
In-Reply-To: <20220907144521.3115321-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-9-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 08/10] selftests/vm: add thp collapse shmem testing
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
index 59f56a329f43..05d9945daa48 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -58,6 +58,7 @@ struct mem_ops {
 
 static struct mem_ops *file_ops;
 static struct mem_ops *anon_ops;
+static struct mem_ops *shmem_ops;
 
 struct collapse_context {
 	void (*collapse)(const char *msg, char *p, int nr_hpages,
@@ -708,6 +709,40 @@ static bool file_check_huge(void *addr, int nr_hpages)
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
@@ -724,6 +759,14 @@ static struct mem_ops __file_ops = {
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
@@ -1285,7 +1328,7 @@ static void usage(void)
 	fprintf(stderr, "\nUsage: ./khugepaged <test type> [dir]\n\n");
 	fprintf(stderr, "\t<test type>\t: <context>:<mem_type>\n");
 	fprintf(stderr, "\t<context>\t: [all|khugepaged|madvise]\n");
-	fprintf(stderr, "\t<mem_type>\t: [all|anon|file]\n");
+	fprintf(stderr, "\t<mem_type>\t: [all|anon|file|shmem]\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires [dir] argument\n");
 	fprintf(stderr, "\n\t\"file,all\" mem_type requires kernel built with\n");
 	fprintf(stderr,	"\tCONFIG_READ_ONLY_THP_FOR_FS=y\n");
@@ -1327,10 +1370,13 @@ static void parse_test_type(int argc, const char **argv)
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
@@ -1347,7 +1393,7 @@ int main(int argc, const char **argv)
 	struct settings default_settings = {
 		.thp_enabled = THP_MADVISE,
 		.thp_defrag = THP_DEFRAG_ALWAYS,
-		.shmem_enabled = SHMEM_NEVER,
+		.shmem_enabled = SHMEM_ADVISE,
 		.use_zero_page = 0,
 		.khugepaged = {
 			.defrag = 1,
@@ -1394,16 +1440,20 @@ int main(int argc, const char **argv)
 
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
@@ -1417,8 +1467,10 @@ int main(int argc, const char **argv)
 
 	TEST(collapse_full_of_compound, khugepaged_context, anon_ops);
 	TEST(collapse_full_of_compound, khugepaged_context, file_ops);
+	TEST(collapse_full_of_compound, khugepaged_context, shmem_ops);
 	TEST(collapse_full_of_compound, madvise_context, anon_ops);
 	TEST(collapse_full_of_compound, madvise_context, file_ops);
+	TEST(collapse_full_of_compound, madvise_context, shmem_ops);
 
 	TEST(collapse_compound_extreme, khugepaged_context, anon_ops);
 	TEST(collapse_compound_extreme, madvise_context, anon_ops);
@@ -1440,6 +1492,7 @@ int main(int argc, const char **argv)
 
 	TEST(madvise_collapse_existing_thps, madvise_context, anon_ops);
 	TEST(madvise_collapse_existing_thps, madvise_context, file_ops);
+	TEST(madvise_collapse_existing_thps, madvise_context, shmem_ops);
 
 	restore_settings(0);
 }
-- 
2.37.2.789.g6183377224-goog

