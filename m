Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A56225482
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfEUPww (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 11:52:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:37856 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbfEUPww (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 21 May 2019 11:52:52 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hT746-000792-M6; Tue, 21 May 2019 18:52:34 +0300
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
To:     Andy Lutomirski <luto@kernel.org>
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
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
 <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <9638a51c-4295-924f-1852-1783c7f3e82d@virtuozzo.com>
Date:   Tue, 21 May 2019 18:52:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrU221N6uPmdaj4bRDDsf+Oc5tEfPERuyV24wsYKHn+spA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 21.05.2019 17:43, Andy Lutomirski wrote:
> On Mon, May 20, 2019 at 7:01 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
> 
>> [Summary]
>>
>> New syscall, which allows to clone a remote process VMA
>> into local process VM. The remote process's page table
>> entries related to the VMA are cloned into local process's
>> page table (in any desired address, which makes this different
>> from that happens during fork()). Huge pages are handled
>> appropriately.
>>
>> This allows to improve performance in significant way like
>> it's shows in the example below.
>>
>> [Description]
>>
>> This patchset adds a new syscall, which makes possible
>> to clone a VMA from a process to current process.
>> The syscall supplements the functionality provided
>> by process_vm_writev() and process_vm_readv() syscalls,
>> and it may be useful in many situation.
>>
>> For example, it allows to make a zero copy of data,
>> when process_vm_writev() was previously used:
>>
>>         struct iovec local_iov, remote_iov;
>>         void *buf;
>>
>>         buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>>                    MAP_PRIVATE|MAP_ANONYMOUS, ...);
>>         recv(sock, buf, n * PAGE_SIZE, 0);
>>
>>         local_iov->iov_base = buf;
>>         local_iov->iov_len = n * PAGE_SIZE;
>>         remove_iov = ...;
>>
>>         process_vm_writev(pid, &local_iov, 1, &remote_iov, 1 0);
>>         munmap(buf, n * PAGE_SIZE);
>>
>>         (Note, that above completely ignores error handling)
>>
>> There are several problems with process_vm_writev() in this example:
>>
>> 1)it causes pagefault on remote process memory, and it forces
>>   allocation of a new page (if was not preallocated);
> 
> I don't see how your new syscall helps.  You're writing to remote
> memory.  If that memory wasn't allocated, it's going to get allocated
> regardless of whether you use a write-like interface or an mmap-like
> interface.

No, the talk is not about just another interface for copying memory.
The talk is about borrowing of remote task's VMA and corresponding
page table's content. Syscall allows to copy part of page table
with preallocated pages from remote to local process. See here:

[task1]                                                        [task2]

buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
           MAP_PRIVATE|MAP_ANONYMOUS, ...);

<task1 populates buf>

                                                               buf = process_vm_mmap(pid_of_task1, addr, n * PAGE_SIZE, ...);
munmap(buf);


process_vm_mmap() copies PTEs related to memory of buf in task1 to task2
just like in the way we do during fork syscall.

There is no copying of buf memory content, unless COW happens. This is
the principal difference to process_vm_writev(), which just allocates
pages in remote VM.

> Keep in mind that, on x86, just the hardware part of a
> page fault is very slow -- populating the memory with a syscall
> instead of a fault may well be faster.

It is not as slow, as disk IO has. Just compare, what happens in case of anonymous
pages related to buf of task1 are swapped:

1)process_vm_writev() reads them back into memory;

2)process_vm_mmap() just copies swap PTEs from task1 page table
  to task2 page table.

Also, for faster page faults one may use huge pages for the mappings.
But really, it's funny to think about page faults, when there are
disk IO problems I shown.

>>
>> 2)amount of memory for this example is doubled in a moment --
>>   n pages in current and n pages in remote tasks are occupied
>>   at the same time;
> 
> This seems disingenuous.  If you're writing p pages total in chunks of
> n pages, you will use a total of p pages if you use mmap and p+n if
> you use write.

I didn't understand this sentence because of many ifs, sorry. Could you
please explain your thought once again?

> That only doubles the amount of memory if you let n
> scale linearly with p, which seems unlikely.
>
>>
>> 3)received data has no a chance to be properly swapped for
>>   a long time.
> 
> ...
> 
>> a)kernel moves @buf pages into swap right after recv();
>> b)process_vm_writev() reads the data back from swap to pages;
> 
> If you're under that much memory pressure and thrashing that badly,
> your performance is going to be awful no matter what you're doing.  If
> you indeed observe this behavior under normal loads, then this seems
> like a VM issue that should be addressed in its own right.

I don't think so. Imagine: a container migrates from one node to another.
The nodes are the same, say, every of them has 4GB of RAM.

Before the migration, the container's tasks used 4GB of RAM and 8GB of swap.
After the page server on the second node received the pages, we want these
pages become swapped as soon as possible, and we don't want to read them from
swap to pass a read consumer.

The page server is task1 in the example. The real consumer is task2.

This is a rather normal load, I think.

>>         buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
>>                    MAP_PRIVATE|MAP_ANONYMOUS, ...);
>>         recv(sock, buf, n * PAGE_SIZE, 0);
>>
>> [Task 2]
>>         buf2 = process_vm_mmap(pid_of_task1, buf, n * PAGE_SIZE, NULL, 0);
>>
>> This creates a copy of VMA related to buf from task1 in task2's VM.
>> Task1's page table entries are copied into corresponding page table
>> entries of VM of task2.
> 
> You need to fully explain a whole bunch of details that you're
> ignored.

Yeah, it's not a problem :) I'm ready to explain and describe everything,
what may cause a question. Just ask ;) 

> For example, if the remote VMA is MAP_ANONYMOUS, do you get
> a CoW copy of it? I assume you don't since the whole point is to
> write to remote memory

But, no, there *is* COW semantic. We do not copy memory. We copy
page table content. This is just the same we have on fork(), when
children duplicates parent's VMA and related page table subset,
and parent's PTEs lose _PAGE_RW flag.

There is all copy_page_range() code reused for that. Please, see [3/7]
for the details.

I'm going to get special performance using THP, when number of entries
to copy is smaller than in case of PTE.

Copy several of PMD from one task page table to another's is much much much faster,
than process_vm_write() copies pages (even not mention about its reading from swap).

>,but it's at the very least quite unusual in
> Linux to have two different anonymous VMAs such that writing one of
> them changes the other one.
Writing to a new VMA does not affect old VMA. Old VMA is just used to
get vma->anon_vma and vma->vm_file from there. Two VMAs remain independent
each other.

> But there are plenty of other questions.
> What happens if the remote VMA is a gate area or other special mapping
> (vDSO, vvar area, etc)?  What if the remote memory comes from a driver
> that wasn't expecting the mapping to get magically copied to a
> different process?

In case of someone wants to duplicate such the mappings, we may consider
that, and extend the interface in the future for VMA types, which are
safe for that.

But now the logic is very overprotective, and all the unusual mappings
like you mentioned (also AIO, etc) is prohibited. Please, see [7/7]
for the details.

> This new API seems quite dangerous and complex to me, and I don't
> think the value has been adequately demonstrated.

I don't think it's dangerous and complex, because of I haven't introduced
any principal VMA conceptions different to what we have now. We just
borrow vma->anon_vma and vma->vm_file from remote process to local
like we did on fork() (borrowing of vma->anon_vma means not blindly
copying, but ordinary anon_vma_fork()).

Maybe I had to focus the description more on copying of PTE/PMD
instead of vma duplication. So, it's unexpected for me, that people
think about simple memory copying after reading the example I gave.
But I gave more explanation here, so I hope the situation became
clearer for a reader. Anyway, if you have any questions, please
ask me.

Thanks,
Kirill
