Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5E13CFA8
	for <lists+linux-api@lfdr.de>; Wed, 15 Jan 2020 23:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAOWEW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jan 2020 17:04:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:48842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbgAOWEW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Jan 2020 17:04:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D273AB016;
        Wed, 15 Jan 2020 22:04:19 +0000 (UTC)
Subject: Re: [PATCH] mm/compaction: Disable compact_unevictable_allowed on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-mm@kvack.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
Date:   Wed, 15 Jan 2020 23:04:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200115161035.893221-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/15/2020 5:10 PM, Sebastian Andrzej Siewior wrote:
> Since commit
>     5bbe3547aa3ba ("mm: allow compaction of unevictable pages")
> 
> it is allowed to examine mlocked pages and compact them by default.
> On -RT even minor pagefaults are problematic because it may take a few
> 100us to resolve them and until then the task is blocked.

Fine, this makes sense on RT I guess. There might be some trade-off for
high-order allocation latencies though. We could perhaps migrate such mlocked
pages to pages allocated without __GFP_MOVABLE during the mlock() to at least
somewhat prevent them being scattered all over the zones. For MCL_FUTURE,
allocate them as unmovable from the beginning. But that can wait until issues
are reported.
I assume you have similar solution for NUMA balancing and whatever else can
cause minor faults?

> Make compact_unevictable_allowed = 0 default and remove it from /proc on
> RT.

Removing it is maybe going too far in terms of RT kernel differences confusing
users? Change the default sure, perhaps making it read-only, but removing?

> Link: https://lore.kernel.org/linux-mm/20190710144138.qyn4tuttdq6h7kqx@linutronix.de/

In any case the sysctl Documentation/ should be updated? And perhaps also the
mlock manpage as you noted in the older thread above?

Thanks,
Vlastimil

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/sysctl.c | 3 ++-
>  mm/compaction.c | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 70665934d53e2..d08bd51a0fbc3 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1488,6 +1488,7 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= &min_extfrag_threshold,
>  		.extra2		= &max_extfrag_threshold,
>  	},
> +#ifndef CONFIG_PREEMPT_RT
>  	{
>  		.procname	= "compact_unevictable_allowed",
>  		.data		= &sysctl_compact_unevictable_allowed,
> @@ -1497,7 +1498,7 @@ static struct ctl_table vm_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> -
> +#endif
>  #endif /* CONFIG_COMPACTION */
>  	{
>  		.procname	= "min_free_kbytes",
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 672d3c78c6abf..b2c804c35ae56 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1590,7 +1590,11 @@ typedef enum {
>   * Allow userspace to control policy on scanning the unevictable LRU for
>   * compactable pages.
>   */
> +#ifdef CONFIG_PREEMPT_RT
> +#define sysctl_compact_unevictable_allowed 0
> +#else
>  int sysctl_compact_unevictable_allowed __read_mostly = 1;
> +#endif
>  
>  static inline void
>  update_fast_start_pfn(struct compact_control *cc, unsigned long pfn)
> 

