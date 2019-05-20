Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8D223919
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387488AbfETOBC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 10:01:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:39784 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732639AbfETOAx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 May 2019 10:00:53 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hSipd-00082V-Un; Mon, 20 May 2019 17:00:02 +0300
Content-Transfer-Encoding: 7bit
Subject: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication a
 process mapping
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 20 May 2019 17:00:01 +0300
Message-ID: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

v2: Add PVMMAP_FIXED_NOREPLACE flag.
    Use find_vma_without_flags() and may_mmap_overlapped_region() helpers,
    so even more code became reused.
    Syscall number is changed.
    Fix whitespaces.

    Prohibited a cloning from local to remote process. Only mapping
    to local process mm is allowed, since I missed initially, that
    get_unmapped_area() can't be used for remote process. This may
    be very simply solved by passing @mm argument to all .get_unmapped_area
    handlers. In this patchset I don't do this, since this gives a lot
    of cleanup patches, which hides main logic away. I'm going to
    send them later, as another series, after we finish with this.

[Summary]

New syscall, which allows to clone a remote process VMA
into local process VM. The remote process's page table
entries related to the VMA are cloned into local process's
page table (in any desired address, which makes this different
from that happens during fork()). Huge pages are handled
appropriately.

This allows to improve performance in significant way like
it's shows in the example below.

[Description] 

This patchset adds a new syscall, which makes possible
to clone a VMA from a process to current process.
The syscall supplements the functionality provided
by process_vm_writev() and process_vm_readv() syscalls,
and it may be useful in many situation.

For example, it allows to make a zero copy of data,
when process_vm_writev() was previously used:

	struct iovec local_iov, remote_iov;
	void *buf;

	buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
		   MAP_PRIVATE|MAP_ANONYMOUS, ...);
	recv(sock, buf, n * PAGE_SIZE, 0);

	local_iov->iov_base = buf;
	local_iov->iov_len = n * PAGE_SIZE;
	remove_iov = ...;

	process_vm_writev(pid, &local_iov, 1, &remote_iov, 1 0);
	munmap(buf, n * PAGE_SIZE);

	(Note, that above completely ignores error handling)

There are several problems with process_vm_writev() in this example:

1)it causes pagefault on remote process memory, and it forces
  allocation of a new page (if was not preallocated);

2)amount of memory for this example is doubled in a moment --
  n pages in current and n pages in remote tasks are occupied
  at the same time;

3)received data has no a chance to be properly swapped for
  a long time.

The third is the most critical in case of remote process touches
the data pages some time after process_vm_writev() was made.
Imagine, node is under memory pressure:

a)kernel moves @buf pages into swap right after recv();
b)process_vm_writev() reads the data back from swap to pages;
c)process_vm_writev() allocates duplicate pages in remote
  process and populates them;
d)munmap() unmaps @buf;
e)5 minutes later remote task touches data.

In stages "a" and "b" kernel submits unneeded IO and makes
system IO throughput worse. To make "b" and "c", kernel
reclaims memory, and moves pages of some other processes
to swap, so they have to read pages from swap back. Also,
unneeded copying of pages is occured, while zero-copy is
more preferred.

We observe similar problem during online migration of big enough
containers, when after doubling of container's size, the time
increases 100 times. The system resides under high IO and
throwing out of useful cashes.

The proposed syscall aims to introduce an interface, which
supplements currently existing process_vm_writev() and
process_vm_readv(), and allows to solve the problem with
anonymous memory transfer. The above example may be rewritten as:

[Task 1]
	void *buf;

	buf = mmap(NULL, n * PAGE_SIZE, PROT_READ|PROT_WRITE,
		   MAP_PRIVATE|MAP_ANONYMOUS, ...);
	recv(sock, buf, n * PAGE_SIZE, 0);

[Task 2]
	buf2 = process_vm_mmap(pid_of_task1, buf, n * PAGE_SIZE, NULL, 0);

This creates a copy of VMA related to buf from task1 in task2's VM.
Task1's page table entries are copied into corresponding page table
entries of VM of task2.

It is swap-friendly: in case of memory is swapped right after recv(),
the syscall just copies pagetable entries like we do on fork(),
so real access to pages does not occurs, and no IO is needed.
No excess pages are reclaimed, and number of pages is not doubled.
Also, zero-copy takes a place, and this also reduces overhead.

The patchset does not introduce much new code, since we simply
reuse existing copy_page_range() and copy_vma() functions.
We extend copy_vma() to be able merge VMAs in remote task [2/7],
and teach copy_page_range() to work with different local and
remote addresses [3/7]. Patch [7/7] introduces the syscall logic,
which mostly consists of sanity checks. The rest of patches
are preparations.

This syscall may be used for page servers like in example
above, for migration (I assume, even virtual machines may
want something like this), for zero-copy desiring users
of process_vm_writev() and process_vm_readv(), for debug
purposes, etc. It requires the same permittions like
existing proc_vm_xxx() syscalls have.

The tests I used may be obtained here (UPDATED):

[1]https://gist.github.com/tkhai/ce46502fc53580372da35e8c3b7818b9
[2]https://gist.github.com/tkhai/40bda78e304d2fe0d90863214b9ac5b5

Previous version (RFC):
[3]https://lore.kernel.org/lkml/CAG48ez0itiEE1x=SXeMbjKvMGkrj7wxjM6c+ZB00LpXAAhqmiw@mail.gmail.com/T/

---

Kirill Tkhai (7):
      mm: Add process_vm_mmap() syscall declaration
      mm: Extend copy_vma()
      mm: Extend copy_page_range()
      mm: Export round_hint_to_min()
      mm: Introduce may_mmap_overlapped_region() helper
      mm: Introduce find_vma_filter_flags() helper
      mm: Add process_vm_mmap()


 arch/x86/entry/syscalls/syscall_32.tbl |    1 
 arch/x86/entry/syscalls/syscall_64.tbl |    2 
 include/linux/huge_mm.h                |    6 +
 include/linux/mm.h                     |   14 ++
 include/linux/mm_types.h               |    2 
 include/linux/mman.h                   |   14 ++
 include/linux/syscalls.h               |    5 +
 include/uapi/asm-generic/mman-common.h |    6 +
 include/uapi/asm-generic/unistd.h      |    5 +
 init/Kconfig                           |    9 +-
 kernel/fork.c                          |    5 +
 kernel/sys_ni.c                        |    2 
 mm/huge_memory.c                       |   30 ++++-
 mm/memory.c                            |  165 +++++++++++++++++++---------
 mm/mmap.c                              |  186 ++++++++++++++++++++++++++------
 mm/mremap.c                            |   43 +++++--
 mm/process_vm_access.c                 |   69 ++++++++++++
 17 files changed, 439 insertions(+), 125 deletions(-)

--
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
