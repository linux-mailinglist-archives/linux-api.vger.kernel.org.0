Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF905BB3A0
	for <lists+linux-api@lfdr.de>; Fri, 16 Sep 2022 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiIPUlr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Sep 2022 16:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIPUlq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Sep 2022 16:41:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9BE786DA
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 13:41:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id t65so21411092pgt.2
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=D2eCqKKZO/KXHTc0SQAQ7M2iKnTcdBEOyyiC24Tc+Xo=;
        b=bBMFda+nptqrlQl7ZUX4e35Q7+mbOtguQHSnbkE3b9DqfJ4xL8COtmNBXQv8rQiiu2
         JMxcLesNiYuLf0uJkRLYOVEo9eJ8QdpyWx5yvcWdLICFIELKcEvlxU906Qj3jdxFlKce
         xirCE72KwiE+Yonxqx7IYFIK8639X/W9dOcAVHDKFromWxBK2ArrJ7uXLprCPLjdNJ+C
         bXt1lN1x6d142yccXeY662hHYuakpJ28R6AY/U71/mSmUoDvqJyL0Yu4HvQM1N7/qCiJ
         OzjCccCkyseW+qcZZHKZkhBFIWmWBWZSskSkcPUEK+JqxWZDD40/V5Tpyu1+1UwmZDcG
         9bdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=D2eCqKKZO/KXHTc0SQAQ7M2iKnTcdBEOyyiC24Tc+Xo=;
        b=JTjlgJuu3PHlyA3D59n/aV/y3aw8TQkNfu3tUtUS27um5aue3ew0qXruK5IHyN4L67
         qiIxBsHmbZeZxjXLIp0RXqsHJFKEiGDM3F7h+LiDxaLIsMBd/NG7pmSAByy+oHaGj0oU
         bCO1MVws9nRuqXdbX5cJSWyZrX6Dn/f8guBPVe8KG2KQ9g1riAgBHinOqh8MTEWe9nhx
         XnFPtYPPZioIHerTb8XfedqHi7eBxRw8x0SUDUCyCcvg4FKEsJrtbi9nJMc048g0XymO
         ZinpvMcj9+9QtmRbdBoMAXA0PMAA+kzVlPh+D3eF5zs9PL9lKLwuiun46KojVdAsf++2
         uiOQ==
X-Gm-Message-State: ACrzQf0T+lY9oRIA7/CFVM9SXq5B6Cm37//q0oy7QUxpG1PyTmGm5oSI
        soYV9ffDOtBtpU0hyKkhETLLlhKm5XPPaoZY+TQ=
X-Google-Smtp-Source: AMsMyM6t0VmlxoQlMKOPt/NFyQo/t6IJwLAzKh0xQPTMuf8YK+2qyVgXZdHuBcgogMxeyRDcgOBJxNhyFHMqBUsMDkQ=
X-Received: by 2002:aa7:9193:0:b0:536:62e6:1a84 with SMTP id
 x19-20020aa79193000000b0053662e61a84mr7176756pfa.20.1663360904910; Fri, 16
 Sep 2022 13:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com> <20220907144521.3115321-5-zokeefe@google.com>
In-Reply-To: <20220907144521.3115321-5-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 16 Sep 2022 13:41:32 -0700
Message-ID: <CAHbLzko9MsLcKhV9hh_0ZN8j5Zqh9cvLTCOrhNXGRcVYWQ1q3g@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 04/10] mm/khugepaged: add tracepoint to hpage_collapse_scan_file()
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 7, 2022 at 7:45 AM Zach O'Keefe <zokeefe@google.com> wrote:
>
> Add huge_memory:trace_mm_khugepaged_scan_file tracepoint to
> hpage_collapse_scan_file() analogously to hpage_collapse_scan_pmd().
> While this change is targeted at debugging MADV_COLLAPSE pathway, the
> "mm_khugepaged" prefix is retained for symmetry with
> huge_memory:trace_mm_khugepaged_scan_pmd, which retains it's legacy name
> to prevent changing kernel ABI as much as possible.
>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/trace/events/huge_memory.h | 34 ++++++++++++++++++++++++++++++
>  mm/khugepaged.c                    |  3 ++-
>  2 files changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index df33453b70fc..935af4947917 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -169,5 +169,39 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
>                 __entry->ret)
>  );
>
> +TRACE_EVENT(mm_khugepaged_scan_file,
> +
> +       TP_PROTO(struct mm_struct *mm, struct page *page, const char *filename,
> +                int present, int swap, int result),
> +
> +       TP_ARGS(mm, page, filename, present, swap, result),
> +
> +       TP_STRUCT__entry(
> +               __field(struct mm_struct *, mm)
> +               __field(unsigned long, pfn)
> +               __string(filename, filename)
> +               __field(int, present)
> +               __field(int, swap)
> +               __field(int, result)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->mm = mm;
> +               __entry->pfn = page ? page_to_pfn(page) : -1;
> +               __assign_str(filename, filename);
> +               __entry->present = present;
> +               __entry->swap = swap;
> +               __entry->result = result;
> +       ),
> +
> +       TP_printk("mm=%p, scan_pfn=0x%lx, filename=%s, present=%d, swap=%d, result=%s",
> +               __entry->mm,
> +               __entry->pfn,
> +               __get_str(filename),
> +               __entry->present,
> +               __entry->swap,
> +               __print_symbolic(__entry->result, SCAN_STATUS))
> +);
> +
>  #endif /* __HUGE_MEMORY_H */
>  #include <trace/define_trace.h>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 66457a06b4e7..9325aec25abc 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2152,7 +2152,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
>                 }
>         }
>
> -       /* TODO: tracepoints */
> +       trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
> +                                     present, swap, result);
>         return result;
>  }
>  #else
> --
> 2.37.2.789.g6183377224-goog
>
