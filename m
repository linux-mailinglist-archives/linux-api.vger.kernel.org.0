Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8863E0AAA
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 00:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhHDXAE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 19:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhHDXAD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 19:00:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675CC061798
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 15:59:49 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b6so7197283lff.10
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 15:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKBCddFUD4ZVg3evBH79AytFMC59ICl5HYXSEir7plU=;
        b=ebulXj+Z6/Ub9Krg3pAiSomWCFfnFE/iXQaNP7ubYVZykn93fMeXr1/xIqFRinj3Ew
         GHG0ZtsMBZ3vsbi1bV89yG7QxskFZE9zwNBwqkrEAOoJJUVnzDtdJsNT2+45YXIs3Zix
         1CTFZIkW9Qr7PMfu0rJP0gTAu9mb4U52cMdey1lgVR2VdwunvqUNyP3NVzTRvl/pfFaJ
         P8J6dtw+mEIbLeQ6+dklxX/a5k1orE/BdNeGeIfsvf/RA7EXcWQgWbvdJWHCRgPnQPYJ
         8AF8Gtsv0G12SRSlrSWkKWhPVVMYwIUtwxD4yfRVyZgjFmcAU9cXYjfvghjjixLO60CZ
         Rmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKBCddFUD4ZVg3evBH79AytFMC59ICl5HYXSEir7plU=;
        b=IUeJOhJ3YXBxopIp99b//JNSuCBb5jbpZ/9JFefM3+GQg0zDRlGHiWKtZqhaJnO7GR
         RUObba36HKf8l+XqeW40O9JzqDxFAWpN+EN8lvy673RGfYvjYRB5TXdNmhW/aIevfRUz
         kRNicNICRbuc7DnC6aW9CdyHdOVYtpXO9bP5lz8LTovL4EMzoKZzCnhP/G2aak9zDx+K
         KgWiDBqHauoOX1mFK1aEjbEF8zHAkJHJnrkfniaArwBxngpkrYMq64DsoJS9Akq+fDjZ
         RLC8JyRzCLMBosW2FZG2Tr7vvNa1GI4OBZeEFxlNJYHBP0aqJdyTNfiVJJ7QYtDrbMPk
         oWnw==
X-Gm-Message-State: AOAM5323UHgxnlByycZn7nBlNijGjdD5Cfx5U+9ZZyHAD7Bd02+fu6FH
        5eIaX7XJ7MgeZxCWa45puLR0iMNm1LVjzrwck3uq6g==
X-Google-Smtp-Source: ABdhPJxTwTEidem65WeqdTi/dr8QkeyuaN9y+ifYH6uanXfbyxom6MSKvxOnh5EKy7wfDzYDsvtUpyai4/S+yITO06k=
X-Received: by 2002:a05:6512:c23:: with SMTP id z35mr1101321lfu.299.1628117987480;
 Wed, 04 Aug 2021 15:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210804185004.1304692-1-surenb@google.com>
In-Reply-To: <20210804185004.1304692-1-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 4 Aug 2021 15:59:36 -0700
Message-ID: <CALvZod4gnVq+7=+i2=Q0aLN+n=aKEWdM2qyNsCAKLxR=s3uvqw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
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

On Wed, Aug 4, 2021 at 11:50 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> In modern systems it's not unusual to have a system component monitoring
> memory conditions of the system and tasked with keeping system memory
> pressure under control. One way to accomplish that is to kill
> non-essential processes to free up memory for more important ones.
> Examples of this are Facebook's OOM killer daemon called oomd and
> Android's low memory killer daemon called lmkd.
> For such system component it's important to be able to free memory
> quickly and efficiently. Unfortunately the time process takes to free
> up its memory after receiving a SIGKILL might vary based on the state
> of the process (uninterruptible sleep), size and OPP level of the core
> the process is running. A mechanism to free resources of the target
> process in a more predictable way would improve system's ability to
> control its memory pressure.
> Introduce process_mrelease system call that releases memory of a dying
> process from the context of the caller. This way the memory is freed in
> a more controllable way with CPU affinity and priority of the caller.
> The workload of freeing the memory will also be charged to the caller.
> The operation is allowed only on a dying process.
>
> After previous discussions [1, 2, 3] the decision was made [4] to introduce
> a dedicated system call to cover this use case.
>
> The API is as follows,
>
>           int process_mrelease(int pidfd, unsigned int flags);
>
>         DESCRIPTION
>           The process_mrelease() system call is used to free the memory of
>           an exiting process.
>
>           The pidfd selects the process referred to by the PID file
>           descriptor.
>           (See pidofd_open(2) for further information)
>
>           The flags argument is reserved for future use; currently, this
>           argument must be specified as 0.
>
>         RETURN VALUE
>           On success, process_mrelease() returns 0. On error, -1 is
>           returned and errno is set to indicate the error.
>
>         ERRORS
>           EBADF  pidfd is not a valid PID file descriptor.
>
>           EAGAIN Failed to release part of the address space.
>
>           EINTR  The call was interrupted by a signal; see signal(7).
>
>           EINVAL flags is not 0.
>
>           EINVAL The memory of the task cannot be released because the
>                  process is not exiting, the address space is shared
>                  with another live process or there is a core dump in
>                  progress.
>
>           ENOSYS This system call is not supported, for example, without
>                  MMU support built into Linux.
>
>           ESRCH  The target process does not exist (i.e., it has terminated
>                  and been waited on).
>
> [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
> [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

Next I wanna see cgroup.procs giving me pidfds.
