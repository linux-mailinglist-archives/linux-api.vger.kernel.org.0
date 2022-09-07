Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A85B075A
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiIGOqF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIGOpv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4546576442
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:50 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x1-20020a17090a8a8100b00200a805fba9so2766965pjn.7
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=FYqAi1jHmyScE1mrG987cKg/EAGckhoLmmPDIX84Tvw=;
        b=DaAmyh6J56QkID3ea0yNKMqm9UCjZjckDxCnuGGRGTbo2ez2y3CyVe3yjah/8l+4sO
         Hzf36SL9iuP8kzrIDGUqAW5BCgzCq6tzzkM1daitHfejYwGhTgJlwVFRVI0ZWrrok9Sl
         eRWox1smiYvmfOEmLMonbh8ZkBubAAnQSqvYZPxkhbjdQ3Qj+9a8P99Bm06HquQiNu/N
         FhfIJUW/s8KMP8+DhdkqZWdLWaYcAMkUPQ+S1SCZUnPadaZ9biaR8ffIrTFiXV6CdOtT
         ufq5kR2vIaarLmy/lDyLZcN6/tx5hYP1sAHd/whzUDvAOo4rg35mgDGo5h/Ufia5BMvH
         tBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=FYqAi1jHmyScE1mrG987cKg/EAGckhoLmmPDIX84Tvw=;
        b=h5vdxZ6E9HfooS8E0IiHp55RAlz8mjvc0BZ4A4YRb8tqortSzyasLV/+Ee5kqaZ2/H
         IEQ+JiSKMmPyghgoOe4T8ExByp8N5ZJrofNA2KN2DtLQqw6NzUsODMyPY32wV8l1rA7h
         9XQRT2VhufqC34KQ9hI/Or4cHLnmAKCJmyLv4TyIXRh68aUe1EaTuaUshhZle9zJAuii
         vRGgwU3ByONxWjHK0XFneeFUY2cWJ1VDTVFzpvdL3eh872wiGxBlQkIOO6VlRjwt8UGx
         aqh2AT/28JBHdTO2XMsXu4zMKrPR9KqBT8cMR7Sts2h8UYjEXLLapKhgNGNguWu0/04I
         UVeA==
X-Gm-Message-State: ACgBeo0SkOsaZTXUBZceZvkO7ke0mIoMFX4ZwIg8wd/t5AridVB6Knqw
        or0izoVKqT37DCGadN0tW+LQixygEI9Y
X-Google-Smtp-Source: AA6agR61hEeBoQYkr4zmmupDwv2ODnLucmnXBc4bU4uKv7AW1wZoMt6tPqtytqdXlNiubeKYpDBBgPOX2W/B
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a62:cec5:0:b0:53e:2101:c7b1 with SMTP id
 y188-20020a62cec5000000b0053e2101c7b1mr4267225pfg.40.1662561949867; Wed, 07
 Sep 2022 07:45:49 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:20 -0700
In-Reply-To: <20220907144521.3115321-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-10-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 09/10] selftests/vm: add file/shmem
 MADV_COLLAPSE selftest for cleared pmd
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

This test tests that MADV_COLLAPSE acting on file/shmem memory for which
(1) the file extent mapping by the memory is already a huge page in the
page cache, and (2) the pmd mapping this memory in the target process
is none.

In practice, (1)+(2) is the state left over after khugepaged has
successfully collapsed file/shmem memory for a target VMA, but the
memory has not yet been refaulted. So, this test in-effect tests
MADV_COLLAPSE racing with khugepaged to collapse the memory first.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 tools/testing/selftests/vm/khugepaged.c | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/vm/khugepaged.c b/tools/testing/selftests/vm/khugepaged.c
index 05d9945daa48..730507e38c58 100644
--- a/tools/testing/selftests/vm/khugepaged.c
+++ b/tools/testing/selftests/vm/khugepaged.c
@@ -1323,6 +1323,33 @@ static void madvise_collapse_existing_thps(struct collapse_context *c,
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
@@ -1494,5 +1521,8 @@ int main(int argc, const char **argv)
 	TEST(madvise_collapse_existing_thps, madvise_context, file_ops);
 	TEST(madvise_collapse_existing_thps, madvise_context, shmem_ops);
 
+	TEST(madvise_retracted_page_tables, madvise_context, file_ops);
+	TEST(madvise_retracted_page_tables, madvise_context, shmem_ops);
+
 	restore_settings(0);
 }
-- 
2.37.2.789.g6183377224-goog

