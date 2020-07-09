Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AE721A67E
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2020 20:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGISAl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 14:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgGISAk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 14:00:40 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AB1C08C5CE;
        Thu,  9 Jul 2020 11:00:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C5E122A65E7
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com,
        andrealmeid@collabora.com, dvhart@infradead.org, mingo@redhat.com,
        pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org, arnd@arndb.de
Subject: [RFC v2 0/4] futex2: Add new futex interface
Date:   Thu,  9 Jul 2020 14:59:17 -0300
Message-Id: <20200709175921.211387-1-andrealmeid@collabora.com>
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

- What suggestions do you have to implement this? Start from scratch or
  reuse the most code possible?

- The interface seems correct and implements the requirements asked by you?

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
		  unsigned long flags, struct __kernel_timespec *timo);

- Have NUMA optimizations: if FUTEX_NUMA_FLAG is set, the `void *uaddr`
  argument won't be a value of type u{8, 16, 32, 64} anymore, but a struct
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

Changes since v1:
 - The timeout argument now uses __kernel_timespec as type
 - time32 interface was removed
 v1: https://lore.kernel.org/patchwork/cover/1255437/

[1] https://lore.kernel.org/patchwork/patch/1194339/

André Almeida (4):
  futex2: Add new futex interface
  selftests: futex: Add futex2 wake/wait test
  selftests: futex: Add futex2 timeout test
  selftests: futex: Add futex2 wouldblock test

 MAINTAINERS                                   |   2 +-
 arch/x86/entry/syscalls/syscall_32.tbl        |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl        |   2 +
 include/linux/syscalls.h                      |   7 ++
 include/uapi/asm-generic/unistd.h             |   8 +-
 include/uapi/linux/futex.h                    |  10 ++
 init/Kconfig                                  |   7 ++
 kernel/Makefile                               |   1 +
 kernel/futex2.c                               |  73 ++++++++++++
 kernel/sys_ni.c                               |   4 +
 tools/include/uapi/asm-generic/unistd.h       |   7 +-
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   4 +-
 .../selftests/futex/functional/futex2_wait.c  | 111 ++++++++++++++++++
 .../futex/functional/futex_wait_timeout.c     |  38 ++++--
 .../futex/functional/futex_wait_wouldblock.c  |  33 +++++-
 .../testing/selftests/futex/functional/run.sh |   3 +
 .../selftests/futex/include/futex2test.h      |  77 ++++++++++++
 18 files changed, 373 insertions(+), 17 deletions(-)
 create mode 100644 kernel/futex2.c
 create mode 100644 tools/testing/selftests/futex/functional/futex2_wait.c
 create mode 100644 tools/testing/selftests/futex/include/futex2test.h

-- 
2.27.0

