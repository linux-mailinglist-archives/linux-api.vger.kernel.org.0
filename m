Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98BEE17421A
	for <lists+linux-api@lfdr.de>; Fri, 28 Feb 2020 23:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1WlU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Feb 2020 17:41:20 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41417 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgB1WlU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Feb 2020 17:41:20 -0500
Received: by mail-vs1-f67.google.com with SMTP id k188so2998502vsc.8
        for <linux-api@vger.kernel.org>; Fri, 28 Feb 2020 14:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9BTwZzXxDzrVF6UcyviikLcydQEHUNnudxLaL8uKts=;
        b=od+LBP/b8AMnzHYGyWOnh67HAS41CcWjLjL6lDYC0IPO5w9Y+65KibixkdjVm0Jyki
         jrMHaWIyTGMm7MfEZ5ojgmzD5FeHRS9dd46zT+Ma7W2AF0oPG/ZHVQZRQxf6W3V9JK6f
         RQ5AsX8F6clUzPqYCRUBczsZwgMk9yTKJfVJceHfV1xz5qR0gcIJwKmKoV/ixJCTx48b
         wbpAdqCb2dN5Eh4Z7DSEND//LSvQvYYMbyTSJt7FS3pgkGluUF8htfuFhoBJxB9bxNoo
         sFoX/jxeHVnTHZtOsOUP8ifNUgMLgoB7PpK98WxIODlBHfQ5cfxISbjpF1d9HsbWKSeG
         4Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9BTwZzXxDzrVF6UcyviikLcydQEHUNnudxLaL8uKts=;
        b=od/39vuBcOkqNCRUwdGWmcnwiebONkqs+MJ0rMBe57QFpFT0TGsIRwcgQH1TFUh9L+
         h4955JxSpfv+DVNAarOV98b6LD9/xM+DCrtgH4ZNTuaiFWneJKbU1K3OGhFbBVCilrMY
         aMwfCG20tJhXp6W+dQcoK6t6xWuUSUK7BwGVANTXl4S+mxCutL2qLVDToZS5wGxoMpSQ
         qNoAaKtegWm6R5Cmv9GArHwRpSwmHBBIhmxVjtmr0wt/t1SatC9sy/+XPi7ckGRPkCCp
         AZaJqYY2wQQgWntt6DH5BoXxlT4tC2jjtqjp9WVLiqE62bQHhY/Q+C3juJGNnrbN010u
         PdSQ==
X-Gm-Message-State: ANhLgQ0jLx/GBcJPuUYCx3ro+qA+cJjmKlHRWlNeczUosn8tgeGQajKZ
        uA6OkeaQU/FIj7W+ZScX7128soEOLc5O1eWpYpWN9g==
X-Google-Smtp-Source: ADFU+vsU9EKYwuh5cDn64CV1YZwJLdXB+wHL9slJ1TyqxeZMR/DWCL7TOAXvCTq9PPzu7K4/OV39qXsbqz8VvHNwGLo=
X-Received: by 2002:a05:6102:303a:: with SMTP id v26mr4021916vsa.119.1582929678413;
 Fri, 28 Feb 2020 14:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-6-minchan@kernel.org>
In-Reply-To: <20200219014433.88424-6-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Feb 2020 14:41:07 -0800
Message-ID: <CAJuCfpE_T1UG_eSQMa6y7n0GXQBOQ8sE=0fcWmSo2ZhHoj4mCg@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] mm: support both pid and pidfd for process_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
>
> There is a demand[1] to support pid as well pidfd for process_madvise
> to reduce unnecessary syscall to get pidfd if the user has control of
> the target process(ie, they could guarantee the process is not gone
> or pid is not reused. Or, it might be okay to give a hint to wrong
> process).

nit: When would "give a hint to wrong process" be ok? I would just
remove this part.

>
> This patch aims for supporting both options like waitid(2). So, the
> syscall is currently,
>
>         int process_madvise(int which, pid_t pid, void *addr,
>                 size_t length, int advise, unsigned long flag);
>
> @which is actually idtype_t for userspace libray and currently,
> it supports P_PID and P_PIDFD.
>
> [1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
>
> Cc: Christian Brauner <christian@brauner.io>
> Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/syscalls.h |  3 ++-
>  mm/madvise.c             | 34 ++++++++++++++++++++++------------
>  2 files changed, 24 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e4cd2c2f8bb4..f5ada20e2943 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -876,7 +876,8 @@ asmlinkage long sys_munlockall(void);
>  asmlinkage long sys_mincore(unsigned long start, size_t len,
>                                 unsigned char __user * vec);
>  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> -asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
> +
> +asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
>                         size_t len, int behavior, unsigned long flags);
>  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
>                         unsigned long prot, unsigned long pgoff,
> diff --git a/mm/madvise.c b/mm/madvise.c
> index def1507c2030..f6d9b9e66243 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1182,11 +1182,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>         return do_madvise(current, current->mm, start, len_in, behavior);
>  }
>
> -SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> +SYSCALL_DEFINE6(process_madvise, int, which, pid_t, upid, unsigned long, start,
>                 size_t, len_in, int, behavior, unsigned long, flags)
>  {
>         int ret;
> -       struct fd f;
>         struct pid *pid;
>         struct task_struct *task;
>         struct mm_struct *mm;
> @@ -1197,20 +1196,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
>         if (!process_madvise_behavior_valid(behavior))
>                 return -EINVAL;
>
> -       f = fdget(pidfd);
> -       if (!f.file)
> -               return -EBADF;
> +       switch (which) {
> +       case P_PID:
> +               if (upid <= 0)
> +                       return -EINVAL;
> +
> +               pid = find_get_pid(upid);
> +               if (!pid)
> +                       return -ESRCH;
> +               break;
> +       case P_PIDFD:
> +               if (upid < 0)
> +                       return -EINVAL;
>
> -       pid = pidfd_pid(f.file);
> -       if (IS_ERR(pid)) {
> -               ret = PTR_ERR(pid);
> -               goto fdput;
> +               pid = pidfd_get_pid(upid);
> +               if (IS_ERR(pid))
> +                       return PTR_ERR(pid);
> +               break;
> +       default:
> +               return -EINVAL;
>         }
>
>         task = get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
>                 ret = -ESRCH;
> -               goto fdput;
> +               goto put_pid;
>         }
>
>         mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> @@ -1223,7 +1233,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
>         mmput(mm);
>  release_task:
>         put_task_struct(task);
> -fdput:
> -       fdput(f);
> +put_pid:
> +       put_pid(pid);
>         return ret;
>  }
> --
> 2.25.0.265.gbab2e86ba0-goog
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
