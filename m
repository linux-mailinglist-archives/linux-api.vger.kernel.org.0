Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287BC5EB6C9
	for <lists+linux-api@lfdr.de>; Tue, 27 Sep 2022 03:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiI0BYt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Sep 2022 21:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiI0BYs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Sep 2022 21:24:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DF440BC8
        for <linux-api@vger.kernel.org>; Mon, 26 Sep 2022 18:24:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id q10so2786347oib.5
        for <linux-api@vger.kernel.org>; Mon, 26 Sep 2022 18:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=x5/X7S0D0PsuMd9Bj3ADbJYnKoDs6aX3p9Vher7KPK4=;
        b=T98Ol14yNXZ31PsX1YZ/ZbDp+5FlzJPaIzZEe0LSf2DkhQF4ebrQcTWXHdXnaMYNMf
         CgMYngJMjRuQpKh3Mcql2Jrpiji5N6l6zmn4I9zqErJksR7mIJ97v2GgQx2pG4lxLxrd
         uG8K02iuABu4v8//VIlJDsnSHlc88WPqWaj5K5Cumw/6D0EvAksefSedSqfHhxXHYquE
         EZ1i3z7ttGAPgiN0bMqd5CUnffFAZGUjTIWJo4yZdIUzWW5y64t8eCb/nLJONkLL1JPr
         BwxZeh+l/JWjl9K0nt79CTW4TPEq9WL3pUFlyXvzG7/yIr/s4o+pgAI1aDzV/o7iCOf4
         K50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x5/X7S0D0PsuMd9Bj3ADbJYnKoDs6aX3p9Vher7KPK4=;
        b=e5DuKcUZ8UNOSE8hONszPQfwtt5EBAX3zNZsN4imel8eVTuYDyJBF8LeMEIXZ/fijN
         tZx6l/ZECE0GbQVpkMv8GhaI9Tae05qFTdeMb6iVDTj3l96YyeDexWXYHyLhxOqF9bd/
         Q9CPDYzCW8mlFI62LDQ+8QaAtwsOUkBFPoEcRfrfoPy7cTivJdUs6As2YHlxyOfvvQYO
         amviR0JVoYN6/vqxUEwEuo0Kn2HuRkkv4yYJaGl4vDqb0BXJmk1Z5k1qQHQ8zd6kxGU9
         BFh8PQyD+0cCubgUKlJzKWzksc5pxYLx9wMHAi1TWifn7Liz/3evwlSClxxdqK0sWvqU
         NgYA==
X-Gm-Message-State: ACrzQf1ZHGvBvsq/98UnSkwusJCqvJSXxYWAwVMueUZbxm6GnXWiNu7y
        lwtwRGWgF3P1Oq2+ABte+AXdIYgDxd1ZOx2ewCKhwg==
X-Google-Smtp-Source: AMsMyM53qxm8TeeWPjeLMg0JvSbn5Pjf07PvnhyBrbbJ1MGPvORc08yLoh3G5TEOasK8IK4UBQPsv8fDwqhkkCf3SEg=
X-Received: by 2002:a05:6808:118c:b0:34f:9fc9:ce15 with SMTP id
 j12-20020a056808118c00b0034f9fc9ce15mr727979oil.220.1664241885468; Mon, 26
 Sep 2022 18:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com> <20220922224046.1143204-4-zokeefe@google.com>
 <CAHbLzkrL4T_kBG3VgxYgoiHkpe0eqkJvmmGKt9swy39c6MMCrw@mail.gmail.com>
In-Reply-To: <CAHbLzkrL4T_kBG3VgxYgoiHkpe0eqkJvmmGKt9swy39c6MMCrw@mail.gmail.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Mon, 26 Sep 2022 18:24:09 -0700
Message-ID: <CAAa6QmTrAQQBqL7ry6_Mpg0D8C1uNDtfhjkzFyZz2+G_VXmGdQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v4 03/10] mm/madvise: add file and shmem
 support to MADV_COLLAPSE
To:     Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
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

> > +/* hpage must be locked, and mmap_lock must be held in write */
> > +static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
> > +                       pmd_t *pmdp, struct page *hpage)
> > +{
> > +       struct vm_fault vmf = {
> > +               .vma = vma,
> > +               .address = addr,
> > +               .flags = 0,
>
> It means you are going to install a readonly PMD. It is fine for
> readonly fs, but it may be not performant for shmem since the
> following write will trigger wp fault then the PMD will be split. So
> it should be ok to install writable PMD for shmem.
>
> But anyway this is not a fatal problem, the patch looks good to me.
> Reviewed-by: Yang Shi <shy828301@gmail.com>
>

Thanks, Yang!

I haven't worked out the details for writable shmem, but I'm hoping
FAULT_FLAG_WRITE is enough here.

I'm also now wondering if FAULT_FLAG_REMOTE is needed here for
process_madvise(MADV_COLLAPSE) when called on behalf of another
process; though that would also mean it's needed in
__collapse_huge_page_swapin() as well (even when running as
khugepaged). I can't say I fully understand 1b2ee1266ea6 ("mm/core: Do
not enforce PKEY permissions on remote mm access"), but if the comment
in include/linux/mm_types.h is to be trusted, then this would be the
case.
