Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82BFB79BAA
	for <lists+linux-api@lfdr.de>; Mon, 29 Jul 2019 23:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfG2V6E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39641 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbfG2V6E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so44434800wmc.4
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLK9oMfbasIpMpwpIJOB7RGP16SH8kQ3V/EEqtgGXjs=;
        b=X7ZD4YIBzcoVosqzT5iBkTOeqsuZm/rxLyFLnrsGmbvTAZWhA/8IGVOZnTHU19Jh8U
         cpSC9Jngdlk6Icmc0tMYEAqyaO5jYUyhDaA43UkqhEyLCaAOKl/70hNEjg40menuOw+0
         gnDD/dSBMhTgbkcgz91bS+SNWki4KsjQ7X6jy7Sxe1nvlwMNoSgPGGAisMJZj5qhCbZy
         1waTAdt32Yksu33t4wC6W4Mc0DwhfzNGOxD2Zv8OF6cHnGfltgbCErIi4kvxlLJttrif
         h0jsLEt2I7nh7tdbVcC5NpUr2obeJowLGMN7yFUWrpfmrm73yRns+L0dm6eZp3JD7spP
         OW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLK9oMfbasIpMpwpIJOB7RGP16SH8kQ3V/EEqtgGXjs=;
        b=n+/XSCKS3j3yLHZ3HlzyPOULROB2jhLy3sMPB/UCwG5gOR0uxampHy6fvh7vCG/epv
         fe2ujjx5ufv2V3b0Jn5X/oKtYmUUMMtvQmqLtukI3DdrxKcRZ9+nb1okcGJckkRjnirA
         vb5aF9xRQ/P1cMboYo+UbP7hRqnLWqreBDPNVwdACY/kCOI8c2zEIu/nZ1MaCA/j89yd
         86jQN2ihBHjxHN+To7Y7VVU1BwElMCj5W8FqcjNnyuCSxw8OMF8mB4vUgJNYUvWQUZrJ
         RWzouyvtBA7esZKX1C1Bwhuy9sxxYkPkaqFWCku0Jn6dDI0llE3Rz+4/OnmC7uyAkUrb
         T0iw==
X-Gm-Message-State: APjAAAWU07Q1qeHidp1qq9/IvSk4dUE6yRtMQJNCUhBI+Xl7swVlg/jm
        fXkTtja1G5wnpXOdwVYPZOsi5obrjj7cY+auDEHZ1NZFD4s3uM+g+rMVWZ47q3lyxcusoyx7/pZ
        hxzwPapqWXsw+0HjkvQBJJuoghjEpss3zDnERS5ZtKIJRu8wxfnZbuyMjphMFWiTl+rNMapT2b3
        vUQSeRmmzBl+c2zNBZ8A2Wvl8Xhw==
X-Google-Smtp-Source: APXvYqwrkYlRNEYm6+OuQPuRR0WSYwE98Nuwt5N1B4SpdwHjuIw5pG9T8harxJbDuIP6BK+mr6hksw==
X-Received: by 2002:a1c:6c08:: with SMTP id h8mr11904508wmc.62.1564437479978;
        Mon, 29 Jul 2019 14:57:59 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.57.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:57:59 -0700 (PDT)
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
Subject: [PATCHv5 00/37] kernel: Introduce Time Namespace
Date:   Mon, 29 Jul 2019 22:56:42 +0100
Message-Id: <20190729215758.28405-1-dima@arista.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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

[v1..v4 Changelog is at the very bottom here]

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

v5 on github (if someone prefers `git pull` or `git log`):
https://github.com/0x7f454c46/linux/tree/timens-v5

v4: https://lkml.kernel.org/r/20190612192628.23797-1-dima@arista.com
v3: https://lkml.kernel.org/r/20190425161416.26600-1-dima@arista.com
v2: https://lore.kernel.org/lkml/20190206001107.16488-1-dima@arista.com/
RFC: https://lkml.kernel.org/r/20180919205037.9574-1-dima@arista.com/

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


Andrei Vagin (25):
  ns: Introduce Time Namespace
  timens: Add timens_offsets
  posix-clocks: Rename the clock_get() into clock_get_timespec()
  posix-clocks: Rename *_clock_get() functions into
    *_clock_get_timespec()
  alarmtimer: Rename gettime() callback to get_ktime()
  alarmtimer: Provide get_timespec() callback
  posix-clocks: Introduce clock_get_ktime() callback
  posix-timers: Use clock_get_ktime() in common_timer_get()
  posix-clocks: Introduce CLOCK_MONOTONIC time namespace offsets
  posix-clocks: Introduce CLOCK_BOOTTIME time namespace offset
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
 kernel/time/alarmtimer.c                      |  68 +++-
 kernel/time/hrtimer.c                         |   8 +-
 kernel/time/posix-clock.c                     |   8 +-
 kernel/time/posix-cpu-timers.c                |  32 +-
 kernel/time/posix-stubs.c                     |  15 +-
 kernel/time/posix-timers.c                    |  89 ++--
 kernel/time/posix-timers.h                    |   7 +-
 kernel/time_namespace.c                       | 385 ++++++++++++++++++
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
 51 files changed, 2304 insertions(+), 115 deletions(-)
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

