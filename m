Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19D9FD773
	for <lists+linux-api@lfdr.de>; Fri, 15 Nov 2019 08:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfKOH66 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Nov 2019 02:58:58 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:56717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOH65 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Nov 2019 02:58:57 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MjBNV-1i01e11Hcb-00fBFw; Fri, 15 Nov 2019 08:58:56 +0100
Received: by mail-qk1-f174.google.com with SMTP id 15so7408314qkh.6;
        Thu, 14 Nov 2019 23:58:56 -0800 (PST)
X-Gm-Message-State: APjAAAVWz71Iy5+4Rq24TRv9rPFbArRAQa1QFxmlL26FuzS1+BBTDn3s
        CTT3kzbXVKPgsHmzwi1/Xvu9NCL42O/KdIKhC3I=
X-Google-Smtp-Source: APXvYqwCRuiHvMPdYEY+9nrthVzUL3CgZixPFa9ovvXaTu9Dd/zwghEHxJAIe2DFRARnaqz/NY6t/yktdwjQXJgLorg=
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr11550080qke.352.1573804735045;
 Thu, 14 Nov 2019 23:58:55 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-8-arnd@arndb.de>
 <20191114230127.GA3580@ryzen.lan>
In-Reply-To: <20191114230127.GA3580@ryzen.lan>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Nov 2019 08:58:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3jn8GcedX=HaTFiPY+fyHPoyVUnpcX19nMZqmuUA1RzA@mail.gmail.com>
Message-ID: <CAK8P3a3jn8GcedX=HaTFiPY+fyHPoyVUnpcX19nMZqmuUA1RzA@mail.gmail.com>
Subject: Re: [PATCH 17/23] y2038: time: avoid timespec usage in settimeofday()
To:     Abel Vesa <abelvesa@linux.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        zhengbin <zhengbin13@huawei.com>,
        Li RongQing <lirongqing@baidu.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:j3PB+Y+jway3c/Ss15Xlyv/RRWxUl1xeuK03VBF4XDs8ImO1J6g
 K2ugGwoGetM62zA0Kip6QQdkppL7ow/pZqhYHDE0UGDltyDPe391s/+GrMgwjo31s19YVwJ
 UMl7LYApu4RWMUvXJdSdQ62XNjyTIGqkt1dKgSFucHxnETvcGSVaWDQxfO+1iJClp1ceLnO
 JEbBTCOmwf42pEw8l03ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PGtr4UenFMM=:MtRQn2pmPIW9qNSj9oyXJM
 M+VKquevu3b1TQ9zKRMGHgLJ3SZiqx7sepixXHJfTENdWf9j1gf6Xi44q4WcEcb9Y+m8WncsQ
 tYMtW/o7gBgf3BRO+7rCkMjHUlhN/lKh5PbEAXfaEOdQ4o+P8J6czyZKF0EdZj+2Y2qKJpZ5w
 Kvu/HwXMJxKIAzP9G11/S2xj9g0YH8W6gEG/zdBZcf5qtoCWQWFxGp3x1qYgn7cDbJjdwsLPa
 25OB7ckNmlmdii3+A95ltykf54dx3lgMfG3VXsrjQUNqIGLE4KZObh0q+f0WJAIzDwrD0o9Aj
 iLI+ShVW1DngTvMGBD9dgGe/vlGk5J5Wqfknf8FD39bixIWFpBDbZ0EJQzCWBLE9BbDJ0JWsM
 pk8J6GuwIDBBDkOGwrroJ/zWTeBPn7PudifycR1Zv9srWlMtjtnWm69Se/CyD6tnjuPbE/MPy
 nT92gG7sJBBbAq+TUAsPYzqA6bgju+H1U1AFJBPsjvRoQwTGvlcMLuT6G7fLp8J4n54mfNabC
 pMMluWVJN3Ermu53DgNFl+/s8BDoZMpkER46nBYLDYCByAJzoixsUofpznLbCCCZP2/r8eBzL
 4aeUa3lLKUpm/uz0AMHx8MuOf+zjNwsmdE/l5Q2qNF+b3TQUbJuTL7siArtsgCp/KiQ0+2iwY
 w5HMefYyyU8ei5JjbQT2G8i9vcJM17w81m/Y8M5sz4TdqAzkBPo2395cbCUHcYhCdc9SXCsTs
 zZYr641cdKOe0Fq14qndUVp7yUIRjmaSyw8lk+991nnA7c5T7U7QIKfURZ5k7BSwVmB6yNiHj
 5YQJGymyaU7BPaupXACMFMnmhdRz5UvPexpeBdVrir75AIkTRzoS0JCuVrmhNY9uGlECw6WnI
 0bHrkiz8YUw46C1pINNQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 15, 2019 at 12:01 AM Abel Vesa <abelvesa@linux.com> wrote:
>
> On 19-11-08 22:12:16, Arnd Bergmann wrote:
> > The compat_get_timeval() and timeval_valid() interfaces
> > are deprecated and getting removed along with the definition
> > of struct timeval itself.
> >
> > Change the two implementations of the settimeofday()
> > system call to open-code these helpers and completely
> > avoid references to timeval.
> >

I'm not sure how we get to the RCU stall, but this is almost certainly another
symptom of a typo I had introduced in the patch, which others have also
reported. This is the the fix in today's linux-next:

--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -207,7 +207,7 @@ SYSCALL_DEFINE2(settimeofday, struct
__kernel_old_timeval __user *, tv,
                    get_user(new_ts.tv_nsec, &tv->tv_usec))
                        return -EFAULT;

-               if (tv->tv_usec > USEC_PER_SEC)
+               if (new_ts->tv_usec > USEC_PER_SEC)
                        return -EINVAL;

                new_ts.tv_nsec *= NSEC_PER_USEC;


    Arnd

> I get the following rcu stalls due to this patch on riscv64 (on qemu):
>
>         [root@riscv ~]# uname -a
>         Linux riscv 5.4.0-rc6-00018-gadde74306a4b #112 SMP Fri Nov 15 00:46:20 EET 2019 riscv64 riscv64 riscv64 GNU/Linux
>         [root@riscv ~]# [  420.135710] rcu: INFO: rcu_sched self-detected stall
>         on CPU
>         [  420.136839] rcu:     3-....: (99702 ticks this GP) idle=482/1/0x4000000000000002 softirq=3322/3322 fqs=48784
>         [  420.138917]  (t=99768 jiffies g=4985 q=8343)
>         [  420.139772] Task dump for CPU 3:
>         [  420.140236] rdate           R  running task        0   254      1 0x00000008
>         [  420.142226] Call Trace:
>         [  420.142791] [<ffffffe000037954>] walk_stackframe+0x0/0xa6
>         [  420.143911] [<ffffffe000037aba>] show_stack+0x2a/0x34
>         [  420.145010] [<ffffffe0000569c8>] sched_show_task+0xf0/0x116
>         [  420.145996] [<ffffffe00005b502>] dump_cpu_task+0x3e/0x48
>         [  420.147073] [<ffffffe000084e5e>] rcu_dump_cpu_stacks+0x7c/0xb4
>         [  420.148243] [<ffffffe0000842f6>] rcu_sched_clock_irq+0x3d6/0x582
>         [  420.149349] [<ffffffe0000897b4>] update_process_times+0x1e/0x42
>         [  420.150306] [<ffffffe000093a34>] tick_sched_handle.isra.0+0x2a/0x3a
>         [  420.150997] [<ffffffe000093ce8>] tick_sched_timer+0x4e/0x92
>         [  420.151603] [<ffffffe000089eb6>] __hrtimer_run_queues+0xae/0x108
>         [  420.152639] [<ffffffe00008a5ac>] hrtimer_interrupt+0xca/0x1d4
>         [  420.153629] [<ffffffe0004de564>] riscv_timer_interrupt+0x32/0x3a
>         [  420.154629] [<ffffffe000612ad4>] do_IRQ+0xa4/0xb8
>         [  420.155294] [<ffffffe000036814>] ret_from_exception+0x0/0xc
>         [  420.156073] [<ffffffe000036814>] ret_from_exception+0x0/0xc
