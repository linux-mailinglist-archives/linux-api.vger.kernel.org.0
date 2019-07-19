Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F566E88C
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2019 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfGSQRq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Jul 2019 12:17:46 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:36965 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728346AbfGSQRq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Jul 2019 12:17:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TXIWw-t_1563553057;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TXIWw-t_1563553057)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Jul 2019 00:17:39 +0800
Subject: Re: [v3 PATCH 2/2] mm: mempolicy: handle vma with unmovable pages
 mapped correctly in mbind
To:     Vlastimil Babka <vbabka@suse.cz>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <1563470274-52126-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563470274-52126-3-git-send-email-yang.shi@linux.alibaba.com>
 <6ba72e56-9f62-36bf-ded7-f337522715d5@suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2a753062-a6bd-d767-085a-0bf9847ea067@linux.alibaba.com>
Date:   Fri, 19 Jul 2019 09:17:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6ba72e56-9f62-36bf-ded7-f337522715d5@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 7/19/19 6:01 AM, Vlastimil Babka wrote:
> On 7/18/19 7:17 PM, Yang Shi wrote:
>> When running syzkaller internally, we ran into the below bug on 4.9.x
>> kernel:
>>
>> kernel BUG at mm/huge_memory.c:2124!
>> invalid opcode: 0000 [#1] SMP KASAN
>> Dumping ftrace buffer:
>>     (ftrace buffer empty)
>> Modules linked in:
>> CPU: 0 PID: 1518 Comm: syz-executor107 Not tainted 4.9.168+ #2
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
>> task: ffff880067b34900 task.stack: ffff880068998000
>> RIP: 0010:[<ffffffff81895d6b>]  [<ffffffff81895d6b>] split_huge_page_to_list+0x8fb/0x1030 mm/huge_memory.c:2124
>> RSP: 0018:ffff88006899f980  EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: ffffea00018f1700 RCX: 0000000000000000
>> RDX: 1ffffd400031e2e7 RSI: 0000000000000001 RDI: ffffea00018f1738
>> RBP: ffff88006899f9e8 R08: 0000000000000001 R09: 0000000000000000
>> R10: 0000000000000000 R11: fffffbfff0d8b13e R12: ffffea00018f1400
>> R13: ffffea00018f1400 R14: ffffea00018f1720 R15: ffffea00018f1401
>> FS:  00007fa333996740(0000) GS:ffff88006c600000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 0000000020000040 CR3: 0000000066b9c000 CR4: 00000000000606f0
>> Stack:
>>   0000000000000246 ffff880067b34900 0000000000000000 ffff88007ffdc000
>>   0000000000000000 ffff88006899f9e8 ffffffff812b4015 ffff880064c64e18
>>   ffffea00018f1401 dffffc0000000000 ffffea00018f1700 0000000020ffd000
>> Call Trace:
>>   [<ffffffff818490f1>] split_huge_page include/linux/huge_mm.h:100 [inline]
>>   [<ffffffff818490f1>] queue_pages_pte_range+0x7e1/0x1480 mm/mempolicy.c:538
>>   [<ffffffff817ed0da>] walk_pmd_range mm/pagewalk.c:50 [inline]
>>   [<ffffffff817ed0da>] walk_pud_range mm/pagewalk.c:90 [inline]
>>   [<ffffffff817ed0da>] walk_pgd_range mm/pagewalk.c:116 [inline]
>>   [<ffffffff817ed0da>] __walk_page_range+0x44a/0xdb0 mm/pagewalk.c:208
>>   [<ffffffff817edb94>] walk_page_range+0x154/0x370 mm/pagewalk.c:285
>>   [<ffffffff81844515>] queue_pages_range+0x115/0x150 mm/mempolicy.c:694
>>   [<ffffffff8184f493>] do_mbind mm/mempolicy.c:1241 [inline]
>>   [<ffffffff8184f493>] SYSC_mbind+0x3c3/0x1030 mm/mempolicy.c:1370
>>   [<ffffffff81850146>] SyS_mbind+0x46/0x60 mm/mempolicy.c:1352
>>   [<ffffffff810097e2>] do_syscall_64+0x1d2/0x600 arch/x86/entry/common.c:282
>>   [<ffffffff82ff6f93>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
>> Code: c7 80 1c 02 00 e8 26 0a 76 01 <0f> 0b 48 c7 c7 40 46 45 84 e8 4c
>> RIP  [<ffffffff81895d6b>] split_huge_page_to_list+0x8fb/0x1030 mm/huge_memory.c:2124
>>   RSP <ffff88006899f980>
> ...
>
>> @@ -532,7 +531,14 @@ static int queue_pages_pte_range(pmd_t *pmd, unsigned long addr,
>>   				has_unmovable |= true;
>>   				break;
>>   			}
>> -			migrate_page_add(page, qp->pagelist, flags);
>> +
>> +			/*
>> +			 * Do not abort immediately since there may be
>> +			 * temporary off LRU pages in the range.  Still
>> +			 * need migrate other LRU pages.
>> +			 */
>> +			if (migrate_page_add(page, qp->pagelist, flags))
>> +				has_unmovable |= true;
> Also = instead of |=

OK

>
>>   		} else
>>   			break;
>>   	}
>> @@ -961,10 +967,21 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
>>   /*
>>    * page migration, thp tail pages can be passed.
>>    */
>> -static void migrate_page_add(struct page *page, struct list_head *pagelist,
>> +static int migrate_page_add(struct page *page, struct list_head *pagelist,
>>   				unsigned long flags)
>>   {
>>   	struct page *head = compound_head(page);
>> +
>> +	/*
>> +	 * Non-movable page may reach here.  And, there may be
>> +	 * temporary off LRU pages or non-LRU movable pages.
>> +	 * Treat them as unmovable pages since they can't be
>> +	 * isolated, so they can't be moved at the moment.  It
>> +	 * should return -EIO for this case too.
>> +	 */
>> +	if (!PageLRU(head) && (flags & MPOL_MF_STRICT))
>> +		return -EIO;
> As this test is racy, why not just use the result of isolate_lru_page().

Sounds good to me. Will fix in v4.

Thanks,
Yang

>
>> +
>>   	/*
>>   	 * Avoid migrating a page that is shared with others.
>>   	 */
>> @@ -976,6 +993,8 @@ static void migrate_page_add(struct page *page, struct list_head *pagelist,
>>   				hpage_nr_pages(head));
>>   		}
>>   	}
>> +
>> +	return 0;
>>   }
>>   
>>   /* page allocation callback for NUMA node migration */
>> @@ -1178,9 +1197,10 @@ static struct page *new_page(struct page *page, unsigned long start)
>>   }
>>   #else
>>   
>> -static void migrate_page_add(struct page *page, struct list_head *pagelist,
>> +static int migrate_page_add(struct page *page, struct list_head *pagelist,
>>   				unsigned long flags)
>>   {
>> +	return -EIO;
>>   }
>>   
>>   int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
>>

