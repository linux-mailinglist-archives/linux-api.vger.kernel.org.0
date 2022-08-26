Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADDD5A31A9
	for <lists+linux-api@lfdr.de>; Sat, 27 Aug 2022 00:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbiHZWDo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Aug 2022 18:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243653AbiHZWDk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Aug 2022 18:03:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60004DAA07
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:36 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z22-20020a630a56000000b0041b98176de9so1408160pgk.15
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=ZfMjBnU9jBash3JYHUYPEIOkw8Dh5mtl2yjBQXbzd8w=;
        b=lRCYS8VfUdwm2C4R1gez0VWa0kSo8O/qaTBR2zSmsfSTaXvVHg4DnAyzgeb2xZvEv3
         xtWNe8PvzvdfQhF4mGp4bS2PzSXXw0ym1JNep/Xmoz2IV74exGjjNlE2YoLQNf85P5ZG
         ueqLdHFEpaN7QOjnctgb3/iF2Yemk5blhIU30bbA2S3hjYdslgKKo0PHEWp7GjB9qRlq
         PjZ0pd9xdfAC/TfooBjTcJYH5wfe6TTDgGR1bJz5zdvq/fMcmQDlV4pzBMXxAh3bON4t
         vXCa06t5QWRkVgMiWBSedGfN4tlY/kjX2qEVvvZoNjO56bi+mIGU6Xe5w8D2UxFs8OnG
         Jdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=ZfMjBnU9jBash3JYHUYPEIOkw8Dh5mtl2yjBQXbzd8w=;
        b=3p+ytb201OvlgUwk9saLJPatWk/eB7PwDEt15StRWNSL8Rkxh6xpqmX04R0QtZu40H
         UyQa6khDDEltXHa4+kqpvQHsBImHkWk2pF6ENj+M1IwKY3XICSA/YhmYtkdE3r9U4vFH
         rDrymS7eG60Ugt4vMPbLPzSU3jxCMqCkoeb1KpOl73jRsTSjHR4lZs0VH6yVIVF+2JMG
         tA3rLtTtT0BMcvoaWnIwARjlB/nCCQsVa1aKoDhSCm+I9FHFoD4egKRihrvjYNOFIPRQ
         NCwHMjDVajySLfvG0wzyNvq3VbwIGd42RKf4ESmDXR2BrJE2asyaDKe1ThgCoXw9UpcU
         WEQg==
X-Gm-Message-State: ACgBeo0ZgibZ2xO/asEk6340IKe4P8umHvLn0XkFztgbe9lTiTa0FE7c
        ubwXsgi2bQHUHbQBsX3LWqVyOpgafTcP
X-Google-Smtp-Source: AA6agR4kvG2FLnY/ao//0NEq9QlaJoZJpTEl6AOSVFU/LTgmCWARNCcwmtvWZCAGEYYadyxUyGcBnV7sXIE3
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:2a04:b0:536:9d21:c177 with SMTP
 id ce4-20020a056a002a0400b005369d21c177mr5918144pfb.4.1661551415711; Fri, 26
 Aug 2022 15:03:35 -0700 (PDT)
Date:   Fri, 26 Aug 2022 15:03:20 -0700
In-Reply-To: <20220826220329.1495407-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826220329.1495407-2-zokeefe@google.com>
Subject: [PATCH mm-unstable v2 1/9] mm/shmem: add flag to enforce shmem THP in hugepage_vma_check()
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

Extend 'mm/thp: add flag to enforce sysfs THP in
hugepage_vma_check()' to shmem, allowing callers to ignore
/sys/kernel/transparent_hugepage/shmem_enabled and tmpfs huge= mount.

This is intended to be used by MADV_COLLAPSE, and the rationale is
analogous to the anon/file case: MADV_COLLAPSE is not coupled to
directives that advise the kernel's decisions on when THPs should be
considered eligible. shmem/tmpfs always claims large folio support,
regardless of sysfs or mount options.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 include/linux/shmem_fs.h | 10 ++++++----
 mm/huge_memory.c         |  2 +-
 mm/shmem.c               | 18 +++++++++---------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index ff0b990de83d..f5e9b01dbf4c 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -92,11 +92,13 @@ extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
-extern bool shmem_is_huge(struct vm_area_struct *vma,
-			  struct inode *inode, pgoff_t index);
-static inline bool shmem_huge_enabled(struct vm_area_struct *vma)
+extern bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
+			  pgoff_t index, bool shmem_huge_force);
+static inline bool shmem_huge_enabled(struct vm_area_struct *vma,
+				      bool shmem_huge_force)
 {
-	return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff);
+	return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff,
+			     shmem_huge_force);
 }
 extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
 extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 88d98241a635..b3acc8e3046d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -119,7 +119,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 * own flags.
 	 */
 	if (!in_pf && shmem_file(vma->vm_file))
-		return shmem_huge_enabled(vma);
+		return shmem_huge_enabled(vma, !enforce_sysfs);
 
 	/* Enforce sysfs THP requirements as necessary */
 	if (enforce_sysfs &&
diff --git a/mm/shmem.c b/mm/shmem.c
index 42e5888bf84d..b9bab1abf142 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -472,20 +472,20 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
 static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
 
-bool shmem_is_huge(struct vm_area_struct *vma,
-		   struct inode *inode, pgoff_t index)
+bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
+		   pgoff_t index, bool shmem_huge_force)
 {
 	loff_t i_size;
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (shmem_huge == SHMEM_HUGE_DENY)
-		return false;
 	if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
 	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
 		return false;
-	if (shmem_huge == SHMEM_HUGE_FORCE)
+	if (shmem_huge == SHMEM_HUGE_FORCE || shmem_huge_force)
 		return true;
+	if (shmem_huge == SHMEM_HUGE_DENY)
+		return false;
 
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
@@ -680,8 +680,8 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
-bool shmem_is_huge(struct vm_area_struct *vma,
-		   struct inode *inode, pgoff_t index)
+bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
+		   pgoff_t index, bool shmem_huge_force)
 {
 	return false;
 }
@@ -1069,7 +1069,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(&init_user_ns, inode, stat);
 
-	if (shmem_is_huge(NULL, inode, 0))
+	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1910,7 +1910,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	if (!shmem_is_huge(vma, inode, index))
+	if (!shmem_is_huge(vma, inode, index, false))
 		goto alloc_nohuge;
 
 	huge_gfp = vma_thp_gfp_mask(vma);
-- 
2.37.2.672.g94769d06f0-goog

