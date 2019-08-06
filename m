Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC4382DDA
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2019 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfHFIgt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 6 Aug 2019 04:36:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57862 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730068AbfHFIgs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 6 Aug 2019 04:36:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A0BBEAF90;
        Tue,  6 Aug 2019 08:36:46 +0000 (UTC)
Subject: Re: [PATCH] mm/mempolicy.c: Remove unnecessary nodemask check in
 kernel_migrate_pages()
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        Linux API <linux-api@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
References: <20190806023634.55356-1-wangkefeng.wang@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <80f8da83-f425-1aab-f47e-8da41ec6dcbf@suse.cz>
Date:   Tue, 6 Aug 2019 10:36:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806023634.55356-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/6/19 4:36 AM, Kefeng Wang wrote:
> 1) task_nodes = cpuset_mems_allowed(current);
>    -> cpuset_mems_allowed() guaranteed to return some non-empty
>       subset of node_states[N_MEMORY].

Right, there's an explicit guarantee.

> 2) nodes_and(*new, *new, task_nodes);
>    -> after nodes_and(), the 'new' should be empty or appropriate
>       nodemask(online node and with memory).
> 
> After 1) and 2), we could remove unnecessary check whether the 'new'
> AND node_states[N_MEMORY] is empty.

Yeah looks like the check is there due to evolution of the code, where initially
it was added to prevent calling the syscall with bogus nodes, but now that's
achieved by cpuset_mems_allowed().

> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> 
> [QUESTION]
> 
> SYSCALL_DEFINE4(migrate_pages, pid_t, pid, unsigned long, maxnode,
>                 const unsigned long __user *, old_nodes,
>                 const unsigned long __user *, new_nodes)
> {
>         return kernel_migrate_pages(pid, maxnode, old_nodes, new_nodes);
> }
> 
> The migrate_pages() takes pid argument, witch is the ID of the process
> whose pages are to be moved. should the cpuset_mems_allowed(current) be
> cpuset_mems_allowed(task)?

The check for cpuset_mems_allowed(task) is just above the code you change, so
the new nodes have to be subset of the target task's cpuset.
But they also have to be allowed by the calling task's cpuset. In manpage of
migrate_pages(2), this is hinted by the NOTES "Use get_mempolicy(2) with the
MPOL_F_MEMS_ALLOWED flag to obtain the set of nodes that are allowed by the
calling process's cpuset..."

But perhaps the manpage should be better clarified:

- the EINVAL case includes "Or, none of the node IDs specified by new_nodes are
on-line and allowed by the process's current cpuset context, or none of the
specified nodes contain memory." - this should probably say "calling process" to
disambiguate
- the EPERM case should mention that new_nodes have to be subset of the target
process' cpuset context. The caller should also have CAP_SYS_NICE and
ptrace_may_access()

>  mm/mempolicy.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f48693f75b37..fceb44066184 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1467,10 +1467,6 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>  	if (nodes_empty(*new))
>  		goto out_put;
>  
> -	nodes_and(*new, *new, node_states[N_MEMORY]);
> -	if (nodes_empty(*new))
> -		goto out_put;
> -
>  	err = security_task_movememory(task);
>  	if (err)
>  		goto out_put;
> 

