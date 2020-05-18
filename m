Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB321D89D6
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 23:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgERVOK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 17:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgERVOK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 17:14:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700CC061A0C;
        Mon, 18 May 2020 14:14:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b8so5404368pgi.11;
        Mon, 18 May 2020 14:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gJhA0EnWWogyqjagjGROhMHz7AQftODHYp71lZxH6sg=;
        b=BJ1ex82NYDjkhYOcAaWRmnN8O0MLXSHnbo3aY/IrfshRrVMDW6+LUfqAZUdWm5gGS6
         3PeRA4/IcSW6VCkXDSVCGH0VcuXDJP9awzm4p3SHnMENvfjFmKhO6GsSLldvJD9IAQDl
         jcGre5r5QipMag/Se7eYUZaWgUOW5oFNBJ0quv0tGK+0cU+4lpcqFF3cbztNYFv20q3O
         GK45DnDj8kbn/Xxiit7yw69YutJ6VSxYlEmWikfT1dg0JEcEuZOASMwsFrrXLVyuls94
         /Srh4055SWBl4yKN8FI1wcuzhQcdO4GMVcb0fvhDafVZSk15njbPuXYYj9XFRN9dmE0H
         i4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gJhA0EnWWogyqjagjGROhMHz7AQftODHYp71lZxH6sg=;
        b=ctS9nYHOFSfz7OL33IAnmP9FvRHoz02Wl/Y4bp+WUDSzL5Ct/ok6YfbS32zCM4NOSS
         l1VfsgtJuJBr6QWN4ZuEYO7sJK2RPpKwlJ+3PWeolH1NYoq01kyhGdFzBJwQm+oXuei3
         5lUa3k6QuZK47dMhJm0Lt0lhrbnvVK6YkqlCp/bcVX+oXvRdTnO3VT0WPb1Gzu3lLuCb
         wpRthOL4FfhgdPeWVzHd5RcgXbEpgMhp9W+lnQMxeU5J/pvl9pTrio+B9gwoKNMWvaoc
         jYWPS9r2X7WQLiRK+YxPOsf2aGLY3zSnKrTSuvpm+0LwMgAKyd2VBmWJSonlsck5e9IB
         nTCQ==
X-Gm-Message-State: AOAM531GvxIMytb+pKUG/UsPf1Hy1jFsHW4E+sb+dUqA++BEG3d1pUDK
        dIxCiP1UB4gk20pXfDpVH3r4HDd6
X-Google-Smtp-Source: ABdhPJyAOmytiozarBPse5ichjrDFa9QAlI96mBDsytsPdvHWvIzn0ED6e8IbvYFvlJQYy7gAPGZzQ==
X-Received: by 2002:aa7:83c9:: with SMTP id j9mr16754790pfn.180.1589836449413;
        Mon, 18 May 2020 14:14:09 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id e13sm9432643pfh.19.2020.05.18.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 14:14:08 -0700 (PDT)
Date:   Mon, 18 May 2020 14:13:50 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@redhat.com>,
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
Message-ID: <20200518211350.GA50295@google.com>
References: <20200516012055.126205-1-minchan@kernel.org>
 <CAJuCfpGbPUpWLDgwt5ZP4Uf8fp6ht_6eqUypMVYYh3btJdz_8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpGbPUpWLDgwt5ZP4Uf8fp6ht_6eqUypMVYYh3btJdz_8Q@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 12:22:56PM -0700, Suren Baghdasaryan wrote:
> On Fri, May 15, 2020 at 6:21 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > Based on discussion[1], people didn't feel we need to support both
> > pid and pidfd for every new coming API[2] so this patch keeps only
> > pidfd. This patch also changes flags's type with "unsigned int".
> > So finally, the API is as follows,
> >
> >       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
> >                 unsigned long vlen, int advice, unsigned int flags);
> >
> >     DESCRIPTION
> >       The process_madvise() system call is used to give advice or directions
> >       to the kernel about the address ranges from external process as well as
> >       local process. It provides the advice to address ranges of process
> >       described by iovec and vlen. The goal of such advice is to improve system
> >       or application performance.
> >
> >       The pidfd selects the process referred to by the PID file descriptor
> >       specified in pidfd. (See pidofd_open(2) for further information)
> >
> >       The pointer iovec points to an array of iovec structures, defined in
> >       <sys/uio.h> as:
> >
> >         struct iovec {
> >             void *iov_base;         /* starting address */
> >             size_t iov_len;         /* number of bytes to be advised */
> >         };
> >
> >       The iovec describes address ranges beginning at address(iov_base)
> >       and with size length of bytes(iov_len).
> >
> >       The vlen represents the number of elements in iovec.
> >
> >       The advice is indicated in the advice argument, which is one of the
> >       following at this moment if the target process specified by idtype and
> 
> There is no idtype parameter anymore, so maybe just "if the target
> process is external"?

Fixed.

> 
> >       id is external.
> >
> >         MADV_COLD
> >         MADV_PAGEOUT
> >         MADV_MERGEABLE
> >         MADV_UNMERGEABLE
> >
> >       Permission to provide a hint to external process is governed by a
> >       ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).
> >
> >       The process_madvise supports every advice madvise(2) has if target
> >       process is in same thread group with calling process so user could
> >       use process_madvise(2) to extend existing madvise(2) to support
> >       vector address ranges.
> >
> >     RETURN VALUE
> >       On success, process_madvise() returns the number of bytes advised.
> >       This return value may be less than the total number of requested
> >       bytes, if an error occurred. The caller should check return value
> >       to determine whether a partial advice occurred.
> >
> > [1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
> > [2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/madvise.c | 42 +++++++++++++-----------------------------
> >  1 file changed, 13 insertions(+), 29 deletions(-)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index d3fbbe52d230..35c9b220146a 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1229,8 +1229,8 @@ static int process_madvise_vec(struct task_struct *target_task,
> >         return ret;
> >  }
> >
> > -static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> > -                                      int behavior, unsigned long flags)
> > +static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> > +                               int behavior, unsigned int flags)
> >  {
> >         ssize_t ret;
> >         struct pid *pid;
> > @@ -1241,26 +1241,12 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> >         if (flags != 0)
> >                 return -EINVAL;
> >
> > -       switch (which) {
> > -       case P_PID:
> > -               if (upid <= 0)
> > -                       return -EINVAL;
> > -
> > -               pid = find_get_pid(upid);
> > -               if (!pid)
> > -                       return -ESRCH;
> > -               break;
> > -       case P_PIDFD:
> > -               if (upid < 0)
> > -                       return -EINVAL;
> > -
> > -               pid = pidfd_get_pid(upid);
> > -               if (IS_ERR(pid))
> > -                       return PTR_ERR(pid);
> > -               break;
> > -       default:
> > +       if (pidfd < 0)
> >                 return -EINVAL;
> > -       }
> > +
> > +       pid = pidfd_get_pid(pidfd);
> > +       if (IS_ERR(pid))
> > +               return PTR_ERR(pid);
> >
> >         task = get_pid_task(pid, PIDTYPE_PID);
> >         if (!task) {
> > @@ -1292,9 +1278,8 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> >         return ret;
> >  }
> >
> > -SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
> > -               const struct iovec __user *, vec, unsigned long, vlen,
> > -               int, behavior, unsigned long, flags)
> > +SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > +               unsigned long, vlen, int, behavior, unsigned int, flags)
> >  {
> >         ssize_t ret;
> >         struct iovec iovstack[UIO_FASTIOV];
> > @@ -1303,19 +1288,18 @@ SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
> >
> >         ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
> >         if (ret >= 0) {
> > -               ret = do_process_madvise(which, upid, &iter, behavior, flags);
> > +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> >                 kfree(iov);
> >         }
> >         return ret;
> >  }
> >
> >  #ifdef CONFIG_COMPAT
> > -COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
> > -                       compat_pid_t, upid,
> > +COMPAT_SYSCALL_DEFINE5(process_madvise, compat_int_t, pidfd,
> >                         const struct compat_iovec __user *, vec,
> >                         compat_ulong_t, vlen,
> >                         compat_int_t, behavior,
> > -                       compat_ulong_t, flags)
> > +                       compat_int_t, flags)
> >
> >  {
> >         ssize_t ret;
> > @@ -1326,7 +1310,7 @@ COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
> >         ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
> >                                 &iov, &iter);
> >         if (ret >= 0) {
> > -               ret = do_process_madvise(which, upid, &iter, behavior, flags);
> > +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
> >                 kfree(iov);
> >         }
> >         return ret;
> > --
> > 2.26.2.761.g0e0b3e54be-goog
> >
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks for the review, Suren.

Andrew, I sent this patch without folding into previous syscall introducing
patches because it could be arguable. If you want to fold it into each
patchset(i.e., introdcuing process_madvise syscall and introducing
compat_syscall), let me know it. I will send partial diff to each
patchset.

From 1f5d3c22426b79b76690145102c6ec905a405790 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Fri, 15 May 2020 17:48:08 -0700
Subject: [PATCH v2] mm: use only pidfd for process_madvise syscall

Based on discussion[1], people didn't feel we need to support both
pid and pidfd for every new coming API[2] so this patch keeps only
pidfd. This patch also changes flags's type with "unsigned int".
So finally, the API is as follows,

      ssize_t process_madvise(int pidfd, const struct iovec *iovec,
      		unsigned long vlen, int advice, unsigned int flags);

    DESCRIPTION
      The process_madvise() system call is used to give advice or directions
      to the kernel about the address ranges from external process as well as
      local process. It provides the advice to address ranges of process
      described by iovec and vlen. The goal of such advice is to improve system
      or application performance.

      The pidfd selects the process referred to by the PID file descriptor
      specified in pidfd. (See pidofd_open(2) for further information)

      The pointer iovec points to an array of iovec structures, defined in
      <sys/uio.h> as:

        struct iovec {
            void *iov_base;         /* starting address */
            size_t iov_len;         /* number of bytes to be advised */
        };

      The iovec describes address ranges beginning at address(iov_base)
      and with size length of bytes(iov_len).

      The vlen represents the number of elements in iovec.

      The advice is indicated in the advice argument, which is one of the
      following at this moment if the target process specified by pidfd is
      external.

        MADV_COLD
        MADV_PAGEOUT
        MADV_MERGEABLE
        MADV_UNMERGEABLE

      Permission to provide a hint to external process is governed by a
      ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).

      The process_madvise supports every advice madvise(2) has if target
      process is in same thread group with calling process so user could
      use process_madvise(2) to extend existing madvise(2) to support
      vector address ranges.

    RETURN VALUE
      On success, process_madvise() returns the number of bytes advised.
      This return value may be less than the total number of requested
      bytes, if an error occurred. The caller should check return value
      to determine whether a partial advice occurred.

[1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
[2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/madvise.c | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index d3fbbe52d230..35c9b220146a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1229,8 +1229,8 @@ static int process_madvise_vec(struct task_struct *target_task,
 	return ret;
 }
 
-static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
-				       int behavior, unsigned long flags)
+static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
+				int behavior, unsigned int flags)
 {
 	ssize_t ret;
 	struct pid *pid;
@@ -1241,26 +1241,12 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
 	if (flags != 0)
 		return -EINVAL;
 
-	switch (which) {
-	case P_PID:
-		if (upid <= 0)
-			return -EINVAL;
-
-		pid = find_get_pid(upid);
-		if (!pid)
-			return -ESRCH;
-		break;
-	case P_PIDFD:
-		if (upid < 0)
-			return -EINVAL;
-
-		pid = pidfd_get_pid(upid);
-		if (IS_ERR(pid))
-			return PTR_ERR(pid);
-		break;
-	default:
+	if (pidfd < 0)
 		return -EINVAL;
-	}
+
+	pid = pidfd_get_pid(pidfd);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
 
 	task = get_pid_task(pid, PIDTYPE_PID);
 	if (!task) {
@@ -1292,9 +1278,8 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
 	return ret;
 }
 
-SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
-		const struct iovec __user *, vec, unsigned long, vlen,
-		int, behavior, unsigned long, flags)
+SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
+		unsigned long, vlen, int, behavior, unsigned int, flags)
 {
 	ssize_t ret;
 	struct iovec iovstack[UIO_FASTIOV];
@@ -1303,19 +1288,18 @@ SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
 
 	ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
 	if (ret >= 0) {
-		ret = do_process_madvise(which, upid, &iter, behavior, flags);
+		ret = do_process_madvise(pidfd, &iter, behavior, flags);
 		kfree(iov);
 	}
 	return ret;
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
-			compat_pid_t, upid,
+COMPAT_SYSCALL_DEFINE5(process_madvise, compat_int_t, pidfd,
 			const struct compat_iovec __user *, vec,
 			compat_ulong_t, vlen,
 			compat_int_t, behavior,
-			compat_ulong_t, flags)
+			compat_int_t, flags)
 
 {
 	ssize_t ret;
@@ -1326,7 +1310,7 @@ COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
 	ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
 				&iov, &iter);
 	if (ret >= 0) {
-		ret = do_process_madvise(which, upid, &iter, behavior, flags);
+		ret = do_process_madvise(pidfd, &iter, behavior, flags);
 		kfree(iov);
 	}
 	return ret;
-- 
2.26.2.761.g0e0b3e54be-goog

