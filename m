Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACD6435AE8
	for <lists+linux-api@lfdr.de>; Thu, 21 Oct 2021 08:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhJUGda (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Oct 2021 02:33:30 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhJUGd3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Oct 2021 02:33:29 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M4rkF-1mepBW0OqF-001xSh; Thu, 21 Oct 2021 08:31:13 +0200
Received: by mail-wm1-f43.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso5526660wmc.1;
        Wed, 20 Oct 2021 23:31:12 -0700 (PDT)
X-Gm-Message-State: AOAM531RgG0997VKyEVdERr1NwKqmMAUneKQT0+Cw2UVS7YCPQ88f8Yl
        xd47ZnUN2KfYUeeKqdy9kzwOWvBMj7/LdLtVsX8=
X-Google-Smtp-Source: ABdhPJzDOUBrLJ7Gqa9iBZ0rDMl8wwQc5eUNmn1QOvGMK2ala3SswXlgCkft6lFYRMtx6XR7DoEky//ysghrPWSf88A=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr4478087wmg.35.1634797872724;
 Wed, 20 Oct 2021 23:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 Oct 2021 08:30:56 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3t8TLiXtp38=nYanwJyDNtX4=ANU8FXx8cr5w-W3hPRQ@mail.gmail.com>
Message-ID: <CAK8P3a3t8TLiXtp38=nYanwJyDNtX4=ANU8FXx8cr5w-W3hPRQ@mail.gmail.com>
Subject: Re: [PATCH v2] uapi: futex: Add a futex syscall
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FQR2wHZ5CYBWUYrZcsTkgopR5LtrVILVdN0WbvQu99MssCRgTkG
 FYMCBr8ZrtNrmobuvzlaoHV68g/YGqWDg1sB+yF2OCALn/esAVrjfQ8YPEZbSWgq1t+oG+v
 caURLEg/d0hFNNc4lzLgP0V1VGyl3Hcp32vwUFn0mrGQR2MGZQE3HKX15L7F7fGANcs/tNz
 MWToiDcBrcVQHPXiTc0Jg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:zncAV0bsKhI=:b4kKF0qh5OlJLVCuseV8qx
 Lhxv5z6wlR66DNOlK783ynPsMTNIGfkq9gs0IrFI3qyndDdsDSSa50ZE30vgeY8A62P4aK01D
 0TsCe8baCcFZt/4I1oMOniPKfh3mPOLVyHWGVJlC9+YWT14Yk/h4WxmyGspjPumnIpNdcD04Q
 TZCj2EKzZAbemrRIQ+wmKBIfa6xrIJRPJcpxlL7B/geiHdeaov4PIZSYLKXksVK2VYAiHXupw
 DzCqWJLV79X9uEp2sov/SwtN2MlAumJul2EiZjgNTdtOJOTTIe4lFjzKRHzzqgiR3g7pbb3Dr
 KL8acDXNSHW9/IZQXePKuJQxX/UxdoxGrEx6omvFmbbfHpuHh1qfGwshwqj3dWhPYv6GDU8Sg
 VxBgw3qXSbFhAoVF9vH1xDNmgBvLUU6kVeRuHoxx9smUsxI3vgjiIbx+SntPgDNzdVpqE0ktF
 tDI3yn07rkCcVxn2MIlyyT5MiKs+GoKkoy0vGV2nkjxHaHW2ekzgTY3nR4FGdbHqV3e6ckJ7Y
 cNech9m4FybakH3xlFpo6b475IKf9DAx4mIfzJiB6FH21TWxg0DZ4Ifa7jst9JbnqhsB+v4hw
 lsl7tawHWTswyhyrOdBBoApwyeafEVgIhlX463xrfJuu1o52NILZcl+BfkGmwSbyihk62LyFa
 BeaBzVjlPW0SXVW70ETx3eVdXrAwjkSLYdERPmtnJvum6D99bb+sd4DqWpIyOjuRPdh+5OuNo
 F9HTh0CMpR6muiaJFGWAp2N+0qzComY9whcYnboX7wbMnR6CEJECZa0WZsTBHYkK8KpQQ9L49
 yDCd9kEhCq7iTZDQTyjdd3TICokvAI+DkRvZTsYWEWwLWohUzQ=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 21, 2021 at 7:54 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> This commit adds two futex syscall wrappers that are exposed to
> userspace.
>
> Neither the kernel or glibc currently expose a futex wrapper, so
> userspace is left performing raw syscalls. This has mostly been becuase
> the overloading of one of the arguments makes it impossible to provide a
> single type safe function.
>
> Until recently the single syscall has worked fine. With the introduction
> of a 64-bit time_t futex call on 32-bit architectures, this has become
> more complex. The logic of handling the two possible futex syscalls is
> complex and often implemented incorrectly.
>
> This patch adds two futux syscall functions that correctly handle the
> time_t complexity for userspace.
>
> This idea is based on previous discussions: https://lkml.org/lkml/2021/9/21/143
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

This looks good to me, it addresses my earlier feedback, but I think we
need others to look into the question of whether we want this to be a
single function (as I suggested last time) or a pair of them (as you did).

I just replied to your email about this at
https://lore.kernel.org/lkml/CAK8P3a1CxFfHze6id1sQbQXV-x8DXkEdfqh51MwabzwhKAoTdQ@mail.gmail.com/

I added the futex maintainers and the linux-api list to Cc for them to
reply. Full patch quoted below, no further comments from me.

        Arnd

> ---
>  include/uapi/linux/futex_syscall.h | 81 ++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 include/uapi/linux/futex_syscall.h
>
> diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/futex_syscall.h
> new file mode 100644
> index 0000000000000..f84a0c68baf78
> --- /dev/null
> +++ b/include/uapi/linux/futex_syscall.h
> @@ -0,0 +1,81 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
> +#define _UAPI_LINUX_FUTEX_SYSCALL_H
> +
> +#include <asm/unistd.h>
> +#include <errno.h>
> +#include <linux/types.h>
> +#include <linux/time_types.h>
> +#include <sys/syscall.h>
> +
> +/**
> + * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrapper
> + * @uaddr:  address of first futex
> + * @op:   futex op code
> + * @val:  typically expected value of uaddr, but varies by op
> + * @timeout:  an absolute struct timespec
> + * @uaddr2: address of second futex for some ops
> + * @val3: varies by op
> + */
> +static inline int
> +__kernel_futex_syscall_timeout(volatile u_int32_t *uaddr, int op, u_int32_t val,
> +                     struct timespec *timeout, volatile u_int32_t *uaddr2, int val3)
> +{
> +#if defined(__NR_futex_time64)
> +       if (sizeof(*timeout) != sizeof(struct __kernel_old_timespec)) {
> +               int ret =  syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2, val3);
> +
> +               if (ret == 0 || errno != ENOSYS)
> +                       return ret;
> +       }
> +#endif
> +
> +#if defined(__NR_futex)
> +       if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
> +               return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
> +
> +       if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
> +               struct __kernel_old_timespec ts32;
> +
> +               ts32.tv_sec = (__kernel_long_t) timeout->tv_sec;
> +               ts32.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
> +
> +               return syscall(__NR_futex, uaddr, op, val, &ts32, uaddr2, val3);
> +       } else if (!timeout) {
> +               return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
> +       }
> +#endif
> +
> +       errno = ENOSYS;
> +       return -1;
> +}
> +
> +/**
> + * futex_syscall_nr_requeue() - __NR_futex/__NR_futex_time64 syscall wrapper
> + * @uaddr:  address of first futex
> + * @op:   futex op code
> + * @val:  typically expected value of uaddr, but varies by op
> + * @nr_requeue:  an op specific meaning
> + * @uaddr2: address of second futex for some ops
> + * @val3: varies by op
> + */
> +static inline int
> +__kernel_futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t val,
> +                        u_int32_t nr_requeue, volatile u_int32_t *uaddr2, int val3)
> +{
> +#if defined(__NR_futex_time64)
> +       int ret =  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uaddr2, val3);
> +
> +       if (ret == 0 || errno != ENOSYS)
> +               return ret;
> +#endif
> +
> +#if defined(__NR_futex)
> +       return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
> +#endif
> +
> +       errno = ENOSYS;
> +       return -1;
> +}
> +
> +#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
> --
> 2.31.1
>
