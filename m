Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9515BB460
	for <lists+linux-api@lfdr.de>; Sat, 17 Sep 2022 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIPWXF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Sep 2022 18:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIPWXE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Sep 2022 18:23:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7946BBBA57
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 15:23:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id t3so22698955ply.2
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=y8Pxj/xcXZKxaO0043xI3pHADs/M/D9Ct7+T8iYZvS4=;
        b=n9byK+Xla98dDRkSNwgCOutFwTs7hhhydnNxVaBpdmTs6Lvb6AOE1y9SaGbZjgNluK
         ZJxAqBF3vpa5dnDW1mDbTEHCk5WjUEo9SdprIYkPJQoC0n6iiuiXJJREVERoo9zvR9ZF
         OMzdTS5XeYPA7rOBFmqW5DVE5E7Lw1VlZJ2cMw8uRd2Hu5n4dnp8GeIRUQ02DQFz8aDb
         ABRlAX62ZwLpvnlbKgI5rOXzAlw2BIIqJJSA/mKvq5LvyViayIX7DuJz8CRxTFAC6DmK
         FNJ9t/HdMyYD6BSAQJkhoM6tYqvOBg69kqdRz6to9O+KNw+qiOJ9PHB0p/l/qFvxUrIk
         7WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=y8Pxj/xcXZKxaO0043xI3pHADs/M/D9Ct7+T8iYZvS4=;
        b=hw14hX3vukHgk/O8HjjXq9vHkNL9EnC4fD4kVdCNfafLOpTsxHaia/d7zxDPga7FL9
         UVNo7a1cRAjInS85K4XDxrWw9+HpCCpD7Xp0aglYe8w4gG7AUmDQhOhs3SxcKTMPsAUN
         ybrvjwXJR0IM4TDUULWXbPYl1K7VBCKuj2n1Ta7PkQwP0cCYG3GIi/Cm1XC+C4YGwLCi
         vptOg+T+kxJ+JMuhol+DknkyUVlSIEew1d7JwnrPLbDcwMkphnU6TNEI/o+MeJgWWV/B
         t29PfT2uZ07D2VVgMEkU2hx2dSNG1s6GlMlYyMSaajDeUrhmD+3Kw36bQYOwhyo5R0q9
         s2WA==
X-Gm-Message-State: ACrzQf1ryqJRsHOilx628XVuNSOrkLy/TomC8jCSFscJ7EJVGU8+2Ksj
        LMI+dIUKPOR7BO85rprWD+gkTg==
X-Google-Smtp-Source: AMsMyM79sV92fDMUai7ZIkQsZ8oz4lklJoYx1OUgoInKmlpSZH8mKJxxpNgGVFSaW9VI9+OTX7SRBw==
X-Received: by 2002:a17:90a:8992:b0:202:f6b1:ef25 with SMTP id v18-20020a17090a899200b00202f6b1ef25mr18511741pjn.239.1663366982640;
        Fri, 16 Sep 2022 15:23:02 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903121000b00178865002a2sm1332215plh.195.2022.09.16.15.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:23:02 -0700 (PDT)
Date:   Fri, 16 Sep 2022 15:22:58 -0700
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
Subject: Re: [PATCH mm-unstable v3 01/10] mm/shmem: add flag to enforce shmem
 THP in hugepage_vma_check()
Message-ID: <YyT3Qq7K8UZM6IrF@google.com>
References: <20220907144521.3115321-1-zokeefe@google.com>
 <20220907144521.3115321-2-zokeefe@google.com>
 <CAHbLzko3A5-TpS0BgBeKkx5cuOkWgLvWXQH=TdgW-baO4rPtdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzko3A5-TpS0BgBeKkx5cuOkWgLvWXQH=TdgW-baO4rPtdg@mail.gmail.com>
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

On Sep 16 10:46, Yang Shi wrote:
> On Wed, Sep 7, 2022 at 7:45 AM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > Extend 'mm/thp: add flag to enforce sysfs THP in
> > hugepage_vma_check()' to shmem, allowing callers to ignore
> > /sys/kernel/transparent_hugepage/shmem_enabled and tmpfs huge= mount.
> >
> > This is intended to be used by MADV_COLLAPSE, and the rationale is
> > analogous to the anon/file case: MADV_COLLAPSE is not coupled to
> > directives that advise the kernel's decisions on when THPs should be
> > considered eligible. shmem/tmpfs always claims large folio support,
> > regardless of sysfs or mount options.
> >
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> 
> A nit below...
> 

Hey Yang,

Thanks for taking the time as always :)

> > ---
> >  include/linux/shmem_fs.h | 10 ++++++----
> >  mm/huge_memory.c         |  2 +-
> >  mm/shmem.c               | 18 +++++++++---------
> >  3 files changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> > index f24071e3c826..d500ea967dc7 100644
> > --- a/include/linux/shmem_fs.h
> > +++ b/include/linux/shmem_fs.h
> > @@ -92,11 +92,13 @@ extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
> >  extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
> >  int shmem_unuse(unsigned int type);
> >
> > -extern bool shmem_is_huge(struct vm_area_struct *vma,
> > -                         struct inode *inode, pgoff_t index);
> > -static inline bool shmem_huge_enabled(struct vm_area_struct *vma)
> > +extern bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
> > +                         pgoff_t index, bool shmem_huge_force);
> > +static inline bool shmem_huge_enabled(struct vm_area_struct *vma,
> > +                                     bool shmem_huge_force)
> >  {
> > -       return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff);
> > +       return shmem_is_huge(vma, file_inode(vma->vm_file), vma->vm_pgoff,
> > +                            shmem_huge_force);
> >  }
> >  extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
> >  extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 7fa74b9749a6..53d170dac332 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -119,7 +119,7 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
> >          * own flags.
> >          */
> >         if (!in_pf && shmem_file(vma->vm_file))
> > -               return shmem_huge_enabled(vma);
> > +               return shmem_huge_enabled(vma, !enforce_sysfs);
> >
> >         /* Enforce sysfs THP requirements as necessary */
> >         if (enforce_sysfs &&
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 99b7341bd0bf..47c42c566fd1 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -461,20 +461,20 @@ static bool shmem_confirm_swap(struct address_space *mapping,
> >
> >  static int shmem_huge __read_mostly = SHMEM_HUGE_NEVER;
> >
> > -bool shmem_is_huge(struct vm_area_struct *vma,
> > -                  struct inode *inode, pgoff_t index)
> > +bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
> > +                  pgoff_t index, bool shmem_huge_force)
> >  {
> >         loff_t i_size;
> >
> >         if (!S_ISREG(inode->i_mode))
> >                 return false;
> > -       if (shmem_huge == SHMEM_HUGE_DENY)
> > -               return false;
> >         if (vma && ((vma->vm_flags & VM_NOHUGEPAGE) ||
> >             test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags)))
> >                 return false;
> > -       if (shmem_huge == SHMEM_HUGE_FORCE)
> > +       if (shmem_huge == SHMEM_HUGE_FORCE || shmem_huge_force)
> 
> shmem_huge_force means ignore all sysfs and mount options, so it seems
> better to have it test explicitly IMHO, like:
> 
> if (shmem_huge_force)
>     return true;
> 
> if (shmem_huge == SHMEM_HUGE_FORCE)
>     return true;
> 
> 

This makes sense to me - a little bit cleaner / more direct.  Thanks for the
suggestion.

Thank you again,
Zach

> >                 return true;
> > +       if (shmem_huge == SHMEM_HUGE_DENY)
> > +               return false;
> >
> >         switch (SHMEM_SB(inode->i_sb)->huge) {
> >         case SHMEM_HUGE_ALWAYS:
> > @@ -669,8 +669,8 @@ static long shmem_unused_huge_count(struct super_block *sb,
> >
> >  #define shmem_huge SHMEM_HUGE_DENY
> >
> > -bool shmem_is_huge(struct vm_area_struct *vma,
> > -                  struct inode *inode, pgoff_t index)
> > +bool shmem_is_huge(struct vm_area_struct *vma, struct inode *inode,
> > +                  pgoff_t index, bool shmem_huge_force)
> >  {
> >         return false;
> >  }
> > @@ -1056,7 +1056,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
> >                         STATX_ATTR_NODUMP);
> >         generic_fillattr(&init_user_ns, inode, stat);
> >
> > -       if (shmem_is_huge(NULL, inode, 0))
> > +       if (shmem_is_huge(NULL, inode, 0, false))
> >                 stat->blksize = HPAGE_PMD_SIZE;
> >
> >         if (request_mask & STATX_BTIME) {
> > @@ -1888,7 +1888,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
> >                 return 0;
> >         }
> >
> > -       if (!shmem_is_huge(vma, inode, index))
> > +       if (!shmem_is_huge(vma, inode, index, false))
> >                 goto alloc_nohuge;
> >
> >         huge_gfp = vma_thp_gfp_mask(vma);
> > --
> > 2.37.2.789.g6183377224-goog
> >
