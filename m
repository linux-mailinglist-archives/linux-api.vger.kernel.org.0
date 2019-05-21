Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C992556B
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEUQUo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 12:20:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35307 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfEUQUn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 12:20:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id n14so16903056otk.2
        for <linux-api@vger.kernel.org>; Tue, 21 May 2019 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BW3bQNoDviAamFC+RcRIIS02hInnMbbXec0nwAshfyk=;
        b=BIsbOTpu8o1r4oR1eExX7HB2wuf7SF+K+1MHv2XnAvbhBJK94bjaX5xD3Wz00KmoNf
         O34+uTz4vJ6ALRoh77myvTmXrWYWdqo+HxwNwrLbQCMBmPdAin6qfsGIqtkCARvPA2N6
         YOltAYKFOJqAnUMjA+r4baJ5pwlRpjQxbG27SvDbEShhPUNuPwMTC6ttd6WH1js0k1VQ
         sWsDtK5uUOPUUxD18R5Ixsq3x+A5W3nSQ/xZrxdVfvLlKfdbl6oBBgOrdBipX5gL0o7T
         +QQjXpZXtRhp7swD84820UmczIkTD/SPRl8g02G3iC6olxH7wcg/yWVEkGkWfYpnUig5
         K7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BW3bQNoDviAamFC+RcRIIS02hInnMbbXec0nwAshfyk=;
        b=k4DtkBFnfyJKMVn5GU1e2BI8AdSwuHcmDVwuuUVfLemBbWPaBM61/Ol8zdEIhoGwNc
         5vAfRaCB8x/2QKhI+d/by21PzV/RXQ8TDtTKxAj/1imlg4ZqYY/UJGY/9PwIur/8BwIg
         MRkPwr4HTMYnwThnX7f9DThAQv1c52ctg10VTaTxsghEiXnMy/tUDxJV2H34fdbZdtkp
         k07pkQRvcDSt9M417Vc8F1rKUTSu2VGzYKUrj2IDgDOydR6P/uQccxF/6DdvNB3opuYb
         jbY3FzXF8SmFTDqZBb4GkuXAX7sGrmas56cbl4DDqrV7wKeOUSDTFYvfoP7dH7/P1BZk
         wG9g==
X-Gm-Message-State: APjAAAVCh39LY3NyLN/oDHkuxCGxnzAO8dRTW2gbYXE7dGOQCDh9cfM4
        eh+u6NKFBK9M5oGtAtgfxXz/z2Gbj1+/kRkU55pxVQ==
X-Google-Smtp-Source: APXvYqxHnjO0O+EyjFF0Z4zORdD2l9Rk3gkQ77tzlptApyPkz1WpeDUvMdq02nYzFbXQN+tda0ZsRLQKk/6mLvObkI8=
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr38337otp.110.1558455642667;
 Tue, 21 May 2019 09:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com> <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
In-Reply-To: <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 May 2019 18:20:16 +0200
Message-ID: <CAG48ez2BcVCwYGmAo4MwZ2crZ9f7=qKrORcN=fYz=K5xP2xfgQ@mail.gmail.com>
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

On Tue, May 21, 2019 at 5:52 PM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> On 21.05.2019 17:43, Andy Lutomirski wrote:
> > On Mon, May 20, 2019 at 7:01 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >> New syscall, which allows to clone a remote process VMA
> >> into local process VM. The remote process's page table
> >> entries related to the VMA are cloned into local process's
> >> page table (in any desired address, which makes this different
> >> from that happens during fork()). Huge pages are handled
> >> appropriately.
[...]
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
[...]
> > That only doubles the amount of memory if you let n
> > scale linearly with p, which seems unlikely.
> >
> >>
> >> 3)received data has no a chance to be properly swapped for
> >>   a long time.
> >
> > ...
> >
> >> a)kernel moves @buf pages into swap right after recv();
> >> b)process_vm_writev() reads the data back from swap to pages;
> >
> > If you're under that much memory pressure and thrashing that badly,
> > your performance is going to be awful no matter what you're doing.  If
> > you indeed observe this behavior under normal loads, then this seems
> > like a VM issue that should be addressed in its own right.
>
> I don't think so. Imagine: a container migrates from one node to another.
> The nodes are the same, say, every of them has 4GB of RAM.
>
> Before the migration, the container's tasks used 4GB of RAM and 8GB of swap.
> After the page server on the second node received the pages, we want these
> pages become swapped as soon as possible, and we don't want to read them from
> swap to pass a read consumer.

But you don't have to copy that memory into the container's tasks all
at once, right? Can't you, every time you've received a few dozen
kilobytes of data or whatever, shove them into the target task? That
way you don't have problems with swap because the time before the data
has arrived in its final VMA is tiny.
