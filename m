Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80CF734CB7
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 17:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfFDP5y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 11:57:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:45566 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbfFDP5y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 11:57:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4C4CB234FD7;
        Tue,  4 Jun 2019 11:57:51 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Zp6BZiNExbXZ; Tue,  4 Jun 2019 11:57:50 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3EC9E234FC7;
        Tue,  4 Jun 2019 11:57:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3EC9E234FC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1559663870;
        bh=W2jdImb6kIMUSLl7hFGPg77zIGSS8POEJyXEdDpjCn8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nOlg5MsL+VlB9bLqn+88PkSIMr1Zs+aFQZ1Ta9ibMUJ02YB8XQxhL5YKaVDkh5u9M
         NdT++QkxVHCDJ2Q3sYSvMzohv1QvDgRqd4J/qXkN5ah+AnyTC7lhzYyOWR+QBG/oP4
         9AErFY+kv029DhIuXETZaVhRGGRY12V+wrkyQkn7P/XngJAKHCk9pmVXO6t9hwboqP
         9SjF1a92k3XRyzF5Z0FyLpLbXItxbQqbnuTXg6hDmQ1dSh96yVa/+fJk3v0H+I/tE5
         E7tcsn6Tkkem4drZIDadIVUF11iPXBCysM1BtYeicq5qdHpMoucypLz+0YDOf30x0r
         V6SulU3F2wHHg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 3ZrLWlYrLBqf; Tue,  4 Jun 2019 11:57:50 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 22D49234FBF;
        Tue,  4 Jun 2019 11:57:50 -0400 (EDT)
Date:   Tue, 4 Jun 2019 11:57:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
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
Message-ID: <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com>
In-Reply-To: <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com> <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com> <875zprm4jo.fsf@oldenburg2.str.redhat.com> <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com> <87muj2k4ov.fsf@oldenburg2.str.redhat.com> <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com> <87o93d4lqb.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: qOC3WlaZbEwJZoJXLOv6rJz7GkQdxA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 4, 2019, at 7:46 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
>=20
>> ----- On May 31, 2019, at 11:46 AM, Florian Weimer fweimer@redhat.com wr=
ote:
>>
>>> * Mathieu Desnoyers:
>>>=20
>>>> Let's break this down into the various sub-issues involved:
>>>>
>>>> 1) How early do we need to setup rseq ? Should it be setup before:
>>>>    - LD_PRELOAD .so constructors ?
>>>>      - Without circular dependency,
>>>>      - With circular dependency,
>>>>    - audit libraries initialization ?
>>>>    - IFUNC resolvers ?
>>>>    - other callbacks ?
>>>>    - memory allocator calls ?
>>>>
>>>> We may end up in a situation where we need memory allocation to be set=
up
>>>> in order to initialize TLS before rseq can be registered for the main
>>>> thread. I suspect we will end up needing a fallbacks which always work
>>>> for the few cases that would try to use rseq too early in dl/libc star=
tup.
>>>=20
>>> I think the answer to that depends on whether it's okay to have an
>>> observable transition from =E2=80=9Cno rseq kernel support=E2=80=9D to =
=E2=80=9Ckernel supports
>>> rseq=E2=80=9D.
>>
>> As far as my own use-cases are concerned, I only care that rseq is initi=
alized
>> before LD_PRELOAD .so constructors are executed.
>=20
> <https://sourceware.org/bugzilla/show_bug.cgi?id=3D14379> is relevant in
> this context.  It requests the opposite behavior from LD_PRELOAD.

This link is very interesting. It sheds some light into how a LD_PRELOAD us=
er
wants to override malloc.

Should we plan ahead for such scheme to override which library "owns" rseq
registration from a LD_PRELOAD library ? If so, then we would want glibc to
set __rseq_handled _after_ LD_PRELOAD ctors are executed.

However, this brings the following situation: lttng-ust can be LD_PRELOADed
into applications, and I intend to make it provide rseq registration *only =
if*
the glibc does not provide it.

As a brainstorm idea, one way around this would be to turn __rseq_handled i=
nto
a 4-states variable:

RSEQ_REG_UNSET =3D 0, -> no library handles rseq
RSEQ_REG_PREINIT =3D 1, -> libc supports RSEQ, initialization not done yet,
RSEQ_REG_LIBC =3D 2, -> libc supports RSEQ, owns registration,
RSEQ_REG_OVERRIDE =3D 3, -> LD_PRELOAD library owns registration.

So a lttng-ust LD_PRELOAD could manage rseq registration by setting
__rseq_handled =3D RSEQ_REG_OVERRIDE only after observing the state
RSEQ_REG_UNSET.

A LD_PRELOAD library wishing to override the libc rseq management should se=
t
__rseq_handled to RSEQ_REG_OVERRIDE after observing either UNSET or PREINIT=
.

>=20
>> There appears to be some amount of documented limitations for what can b=
e
>> done by the IFUNC resolvers. It might be acceptable to document that rse=
q
>> might not be initialized yet when those are executed.
>=20
> The only obstacle is that there are so many places where we could put
> this information.

If we postpone the actual rseq registration by glibc after LD_PRELOAD ctors
execution, I think it makes it clear that we have a part of the startup
which executes without rseq being registered:

(please let me know if I'm getting some things wrong in the following seque=
nces)

A) Startup sequence (glibc owns rseq):

                                  __rseq_handled          __rseq_abi (TLS)
                                  --------------          -----------------=
-----
                                  RSEQ_REG_UNSET          no TLS available
                                  RSEQ_REG_PREINIT
IFUNC resolvers,
audit libraries...
                                                          TLS becomes avail=
able
LD_PRELOAD ctors
glibc initialization              RSEQ_REG_LIBC
                                                          registered to ker=
nel by sys_rseq.


B) Startup sequence (LD_PRELOAD lttng-ust owns rseq, old glibc):

                                  __rseq_handled          __rseq_abi (TLS)
                                  --------------          -----------------=
-----
                                  RSEQ_REG_UNSET          no TLS available
IFUNC resolvers,
audit libraries...
                                                          TLS becomes avail=
able
LD_PRELOAD ctors                  RSEQ_REG_OVERRIDE
                                                          registered to ker=
nel by sys_rseq.


C) Startup sequence (LD_PRELOAD rseq override library owning rseq):

                                  __rseq_handled          __rseq_abi (TLS)
                                  --------------          -----------------=
-----
                                  RSEQ_REG_UNSET          no TLS available
                                  RSEQ_REG_PREINIT
IFUNC resolvers,
audit libraries...
                                                          TLS becomes avail=
able
LD_PRELOAD ctors                  RSEQ_REG_OVERRIDE
                                                          registered to ker=
nel by sys_rseq.
glibc initialization

>=20
>> I'd like to hear what others think about whether we should care about IF=
UNC
>> resolvers and audit libraries using restartable sequences TLS ?
>=20
> In audit libraries (and after dlmopen), the inner libc will have
> duplicated TLS values, so it will look as if the TLS area is not active
> (but a registration has happened with the kernel).  If we move
> __rseq_handled into the dynamic linker, its value will be shared along
> with ld.so with the inner objects.  However, the inner libc still has to
> ensure that its registration attempt does not succeed because that would
> activate the wrong rseq area.

Having an intermediate RSEQ_REG_PREINIT state covering the entire
duration where the inner libc is in use should do the trick to ensure
the duplicated TLS area is not used at that point.

The covered use-cases would be to override rseq registration ownership
from LD_PRELOADed libraries, but disallow it from IFUNC resolvers and
audit libraries.

As a consequence of this, rseq critical sections should be prepared
to use a fall-back mechanism (e.g. the cpu_opv system call I have been
trying to upstream) when they notice rseq is not yet initialized
for a rseq c.s. executed within a preinit stage, or very early/late
in a thread's lifetime. This is a requirement I have seen coming for
a while now. Testing for non-registered rseq is very straightforward
and fast to do on a fast-path through the __rseq_abi.cpu_id field:
it has a negative value if rseq is not registered for the current
thread.

>=20
> The final remaining case is static dlopen.  There is a copy of ld.so on
> the dynamic side, but it is completely inactive and has never run.  I do
> not think we need to support that because multi-threading does not work
> reliably in this scenario, either.  However, we should skip rseq
> registration in a nested libc (see the rtld_active function).

So for SHARED, if (!rtld_active ()), we should indeed leave the state of
__rseq_handled as it is, because we are within a nested inactive ld.so.

>=20
>>>> 4) Inability to touch a TLS variable (__rseq_abi) from ld-linux-*.so.2
>>>>    - Should we extend the dynamic linker to allow such TLS variable to=
 be
>>>>      accessed ? If so, how much effort is required ?
>>>>    - Can we find an alternative way to initialize rseq early during
>>>>      dl init stages while still performing the TLS access from a funct=
ion
>>>>      implemented within libc.so ?
>>>=20
>>> This is again related to the answer for (1).  There are various hacks w=
e
>>> could implement to make the initialization invisible (e.g., computing
>>> the address of the variable using the equivalent of dlsym, after loadin=
g
>>> all the initial objects and before starting relocation).  If it's not
>>> too hard to add TLS support to ld.so, we can consider that as well.
>>> (The allocation side should be pretty easy, relocation support it could
>>> be more tricky.)
>>>=20
>>>> So far, I got rseq to be initialized before LD_PRELOADed library
>>>> constructors by doing the initialization in a constructor within
>>>> libc.so. I don't particularly like this approach, because the
>>>> constructor order is not guaranteed.
>>>=20
>>> Right.
>>
>> One question related to use of constructors: AFAIU, if a library depends
>> on glibc, ELF guarantees that the glibc constructor will be executed fir=
st,
>> before the other library.
>=20
> There are some exceptions, like DT_PREINIT_ARRAY functions and
> DF_1_INITFIRST.  Some of these mechanisms we use in the implementation
> itself, so they are not really usable to end users.  Cycles should not
> come into play here.
>=20
> By default, an object that uses the rseq area will have to link against
> libc (perhaps indirectly), and therefore the libc constructor runs
> first.

If we agree on postponing the actual TLS registration _after_ LD_PRELOAD
ctors are executed, the problem becomes easier. We then only need to
move __rseq_handled to ld.so, and set it to a PREINIT state until we
eventually perform the TLS registration (after LD_PRELOAD ctors).

>=20
>> Which leaves us with the execution order of constructors within libc.so,
>> which is not guaranteed if we just use __attribute__ ((constructor)).
>> However, all gcc versions that are required to build recent glibc
>> seem to support a constructor with a "priority" value (lower gets
>> executed first, and those are executed before constructors without
>> priority).
>=20
> I'm not sure that's the right way to do it.  If we want to happen
> execution in a specific order, we should write a single constructor
> function which is called from _init.  For the time being, we can add the
> call to an appropriately defined inline function early in _init in
> elf/init-first.c (which is shared with Hurd, so Hurd will need some sort
> of stub function).

In my attempts, there were some cases where _init was not invoked before
LD_PRELOAD ctors, but I cannot remember which at this point. Anyhow, if
we choose to postpone the actual TLS registration after LD_PRELOAD ctors,
this becomes a non-issue.

We might want to rename the __rseq_handled symbol to a better name if
it becomes a 4-states variable, e.g. __rseq_reg_owner.

Thoughts ?

Thanks,

Mathieu


>=20
> Thanks,
> Florian

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
