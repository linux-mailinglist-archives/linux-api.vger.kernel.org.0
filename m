Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED533E1801
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 17:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbhHEPaY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbhHEPaY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 11:30:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3FFC0613D5
        for <linux-api@vger.kernel.org>; Thu,  5 Aug 2021 08:30:09 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z5so7893222ybj.2
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 08:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2tU8mV4kGo7B6sAAhPR8hBvbRKDUXIJ345PeY/aAOBg=;
        b=f42bJF/1Dk3qBScrNnooaWUVAZzkLtIj7HBfdCOwEgtizu7GOgYeHzhTLcHYniO5F6
         RUlhXZJ1NNv0m4d/N4jpYoMs/zsueUVLfWdpg32nakElzLVGY8ajhUKdySHoSr2NtLlr
         WJheTug+4Cbr13BVfdGuZj4ZUVtzQCecn+o6GQkgOBmPnv6QoQqprx6zAUQYfI5J3j8Y
         ysTwi12ZG2dpM8CUh1bywMCrTFnmv8pgkKTAshspGbXaZU9u8WqgFHth7/1RlhOAS/jv
         lhqAalia4DP3BPSMN/cvfzFbrEzR0VVEvk+KSP19fPYmndIQ9+8hiD3URpC82jIongpY
         zmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2tU8mV4kGo7B6sAAhPR8hBvbRKDUXIJ345PeY/aAOBg=;
        b=Y0BuSX0HpDs1gDzmg6SqTGwpxe3uyX2ajzfCTAO/lBjoguFCSMNyEVzrZyCqDANlko
         9qhbjmaFrhh8oAxP9k52lTcdZvP9mpMAzIatONECe5N4MAPSZA4lnEmRqrTnWHykcaD7
         h8e2RYg/QupiaXBZMmIgBLsDvOvDlC6l4Hpq+cY6f5JcRDDVHr0oPm3ofXG/EtF/t9r6
         vP9nWOvP4AzdQFXqDc5Yw0PWXSA6ms9pO5oWJcemEPdG9TqiSDHjdxm7EwGLONDAHMzE
         3Tj5NdXJT5nvsTKZ8JwrVyt6CDRlHO0fn0I3EVysDOVK2pUOPctr9XwQrkL7JgexFe0E
         IdeA==
X-Gm-Message-State: AOAM531sfm29gbSZnvqmLQtFF+8MgWKA63GoIr48PgEqLiHxLbwHRIZw
        lTn/ASfSQGNMyZdFvqa9zrddNFvnNrxb17YdG8puPA==
X-Google-Smtp-Source: ABdhPJxUS4czW0V1Clmo2rkCzA8soyzkXMnFhkpuCErHWLlAEPCH8nIhEIa3XsBc7kIhmxFERhlxoO1fRLGjHS5wrn0=
X-Received: by 2002:a25:4216:: with SMTP id p22mr6237785yba.397.1628177408208;
 Thu, 05 Aug 2021 08:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210804185004.1304692-1-surenb@google.com> <YQuO36AeQUwsAyU1@dhcp22.suse.cz>
In-Reply-To: <YQuO36AeQUwsAyU1@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 5 Aug 2021 08:29:57 -0700
Message-ID: <CAJuCfpF1JSTSRu5v8s9wG0J-S+-p57tMO+0dUF+P16_6yYV7Mg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
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

On Thu, Aug 5, 2021 at 12:10 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 04-08-21 11:50:03, Suren Baghdasaryan wrote:
> [...]
> > +SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > +{
> > +#ifdef CONFIG_MMU
> > +     struct mm_struct *mm = NULL;
> > +     struct task_struct *task;
> > +     unsigned int f_flags;
> > +     struct pid *pid;
> > +     long ret = 0;
> > +
> > +     if (flags)
> > +             return -EINVAL;
> > +
> > +     pid = pidfd_get_pid(pidfd, &f_flags);
> > +     if (IS_ERR(pid))
> > +             return PTR_ERR(pid);
> > +
> > +     task = get_pid_task(pid, PIDTYPE_PID);
> > +     if (!task) {
> > +             ret = -ESRCH;
> > +             goto put_pid;
> > +     }
> > +
> > +     /*
> > +      * If the task is dying and in the process of releasing its memory
> > +      * then get its mm.
> > +      */
> > +     task = find_lock_task_mm(task);
>
> You want a different task_struct because the returned one might be
> different from the given one and you already hold a reference which you
> do not want to leak

Ah, right. I was looking at the task locking and find_lock_task_mm()
handles that but I missed the task pinning part. Will fix.

>
> > +     if (!task) {
> > +             ret = -ESRCH;
> > +             goto put_pid;
> > +     }
> > +     if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> > +             mm = task->mm;
> > +             mmget(mm);
> > +     }
> > +     task_unlock(task);
> > +     if (!mm) {
> > +             ret = -EINVAL;
> > +             goto put_task;
> > +     }
> > +
> > +     if (test_bit(MMF_OOM_SKIP, &mm->flags))
> > +             goto put_mm;
>
> This is too late to check for MMF_OOM_SKIP. task_will_free_mem will fail
> with the flag being set. I believe you want something like the
> following:
>
>         p = find_lock_task_mm(task);
>         mm = p->mm;
>
>         /* The work has been done already */
>         if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
>                 task_unlock(p);
>                 goto put_task;
>         }
>
>         i
>         if (!task_will_free_mem(p)) {
>                 task_unlock(p);
>                 goto put_task;
>         }
>
>         mmget(mm);
>         task_unlock(p);
>

I see. Let me update the patch and will ask Andrew to remove the
previous version from mm tree.
Thanks for reviewing and pointing out the issues!

>
> > +
> > +     if (mmap_read_lock_killable(mm)) {
> > +             ret = -EINTR;
> > +             goto put_mm;
> > +     }
> > +     if (!__oom_reap_task_mm(mm))
> > +             ret = -EAGAIN;
> > +     mmap_read_unlock(mm);
> > +
> > +put_mm:
> > +     mmput(mm);
> > +put_task:
> > +     put_task_struct(task);
> > +put_pid:
> > +     put_pid(pid);
> > +     return ret;
> > +#else
> > +     return -ENOSYS;
> > +#endif /* CONFIG_MMU */
> > +}
> > --
> > 2.32.0.554.ge1b32706d8-goog
>
> --
> Michal Hocko
> SUSE Labs
