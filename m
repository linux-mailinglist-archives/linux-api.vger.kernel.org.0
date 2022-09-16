Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D485BB496
	for <lists+linux-api@lfdr.de>; Sat, 17 Sep 2022 01:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIPXFo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Sep 2022 19:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiIPXFn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Sep 2022 19:05:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5834DF10
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 16:05:42 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d82so22585635pfd.10
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JPS3rZg4bQ62RtLzsB7DgGU6ZsDdjoF4tP8H2c4lSWg=;
        b=jh7AhztYzYpQz9QGFSUwzCSl6BMCHWMP5wLzATZsIheNEgGXNQ8PlG5i9weZ51RKmf
         hDhnRs4dglyPOGituqoUMss4FgEukjpASj9OouMXam+9KJJ4cmIvHmOSERSqXmdaRxfG
         yt3/E5GzzjG5EgQtBohUesRrPXzEoSJ4047ffdt8W1C4FOXlJPEQeQsNWNsH7Emz+W/s
         1ezR39+sok5UN+ys0LIhMmEKCXTuZHgzGh4puiywidbDm0I6zxGLaLCDZtpS47PknAfV
         Wwd6y35mHkM92lOBgDEKmtuEb5h5CHu/2ClPPNoiUMkFb8qEhw7vKAAIoZAOa0KV8MaU
         5TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JPS3rZg4bQ62RtLzsB7DgGU6ZsDdjoF4tP8H2c4lSWg=;
        b=Du/hQAIrbFveeJ9E2fzeWfs5DS6Ra8ULfUBDVqtB1eaY4rGERqTwiSQvLL7pc5bhaO
         7qj8OFLlbkM49DCIIxs+mCgQN9JpOzrb72nzDTZ75VXAAGtCq3zV/mdscCugRqNXHvpn
         RGqQe6nyeDEc0lL7iSRLRAvez+nUfA/4CI3AIds4vAYRjVVTsRawqs4XX2cSUoVciSNW
         Xck3uWZlJsXPAnTovC4CM83FIQL1DIeg02T/x1oed2GVNbS8i0LFw1LZdX8enplWaYnr
         J+CLuRVia+8JnipM+AqSB17A4mWyDJv2M6Jwdjk1SfITv+1o7yeFKDjHPSH7NDB+kYFn
         9oWg==
X-Gm-Message-State: ACrzQf09mxWtoMQTWB3wZ+MjVgKvKD+AlriDmSFKQQpb1Nqvd7o7w3g3
        EJb05q1cjgXsr5H8JYkPtsnxmQ==
X-Google-Smtp-Source: AMsMyM4w0RVV82+Q3b7HuylqZMpKg87acNTPI01JO42vgXPC+p5MKWY281B2C9+jJX3cGhkOJWq/9g==
X-Received: by 2002:a62:1a8d:0:b0:544:1309:19f3 with SMTP id a135-20020a621a8d000000b00544130919f3mr7429622pfa.37.1663369541940;
        Fri, 16 Sep 2022 16:05:41 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d48300b001786b712f0esm4535776plg.227.2022.09.16.16.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 16:05:41 -0700 (PDT)
Date:   Fri, 16 Sep 2022 16:05:37 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
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
Subject: Re: [PATCH mm-unstable v3 04/10] mm/khugepaged: add tracepoint to
 hpage_collapse_scan_file()
Message-ID: <YyUBQbIgLmAoAOLo@google.com>
References: <20220907144521.3115321-1-zokeefe@google.com>
 <20220907144521.3115321-5-zokeefe@google.com>
 <CAHbLzko9MsLcKhV9hh_0ZN8j5Zqh9cvLTCOrhNXGRcVYWQ1q3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzko9MsLcKhV9hh_0ZN8j5Zqh9cvLTCOrhNXGRcVYWQ1q3g@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sep 16 13:41, Yang Shi wrote:
> On Wed, Sep 7, 2022 at 7:45 AM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > Add huge_memory:trace_mm_khugepaged_scan_file tracepoint to
> > hpage_collapse_scan_file() analogously to hpage_collapse_scan_pmd().
> > While this change is targeted at debugging MADV_COLLAPSE pathway, the
> > "mm_khugepaged" prefix is retained for symmetry with
> > huge_memory:trace_mm_khugepaged_scan_pmd, which retains it's legacy name
> > to prevent changing kernel ABI as much as possible.
> >
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> 

Thanks, as always!

> > ---
> >  include/trace/events/huge_memory.h | 34 ++++++++++++++++++++++++++++++
> >  mm/khugepaged.c                    |  3 ++-
> >  2 files changed, 36 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> > index df33453b70fc..935af4947917 100644
> > --- a/include/trace/events/huge_memory.h
> > +++ b/include/trace/events/huge_memory.h
> > @@ -169,5 +169,39 @@ TRACE_EVENT(mm_collapse_huge_page_swapin,
> >                 __entry->ret)
> >  );
> >
> > +TRACE_EVENT(mm_khugepaged_scan_file,
> > +
> > +       TP_PROTO(struct mm_struct *mm, struct page *page, const char *filename,
> > +                int present, int swap, int result),
> > +
> > +       TP_ARGS(mm, page, filename, present, swap, result),
> > +
> > +       TP_STRUCT__entry(
> > +               __field(struct mm_struct *, mm)
> > +               __field(unsigned long, pfn)
> > +               __string(filename, filename)
> > +               __field(int, present)
> > +               __field(int, swap)
> > +               __field(int, result)
> > +       ),
> > +
> > +       TP_fast_assign(
> > +               __entry->mm = mm;
> > +               __entry->pfn = page ? page_to_pfn(page) : -1;
> > +               __assign_str(filename, filename);
> > +               __entry->present = present;
> > +               __entry->swap = swap;
> > +               __entry->result = result;
> > +       ),
> > +
> > +       TP_printk("mm=%p, scan_pfn=0x%lx, filename=%s, present=%d, swap=%d, result=%s",
> > +               __entry->mm,
> > +               __entry->pfn,
> > +               __get_str(filename),
> > +               __entry->present,
> > +               __entry->swap,
> > +               __print_symbolic(__entry->result, SCAN_STATUS))
> > +);
> > +
> >  #endif /* __HUGE_MEMORY_H */
> >  #include <trace/define_trace.h>
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 66457a06b4e7..9325aec25abc 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2152,7 +2152,8 @@ static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> >                 }
> >         }
> >
> > -       /* TODO: tracepoints */
> > +       trace_mm_khugepaged_scan_file(mm, page, file->f_path.dentry->d_iname,
> > +                                     present, swap, result);
> >         return result;
> >  }
> >  #else
> > --
> > 2.37.2.789.g6183377224-goog
> >
