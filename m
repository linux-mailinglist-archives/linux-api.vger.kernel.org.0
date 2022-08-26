Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9CE5A31AD
	for <lists+linux-api@lfdr.de>; Sat, 27 Aug 2022 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243653AbiHZWDr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Aug 2022 18:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344267AbiHZWDm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Aug 2022 18:03:42 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F842DAA11
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:41 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j3-20020a634a43000000b00429f2cb4a43so1424762pgl.0
        for <linux-api@vger.kernel.org>; Fri, 26 Aug 2022 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=xLLp8vTNhH59q1o8fD2SQ2kq8Qu3/LkoSxB3VWIQLC0=;
        b=XvGjn7gHG0Jy2AgL77bVjBMmKvfX3u39kZPEEpJFPH3teQ46Dx+8hErcT5acLyHFxg
         BiyWrmpM4RizBfuDsPxpBk943ZIjrRWOxEy2zkWBTftKoyNWlj9lf9QklHxMy3vC+xlv
         V3seD2HOV6EveLNH+xLmeGYqsBn02pZFAvymqrL0OIC7CSiBfl66bGJsjFqYqFiV5zJs
         QUQpdIUZWpEMSFiB65kNDqOrA5YXNZMKgBOEwShMJZ621cuDotTqKpmUDfeC7N9LO++c
         oZML7KAJBXdszNb7u7KfIKDVylXzic3HQ+nnItcuZFTHijcTYJdofdihTYG/d05OCaoM
         p53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=xLLp8vTNhH59q1o8fD2SQ2kq8Qu3/LkoSxB3VWIQLC0=;
        b=SP8FxdU5Inez2hENTmkeQsuczvk13MV5WDia7hiz15hl4tZqs10Rl4pT0rCb6WOu8K
         AgGw5z1EAnCU81Htdj2wb0aRw90ZGKGGkv8WGK0jsIXPg4v4ek/lC0AD0l8mBsIsxhT0
         1m5tBuG/IOpZkj/b3hN8kfOWGBdHMiDW4NQQVMeuREXJ7/U48MZKllJkilqUXRGg5LCK
         wQPAaVgSQM1DyiWV1/spSf0Lhk6NC7HS3hrtJn6oNo2vjO0lL6lmUj7RMjL8qk56aFDX
         6l4I0aQWi8QNBJDGRv/k8rn8EWvelLOkPt0SHX0kdJfGT48ulybnT9HkDODUx4CrNL0Q
         ZjEA==
X-Gm-Message-State: ACgBeo345U+4O6bII+9F9bMn9fCplV9M1+KCzNkQoRnX1L8uzDn1dhhz
        Mws/zCMIEZuBiKr1QpLM4c4lQYnoXWq6
X-Google-Smtp-Source: AA6agR6DfENa/SqqjaPKPVw6ISWE0peW5BCO0Jlhcvcu4MaLoFQGGb8x4Ck9MTRbtfqdId2FemtcKWQt4S0Q
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a17:902:b489:b0:171:5091:d53b with SMTP id
 y9-20020a170902b48900b001715091d53bmr5690727plr.44.1661551420635; Fri, 26 Aug
 2022 15:03:40 -0700 (PDT)
Date:   Fri, 26 Aug 2022 15:03:23 -0700
In-Reply-To: <20220826220329.1495407-1-zokeefe@google.com>
Mime-Version: 1.0
References: <20220826220329.1495407-1-zokeefe@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826220329.1495407-5-zokeefe@google.com>
Subject: [PATCH mm-unstable v2 4/9] mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
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
index 34c0c74b3839..55144f33ba09 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2171,7 +2171,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
 		}
 	}
 
-	/* TODO: tracepoints */
+	trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
+				      present, swap, result);
 	return result;
 }
 #else
-- 
2.37.2.672.g94769d06f0-goog

