Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123D42B49ED
	for <lists+linux-api@lfdr.de>; Mon, 16 Nov 2020 16:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbgKPPvi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 10:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730396AbgKPPvh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 10:51:37 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867FEC0613CF;
        Mon, 16 Nov 2020 07:51:37 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so14520421pfp.5;
        Mon, 16 Nov 2020 07:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L0xfL/n3M9jtte04xjeIvjNXBfbEgapxZwA8qK71lcA=;
        b=ep66z+4vsNHbYmfYG60LBTX4UGqJPQKyBXvZGL8wCQIZXSZw4blxFnENz3ucAidizO
         uye/N+TnkqWC45yguyDBQaDSYhWWJbsJ6BdyE8nQKs46tq26KIVXy9uQppHSy6gq/SrL
         iM3+5nb/sCtcF5W7Jt7ji11jkO3bT13a9GnZOigxcVGSmoAOmR7d9rffQE1QxP/hlcxc
         aFYUF7jNSu+MLqRdWLllQ/LXGIezK9XrDMw1AJ9PeHkQJ0qzs6Y6Bauoyz+8PhcGuAr+
         7sTwZBiTpk+PJkT3C14z6G6epJx1PLVbwagn4GXvee625/qvVjaCa7z6D4lD0gbgVF1X
         qJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=L0xfL/n3M9jtte04xjeIvjNXBfbEgapxZwA8qK71lcA=;
        b=M9YzdhVF06uFdU7swZfS20gj4YQho4wA1VoxhfNERchERuREtY/vypwRpulhGE5474
         HobAz1jNLv0/rEXmHWAUKRoaqwM/Co50h7J2p0BC5K52GkiJ3d8ndym2VBkLv/b4OsbP
         DKaoBo4oF5VJRN9WhkQaec9gsQ6Ws1pSHSD9lp38Wms/TBVEcAC09m7jVM64EwDkExiW
         yRdyvE9T0hVz2RGN9OQnpVCpDNmXl7SvXdfgbGbGb70iRNrzr9rwef3FLbqfVKNAxv5G
         vAqWIBLKCNRb82HcCEa0yHu18Ibl+ENbi2S6Li2ATHTQ4e6Jn0Qh3SL+VvPvmKZ8SPww
         aPWg==
X-Gm-Message-State: AOAM530HBHpsTHyPAFjBdUUHbIWXYvdHMF1exBJ6U5xdXLRU0okULb0W
        fwxakVxtxGov9+nJSKpw2aA=
X-Google-Smtp-Source: ABdhPJydLx6ffMP9PurUpQWfvBe9Wyy9Mb1BzB9ATM0ZTamhDV/epntT20eGMJbdNDhXcgLDZpGfHA==
X-Received: by 2002:a65:6205:: with SMTP id d5mr13483505pgv.76.1605541897062;
        Mon, 16 Nov 2020 07:51:37 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id y9sm3502183pjn.24.2020.11.16.07.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:51:35 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 16 Nov 2020 07:51:32 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
Message-ID: <20201116155132.GA3805951@google.com>
References: <20200901000633.1920247-1-minchan@kernel.org>
 <20200901000633.1920247-4-minchan@kernel.org>
 <20200921065633.GA8070@infradead.org>
 <20200921175539.GB387368@google.com>
 <a376191d-908d-7d3c-a810-8ef51cc45f49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a376191d-908d-7d3c-a810-8ef51cc45f49@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 16, 2020 at 10:02:42AM +0100, Eric Dumazet wrote:

< snip >

> > From 02d63c6b3f61a1085f4eab80f5171bd2627b5ab0 Mon Sep 17 00:00:00 2001
> > From: Minchan Kim <minchan@kernel.org>
> > Date: Mon, 21 Sep 2020 09:31:25 -0700
> > Subject: [PATCH] mm: do not use helper functions for process_madvise
> > 
> > This patch removes helper functions process_madvise_vec,
> > do_process_madvise and madv_import_iovec and use them inline.
> > 
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/madvise.c | 97 +++++++++++++++++++++++-----------------------------
> >  1 file changed, 43 insertions(+), 54 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index ae266dfede8a..aa8bc65dbdb6 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1166,37 +1166,40 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
> >  	return do_madvise(current->mm, start, len_in, behavior);
> >  }
> >  
> > -static int process_madvise_vec(struct mm_struct *mm, struct iov_iter *iter, int behavior)
> > -{
> > -	struct iovec iovec;
> > -	int ret = 0;
> > -
> > -	while (iov_iter_count(iter)) {
> > -		iovec = iov_iter_iovec(iter);
> > -		ret = do_madvise(mm, (unsigned long)iovec.iov_base, iovec.iov_len, behavior);
> > -		if (ret < 0)
> > -			break;
> > -		iov_iter_advance(iter, iovec.iov_len);
> > -	}
> > -
> > -	return ret;
> > -}
> > -
> > -static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> > -				int behavior, unsigned int flags)
> > +SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > +		size_t, vlen, int, behavior, unsigned int, flags)
> >  {
> >  	ssize_t ret;
> > +	struct iovec iovstack[UIO_FASTIOV], iovec;
> > +	struct iovec *iov = iovstack;
> > +	struct iov_iter iter;
> >  	struct pid *pid;
> >  	struct task_struct *task;
> >  	struct mm_struct *mm;
> > -	size_t total_len = iov_iter_count(iter);
> > +	size_t total_len;
> >  
> > -	if (flags != 0)
> > -		return -EINVAL;
> > +	if (flags != 0) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +#ifdef CONFIG_COMPAT
> > +	if (in_compat_syscall())
> > +		ret = compat_import_iovec(READ,
> > +				(struct compat_iovec __user *)vec, vlen,
> > +				ARRAY_SIZE(iovstack), &iov, &iter);
> > +	else
> > +#endif
> > +		ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
> > +				&iov, &iter);
> > +	if (ret < 0)
> > +		goto out;
> >  
> >  	pid = pidfd_get_pid(pidfd);
> > -	if (IS_ERR(pid))
> > -		return PTR_ERR(pid);
> > +	if (IS_ERR(pid)) {
> > +		ret = PTR_ERR(pid);
> > +		goto free_iov;
> > +	}
> >  
> >  	task = get_pid_task(pid, PIDTYPE_PID);
> >  	if (!task) {
> > @@ -1216,43 +1219,29 @@ static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> >  		goto release_task;
> >  	}
> >  
> > -	ret = process_madvise_vec(mm, iter, behavior);
> > -	if (ret >= 0)
> > -		ret = total_len - iov_iter_count(iter);
> > +	total_len = iov_iter_count(&iter);
> > +
> > +	while (iov_iter_count(&iter)) {
> > +		iovec = iov_iter_iovec(&iter);
> > +		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
> > +					iovec.iov_len, behavior);
> > +		if (ret < 0)
> > +			break;
> > +		iov_iter_advance(&iter, iovec.iov_len);
> > +	}
> > +
> > +	if (ret == 0)
> > +		ret = total_len - iov_iter_count(&iter);
> >  
> >  	mmput(mm);
> > +	return ret;
> 
> This "return ret;" seems quite wrong...

/me slaps self.

> 
> I will send the following :
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 416a56b8e757bf3465ab13cea51e0751ade2c745..cc9224a59e9fa07e41f9b4ad2e58b9c97889299b 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1231,7 +1231,6 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>                 ret = total_len - iov_iter_count(&iter);
>  
>         mmput(mm);
> -       return ret;
>  
>  release_task:
>         put_task_struct(task);
> 
> 
> 
> 
> > +
> >  release_task:
> >  	put_task_struct(task);
> >  put_pid:
> >  	put_pid(pid);
> > -	return ret;
> > -}

Thanks, Eric!

Let me send a patch with your SoB if you don't mind.

From 0f37d5295324721ee19a3ad40fe58e3002cd9934 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Nov 2020 07:34:02 -0800
Subject: [PATCH] mm/madvise: fix memory leak from process_madvise

The eary return in process_madvise will produce memory leak.
Fix it.

Fixes: ecb8ac8b1f14 ("mm/madvise: introduce process_madvise() syscall: an external memory hinting API")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 416a56b8e757..7e773f949ef9 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1231,8 +1231,6 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		ret = total_len - iov_iter_count(&iter);
 
 	mmput(mm);
-	return ret;
-
 release_task:
 	put_task_struct(task);
 put_pid:
-- 
2.29.2.299.gdc1121823c-goog

