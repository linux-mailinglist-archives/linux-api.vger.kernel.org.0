Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA2A5EB03C
	for <lists+linux-api@lfdr.de>; Mon, 26 Sep 2022 20:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiIZSlW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Sep 2022 14:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiIZSky (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Sep 2022 14:40:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A489712AF1
        for <linux-api@vger.kernel.org>; Mon, 26 Sep 2022 11:40:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v4so7316481pgi.10
        for <linux-api@vger.kernel.org>; Mon, 26 Sep 2022 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PJBSyI8naYpvY03OnBbdIewGNHGjGyHD9ykkjmjkqAg=;
        b=VJz+XT/aic3cDOg98Pw1GSogpUZznnW7qTY6UTa90i+Htg4ZR0trJwdiaJwBMREjQV
         nBtXe39GWaGKJKMGPhI5iyRHtsZjcGyf+/R3NMOj9b16MHdQ9/ZeSScZRdyf8wyKE1Ha
         v/hNfTSIoRDrz6zrMmYCHLHKU9BHl/FW2J5zAwFJz+luKEs+uLof7xwYGHuw/E+APFMW
         Dem17igdN1xkP+nLylTAxW0I+BGNisFxRSFqd36t0/iux6wNUVvWWryQyPPrj4GKwS8+
         9txyAkz8+PFXc4lpN0KQgztd9Nmj81IBXGG3I499d5NGhPwHjCPFIBXnueowygI6fyCi
         /Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PJBSyI8naYpvY03OnBbdIewGNHGjGyHD9ykkjmjkqAg=;
        b=2ixDMC1zV6C+nN63Hl/i7+7S07CH+pCDrTl5BhVyBGoJJ+bU3IhLa9Wr4PLpdv+NKN
         9nVFYuy+idMva/C4WRe6FnMmcpU+hBn9k6YZKw0nzinB9FlaVWs2v9s2fbmj2wYMKua7
         64VOdDJzondqK3DcHr+U7UYlPRfPMZ9vE8fXNeTtxV0bRBMuVQ3b+tifGXMKEmO40giV
         9SttupMymHX8+EIe6UIILgYzzcvduSiT0tKbKlOzce2tiKBaTqm9Ackiqetf6mSGTQax
         yMRZoLvtYPkPv/jKw0KbsGjwPANMxchn5wW1EDllvc8ibkqJA5ffxNA5cuJ4/PAzedkB
         wP9A==
X-Gm-Message-State: ACrzQf2avftnsXdAlUR0yysHbPg2hTiK/KcinXe0XTm/eBCDR5zAz42k
        jelmZeqcyNfzKsxB6kszG7Z9g48p0OzZ6Dtgj6M=
X-Google-Smtp-Source: AMsMyM7rC25xL2IEBT4pdj/SK/PXoFj8TcD3jjdnhP+rtOCS1IZbBkKR3tUrUXU4u3Syejz+wuamRzck8f7Fu602uHY=
X-Received: by 2002:a63:e417:0:b0:43c:2fc6:d60c with SMTP id
 a23-20020a63e417000000b0043c2fc6d60cmr17965667pgi.436.1664217583973; Mon, 26
 Sep 2022 11:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com> <20220922224046.1143204-4-zokeefe@google.com>
In-Reply-To: <20220922224046.1143204-4-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 26 Sep 2022 11:39:31 -0700
Message-ID: <CAHbLzkrL4T_kBG3VgxYgoiHkpe0eqkJvmmGKt9swy39c6MMCrw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v4 03/10] mm/madvise: add file and shmem
 support to MADV_COLLAPSE
To:     "Zach O'Keefe" <zokeefe@google.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 22, 2022 at 3:40 PM Zach O'Keefe <zokeefe@google.com> wrote:
>
> Add support for MADV_COLLAPSE to collapse shmem-backed and file-backed
> memory into THPs (requires CONFIG_READ_ONLY_THP_FOR_FS=y).
>
> On success, the backing memory will be a hugepage.  For the memory range
> and process provided, the page tables will synchronously have a huge pmd
> installed, mapping the THP.  Other mappings of the file extent mapped by
> the memory range may be added to a set of entries that khugepaged will
> later process and attempt update their page tables to map the THP by a
> pmd.
>
> This functionality unlocks two important uses:
>
> (1)     Immediately back executable text by THPs.  Current support provided
>         by CONFIG_READ_ONLY_THP_FOR_FS may take a long time on a large
>         system which might impair services from serving at their full rated
>         load after (re)starting.  Tricks like mremap(2)'ing text onto
>         anonymous memory to immediately realize iTLB performance prevents
>         page sharing and demand paging, both of which increase steady state
>         memory footprint.  Now, we can have the best of both worlds: Peak
>         upfront performance and lower RAM footprints.
>
> (2)     userfaultfd-based live migration of virtual machines satisfy UFFD
>         faults by fetching native-sized pages over the network (to avoid
>         latency of transferring an entire hugepage).  However, after guest
>         memory has been fully copied to the new host, MADV_COLLAPSE can
>         be used to immediately increase guest performance.
>
> Since khugepaged is single threaded, this change now introduces
> possibility of collapse contexts racing in file collapse path.  There a
> important few places to consider:
>
> (1)     hpage_collapse_scan_file(), when we xas_pause() and drop RCU.
>         We could have the memory collapsed out from under us, but
>         the next xas_for_each() iteration will correctly pick up the
>         hugepage.  The hugepage might not be up to date (insofar as
>         copying of small page contents might not have completed - the
>         page still may be locked), but regardless what small page index
>         we were iterating over, we'll find the hugepage and identify it
>         as a suitably aligned compound page of order HPAGE_PMD_ORDER.
>
>         In khugepaged path, we locklessly check the value of the pmd,
>         and only add it to deferred collapse array if we find pmd
>         mapping pte table. This is fine, since other values that could
>         have raced in right afterwards denote failure, or that the
>         memory was successfully collapsed, so we don't need further
>         processing.
>
>         In madvise path, we'll take mmap_lock() in write to serialize
>         against page table updates and will know what to do based on the
>         true value of the pmd: recheck all ptes if we point to a pte table,
>         directly install the pmd, if the pmd has been cleared, but
>         memory not yet faulted, or nothing at all if we find a huge pmd.
>
>         It's worth putting emphasis here on how we treat the none pmd
>         here.  If khugepaged has processed this mm's page tables
>         already, it will have left the pmd cleared (ready for refault by
>         the process).  Depending on the VMA flags and sysfs settings,
>         amount of RAM on the machine, and the current load, could be a
>         relatively common occurrence - and as such is one we'd like to
>         handle successfully in MADV_COLLAPSE.  When we see the none pmd
>         in collapse_pte_mapped_thp(), we've locked mmap_lock in write
>         and checked (a) huepaged_vma_check() to see if the backing
>         memory is appropriate still, along with VMA sizing and
>         appropriate hugepage alignment within the file, and (b) we've
>         found a hugepage head of order HPAGE_PMD_ORDER at the offset
>         in the file mapped by our hugepage-aligned virtual address.
>         Even though the common-case is likely race with khugepaged,
>         given these checks (regardless how we got here - we could be
>         operating on a completely different file than originally checked
>         in hpage_collapse_scan_file() for all we know) it should be safe
>         to directly make the pmd a huge pmd pointing to this hugepage.
>
> (2)     collapse_file() is mostly serialized on the same file extent by
>         lock sequence:
>
>                 |       lock hupepage
>                 |               lock mapping->i_pages
>                 |                       lock 1st page
>                 |               unlock mapping->i_pages
>                 |                               <page checks>
>                 |               lock mapping->i_pages
>                 |                               page_ref_freeze(3)
>                 |                               xas_store(hugepage)
>                 |               unlock mapping->i_pages
>                 |                               page_ref_unfreeze(1)
>                 |                       unlock 1st page
>                 V       unlock hugepage
>
>         Once a context (who already has their fresh hugepage locked)
>         locks mapping->i_pages exclusively, it will hold said lock
>         until it locks the first page, and it will hold that lock until
>         the after the hugepage has been added to the page cache (and
>         will unlock the hugepage after page table update, though that
>         isn't important here).
>
>         A racing context that loses the race for mapping->i_pages will
>         then lose the race to locking the first page.  Here - depending
>         on how far the other racing context has gotten - we might find
>         the new hugepage (in which case we'll exit cleanly when we
>         check PageTransCompound()), or we'll find the "old" 1st small
>         page (in which we'll exit cleanly when we discover unexpected
>         refcount of 2 after isolate_lru_page()).  This is assuming we
>         are able to successfully lock the page we find - in shmem path,
>         we could just fail the trylock and exit cleanly anyways.
>
>         Failure path in collapse_file() is similar: once we hold lock
>         on 1st small page, we are serialized against other collapse
>         contexts.  Before the 1st small page is unlocked, we add it
>         back to the pagecache and unfreeze the refcount appropriately.
>         Contexts who lost the race to the 1st small page will then find
>         the same 1st small page with the correct refcount and will be
>         able to proceed.
>
> [shy828301@gmail.com: Delete hugepage_vma_revalidate_anon(), remove
>         check for multi-add in khugepaged_add_pte_mapped_thp()]
>   Link: https://lore.kernel.org/linux-mm/CAHbLzkrtpM=ic7cYAHcqkubah5VTR8N5=k5RT8MTvv5rN1Y91w@mail.gmail.com/
> Link: https://lkml.kernel.org/r/20220907144521.3115321-4-zokeefe@google.com
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>
> Cc: Axel Rasmussen <axelrasmussen@google.com>
> Cc: Chris Kennelly <ckennelly@google.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: James Houghton <jthoughton@google.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Rongwei Wang <rongwei.wang@linux.alibaba.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  include/linux/khugepaged.h         |  13 +-
>  include/trace/events/huge_memory.h |   1 +
>  kernel/events/uprobes.c            |   2 +-
>  mm/khugepaged.c                    | 245 ++++++++++++++++++++++-------
>  4 files changed, 199 insertions(+), 62 deletions(-)
>
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index 384f034ae947..70162d707caf 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -16,11 +16,13 @@ extern void khugepaged_enter_vma(struct vm_area_struct *vma,
>                                  unsigned long vm_flags);
>  extern void khugepaged_min_free_kbytes_update(void);
>  #ifdef CONFIG_SHMEM
> -extern void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr);
> +extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> +                                  bool install_pmd);
>  #else
> -static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
> -                                          unsigned long addr)
> +static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
> +                                         unsigned long addr, bool install_pmd)
>  {
> +       return 0;
>  }
>  #endif
>
> @@ -46,9 +48,10 @@ static inline void khugepaged_enter_vma(struct vm_area_struct *vma,
>                                         unsigned long vm_flags)
>  {
>  }
> -static inline void collapse_pte_mapped_thp(struct mm_struct *mm,
> -                                          unsigned long addr)
> +static inline int collapse_pte_mapped_thp(struct mm_struct *mm,
> +                                         unsigned long addr, bool install_pmd)
>  {
> +       return 0;
>  }
>
>  static inline void khugepaged_min_free_kbytes_update(void)
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index fbbb25494d60..df33453b70fc 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -11,6 +11,7 @@
>         EM( SCAN_FAIL,                  "failed")                       \
>         EM( SCAN_SUCCEED,               "succeeded")                    \
>         EM( SCAN_PMD_NULL,              "pmd_null")                     \
> +       EM( SCAN_PMD_NONE,              "pmd_none")                     \
>         EM( SCAN_PMD_MAPPED,            "page_pmd_mapped")              \
>         EM( SCAN_EXCEED_NONE_PTE,       "exceed_none_pte")              \
>         EM( SCAN_EXCEED_SWAP_PTE,       "exceed_swap_pte")              \
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index e0a9b945e7bc..d9e357b7e17c 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -555,7 +555,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>
>         /* try collapse pmd for compound page */
>         if (!ret && orig_page_huge)
> -               collapse_pte_mapped_thp(mm, vaddr);
> +               collapse_pte_mapped_thp(mm, vaddr, false);
>
>         return ret;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b1e3f83c4eb2..a272fc065dd7 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -29,6 +29,7 @@ enum scan_result {
>         SCAN_FAIL,
>         SCAN_SUCCEED,
>         SCAN_PMD_NULL,
> +       SCAN_PMD_NONE,
>         SCAN_PMD_MAPPED,
>         SCAN_EXCEED_NONE_PTE,
>         SCAN_EXCEED_SWAP_PTE,
> @@ -821,6 +822,7 @@ static bool hpage_collapse_alloc_page(struct page **hpage, gfp_t gfp, int node)
>   */
>
>  static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
> +                                  bool expect_anon,
>                                    struct vm_area_struct **vmap,
>                                    struct collapse_control *cc)
>  {
> @@ -845,8 +847,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>          * hugepage_vma_check may return true for qualified file
>          * vmas.
>          */
> -       if (!vma->anon_vma || !vma_is_anonymous(vma))
> -               return SCAN_VMA_CHECK;
> +       if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
> +               return SCAN_PAGE_ANON;
>         return SCAN_SUCCEED;
>  }
>
> @@ -866,8 +868,8 @@ static int find_pmd_or_thp_or_none(struct mm_struct *mm,
>         /* See comments in pmd_none_or_trans_huge_or_clear_bad() */
>         barrier();
>  #endif
> -       if (!pmd_present(pmde))
> -               return SCAN_PMD_NULL;
> +       if (pmd_none(pmde))
> +               return SCAN_PMD_NONE;
>         if (pmd_trans_huge(pmde))
>                 return SCAN_PMD_MAPPED;
>         if (pmd_bad(pmde))
> @@ -995,7 +997,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>                 goto out_nolock;
>
>         mmap_read_lock(mm);
> -       result = hugepage_vma_revalidate(mm, address, &vma, cc);
> +       result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>         if (result != SCAN_SUCCEED) {
>                 mmap_read_unlock(mm);
>                 goto out_nolock;
> @@ -1026,7 +1028,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>          * handled by the anon_vma lock + PG_lock.
>          */
>         mmap_write_lock(mm);
> -       result = hugepage_vma_revalidate(mm, address, &vma, cc);
> +       result = hugepage_vma_revalidate(mm, address, true, &vma, cc);
>         if (result != SCAN_SUCCEED)
>                 goto out_up_write;
>         /* check if the pmd is still valid */
> @@ -1320,6 +1322,26 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>  /*
>   * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
>   * khugepaged should try to collapse the page table.
> + *
> + * Note that following race exists:
> + * (1) khugepaged calls khugepaged_collapse_pte_mapped_thps() for mm_struct A,
> + *     emptying the A's ->pte_mapped_thp[] array.
> + * (2) MADV_COLLAPSE collapses some file extent with target mm_struct B, and
> + *     retract_page_tables() finds a VMA in mm_struct A mapping the same extent
> + *     (at virtual address X) and adds an entry (for X) into mm_struct A's
> + *     ->pte-mapped_thp[] array.
> + * (3) khugepaged calls khugepaged_collapse_scan_file() for mm_struct A at X,
> + *     sees a pte-mapped THP (SCAN_PTE_MAPPED_HUGEPAGE) and adds an entry
> + *     (for X) into mm_struct A's ->pte-mapped_thp[] array.
> + * Thus, it's possible the same address is added multiple times for the same
> + * mm_struct.  Should this happen, we'll simply attempt
> + * collapse_pte_mapped_thp() multiple times for the same address, under the same
> + * exclusive mmap_lock, and assuming the first call is successful, subsequent
> + * attempts will return quickly (without grabbing any additional locks) when
> + * a huge pmd is found in find_pmd_or_thp_or_none().  Since this is a cheap
> + * check, and since this is a rare occurrence, the cost of preventing this
> + * "multiple-add" is thought to be more expensive than just handling it, should
> + * it occur.

I do appreciate the thorough comments. It is quite helpful.

>   */
>  static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>                                           unsigned long addr)
> @@ -1341,6 +1363,27 @@ static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>         return ret;
>  }
>
> +/* hpage must be locked, and mmap_lock must be held in write */
> +static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
> +                       pmd_t *pmdp, struct page *hpage)
> +{
> +       struct vm_fault vmf = {
> +               .vma = vma,
> +               .address = addr,
> +               .flags = 0,

It means you are going to install a readonly PMD. It is fine for
readonly fs, but it may be not performant for shmem since the
following write will trigger wp fault then the PMD will be split. So
it should be ok to install writable PMD for shmem.

But anyway this is not a fatal problem, the patch looks good to me.
Reviewed-by: Yang Shi <shy828301@gmail.com>


> +               .pmd = pmdp,
> +       };
> +
> +       VM_BUG_ON(!PageTransHuge(hpage));
> +       mmap_assert_write_locked(vma->vm_mm);
> +
> +       if (do_set_pmd(&vmf, hpage))
> +               return SCAN_FAIL;
> +
> +       get_page(hpage);
> +       return SCAN_SUCCEED;
> +}
> +
>  static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
>                                   unsigned long addr, pmd_t *pmdp)
>  {
> @@ -1362,12 +1405,14 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
>   *
>   * @mm: process address space where collapse happens
>   * @addr: THP collapse address
> + * @install_pmd: If a huge PMD should be installed
>   *
>   * This function checks whether all the PTEs in the PMD are pointing to the
>   * right THP. If so, retract the page table so the THP can refault in with
> - * as pmd-mapped.
> + * as pmd-mapped. Possibly install a huge PMD mapping the THP.
>   */
> -void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
> +int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> +                           bool install_pmd)
>  {
>         unsigned long haddr = addr & HPAGE_PMD_MASK;
>         struct vm_area_struct *vma = vma_lookup(mm, haddr);
> @@ -1380,14 +1425,14 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>
>         mmap_assert_write_locked(mm);
>
> -       /* Fast check before locking page if not PMD mapping PTE table */
> +       /* Fast check before locking page if already PMD-mapped */
>         result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
> -       if (result != SCAN_SUCCEED)
> -               return;
> +       if (result == SCAN_PMD_MAPPED)
> +               return result;
>
>         if (!vma || !vma->vm_file ||
>             !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
> -               return;
> +               return SCAN_VMA_CHECK;
>
>         /*
>          * If we are here, we've succeeded in replacing all the native pages
> @@ -1397,27 +1442,45 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>          * analogously elide sysfs THP settings here.
>          */
>         if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
> -               return;
> +               return SCAN_VMA_CHECK;
>
>         /* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
>         if (userfaultfd_wp(vma))
> -               return;
> +               return SCAN_PTE_UFFD_WP;
>
>         hpage = find_lock_page(vma->vm_file->f_mapping,
>                                linear_page_index(vma, haddr));
>         if (!hpage)
> -               return;
> +               return SCAN_PAGE_NULL;
>
> -       if (!PageHead(hpage))
> +       if (!PageHead(hpage)) {
> +               result = SCAN_FAIL;
>                 goto drop_hpage;
> +       }
>
> -       if (compound_order(hpage) != HPAGE_PMD_ORDER)
> +       if (compound_order(hpage) != HPAGE_PMD_ORDER) {
> +               result = SCAN_PAGE_COMPOUND;
>                 goto drop_hpage;
> +       }
>
>         if (find_pmd_or_thp_or_none(mm, haddr, &pmd) != SCAN_SUCCEED)
> +       result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
> +       switch (result) {
> +       case SCAN_SUCCEED:
> +               break;
> +       case SCAN_PMD_NONE:
> +               /*
> +                * In MADV_COLLAPSE path, possible race with khugepaged where
> +                * all pte entries have been removed and pmd cleared.  If so,
> +                * skip all the pte checks and just update the pmd mapping.
> +                */
> +               goto maybe_install_pmd;
> +       default:
>                 goto drop_hpage;
> +       }
>
>         start_pte = pte_offset_map_lock(mm, pmd, haddr, &ptl);
> +       result = SCAN_FAIL;
>
>         /* step 1: check all mapped PTEs are to the right huge page */
>         for (i = 0, addr = haddr, pte = start_pte;
> @@ -1429,8 +1492,10 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>                         continue;
>
>                 /* page swapped out, abort */
> -               if (!pte_present(*pte))
> +               if (!pte_present(*pte)) {
> +                       result = SCAN_PTE_NON_PRESENT;
>                         goto abort;
> +               }
>
>                 page = vm_normal_page(vma, addr, *pte);
>                 if (WARN_ON_ONCE(page && is_zone_device_page(page)))
> @@ -1465,12 +1530,19 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>                 add_mm_counter(vma->vm_mm, mm_counter_file(hpage), -count);
>         }
>
> -       /* step 4: collapse pmd */
> +       /* step 4: remove pte entries */
>         collapse_and_free_pmd(mm, vma, haddr, pmd);
> +
> +maybe_install_pmd:
> +       /* step 5: install pmd entry */
> +       result = install_pmd
> +                       ? set_huge_pmd(vma, haddr, pmd, hpage)
> +                       : SCAN_SUCCEED;
> +
>  drop_hpage:
>         unlock_page(hpage);
>         put_page(hpage);
> -       return;
> +       return result;
>
>  abort:
>         pte_unmap_unlock(start_pte, ptl);
> @@ -1493,22 +1565,29 @@ static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_sl
>                 goto out;
>
>         for (i = 0; i < mm_slot->nr_pte_mapped_thp; i++)
> -               collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i]);
> +               collapse_pte_mapped_thp(mm, mm_slot->pte_mapped_thp[i], false);
>
>  out:
>         mm_slot->nr_pte_mapped_thp = 0;
>         mmap_write_unlock(mm);
>  }
>
> -static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
> +static int retract_page_tables(struct address_space *mapping, pgoff_t pgoff,
> +                              struct mm_struct *target_mm,
> +                              unsigned long target_addr, struct page *hpage,
> +                              struct collapse_control *cc)
>  {
>         struct vm_area_struct *vma;
> -       struct mm_struct *mm;
> -       unsigned long addr;
> -       pmd_t *pmd;
> +       int target_result = SCAN_FAIL;
>
>         i_mmap_lock_write(mapping);
>         vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
> +               int result = SCAN_FAIL;
> +               struct mm_struct *mm = NULL;
> +               unsigned long addr = 0;
> +               pmd_t *pmd;
> +               bool is_target = false;
> +
>                 /*
>                  * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
>                  * got written to. These VMAs are likely not worth investing
> @@ -1525,24 +1604,34 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>                  * ptl. It has higher chance to recover THP for the VMA, but
>                  * has higher cost too.
>                  */
> -               if (vma->anon_vma)
> -                       continue;
> +               if (vma->anon_vma) {
> +                       result = SCAN_PAGE_ANON;
> +                       goto next;
> +               }
>                 addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
> -               if (addr & ~HPAGE_PMD_MASK)
> -                       continue;
> -               if (vma->vm_end < addr + HPAGE_PMD_SIZE)
> -                       continue;
> +               if (addr & ~HPAGE_PMD_MASK ||
> +                   vma->vm_end < addr + HPAGE_PMD_SIZE) {
> +                       result = SCAN_VMA_CHECK;
> +                       goto next;
> +               }
>                 mm = vma->vm_mm;
> -               if (find_pmd_or_thp_or_none(mm, addr, &pmd) != SCAN_SUCCEED)
> -                       continue;
> +               is_target = mm == target_mm && addr == target_addr;
> +               result = find_pmd_or_thp_or_none(mm, addr, &pmd);
> +               if (result != SCAN_SUCCEED)
> +                       goto next;
>                 /*
>                  * We need exclusive mmap_lock to retract page table.
>                  *
>                  * We use trylock due to lock inversion: we need to acquire
>                  * mmap_lock while holding page lock. Fault path does it in
>                  * reverse order. Trylock is a way to avoid deadlock.
> +                *
> +                * Also, it's not MADV_COLLAPSE's job to collapse other
> +                * mappings - let khugepaged take care of them later.
>                  */
> -               if (mmap_write_trylock(mm)) {
> +               result = SCAN_PTE_MAPPED_HUGEPAGE;
> +               if ((cc->is_khugepaged || is_target) &&
> +                   mmap_write_trylock(mm)) {
>                         /*
>                          * When a vma is registered with uffd-wp, we can't
>                          * recycle the pmd pgtable because there can be pte
> @@ -1551,22 +1640,45 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>                          * it'll always mapped in small page size for uffd-wp
>                          * registered ranges.
>                          */
> -                       if (!hpage_collapse_test_exit(mm) &&
> -                           !userfaultfd_wp(vma))
> -                               collapse_and_free_pmd(mm, vma, addr, pmd);
> +                       if (hpage_collapse_test_exit(mm)) {
> +                               result = SCAN_ANY_PROCESS;
> +                               goto unlock_next;
> +                       }
> +                       if (userfaultfd_wp(vma)) {
> +                               result = SCAN_PTE_UFFD_WP;
> +                               goto unlock_next;
> +                       }
> +                       collapse_and_free_pmd(mm, vma, addr, pmd);
> +                       if (!cc->is_khugepaged && is_target)
> +                               result = set_huge_pmd(vma, addr, pmd, hpage);
> +                       else
> +                               result = SCAN_SUCCEED;
> +
> +unlock_next:
>                         mmap_write_unlock(mm);
> -               } else {
> -                       /* Try again later */
> +                       goto next;
> +               }
> +               /*
> +                * Calling context will handle target mm/addr. Otherwise, let
> +                * khugepaged try again later.
> +                */
> +               if (!is_target) {
>                         khugepaged_add_pte_mapped_thp(mm, addr);
> +                       continue;
>                 }
> +next:
> +               if (is_target)
> +                       target_result = result;
>         }
>         i_mmap_unlock_write(mapping);
> +       return target_result;
>  }
>
>  /**
>   * collapse_file - collapse filemap/tmpfs/shmem pages into huge one.
>   *
>   * @mm: process address space where collapse happens
> + * @addr: virtual collapse start address
>   * @file: file that collapse on
>   * @start: collapse start address
>   * @cc: collapse context and scratchpad
> @@ -1586,8 +1698,9 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
>   *    + restore gaps in the page cache;
>   *    + unlock and free huge page;
>   */
> -static int collapse_file(struct mm_struct *mm, struct file *file,
> -                        pgoff_t start, struct collapse_control *cc)
> +static int collapse_file(struct mm_struct *mm, unsigned long addr,
> +                        struct file *file, pgoff_t start,
> +                        struct collapse_control *cc)
>  {
>         struct address_space *mapping = file->f_mapping;
>         struct page *hpage;
> @@ -1895,7 +2008,8 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
>                 /*
>                  * Remove pte page tables, so we can re-fault the page as huge.
>                  */
> -               retract_page_tables(mapping, start);
> +               result = retract_page_tables(mapping, start, mm, addr, hpage,
> +                                            cc);
>                 unlock_page(hpage);
>                 hpage = NULL;
>         } else {
> @@ -1951,8 +2065,9 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
>         return result;
>  }
>
> -static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
> -                               pgoff_t start, struct collapse_control *cc)
> +static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> +                                   struct file *file, pgoff_t start,
> +                                   struct collapse_control *cc)
>  {
>         struct page *page = NULL;
>         struct address_space *mapping = file->f_mapping;
> @@ -2040,7 +2155,7 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
>                         result = SCAN_EXCEED_NONE_PTE;
>                         count_vm_event(THP_SCAN_EXCEED_NONE_PTE);
>                 } else {
> -                       result = collapse_file(mm, file, start, cc);
> +                       result = collapse_file(mm, addr, file, start, cc);
>                 }
>         }
>
> @@ -2048,8 +2163,9 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
>         return result;
>  }
>  #else
> -static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
> -                               pgoff_t start, struct collapse_control *cc)
> +static int hpage_collapse_scan_file(struct mm_struct *mm, unsigned long addr,
> +                                   struct file *file, pgoff_t start,
> +                                   struct collapse_control *cc)
>  {
>         BUILD_BUG();
>  }
> @@ -2145,8 +2261,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>                                                 khugepaged_scan.address);
>
>                                 mmap_read_unlock(mm);
> -                               *result = khugepaged_scan_file(mm, file, pgoff,
> -                                                              cc);
> +                               *result = hpage_collapse_scan_file(mm,
> +                                                                  khugepaged_scan.address,
> +                                                                  file, pgoff, cc);
>                                 mmap_locked = false;
>                                 fput(file);
>                         } else {
> @@ -2453,10 +2570,6 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>
>         *prev = vma;
>
> -       /* TODO: Support file/shmem */
> -       if (!vma->anon_vma || !vma_is_anonymous(vma))
> -               return -EINVAL;
> -
>         if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
>                 return -EINVAL;
>
> @@ -2479,7 +2592,8 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>                         cond_resched();
>                         mmap_read_lock(mm);
>                         mmap_locked = true;
> -                       result = hugepage_vma_revalidate(mm, addr, &vma, cc);
> +                       result = hugepage_vma_revalidate(mm, addr, false, &vma,
> +                                                        cc);
>                         if (result  != SCAN_SUCCEED) {
>                                 last_fail = result;
>                                 goto out_nolock;
> @@ -2489,16 +2603,35 @@ int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
>                 }
>                 mmap_assert_locked(mm);
>                 memset(cc->node_load, 0, sizeof(cc->node_load));
> -               result = hpage_collapse_scan_pmd(mm, vma, addr, &mmap_locked,
> -                                                cc);
> +               if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
> +                       struct file *file = get_file(vma->vm_file);
> +                       pgoff_t pgoff = linear_page_index(vma, addr);
> +
> +                       mmap_read_unlock(mm);
> +                       mmap_locked = false;
> +                       result = hpage_collapse_scan_file(mm, addr, file, pgoff,
> +                                                         cc);
> +                       fput(file);
> +               } else {
> +                       result = hpage_collapse_scan_pmd(mm, vma, addr,
> +                                                        &mmap_locked, cc);
> +               }
>                 if (!mmap_locked)
>                         *prev = NULL;  /* Tell caller we dropped mmap_lock */
>
> +handle_result:
>                 switch (result) {
>                 case SCAN_SUCCEED:
>                 case SCAN_PMD_MAPPED:
>                         ++thps;
>                         break;
> +               case SCAN_PTE_MAPPED_HUGEPAGE:
> +                       BUG_ON(mmap_locked);
> +                       BUG_ON(*prev);
> +                       mmap_write_lock(mm);
> +                       result = collapse_pte_mapped_thp(mm, addr, true);
> +                       mmap_write_unlock(mm);
> +                       goto handle_result;
>                 /* Whitelisted set of results where continuing OK */
>                 case SCAN_PMD_NULL:
>                 case SCAN_PTE_NON_PRESENT:
> --
> 2.37.3.998.g577e59143f-goog
>
