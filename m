Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F945B434
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhKXGNm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 01:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKXGNm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 01:13:42 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62993C061574;
        Tue, 23 Nov 2021 22:10:33 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id k1so1425352ilo.7;
        Tue, 23 Nov 2021 22:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mpaq/sbQwlhNhkvf2MHPSr/3GWUoeeBjSlnS29gm85I=;
        b=Slo8QFI/AvSbg8d04rSBmxsiWDfhI3z2cIMHBAWUg/ogyROniT1vPZDQU+590QiTW9
         qJHfhJ66pHUndB/QI4FN/S7beF6bjQew3tK+9NM2nn/KLL6sNcRhBYsv4sH9/TO/QhJX
         7FNe4aX603+PiXvbeGk9mie9XtLzHLd5srFO4cg8LgTukk04zqc7VyvvUzqc4VghcTjA
         Ca1bQcVUZ99KHDq6Gc02VF+9dqI1f00GmsN+msGIFMx+vHj6euu9014fFHbCEnY29tXQ
         U+Ts5byeREBz3vKH+bCaLvs1+l4hdtYxJUY7sJODWOFUwITGGgeOujG3wum9NUpbOBHO
         DwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mpaq/sbQwlhNhkvf2MHPSr/3GWUoeeBjSlnS29gm85I=;
        b=g2sLST/rlLi10u+LlT89p2/TTkJ0L/k+rsVQjYwsdyjeXni7x7oVJcNXb30jiNPaLl
         DWNZdI9Mbh9I5jIYN/dUv2zS866F42xIgSTOFcAchlyenHeDcCfM7WMb4UMyoIdPv7EW
         XlsFGrwfA1UnmnF5gtcEVUIMl8qJiABxlwOulQ+LWH3+oajnwuO2uPPUCeJ4CDSjeWAZ
         a7hX84Whzmij0k0wynwqXDJ735ANKBpNO9esha/FntNNOsG4BP9GCQXJOYNFYBse/zUj
         KiW5A84PhP3O20rRGB8WJy+F7mymC317mQWmZdz5lsEknxOHrn5exm5BPvtdFoacynPg
         6mcg==
X-Gm-Message-State: AOAM531NW/DKQQrXtCIs79bAxh0KARkqYcMufpdG+bTG5Nfr4ZFPFZFp
        6Nzu7BFc4r9+jwRi8Kj5UQZn2087jFcoucSxifXn4pEeHuvo8f2M+So=
X-Google-Smtp-Source: ABdhPJz47YZiSwEk1vmyTxhrUOX2ZRfJSvcphYE/Bk5RSBxbhD0idqhm7X5BkAc7Xs9BrsIhdQarc14/6iDjjyuqklg=
X-Received: by 2002:a05:6e02:1e02:: with SMTP id g2mr10649428ila.290.1637734232771;
 Tue, 23 Nov 2021 22:10:32 -0800 (PST)
MIME-Version: 1.0
References: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com> <1e24268a-fd6a-10cd-cb1d-c479bb2f930f@collabora.com>
In-Reply-To: <1e24268a-fd6a-10cd-cb1d-c479bb2f930f@collabora.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 24 Nov 2021 16:10:06 +1000
Message-ID: <CAKmqyKP644V16Q-XKWKLudAVueQxYyZvwGrbe9XP9573p_cDoA@mail.gmail.com>
Subject: Re: [PATCH v2] uapi: futex: Add a futex syscall
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 26, 2021 at 2:34 AM Andr=C3=A9 Almeida <andrealmeid@collabora.c=
om> wrote:
>
> Hi Alistair,
>
> =C3=80s 02:54 de 21/10/21, Alistair Francis escreveu:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > This commit adds two futex syscall wrappers that are exposed to
> > userspace.
> >
> > Neither the kernel or glibc currently expose a futex wrapper, so
> > userspace is left performing raw syscalls. This has mostly been becuase
>
>                                                                   because
>
> > the overloading of one of the arguments makes it impossible to provide =
a
> > single type safe function.
> >
> > Until recently the single syscall has worked fine. With the introductio=
n
> > of a 64-bit time_t futex call on 32-bit architectures, this has become
> > more complex. The logic of handling the two possible futex syscalls is
> > complex and often implemented incorrectly.
> >
> > This patch adds two futux syscall functions that correctly handle the
> > time_t complexity for userspace.
> >
> > This idea is based on previous discussions: https://lkml.org/lkml/2021/=
9/21/143
>
> I would use lore
> https://lore.kernel.org/lkml/CAK8P3a3x_EyCiPDpMK54y=3DRtm-Wb08ym2TNiuAZgX=
hYrThcWTw@mail.gmail.com/
>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> Thanks for working on that :)
>
> > ---
> >  include/uapi/linux/futex_syscall.h | 81 ++++++++++++++++++++++++++++++
> >  1 file changed, 81 insertions(+)
> >  create mode 100644 include/uapi/linux/futex_syscall.h
> >
> > diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fu=
tex_syscall.h
> > new file mode 100644
> > index 0000000000000..f84a0c68baf78
> > --- /dev/null
> > +++ b/include/uapi/linux/futex_syscall.h
> > @@ -0,0 +1,81 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
> > +#define _UAPI_LINUX_FUTEX_SYSCALL_H
> > +
> > +#include <asm/unistd.h>
> > +#include <errno.h>
> > +#include <linux/types.h>
> > +#include <linux/time_types.h>
> > +#include <sys/syscall.h>
> > +
> > +/**
> > + * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrap=
per
> > + * @uaddr:  address of first futex
> > + * @op:   futex op code
> > + * @val:  typically expected value of uaddr, but varies by op
> > + * @timeout:  an absolute struct timespec
> > + * @uaddr2: address of second futex for some ops
> > + * @val3: varies by op
> > + */
> > +static inline int
> > +__kernel_futex_syscall_timeout(volatile u_int32_t *uaddr, int op, u_in=
t32_t val,
> > +                   struct timespec *timeout, volatile u_int32_t *uaddr=
2, int val3)
>
> I tried to write an example[0] that uses this header, but I can't
> compile given that u_int32_t isn't defined. Maybe change to uint32_t and
> include <stdint.h>?
>
> Also, I got some invalid use of undefined type 'struct timespec', and
> #include <time.h> solved.
>
> [0] https://paste.debian.net/1216834/
>
> > +{
> > +#if defined(__NR_futex_time64)
> > +     if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
> > +             int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, t=
imeout, uaddr2, val3);
> > +
> > +             if (ret =3D=3D 0 || errno !=3D ENOSYS)
> > +                     return ret;
> > +     }
> > +#endif
> > +
> > +#if defined(__NR_futex)
> > +     if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
> > +             return syscall(__NR_futex, uaddr, op, val, timeout, uaddr=
2, val3);
> > +
> > +     if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
> > +             struct __kernel_old_timespec ts32;
> > +
> > +             ts32.tv_sec =3D (__kernel_long_t) timeout->tv_sec;> +    =
         ts32.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
> > +
> > +             return syscall(__NR_futex, uaddr, op, val, &ts32, uaddr2,=
 val3);
> > +     } else if (!timeout) {
> > +             return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, =
val3);
> > +     }
> > +#endif
>
> If I read this part right, you will always use ts32 for __NR_futex. I
> know that it can be misleading, but __NR_futex uses ts64 in 64-bit
> archs, so they shouldn't be converted to ts32 in those cases.
>
> Just to make it clear, there's no __NR_futex_time64 at 64-bit archs.
>
> > +
> > +     errno =3D ENOSYS;
> > +     return -1;
> > +}
> > +
> > +/**
> > + * futex_syscall_nr_requeue() - __NR_futex/__NR_futex_time64 syscall w=
rapper
> > + * @uaddr:  address of first futex
> > + * @op:   futex op code
> > + * @val:  typically expected value of uaddr, but varies by op
> > + * @nr_requeue:  an op specific meaning
> > + * @uaddr2: address of second futex for some ops
> > + * @val3: varies by op
> > + */
> > +static inline int
> > +__kernel_futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u=
_int32_t val,
> > +                      u_int32_t nr_requeue, volatile u_int32_t *uaddr2=
, int val3)
>
> I would always assume that op is FUTEX_CMP_REQUEUE, given that
> FUTEX_REQUEUE is racy. From `man futex`:

There are other ops that this could be though. From just the kernel
futex self tests it could be FUTEX_WAKE_OP, FUTEX_WAIT_REQUEUE_PI or
FUTEX_CMP_REQUEUE_PI

Alistair

>
> The  FUTEX_CMP_REQUEUE operation was added as a replacement for the
> earlier FUTEX_REQUEUE.  The difference is that the check of the value at
> uaddr can be used to ensure that requeueing happens only under certain
> conditions, which allows race conditions to be avoided in certain use cas=
es.
>
> And then we can drop `int op` from the args and give defined
> descriptions for the args.
>
