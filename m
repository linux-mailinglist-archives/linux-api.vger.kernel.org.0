Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D59F814CB6B
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 14:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgA2N1Y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 08:27:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:54060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgA2N1X (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 29 Jan 2020 08:27:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9439EAC46;
        Wed, 29 Jan 2020 13:27:20 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:27:19 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/6] clone3: allow spawning processes into cgroups
Message-ID: <20200129132719.GD11384@blackbody.suse.cz>
References: <20200121154844.411-1-christian.brauner@ubuntu.com>
 <20200121154844.411-6-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121154844.411-6-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello.

On Tue, Jan 21, 2020 at 04:48:43PM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> +static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
> +	__acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
> +{
> +	int ret;
> +	struct cgroup *dst_cgrp = NULL;
> +	struct css_set *cset;
> +	struct super_block *sb;
> +	struct file *f;
> +
> +	if (kargs->flags & CLONE_INTO_CGROUP)
> +		mutex_lock(&cgroup_mutex);
> +
> +	cgroup_threadgroup_change_begin(current);
> +
> +	spin_lock_irq(&css_set_lock);
> +	cset = task_css_set(current);
> +	get_css_set(cset);
> +	spin_unlock_irq(&css_set_lock);
> +
> +	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
> +		kargs->cset = cset;
Where is this css_set put when CLONE_INTO_CGROUP isn't used?
(Aha, it's passed to child's tsk->cgroups but see my other note below.)

> +	dst_cgrp = cgroup_get_from_file(f);
> +	if (IS_ERR(dst_cgrp)) {
> +		ret = PTR_ERR(dst_cgrp);
> +		dst_cgrp = NULL;
> +		goto err;
> +	}
> +
> +	/*
> +	 * Verify that we the target cgroup is writable for us. This is
> +	 * usually done by the vfs layer but since we're not going through
> +	 * the vfs layer here we need to do it "manually".
> +	 */
> +	ret = cgroup_may_write(dst_cgrp, sb);
> +	if (ret)
> +		goto err;
> +
> +	ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
> +					!!(kargs->flags & CLONE_THREAD));
> +	if (ret)
> +		goto err;
> +
> +	kargs->cset = find_css_set(cset, dst_cgrp);
> +	if (!kargs->cset) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	if (cgroup_is_dead(dst_cgrp)) {
> +		ret = -ENODEV;
> +		goto err;
> +	}
I'd move this check right after cgroup_get_from_file. The fork-migration
path is synchrinized via cgroup_mutex with cgroup_destroy_locked and
there's no need checking permissions on cgroup that's going away anyway.


> +static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
> +	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
> +{
> +	cgroup_threadgroup_change_end(current);
> +
> +	if (kargs->flags & CLONE_INTO_CGROUP) {
> +		struct cgroup *cgrp = kargs->cgrp;
> +		struct css_set *cset = kargs->cset;
> +
> +		mutex_unlock(&cgroup_mutex);
> +
> +		if (cset) {
> +			put_css_set(cset);
> +			kargs->cset = NULL;
> +		}
> +
> +		if (cgrp) {
> +			cgroup_put(cgrp);
> +			kargs->cgrp = NULL;
> +		}
> +	}
I don't see any function problem with this ordering, however, I'd
prefer symmetry with the "allocation" path (in cgroup_css_set_fork),
i.e. cgroup_put, put_css_set and lastly mutex_unlock.

> +void cgroup_post_fork(struct task_struct *child,
> +		      struct kernel_clone_args *kargs)
> +	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
>  {
>  	struct cgroup_subsys *ss;
> -	struct css_set *cset;
> +	struct css_set *cset = kargs->cset;
>  	int i;
>  
>  	spin_lock_irq(&css_set_lock);
>  
>  	WARN_ON_ONCE(!list_empty(&child->cg_list));
> -	cset = task_css_set(current); /* current is @child's parent */
> -	get_css_set(cset);
>  	cset->nr_tasks++;
>  	css_set_move_task(child, NULL, cset, false);
So, the reference is passed over from kargs->cset to task->cgroups. I
think it's necessary to zero kargs->cset in order to prevent droping the 
reference in cgroup_css_set_put_fork.
Perhaps, a general comment about css_set whereabouts during fork and
kargs passing would be useful.

> @@ -6016,6 +6146,17 @@ void cgroup_post_fork(struct task_struct *child)
>  	} while_each_subsys_mask();
>  
>  	cgroup_threadgroup_change_end(current);
> +
> +	if (kargs->flags & CLONE_INTO_CGROUP) {
> +		mutex_unlock(&cgroup_mutex);
> +
> +		cgroup_put(kargs->cgrp);
> +		kargs->cgrp = NULL;
> +	}
> +
> +	/* Make the new cset the root_cset of the new cgroup namespace. */
> +	if (kargs->flags & CLONE_NEWCGROUP)
> +		child->nsproxy->cgroup_ns->root_cset = cset;
root_cset reference (from copy_cgroup_ns) seems leaked here and where is
the additional reference to new cset obtained?

Thanks,
Michal
