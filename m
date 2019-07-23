Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B06B87113E
	for <lists+linux-api@lfdr.de>; Tue, 23 Jul 2019 07:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfGWFfr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jul 2019 01:35:47 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:35848 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729633AbfGWFfr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Jul 2019 01:35:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXbijdu_1563860140;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TXbijdu_1563860140)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Jul 2019 13:35:43 +0800
Subject: Re: [v4 PATCH 2/2] mm: mempolicy: handle vma with unmovable pages
 mapped correctly in mbind
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     mhocko@kernel.org, mgorman@techsingularity.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
References: <1563556862-54056-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563556862-54056-3-git-send-email-yang.shi@linux.alibaba.com>
 <6c948a96-7af1-c0d2-b3df-5fe613284d4f@suse.cz>
 <20190722180231.b7abbe8bdb046d725bdd9e6b@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <a9b8cae7-4bca-3c98-99f9-6b92de7e5909@linux.alibaba.com>
Date:   Mon, 22 Jul 2019 22:35:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190722180231.b7abbe8bdb046d725bdd9e6b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 7/22/19 6:02 PM, Andrew Morton wrote:
> On Mon, 22 Jul 2019 09:25:09 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
>
>>> since there may be pages off LRU temporarily.  We should migrate other
>>> pages if MPOL_MF_MOVE* is specified.  Set has_unmovable flag if some
>>> paged could not be not moved, then return -EIO for mbind() eventually.
>>>
>>> With this change the above test would return -EIO as expected.
>>>
>>> Cc: Vlastimil Babka <vbabka@suse.cz>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: Mel Gorman <mgorman@techsingularity.net>
>>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Thanks.
>
> I'm a bit surprised that this doesn't have a cc:stable.  Did we
> consider that?

The VM_BUG just happens on 4.9, and it is enabled only by CONFIG_VM. For 
post-4.9 kernel, this fixes the semantics of mbind which should be not a 
regression IMHO.

>
> Also, is this patch dependent upon "mm: mempolicy: make the behavior
> consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified"?
> Doesn't look that way..

No, it depends on patch #1.

>
> Also, I have a note that you had concerns with "mm: mempolicy: make the
> behavior consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were
> specified".  What is the status now?

Vlastimil had given his Reviewed-by.

>
>
> From: Yang Shi <yang.shi@linux.alibaba.com>
> Subject: mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
>
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
> after the commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 ("mm: mempolicy:
> make mbind() return -EIO when MPOL_MF_STRICT is specified").
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
> Make queue_pages_range() return 1 to indicate there are unmovable pages or
> vma is not migratable.
>
> The #2 is not handled correctly in the current kernel, the following patch
> will fix it.
>
> Link: http://lkml.kernel.org/r/1561162809-59140-2-git-send-email-yang.shi@linux.alibaba.com
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>   mm/mempolicy.c |   84 +++++++++++++++++++++++++++++++++--------------
>   1 file changed, 60 insertions(+), 24 deletions(-)
>
> --- a/mm/mempolicy.c~mm-mempolicy-make-the-behavior-consistent-when-mpol_mf_move-and-mpol_mf_strict-were-specified
> +++ a/mm/mempolicy.c
> @@ -429,11 +429,14 @@ static inline bool queue_pages_required(
>   }
>   
>   /*
> - * queue_pages_pmd() has three possible return values:
> + * queue_pages_pmd() has four possible return values:
> + * 2 - there is unmovable page, and MPOL_MF_MOVE* & MPOL_MF_STRICT were
> + *     specified.
>    * 1 - pages are placed on the right node or queued successfully.
>    * 0 - THP was split.
> - * -EIO - is migration entry or MPOL_MF_STRICT was specified and an existing
> - *        page was already on a node that does not follow the policy.
> + * -EIO - is migration entry or only MPOL_MF_STRICT was specified and an
> + *        existing page was already on a node that does not follow the
> + *        policy.
>    */
>   static int queue_pages_pmd(pmd_t *pmd, spinlock_t *ptl, unsigned long addr,
>   				unsigned long end, struct mm_walk *walk)
> @@ -463,7 +466,7 @@ static int queue_pages_pmd(pmd_t *pmd, s
>   	/* go to thp migration */
>   	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>   		if (!vma_migratable(walk->vma)) {
> -			ret = -EIO;
> +			ret = 2;
>   			goto unlock;
>   		}
>   
> @@ -488,16 +491,29 @@ static int queue_pages_pte_range(pmd_t *
>   	struct queue_pages *qp = walk->private;
>   	unsigned long flags = qp->flags;
>   	int ret;
> +	bool has_unmovable = false;
>   	pte_t *pte;
>   	spinlock_t *ptl;
>   
>   	ptl = pmd_trans_huge_lock(pmd, vma);
>   	if (ptl) {
>   		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
> -		if (ret > 0)
> +		switch (ret) {
> +		/* THP was split, fall through to pte walk */
> +		case 0:
> +			break;
> +		/* Pages are placed on the right node or queued successfully */
> +		case 1:
>   			return 0;
> -		else if (ret < 0)
> +		/*
> +		 * Met unmovable pages, MPOL_MF_MOVE* & MPOL_MF_STRICT
> +		 * were specified.
> +		 */
> +		case 2:
> +			return 1;
> +		case -EIO:
>   			return ret;
> +		}
>   	}
>   
>   	if (pmd_trans_unstable(pmd))
> @@ -519,14 +535,21 @@ static int queue_pages_pte_range(pmd_t *
>   		if (!queue_pages_required(page, qp))
>   			continue;
>   		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
> -			if (!vma_migratable(vma))
> +			/* MPOL_MF_STRICT must be specified if we get here */
> +			if (!vma_migratable(vma)) {
> +				has_unmovable |= true;
>   				break;
> +			}
>   			migrate_page_add(page, qp->pagelist, flags);
>   		} else
>   			break;
>   	}
>   	pte_unmap_unlock(pte - 1, ptl);
>   	cond_resched();
> +
> +	if (has_unmovable)
> +		return 1;
> +
>   	return addr != end ? -EIO : 0;
>   }
>   
> @@ -639,7 +662,13 @@ static int queue_pages_test_walk(unsigne
>    *
>    * If pages found in a given range are on a set of nodes (determined by
>    * @nodes and @flags,) it's isolated and queued to the pagelist which is
> - * passed via @private.)
> + * passed via @private.
> + *
> + * queue_pages_range() has three possible return values:
> + * 1 - there is unmovable page, but MPOL_MF_MOVE* & MPOL_MF_STRICT were
> + *     specified.
> + * 0 - queue pages successfully or no misplaced page.
> + * -EIO - there is misplaced page and only MPOL_MF_STRICT was specified.
>    */
>   static int
>   queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
> @@ -1182,6 +1211,7 @@ static long do_mbind(unsigned long start
>   	struct mempolicy *new;
>   	unsigned long end;
>   	int err;
> +	int ret;
>   	LIST_HEAD(pagelist);
>   
>   	if (flags & ~(unsigned long)MPOL_MF_VALID)
> @@ -1243,26 +1273,32 @@ static long do_mbind(unsigned long start
>   	if (err)
>   		goto mpol_out;
>   
> -	err = queue_pages_range(mm, start, end, nmask,
> +	ret = queue_pages_range(mm, start, end, nmask,
>   			  flags | MPOL_MF_INVERT, &pagelist);
> -	if (!err)
> -		err = mbind_range(mm, start, end, new);
>   
> -	if (!err) {
> -		int nr_failed = 0;
> +	if (ret < 0)
> +		err = -EIO;
> +	else {
> +		err = mbind_range(mm, start, end, new);
>   
> -		if (!list_empty(&pagelist)) {
> -			WARN_ON_ONCE(flags & MPOL_MF_LAZY);
> -			nr_failed = migrate_pages(&pagelist, new_page, NULL,
> -				start, MIGRATE_SYNC, MR_MEMPOLICY_MBIND);
> -			if (nr_failed)
> -				putback_movable_pages(&pagelist);
> -		}
> +		if (!err) {
> +			int nr_failed = 0;
>   
> -		if (nr_failed && (flags & MPOL_MF_STRICT))
> -			err = -EIO;
> -	} else
> -		putback_movable_pages(&pagelist);
> +			if (!list_empty(&pagelist)) {
> +				WARN_ON_ONCE(flags & MPOL_MF_LAZY);
> +				nr_failed = migrate_pages(&pagelist, new_page,
> +					NULL, start, MIGRATE_SYNC,
> +					MR_MEMPOLICY_MBIND);
> +				if (nr_failed)
> +					putback_movable_pages(&pagelist);
> +			}
> +
> +			if ((ret > 0) ||
> +			    (nr_failed && (flags & MPOL_MF_STRICT)))
> +				err = -EIO;
> +		} else
> +			putback_movable_pages(&pagelist);
> +	}
>   
>   	up_write(&mm->mmap_sem);
>    mpol_out:
> _

