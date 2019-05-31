Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432603146B
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 20:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfEaSLA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 14:11:00 -0400
Received: from mail.efficios.com ([167.114.142.138]:37580 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEaSLA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 14:11:00 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2AD3922F45C;
        Fri, 31 May 2019 14:10:58 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CVbXiAMBTh8l; Fri, 31 May 2019 14:10:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6F47022F452;
        Fri, 31 May 2019 14:10:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6F47022F452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1559326257;
        bh=5pWd1qkBb3teYvKpgXTm+KiNou/eDaH+jFixlM1uv00=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=k5VLoki8BdROQLM1uUaHJqdewCx2tHy6R5ucG0eHqDTt3UWAv1n9iK2SuWXSWBFUQ
         vlulMZ9s32lcR5UkF7OzzNks0Vn7Qmks0QyoxoGO4Xut/3s8omXKqVY9RVZMKGHJEI
         TNqhwXToZDkqim9Wpy910sYbH4lsLnAPsrijTPNGLKiLLYsDQW/h96scaq1Uz6nVj8
         BZnP7fvRhAFDklGPfoCS5E3wkvGtefxr4UxK/oVrXr8d2brN7j9RIel3zHh5puZV8Q
         /NZCvbAJaWDLBdFEiZFzMBJ91j6l7XEUzfYmXUaLL2hqS7cAoqdjCR7GuqfT8uQGFc
         Ahvecd3l/caGw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id kld0ZKmMzhFe; Fri, 31 May 2019 14:10:57 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 516D322F446;
        Fri, 31 May 2019 14:10:57 -0400 (EDT)
Date:   Fri, 31 May 2019 14:10:57 -0400 (EDT)
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
Message-ID: <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com>
In-Reply-To: <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <87h89gjgaf.fsf@oldenburg2.str.redhat.com> <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com> <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com> <2022553041.20966.1559249801435.JavaMail.zimbra@efficios.com> <875zprm4jo.fsf@oldenburg2.str.redhat.com> <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com> <87muj2k4ov.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: 86crk3o97x34dTvOXYVp+G+7ug75ug==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



----- On May 31, 2019, at 11:46 AM, Florian Weimer fweimer@redhat.com wrote=
:

> * Mathieu Desnoyers:
>=20
>> Let's break this down into the various sub-issues involved:
>>
>> 1) How early do we need to setup rseq ? Should it be setup before:
>>    - LD_PRELOAD .so constructors ?
>>      - Without circular dependency,
>>      - With circular dependency,
>>    - audit libraries initialization ?
>>    - IFUNC resolvers ?
>>    - other callbacks ?
>>    - memory allocator calls ?
>>
>> We may end up in a situation where we need memory allocation to be setup
>> in order to initialize TLS before rseq can be registered for the main
>> thread. I suspect we will end up needing a fallbacks which always work
>> for the few cases that would try to use rseq too early in dl/libc startu=
p.
>=20
> I think the answer to that depends on whether it's okay to have an
> observable transition from =E2=80=9Cno rseq kernel support=E2=80=9D to =
=E2=80=9Ckernel supports
> rseq=E2=80=9D.

As far as my own use-cases are concerned, I only care that rseq is initiali=
zed
before LD_PRELOAD .so constructors are executed.

There appears to be some amount of documented limitations for what can be
done by the IFUNC resolvers. It might be acceptable to document that rseq
might not be initialized yet when those are executed.

I'd like to hear what others think about whether we should care about IFUNC
resolvers and audit libraries using restartable sequences TLS ?

[...]

>=20
>> 4) Inability to touch a TLS variable (__rseq_abi) from ld-linux-*.so.2
>>    - Should we extend the dynamic linker to allow such TLS variable to b=
e
>>      accessed ? If so, how much effort is required ?
>>    - Can we find an alternative way to initialize rseq early during
>>      dl init stages while still performing the TLS access from a functio=
n
>>      implemented within libc.so ?
>=20
> This is again related to the answer for (1).  There are various hacks we
> could implement to make the initialization invisible (e.g., computing
> the address of the variable using the equivalent of dlsym, after loading
> all the initial objects and before starting relocation).  If it's not
> too hard to add TLS support to ld.so, we can consider that as well.
> (The allocation side should be pretty easy, relocation support it could
> be more tricky.)
>=20
>> So far, I got rseq to be initialized before LD_PRELOADed library
>> constructors by doing the initialization in a constructor within
>> libc.so. I don't particularly like this approach, because the
>> constructor order is not guaranteed.
>=20
> Right.

One question related to use of constructors: AFAIU, if a library depends
on glibc, ELF guarantees that the glibc constructor will be executed first,
before the other library.

Which leaves us with the execution order of constructors within libc.so,
which is not guaranteed if we just use __attribute__ ((constructor)).
However, all gcc versions that are required to build recent glibc
seem to support a constructor with a "priority" value (lower gets
executed first, and those are executed before constructors without
priority).

Could we do e.g.:

--- a/include/libc-internal.h
+++ b/include/libc-internal.h
@@ -21,6 +21,12 @@
=20
 #include <hp-timing.h>
=20
+/* Libc constructor priority order. Lower is executed first.  */
+enum libc_constructor_prio {
+       /* Priorities between 0 and 100 are reserved.  */
+       LIBC_CONSTRUCTOR_PRIO_RSEQ_INIT =3D 1000,
+};
+
 /* Initialize the `__libc_enable_secure' flag.  */
 extern void __libc_init_secure (void);
=20
and

csu/libc-start.c:

static
__attribute__ ((constructor (LIBC_CONSTRUCTOR_PRIO_RSEQ_INIT)))
void __rseq_libc_init (void)
{
  rseq_init ();
  /* Register rseq ABI to the kernel.   */
  (void) rseq_register_current_thread ();
}

[...]

Thanks,

Mathieu




--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
