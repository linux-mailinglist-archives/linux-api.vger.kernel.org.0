Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0964041DA
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 01:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhIHXkN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 19:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhIHXkM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 19:40:12 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4ABC061575
        for <linux-api@vger.kernel.org>; Wed,  8 Sep 2021 16:39:03 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l18so6230613lji.12
        for <linux-api@vger.kernel.org>; Wed, 08 Sep 2021 16:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2WeuCmhWaFYpyNVf9oP+KeCDcHhyaae5mJ9onxwaPPE=;
        b=O327Ig1XKpBHQ67egGdBzzNalweEv/MWYcnITSM7fnWIU/fovblbPA6fub7vzhTICf
         t1mrkpbOHL1yZG3Z4O15FZjB5kurpXglhwpFjfCJb8FlFHEhEViQ3z6eSwg4Gs2VfqrO
         X2eIhKuW0oJFOqDX6IsJdGwGiUhNsJQc4YCagRpvAdPYELZhvLcFwzlp76ly6RWTO073
         as5yXv7qnnohr1vENmrujf/uq3bzf8rUTitkMubz/a0iW12HQY4cbEJ1JK9fO6VY3Sk2
         SGkSqPrQSRFyjzziW5sNLfWzbMBlQkqpqJssiSO9pNHU+K664T23PKfJ6yxaCi6Q+9Il
         /JxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2WeuCmhWaFYpyNVf9oP+KeCDcHhyaae5mJ9onxwaPPE=;
        b=WE9kos6fYu9WYB4vdH02vTyuwVYqG4J061+LkfxLmI5DShEvHhPj5djV7JKWMYgTcn
         yEgUWrBKAZLQCywqqGvCiHnH/sA3iqTuAt6aoJsEVNOi4U83lv3JB1bMAPdvuIAlFwW4
         SmKWKpgW0NOihxFiSjGeqh6m0wu7KkuRxkc7ekQEotSdY4F7OvVdH7U+yNl4of9qOJ2I
         chJ2IVlXLDX18SOx7fcjXVIjubvR5Wq4FkIue+1spxZVtWKkwD+Lks8tPU63MOSz1gx/
         j9pHEb1lmhqkhzzcE763Wt+i8olC9+frlwg3VuUwvWgxhwA79WC/U65vCErwLn6Slhjl
         8giQ==
X-Gm-Message-State: AOAM530VP8m2n3YJhNC4UA44bYIEFJkNF25xx7bQWzctcMHLnbsH6PnC
        EBpn3M2fIlkqkBj4lPPL+kPv00qaRdJkRa4AM0YbJg==
X-Google-Smtp-Source: ABdhPJxRRvoxjXIq8Em7uYSGE5Tb5mF9KiWDuLBGRpZkPuXv4fwzD5lhuEMZ8zYSTSx+gJdWc1urdbx4Q+79JGBiXhY=
X-Received: by 2002:a05:651c:118f:: with SMTP id w15mr631194ljo.47.1631144341124;
 Wed, 08 Sep 2021 16:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210908184905.163787-1-posk@google.com> <20210908184905.163787-3-posk@google.com>
In-Reply-To: <20210908184905.163787-3-posk@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 9 Sep 2021 01:38:34 +0200
Message-ID: <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
To:     Peter Oskolkov <posk@posk.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 8, 2021 at 8:49 PM Peter Oskolkov <posk@posk.io> wrote:
> Add helper functions to work atomically with userspace 32/64 bit values -
> there are some .*futex.* named helpers, but they are not exactly
> what is needed for UMCG; I haven't found what else I could use, so I
> rolled these.
[...]
> +static inline int fix_pagefault(unsigned long uaddr, bool write_fault)
> +{
> +       struct mm_struct *mm = current->mm;
> +       int ret;
> +
> +       mmap_read_lock(mm);

A minor note: mmap_read_lock() can potentially block for extended
amounts of time, so *if* you have a way to safely bail out, it's nice
to use mmap_read_lock_killable() to ensure that if the task gets
killed, it'll go away quickly instead of continuing to potentially
wait on the lock. (But of course, there are situations where you just
can't do that, so there you have to use the unconditional
mmap_read_lock().)

So here, since you need a bailout path anyway in this function, I'd write:

if (mmap_read_lock_killable(mm))
        return -EINTR;

> +       ret = fixup_user_fault(mm, uaddr, write_fault ? FAULT_FLAG_WRITE : 0,
> +                       NULL);
> +       mmap_read_unlock(mm);
> +
> +       return ret < 0 ? ret : 0;
> +}
[...]
> +static inline int __try_xchg_user_64(u64 *oval, u64 __user *uaddr, u64 newval)
> +{
> +       u64 oldval = 0;
> +       int ret = 0;
> +
> +       asm volatile("\n"
> +               "1:\txchgq %0, %2\n"
> +               "2:\n"
> +               "\t.section .fixup, \"ax\"\n"
> +               "3:\tmov     %3, %0\n"
> +               "\tjmp     2b\n"
> +               "\t.previous\n"
> +               _ASM_EXTABLE_UA(1b, 3b)
> +               : "=r" (oldval), "=r" (ret), "+m" (*uaddr)
> +               : "i" (-EFAULT), "0" (newval), "1" (0)
> +       );
> +
> +       if (ret)
> +               return ret;
> +
> +       *oval = oldval;
> +       return 0;
> +}
[...]
> +/**
> + * xchg_64_user - atomically exchange 64-bit values
> + *
> + * Return:
> + * 0 - OK
> + * -EFAULT: memory access error
> + */
> +static inline int xchg_user_64(u64 __user *uaddr, u64 *val)
> +{
> +       int ret = -EFAULT;
> +
> +       if (unlikely(!access_ok(uaddr, sizeof(*uaddr))))
> +               return -EFAULT;

For these atomic xchg operations, I think you should probably also
check for proper alignment (something like "(unsigned long)uaddr %
sizeof(*uaddr) == 0", I guess)?
Otherwise the __try_xchg_user_64() call could hit Split Lock Detection
(see <https://lore.kernel.org/all/1555536851-17462-1-git-send-email-fenghua.yu@intel.com/>)
on newer hardware, meaning the XCHGQ instruction would throw a #AC
exception, which would get caught by the kernel because it happened
during user access, so then you land on the fixup path that returns
-EFAULT, and then this function would assume that it was caused by a
pagefault, invoke pagefault handling, the pagefault handling would say
"the page is present, try again now", and you'd end up in an infinite
loop...

(Yes, the futex version doesn't have that - the futex code instead
does that check further up, in get_futex_key() and
handle_futex_death().)

> +       pagefault_disable();
> +
> +       while (true) {
> +               __uaccess_begin_nospec();
> +               ret = __try_xchg_user_64(val, uaddr, *val);
> +               user_access_end();
> +
> +               if (!ret)
> +                       break;
> +
> +               if (fix_pagefault((unsigned long)uaddr, true) < 0)
> +                       break;
> +       }
> +
> +       pagefault_enable();
> +
> +       return ret;
> +}
> +
> +/**
> + * get_user_nosleep - get user value with inline fixup without sleeping.
> + *
> + * get_user() might sleep and therefore cannot be used in preempt-disabled
> + * regions.
> + */

If this function is not allowed to sleep, as the comment says...

> +#define get_user_nosleep(out, uaddr)                                   \
> +({                                                                     \
> +       int ret = -EFAULT;                                              \
> +                                                                       \
> +       if (access_ok((uaddr), sizeof(*(uaddr)))) {                     \
> +               pagefault_disable();                                    \
> +                                                                       \
> +               while (true) {                                          \
> +                       if (!__get_user((out), (uaddr))) {              \
> +                               ret = 0;                                \
> +                               break;                                  \
> +                       }                                               \
> +                                                                       \
> +                       if (fix_pagefault((unsigned long)(uaddr), false) < 0) \
> +                               break;                                  \

... then I'm pretty sure you can't call fix_pagefault() here, which
acquires the mmap semaphore (which may involve sleeping) and then goes
through the pagefault handling path (which can also sleep for various
reasons, like allocating memory for pagetables, loading pages from
disk / NFS / FUSE, and so on).

If you're in some kind of non-sleepable context, and you want to
access a userspace address that isn't currently paged in, you have to
get out of whatever non-sleepable context you're in before going
through the fault-handling path and back into the context you were in.

Alternatively, if sleeping isn't possible and getting back out of the
sleepable context temporarily is also too hard, you could try to look
up the userspace page ahead of time (e.g. during umcg_ctl()) with
pin_user_pages_unlocked() and kmap() it into the kernel. That's
probably a lot slower than a direct userspace access, but if you only
have to do it during umcg_ctl(), that might not be a problem. It also
more or less requires that the userspace struct doesn't cross a page
boundary (otherwise you'd have to either vmap it or use helpers for
accessing the pages), and it means you have 4KiB of extra unswappable
memory per thread, and it might worsen memory fragmentation (because
pinned pages can't be migrated anymore even though the kernel thought
they'd probably be migratable at page allocation time).

Since it looks like you want to access userspace memory during
sched_submit_work() (e.g. for storing the UMCG_TF_PREEMPTED flag), I
think the pin_user_pages_unlocked() approach is what you'll have to
use there. There you can then essentially access the userspace
structure through its kernel mapping, basically like normal kernel
memory (except of course that you have to keep in mind that userspace
can concurrently read and write that memory, so instead of plain
loads/stores you have to use at least READ_ONCE()/WRITE_ONCE()).

You of course won't be able to simply traverse userspace pointers in
such a situation, only access the specific userspace object that
you've prepared beforehand, but luckily it looks like:

 * idle_server_tid_ptr is only accessed in get_idle_server()
   -> which is used from process_waking_worker()
     -> which runs in sleepable context
 * idle_workers_ptr is accessed from:
   -> enqueue_idle_worker
     -> which is also used from process_waking_worker()

so I guess that's not a problem?





> +               }                                                       \
> +                                                                       \
> +               pagefault_enable();                                     \
> +       }                                                               \
> +       ret;                                                            \
> +})
