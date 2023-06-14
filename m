Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0889E724C3A
	for <lists+linux-api@lfdr.de>; Tue,  6 Jun 2023 21:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbjFFTFP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Jun 2023 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbjFFTEr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Jun 2023 15:04:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08B21717
        for <linux-api@vger.kernel.org>; Tue,  6 Jun 2023 12:04:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bad06cc7fb7so10378623276.3
        for <linux-api@vger.kernel.org>; Tue, 06 Jun 2023 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686078271; x=1688670271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QP9zRN1PPC9/vVggheoZtkj7ew+Av1V49kv617fnYR8=;
        b=FI4N69NL3RScUYfhkbRLrL4c1EfS/desGI2Shr1/96TXRRDn4geHvyU1N7eGgqKJyG
         GWBPzDYB1BfYFhv6zCt0EhdFu5tldM3yzA5NvQB4/zCb+hcK/bM/QuqRiIfDvi5+hI04
         SbvBvKqQxgCQVjt+cTCPYL6N1+wfniCAiJKkEW+sWbUf69X9qSMHub3UvTd9MQDzXMi4
         1B4c0zvORWB8HqA5+0cdcj+spglhu6jaXUuf69LPtiQvLZve3RcWtPEQxixl3Ypwmw86
         K8LGygCgyEMNtUVq9AiwfPbvahkLarTMGurJs3foOYOqn4CdQy93rRAZp4edz17ORY67
         OYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686078271; x=1688670271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP9zRN1PPC9/vVggheoZtkj7ew+Av1V49kv617fnYR8=;
        b=LxGJve8UaCnb3dLc9KrEAPOSURsC4FkzmxZJ3RXj8tMrJ77Ix+G8P4TjyjOQBlr9Fd
         L4k+lbrL8TJNxiKI6mZ6dSdM32lPxc+tpf4lONZAgBV1g0wE7907cTWhQrIogm+UP81z
         O2wZ+oErIpHu+vwFW4tvvMrJ8cj/HrLx6dm0KzBUKTq4tFQ9YxgeDMN2taAp41/QLvqv
         Bb2mtOpllhKCG0xyMXAPX7zpgWSLSczS6g3G4JOZJcTEghgjJJ8bxRaPMlf/VP4VZK1Q
         xpGtFfZRzdCZgQty2MJFUOtiEvS2tRHlHabGfErwrNKGHa2NjOoSVHFB3fKjDFuvmdHZ
         NEkA==
X-Gm-Message-State: AC+VfDzLQf6mlz96xQ9kjMa7+mQjHYwzu1QIBsm/uhMNLu8Sq8kn5C+b
        jC5PW7KvoOzk98MbFJ4s02Tusiux5cKnnuxB2g==
X-Google-Smtp-Source: ACHHUZ76bqpjC35XKXFBahxA9u7+2eFkt14S7ZQHJlZjw7W0ReYy7o2ytYkzhnc/yAz55ZaZBmAlcbBYdbpzzQGaSA==
X-Received: from ackerleytng-ctop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:13f8])
 (user=ackerleytng job=sendgmr) by 2002:a25:105:0:b0:bab:a276:caac with SMTP
 id 5-20020a250105000000b00baba276caacmr1716574ybb.3.1686078271536; Tue, 06
 Jun 2023 12:04:31 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:03:55 +0000
In-Reply-To: <cover.1686077275.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1686077275.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <382ee70df7b65c365a1eab1223f84aecc0c5be10.1686077275.git.ackerleytng@google.com>
Subject: [RFC PATCH 10/19] mm: hugetlb: Parametrize alloc_hugetlb_folio_from_subpool()
 by resv_map
From:   Ackerley Tng <ackerleytng@google.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, pbonzini@redhat.com, seanjc@google.com,
        shuah@kernel.org, willy@infradead.org
Cc:     brauner@kernel.org, chao.p.peng@linux.intel.com,
        coltonlewis@google.com, david@redhat.com, dhildenb@redhat.com,
        dmatlack@google.com, erdemaktas@google.com, hughd@google.com,
        isaku.yamahata@gmail.com, jarkko@kernel.org, jmattson@google.com,
        joro@8bytes.org, jthoughton@google.com, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, liam.merwick@oracle.com,
        mail@maciej.szmigiero.name, mhocko@suse.com, michael.roth@amd.com,
        qperret@google.com, rientjes@google.com, rppt@kernel.org,
        steven.price@arm.com, tabba@google.com, vannapurve@google.com,
        vbabka@suse.cz, vipinsh@google.com, vkuznets@redhat.com,
        wei.w.wang@intel.com, yu.c.zhang@linux.intel.com,
        kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, x86@kernel.org,
        Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Parametrize alloc_hugetlb_folio_from_subpool() by resv_map to remove
the use of vma_resv_map() and decouple hugetlb with hugetlbfs.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/hugetlb.h | 2 +-
 mm/hugetlb.c            | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 5fe9643826d7..d564802ace4b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -767,7 +767,7 @@ struct huge_bootmem_page {
 
 int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list);
 struct folio *alloc_hugetlb_folio_from_subpool(
-	struct hugepage_subpool *spool, struct hstate *h,
+	struct hugepage_subpool *spool, struct hstate *h, struct resv_map *resv,
 	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve);
 struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 				unsigned long addr, int avoid_reserve);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 540634aec181..aebdd8c63439 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3003,7 +3003,7 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
 }
 
 struct folio *alloc_hugetlb_folio_from_subpool(
-	struct hugepage_subpool *spool, struct hstate *h,
+	struct hugepage_subpool *spool, struct hstate *h, struct resv_map *resv,
 	struct vm_area_struct *vma, unsigned long addr, int avoid_reserve)
 {
 	struct folio *folio;
@@ -3013,7 +3013,6 @@ struct folio *alloc_hugetlb_folio_from_subpool(
 	struct hugetlb_cgroup *h_cg = NULL;
 	bool deferred_reserve;
 
-	struct resv_map *resv = vma_resv_map(vma);
 	pgoff_t resv_index = vma_hugecache_offset(h, vma, addr);
 	bool may_share = vma->vm_flags & VM_MAYSHARE;
 
@@ -3141,8 +3140,9 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 {
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
+	struct resv_map *resv = vma_resv_map(vma);
 
-	return alloc_hugetlb_folio_from_subpool(spool, h, vma, addr, avoid_reserve);
+	return alloc_hugetlb_folio_from_subpool(spool, h, resv, vma, addr, avoid_reserve);
 }
 
 int alloc_bootmem_huge_page(struct hstate *h, int nid)
-- 
2.41.0.rc0.172.g3f132b7071-goog

