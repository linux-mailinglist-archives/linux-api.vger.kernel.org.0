Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B373E3B50
	for <lists+linux-api@lfdr.de>; Sun,  8 Aug 2021 18:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhHHQOC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 8 Aug 2021 12:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhHHQOB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 8 Aug 2021 12:14:01 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CB8C0613CF
        for <linux-api@vger.kernel.org>; Sun,  8 Aug 2021 09:13:42 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id s48so24892190ybi.7
        for <linux-api@vger.kernel.org>; Sun, 08 Aug 2021 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TCK5nBQQabIUN0WbQjXhg9KlErctfVr7limBHCaiG+A=;
        b=P09Mz/mILYaoYE3EajDRpkc8akaY7fTBsUTWh/DDjvyIVcbgMaZWzI+LtlcoWEveOD
         rhx8918aHZb+O4eacyH9xJ39yZ0R0Ijqpx/MepcAKa8/2gZ5+AVf01MP0FU5rtgj0aaI
         ZOn+r2ameWRT7D0AaL+uSp1MMJV6BIO04kwUPuwtrDbWxbL86dxGwXjCh8J+AwMkozcs
         y1mHfPiyIhI4iox17HTcyNBHoFvdDSpVFAZKWamRg7qw92Jqi0wzk6fCPKC2Ilmft8gc
         6xtZM6GOlAFZn84PTqwvcOz6XFlG9JONgTvDHC8swDsPKC28qv4jvo5Vx9VKEuRlASq2
         T1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TCK5nBQQabIUN0WbQjXhg9KlErctfVr7limBHCaiG+A=;
        b=IHKDryPWso2TV0cfttb1sdZjMHzlnCnfiyL4N1X10fpCQH3kYaHw3idnGsNRTdzCe/
         AbvKT8Tm7g1G2Hgxzud8n8yYTo3Jnd901ooYIptKdurB8peCVrDNPABR3nPa3pTKwM4y
         YMuX1VbwVsrBDpLtGjAqxlKqrPK26P6ZMl6rDo4uAKjlyTk/ldhpBDaKvtFgpcK/yX+U
         NWqbN/U8FY/MV042gaw1jC+v0souHe0a9yQ0S1chaUYH35MXs4zqXqTIwqiw6W4c3lnK
         ijlOGnbNuXTiYaVdPWYkaaJqoxbiio1luO/8+13LslmEv7nixgIT/ECmyJTzpdxZfsys
         79vw==
X-Gm-Message-State: AOAM530NLij16SMwcKlpIwvi7RmF69eW3uSMI7avGgZtk0MF9sAtH0j3
        twkB4YDW3j5Y9+oRt3/hCZPWQFyuYsLZJEAtQJH71A==
X-Google-Smtp-Source: ABdhPJx0dWjYkHDsO+8kSP89UPL2BlSOBVWTieqq/F7t4NM8YSZ1slbEbkxEHATJiigRfMb9++IRuvn6g9kCzcz5GpU=
X-Received: by 2002:a25:49c2:: with SMTP id w185mr23459074yba.294.1628439221480;
 Sun, 08 Aug 2021 09:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210805170859.2389276-1-surenb@google.com> <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
 <CAJuCfpFL_7Zk4Nk5E_kCSnsCsXgmWGW9R3AnXW-T5EH7URUkRg@mail.gmail.com>
In-Reply-To: <CAJuCfpFL_7Zk4Nk5E_kCSnsCsXgmWGW9R3AnXW-T5EH7URUkRg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 8 Aug 2021 09:13:30 -0700
Message-ID: <CAJuCfpFeup+rppM7mbJWJeaCbTdbp=1=r24CjmLWWv4Vsydd2A@mail.gmail.com>
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

On Fri, Aug 6, 2021 at 9:07 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Aug 5, 2021 at 11:40 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 05-08-21 10:08:58, Suren Baghdasaryan wrote:
> > [...]
> > > +     /*
> > > +      * If the task is dying and in the process of releasing its memory
> > > +      * then get its mm.
> > > +      */
> > > +     p = find_lock_task_mm(task);
> > > +     if (!p) {
> > > +             ret = -ESRCH;
> > > +             goto put_pid;
> > > +     }
> > > +     if (task != p) {
> > > +             get_task_struct(p);
> > > +             put_task_struct(task);
> > > +             task = p;
> > > +     }
> >
> > Why do you need to take a reference to the p here? You are under
> > task_lock so this will not go away and you only need p to get your mm.
>
> True.
>
> >
> > > +
> > > +     /* If the work has been done already, just exit with success */
> > > +     if (test_bit(MMF_OOM_SKIP, &task->mm->flags))
> > > +             goto put_task;
> >
> > You want to release the task_lock
>
> Missed it again :(
>
> >
> > > +
> > > +     if (task_will_free_mem(task) && (task->flags & PF_KTHREAD) == 0) {
> >
> > you want task_will_free_mem(p) and what is the point of the PF_KTHREAD
> > check?
>
> Yeah, looks like task_will_free_mem() covers that case already.
>
> >
> > > +             mm = task->mm;
> > > +             mmget(mm);
> >
> > All you need is to make sure mm will not get released under your feet
> > once task_lock is released so mmgrab is the right thing to do here. The
> > address space can be torn down in parallel and that is OK and desirable.
> >
> > I think you really want something like this:
> >
> >         if (flags)
> >                 return -EINVAL;
> >
> >         pid = pidfd_get_pid(fd, &f_flags);
> >         if (IS_ERR(pid))
> >                 return PTR_ERR(pid);
> >         task = get_pid_task(pid, PIDTYPE_PID);
> >         if (!task) {
> >                 ret = -ESRCH;
> >                 goto put_pid;
> >         }
> >
> >         /*
> >          * Make sure to chose a thread which still has a reference to mm
> >          * during the group exit
> >          */
> >         p = find_lock_task_mm(task);
> >         if (!p) {
> >                 ret = -ESRCH;
> >                 goto put_task;
> >         }
> >
> >         mm = task->mm;
> >         mmgrab(mm);
> >         reap = true;
> >         /* If the work has been done already, just exit with success */
> >         if (test_bit(MMF_OOM_SKIP, &mm->flags)) {
> >                 reap = false;
> >         } else if (!task_will_free_mem(p)) {
> >                 reap = false;
> >                 ret = -EINVAL;
> >         }
> >         task_unlock(p);
> >
> >         if (!reap)
> >                 goto dropmm;;
> >
> >         /* Do the work*/
> >
> >
> > dropmm:
> >         mmdrop(mm);
> > put_task:
> >         put_task(task);
> > put_pid:
> >         put_pid(pid);
> >
> >         return ret;
> >
>
> This is indeed simpler to follow. I'll adopt your version. Thanks!

v8 is posted at https://lore.kernel.org/patchwork/patch/1473697/
Testing shows performance improvement from replacing mmget with mmgrab.

>
> > --
> > Michal Hocko
> > SUSE Labs
