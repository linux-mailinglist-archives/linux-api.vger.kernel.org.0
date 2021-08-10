Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472AC3E8415
	for <lists+linux-api@lfdr.de>; Tue, 10 Aug 2021 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhHJUHU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Aug 2021 16:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhHJUHT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 10 Aug 2021 16:07:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F218C60EC0;
        Tue, 10 Aug 2021 20:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628626017;
        bh=dYMLAdLlwEAxyd8jTPoXpFKuKuNTSFdWKtkdKgFw5QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9r9SHnOKzunQebZoc7NfQP7ef7ow0SY52KTIUc8l4bbpzZGOraE3n1hWGaZ8/Y6H
         mQTrN497q3UdoD1kBQ2Uo5MdV0BlzddoXIrqMN4L+SHu4Jbi7BH2iPeRKp7x1ilu99
         aZIZ+XWpJgF9r5rHgVHoCRgUl4yWvj3XzrzSed2TJvafiM1R9Jn9QcQmClbczA/vza
         fInweENoSIUa73c7iyJ5Sr1dtScKMwNjL+cnfqQoD2455YYp6FqFMM3i/tAekdjjDp
         6YJoAJ/KVgnZOwFgMQPk/CjT8ppRHF+cTHtinxE4RqC51N8PHcPXG94FnYKT8yrTIf
         x1NrhU2OuBpYw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     feng.tang@intel.com
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        ben.widawsky@intel.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mhocko@suse.com,
        mike.kravetz@oracle.com, rdunlap@infradead.org,
        rientjes@google.com, vbabka@suse.cz, ying.huang@intel.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] mm/hugetlb: Initialize page to NULL in alloc_buddy_huge_page_with_mpol()
Date:   Tue, 10 Aug 2021 13:06:32 -0700
Message-Id: <20210810200632.3812797-1-nathan@kernel.org>
X-Mailer: git-send-email 2.33.0.rc1
In-Reply-To: <20210809024430.GA46432@shbuild999.sh.intel.com>
References: <20210809024430.GA46432@shbuild999.sh.intel.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Clang warns:

mm/hugetlb.c:2162:6: warning: variable 'page' is used uninitialized
whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (mpol_is_preferred_many(mpol)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/hugetlb.c:2172:7: note: uninitialized use occurs here
        if (!page)
             ^~~~
mm/hugetlb.c:2162:2: note: remove the 'if' if its condition is always
true
        if (mpol_is_preferred_many(mpol)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
mm/hugetlb.c:2155:19: note: initialize the variable 'page' to silence
this warning
        struct page *page;
                         ^
                          = NULL
1 warning generated.

Initialize page to NULL like in dequeue_huge_page_vma() so that page is
not used uninitialized.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3d9cd2722ea5..604e2d6bd506 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2152,7 +2152,7 @@ static
 struct page *alloc_buddy_huge_page_with_mpol(struct hstate *h,
 		struct vm_area_struct *vma, unsigned long addr)
 {
-	struct page *page;
+	struct page *page = NULL;
 	struct mempolicy *mpol;
 	gfp_t gfp_mask = htlb_alloc_mask(h);
 	int nid;

base-commit: 18f73b217b4633e27a61832e1485ce927a8ee5c1
-- 
2.33.0.rc1

