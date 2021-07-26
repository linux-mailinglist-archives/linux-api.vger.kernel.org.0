Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5973D5AA0
	for <lists+linux-api@lfdr.de>; Mon, 26 Jul 2021 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhGZNDf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Jul 2021 09:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhGZNDf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Jul 2021 09:03:35 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A33C061757
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 06:44:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id r23so8211422lji.3
        for <linux-api@vger.kernel.org>; Mon, 26 Jul 2021 06:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TLycPxviRjQS2vlWYgAqhStL9LKdE5LJjJtFS7Jae4Y=;
        b=kM3ffQibqdlLWCaxU3irV+dXOOAiJRgpArqXCrZqUlURkhV3Uj7T8ux2Ir7Z9cReit
         sl0WxaiR7gwq+eJ/XKMu6TRVKV1my3wGtPAGwJ2G3Qm+9koRzZtV+JdcqyUzr2EhIcfX
         ufHWsMiRjGklH8iHGZD4IGM6CFSx+vFneLC8532Df/g/4zOZ5s5OuUE0gHkaWpz/aIH0
         d5KATqF9cmZJGa/LlkElPYuMQubU9BvAUrDd7RNkVvdTbwypVi4BJheSfkGPEY7EHTTD
         iqyA7t9AjMkRHoUSEBnmRaMdq0wJ7r9mri8PykgK+wl00Zw8d52GCbEaSjmhABtQmzWK
         jg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TLycPxviRjQS2vlWYgAqhStL9LKdE5LJjJtFS7Jae4Y=;
        b=YvBFSuPcdlzz8CJQ6C4e9hA3uOnvvSjXg8yzkF7rzCrQLPGqqLU61rqdHqaiXzYwYD
         0UO7VjrXYvDpo+mRpkEZK8S6GfrXWBy4IKQW0s9cbQ2mo4j9rveuKkGckp/1Frgk/3os
         tkdZt/cpPUuYI8gC0hIVeCl2JB8MWChz4sqWFfy/lOZCGDqfn4JGT3XMV7KqQ/Pn5Njh
         5k0hRc92DJvHJUrKGpHLhnxcvJSp3nGgpictAjDYlmIuGC7z9cl0V4bwexbawXcxV9HG
         04xMuoaAKLn/eRGVghLMaQLroAr+tdDow5LonZOVmaEZVI3y0sulRR2hBKgHQGPNeb9R
         YFyg==
X-Gm-Message-State: AOAM533xojThGwd1cZCcQl6xkESOcqhuMnJk8/gUYfpuT/iekK1D+2Fl
        5zYV2KIIQ8NRVL3aBvFKCroymCMrNOM8SjrhMzb6Dg==
X-Google-Smtp-Source: ABdhPJwAkFnDG7NuQtWLLexIiDYnWTWvIxBeII4m/0QIeM7dBhx7GXfH+UoikLc0g6EgogQ1N+7fjJ6zmkJsQ7tEbhE=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr12408419ljj.279.1627307041973;
 Mon, 26 Jul 2021 06:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz> <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
 <CAJuCfpGmpwTv92joNuVPaEJg1PigtGQn2daywHaqF4TXjuiCWQ@mail.gmail.com>
 <CALvZod7Vb2MKgCcSYtsMd8F4sFb2K7jQk3AGSECYfKvd3MNqzQ@mail.gmail.com> <YP5jyLeYsN3JtdX8@dhcp22.suse.cz>
In-Reply-To: <YP5jyLeYsN3JtdX8@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Jul 2021 06:43:50 -0700
Message-ID: <CALvZod4M6mF3VvAdade3n5fE1E0LQp+CeJHWLc+pHmZqqAhepg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
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

On Mon, Jul 26, 2021 at 12:27 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
>
> Is process_mrelease on all of them really necessary? I thought that the
> primary reason for the call is to guarantee a forward progress in cases
> where the userspace OOM victim cannot die on SIGKILL. That should be
> more an exception than a normal case, no?
>

I am thinking of using this API in this way: On user-defined OOM
condition, kill a job/cgroup and unconditionally reap all of its
processes. Keep monitoring the situation and if it does not improve go
for another kill and reap.

I can add additional logic in between kill and reap to see if reap is
necessary but unconditionally reaping is more simple.

>
> > An alternative would be to have a cgroup specific interface for
> > reaping similar to cgroup.kill.
>
> Could you elaborate?
>

I mentioned this in [1] where I was thinking if it makes sense to
overload cgroup.kill to also add the SIGKILLed processes in
oom_reaper_list. The downside would be that there will be one thread
doing the reaping and the syscall approach allows userspace to reap in
multiple threads. I think for now, I would go with whatever Suren is
proposing and we can always add more stuff if need arises.

[1] https://lore.kernel.org/containers/CALvZod4jsb6bFzTOS4ZRAJGAzBru0oWanAhezToprjACfGm+ew@mail.gmail.com/
