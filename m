Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932F621F250
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGNNTx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 09:19:53 -0400
Received: from mail.efficios.com ([167.114.26.124]:32892 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGNNTw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 09:19:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EB1382BE60C;
        Tue, 14 Jul 2020 09:19:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xayI0xZlvxfa; Tue, 14 Jul 2020 09:19:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id AB7BC2BE165;
        Tue, 14 Jul 2020 09:19:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com AB7BC2BE165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594732791;
        bh=0UYHQAplI6ZwH5L2kpETJucy62xyxgvLq0FyGt1NMmw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nH06SGdjfmW9ixdEhn/cxqRbbYOTuhL6feo8kzlzBrXu0L3Gx7v55+Gcwp43jrwSY
         Ktqd6F0NqANCXdPzyBHygs4TvxST+/epA7EKEQbO0qO8Q5sCJg7rU86EgGqvB4Rx/M
         ClXml5+aXGGcjAyMEmv6DTTIcn89P3a9YvcVM0KorYkA+4uH4c0piDnfM1cqfxWt8e
         Nhzi/Xjx4OUx3Q5CzujQHH+3TkOWT5451EZwDIW77hxnxBs7J/xk2N9pMz/F/s4WkQ
         Rm6fqmuut4X4aNrTutD+uGOnU6GE2NCycpufi2Nm2w9uEpHV1V/zL2ZNH0Jx2xwX5b
         688EYkhhDEdAw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SyMSwQmj9d-i; Tue, 14 Jul 2020 09:19:51 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9C09B2BE164;
        Tue, 14 Jul 2020 09:19:51 -0400 (EDT)
Date:   Tue, 14 Jul 2020 09:19:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Message-ID: <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com>
In-Reply-To: <87a7028d5u.fsf@oldenburg2.str.redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <20200714030348.6214-3-mathieu.desnoyers@efficios.com> <87mu42bepq.fsf@oldenburg2.str.redhat.com> <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com> <87a7028d5u.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Allow extending struct rseq
Thread-Index: 9tyJaU9TMeuq2KdCvH7TV6HBMkiNfw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 14, 2020, at 9:00 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>>> How are extensions going to affect the definition of struct rseq,
>>> including its alignment?
>>
>> The alignment will never decrease. If the structure becomes large enough
>> its alignment could theoretically increase. Would that be an issue ?
> 
> Telling the compiler that struct is larger than it actually is, or that
> it has more alignment than in memory, results in undefined behavior,
> even if only fields are accessed in the smaller struct region.
> 
> An increase in alignment from 32 to 64 is perhaps not likely to have
> this effect.  But the undefined behavior is still there, and has been
> observed for mismatches like 8 vs 16.

Good points.

> 
>>> As things stand now, glibc 2.32 will make the size and alignment of
>>> struct rseq part of its ABI, so it can't really change after that.
>>
>> Can the size and alignment of a structure be defined as minimum alignment
>> and size values ? For instance, those would be invariant for a given glibc
>> version (if we always use the internal struct rseq declaration), but could
>> be increased in future versions.
> 
> Not if we are talking about a global (TLS) data symbol.  No such changes
> are possible there.  We have some workarounds for symbols that live
> exclusively within glibc, but they don't work if there are libraries out
> there which interpose the symbol.

OK

> 
>>> With a different approach, we can avoid making the symbol size part of
>>> the ABI, but then we cannot use the __rseq_abi TLS symbol.  As a result,
>>> interoperability with early adopters would be lost.
>>
>> Do you mean with a function "getter", and then keeping that pointer around
>> in a per-user TLS ? I would prefer to avoid that because it adds an extra
>> pointer dereference on a fast path.
> 
> My choice would have been a function that returns the offset from the
> thread pointer (which has to be unchanged regarding all threads).

So AFAIU we would have glibc expose a symbol, e.g.:

off_t rseq_tls_offset(void);

Which would be typically called by user libraries and applications at initialization
to get the offset of the struct rseq. They should store it in a static variable so
rseq critical sections can use that offset.

Is there an arch-agnostic way to get the thread pointer from user-space code ? That
would be needed by all rseq critical section implementations.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
