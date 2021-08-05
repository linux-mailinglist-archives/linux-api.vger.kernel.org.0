Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDCC3E0EE9
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 09:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhHEHKj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 03:10:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57236 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhHEHKi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 03:10:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2FF061FE2A;
        Thu,  5 Aug 2021 07:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628147424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oyvVbHlj5obJYiaLItZ1ogsQi32IrIb7/8pgtHva86I=;
        b=HIsf0MbBWCBatjQdI2swaBz2R1bGGbFhxcyVQi5x5DWK696tjML7N9fcm0Sxj4DXVi9Fxp
        Uc5r3EXUpNXRGE40C252lVaTabOzVe1afUlBSWPmB2LC7lPHBabXgKvMItV3eAjZ1rScFI
        +aEPnIk9LS9kOf6YLNNeU3vbSy2V29k=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B6318A3B97;
        Thu,  5 Aug 2021 07:10:23 +0000 (UTC)
Date:   Thu, 5 Aug 2021 09:10:23 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
Message-ID: <YQuO36AeQUwsAyU1@dhcp22.suse.cz>
References: <20210804185004.1304692-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804185004.1304692-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 04-08-21 11:50:03, Suren Baghdasaryan wrote:
[...]
> +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> +{
> +#ifdef CONFIG_MMU
> +	struct mm_struct *mm = NULL;
> +	struct task_struct *task;
> +	unsigned int f_flags;
> +	struct pid *pid;
> +	long ret = 0;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	pid = pidfd_get_pid(pidfd, &f_flags);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +
> +	/*
> +	 * If the task is dying and in the process of releasing its memory
> +	 * then get its mm.
> +	 */
> +	task = find_lock_task_mm(task);

You want a different task_struct because the returned one might be
different from the given one and you already hold a reference which you
do not want to leak

> +	if (!task) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> +		mm = task->mm;
> +		mmget(mm);
> +	}
> +	task_unlock(task);
> +	if (!mm) {
> +		ret = -EINVAL;
> +		goto put_task;
> +	}
> +
> +	if (test_bit(MMF_OOM_SKIP, &mm->flags))
> +		goto put_mm;

This is too late to check for MMF_OOM_SKIP. task_will_free_mem will fail
with the flag being set. I believe you want something like the
following:

	p = find_lock_task_mm(task);
	mm = p->mm;

	/* The work has been done already */
	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
		task_unlock(p);	
		goto put_task;
	}

	i
	if (!task_will_free_mem(p)) {
		task_unlock(p);	
		goto put_task;
	}

	mmget(mm);
	task_unlock(p);


> +
> +	if (mmap_read_lock_killable(mm)) {
> +		ret = -EINTR;
> +		goto put_mm;
> +	}
> +	if (!__oom_reap_task_mm(mm))
> +		ret = -EAGAIN;
> +	mmap_read_unlock(mm);
> +
> +put_mm:
> +	mmput(mm);
> +put_task:
> +	put_task_struct(task);
> +put_pid:
> +	put_pid(pid);
> +	return ret;
> +#else
> +	return -ENOSYS;
> +#endif /* CONFIG_MMU */
> +}
> -- 
> 2.32.0.554.ge1b32706d8-goog

-- 
Michal Hocko
SUSE Labs
