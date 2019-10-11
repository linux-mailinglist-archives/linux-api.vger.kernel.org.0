Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD30D36E2
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfJKBXs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:23:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34259 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfJKBXs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:23:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id j11so9979216wrp.1
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zxpl33RW3Wom4lUiytphtHFi0rPwSvfwF9l8JMmQQg=;
        b=ea4Cao3rzK3ZzqYe68FAzB2sqhqOMyV3WCsWnNj33Ym78pk73Jy+mRR3X+fkF7h2Ut
         dVfGR4dVp2/04qlz1m+kbVod2CpDlQsG1dcwwxKbVO/pTj85pIFDkYRurE+KzhBmzEER
         En8X7COa9+gJr30QT4rMqphm+Zb92DBwjuG/YdDFzIxr15gpE/kuMX7N3b1rQHtbHOc8
         FL+B562K48CBuvsEnsFjYYmQiCToeuURIVzf9GY/1S/T34rlVUiaDlKpQkrUI5tLcyLq
         m4A9m6l8ivl5WAjMGFcj4Rq5kIZFN9bIVHsh7byODRrXDXIH96fB9oJIzG/wO0C/XwRQ
         Ovcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7zxpl33RW3Wom4lUiytphtHFi0rPwSvfwF9l8JMmQQg=;
        b=lCXdCBkYhoo6nwH7c0iDJMY6nWvKqo7yKkWTUyfOlGMqIShkKUkRoHzavWFuZ90CWW
         +KzMxPdwTt6gTw8egWp87NJMUeH0gLCk+Jg4Lqsji3GPsMKpbCJjC0rtcy6apmXSzACz
         2LsB44EoSCzraV3ZYWePGz1opNK8X6D3zsIb5Sc5oJUSkhTO7oHBehGQZR1mDKJujGz9
         30qpxSzS7Yme4u/QV/md4V8xOcMH9ktz/Mf8n1+xjgAWrwAL2ypDPh/KCI2ZaYFOH+If
         i6T25e/33D4e2hIarjwoD5chq0oeqRpSpqSrN8E4Xwom0ixCVs/oBWOuFvMMo4zlo1G6
         ICng==
X-Gm-Message-State: APjAAAWPwuhtS0EAv3scd0PlVpu3BfDrZ8CgUOcWLiU5ID3MmlFyS+V9
        Zg9orq3GrqBaUuyZpTdbMcb7SA==
X-Google-Smtp-Source: APXvYqyt4/t69UjXrIgmmPorscC1dlOLqKrPl9Ma+61ugvDDFj99VuhuetAzs1gB42E9SOz0h9ewGQ==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr10336038wrc.251.1570757024623;
        Thu, 10 Oct 2019 18:23:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:23:44 -0700 (PDT)
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
Subject: [PATCHv7 00/33] kernel: Introduce Time Namespace
Date:   Fri, 11 Oct 2019 02:23:08 +0100
Message-Id: <20191011012341.846266-1-dima@arista.com>
X-Mailer: git-send-email 2.23.0
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
        | 153242367 | 153567617        | 150933203 | 139310914
        | 153324800 | 153115132        | 150919828 | 139299761
        | 153125401 | 153686868        | 150930471 | 139273917
        | 153399355 | 153694866        | 151083410 | 139286081
        | 153489417 | 153739716        | 150997262 | 139146403
        | 153494270 | 153724332        | 150035651 | 138835612
-----------------------------------------------------------
avg     | 153345935 | 153588088        | 150816637 | 139192114
diff %  | 100       | 100.1            | 98.3      | 90.7
-------------------------------------------------------------
stdev % | 0.09      | 0.15              |0.25      | 0.13


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

v7 on github (if someone prefers `git pull` to `git am`):
https://github.com/0x7f454c46/linux/tree/timens-v7

v6: https://lkml.kernel.org/r/20190815163836.2927-1-dima@arista.com
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

Andrei Vagin (22):
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
  lib/vdso: Add unlikely() hint into vdso_read_begin()
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
 include/linux/posix-timers.h                  |   3 +
 include/linux/proc_ns.h                       |   3 +
 include/linux/time.h                          |   6 +
 include/linux/time_namespace.h                | 119 +++++
 include/linux/user_namespace.h                |   1 +
 include/uapi/linux/sched.h                    |   6 +
 include/vdso/datapage.h                       |  19 +-
 include/vdso/helpers.h                        |   2 +-
 init/Kconfig                                  |   7 +
 kernel/fork.c                                 |  16 +-
 kernel/nsproxy.c                              |  41 +-
 kernel/time/Makefile                          |   1 +
 kernel/time/alarmtimer.c                      |  68 ++-
 kernel/time/hrtimer.c                         |   8 +-
 kernel/time/namespace.c                       | 466 ++++++++++++++++++
 kernel/time/posix-clock.c                     |   8 +-
 kernel/time/posix-cpu-timers.c                |  32 +-
 kernel/time/posix-stubs.c                     |  15 +-
 kernel/time/posix-timers.c                    |  88 +++-
 kernel/time/posix-timers.h                    |   7 +-
 lib/vdso/Kconfig                              |   6 +
 lib/vdso/gettimeofday.c                       | 128 ++++-
 mm/mmap.c                                     |   2 +
 tools/perf/examples/bpf/5sec.c                |   6 +-
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/timens/.gitignore     |   8 +
 tools/testing/selftests/timens/Makefile       |   7 +
 .../selftests/timens/clock_nanosleep.c        | 143 ++++++
 tools/testing/selftests/timens/config         |   1 +
 tools/testing/selftests/timens/exec.c         |  94 ++++
 tools/testing/selftests/timens/gettime_perf.c |  91 ++++
 tools/testing/selftests/timens/log.h          |  26 +
 tools/testing/selftests/timens/procfs.c       | 144 ++++++
 tools/testing/selftests/timens/timens.c       | 185 +++++++
 tools/testing/selftests/timens/timens.h       |  73 +++
 tools/testing/selftests/timens/timer.c        | 118 +++++
 tools/testing/selftests/timens/timerfd.c      | 129 +++++
 52 files changed, 2246 insertions(+), 106 deletions(-)
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
2.23.0

