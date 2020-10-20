Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A532E294270
	for <lists+linux-api@lfdr.de>; Tue, 20 Oct 2020 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437595AbgJTSsB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Oct 2020 14:48:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:36852 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437713AbgJTSr7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Oct 2020 14:47:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C440C2DD550;
        Tue, 20 Oct 2020 14:47:57 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id icPB035Au0zd; Tue, 20 Oct 2020 14:47:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3E6482DD726;
        Tue, 20 Oct 2020 14:47:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3E6482DD726
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603219677;
        bh=0G55Jjn+yLDTEo95H/YMY9F6JPADwDSbuwGNt0k6SXk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OTU3/AMQIYUoqdwfh2PdKV1GQ7jHj34ZYf2SlbsgfYtKVThUkR9TV6v9jpF1dhrRH
         zOCKlMnhzptwj/sxL12cHRwM3o+aiEa0xBqMpF9cPR6KIQ8Gqqd+sIhiQ4TIcaT5gH
         d6NJnVx8wlcwXwDrInz+0kHT52RErZbaJhsERQYSVGQ9/VUYqbRoNAEzs/8umtmJcZ
         mmzMYns6wop3n4zdP3aKqmJqGcVWei+D0hC+Q+yyXNJeN8I9Ixd4p1vp3YvfzVsJGz
         OFIGRUV/rA4lITr2cJlUWC0pmohrLkyRDRFGJ2vRlu5qNRAi5aQSWz6X3Yd3aofz5q
         Sv0vRFFWU3htg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dQDrfJVEjK7e; Tue, 20 Oct 2020 14:47:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 2DB262DD7A6;
        Tue, 20 Oct 2020 14:47:57 -0400 (EDT)
Date:   Tue, 20 Oct 2020 14:47:57 -0400 (EDT)
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
Message-ID: <1247061646.32339.1603219677094.JavaMail.zimbra@efficios.com>
In-Reply-To: <873631yp8t.fsf@oldenburg2.str.redhat.com>
References: <20200925181518.4141-1-mathieu.desnoyers@efficios.com> <87r1qm2atk.fsf@oldenburg2.str.redhat.com> <905713397.71512.1601314192367.JavaMail.zimbra@efficios.com> <873631yp8t.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH 1/2] rseq: Implement KTLS prototype for x86-64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: rseq: Implement KTLS prototype for x86-64
Thread-Index: i/hhmILYI0bX65bbHI+Ec7cJZSCn7Q==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Sep 29, 2020, at 4:13 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>>> So we have a bootstrap issue here that needs to be solved, I think.
>>
>> The one thing I'm not sure about is whether the vDSO interface is indeed
>> superior to KTLS, or if it is just the model we are used to.
>>
>> AFAIU, the current use-cases for vDSO is that an application calls into
>> glibc, which then calls the vDSO function exposed by the kernel. I wonder
>> whether the vDSO indirection is really needed if we typically have a glibc
>> function used as indirection ? For an end user, what is the benefit of vDSO
>> over accessing KTLS data directly from glibc ?
> 
> I think the kernel can only reasonably maintain a single userspace data
> structure.  It's not reasonable to update several versions of the data
> structure in parallel.

I disagree with your statement. Considering that the kernel needs to keep
ABI compatibility for whatever it exposes to user-space, claiming that it
should never update several versions of data structures exposed to user-space
in parallel means that once a data structure is exposed to user-space as ABI
in a certain way, it can never ever change in the future, even if we find
a better way to do things.

It makes more sense to allow multiple data structures to be updated
in parallel until older ones become deprecated/unused/irrelevant, at
which point those can be configured out at build time and eventually
phased out after years of deprecation. Having the ability to update multiple
data structures in user-space with replicated information is IMHO necessary
to allow creation of new/better accelerated ABIs.

> 
> This means that glibc would have to support multiple kernel data
> structures, and users might lose userspace acceleration after a kernel
> update, until they update glibc as well.  The glibc update should be
> ABI-compatible, but someone would still have to backport it, apply it to
> container images, etc.

No. If the kernel ever exposes a data structure to user-space as ABI,
then it needs to stay there, and not break userspace. Hence the need to
duplicate information provided to user-space if need be, so we can move
on to better ABIs without breaking the old ones.

> 
> What's worse, the glibc code would be quite hard to test because we
> would have to keep around multiple kernel versions to exercise all the
> different data structure variants.
> 
> In contrast, the vDSO code always matches the userspace data structures,
> is always updated at the same time, and tested together.  That looks
> like a clear win to me.

For cases where the overhead of vDSO is not an issue, I agree that it
makes things tidier than directly accessing a data structure. The
documentation of the ABI becomes much simpler as well.

> 
>> If we decide that using KTLS from a vDSO function is indeed a requirement,
>> then, as you point out, the thread_pointer is available as ABI, but we miss
>> the KTLS offset.
>>
>> Some ideas on how we could solve this: we could either make the KTLS
>> offset part of the ABI (fixed offset), or save the offset near the
>> thread pointer at a location that would become ABI. It would have to
>> be already populated with something which can help detect the case
>> where a vDSO is called from a thread which does not populate KTLS
>> though. Is that even remotely doable ?
> 
> I don't know.
> 
> We could decide that these accelerated system calls must only be called
> with a valid TCB.  That's unavoidable if the vDSO sets errno directly,
> so it's perhaps not a big loss.  It's also backwards-compatible because
> existing TCB-less code won't know about those new vDSO entrypoints.
> Calling into glibc from a TCB-less thread has always been undefined.
> TCB-less code would have to make direct, non-vDSO system calls, as today.
> 
> For discovering the KTLS offset, a per-process page at a fixed offset
> from the vDSO code (i.e., what real shared objects already do for global
> data) could store this offset.  This way, we could entirely avoid an ABI
> dependency.

Or as Andy mentioned, we would simply pass the ktls offset as argument to
the vDSO ? It seems simple enough. Would it fit all our use-cases including
errno ?

> 
> We'll see what will break once we have the correct TID after vfork. 8->
> glibc currently supports malloc-after-vfork as an extension, and
> a lot of software depends on it (OpenJDK, for example).

I am not sure to see how that is related to ktls ?

> 
>>> With the latter, we could
>>> directly expose the vDSO implementation to applications, assuming that
>>> we agree that the vDSO will not fail with ENOSYS to request fallback to
>>> the system call, but will itself perform the system call.
>>
>> We should not forget the fields needed by rseq as well: the rseq_cs
>> pointer and the cpu_id fields need to be accessed directly from the
>> rseq critical section, without function call. Those use-cases require
>> that applications and library can know the KTLS offset and size and
>> use those fields directly.
> 
> Yes, but those offsets could be queried using a function from the vDSO
> (or using a glibc interface, to simplify linking).

Good point!

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
