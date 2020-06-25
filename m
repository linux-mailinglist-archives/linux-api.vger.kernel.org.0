Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013C920A6E3
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2020 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405336AbgFYUi6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jun 2020 16:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404887AbgFYUi6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jun 2020 16:38:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F6C08C5C1;
        Thu, 25 Jun 2020 13:38:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b7so3805970pju.0;
        Thu, 25 Jun 2020 13:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fal5fqZa3XRJjCDuPEDO6zOzKkuAxW+azO7zrgA/xGY=;
        b=aLT7qv2dcaqHBFn4kQfpKHtVN6sYDmcOrsDuprsoieasLVliTBRM5T7A0pMy0gAIuq
         uvzufWdVBX/DMTjf4ECX6E6STgixlstptr4e2vkMqq18VpTcSn3n6SX9js5Om4xyiV9a
         DYp1o9qmkI/I0JFPZ1ZsEOcWwNf0eWWiJH54+iyf/YzTO2q5UB6e5A+GF2QwIXs4sBHd
         b1XL1CvOk3K67j/6DY0PI+3Wo0o7O6kajqv1f0evKIOwUjPwHHFN/mhXBh2WfNEsb2mV
         bE52EFH9Miu4IddBuds+4aDN4vFcKbEYyPvEGkVQyQMfHXPS9cG06ZWTZDoXqYY49Ul1
         nUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fal5fqZa3XRJjCDuPEDO6zOzKkuAxW+azO7zrgA/xGY=;
        b=kvHx32n84pLF9E5ZT7wsR2KyCNx3N4+ZRkfiOLdKsjQ3RDaFKKehOyzATTHTxSQwVj
         akSAORh5ojQjbdtJtsZmKSBixsm/WlYVyYSo2u9TuWZh/c+ua+kfJMd0cDnW/Ur7UP2R
         Acpsqkh3yVaeQDZAEc3EQOh+lj3T3brzdR+rMjbziqxCl+U6XpivxnY46+VT37Zw2c/h
         y/igIsEEeXm2cPrLimM+35G9mOjuEqvsQMvgb+8xpsgjVemcFzOGaxPZhEkQj5HVsSc9
         myPYjsJzOo1xDeEstCBlmHUMk11Unoda+CVvfYWF9qmffi1DoAU3hiqgu26B2H3hMWWE
         dcTA==
X-Gm-Message-State: AOAM533ZnfqIx4dwdrWNnQLeg3fiANm/b6WpmE1XcloGKc8F1D6i6lNX
        hHaNJ/nYwPOM790Vm8SgA84=
X-Google-Smtp-Source: ABdhPJwHUrhTo0VdWyqXJVodPYWb24wQPdUWi/z7ywPj+PvwIUdMoVmkl8yxs2jJOixXvCCSjCoc6w==
X-Received: by 2002:a17:90a:a383:: with SMTP id x3mr5457506pjp.199.1593117537570;
        Thu, 25 Jun 2020 13:38:57 -0700 (PDT)
Received: from google.com ([2601:647:4001:3000::e690])
        by smtp.gmail.com with ESMTPSA id y7sm9823972pjm.54.2020.06.25.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 13:38:55 -0700 (PDT)
Date:   Thu, 25 Jun 2020 13:38:52 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20200625203852.GA55572@google.com>
References: <20200622192900.22757-1-minchan@kernel.org>
 <20200622192900.22757-4-minchan@kernel.org>
 <alpine.DEB.2.22.394.2006241251080.35388@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006241251080.35388@chino.kir.corp.google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 24, 2020 at 01:00:14PM -0700, David Rientjes wrote:
> On Mon, 22 Jun 2020, Minchan Kim wrote:
> 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 551ed816eefe..23abca3f93fa 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/falloc.h>
> >  #include <linux/fadvise.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/ksm.h>
> >  #include <linux/fs.h>
> >  #include <linux/file.h>
> > @@ -995,6 +996,18 @@ madvise_behavior_valid(int behavior)
> >  	}
> >  }
> >  
> > +static bool
> > +process_madvise_behavior_valid(int behavior)
> > +{
> > +	switch (behavior) {
> > +	case MADV_COLD:
> > +	case MADV_PAGEOUT:
> > +		return true;
> > +	default:
> > +		return false;
> > +	}
> > +}
> > +
> >  /*
> >   * The madvise(2) system call.
> >   *
> > @@ -1042,6 +1055,11 @@ madvise_behavior_valid(int behavior)
> >   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> >   *		from being included in its core dump.
> >   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> > + *  MADV_COLD - the application is not expected to use this memory soon,
> > + *		deactivate pages in this range so that they can be reclaimed
> > + *		easily if memory pressure hanppens.
> > + *  MADV_PAGEOUT - the application is not expected to use this memory soon,
> > + *		page out the pages in this range immediately.
> >   *
> >   * return values:
> >   *  zero    - success
> > @@ -1176,3 +1194,106 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> >  {
> >  	return do_madvise(current, current->mm, start, len_in, behavior);
> >  }
> > +
> > +static int process_madvise_vec(struct task_struct *target_task,
> > +		struct mm_struct *mm, struct iov_iter *iter, int behavior)
> > +{
> > +	struct iovec iovec;
> > +	int ret = 0;
> > +
> > +	while (iov_iter_count(iter)) {
> > +		iovec = iov_iter_iovec(iter);
> > +		ret = do_madvise(target_task, mm, (unsigned long)iovec.iov_base,
> > +					iovec.iov_len, behavior);
> > +		if (ret < 0)
> > +			break;
> > +		iov_iter_advance(iter, iovec.iov_len);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> > +				int behavior, unsigned int flags)
> > +{
> > +	ssize_t ret;
> > +	struct pid *pid;
> > +	struct task_struct *task;
> > +	struct mm_struct *mm;
> > +	size_t total_len = iov_iter_count(iter);
> > +
> > +	if (flags != 0)
> > +		return -EINVAL;
> > +
> > +	pid = pidfd_get_pid(pidfd);
> > +	if (IS_ERR(pid))
> > +		return PTR_ERR(pid);
> > +
> > +	task = get_pid_task(pid, PIDTYPE_PID);
> > +	if (!task) {
> > +		ret = -ESRCH;
> > +		goto put_pid;
> > +	}
> > +
> > +	if (task->mm != current->mm &&
> > +			!process_madvise_behavior_valid(behavior)) {
> > +		ret = -EINVAL;
> > +		goto release_task;
> > +	}
> > +
> > +	mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > +	if (IS_ERR_OR_NULL(mm)) {
> > +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > +		goto release_task;
> > +	}
> > 
> 
> mm is always task->mm right?  I'm wondering if it would be better to find 
> the mm directly in process_madvise_vec() rather than passing it into the 
> function.  I'm not sure why we'd pass both task and mm here.

That's because of hint Jann provided in the past version.
https://lore.kernel.org/linux-api/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com/

Thanks for the review, David.
