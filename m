Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 216966E5DF
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2019 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfGSMs1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Jul 2019 08:48:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:55894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727559AbfGSMs1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 19 Jul 2019 08:48:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D75DEAF6B;
        Fri, 19 Jul 2019 12:48:24 +0000 (UTC)
Subject: Re: [v3 PATCH 1/2] mm: mempolicy: make the behavior consistent when
 MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <1563470274-52126-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563470274-52126-2-git-send-email-yang.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c1e2b48a-972f-3944-bc17-598cb81a6658@suse.cz>
Date:   Fri, 19 Jul 2019 14:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563470274-52126-2-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/18/19 7:17 PM, Yang Shi wrote:
> When both MPOL_MF_MOVE* and MPOL_MF_STRICT was specified, mbind() should
> try best to migrate misplaced pages, if some of the pages could not be
> migrated, then return -EIO.
> 
> There are three different sub-cases:
> 1. vma is not migratable
> 2. vma is migratable, but there are unmovable pages
> 3. vma is migratable, pages are movable, but migrate_pages() fails
> 
> If #1 happens, kernel would just abort immediately, then return -EIO,
> after the commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 ("mm:
> mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified").
> 
> If #3 happens, kernel would set policy and migrate pages with best-effort,
> but won't rollback the migrated pages and reset the policy back.
> 
> Before that commit, they behaves in the same way.  It'd better to keep
> their behavior consistent.  But, rolling back the migrated pages and
> resetting the policy back sounds not feasible, so just make #1 behave as
> same as #3.
> 
> Userspace will know that not everything was successfully migrated (via
> -EIO), and can take whatever steps it deems necessary - attempt rollback,
> determine which exact page(s) are violating the policy, etc.
> 
> Make queue_pages_range() return 1 to indicate there are unmovable pages
> or vma is not migratable.
> 
> The #2 is not handled correctly in the current kernel, the following
> patch will fix it.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits below (I guess Andrew can incorporate them, no need to resend)

...

> @@ -488,15 +496,15 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  	struct queue_pages *qp = walk->private;
>  	unsigned long flags = qp->flags;
>  	int ret;
> +	bool has_unmovable = false;
>  	pte_t *pte;
>  	spinlock_t *ptl;
>  
>  	ptl = pmd_trans_huge_lock(pmd, vma);
>  	if (ptl) {
>  		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
> -		if (ret > 0)
> -			return 0;
> -		else if (ret < 0)
> +		/* THP was split, fall through to pte walk */
> +		if (ret != 2)
>  			return ret;

The comment should better go here after the if, as that's where fall through
happens.

>  	}
>  
> @@ -519,14 +527,21 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>  		if (!queue_pages_required(page, qp))
>  			continue;
>  		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> -			if (!vma_migratable(vma))
> +			/* MPOL_MF_STRICT must be specified if we get here */
> +			if (!vma_migratable(vma)) {
> +				has_unmovable |= true;

'|=' is weird, just use '='

>  				break;
> +			}
>  			migrate_page_add(page, qp->pagelist, flags);
>  		} else
>  			break;
>  	}
>  	pte_unmap_unlock(pte - 1, ptl);
>  	cond_resched();
> +
> +	if (has_unmovable)
> +		return 1;
> +
>  	return addr != end ? -EIO : 0;
>  }
>  
...
> @@ -1259,11 +1286,12 @@ static long do_mbind(unsigned long start, unsigned long len,
>  				putback_movable_pages(&pagelist);
>  		}
>  
> -		if (nr_failed && (flags & MPOL_MF_STRICT))
> +		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
>  			err = -EIO;
>  	} else
>  		putback_movable_pages(&pagelist);
>  
> +up_out:
>  	up_write(&mm->mmap_sem);
>   mpol_out:

The new label made the wrong identation of this one stand out, so I'd just fix
it up while here.

Thanks!

>  	mpol_put(new);
> 

