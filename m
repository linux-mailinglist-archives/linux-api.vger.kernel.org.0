Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E806542FE0
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfFLT0e (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35819 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfFLT0e (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:34 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so7704038wml.0
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP9i/4+RFXXs6vZEMe5dSWLsdT0WU4d9ROBF0JTFc+8=;
        b=RSyibbuLuFaB6LvVdiFpypBOa4vFgdRVCoRzcpKAi+XhRCtEq8DwMgmLFzhRR9DdKD
         5O7c0yrC2bDghkOuw7p+EKR5NLjSR8uV7sRnatQraKkEpwHmR4i7Fu1VwKhgSHdOO6WS
         A/4igX0NkK6/v+X8eidZKKtjooOHARbrw/9n587fcUuQJmDXtBdCxPg/1/E2GNmQgHTs
         2mK2l2r9FA27/PRLPiMrboC0s+c4yrVS97nq7q7HjKuPrPX0+LFTuYy2GFlbiUYSrrrY
         K2+Ce6O2YhmEukMWaikZHNJ2+TxuRntREExCeEKerBvcvBf/M6O8vD98JC6WEBex4H8s
         SjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP9i/4+RFXXs6vZEMe5dSWLsdT0WU4d9ROBF0JTFc+8=;
        b=fWG+dBzpZ/o1A9TQykNvs+YMWNOaDQw2eOGApIpT89GO++y15kd0EuvLUMYZR5+bWM
         vuiD++Vi5d+IbThTjhZ4hmgIiapYX6ErKYEdfKoAuWWzf2CqxQaF03pf7c7NFAXlFyBQ
         R6j24yIEfxcFDeo8ek/ay94tTfqyVvN6JT3VLX6YL6CGc/IP1IET7s1jcVCNnbeVF717
         XzR1WzQtBen0nQqxfbRSmGTOUxjP6S7JKy5+rXQXKMbiBHWxW2Xoy2Q7qYdJraiHtBk5
         ePYF0z8NcRgqKDHXi41agHDoZFKCFPz0S63BDNfamn3IamaITeTsT7szTHqnv/xaiOmJ
         c2iw==
X-Gm-Message-State: APjAAAVBX9uLtbpG+GgdQDn0PHvdkZ7H2miB0k7vfoOkXsH6K4xkShIa
        68BcmwIpXR+0ayrmDn1ruQHDSQ==
X-Google-Smtp-Source: APXvYqxWAsuEm2sE8nu1IrC7sx4/phkV3uK4oHIXsyiBfXyaa0vKO+uTFFuUNQAjor+9IneBRImQtg==
X-Received: by 2002:a1c:4956:: with SMTP id w83mr509200wma.67.1560367590042;
        Wed, 12 Jun 2019 12:26:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:29 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv4 00/28] kernel: Introduce Time Namespace
Date:   Wed, 12 Jun 2019 20:25:59 +0100
Message-Id: <20190612192628.23797-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Discussions around time namespace are there for a long time. The first
attempt to implement it was in 2006 by Jeff Dike. From that time, the
topic appears on and off in various discussions.

There are two main use cases for time namespaces:
1. change date and time inside a container;
2. adjust clocks for a container restored from a checkpoint.

“It seems like this might be one of the last major obstacles keeping
migration from being used in production systems, given that not all
containers and connections can be migrated as long as a time dependency
is capable of messing it up.” (by github.com/dav-ell)

The kernel provides access to several clocks: CLOCK_REALTIME,
CLOCK_MONOTONIC, CLOCK_BOOTTIME. Last two clocks are monotonous, but the
start points for them are not defined and are different for each
system. When a container is migrated from one node to another, all
clocks have to be restored into consistent states; in other words, they
have to continue running from the same points where they have been
dumped.

The main idea of this patch set is adding per-namespace offsets for
system clocks. When a process in a non-root time namespace requests
time of a clock, a namespace offset is added to the current value of
this clock and the sum is returned.

All offsets are placed on a separate page, this allows us to map it as
part of VVAR into user processes and use offsets from VDSO calls.

Now offsets are implemented for CLOCK_MONOTONIC and CLOCK_BOOTTIME
clocks.

v4 Changes:

* CLOCKE_NEWTIME is unshare()-only flag now (CLON_PIDFD took previous value)
* Addressing Jann Horn's feedback - we don't allow CLONE_THREAD or
  CLONE_VM together with CLONE_NEWTIME (thanks for spotting!)
* Addressing issues found by Thomas - removed unmaintainable CLOCK_TIMENS
  and introduced another call back into k_clock to get ktime instead
  of getting timespec and converting it (Patch 03)
* Renaming timens_offsets members to omit _offset postfix
  (thanks Cyrill for the suggestion)
* Suggestions, renaming and making code more maintainable from Thomas's
  feedback (thanks much!)
* Fixing out-of-bounds and other issues in procfs file (kudos Jann Horn)
* vdso_fault() can be called on a remote task by /proc/$pid/mem or
  process_vm_readv() - addressed by adding a slow-path with searching
  for owner's namespace (thanks for spotting this unobvious issue, Jann)
* Other nits by Jann Horn

v3: Major changes:

* Simplify two VDSO images by using static_branch() in vclock_gettime()
  Removes unwanted conflicts with generic VDSO movement patches and
  simplifies things by dropping too invasive linker magic.
  As an alternative to static_branch() we tested an attempt to introduce
  home-made dynamic patching called retcalls:
  https://github.com/0x7f454c46/linux/commit/4cc0180f6d65
  Considering some theoretical problems with toolchains, we decided to go
  with long well-tested nop-patching in static_branch(). Though, it was
  needed to provide backend for relative code.

* address Thomas' comments.
* add sanity checks for offsets:
  - the current clock time in a namespace has to be in [0, KTIME_MAX / 2).
    KTIME_MAX is divided by two here to be sure that the KTIME_MAX limit
    is still unreachable.
Link: https://lkml.org/lkml/2018/9/19/950
Link: https://lkml.org/lkml/2019/2/5/867

v2: There are two major changes:

* Two versions of the VDSO library to avoid a performance penalty for
  host tasks outside time namespace (as suggested by Andy and Thomas).

  As it has been discussed on timens RFC, adding a new conditional branch
  `if (inside_time_ns)` on VDSO for all processes is undesirable.
  It will add a penalty for everybody as branch predictor may mispredict
  the jump. Also there are instruction cache lines wasted on cmp/jmp.

  Those effects of introducing time namespace are very much unwanted
  having in mind how much work have been spent on micro-optimisation
  VDSO code.

  Addressing those problems, there are two versions of VDSO's .so:
  for host tasks (without any penalty) and for processes inside of time
  namespace with clk_to_ns() that subtracts offsets from host's time.


* Allow to set clock offsets for a namespace only before any processes
  appear in it.

  Now a time namespace looks similar to a pid namespace in a way how it is
  created: unshare(CLONE_NEWTIME) system call creates a new time namespace,
  but doesn't set it to the current process. Then all children of
  the process will be born in the new time namespace, or a process can
  use the setns() system call to join a namespace.

  This scheme allows to create a new time namespaces, set clock offsets
  and then populate the namespace with processes.

Our performance measurements show that the price of VDSO's clock_gettime()
in a child time namespace is about 8% with a hot CPU cache and about 90%
with a cold CPU cache. There is no performance regression for host
processes outside time namespace on those tests.

We wrote two small benchmarks. The first one gettime_perf.c calls
clock_gettime() in a loop for 3 seconds. It shows us performance with
a hot CPU cache (more clock_gettime() cycles - the better):

        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
cycles  | 139887013  | 139453003        | 139899785   | 128792458
diff (%)| 100        | 99.7             | 100         | 92

The second one gettime_perf_cold.c calls rdtsc, clock_gettime(), rdtsc
and shows a difference of second and first rdtsc. We call this binary in
a loop 1000 times, get 1000 values and calculate MODE for them.
It should show us performance with a cold CPU cache
(lesser tsc per cycle - the better):

        | before     | CONFIG_TIME_NS=n | host        | inside timens
--------|------------|------------------|-------------|-------------
tsc     | 6748       | 6718             | 6862        | 12682
diff (%)| 100        | 99.6             | 101.7       | 188

The numbers gathered on Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz.

Cc: Adrian Reber <adrian@lisas.de>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Pavel Emelyanov <xemul@virtuozzo.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: containers@lists.linux-foundation.org
Cc: criu@openvz.org
Cc: linux-api@vger.kernel.org
Cc: x86@kernel.org

v3: https://lkml.kernel.org/r/20190425161416.26600-1-dima@arista.com
v2: https://lore.kernel.org/lkml/20190206001107.16488-1-dima@arista.com/
RFC: https://lkml.kernel.org/r/20180919205037.9574-1-dima@arista.com/

Andrei Vagin (17):
  ns: Introduce Time Namespace
  timens: Add timens_offsets
  posix-clocks: add another call back to return clock time in ktime_t
  timens: Introduce CLOCK_MONOTONIC offsets
  timens: Introduce CLOCK_BOOTTIME offset
  timerfd/timens: Take into account ns clock offsets
  posix-timers/timens: Take into account clock offsets
  timens/kernel: Take into account timens clock offsets in
    clock_nanosleep
  x86/vdso: Add offsets page in vvar
  vdso: introduce timens_static_branch
  timens/fs/proc: Introduce /proc/pid/timens_offsets
  selftest/timens: Add a test for timerfd
  selftest/timens: Add a test for clock_nanosleep()
  selftest/timens: Add timer offsets test
  x86/vdso: Align VDSO functions by CPU L1 cache line
  selftests: Add a simple perf test for clock_gettime()
  selftest/timens: Check that a right vdso is mapped after fork and exec

Dmitry Safonov (11):
  timens: Shift /proc/uptime
  x86/vdso2c: Correct err messages on file opening
  x86/vdso2c: Convert iterator to unsigned
  x86/vdso/Makefile: Add vobjs32
  x86/vdso: Restrict splitting VVAR VMA
  x86/vdso: Rename vdso_image {.data=>.text}
  x86/vdso: Allocate timens vdso
  x86/vdso: Switch image on setns()/unshare()/clone()
  timens: Add align for timens_offsets
  selftest/timens: Add Time Namespace test for supported clocks
  selftest/timens: Add procfs selftest

 MAINTAINERS                                   |   3 +
 arch/Kconfig                                  |   5 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/Makefile                  |  16 +-
 arch/x86/entry/vdso/vclock_gettime.c          |  48 +++
 arch/x86/entry/vdso/vdso-layout.lds.S         |  10 +-
 arch/x86/entry/vdso/vdso2c.c                  |   7 +-
 arch/x86/entry/vdso/vdso2c.h                  |  24 +-
 arch/x86/entry/vdso/vma.c                     | 189 ++++++++-
 arch/x86/include/asm/jump_label.h             |  14 +
 arch/x86/include/asm/vdso.h                   |  14 +-
 fs/proc/base.c                                |  95 +++++
 fs/proc/namespaces.c                          |   4 +
 fs/proc/uptime.c                              |   3 +
 fs/timerfd.c                                  |   3 +
 include/linux/hrtimer.h                       |   2 +-
 include/linux/jump_label.h                    |   5 +
 include/linux/nsproxy.h                       |   2 +
 include/linux/posix-timers.h                  |   3 +
 include/linux/proc_ns.h                       |   2 +
 include/linux/time_namespace.h                | 115 ++++++
 include/linux/timens_offsets.h                |  18 +
 include/linux/user_namespace.h                |   1 +
 include/uapi/linux/sched.h                    |   5 +
 init/Kconfig                                  |   8 +
 kernel/Makefile                               |   1 +
 kernel/fork.c                                 |  29 +-
 kernel/nsproxy.c                              |  41 +-
 kernel/time/alarmtimer.c                      |  27 +-
 kernel/time/hrtimer.c                         |   8 +-
 kernel/time/posix-clock.c                     |   8 +-
 kernel/time/posix-cpu-timers.c                |  32 +-
 kernel/time/posix-stubs.c                     |  15 +-
 kernel/time/posix-timers.c                    |  87 +++--
 kernel/time/posix-timers.h                    |   7 +-
 kernel/time_namespace.c                       | 367 ++++++++++++++++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/timens/.gitignore     |   8 +
 tools/testing/selftests/timens/Makefile       |  12 +
 .../selftests/timens/clock_nanosleep.c        | 100 +++++
 tools/testing/selftests/timens/config         |   1 +
 tools/testing/selftests/timens/exec.c         |  91 +++++
 tools/testing/selftests/timens/gettime_perf.c |  74 ++++
 .../selftests/timens/gettime_perf_cold.c      |  63 +++
 tools/testing/selftests/timens/log.h          |  26 ++
 tools/testing/selftests/timens/procfs.c       | 142 +++++++
 tools/testing/selftests/timens/timens.c       | 188 +++++++++
 tools/testing/selftests/timens/timens.h       |  63 +++
 tools/testing/selftests/timens/timer.c        | 116 ++++++
 tools/testing/selftests/timens/timerfd.c      | 127 ++++++
 50 files changed, 2132 insertions(+), 99 deletions(-)
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 include/linux/timens_offsets.h
 create mode 100644 kernel/time_namespace.c
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/exec.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf_cold.c
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/procfs.c
 create mode 100644 tools/testing/selftests/timens/timens.c
 create mode 100644 tools/testing/selftests/timens/timens.h
 create mode 100644 tools/testing/selftests/timens/timer.c
 create mode 100644 tools/testing/selftests/timens/timerfd.c

-- 
2.22.0

