Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCA83B667C
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhF1QQY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 12:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhF1QQX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 12:16:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE1C061574
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 09:13:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so33548444lfc.8
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3MPWI09cDaXVTeiQJMgfQS8bGelaaSuy44zASltbRb4=;
        b=rkwRM0fS1WoGWcWVRW/6QFSgqfdRye+O5sp8Bib33VhmnJhVInq+Kk+YrqtdQ2KUMN
         cVqqGtolTmVmpZ7v4hxWOv+/SoYMpEGgRVoFXJOqR/SAer2Z5CcWmFgmNxymbO0j8XG3
         gRz9U8eKvxyx6T2Ky8tF23fOM+LvGnxv+Nrk0omQbmgcF6emaCtFgAvm/i18QLdd3mKI
         SIJkCqMT7KQeMug823yLWgRWAdnyq33kWyWJKUWvbY4JQ2MfrJGJYhk9eCQ03Kn/qpCv
         EQnaLbeA0tBA1/GFwDNLsAj/SPrxMR/G70gyjwnLii+cOkiKy+qpWyISlT/L5mRSy9h2
         T/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3MPWI09cDaXVTeiQJMgfQS8bGelaaSuy44zASltbRb4=;
        b=BTMzo6KZ0G81PzBcDoaoTgMHFPrM5kf5bbBnRYzUlbqBX4ambwUaL3OPoDE2kC/hwp
         Kb0SLrEcMT9bmTkY95jwp0R7+dgtOoX12OnvVzd/XliOAtdj6SuAKLAi49qXS1Aflcuw
         PdeWzusqpPU/+H9A6EPXdzcTbcO79CNFd7KL+V5NCc3nQ2MqfZJcG6AmOyUQ914dH5Jf
         4TkfvwZ7FFewi3ar0tXZ+EVfJsmY+CE3Ia+zriN2BVyiGg0kYusmxH8CiYIE959Jx+oW
         JHbGhYlhXG4mYKHxGrbGdMjqWkAtyOlI6j4Rx0wJR68/2umpHQL3H9yErLjF5RdrUBF4
         Bv3w==
X-Gm-Message-State: AOAM530ZgQIVkbGL8Y1TJ4AsEGKRix0Y8PN6VrYiGIcxecrNY6dPHRek
        80RdYxiLcRjRiYGJauCMLT3TR/+P3w0KILoZ9zIsnw==
X-Google-Smtp-Source: ABdhPJwZs5OJa+k9Ldlu6QGUA3YD4Fdm3MNpYu04zZpufuU9wCx4O+kM3Vy7OAY7jQpT9Sqrf1V5VMJvTejrr5aVbBs=
X-Received: by 2002:a05:6512:210e:: with SMTP id q14mr18614285lfr.356.1624896835735;
 Mon, 28 Jun 2021 09:13:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com> <20210414055217.543246-3-avagin@gmail.com>
In-Reply-To: <20210414055217.543246-3-avagin@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Jun 2021 18:13:29 +0200
Message-ID: <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
To:     Andrei Vagin <avagin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> This change introduces the new system call:
> process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
>                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)
>
> process_vm_exec allows to execute the current process in an address
> space of another process.
[...]

I still think that this whole API is fundamentally the wrong approach
because it tries to shoehorn multiple usecases with different
requirements into a single API. But that aside:

> +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> +{
> +       struct task_struct *tsk = current;
> +       struct mm_struct *active_mm;
> +
> +       task_lock(tsk);
> +       /* Hold off tlb flush IPIs while switching mm's */
> +       local_irq_disable();
> +
> +       sync_mm_rss(prev_mm);
> +
> +       vmacache_flush(tsk);
> +
> +       active_mm = tsk->active_mm;
> +       if (active_mm != target_mm) {
> +               mmgrab(target_mm);
> +               tsk->active_mm = target_mm;
> +       }
> +       tsk->mm = target_mm;

I'm pretty sure you're not currently allowed to overwrite the ->mm
pointer of a userspace thread. For example, zap_threads() assumes that
all threads running under a process have the same ->mm. (And if you're
fiddling with ->mm stuff, you should probably CC linux-mm@.)

As far as I understand, only kthreads are allowed to do this (as
implemented in kthread_use_mm()).

> +       switch_mm_irqs_off(active_mm, target_mm, tsk);
> +       local_irq_enable();
> +       task_unlock(tsk);
> +#ifdef finish_arch_post_lock_switch
> +       finish_arch_post_lock_switch();
> +#endif
> +
> +       if (active_mm != target_mm)
> +               mmdrop(active_mm);
> +}
