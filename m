Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E4D6FA51
	for <lists+linux-api@lfdr.de>; Mon, 22 Jul 2019 09:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfGVHZM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Jul 2019 03:25:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57336 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfGVHZM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 22 Jul 2019 03:25:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5478DAE2D;
        Mon, 22 Jul 2019 07:25:10 +0000 (UTC)
Subject: Re: [v4 PATCH 2/2] mm: mempolicy: handle vma with unmovable pages
 mapped correctly in mbind
To:     Yang Shi <yang.shi@linux.alibaba.com>, mhocko@kernel.org,
        mgorman@techsingularity.net, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <1563556862-54056-1-git-send-email-yang.shi@linux.alibaba.com>
 <1563556862-54056-3-git-send-email-yang.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6c948a96-7af1-c0d2-b3df-5fe613284d4f@suse.cz>
Date:   Mon, 22 Jul 2019 09:25:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563556862-54056-3-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/19/19 7:21 PM, Yang Shi wrote:
> When running syzkaller internally, we ran into the below bug on 4.9.x
> kernel:
> 
> kernel BUG at mm/huge_memory.c:2124!
> invalid opcode: 0000 [#1] SMP KASAN
> Dumping ftrace buffer:
>    (ftrace buffer empty)
> Modules linked in:
> CPU: 0 PID: 1518 Comm: syz-executor107 Not tainted 4.9.168+ #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.5.1 01/01/2011
> task: ffff880067b34900 task.stack: ffff880068998000
> RIP: 0010:[<ffffffff81895d6b>]  [<ffffffff81895d6b>] split_huge_page_to_list+0x8fb/0x1030 mm/huge_memory.c:2124
> RSP: 0018:ffff88006899f980  EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffffea00018f1700 RCX: 0000000000000000
> RDX: 1ffffd400031e2e7 RSI: 0000000000000001 RDI: ffffea00018f1738
> RBP: ffff88006899f9e8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: fffffbfff0d8b13e R12: ffffea00018f1400
> R13: ffffea00018f1400 R14: ffffea00018f1720 R15: ffffea00018f1401
> FS:  00007fa333996740(0000) GS:ffff88006c600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000040 CR3: 0000000066b9c000 CR4: 00000000000606f0
> Stack:
>  0000000000000246 ffff880067b34900 0000000000000000 ffff88007ffdc000
>  0000000000000000 ffff88006899f9e8 ffffffff812b4015 ffff880064c64e18
>  ffffea00018f1401 dffffc0000000000 ffffea00018f1700 0000000020ffd000
> Call Trace:
>  [<ffffffff818490f1>] split_huge_page include/linux/huge_mm.h:100 [inline]
>  [<ffffffff818490f1>] queue_pages_pte_range+0x7e1/0x1480 mm/mempolicy.c:538
>  [<ffffffff817ed0da>] walk_pmd_range mm/pagewalk.c:50 [inline]
>  [<ffffffff817ed0da>] walk_pud_range mm/pagewalk.c:90 [inline]
>  [<ffffffff817ed0da>] walk_pgd_range mm/pagewalk.c:116 [inline]
>  [<ffffffff817ed0da>] __walk_page_range+0x44a/0xdb0 mm/pagewalk.c:208
>  [<ffffffff817edb94>] walk_page_range+0x154/0x370 mm/pagewalk.c:285
>  [<ffffffff81844515>] queue_pages_range+0x115/0x150 mm/mempolicy.c:694
>  [<ffffffff8184f493>] do_mbind mm/mempolicy.c:1241 [inline]
>  [<ffffffff8184f493>] SYSC_mbind+0x3c3/0x1030 mm/mempolicy.c:1370
>  [<ffffffff81850146>] SyS_mbind+0x46/0x60 mm/mempolicy.c:1352
>  [<ffffffff810097e2>] do_syscall_64+0x1d2/0x600 arch/x86/entry/common.c:282
>  [<ffffffff82ff6f93>] entry_SYSCALL_64_after_swapgs+0x5d/0xdb
> Code: c7 80 1c 02 00 e8 26 0a 76 01 <0f> 0b 48 c7 c7 40 46 45 84 e8 4c
> RIP  [<ffffffff81895d6b>] split_huge_page_to_list+0x8fb/0x1030 mm/huge_memory.c:2124
>  RSP <ffff88006899f980>
> 
> with the below test:
> 
> ---8<---
> 
> uint64_t r[1] = {0xffffffffffffffff};
> 
> int main(void)
> {
>         syscall(__NR_mmap, 0x20000000, 0x1000000, 3, 0x32, -1, 0);
>                                 intptr_t res = 0;
>         res = syscall(__NR_socket, 0x11, 3, 0x300);
>         if (res != -1)
>                 r[0] = res;
> *(uint32_t*)0x20000040 = 0x10000;
> *(uint32_t*)0x20000044 = 1;
> *(uint32_t*)0x20000048 = 0xc520;
> *(uint32_t*)0x2000004c = 1;
>         syscall(__NR_setsockopt, r[0], 0x107, 0xd, 0x20000040, 0x10);
>         syscall(__NR_mmap, 0x20fed000, 0x10000, 0, 0x8811, r[0], 0);
> *(uint64_t*)0x20000340 = 2;
>         syscall(__NR_mbind, 0x20ff9000, 0x4000, 0x4002, 0x20000340,
> 0x45d4, 3);
>         return 0;
> }
> 
> ---8<---
> 
> Actually the test does:
> 
> mmap(0x20000000, 16777216, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x20000000
> socket(AF_PACKET, SOCK_RAW, 768)        = 3
> setsockopt(3, SOL_PACKET, PACKET_TX_RING, {block_size=65536, block_nr=1, frame_size=50464, frame_nr=1}, 16) = 0
> mmap(0x20fed000, 65536, PROT_NONE, MAP_SHARED|MAP_FIXED|MAP_POPULATE|MAP_DENYWRITE, 3, 0) = 0x20fed000
> mbind(..., MPOL_MF_STRICT|MPOL_MF_MOVE) = 0
> 
> The setsockopt() would allocate compound pages (16 pages in this test)
> for packet tx ring, then the mmap() would call packet_mmap() to map the
> pages into the user address space specified by the mmap() call.
> 
> When calling mbind(), it would scan the vma to queue the pages for
> migration to the new node.  It would split any huge page since 4.9
> doesn't support THP migration, however, the packet tx ring compound
> pages are not THP and even not movable.  So, the above bug is triggered.
> 
> However, the later kernel is not hit by this issue due to the
> commit d44d363f65780f2ac2 ("mm: don't assume anonymous pages have
> SwapBacked flag"), which just removes the PageSwapBacked check for a
> different reason.
> 
> But, there is a deeper issue.  According to the semantic of mbind(), it
> should return -EIO if MPOL_MF_MOVE or MPOL_MF_MOVE_ALL was specified and
> MPOL_MF_STRICT was also specified, but the kernel was unable to move
> all existing pages in the range.  The tx ring of the packet socket is
> definitely not movable, however, mbind() returns success for this case.
> 
> Although the most socket file associates with non-movable pages, but XDP
> may have movable pages from gup.  So, it sounds not fine to just check
> the underlying file type of vma in vma_migratable().
> 
> Change migrate_page_add() to check if the page is movable or not, if it
> is unmovable, just return -EIO.  But do not abort pte walk immediately,
> since there may be pages off LRU temporarily.  We should migrate other
> pages if MPOL_MF_MOVE* is specified.  Set has_unmovable flag if some
> paged could not be not moved, then return -EIO for mbind() eventually.
> 
> With this change the above test would return -EIO as expected.
> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!
