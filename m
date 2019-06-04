Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD52345C9
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfFDLqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 4 Jun 2019 07:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbfFDLqV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 4 Jun 2019 07:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD7A630C084B;
        Tue,  4 Jun 2019 11:46:15 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D23467269;
        Tue,  4 Jun 2019 11:46:05 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup and thread creation (v10)
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com>
        <87h89gjgaf.fsf@oldenburg2.str.redhat.com>
        <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com>
        <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
        <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com>
        <875zprm4jo.fsf@oldenburg2.str.redhat.com>
        <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com>
        <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
        <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com>
Date:   Tue, 04 Jun 2019 13:46:04 +0200
In-Reply-To: <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 31 May 2019 14:10:57 -0400
        (EDT)")
Message-ID: <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 04 Jun 2019 11:46:21 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On May 31, 2019, at 11:46 AM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>> 
>>> Let's break this down into the various sub-issues involved:
>>>
>>> 1) How early do we need to setup rseq ? Should it be setup before:
>>>    - LD_PRELOAD .so constructors ?
>>>      - Without circular dependency,
>>>      - With circular dependency,
>>>    - audit libraries initialization ?
>>>    - IFUNC resolvers ?
>>>    - other callbacks ?
>>>    - memory allocator calls ?
>>>
>>> We may end up in a situation where we need memory allocation to be setup
>>> in order to initialize TLS before rseq can be registered for the main
>>> thread. I suspect we will end up needing a fallbacks which always work
>>> for the few cases that would try to use rseq too early in dl/libc startup.
>> 
>> I think the answer to that depends on whether it's okay to have an
>> observable transition from “no rseq kernel support” to “kernel supports
>> rseq”.
>
> As far as my own use-cases are concerned, I only care that rseq is initialized
> before LD_PRELOAD .so constructors are executed.

<https://sourceware.org/bugzilla/show_bug.cgi?id=14379> is relevant in
this context.  It requests the opposite behavior from LD_PRELOAD.

> There appears to be some amount of documented limitations for what can be
> done by the IFUNC resolvers. It might be acceptable to document that rseq
> might not be initialized yet when those are executed.

The only obstacle is that there are so many places where we could put
this information.

> I'd like to hear what others think about whether we should care about IFUNC
> resolvers and audit libraries using restartable sequences TLS ?

In audit libraries (and after dlmopen), the inner libc will have
duplicated TLS values, so it will look as if the TLS area is not active
(but a registration has happened with the kernel).  If we move
__rseq_handled into the dynamic linker, its value will be shared along
with ld.so with the inner objects.  However, the inner libc still has to
ensure that its registration attempt does not succeed because that would
activate the wrong rseq area.

The final remaining case is static dlopen.  There is a copy of ld.so on
the dynamic side, but it is completely inactive and has never run.  I do
not think we need to support that because multi-threading does not work
reliably in this scenario, either.  However, we should skip rseq
registration in a nested libc (see the rtld_active function).

>>> 4) Inability to touch a TLS variable (__rseq_abi) from ld-linux-*.so.2
>>>    - Should we extend the dynamic linker to allow such TLS variable to be
>>>      accessed ? If so, how much effort is required ?
>>>    - Can we find an alternative way to initialize rseq early during
>>>      dl init stages while still performing the TLS access from a function
>>>      implemented within libc.so ?
>> 
>> This is again related to the answer for (1).  There are various hacks we
>> could implement to make the initialization invisible (e.g., computing
>> the address of the variable using the equivalent of dlsym, after loading
>> all the initial objects and before starting relocation).  If it's not
>> too hard to add TLS support to ld.so, we can consider that as well.
>> (The allocation side should be pretty easy, relocation support it could
>> be more tricky.)
>> 
>>> So far, I got rseq to be initialized before LD_PRELOADed library
>>> constructors by doing the initialization in a constructor within
>>> libc.so. I don't particularly like this approach, because the
>>> constructor order is not guaranteed.
>> 
>> Right.
>
> One question related to use of constructors: AFAIU, if a library depends
> on glibc, ELF guarantees that the glibc constructor will be executed first,
> before the other library.

There are some exceptions, like DT_PREINIT_ARRAY functions and
DF_1_INITFIRST.  Some of these mechanisms we use in the implementation
itself, so they are not really usable to end users.  Cycles should not
come into play here.

By default, an object that uses the rseq area will have to link against
libc (perhaps indirectly), and therefore the libc constructor runs
first.

> Which leaves us with the execution order of constructors within libc.so,
> which is not guaranteed if we just use __attribute__ ((constructor)).
> However, all gcc versions that are required to build recent glibc
> seem to support a constructor with a "priority" value (lower gets
> executed first, and those are executed before constructors without
> priority).

I'm not sure that's the right way to do it.  If we want to happen
execution in a specific order, we should write a single constructor
function which is called from _init.  For the time being, we can add the
call to an appropriately defined inline function early in _init in
elf/init-first.c (which is shared with Hurd, so Hurd will need some sort
of stub function).

Thanks,
Florian
