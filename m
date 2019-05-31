Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD23083F
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 08:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfEaGEE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 02:04:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:56496 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfEaGEE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 31 May 2019 02:04:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BEF9AF32;
        Fri, 31 May 2019 06:04:02 +0000 (UTC)
Date:   Fri, 31 May 2019 08:04:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     semenzato@chromium.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        sonnyrao@chromium.org, Yu Zhao <yuzhao@chromium.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: smaps: split PSS into components
Message-ID: <20190531060401.GA7386@dhcp22.suse.cz>
References: <20190531002633.128370-1-semenzato@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531002633.128370-1-semenzato@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Please always Cc linux-api mailing list (now added) when adding a new
user visible API. Keeping the rest of the email intact for reference]

On Thu 30-05-19 17:26:33, semenzato@chromium.org wrote:
> From: Luigi Semenzato <semenzato@chromium.org>
> 
> Report separate components (anon, file, and shmem)
> for PSS in smaps_rollup.
> 
> This helps understand and tune the memory manager behavior
> in consumer devices, particularly mobile devices.  Many of
> them (e.g. chromebooks and Android-based devices) use zram
> for anon memory, and perform disk reads for discarded file
> pages.  The difference in latency is large (e.g. reading
> a single page from SSD is 30 times slower than decompressing
> a zram page on one popular device), thus it is useful to know
> how much of the PSS is anon vs. file.
> 
> This patch also removes a small code duplication in smaps_account,
> which would have gotten worse otherwise.
> 
> Acked-by: Yu Zhao <yuzhao@chromium.org>
> Signed-off-by: Luigi Semenzato <semenzato@chromium.org>
> ---
>  fs/proc/task_mmu.c | 91 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 61 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 01d4eb0e6bd1..ed3b952f0d30 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -417,17 +417,53 @@ struct mem_size_stats {
>  	unsigned long shared_hugetlb;
>  	unsigned long private_hugetlb;
>  	u64 pss;
> +	u64 pss_anon;
> +	u64 pss_file;
> +	u64 pss_shmem;
>  	u64 pss_locked;
>  	u64 swap_pss;
>  	bool check_shmem_swap;
>  };
>  
> +static void smaps_page_accumulate(struct mem_size_stats *mss,
> +		struct page *page, unsigned long size, unsigned long pss,
> +		bool dirty, bool locked, bool private)
> +{
> +	mss->pss += pss;
> +
> +	if (PageAnon(page))
> +		mss->pss_anon += pss;
> +	else if (PageSwapBacked(page))
> +		mss->pss_shmem += pss;
> +	else
> +		mss->pss_file += pss;
> +
> +	if (locked)
> +		mss->pss_locked += pss;
> +
> +	if (dirty || PageDirty(page)) {
> +		if (private)
> +			mss->private_dirty += size;
> +		else
> +			mss->shared_dirty += size;
> +	} else {
> +		if (private)
> +			mss->private_clean += size;
> +		else
> +			mss->shared_clean += size;
> +	}
> +}
> +
>  static void smaps_account(struct mem_size_stats *mss, struct page *page,
>  		bool compound, bool young, bool dirty, bool locked)
>  {
>  	int i, nr = compound ? 1 << compound_order(page) : 1;
>  	unsigned long size = nr * PAGE_SIZE;
>  
> +	/*
> +	 * First accumulate quantities that depend only on |size| and the type
> +	 * of the compound page.
> +	 */
>  	if (PageAnon(page)) {
>  		mss->anonymous += size;
>  		if (!PageSwapBacked(page) && !dirty && !PageDirty(page))
> @@ -440,42 +476,24 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
>  		mss->referenced += size;
>  
>  	/*
> +	 * Then accumulate quantities that may depend on sharing, or that may
> +	 * differ page-by-page.
> +	 *
>  	 * page_count(page) == 1 guarantees the page is mapped exactly once.
>  	 * If any subpage of the compound page mapped with PTE it would elevate
>  	 * page_count().
>  	 */
>  	if (page_count(page) == 1) {
> -		if (dirty || PageDirty(page))
> -			mss->private_dirty += size;
> -		else
> -			mss->private_clean += size;
> -		mss->pss += (u64)size << PSS_SHIFT;
> -		if (locked)
> -			mss->pss_locked += (u64)size << PSS_SHIFT;
> +		smaps_page_accumulate(mss, page, size, size << PSS_SHIFT, dirty,
> +			locked, true);
>  		return;
>  	}
> -
>  	for (i = 0; i < nr; i++, page++) {
>  		int mapcount = page_mapcount(page);
> -		unsigned long pss = (PAGE_SIZE << PSS_SHIFT);
> -
> -		if (mapcount >= 2) {
> -			if (dirty || PageDirty(page))
> -				mss->shared_dirty += PAGE_SIZE;
> -			else
> -				mss->shared_clean += PAGE_SIZE;
> -			mss->pss += pss / mapcount;
> -			if (locked)
> -				mss->pss_locked += pss / mapcount;
> -		} else {
> -			if (dirty || PageDirty(page))
> -				mss->private_dirty += PAGE_SIZE;
> -			else
> -				mss->private_clean += PAGE_SIZE;
> -			mss->pss += pss;
> -			if (locked)
> -				mss->pss_locked += pss;
> -		}
> +		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
> +
> +		smaps_page_accumulate(mss, page, PAGE_SIZE, pss / mapcount,
> +			dirty, locked, mapcount < 2);
>  	}
>  }
>  
> @@ -754,10 +772,23 @@ static void smap_gather_stats(struct vm_area_struct *vma,
>  		seq_put_decimal_ull_width(m, str, (val) >> 10, 8)
>  
>  /* Show the contents common for smaps and smaps_rollup */
> -static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss)
> +static void __show_smap(struct seq_file *m, const struct mem_size_stats *mss,
> +	bool rollup_mode)
>  {
>  	SEQ_PUT_DEC("Rss:            ", mss->resident);
>  	SEQ_PUT_DEC(" kB\nPss:            ", mss->pss >> PSS_SHIFT);
> +	if (rollup_mode) {
> +		/*
> +		 * These are meaningful only for smaps_rollup, otherwise two of
> +		 * them are zero, and the other one is the same as Pss.
> +		 */
> +		SEQ_PUT_DEC(" kB\nPss_Anon:       ",
> +			mss->pss_anon >> PSS_SHIFT);
> +		SEQ_PUT_DEC(" kB\nPss_File:       ",
> +			mss->pss_file >> PSS_SHIFT);
> +		SEQ_PUT_DEC(" kB\nPss_Shmem:      ",
> +			mss->pss_shmem >> PSS_SHIFT);
> +	}
>  	SEQ_PUT_DEC(" kB\nShared_Clean:   ", mss->shared_clean);
>  	SEQ_PUT_DEC(" kB\nShared_Dirty:   ", mss->shared_dirty);
>  	SEQ_PUT_DEC(" kB\nPrivate_Clean:  ", mss->private_clean);
> @@ -794,7 +825,7 @@ static int show_smap(struct seq_file *m, void *v)
>  	SEQ_PUT_DEC(" kB\nMMUPageSize:    ", vma_mmu_pagesize(vma));
>  	seq_puts(m, " kB\n");
>  
> -	__show_smap(m, &mss);
> +	__show_smap(m, &mss, false);
>  
>  	seq_printf(m, "THPeligible:    %d\n", transparent_hugepage_enabled(vma));
>  
> @@ -841,7 +872,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
>  	seq_pad(m, ' ');
>  	seq_puts(m, "[rollup]\n");
>  
> -	__show_smap(m, &mss);
> +	__show_smap(m, &mss, true);
>  
>  	release_task_mempolicy(priv);
>  	up_read(&mm->mmap_sem);
> -- 
> 2.22.0.rc1.257.g3120a18244-goog

-- 
Michal Hocko
SUSE Labs
