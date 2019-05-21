Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC2D25269
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEUOoO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 10:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbfEUOoK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 21 May 2019 10:44:10 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 747662184C
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 14:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558449849;
        bh=UXFXrEA/XzWJSiUo9Qp4UMS3ywgS7m/ucbmbFiKpKdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ggdw0BLYs+MUWCzaemnKs7kSn7TwV/Z1WyTZ21WH/Jz1MnoGDQXLI9sEuswTUvuTS
         8pQ9c8rrHOkToDiNw4MOcaMc2FDInI4T5EHyUjCtb3CIFqXtP49Sw4Q953xH/Y7U+O
         DkHtReRVA2CdJGsCfXC19OMfPrqWV+XYmG7ky4Kc=
Received: by mail-wm1-f42.google.com with SMTP id 7so3191974wmo.2
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 07:44:09 -0700 (PDT)
X-Gm-Message-State: APjAAAXuwQJZAdA38SxRsgrKpi4x9f5+5/dnXEl6z6QslWOsiuN6wtw0
        3HtOBqAGtukWuQjBXi9EvZNVcP2nSgJnEriw+I5XsA==
X-Google-Smtp-Source: APXvYqw05JswjNvqBUGl7gXKRzK+1KXPBZ3mlltGiRg3F6iRofmtTtwuivIZNqWiZcVx294tPDvD+1kLa6+lbLtQJT0=
X-Received: by 2002:a1c:e906:: with SMTP id q6mr3923719wmc.47.1558449846202;
 Tue, 21 May 2019 07:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
In-Reply-To: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 21 May 2019 07:43:54 -0700
X-Gmail-Original-Message-ID: <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com>
Message-ID: <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        alexander.h.duyck@linux.intel.com, Weiny Ira <ira.weiny@intel.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        arunks@codeaurora.org, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Rik van Riel <riel@surriel.com>,
        Kees Cook <keescook@chromium.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        daniel.m.jordan@oracle.com, Jann Horn <jannh@google.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 7:01 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>

> [Summary]
>
> New syscall, which allows to clone a remote process VMA
> into local process VM. The remote process's page table
> entries related to the VMA are cloned into local process's
> page table (in any desired address, which makes this different
> from that happens during fork()). Huge pages are handled
> appropriately.
>
> This allows to improve performance in significant way like
> it's shows in the example below.
>
> [Description]
>
> This patchset adds a new syscall, which makes possible
> to clone a VMA from a process to current process.
> The syscall supplements the functionality provided
> by process_vm_writev() and process_vm_readv() syscalls,
> and it may be useful in many situation.
>
> For example, it allows to make a zero copy of data,
> when process_vm_writev() was previously used:
>
>         struct iovec local_iov, remote_iov;
>         void *buf;
>
>         buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>                    MAP_PRIVATE|MAP_ANONYMOUS, ...);
>         recv(sock, buf, n * PAGE_SIZE, 0);
>
>         local_iov->iov_base = buf;
>         local_iov->iov_len = n * PAGE_SIZE;
>         remove_iov = ...;
>
>         process_vm_writev(pid, &local_iov, 1, &remote_iov, 1 0);
>         munmap(buf, n * PAGE_SIZE);
>
>         (Note, that above completely ignores error handling)
>
> There are several problems with process_vm_writev() in this example:
>
> 1)it causes pagefault on remote process memory, and it forces
>   allocation of a new page (if was not preallocated);

I don't see how your new syscall helps.  You're writing to remote
memory.  If that memory wasn't allocated, it's going to get allocated
regardless of whether you use a write-like interface or an mmap-like
interface.  Keep in mind that, on x86, just the hardware part of a
page fault is very slow -- populating the memory with a syscall
instead of a fault may well be faster.

>
> 2)amount of memory for this example is doubled in a moment --
>   n pages in current and n pages in remote tasks are occupied
>   at the same time;

This seems disingenuous.  If you're writing p pages total in chunks of
n pages, you will use a total of p pages if you use mmap and p+n if
you use write.  That only doubles the amount of memory if you let n
scale linearly with p, which seems unlikely.

>
> 3)received data has no a chance to be properly swapped for
>   a long time.

...

> a)kernel moves @buf pages into swap right after recv();
> b)process_vm_writev() reads the data back from swap to pages;

If you're under that much memory pressure and thrashing that badly,
your performance is going to be awful no matter what you're doing.  If
you indeed observe this behavior under normal loads, then this seems
like a VM issue that should be addressed in its own right.

>         buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>                    MAP_PRIVATE|MAP_ANONYMOUS, ...);
>         recv(sock, buf, n * PAGE_SIZE, 0);
>
> [Task 2]
>         buf2 = process_vm_mmap(pid_of_task1, buf, n * PAGE_SIZE, NULL, 0);
>
> This creates a copy of VMA related to buf from task1 in task2's VM.
> Task1's page table entries are copied into corresponding page table
> entries of VM of task2.

You need to fully explain a whole bunch of details that you're
ignored.  For example, if the remote VMA is MAP_ANONYMOUS, do you get
a CoW copy of it?  I assume you don't since the whole point is to
write to remote memory, but it's at the very least quite unusual in
Linux to have two different anonymous VMAs such that writing one of
them changes the other one.  But there are plenty of other questions.
What happens if the remote VMA is a gate area or other special mapping
(vDSO, vvar area, etc)?  What if the remote memory comes from a driver
that wasn't expecting the mapping to get magically copied to a
different process?

This new API seems quite dangerous and complex to me, and I don't
think the value has been adequately demonstrated.
