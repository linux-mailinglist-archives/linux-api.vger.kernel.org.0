Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BF7271B28
	for <lists+linux-api@lfdr.de>; Mon, 21 Sep 2020 08:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIUG4l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Sep 2020 02:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIUG4l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Sep 2020 02:56:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A46C061755;
        Sun, 20 Sep 2020 23:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=md7y5e0HfZ1GvUz4qtvne4abAY5FcLsckYHQg6+5lwk=; b=TwmIb7j7s/EhHzRsO+fjzmtM0w
        hSz6/NAIH+PW0N60E6ZKqCDxVD+5kC32d/y2WJAdFpVIhOrJGhA1kZjoZ8+ag3tRqldF59Ntymt/R
        UYisBw69nueYH5xPgn7roJdfZqH9hPzTiYv6+PSsTHbLFU5NOEJDVxQzFEtmF16zofaHXbKlKPDRl
        iCbEfq4zBUJvNSM+wleDMPmA9PT7IgaDPxn8rr50JeynC92bRMAydCmz/w3mAQPJU8hy6Um0pKPZd
        iLyOz9f0lNwDdqFRropjn2SWG/3vDlgvrFEiyIaCOaCsXHx/ssKPiFx4oBW/3rTKofvmiZFcs+Wwj
        vGU1Lo8A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKFkX-00026F-FF; Mon, 21 Sep 2020 06:56:33 +0000
Date:   Mon, 21 Sep 2020 07:56:33 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20200921065633.GA8070@infradead.org>
References: <20200901000633.1920247-1-minchan@kernel.org>
 <20200901000633.1920247-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901000633.1920247-4-minchan@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Aug 31, 2020 at 05:06:33PM -0700, Minchan Kim wrote:
> There is usecase that System Management Software(SMS) want to give a
> memory hint like MADV_[COLD|PAGEEOUT] to other processes and in the
> case of Android, it is the ActivityManagerService.
> 
> The information required to make the reclaim decision is not known to
> the app.  Instead, it is known to the centralized userspace
> daemon(ActivityManagerService), and that daemon must be able to
> initiate reclaim on its own without any app involvement.
> 
> To solve the issue, this patch introduces a new syscall process_madvise(2).
> It uses pidfd of an external process to give the hint. It also supports
> vector address range because Android app has thousands of vmas due to
> zygote so it's totally waste of CPU and power if we should call the
> syscall one by one for each vma.(With testing 2000-vma syscall vs
> 1-vector syscall, it showed 15% performance improvement.  I think it
> would be bigger in real practice because the testing ran very cache
> friendly environment).

I'm really not sure this syscall is a good idea.  If you want central
control you should implement an IPC mechanisms that allows your
supervisor daemon to tell the application to perform the madvice
instead of forcing the behavior on it.

>  /*
>   * The madvise(2) system call.
>   *
> @@ -1036,6 +1049,11 @@ madvise_behavior_valid(int behavior)
>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>   *		from being included in its core dump.
>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> + *  MADV_COLD - the application is not expected to use this memory soon,
> + *		deactivate pages in this range so that they can be reclaimed
> + *		easily if memory pressure hanppens.
> + *  MADV_PAGEOUT - the application is not expected to use this memory soon,
> + *		page out the pages in this range immediately.

This should really go into a separate patch, as it has nothing to do
with the new syscall.

> +static int process_madvise_vec(struct mm_struct *mm, struct iov_iter *iter, int behavior)
> +{
> +	struct iovec iovec;
> +	int ret = 0;
> +
> +	while (iov_iter_count(iter)) {
> +		iovec = iov_iter_iovec(iter);
> +		ret = do_madvise(mm, (unsigned long)iovec.iov_base, iovec.iov_len, behavior);
> +		if (ret < 0)
> +			break;
> +		iov_iter_advance(iter, iovec.iov_len);
> +	}
> +
> +	return ret;

Please avoid the entirely pointless overly long line.

> +static inline int madv_import_iovec(int type, const struct iovec __user *uvec, unsigned int nr_segs,
> +		unsigned int fast_segs, struct iovec **iov, struct iov_iter *i)
> +{
> +#ifdef CONFIG_COMPAT
> +	if (in_compat_syscall())
> +		return compat_import_iovec(type, (struct compat_iovec __user *)uvec, nr_segs,
> +				fast_segs, iov, i);
> +#endif

More of the same.

> +SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> +		unsigned long, vlen, int, behavior, unsigned int, flags)
> +{
> +	ssize_t ret;
> +	struct iovec iovstack[UIO_FASTIOV];
> +	struct iovec *iov = iovstack;
> +	struct iov_iter iter;
> +
> +	ret = madv_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = do_process_madvise(pidfd, &iter, behavior, flags);
> +	kfree(iov);
> +	return ret;

Even more here.  But more importantly there seems to be absolutely
no reason for the madv_import_iovec and do_process_madvise helpers
that both are tiny and have this even smaller function as the only
caller.
