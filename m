Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DFD5BB21D
	for <lists+linux-api@lfdr.de>; Fri, 16 Sep 2022 20:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiIPS1u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Sep 2022 14:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiIPS1d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Sep 2022 14:27:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD21FB6D7E
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 11:26:59 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c24so547339plo.3
        for <linux-api@vger.kernel.org>; Fri, 16 Sep 2022 11:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nbMtLs2O8Mwfvd2MHovhrBbIrLg77ynAXyMa0g/+J+0=;
        b=ASrYycClqJNrwYmIBj7dRont7LhhUvKpOVsxI3tZjh0Y4NfsQKi8AQZzFE2iDAy0Nu
         KfJe1GEaXFwB5atFjfNvQh1N2stc4lnOvm/Q4l6qc+slLV1m+noFosxUa3BjAnGi8cic
         1RWH5IkQSg76Dr6a66dvHGW7U8VllUVEtT65IT6N1vZ3/bszhpwNXK3TVJPnjsqflSVM
         x9I2kHztUlwco4s1mAdCnqfjkubTv2xM5rpF0rd1nDfCEUvULRENZZ8c/aAq2r4pG7Oe
         jBRmLGhQUp4mCjEgPsQc3zXh47r4PIL0f+3ehcJ7jLorWEpIKRUyJPExLlfDtPM8Hsmr
         Bdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nbMtLs2O8Mwfvd2MHovhrBbIrLg77ynAXyMa0g/+J+0=;
        b=3lY3NcSx6BPbft4t5ok3yrivoHla5jQRtE39B0RegTosfe0qEWGUb2mbXwiai0Qnye
         cd+Qe5Iada11PpuFAecnT/CljghjtONXsv2Yvau6V7Nm6PWL+0TPCLcwIrdlRTQmmBXZ
         Fo8qtIy68oGsh/OZAgigPo3iT4Ipo9EDrgyH0MVrBSE4XfCeX0NlC2fmh03VYmMcY4gh
         iXyzv2JH9JeEZ3lTEl4hskWhKAb6N3TC0ANCzU0B9MrVXVhJAH0r0oBSay/DW3T0QH/a
         qozR5krqMcdq6b0fwd2eL+SI0xLPPkF82JWWumg477LLd9RsTJoIv9bTeSTbx7KHf8Ex
         Mthg==
X-Gm-Message-State: ACrzQf0h6sFuOcT2SBm8paEfw8knWFoWVKAF5MeTwY+V7fL9zamCjYmU
        mYwhdmhxjVTQreuDHAnZoZTIJaQURqrhdKgPZc4=
X-Google-Smtp-Source: AMsMyM6bQUENUWkL7by1pncT7EBtBH+sLF0BPaxSPHqZYOovQ5aci3a5SZqteCYFwWRUQFLApqgodawC0Tyl9WwqO3c=
X-Received: by 2002:a17:902:e5c1:b0:176:c2b3:6a4c with SMTP id
 u1-20020a170902e5c100b00176c2b36a4cmr1075254plf.87.1663352818766; Fri, 16 Sep
 2022 11:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220907144521.3115321-1-zokeefe@google.com> <20220907144521.3115321-3-zokeefe@google.com>
In-Reply-To: <20220907144521.3115321-3-zokeefe@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 16 Sep 2022 11:26:46 -0700
Message-ID: <CAHbLzkpHwZxFzjfX9nxVoRhzup8WMjMfyL6Xiq8mZ9M-N3ombw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v3 02/10] mm/khugepaged: attempt to map
 file/shmem-backed pte-mapped THPs by pmds
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
> The main benefit of THPs are that they can be mapped at the pmd level,
> increasing the likelihood of TLB hit and spending less cycles in page
> table walks.  pte-mapped hugepages - that is - hugepage-aligned compound
> pages of order HPAGE_PMD_ORDER mapped by ptes - although being
> contiguous in physical memory, don't have this advantage.  In fact, one
> could argue they are detrimental to system performance overall since
> they occupy a precious hugepage-aligned/sized region of physical memory
> that could otherwise be used more effectively.  Additionally, pte-mapped
> hugepages can be the cheapest memory to collapse for khugepaged since no
> new hugepage allocation or copying of memory contents is necessary - we
> only need to update the mapping page tables.
>
> In the anonymous collapse path, we are able to collapse pte-mapped
> hugepages (albeit, perhaps suboptimally), but the file/shmem path makes no
> effort when compound pages (of any order) are encountered.
>
> Identify pte-mapped hugepages in the file/shmem collapse path.  The
> final step of which makes a racy check of the value of the pmd to ensure
> it maps a pte table.  This should be fine, since races that result in
> false-positive (i.e. attempt collapse even though we sholdn't) will fail

s/sholdn't/shouldn't

> later in collapse_pte_mapped_thp() once we actually lock mmap_lock and
> reinspect the pmd value.  Races that result in false-negatives (i.e.
> where we decide to not attempt collapse, but should have) shouldn't be
> an issue, since in the worst case, we do nothing - which is what we've
> done up to this point.  We make a similar check in retract_page_tables().
> If we do think we've found a pte-mapped hugepgae in khugepaged context,
> attempt to update page tables mapping this hugepage.
>
> Note that these collapses still count towards the
> /sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed counter, and
> if the pte-mapped hugepage was also mapped into multiple process' address
> spaces, could be incremented for each page table update.  Since we
> increment the counter when a pte-mapped hugepage is successfully added to
> the list of to-collapse pte-mapped THPs, it's possible that we never
> actually update the page table either.  This is different from how
> file/shmem pages_collapsed accounting works today where only a successful
> page cache update is counted (it's also possible here that no page tables
> are actually changed).  Though it incurs some slop, this is preferred to
> either not accounting for the event at all, or plumbing through data in
> struct mm_slot on whether to account for the collapse or not.

I don't have a strong preference on this. Typically it is used to tell
the users khugepaged is making progress. We have thp_collapse_alloc
from /proc/vmstat to account how many huge pages are really allocated
by khugepaged/MADV_COLLAPSE.

But it may be better to add a note in the document
(Documentation/admin-guide/mm/transhuge.rst) to make it more explicit.

>
> Also note that work still needs to be done to support arbitrary compound
> pages, and that this should all be converted to using folios.
>
> Signed-off-by: Zach O'Keefe <zokeefe@google.com>

Other than the above comments and two nits below, the patch looks good
to me. Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/trace/events/huge_memory.h |  1 +
>  mm/khugepaged.c                    | 67 +++++++++++++++++++++++++++---
>  2 files changed, 62 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
> index 55392bf30a03..fbbb25494d60 100644
> --- a/include/trace/events/huge_memory.h
> +++ b/include/trace/events/huge_memory.h
> @@ -17,6 +17,7 @@
>         EM( SCAN_EXCEED_SHARED_PTE,     "exceed_shared_pte")            \
>         EM( SCAN_PTE_NON_PRESENT,       "pte_non_present")              \
>         EM( SCAN_PTE_UFFD_WP,           "pte_uffd_wp")                  \
> +       EM( SCAN_PTE_MAPPED_HUGEPAGE,   "pte_mapped_hugepage")          \
>         EM( SCAN_PAGE_RO,               "no_writable_page")             \
>         EM( SCAN_LACK_REFERENCED_PAGE,  "lack_referenced_page")         \
>         EM( SCAN_PAGE_NULL,             "page_null")                    \
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 55c8625ed950..31ccf49cf279 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -35,6 +35,7 @@ enum scan_result {
>         SCAN_EXCEED_SHARED_PTE,
>         SCAN_PTE_NON_PRESENT,
>         SCAN_PTE_UFFD_WP,
> +       SCAN_PTE_MAPPED_HUGEPAGE,
>         SCAN_PAGE_RO,
>         SCAN_LACK_REFERENCED_PAGE,
>         SCAN_PAGE_NULL,
> @@ -1318,20 +1319,24 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>   * Notify khugepaged that given addr of the mm is pte-mapped THP. Then
>   * khugepaged should try to collapse the page table.
>   */
> -static void khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
>                                           unsigned long addr)
>  {
>         struct khugepaged_mm_slot *mm_slot;
>         struct mm_slot *slot;
> +       bool ret = false;
>
>         VM_BUG_ON(addr & ~HPAGE_PMD_MASK);
>
>         spin_lock(&khugepaged_mm_lock);
>         slot = mm_slot_lookup(mm_slots_hash, mm);
>         mm_slot = mm_slot_entry(slot, struct khugepaged_mm_slot, slot);
> -       if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP))
> +       if (likely(mm_slot && mm_slot->nr_pte_mapped_thp < MAX_PTE_MAPPED_THP)) {
>                 mm_slot->pte_mapped_thp[mm_slot->nr_pte_mapped_thp++] = addr;
> +               ret = true;
> +       }
>         spin_unlock(&khugepaged_mm_lock);
> +       return ret;
>  }
>
>  static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *vma,
> @@ -1368,9 +1373,16 @@ void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
>         pte_t *start_pte, *pte;
>         pmd_t *pmd;
>         spinlock_t *ptl;
> -       int count = 0;
> +       int count = 0, result = SCAN_FAIL;
>         int i;
>
> +       mmap_assert_write_locked(mm);
> +
> +       /* Fast check before locking page if already PMD-mapped  */

It also back off if the page is not mapped at all. So better to
reflect this in the comment too.

> +       result = find_pmd_or_thp_or_none(mm, haddr, &pmd);
> +       if (result != SCAN_SUCCEED)
> +               return;
> +
>         if (!vma || !vma->vm_file ||
>             !range_in_vma(vma, haddr, haddr + HPAGE_PMD_SIZE))
>                 return;
> @@ -1721,9 +1733,16 @@ static int collapse_file(struct mm_struct *mm, struct file *file,
>                 /*
>                  * If file was truncated then extended, or hole-punched, before
>                  * we locked the first page, then a THP might be there already.
> +                * This will be discovered on the first iteration.
>                  */
>                 if (PageTransCompound(page)) {
> -                       result = SCAN_PAGE_COMPOUND;
> +                       struct page *head = compound_head(page);
> +
> +                       result = compound_order(head) == HPAGE_PMD_ORDER &&
> +                                       head->index == start
> +                                       /* Maybe PMD-mapped */
> +                                       ? SCAN_PTE_MAPPED_HUGEPAGE
> +                                       : SCAN_PAGE_COMPOUND;
>                         goto out_unlock;
>                 }
>
> @@ -1961,7 +1980,19 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
>                  * into a PMD sized page
>                  */

The comment starts with "XXX:", better to rephrase to "TODO:", it
seems more understandable.

>                 if (PageTransCompound(page)) {
> -                       result = SCAN_PAGE_COMPOUND;
> +                       struct page *head = compound_head(page);
> +
> +                       result = compound_order(head) == HPAGE_PMD_ORDER &&
> +                                       head->index == start
> +                                       /* Maybe PMD-mapped */
> +                                       ? SCAN_PTE_MAPPED_HUGEPAGE
> +                                       : SCAN_PAGE_COMPOUND;
> +                       /*
> +                        * For SCAN_PTE_MAPPED_HUGEPAGE, further processing
> +                        * by the caller won't touch the page cache, and so
> +                        * it's safe to skip LRU and refcount checks before
> +                        * returning.
> +                        */
>                         break;
>                 }
>
> @@ -2021,6 +2052,12 @@ static int khugepaged_scan_file(struct mm_struct *mm, struct file *file,
>  static void khugepaged_collapse_pte_mapped_thps(struct khugepaged_mm_slot *mm_slot)
>  {
>  }
> +
> +static bool khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
> +                                         unsigned long addr)
> +{
> +       return false;
> +}
>  #endif
>
>  static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
> @@ -2115,8 +2152,26 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>                                                                   &mmap_locked,
>                                                                   cc);
>                         }
> -                       if (*result == SCAN_SUCCEED)
> +                       switch (*result) {
> +                       case SCAN_PTE_MAPPED_HUGEPAGE: {
> +                               pmd_t *pmd;
> +
> +                               *result = find_pmd_or_thp_or_none(mm,
> +                                                                 khugepaged_scan.address,
> +                                                                 &pmd);
> +                               if (*result != SCAN_SUCCEED)
> +                                       break;
> +                               if (!khugepaged_add_pte_mapped_thp(mm,
> +                                                                  khugepaged_scan.address))
> +                                       break;
> +                       } fallthrough;
> +                       case SCAN_SUCCEED:
>                                 ++khugepaged_pages_collapsed;
> +                               break;
> +                       default:
> +                               break;
> +                       }
> +
>                         /* move to next address */
>                         khugepaged_scan.address += HPAGE_PMD_SIZE;
>                         progress += HPAGE_PMD_NR;
> --
> 2.37.2.789.g6183377224-goog
>
