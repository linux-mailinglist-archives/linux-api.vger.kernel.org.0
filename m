Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599EF207C8B
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391421AbgFXUAT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 16:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391221AbgFXUAR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 16:00:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E85BC061795
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 13:00:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j1so1687215pfe.4
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t4v5KqGdhOyQDdtaopLkokN0MyYgv8PQbu6M776ynnU=;
        b=pc8morrKQjJuftmGPd9dqzIkqrfZU6KhnvfDKy4deJbIsgbmlJrhbl+IgKDXgW0imd
         leJ2wlzd5Jfm3/iS6XwM7rf9p0Jr4xb90Z9+STbBP3U2BVt8/bao7D/+DnUtUbyn+hwf
         xlGs87BYYs+qeZjmkswUttP8DxX4DTpQ618DlxqoGhGVPWdPeGo0Kw7cIjBuHDmXv622
         FthieZpfV2Je42+7ai1OM7aVJUC+PDRKm1kvKP4GpH/n195TpXZJZXkxUBZNTfnAeyG/
         br2Q47pxLqA/C2DR0FPwsDHTV3iD7EwDTi4Qj+gbSmFXg56VIxIvyY0OC/mkOAfQkhxu
         76nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t4v5KqGdhOyQDdtaopLkokN0MyYgv8PQbu6M776ynnU=;
        b=Kx5LfUOjBU5nEaq6XzcJr8PdjSKgRSLYJ3rod0Ygm/aayBBegiUxBjPCCbzeCDkZ01
         tEat4ueTAfFsiXBjcUz92cV+8T+4PRf/4GmyZIXenU3fyZJgAtziA7iX505BQS0b7sbz
         6I9LrJy1HPQwOetDU8QyuPP7UV1N3PLpUJxqF4tB+SwaeebphcRJyKqA8ya7CsNTfZbE
         0mF+N3RyiIV2wM2tvFd+DoAr3KiHf+PnjGcDOkuywZlwjHUemd3kEB7FnBlWoXIshxCf
         ojPyoWPAb2CbpISQLvZrvoI/qY1Sl4boDezZhNHnYLxUSfUi6EFiAGtNKwiXuozAILnw
         QMyQ==
X-Gm-Message-State: AOAM531sfRL9GD727nKOrf6Co+xDB2TJ37xq5Zx+Ph49cciCwG+RNCRI
        8ORIG9Vejs8sY/A2NxMxNiJsdz3SsFY=
X-Google-Smtp-Source: ABdhPJzfhyuza8cK2CGRBHpWh4arBB6aBqScHlMM2IiEkCJmqIKSvNvriANHw5n+fd5gXC4KXu9pHw==
X-Received: by 2002:a63:481:: with SMTP id 123mr21855027pge.2.1593028815929;
        Wed, 24 Jun 2020 13:00:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 4sm20452879pfn.205.2020.06.24.13.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:00:15 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:00:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Minchan Kim <minchan@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
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
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
In-Reply-To: <20200622192900.22757-4-minchan@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2006241251080.35388@chino.kir.corp.google.com>
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-4-minchan@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 22 Jun 2020, Minchan Kim wrote:

> diff --git a/mm/madvise.c b/mm/madvise.c
> index 551ed816eefe..23abca3f93fa 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -17,6 +17,7 @@
>  #include <linux/falloc.h>
>  #include <linux/fadvise.h>
>  #include <linux/sched.h>
> +#include <linux/sched/mm.h>
>  #include <linux/ksm.h>
>  #include <linux/fs.h>
>  #include <linux/file.h>
> @@ -995,6 +996,18 @@ madvise_behavior_valid(int behavior)
>  	}
>  }
>  
> +static bool
> +process_madvise_behavior_valid(int behavior)
> +{
> +	switch (behavior) {
> +	case MADV_COLD:
> +	case MADV_PAGEOUT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  /*
>   * The madvise(2) system call.
>   *
> @@ -1042,6 +1055,11 @@ madvise_behavior_valid(int behavior)
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *		from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> + *  MADV_COLD - the application is not expected to use this memory soon,
> + *		deactivate pages in this range so that they can be reclaimed
> + *		easily if memory pressure hanppens.
> + *  MADV_PAGEOUT - the application is not expected to use this memory soon,
> + *		page out the pages in this range immediately.
>   *
>   * return values:
>   *  zero    - success
> @@ -1176,3 +1194,106 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  {
>  	return do_madvise(current, current->mm, start, len_in, behavior);
>  }
> +
> +static int process_madvise_vec(struct task_struct *target_task,
> +		struct mm_struct *mm, struct iov_iter *iter, int behavior)
> +{
> +	struct iovec iovec;
> +	int ret = 0;
> +
> +	while (iov_iter_count(iter)) {
> +		iovec = iov_iter_iovec(iter);
> +		ret = do_madvise(target_task, mm, (unsigned long)iovec.iov_base,
> +					iovec.iov_len, behavior);
> +		if (ret < 0)
> +			break;
> +		iov_iter_advance(iter, iovec.iov_len);
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> +				int behavior, unsigned int flags)
> +{
> +	ssize_t ret;
> +	struct pid *pid;
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	size_t total_len = iov_iter_count(iter);
> +
> +	if (flags != 0)
> +		return -EINVAL;
> +
> +	pid = pidfd_get_pid(pidfd);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	if (!task) {
> +		ret = -ESRCH;
> +		goto put_pid;
> +	}
> +
> +	if (task->mm != current->mm &&
> +			!process_madvise_behavior_valid(behavior)) {
> +		ret = -EINVAL;
> +		goto release_task;
> +	}
> +
> +	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> +	if (IS_ERR_OR_NULL(mm)) {
> +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +		goto release_task;
> +	}
> 

mm is always task->mm right?  I'm wondering if it would be better to find 
the mm directly in process_madvise_vec() rather than passing it into the 
function.  I'm not sure why we'd pass both task and mm here.

+
> +	ret = process_madvise_vec(task, mm, iter, behavior);
> +	if (ret >= 0)
> +		ret = total_len - iov_iter_count(iter);
> +
> +	mmput(mm);
> +release_task:
> +	put_task_struct(task);
> +put_pid:
> +	put_pid(pid);
> +	return ret;
> +}
> +
> +SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> +		unsigned long, vlen, int, behavior, unsigned int, flags)

I love the idea of adding the flags parameter here and I can think of an 
immediate use case for MADV_HUGEPAGE, which is overloaded.

Today, MADV_HUGEPAGE controls enablement depending on system config and 
controls defrag behavior based on system config.  It also cannot be opted 
out of without setting MADV_NOHUGEPAGE :)

I was thinking of a flag that users could use to trigger an immediate 
collapse in process context regardless of the system config.

So I'm a big advocate of this flags parameter and consider it an absolute 
must for the API.

Acked-by: David Rientjes <rientjes@google.com>
