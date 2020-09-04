Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4712A25D79D
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 13:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgIDLlb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 07:41:31 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49564 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730018AbgIDLlW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 07:41:22 -0400
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
        by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id 217D530747C4;
        Fri,  4 Sep 2020 14:31:05 +0300 (EEST)
Received: from localhost.localdomain (unknown [195.189.155.252])
        by smtp.bitdefender.com (Postfix) with ESMTPSA id 2B7513072785;
        Fri,  4 Sep 2020 14:31:04 +0300 (EEST)
From:   =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To:     linux-mm@kvack.org
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RESEND RFC PATCH 0/5] Remote mapping
Date:   Fri,  4 Sep 2020 14:31:11 +0300
Message-Id: <20200904113116.20648-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patchset adds support for the remote mapping feature.
Remote mapping, as its name suggests, is a means for transparent and
zero-copy access of a remote process' address space.
access of a remote process' address space.

The feature was designed according to a specification suggested by
Paolo Bonzini:
>> The proposed API is a new pidfd system call, through which the parent
>> can map portions of its virtual address space into a file descriptor
>> and then pass that file descriptor to a child.
>>
>> This should be:
>>
>> - upstreamable, pidfd is the new cool thing and we could sell it as a
>> better way to do PTRACE_{PEEK,POKE}DATA
>>
>> - relatively easy to do based on the bitdefender remote process
>> mapping patches at.
>>
>> - pidfd_mem() takes a pidfd and some flags (which are 0) and returns
>> two file descriptors for respectively the control plane and the memory access.
>>
>> - the control plane accepts three ioctls
>>
>> PIDFD_MEM_MAP takes a struct like
>>
>>     struct pidfd_mem_map {
>>          uint64_t address;
>>          off_t offset;
>>          off_t size;
>>          int flags;
>>          int padding[7];
>>     }
>>
>> After this is done, the memory access fd can be mmap-ed at range
>> [offset,
>> offset+size), and it will read memory from range [address,
>> address+size) of the target descriptor.
>>
>> PIDFD_MEM_UNMAP takes a struct like
>>
>>     struct pidfd_mem_unmap {
>>          off_t offset;
>>          off_t size;
>>     }
>>
>> and unmaps the corresponding range of course.
>>
>> Finally PIDFD_MEM_LOCK forbids subsequent PIDFD_MEM_MAP or
>> PIDFD_MEM_UNMAP.  For now I think it should just check that the
>> argument is zero, bells and whistles can be added later.
>>
>> - the memory access fd can be mmap-ed as in the bitdefender patches
>> but also accessed with read/write/pread/pwrite/...  As in the
>> BitDefender patches, MMU notifiers can be used to adjust any mmap-ed
>> regions when the source address space changes.  In this case,
>> PIDFD_MEM_UNMAP could also cause a pre-existing mmap to "disappear".
(it currently doesn't support read/write/pread/pwrite/...)

The main remote mapping patch also contains the legacy implementation which
creates a region the size of the whole process address space by means of the
REMOTE_PROC_MAP ioctl. The user is then free to mmap() any region of the
address space it wishes.

VMAs obtained by mmap()ing memory access fds mirror the contents of the remote
process address space within the specified range. Pages are installed in the
current process page tables at fault time and removed by the mmu_interval_notifier
invalidate callbck. No further memory management is involved.
On attempts to access a hole, or if a mapping was removed by PIDFD_MEM_UNMAP,
or if the remote process address space was reaped by OOM, the remote mapping
fault handler returns VM_FAULT_SIGBUS.

At Bitdefender we are using remote mapping for virtual machine introspection:
- the QEMU running the introspected machine creates the pair of file descriptors,
passes the access fd to the introspector QEMU, and uses the control fd to allow
access to the memslots it creates for its machine
- the QEMU running the introspector machine receives the access fd and mmap()s
the regions made available, then hotplugs the obtained memory in its machine
Having this setup creates nested invalidate_range_start/end MMU notifier calls.

Patch organization:
- patch 1 allows unmap_page_range() to run without rescheduling
  Needed for remote mapping to zap current process page tables when OOM calls
  mmu_notifier_invalidate_range_start_nonblock(&range)

- patch 2 creates VMA-specific zapping behavior
  A remote mapping VMA does not own the pages it maps, so all it has to do is
  clear the PTEs.

- patch 3 removed MMU notifier lockdep map
  It was just incompatible with our use case.

- patch 4 is the remote mapping implementation

- patch 5 adds suggested pidfd_mem system call

Mircea Cirjaliu (5):
  mm: add atomic capability to zap_details
  mm: let the VMA decide how zap_pte_range() acts on mapped pages
  mm/mmu_notifier: remove lockdep map, allow mmu notifier to be used in
    nested scenarios
  mm/remote_mapping: use a pidfd to access memory belonging to unrelated
    process
  pidfd_mem: implemented remote memory mapping system call

 arch/x86/entry/syscalls/syscall_32.tbl |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl |    1 +
 include/linux/mm.h                     |   22 +
 include/linux/mmu_notifier.h           |    5 +-
 include/linux/pid.h                    |    1 +
 include/linux/remote_mapping.h         |   22 +
 include/linux/syscalls.h               |    1 +
 include/uapi/asm-generic/unistd.h      |    2 +
 include/uapi/linux/remote_mapping.h    |   36 +
 kernel/exit.c                          |    2 +-
 kernel/pid.c                           |   55 +
 mm/Kconfig                             |   11 +
 mm/Makefile                            |    1 +
 mm/memory.c                            |  193 ++--
 mm/mmu_notifier.c                      |   19 -
 mm/remote_mapping.c                    | 1273 ++++++++++++++++++++++++
 16 files changed, 1535 insertions(+), 110 deletions(-)
 create mode 100644 include/linux/remote_mapping.h
 create mode 100644 include/uapi/linux/remote_mapping.h
 create mode 100644 mm/remote_mapping.c


base-commit: ae83d0b416db002fe95601e7f97f64b59514d936
