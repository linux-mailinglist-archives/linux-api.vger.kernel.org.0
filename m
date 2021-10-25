Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062B9439B9A
	for <lists+linux-api@lfdr.de>; Mon, 25 Oct 2021 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhJYQgX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 Oct 2021 12:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJYQgW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 Oct 2021 12:36:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C5C061745;
        Mon, 25 Oct 2021 09:34:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id AF1991F43289
Message-ID: <1e24268a-fd6a-10cd-cb1d-c479bb2f930f@collabora.com>
Date:   Mon, 25 Oct 2021 13:33:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] uapi: futex: Add a futex syscall
Content-Language: en-US
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     alistair23@gmail.com, arnd@arndb.de,
        Alistair Francis <alistair.francis@wdc.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>
References: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
In-Reply-To: <20211021055408.4006408-1-alistair.francis@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Alistair,

Às 02:54 de 21/10/21, Alistair Francis escreveu:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> This commit adds two futex syscall wrappers that are exposed to
> userspace.
> 
> Neither the kernel or glibc currently expose a futex wrapper, so
> userspace is left performing raw syscalls. This has mostly been becuase

                                                                  because

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

I would use lore
https://lore.kernel.org/lkml/CAK8P3a3x_EyCiPDpMK54y=Rtm-Wb08ym2TNiuAZgXhYrThcWTw@mail.gmail.com/

> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks for working on that :)

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
> +		      struct timespec *timeout, volatile u_int32_t *uaddr2, int val3)

I tried to write an example[0] that uses this header, but I can't
compile given that u_int32_t isn't defined. Maybe change to uint32_t and
include <stdint.h>?

Also, I got some invalid use of undefined type 'struct timespec', and
#include <time.h> solved.

[0] https://paste.debian.net/1216834/

> +{
> +#if defined(__NR_futex_time64)
> +	if (sizeof(*timeout) != sizeof(struct __kernel_old_timespec)) {
> +		int ret =  syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2, val3);
> +
> +		if (ret == 0 || errno != ENOSYS)
> +			return ret;
> +	}
> +#endif
> +
> +#if defined(__NR_futex)
> +	if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
> +		return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
> +
> +	if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
> +		struct __kernel_old_timespec ts32;
> +
> +		ts32.tv_sec = (__kernel_long_t) timeout->tv_sec;> +		ts32.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
> +
> +		return syscall(__NR_futex, uaddr, op, val, &ts32, uaddr2, val3);
> +	} else if (!timeout) {
> +		return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
> +	}
> +#endif

If I read this part right, you will always use ts32 for __NR_futex. I
know that it can be misleading, but __NR_futex uses ts64 in 64-bit
archs, so they shouldn't be converted to ts32 in those cases.

Just to make it clear, there's no __NR_futex_time64 at 64-bit archs.

> +
> +	errno = ENOSYS;
> +	return -1;
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
> +			 u_int32_t nr_requeue, volatile u_int32_t *uaddr2, int val3)

I would always assume that op is FUTEX_CMP_REQUEUE, given that
FUTEX_REQUEUE is racy. From `man futex`:

The  FUTEX_CMP_REQUEUE operation was added as a replacement for the
earlier FUTEX_REQUEUE.  The difference is that the check of the value at
uaddr can be used to ensure that requeueing happens only under certain
conditions, which allows race conditions to be avoided in certain use cases.

And then we can drop `int op` from the args and give defined
descriptions for the args.

> +{
> +#if defined(__NR_futex_time64)
> +	int ret =  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uaddr2, val3);
> +
> +	if (ret == 0 || errno != ENOSYS)
> +		return ret;
> +#endif
> +
> +#if defined(__NR_futex)
> +	return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
> +#endif
> +
> +	errno = ENOSYS;
> +	return -1;
> +}
> +
> +#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
> 

Sorry if this question was already asked but I didn't find it in the
thread: Should we go with wrappers for the most common op? Like:

__kernel_futex_wait(volatile uint32_t *uaddr, uint32_t val, struct
timespec *timeout)

__kernel_futex_wake(volatile uint32_t *uaddr, uint32_t nr_wake)

Thanks!
	André
