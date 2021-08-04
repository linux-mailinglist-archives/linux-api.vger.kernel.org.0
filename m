Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A93E0A9B
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 00:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHDWz1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 18:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhHDWz0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 18:55:26 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF69C061798
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 15:55:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a201so6085084ybg.12
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tVCIYEWsJT9t+6yApOAgsgx/mmNe4rHwOe1CneWcSqA=;
        b=je/d+I73tXt6x535d/iQd245j0n/rAzC5NzaQ5B7vKBA8MDZqAOvvryDLgWWXSKO1N
         3sJrAvjB4jPo4sQoDUQu5DL4RbM4f38nTlNxpFzh1aPf8nHZA3pgOcrpf6aTxdaHJ/km
         eKuhiXAxYBfkVGEA/iO19lJsuN0IRGjfzjUaZdg6ncAnBaGX4uj3Ygxnh9sAFTASeLnF
         daGtoy+T41ZJp4qyKZvLwyMsXBuJUfhpIjne99lyiHHgq8EUwVwltQlhKDfJL2lzMVES
         QpbThhNEbqoHA4Sb6DriC2U2F8jR/VbBaZsl11galxs78n165b2UQnXH7znlNqPLNkVc
         4hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tVCIYEWsJT9t+6yApOAgsgx/mmNe4rHwOe1CneWcSqA=;
        b=sAeOSsJb3gVzZV8eOvLOjNaDU5gEeRUN3uu2lqsA8tE2ToD3EyognTjEer2G0LWhkF
         NDGlz7NTp4XlJ7EkrSNDqFS6wD3Oms5H6ZWlM1HtqEDkIsLlx1F9j9krtH3M2O4Tg100
         SSJqaxcAl0sC/22+uD0o06Ao4f3+8Gb1tZkESncbQXiJlSw5PMKMG7/wUQJXO62DE14y
         35gTAz6tk16ynJ0SCiPZo8JAAUnokqmJ8C7PSyhoOVBSVRkg2hAHtior5EK+9eEpkhgo
         3npXS1JUUISa8c66bxqmJOmuzLq4YORtzfmm5cNOGCi9trrmDMZWVWQpOcTL1bQhqOZo
         MxMg==
X-Gm-Message-State: AOAM5322CAg+4qSpAsDhxErWkLChlZ8b2qsWfj1q2emrrMs7WJyjDwoA
        ooEbpVjK2ju9YRZ8wLcaBty10u59f8HYGK0wOFqhKA==
X-Google-Smtp-Source: ABdhPJw8sr/btOOscCL9FUHmBB6W9co69B++CSACaOYEe1NiJsxUUMbxlnN7j7zXEGL2F3RA+ucThpUrZ/F9tfFaB3I=
X-Received: by 2002:a25:14d6:: with SMTP id 205mr2474720ybu.250.1628117711518;
 Wed, 04 Aug 2021 15:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210804185004.1304692-1-surenb@google.com> <20210804155024.e4e42e1b7b087937271fa7ce@linux-foundation.org>
In-Reply-To: <20210804155024.e4e42e1b7b087937271fa7ce@linux-foundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 4 Aug 2021 15:55:00 -0700
Message-ID: <CAJuCfpHjvaOpUbg-UaZowgs0P-FN3P79VXnC-HuriK8SUqCX0g@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Michal Hocko <mhocko@suse.com>,
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

On Wed, Aug 4, 2021 at 3:50 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  4 Aug 2021 11:50:03 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
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
> > the process is running. A mechanism to free resources of the target
> > process in a more predictable way would improve system's ability to
> > control its memory pressure.
> > Introduce process_mrelease system call that releases memory of a dying
> > process from the context of the caller. This way the memory is freed in
> > a more controllable way with CPU affinity and priority of the caller.
> > The workload of freeing the memory will also be charged to the caller.
> > The operation is allowed only on a dying process.
> >
> > After previous discussions [1, 2, 3] the decision was made [4] to introduce
> > a dedicated system call to cover this use case.
> >
> > The API is as follows,
> >
> >           int process_mrelease(int pidfd, unsigned int flags);
> >
> >         DESCRIPTION
> >           The process_mrelease() system call is used to free the memory of
> >           an exiting process.
> >
> >           The pidfd selects the process referred to by the PID file
> >           descriptor.
> >           (See pidofd_open(2) for further information)
>
> I did s/pidofd_open/pidfd_open/

Thanks!

>
> >
> >           The flags argument is reserved for future use; currently, this
> >           argument must be specified as 0.
> >
> >         RETURN VALUE
> >           On success, process_mrelease() returns 0. On error, -1 is
> >           returned and errno is set to indicate the error.
> >
> >         ERRORS
> >           EBADF  pidfd is not a valid PID file descriptor.
> >
> >           EAGAIN Failed to release part of the address space.
> >
> >           EINTR  The call was interrupted by a signal; see signal(7).
> >
> >           EINVAL flags is not 0.
> >
> >           EINVAL The memory of the task cannot be released because the
> >                  process is not exiting, the address space is shared
> >                  with another live process or there is a core dump in
> >                  progress.
> >
> >           ENOSYS This system call is not supported, for example, without
> >                  MMU support built into Linux.
> >
> >           ESRCH  The target process does not exist (i.e., it has terminated
> >                  and been waited on).
> >
> > ...
> >
> >  mm/oom_kill.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
>
> The code is nice and simple.
>
> Can we get a test suite into tools/testing/selftests?

Let me take a stab at it.
Thanks!
