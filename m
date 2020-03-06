Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01117BA1C
	for <lists+linux-api@lfdr.de>; Fri,  6 Mar 2020 11:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgCFKWL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Mar 2020 05:22:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:57850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFKWL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 6 Mar 2020 05:22:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 55E98B1D2;
        Fri,  6 Mar 2020 10:22:09 +0000 (UTC)
Subject: Re: [PATCH v7 3/7] mm: check fatal signal pending of target process
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
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-4-minchan@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2f3a9530-483d-0861-3844-bc12d212dd93@suse.cz>
Date:   Fri, 6 Mar 2020 11:22:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302193630.68771-4-minchan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/2/20 8:36 PM, Minchan Kim wrote:
> Bail out to prevent unnecessary CPU overhead if target process has
> pending fatal signal during (MADV_COLD|MADV_PAGEOUT) operation.
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
>  mm/madvise.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 349473fc6683..6543f2bfc3d8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -36,6 +36,7 @@
>  struct madvise_walk_private {
>  	struct mmu_gather *tlb;
>  	bool pageout;
> +	struct task_struct *target_task;
>  };
>  
>  /*
> @@ -316,6 +317,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	if (fatal_signal_pending(current))
>  		return -EINTR;
>  
> +	if (private->target_task &&
> +			fatal_signal_pending(private->target_task))
> +		return -EINTR;

With madvise(2) private->target_task will be current, thus current will be
tested twice. Not wrong, but maybe add a "private->target_task != current"
condition?
