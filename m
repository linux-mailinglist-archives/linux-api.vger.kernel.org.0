Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B855B3DBE02
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 19:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhG3R6y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jul 2021 13:58:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229773AbhG3R6x (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Jul 2021 13:58:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1254E60F4B;
        Fri, 30 Jul 2021 17:58:46 +0000 (UTC)
Date:   Fri, 30 Jul 2021 18:58:44 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Jann Horn <jannh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm@kvack.org, kernel test robot <lkp@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5] mm: introduce reference pages
Message-ID: <20210730175843.GB2690@arm.com>
References: <20210717025757.3945742-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717025757.3945742-1-pcc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 16, 2021 at 07:57:57PM -0700, Peter Collingbourne wrote:
> Introduce a new syscall, refpage_create, which returns a file
> descriptor which may be mapped using mmap. Such a mapping is similar
> to an anonymous mapping, but instead of clean pages being backed by the
> zero page, they are instead backed by a so-called reference page, whose
> contents are specified using an argument to refpage_create. Loads from
> the mapping will load directly from the reference page, and initial
> stores to the mapping will copy-on-write from the reference page.

I think you mentioned in an earlier version, we can't use memfd_create()
as we want a single reference page to back arbitrarily sized mmap()
regions. Random API thought: could we instead add an MFD_MMAP_WRAP flag
or something to memfd_create() which pretends on mmap(MAP_PRIVATE) that
it's an infinite file and just replicates the data it already has in
that fd on read? On write, it would do a CoW.

Not sure it's any better than your proposal, just wondering whether we
can contain it to shmem_fault() mostly and maybe a new
shmem_map_pages(). Anyway, more API design comments below.

> Reference pages are useful in circumstances where anonymous mappings
> combined with manual stores to memory would impose undesirable costs,
> either in terms of performance or RSS. Use cases are focused on heap
> allocators and include:
> 
> - Pattern initialization for the heap. This is where malloc(3) gives
>   you memory whose contents are filled with a non-zero pattern
>   byte, in order to help detect and mitigate bugs involving use
>   of uninitialized memory. Typically this is implemented by having
>   the allocator memset the allocation with the pattern byte before
>   returning it to the user, but for large allocations this can result
>   in a significant increase in RSS, especially for allocations that
>   are used sparsely. Even for dense allocations there is a needless
>   impact to startup performance when it may be better to amortize it
>   throughout the program. By creating allocations using a reference
>   page filled with the pattern byte, we can avoid these costs.
> 
> - Pre-tagged heap memory. Memory tagging [1] is an upcoming ARMv8.5
>   feature which allows for memory to be tagged in order to detect
>   certain kinds of memory errors with low overhead. In order to set
>   up an allocation to allow memory errors to be detected, the entire
>   allocation needs to have the same tag. The issue here is similar to
>   pattern initialization in the sense that large tagged allocations
>   will be expensive if the tagging is done up front. The idea is that
>   the allocator would create reference pages with each of the possible
>   memory tags, and use those reference pages for the large allocations.

So for MTE you'd need the same tag other than tag 0 (which is what
mmap() gives you). An alternative here is to allow passing a tag hint to
mmap() with the kernel allocating and maintaining a reference page (we
had some non-optimal internal attempts at this). But if the first case
(data pattern initialisation) is equally important, a reference pattern
may be a better option.

> This patch includes specific optimizations for these use cases in
> order to reduce memory traffic. If the reference page consists of a
> single repeating byte, the page is initialized using memset, and on
> arm64 if the reference page consists of a uniformly tagged zero page,
> the DC GZVA instruction is used to initialize the page.

I don't particularly like such heuristics. If the memset/single-tag is
your main use-case, just bake it into the API from the start. As David
said, how important is the read prior to a write of such page? I suspect
it's not relevant at all, so we could have the page allocated and
populated on fault (even a read fault). The pattern and its size could
be stored in the kernel as I suspect even if you need something other
than a single byte, it would still be a repetitive pattern.

Also please split this into multiple patches as it's hard to follow.
Something like (1) refpage_create, (2) basic arm64 tagging support, (3)
optimisation for specific cases etc.

> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index 36f51b0e438a..876997703d7b 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -450,3 +450,27 @@ int mte_ptrace_copy_tags(struct task_struct *child, long request,
>  
>  	return ret;
>  }
> +
> +u8 mte_check_tag_zero_page(struct page *userpage)
> +{
> +	char *userpage_addr = page_address(userpage);
> +	u8 tag;
> +	int i;
> +
> +	if (!test_bit(PG_mte_tagged, &userpage->flags))
> +		return 0;
> +
> +	tag = mte_get_mem_tag(userpage_addr) & 0xF;
> +	if (tag == 0)
> +		return 0;
> +
> +	for (i = 0; i != PAGE_SIZE; ++i)
> +		if (userpage_addr[i] != 0)
> +			return 0;
> +
> +	for (i = MTE_GRANULE_SIZE; i != PAGE_SIZE; i += MTE_GRANULE_SIZE)
> +		if ((mte_get_mem_tag(userpage_addr + i) & 0xF) != tag)
> +			return 0;
> +
> +	return tag;
> +}

What's this function for? I couldn't see a user in this patch (maybe I
didn't look harder).

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 349c488765ca..73fe728787f0 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -25,6 +25,7 @@
>  #include <linux/perf_event.h>
>  #include <linux/preempt.h>
>  #include <linux/hugetlb.h>
> +#include <linux/mman.h>
>  
>  #include <asm/acpi.h>
>  #include <asm/bug.h>
> @@ -939,9 +940,52 @@ struct page *alloc_zeroed_user_highpage_movable(struct vm_area_struct *vma,
>  	return alloc_page_vma(flags, vma, vaddr);
>  }
>  
> -void tag_clear_highpage(struct page *page)
> +void tag_set_highpage(struct page *page, unsigned long tag)
>  {
> -	mte_zero_clear_page_tags(page_address(page));
> +	unsigned long addr = (unsigned long)page_address(page);
> +
> +	addr &= ~MTE_TAG_MASK;
> +	addr |= tag << MTE_TAG_SHIFT;
> +	mte_zero_set_page_tags((void *)addr);
>  	page_kasan_tag_reset(page);
>  	set_bit(PG_mte_tagged, &page->flags);
>  }
> +
> +void arch_prep_refpage_private_data(struct refpage_private_data *priv,
> +				    char *content_kaddr, unsigned long size)
> +{
> +	if (system_supports_mte()) {
> +		u64 *content_kaddr_u64 = (u64 *)content_kaddr;
> +
> +		if (size == MTE_GRANULE_SIZE && content_kaddr_u64[0] == 0 &&
> +		    content_kaddr_u64[1] == 0) {
> +			priv->content_type = REFPAGE_CONTENT_TYPE_MTE_TAGGED;
> +			priv->content_info = mte_get_mem_tag(content_kaddr);
> +		}
> +
> +		set_bit(PG_mte_tagged, &priv->refpage->flags);

As per your example, the reference page may be in the data section. We
explicitly avoid tagged pages in there (could be a file mmap, not
necessarily bss) but you just force it here. I'd rather skip the tagging
altogether if the page was not mapped with PROT_MTE.

> +		if (size >= MTE_GRANULE_SIZE) {
> +			char *refpage_kaddr = page_address(priv->refpage);
> +			unsigned long i;
> +
> +			for (i = 0; i != PAGE_SIZE; i += size)
> +				mte_memcpy(refpage_kaddr + i, content_kaddr,
> +					   size);
> +			return;
> +		}
> +		mte_clear_page_tags(page_address(priv->refpage));
> +	}
> +
> +	prep_refpage_private_data(priv, content_kaddr, size);
> +}

IIUC this function writes to the reference page provided by the user but
get_user_pages() did not use a FOLL_WRITE. Even worse, the
refpage_create() syscall does not seem to reject size != PAGE_SIZE
values, so the user may think it's fine to have a shorter buffer with
the kernel overriding whatever is around it. If the API states that the
buffer must be PAGE_SIZE, why not get the user to populate it and avoid
this arch_prep_refpage_private_data() altogether. I think it
overcomplicates the kernel for something the user could do.

> +
> +void arch_copy_refpage(struct page *page, unsigned long addr,
> +		       struct vm_area_struct *vma)
> +{
> +	struct refpage_private_data *priv = vma->vm_private_data;
> +
> +	if (priv->content_type == REFPAGE_CONTENT_TYPE_MTE_TAGGED)
> +		tag_set_highpage(page, priv->content_info);
> +	else
> +		copy_refpage(page, addr, vma);
> +}

Another heuristics targeted at your specific allocator. Just leave it as
a later optimisation or at least a separate patch.

> diff --git a/mm/refpage.c b/mm/refpage.c
> new file mode 100644
> index 000000000000..13c0930dc926
> --- /dev/null
> +++ b/mm/refpage.c
> @@ -0,0 +1,151 @@
[...]
> +SYSCALL_DEFINE3(refpage_create, const void *__user, content, unsigned int,
> +		size, unsigned long, flags)
> +{
> +	unsigned long content_addr = (unsigned long)content;
> +	char *content_kaddr;
> +	struct page *userpage;
> +	struct refpage_private_data *private_data;
> +	long retval;
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	if (!is_power_of_2(size) || size > PAGE_SIZE ||
> +	    (content_addr & (size - 1)) != 0)
> +		return -EINVAL;

Alternative: copy the pattern from the user content to a kernel buffer
and in the file ops .mmap, instead of vma_set_anonymous(), just
implement your own vma ops with a .fault callback that takes care of
copying the pattern to a newly allocated page on any fault.

> +
> +	if (get_user_pages(content_addr & ~(PAGE_SIZE - 1), 1, 0, &userpage,
> +			   0) != 1)
> +		return -EFAULT;

FOLL_WRITE to the gup flags?

-- 
Catalin
