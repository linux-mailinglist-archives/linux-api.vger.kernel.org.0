Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1610B05C
	for <lists+linux-api@lfdr.de>; Wed, 27 Nov 2019 14:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfK0Ngh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 27 Nov 2019 08:36:37 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:60579 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0Ngg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 27 Nov 2019 08:36:36 -0500
Received: from mail-qv1-f44.google.com ([209.85.219.44]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N8XDT-1hnqsd0HqL-014PO2; Wed, 27 Nov 2019 14:36:34 +0100
Received: by mail-qv1-f44.google.com with SMTP id cg2so8859181qvb.10;
        Wed, 27 Nov 2019 05:36:33 -0800 (PST)
X-Gm-Message-State: APjAAAW+nia/AwvYd2Y/3Yssx52PQ2/KxgKQ/bM3TplD08S8x53pcxde
        2q5RQIkLVwzGe9bC4+nZAkY4m1I9QD3ryS0jT5A=
X-Google-Smtp-Source: APXvYqwUVmlbP6tTKdotoXt7sMSzYysgUm0qCCKzhXxwlbPreRA7jD6rjDUldB+HlyZ0ZqvnSdV20QuuMxN452E7DOw=
X-Received: by 2002:ad4:404e:: with SMTP id r14mr4979402qvp.4.1574861792782;
 Wed, 27 Nov 2019 05:36:32 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Nov 2019 14:36:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
Message-ID: <CAK8P3a38Q_yhiyODpFd6ZqLv=QyKRmCm8FOMuSr4RPvGtWNPYw@mail.gmail.com>
Subject: [GIT PULL] y2038: syscall implementation cleanups
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1EoycpF3BIGb1K1Q8yE4cXEzhnIC04e20nvo3C1fPSWBmsRm3P+
 KlH27boSv5M6FHPvs3wuBCU9CyO2PCdE47HyzS/4bmr2zLYACVRMLupB+iLR1V/tpBI4yJ3
 xYlGGthMHFu3naJbs+AKB1/Cjz+Gc3tbGGYUgiRqDGOElQSlrSDc9KnRGZGJbnvDG3vglGO
 HNYIWGNMQrznMSCkjE0TA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LBeFqs2Jj1M=:upFvDLmnxGY6rp4ooRLK/F
 ydztrS4PlncUTuPl4W5KKZT4RtpRjZO641EcxmXyglsiegEg8JQpWpPQoUHF301PM5Owt0Zgv
 yJ1zy/i87tmBU4UUySvq1GWFnTezEnOM+Hr6FwwrK+RNzebmTJkkmTF4typvwW6pSP3qp4Hr5
 eYMiqqUWLNOSCtBq0K6ahIwMh5rpO9UQ3BXCLbLf3phEpLFAeH3oBTiFQMqABGCNVvoDbwiTj
 W+BA34uamtEsNWmzsRy6vtgejLM399xiyZ3Jk+Wf4so7BoowleEjxOAQp8+oCPo/kxADNV5Q1
 mNajOkq+hy5gALKYCq8U3iG0RkMIgQH4fOJXsvVzczxTw0QjRplJ7XoiuqrVmW32vaqqsyH47
 idXAjHbP2sGmb9sli4B4cIMtphrN9/S32xG5btS+Y8Uq7TwnbPzsnchS67jTWhg1TwVYSHKGN
 nT/1sdbJLzTz3k3wFYBzKIZxP5z//kyWZMGaEeoL3ELF0C92ESn+AuxMPROVxD1FdnQLFCWmB
 liSx8RIUzP/g0kk8AFpc+mIQRhS2YXO4USrk1XsV7pjzI6Dta8YzHlaIC486qqov4dJf7+joq
 TKBXJz8Q5MU12XriXoJAp/fhreUpUVs8oTSOYx/BVJg3+mvxSmj1O7Wyp4ndA5ZrTJsv7nBeV
 IJsv3R0E1jxsNjKyNTUor7fx91+mVSd+3SUmAxBxzhpHXfcGUNDkC4D6tnGttJD1h5Pekrbb4
 HIF5gn/v2/9WTDuWaNjseb1+POZC0bpWmCdhMwmxC2uG5yG2cUBQJmI/QM/7tmriOLzJDmvec
 DPfYNCVYu5RbREJH9OfzfoOIGTNgbXb+ozny0T1yX1qGVqBnjV60y3JpWBLCgDnxN/SDEPHQp
 ONwmB40bvLwXbovW6tyw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-cleanups-5.5

for you to fetch changes up to b111df8447acdeb4b9220f99d5d4b28f83eb56ad:

  y2038: alarm: fix half-second cut-off (2019-11-25 21:52:35 +0100)

----------------------------------------------------------------
y2038: syscall implementation cleanups

This is a series of cleanups for the y2038 work, mostly intended
for namespace cleaning: the kernel defines the traditional
time_t, timeval and timespec types that often lead to y2038-unsafe
code. Even though the unsafe usage is mostly gone from the kernel,
having the types and associated functions around means that we
can still grow new users, and that we may be missing conversions
to safe types that actually matter.

There are still a number of driver specific patches needed to
get the last users of these types removed, those have been
submitted to the respective maintainers.

Link: https://lore.kernel.org/lkml/20191108210236.1296047-1-arnd@arndb.de/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (26):
      y2038: remove CONFIG_64BIT_TIME
      y2038: add __kernel_old_timespec and __kernel_old_time_t
      y2038: vdso: change timeval to __kernel_old_timeval
      y2038: vdso: change timespec to __kernel_old_timespec
      y2038: vdso: change time_t to __kernel_old_time_t
      y2038: vdso: nds32: open-code timespec_add_ns()
      y2038: vdso: powerpc: avoid timespec references
      y2038: ipc: remove __kernel_time_t reference from headers
      y2038: stat: avoid 'time_t' in 'struct stat'
      y2038: uapi: change __kernel_time_t to __kernel_old_time_t
      y2038: rusage: use __kernel_old_timeval
      y2038: syscalls: change remaining timeval to __kernel_old_timeval
      y2038: socket: remove timespec reference in timestamping
      y2038: socket: use __kernel_old_timespec instead of timespec
      y2038: make ns_to_compat_timeval use __kernel_old_timeval
      y2038: elfcore: Use __kernel_old_timeval for process times
      y2038: timerfd: Use timespec64 internally
      y2038: time: avoid timespec usage in settimeofday()
      y2038: itimer: compat handling to itimer.c
      y2038: use compat_{get,set}_itimer on alpha
      y2038: move itimer reset into itimer.c
      y2038: itimer: change implementation to timespec64
      y2038: allow disabling time32 system calls
      y2038: fix typo in powerpc vdso "LOPART"
      y2038: ipc: fix x32 ABI breakage
      y2038: alarm: fix half-second cut-off

 arch/Kconfig                              |  11 +-
 arch/alpha/kernel/osf_sys.c               |  67 +----------
 arch/alpha/kernel/syscalls/syscall.tbl    |   4 +-
 arch/ia64/kernel/asm-offsets.c            |   2 +-
 arch/mips/include/uapi/asm/msgbuf.h       |   6 +-
 arch/mips/include/uapi/asm/sembuf.h       |   4 +-
 arch/mips/include/uapi/asm/shmbuf.h       |   6 +-
 arch/mips/include/uapi/asm/stat.h         |  16 +--
 arch/mips/kernel/binfmt_elfn32.c          |   4 +-
 arch/mips/kernel/binfmt_elfo32.c          |   4 +-
 arch/nds32/kernel/vdso/gettimeofday.c     |  61 +++++-----
 arch/parisc/include/uapi/asm/msgbuf.h     |   6 +-
 arch/parisc/include/uapi/asm/sembuf.h     |   4 +-
 arch/parisc/include/uapi/asm/shmbuf.h     |   6 +-
 arch/powerpc/include/asm/asm-prototypes.h |   3 +-
 arch/powerpc/include/asm/vdso_datapage.h  |   6 +-
 arch/powerpc/include/uapi/asm/msgbuf.h    |   6 +-
 arch/powerpc/include/uapi/asm/sembuf.h    |   4 +-
 arch/powerpc/include/uapi/asm/shmbuf.h    |   6 +-
 arch/powerpc/include/uapi/asm/stat.h      |   2 +-
 arch/powerpc/kernel/asm-offsets.c         |  18 ++-
 arch/powerpc/kernel/syscalls.c            |   4 +-
 arch/powerpc/kernel/time.c                |   5 +-
 arch/powerpc/kernel/vdso32/gettimeofday.S |   6 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S |   8 +-
 arch/sparc/include/uapi/asm/msgbuf.h      |   6 +-
 arch/sparc/include/uapi/asm/sembuf.h      |   4 +-
 arch/sparc/include/uapi/asm/shmbuf.h      |   6 +-
 arch/sparc/include/uapi/asm/stat.h        |  24 ++--
 arch/sparc/vdso/vclock_gettime.c          |  36 +++---
 arch/x86/entry/vdso/vclock_gettime.c      |   6 +-
 arch/x86/entry/vsyscall/vsyscall_64.c     |   4 +-
 arch/x86/include/uapi/asm/msgbuf.h        |   6 +-
 arch/x86/include/uapi/asm/sembuf.h        |   4 +-
 arch/x86/include/uapi/asm/shmbuf.h        |   6 +-
 arch/x86/um/vdso/um_vdso.c                |  12 +-
 fs/aio.c                                  |   2 +-
 fs/binfmt_elf.c                           |  12 +-
 fs/binfmt_elf_fdpic.c                     |  12 +-
 fs/compat_binfmt_elf.c                    |   4 +-
 fs/select.c                               |  10 +-
 fs/timerfd.c                              |  14 +--
 fs/utimes.c                               |   8 +-
 include/linux/compat.h                    |  19 +--
 include/linux/skbuff.h                    |   7 +-
 include/linux/syscalls.h                  |  16 +--
 include/linux/time.h                      |   9 +-
 include/linux/time32.h                    |   2 +-
 include/linux/types.h                     |   2 +-
 include/trace/events/timer.h              |  16 +--
 include/uapi/asm-generic/msgbuf.h         |  12 +-
 include/uapi/asm-generic/posix_types.h    |   1 +
 include/uapi/asm-generic/sembuf.h         |   7 +-
 include/uapi/asm-generic/shmbuf.h         |  12 +-
 include/uapi/linux/cyclades.h             |   6 +-
 include/uapi/linux/elfcore.h              |   8 +-
 include/uapi/linux/errqueue.h             |   7 ++
 include/uapi/linux/msg.h                  |   6 +-
 include/uapi/linux/ppp_defs.h             |   4 +-
 include/uapi/linux/resource.h             |   4 +-
 include/uapi/linux/sem.h                  |   4 +-
 include/uapi/linux/shm.h                  |   6 +-
 include/uapi/linux/time.h                 |   6 +-
 include/uapi/linux/time_types.h           |   5 +
 include/uapi/linux/utime.h                |   4 +-
 ipc/syscall.c                             |   2 +-
 kernel/compat.c                           |  24 ----
 kernel/power/power.h                      |   2 +-
 kernel/sys.c                              |   4 +-
 kernel/sys_ni.c                           |  23 ++++
 kernel/time/hrtimer.c                     |   2 +-
 kernel/time/itimer.c                      | 189 +++++++++++++++++++++---------
 kernel/time/time.c                        |  32 +++--
 lib/vdso/gettimeofday.c                   |   4 +-
 net/compat.c                              |   2 +-
 net/core/scm.c                            |   6 +-
 net/ipv4/tcp.c                            |  28 +++--
 net/socket.c                              |   4 +-
 security/selinux/hooks.c                  |  10 +-
 79 files changed, 472 insertions(+), 468 deletions(-)
