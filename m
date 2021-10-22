Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6699843736D
	for <lists+linux-api@lfdr.de>; Fri, 22 Oct 2021 10:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhJVIFt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 Oct 2021 04:05:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34640 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhJVIFs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 Oct 2021 04:05:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 37FE92197F;
        Fri, 22 Oct 2021 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634889810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HvhUhgJHwAx55o4YokA22XdtEWzDOauJw0wkGsftkJE=;
        b=Ci7jMbyro7pQNwCkLt8dItkEIHsVqVyHs4jNAWucpPnB3LJ58r81yzRR7DWgn/zlVOC4th
        lDfyRSuTDVMiwda1ZAD2UfB+0cbM9uVlafVhIiS9fyXrogMf4tGdQqLERlYFSXliPOhe5f
        xC3Yg1khDW6b0OvksM2FGzhz0Nap7IE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 845CCA3B83;
        Fri, 22 Oct 2021 08:03:29 +0000 (UTC)
Date:   Fri, 22 Oct 2021 10:03:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and
 exit_mmap
Message-ID: <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
References: <20211022014658.263508-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022014658.263508-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 21-10-21 18:46:58, Suren Baghdasaryan wrote:
> Race between process_mrelease and exit_mmap, where free_pgtables is
> called while __oom_reap_task_mm is in progress, leads to kernel crash
> during pte_offset_map_lock call. oom-reaper avoids this race by setting
> MMF_OOM_VICTIM flag and causing exit_mmap to take and release
> mmap_write_lock, blocking it until oom-reaper releases mmap_read_lock.
> Reusing MMF_OOM_VICTIM for process_mrelease would be the simplest way to
> fix this race, however that would be considered a hack. Fix this race
> by elevating mm->mm_users and preventing exit_mmap from executing until
> process_mrelease is finished. Patch slightly refactors the code to adapt
> for a possible mmget_not_zero failure.
> This fix has considerable negative impact on process_mrelease performance
> and will likely need later optimization.

I am not sure there is any promise that process_mrelease will run in
parallel with the exiting process. In fact the primary purpose of this
syscall is to provide a reliable way to oom kill from user space. If you
want to optimize process exit resp. its exit_mmap part then you should
be using other means. So I would be careful calling this a regression.

I do agree that taking the reference count is the right approach here. I
was wrong previously [1] when saying that pinning the mm struct is
sufficient. I have completely forgot about the subtle sync in exit_mmap.
One way we can approach that would be to take exclusive mmap_sem
throughout the exit_mmap unconditionally. There was a push back against
that though so arguments would have to be re-evaluated.

[1] http://lkml.kernel.org/r/YQzZqFwDP7eUxwcn@dhcp22.suse.cz

That being said
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> Fixes: 884a7e5964e0 ("mm: introduce process_mrelease system call")
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/oom_kill.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 831340e7ad8b..989f35a2bbb1 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1150,7 +1150,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	struct task_struct *task;
>  	struct task_struct *p;
>  	unsigned int f_flags;
> -	bool reap = true;
> +	bool reap = false;
>  	struct pid *pid;
>  	long ret = 0;
>  
> @@ -1177,15 +1177,15 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  		goto put_task;
>  	}
>  
> -	mm = p->mm;
> -	mmgrab(mm);
> -
> -	/* If the work has been done already, just exit with success */
> -	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> -		reap = false;
> -	else if (!task_will_free_mem(p)) {
> -		reap = false;
> -		ret = -EINVAL;
> +	if (mmget_not_zero(p->mm)) {
> +		mm = p->mm;
> +		if (task_will_free_mem(p))
> +			reap = true;
> +		else {
> +			/* Error only if the work has not been done already */
> +			if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> +				ret = -EINVAL;
> +		}
>  	}
>  	task_unlock(p);
>  
> @@ -1201,7 +1201,8 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>  	mmap_read_unlock(mm);
>  
>  drop_mm:
> -	mmdrop(mm);
> +	if (mm)
> +		mmput(mm);
>  put_task:
>  	put_task_struct(task);
>  put_pid:
> -- 
> 2.33.0.1079.g6e70778dc9-goog

-- 
Michal Hocko
SUSE Labs
