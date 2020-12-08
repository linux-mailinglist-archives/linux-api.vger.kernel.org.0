Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB962D374C
	for <lists+linux-api@lfdr.de>; Wed,  9 Dec 2020 01:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgLIAAb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 8 Dec 2020 19:00:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730625AbgLIAAb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 Dec 2020 19:00:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8B6C0613D6
        for <linux-api@vger.kernel.org>; Tue,  8 Dec 2020 15:59:50 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id k14so99205wrn.1
        for <linux-api@vger.kernel.org>; Tue, 08 Dec 2020 15:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlUeL94EMQ2mw/JUtxwCrK3jcneUAYJBBgQnd4y+zNg=;
        b=Edq1CVvPQKilfg2eDpW2y/52GBtWVJoIisqFyyH4DiApGXBvGccrYZnb4ppeJREqR7
         3PUoGbsEeb9wev7096enOgV+BT6P9oNUGTZUxnQdtg7eWts6tYgZ6nZ+e9ur/fIcajhX
         5DqIYLAYauN54V4uaCEp5/EK0rMZB3AawHE/aQKf/+m5xxd3/3fiJECHLKADzmRb6/nz
         ugiCHzkpN7TbNyk6Cj+kZMQCQtZ6OAm8GCmKxlMA5ZuSiF3UDJbWKyeMwVhQp0Vr9dR6
         ESYN4wHypyOw/kE4fXkrUhGE+dPCIwqLdKMnfujJLrDCjo2bBm7pAg7RqqOAIn8xUQVM
         8isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlUeL94EMQ2mw/JUtxwCrK3jcneUAYJBBgQnd4y+zNg=;
        b=aC6c4g18zbJQjdnTyikLR2Hp2WbuZc/suyv3RApe63hKROc7Em0L6MjV8w+bz8PZMc
         wJ0mDhkJpcyVeNHMtmz3jTYlBnyikTO9d9SovfFXm7NW7jskw7/Doj/e9RE1n5f5Jx5o
         OrTbVHXF3sCmpgqt/HpPoWJrwRAzJD2qjAcZ2VEznwfGwrueTFCDbv/CWFxbuHbYBEGi
         q4deQgRkwlSKaTFXFDnTUvIW3gewCGUvFm7rIpuf1zP62vIKzWbu4QV/9lkmHUYmyfiq
         EdS1/Urm3PQnr0/bUXY2g7sACTXClMYSdPhdtHTBMFTGsG484GxopUoj2GoQCjKWAxvw
         mwAg==
X-Gm-Message-State: AOAM533pxYKL7cBMDu/D7wpCeHq6MH2rvfCuyjLM5czS8TTDwA1qUsQ7
        8yJfyFlQ3TXIxZARYVgqW46z+vi6L7CYQFUyJU+7ew==
X-Google-Smtp-Source: ABdhPJx/e96M5QxZfOV2yS34D1ceLVp3WIR5bIkqmCEwBy7gwJnwcD76VCWHfNTmg9pVDdfSVhJMj0viccbvch35sog=
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr575805wrv.92.1607471989205;
 Tue, 08 Dec 2020 15:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-3-surenb@google.com>
 <CAG48ez1M5tT=4T2RREhs1U3yMJH2N7HPWySBnMJyMSg0WtdD2A@mail.gmail.com>
In-Reply-To: <CAG48ez1M5tT=4T2RREhs1U3yMJH2N7HPWySBnMJyMSg0WtdD2A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 8 Dec 2020 15:59:38 -0800
Message-ID: <CAJuCfpFJFZyOANvmOn0sw-sDDrk4WFgtLcRtQBKOSELohWaDuA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/madvise: add process_madvise MADV_DONTNEER support
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 8, 2020 at 3:40 PM Jann Horn <jannh@google.com> wrote:
>
> On Tue, Nov 24, 2020 at 6:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > In modern systems it's not unusual to have a system component monitoring
> > memory conditions of the system and tasked with keeping system memory
> > pressure under control. One way to accomplish that is to kill
> > non-essential processes to free up memory for more important ones.
> > Examples of this are Facebook's OOM killer daemon called oomd and
> > Android's low memory killer daemon called lmkd.
> > For such system component it's important to be able to free memory
> > quickly and efficiently. Unfortunately the time process takes to free
> > up its memory after receiving a SIGKILL might vary based on the state
> > of the process (uninterruptible sleep), size and OPP level of the core
> > the process is running.
> > In such situation it is desirable to be able to free up the memory of the
> > process being killed in a more controlled way.
> > Enable MADV_DONTNEED to be used with process_madvise when applied to a
> > dying process to reclaim its memory. This would allow userspace system
> > components like oomd and lmkd to free memory of the target process in
> > a more predictable way.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> [...]
> > @@ -1239,6 +1256,23 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >                 goto release_task;
> >         }
> >
> > +       if (madvise_destructive(behavior)) {
> > +               /* Allow destructive madvise only on a dying processes */
> > +               if (!signal_group_exit(task->signal)) {
> > +                       ret = -EINVAL;
> > +                       goto release_mm;
> > +               }
>
> Technically Linux allows processes to share mm_struct without being in
> the same thread group, so I'm not sure whether this check is good
> enough? AFAICS the normal OOM killer deals with this case by letting
> __oom_kill_process() always kill all tasks that share the mm_struct.

Thanks for the comment Jann.
You are right. I think replacing !signal_group_exit(task->signal) with
task_will_free_mem(task) would address both your and Oleg's comments.
IIUC, task_will_free_mem() calls __task_will_free_mem() on the task
itself and on all processes sharing the mm_struct ensuring that they
are all dying.
