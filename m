Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EDF255E7
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 18:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfEUQoN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 12:44:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbfEUQoM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 21 May 2019 12:44:12 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816672186A
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558457051;
        bh=qQZm8Nb/SzGNYia6YWo9lmooe1BQu0rQ4dsfiiwy4L0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zpIgXxDCkoO2vVHWlTYLw1c5wyXjd3sIECQdfG1SeUtg/azv7nVZmt5nge5TvMFGf
         /HflMm9yUHf3EmK+ynkHa4lj7QPGPUSkpCcfalXiSy9ZfBMMleMmq0OHcZXWrkh7D5
         arfTpmXPHGf9FtxafSrOwRlr9Il24S3QN3O5gHkM=
Received: by mail-wr1-f51.google.com with SMTP id f8so13022946wrt.1
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 09:44:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXDN814lEATN3nq3/sOgTeh7EJHLyGrQOd7+CocER8zlcdXy4kJ
        g3mKYOiPxvFHp3b8QYxNabAmt0zdHnQ7zR7YKDuXCg==
X-Google-Smtp-Source: APXvYqyiAsj6k2lelSuLzA8lDaQTA5IuKvejy22iJ5REZyntNBokRByJ8IeZaodL+yAi+2uA4IBjt6XmnPRl80KDcsU=
X-Received: by 2002:a5d:4a92:: with SMTP id o18mr7798645wrq.80.1558457048163;
 Tue, 21 May 2019 09:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com> <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
In-Reply-To: <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 21 May 2019 09:43:56 -0700
X-Gmail-Original-Message-ID: <CALCETrUMDTGRtLFocw6vnN___7rkb6r82ULehs0=yQO5PZL8MA@mail.gmail.com>
Message-ID: <CALCETrUMDTGRtLFocw6vnN___7rkb6r82ULehs0=yQO5PZL8MA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Tue, May 21, 2019 at 8:52 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>
> On 21.05.2019 17:43, Andy Lutomirski wrote:
> > On Mon, May 20, 2019 at 7:01 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>
> >
> >> [Summary]
> >>
> >> New syscall, which allows to clone a remote process VMA
> >> into local process VM. The remote process's page table
> >> entries related to the VMA are cloned into local process's
> >> page table (in any desired address, which makes this different
> >> from that happens during fork()). Huge pages are handled
> >> appropriately.
> >>
> >> This allows to improve performance in significant way like
> >> it's shows in the example below.
> >>
> >> [Description]
> >>
> >> This patchset adds a new syscall, which makes possible
> >> to clone a VMA from a process to current process.
> >> The syscall supplements the functionality provided
> >> by process_vm_writev() and process_vm_readv() syscalls,
> >> and it may be useful in many situation.
> >>
> >> For example, it allows to make a zero copy of data,
> >> when process_vm_writev() was previously used:
> >>
> >>         struct iovec local_iov, remote_iov;
> >>         void *buf;
> >>
> >>         buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
> >>                    MAP_PRIVATE|MAP_ANONYMOUS, ...);
> >>         recv(sock, buf, n * PAGE_SIZE, 0);
> >>
> >>         local_iov->iov_base = buf;
> >>         local_iov->iov_len = n * PAGE_SIZE;
> >>         remove_iov = ...;
> >>
> >>         process_vm_writev(pid, &local_iov, 1, &remote_iov, 1 0);
> >>         munmap(buf, n * PAGE_SIZE);
> >>
> >>         (Note, that above completely ignores error handling)
> >>
> >> There are several problems with process_vm_writev() in this example:
> >>
> >> 1)it causes pagefault on remote process memory, and it forces
> >>   allocation of a new page (if was not preallocated);
> >
> > I don't see how your new syscall helps.  You're writing to remote
> > memory.  If that memory wasn't allocated, it's going to get allocated
> > regardless of whether you use a write-like interface or an mmap-like
> > interface.
>
> No, the talk is not about just another interface for copying memory.
> The talk is about borrowing of remote task's VMA and corresponding
> page table's content. Syscall allows to copy part of page table
> with preallocated pages from remote to local process. See here:
>
> [task1]                                                        [task2]
>
> buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>            MAP_PRIVATE|MAP_ANONYMOUS, ...);
>
> <task1 populates buf>
>
>                                                                buf = process_vm_mmap(pid_of_task1, addr, n * PAGE_SIZE, ...);
> munmap(buf);
>
>
> process_vm_mmap() copies PTEs related to memory of buf in task1 to task2
> just like in the way we do during fork syscall.

If I understand this correctly, your intended use is to have one task
allocate memory and fill it, have the other task clone the VMA, and
have the first task free the VMA?  If so, that wasn't at all obvious
from your original email.

Why don't you use splice() instead?  splice() the data to the remote
task and have the remove task read() it?  All these VMA games will
result in a lot of flushes, which is bad for performance.  Or,
depending on your exact constraints, you could map a memfd in both
tasks instead, which has the same flushing issues but at least has a
sensible API.

>
> There is no copying of buf memory content, unless COW happens. This is
> the principal difference to process_vm_writev(), which just allocates
> pages in remote VM.
>
> > Keep in mind that, on x86, just the hardware part of a
> > page fault is very slow -- populating the memory with a syscall
> > instead of a fault may well be faster.
>
> It is not as slow, as disk IO has. Just compare, what happens in case of anonymous
> pages related to buf of task1 are swapped:
>
> 1)process_vm_writev() reads them back into memory;
>
> 2)process_vm_mmap() just copies swap PTEs from task1 page table
>   to task2 page table.
>
> Also, for faster page faults one may use huge pages for the mappings.
> But really, it's funny to think about page faults, when there are
> disk IO problems I shown.

What are you doing that is causing *disk* IO in any of this?  I
suspect your real problem is that you are using far too large of a
buffer. See below.

>
> >>
> >> 2)amount of memory for this example is doubled in a moment --
> >>   n pages in current and n pages in remote tasks are occupied
> >>   at the same time;
> >
> > This seems disingenuous.  If you're writing p pages total in chunks of
> > n pages, you will use a total of p pages if you use mmap and p+n if
> > you use write.
>
> I didn't understand this sentence because of many ifs, sorry. Could you
> please explain your thought once again?

You seem to have a function that tries to populate p pages of memory
with data received from a socket.  It looks like you're doing
something like this:

void copy_p_pages(size_t p)
{
  size_t n = some_value(p);
  char *buf = malloc(n * PAGE_SIZE);
  for (int i = 0; i < p; i += n*PAGE_SIZE) {
    read(fd, buf, n*PAGE_SIZE);  /* check return value, etc */
    process_vm_writev(write n*PAGE_SIZE bytes to remote process);
  }
  free(buf);
}

If you have a *constant* n (i.e. some_value(p) is just a number like
16)), then you aren't doubling memory usage.  If you have
some_value(p) return p, then you are indeed doubling memory usage.  So
don't do that!
If buf is getting swapped out, you are very likely doing something
wrong.  If you're using a 100MB buffer or a 10GB, then I'm not
surprised you have problems.  Try something reasonable like 128kB. For
extra fun, you could mlock() that buf, but if you're thrashing on
access to a 128kB working set, you will probably also get your *code*
swapped out, in which case you pretty much lose.


> > For example, if the remote VMA is MAP_ANONYMOUS, do you get
> > a CoW copy of it? I assume you don't since the whole point is to
> > write to remote memory
>
> But, no, there *is* COW semantic. We do not copy memory. We copy
> page table content. This is just the same we have on fork(), when
> children duplicates parent's VMA and related page table subset,
> and parent's PTEs lose _PAGE_RW flag.

Then you need to document this very carefully, because other people
will use your syscall in different ways than you use it.

And, if you are doing CoW like this, then your syscall is basically
only useful for your really weird use case in which you're using it to
import an already-populated VMA.  Maybe this is a reasonable feature
to add to the kernel, but it needs a benchmark against a reasonable
alternative.

>
> There is all copy_page_range() code reused for that. Please, see [3/7]
> for the details.

You can't as users of a syscall to read the nitty gritty mm code to
figure out what the syscall does from a user's perspective.

> > But there are plenty of other questions.
> > What happens if the remote VMA is a gate area or other special mapping
> > (vDSO, vvar area, etc)?  What if the remote memory comes from a driver
> > that wasn't expecting the mapping to get magically copied to a
> > different process?
>
> In case of someone wants to duplicate such the mappings, we may consider
> that, and extend the interface in the future for VMA types, which are
> safe for that.

Do you mean that the code you sent rejects this case?  If so, please
document it.  In any case, I looked at the code, and it seems to be
trying to handle MAP_SHARED and MAP_ANONYMOUS.  I don't see where it
would reject copying a vDSO.
