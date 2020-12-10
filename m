Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993A22D63BD
	for <lists+linux-api@lfdr.de>; Thu, 10 Dec 2020 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392763AbgLJRhk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Dec 2020 12:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392749AbgLJRh2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Dec 2020 12:37:28 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A0CC0613CF;
        Thu, 10 Dec 2020 09:36:47 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a12so6338996wrv.8;
        Thu, 10 Dec 2020 09:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1QAgEfLbDqvLOTms5FuJD8g2f8Zb8lG9g+EAmIv/LsM=;
        b=bLOMD2POUfsIYyNQChcFt1XNUfGOpslB+5byR6Dv9enjapsZsAt5oGX+sS+jO7Xxkv
         413dl3kZxpfy8GGl2TsmNaJZD3uMTIH6Eur+2hytUYbU6CE4wRZqyIS8WtUj+u1ypIv5
         +d15RMgGNhhmOBItiC+mGPQEcu7xI2zQICEhaEIA2Bkzc9GTTRtW743sJldsfuNal1d1
         OxMFzuON6apt2JlKQBlYGS3QqI4BV/Yyo7QLkDXpVOBfBOcBxi9Q/MdYNv7ODN9AgsJ2
         ZI729ytStgxbjx84BQChPbhz9Tnnjp9/9pzUxmxa5+nVTGyMy/TpyLUJ4G3veQxC3DDy
         9q0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1QAgEfLbDqvLOTms5FuJD8g2f8Zb8lG9g+EAmIv/LsM=;
        b=i1z8oaaE+K7g75zSYiFedjBD/QxRcabGbGi7jsHgQf7jMrls0SQLQ1GjP6LBDuzD9t
         ACU44YCRO106QMh4uA3Ubtxh+XK7JZvkNXbjUuNuInPmq26Z6a8YPoc1nN3RvKSikU8J
         xWq/4HlvKCN92pi1IURCL/KEp8o67MzwmzAY+c1zTH9UtiOHxlkrxKpvfgDvkj6ZVE22
         fGRAZJzxeVYz1G4hGKXbN5pM54wAMjKYIlbQmJmw49FqdKDgRVSknU7OgwDvjM3+sC8P
         DQaNB9hGOEsmJKsxJDd5/xJQCzlhVtCbOZ/uj35G8jAoSpef1UPSS/+yq15gYhxPNBY4
         EtWA==
X-Gm-Message-State: AOAM533LCk3Xe8dAKd21Y/eIU0vXiVVtLAX7Hkke4IqSKdY0lQ3YZH7A
        9kxKtaZ7w1QVUpxXqbrztX31FlrgsIU=
X-Google-Smtp-Source: ABdhPJwKH5s9bXb6DNvrt4AJjd71jK69ajr+CeJjp2QNajxjA4R2G5xJV/BCXEN+tXEjWhECTYW8sQ==
X-Received: by 2002:adf:e749:: with SMTP id c9mr9840799wrn.409.1607621806141;
        Thu, 10 Dec 2020 09:36:46 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id y130sm11219363wmc.22.2020.12.10.09.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 09:36:45 -0800 (PST)
Subject: Re: [PATCH] futex: Change 'utime' parameter to be 'const ... *'
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20201128123945.4592-1-alx.manpages@gmail.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <869f16b2-ee4f-5f33-4b82-43332a381660@gmail.com>
Date:   Thu, 10 Dec 2020 18:36:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201128123945.4592-1-alx.manpages@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas & Ingo,

I tested the changes. Everything's OK.

Cheers,

Alex

$ uname -a
Linux debian 5.10.0-rc7+alx3+ #4 SMP Thu Dec 10 18:05:03 CET 2020 x86_64
GNU/Linux

.../linux/tools/testing/selftests/futex$ sudo ./run.sh
[sudo] password for user:

TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=0 owner=0 timeout=0ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=0 owner=0 timeout=0ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=1 owner=0 timeout=0ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=0 owner=1 timeout=0ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=1 owner=0 timeout=0ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=0 owner=1 timeout=0ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=1 owner=0 timeout=5000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=1 owner=0 timeout=5000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=1 owner=0 timeout=500000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=1 owner=0 timeout=500000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=0 owner=0 timeout=5000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=0 owner=0 timeout=5000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=0 owner=0 timeout=500000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=0 owner=0 timeout=500000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=0 owner=1 timeout=5000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=1 owner=0 timeout=5000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=0 owner=1 timeout=500000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=1 owner=0 timeout=500000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=1 locked=1 owner=0 timeout=2000000000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_requeue_pi: Test requeue functionality
# 	Arguments: broadcast=0 locked=1 owner=0 timeout=2000000000ns
ok 1 futex-requeue-pi
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

TAP version 13
1..1
# futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
ok 1 futex-requeue-pi-mismatched-ops
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

TAP version 13
1..1
# futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
# 	Arguments: <none>
ok 1 futex-requeue-pi-signal-restart
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

TAP version 13
1..1
# futex_wait_timeout: Block on a futex and wait for timeout
# 	Arguments: timeout=100000ns
ok 1 futex-wait-timeout
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

TAP version 13
1..1
# futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
ok 1 futex-wait-wouldblock
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

TAP version 13
1..1
# futex_wait_uninitialized_heap: Test the uninitialized futex value in
FUTEX_WAIT
ok 1 futex-wait-uninitialized-heap
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
TAP version 13
1..1
# futex_wait_private_mapped_file: Test the futex value of private file
mappings in FUTEX_WAIT
ok 1 futex-wait-private-mapped-file
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0


On 11/28/20 1:39 PM, Alejandro Colomar wrote:
> futex(2) says that 'utime' is a pointer to 'const'.
> The implementation doesn't use 'const';
> however, it _never_ modifies the contents of utime.
> 
> - futex() either uses 'utime' as a pointer to struct or as a 'u32'.
> 
> - In case it's used as a 'u32', it makes a copy of it,
>   and of course it is not dereferenced.
> 
> - In case it's used as a 'struct __kernel_timespec __user *',
>   the pointer is not dereferenced inside the futex() definition,
>   and it is only passed to a function: get_timespec64(),
>   which accepts a 'const struct __kernel_timespec __user *'.
> 
> context:
> ........
> 
> [[
> FUTEX(2)               Linux Programmer's Manual              FUTEX(2)
> 
> NAME
>        futex - fast user-space locking
> 
> SYNOPSIS
>        #include <linux/futex.h>
>        #include <stdint.h>
>        #include <sys/time.h>
> 
>        long futex(uint32_t *uaddr, int futex_op, uint32_t val,
>                  const struct timespec *timeout,   /* or: uint32_t val2 */
>                  uint32_t *uaddr2, uint32_t val3);
> 
>        Note:  There  is  no  glibc  wrapper  for this system call; see
>        NOTES.
> ]]
> 
> $ sed -n '/SYSCALL_DEFINE.(futex\>/,/^}/p' linux/kernel/futex.c
> SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
> 		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
> 		u32, val3)
> {
> 	struct timespec64 ts;
> 	ktime_t t, *tp = NULL;
> 	u32 val2 = 0;
> 	int cmd = op & FUTEX_CMD_MASK;
> 
> 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
> 		      cmd == FUTEX_WAIT_BITSET ||
> 		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
> 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
> 			return -EFAULT;
> 		if (get_timespec64(&ts, utime))
> 			return -EFAULT;
> 		if (!timespec64_valid(&ts))
> 			return -EINVAL;
> 
> 		t = timespec64_to_ktime(ts);
> 		if (cmd == FUTEX_WAIT)
> 			t = ktime_add_safe(ktime_get(), t);
> 		else if (!(op & FUTEX_CLOCK_REALTIME))
> 			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
> 		tp = &t;
> 	}
> 	/*
> 	 * requeue parameter in 'utime' if cmd == FUTEX_*_REQUEUE_*.
> 	 * number of waiters to wake in 'utime' if cmd == FUTEX_WAKE_OP.
> 	 */
> 	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
> 	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
> 		val2 = (u32) (unsigned long) utime;
> 
> 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
> }
> 
> $ sed -n '/get_timespec64(/,/;/p' linux/include/linux/time.h
> int get_timespec64(struct timespec64 *ts,
> 		const struct __kernel_timespec __user *uts);
> 
> ...
> 
> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
> ---
> 
> Hello Thomas & Ingo,
> 
> I'm sorry I couldn't test the change in my computers,
> as there is a bug since Linux 5.7 where I can't boot
> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=974166).
> 
> Alex
> 
>  kernel/futex.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 00259c7e288e..28577c7d2805 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3792,8 +3792,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
>  
>  
>  SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
> -		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
> -		u32, val3)
> +		const struct __kernel_timespec __user *, utime,
> +		u32 __user *, uaddr2, u32, val3)
>  {
>  	struct timespec64 ts;
>  	ktime_t t, *tp = NULL;
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es
