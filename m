Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDF23F11FF
	for <lists+linux-api@lfdr.de>; Thu, 19 Aug 2021 05:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhHSDjr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 23:39:47 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbhHSDjS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 23:39:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 555FA1F439A2
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>
Subject: Re: [PATCH 2/4] futex2: Implement vectorized wait
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        malteskarupke@fastmail.fm, malteskarupke@web.de,
        Peter Oskolkov <posk@posk.io>,
        Andrey Semashev <andrey.semashev@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
 <20210805190405.59110-3-andrealmeid@collabora.com> <87v94310gm.ffs@tglx>
 <20210818162034.GA26408@worktop.programming.kicks-ass.net>
 <87k0ki1qr8.ffs@tglx>
Message-ID: <20072f5b-aa21-339f-5368-be10e76b2e47@collabora.com>
Date:   Thu, 19 Aug 2021 00:38:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87k0ki1qr8.ffs@tglx>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Às 16:45 de 18/08/21, Thomas Gleixner escreveu:
> On Wed, Aug 18 2021 at 18:20, Peter Zijlstra wrote:
>> On Wed, Aug 18, 2021 at 01:00:57PM +0200, Thomas Gleixner wrote:
>>>> +/**
>>>> + * struct futex_waitv - A waiter for vectorized wait
>>>> + * @val:   Expected value at uaddr
>>>> + * @uaddr: User address to wait on
>>>> + * @flags: Flags for this waiter
>>>> + */
>>>> +struct futex_waitv {
>>>> +	__u64 val;
>>>
>>> Again. Why u64?
>>
>> So I think the idea was that if we're going to do new syscalls, we
>> should cater for future extentions, one of which was 64bit futexes (for
>> 64bit archs) (along with u{8,16,32})
>>
>> The previous set of patches implemented a more complete replacement ABI
>> -- which I rather liked, however the implementation was completely
>> disjoint from the existing futexes, which was a non-starter for me.
>>
>> Anyway, yes, current futexes are u32, but if we want to ever do u64
>> futexes, we should either do this syscall with a u64, or already plan to
>> retire the whole syscall.
>>
>> Obiously this would've made good Changelog material, but alas it wasn't
>> there.
> 
> Fair enough, but OTOH 64bit futexes for 64bit architectures: What's
> exactly the point? Just because 64bit architectures can implement it is
> not really a good reason. Where is the use case and the benefit and
> what's the workaround for 32bit user space / architectures?
> 
> I'm not opposed against variable sized futexes in principle, but they
> come with limitations and we end up with tons of sanity checks and
> exclusions all over the place.
> 
> The 32bit futexes have a charm as they just work for all architectures
> and the interaction with PI and robust list is trivial and well
> established.
> 
> I serioulsy doubt that 8 and 16 bit futexes can be actually used for
> locking in a meaningful way. If they are purely wait/wake then the
> question is whether they actually fit into futex in the first place or
> just happen to be implementable via futexes.

This is the feedback that I have collected from the community about
variable sized futex:

- At Boost Libraries, futex is used as back end to implement atomic
primitives for some architectures. It works fine for 32-bit futexes, but
for other sizes it "must use an internal lock pool to implement waiting
and notifying operations, which increases thread contention. For
inter-process atomics, this means that waiting must be done using a spin
loop, which is terribly inefficient."[0]

- glibc’s rwlock implementation "uses a torn 32-bit futex read which is
part of an atomically updated 64-bit word".[1]

- Peter Oskolkov[2] pointed out that for 64-bit platforms it would be
useful to do atomic operations in pointer values: "imagine a simple
producer/consumer scenario, with the producer updating some shared
memory data and waking the consumer. Storing the pointer in the futex
makes it so that only one shared memory location needs to be accessed
atomically".

- The original proposal[3] to support 8-bit and 16-bit futexes had some
use cases as well: "Having mutexes that are only one byte in size was
the first reason WebKit mentioned for re-implementing futexes in a
library" and "The C++ standard added futexes to the standard library in
C++20 under the name atomic_wait and atomic_notify. The C++20 version
supports this for atomic variables of any size. The more sizes we can
support, the better the implementation can be in the standard library."

[0] https://lists.boost.org/Archives/boost/2021/05/251508.php

[1]
https://lore.kernel.org/lkml/20210603195924.361327-1-andrealmeid@collabora.com/T/#m37bfbbd6ac76c121941defd1daea774389552674

[2]
https://lore.kernel.org/lkml/CAFTs51XAr2b3DmcSM4=qeU5cNuh0mTxUbhG66U6bc63YYzkzYA@mail.gmail.com/

[3]
https://lore.kernel.org/lkml/20191204235238.10764-1-malteskarupke@web.de/

