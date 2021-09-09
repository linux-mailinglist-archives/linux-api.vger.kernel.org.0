Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600EF405EB3
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 23:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346332AbhIIVWe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 17:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbhIIVWe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Sep 2021 17:22:34 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB1EC061575
        for <linux-api@vger.kernel.org>; Thu,  9 Sep 2021 14:21:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id j12so5158257ljg.10
        for <linux-api@vger.kernel.org>; Thu, 09 Sep 2021 14:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jo48A/6vEdhUXGvQfBk5fPhiOK0Nx5+tyVkiJQ9UE1A=;
        b=SOUFGOJDCqE8hO3ROO4SYkOmMIL8xsiEijGi+FXXATaHL0N0/VyhBlza7lMIb0daoi
         eGqc3PQJgmztEDAJ283dGh3s5kbIxOEy92htSTzslv7DtYXbiy7HR7wnSaDFSOuq7KTl
         U6WvBRRF/mX41nyx/+5R/pKX0CwH2c5yrqHbco1QCnvUQb8OC/RB2p6AZHuOwbRo+bYG
         uIO/fgZVTk2fXKVBRoJzzdEh2GpH3bdEeyudyzcVFtBkf2+NpswyPir1SpaB4hYKOrHu
         1FRvm8YpSFKzFbAOAs5KK/S3GEeNmRthwxBhHSj4J0o74s7Yxo4vOqctbCgfwI+0Wd+o
         MUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jo48A/6vEdhUXGvQfBk5fPhiOK0Nx5+tyVkiJQ9UE1A=;
        b=XsRIUEMg7DD5eVDSOoE7KwAabGVvaCuhogs/Yo6Xje0OCIvfqDDH/V6cUC/bNbRX/k
         DoO3xApzChezRab9mVcjFxsEcSZLRt1QnFaOtqwqiyzkL4JuTGNUEZ+p50CczZz8D6tD
         JPSR1azOJcVWFd8f9tA6t7xwH1Qlj//lV1McevDFIf2xjH4QCHWPgjNphwviPuTisenz
         /FahjwnMxuPxtfShEM4A1IIbUKhO99pba8SkU5tOg34Tk8gR7H2uwpa44Uszg2T1Bo4M
         P5aonP7k9I2QAyZESsbioOXFSD93IGtittY046MMymKYVB6tMtBwdnIacsnpIGaym4LV
         6UTQ==
X-Gm-Message-State: AOAM530J0lUMKnwbKxfcYdtUxE7XjONyCA4dLzRohe1si9h53ECgv5Dz
        ZcsUZnzBlfjzJVLEvV5EUj4+Vnzb2MirbeNlAwvlgQ==
X-Google-Smtp-Source: ABdhPJxqwrJtXVgVcnK7CLGe9RMGTDbg9ItWrxypbspy4fHW2lO0d9u4QaAwddoTnFPMBXiw2rUdSE+1gAA6ImN599k=
X-Received: by 2002:a2e:1508:: with SMTP id s8mr631481ljd.47.1631222482331;
 Thu, 09 Sep 2021 14:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com> <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
In-Reply-To: <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Sep 2021 23:20:55 +0200
Message-ID: <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 9, 2021 at 9:07 PM Peter Oskolkov <posk@google.com> wrote:
> On Wed, Sep 8, 2021 at 4:39 PM Jann Horn <jannh@google.com> wrote:
>
> Thanks a lot for the reviews, Jann!
>
> I understand how to address most of your comments. However, one issue
> I'm not sure what to do about:
>
> [...]
>
> > If this function is not allowed to sleep, as the comment says...
>
> [...]
>
> > ... then I'm pretty sure you can't call fix_pagefault() here, which
> > acquires the mmap semaphore (which may involve sleeping) and then goes
> > through the pagefault handling path (which can also sleep for various
> > reasons, like allocating memory for pagetables, loading pages from
> > disk / NFS / FUSE, and so on).
>
> <quote from peterz@ from
> https://lore.kernel.org/lkml/20210609125435.GA68187@worktop.programming.kicks-ass.net/>:
>   So a PF_UMCG_WORKER would be added to sched_submit_work()'s PF_*_WORKER
>   path to capture these tasks blocking. The umcg_sleeping() hook added
>   there would:
>
>     put_user(BLOCKED, umcg_task->umcg_status);
>     ...
> </quote>
>
> Which is basically what I am doing here: in sched_submit_work() I need
> to read/write to userspace; and we cannot sleep in
> sched_submit_work(), I believe.
>
> If you are right that it is impossible to deal with pagefaults from
> within non-sleepable contexts, I see two options:
>
> Option 1: as you suggest, pin pages holding struct umcg_task in sys_umcg_ctl;

FWIW, there is a variant on this that might also be an option:

You can create a new memory mapping from kernel code and stuff pages
into it that were originally allocated as normal kernel pages. This is
done in a bunch of places, e.g.:

This has the advantage that it avoids pinning random pages that were
originally allocated from ZONE_MOVABLE blocks. (Or pinning hugepages,
or something like that.)
The downsides are that it reduces userspace's freedom to place the
UAPI structs wherever it wants (so userspace e.g. probably can't
directly put the struct in thread-local storage, instead it has to
store a pointer to the struct), and that you need to write a bunch of
code to create the mapping and allocate slots in these pages for
userspace threads.

Maybe UMCG_CTL_REGISTER could do something vaguely like this (utterly
untested, I just scribbled this down in my mail client)?


#define UMCG_TASKS_PER_PAGE (sizeof(struct umcg_task) / PAGE_SIZE)
struct umcg_page {
  struct page *page;
  struct umcg_task *__user user_base;
  struct vm_special_mapping special_mapping;
  DECLARE_BITMAP(inuse_bits, UMCG_TASKS_PER_PAGE);
 };
struct mm_umcg {
  struct umcg_page *slot_pages;
  size_t slot_page_count;
  size_t used_slots;
};
struct mm_struct {
   ...
#ifdef CONFIG_UMCG
    struct mm_umcg umcg;
#endif
  ...
};

static int deny_mremap(struct vm_area_struct *new_vma)
{
  return -EINVAL;
}

BUILD_BUG_ON(UMCG_TASKS_PER_PAGE < 1);
struct mm_struct *mm = current->mm;
size_t page_idx, free_idx_in_page;
if (!mmap_lock_killable(mm))
  return -EINTR;
if (mm->umcg.used_slots == mm->umcg.slot_page_count * UMCG_TASKS_PER_PAGE) {
  unsigned long addr;
  struct page *new_page;
  struct umcg_page *slot_pages_new;

  addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
  if (IS_ERR_VALUE(addr)) {
    ret = addr;
    goto unlock;
  }

  slot_pages_new = krealloc_array(mm->umcg.slot_page_count + 1,
sizeof(struct umcg_page), GFP_KERNEL);
  if (!slot_pages_new) {
    ret = -ENOMEM;
    goto unlock;
  }
  mm->umcg.slot_pages = slot_pages_new;
  new_page = alloc_page(GFP_USER | __GFP_ACCOUNT);
  if (!new_page) {
    ret = -ENOMEM;
    goto unlock;
  }
  mm->umcg.slot_pages[mm->umcg.slot_page_count].page = new_page;
  mm->umcg.slot_pages[mm->umcg.slot_page_count].user_base = addr;
  mm->umcg.slot_pages[mm->umcg.slot_page_count].special_mapping.name = "[umcg]";
  mm->umcg.slot_pages[mm->umcg.slot_page_count].special_mapping.pages
= &mm->umcg.slot_pages[mm->umcg.slot_page_count].page;
  mm->umcg.slot_pages[mm->umcg.slot_page_count].special_mapping.mremap
= deny_mremap;
  if (IS_ERR(_install_special_mapping(mm, addr, PAGE_SIZE,
VM_READ|VM_WRITE|VM_MAYREAD|VM_MAYWRITE|VM_DONTCOPY,
&new_page->special_mapping)))
    ... free new_page and return error ...
  mm->umcg.slot_page_count++;
}

for (page_idx = 0; 1; page_idx++) {
  if (page_idx == mm->umcg->slot_page_count)
    ... WARN() and bail out, shouldn't happen...
  free_idx_in_page =
find_first_zero_bit(mm->umcg->slot_pages[page_idx],
UMCG_TASKS_PER_PAGE);
  if (free_idx_in_page != UMCG_TASKS_PER_PAGE)
    break;
}
set_bit(free_idx_in_page, mm->umcg->slot_pages[page_idx]);
mm->umcg.used_slots++;
current->umcg_user_mapping = mm->umcg->slot_pages[page_idx].user_base
+ free_idx_in_page;
current->umcg_kernel_mapping = (struct umcg_task
*)page_to_virt(mm->umcg->slot_pages[page_idx].page) +
free_idx_in_page;
current->umcg_index = page_idx * UMCG_TASKS_PER_PAGE + free_idx_in_page;
unlock:
mmap_unlock(mm);

... and then when a task exits, you'd pretty much just take the
mmap_lock and do clear_bit(current->umcg_index % UMCG_TASKS_PER_PAGE,
current->mm->umcg.slot_pages[current->umcg_index /
UMCG_TASKS_PER_PAGE].inuse_bits)?

The pages would stay allocated as long as the process is running, but
given how fragmented those pages are going to get, that's probably
inevitable. And when the process exits (more precisely, when the
mm_struct is torn down), you could free all this stuff?

Note that what I'm suggesting here is a bit unusual - normally only
the vDSO is a "special mapping", other APIs tend to use mappings that
are backed by files. But I think we probably don't want to have a file
involved here...

If you decide to go this route, you should probably CC
linux-mm@kvack.org (for general memory management) and Andy Lutomirski
(who has tinkered around in vDSO-related code a lot).

> or
>
> Option 2: add more umcg-related kernel state to task_struct so that
> reading/writing to userspace is not necessary in sched_submit_work().
>
> The first option sounds much better from the code simplicity point of
> view, but I'm not sure if it is a viable approach, i.e. I'm afraid
> we'll get a hard NACK here, as a non-privileged process will be able
> to force the kernel to pin a page per task/thread.

To clarify: It's entirely normal that userspace processes can force
the kernel to hold on to some amounts of memory that can't be paged
out - consider e.g. pagetables and kernel objects referenced by file
descriptors. So an API that pins limited amounts of memory that are
also mapped in userspace isn't inherently special. But pinning pages
that were originally allocated as normal userspace memory can be more
problematic because that memory might be hugepages, or file pages, or
it might prevent the hugepaged from being able to defragment memory
because the pinned page was allocated in ZONE_MOVABLE.


> We may get around
> it by first pinning a limited number of pages, then having the
> userspace allocate structs umcg_task on those pages, so that a pinned
> page would cover more than a single task/thread. And have a sysctl
> that limits the number of pinned pages per MM.

I think that you wouldn't necessarily need a sysctl for that if the
kernel can enforce that you don't have more pages allocated than you
need for the maximum number of threads that have ever been running
under the process, and you also use __GFP_ACCOUNT so that cgroups can
correctly attribute the memory usage.

> Peter Z., could you, please, comment here? Do you think pinning pages
> to hold structs umcg_task is acceptable?
