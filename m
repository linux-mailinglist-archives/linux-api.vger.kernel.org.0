Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383D7439DA6
	for <lists+linux-api@lfdr.de>; Mon, 25 Oct 2021 19:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJYRfa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 25 Oct 2021 13:35:30 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:53783 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhJYRf3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Oct 2021 13:35:29 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MumVX-1mwB5V0IIV-00rmc4; Mon, 25 Oct 2021 19:33:06 +0200
Received: by mail-wr1-f47.google.com with SMTP id e12so14194023wra.4;
        Mon, 25 Oct 2021 10:33:05 -0700 (PDT)
X-Gm-Message-State: AOAM531ytlD5jgAf4fH4znDkmqS/bOdtrqMntI/UkwITdvBjsQrikKjJ
        xOG5ppsegrIVQB06jebJdI51FvUAPeAFW/wRYy4=
X-Google-Smtp-Source: ABdhPJyQ4oJStzXEElhoVVEe5cI928P6BC7+29Y4pK2PWMSfQFK+AUKrujYqzSHNQD+evR9vG2uLNBBz40j/XPxyrmI=
X-Received: by 2002:a5d:47a3:: with SMTP id 3mr12558143wrb.336.1635183185670;
 Mon, 25 Oct 2021 10:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com> <1e24268a-fd6a-10cd-cb1d-c479bb2f930f@collabora.com>
In-Reply-To: <1e24268a-fd6a-10cd-cb1d-c479bb2f930f@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Oct 2021 19:32:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2R=e7we11Gi2zTVwFYrEt9Di6Bgzi9xtjMAX9BZex7Cw@mail.gmail.com>
Message-ID: <CAK8P3a2R=e7we11Gi2zTVwFYrEt9Di6Bgzi9xtjMAX9BZex7Cw@mail.gmail.com>
Subject: Re: [PATCH v2] uapi: futex: Add a futex syscall
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Alistair Francis <alistair23@gmail.com>,
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
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:UUko3k5LbLqO7C6a9OaVdstsVC4XNKJtuyAuYGEUETAAcPdSSBP
 mwDeZdWdvbHrbleccsvPBZLXa+U7nYSOMvaPG+tnL4yz/bP51zw2jYVPI3SC/gY3w57fJDX
 YBsf0YGSCndvl3xlC7a+c/Q/YAyzBZIqFxYKDnwR3dT6H7uSkEayS6vVdoCh6PKz23ibtPa
 oakr5DAkWQ0QYEsu2WQ/g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u6RUVbwlsnU=:g26SIWBCRfJ705MhBiyO2L
 bE8KEXauNlCjKsGpaxyd1wa2q7w4D5Hmbc4mE+hyyaLa/kZUt2dKHlBQtJ9KpaE4hzNYszGB/
 RosOnY6oDkyWHR/g8SCnvL0r5zaXEVN094YfKj/uv3EKXtBtYJbL0IPvteDBUxuUlq1DOmuf8
 Tzs61KPejbqHjwNc48/G6UZklX5QTORxgld1XqfOcBOupj9NDOko4ei55E2P6zDWel8EwUnry
 HntL/c9eFuKNFvjlTTfSZ/KaMUwKjuzTRp6P5/Qw8jDdr4WrmE4jM+3gB4vKwvIc0JAgWcnxM
 QhLzqM8hai06H6hqhxygUYb3xgmLRvgWtX7ith0LMkSJ1l+Ldh4Jqo5/6/fJEp+PM81YXK3jY
 zoZ4yLfVYvFX28Ud6k0NX97/osaUJOVkPaFcvp5+5U3Ltzfl3PIHvIq3qL42/u5/NsJsZ/eeq
 vZdtIA+BOPKeX3uhSL7lsIekCqh+6FbMrn1TizcoIWCumxzRey/ey68et5relFBpX6qBNKiqr
 YxbnEyBhev+G2lTH2m+Ynih6os4oycU2axjyG/2W7pgefEVyFvW4m9zxw3MhetclizNznLZIi
 DTImbqRX39mTd1h/+unfPcb0X3C399Xe2W/0Cg/X6CGtTtfiaqiR4+Sv3js64t6t3Ob3lGdXn
 SL744unCl+QXHlcU8F+5ofo2GrMbW3KGtaAsaaP1yu92A7TdiRtWFrhCjGYe8ai8I+nk=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Oct 25, 2021 at 6:33 PM André Almeida <andrealmeid@collabora.com> wrote:
> Às 02:54 de 21/10/21, Alistair Francis escreveu:
> > From: Alistair Francis <alistair.francis@wdc.com>

> > +#if defined(__NR_futex)
> > +     if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
> > +             return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
> > +
> > +     if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
> > +             struct __kernel_old_timespec ts32;
> > +
> > +             ts32.tv_sec = (__kernel_long_t) timeout->tv_sec;> +             ts32.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
> > +
> > +             return syscall(__NR_futex, uaddr, op, val, &ts32, uaddr2, val3);
> > +     } else if (!timeout) {
> > +             return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
> > +     }
> > +#endif
>
> If I read this part right, you will always use ts32 for __NR_futex. I
> know that it can be misleading, but __NR_futex uses ts64 in 64-bit
> archs, so they shouldn't be converted to ts32 in those cases.

__kernel_old_timespec is the correct type for sys_futex() on all
architectures.

Maybe name the local variable 'ts' or 'ts_old' instead of 'ts32' then?

> > +{
> > +#if defined(__NR_futex_time64)
> > +     int ret =  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uaddr2, val3);
> > +
> > +     if (ret == 0 || errno != ENOSYS)
> > +             return ret;
> > +#endif
> > +
> > +#if defined(__NR_futex)
> > +     return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
> > +#endif
> > +
> > +     errno = ENOSYS;
> > +     return -1;
> > +}
> > +
> > +#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
> >
>
> Sorry if this question was already asked but I didn't find it in the
> thread: Should we go with wrappers for the most common op? Like:
>
> __kernel_futex_wait(volatile uint32_t *uaddr, uint32_t val, struct
> timespec *timeout)
>
> __kernel_futex_wake(volatile uint32_t *uaddr, uint32_t nr_wake)

I had suggested having just a single function definition here, but having one
per argument type seems reasonable as well. Having one definition
per futex_op value would also be possible, but in that case I suppose
we need all 13 of them, not just two.

        Arnd
