Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004764BF61
	for <lists+linux-api@lfdr.de>; Wed, 19 Jun 2019 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbfFSRNo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 19 Jun 2019 13:13:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45742 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfFSRNn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 19 Jun 2019 13:13:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id s21so9270pga.12
        for <linux-api@vger.kernel.org>; Wed, 19 Jun 2019 10:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i/XO8+coA/r/SHBk8LHH1LUnKstUAXiUn5vgC6NvJ2Q=;
        b=iJHowDYD8LB5Iu89K82MJbUWWOB2ufu41TdYfF1Tk4N3jN/VT2k11eanh1H64X1/d3
         F4OYORNleDxOD0NwPLXRHs3xqWHnuFbIhr2TuTkG/2W7dVMQeYXt12TqKqgaIjHNrG4b
         k4KjgAZhE/ZFsWOl4mlTYHcB85NQUS+pMsxsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i/XO8+coA/r/SHBk8LHH1LUnKstUAXiUn5vgC6NvJ2Q=;
        b=Z+m9TxXxAHlqhaB6kFBjCRvnBRY4QRR+UWrBmKjCIbZ+dPB1ZmS4VdweG0yH8Ci2Oj
         +di9EnJcgHdB8s++70JlgmaT1qOkxM1Cl09EEsYmlGGOpCe9keCL/RGwaZigO57yKEw1
         wNbZw/tP5SgzpIUsNHAs4s32FZmspw5Zth7+ffi44jpjeiwxNcGavvRcAeB+i5MAZHoa
         E7diCKx0IX0moQZtIzsQBJBqEOgiv8We/9pwbOVT9kELIWTIHXWul3rn05NVQlQOQDw+
         +bKHv/KvEwMenFXWO+WbU63atd8IUIOGt6nUByI2rQXdqol8j8ysiQc7uTXxLIC6oOSQ
         4bcw==
X-Gm-Message-State: APjAAAWeMgLOd1UwsSzrVJIN3r363PhIWFfdGSQ8euu6nktFn5utvJXl
        hlAHXq8iPDlQQabj7yBQfwaZBA==
X-Google-Smtp-Source: APXvYqwKbCh7io7tJRH404WvEPHYj72OEzcU6yS3DtjjVHI50SmQeLIp5r07bWlQGhHUfSSoKvwwZw==
X-Received: by 2002:a17:90a:30e4:: with SMTP id h91mr11762146pjb.37.1560964422757;
        Wed, 19 Jun 2019 10:13:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id d132sm20580100pfd.61.2019.06.19.10.13.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 10:13:41 -0700 (PDT)
Date:   Wed, 19 Jun 2019 13:13:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH v1 1/4] mm: introduce MADV_COLD
Message-ID: <20190619171340.GA83620@google.com>
References: <20190603053655.127730-1-minchan@kernel.org>
 <20190603053655.127730-2-minchan@kernel.org>
 <20190604203841.GC228607@google.com>
 <20190610100904.GC55602@google.com>
 <20190612172104.GA125771@google.com>
 <20190613044824.GF55602@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613044824.GF55602@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sorry Minchan for late reply, I had a visa interview travel and then the weekend
came. I replied below:

On Thu, Jun 13, 2019 at 01:48:24PM +0900, Minchan Kim wrote:
> On Wed, Jun 12, 2019 at 01:21:04PM -0400, Joel Fernandes wrote:
> > On Mon, Jun 10, 2019 at 07:09:04PM +0900, Minchan Kim wrote:
> > > Hi Joel,
> > > 
> > > On Tue, Jun 04, 2019 at 04:38:41PM -0400, Joel Fernandes wrote:
> > > > On Mon, Jun 03, 2019 at 02:36:52PM +0900, Minchan Kim wrote:
> > > > > When a process expects no accesses to a certain memory range, it could
> > > > > give a hint to kernel that the pages can be reclaimed when memory pressure
> > > > > happens but data should be preserved for future use.  This could reduce
> > > > > workingset eviction so it ends up increasing performance.
> > > > > 
> > > > > This patch introduces the new MADV_COLD hint to madvise(2) syscall.
> > > > > MADV_COLD can be used by a process to mark a memory range as not expected
> > > > > to be used in the near future. The hint can help kernel in deciding which
> > > > > pages to evict early during memory pressure.
> > > > > 
> > > > > It works for every LRU pages like MADV_[DONTNEED|FREE]. IOW, It moves
> > > > > 
> > > > > 	active file page -> inactive file LRU
> > > > > 	active anon page -> inacdtive anon LRU
> > > > > 
> > > > > Unlike MADV_FREE, it doesn't move active anonymous pages to inactive
> > > > > files's head because MADV_COLD is a little bit different symantic.
> > > > > MADV_FREE means it's okay to discard when the memory pressure because
> > > > > the content of the page is *garbage* so freeing such pages is almost zero
> > > > > overhead since we don't need to swap out and access afterward causes just
> > > > > minor fault. Thus, it would make sense to put those freeable pages in
> > > > > inactive file LRU to compete other used-once pages. Even, it could
> > > > > give a bonus to make them be reclaimed on swapless system. However,
> > > > > MADV_COLD doesn't mean garbage so reclaiming them requires swap-out/in
> > > > > in the end. So it's better to move inactive anon's LRU list, not file LRU.
> > > > > Furthermore, it would help to avoid unnecessary scanning of cold anonymous
> > > > > if system doesn't have a swap device.
> > > > > 
> > > > > All of error rule is same with MADV_DONTNEED.
> > > > > 
> > > > > Note:
> > > > > This hint works with only private pages(IOW, page_mapcount(page) < 2)
> > > > > because shared page could have more chance to be accessed from other
> > > > > processes sharing the page although the caller reset the reference bits.
> > > > > It ends up preventing the reclaim of the page and wastes CPU cycle.
> > > > > 
> > > > > * RFCv2
> > > > >  * add more description - mhocko
> > > > > 
> > > > > * RFCv1
> > > > >  * renaming from MADV_COOL to MADV_COLD - hannes
> > > > > 
> > > > > * internal review
> > > > >  * use clear_page_youn in deactivate_page - joelaf
> > > > >  * Revise the description - surenb
> > > > >  * Renaming from MADV_WARM to MADV_COOL - surenb
> > > > > 
> > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > ---
> > > > >  include/linux/page-flags.h             |   1 +
> > > > >  include/linux/page_idle.h              |  15 ++++
> > > > >  include/linux/swap.h                   |   1 +
> > > > >  include/uapi/asm-generic/mman-common.h |   1 +
> > > > >  mm/internal.h                          |   2 +-
> > > > >  mm/madvise.c                           | 115 ++++++++++++++++++++++++-
> > > > >  mm/oom_kill.c                          |   2 +-
> > > > >  mm/swap.c                              |  43 +++++++++
> > > > >  8 files changed, 176 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > > > > index 9f8712a4b1a5..58b06654c8dd 100644
> > > > > --- a/include/linux/page-flags.h
> > > > > +++ b/include/linux/page-flags.h
> > > > > @@ -424,6 +424,7 @@ static inline bool set_hwpoison_free_buddy_page(struct page *page)
> > > > >  TESTPAGEFLAG(Young, young, PF_ANY)
> > > > >  SETPAGEFLAG(Young, young, PF_ANY)
> > > > >  TESTCLEARFLAG(Young, young, PF_ANY)
> > > > > +CLEARPAGEFLAG(Young, young, PF_ANY)
> > > > >  PAGEFLAG(Idle, idle, PF_ANY)
> > > > >  #endif
> > > > >  
> > > > > diff --git a/include/linux/page_idle.h b/include/linux/page_idle.h
> > > > > index 1e894d34bdce..f3f43b317150 100644
> > > > > --- a/include/linux/page_idle.h
> > > > > +++ b/include/linux/page_idle.h
> > > > > @@ -19,6 +19,11 @@ static inline void set_page_young(struct page *page)
> > > > >  	SetPageYoung(page);
> > > > >  }
> > > > >  
> > > > > +static inline void clear_page_young(struct page *page)
> > > > > +{
> > > > > +	ClearPageYoung(page);
> > > > > +}
> > > > > +
> > > > >  static inline bool test_and_clear_page_young(struct page *page)
> > > > >  {
> > > > >  	return TestClearPageYoung(page);
> > > > > @@ -65,6 +70,16 @@ static inline void set_page_young(struct page *page)
> > > > >  	set_bit(PAGE_EXT_YOUNG, &page_ext->flags);
> > > > >  }
> > > > >  
> > > > > +static void clear_page_young(struct page *page)
> > > > > +{
> > > > > +	struct page_ext *page_ext = lookup_page_ext(page);
> > > > > +
> > > > > +	if (unlikely(!page_ext))
> > > > > +		return;
> > > > > +
> > > > > +	clear_bit(PAGE_EXT_YOUNG, &page_ext->flags);
> > > > > +}
> > > > > +
> > > > >  static inline bool test_and_clear_page_young(struct page *page)
> > > > >  {
> > > > >  	struct page_ext *page_ext = lookup_page_ext(page);
> > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > index de2c67a33b7e..0ce997edb8bb 100644
> > > > > --- a/include/linux/swap.h
> > > > > +++ b/include/linux/swap.h
> > > > > @@ -340,6 +340,7 @@ extern void lru_add_drain_cpu(int cpu);
> > > > >  extern void lru_add_drain_all(void);
> > > > >  extern void rotate_reclaimable_page(struct page *page);
> > > > >  extern void deactivate_file_page(struct page *page);
> > > > > +extern void deactivate_page(struct page *page);
> > > > >  extern void mark_page_lazyfree(struct page *page);
> > > > >  extern void swap_setup(void);
> > > > >  
> > > > > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> > > > > index bea0278f65ab..1190f4e7f7b9 100644
> > > > > --- a/include/uapi/asm-generic/mman-common.h
> > > > > +++ b/include/uapi/asm-generic/mman-common.h
> > > > > @@ -43,6 +43,7 @@
> > > > >  #define MADV_SEQUENTIAL	2		/* expect sequential page references */
> > > > >  #define MADV_WILLNEED	3		/* will need these pages */
> > > > >  #define MADV_DONTNEED	4		/* don't need these pages */
> > > > > +#define MADV_COLD	5		/* deactivatie these pages */
> > > > >  
> > > > >  /* common parameters: try to keep these consistent across architectures */
> > > > >  #define MADV_FREE	8		/* free pages only if memory pressure */
> > > > > diff --git a/mm/internal.h b/mm/internal.h
> > > > > index 9eeaf2b95166..75a4f96ec0fb 100644
> > > > > --- a/mm/internal.h
> > > > > +++ b/mm/internal.h
> > > > > @@ -43,7 +43,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
> > > > >  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
> > > > >  		unsigned long floor, unsigned long ceiling);
> > > > >  
> > > > > -static inline bool can_madv_dontneed_vma(struct vm_area_struct *vma)
> > > > > +static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
> > > > >  {
> > > > >  	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
> > > > >  }
> > > > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > > > index 628022e674a7..ab158766858a 100644
> > > > > --- a/mm/madvise.c
> > > > > +++ b/mm/madvise.c
> > > > > @@ -40,6 +40,7 @@ static int madvise_need_mmap_write(int behavior)
> > > > >  	case MADV_REMOVE:
> > > > >  	case MADV_WILLNEED:
> > > > >  	case MADV_DONTNEED:
> > > > > +	case MADV_COLD:
> > > > >  	case MADV_FREE:
> > > > >  		return 0;
> > > > >  	default:
> > > > > @@ -307,6 +308,113 @@ static long madvise_willneed(struct vm_area_struct *vma,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static int madvise_cold_pte_range(pmd_t *pmd, unsigned long addr,
> > > > > +				unsigned long end, struct mm_walk *walk)
> > > > > +{
> > > > > +	pte_t *orig_pte, *pte, ptent;
> > > > > +	spinlock_t *ptl;
> > > > > +	struct page *page;
> > > > > +	struct vm_area_struct *vma = walk->vma;
> > > > > +	unsigned long next;
> > > > > +
> > > > > +	next = pmd_addr_end(addr, end);
> > > > > +	if (pmd_trans_huge(*pmd)) {
> > > > > +		ptl = pmd_trans_huge_lock(pmd, vma);
> > > > > +		if (!ptl)
> > > > > +			return 0;
> > > > > +
> > > > > +		if (is_huge_zero_pmd(*pmd))
> > > > > +			goto huge_unlock;
> > > > > +
> > > > > +		page = pmd_page(*pmd);
> > > > > +		if (page_mapcount(page) > 1)
> > > > > +			goto huge_unlock;
> > > > > +
> > > > > +		if (next - addr != HPAGE_PMD_SIZE) {
> > > > > +			int err;
> > > > > +
> > > > > +			get_page(page);
> > > > > +			spin_unlock(ptl);
> > > > > +			lock_page(page);
> > > > > +			err = split_huge_page(page);
> > > > > +			unlock_page(page);
> > > > > +			put_page(page);
> > > > > +			if (!err)
> > > > > +				goto regular_page;
> > > > > +			return 0;
> > > > > +		}
> > > > > +
> > > > > +		pmdp_test_and_clear_young(vma, addr, pmd);
> > > > > +		deactivate_page(page);
> > > > > +huge_unlock:
> > > > > +		spin_unlock(ptl);
> > > > > +		return 0;
> > > > > +	}
> > > > > +
> > > > > +	if (pmd_trans_unstable(pmd))
> > > > > +		return 0;
> > > > > +
> > > > > +regular_page:
> > > > > +	orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > > > > +	for (pte = orig_pte; addr < end; pte++, addr += PAGE_SIZE) {
> > > > > +		ptent = *pte;
> > > > > +
> > > > > +		if (pte_none(ptent))
> > > > > +			continue;
> > > > > +
> > > > > +		if (!pte_present(ptent))
> > > > > +			continue;
> > > > > +
> > > > > +		page = vm_normal_page(vma, addr, ptent);
> > > > > +		if (!page)
> > > > > +			continue;
> > > > > +
> > > > > +		if (page_mapcount(page) > 1)
> > > > > +			continue;
> > > > > +
> > > > > +		ptep_test_and_clear_young(vma, addr, pte);
> > > > 
> > > > Wondering here how it interacts with idle page tracking. Here since young
> > > > flag is cleared by the cold hint, page_referenced_one() or
> > > > page_idle_clear_pte_refs_one() will not be able to clear the page-idle flag
> > > > if it was previously set since it does not know any more that a page was
> > > > actively referenced.
> > > 
> > > ptep_test_and_clear_young doesn't change PG_idle/young so idle page tracking
> > > doesn't affect.
> 
> You said *young flag* in the comment, which made me confused. I thought you meant
> PG_young flag but you mean PTE access bit.
> 
> > 
> > Clearing of the young bit in the PTE does affect idle tracking.
> > 
> > Both page_referenced_one() and page_idle_clear_pte_refs_one() check this bit.
> > 
> > > > bit was previously set, just so that page-idle tracking works smoothly when
> > > > this hint is concurrently applied?
> > > 
> > > deactivate_page will remove PG_young bit so that the page will be reclaimed.
> > > Do I miss your point?
> > 
> > Say a process had accessed PTE bit not set, then idle tracking is run and PG_Idle
> > is set. Now the page is accessed from userspace thus setting the accessed PTE
> > bit.  Now a remote process passes this process_madvise cold hint (I know your
> > current series does not support remote process, but I am saying for future
> > when you post this). Because you cleared the PTE accessed bit through the
> > hint, idle tracking no longer will know that the page is referenced and the
> > user gets confused because accessed page appears to be idle.
> 
> Right.
> 
> > 
> > I think to fix this, what you should do is clear the PG_Idle flag if the
> > young/accessed PTE bits are set. If PG_Idle is already cleared, then you
> > don't need to do anything.
> 
> I'm not sure. What does it make MADV_COLD special?
> How about MADV_FREE|MADV_DONTNEED?
> Why don't they clear PG_Idle if pte was young at tearing down pte? 

Good point, so it sounds like those (MADV_FREE|MADV_DONTNEED) also need to be fixed then?

> The page could be shared by other processes so if we miss to clear out
> PG_idle in there, page idle tracking could miss the access history forever.

I did not understand this. So say a page X is shared process P and Q and
assume the PG_idle flag is set on the page.

P accesses memory and has the pte accessed bit set. P now gets the MADV_COLD
hint and forgets to clear the idle flag while clearing the pte accessed bit.

Now the page appears to be idle, even though it was not. This has nothing to
do with Q and whether the page is shared or not.

> If it's not what you want, maybe we need to fix all places all at once.
> However, I'm not sure. Rather than, I want to keep PG_idle in those hints
> even though pte was accesssed because the process now gives strong hint
> "The page is idle from now on". It's valid because he knows himself better than
> others, even admin. IOW, he declare the page is not workingset any more.

Even if the PG_idle flag is not cleared - it is not a strong hint for working
set size IMHO, because the page *was* accessed so the process definitely needed the
page at some point even though now it says it is MADV_COLD. So that is part
of working set. I don't think we should implicitly provide such hints and we
should fix it.

Also I was saying in previous email, if process_madvise (future extension) is
called from say activity manager, then the process and the user running the
idle tracking feature has no idea that the page was accessed because the idle
flag is still set. That is a bit weird and is loss of information.

It may not be a big deal in the long run if the page is accessed a lot, since
the PTE accessed bit will be set again and idle-tracking feature may not miss
it, but why leave it to chance if it is a simple fix?

> What's the problem if page idle tracking feature miss it?

What's the problem if PG_idle flag is cleared here? It is just a software
flag.

> If other processs still have access bit of their pte for the page, page idle
> tracking could find the page as non-idle so it's no problem, either.

Yes, but if the other process also does not access the page, then the access
information is lost.

thanks!

 - Joel

