Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964ED400D72
	for <lists+linux-api@lfdr.de>; Sun,  5 Sep 2021 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhIDXNW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 4 Sep 2021 19:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236070AbhIDXNS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 4 Sep 2021 19:13:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A51C061575;
        Sat,  4 Sep 2021 16:12:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 82EF91F41B94
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 0/5] futex2: Add wait on multiple futexes syscall
Date:   Sat,  4 Sep 2021 20:11:54 -0300
Message-Id: <20210904231159.13292-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

This patchset introduce the futex_waitv syscall. It reuses as much as
possible of original futex code for the new operation, so the first
commit move some stuff to futex header to make accessible for futex2.

* Use case

The use case of this syscall is to allow low level locking libraries to
wait for multiple locks at the same time. This is specially useful for
emulating Windows' WaitForMultipleObjects. A futex_waitv()-based solution
has been used for some time at Proton's Wine (a compatibility layer to
run Windows games on Linux). Compared to a solution that uses eventfd(),
futex was able to reduce CPU utilization for games, and even increase
frames per second for some games. This happens because eventfd doesn't
scale very well for a huge number of read, write and poll calls compared
to futex. Native game engines will benefit of this as well, given that
this wait pattern is common for games.

* The interface

This is how the interface looks like:

  futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
              unsigned int flags, struct timespec *timo)

  struct futex_waitv {
          __u64 val;
          __u64 uaddr;
          __u32 flags;
          __u32 __reserved;
  };

struct futex_waitv uses explicit padding, so we can use it in all
architectures. The __reserved is used for the padding and should always
be 0, but it may be repurposed in the future for some extension. If
userspace has 32-bit pointers, it should do a explicit cast to make sure
the upper bits are zeroed. uintptr_t does the tricky and it works for
32/64-bit pointers.

* Why u64?

Although futex() supports only 32-bit long integers, while researching
about feedback around a new futex interface, developers made some points
for variable size support:

- At Boost Libraries, futex is used as back end to implement atomic
primitives for some architectures. It works fine for 32-bit futexes, but
for other sizes it "must use an internal lock pool to implement waiting
and notifying operations, which increases thread contention. For
inter-process atomics, this means that waiting must be done using a spin
loop, which is terribly inefficient."[1]

- glibc’s rwlock implementation "uses a torn 32-bit futex read which is
part of an atomically updated 64-bit word".[2]

- Peter Oskolkov[3] pointed out that for 64-bit platforms it would be
useful to do atomic operations in pointer values: "imagine a simple
producer/consumer scenario, with the producer updating some shared
memory data and waking the consumer. Storing the pointer in the futex
makes it so that only one shared memory location needs to be accessed
atomically".

- The original proposal[4] to support 8-bit and 16-bit futexes had some
use cases as well: "Having mutexes that are only one byte in size was
the first reason WebKit mentioned for re-implementing futexes in a
library" and "The C++ standard added futexes to the standard library in
C++20 under the name atomic_wait and atomic_notify. The C++20 version
supports this for atomic variables of any size. The more sizes we can
support, the better the implementation can be in the standard library."

 Testing

Through Proton, I've tested futex_waitv() with modern games that issue
more than 40k futex calls per second. Selftest are provided as part of this
patchset. However, those selftests aren't really reliable in 32-bit
platforms giving that glibc doesn't expose a way to have a 64-bit timespec 
gettime(). In the past I implemented a gettime64() by myself as part of
the selftest, but I'm not sure if this the best approach:
https://lore.kernel.org/lkml/20210805190405.59110-4-andrealmeid@collabora.com/

 Changelog

Changes from v1:
v1: https://lore.kernel.org/lkml/20210805190405.59110-1-andrealmeid@collabora.com/
- Tons of code and comment improvements and fixes (thanks Thomas!)
- Changed the struct to have explicit padding (thanks Arnd!)
- Created a kernel/futex.h
- Splitted syscall table changes from the implementation
- Compat and non-compat entry point now uses the same code and same
  struct
- Added test for timeout

More info about futex2: https://lore.kernel.org/lkml/20210709001328.329716-1-andrealmeid@collabora.com/

[1] https://lists.boost.org/Archives/boost/2021/05/251508.php

[2]
https://lore.kernel.org/lkml/20210603195924.361327-1-andrealmeid@collabora.com/T/#m37bfbbd6ac76c121941defd1daea774389552674

[3]
https://lore.kernel.org/lkml/CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com/

[4]
https://lore.kernel.org/lkml/20191204235238.10764-1-malteskarupke@web.de/

André Almeida (5):
  futex: Prepare for futex_wait_multiple()
  futex2: Implement vectorized wait
  futex2: wire up syscall for x86
  selftests: futex2: Add waitv test
  selftests: futex2: Test futex_waitv timeout

 MAINTAINERS                                   |   3 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/compat.h                        |   3 +
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/futex.h                    |  25 ++
 init/Kconfig                                  |   7 +
 kernel/Makefile                               |   1 +
 kernel/futex.c                                | 319 +++++++++++-------
 kernel/futex.h                                | 155 +++++++++
 kernel/futex2.c                               | 131 +++++++
 kernel/sys_ni.c                               |   4 +
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../futex/functional/futex_wait_timeout.c     |  21 +-
 .../selftests/futex/functional/futex_waitv.c  | 158 +++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  43 +++
 18 files changed, 764 insertions(+), 120 deletions(-)
 create mode 100644 kernel/futex.h
 create mode 100644 kernel/futex2.c
 create mode 100644 tools/testing/selftests/futex/functional/futex_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

-- 
2.33.0

