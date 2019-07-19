Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEF36E890
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2019 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfGSQS4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Jul 2019 12:18:56 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56178 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727910AbfGSQS4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Jul 2019 12:18:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXIf.k8_1563553123;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TXIf.k8_1563553123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Jul 2019 00:18:45 +0800
Subject: Re: [v3 PATCH 1/2] mm: mempolicy: make the behavior consistent when
 MPOL_MF_MOVE* and MPOL_MF_STRICT were specified
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <1563470274-52126-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563470274-52126-2-git-send-email-yang.shi@linux.alibaba.com>
 <c1e2b48a-972f-3944-bc17-598cb81a6658@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <081eeac9-f7a3-a2e6-480a-9f527f378591@linux.alibaba.com>
Date:   Fri, 19 Jul 2019 09:18:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c1e2b48a-972f-3944-bc17-598cb81a6658@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 7/19/19 5:48 AM, Vlastimil Babka wrote:
> On 7/18/19 7:17 PM, Yang Shi wrote:
>> When both MPOL_MF_MOVE* and MPOL_MF_STRICT was specified, mbind() should
>> try best to migrate misplaced pages, if some of the pages could not be
>> migrated, then return -EIO.
>>
>> There are three different sub-cases:
>> 1. vma is not migratable
>> 2. vma is migratable, but there are unmovable pages
>> 3. vma is migratable, pages are movable, but migrate_pages() fails
>>
>> If #1 happens, kernel would just abort immediately, then return -EIO,
>> after the commit a7f40cfe3b7ada57af9b62fd28430eeb4a7cfcb7 ("mm:
>> mempolicy: make mbind() return -EIO when MPOL_MF_STRICT is specified").
>>
>> If #3 happens, kernel would set policy and migrate pages with best-effort,
>> but won't rollback the migrated pages and reset the policy back.
>>
>> Before that commit, they behaves in the same way.  It'd better to keep
>> their behavior consistent.  But, rolling back the migrated pages and
>> resetting the policy back sounds not feasible, so just make #1 behave as
>> same as #3.
>>
>> Userspace will know that not everything was successfully migrated (via
>> -EIO), and can take whatever steps it deems necessary - attempt rollback,
>> determine which exact page(s) are violating the policy, etc.
>>
>> Make queue_pages_range() return 1 to indicate there are unmovable pages
>> or vma is not migratable.
>>
>> The #2 is not handled correctly in the current kernel, the following
>> patch will fix it.
>>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
> Some nits below (I guess Andrew can incorporate them, no need to resend)
>
> ...
>
>> @@ -488,15 +496,15 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>>   	struct queue_pages *qp = walk->private;
>>   	unsigned long flags = qp->flags;
>>   	int ret;
>> +	bool has_unmovable = false;
>>   	pte_t *pte;
>>   	spinlock_t *ptl;
>>   
>>   	ptl = pmd_trans_huge_lock(pmd, vma);
>>   	if (ptl) {
>>   		ret = queue_pages_pmd(pmd, ptl, addr, end, walk);
>> -		if (ret > 0)
>> -			return 0;
>> -		else if (ret < 0)
>> +		/* THP was split, fall through to pte walk */
>> +		if (ret != 2)
>>   			return ret;
> The comment should better go here after the if, as that's where fall through
> happens.
>
>>   	}
>>   
>> @@ -519,14 +527,21 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>>   		if (!queue_pages_required(page, qp))
>>   			continue;
>>   		if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) {
>> -			if (!vma_migratable(vma))
>> +			/* MPOL_MF_STRICT must be specified if we get here */
>> +			if (!vma_migratable(vma)) {
>> +				has_unmovable |= true;
> '|=' is weird, just use '='
>
>>   				break;
>> +			}
>>   			migrate_page_add(page, qp->pagelist, flags);
>>   		} else
>>   			break;
>>   	}
>>   	pte_unmap_unlock(pte - 1, ptl);
>>   	cond_resched();
>> +
>> +	if (has_unmovable)
>> +		return 1;
>> +
>>   	return addr != end ? -EIO : 0;
>>   }
>>   
> ...
>> @@ -1259,11 +1286,12 @@ static long do_mbind(unsigned long start, unsigned long len,
>>   				putback_movable_pages(&pagelist);
>>   		}
>>   
>> -		if (nr_failed && (flags & MPOL_MF_STRICT))
>> +		if ((ret > 0) || (nr_failed && (flags & MPOL_MF_STRICT)))
>>   			err = -EIO;
>>   	} else
>>   		putback_movable_pages(&pagelist);
>>   
>> +up_out:
>>   	up_write(&mm->mmap_sem);
>>    mpol_out:
> The new label made the wrong identation of this one stand out, so I'd just fix
> it up while here.

Thanks, will fix all of these. I will resend this patch along with patch 
2/2 which has to be resent anyway.

Yang

> Thanks!
>
>>   	mpol_put(new);
>>

