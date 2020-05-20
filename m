Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50E51DAD26
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2020 10:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETIWO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 May 2020 04:22:14 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:46074 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbgETIWN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 May 2020 04:22:13 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 36B272E15D2;
        Wed, 20 May 2020 11:22:10 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id qWncYU4vfQ-M8TSm8Ge;
        Wed, 20 May 2020 11:22:10 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1589962930; bh=X96Uw2L+REBtZsBYuhXcIA170g1njmPsYoLuNgo9Yr0=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=QzeIZdQrC/aKYzxPtZYUcPnkBfxq8OMpr6nOxCVO28jq8kqmp/8D/mL+OFRGfhVQ6
         x0TGummHXjAQMPenYTs0qb9++h2MDWfh6Ruh9h1tJ04miiw1TvzYG4nWoO86aNvm49
         ZqdT9s/RimBRZhSKVEBzoja6HMDA2++ScM42ITJ4=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:704::1:9])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gJswpWQIQn-M8Xe24Cd;
        Wed, 20 May 2020 11:22:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] futex: send SIGBUS if argument is not aligned on a
 four-byte boundary
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Maxim Samoylov <max7255@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
References: <158955700764.647498.18025770126733698386.stgit@buzz>
 <87sgfv5yfv.fsf@nanos.tec.linutronix.de>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1fac8d40-fb00-f09f-8b13-2348d0cd74a2@yandex-team.ru>
Date:   Wed, 20 May 2020 11:22:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87sgfv5yfv.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 20/05/2020 01.53, Thomas Gleixner wrote:
> Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:
> 
>> Userspace implementations of mutexes (including glibc) in some cases
>> retries operation without checking error code from syscall futex.
>> This is good for performance because most errors are impossible when
>> locking code trusts itself.
> 
> This argument is blantantly wrong. It's the justification for bad
> programming. Code ignoring error returns is simply buggy.

I knew you'll love it. =)

> 
>> Some errors which could came from outer code are handled automatically,
>> for example invalid address triggers SIGSEGV on atomic fast path.
>>
>> But one case turns into nasty busy-loop: when address is unaligned.
>> futex(FUTEX_WAIT) returns EINVAL immediately and loop goes to retry.
> 
> Why is that something the kernel has to care about? The kernel returns
> EINVAl as documented and when user space decides to ignore then it goes
> to retry for a full timeslice for nothing.
> 
> You have to come up with a better argument why we want to send a signal
> here.
> 
> Along with an argument why SIGBUS is the right thing when a user space
> fast path violation results in a SIGSEGV as you stated above.

SIGSEGV comes only if address points to unmapped area.
This case doesn't need special care unlike to misaligned address.

> 
> Plus a patch which documents this change in the futex man page.

Yep, will do.

> 
>> Example which loops inside second call rather than hung peacefully:
>>
>> #include <stdlib.h>
>> #include <pthread.h>
>>
>> int main(int argc, char **argv)
>> {
>> 	char buf[sizeof(pthread_mutex_t) + 1];
>> 	pthread_mutex_t *mutex = (pthread_mutex_t *)(buf + 1);
>>
>> 	pthread_mutex_init(mutex, NULL);
>> 	pthread_mutex_lock(mutex);
>> 	pthread_mutex_lock(mutex);
>> }
> 
> And this broken code is a kernel problem because?

That's just distilled example how pthread primitives works
when application passes misaligned pointer.

> 
>> It seems there is no practical usage for calling syscall futex for
>> unaligned address. This may be only bug in user space. Let's help and
>> handle this gracefully without adding extra code on fast path.
> 
> How does that help?
> 
> Are you going to stick SIGBUS in _ALL_ syscalls which might be retried
> in a loop just because user space fails to evaluate the error code
> properly?
> 
> You have to come up with a better argument to justify this change.

This particular case is important because buggy code is in glibc.
Definitely most frequently used library ever.  Musl is buggy too.

Bug is here for ages and it took another decade to spread update.
In modern containerized setup kernel updates much more frequently.

All this hides bugs: application might recover from loop
if another thread unlock mutex from atomic fast path.
But mutex works as spin-lock wasting cpu time.

So, these few lines of code might prevent significant CO2 emission =)

> 
>> This patch sends SIGBUS signal to slay task and break busy-loop.
> 
> I'm pretty sure that I asked you to read and follow documentation
> before. If I did not:
> 
>   git grep 'This patch' Documentation/process/

Force of habit. =/
Definitely should be in checkpatch.pl

> 
> Thanks,
> 
>          tglx
