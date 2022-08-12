Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCB65909D8
	for <lists+linux-api@lfdr.de>; Fri, 12 Aug 2022 03:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiHLB3T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Aug 2022 21:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235753AbiHLB3S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Aug 2022 21:29:18 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2EF9BB5E
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:17 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k13-20020a170902c40d00b0016f90eba744so11796329plk.22
        for <linux-api@vger.kernel.org>; Thu, 11 Aug 2022 18:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=jDF7dMpuWYOG8UKbkC4L3SFnWIZkMKf/Zh805z9oCHM=;
        b=Y3m0BXocyTl5mEsD5PBF9KTfAs6zkewRsQcGgZ9G1OOwLy3gLvfQj9VfsVAc7wz72e
         ydOzFFic3cRGCVb1iGqZCMtbFmGqWET3LA9QWNfvpkz2iZrmwOWMHpunueEynkmKSlGu
         THaXRbc7XRPI64byuEAB89HA2pP8zcnh56dOLpZyhbmWnbu2itvGkmIZe7ZM9iFtX2d5
         3IF2Ct6/oDXtVyrOx5t3TSiaLtA1kRiXuBbXqlkcaXHuwz1kVH3VIBAckiy8ThYiNrDX
         cyo6S9p1Mg3po6Fi71ZWkJe2XO+Wq+xlcXXHFoOlOwZTSgElfL4HQumahkElurSL8ot2
         BiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=jDF7dMpuWYOG8UKbkC4L3SFnWIZkMKf/Zh805z9oCHM=;
        b=rGs+W88o3wvIRVpKPQaurERVAGCGArhq0GztKi/k2SXmQlaW/o1P2eV2jHDu7thtRg
         Zn7MpNuoXjhxGIraRSKJ5ZVoecBXLF7n7gSk6t2U1vLZ77fVsiw9OyxAECfEi+AZUbe5
         NMCGZSHp+M6RdRh3K0qt1BtbYHRnCTal2pjZd/hzxLgZ329sGu97sSq+283s6ImM2yfv
         qYF90O/DkUn22zgDWYPeZINUFsmBvzwP3W1eG8mPjzHwzDKNm/hMS3JF3cHUYkGnUGtw
         kUphdIOZdts1ZPJN2vyHgd+yg58QDj4iOTgeM9Eu8DJoC3kawgCfoHPiraPaCdYEjKyE
         bveQ==
X-Gm-Message-State: ACgBeo1zlp3MpMGwaoRxZyKJD74VOARrFngea592Dk9ikBuTOebGhh4W
        FoGnOCTlbaUiIyEnPi6CRgRuYdy58cLf
X-Google-Smtp-Source: AA6agR7Ae2xcZcviGvVh4A3ONRePNnbNXtCAzLeHWqQ7v/7hQD/l9nlG+rPbSV20jYVNytWNAursmG1w3FFl
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:8f8a:b0:16f:975e:7c6e with SMTP id
 z10-20020a1709028f8a00b0016f975e7c6emr1873309plo.136.1660267757160; Thu, 11
 Aug 2022 18:29:17 -0700 (PDT)
Date:   Thu, 11 Aug 2022 18:28:38 -0700
In-Reply-To: <20220812012843.3948330-1-zokeefe@google.com>
Message-Id: <20220812012843.3948330-5-zokeefe@google.com>
Mime-Version: 1.0
References: <20220812012843.3948330-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH mm-unstable 4/9] mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
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

Add huge_memory:trace_mm_khugepaged_scan_file tracepoint to
hpage_collapse_scan_file() analogously to hpage_collapse_scan_pmd().
While this change is targeted at debugging MADV_COLLAPSE pathway, the
"mm_khugepaged" prefix is retained for symmetry with
huge_memory:trace_mm_khugepaged_scan_pmd, which retains it's legacy name
to prevent changing kernel ABI as much as possible.

Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 include/trace/events/huge_memory.h | 34 ++++++++++++++++++++++++++++++
 mm/khugepaged.c                    |  3 ++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index a8db658e99e9..1d2dd88dc3c4 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -169,5 +169,39 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
 		__entry->ret)
 );
 
+TRACE_EVENT(mm_khugepaged_scan_file,
+
+	TP_PROTO(struct mm_struct *mm, struct page *page, const char *filename,
+		 int present, int swap, int result),
+
+	TP_ARGS(mm, page, filename, present, swap, result),
+
+	TP_STRUCT__entry(
+		__field(struct mm_struct *, mm)
+		__field(unsigned long, pfn)
+		__string(filename, filename)
+		__field(int, present)
+		__field(int, swap)
+		__field(int, result)
+	),
+
+	TP_fast_assign(
+		__entry->mm = mm;
+		__entry->pfn = page ? page_to_pfn(page) : -1;
+		__assign_str(filename, filename);
+		__entry->present = present;
+		__entry->swap = swap;
+		__entry->result = result;
+	),
+
+	TP_printk("mm=%p, scan_pfn=0x%lx, filename=%s, present=%d, swap=%d, result=%s",
+		__entry->mm,
+		__entry->pfn,
+		__get_str(filename),
+		__entry->present,
+		__entry->swap,
+		__print_symbolic(__entry->result, SCAN_STATUS))
+);
+
 #endif /* __HUGE_MEMORY_H */
 #include <trace/define_trace.h>
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f89c60ef8382..5710c4f4925f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2173,7 +2173,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	/* TODO: tracepoints */
+	trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
+				      present, swap, result);
 	return result;
 }
 #else
-- 
2.37.1.559.g78731f0fdb-goog

