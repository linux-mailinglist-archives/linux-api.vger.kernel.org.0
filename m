Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207F6273146
	for <lists+linux-api@lfdr.de>; Mon, 21 Sep 2020 19:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgIURzn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Sep 2020 13:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgIURzn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Sep 2020 13:55:43 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536C3C061755;
        Mon, 21 Sep 2020 10:55:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f2so9705572pgd.3;
        Mon, 21 Sep 2020 10:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qJvUV/ZOl5BC2PLiKGGB8lltWoSv68/dQ80XBoidpxw=;
        b=gXUGK058qlUtWe2n2PHDtsH3SQ8KxKbdgW1zrQ7FnQZUsuSRmenroG2zh0YKpRDXJZ
         Rf5fviou19jex1Zn2U133JPbz5mY7BuxAnVOsukLoXSc9kdgjoLCoWQ5LPMz0t2uiCgU
         nqCzExCVn3BQuEvoQCiQa4Ff4RDc16rW9kFdhxiKd9ZXTZl28dkAuPwlD7mE9TPIkJjP
         6BlJCJjstJ8VW6+WHpa1vEFCfTW1OuHxs6hptCngniXaT3dLryyqcgYtFfIV/S4zSu7Q
         bwCWIZUJG3QQascK6ZSLgu/yw7gsrVQUkC7XPaH/5c5NHUa9KfmyCEndl6ibycF9upWP
         4rvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qJvUV/ZOl5BC2PLiKGGB8lltWoSv68/dQ80XBoidpxw=;
        b=lrhokf3e6T+HGQnijyTrFSTi0a5Q8EuDlNQLf+i0OyekxMOJ0hR8ZOMF5iVxAw+fy3
         zbb2uLFNBtsnvu1oY9XQuUiLoduWH6u7eHdkAeatp5aBEOQkjrRHL9Fzyx7wq1gzKeHT
         DdRIlDj/SKhdFlVww48lEm8GFUbxMmxBAHkJ62wQ1ewZyExPYxPcpeZ3P6kMPIg4xR6v
         XfSBpdxBbuRmSENOkSo1DKD9LZ+ai9/xAHrAkR53cPhcIFmFHJFtdFEv8aGn8wcFMlQ1
         14Q4wKKxgz9SsGFMziUdI2/bjpg92EKPfAFRaif0liCfvCW23K8rK9Dru4MpxuTAVBPN
         LQfg==
X-Gm-Message-State: AOAM533fYouLooIGewa8pn4iksvc1/PsBuPiLws2v0JgiG+lsqX1jMFM
        SvQiVnMmsxFPmVBqVdv4rlo=
X-Google-Smtp-Source: ABdhPJwD0j76vWtv33Cc1/OzRKVsHaKhbghjvH2Xt/yyjEmum7e5KqJJsDsWFpImwDLAo/Y0dQv8XQ==
X-Received: by 2002:a63:f615:: with SMTP id m21mr624271pgh.154.1600710942737;
        Mon, 21 Sep 2020 10:55:42 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id e17sm12347576pff.6.2020.09.21.10.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 10:55:41 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 21 Sep 2020 10:55:39 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
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
Message-ID: <20200921175539.GB387368@google.com>
References: <20200901000633.1920247-1-minchan@kernel.org>
 <20200901000633.1920247-4-minchan@kernel.org>
 <20200921065633.GA8070@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921065633.GA8070@infradead.org>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 21, 2020 at 07:56:33AM +0100, Christoph Hellwig wrote:
> On Mon, Aug 31, 2020 at 05:06:33PM -0700, Minchan Kim wrote:
> > There is usecase that System Management Software(SMS) want to give a
> > memory hint like MADV_[COLD|PAGEEOUT] to other processes and in the
> > case of Android, it is the ActivityManagerService.
> > 
> > The information required to make the reclaim decision is not known to
> > the app.  Instead, it is known to the centralized userspace
> > daemon(ActivityManagerService), and that daemon must be able to
> > initiate reclaim on its own without any app involvement.
> > 
> > To solve the issue, this patch introduces a new syscall process_madvise(2).
> > It uses pidfd of an external process to give the hint. It also supports
> > vector address range because Android app has thousands of vmas due to
> > zygote so it's totally waste of CPU and power if we should call the
> > syscall one by one for each vma.(With testing 2000-vma syscall vs
> > 1-vector syscall, it showed 15% performance improvement.  I think it
> > would be bigger in real practice because the testing ran very cache
> > friendly environment).
> 
> I'm really not sure this syscall is a good idea.  If you want central
> control you should implement an IPC mechanisms that allows your
> supervisor daemon to tell the application to perform the madvice
> instead of forcing the behavior on it.

There was dicussion about the approach. There were several issues.
One of them was the target app was already freezed and we wanted
to run the syscall in caller's context, not callee.

> 
> >  /*
> >   * The madvise(2) system call.
> >   *
> > @@ -1036,6 +1049,11 @@ madvise_behavior_valid(int behavior)
> >   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
> >   *		from being included in its core dump.
> >   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
> > + *  MADV_COLD - the application is not expected to use this memory soon,
> > + *		deactivate pages in this range so that they can be reclaimed
> > + *		easily if memory pressure hanppens.
> > + *  MADV_PAGEOUT - the application is not expected to use this memory soon,
> > + *		page out the pages in this range immediately.
> 
> This should really go into a separate patch, as it has nothing to do
> with the new syscall.

Technically, right but I expected it's not worth to have separate patch.

> 
> > +static int process_madvise_vec(struct mm_struct *mm, struct iov_iter *iter, int behavior)
> > +{
> > +	struct iovec iovec;
> > +	int ret = 0;
> > +
> > +	while (iov_iter_count(iter)) {
> > +		iovec = iov_iter_iovec(iter);
> > +		ret = do_madvise(mm, (unsigned long)iovec.iov_base, iovec.iov_len, behavior);
> > +		if (ret < 0)
> > +			break;
> > +		iov_iter_advance(iter, iovec.iov_len);
> > +	}
> > +
> > +	return ret;
> 
> Please avoid the entirely pointless overly long line.
> 
> > +static inline int madv_import_iovec(int type, const struct iovec __user *uvec, unsigned int nr_segs,
> > +		unsigned int fast_segs, struct iovec **iov, struct iov_iter *i)
> > +{
> > +#ifdef CONFIG_COMPAT
> > +	if (in_compat_syscall())
> > +		return compat_import_iovec(type, (struct compat_iovec __user *)uvec, nr_segs,
> > +				fast_segs, iov, i);
> > +#endif
> 
> More of the same.
> 
> > +SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > +		unsigned long, vlen, int, behavior, unsigned int, flags)
> > +{
> > +	ssize_t ret;
> > +	struct iovec iovstack[UIO_FASTIOV];
> > +	struct iovec *iov = iovstack;
> > +	struct iov_iter iter;
> > +
> > +	ret = madv_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = do_process_madvise(pidfd, &iter, behavior, flags);
> > +	kfree(iov);
> > +	return ret;
> 
> Even more here.  But more importantly there seems to be absolutely
> no reason for the madv_import_iovec and do_process_madvise helpers
> that both are tiny and have this even smaller function as the only
> caller.

Fair enough.


Andrew, could you fold this patch?
Thank you.

From 02d63c6b3f61a1085f4eab80f5171bd2627b5ab0 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Mon, 21 Sep 2020 09:31:25 -0700
Subject: [PATCH] mm: do not use helper functions for process_madvise

This patch removes helper functions process_madvise_vec,
do_process_madvise and madv_import_iovec and use them inline.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 97 +++++++++++++++++++++++-----------------------------
 1 file changed, 43 insertions(+), 54 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index ae266dfede8a..aa8bc65dbdb6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1166,37 +1166,40 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }
 
-static int process_madvise_vec(struct mm_struct *mm, struct iov_iter *iter, int behavior)
-{
-	struct iovec iovec;
-	int ret = 0;
-
-	while (iov_iter_count(iter)) {
-		iovec = iov_iter_iovec(iter);
-		ret = do_madvise(mm, (unsigned long)iovec.iov_base, iovec.iov_len, behavior);
-		if (ret < 0)
-			break;
-		iov_iter_advance(iter, iovec.iov_len);
-	}
-
-	return ret;
-}
-
-static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
-				int behavior, unsigned int flags)
+SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
+		size_t, vlen, int, behavior, unsigned int, flags)
 {
 	ssize_t ret;
+	struct iovec iovstack[UIO_FASTIOV], iovec;
+	struct iovec *iov = iovstack;
+	struct iov_iter iter;
 	struct pid *pid;
 	struct task_struct *task;
 	struct mm_struct *mm;
-	size_t total_len = iov_iter_count(iter);
+	size_t total_len;
 
-	if (flags != 0)
-		return -EINVAL;
+	if (flags != 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		ret = compat_import_iovec(READ,
+				(struct compat_iovec __user *)vec, vlen,
+				ARRAY_SIZE(iovstack), &iov, &iter);
+	else
+#endif
+		ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
+				&iov, &iter);
+	if (ret < 0)
+		goto out;
 
 	pid = pidfd_get_pid(pidfd);
-	if (IS_ERR(pid))
-		return PTR_ERR(pid);
+	if (IS_ERR(pid)) {
+		ret = PTR_ERR(pid);
+		goto free_iov;
+	}
 
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
@@ -1216,43 +1219,29 @@ static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
 		goto release_task;
 	}
 
-	ret = process_madvise_vec(mm, iter, behavior);
-	if (ret >= 0)
-		ret = total_len - iov_iter_count(iter);
+	total_len = iov_iter_count(&iter);
+
+	while (iov_iter_count(&iter)) {
+		iovec = iov_iter_iovec(&iter);
+		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
+					iovec.iov_len, behavior);
+		if (ret < 0)
+			break;
+		iov_iter_advance(&iter, iovec.iov_len);
+	}
+
+	if (ret == 0)
+		ret = total_len - iov_iter_count(&iter);
 
 	mmput(mm);
+	return ret;
+
 release_task:
 	put_task_struct(task);
 put_pid:
 	put_pid(pid);
-	return ret;
-}
-
-static inline int madv_import_iovec(int type, const struct iovec __user *uvec, size_t nr_segs,
-		unsigned int fast_segs, struct iovec **iov, struct iov_iter *i)
-{
-#ifdef CONFIG_COMPAT
-	if (in_compat_syscall())
-		return compat_import_iovec(type, (struct compat_iovec __user *)uvec, nr_segs,
-				fast_segs, iov, i);
-#endif
-
-	return import_iovec(type, uvec, nr_segs, fast_segs, iov, i);
-}
-
-SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
-		size_t, vlen, int, behavior, unsigned int, flags)
-{
-	ssize_t ret;
-	struct iovec iovstack[UIO_FASTIOV];
-	struct iovec *iov = iovstack;
-	struct iov_iter iter;
-
-	ret = madv_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
-	if (ret < 0)
-		return ret;
-
-	ret = do_process_madvise(pidfd, &iter, behavior, flags);
+free_iov:
 	kfree(iov);
+out:
 	return ret;
 }
-- 
2.28.0.681.g6f77f65b4e-goog


