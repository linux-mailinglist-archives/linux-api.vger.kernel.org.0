Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F0927B332
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgI1R3y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 13:29:54 -0400
Received: from mail.efficios.com ([167.114.26.124]:53480 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgI1R3y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 13:29:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0A6602E8BDA;
        Mon, 28 Sep 2020 13:29:53 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yFNY_omDYOTz; Mon, 28 Sep 2020 13:29:52 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 86DAD2E8F04;
        Mon, 28 Sep 2020 13:29:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 86DAD2E8F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1601314192;
        bh=AeJ9hA06ovRwyG6auHjZ8QjPn+h6FMAAV/yFhO56FUA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YX2IYlT9W1OMvZ8cHPBKP6J9B1UlejlGlJAoXcJJW7bnivYsUNVqrdYo4p/vUISeL
         bYgGlhRdB3QtJKRsN2/r1Tx9P+wpa2LmtYxQ/eTul2tERFvXrLOtPh0I2ZJMWeKsno
         lt4nYjoTfCae1fdXUIef/WAthhkP1FA5KAIRpEoWdQghidT/8fGOXuBAGzsdvRdvyA
         Xur1ziaeYKriufnJRprP8Ez2vfGKpicKGcrZU/4r5x701l+HvmPNFLsQKh9p/6vP3A
         NtdytkAbmFukqkVmDNDou0LRd1oG1FV7ci/cOgRKU1d4oBBM4+heN+Ah0gbsGdJeAZ
         ENmS9hRgYBlNA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1slh_VvKXk4l; Mon, 28 Sep 2020 13:29:52 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 754A32E8F01;
        Mon, 28 Sep 2020 13:29:52 -0400 (EDT)
Date:   Mon, 28 Sep 2020 13:29:52 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <905713397.71512.1601314192367.JavaMail.zimbra@efficios.com>
In-Reply-To: <87r1qm2atk.fsf@oldenburg2.str.redhat.com>
References: <20200925181518.4141-1-mathieu.desnoyers@efficios.com> <87r1qm2atk.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH 1/2] rseq: Implement KTLS prototype for x86-64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3965 (ZimbraWebClient - FF80 (Linux)/8.8.15_GA_3963)
Thread-Topic: rseq: Implement KTLS prototype for x86-64
Thread-Index: kkGWs2bJIvZZIFVzADW4JHcbF8Z8JQ==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Sep 28, 2020, at 11:13 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> Upstreaming efforts aiming to integrate rseq support into glibc led to
>> interesting discussions, where we identified a clear need to extend the
>> size of the per-thread structure shared between kernel and user-space
>> (struct rseq).  This is something that is not possible with the current
>> rseq ABI.  The fact that the current non-extensible rseq kernel ABI
>> would also prevent glibc's ABI to be extended prevents its integration
>> into glibc.
>>
>> Discussions with glibc maintainers led to the following design, which we
>> are calling "Kernel Thread Local Storage" or KTLS:
>>
>> - at glibc library init:
>>   - glibc queries the size and alignment of the KTLS area supported by the
>>     kernel,
>>   - glibc reserves the memory area required by the kernel for main
>>     thread,
>>   - glibc registers the offset from thread pointer where the KTLS area
>>     will be placed for all threads belonging to the threads group which
>>     are created with clone3 CLONE_RSEQ_KTLS,
>> - at nptl thread creation:
>>   - glibc reserves the memory area required by the kernel,
>> - application/libraries can query glibc for the offset/size of the
>>   KTLS area, and offset from the thread pointer to access that area.
> 
> One remaining challenge see is that we want to use vDSO functions to
> abstract away the exact layout of the KTLS area.  For example, there are
> various implementation strategies for getuid optimizations, some of them
> exposing a shared struct cred in a thread group, and others not doing
> that.
> 
> The vDSO has access to the thread pointer because it's ABI (something
> that we recently (and quite conveniently) clarified for x86).  What it
> does not know is the offset of the KTLS area from the thread pointer.
> In the original rseq implementation, this offset could vary from thread
> to thread in a process, although the submitted glibc implementation did
> not use this level of flexibility and the offset is constant.  The vDSO
> is not relocated by the run-time dynamic loader, so it can't use ELF TLS
> data.

In the context of this prototype, the KTLS offset is the same for all threads
belonging to a thread group.

> 
> Furthermore, not all threads in a thread group may have an associated
> KTLS area.  In a potential glibc implementation, only the threads
> created by pthread_create would have it; threads created directly using
> clone would lack it (and would not even run with a correctly set up
> userspace TCB).

Right.

> 
> So we have a bootstrap issue here that needs to be solved, I think.

The one thing I'm not sure about is whether the vDSO interface is indeed
superior to KTLS, or if it is just the model we are used to.

AFAIU, the current use-cases for vDSO is that an application calls into
glibc, which then calls the vDSO function exposed by the kernel. I wonder
whether the vDSO indirection is really needed if we typically have a glibc
function used as indirection ? For an end user, what is the benefit of vDSO
over accessing KTLS data directly from glibc ?

If we decide that using KTLS from a vDSO function is indeed a requirement,
then, as you point out, the thread_pointer is available as ABI, but we miss
the KTLS offset.

Some ideas on how we could solve this: we could either make the KTLS
offset part of the ABI (fixed offset), or save the offset near the thread pointer
at a location that would become ABI. It would have to be already populated with
something which can help detect the case where a vDSO is called from a thread
which does not populate KTLS though. Is that even remotely doable ?

> 
> In most cases, I would not be too eager to bypass the vDSO completely,
> and having the kernel expose a data-only interface.  I could perhaps
> make an exception for the current TID because that's so convenient to
> use in mutex implementations, and errno.

Indeed, using a KTLS field to store errno is another use-case I forgot to
mention. That would make life easier for errno handling in vDSO as well.

> With the latter, we could
> directly expose the vDSO implementation to applications, assuming that
> we agree that the vDSO will not fail with ENOSYS to request fallback to
> the system call, but will itself perform the system call.

We should not forget the fields needed by rseq as well: the rseq_cs pointer and
the cpu_id fields need to be accessed directly from the rseq critical section,
without function call. Those use-cases require that applications and library can
know the KTLS offset and size and use those fields directly. That being said,
there are certainly plenty of use-cases where it makes sense to use the KTLS
data through a vDSO, and only expose the vDSO interface, if the cost of the
extra vDSO call indirection is not prohibitive.

Thanks,

Mathieu

> 
> Thanks,
> Florian
> --
> Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
> Commercial register: Amtsgericht Muenchen, HRB 153243,
> Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
