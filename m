Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFF81BBDAB
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 14:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD1MdQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 08:33:16 -0400
Received: from mail.efficios.com ([167.114.26.124]:51996 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgD1MdQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 08:33:16 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A929B27C981;
        Tue, 28 Apr 2020 08:33:14 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UScW_tH3c0D3; Tue, 28 Apr 2020 08:33:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A1B2127C6E3;
        Tue, 28 Apr 2020 08:33:13 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A1B2127C6E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588077193;
        bh=J8jiogIS+DDAUp+yVXnyW+aSI7i7HNRyneO/CtS4SDQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ZZ9xS/i3yunEnUaFzb5c51+oTuUa8VLUnMjFnsY05dQEntEVL6JmtwaHdFRYFHO3R
         EdQG6v/ouzBVaCfqoN667zmHXE/fQ3nzeZj20nCEz3i3ynZAimZBglj+hd4LovLvoS
         Ir+G7O1h91QBnIyQGJBVm9KjYK4xhw7uKa6zTG7RHDfA25fz+wHB5l3RBYEXEy0iS2
         tDDFFpWmqCTslEyG+CUYWmRenA4Q7fhxO8Cf6nuPxezcgUeBXbf+tkGNK1GS9eMhZU
         XEh5cl5rvXor/mWD93jENfOHzeLpEwBaSKwLZ5+DSL9pRnrK0ohzr6+wYHb+/CRtS9
         6TyKPoIme+R5Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lOp1kXQvfL0l; Tue, 28 Apr 2020 08:33:13 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8A94C27C2F7;
        Tue, 28 Apr 2020 08:33:13 -0400 (EDT)
Date:   Tue, 28 Apr 2020 08:33:13 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
In-Reply-To: <87ftcnrf7d.fsf@mid.deneb.enyo.de>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <20200326155633.18236-6-mathieu.desnoyers@efficios.com> <87ees9z417.fsf@mid.deneb.enyo.de> <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com> <87zhawvphv.fsf@mid.deneb.enyo.de> <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com> <87ftcnrf7d.fsf@mid.deneb.enyo.de>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: z7tk/3iPPlCh9cj1VVKnVHBj0mM1xA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 28, 2020, at 8:02 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
>=20
>>>>>> +/* struct rseq is aligned on 4 * 8 bytes to ensure it is always
>>>>>> +   contained within a single cache-line.
>>>>>> +
>>>>>> +   A single struct rseq per thread is allowed.  */
>>>>>> +struct rseq
>>>>>> +  {
>>>>>> +    /* Restartable sequences cpu_id_start field. Updated by the
>>>>>> +       kernel. Read by user-space with single-copy atomicity
>>>>>> +       semantics. This field should only be read by the thread whic=
h
>>>>>> +       registered this data structure. Aligned on 32-bit. Always
>>>>>=20
>>>>> What does =E2=80=9CAligned on 32-bit=E2=80=9D mean in this context?  =
Do you mean to
>>>>> reference 32-*byte* alignment here?
>>>>
>>>> No. I really mean 32-bit (4-byte). Being aligned on 32-byte guarantees=
 that
>>>> this field is aligned at least on 4-byte. This is required by single-c=
opy
>>>> atomicity semantics.
>>>>
>>>> Should I update this comment to state "Aligned on 4-byte" instead ?
>>>=20
>>> I think this is implied by all Linux ABIs.  And the explicit alignment
>>> specification for struct rseq makes the alignment 32 bytes.
>>
>> Unless a structure ends up being packed, which is of course not the case
>> here.
>>
>> I would prefer to keep the comment about 32-bit alignment requirement on
>> the specific fields, because the motivation for alignment requirement is
>> much more strict for fields (correctness) than the motivation for alignm=
ent
>> of the structure (performance).
>=20
> But the correctness is already enforced by the compiler, so I fail to
> see point of mentioning this in the comment.
>=20
> Anyway, I don't want to make a big deal of it.  Please leave it in if
> you think it is ehlpful.

I would prefer to leave it in, just to make the requirements plain clear in
case those structures are allocated on the heap (for instance).

>=20
>> x32 should not be an issue as explained above, so I'm very open to
>> add this "uptr" for user-space only.
>=20
> Okay, then please use anonymous unions and structs as necessary, to
> ensure that the uptr field can be reached on all platforms in the same
> way.

OK, will do!

One issue I'm currently facing when running "make check": because nptl/tst-=
rseq-nptl.c
uses pthread_cancel(), I run into an Abort with:

libgcc_s.so.1 must be installed for pthread_cancel to work
Didn't expect signal from child: got `Aborted'

So far I've tested the rest of that file with a patch on top which disables=
 the use of
pthread_cancel (), but I'd really like to give it a full coverage before se=
nding this out.
In https://sourceware.org/glibc/wiki/Testing/Builds there is a section abou=
t
"Building glibc with intent to install" which describes that libgcc must be=
 copied
manually. My use-case is that I just want to run "make check" in the build =
directory
and make sure it finds the libgcc it needs to succeed using pthread_cancel =
().
How can I achieve this ?

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
