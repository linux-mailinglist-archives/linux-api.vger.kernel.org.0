Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6E621ABEF
	for <lists+linux-api@lfdr.de>; Fri, 10 Jul 2020 02:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGJAT5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jul 2020 20:19:57 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35468 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgGJAT5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jul 2020 20:19:57 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 57E6A2A43C8
Subject: Re: [RFC v2 1/4] futex2: Add new futex interface
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, peterz@infradead.org
Cc:     krisman@collabora.com, kernel@collabora.com, dvhart@infradead.org,
        mingo@redhat.com, pgriffais@valvesoftware.com, fweimer@redhat.com,
        libc-alpha@sourceware.org, malteskarupke@web.de,
        linux-api@vger.kernel.org, arnd@arndb.de
References: <20200709175921.211387-1-andrealmeid@collabora.com>
 <20200709175921.211387-2-andrealmeid@collabora.com>
 <b505827d-252f-4325-db8e-047b8eb9c5fb@infradead.org>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Message-ID: <9d09639f-6821-8d21-d3cb-ec980338c4e8@collabora.com>
Date:   Thu, 9 Jul 2020 21:19:47 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b505827d-252f-4325-db8e-047b8eb9c5fb@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

On 7/9/20 9:09 PM, Randy Dunlap wrote:
> Hi,
> 
> On 7/9/20 10:59 AM, André Almeida wrote:
>>
>>
>> diff --git a/kernel/futex2.c b/kernel/futex2.c
>> new file mode 100644
>> index 000000000000..b87a10ba7c01
>> --- /dev/null
>> +++ b/kernel/futex2.c
>> @@ -0,0 +1,73 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * futex2 system call interface by André Almeida <andrealmeid@collabora.com>
>> + *
>> + * Copyright 2020 Collabora Ltd.
>> + */
>> +
>> +#include <linux/syscalls.h>
>> +
>> +#include <asm/futex.h>
>> +
>> +/*
>> + * Set of flags that futex2 operates. If we got something that is not in this
>> + * set, it can be a unsupported futex1 operation like BITSET or PI, so we
>> + * refuse to accept
>> + */
>> +#define FUTEX2_MASK (FUTEX_SIZE_MASK | FUTEX_PRIVATE_FLAG | FUTEX_CLOCK_REALTIME)
>> +
>> +/**
>> + * sys_futex_wait: Wait on a futex address if (*uaddr) == val
> 
> Function name line should use - as separator, not :, so
>  * sys_futex_wait - Wait on a futex address if (*uaddr) == val
> 
>> + * @uaddr: User address of futex
>> + * @val:   Expected value of futex
>> + * @flags: Checks if futex is private, the size of futex and the clockid
>> + * @timo:  Optional absolute timeout. Supports only 64bit time.
>> + */
>> +SYSCALL_DEFINE4(futex_wait, void __user *, uaddr, unsigned long, val,
>> +		unsigned long, flags, struct __kernel_timespec __user *, timo)
>> +{
>   ...
>> +}
>> +
>> +/**
>> + * sys_futex_wake: Wake a number of futexes waiting in an address
> 
> Same here:
>  * sys_futex_wake - Wake a number of futexes waiting in an address
> 
> or could it be "on an address":
>  * sys_futex_wake - Wake a number of futexes waiting on an address
> 
>> + * @uaddr:   Address of futex to be woken up
>> + * @nr_wake: Number of futexes to be woken up
>> + * @flags:   Checks if futex is private and the size of futex
>> + */
>> +SYSCALL_DEFINE3(futex_wake, void __user *, uaddr, unsigned int, nr_wake,
>> +		unsigned long, flags)
>> +{
> 

Both changes applied for v3, thanks for the feedback.

> 
> thanks.
> 

