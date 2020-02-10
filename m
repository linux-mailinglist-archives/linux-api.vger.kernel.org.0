Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C70158606
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 00:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBJXNF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 18:13:05 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46617 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgBJXNF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 18:13:05 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so1777318ilm.13;
        Mon, 10 Feb 2020 15:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94ZdrxwQP1++2+57igxiGpwY0OWBi7u5WQy0d6CqXYg=;
        b=PcoIaKD7tbZdgLNmUEXt2KmnCvsYm4xQI4sudxffeOY7Tiq69BlYX0kTlgicLRfRHq
         jNnr87yJTVEExaYRyw9XvJ3J7iL7h7GYHMETNzW9lkf38/g9scoBRrwbsvQjOPmXKLkq
         WrAOVa18vSm6l7j08No0uSZcAIIZhIZWgRasu5W/3yf5Dz28dVdQBJ83EIR5AQerKnH6
         VaDGQ7QaqwvRssiIlyYkiwtwwD/IY8mhijlm3ahP4nhAEviPu5JG6tEkxXt4L6v31ulR
         Yp2vml36aB/yZPJ3wqCKw3TW16Ap9xepH3DFzG7joLEUx4k7MHgGpZo4mIFuBIsmDg/h
         dxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94ZdrxwQP1++2+57igxiGpwY0OWBi7u5WQy0d6CqXYg=;
        b=YsOaSC6QvGq5EQOHJd0CyVCCFDM3rnpzls/Nupk66aNx5Dt7ToTfxo2+AaEAG0HO9C
         xb3MJfq1lJu/db/EnDeVhdUhUmtEJrpUtMWwjcl1OkExptyDTFer85Y3Cl+bot0YQL5u
         CXhmZONHzmalsQeXg/AzikzwEDwuZAhEdf3N9C0lMtABM4/JgAXUtq6yB/7K4Q9evBgS
         5rxT0w91aWHPmaVyf2ZwB1dC8TQXcsB8b6Ch2/YGOqlRJAjjhHEq0YuH3DW6BlFuypSG
         G+v6cKtyWYDWwSA8VWQDrzc82vHa7SHCVQal0BHLNG/ayOXYzYDN2s4G1kTD84mLbSIN
         hgLw==
X-Gm-Message-State: APjAAAXBkfZu3oQfEAznB3o8Eg0x6JjS0QQw3fnE/sXub/ZT8Rl1fByQ
        JQ3K8QjTr/Yu9GudLzTQJ3AeL0hf6fVrV/BCzW0=
X-Google-Smtp-Source: APXvYqzYb8NMk1n3a8T4EB7o9uXLe4Fcx0D0yI8gD7+dI3IQ933dZ9rbhnKJfRKS8E61ad0wmzVcGrulVB8YxEHjsUc=
X-Received: by 2002:a92:dac3:: with SMTP id o3mr3950136ilq.237.1581376382942;
 Mon, 10 Feb 2020 15:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20200128001641.5086-1-minchan@kernel.org> <20200128001641.5086-6-minchan@kernel.org>
In-Reply-To: <20200128001641.5086-6-minchan@kernel.org>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 10 Feb 2020 15:12:52 -0800
Message-ID: <CAKgT0Ue9y=CL-f8xNXLo70nSk1wR_tG6TYXQUYpfk42PkHWeug@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] mm: support both pid and pidfd for process_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jan 27, 2020 at 4:17 PM Minchan Kim <minchan@kernel.org> wrote:
>
> There is a demand[1] to support pid as well pidfd for process_madvise
> to reduce unncessary syscall to get pidfd if the user has control of
> the targer process(ie, they could gaurantee the process is not gone
> or pid is not reused. Or, it might be okay to give a hint to wrong
> process).

It looks like you misspelled several items in here including
"unnecessary", "target", and "guarantee".

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
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  include/linux/pid.h      |  1 +
>  include/linux/syscalls.h |  3 ++-
>  kernel/exit.c            | 17 -----------------
>  kernel/pid.c             | 17 +++++++++++++++++
>  mm/madvise.c             | 34 ++++++++++++++++++++++------------
>  5 files changed, 42 insertions(+), 30 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 998ae7d24450..023d9c3a8edc 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -75,6 +75,7 @@ extern const struct file_operations pidfd_fops;
>  struct file;
>
>  extern struct pid *pidfd_pid(const struct file *file);
> +extern struct pid *pidfd_get_pid(unsigned int fd);
>
>  static inline struct pid *get_pid(struct pid *pid)
>  {

So really this is two patches interleaved. You have the moving of the
pidfd_get_pid function and the update of the syscall. Personally I
would make the function move a separate patch and place it before you
define the syscall and fold the syscall changes into your original
patch.

Doing that you wouldn't have to worry about the syscall changing in
behavior midway through a bisect. It would either be there or it
wouldn't.

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1b58a11ff49f..27060e59db37 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -877,7 +877,8 @@ asmlinkage long sys_munlockall(void);
>  asmlinkage long sys_mincore(unsigned long start, size_t len,
>                                 unsigned char __user * vec);
>  asmlinkage long sys_madvise(unsigned long start, size_t len, int behavior);
> -asmlinkage long sys_process_madvise(int pidfd, unsigned long start,
> +
> +asmlinkage long sys_process_madvise(int which, pid_t pid, unsigned long start,
>                         size_t len, int behavior, unsigned long flags);
>  asmlinkage long sys_remap_file_pages(unsigned long start, unsigned long size,
>                         unsigned long prot, unsigned long pgoff,
> diff --git a/kernel/exit.c b/kernel/exit.c
> index bcbd59888e67..7698843b1411 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1466,23 +1466,6 @@ static long do_wait(struct wait_opts *wo)
>         return retval;
>  }
>
> -static struct pid *pidfd_get_pid(unsigned int fd)
> -{
> -       struct fd f;
> -       struct pid *pid;
> -
> -       f = fdget(fd);
> -       if (!f.file)
> -               return ERR_PTR(-EBADF);
> -
> -       pid = pidfd_pid(f.file);
> -       if (!IS_ERR(pid))
> -               get_pid(pid);
> -
> -       fdput(f);
> -       return pid;
> -}
> -
>  static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>                           int options, struct rusage *ru)
>  {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2278e249141d..a41a89d5dad2 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -496,6 +496,23 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>         return idr_get_next(&ns->idr, &nr);
>  }
>
> +struct pid *pidfd_get_pid(unsigned int fd)
> +{
> +       struct fd f;
> +       struct pid *pid;
> +
> +       f = fdget(fd);
> +       if (!f.file)
> +               return ERR_PTR(-EBADF);
> +
> +       pid = pidfd_pid(f.file);
> +       if (!IS_ERR(pid))
> +               get_pid(pid);
> +
> +       fdput(f);
> +       return pid;
> +}
> +
>  /**
>   * pidfd_create() - Create a new pid file descriptor.
>   *
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 39c40cbb389e..ba3a9bd8ea27 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1197,11 +1197,10 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>         return madvise_common(current, current->mm, start, len_in, behavior);
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
> @@ -1212,20 +1211,31 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
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
> @@ -1238,7 +1248,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
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
> 2.25.0.341.g760bfbb309-goog
>
>
