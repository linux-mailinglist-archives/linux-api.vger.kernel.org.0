Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A2C21390A
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 13:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCLEf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 07:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCLEf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 07:04:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DBAC08C5C1
        for <linux-api@vger.kernel.org>; Fri,  3 Jul 2020 04:04:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so18209218lfl.5
        for <linux-api@vger.kernel.org>; Fri, 03 Jul 2020 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OSzLG/Q5ctkpPGhuaPoxJvjTyfdlXE2F3IbF2Pwkk7E=;
        b=Pua0s1Lja8sM6i+ugrq9k9QZGR/RJ80SSdCJ/kQ/d6ICO4o7o6CHfNFNSZ0Q4rrKIq
         smEu/TpYh/5kBXc3s7RbLvo9vdxuEgfJ9fnIoKxHcGvY9MeDojxCKeBm1jw9Lxo1S+uw
         xEcODlP6Kw5MVjda+EIESAD6qsfRipIGOswibWtuyOa0IXiTEWfb09F1WET2qlW97S1u
         km5fBU37jUymHPZnsVe77SYwM7yLj+Lj/N2E5xUWMuMAxc2BA/N1GzbxrsPqcd7aC1i1
         uhpgIEp9C3qnctr4mj4T1fu3oiZ6FjKSaUKystz+5WdalJgVMlOdRQ3GxgiADnJbj2Pz
         Pelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OSzLG/Q5ctkpPGhuaPoxJvjTyfdlXE2F3IbF2Pwkk7E=;
        b=Q3R5JJ7o7+SVwsBxJKWHeohno58FzTtlyIEfSVrauEFF7SBRmJoSG5Q1LBVbd6J3cf
         ipZKv4Y+7bkJCQcKSKzgSyAfrc0yHfjeq5cfhf+lVayc2kgQhV6Fvbbt2X4in+Xou2QV
         1rzfIHWS/JoG4rWAYY4BC/4iaMyZH4mpyFGj+p8DQj2giq+Vn3SSxC74vMq6m1uqSGJP
         1Edarec/NY7PVfLybqAjEKe4gfmv7gfLFhEmLR3tqNDt/zOirvIeUqSlW223WpYvLa+u
         11tJHqXCjCMKEK8ALT+R6K/xrWjABDo8JuemiTFB6sQUDjAyR++aCVXJsdxIzaPTCRVH
         qVlQ==
X-Gm-Message-State: AOAM531LCRiI+R/sp+LWW/RufTw5gOTGDOwiUcVivEmo1W59KR3LYk2U
        Su3hP3nUlAlHoC4boYsL6mZs+GqVB7fLVzEX91BkUw==
X-Google-Smtp-Source: ABdhPJwCBAYxeYjK4PxqGeHvUGXev/BGu5CvhhXznpS3i7EMvLEgcVNQSVGxxsASwC6knmsUQUEOB6ytdcgHUZZ9pVM=
X-Received: by 2002:a05:6512:3107:: with SMTP id n7mr21993946lfb.63.1593774271705;
 Fri, 03 Jul 2020 04:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
In-Reply-To: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 3 Jul 2020 13:04:05 +0200
Message-ID: <CAG48ez2CpHX9i3YgkNyMHPz63ohjkaSZscMtwSHOFYN4VQow3Q@mail.gmail.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
To:     "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 3, 2020 at 12:34 PM Catangiu, Adrian Costin
<acatan@amazon.com> wrote:
> Cryptographic libraries carry pseudo random number generators to
> quickly provide randomness when needed. If such a random pool gets
> cloned, secrets may get revealed, as the same random number may get
> used multiple times. For fork, this was fixed using the WIPEONFORK
> madvise flag [1].
>
> Unfortunately, the same problem surfaces when a virtual machine gets
> cloned. The existing flag does not help there. This patch introduces a
> new flag to automatically clear memory contents on VM suspend/resume,
> which will allow random number generators to reseed when virtual
> machines get cloned.
>
> Examples of this are:
>  - PKCS#11 API reinitialization check (mandated by specification)
>  - glibc's upcoming PRNG (reseed after wake)
>  - OpenSSL PRNG (reseed after wake)
>
> Benefits exist in two spaces:
>  - The security benefits of a cloned virtual machine having a
>    re-initialized PRNG in every process are straightforward.
>    Without reinitialization, two or more cloned VMs could produce
>    identical random numbers, which are often used to generate secure
>    keys.
>  - Provides a simple mechanism to avoid RAM exfiltration during
>    traditional sleep/hibernate on a laptop or desktop when memory,
>    and thus secrets, are vulnerable to offline tampering or inspection.

For the first usecase, I wonder which way around this would work
better - do the wiping when a VM is saved, or do it when the VM is
restored? I guess that at least in some scenarios, doing it on restore
would be nicer because that way the hypervisor can always instantly
save a VM without having to wait for the guest to say "alright, I'm
ready" - especially if someone e.g. wants to take a snapshot of a
running VM while keeping it running? Or do hypervisors inject such
ACPI transitions every time they snapshot/save/restore a VM anyway?

> This RFC is foremost aimed at defining a userspace interface to enable
> applications and libraries that store or cache sensitive information,
> to know that they need to regenerate it after process memory has been
> exposed to potential copying.  The proposed userspace interface is
> a new MADV_WIPEONSUSPEND 'madvise()' flag used to mark pages which
> contain such data. This newly added flag would only be available on
> 64bit archs, since we've run out of 32bit VMA flags.
>
> The mechanism through which the kernel marks the application sensitive
> data as potentially copied, is a secondary objective of this RFC. In
> the current PoC proposal, the RFC kernel code combines
> MADV_WIPEONSUSPEND semantics with ACPI suspend/wake transitions to zero
> out all process pages that fall in VMAs marked as MADV_WIPEONSUSPEND
> and thus allow applications and libraries be notified and regenerate
> their sensitive data.  Marking VMAs as MADV_WIPEONSUSPEND results in
> the VMAs being empty in the process after any suspend/wake cycle.
> Similar to MADV_WIPEONFORK, if the process accesses memory that was
> wiped on suspend, it will get zeroes.  The address ranges are still
> valid, they are just empty.
>
> This patch adds logic to the kernel power code to zero out contents of
> all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> to any suspend state equal or greater/deeper than Suspend-to-memory,
> known as S3.
>
> MADV_WIPEONSUSPEND only works on private, anonymous mappings.
> The patch also adds MADV_KEEPONSUSPEND, to undo the effects of a
> prior MADV_WIPEONSUSPEND for a VMA.
>
> Hypervisors can issue ACPI S0->S3 and S3->S0 events to leverage this
> functionality in a virtualized environment.
>
> Alternative kernel implementation ideas:
>  - Move the code that clears MADV_WIPEONFORK pages to a virtual
>    device driver that registers itself to ACPI events.
>  - Add prerequisite that MADV_WIPEONFORK pages must be pinned (so
>    no faulting happens) and clear them in a custom/roll-your-own
>    device driver on a NMI handler. This could work in a virtualized
>    environment where the hypervisor pauses all other vCPUs before
>    injecting the NMI.
>
> [1] https://lore.kernel.org/lkml/20170811212829.29186-1-riel@redhat.com/
[...]
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index c874a7026e24..4282b7f0dd03 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -323,6 +323,78 @@ static bool platform_suspend_again(suspend_state_t state)
>                 suspend_ops->suspend_again() : false;
>  }
>
> +#ifdef VM_WIPEONSUSPEND
> +static void memory_cleanup_on_suspend(suspend_state_t state)
> +{
> +       struct task_struct *p;
> +       struct mm_struct *mm;
> +       struct vm_area_struct *vma;
> +       struct page *pages[32];
> +       unsigned long max_pages_per_loop = ARRAY_SIZE(pages);
> +
> +       /* Only care about states >= S3 */
> +       if (state < PM_SUSPEND_MEM)
> +               return;
> +
> +       rcu_read_lock();
> +       for_each_process(p) {
> +               int gup_flags = FOLL_WRITE;
> +
> +               mm = p->mm;
> +               if (!mm)
> +                       continue;
> +
> +               down_read(&mm->mmap_sem);

Blocking actions, such as locking semaphores, are forbidden in RCU
read-side critical sections. Also, from a more high-level perspective,
do we need to be careful here to avoid deadlocks with frozen tasks or
stuff like that?

> +               for (vma = mm->mmap; vma; vma = vma->vm_next) {
> +                       unsigned long addr, nr_pages;
> +
> +                       if (!(vma->vm_flags & VM_WIPEONSUSPEND))
> +                               continue;
> +
> +                       addr = vma->vm_start;
> +                       nr_pages = (vma->vm_end - addr - 1) / PAGE_SIZE + 1;
> +                       while (nr_pages) {
> +                               int count = min(nr_pages, max_pages_per_loop);
> +                               void *kaddr;
> +
> +                               count = get_user_pages_remote(p, mm, addr,
> +                                                       count, gup_flags,
> +                                                       pages, NULL, NULL);

get_user_pages_remote() can wait for disk I/O (for swapping stuff back
in), which we'd probably like to avoid here. And I think it can also
wait for userfaultfd handling from userspace? zap_page_range() (which
is what e.g. MADV_DONTNEED uses) might be a better fit, since it can
yank entries out of the page table (forcing the next write fault to
allocate a new zeroed page) without faulting them into RAM.

> +                               if (count <= 0) {
> +                                       /*
> +                                        * FIXME: In this PoC just break if we
> +                                        * get an error.
> +                                        * In the final implementation we need
> +                                        * to handle this better and not leave
> +                                        * pages uncleared.
> +                                        */
> +                                       break;
> +                               }
> +                               /* Go through pages buffer and clear them. */
> +                               while (count) {
> +                                       struct page *page = pages[--count];
> +
> +                                       kaddr = kmap(page);
> +                                       clear_page(kaddr);
> +                                       kunmap(page);

(This part should go away, but if it stayed, you'd probably want to
use clear_user_highpage() or so instead of open-coding this.)

> +                                       put_page(page);
> +                                       nr_pages--;
> +                                       addr += PAGE_SIZE;
> +                               }
> +                       }
> +               }
> +               up_read(&mm->mmap_sem);
> +       }
> +       rcu_read_unlock();
> +}
