Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AE82F93FA
	for <lists+linux-api@lfdr.de>; Sun, 17 Jan 2021 17:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbhAQQdW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Jan 2021 11:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbhAQQdV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Jan 2021 11:33:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6AC061573;
        Sun, 17 Jan 2021 08:32:40 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id 6so6877532wri.3;
        Sun, 17 Jan 2021 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XUBhonaNsiMuXt1uG+fMMiWGYeaPNNbQEBbNBXexvcw=;
        b=eje2ln/DeTINa3SIMc5Im1OMP5vI+pUhXHX/T7/2wbFMIkvhR+GFNEuIsdQsY1O9ye
         DER/ggsCq4dYhtbkGmPyHRCFu1Ug/t0rut1y+6KsZBoOJd111Iy2MvYdyGBqVfpClBuv
         kLDTb5et0kY6rTkxMN3zo7toekD3YSvoppPvfs6zAo7xB9sQ5BAI8nfnHN0QZakzD96u
         Vk+CK27DAU3T3ZzX3wd5X/FSBnJ2SwcXxlcNaocYsBDJBaGtBWqQEXjLnuVNjTDAL83c
         LxjkMsx5c199gkuQxg7N5zsE24/972lp96Bb2gjRpOfKrmuCHIdTSm4xJ/eHh+moadSP
         oimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XUBhonaNsiMuXt1uG+fMMiWGYeaPNNbQEBbNBXexvcw=;
        b=IFqZrlGnLc4SzEOmbkK1VOkw1jb6PCEg8/amdrbE/zL1ibHJ+XoFtyIBmuvdVPLItT
         97z21A5eVi2+atxVTaTeMiBf1iw9GaT5+Ej7djJUDny4Oa9wQ3p8tPrN8vMDTqLuK5Kp
         bAJjQEEnW38XpmlvsftL6Wi4/xrxtTWNDp3KiLfdt1PfGWnJ41tJ92JjRfEvskmo9ky2
         ke5m2+MeBwww0m0uvJMNq1R8ESafUFVC1pSk7ai3r4s+kvJEU1uvC65OMExCnGwcyhy0
         l4gGspeRnZB5X1mzDgMLLdCuqQTt6c/bTkjVolhjIrPa2F+Azg9iTOv3DJVs55lcuUiM
         IZNg==
X-Gm-Message-State: AOAM530Yvc9aK1BmORS47y9GRbHqdPOb2wyNH7DIJDCN/DJojWeVQAPd
        LIC5X1/qOzAqNo4vneY6a1WtgnLRllU=
X-Google-Smtp-Source: ABdhPJwZgE+CiLmIIviL6ERgFeMWipbxRLHWjxX53p/qTZjMVzl7950blBXdKGr9kcy4EywqigAbhw==
X-Received: by 2002:adf:efc5:: with SMTP id i5mr21692536wrp.377.1610901159251;
        Sun, 17 Jan 2021 08:32:39 -0800 (PST)
Received: from [192.168.0.160] ([170.253.49.0])
        by smtp.gmail.com with ESMTPSA id q6sm20927966wmj.32.2021.01.17.08.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jan 2021 08:32:38 -0800 (PST)
Subject: Ping: [PATCH] futex: Change 'utime' parameter to be 'const ... *'
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20201128123945.4592-1-alx.manpages@gmail.com>
 <869f16b2-ee4f-5f33-4b82-43332a381660@gmail.com>
Message-ID: <6c8e46cd-1526-7aec-2115-572565176247@gmail.com>
Date:   Sun, 17 Jan 2021 17:32:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <869f16b2-ee4f-5f33-4b82-43332a381660@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Ping!

On 12/10/20 6:36 PM, Alejandro Colomar (man-pages) wrote:
> Hi Thomas & Ingo,
> 
> I tested the changes. Everything's OK.
> 
> Cheers,
> 
> Alex
> 
> $ uname -a
> Linux debian 5.10.0-rc7+alx3+ #4 SMP Thu Dec 10 18:05:03 CET 2020 x86_64
> GNU/Linux
> 
> .../linux/tools/testing/selftests/futex$ sudo ./run.sh
> [sudo] password for user:
> 
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=0 owner=0 timeout=0ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=0 owner=0 timeout=0ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=1 owner=0 timeout=0ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=0 owner=1 timeout=0ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=1 owner=0 timeout=0ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=0 owner=1 timeout=0ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=1 owner=0 timeout=5000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=1 owner=0 timeout=5000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=1 owner=0 timeout=500000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=1 owner=0 timeout=500000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=0 owner=0 timeout=5000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=0 owner=0 timeout=5000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=0 owner=0 timeout=500000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=0 owner=0 timeout=500000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=0 owner=1 timeout=5000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=1 owner=0 timeout=5000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=0 owner=1 timeout=500000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=1 owner=0 timeout=500000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=1 locked=1 owner=0 timeout=2000000000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_requeue_pi: Test requeue functionality
> # 	Arguments: broadcast=0 locked=1 owner=0 timeout=2000000000ns
> ok 1 futex-requeue-pi
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> TAP version 13
> 1..1
> # futex_requeue_pi_mismatched_ops: Detect mismatched requeue_pi operations
> ok 1 futex-requeue-pi-mismatched-ops
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> TAP version 13
> 1..1
> # futex_requeue_pi_signal_restart: Test signal handling during requeue_pi
> # 	Arguments: <none>
> ok 1 futex-requeue-pi-signal-restart
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> TAP version 13
> 1..1
> # futex_wait_timeout: Block on a futex and wait for timeout
> # 	Arguments: timeout=100000ns
> ok 1 futex-wait-timeout
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> TAP version 13
> 1..1
> # futex_wait_wouldblock: Test the unexpected futex value in FUTEX_WAIT
> ok 1 futex-wait-wouldblock
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> TAP version 13
> 1..1
> # futex_wait_uninitialized_heap: Test the uninitialized futex value in
> FUTEX_WAIT
> ok 1 futex-wait-uninitialized-heap
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> TAP version 13
> 1..1
> # futex_wait_private_mapped_file: Test the futex value of private file
> mappings in FUTEX_WAIT
> ok 1 futex-wait-private-mapped-file
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> 
> On 11/28/20 1:39 PM, Alejandro Colomar wrote:
>> futex(2) says that 'utime' is a pointer to 'const'.
>> The implementation doesn't use 'const';
>> however, it _never_ modifies the contents of utime.
>>
>> - futex() either uses 'utime' as a pointer to struct or as a 'u32'.
>>
>> - In case it's used as a 'u32', it makes a copy of it,
>>   and of course it is not dereferenced.
>>
>> - In case it's used as a 'struct __kernel_timespec __user *',
>>   the pointer is not dereferenced inside the futex() definition,
>>   and it is only passed to a function: get_timespec64(),
>>   which accepts a 'const struct __kernel_timespec __user *'.
>>
>> context:
>> ........
>>
>> [[
>> FUTEX(2)               Linux Programmer's Manual              FUTEX(2)
>>
>> NAME
>>        futex - fast user-space locking
>>
>> SYNOPSIS
>>        #include <linux/futex.h>
>>        #include <stdint.h>
>>        #include <sys/time.h>
>>
>>        long futex(uint32_t *uaddr, int futex_op, uint32_t val,
>>                  const struct timespec *timeout,   /* or: uint32_t val2 */
>>                  uint32_t *uaddr2, uint32_t val3);
>>
>>        Note:  There  is  no  glibc  wrapper  for this system call; see
>>        NOTES.
>> ]]
>>
>> $ sed -n '/SYSCALL_DEFINE.(futex\>/,/^}/p' linux/kernel/futex.c
>> SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
>> 		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
>> 		u32, val3)
>> {
>> 	struct timespec64 ts;
>> 	ktime_t t, *tp = NULL;
>> 	u32 val2 = 0;
>> 	int cmd = op & FUTEX_CMD_MASK;
>>
>> 	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
>> 		      cmd == FUTEX_WAIT_BITSET ||
>> 		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
>> 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
>> 			return -EFAULT;
>> 		if (get_timespec64(&ts, utime))
>> 			return -EFAULT;
>> 		if (!timespec64_valid(&ts))
>> 			return -EINVAL;
>>
>> 		t = timespec64_to_ktime(ts);
>> 		if (cmd == FUTEX_WAIT)
>> 			t = ktime_add_safe(ktime_get(), t);
>> 		else if (!(op & FUTEX_CLOCK_REALTIME))
>> 			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
>> 		tp = &t;
>> 	}
>> 	/*
>> 	 * requeue parameter in 'utime' if cmd == FUTEX_*_REQUEUE_*.
>> 	 * number of waiters to wake in 'utime' if cmd == FUTEX_WAKE_OP.
>> 	 */
>> 	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
>> 	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
>> 		val2 = (u32) (unsigned long) utime;
>>
>> 	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
>> }
>>
>> $ sed -n '/get_timespec64(/,/;/p' linux/include/linux/time.h
>> int get_timespec64(struct timespec64 *ts,
>> 		const struct __kernel_timespec __user *uts);
>>
>> ...
>>
>> Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
>> ---
>>
>> Hello Thomas & Ingo,
>>
>> I'm sorry I couldn't test the change in my computers,
>> as there is a bug since Linux 5.7 where I can't boot
>> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=974166).
>>
>> Alex
>>
>>  kernel/futex.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/futex.c b/kernel/futex.c
>> index 00259c7e288e..28577c7d2805 100644
>> --- a/kernel/futex.c
>> +++ b/kernel/futex.c
>> @@ -3792,8 +3792,8 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
>>  
>>  
>>  SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
>> -		struct __kernel_timespec __user *, utime, u32 __user *, uaddr2,
>> -		u32, val3)
>> +		const struct __kernel_timespec __user *, utime,
>> +		u32 __user *, uaddr2, u32, val3)
>>  {
>>  	struct timespec64 ts;
>>  	ktime_t t, *tp = NULL;
>>
> 
