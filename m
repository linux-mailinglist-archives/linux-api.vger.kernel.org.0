Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E850964F1ED
	for <lists+linux-api@lfdr.de>; Fri, 16 Dec 2022 20:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiLPTpx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Dec 2022 14:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiLPTps (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Dec 2022 14:45:48 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1DB8FCC
        for <linux-api@vger.kernel.org>; Fri, 16 Dec 2022 11:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1671219945;
        bh=C3x0LxEaOZxc8RC+32bOB5QAmF9xMZLVglOZu0jV2nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T4TW14IBwDykxKAdOJEumQDzYo81Fj7dUn/WD8Lb8OJcFIsOrRessQxWLDlr0n76e
         4hUv8PS4ZUKS3k5+7NrLSV8sBMSdsaoBMwrxGl2KPgn2Rjf714stlIsd8Glw49SsRr
         Y5jlZPBIE+030hCcSRO50IAk8RYgBTB20BU1bWCIE20rjPaoyA8c4lPceOJD+R6Ngj
         UiC54cy7oC8KhtYbCzPfNvN5vcnVeODmQ/S/uELtnDclvN4DM+T6fOkBodobyrV4IA
         0RrXJ2FGJhyWn+XRPLHkIgcIb5peu/0SxC/SH5d65MbxBuMFKBgSCTlEohCmvWSi7B
         7Xx3ML+O0xqdg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4NYfj51zpjzbGl;
        Fri, 16 Dec 2022 14:45:45 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Huang Ying <ying.huang@intel.com>, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] mm/mempolicy: do not duplicate policy if it is not applicable for set_mempolicy_home_node
Date:   Fri, 16 Dec 2022 14:45:37 -0500
Message-Id: <20221216194537.238047-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216194537.238047-1-mathieu.desnoyers@efficios.com>
References: <20221216194537.238047-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

set_mempolicy_home_node tries to duplicate a memory policy before
checking it whether it is applicable for the operation. There is
no real reason for doing that and it might actually be a pointless
memory allocation and deallocation exercise for MPOL_INTERLEAVE.

Not a big problem but we can do better. Simply check the policy before
acting on it.

[ Mathieu: compile-tested only. Tested-by would be welcome. ]

Signed-off-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: linux-api@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 mm/mempolicy.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 02c8a712282f..becf41e10076 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1489,7 +1489,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct mempolicy *new;
+	struct mempolicy *new, *old;
 	unsigned long vmstart;
 	unsigned long vmend;
 	unsigned long end;
@@ -1521,31 +1521,27 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 		return 0;
 	mmap_write_lock(mm);
 	for_each_vma_range(vmi, vma, end) {
-		vmstart = max(start, vma->vm_start);
-		vmend   = min(end, vma->vm_end);
-		new = mpol_dup(vma_policy(vma));
-		if (IS_ERR(new)) {
-			err = PTR_ERR(new);
-			break;
-		}
-		/*
-		 * Only update home node if there is an existing vma policy
-		 */
-		if (!new)
-			continue;
-
 		/*
 		 * If any vma in the range got policy other than MPOL_BIND
 		 * or MPOL_PREFERRED_MANY we return error. We don't reset
 		 * the home node for vmas we already updated before.
 		 */
-		if (new->mode != MPOL_BIND && new->mode != MPOL_PREFERRED_MANY) {
-			mpol_put(new);
+		old = vma_policy(vma);
+		if (!old)
+			continue;
+		if (old->mode != MPOL_BIND && old->mode != MPOL_PREFERRED_MANY) {
 			err = -EOPNOTSUPP;
 			break;
 		}
+		new = mpol_dup(old);
+		if (IS_ERR(new)) {
+			err = PTR_ERR(new);
+			break;
+		}
 
 		new->home_node = home_node;
+		vmstart = max(start, vma->vm_start);
+		vmend   = min(end, vma->vm_end);
 		err = mbind_range(mm, vmstart, vmend, new);
 		mpol_put(new);
 		if (err)
-- 
2.25.1

