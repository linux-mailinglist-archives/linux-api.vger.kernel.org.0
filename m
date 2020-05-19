Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3458B1D9EF5
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2020 20:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgESSOv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 14:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgESSOu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 14:14:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4AC08C5C0;
        Tue, 19 May 2020 11:14:50 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so226829plt.5;
        Tue, 19 May 2020 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h9siz1ifxNEzV/qBCHo46GlRWY7rdqYU0IVXQ8ULV+0=;
        b=Vxdb1epaiYwg+hDwLEaNLl/vxXzEEwzPjc7+0NXg/tl3VvgdCuGKz9xQ6q4PvOXFMx
         P7x5P5CdIwxTuZwtoxixWJOu0JD3l19Nd2/PWYkOrlYmR6Fux441ZCmH9bJ+2CZPfyyN
         zq0W/lQHiqsLZ7XJXz1v5JwPzUIUjOFN+4V3neojB15XwStV3+td8NvLhme9XQsndkz9
         Ini8TkKT2domPEZcK3d2Qa17SFZ1k+B+nYy7ipjkayg24SBodUSkHWFwne5nJgwM1Bd8
         wpzj7y2YB8lTCk1F0Vr7sD3YLUQ1TVg/vN4mzXjQ4YWcPxXgJNvz2LXPGb1APF7+GXU2
         vgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h9siz1ifxNEzV/qBCHo46GlRWY7rdqYU0IVXQ8ULV+0=;
        b=TDu/u4ynxZEMh4FzsG5isW5akonRqLlkBI9u9h5kKK6YqL99qdeENVEg79lk/Ax51E
         LZLDsME7Pc++wW6MiamQwD9fdSiaV0foxwGqTxKhX1+ekB2c79/jHhfBTHwBV+lfr5hp
         L9OyyKxLyZrJZ9r+m2J1FhOI1p+yMtKbuYSpWWl4K9pO+utAMsvLMevD90j5MQw3xA8V
         CUwvV85cD9TT/GHX21r/vIdwJlRYbnRF/7K92MEpKGY2bz/00+ryYLjbv9R9CFbfzleP
         eVSFnBDoSoYGJVHcvFCk2f5TdAbbqbvDjAJEgFJMKXu25HFYN2qwtqYwBJ2xW8AaQ3iJ
         g8qA==
X-Gm-Message-State: AOAM53117vhRnEsMAL9LImLa/aiSuj2lWdoLHbzDMSWvrAHYl6ANOmFF
        iMB0InWED9ycPdjpg1+PviM=
X-Google-Smtp-Source: ABdhPJw1JhLaxi0FMtAyg/GpFDqQAWRCwWNuLTDT6NDVxtGBo9VK4pJznY86Jjhm6UhAK+aSWeiD2Q==
X-Received: by 2002:a17:90a:248a:: with SMTP id i10mr902125pje.174.1589912090169;
        Tue, 19 May 2020 11:14:50 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d124sm147131pfa.98.2020.05.19.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:14:49 -0700 (PDT)
Date:   Tue, 19 May 2020 11:14:47 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sjpark@amazon.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH] mm: use only pidfd for process_madvise syscall
Message-ID: <20200519181447.GA220547@google.com>
References: <20200516012055.126205-1-minchan@kernel.org>
 <20200519074518.dur6qvfaq5pujtmg@wittgenstein>
 <20200519161956.GA66748@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519161956.GA66748@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 19, 2020 at 09:19:56AM -0700, Minchan Kim wrote:
> Hi Christian,
> 
> On Tue, May 19, 2020 at 09:45:18AM +0200, Christian Brauner wrote:
> > On Fri, May 15, 2020 at 06:20:55PM -0700, Minchan Kim wrote:
> > > Based on discussion[1], people didn't feel we need to support both
> > > pid and pidfd for every new coming API[2] so this patch keeps only
> > > pidfd. This patch also changes flags's type with "unsigned int".
> > > So finally, the API is as follows,
> > > 
> > >       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
> > >       		unsigned long vlen, int advice, unsigned int flags);
> > > 
> > >     DESCRIPTION
> > >       The process_madvise() system call is used to give advice or directions
> > >       to the kernel about the address ranges from external process as well as
> > >       local process. It provides the advice to address ranges of process
> > >       described by iovec and vlen. The goal of such advice is to improve system
> > >       or application performance.
> > > 
> > >       The pidfd selects the process referred to by the PID file descriptor
> > >       specified in pidfd. (See pidofd_open(2) for further information)
> > > 
> > >       The pointer iovec points to an array of iovec structures, defined in
> > >       <sys/uio.h> as:
> > > 
> > >         struct iovec {
> > >             void *iov_base;         /* starting address */
> > >             size_t iov_len;         /* number of bytes to be advised */
> > >         };
> > > 
> > >       The iovec describes address ranges beginning at address(iov_base)
> > >       and with size length of bytes(iov_len).
> > > 
> > >       The vlen represents the number of elements in iovec.
> > > 
> > >       The advice is indicated in the advice argument, which is one of the
> > >       following at this moment if the target process specified by idtype and
> > >       id is external.
> > > 
> > >         MADV_COLD
> > >         MADV_PAGEOUT
> > >         MADV_MERGEABLE
> > >         MADV_UNMERGEABLE
> > > 
> > >       Permission to provide a hint to external process is governed by a
> > >       ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).
> > > 
> > >       The process_madvise supports every advice madvise(2) has if target
> > >       process is in same thread group with calling process so user could
> > >       use process_madvise(2) to extend existing madvise(2) to support
> > >       vector address ranges.
> > > 
> > >     RETURN VALUE
> > >       On success, process_madvise() returns the number of bytes advised.
> > >       This return value may be less than the total number of requested
> > >       bytes, if an error occurred. The caller should check return value
> > >       to determine whether a partial advice occurred.
> > > 
> > > [1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
> > > [2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > 
> > Thanks for the ping Minchan, and sorry for not replying earlier to this.
> > 
> > Also, sorry that i delayed the patch but this here really seems a way
> > cleaner api to me and feels less hackish. In general this patch seems
> > fine to me.
> 
> Thanks.
> 
> > But two comments below:
> > 
> > > ---
> > >  mm/madvise.c | 42 +++++++++++++-----------------------------
> > >  1 file changed, 13 insertions(+), 29 deletions(-)
> > > 
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index d3fbbe52d230..35c9b220146a 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -1229,8 +1229,8 @@ static int process_madvise_vec(struct task_struct *target_task,
> > >  	return ret;
> > >  }
> > >  
> > > -static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> > > -				       int behavior, unsigned long flags)
> > > +static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> > > +				int behavior, unsigned int flags)
> > >  {
> > >  	ssize_t ret;
> > >  	struct pid *pid;
> > > @@ -1241,26 +1241,12 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> > >  	if (flags != 0)
> > >  		return -EINVAL;
> > >  
> > > -	switch (which) {
> > > -	case P_PID:
> > > -		if (upid <= 0)
> > > -			return -EINVAL;
> > > -
> > > -		pid = find_get_pid(upid);
> > > -		if (!pid)
> > > -			return -ESRCH;
> > > -		break;
> > > -	case P_PIDFD:
> > > -		if (upid < 0)
> > > -			return -EINVAL;
> > > -
> > > -		pid = pidfd_get_pid(upid);
> > > -		if (IS_ERR(pid))
> > > -			return PTR_ERR(pid);
> > > -		break;
> > > -	default:
> > > +	if (pidfd < 0)
> > >  		return -EINVAL;
> > 
> > When garbage file descriptors are passed EBADF needs to be returned, not
> > EINVAL. That's the case with most apis and also with pidfds, compare:
> 
> True. Let me cook a patch for that.

Hi Andrew,

Please fold this patch against on last patch you have for process_madvise.
Thanks!

From 939e4c5b7ca12efc5d5eeb8ff55fc02752f70544 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 19 May 2020 11:06:57 -0700
Subject: [PATCH] mm: return EBADF if pidfd is invalid

This patch makes returning of EBADF when the fd passed as argument is
invalid. The implementaion relies on pidfd_get_pid's error return.

This patch also fixes syscall declare part since we removed pid support.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 include/linux/compat.h   | 6 +++---
 include/linux/syscalls.h | 5 ++---
 mm/madvise.c             | 3 ---
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/compat.h b/include/linux/compat.h
index 2e2f0a2700ab..86b61e873947 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -827,10 +827,10 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 		unsigned long vlen, loff_t pos, rwf_t flags);
 #endif
 
-asmlinkage ssize_t compat_sys_process_madvise(compat_int_t which,
-		compat_pid_t upid, const struct compat_iovec __user *vec,
+asmlinkage ssize_t compat_sys_process_madvise(compat_int_t pidfd,
+		const struct compat_iovec __user *vec,
 		compat_ulong_t vlen, compat_int_t behavior,
-		compat_ulong_t flags);
+		compat_int_t flags);
 
 /*
  * Deprecated system calls which are still defined in
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 2cbd3660e8e6..63ffa6dc9da3 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -879,9 +879,8 @@ asmlinkage long sys_munlockall(void);
 asmlinkage long sys_mincore(unsigned long start, size_t len,
 				unsigned char __user * vec);
 asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
-asmlinkage long sys_process_madvise(int which, pid_t upid,
-		const struct iovec __user *vec, unsigned long vlen,
-		int behavior, unsigned long flags);
+asmlinkage long sys_process_madvise(int pidfd, const struct iovec __user *vec,
+		unsigned long vlen, int behavior, unsigned int flags);
 asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
 			unsigned long prot, unsigned long pgoff,
 			unsigned long flags);
diff --git a/mm/madvise.c b/mm/madvise.c
index 35c9b220146a..3ac1eda1203f 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1241,9 +1241,6 @@ static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
 	if (flags != 0)
 		return -EINVAL;
 
-	if (pidfd < 0)
-		return -EINVAL;
-
 	pid = pidfd_get_pid(pidfd);
 	if (IS_ERR(pid))
 		return PTR_ERR(pid);
-- 
2.26.2.761.g0e0b3e54be-goog

