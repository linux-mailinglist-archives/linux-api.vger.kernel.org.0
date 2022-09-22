Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0717C5E6FD6
	for <lists+linux-api@lfdr.de>; Fri, 23 Sep 2022 00:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIVWlC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 22 Sep 2022 18:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiIVWk6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Sep 2022 18:40:58 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88208100A9F
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:40:56 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id w197-20020a627bce000000b00556ac6baf07so15038pfc.4
        for <linux-api@vger.kernel.org>; Thu, 22 Sep 2022 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=MBOpi+V30VyxTJAocMNniALW6MRkylbw2LBwu6hBIIE=;
        b=oCIFKiW4OUoQtrTsXOTzbEwKVNj3saFB85MgUqa9cFr48OmpsyR1spCbGGEqcyYPFG
         7YEMwrHdx3zwZ8hqx0g8fa+21utbCxsG/YoS645+NA4dDCrwoFB9tEJsfDHbYgveDgqQ
         CnqIbfysHBPRpIzSkkWe/59LIuau6cZPk0i2Hc0QmysIZbmcJMqYfOpfg4DZvb+jlsKL
         KkolsrymESXvFV3oLZXN6pBwGXgg3wdGK5tW//5Z5FtbMefTOJ1uzPjxGdxOmdjRdcV8
         CMyAribGVqeaxHtoSIlpa4HGiBt592UTr0/CmDONCJ1n1a4YWfJu7f6toC9EHRYOO74w
         9BYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=MBOpi+V30VyxTJAocMNniALW6MRkylbw2LBwu6hBIIE=;
        b=KpMl//pbVh3epP7x668lGo/WLnVytzRC3vy0QHf01liF1olP7nvCHVtB8z08xlHEGS
         jYhTbQ5vvIaxK+fglEk9rXoRvJmkCYG2kCvCsGr1wBglXekARLx7MEwnLgEwh6yNdD1B
         w9EqZecuUPlreb2cT7TpWro5+vqdB9QS2Lt23BpzY3OzF1pH6v92DUFvL6VW2DeTJlOb
         kJwgXvnbSj0nsb5cVFGzYeev+lQ3Rr8c1LnKtahE3bLdRs/cFMC6NF7WWJ5u5hsCryHG
         MwuvrXa6UBLyhEIcwE2kh2A/MOR+0FCgSNVK37Lo1SXyc8j+AYT1nufHFJ9qON5NGoVG
         CViw==
X-Gm-Message-State: ACrzQf3ZTgCKQGTQtsaj5rtndtdUqxRzmwcKsx95UfXyxwis6Phnrrak
        Cgt7OEVNf9b/amrhd/JIslQJNk2h6K5Y
X-Google-Smtp-Source: AMsMyM4jj4v1oLXtfd10ojhtj3GOdmWxKUkaFwe9xELneMFuZPFD1yJUHeS6uz/V1MAyM3E0xOLKc9miAq6L
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:17a1:b0:542:be09:7b23 with SMTP
 id s33-20020a056a0017a100b00542be097b23mr5939804pfg.12.1663886455880; Thu, 22
 Sep 2022 15:40:55 -0700 (PDT)
Date:   Thu, 22 Sep 2022 15:40:40 -0700
In-Reply-To: <20220922224046.1143204-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220922224046.1143204-5-zokeefe@google.com>
Subject: [PATCH mm-unstable v4 04/10] mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
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

Add huge_memory:trace_mm_khugepaged_scan_file tracepoint to
hpage_collapse_scan_file() analogously to hpage_collapse_scan_pmd().

While this change is targeted at debugging MADV_COLLAPSE pathway, the
"mm_khugepaged" prefix is retained for symmetry with
huge_memory:trace_mm_khugepaged_scan_pmd, which retains it's legacy name
to prevent changing kernel ABI as much as possible.

Link: https://lkml.kernel.org/r/20220907144521.3115321-5-zokeefe@google.com
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
index a272fc065dd7..6d2dfd96608a 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2159,7 +2159,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	/* TODO: tracepoints */
+	trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
+				      present, swap, result);
 	return result;
 }
 #else
-- 
2.37.3.998.g577e59143f-goog

