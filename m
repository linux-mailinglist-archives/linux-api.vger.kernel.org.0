Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021161D8823
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2020 21:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgERTXJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 May 2020 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgERTXJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 May 2020 15:23:09 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB58DC05BD09
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 12:23:08 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id w65so3661532vsw.11
        for <linux-api@vger.kernel.org>; Mon, 18 May 2020 12:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3ILiyk30wRbfK23dh/O9xFsFphYtNDbVYfVZgp73Oc=;
        b=ArinD1zH1rcDoD3eiWAyIe2Q8HfWaY+YmTtTgigWn7pciUtEgLRFTDSawEinY3f1nN
         xZhZxUiZXPT2usRKyRNF3hC0LmKdyukGGtkPwogqkCY2DZnD974VBZuJNfzTSbn+Cm+P
         8ztyv1L7mnw/E2+5qty9azyOElIkgEY9hr0g7cmXvZtYE2gWUUBbRJ0optWiBxptKwFf
         mc/zbsIdcaW4V/4P59+fMlSPgWvLUhA3WdIOzan5elDVqy6tUSDUQOkpemo/AWTCcbJr
         Tka2KsAzTztWVAJFwqnVxia8oin4uiGg/nGkuvNPuWjIXwPG0PdVpxKRCbiSpNuzv9ej
         n66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3ILiyk30wRbfK23dh/O9xFsFphYtNDbVYfVZgp73Oc=;
        b=ROEmRY2hu4EqeMupKB7Bnm+dwUQys3RZi9HYqw3HEFyLQO12ykQnn9pn3fj+9fynhJ
         jHHuo6yoBJUhkuUKEd7QkCd1eMzgFBKFxQosX13gHPYF1VhLlcue/iCYAnkiUdsPFPQU
         RVmgYLWthtVXbCSv2n4eiQBPTXlAyTQB1InWRCH4Rl9LZWgodMEOJUIMOVYepQ2VSn0O
         b7FpbqfqYnInwj7rRnr8WZkTznAWWxxceAfEv5PAyUp3TvJRCTaT9Vk+zXC9JIUy72Dx
         d5PWWj+CymJnJ/bAiEfIP86MCsx8XvdyObqWWWV7Y8Wt4p6/0FR2olEopLXVZyZsu2g6
         qlAw==
X-Gm-Message-State: AOAM531WYcFz8ISXdBV99DrSj48yd8/ohOsymG3+45O7IGs0cJJ4XL9K
        Mf5DMCWhS3cl6LDrgEXbPI+Lt1ttkgYhPLAJ+y2Ohg==
X-Google-Smtp-Source: ABdhPJxDL/9YgOnqV3iWJOuJCL8QuNnztjnS6s28kHehJj8idXehTbtn/Sfp0ou+w9qe7XSEVPhnR2x3JXc5/5UqawY=
X-Received: by 2002:a67:f883:: with SMTP id h3mr7772716vso.239.1589829787468;
 Mon, 18 May 2020 12:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200516012055.126205-1-minchan@kernel.org>
In-Reply-To: <20200516012055.126205-1-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 18 May 2020 12:22:56 -0700
Message-ID: <CAJuCfpGbPUpWLDgwt5ZP4Uf8fp6ht_6eqUypMVYYh3btJdz_8Q@mail.gmail.com>
Subject: Re: [PATCH] mm: use only pidfd for process_madvise syscall
To:     Minchan Kim <minchan@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 15, 2020 at 6:21 PM Minchan Kim <minchan@kernel.org> wrote:
>
> Based on discussion[1], people didn't feel we need to support both
> pid and pidfd for every new coming API[2] so this patch keeps only
> pidfd. This patch also changes flags's type with "unsigned int".
> So finally, the API is as follows,
>
>       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>                 unsigned long vlen, int advice, unsigned int flags);
>
>     DESCRIPTION
>       The process_madvise() system call is used to give advice or directions
>       to the kernel about the address ranges from external process as well as
>       local process. It provides the advice to address ranges of process
>       described by iovec and vlen. The goal of such advice is to improve system
>       or application performance.
>
>       The pidfd selects the process referred to by the PID file descriptor
>       specified in pidfd. (See pidofd_open(2) for further information)
>
>       The pointer iovec points to an array of iovec structures, defined in
>       <sys/uio.h> as:
>
>         struct iovec {
>             void *iov_base;         /* starting address */
>             size_t iov_len;         /* number of bytes to be advised */
>         };
>
>       The iovec describes address ranges beginning at address(iov_base)
>       and with size length of bytes(iov_len).
>
>       The vlen represents the number of elements in iovec.
>
>       The advice is indicated in the advice argument, which is one of the
>       following at this moment if the target process specified by idtype and

There is no idtype parameter anymore, so maybe just "if the target
process is external"?

>       id is external.
>
>         MADV_COLD
>         MADV_PAGEOUT
>         MADV_MERGEABLE
>         MADV_UNMERGEABLE
>
>       Permission to provide a hint to external process is governed by a
>       ptrace access mode PTRACE_MODE_ATTACH_FSCREDS check; see ptrace(2).
>
>       The process_madvise supports every advice madvise(2) has if target
>       process is in same thread group with calling process so user could
>       use process_madvise(2) to extend existing madvise(2) to support
>       vector address ranges.
>
>     RETURN VALUE
>       On success, process_madvise() returns the number of bytes advised.
>       This return value may be less than the total number of requested
>       bytes, if an error occurred. The caller should check return value
>       to determine whether a partial advice occurred.
>
> [1] https://lore.kernel.org/linux-mm/20200509124817.xmrvsrq3mla6b76k@wittgenstein/
> [2] https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/madvise.c | 42 +++++++++++++-----------------------------
>  1 file changed, 13 insertions(+), 29 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index d3fbbe52d230..35c9b220146a 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1229,8 +1229,8 @@ static int process_madvise_vec(struct task_struct *target_task,
>         return ret;
>  }
>
> -static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
> -                                      int behavior, unsigned long flags)
> +static ssize_t do_process_madvise(int pidfd, struct iov_iter *iter,
> +                               int behavior, unsigned int flags)
>  {
>         ssize_t ret;
>         struct pid *pid;
> @@ -1241,26 +1241,12 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
>         if (flags != 0)
>                 return -EINVAL;
>
> -       switch (which) {
> -       case P_PID:
> -               if (upid <= 0)
> -                       return -EINVAL;
> -
> -               pid = find_get_pid(upid);
> -               if (!pid)
> -                       return -ESRCH;
> -               break;
> -       case P_PIDFD:
> -               if (upid < 0)
> -                       return -EINVAL;
> -
> -               pid = pidfd_get_pid(upid);
> -               if (IS_ERR(pid))
> -                       return PTR_ERR(pid);
> -               break;
> -       default:
> +       if (pidfd < 0)
>                 return -EINVAL;
> -       }
> +
> +       pid = pidfd_get_pid(pidfd);
> +       if (IS_ERR(pid))
> +               return PTR_ERR(pid);
>
>         task = get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
> @@ -1292,9 +1278,8 @@ static ssize_t do_process_madvise(int which, pid_t upid, struct iov_iter *iter,
>         return ret;
>  }
>
> -SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
> -               const struct iovec __user *, vec, unsigned long, vlen,
> -               int, behavior, unsigned long, flags)
> +SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> +               unsigned long, vlen, int, behavior, unsigned int, flags)
>  {
>         ssize_t ret;
>         struct iovec iovstack[UIO_FASTIOV];
> @@ -1303,19 +1288,18 @@ SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid,
>
>         ret = import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack), &iov, &iter);
>         if (ret >= 0) {
> -               ret = do_process_madvise(which, upid, &iter, behavior, flags);
> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
>                 kfree(iov);
>         }
>         return ret;
>  }
>
>  #ifdef CONFIG_COMPAT
> -COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
> -                       compat_pid_t, upid,
> +COMPAT_SYSCALL_DEFINE5(process_madvise, compat_int_t, pidfd,
>                         const struct compat_iovec __user *, vec,
>                         compat_ulong_t, vlen,
>                         compat_int_t, behavior,
> -                       compat_ulong_t, flags)
> +                       compat_int_t, flags)
>
>  {
>         ssize_t ret;
> @@ -1326,7 +1310,7 @@ COMPAT_SYSCALL_DEFINE6(process_madvise, compat_int_t, which,
>         ret = compat_import_iovec(READ, vec, vlen, ARRAY_SIZE(iovstack),
>                                 &iov, &iter);
>         if (ret >= 0) {
> -               ret = do_process_madvise(which, upid, &iter, behavior, flags);
> +               ret = do_process_madvise(pidfd, &iter, behavior, flags);
>                 kfree(iov);
>         }
>         return ret;
> --
> 2.26.2.761.g0e0b3e54be-goog
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
