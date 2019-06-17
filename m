Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 285FC485AE
	for <lists+linux-api@lfdr.de>; Mon, 17 Jun 2019 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfFQOir (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jun 2019 10:38:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:53368 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbfFQOir (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 17 Jun 2019 10:38:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AAABAEC3;
        Mon, 17 Jun 2019 14:38:44 +0000 (UTC)
Date:   Mon, 17 Jun 2019 16:38:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: Report number of memcg caches in slabinfo
Message-ID: <20190617143842.GC1492@dhcp22.suse.cz>
References: <20190617142149.5245-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617142149.5245-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Cc linux-api]

On Mon 17-06-19 10:21:49, Waiman Long wrote:
> There are concerns about memory leaks from extensive use of memory
> cgroups as each memory cgroup creates its own set of kmem caches. There
> is a possiblity that the memcg kmem caches may remain even after the
> memory cgroup removal.
> 
> Therefore, it will be useful to show how many memcg caches are present
> for each of the kmem caches.

How is a user going to use that information?  Btw. Don't we have an
interface to display the number of (dead) cgroups?

Keeping the rest of the email for the reference.

> As slabinfo reporting code has to iterate
> through all the memcg caches to get the final numbers anyway, there is
> no additional cost in reporting the number of memcg caches available.
> 
> The slabinfo version is bumped up to 2.2 as a new "<num_caches>" column
> is added at the end.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/slab_common.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 58251ba63e4a..c7aa47a99b2b 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1308,13 +1308,13 @@ static void print_slabinfo_header(struct seq_file *m)
>  	 * without _too_ many complaints.
>  	 */
>  #ifdef CONFIG_DEBUG_SLAB
> -	seq_puts(m, "slabinfo - version: 2.1 (statistics)\n");
> +	seq_puts(m, "slabinfo - version: 2.2 (statistics)\n");
>  #else
> -	seq_puts(m, "slabinfo - version: 2.1\n");
> +	seq_puts(m, "slabinfo - version: 2.2\n");
>  #endif
>  	seq_puts(m, "# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>");
>  	seq_puts(m, " : tunables <limit> <batchcount> <sharedfactor>");
> -	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail>");
> +	seq_puts(m, " : slabdata <active_slabs> <num_slabs> <sharedavail> <num_caches>");
>  #ifdef CONFIG_DEBUG_SLAB
>  	seq_puts(m, " : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> <alienoverflow>");
>  	seq_puts(m, " : cpustat <allochit> <allocmiss> <freehit> <freemiss>");
> @@ -1338,14 +1338,18 @@ void slab_stop(struct seq_file *m, void *p)
>  	mutex_unlock(&slab_mutex);
>  }
>  
> -static void
> +/*
> + * Return number of memcg caches.
> + */
> +static unsigned int
>  memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
>  {
>  	struct kmem_cache *c;
>  	struct slabinfo sinfo;
> +	unsigned int cnt = 0;
>  
>  	if (!is_root_cache(s))
> -		return;
> +		return 0;
>  
>  	for_each_memcg_cache(c, s) {
>  		memset(&sinfo, 0, sizeof(sinfo));
> @@ -1356,17 +1360,20 @@ memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
>  		info->shared_avail += sinfo.shared_avail;
>  		info->active_objs += sinfo.active_objs;
>  		info->num_objs += sinfo.num_objs;
> +		cnt++;
>  	}
> +	return cnt;
>  }
>  
>  static void cache_show(struct kmem_cache *s, struct seq_file *m)
>  {
>  	struct slabinfo sinfo;
> +	unsigned int nr_memcg_caches;
>  
>  	memset(&sinfo, 0, sizeof(sinfo));
>  	get_slabinfo(s, &sinfo);
>  
> -	memcg_accumulate_slabinfo(s, &sinfo);
> +	nr_memcg_caches = memcg_accumulate_slabinfo(s, &sinfo);
>  
>  	seq_printf(m, "%-17s %6lu %6lu %6u %4u %4d",
>  		   cache_name(s), sinfo.active_objs, sinfo.num_objs, s->size,
> @@ -1374,8 +1381,9 @@ static void cache_show(struct kmem_cache *s, struct seq_file *m)
>  
>  	seq_printf(m, " : tunables %4u %4u %4u",
>  		   sinfo.limit, sinfo.batchcount, sinfo.shared);
> -	seq_printf(m, " : slabdata %6lu %6lu %6lu",
> -		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail);
> +	seq_printf(m, " : slabdata %6lu %6lu %6lu %3u",
> +		   sinfo.active_slabs, sinfo.num_slabs, sinfo.shared_avail,
> +		   nr_memcg_caches);
>  	slabinfo_show_stats(m, s);
>  	seq_putc(m, '\n');
>  }
> -- 
> 2.18.1

-- 
Michal Hocko
SUSE Labs
