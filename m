Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD5A57216F
	for <lists+linux-api@lfdr.de>; Tue, 12 Jul 2022 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiGLQzC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 Jul 2022 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiGLQzA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 Jul 2022 12:55:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634DFB3D4B
        for <linux-api@vger.kernel.org>; Tue, 12 Jul 2022 09:54:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p9so8282316pjd.3
        for <linux-api@vger.kernel.org>; Tue, 12 Jul 2022 09:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SNbvxQrAF0PGcWamYEyo8Q3smlt0K9Ue+RRXRcxSf94=;
        b=qoixECQBykn1whjmBUMxClVzmZaLfgU87MkzAi56yZgkw/6M1Jk+D/0kyqEJeVg79S
         qr1kuYjaaM0Pn1+fyw4B/hB41KAV3Y/6uwX+qSxouA0HfYLvoSTRywD/azAjOELNGd3s
         5oRqb+W9jo6RZeQbPeG35GCgdoiR6IHrcD8TeRqQRtLXmYXSdqL1iQizZRsi7P07cLR6
         X5a89k27O/E/aI9afoEpQ0Ezhl9t766rYc34qL8WxXUNC+20bDHIpYQSN6ERJk/4Bj+s
         cmzMDbQ2PqTINDPmm488KMxqLZu38TElVSFlc24eGFwIW2APhN76nPUt9VKkh3V4pNvl
         ozCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SNbvxQrAF0PGcWamYEyo8Q3smlt0K9Ue+RRXRcxSf94=;
        b=IgEmxVg/L4fE0z84TKERfw9SOvYmi4TMibf4vQgtQZNTEkXFwUcyfqPdlaX2RLNjfC
         GZJPT//xfVAx3wG0QgFBrNug73zbTlY5o/xTewVdBAaI7aPRzY5grWQFxjWAveHmv7L4
         2isLISNJYqidFH70JcLESkIdnrVt4LGtJBmxn1PB+dqtNT8MGcaILg+cwmFE4NsysiAT
         0+fF6L5beTAZRCXuRPaah9PapGCsSpea6bLoeWjBNiYCaKjnc9+pdy1lvpRxLPHp1j3Q
         MraZbfX5w+epLsPKVtaNwC12hCPR8x8Wx455I7d1fC3+3NvEHipPM0Ig6JyOT7lRofKo
         WYJQ==
X-Gm-Message-State: AJIora+9+ziW+yreXz2B9aw+/C20Yz8+mKy5UyKE+HTbn1ZLCTverfIs
        Ukpv9Zne1cKNo50WqDGqguJZCg==
X-Google-Smtp-Source: AGRyM1sFGPWf6FKecDUbG+GZhrkpljlf9bfuS7/lNjUhV6QI55IwuKKqhqA5zXdKlU89oKIIvTUlzg==
X-Received: by 2002:a17:90b:33c4:b0:1f0:3d9d:39ac with SMTP id lk4-20020a17090b33c400b001f03d9d39acmr5357409pjb.56.1657644898526;
        Tue, 12 Jul 2022 09:54:58 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id 64-20020a621943000000b00518764d09cdsm7059748pfz.164.2022.07.12.09.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 09:54:57 -0700 (PDT)
Date:   Tue, 12 Jul 2022 09:54:54 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Hugh Dickins <hughd@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-api@vger.kernel.org
Subject: Re: [mm-unstable v7 09/18] mm/madvise: introduce MADV_COLLAPSE sync
 hugepage collapse
Message-ID: <Ys2nXoMRhyfcx4q8@google.com>
References: <20220706235936.2197195-1-zokeefe@google.com>
 <20220706235936.2197195-10-zokeefe@google.com>
 <CAHbLzkrgLovEf71E+FTTLAmTwWuDhTYvFEYbqHxhMQkM2zAT7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrgLovEf71E+FTTLAmTwWuDhTYvFEYbqHxhMQkM2zAT7g@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Jul 11 14:22, Yang Shi wrote:
> On Wed, Jul 6, 2022 at 5:06 PM Zach O'Keefe <zokeefe@google.com> wrote:
> >
> > This idea was introduced by David Rientjes[1].
> >
> > Introduce a new madvise mode, MADV_COLLAPSE, that allows users to request a
> > synchronous collapse of memory at their own expense.
> >
> > The benefits of this approach are:
> >
> > * CPU is charged to the process that wants to spend the cycles for the
> >   THP
> > * Avoid unpredictable timing of khugepaged collapse
> >
> > Semantics
> >
> > This call is independent of the system-wide THP sysfs settings, but will
> > fail for memory marked VM_NOHUGEPAGE.  If the ranges provided span
> > multiple VMAs, the semantics of the collapse over each VMA is
> > independent from the others.  This implies a hugepage cannot cross a VMA
> > boundary.  If collapse of a given hugepage-aligned/sized region fails,
> > the operation may continue to attempt collapsing the remainder of memory
> > specified.
> >
> > The memory ranges provided must be page-aligned, but are not required to
> > be hugepage-aligned.  If the memory ranges are not hugepage-aligned, the
> > start/end of the range will be clamped to the first/last
> > hugepage-aligned address covered by said range.  The memory ranges must
> > span at least one hugepage-sized region.
> >
> > All non-resident pages covered by the range will first be
> > swapped/faulted-in, before being internally copied onto a freshly
> > allocated hugepage.  Unmapped pages will have their data directly
> > initialized to 0 in the new hugepage.  However, for every eligible hugepage
> > aligned/sized region to-be collapsed, at least one page must currently be
> > backed by memory (a PMD covering the address range must already exist).
> >
> > Allocation for the new hugepage may enter direct reclaim and/or
> > compaction, regardless of VMA flags.  When the system has multiple NUMA
> > nodes, the hugepage will be allocated from the node providing the most
> > native pages.  This operation operates on the current state of the
> > specified process and makes no persistent changes or guarantees on how
> > pages will be mapped, constructed, or faulted in the future
> >
> > Return Value
> >
> > If all hugepage-sized/aligned regions covered by the provided range were
> > either successfully collapsed, or were already PMD-mapped THPs, this
> > operation will be deemed successful.  On success, process_madvise(2)
> > returns the number of bytes advised, and madvise(2) returns 0.  Else, -1
> > is returned and errno is set to indicate the error for the most-recently
> > attempted hugepage collapse.  Note that many failures might have
> > occurred, since the operation may continue to collapse in the event a
> > single hugepage-sized/aligned region fails.
> >
> >         ENOMEM  Memory allocation failed or VMA not found
> >         EBUSY   Memcg charging failed
> >         EAGAIN  Required resource temporarily unavailable.  Try again
> >                 might succeed.
> >         EINVAL  Other error: No PMD found, subpage doesn't have Present
> >                 bit set, "Special" page no backed by struct page, VMA
> >                 incorrectly sized, address not page-aligned, ...
> >
> > Most notable here is ENOMEM and EBUSY (new to madvise) which are
> > intended to provide the caller with actionable feedback so they may take
> > an appropriate fallback measure.
> 
> Don't forget to update man-pages. And cc'ed linux-api.
>

Thanks for the review, Yang. Yes, have plans to update the man-pages once things
are fully ironed out. Also, thanks for tip to cc linux-api - I did not know
about that.

Best,
Zach

> >
> > Use Cases
> >
> > An immediate user of this new functionality are malloc() implementations
> > that manage memory in hugepage-sized chunks, but sometimes subrelease
> > memory back to the system in native-sized chunks via MADV_DONTNEED;
> > zapping the pmd.  Later, when the memory is hot, the implementation
> > could madvise(MADV_COLLAPSE) to re-back the memory by THPs to regain
> > hugepage coverage and dTLB performance.  TCMalloc is such an
> > implementation that could benefit from this[2].
> >
> > Only privately-mapped anon memory is supported for now, but additional
> > support for file, shmem, and HugeTLB high-granularity mappings[2] is
> > expected.  File and tmpfs/shmem support would permit:
> >
> > * Backing executable text by THPs.  Current support provided by
> >   CONFIG_READ_ONLY_THP_FOR_FS may take a long time on a large system which
> >   might impair services from serving at their full rated load after
> >   (re)starting.  Tricks like mremap(2)'ing text onto anonymous memory to
> >   immediately realize iTLB performance prevents page sharing and demand
> >   paging, both of which increase steady state memory footprint.  With
> >   MADV_COLLAPSE, we get the best of both worlds: Peak upfront performance
> >   and lower RAM footprints.
> > * Backing guest memory by hugapages after the memory contents have been
> >   migrated in native-page-sized chunks to a new host, in a
> >   userfaultfd-based live-migration stack.
> >
> > [1] https://lore.kernel.org/linux-mm/d098c392-273a-36a4-1a29-59731cdf5d3d@google.com/
> > [2] https://github.com/google/tcmalloc/tree/master/tcmalloc
> >
> > Suggested-by: David Rientjes <rientjes@google.com>
> > Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> 
> Reviewed-by: Yang Shi <shy828301@gmail.com>
> 
> > ---
> >  arch/alpha/include/uapi/asm/mman.h           |   2 +
> >  arch/mips/include/uapi/asm/mman.h            |   2 +
> >  arch/parisc/include/uapi/asm/mman.h          |   2 +
> >  arch/xtensa/include/uapi/asm/mman.h          |   2 +
> >  include/linux/huge_mm.h                      |  14 ++-
> >  include/uapi/asm-generic/mman-common.h       |   2 +
> >  mm/khugepaged.c                              | 118 ++++++++++++++++++-
> >  mm/madvise.c                                 |   5 +
> >  tools/include/uapi/asm-generic/mman-common.h |   2 +
> >  9 files changed, 146 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
> > index 4aa996423b0d..763929e814e9 100644
> > --- a/arch/alpha/include/uapi/asm/mman.h
> > +++ b/arch/alpha/include/uapi/asm/mman.h
> > @@ -76,6 +76,8 @@
> >
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked pages too */
> >
> > +#define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
> > index 1be428663c10..c6e1fc77c996 100644
> > --- a/arch/mips/include/uapi/asm/mman.h
> > +++ b/arch/mips/include/uapi/asm/mman.h
> > @@ -103,6 +103,8 @@
> >
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked pages too */
> >
> > +#define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
> > index a7ea3204a5fa..22133a6a506e 100644
> > --- a/arch/parisc/include/uapi/asm/mman.h
> > +++ b/arch/parisc/include/uapi/asm/mman.h
> > @@ -70,6 +70,8 @@
> >  #define MADV_WIPEONFORK 71             /* Zero memory on fork, child only */
> >  #define MADV_KEEPONFORK 72             /* Undo MADV_WIPEONFORK */
> >
> > +#define MADV_COLLAPSE  73              /* Synchronous hugepage collapse */
> > +
> >  #define MADV_HWPOISON     100          /* poison a page for testing */
> >  #define MADV_SOFT_OFFLINE 101          /* soft offline page for testing */
> >
> > diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
> > index 7966a58af472..1ff0c858544f 100644
> > --- a/arch/xtensa/include/uapi/asm/mman.h
> > +++ b/arch/xtensa/include/uapi/asm/mman.h
> > @@ -111,6 +111,8 @@
> >
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked pages too */
> >
> > +#define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 00312fc251c1..39193623442e 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -218,6 +218,9 @@ void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
> >
> >  int hugepage_madvise(struct vm_area_struct *vma, unsigned long *vm_flags,
> >                      int advice);
> > +int madvise_collapse(struct vm_area_struct *vma,
> > +                    struct vm_area_struct **prev,
> > +                    unsigned long start, unsigned long end);
> >  void vma_adjust_trans_huge(struct vm_area_struct *vma, unsigned long start,
> >                            unsigned long end, long adjust_next);
> >  spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma);
> > @@ -361,9 +364,16 @@ static inline void split_huge_pmd_address(struct vm_area_struct *vma,
> >  static inline int hugepage_madvise(struct vm_area_struct *vma,
> >                                    unsigned long *vm_flags, int advice)
> >  {
> > -       BUG();
> > -       return 0;
> > +       return -EINVAL;
> >  }
> > +
> > +static inline int madvise_collapse(struct vm_area_struct *vma,
> > +                                  struct vm_area_struct **prev,
> > +                                  unsigned long start, unsigned long end)
> > +{
> > +       return -EINVAL;
> > +}
> > +
> >  static inline void vma_adjust_trans_huge(struct vm_area_struct *vma,
> >                                          unsigned long start,
> >                                          unsigned long end,
> > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> > index 6c1aa92a92e4..6ce1f1ceb432 100644
> > --- a/include/uapi/asm-generic/mman-common.h
> > +++ b/include/uapi/asm-generic/mman-common.h
> > @@ -77,6 +77,8 @@
> >
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked pages too */
> >
> > +#define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index c7a09cc9a0e8..2b2d832e44f2 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -976,7 +976,8 @@ static int alloc_charge_hpage(struct page **hpage, struct mm_struct *mm,
> >                               struct collapse_control *cc)
> >  {
> >         /* Only allocate from the target node */
> > -       gfp_t gfp = alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
> > +       gfp_t gfp = (cc->is_khugepaged ? alloc_hugepage_khugepaged_gfpmask() :
> > +                    GFP_TRANSHUGE) | __GFP_THISNODE;
> >         int node = khugepaged_find_target_node(cc);
> >
> >         if (!khugepaged_alloc_page(hpage, gfp, node))
> > @@ -2356,3 +2357,118 @@ void khugepaged_min_free_kbytes_update(void)
> >                 set_recommended_min_free_kbytes();
> >         mutex_unlock(&khugepaged_mutex);
> >  }
> > +
> > +static int madvise_collapse_errno(enum scan_result r)
> > +{
> > +       /*
> > +        * MADV_COLLAPSE breaks from existing madvise(2) conventions to provide
> > +        * actionable feedback to caller, so they may take an appropriate
> > +        * fallback measure depending on the nature of the failure.
> > +        */
> > +       switch (r) {
> > +       case SCAN_ALLOC_HUGE_PAGE_FAIL:
> > +               return -ENOMEM;
> > +       case SCAN_CGROUP_CHARGE_FAIL:
> > +               return -EBUSY;
> > +       /* Resource temporary unavailable - trying again might succeed */
> > +       case SCAN_PAGE_LOCK:
> > +       case SCAN_PAGE_LRU:
> > +               return -EAGAIN;
> > +       /*
> > +        * Other: Trying again likely not to succeed / error intrinsic to
> > +        * specified memory range. khugepaged likely won't be able to collapse
> > +        * either.
> > +        */
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
> > +                    unsigned long start, unsigned long end)
> > +{
> > +       struct collapse_control *cc;
> > +       struct mm_struct *mm = vma->vm_mm;
> > +       unsigned long hstart, hend, addr;
> > +       int thps = 0, last_fail = SCAN_FAIL;
> > +       bool mmap_locked = true;
> > +
> > +       BUG_ON(vma->vm_start > start);
> > +       BUG_ON(vma->vm_end < end);
> > +
> > +       cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> > +       if (!cc)
> > +               return -ENOMEM;
> > +       cc->is_khugepaged = false;
> > +       cc->last_target_node = NUMA_NO_NODE;
> > +
> > +       *prev = vma;
> > +
> > +       /* TODO: Support file/shmem */
> > +       if (!vma->anon_vma || !vma_is_anonymous(vma))
> > +               return -EINVAL;
> > +
> > +       hstart = (start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
> > +       hend = end & HPAGE_PMD_MASK;
> > +
> > +       if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
> > +               return -EINVAL;
> > +
> > +       mmgrab(mm);
> > +       lru_add_drain_all();
> > +
> > +       for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
> > +               int result = SCAN_FAIL;
> > +
> > +               if (!mmap_locked) {
> > +                       cond_resched();
> > +                       mmap_read_lock(mm);
> > +                       mmap_locked = true;
> > +                       result = hugepage_vma_revalidate(mm, addr, &vma, cc);
> > +                       if (result  != SCAN_SUCCEED) {
> > +                               last_fail = result;
> > +                               goto out_nolock;
> > +                       }
> > +               }
> > +               mmap_assert_locked(mm);
> > +               memset(cc->node_load, 0, sizeof(cc->node_load));
> > +               result = khugepaged_scan_pmd(mm, vma, addr, &mmap_locked, cc);
> > +               if (!mmap_locked)
> > +                       *prev = NULL;  /* Tell caller we dropped mmap_lock */
> > +
> > +               switch (result) {
> > +               case SCAN_SUCCEED:
> > +               case SCAN_PMD_MAPPED:
> > +                       ++thps;
> > +                       break;
> > +               /* Whitelisted set of results where continuing OK */
> > +               case SCAN_PMD_NULL:
> > +               case SCAN_PTE_NON_PRESENT:
> > +               case SCAN_PTE_UFFD_WP:
> > +               case SCAN_PAGE_RO:
> > +               case SCAN_LACK_REFERENCED_PAGE:
> > +               case SCAN_PAGE_NULL:
> > +               case SCAN_PAGE_COUNT:
> > +               case SCAN_PAGE_LOCK:
> > +               case SCAN_PAGE_COMPOUND:
> > +               case SCAN_PAGE_LRU:
> > +                       last_fail = result;
> > +                       break;
> > +               default:
> > +                       last_fail = result;
> > +                       /* Other error, exit */
> > +                       goto out_maybelock;
> > +               }
> > +       }
> > +
> > +out_maybelock:
> > +       /* Caller expects us to hold mmap_lock on return */
> > +       if (!mmap_locked)
> > +               mmap_read_lock(mm);
> > +out_nolock:
> > +       mmap_assert_locked(mm);
> > +       mmdrop(mm);
> > +
> > +       return thps == ((hend - hstart) >> HPAGE_PMD_SHIFT) ? 0
> > +                       : madvise_collapse_errno(last_fail);
> > +}
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 851fa4e134bc..9f08e958ea86 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -59,6 +59,7 @@ static int madvise_need_mmap_write(int behavior)
> >         case MADV_FREE:
> >         case MADV_POPULATE_READ:
> >         case MADV_POPULATE_WRITE:
> > +       case MADV_COLLAPSE:
> >                 return 0;
> >         default:
> >                 /* be safe, default to 1. list exceptions explicitly */
> > @@ -1057,6 +1058,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> >                 if (error)
> >                         goto out;
> >                 break;
> > +       case MADV_COLLAPSE:
> > +               return madvise_collapse(vma, prev, start, end);
> >         }
> >
> >         anon_name = anon_vma_name(vma);
> > @@ -1150,6 +1153,7 @@ madvise_behavior_valid(int behavior)
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >         case MADV_HUGEPAGE:
> >         case MADV_NOHUGEPAGE:
> > +       case MADV_COLLAPSE:
> >  #endif
> >         case MADV_DONTDUMP:
> >         case MADV_DODUMP:
> > @@ -1339,6 +1343,7 @@ int madvise_set_anon_name(struct mm_struct *mm, unsigned long start,
> >   *  MADV_NOHUGEPAGE - mark the given range as not worth being backed by
> >   *             transparent huge pages so the existing pages will not be
> >   *             coalesced into THP and new pages will not be allocated as THP.
> > + *  MADV_COLLAPSE - synchronously coalesce pages into new THP.
> >   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> >   *             from being included in its core dump.
> >   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> > diff --git a/tools/include/uapi/asm-generic/mman-common.h b/tools/include/uapi/asm-generic/mman-common.h
> > index 6c1aa92a92e4..6ce1f1ceb432 100644
> > --- a/tools/include/uapi/asm-generic/mman-common.h
> > +++ b/tools/include/uapi/asm-generic/mman-common.h
> > @@ -77,6 +77,8 @@
> >
> >  #define MADV_DONTNEED_LOCKED   24      /* like DONTNEED, but drop locked pages too */
> >
> > +#define MADV_COLLAPSE  25              /* Synchronous hugepage collapse */
> > +
> >  /* compatibility flags */
> >  #define MAP_FILE       0
> >
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
