Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA185B0752
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiIGOpq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiIGOpi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:38 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD665560
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:37 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w1-20020a63d741000000b0042c254a4ccdso7638497pgi.15
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=MN/ZlHKT+7W41miOn2/0m2ZA9qELlvXE7LledaUHh44=;
        b=JOIc6Jl/2jszGxnKakpKeyS70LVbbi4bcyql7qNYfzOaushdICpG9od2gtLL7fyvjt
         S7uWIFeB1CQ3VrLmUXVITGdbIJ0yuW/CMx7ZRxjxXzx/DvLkIUbKZ6wqCZ8xoxvtvJAD
         QStEyMMpJAXdcuBWJSvbT7kyTAtZM7odCYGsZSfgMwGx+uLwcqNd++RYRwQHwFDBT9Xv
         8R7JGgBr2EHsr5FwVe7FRzXZXQ3bcPANuiJuiBPwavWkMMDBJYeyep0nyU+/361IWFWm
         GWb7CkhmcgJOwlj/Ms3dMjQml6ONqy5eIB53gRnx56BT26M49f/PW7aKyP1lhkJHvgOB
         YWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=MN/ZlHKT+7W41miOn2/0m2ZA9qELlvXE7LledaUHh44=;
        b=IAHxlOo2Z+Fzl6/uvbOByj8loK2mMoWWmpQTYOL0qLgRZyLIZic8E0ulFzj+/H/+5U
         ofxDn6vFTASUhoVDD1m6f4O1JlIDwkY1oXaUW/0OZCh3oXoVl+8vWzsHv57s9cP6JFHl
         +TcBvXNISvrIl7Cb/OlSNHkTFxu7PuQEsFMOIrhN1gV8/AvpqhFXa9Z2wiVjRVmE9aRG
         cZQYLkL9bd6vqrJnkdlMbKCQ6w6tpedkKlpcn99SWcS4dsOVnmA6pab7YSvDzJReroaw
         ARlTStEaKXKhUpn6+HB2rMwRK0nUVmZZqBEacQFFmgueq/ssDkyiI1K5kWuVjLCv+Vhn
         PBMg==
X-Gm-Message-State: ACgBeo2boKtECjfKlNUFMqZab3iXHF4P4WAcy2FbxCYW4QSJNzaQBM3u
        qZxSISCAPbs6wl+Mf/KhtSmHdSZlz6so
X-Google-Smtp-Source: AA6agR78bGgOXV5fSVnv0NdZOOIOhzqfjAlFgDDjCKJnYnJ6IVzy/LTPPfuU4zmHHtyq3VFWKqY+w+sikor4
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:db0e:b0:177:e590:df8d with SMTP id
 m14-20020a170902db0e00b00177e590df8dmr1689764plx.157.1662561936532; Wed, 07
 Sep 2022 07:45:36 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:12 -0700
In-Reply-To: <20220907144521.3115321-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-2-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 01/10] mm/shmem: add flag to enforce shmem THP
 in hugepage_vma_check()
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
index 7fa74b9749a6..53d170dac332 100644
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
index 99b7341bd0bf..47c42c566fd1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -461,20 +461,20 @@ static bool shmem_confirm_swap(struct address_space *mapping,
 
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
@@ -669,8 +669,8 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
-bool shmem_is_huge(struct vm_area_struct *vma,
-		   struct inode *inode, pgoff_t index)
+bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
+		   pgoff_t index, bool shmem_huge_force)
 {
 	return false;
 }
@@ -1056,7 +1056,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 			STATX_ATTR_NODUMP);
 	generic_fillattr(&init_user_ns, inode, stat);
 
-	if (shmem_is_huge(NULL, inode, 0))
+	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	if (request_mask & STATX_BTIME) {
@@ -1888,7 +1888,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		return 0;
 	}
 
-	if (!shmem_is_huge(vma, inode, index))
+	if (!shmem_is_huge(vma, inode, index, false))
 		goto alloc_nohuge;
 
 	huge_gfp = vma_thp_gfp_mask(vma);
-- 
2.37.2.789.g6183377224-goog

