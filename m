Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9E35E6FDA
	for <lists+linux-api@lfdr.de>; Fri, 23 Sep 2022 00:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIVWlM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Sep 2022 18:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiIVWlI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Sep 2022 18:41:08 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4ECA103FEF
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:41:04 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l72-20020a63914b000000b00434ac6f8214so6027132pge.13
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=yfmQyCpPKoozqzWfXY5DtmVT4vjPpKAbwFoVy0wbyyY=;
        b=jgxIKy0YnIHXFu7DxVvRJF6oQBx1pTOqEYXftlCJey9nT6iUS3R6jcjq/aEUZAp8jj
         kobCKngbcpA8+rJaJfm3kD6GMY1LeQJBxQL/4wwCXYAq+2O1P/sQSSi3pZCl+ikexaSE
         fP9W1AVrmYow9I0eu5zMFEk3eioPkgwaI5AIOdzr+/Ocmc6LQK1eapuu2RE+/aa+kuzM
         325FrgT+Ci4Hm9rqbt+QWDaOwOuQJ6FkIbDWW+mKjVqONLtmwWkjvjd3hdSb5sBlYR9T
         MUygV+LTmuwWsKA30a4i11osCLlc8sXzy6v5fgbxdPR00x4r+c5xfVuMScs2oyfp68cb
         BCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=yfmQyCpPKoozqzWfXY5DtmVT4vjPpKAbwFoVy0wbyyY=;
        b=wlcu0mBmHd7OLTq6/QjJMC08UsGVS5hrWwv9AT7zqVDPWyIisuc6Alnobk3VrfYWxz
         KMolLOhM0nrpQXM6e5xUjskQlSbn4wT0IVGrzTLnK2exnimoOQgoTBX0bNDuoBQMctpG
         b1DheZheeXX9BgnU7Wno5s7aocZSCcGhbc50nRHGG7qwxZKf+Lcti7zshud/srwFgPDI
         snmA5tNQJbMDiwiUdvdqS69qVKuB9rRB7G+v4OTt/eCDmSNrKfGY6eXzu092I4NCUvhH
         uyLUcMYtARmv6Y6cWsd+corqhIhNwqsqI6Zb8XPY2EQhsSh7Dg1i+ke+dRhRlx9sPM79
         nRDw==
X-Gm-Message-State: ACrzQf2ml8DWjlJ4UgNcqr33CIXHQna5KQcrlpxj5JnN70x6DjKgyceN
        IsN5iMW+X18PHzWV/7A8z9l4ZGwp2Ryk
X-Google-Smtp-Source: AMsMyM5rA5SRcjBMelsf8wDZWEADHxT93l2AGD6ACCrsVyFwSGH2llPq6lqi9pl/KA6T+2jXlVBAt37kyyW/
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a62:1e83:0:b0:545:6896:188 with SMTP id
 e125-20020a621e83000000b0054568960188mr5680742pfe.51.1663886464257; Thu, 22
 Sep 2022 15:41:04 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:40:45 -0700
In-Reply-To: <20220922224046.1143204-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922224046.1143204-10-zokeefe@google.com>
Subject: [PATCH mm-unstable v4 09/10] selftests/vm: add file/shmem
 MADV_COLLAPSE selftest for cleared pmd
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

This test tests that MADV_COLLAPSE acting on file/shmem memory for which
(1) the file extent mapping by the memory is already a huge page in the
page cache, and (2) the pmd mapping this memory in the target process is
none.

In practice, (1)+(2) is the state left over after khugepaged has
successfully collapsed file/shmem memory for a target VMA, but the memory
has not yet been refaulted.  So, this test in-effect tests MADV_COLLAPSE
racing with khugepaged to collapse the memory first.

Link: https://lkml.kernel.org/r/20220907144521.3115321-10-zokeefe@google.com
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
 tools/testing/selftests/vm/khugepaged.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index eabbd2710096..64126c8cd561 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -1353,6 +1353,33 @@ static void madvise_collapse_existing_thps(struct collapse_context *c,
 	ops->cleanup_area(p, hpage_pmd_size);
 }
 
+/*
+ * Test race with khugepaged where page tables have been retracted and
+ * pmd cleared.
+ */
+static void madvise_retracted_page_tables(struct collapse_context *c,
+					  struct mem_ops *ops)
+{
+	void *p;
+	int nr_hpages = 1;
+	unsigned long size = nr_hpages * hpage_pmd_size;
+
+	p = ops->setup_area(nr_hpages);
+	ops->fault(p, 0, size);
+
+	/* Let khugepaged collapse and leave pmd cleared */
+	if (wait_for_scan("Collapse and leave PMD cleared", p, nr_hpages,
+			  ops)) {
+		fail("Timeout");
+		return;
+	}
+	success("OK");
+	c->collapse("Install huge PMD from page cache", p, nr_hpages, ops,
+		    true);
+	validate_memory(p, 0, size);
+	ops->cleanup_area(p, size);
+}
+
 static void usage(void)
 {
 	fprintf(stderr, "\nUsage: ./khugepaged <test type> [dir]\n\n");
@@ -1524,5 +1551,8 @@ int main(int argc, const char **argv)
 	TEST(madvise_collapse_existing_thps, madvise_context, file_ops);
 	TEST(madvise_collapse_existing_thps, madvise_context, shmem_ops);
 
+	TEST(madvise_retracted_page_tables, madvise_context, file_ops);
+	TEST(madvise_retracted_page_tables, madvise_context, shmem_ops);
+
 	restore_settings(0);
 }
-- 
2.37.3.998.g577e59143f-goog

