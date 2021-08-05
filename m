Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46CD3E1C0A
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 21:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242795AbhHETEv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 15:04:51 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34198 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242637AbhHETEm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 15:04:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 30C5C1F4431A
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
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 0/4] futex2: Add wait on multiple futexes syscall
Date:   Thu,  5 Aug 2021 16:04:01 -0300
Message-Id: <20210805190405.59110-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

As opposed to previous futex2 patchsets, this one adds only one syscall:
futex_waitv(). This way we can focus on this operation that already have
a well defined use case and has been tested for months now.

The patchset reuses as much as possible of original futex code for the new
operation, so the first commit move some stuff to futex header to make
accessible for futex2.

Ideally, I would completely replace futex_wait_setup() with
futex_wait_multiple(): it is basic the same logic, but for n futexes,
so for existing operations it was a matter of calling it with nr_futexes=1.
This worked pretty well for futex_wait(): I tested with glibc tests,
tested with a complete distro running on top of it and perf benchs
presented no performance difference. However, it didn't work for
futex_wait_requeue_pi(), since the wait path for it is slightly different
of the normal wait, that would require some refactor to get it in a way to
be easily replaced. So I decided to not replace it at all.

 Use case

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

 Testing

Selftest is provided as part of this patchset. As stated above, I used
the futex_wait_multiple() in FUTEX_WAIT path and it worked fine in a
full distro. Throught Proton, I've tested futex_waitv() with modern games
that issue more than 40k futex calls per second.

André Almeida (4):
  futex: Prepare for futex_wait_multiple()
  futex2: Implement vectorized wait
  selftests: futex2: Add waitv test
  futex2: Documentation: Document futex_waitv() uAPI

 Documentation/userspace-api/futex2.rst        |  79 ++++++
 Documentation/userspace-api/index.rst         |   1 +
 arch/x86/entry/syscalls/syscall_32.tbl        |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   1 +
 include/linux/compat.h                        |   9 +
 include/linux/futex.h                         |  75 ++++++
 include/uapi/asm-generic/unistd.h             |   5 +-
 include/uapi/linux/futex.h                    |  17 ++
 init/Kconfig                                  |   7 +
 kernel/Makefile                               |   1 +
 kernel/futex.c                                | 224 ++++++++++++++----
 kernel/futex2.c                               | 198 ++++++++++++++++
 kernel/sys_ni.c                               |   4 +
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/futex2_waitv.c | 154 ++++++++++++
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  72 ++++++
 18 files changed, 812 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/userspace-api/futex2.rst
 create mode 100644 kernel/futex2.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_waitv.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

-- 
2.32.0

