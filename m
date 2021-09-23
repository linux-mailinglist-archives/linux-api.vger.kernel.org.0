Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893024163F2
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhIWRM7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbhIWRM6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:12:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B617DC061574;
        Thu, 23 Sep 2021 10:11:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 3C3221F445F0
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
Subject: [PATCH v2 00/22] futex: splitup and waitv syscall
Date:   Thu, 23 Sep 2021 14:10:49 -0300
Message-Id: <20210923171111.300673-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This v2 is a followup of Peter's patchset that addresses feedback from
the Linux Plumbers Conference session about new futex syscalls.

Changelog:
v1: https://lore.kernel.org/lkml/20210915140710.596174479@infradead.org/
- Added a clockid argument in sys_futex_waitv()
	- This required some changes in the timeout init
- Added test for wouldblock
- Added documentation file
- Fixed error path order for futex_wait_multiple()
- Return error if FUTEX_32 is not set for a waiter
	- Extended futex_waitv() selftest to cover error paths like this

Original cover letter for this syscall (extracted from
https://lore.kernel.org/lkml/20210904231159.13292-1-andrealmeid@collabora.com/):

This patchset introduce the futex_waitv syscall, that enables userspace
to wait in an array of futexes and wake on any.

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
              unsigned int flags, struct timespec *timo, clockid_t clockid)

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
32/64-bit pointers. The documentation patch provides more detailed
information about the interface.

André Almeida (7):
  futex: Implement sys_futex_waitv()
  futex,x86: Wire up sys_futex_waitv()
  futex,arm: Wire up sys_futex_waitv()
  selftests: futex: Add sys_futex_waitv() test
  selftests: futex: Test sys_futex_waitv() timeout
  selftests: futex: Test sys_futex_waitv() wouldblock
  futex2: Documentation: Document futex_waitv() uAPI

Peter Zijlstra (15):
  futex: Move to kernel/futex/
  futex: Split out syscalls
  futex: Rename {,__}{,un}queue_me()
  futex: Rename futex_wait_queue_me()
  futex: Rename: queue_{,un}lock()
  futex: Rename __unqueue_futex()
  futex: Rename hash_futex()
  futex: Rename: {get,cmpxchg}_futex_value_locked()
  futex: Split out PI futex
  futex: Rename: hb_waiter_{inc,dec,pending}()
  futex: Rename: match_futex()
  futex: Rename mark_wake_futex()
  futex: Split out requeue
  futex: Split out wait/wake
  futex: Simplify double_lock_hb()

 Documentation/userspace-api/futex2.rst        |   81 +
 Documentation/userspace-api/index.rst         |    1 +
 MAINTAINERS                                   |    3 +-
 arch/arm/tools/syscall.tbl                    |    1 +
 arch/arm64/include/asm/unistd.h               |    2 +-
 arch/arm64/include/asm/unistd32.h             |    2 +
 arch/x86/entry/syscalls/syscall_32.tbl        |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |    1 +
 include/linux/syscalls.h                      |    6 +
 include/uapi/asm-generic/unistd.h             |    5 +-
 include/uapi/linux/futex.h                    |   25 +
 kernel/Makefile                               |    2 +-
 kernel/futex.c                                | 4272 -----------------
 kernel/futex/Makefile                         |    3 +
 kernel/futex/core.c                           | 1176 +++++
 kernel/futex/futex.h                          |  295 ++
 kernel/futex/pi.c                             | 1233 +++++
 kernel/futex/requeue.c                        |  897 ++++
 kernel/futex/syscalls.c                       |  387 ++
 kernel/futex/waitwake.c                       |  708 +++
 kernel/sys_ni.c                               |    3 +
 .../selftests/futex/functional/.gitignore     |    1 +
 .../selftests/futex/functional/Makefile       |    3 +-
 .../futex/functional/futex_wait_timeout.c     |   21 +-
 .../futex/functional/futex_wait_wouldblock.c  |   41 +-
 .../selftests/futex/functional/futex_waitv.c  |  158 +
 .../testing/selftests/futex/functional/run.sh |    3 +
 .../selftests/futex/include/futex2test.h      |   31 +
 28 files changed, 5080 insertions(+), 4282 deletions(-)
 create mode 100644 Documentation/userspace-api/futex2.rst
 delete mode 100644 kernel/futex.c
 create mode 100644 kernel/futex/Makefile
 create mode 100644 kernel/futex/core.c
 create mode 100644 kernel/futex/futex.h
 create mode 100644 kernel/futex/pi.c
 create mode 100644 kernel/futex/requeue.c
 create mode 100644 kernel/futex/syscalls.c
 create mode 100644 kernel/futex/waitwake.c
 create mode 100644 tools/testing/selftests/futex/functional/futex_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

--
2.33.0

