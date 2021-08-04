Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB633E0A8C
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 00:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhHDWum (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 18:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhHDWum (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Aug 2021 18:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D76F601FE;
        Wed,  4 Aug 2021 22:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1628117428;
        bh=au1jMsHrlZQGAFtzrot7CCPS+RgEAXFEcGYA0uxvwUA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O4pj+MUbZwCirnYWew8Dlfb93x0HyiTgZGzxQRxfDe2cCKD9mmUaO/UBk3HS5o85X
         +iXxVrhGnbwzdi1E8oJHSppWyTUsv/w/Crsj4UEOIdnq3i7j+tsAGvPAtI8QFWeoMG
         MavZmyqLfP1+ptt0e4qk0PPEXD3nST0irkff/xDA=
Date:   Wed, 4 Aug 2021 15:50:24 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mhocko@kernel.org, mhocko@suse.com, rientjes@google.com,
        willy@infradead.org, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, christian@brauner.io,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, luto@kernel.org,
        christian.brauner@ubuntu.com, fweimer@redhat.com, jengelh@inai.de,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v6 1/2] mm: introduce process_mrelease system call
Message-Id: <20210804155024.e4e42e1b7b087937271fa7ce@linux-foundation.org>
In-Reply-To: <20210804185004.1304692-1-surenb@google.com>
References: <20210804185004.1304692-1-surenb@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed,  4 Aug 2021 11:50:03 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

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

I did s/pidofd_open/pidfd_open/

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
> ...
>
>  mm/oom_kill.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)

The code is nice and simple.

Can we get a test suite into tools/testing/selftests?
