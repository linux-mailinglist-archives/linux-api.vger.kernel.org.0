Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B776ED6A7B
	for <lists+linux-api@lfdr.de>; Mon, 14 Oct 2019 21:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfJNT6u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Oct 2019 15:58:50 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33671 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730912AbfJNT6u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Oct 2019 15:58:50 -0400
Received: by mail-vk1-f195.google.com with SMTP id s21so3810208vkm.0;
        Mon, 14 Oct 2019 12:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uKerVrTr0E3NNBDBoJ7JKp0Tg8uIHC/YwpSH0yWT5xs=;
        b=mCvsiqw82+Hos3i3oWZSSUiDfc6Telgd+kq66dil7OYS7vZX6IUeRhyTK4ym223zc8
         PZ8KxYTwV+z9K0D/A5n4Wl5tejseC5GD8VUBl5sep/qmNTlkr3wV88tYfeZp8hBPY1W/
         pBItm90ifPP8zMruAFfO69RzYF+wD0XzBw8UUv48gHpQzITIxBNZ46XgbUGa4KsDdOO5
         YLSncTAWOe7dtmo3IXnjKq08SNDWDfG0z4mbYALfJ7ftz1XFoI3DuTExtUQFGS7RunvR
         VY85UdFo8izqIY+mMxB01GR+zgW6oLOitpASVdFqH54MNBioaBl1KnLw6BZb9NHZc0pn
         /8bw==
X-Gm-Message-State: APjAAAVBF7JyFgIafZYRjq4lYTXjxmjNrys1C3w9P2KFDCydv0yZWjx1
        QTr0Bw0Yc0i2yrk9TW93gLCmkcyoIBMFvuQQi6s=
X-Google-Smtp-Source: APXvYqwS14skViwFtpS1qFNS9O1y8/o+stplkXmQN+/eDze8Vtb5YAEoG1VSK9WL5IjzUMOos3pKeKcBk+kuIpCqNJM=
X-Received: by 2002:a1f:1605:: with SMTP id 5mr17245867vkw.16.1571083128187;
 Mon, 14 Oct 2019 12:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191011012341.846266-16-dima@arista.com> <201910141209.9Vv7oLGL%lkp@intel.com>
In-Reply-To: <201910141209.9Vv7oLGL%lkp@intel.com>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Mon, 14 Oct 2019 12:58:37 -0700
Message-ID: <CANaxB-z39mNJ-=9gY8C8Kvnk2kUFYHW8mt007LFEOzh-nshmaQ@mail.gmail.com>
Subject: Re: [PATCHv7 15/33] posix-timers: Make clock_nanosleep() time
 namespace aware
To:     kbuild test robot <lkp@intel.com>
Cc:     Dmitry Safonov <dima@arista.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
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
        Linux Containers <containers@lists.linux-foundation.org>,
        crml <criu@openvz.org>, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Oct 13, 2019 at 9:28 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Dmitry,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.4-rc2 next-20191011]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/kernel-Introduce-Time-Namespace/20191014-075119
> config: x86_64-randconfig-s1-201941 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    kernel//time/posix-stubs.c: In function '__do_sys_clock_nanosleep':
> >> kernel//time/posix-stubs.c:153:31: error: 'clockid' undeclared (first use in this function)
>       texp = timens_ktime_to_host(clockid, texp);

This is my fault. I forgot to compile it without CONFIG_POSIX_TIMERS.
Will fix this shortly. Sorry for inconvenience.

>                                   ^
>    kernel//time/posix-stubs.c:153:31: note: each undeclared identifier is reported only once for each function it appears in
>    kernel//time/posix-stubs.c: In function '__do_sys_clock_nanosleep_time32':
> >> kernel//time/posix-stubs.c:222:2: error: unknown type name 'ktime'
>      ktime texp;
>      ^
>    kernel//time/posix-stubs.c:243:31: error: 'clockid' undeclared (first use in this function)
>       texp = timens_ktime_to_host(clockid, texp);
>                                   ^
>
> vim +/clockid +153 kernel//time/posix-stubs.c
>
>    126
>    127  SYSCALL_DEFINE4(clock_nanosleep, const clockid_t, which_clock, int, flags,
>    128                  const struct __kernel_timespec __user *, rqtp,
>    129                  struct __kernel_timespec __user *, rmtp)
>    130  {
>    131          struct timespec64 t;
>    132          ktime_t texp;
>    133
>    134          switch (which_clock) {
>    135          case CLOCK_REALTIME:
>    136          case CLOCK_MONOTONIC:
>    137          case CLOCK_BOOTTIME:
>    138                  break;
>    139          default:
>    140                  return -EINVAL;
>    141          }
>    142
>    143          if (get_timespec64(&t, rqtp))
>    144                  return -EFAULT;
>    145          if (!timespec64_valid(&t))
>    146                  return -EINVAL;
>    147          if (flags & TIMER_ABSTIME)
>    148                  rmtp = NULL;
>    149          current->restart_block.nanosleep.type = rmtp ? TT_NATIVE : TT_NONE;
>    150          current->restart_block.nanosleep.rmtp = rmtp;
>    151          texp = timespec64_to_ktime(t);
>    152          if (flags & TIMER_ABSTIME)
>  > 153                  texp = timens_ktime_to_host(clockid, texp);
>    154          return hrtimer_nanosleep(texp, flags & TIMER_ABSTIME ?
>    155                                   HRTIMER_MODE_ABS : HRTIMER_MODE_REL,
>    156                                   which_clock);
>    157  }
>    158
>    159  #ifdef CONFIG_COMPAT
>    160  COMPAT_SYS_NI(timer_create);
>    161  COMPAT_SYS_NI(getitimer);
>    162  COMPAT_SYS_NI(setitimer);
>    163  #endif
>    164
>    165  #ifdef CONFIG_COMPAT_32BIT_TIME
>    166  SYS_NI(timer_settime32);
>    167  SYS_NI(timer_gettime32);
>    168
>    169  SYSCALL_DEFINE2(clock_settime32, const clockid_t, which_clock,
>    170                  struct old_timespec32 __user *, tp)
>    171  {
>    172          struct timespec64 new_tp;
>    173
>    174          if (which_clock != CLOCK_REALTIME)
>    175                  return -EINVAL;
>    176          if (get_old_timespec32(&new_tp, tp))
>    177                  return -EFAULT;
>    178
>    179          return do_sys_settimeofday64(&new_tp, NULL);
>    180  }
>    181
>    182  SYSCALL_DEFINE2(clock_gettime32, clockid_t, which_clock,
>    183                  struct old_timespec32 __user *, tp)
>    184  {
>    185          int ret;
>    186          struct timespec64 kernel_tp;
>    187
>    188          ret = do_clock_gettime(which_clock, &kernel_tp);
>    189          if (ret)
>    190                  return ret;
>    191
>    192          if (put_old_timespec32(&kernel_tp, tp))
>    193                  return -EFAULT;
>    194          return 0;
>    195  }
>    196
>    197  SYSCALL_DEFINE2(clock_getres_time32, clockid_t, which_clock,
>    198                  struct old_timespec32 __user *, tp)
>    199  {
>    200          struct timespec64 rtn_tp = {
>    201                  .tv_sec = 0,
>    202                  .tv_nsec = hrtimer_resolution,
>    203          };
>    204
>    205          switch (which_clock) {
>    206          case CLOCK_REALTIME:
>    207          case CLOCK_MONOTONIC:
>    208          case CLOCK_BOOTTIME:
>    209                  if (put_old_timespec32(&rtn_tp, tp))
>    210                          return -EFAULT;
>    211                  return 0;
>    212          default:
>    213                  return -EINVAL;
>    214          }
>    215  }
>    216
>    217  SYSCALL_DEFINE4(clock_nanosleep_time32, clockid_t, which_clock, int, flags,
>    218                  struct old_timespec32 __user *, rqtp,
>    219                  struct old_timespec32 __user *, rmtp)
>    220  {
>    221          struct timespec64 t;
>  > 222          ktime texp;
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
