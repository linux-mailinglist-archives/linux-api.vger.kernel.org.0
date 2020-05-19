Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935AC1DA506
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2020 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgESWxb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 May 2020 18:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESWxb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 May 2020 18:53:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E352DC061A0E;
        Tue, 19 May 2020 15:53:30 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbB6y-0003lX-Nc; Wed, 20 May 2020 00:53:25 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 30B81100D00; Wed, 20 May 2020 00:53:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Maxim Samoylov <max7255@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] futex: send SIGBUS if argument is not aligned on a four-byte boundary
In-Reply-To: <158955700764.647498.18025770126733698386.stgit@buzz>
References: <158955700764.647498.18025770126733698386.stgit@buzz>
Date:   Wed, 20 May 2020 00:53:24 +0200
Message-ID: <87sgfv5yfv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:

> Userspace implementations of mutexes (including glibc) in some cases
> retries operation without checking error code from syscall futex.
> This is good for performance because most errors are impossible when
> locking code trusts itself.

This argument is blantantly wrong. It's the justification for bad
programming. Code ignoring error returns is simply buggy.

> Some errors which could came from outer code are handled automatically,
> for example invalid address triggers SIGSEGV on atomic fast path.
>
> But one case turns into nasty busy-loop: when address is unaligned.
> futex(FUTEX_WAIT) returns EINVAL immediately and loop goes to retry.

Why is that something the kernel has to care about? The kernel returns
EINVAl as documented and when user space decides to ignore then it goes
to retry for a full timeslice for nothing.

You have to come up with a better argument why we want to send a signal
here.

Along with an argument why SIGBUS is the right thing when a user space
fast path violation results in a SIGSEGV as you stated above.

Plus a patch which documents this change in the futex man page.

> Example which loops inside second call rather than hung peacefully:
>
> #include <stdlib.h>
> #include <pthread.h>
>
> int main(int argc, char **argv)
> {
> 	char buf[sizeof(pthread_mutex_t) + 1];
> 	pthread_mutex_t *mutex = (pthread_mutex_t *)(buf + 1);
>
> 	pthread_mutex_init(mutex, NULL);
> 	pthread_mutex_lock(mutex);
> 	pthread_mutex_lock(mutex);
> }

And this broken code is a kernel problem because?

> It seems there is no practical usage for calling syscall futex for
> unaligned address. This may be only bug in user space. Let's help and
> handle this gracefully without adding extra code on fast path.

How does that help?

Are you going to stick SIGBUS in _ALL_ syscalls which might be retried
in a loop just because user space fails to evaluate the error code
properly?

You have to come up with a better argument to justify this change.

> This patch sends SIGBUS signal to slay task and break busy-loop.

I'm pretty sure that I asked you to read and follow documentation
before. If I did not:

 git grep 'This patch' Documentation/process/

Thanks,

        tglx
