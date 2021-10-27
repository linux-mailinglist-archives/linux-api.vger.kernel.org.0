Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6BF43CFED
	for <lists+linux-api@lfdr.de>; Wed, 27 Oct 2021 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhJ0RpI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 27 Oct 2021 13:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243330AbhJ0RpH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 27 Oct 2021 13:45:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE9C061348
        for <linux-api@vger.kernel.org>; Wed, 27 Oct 2021 10:42:41 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id d204so8308968ybb.4
        for <linux-api@vger.kernel.org>; Wed, 27 Oct 2021 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBCZKPDNQAHmIZq7XduSwhYmuOetWWPl476PrH0YNN0=;
        b=c1yWnQHxZHmMmNhoUfzo1TMFW/D1F1/UZAPStMR8kK2shT1bIlw4Vz87gK7e2W7C5d
         qZyapuNaU8LqKQ7yqG6aDFRV+/6fDIgicnSOt3MVoQv473UjZ4sNsN4GIxWCZwq8cvz/
         aXmvuWfYbWB3uoKmZf1L4BOJHgIU1r0S7jpDyMini7wC2QsiwWXh8jlTuABGzgvarTKU
         /PrRXTDJJn3cYwR7jGGdjH6OTWA1VuF5N24mb12ryhSfQelkF94CPVK+/s519yEvWEjG
         Yhp5wZgFsroCt/Ds03/trmCuPE988KKx9V74jYCqtKI/RerFz/T6u7PNkcYkzyvbUlou
         AfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBCZKPDNQAHmIZq7XduSwhYmuOetWWPl476PrH0YNN0=;
        b=A5Fk/AoyyZCj5R8XldAf/I/bRNE/i1XMQ4Ozs3VnZYBTjU1J/ijr+44WszbUDA+Ep6
         oIrFyiaAKVCrEG9OOoY0co6fRF83a+CH5GhSkHsFzOx1uGonOSFX5OsqXRSQd6EQDWxx
         1A5kE5Av30jwzSQsrIkJJY3KtlXR2k0z9AaEyLJMv4tPgdl+IL8mqIJzq1Jq8izXidMy
         La3G1YnSa21j9JlMBug7bqLouriFbZBPp228/tc4vDQCJ/T6pT9+kEyFsonvFfbqWeG5
         lQ8RqxHk3he/lmOMi1JzHp9ypiOTdptwthPFOrwh7xGG7kom+AqgFJPzhB7DiLuU2Sq5
         ZLLA==
X-Gm-Message-State: AOAM533398DOj6owu2712+uZWV1Meq9kCCKCL69vNsU2rPP5q52acHtP
        pW5SiYo5H5+1kciZbpeV0KvKxCTtmNOux1IoY+sKYQ==
X-Google-Smtp-Source: ABdhPJyzyQR0M+no29qupLGsoz3t3Qt4vFELy82tvV2wN2FrbWSg0TFPJJgUZMaYPBh3o4cyCdgrlqUnK/2uL8vDe4c=
X-Received: by 2002:a25:30b:: with SMTP id 11mr33445740ybd.202.1635356560450;
 Wed, 27 Oct 2021 10:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com> <YXmNaoV4dBTOJ3+w@casper.infradead.org>
In-Reply-To: <YXmNaoV4dBTOJ3+w@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Oct 2021 10:42:29 -0700
Message-ID: <CAJuCfpFP-57JkWhDAN4T6VtPboSV4LGqipHMU4j+wJKU45yjYg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 27, 2021 at 10:35 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 27, 2021 at 09:08:21AM -0700, Suren Baghdasaryan wrote:
> > Unconditional mmap_write_lock around free_pgtables in exit_mmap seems
> > to me the most semantically correct way forward and the pushback is on
> > the basis of regressing performance of the exit path. I would like to
> > measure that regression to confirm this. I don't have access to a big
> > machine but will ask someone in another Google team to try the test
> > Michal wrote here
> > https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/ on
> > a server with and without a custom patch.
>
> Sorry to hijack this, but could you ask that team to also test this
> patch?  I think there's probably a good-sized win here, but I have no
> profiles to share at this point.  I've only done light testing, and
> it may have bugs.
>
> NB: I only did the exit() path here.  fork() conversion is left as an
> exercise for the reader^W^W Liam.

To clarify, this patch does not change the mmap_write_lock portion of
exit_mmap. Do you want to test it in isolation or with the locking
changes in exit_mmap I mentioned?

>
> From 5f9daa14a5e58c86a73eccf59abe23d131004926 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Wed, 27 Oct 2021 13:28:35 -0400
> Subject: [PATCH] mm: Add vmavec
>
> The vmavec lets us allocate and free batches of VMAs instead of
> one at a time.  Should improve fork() and exit() performance.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/vmavec.h | 38 ++++++++++++++++++++++++++++++++++++++
>  kernel/fork.c          | 17 +++++++++++++++++
>  mm/mmap.c              | 30 ++++++++++++++++++++++--------
>  3 files changed, 77 insertions(+), 8 deletions(-)
>  create mode 100644 include/linux/vmavec.h
>
> diff --git a/include/linux/vmavec.h b/include/linux/vmavec.h
> new file mode 100644
> index 000000000000..8a324e2e1258
> --- /dev/null
> +++ b/include/linux/vmavec.h
> @@ -0,0 +1,38 @@
> +/*
> + * A vma vector is an array of vm_area_structs, with a counter.
> + */
> +
> +struct vm_area_struct;
> +
> +#define VMAVEC_SIZE    15
> +
> +struct vmavec {
> +       unsigned char nr;
> +       void *vmas[VMAVEC_SIZE];
> +};
> +
> +#define VMAVEC(name)   struct vmavec name = { }
> +
> +static inline bool vmavec_full(struct vmavec *vmavec)
> +{
> +       return vmavec->nr == VMAVEC_SIZE;
> +}
> +
> +static inline bool vmavec_empty(struct vmavec *vmavec)
> +{
> +       return vmavec->nr == 0;
> +}
> +
> +static inline
> +void vmavec_push(struct vmavec *vmavec, struct vm_area_struct *vma)
> +{
> +       vmavec->vmas[vmavec->nr++] = vma;
> +}
> +
> +static inline struct vm_area_struct *vmavec_pop(struct vmavec *vmavec)
> +{
> +       return vmavec->vmas[--vmavec->nr];
> +}
> +
> +void vm_area_free_vec(struct vmavec *vmavec);
> +void vm_area_alloc_vec(struct mm_struct *mm, struct vmavec *vmavec);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 38681ad44c76..ea7e8bd00be8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -97,6 +97,7 @@
>  #include <linux/scs.h>
>  #include <linux/io_uring.h>
>  #include <linux/bpf.h>
> +#include <linux/vmavec.h>
>
>  #include <asm/pgalloc.h>
>  #include <linux/uaccess.h>
> @@ -375,6 +376,22 @@ void vm_area_free(struct vm_area_struct *vma)
>         kmem_cache_free(vm_area_cachep, vma);
>  }
>
> +void vm_area_alloc_vec(struct mm_struct *mm, struct vmavec *vmavec)
> +{
> +       int i;
> +
> +       vmavec->nr = kmem_cache_alloc_bulk(vm_area_cachep, GFP_KERNEL,
> +                               VMAVEC_SIZE, vmavec->vmas);
> +       for (i = 0; i < vmavec->nr; i++)
> +               vma_init(vmavec->vmas[i], mm);
> +}
> +
> +void vm_area_free_vec(struct vmavec *vmavec)
> +{
> +       kmem_cache_free_bulk(vm_area_cachep, vmavec->nr, vmavec->vmas);
> +       vmavec->nr = 0;
> +}
> +
>  static void account_kernel_stack(struct task_struct *tsk, int account)
>  {
>         void *stack = task_stack_page(tsk);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 88dcc5c25225..bff4e94eec8c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -47,6 +47,7 @@
>  #include <linux/pkeys.h>
>  #include <linux/oom.h>
>  #include <linux/sched/mm.h>
> +#include <linux/vmavec.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/cacheflush.h>
> @@ -172,19 +173,24 @@ void unlink_file_vma(struct vm_area_struct *vma)
>         }
>  }
>
> -/*
> - * Close a vm structure and free it, returning the next.
> - */
> -static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
> +static void __remove_vma(struct vm_area_struct *vma)
>  {
> -       struct vm_area_struct *next = vma->vm_next;
> -
>         might_sleep();
>         if (vma->vm_ops && vma->vm_ops->close)
>                 vma->vm_ops->close(vma);
>         if (vma->vm_file)
>                 fput(vma->vm_file);
>         mpol_put(vma_policy(vma));
> +}
> +
> +/*
> + * Close a vm structure and free it, returning the next.
> + */
> +static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
> +{
> +       struct vm_area_struct *next = vma->vm_next;
> +
> +       __remove_vma(vma);
>         vm_area_free(vma);
>         return next;
>  }
> @@ -3125,6 +3131,7 @@ void exit_mmap(struct mm_struct *mm)
>  {
>         struct mmu_gather tlb;
>         struct vm_area_struct *vma;
> +       VMAVEC(vmavec);
>         unsigned long nr_accounted = 0;
>
>         /* mm's last user has gone, and its about to be pulled down */
> @@ -3179,9 +3186,16 @@ void exit_mmap(struct mm_struct *mm)
>         while (vma) {
>                 if (vma->vm_flags & VM_ACCOUNT)
>                         nr_accounted += vma_pages(vma);
> -               vma = remove_vma(vma);
> -               cond_resched();
> +               __remove_vma(vma);
> +               vmavec_push(&vmavec, vma);
> +               vma = vma->vm_next;
> +               if (vmavec_full(&vmavec)) {
> +                       vm_area_free_vec(&vmavec);
> +                       cond_resched();
> +               }
>         }
> +       if (!vmavec_empty(&vmavec))
> +               vm_area_free_vec(&vmavec);
>         vm_unacct_memory(nr_accounted);
>  }
>
> --
> 2.33.0
>
