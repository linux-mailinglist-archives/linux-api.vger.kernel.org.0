Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 203651741DF
	for <lists+linux-api@lfdr.de>; Fri, 28 Feb 2020 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgB1WPz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Feb 2020 17:15:55 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33272 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgB1WPz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Feb 2020 17:15:55 -0500
Received: by mail-vs1-f68.google.com with SMTP id n27so3002940vsa.0
        for <linux-api@vger.kernel.org>; Fri, 28 Feb 2020 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=izrh7YjDkt7UIn90MCxZtkunk1I466I2NQe0fd5UD1c=;
        b=MONMVmL5nJ2o7dqPCcAtuwwGnyiEV0Qi7eGjTKznec56QQA51gYOydJ5vVGSyoxi5f
         79zwoYTsxv3Pw8fls6sBncB/7dvkthXNFRasH0eJkuTelWtCJb1CBNhQRjetfZjL/e9L
         6yN9TbInwe0hR6I386DP5thL71lzcNBYW0kTsj25S/giiDROjYa6yZRyjCFQljUrJoPr
         R1ZYrcZxRYErw6a/PQa2YH2Cqa4vhR80oIIvRXm8pX6BLPtls0QqsU2bXAtzvDbRXbAo
         SNRPdwpGcTKV/2E15lddgYYSE9Th4Q58GMvolAxdmocSsDP49dIcoyqJfgjEhU31YeWj
         taBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=izrh7YjDkt7UIn90MCxZtkunk1I466I2NQe0fd5UD1c=;
        b=oWOBfWX4VxxgSm7jbHh/O0CNaqGyO8dtgPNq+DUi7oR1pm9KAKwMcv7C0TPcsg5HlC
         qZ6CBg+LwgRE1nMpqIrlb5ezpZHDgncQXEWMTcIx71hXstr1jXbYesFROmyF3j0VyOcx
         twaKTLqEg1kx8/xt565egXLb/V4EXUVur89rFPHE+suzIwasue/gB+6WLI1XJzJhuq4w
         qsXavHox5XAZ5p5wEJHKb6oXZ7qHCMIv228Z7Gp/gkMoTcZsC75qboMFKlLmkrt6eN74
         WOTavagHjOwKofubzC1iHS4gQ3JaK38OgnmN39UcvqLlhpAT0k0gBhqN+NN9Gz3wJwcR
         UxVQ==
X-Gm-Message-State: ANhLgQ1RBlmI49pQ+tCTH9jfS22tc3vzMNYYvP4vlFIJRTHAgGAmVRDm
        RS61RIJNjEw6K0FW6qhEX2zxXxcnkK4h1SOu0h4XHA==
X-Google-Smtp-Source: ADFU+vswZnMJG5T1/Ed3hnj2geK/OAsTlMewPwkaQ/rsOZA9oEezP0rsg5umK7KP+mqBa+9/nuq90DHtBwMWGk3s5+Y=
X-Received: by 2002:a67:fd63:: with SMTP id h3mr4111090vsa.221.1582928153315;
 Fri, 28 Feb 2020 14:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-2-minchan@kernel.org>
In-Reply-To: <20200219014433.88424-2-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Feb 2020 14:15:42 -0800
Message-ID: <CAJuCfpGdOUp4pU2TyC3O=kCwL85wOc5szbNVTy9iSLe-CKVvzA@mail.gmail.com>
Subject: Re: [PATCH v6 1/7] mm: pass task and mm to do_madvise
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
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
>
> In upcoming patches, do_madvise will be called from external process
> context so we shouldn't asssume "current" is always hinted process's
> task_struct. Furthermore, we couldn't access mm_struct via task->mm
> once it's verified by access_mm which will be introduced in next
> patch[1]. And let's pass *current* and current->mm as arguments of
> do_madvise so it shouldn't change existing behavior but prepare
> next patch to make review easy.
>
> Note: io_madvise pass NULL as target_task argument of do_madvise
> because it couldn't know who is target.
>
> [1] http://lore.kernel.org/r/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com
>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  fs/io_uring.c      |  2 +-
>  include/linux/mm.h |  3 ++-
>  mm/madvise.c       | 34 +++++++++++++++++++---------------
>  3 files changed, 22 insertions(+), 17 deletions(-)
>
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 63beda9bafc5..a858da2ae2f4 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2736,7 +2736,7 @@ static int io_madvise(struct io_kiocb *req, struct io_kiocb **nxt,
>         if (force_nonblock)
>                 return -EAGAIN;
>
> -       ret = do_madvise(ma->addr, ma->len, ma->advice);
> +       ret = do_madvise(NULL, req->work.mm, ma->addr, ma->len, ma->advice);
>         if (ret < 0)
>                 req_set_fail_links(req);
>         io_cqring_add_event(req, ret);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 52269e56c514..bc16c8774328 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2323,7 +2323,8 @@ extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
>                        struct list_head *uf, bool downgrade);
>  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
>                      struct list_head *uf);
> -extern int do_madvise(unsigned long start, size_t len_in, int behavior);
> +extern int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> +               unsigned long start, size_t len_in, int behavior);
>
>  static inline unsigned long
>  do_mmap_pgoff(struct file *file, unsigned long addr,
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 43b47d3fae02..f75c86b6c463 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -254,6 +254,7 @@ static long madvise_willneed(struct vm_area_struct *vma,
>                              struct vm_area_struct **prev,
>                              unsigned long start, unsigned long end)
>  {
> +       struct mm_struct *mm = vma->vm_mm;
>         struct file *file = vma->vm_file;
>         loff_t offset;
>
> @@ -288,12 +289,12 @@ static long madvise_willneed(struct vm_area_struct *vma,
>          */
>         *prev = NULL;   /* tell sys_madvise we drop mmap_sem */
>         get_file(file);
> -       up_read(&current->mm->mmap_sem);
> +       up_read(&mm->mmap_sem);
>         offset = (loff_t)(start - vma->vm_start)
>                         + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
>         vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
>         fput(file);
> -       down_read(&current->mm->mmap_sem);
> +       down_read(&mm->mmap_sem);
>         return 0;
>  }
>
> @@ -676,7 +677,6 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>         if (nr_swap) {
>                 if (current->mm == mm)
>                         sync_mm_rss(mm);
> -
>                 add_mm_counter(mm, MM_SWAPENTS, nr_swap);
>         }
>         arch_leave_lazy_mmu_mode();
> @@ -756,6 +756,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>                                   unsigned long start, unsigned long end,
>                                   int behavior)
>  {
> +       struct mm_struct *mm = vma->vm_mm;
> +
>         *prev = vma;
>         if (!can_madv_lru_vma(vma))
>                 return -EINVAL;
> @@ -763,8 +765,8 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>         if (!userfaultfd_remove(vma, start, end)) {
>                 *prev = NULL; /* mmap_sem has been dropped, prev is stale */
>
> -               down_read(&current->mm->mmap_sem);
> -               vma = find_vma(current->mm, start);
> +               down_read(&mm->mmap_sem);
> +               vma = find_vma(mm, start);
>                 if (!vma)
>                         return -ENOMEM;
>                 if (start < vma->vm_start) {
> @@ -818,6 +820,7 @@ static long madvise_remove(struct vm_area_struct *vma,
>         loff_t offset;
>         int error;
>         struct file *f;
> +       struct mm_struct *mm = vma->vm_mm;
>
>         *prev = NULL;   /* tell sys_madvise we drop mmap_sem */
>
> @@ -845,13 +848,13 @@ static long madvise_remove(struct vm_area_struct *vma,
>         get_file(f);
>         if (userfaultfd_remove(vma, start, end)) {
>                 /* mmap_sem was not released by userfaultfd_remove() */
> -               up_read(&current->mm->mmap_sem);
> +               up_read(&mm->mmap_sem);
>         }
>         error = vfs_fallocate(f,
>                                 FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>                                 offset, end - start);
>         fput(f);
> -       down_read(&current->mm->mmap_sem);
> +       down_read(&mm->mmap_sem);
>         return error;
>  }
>
> @@ -1044,7 +1047,8 @@ madvise_behavior_valid(int behavior)
>   *  -EBADF  - map exists, but area maps something that isn't a file.
>   *  -EAGAIN - a kernel resource was temporarily unavailable.
>   */
> -int do_madvise(unsigned long start, size_t len_in, int behavior)
> +int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> +               unsigned long start, size_t len_in, int behavior)
>  {
>         unsigned long end, tmp;
>         struct vm_area_struct *vma, *prev;
> @@ -1082,10 +1086,10 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
>
>         write = madvise_need_mmap_write(behavior);
>         if (write) {
> -               if (down_write_killable(&current->mm->mmap_sem))
> +               if (down_write_killable(&mm->mmap_sem))
>                         return -EINTR;
>         } else {
> -               down_read(&current->mm->mmap_sem);
> +               down_read(&mm->mmap_sem);
>         }
>
>         /*
> @@ -1093,7 +1097,7 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
>          * ranges, just ignore them, but return -ENOMEM at the end.
>          * - different from the way of handling in mlock etc.
>          */
> -       vma = find_vma_prev(current->mm, start, &prev);
> +       vma = find_vma_prev(mm, start, &prev);
>         if (vma && start > vma->vm_start)
>                 prev = vma;
>
> @@ -1130,19 +1134,19 @@ int do_madvise(unsigned long start, size_t len_in, int behavior)
>                 if (prev)
>                         vma = prev->vm_next;
>                 else    /* madvise_remove dropped mmap_sem */
> -                       vma = find_vma(current->mm, start);
> +                       vma = find_vma(mm, start);
>         }
>  out:
>         blk_finish_plug(&plug);
>         if (write)
> -               up_write(&current->mm->mmap_sem);
> +               up_write(&mm->mmap_sem);
>         else
> -               up_read(&current->mm->mmap_sem);
> +               up_read(&mm->mmap_sem);
>
>         return error;
>  }
>
>  SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
>  {
> -       return do_madvise(start, len_in, behavior);
> +       return do_madvise(current, current->mm, start, len_in, behavior);
>  }
> --
> 2.25.0.265.gbab2e86ba0-goog
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
