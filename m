Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C89F3E272B
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 11:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244363AbhHFJXq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 05:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbhHFJXq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 05:23:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F6AC061799
        for <linux-api@vger.kernel.org>; Fri,  6 Aug 2021 02:23:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u3so16658338lff.9
        for <linux-api@vger.kernel.org>; Fri, 06 Aug 2021 02:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pz/ZNLrZ0O+ZYLO34S4orrCykgTqtG1p1sxk4AuVhP8=;
        b=cGHj/WVq/vdRsPecp7h5K9JfcZgFhYagyOxvNOodNjPWx1ajkrEXS3JlyTiNibU3Zp
         SwCEr2nxYnnoN/rDaQwb38GFSgdZl2Kq0S1ZixHKqp+2avGFzfRNz6/iVMXsnP13GDXH
         RgM2ccrAp/Y1PFbzphGj/HwyUf/rf0UTzlmJOICfUXjvGmeePTEJrpD9OV4lH2mafCPY
         EUwoVZfgNlJ5UV5dhZ/CcQ8uSISli8alXXvbGedEUPmFhOF7U0zEPU4QCO18qhf9yaxy
         TcA08g0vlBeSatSxXBIZQVQuFf1Og0jFqjL2CJHgmHoOtEAS/Q+fp37wUoAuWgX6aBA1
         VJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pz/ZNLrZ0O+ZYLO34S4orrCykgTqtG1p1sxk4AuVhP8=;
        b=BhxK69MYK6MEEfREBhtaiqOHeFnyzxcY+sAde4YANJcnUiy3OIaWakkb/+XeQubVsg
         lLuw7VYu6hy0532h4QGLWfHS6sHQEEAkTd8FQ/Z2KqhbqdNyK/YFKu5ZdkuHcV6gQR0J
         kneuBnyFh03qmmo+x+093h9VT5RYDoGxZmZJCd/7d+1SG0vrd3xj3l1RodyFSY/LX0xf
         U9V/j/qFXfO+RUqBuaqbVFtx/kOwWYda0vWh4ni8j5hiOHkeEouFWEZI2lnTZmow8Izx
         54fjU0lIwRhvvtAHwKwia6bQU+vHd8k0nHNxL7fj6ICkyVRkYvnHgLvbtWUF1NmMeLYy
         PujA==
X-Gm-Message-State: AOAM533zht890kbW08PTtIJX2Lm53DTEszk+fUPV2cQtRqZGXrab+BeS
        0ZyL3NMRbQqTqsEH2GDLmZTyt96bCjkCAQEq6MDS4A==
X-Google-Smtp-Source: ABdhPJxF+e96ji6+s/JU3AfUGss3Zf7f2U0jNy8HR7IhhDpf9cNHe8wRq2148ITd4iRoh3nJDaO7hsQbtRbL15dwnV8=
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr7112194lfo.117.1628241808578;
 Fri, 06 Aug 2021 02:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210805170859.2389276-1-surenb@google.com> <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
In-Reply-To: <YQzZSmRqYmxFJ61y@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Aug 2021 02:23:17 -0700
Message-ID: <CALvZod6k3Bm77xt4y=Mvf1Oi8XH25UJwLQaJaFNBFsBAcRuO_Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] mm: introduce process_mrelease system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Aug 5, 2021 at 11:40 PM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
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

mm = p->mm;

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
> --
> Michal Hocko
> SUSE Labs
