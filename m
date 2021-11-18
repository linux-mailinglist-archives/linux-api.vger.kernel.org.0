Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6552456089
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 17:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbhKRQgB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 11:36:01 -0500
Received: from mail.efficios.com ([167.114.26.124]:54036 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbhKRQgB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 11:36:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1F8D239D8B8;
        Thu, 18 Nov 2021 11:33:00 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 98czGaYCWtIJ; Thu, 18 Nov 2021 11:32:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8D56939D965;
        Thu, 18 Nov 2021 11:32:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8D56939D965
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1637253179;
        bh=NfC4SSSNEWA1jBKBwHifZUCh2EDmIoC+7MtCcUQxMRA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JNT2/NqtOAD3fQ/8tkaPO8C4uLBW6bgbNSoJpqGdGUVU87zCG37Xn3RYosEpfTCrL
         0x9kjcLu26dchdZs9TwnRoq/MlnjmMYMPh1Hx4ESYALro/vY/JltRchOt6AT2CGB3n
         SF9LWJuBHclrPv/+3BAHsKxfWqyXKve/TuD68ioW6eTQ7Ob0CD59AUXYKeBajv81qA
         k8S6Nx8nSQy7KKZe2Zizxo0NLHSQmPQl7Q75ih1MjVQ7PQInM+bu1AKM7kTVAwQ+Ss
         oymdKCB7o4rHgQr7/unYDXzUyTACSTpnknhPy4Xn4YEIci0cwOK2wb9kpcR/+xoRtM
         zhqEZ74O98wNQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sAlC-7dcRbCd; Thu, 18 Nov 2021 11:32:59 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7992139DBD5;
        Thu, 18 Nov 2021 11:32:59 -0500 (EST)
Date:   Thu, 18 Nov 2021 11:32:59 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Rich Felker <dalias@libc.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <233151767.18864.1637253179376.JavaMail.zimbra@efficios.com>
In-Reply-To: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
References: <87wnl5u5rz.fsf@oldenburg.str.redhat.com>
Subject: Re: Bringing rseq back into glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4156)
Thread-Topic: Bringing rseq back into glibc
Thread-Index: BCp9HxcX96tED5pshHeBgBFdPtjasA==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Nov 18, 2021, at 5:17 AM, Florian Weimer fweimer@redhat.com wrote:

> I would like to bring back rseq for glibc 2.35.

That's excellent news ! Thanks for looking into this.

> I propose the following steps:
> 
> 1. Enable rseq registration in glibc, for internal use only.  This time,
>   put the rseq area into struct pthread, not into a initial-exec TLS
>   symbol.  (This helps to avoid with initial-exec TLS bloat with dlopen
>   and simplifies initialization somewhat.)

That works for me.

> 
> 2. Add a tunable to disable rseq registration in glibc.  This way, if
>   there is already an rseq user, it can be made to work again by
>   setting the tunable.

Out of curiosity, how is the glibc tunable exposed ? Can it be called
from the application, or is it an environment variable which needs to
be set before running the application ?

> 
> 3. Implement sched_getcpu on top of rseq.
> 
> 4. Add public symbols __rseq_abi_offset, __rseq_abi_size (currently 32
>   or 0), __rseq_abi_flags (currently 0).  __rseq_abi_offset is the
>   offset to add to the thread pointer (see __builtin_thread_pointer) to
>   get to the rseq area.  They will be public ABI symbols.  These
>   variables are initialized before user code runs, and changing the
>   results in undefined behavior.

Works for me. So if the Linux kernel eventually implements something along
the lines of an extensible kTLS, we can could use that underneath.

Small bike-shedding comment: I wonder if we want those public glibc
symbols to be called "__rseq_abi_{offset,size,flags}", or if a name like
"__ktls_{offset,size,flags}" might be more appropriate and future-proof
from a glibc ABI standpoint ?

> 
> Under this model, the rseq area offset is clearly constant across all
> threads.  (This was previously implied by using initial-exec TLS
> memory.)  rseq registration failure is indicated by __rseq_abi_size ==
> 0.  If the size is non-zero, rseq will be registered on all threads
> created by glibc, and all the time as far as user code is concernes.
> (This assumes that if rseq registration succeeds on the main thread, it
> will succeed on all other threads.  We will terminate the process if
> not.)  For example, if a JIT compiler sees __rseq_abi_size >= 32, in
> generated code, it can inline a version of sched_getcpu that
> materializes the thread pointer and loads the cpu_id field from the rseq
> area, without further checks.  Under the old TLS-based model, it was
> less clear that this was a valid optimization.

Sounds good.

Note that multiple applications wishing to use rseq on a shared memory
area may find themselves in a situation where some applications support
rseq, and others don't. So it would be up to the application to negotiate
whether they can use rseq in a shared memory area or not.

> 
> Furthermore, I believe this approach will be more compatible with
> potential future kernel changes in this area.  If the kernel tells us
> some day through the auxiliary vector that we should register a 128-byte
> rseq area with 64-byte alignment, we can make that happen and change
> __rseq_abi_offset and __rseq_abi_size accordingly.

Yes, hence my question about __ktls_* naming for the glibc symbols.

> 
> Steps 1 to 3 are backportable to previous glibc version, especially to
> 2.34 with its integrated libpthread.

So if we have an application or library already using rseq directly through
the system call, upgrading glibc may cause it to fail. Arguably, no new
symbol are exposed, so I guess it's OK with the backport guide-lines.
My question here is: is it OK for a backported patch to break an
application which uses the Linux kernel system calls directly ?

> 
> Comments?  As I said, I'd like to bring these changes into glibc 2.35,
> hopefully in early December.

I won't have time to do the implementation effort myself this time due to
other commitments, but I will try to free up some time for review. Feel
free to grab whatever code you feel is useful from my earlier rseq
integration patches (if any).

Thanks,

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
