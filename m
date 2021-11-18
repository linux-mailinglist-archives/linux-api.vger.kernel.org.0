Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AFA4561D1
	for <lists+linux-api@lfdr.de>; Thu, 18 Nov 2021 18:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbhKRRzU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Nov 2021 12:55:20 -0500
Received: from mail.efficios.com ([167.114.26.124]:55680 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbhKRRzU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Nov 2021 12:55:20 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4E76B39EA25;
        Thu, 18 Nov 2021 12:52:19 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z-pOSSVYOkNG; Thu, 18 Nov 2021 12:52:18 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BC26E39E375;
        Thu, 18 Nov 2021 12:52:18 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BC26E39E375
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1637257938;
        bh=OwN2kLHrLKXUoM5AbBe9AHf66RH301G5MZLOh6pLalc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=sgYPflYmdqLW+eVilI8B0TjdxwJwfJ404PQKvFuViUdshaFNqmPfaGj4CVsttvLEB
         DBv4zRY4KU8rOFQZhZUT4chAcf92M25DUGgJVeqfuKAMoWY8vctXt0Xw3UuH1pTZiQ
         TGzaj6u4oD5fSEGTTD/RG0Wz7FysJMWoXgh9e7Tcpzbjt9Ko01r868ivU4VcG2/ZfU
         /T56UmHiUzel1p20A6usvRMK4qogS3KU5Sxljt54HLaP+NHPMUcJ0EG/6AEIiwmmfh
         FCJ4VXnKBZ8cBKSy6GDJ7eniRlkJyncrEg1VzfnXqOh0Zzk7wBfT7lLPhgbK+AgiCL
         MVBFeDEOUOPKQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5u2rbx-3LSwD; Thu, 18 Nov 2021 12:52:18 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A5EB539E6E4;
        Thu, 18 Nov 2021 12:52:18 -0500 (EST)
Date:   Thu, 18 Nov 2021 12:52:18 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-api <linux-api@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Rich Felker <dalias@libc.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Message-ID: <1640608916.19206.1637257938544.JavaMail.zimbra@efficios.com>
In-Reply-To: <87fsrtflpo.fsf@oldenburg.str.redhat.com>
References: <87wnl5u5rz.fsf@oldenburg.str.redhat.com> <233151767.18864.1637253179376.JavaMail.zimbra@efficios.com> <87fsrtflpo.fsf@oldenburg.str.redhat.com>
Subject: Re: Bringing rseq back into glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4156 (ZimbraWebClient - FF94 (Linux)/8.8.15_GA_4156)
Thread-Topic: Bringing rseq back into glibc
Thread-Index: hTxZgFylkkJl8gN/JW5bDmGx91grVQ==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Nov 18, 2021, at 11:54 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Nov 18, 2021, at 5:17 AM, Florian Weimer fweimer@redhat.com wrote:

[...]

> 
>>> 3. Implement sched_getcpu on top of rseq.
>>> 
>>> 4. Add public symbols __rseq_abi_offset, __rseq_abi_size (currently 32
>>>   or 0), __rseq_abi_flags (currently 0).  __rseq_abi_offset is the
>>>   offset to add to the thread pointer (see __builtin_thread_pointer) to
>>>   get to the rseq area.  They will be public ABI symbols.  These
>>>   variables are initialized before user code runs, and changing the
>>>   results in undefined behavior.
>>
>> Works for me. So if the Linux kernel eventually implements something along
>> the lines of an extensible kTLS, we can could use that underneath.
>>
>> Small bike-shedding comment: I wonder if we want those public glibc
>> symbols to be called "__rseq_abi_{offset,size,flags}", or if a name like
>> "__ktls_{offset,size,flags}" might be more appropriate and future-proof
>> from a glibc ABI standpoint ?
> 
> No, if the kTLS stuff arrives, it might have different sizes and
> offsets, and the rseq area is just a slice of that.  So the numbers
> could be different.  We could do things as you propose if rseq is
> guaranteed to be at the start of the kernel area, always, but do we know
> that yet?

You're right, we don't. So let's stick with __rseq_abi_.

> 
> Also, kTLS wille likely be called something else to avoid confusion with
> Kernel Transport Layer Security.  That's another reason to stick with
> __rseq_.

Yep.

> 
>>> Steps 1 to 3 are backportable to previous glibc version, especially to
>>> 2.34 with its integrated libpthread.
>>
>> So if we have an application or library already using rseq directly through
>> the system call, upgrading glibc may cause it to fail. Arguably, no new
>> symbol are exposed, so I guess it's OK with the backport guide-lines.
>> My question here is: is it OK for a backported patch to break an
>> application which uses the Linux kernel system calls directly ?
> 
> It depends. 8-)
> 
> I think we can get away with it because shipping software for deployment
> on other people's system must have a fallback path for non-rseq mode
> outside of specialized environments.  For the (hopefully) rare
> exceptions, we'll provide the tunable setting.

Fair enough.

> 
> We must have done it before with similar system calls (set_tid_address,
> set_robust_list).  But system call design tends to avoid creating new
> examples.  rseq is similar to set_tid_address and set_robust_list in
> that more or less has to be this way, with the single-user property.
> (Supporting multiple users is undesirable from a performance/complexity
> perspective.)

Right.

> 
>>> Comments?  As I said, I'd like to bring these changes into glibc 2.35,
>>> hopefully in early December.
>>
>> I won't have time to do the implementation effort myself this time due to
>> other commitments, but I will try to free up some time for review. Feel
>> free to grab whatever code you feel is useful from my earlier rseq
>> integration patches (if any).
> 
> I plan to reuse the architecture-specific marker constants from your
> version at least.  That's already going to save a lot of work.  Thanks.

You're welcome. Let me know if I can be of further assistance.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
