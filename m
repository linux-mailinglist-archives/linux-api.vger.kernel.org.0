Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31195E6FD2
	for <lists+linux-api@lfdr.de>; Fri, 23 Sep 2022 00:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIVWlA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Sep 2022 18:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiIVWkv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Sep 2022 18:40:51 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2711F9600
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:40:50 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id cg5-20020a056a00290500b0053511889856so6093307pfb.18
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=puqRnKrvqny8lZD9l+R4ob28H2OLAsGqa9r7Be9elB8=;
        b=Ug3xHbvJiPRbeH5/g7NxHX1Ur65ZzMM13E45ZG6fdmj3/8Xr7SkDVcp+4InbNMfq23
         6FKA1hdhTn8aBKhC5gmv/T/+jaMgSgC69WAyWTG5+VMvcLrq9vaj9jDFsNDSXq/7F3Kg
         onMgCGFUjVKf83LrP8GEWyUSLGaVO2h6RQQqMTvcgUS8Iu/vYaFUoh6gYjDsMDeTNNZ4
         EMA7FTLwt05Dhx/r+I99rDnYr/rv8HHjPqW8KGROSd9O1KUhStlBbam+omwJJ3dOR6XF
         +cRf1/5tuW1ecaG1GExyP7svjNkE/4wllJtbKKNbbVtyeJ4bNKB5grOhEbKvrgjqyVxm
         qP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=puqRnKrvqny8lZD9l+R4ob28H2OLAsGqa9r7Be9elB8=;
        b=eO3UFrRv2Mik+Fp1KHsaZLGkU40GYJHLkQNwXXFLBEIEn1tf2tWV7/8MzsBNbAbUYP
         WfIZ1hcYw5ZhenSA1OTXxy4D79fvokOFMkXKjC6mp2gWN5CojWAFEd3yqkdiGnyF1p4Q
         9wjidVvWUt0LynVKbc+k+Zir5e6N8dMGMnYJMcYOpF7itlgfR/mKJH7i5kroUfz8ACz4
         eVYSl4Y/2VdYAqi/+J3w/KZ7ntopM7ws/Avf58h9GdIxKnoDZmtpaMPS64xg9qvCGVIT
         XL6cWpgJhguN+8SQDngTXKH+ziMK+onl8wA87YM+vA4fqZ1SKNzUyKqSvbYLovh+Bcgn
         aXiw==
X-Gm-Message-State: ACrzQf1+8SHvKHediIFbTeJf73iiah/ADftpUoBdvCDQBHBMaYLjc49F
        zE9xLRI4MxId0CHQlKABgUWBDfTZ6QNB
X-Google-Smtp-Source: AMsMyM6XJd66bYtUXfIU+MAlCiD+0FD+J03+WZRCwrKo791W5IgmAyRWIMLXSySop/rZiyMsOAs6YvVUgwIk
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:e88b:b0:176:c37f:511c with SMTP id
 w11-20020a170902e88b00b00176c37f511cmr5628990plg.2.1663886450312; Thu, 22 Sep
 2022 15:40:50 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:40:37 -0700
In-Reply-To: <20220922224046.1143204-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922224046.1143204-2-zokeefe@google.com>
Subject: [PATCH mm-unstable v4 01/10] mm/shmem: add flag to enforce shmem THP
 in hugepage_vma_check()
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

Extend 'mm/thp: add flag to enforce sysfs THP in hugepage_vma_check()' to
shmem, allowing callers to ignore
/sys/kernel/transparent_hugepage/shmem_enabled and tmpfs huge= mount.

This is intended to be used by MADV_COLLAPSE, and the rationale is
analogous to the anon/file case: MADV_COLLAPSE is not coupled to
directives that advise the kernel's decisions on when THPs should be
considered eligible.  shmem/tmpfs always claims large folio support,
regardless of sysfs or mount options.

[shy828301@gmail.com: test shmem_huge_force explicitly]
  Link: https://lore.kernel.org/linux-mm/CAHbLzko3A5-TpS0BgBeKkx5cuOkWgLvWXQH=TdgW-baO4rPtdg@mail.gmail.com/
Link: https://lkml.kernel.org/r/20220907144521.3115321-2-zokeefe@google.com
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
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
---
 include/linux/shmem_fs.h | 10 ++++++----
 mm/huge_memory.c         |  2 +-
 mm/shmem.c               | 18 ++++++++++--------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index f24071e3c826..d500ea967dc7 100644
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
index 4938defe4e73..1cc4a5f4791e 100644
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
index 305dbca9ceef..fd15b7ca1d7e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -462,20 +462,22 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
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
+	if (shmem_huge_force)
+		return true;
 	if (shmem_huge == SHMEM_HUGE_FORCE)
 		return true;
+	if (shmem_huge == SHMEM_HUGE_DENY)
+		return false;
 
 	switch (SHMEM_SB(inode->i_sb)->huge) {
 	case SHMEM_HUGE_ALWAYS:
@@ -670,8 +672,8 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
-bool shmem_is_huge(struct vm_area_struct *vma,
-		   struct inode *inode, pgoff_t index)
+bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
+		   pgoff_t index, bool shmem_huge_force)
 {
 	return false;
 }
@@ -1058,7 +1060,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(&init_user_ns, inode, stat);
 
-	if (shmem_is_huge(NULL, inode, 0))
+	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1900,7 +1902,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	if (!shmem_is_huge(vma, inode, index))
+	if (!shmem_is_huge(vma, inode, index, false))
 		goto alloc_nohuge;
 
 	huge_gfp = vma_thp_gfp_mask(vma);
-- 
2.37.3.998.g577e59143f-goog

