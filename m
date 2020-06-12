Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0371F7D2A
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2020 20:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLSvY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 12 Jun 2020 14:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLSvX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 12 Jun 2020 14:51:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CF6C03E96F;
        Fri, 12 Jun 2020 11:51:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 52F862A5160
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org
Subject: [RFC 0/4] futex2: Add new futex interface
Date:   Fri, 12 Jun 2020 15:51:18 -0300
Message-Id: <20200612185122.327860-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

This RFC is a followup to the previous discussion initiated from my last
patch "futex: Implement mechanism to wait on any of several futexes"[1].
As stated in the thread, the correct approach to move forward with the
wait multiple operation would be to create a new syscall that would have
all new cool features.

The first patch adds the new interface and just translate the call for
the old interface, without implementing new features. The goal here is
to establish the interface and to check if everyone is happy with this
API. The rest of patches are selftests to show the interface in action.
I have the following questions:

- Has anyone stared worked on a implementation of this interface? If
  yes, it would be nice to share the progress so we don't have duplicated
  work.

- What suggestions do you have to implement this? Start from scratch or
  reuse the most code possible?

- The interface seems correct and implements the requirements asked by you?

- The proposed interface uses ktime_t type for absolute timeout, and I
  assumed that it should use values in a nsec resolution. If this is true,
  we have some problems with i386 ABI, please check out the
  COMPAT_32BIT_TIME implementation in patch 1 for more details. I
  haven't added a time64 implementation yet, until this is clarified.

- Is expected to have a x32 ABI implementation as well? In the case of
  wait and wake, we could use the same as x86_64 ABI. However, for the
  waitv (aka wait on multiple futexes) we would need a proper x32 entry
  since we are dealing with 32bit pointers.

Those are the cool new features that this syscall should address some
day:

- Operate with variable bit size futexes, not restricted to 32:
  8, 16 and 64

- Wait on multiple futexes, using the following semantics:

  struct futex_wait {
	void *uaddr;
	unsigned long val;
	unsigned long flags;
  };

  sys_futex_waitv(struct futex_wait *waiters, unsigned int nr_waiters,
		  unsigned long flags, ktime_t *timo);

- Have NUMA optimizations: if FUTEX_NUMA_FLAG is present, the `void *uaddr`
  argument won't be a u{8, 16, 32, 64} value anymore, but a struct
  containing a NUMA node hint:

  struct futex32_numa {
	  u32 value __attribute__ ((aligned (8)));
	  u32 hint;
  };

  struct futex64_numa {
	  u64 value __attribute__ ((aligned (16)));
	  u64 hint;
  };

Thanks,
	André

André Almeida (4):
  futex2: Add new futex interface
  selftests: futex: Add futex2 wake/wait test
  selftests: futex: Add futex2 timeout test
  selftests: futex: Add futex2 wouldblock test

 MAINTAINERS                                   |   2 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   2 +
 include/linux/syscalls.h                      |   9 ++
 include/uapi/asm-generic/unistd.h             |   7 +-
 include/uapi/linux/futex.h                    |  10 ++
 init/Kconfig                                  |   7 ++
 kernel/Makefile                               |   1 +
 kernel/futex2.c                               |  97 ++++++++++++++++
 kernel/sys_ni.c                               |   5 +
 tools/include/uapi/asm-generic/unistd.h       |   7 +-
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   4 +-
 .../selftests/futex/functional/futex2_wait.c  | 106 ++++++++++++++++++
 .../futex/functional/futex_wait_timeout.c     |  27 ++++-
 .../futex/functional/futex_wait_wouldblock.c  |  34 +++++-
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  50 +++++++++
 18 files changed, 361 insertions(+), 13 deletions(-)
 create mode 100644 kernel/futex2.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

-- 
2.27.0

