Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA9256B9
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfEUR30 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 13:29:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47054 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbfEUR30 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 13:29:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id j49so17039250otc.13
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 10:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZkH899cMft3NriqnFbluuuxiqVxw6v9M9zlhn9yN3w=;
        b=P3iQ35EuyfDtHooEdbjohs5k55fLCV1rJaFQ0fc7MAJfML3SX7cJXNSLVdsrupNHmi
         5lkq6BI8Sj/iWUxf9g/aWs/nQzQgkaNQMQ/PBQYsKA1XliMhZLc3GrT/WC07GFE3ZS9Z
         pzccjY3pwoby1nWpgp8ivqkTQK4mgmgBxQ5b+kUK1yp5QzU3M8DvL1bbfv248dQe28bO
         Unzn05XcJFkPBeHrKLhwr2XPtTaK1/KJKVbq9XAQCx9Y8+Fb6xha75yYehZDNMtqurCV
         l+ZHqGAynT8bRC6xUTFbte94zIE3m0YB2BfTulFVg3gHCLsDoMW/bsmMTSwRo9qo7mEx
         Bm1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZkH899cMft3NriqnFbluuuxiqVxw6v9M9zlhn9yN3w=;
        b=HwUAPkPglr9PNWfCOIeAt52Xt3YxZFsVvaDkS1h2n/D4WihHnfsh3AyXgtgPU1N0nN
         NCYHbhaTFkEXl58wml9/r/yK0yURkTiU284lVgtz2aWMPLxMq6v235fzN8k1YPuhcaHY
         VU6qVUPwJZ8yvwmng0G58nHdcs43tubexBdgsDuK5uCBEQDARob51iyP4Fn2ox+5Oteb
         2Zm92sBsNiz6k48WPMvw+YcuKPwxOb6+uiB9nL6zDCwZ3keJcTZL6QH6DRA0BDSzdLEI
         NbF4PbR/ihH3DnCtofYEfnmV6kDAAikxteNCfXOrUubs41KBb1dHXUW0rpaMu5H77i8X
         h4YQ==
X-Gm-Message-State: APjAAAWzdcAfpRggjId++p4CCTbQC6X6c0lsCG34gZ+d2vZqH/UemlGg
        72AKYmQYwLsESxKbnYYnZ34EmxKMozMbT/JGLRy77g==
X-Google-Smtp-Source: APXvYqw7HXUy4K0HaHYv0BxFhx7C+RZx2NQiSRIQ8doSLJTez4tAj8hTmHNjpf4YTBuotTX+eneqN5EINh71j4hhp6M=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr19465404otk.183.1558459764806;
 Tue, 21 May 2019 10:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com>
 <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com> <CAG48ez2BcVCwYGmAo4MwZ2crZ9f7=qKrORcN=fYz=K5xP2xfgQ@mail.gmail.com>
 <069c90d6-924b-fa97-90d7-7d74f8785d9b@virtuozzo.com>
In-Reply-To: <069c90d6-924b-fa97-90d7-7d74f8785d9b@virtuozzo.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 May 2019 19:28:58 +0200
Message-ID: <CAG48ez31Kxukg7y4PU-+3RjsYZxEHfjvs2q0EFqxDM2KDcLUoA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Weiny Ira <ira.weiny@intel.com>,
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
        daniel.m.jordan@oracle.com, Adam Borowski <kilobyte@angband.pl>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 7:04 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 21.05.2019 19:20, Jann Horn wrote:
> > On Tue, May 21, 2019 at 5:52 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >> On 21.05.2019 17:43, Andy Lutomirski wrote:
> >>> On Mon, May 20, 2019 at 7:01 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>>> New syscall, which allows to clone a remote process VMA
> >>>> into local process VM. The remote process's page table
> >>>> entries related to the VMA are cloned into local process's
> >>>> page table (in any desired address, which makes this different
> >>>> from that happens during fork()). Huge pages are handled
> >>>> appropriately.
> > [...]
> >>>> There are several problems with process_vm_writev() in this example:
> >>>>
> >>>> 1)it causes pagefault on remote process memory, and it forces
> >>>>   allocation of a new page (if was not preallocated);
> >>>
> >>> I don't see how your new syscall helps.  You're writing to remote
> >>> memory.  If that memory wasn't allocated, it's going to get allocated
> >>> regardless of whether you use a write-like interface or an mmap-like
> >>> interface.
> >>
> >> No, the talk is not about just another interface for copying memory.
> >> The talk is about borrowing of remote task's VMA and corresponding
> >> page table's content. Syscall allows to copy part of page table
> >> with preallocated pages from remote to local process. See here:
> >>
> >> [task1]                                                        [task2]
> >>
> >> buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
> >>            MAP_PRIVATE|MAP_ANONYMOUS, ...);
> >>
> >> <task1 populates buf>
> >>
> >>                                                                buf = process_vm_mmap(pid_of_task1, addr, n * PAGE_SIZE, ...);
> >> munmap(buf);
> >>
> >>
> >> process_vm_mmap() copies PTEs related to memory of buf in task1 to task2
> >> just like in the way we do during fork syscall.
> >>
> >> There is no copying of buf memory content, unless COW happens. This is
> >> the principal difference to process_vm_writev(), which just allocates
> >> pages in remote VM.
> >>
> >>> Keep in mind that, on x86, just the hardware part of a
> >>> page fault is very slow -- populating the memory with a syscall
> >>> instead of a fault may well be faster.
> >>
> >> It is not as slow, as disk IO has. Just compare, what happens in case of anonymous
> >> pages related to buf of task1 are swapped:
> >>
> >> 1)process_vm_writev() reads them back into memory;
> >>
> >> 2)process_vm_mmap() just copies swap PTEs from task1 page table
> >>   to task2 page table.
> >>
> >> Also, for faster page faults one may use huge pages for the mappings.
> >> But really, it's funny to think about page faults, when there are
> >> disk IO problems I shown.
> > [...]
> >>> That only doubles the amount of memory if you let n
> >>> scale linearly with p, which seems unlikely.
> >>>
> >>>>
> >>>> 3)received data has no a chance to be properly swapped for
> >>>>   a long time.
> >>>
> >>> ...
> >>>
> >>>> a)kernel moves @buf pages into swap right after recv();
> >>>> b)process_vm_writev() reads the data back from swap to pages;
> >>>
> >>> If you're under that much memory pressure and thrashing that badly,
> >>> your performance is going to be awful no matter what you're doing.  If
> >>> you indeed observe this behavior under normal loads, then this seems
> >>> like a VM issue that should be addressed in its own right.
> >>
> >> I don't think so. Imagine: a container migrates from one node to another.
> >> The nodes are the same, say, every of them has 4GB of RAM.
> >>
> >> Before the migration, the container's tasks used 4GB of RAM and 8GB of swap.
> >> After the page server on the second node received the pages, we want these
> >> pages become swapped as soon as possible, and we don't want to read them from
> >> swap to pass a read consumer.
> >
> > But you don't have to copy that memory into the container's tasks all
> > at once, right? Can't you, every time you've received a few dozen
> > kilobytes of data or whatever, shove them into the target task? That
> > way you don't have problems with swap because the time before the data
> > has arrived in its final VMA is tiny.
>
> We try to maintain online migration with as small downtime as possible,
> and the container on source node is completely stopped at the very end.
> Memory of container tasks is copied in background without container
> completely stop, and _PAGE_SOFT_DIRTY is used to track dirty pages.
>
> Container may create any new processes during the migration, and these
> processes may contain any memory mappings.
>
> Imagine the situation. We migrate a big web server with a lot of processes,
> and some of children processes have the same COW mapping as parent has.
> In case of all memory dump is available at the moment of the grand parent
> web server process creation, we populate the mapping in parent, and all
> the children may inherit the mapping in case of they want after fork.
> COW works here. But in case of some processes are created before all memory
> is available on destination node, we can't do such the COW inheritance.
> This will be the reason, the memory consumed by container grows many
> times after the migration. So, the only solution is to create process
> tree after memory is available and all mappings are known.

But if one of the processes modifies the memory after you've started
migrating it to the new machine, that memory can't be CoW anymore
anyway, right? So it should work if you first do a first pass of
copying the memory and creating the process hierarchy, and then copy
more recent changes into the individual processes, breaking the CoW
for those pages, right?

> It's on of the examples. But believe me, there are a lot of another reasons,
> why process tree should be created only after all process tree is freezed,
> and no new tasks on source are possible. PGID and SSID inheritance, for
> example. All of this requires special order of tasks creation. In case of
> you try to restore process tree with correct namespaces and especial in
> case of many user namespaces in a container, you will just see like a hell
> will open before your eyes, and we never can think about this.

Could you elaborate on why that is so hellish?


> So, no, we can't create any task before the whole process tree is knows.
> Believe me, the reason is heavy and serious.
>
> Kirill
>
