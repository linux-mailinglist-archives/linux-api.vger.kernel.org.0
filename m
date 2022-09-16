Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A6B5BB1BC
	for <lists+linux-api@lfdr.de>; Fri, 16 Sep 2022 19:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIPRq3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Sep 2022 13:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiIPRq1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Sep 2022 13:46:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3190C72
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 10:46:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so382177pjk.4
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 10:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bGlPiAdoAwCN/kk/sgLTt0tFCqAu0UJel6VuA5nrRzo=;
        b=kj+jNlpEBI1gx5UYRCwGlU0K4V/x/gxhqMZH2GL4znu+wsn4o8owU9yUOQi3EWfGAo
         5388vFVL2ZB/KlkberyIdDGa2Ba0/dzaD8lIjeO08fZJ4RknTMi9duk4Siwj4ODXKyw0
         dDnuxM6XvRptf3VVhf2TH8AmWjNZSuy05+5DjEq0DLAZsRlQhtZGIxX7FH6ChQu4jlH+
         3rWJ51kMHiJ/CmD6twKSuMOJ0wqNUftzvnxol4F/84oawrrhQBJtw8MhD+0hB5+aeTbf
         t/7giJUExIxlOXza4ArgVfIb4MvmH4Q776HlqQVnmWtCNBjM+BzYaRx/SYTjoer5UeyH
         VOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bGlPiAdoAwCN/kk/sgLTt0tFCqAu0UJel6VuA5nrRzo=;
        b=E3+/v1hsm9GoofmrYaU9BeVYvIrQmS5HxIaCv5niAXehJcvuRC/jlzqJOo5BykteQ3
         NZThPxiudOoQ6JuDBXHap/Rj9ZJSYIRGw8G7OAwqy5kUhf1+WG5FJE4jO+c7m0Vr5zjU
         jTPIwcvpTPwqjt5TPsghGmrYtWGkqzenc2ELhRiHmu3UUP8dza0H7foJ5n7axgB3B7rT
         E9PTYuSSsatuVXqT+AjBwOFKCKMdOJcNADKN6wd/qcdpT36RFhU9c1N361Hre0tHTX07
         7uVZ1BsIRxzZ1b/3kfNAQnxSyXZUY61xClDtK/3XsmygnIJxfoGQpFuDbWqSsDlBo7Dd
         8GYQ==
X-Gm-Message-State: ACrzQf1s4e++MFGtoT7ZoDMWbdPhB0zuztXb12FQxkKaUacWC4XZtOSd
        kn92lOlFiYBX7gXTaGT90Tunhu2EtlMon5/i5CU=
X-Google-Smtp-Source: AMsMyM4LUFoR1XGTgnimYOGHfm9KyHt1RuU0QXZaJq3t9UVoRP8j6DITjCtGkO9biE+VIJ1u0nOpi2SkMtELa6coTio=
X-Received: by 2002:a17:90b:1b4c:b0:202:c05f:6e7b with SMTP id
 nv12-20020a17090b1b4c00b00202c05f6e7bmr6729830pjb.200.1663350382684; Fri, 16
 Sep 2022 10:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com> <20220907144521.3115321-2-zokeefe@google.com>
In-Reply-To: <20220907144521.3115321-2-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 16 Sep 2022 10:46:09 -0700
Message-ID: <CAHbLzko3A5-TpS0BgBeKkx5cuOkWgLvWXQH=TdgW-baO4rPtdg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 01/10] mm/shmem: add flag to enforce shmem
 THP in hugepage_vma_check()
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
> Extend 'mm/thp: add flag to enforce sysfs THP in
> hugepage_vma_check()' to shmem, allowing callers to ignore
> /sys/kernel/transparent_hugepage/shmem_enabled and tmpfs huge= mount.
>
> This is intended to be used by MADV_COLLAPSE, and the rationale is
> analogous to the anon/file case: MADV_COLLAPSE is not coupled to
> directives that advise the kernel's decisions on when THPs should be
> considered eligible. shmem/tmpfs always claims large folio support,
> regardless of sysfs or mount options.
>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

A nit below...

> ---
>  include/linux/shmem_fs.h | 10 ++++++----
>  mm/huge_memory.c         |  2 +-
>  mm/shmem.c               | 18 +++++++++---------
>  3 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index f24071e3c826..d500ea967dc7 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -92,11 +92,13 @@ extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
>  extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
>  int shmem_unuse(unsigned int type);
>
> -extern bool shmem_is_huge(struct vm_area_struct *vma,
> -                         struct inode *inode, pgoff_t index);
> -static inline bool shmem_huge_enabled(struct vm_area_struct *vma)
> +extern bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
> +                         pgoff_t index, bool shmem_huge_force);
> +static inline bool shmem_huge_enabled(struct vm_area_struct *vma,
> +                                     bool shmem_huge_force)
>  {
> -       return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff);
> +       return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff,
> +                            shmem_huge_force);
>  }
>  extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
>  extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 7fa74b9749a6..53d170dac332 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -119,7 +119,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
>          * own flags.
>          */
>         if (!in_pf && shmem_file(vma->vm_file))
> -               return shmem_huge_enabled(vma);
> +               return shmem_huge_enabled(vma, !enforce_sysfs);
>
>         /* Enforce sysfs THP requirements as necessary */
>         if (enforce_sysfs &&
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 99b7341bd0bf..47c42c566fd1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -461,20 +461,20 @@ static bool shmem_confirm_swap(struct address_space *mapping,
>
>  static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
>
> -bool shmem_is_huge(struct vm_area_struct *vma,
> -                  struct inode *inode, pgoff_t index)
> +bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
> +                  pgoff_t index, bool shmem_huge_force)
>  {
>         loff_t i_size;
>
>         if (!S_ISREG(inode->i_mode))
>                 return false;
> -       if (shmem_huge == SHMEM_HUGE_DENY)
> -               return false;
>         if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
>             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
>                 return false;
> -       if (shmem_huge == SHMEM_HUGE_FORCE)
> +       if (shmem_huge == SHMEM_HUGE_FORCE || shmem_huge_force)

shmem_huge_force means ignore all sysfs and mount options, so it seems
better to have it test explicitly IMHO, like:

if (shmem_huge_force)
    return true;

if (shmem_huge == SHMEM_HUGE_FORCE)
    return true;


>                 return true;
> +       if (shmem_huge == SHMEM_HUGE_DENY)
> +               return false;
>
>         switch (SHMEM_SB(inode->i_sb)->huge) {
>         case SHMEM_HUGE_ALWAYS:
> @@ -669,8 +669,8 @@ static long shmem_unused_huge_count(struct super_block *sb,
>
>  #define shmem_huge SHMEM_HUGE_DENY
>
> -bool shmem_is_huge(struct vm_area_struct *vma,
> -                  struct inode *inode, pgoff_t index)
> +bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
> +                  pgoff_t index, bool shmem_huge_force)
>  {
>         return false;
>  }
> @@ -1056,7 +1056,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
>                         STATX_ATTR_NODUMP);
>         generic_fillattr(&init_user_ns, inode, stat);
>
> -       if (shmem_is_huge(NULL, inode, 0))
> +       if (shmem_is_huge(NULL, inode, 0, false))
>                 stat->blksize = HPAGE_PMD_SIZE;
>
>         if (request_mask & STATX_BTIME) {
> @@ -1888,7 +1888,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>                 return 0;
>         }
>
> -       if (!shmem_is_huge(vma, inode, index))
> +       if (!shmem_is_huge(vma, inode, index, false))
>                 goto alloc_nohuge;
>
>         huge_gfp = vma_thp_gfp_mask(vma);
> --
> 2.37.2.789.g6183377224-goog
>
