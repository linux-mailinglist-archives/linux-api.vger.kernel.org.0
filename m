Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6755DE23F2
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 22:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbfJWUG2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 16:06:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41533 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733136AbfJWUG2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 16:06:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id x4so10864788lfn.8
        for <linux-api@vger.kernel.org>; Wed, 23 Oct 2019 13:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1jaFwe4q6bPt92D9NnO8xEHAIq6OE3EbX3c4MTsblKI=;
        b=QTa7xQ+lSwOcSENU5d3ioAmvuK+eJ7Opp6W4T7fSOlW+uYkIKp6tgjsMoWHUCikYk/
         yDf7vitA4LeAB/cgHOeLpnumUzwQY6Qd69hoIOyjQpodwhPVfL1HRf/N7jWshrALEz/9
         apqy5xe2oOktYRfGN1Xg7420O1pbiQACdeOUC4zcuFrnnVC78Lp1qHM5N/51hjzBFqHy
         UhlslcLQ6f3ToF8S4XpmZuI+I400E5skjS4Pq1Fvtz6IZnMArKNpxP0NRqdSfsFYzjSL
         EU1hvmNWPEGVpg3E/FZbfnKPYF7528CkuzhBlPAvbZMP7zryD/tQKnSN4W6ZZhcSimft
         G8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1jaFwe4q6bPt92D9NnO8xEHAIq6OE3EbX3c4MTsblKI=;
        b=L+Wb5T+me0XrTxdD300jcLaEn9/Kp2Wrvn3K4TJo+htcOQiXLmoHS0q0KWC0RakaVF
         n+el62biwdSUWAkkO7sB+C8VVuOG/yyLhkpQYXXyAU0uovluSsL2QEilAWeyfXv1LWxa
         WpcNssiJu8t9fipq8dNaWk0bA8JKDxwytqZjR3FxAnoMcdMPpM+o961EAUBxI0/CUQGt
         HhFhAhlPYpvvToQEHq2nv9YIz1bZGgxYtDn6vno3ym0KCyyP5gpxmtSNChM+V/P3LPHi
         ccOxa2kaIDBb35PIfFnpJulgPhrJyzyBEGfBM2UWC6F9lHneMMi2AnfYk0WKEoqoS9rP
         gtmA==
X-Gm-Message-State: APjAAAWngole/mQ2+t5Lkg5HV2R4a0KQYjJDKCTuMxyQ7oabNKT5Xhcn
        VbH3xoKo9bfbotLD7gGCHgjQtz40TVYHknRTYyIUTg==
X-Google-Smtp-Source: APXvYqyaKxx+sqmFJkqH8dzqUztnO8ZQzp3x0kUrGCwpTFMt86EoJ5vWDJlpgMuDwNbHDTYYWwemQujGlchEWihWM9U=
X-Received: by 2002:ac2:5325:: with SMTP id f5mr5158156lfh.98.1571861184749;
 Wed, 23 Oct 2019 13:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com> <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com> <20191023190959.GA9902@redhat.com>
In-Reply-To: <20191023190959.GA9902@redhat.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 23 Oct 2019 13:05:47 -0700
Message-ID: <CAKOZuetKkM=PK2QA8LdXwM8cM8qJvFu4u5bjePWai3XRnHe-pA@mail.gmail.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 12:10 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
> On Sat, Oct 12, 2019 at 06:14:23PM -0700, Andy Lutomirski wrote:
> > [adding more people because this is going to be an ABI break, sigh]
>
> That wouldn't break the ABI, no more than when if you boot a kernel
> built with CONFIG_USERFAULTFD=n.

The change Andy is proposing would convert programs that work with
CONFIG_USERFAULTFD=y today into programs that don't work with
CONFIG_USERFAULTFD. Whether that counts as an ABI break is above my
ability to decide, but IMHO, I think it should count. Such a change at
least merits more-than-usual scrutiny. I'd love to get Linus's
opinion.

> All non-cooperative features can be removed any time in a backwards
> compatible way, the only precaution is to mark their feature bits as
> reserved so they can't be reused for something else later.
>
> > least severely restricted.  A .read implementation MUST NOT ACT ON THE
> > CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
> > as stdin to a setuid program.
>
> With UFFD_EVENT_FORK, the newly created uffd that controls the child,
> is not passed to the parent nor to the child. Instead it's passed to
> the CRIU monitor only, which has to be already running as root and is
> fully trusted and acts a hypervisor (despite there is no hypervisor).

The phrase "CRIU monitor" above stands out.  :-) Not every process
that uses userfaultfd will be CRIU-related, and in particular, there's
no requirement right now that limits UFFD_EVENT_FORK to privileged
processes.

The attack Andy is describing involves a random unprivileged process
creating a userfaultfd file object, configuring it to UFFD_EVENT_FORK,
somehow (stdin, SCM_RIGHTS, binder, etc.) passing that FD to a
more-privileged process, and convincing that privileged process to
read(2) that FD and disturb its file descriptor table, which in turn
can cause EoP or all kinds of other havoc. This is a serious bug that
needs some kind of fix.

> On Mon, Oct 14, 2019 at 06:04:22PM +0200, Jann Horn wrote:
> > FWIW, <https://codesearch.debian.net/search?q=UFFD_FEATURE_EVENT_FORK&literal=1>
> > just shows the kernel, kernel selftests, and strace code for decoding
> > syscall arguments. CRIU uses it though (probably for postcopy live
> > migration / lazy migration?), I guess that code isn't in debian for
> > some reason.
>
> https://criu.org/Userfaultfd#Limitations
>
> The CRIU developers did a truly amazing job by making container post
> copy live migration work great for a subset of apps, that alone was an
> amazing achievement. Is that achievement enough to use post copy live
> migration of bare metal containers in production? Unfortunately
> probably not and not just in debian.

Nobody is claiming that there's anything wrong with UFFD. That UFFD is
being used for features that have nothing to do with CRIU or
containerization is a signal that UFFD's creators made a good,
general-purpose tool. (We're considering it for two completely
unrelated purposes in Android in fact.) I don't think we can assume
that the UFFD feature has gone unused on the basis of CRIU's
slower-than-hoped-for adoption. Who's using it for something?
*Probably* nobody, but like I said above, it's worth thinking about
and being careful.

> In my view there's simply no justification not to use virtual machines
> when the alternative requires so much more code to be written and so
> much more complexity to be dealt with.

This is a debate that won't get resolved here. A ton of work has gone
into namespaces, migration, various cgroup things, and so on, and I
don't see that work getting torn out.

> While at it, as far as userfaultfd is concerned I'd rather see people
> spend time to write a malloc library that uses userfaultfd with the
> UFFD_FEATURE_SIGBUS features and it replaces mmap with UFFDIO_ZEROPAGE
> (plus adding the THP accelleration currently missing)

I'd also like to see realloc(3) use mremap(2) in real implementations
and for C++ to grow an allocator interface that can use realloc(3).
But I think that's a separate matter.

> and munmap with
> MADV_DONTNEED to do allocations and freeing of memory with full
> scalability without ever hitting on the map sem for writing.

Some allocators, e.g., jemalloc, already use MADV_DONTNEED.

> fork COWs cannot throttle

Sure they can. Can't we stick processes in a memcg and set a
memory.high threshold beyond which threads in that cgroup will enter
direct reclaim on page allocations? I'd call that throttling.

> and all apps using fork() risk to hit on x2
> memory usage which can become oom-killer material if the memory size
> of the process is huge.

fork is one of the reasons people use overcommit all the time. I'd
like to see a lot less overcommit in the world.

> On my side, instead of trying to fix whatever issue in
> UFFD_EVENT_FORK,

This issue *has* to get fixed one way or another.
