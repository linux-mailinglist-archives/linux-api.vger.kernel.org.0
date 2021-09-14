Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D90140A24F
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 03:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235894AbhINBGt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 13 Sep 2021 21:06:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36650 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbhINBGt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 13 Sep 2021 21:06:49 -0400
Received: from localhost (unknown [IPv6:2a00:5f00:102:0:f4d2:afff:fe2b:18b5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5A0951F42CA2;
        Tue, 14 Sep 2021 02:05:31 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org, mtk.manpages@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 0/6] futex2: Add wait on multiple futexes syscall
Organization: Collabora
References: <20210913175249.81074-1-andrealmeid@collabora.com>
Date:   Mon, 13 Sep 2021 21:05:28 -0400
In-Reply-To: <20210913175249.81074-1-andrealmeid@collabora.com>
 (=?utf-8?Q?=22Andr=C3=A9?=
        Almeida"'s message of "Mon, 13 Sep 2021 14:52:43 -0300")
Message-ID: <871r5sge5j.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

André Almeida <andrealmeid@collabora.com> writes:

> Hi,
>
> This patchset introduce the futex_waitv syscall. It reuses as much as
> possible of original futex code for the new operation, so the first
> commit move some stuff to futex header to make accessible for futex2.
>

In general, this series is missing a Documentation/ patch at the end.
In particular since it adds a new interface.  Much of what you describe
in the cover letter should go there...

> * Use case
>
> The use case of this syscall is to allow low level locking libraries to
> wait for multiple locks at the same time. This is specially useful for
> emulating Windows' WaitForMultipleObjects. A futex_waitv()-based solution
> has been used for some time at Proton's Wine (a compatibility layer to
> run Windows games on Linux). Compared to a solution that uses eventfd(),
> futex was able to reduce CPU utilization for games, and even increase
> frames per second for some games. This happens because eventfd doesn't
> scale very well for a huge number of read, write and poll calls compared
> to futex. Native game engines will benefit of this as well, given that
> this wait pattern is common for games.
>
> * The interface
>
> This is how the interface looks like:
>
>   futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
>               unsigned int flags, struct timespec *timo)
>
>   struct futex_waitv {
>           __u64 val;
>           __u64 uaddr;
>           __u32 flags;
>           __u32 __reserved;
>   };
>
> struct futex_waitv uses explicit padding, so we can use it in all
> architectures. The __reserved is used for the padding and should always
> be 0, but it may be repurposed in the future for some extension. If
> userspace has 32-bit pointers, it should do a explicit cast to make sure
> the upper bits are zeroed. uintptr_t does the tricky and it works for
> 32/64-bit pointers.
>
> * Why u64?
>
> Although futex() supports only 32-bit long integers, while researching
> about feedback around a new futex interface, developers made some points
> for variable size support:
>
> - At Boost Libraries, futex is used as back end to implement atomic
> primitives for some architectures. It works fine for 32-bit futexes, but
> for other sizes it "must use an internal lock pool to implement waiting
> and notifying operations, which increases thread contention. For
> inter-process atomics, this means that waiting must be done using a spin
> loop, which is terribly inefficient."[1]
>
> - glibc’s rwlock implementation "uses a torn 32-bit futex read which is
> part of an atomically updated 64-bit word".[2]
>
> - Peter Oskolkov[3] pointed out that for 64-bit platforms it would be
> useful to do atomic operations in pointer values: "imagine a simple
> producer/consumer scenario, with the producer updating some shared
> memory data and waking the consumer. Storing the pointer in the futex
> makes it so that only one shared memory location needs to be accessed
> atomically".
>
> - The original proposal[4] to support 8-bit and 16-bit futexes had some
> use cases as well: "Having mutexes that are only one byte in size was
> the first reason WebKit mentioned for re-implementing futexes in a
> library" and "The C++ standard added futexes to the standard library in
> C++20 under the name atomic_wait and atomic_notify. The C++20 version
> supports this for atomic variables of any size. The more sizes we can
> support, the better the implementation can be in the standard library."
>
>  Testing
>
> Through Proton, I've tested futex_waitv() with modern games that issue
> more than 40k futex calls per second. Selftest are provided as part of this
> patchset. However, those selftests aren't really reliable in 32-bit
> platforms giving that glibc doesn't expose a way to have a 64-bit timespec 
> gettime(). In the past I implemented a gettime64() by myself as part of
> the selftest, but I'm not sure if this the best approach:
> https://lore.kernel.org/lkml/20210805190405.59110-4-andrealmeid@collabora.com/
>
>  Changelog
>
> Changes from v2:
> v2: https://lore.kernel.org/lkml/20210904231159.13292-1-andrealmeid@collabora.com/
> - Last version, I made compat and non-compat use the same code, but
> failed to remove the compat entry point. This is fixed now.
> - Add ARM support
>
> Changes from v1:
> v1: https://lore.kernel.org/lkml/20210805190405.59110-1-andrealmeid@collabora.com/
> - Tons of code and comment improvements and fixes (thanks Thomas!)
> - Changed the struct to have explicit padding (thanks Arnd!)
> - Created a kernel/futex.h
> - Splitted syscall table changes from the implementation
> - Compat and non-compat entry point now uses the same code and same
>   struct
> - Added test for timeout
>
> More info about futex2: https://lore.kernel.org/lkml/20210709001328.329716-1-andrealmeid@collabora.com/
>
> [1] https://lists.boost.org/Archives/boost/2021/05/251508.php
>
> [2]
> https://lore.kernel.org/lkml/20210603195924.361327-1-andrealmeid@collabora.com/T/#m37bfbbd6ac76c121941defd1daea774389552674
>
> [3]
> https://lore.kernel.org/lkml/CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com/
>
> [4]
> https://lore.kernel.org/lkml/20191204235238.10764-1-malteskarupke@web.de/
>
> André Almeida (6):
>   futex: Prepare for futex_wait_multiple()
>   futex2: Implement vectorized wait
>   futex2: wire up syscall for x86
>   futex2: wire up syscall for ARM
>   selftests: futex2: Add waitv test
>   selftests: futex2: Test futex_waitv timeout
>
>  MAINTAINERS                                   |   3 +-
>  arch/arm/tools/syscall.tbl                    |   1 +
>  arch/arm64/include/asm/unistd.h               |   2 +-
>  arch/arm64/include/asm/unistd32.h             |   2 +
>  arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
>  include/linux/syscalls.h                      |   6 +
>  include/uapi/asm-generic/unistd.h             |   5 +-
>  include/uapi/linux/futex.h                    |  25 ++
>  init/Kconfig                                  |   7 +
>  kernel/Makefile                               |   1 +
>  kernel/futex.c                                | 335 +++++++++++-------
>  kernel/futex.h                                | 155 ++++++++
>  kernel/futex2.c                               | 117 ++++++
>  kernel/sys_ni.c                               |   3 +
>  .../selftests/futex/functional/.gitignore     |   1 +
>  .../selftests/futex/functional/Makefile       |   3 +-
>  .../futex/functional/futex_wait_timeout.c     |  21 +-
>  .../selftests/futex/functional/futex_waitv.c  | 158 +++++++++
>  .../testing/selftests/futex/functional/run.sh |   3 +
>  .../selftests/futex/include/futex2test.h      |  31 ++
>  21 files changed, 744 insertions(+), 137 deletions(-)
>  create mode 100644 kernel/futex.h
>  create mode 100644 kernel/futex2.c
>  create mode 100644 tools/testing/selftests/futex/functional/futex_waitv.c
>  create mode 100644 tools/testing/selftests/futex/include/futex2test.h
>
> -- 
> 2.33.0

-- 
Gabriel Krisman Bertazi
