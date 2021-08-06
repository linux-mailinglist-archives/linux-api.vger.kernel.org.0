Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB64F3E235E
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 08:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242542AbhHFGkb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 02:40:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52750 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhHFGka (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 02:40:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7CB871FEA4;
        Fri,  6 Aug 2021 06:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628232014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1bzG7zeW8+sEcqaRFyAoUGVQNhJuHDuJNfvputWUxlU=;
        b=DFMfWgoIKq8k2jlf+f9b59bhzeS7lx/OpC0P2llTgssT7CnFQ41p1eTuaVxyugiTl6ZReo
        jLlb1T47D67orJMZCnQEoZcU32vZSOcHMLl9oZRTHw9csBnLC9EY6dzi4XYB2LVfOpkJBK
        xPFL7MtbPOvqOEo+fbdlh1G5pgmdTpY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BE076A3B8B;
        Fri,  6 Aug 2021 06:40:13 +0000 (UTC)
Date:   Fri, 6 Aug 2021 08:40:10 +0200
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
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
Message-ID: <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
References: <20210805170859.2389276-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805170859.2389276-1-surenb@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 05-08-21 10:08:58, Suren Baghdasaryan wrote:
[...]
> +	/*
> +	 * If the task is dying and in the process of releasing its memory
> +	 * then get its mm.
> +	 */
> +	p = find_lock_task_mm(task);
> +	if (!p) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +	if (task != p) {
> +		get_task_struct(p);
> +		put_task_struct(task);
> +		task = p;
> +	}

Why do you need to take a reference to the p here? You are under
task_lock so this will not go away and you only need p to get your mm.

> +
> +	/* If the work has been done already, just exit with success */
> +	if (test_bit(MMF_OOM_SKIP, &task->mm->flags))
> +		goto put_task;

You want to release the task_lock

> +
> +	if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {

you want task_will_free_mem(p) and what is the point of the PF_KTHREAD
check?

> +		mm = task->mm;
> +		mmget(mm);

All you need is to make sure mm will not get released under your feet
once task_lock is released so mmgrab is the right thing to do here. The
address space can be torn down in parallel and that is OK and desirable.

I think you really want something like this:

	if (flags)
		return -EINVAL;
	
	pid = pidfd_get_pid(fd, &f_flags);
	if (IS_ERR(pid))
		return PTR_ERR(pid);
	task = get_pid_task(pid, PIDTYPE_PID);
	if (!task) {
		ret = -ESRCH;
		goto put_pid;
	}

	/*
	 * Make sure to chose a thread which still has a reference to mm
	 * during the group exit
	 */
	p = find_lock_task_mm(task);
	if (!p) {
		ret = -ESRCH;
		goto put_task;
	}

	mm = task->mm;
	mmgrab(mm);
	reap = true;
	/* If the work has been done already, just exit with success */
	if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
		reap = false;
	} else if (!task_will_free_mem(p)) {
		reap = false;
		ret = -EINVAL;
	}
	task_unlock(p);

	if (!reap)
		goto dropmm;;

	/* Do the work*/


dropmm:
	mmdrop(mm);
put_task:
	put_task(task);
put_pid:
	put_pid(pid);

	return ret;

-- 
Michal Hocko
SUSE Labs
