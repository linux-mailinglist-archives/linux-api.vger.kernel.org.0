Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8CCF865E
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 02:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKLBaC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 20:30:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33303 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfKLB1f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 20:27:35 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so1138842wmb.0
        for <linux-api@vger.kernel.org>; Mon, 11 Nov 2019 17:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYSYpT7ys1RoaZOVy87U6UlDUZbhEIEk7nnpOUE05xU=;
        b=Mi+Z4S6e55crR0dhghp9na8WVESww7cAFBn078wPn4bpRbgl9Cuck2eQO76uWfkBfK
         mN7zVVvG7qHOoQKlacb2hwAUqae6ThXifk3RjtTpXy9vnaDVfk58Cg78wetwfVP6YKdQ
         xfoVTOh8i6bI1zDBkF8kKHbXz8qlzuRgR8hC7rbncqxp6lTOFJjSTb6RMC3SEm59LtXx
         QGHRE+Y5lgDTqMNheL6Z6KfqVHZNzPPUzlBYVoYO/W60crBWc6hCAVWU/UACGoiY3why
         SvKTW5aWTWd+YXTVixlY4Ur4R+V+7X1bFxQFv2DcWNEcbXyhCt2W7HKbAeUA0oPteHiL
         6ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JYSYpT7ys1RoaZOVy87U6UlDUZbhEIEk7nnpOUE05xU=;
        b=Z4AwvqKNlt45+eZ9VKibB+FsomDxzM3JVWxppxhRnjHp8Ivl9fqIBf/sgzy/eYjkY8
         RViGwszLKJcvDhXgbzZ4zCntDF6huPjyMTRwIHcM+JoWlgN+T21bgLaslGqn9a1bVrGd
         7pWoCa1vHw9Z/CR3yZZ3EVp3IqBYh7yDon2FyK+jEOKvPfdESjq9YWCEMBdcXCkjRJhY
         49Uuj3rHbFc883Qi8ANWpa6pPxJ9aLcJNQAZkfeMKMnGLdz1HtUxCz80gEgmSZm7Ooj3
         +tBB7QdVBCLubDZ3EWQCEXItU7YHIilr4zcHNcQ5gZyYFNVtmhm3x/NCtxxzOU53bkfw
         D2Fg==
X-Gm-Message-State: APjAAAXKeZxBLMWQg/0vT/EoBExX1yJ5/Yk+XAcER41NvSudKgspI3Sk
        pKLTN/7XfnLCLtnCgje9PxfdsA==
X-Google-Smtp-Source: APXvYqwyGtXKvQkt36x/eFdlUCj6QUDrb3meylZWIDeR8tLeml9hqlXoPxx5ibJH2/egMaXOLH7q5g==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr1402822wmc.110.1573522051153;
        Mon, 11 Nov 2019 17:27:31 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:27:30 -0800 (PST)
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
Subject: [PATCHv8 00/34] kernel: Introduce Time Namespace
Date:   Tue, 12 Nov 2019 01:26:49 +0000
Message-Id: <20191112012724.250792-1-dima@arista.com>
X-Mailer: git-send-email 2.24.0
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

v7..v8 Changes:
* Fix compile-time errors:
  - on architectures without the support of time namespaces.
  - when CONFIG_POSIX_TIMERS isn't set.
* Added checks in selftests for CONFIG_POSIX_TIMERS.
* Inline do_hres and do_coarse.
  (And added Tested-by Vincenzo - thanks!)
* Make TIME_NS depends on GENERIC_VDSO_TIME_NS and set it per-arch.

[v1..v7 Changelogs is at the very bottom here]

Our performance measurements show that the price of VDSO's clock_gettime()
in a child time namespace is about 8% with a hot CPU cache and about 90%
with a cold CPU cache. There is no performance regression for host
processes outside time namespace on those tests.

We wrote two small benchmarks. The first one gettime_perf.c calls
clock_gettime() in a loop for 3 seconds. It shows us performance with
a hot CPU cache (more clock_gettime() cycles - the better):

The first table shows performance of clock_gettime() in the root time
namespace.

        | before    | TIME_NS=n | TIMENS=y
-------------------------------------------
        | 150363883 | 167076184 | 164979177
        | 150616056 | 167348942 | 165202727
        | 150679279 | 167235485 | 165230267
        | 150622312 | 167078735 | 165284077
        | 150706992 | 167301837 | 165372663
        | 150563707 | 167207900 | 165395728
-------------------------------------------
avg     | 150592038 | 167208180 | 165244106
diff %  | 100       | 111       | 109.7
-------------------------------------------
stdev % | 0.08      | 0.07      | 0.1

We can see the 11% performance improvement when CONFIG_TIME_NS is
disabled. This is achieved by adding the unlikely hint into
vdso_read_begin() and inlining do_hres() and do_coarse().

When CONFIG_TIME_NS is enabled, there is one more clobbered register in
the __vdso_clock_gettime function. And this fact explains the performance
difference between the two right columns.

The second table shows the performance of clock_gettime in a non-root
time namespace.

        | before     |  host      | inside timens
----------------------------------------------
        | 150363883 |  164979177 | 138133479
        | 150616056 |  165202727 | 139047394
        | 150679279 |  165230267 | 139284611
        | 150622312 |  165284077 | 139263753
        | 150706992 |  165372663 | 139175419
        | 150563707 |  165395728 | 139334291
----------------------------------------------
avg     | 150592038 |  165244106 | 139039824
diff %  | 100       |  109.7     | 92.3
----------------------------------------------
stdev % | 0.08      |  0.1       | 0.3

In a sub-namespace, the performance hit is 7-8%. The bigger difference
between root and non-root namespaces can be explained by the fact that
do_{hres,coarse}_timens are not inlined. Inlining these functions
improves performance in a sub-namespace, but there will be more
clobbered registers in __vdso_clock_gettime what will decrease the
performance in the root namespace.

The gettime_perf_cold test does 10K iterations. In each iteration, it
drops cpu caches for vdso pages, clflush() is used for this, then it runs
rdtsc(); clock_gettime; rdtsc(); and prints the number of tsc cycles.

Cold CPU cache (lesser tsc per cycle - the better):

           | before    | CONFIG_TIME_NS=n | host      | inside timens
--------------------------------------------------------------
tsc        | 476       | 480              | 487       | 531
stdev(tsc) | 0.6       | 1.3              | 4.3       | 5.7
diff (%)   | 100       | 100.9            | 102       | 112

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

v8 on github (if someone prefers `git pull` to `git am`):
https://github.com/0x7f454c46/linux/tree/timens-v8

v7: https://lkml.kernel.org/r/20191011012341.846266-1-dima@arista.com
v6: https://lkml.kernel.org/r/20190815163836.2927-1-dima@arista.com
v5: https://lkml.kernel.org/r/20190729215758.28405-1-dima@arista.com
v4: https://lkml.kernel.org/r/20190612192628.23797-1-dima@arista.com
v3: https://lkml.kernel.org/r/20190425161416.26600-1-dima@arista.com
v2: https://lore.kernel.org/lkml/20190206001107.16488-1-dima@arista.com/
RFC: https://lkml.kernel.org/r/20180919205037.9574-1-dima@arista.com/

v6..v7 Changes:
* Based on Andy & Thomas suggestions and the patches that Thomas kindely
  sent, reworked from two VDSO code images into trick with odd seq
  number for timens page that goes on the place of vvar page inside ns.
* Moved kernel/time_namespace.c => kernel/time/namespace.c
* Fixed bpf 5sec example
* Added selftests outputs
* By Thomas's suggestion simplified overflow check as ktime_sub(tim, offset)
* Other Thomas's review notes: stylistic, simplifications and
  clearifications (Thanks!)
* Split VDSO patches on generic/x86 parts
* Fixed kernel-doc warnings
* Added checks in selftests for capabilities
* Fixed bisectability issues

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

Andrei Vagin (23):
  lib/vdso: Add unlikely() hint into vdso_read_begin()
  lib/vdso: make do_hres and do_coarse as __always_inline
  ns: Introduce Time Namespace
  time: Add timens_offsets to be used for tasks in timens
  posix-clocks: Rename the clock_get() callback to clock_get_timespec()
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
  fs/proc: Introduce /proc/pid/timens_offsets
  selftests/timens: Add a test for timerfd
  selftests/timens: Add a test for clock_nanosleep()
  selftests/timens: Add timer offsets test
  selftests/timens: Add a simple perf test for clock_gettime()
  selftests/timens: Check for right timens offsets after fork and exec

Dmitry Safonov (10):
  fs/proc: Respect boottime inside time namespace for /proc/uptime
  x86/vdso: Restrict splitting VVAR VMA
  x86/vdso: Provide vdso_data offset on vvar_page
  x86/vdso: Add timens page
  time: Allocate per-timens vvar page
  x86/vdso: Handle faults on timens page
  x86/vdso: On timens page fault prefault also VVAR page
  x86/vdso: Zap vvar pages on switch a time namspace
  selftests/timens: Add Time Namespace test for supported clocks
  selftests/timens: Add procfs selftest

Thomas Gleixner (1):
  lib/vdso: Prepare for time namespace support

 MAINTAINERS                                   |   2 +
 arch/x86/Kconfig                              |   1 +
 arch/x86/entry/vdso/vdso-layout.lds.S         |  13 +-
 arch/x86/entry/vdso/vdso2c.c                  |   3 +
 arch/x86/entry/vdso/vma.c                     | 119 ++++-
 arch/x86/include/asm/vdso.h                   |   1 +
 arch/x86/include/asm/vdso/gettimeofday.h      |   9 +
 arch/x86/include/asm/vvar.h                   |  13 +-
 arch/x86/kernel/vmlinux.lds.S                 |   4 +-
 fs/proc/base.c                                |  95 ++++
 fs/proc/namespaces.c                          |   4 +
 fs/proc/uptime.c                              |   3 +
 fs/timerfd.c                                  |   3 +
 include/linux/hrtimer.h                       |   2 +-
 include/linux/nsproxy.h                       |   2 +
 include/linux/proc_ns.h                       |   3 +
 include/linux/time.h                          |   6 +
 include/linux/time_namespace.h                | 128 +++++
 include/linux/user_namespace.h                |   1 +
 include/uapi/linux/sched.h                    |   6 +
 include/vdso/datapage.h                       |  19 +-
 include/vdso/helpers.h                        |   2 +-
 init/Kconfig                                  |   8 +
 kernel/fork.c                                 |  16 +-
 kernel/nsproxy.c                              |  41 +-
 kernel/time/Makefile                          |   1 +
 kernel/time/alarmtimer.c                      |  73 ++-
 kernel/time/hrtimer.c                         |   8 +-
 kernel/time/namespace.c                       | 466 ++++++++++++++++++
 kernel/time/posix-clock.c                     |   8 +-
 kernel/time/posix-cpu-timers.c                |  32 +-
 kernel/time/posix-stubs.c                     |  15 +-
 kernel/time/posix-timers.c                    |  88 +++-
 kernel/time/posix-timers.h                    |   7 +-
 lib/vdso/Kconfig                              |   6 +
 lib/vdso/gettimeofday.c                       | 164 +++++-
 mm/mmap.c                                     |   2 +
 tools/perf/examples/bpf/5sec.c                |   6 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/timens/.gitignore     |   8 +
 tools/testing/selftests/timens/Makefile       |   7 +
 .../selftests/timens/clock_nanosleep.c        | 150 ++++++
 tools/testing/selftests/timens/config         |   1 +
 tools/testing/selftests/timens/exec.c         |  94 ++++
 tools/testing/selftests/timens/gettime_perf.c |  95 ++++
 tools/testing/selftests/timens/log.h          |  26 +
 tools/testing/selftests/timens/procfs.c       | 144 ++++++
 tools/testing/selftests/timens/timens.c       | 190 +++++++
 tools/testing/selftests/timens/timens.h       | 100 ++++
 tools/testing/selftests/timens/timer.c        | 123 +++++
 tools/testing/selftests/timens/timerfd.c      | 129 +++++
 51 files changed, 2337 insertions(+), 111 deletions(-)
 create mode 100644 include/linux/time_namespace.h
 create mode 100644 kernel/time/namespace.c
 create mode 100644 tools/testing/selftests/timens/.gitignore
 create mode 100644 tools/testing/selftests/timens/Makefile
 create mode 100644 tools/testing/selftests/timens/clock_nanosleep.c
 create mode 100644 tools/testing/selftests/timens/config
 create mode 100644 tools/testing/selftests/timens/exec.c
 create mode 100644 tools/testing/selftests/timens/gettime_perf.c
 create mode 100644 tools/testing/selftests/timens/log.h
 create mode 100644 tools/testing/selftests/timens/procfs.c
 create mode 100644 tools/testing/selftests/timens/timens.c
 create mode 100644 tools/testing/selftests/timens/timens.h
 create mode 100644 tools/testing/selftests/timens/timer.c
 create mode 100644 tools/testing/selftests/timens/timerfd.c

-- 
2.24.0

