Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4471D5601
	for <lists+linux-api@lfdr.de>; Fri, 15 May 2020 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgEOQ1b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 May 2020 12:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOQ1a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 May 2020 12:27:30 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00E9C061A0C;
        Fri, 15 May 2020 09:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aC9hyHleLo4vDUxT+Z5QeopjJNtSZOJdlvX7fJFebgc=; b=SDisOMoxxYtKbAHobnvGTQfe18
        I/euPce16QW5/Fu9jH2GrcWgGP2Tsuj1+B8LmQI1QTJstm2MhikZVoiYzczeTXpNFFno4u5Z2Abzy
        Jw51BzW/byw1yl+BIMGwsNRrUcqasuMn0voH8dv8JUFzG4IPgbZTk1O5GdaGnCZnYAdYAMSXyN7IP
        ikGqCsWmykoL9di/7l9bcWU7dBtprsxn3DxE0oxOYk37908e6P41JMwhuiZ6OEVNQsa2TluMHyzUU
        BFmAH7Kii0egxM/0i3grgMOMXHV0N78i4olzuoW9Q2dfPivXstNsEPVxdLb8Nw1nloQlQku59jkHw
        XVfxdwqA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZdAz-0006bN-58; Fri, 15 May 2020 16:27:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BBF17301A42;
        Fri, 15 May 2020 18:27:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A420020097509; Fri, 15 May 2020 18:27:07 +0200 (CEST)
Date:   Fri, 15 May 2020 18:27:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Maxim Samoylov <max7255@yandex-team.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] futex: send SIGBUS if argument is not aligned on a
 four-byte boundary
Message-ID: <20200515162707.GI2978@hirez.programming.kicks-ass.net>
References: <158955700764.647498.18025770126733698386.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158955700764.647498.18025770126733698386.stgit@buzz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 15, 2020 at 06:36:47PM +0300, Konstantin Khlebnikov wrote:
> Userspace implementations of mutexes (including glibc) in some cases
> retries operation without checking error code from syscall futex.
> This is good for performance because most errors are impossible when
> locking code trusts itself.
> 
> Some errors which could came from outer code are handled automatically,
> for example invalid address triggers SIGSEGV on atomic fast path.
> 
> But one case turns into nasty busy-loop: when address is unaligned.
> futex(FUTEX_WAIT) returns EINVAL immediately and loop goes to retry.
> 
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
> 
> It seems there is no practical usage for calling syscall futex for
> unaligned address. This may be only bug in user space. Let's help
> and handle this gracefully without adding extra code on fast path.
> 
> This patch sends SIGBUS signal to slay task and break busy-loop.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Reported-by: Maxim Samoylov <max7255@yandex-team.ru>

Seems like a sensible idea to me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/futex.c |   13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index b59532862bc0..8a6d35fa56bc 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -508,10 +508,21 @@ get_futex_key(u32 __user *uaddr, int fshared, union futex_key *key, enum futex_a
>  
>  	/*
>  	 * The futex address must be "naturally" aligned.
> +	 * Also send signal to break busy-loop if user-space ignore error.
> +	 * EFAULT case should trigger SIGSEGV at access from user-space.
>  	 */
>  	key->both.offset = address % PAGE_SIZE;
> -	if (unlikely((address % sizeof(u32)) != 0))
> +	if (unlikely((address % sizeof(u32)) != 0)) {
> +		struct kernel_siginfo info;
> +
> +		clear_siginfo(&info);
> +		info.si_signo = SIGBUS;
> +		info.si_code  = BUS_ADRALN;
> +		info.si_addr  = uaddr;
> +		force_sig_info(&info);
> +
>  		return -EINVAL;
> +	}
>  	address -= key->both.offset;
>  
>  	if (unlikely(!access_ok(uaddr, sizeof(u32))))
> 
