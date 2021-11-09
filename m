Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2166544AE6B
	for <lists+linux-api@lfdr.de>; Tue,  9 Nov 2021 14:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbhKINIY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 9 Nov 2021 08:08:24 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:42413 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbhKINIQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 9 Nov 2021 08:08:16 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MYcy3-1nEpjv0UKZ-00VgZ9; Tue, 09 Nov 2021 14:05:28 +0100
Received: by mail-wr1-f53.google.com with SMTP id s13so32913754wrb.3;
        Tue, 09 Nov 2021 05:05:27 -0800 (PST)
X-Gm-Message-State: AOAM531obU9zQxZLci0HZGouM7eA/pZPEgynIlxejLNVY4k9ZiZC3ZyY
        B+XkAhvccXZzszj0gQGHtZNUEBxE73dF2XLXxJw=
X-Google-Smtp-Source: ABdhPJw59Rmr+DMXszKBukNsUqZ3FsgOiqKQbSlqF8XuY+XgF6EW4Cq5VhV2Y1l1S7CXitxZ6DpXsOJS8z6kaIvCVpE=
X-Received: by 2002:adf:df89:: with SMTP id z9mr8974988wrl.336.1636463127622;
 Tue, 09 Nov 2021 05:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20210923171111.300673-1-andrealmeid@collabora.com>
 <20210923171111.300673-21-andrealmeid@collabora.com> <your-ad-here.call-01636456701-ext-5362@work.hours>
 <51bbfe74-33f6-bb92-3ce8-a22e4185820b@collabora.com>
In-Reply-To: <51bbfe74-33f6-bb92-3ce8-a22e4185820b@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 9 Nov 2021 14:05:11 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3T4qmZvags28bibibsyLBBLjsRQTGJqanLdcergxQTXQ@mail.gmail.com>
Message-ID: <CAK8P3a3T4qmZvags28bibibsyLBBLjsRQTGJqanLdcergxQTXQ@mail.gmail.com>
Subject: Re: [PATCH v2 20/22] selftests: futex: Test sys_futex_waitv() timeout
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Collabora kernel ML <kernel@collabora.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux API <linux-api@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:j1y24ZLQaCxUnwIlX4UkGzpcQwqR0k9vJ7BzTd4TvS4BhotMlOC
 dLh9ehv+pKrnceNqMg4UWmtbtGXGXBMlUoXMErYIKABldKOPM08rnx4R7jZufLwY1NaodP3
 d1rsCDC0rjd5JmgydQKTeIjOaqPgtcqpqGudAdmwtdfeI03ZZ8ixBoY+eJQWoQa4X3Xds1G
 kEC9WKv/46/Ow+Xv0fVog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:eFU4pS+yBGA=:0DD8DEJVG7L4LNan7gz6Od
 ZeJFhjshpJTNml5IVCZj1pXCUd2FCWg0i2N7+OszY5zX8aaOfFLLOfgw4PKfD0s84VXtFTWMQ
 DR8p2yuD+tTVIxGy4YMslHVXE78O81JeuqePSSlYCztLAQLdFmFApRSwJq1yN7AMjqcl8sP7D
 SG0OwWyqtUtTp1Vz5+BWgGIXsJwsZhKAH8kxh4KGY3plFo0iQb5YmuqM+hzJpqWGu3gsR/io/
 g+nsdwbWrZ8dH0D8pLa0hCwJpWdd31H9PmGEqxXt1bxL6kvaa9uWkA8zVzZyYGWNouxAgHG8b
 MtU8N4khoWL/glgUGJpqdOQaBHy5C/Y/XSayLKtsq/lU8nz6y/ZUYxa6MdKPiInBUJ+99j+sA
 U/3fZXBpIo4+UGUFy5fL9H6PNwyaTaArUn0Q9X+zGjuz6TdU52mDyGmmxiUB6XjWW0lP3SzJe
 fovHV/j0ZXR6XBFGOIeioTgNqXcRfR/SRbB/Ko7WU92N8rRwn642876pgwnRIpGveOAW5JOb4
 j8yp0v5spJHyd/OGiTM4IaKsatXjTwESOA9tr/y4ukzUQaaxZkdsfFhDXw/jbmu8YIZe8MjJl
 XXnGdXYv8D1gUWG5NrwJ1qibQnC+cFkKBCLbeVooG94/++1Ktea5sv+RQOPXjm43K8F84qGf4
 zxBJmcG1K0AHBHRKZRuCJeEBorcFifDFVxjJHC99fFnHB7nM5uSoWHGqpc/ffRPWqlXRGUeEH
 HSkSsJSmgNXGhPmXi8BQ3WhKqcPx06bEIcj4u3oTGgPFbaXhR6uupZCEKVHfatIsw0cqx6wjt
 7NGBvT5LOxtG1vm72lV4p5c4SA21EtQHveIg/lAwPWkj/OkCYM=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 9, 2021 at 1:52 PM André Almeida <andrealmeid@collabora.com> wrote:
> Às 08:18 de 09/11/21, Vasily Gorbik escreveu:
> > On Thu, Sep 23, 2021 at 02:11:09PM -0300, André Almeida wrote:
> >> Test if the futex_waitv timeout is working as expected, using the
> >> supported clockid options.
> >
> >> +    /* futex_waitv with CLOCK_MONOTONIC */
> >> +    if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
> >> +            return RET_FAIL;
> >> +    res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
> >> +    test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
> >> +
> >> +    /* futex_waitv with CLOCK_REALTIME */
> >> +    if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
> >> +            return RET_FAIL;
> >> +    res = futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
> >> +    test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
> >
> > Hi André,
> >
> > when built with -m32 and run as compat this two futex_waitv calls hang
> > on x86 and s390 (noticed while wiring up futex_waitv). The rest of the
> > futex selftests pass. This suggests some common compat issue? Any ideas?
>
> The issue is that futex_waitv() only accepts struct timespec that uses
> 64bit members. When using -m32, glibc will give you a 32bit timespec,
> thus the timeout won't wort. Someday glibc will provide 64bit timespec
> to 32bit userspace, given that this is affected by y2038 bug.

I think in the latest glibc you should be able to pass -D_TIME_BITS=64 to
the compiler to get the correct definition. Unfortunately, this only works
for simple test cases, but breaks if you call any interfaces from another
(non-glibc) library that depend on a particular time_t definition.

Alistair Francis also recently posted a set of helpers for the old futex()
call to make that easier to use from applications regardless of the libc
interface. I think it would be good to have this for futex_waitv() as well.

       Arnd
