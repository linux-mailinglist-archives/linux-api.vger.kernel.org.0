Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 855F317A92C
	for <lists+linux-api@lfdr.de>; Thu,  5 Mar 2020 16:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEPsQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Mar 2020 10:48:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgCEPsQ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 5 Mar 2020 10:48:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 535D9AC37;
        Thu,  5 Mar 2020 15:48:14 +0000 (UTC)
Subject: Re: [PATCH v7 1/7] mm: pass task and mm to do_madvise
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Jens Axboe <axboe@kernel.dk>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-2-minchan@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2a767d50-4034-da8c-c40c-280e0dda910e@suse.cz>
Date:   Thu, 5 Mar 2020 16:48:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302193630.68771-2-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/2/20 8:36 PM, Minchan Kim wrote:
> In upcoming patches, do_madvise will be called from external process
> context so we shouldn't asssume "current" is always hinted process's
> task_struct.


> Furthermore, we couldn't access mm_struct via task->mm
> once it's verified by access_mm which will be introduced in next
> patch[1].

I would suggest to replace with:

Furthermore, we must not access mm_struct via task->mm, but obtain it via
access_mm() once (in the following patch) and only use that pointer [1], so pass
it to do_madvise() as well. Note the vma->vm_mm pointers are safe, so we can use
them further down the call stack.

> And let's pass *current* and current->mm as arguments of
> do_madvise so it shouldn't change existing behavior but prepare
> next patch to make review easy.
> 
> Note: io_madvise pass NULL as target_task argument of do_madvise
> because it couldn't know who is target.

             can't

> [1] http://lore.kernel.org/r/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jann Horn <jannh@google.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit:

> @@ -676,7 +677,6 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  	if (nr_swap) {
>  		if (current->mm == mm)
>  			sync_mm_rss(mm);
> -
>  		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
>  	}
>  	arch_leave_lazy_mmu_mode();

This looks stray and unrelated.
