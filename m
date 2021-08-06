Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405193E2E22
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 18:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhHFQH6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 12:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhHFQH5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 12:07:57 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F4C0613CF
        for <linux-api@vger.kernel.org>; Fri,  6 Aug 2021 09:07:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k65so15982875yba.13
        for <linux-api@vger.kernel.org>; Fri, 06 Aug 2021 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPa6gpCFto1S8Anmjbtf+lIZ5pc8QBEuFieat3/oBzA=;
        b=kTUbPF5bYWWgLbhYQS3gr9X4Bbz9A7Hw/wdSPQ6B3cZ6W5X64uvJT65/hMuDYACbXt
         B6E92tLsooMGIp4kZPX8L5GZxuGWZHgjloEYiIIRNkb4dOEw0hLST1NZXysc3aIhRUl9
         B5SODDpfG9MLdOeu/BuGEFmaCqEhLum1pKTtbtWXwzAs0dY7jU6qHCZsuV2z4k1SX/m5
         hq+kO0uclbmfSwmSpPtRdARCKy6lvWxemLl4dS43drZ+FJO2h7z1L039l+mkNfYk2N8H
         p7/J0QTh16ACpV+AeHzFrS1kwWVWHekATOYLVjf1CUbF/25QMpBhvAVuyeee/25cO0RW
         W2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPa6gpCFto1S8Anmjbtf+lIZ5pc8QBEuFieat3/oBzA=;
        b=mbYbYBSY7HvYNRFMkOQITDhFxmDrflphlSYTThwUhYM/AVZVofqLy5wrv42W4K+FmB
         +MzImTpnKZ2HxUhoIFLQ9lSZ/lUBGdwYScFFUtBKFZc6Id3Nsrg+Gs0xKCHI6Pt74/70
         kC326dM/BvG7lxpkqrB/8gJGin34Itrz31mG90RvjmiGSvU1sVdzaWq6wXqFG6Prl8Bb
         P/9Pu9vY9kYyzMnOJywSQd9PH2HsacuSgoBDcybnNE3YK3Vf3MlqXzk1chAwjqGZX73a
         mBR1OtFPCqtQfjaIMp3WEwJJkFHibZgfCpHb5T+YjuWYh6SFkbzad/8zJFIMDNCcrfLM
         Dy4g==
X-Gm-Message-State: AOAM531oP/gWnOlSeraCxnqU/ysqUov4oZkDyxDokEdfjXBrpuGoLxts
        N+c5g1u9879SoZXfGPq7NAz7gWK62ygOmKl32gXW9A==
X-Google-Smtp-Source: ABdhPJzqY00horHS8j6EKD2oP+k4vF7kKq9+gpuCgDvcEQ+vpxPPTyWaMOSn+vrADZbw1CTpsIc0CBOkQqfptXgSAHg=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr14175379ybc.136.1628266059961;
 Fri, 06 Aug 2021 09:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210805170859.2389276-1-surenb@google.com> <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
In-Reply-To: <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 6 Aug 2021 09:07:28 -0700
Message-ID: <CAJuCfpFL_7Zk4Nk5E_kCSnsCsXgmWGW9R3AnXW-T5EH7URUkRg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 5, 2021 at 11:40 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 05-08-21 10:08:58, Suren Baghdasaryan wrote:
> [...]
> > +     /*
> > +      * If the task is dying and in the process of releasing its memory
> > +      * then get its mm.
> > +      */
> > +     p = find_lock_task_mm(task);
> > +     if (!p) {
> > +             ret = -ESRCH;
> > +             goto put_pid;
> > +     }
> > +     if (task != p) {
> > +             get_task_struct(p);
> > +             put_task_struct(task);
> > +             task = p;
> > +     }
>
> Why do you need to take a reference to the p here? You are under
> task_lock so this will not go away and you only need p to get your mm.

True.

>
> > +
> > +     /* If the work has been done already, just exit with success */
> > +     if (test_bit(MMF_OOM_SKIP, &task->mm->flags))
> > +             goto put_task;
>
> You want to release the task_lock

Missed it again :(

>
> > +
> > +     if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
>
> you want task_will_free_mem(p) and what is the point of the PF_KTHREAD
> check?

Yeah, looks like task_will_free_mem() covers that case already.

>
> > +             mm = task->mm;
> > +             mmget(mm);
>
> All you need is to make sure mm will not get released under your feet
> once task_lock is released so mmgrab is the right thing to do here. The
> address space can be torn down in parallel and that is OK and desirable.
>
> I think you really want something like this:
>
>         if (flags)
>                 return -EINVAL;
>
>         pid = pidfd_get_pid(fd, &f_flags);
>         if (IS_ERR(pid))
>                 return PTR_ERR(pid);
>         task = get_pid_task(pid, PIDTYPE_PID);
>         if (!task) {
>                 ret = -ESRCH;
>                 goto put_pid;
>         }
>
>         /*
>          * Make sure to chose a thread which still has a reference to mm
>          * during the group exit
>          */
>         p = find_lock_task_mm(task);
>         if (!p) {
>                 ret = -ESRCH;
>                 goto put_task;
>         }
>
>         mm = task->mm;
>         mmgrab(mm);
>         reap = true;
>         /* If the work has been done already, just exit with success */
>         if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
>                 reap = false;
>         } else if (!task_will_free_mem(p)) {
>                 reap = false;
>                 ret = -EINVAL;
>         }
>         task_unlock(p);
>
>         if (!reap)
>                 goto dropmm;;
>
>         /* Do the work*/
>
>
> dropmm:
>         mmdrop(mm);
> put_task:
>         put_task(task);
> put_pid:
>         put_pid(pid);
>
>         return ret;
>

This is indeed simpler to follow. I'll adopt your version. Thanks!

> --
> Michal Hocko
> SUSE Labs
