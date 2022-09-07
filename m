Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62F15B0755
	for <lists+linux-api@lfdr.de>; Wed,  7 Sep 2022 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiIGOpy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Sep 2022 10:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIGOpn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Sep 2022 10:45:43 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09415B04D
        for <linux-api@vger.kernel.org>; Wed,  7 Sep 2022 07:45:41 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b9-20020a170903228900b001730a0e11e5so9998498plh.19
        for <linux-api@vger.kernel.org>; Wed, 07 Sep 2022 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=IipW9wJLhoaQM8RoLqkPizpPvc0vhUndK21L4oCs0Ys=;
        b=bfSyJF4wDhiW4pzRU/9m+TH6Beqq8Xf2702aof6FOKeCB6TReNQvra17hBIB505R5p
         cDedDK5QoByJHBKRt/xLuFbjrixS/92boQmikZSk+s8aDslt4l6XRaXRdsybhKyHFy5G
         o7+bAI95G5a7nS9qZ3p9HaI/yZRCpA9nVhMl41fKsyCbo8CF2EIgEmuwUINPrz1t1Gur
         6kggTnXfqM8zmmT60T+GBPUG4QdpSSONROXNMnQsoSzH5in3RKefhuy9Z0FyvgKXlB4A
         9vgn4EdcyUb66isFFBEN/AESOUMJbf5mdp/dSk5MrVglNMORROVJFHPeAPru8TK7CXXW
         FY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=IipW9wJLhoaQM8RoLqkPizpPvc0vhUndK21L4oCs0Ys=;
        b=anaU+tpkpoOoZ//HL9GV593ohAgWQr7I58AvunL4ZJ4wkQmUjfPkl1NkwwKsHP2Gr2
         D8vTcg5CO1jxDlOwmxnbWrK/CJ7OG5JqcCJwSmtHy8sEqEIhJKITqEOO0q91orWVJgzi
         wS911IyGiAfBagSGXBbK7lo5Jf//gPaYNupgu0Ne7AoE5Qa/KHoybDfDwoj0XbgAxENF
         QAFhB/pHHhcSSh4E+PXgkITUOrSW04MrVFBo2GaWGPhxHKADX4HD0zhthjFjKirwufZf
         BkmGJ04/p7xM34gc0O+Gsx5dE6LgtlPEfuxCDiZYDlnmlkGTYc66BgTrds5+fQR8jWwJ
         0EGw==
X-Gm-Message-State: ACgBeo1gu8lkjmzdw+HJXomp3wMJXXANIdrk4qgFbdHG5cR3AkJhr8HL
        TxRkkCfWYjPxNAvyMwL9JvzRYuBKz7uE
X-Google-Smtp-Source: AA6agR5Srjteij5eEYwwNdglpqDjiZvvqDhsGDYSz5TD9OcblGDRJDujZI50XIbAXxdnGIVGwxCRZHvOkYAB
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:f64f:b0:172:a790:320a with SMTP id
 m15-20020a170902f64f00b00172a790320amr4263311plg.149.1662561941434; Wed, 07
 Sep 2022 07:45:41 -0700 (PDT)
Date:   Wed,  7 Sep 2022 07:45:15 -0700
In-Reply-To: <20220907144521.3115321-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907144521.3115321-5-zokeefe@google.com>
Subject: [PATCH mm-unstable v3 04/10] mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
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
index df33453b70fc..935af4947917 100644
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
index 66457a06b4e7..9325aec25abc 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2152,7 +2152,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	/* TODO: tracepoints */
+	trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
+				      present, swap, result);
 	return result;
 }
 #else
-- 
2.37.2.789.g6183377224-goog

