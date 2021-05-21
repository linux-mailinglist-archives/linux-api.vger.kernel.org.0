Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215AC38CEF7
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 22:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEUUWN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 16:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhEUUVh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 16:21:37 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9333C061344;
        Fri, 21 May 2021 13:20:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q15so15103467pgg.12;
        Fri, 21 May 2021 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pWlA6Z0uQRB5gmh7CBDFvCwLAhIx3wGTepMZkB5gO+4=;
        b=B6XPCCibCdHcokOHgjdOpDV2GQi58o9efG+Y1/QGN2ciJsBCG++oBKEfk3kXmwxHWH
         6nadoIF5c3yBq0FyavAg3v0dBWWzahw+RvXAPYNj2dMSMMkaO3RNqpck+nwNz+r4PLu0
         PcxQbT7NmCbWF+tEpDuiZ/DxOIEBK9CumePubWIWQybf72c+/oxUJA+yccZRP+yLOJW0
         n8ulSP+fZ4+JFQim6rSXv7qgkI1735MB40wcDxkiI57mjIrpXRk5PQPzFzA8DMOCLL5t
         jBoj8NoW2SoUv718YFcerKtWB0piXfqoyjmmHgfLlGaCBZvb6W+I8qaWAJszRNlcKGGW
         tCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pWlA6Z0uQRB5gmh7CBDFvCwLAhIx3wGTepMZkB5gO+4=;
        b=O9v4tIT5S8nDW0Ba6zNC1fWXKE0HrBgW5wT0Ul6COdlZyUYU/EpXf+D5v3jqEnZ0Oy
         wwFa9QrxvrsGhVevrq6epdf0mfpqh3iATAEIlwhExFPd0z9ShsFKG0O0PpptKg6YMbum
         LQhNiaHGnTy2iEBT+QvjKi7EtOqNBY3e4QIIoecLtMoE/zZSh3xWXUbxXQebN/Wazq/1
         qB8FgPvcfAi9/N/znVHKNPMFJLLCsuzhlIaCpD+hask4Uc4REYTFy+Q/RtoYGkT0t5tA
         qv5kF3hvmmgWU0EYnXBh317Bi+ylDhYE1KqQDzfk1fS1NJkzM+TJ5ISWTMSYcIO12gWS
         /iOA==
X-Gm-Message-State: AOAM5334kAtefu+6K+NFwScdtTvnaPyE6i/rBRfIhJ1cPJ0mUBRyLcYx
        AJs4duimlVtFkJhM9sO4yig=
X-Google-Smtp-Source: ABdhPJwFZYzfGBFc5kuLKBBKfFSW9Lt0OhoE/wvMQJJzC1BdE3N9Ue5UVpWThDIscXfoF2i6inw71Q==
X-Received: by 2002:aa7:839a:0:b029:27a:8c0b:3f5e with SMTP id u26-20020aa7839a0000b029027a8c0b3f5emr12152827pfm.69.1621628413028;
        Fri, 21 May 2021 13:20:13 -0700 (PDT)
Received: from gmail.com ([24.19.55.147])
        by smtp.gmail.com with ESMTPSA id d13sm4783563pfn.136.2021.05.21.13.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 13:20:12 -0700 (PDT)
Date:   Fri, 21 May 2021 13:17:11 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 7/9] sched/umcg: add UMCG server/worker API
 (early RFC)
Message-ID: <YKgVR5dM9RTZmCjh@gmail.com>
References: <20210520183614.1227046-1-posk@google.com>
 <20210520183614.1227046-8-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210520183614.1227046-8-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 11:36:12AM -0700, Peter Oskolkov wrote:
> Implement UMCG server/worker API.
> 
> This is an early RFC patch - the code seems working, but
> more testing is needed. Gaps I plan to address before this
> is ready for a detailed review:
> 
> - preemption/interrupt handling;
> - better documentation/comments;
> - tracing;
> - additional testing;
> - corner cases like abnormal process/task termination;
> - in some cases where I kill the task (umcg_segv), returning
> an error may be more appropriate.
> 
> All in all, please focus more on the high-level approach
> and less on things like variable names, (doc) comments, or indentation.
> 
> Signed-off-by: Peter Oskolkov <posk@google.com>
> ---
>  include/linux/mm_types.h |   5 +
>  include/linux/syscalls.h |   5 +
>  kernel/fork.c            |  11 +
>  kernel/sched/core.c      |  11 +
>  kernel/sched/umcg.c      | 764 ++++++++++++++++++++++++++++++++++++++-
>  kernel/sched/umcg.h      |  54 +++
>  mm/init-mm.c             |   4 +
>  7 files changed, 845 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6613b26a8894..5ca7b7d55775 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -562,6 +562,11 @@ struct mm_struct {
>  #ifdef CONFIG_IOMMU_SUPPORT
>  		u32 pasid;
>  #endif
> +
> +#ifdef CONFIG_UMCG
> +	spinlock_t umcg_lock;
> +	struct list_head umcg_groups;
> +#endif
>  	} __randomize_layout;
>  
>  	/*
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 15de3e34ccee..2781659daaf1 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1059,6 +1059,11 @@ asmlinkage long umcg_wait(u32 flags, const struct __kernel_timespec __user *time
>  asmlinkage long umcg_wake(u32 flags, u32 next_tid);
>  asmlinkage long umcg_swap(u32 wake_flags, u32 next_tid, u32 wait_flags,
>  				const struct __kernel_timespec __user *timeout);
> +asmlinkage long umcg_create_group(u32 api_version, u64, flags);
> +asmlinkage long umcg_destroy_group(u32 group_id);
> +asmlinkage long umcg_poll_worker(u32 flags, struct umcg_task __user **ut);
> +asmlinkage long umcg_run_worker(u32 flags, u32 worker_tid,
> +		struct umcg_task __user **ut);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ace4631b5b54..3a2a7950df8e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1026,6 +1026,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	seqcount_init(&mm->write_protect_seq);
>  	mmap_init_lock(mm);
>  	INIT_LIST_HEAD(&mm->mmlist);
> +#ifdef CONFIG_UMCG
> +	spin_lock_init(&mm->umcg_lock);
> +	INIT_LIST_HEAD(&mm->umcg_groups);
> +#endif
>  	mm->core_state = NULL;
>  	mm_pgtables_bytes_init(mm);
>  	mm->map_count = 0;
> @@ -1102,6 +1106,13 @@ static inline void __mmput(struct mm_struct *mm)
>  		list_del(&mm->mmlist);
>  		spin_unlock(&mmlist_lock);
>  	}
> +#ifdef CONFIG_UMCG
> +	if (!list_empty(&mm->umcg_groups)) {
> +		spin_lock(&mm->umcg_lock);
> +		list_del(&mm->umcg_groups);

I am not sure that I understand what is going on here. umsg_groups is
the head of a group list. list_del is usually called on list entries.

Should we enumirate all groups here and destroy them?

> +		spin_unlock(&mm->umcg_lock);
> +	}
> +#endif
>  	if (mm->binfmt)
>  		module_put(mm->binfmt->module);
>  	mmdrop(mm);

...

> +/**
> + * sys_umcg_create_group - create a UMCG group
> + * @api_version:           Requested API version.
> + * @flags:                 Reserved.
> + *
> + * Return:
> + * >= 0                - the group ID
> + * -EOPNOTSUPP         - @api_version is not supported
> + * -EINVAL             - @flags is not valid
> + * -ENOMEM             - not enough memory
> + */
> +SYSCALL_DEFINE2(umcg_create_group, u32, api_version, u64, flags)
> +{
> +	int ret;
> +	struct umcg_group *group;
> +	struct umcg_group *list_entry;
> +	struct mm_struct *mm = current->mm;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (__api_version(api_version))
> +		return -EOPNOTSUPP;
> +
> +	group = kzalloc(sizeof(struct umcg_group), GFP_KERNEL);
> +	if (!group)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&group->lock);
> +	INIT_LIST_HEAD(&group->list);
> +	INIT_LIST_HEAD(&group->waiters);
> +	group->flags = flags;
> +	group->api_version = api_version;
> +
> +	spin_lock(&mm->umcg_lock);
> +
> +	list_for_each_entry_rcu(list_entry, &mm->umcg_groups, list) {
> +		if (list_entry->group_id >= group->group_id)
> +			group->group_id = list_entry->group_id + 1;
> +	}

pls take into account that we need to be able to save and restore umcg
groups from user-space. There is the CRIU project that allows to
checkpoint/restore processes.

> +
> +	list_add_rcu(&mm->umcg_groups, &group->list);

I think it should be:

	list_add_rcu(&group->list, &mm->umcg_groups);
> +
> +	ret = group->group_id;
> +	spin_unlock(&mm->umcg_lock);
> +
> +	return ret;
> +}
> +

Thanks,
Andrei
