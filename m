Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3528F0BA
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfHOQil (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:38:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37912 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbfHOQik (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:38:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id m125so1773256wmm.3
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fssuGudxqPedOcs3pdfTW+Jmy3XNXcYZlllCnLZ0eg4=;
        b=UzmIROz4RTdq8dLLbk5w/wmDu7fJ8ieGUWzS41G27je6KfslmU/YBGGyoCCr4RQ3Nk
         Sv5R3+Z9ntabadXlrwTSPGNiDTtoP79KbMoTkpHLhBrK1xl8aJuFuiLicWd0tkYltrYG
         dOIu20PWQ7QHxUv6KHxEwTNrCOwehk/HGFjYo2nw4f6FP5iFe8uW6P/mqhDmd3nlahQ8
         xHT7PS2yFdIlLumXIPKzPl0pE9SesaJ92Px+94DqNmbQCxhx9bBRSM3nLb/awJaKWvCE
         fWZcCbVSW/QYlwI+LvEhyRoEb80hwcLhtcfjnn5uyFXlusRSSfszVm16arfaIV/WSe3w
         q92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fssuGudxqPedOcs3pdfTW+Jmy3XNXcYZlllCnLZ0eg4=;
        b=GvBY8LC8k1VRDVpHuXaF4coDmyQPpbrDKQnUXB+NUA5vmH4BUUlasHXlfgyaIZLlQt
         ODjRpF0fehM0Ciru8Yd2D5QGgdy6PlfgMK2MtFg4EETIMwVPJ+r3dikZLekAsNCumKZB
         rAD/6A6VNvNtyZ9fEv9V6Eh4l+UOIlde1MUFBt+gtjk2ve4Pl5aInmSOPrCGpRgdQ2o2
         H4g+RUTQzBZq48j0s6/j5KWujsZZqu3zotZjT5RuIxj4Ld0spnTgEknZvYR9TWT7nuEZ
         +81peLdO0yAL3X3I588tupSd3kngkCpaXritiL3HQgPPn04T1N3zzpRUfhIyLYhUeUjm
         KaiA==
X-Gm-Message-State: APjAAAVE8TP/dBj/zBj0J2bjxpQNiY1ROCr/GvGm3OOgYHqgJ8EitYwA
        BLz1wIpRdGLZNdUZ+hYwyRXpIg==
X-Google-Smtp-Source: APXvYqxjS9b8SSWLzaR6C+Snf2W51qVCF+kjkRBYarj4cNxay6jmom9UpdkL4k6kXL5aZ++jQpFZ4w==
X-Received: by 2002:a1c:1f4e:: with SMTP id f75mr3480161wmf.137.1565887118371;
        Thu, 15 Aug 2019 09:38:38 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:38:37 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
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
Subject: [PATCHv6 00/36] kernel: Introduce Time Namespace
Date:   Thu, 15 Aug 2019 17:38:00 +0100
Message-Id: <20190815163836.2927-1-dima@arista.com>
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

v5..v6 Changes:
* Used current_is_single_threaded() instead of thread_group_empty()
  (Thanks for the review, Andy).
* Changed errno code when there are threads on timens joining to
  something more grepabble (EUSERS).
* posix_get_timespec() should have been posix_get_monotonic_timespec()
  (Thanks, Thomas)
* timens_add_monotonic() & timens_add_boottime() were relocated to
  the patch that introduces (struct timens_offsets) (Thomas)
* Avoid breaking alarmtimer for ALARM_REALTIME (Thanks, Thomas)
* Nested namespace inherits father's offsets now
  (Andrei while working on CRIU side for time namespace)
* A minor conflict with commit dbc1625fc9de ("hrtimer: Consolidate
  hrtimer_init() + hrtimer_init_sleeper() calls") in linux-next
  [Sending against next-20190814]

[v1..v5 Changelogs is at the very bottom here]

Our performance measurements show that the price of VDSO's clock_gettime()
in a child time namespace is about 8% with a hot CPU cache and about 90%
with a cold CPU cache. There is no performance regression for host
processes outside time namespace on those tests.

We wrote two small benchmarks. The first one gettime_perf.c calls
clock_gettime() in a loop for 3 seconds. It shows us performance with
a hot CPU cache (more clock_gettime() cycles - the better):

        | before    | CONFIG_TIME_NS=n | host      | inside timens
--------------------------------------------------------------
        | 161822960 | 161147792        | 160187142 | 150584782
        | 161891728 | 161489804        | 159914989 | 150417019
        | 161891770 | 161098734        | 160123179 | 150601277
        | 161687686 | 161114738        | 159874249 | 150243276
        | 161247151 | 161411636        | 159096392 | 149637536
--------------------------------------------------------------
avg     | 161708259 | 161252540        | 159839190 | 150296778
diff %  | 100       | 99.7             | 98.8      | 92.9
-------------------------------------------------------------
stdev % | 0.2       | 0.1              | 0.1       | 0.2

The gettime_perf_cold test does 10K iterations. In each iteration, it
drops cpu caches for vdso pages, clflush is used for this, then it runs
rdtsc(); clock_gettime; rdtsc(); and prints the number of tsc cycles.

(lesser tsc per cycle - the better):

           | before    | CONFIG_TIME_NS=n | host      | inside timens
--------------------------------------------------------------
tsc        | 434       | 433              | 437       | 477
stdev(tsc) | 5         | 5                | 5         | 3
diff (%)   | 1         | 1                | 100.1     | 109

vdsotest results: https://gist.github.com/avagin/f290afb8b721ae0522a561d585f34de0

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

v6 on github (if someone prefers `git pull` or `git log`):
https://github.com/0x7f454c46/linux/tree/timens-v6

v5: https://lkml.kernel.org/r/20190729215758.28405-1-dima@arista.com
v4: https://lkml.kernel.org/r/20190612192628.23797-1-dima@arista.com
v3: https://lkml.kernel.org/r/20190425161416.26600-1-dima@arista.com
v2: https://lore.kernel.org/lkml/20190206001107.16488-1-dima@arista.com/
RFC: https://lkml.kernel.org/r/20180919205037.9574-1-dima@arista.com/

v4..v5 Changes:
* Rebased over generic vdso (already in master)
* Addressing review comments by Thomas Gleixner
  (thanks much for your time and patience):
  - Dropping `timens` prefix from subjects (it's not a subsystem)
  - Keeping commit messages in a neutral technical form
  - Splitting unreasonably large patches
  - Document code with missing comments
  - Dropped dead code that's not compiled with !CONFIG_TIME_NS
* Updated performance results [here, at the bottom]
* Split vdso jump tables patch
* Allow unshare() with many threads: it's safe until fork()/clone(),
  where we check for CLONE_THREADS
* Add missed check in setns() for CLONE_VM | CLONE_THREADS
* Fixed compilation with !CONFIG_UTS_NS
* Add a plan in selftests (prevents new warning "Planned tests != run tests")
* Set jump table section address & size to (-1UL) just in case if there
  is no such section while running vdso2c (and WARN() on boot in such
  case)

v3..v4 Changes:

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

v2..v3: Major changes:

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

v1..v2: There are two major changes:

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

Andrei Vagin (24):
  ns: Introduce Time Namespace
  timens: Add timens_offsets
  posix-clocks: Rename the clock_get() into clock_get_timespec()
  posix-clocks: Rename .clock_get_timespec() callbacks accordingly
  alarmtimer: Rename gettime() callback to get_ktime()
  alarmtimer: Provide get_timespec() callback
  posix-clocks: Introduce clock_get_ktime() callback
  posix-timers: Use clock_get_ktime() in common_timer_get()
  posix-clocks: Wire up clock_gettime() with timens offsets
  kernel: Add do_timens_ktime_to_host() helper
  timerfd: Make timerfd_settime() time namespace aware
  posix-timers: Make timer_settime() time namespace aware
  alarmtimer: Make nanosleep time namespace aware
  hrtimers: Prepare hrtimer_nanosleep() for time namespaces
  posix-timers: Make clock_nanosleep() time namespace aware
  x86/vdso: Add offsets page in vvar
  vdso: Introduce vdso_static_branch_unlikely()
  x86/vdso: Enable static branches for the timens vdso
  fs/proc: Introduce /proc/pid/timens_offsets
  selftest/timens: Add a test for timerfd
  selftest/timens: Add a test for clock_nanosleep()
  selftest/timens: Add timer offsets test
  selftests/timens: Add a simple perf test for clock_gettime()
  selftest/timens: Check that a right vdso is mapped after fork and exec

Dmitry Safonov (12):
  fd/proc: Respect boottime inside time namespace for /proc/uptime
  x86/vdso2c: Correct err messages on file opening
  x86/vdso2c: Convert iterator to unsigned
  x86/vdso/Makefile: Add vobjs32
  x86/vdso: Restrict splitting VVAR VMA
  x86/vdso: Rename vdso_image {.data=>.text}
  x86/vdso: Allocate timens vdso
  x86/vdso: Switch image on setns()/clone()
  x86/vdso2c: Process jump tables
  posix-clocks: Add align for timens_offsets
  selftest/timens: Add Time Namespace test for supported clocks
  selftest/timens: Add procfs selftest

 MAINTAINERS                                   |   3 +
 arch/Kconfig                                  |   5 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/Makefile                  |  15 +-
 arch/x86/entry/vdso/vdso-layout.lds.S         |  10 +-
 arch/x86/entry/vdso/vdso2c.c                  |   7 +-
 arch/x86/entry/vdso/vdso2c.h                  |  22 +-
 arch/x86/entry/vdso/vma.c                     | 177 +++++++-
 arch/x86/include/asm/jump_label.h             |  14 +
 arch/x86/include/asm/vdso.h                   |  14 +-
 arch/x86/kernel/jump_label.c                  |  14 +
 fs/proc/base.c                                |  95 +++++
 fs/proc/namespaces.c                          |   4 +
 fs/proc/uptime.c                              |   3 +
 fs/timerfd.c                                  |   3 +
 include/linux/hrtimer.h                       |   2 +-
 include/linux/jump_label.h                    |   8 +
 include/linux/nsproxy.h                       |   2 +
 include/linux/posix-timers.h                  |   3 +
 include/linux/proc_ns.h                       |   3 +
 include/linux/time_namespace.h                | 114 ++++++
 include/linux/timens_offsets.h                |  18 +
 include/linux/user_namespace.h                |   1 +
 include/uapi/linux/sched.h                    |   6 +
 init/Kconfig                                  |   9 +
 kernel/Makefile                               |   1 +
 kernel/fork.c                                 |  16 +-
 kernel/nsproxy.c                              |  41 +-
 kernel/time/alarmtimer.c                      |  68 ++-
 kernel/time/hrtimer.c                         |   8 +-
 kernel/time/posix-clock.c                     |   8 +-
 kernel/time/posix-cpu-timers.c                |  32 +-
 kernel/time/posix-stubs.c                     |  15 +-
 kernel/time/posix-timers.c                    |  88 ++--
 kernel/time/posix-timers.h                    |   7 +-
 kernel/time_namespace.c                       | 387 ++++++++++++++++++
 lib/vdso/gettimeofday.c                       |  53 +++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/timens/.gitignore     |   8 +
 tools/testing/selftests/timens/Makefile       |  12 +
 .../selftests/timens/clock_nanosleep.c        | 102 +++++
 tools/testing/selftests/timens/config         |   1 +
 tools/testing/selftests/timens/exec.c         |  93 +++++
 tools/testing/selftests/timens/gettime_perf.c | 101 +++++
 .../selftests/timens/gettime_perf_cold.c      | 160 ++++++++
 tools/testing/selftests/timens/log.h          |  26 ++
 tools/testing/selftests/timens/procfs.c       | 144 +++++++
 tools/testing/selftests/timens/timens.c       | 185 +++++++++
 tools/testing/selftests/timens/timens.h       |  63 +++
 tools/testing/selftests/timens/timer.c        | 118 ++++++
 tools/testing/selftests/timens/timerfd.c      | 129 ++++++
 51 files changed, 2305 insertions(+), 115 deletions(-)
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

