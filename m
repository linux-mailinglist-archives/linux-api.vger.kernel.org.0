Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51811ED91E
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2019 07:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfKDGmn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 Nov 2019 01:42:43 -0500
Received: from m15-113.126.com ([220.181.15.113]:47015 "EHLO m15-113.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfKDGmn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 4 Nov 2019 01:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pMijh
        oDJEtCaQ3Zjfe5qkteiGQANRfLuSATLAh2HPy0=; b=dMc2POIrXVOGRbIEZrMGo
        5nITS9iV08OwVlRkUa31UeFyk3Q9o032rkgDxk6jdkqoY1LlmpkOKPQn2fBpvham
        TQdQc82tUr0UntGlbwdsJ8BOPmyvFsezs1pwVOYPi02P5qsaofSG/s+zCgDR0GUf
        +qR/zDQLgzQxowOqT8joAM=
Received: from N-20L6PF1KTYA2.nsn-intra.net (unknown [112.17.245.45])
        by smtp3 (Coremail) with SMTP id DcmowADXJzcoyL9dgpfhDQ--.41074S2;
        Mon, 04 Nov 2019 14:41:47 +0800 (CST)
From:   Li Xinhai <lixinhai_lxh@126.com>
To:     linux-mm@kvack.org
Cc:     Li Xinhai <lixinhai.lxh@gmail.com>, akpm@linux-foundation.org,
        n-horiguchi@ah.jp.nec.com, mhocko@suse.com, vbabka@suse.cz,
        hughd@google.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, Li Xinhai <lixinhai.li@gmail.com>
Subject: [PATCH v3] mm: Fix checking unmapped holes for mbind
Date:   Mon,  4 Nov 2019 14:40:52 +0800
Message-Id: <20191104064052.3444-1-lixinhai_lxh@126.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADXJzcoyL9dgpfhDQ--.41074S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFWUXF4Dtw1rZr1fXr18Xwb_yoWrZF1fpF
        WfKw1Yva17K3ySq3sakFyqkry5trn2g3y0yF4xtwn5Zr15trWYq34xKrWYqFWYyrykZF4a
        yFsI9w4Duw4UZFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjwZcUUUUU=
X-Originating-IP: [112.17.245.45]
X-CM-SenderInfo: pol0x0pkdlszl0k6ij2wof0z/1tbiYAxj1VpD9+M3UgAAsy
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Li Xinhai <lixinhai.lxh@gmail.com>

mbind() is required to report EFAULT if range, specified by addr and len,
contains unmapped holes. In current implementation, below rules are applied
for this checking:
1 Unmapped holes at any part of the specified range should be reported as
  EFAULT if mbind() for none MPOL_DEFAULT cases;
2 Unmapped holes at any part of the specified range should be ignored (do
  not reprot EFAULT) if mbind() for MPOL_DEFAULT case;
3 The whole range in an unmapped hole should be reported as EFAULT;
Note that rule 2 does not fullfill the mbind() API definition, but since
that behavior has existed for long days (refer the usage of internal flag
MPOL_MF_DISCONTIG_OK), this patch does not plan to change it.

Cases do not follow those rules and been fixed by this patch are:
case_1: unmapped hole at tail side of the sepcified range when mbind() for
        non MPOL_DEFAULT cases, EFAULT is not reported (conflicts rule 1).
        [  hole  ][  vma  ][  hole  ]
                       [  range  ]
case_2: unmapped hole at head side of the specified range when mbind() for
        MPOL_DEFAULT case, EFAULT is reported (conflicts rule 2).
        [  hole  ][  vma  ][  hole  ]
             [  range  ]

Fixes: 9d8cebd4bcd7 ("mm: fix mbind vma merge problem")
Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
Fixes: 48684a65b4e3 ("mm: pagewalk: fix misbehavior of walk_page_range for vma(VM_PFNMAP)")
Signed-off-by: Li Xinhai <lixinhai.li@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Naoya Horiguchi<n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-man <linux-man@vger.kernel.org>
---
Changes v2->v3:
  - Add more details in change log;
  - Check holes in .test_walk() and after call walk_page_range()


 mm/mempolicy.c | 52 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967b..b2e10bf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -410,7 +410,9 @@ struct queue_pages {
 	struct list_head *pagelist;
 	unsigned long flags;
 	nodemask_t *nmask;
-	struct vm_area_struct *prev;
+	unsigned long start;
+	struct vm_area_struct *first;
+	struct vm_area_struct *last;
 };
 
 /*
@@ -618,6 +620,21 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 	unsigned long endvma = vma->vm_end;
 	unsigned long flags = qp->flags;
 
+	/* range check first */
+	VM_BUG_ON((vma->vm_start > start) || (vma->vm_end < end));
+
+	if (!qp->first) {
+		qp->first = vma;
+		if (!(flags & MPOL_MF_DISCONTIG_OK) &&
+			(qp->start < vma->vm_start))
+			/* hole at head side of range */
+			return -EFAULT;
+	} else if (!(flags & MPOL_MF_DISCONTIG_OK) &&
+		(vma->vm_prev->vm_end < vma->vm_start))
+		/* hole at middle of range */
+		return -EFAULT;
+	qp->last = vma;
+
 	/*
 	 * Need check MPOL_MF_STRICT to return -EIO if possible
 	 * regardless of vma_migratable
@@ -628,17 +645,6 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 
 	if (endvma > end)
 		endvma = end;
-	if (vma->vm_start > start)
-		start = vma->vm_start;
-
-	if (!(flags & MPOL_MF_DISCONTIG_OK)) {
-		if (!vma->vm_next && vma->vm_end < end)
-			return -EFAULT;
-		if (qp->prev && qp->prev->vm_end < vma->vm_start)
-			return -EFAULT;
-	}
-
-	qp->prev = vma;
 
 	if (flags & MPOL_MF_LAZY) {
 		/* Similar to task_numa_work, skip inaccessible VMAs */
@@ -679,14 +685,29 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 		nodemask_t *nodes, unsigned long flags,
 		struct list_head *pagelist)
 {
+	int err;
 	struct queue_pages qp = {
 		.pagelist = pagelist,
 		.flags = flags,
 		.nmask = nodes,
-		.prev = NULL,
+		.start = start,
+		.first = NULL,
+		.last = NULL,
 	};
 
-	return walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
+	err = walk_page_range(mm, start, end, &queue_pages_walk_ops, &qp);
+
+	if (err != -EFAULT) {
+		if (!qp.first)
+			/* whole range in hole */
+			err = -EFAULT;
+		else if (!(flags & MPOL_MF_DISCONTIG_OK) &&
+			(qp.last->vm_end < end))
+			/* hole at tail side of range */
+			err = -EFAULT;
+	}
+
+	return err;
 }
 
 /*
@@ -738,8 +759,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 	unsigned long vmend;
 
 	vma = find_vma(mm, start);
-	if (!vma || vma->vm_start > start)
-		return -EFAULT;
+	VM_BUG_ON(!vma);
 
 	prev = vma->vm_prev;
 	if (start > vma->vm_start)
-- 
1.8.3.1

