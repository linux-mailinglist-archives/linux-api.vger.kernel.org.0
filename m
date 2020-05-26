Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4901E248C
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 16:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgEZOx0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 10:53:26 -0400
Received: from mail.efficios.com ([167.114.26.124]:48070 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgEZOx0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 10:53:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4323D2530AB;
        Tue, 26 May 2020 10:53:25 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Wd-fD4srGR5b; Tue, 26 May 2020 10:53:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D2F562530AA;
        Tue, 26 May 2020 10:53:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D2F562530AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1590504804;
        bh=J03/Qz2NTKez9n+J8FkkHyKFt/pjXwvDlXKd3V/IOls=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SjLml/DV0mUiubHEz7WbIknofrTOg6Fqmjhiu++r2bpVIAdJprhCu37B7gYzF3QUH
         xJmxVXJ67mEFnymWdjVrdwr4qncETd2Nyt2L87b1d5Tj4MbnvZ9uXT35NL3loSbA0j
         MKh87jgTJPSID5Es8Cqq8lPn884zG2nnuXOSti+PgcUH4bRevn84Q6wSHXiHLRKhoZ
         8Yqmw5kT5mjFdipya4nTITK42XrxDzvHuUKfWv3Zrb1eEOyIPOTRL7O1+CXl+jAD7C
         ddcIVHybri/tre/IbMzsT0Ht+XHFQ5zHSwsPAjYWoRbdP+SgW4GnKsrjln2ZOPkUuP
         hvIcRm2nYxgEg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TN0OeTI4tPQP; Tue, 26 May 2020 10:53:24 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BFB152530A9;
        Tue, 26 May 2020 10:53:24 -0400 (EDT)
Date:   Tue, 26 May 2020 10:53:24 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Message-ID: <1931644690.34207.1590504804638.JavaMail.zimbra@efficios.com>
In-Reply-To: <87ftbmpxqi.fsf@oldenburg2.str.redhat.com>
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com> <87v9kqbzse.fsf@oldenburg2.str.redhat.com> <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com> <87367ovy6k.fsf@oldenburg2.str.redhat.com> <108939265.33525.1590428184533.JavaMail.zimbra@efficios.com> <87lflerhqt.fsf@oldenburg2.str.redhat.com> <1701081361.34159.1590503556923.JavaMail.zimbra@efficios.com> <87ftbmpxqi.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v19)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v19)
Thread-Index: +WF+p2h1qwweiPpTqvCExj6y4Uu9/w==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 26, 2020, at 10:38 AM, Florian Weimer fweimer@redhat.com wrote=
:

> * Mathieu Desnoyers:
>=20
>> AFAIU, the only gain here would be to make sure we don't emit useless
>> ";" in the "/* nothing */" case. But does it matter ?
>=20
> I don't think C allows empty constructs like this at the top level.
>=20
>>>>> And something similar for _Alignas/attribute aligned,
>>>>
>>>> I don't see where _Alignas is needed here ?
>>>>
>>>> For attribute aligned, what would be the oldest supported C and C++
>>>> standards ?
>>>=20
>>> There are no standardized attributes for C, there is only _Alignas.
>>> C++11 has an alignas specifier; it's not an attribute either.  I think
>>> these are syntactically similar.
>>
>> There appears to be an interesting difference between attribute aligned
>> and alignas. It seems like alignas cannot be used on a structure declara=
tion,
>> only on fields, e.g.:
>>
>> struct blah {
>>         int a;
>> } _Alignas (16);
>>
>> o.c:3:1: warning: useless =E2=80=98_Alignas=E2=80=99 in empty declaratio=
n
>>  } _Alignas (16);
>>
>> But
>>
>> struct blah {
>>         int _Alignas (16) a;
>> };
>=20
> Like the attribute, it needs to come right after the struct keyword, I
> think.  (Trailing attributes can be ambiguous, but not in this case.)

Nope. _Alignas really _is_ special :-(

struct _Alignas (16) blah {
        int a;
};

p.c:1:8: error: expected =E2=80=98{=E2=80=99 before =E2=80=98_Alignas=E2=80=
=99
 struct _Alignas (16) blah {

Also:

struct blah _Alignas (16) {
        int a;
};

p.c:1:27: error: expected identifier or =E2=80=98(=E2=80=99 before =E2=80=
=98{=E2=80=99 token
 struct blah _Alignas (16) {

>=20
>> is OK. So if I change e.g. struct rseq_cs to align
>> the first field:
>>
>> struct rseq_cs
>>   {
>>     /* Version of this structure.  */
>>     uint32_t rseq_align (32) version;
>>     /* enum rseq_cs_flags.  */
>>     uint32_t flags;
>>     uint64_t start_ip;
>>     /* Offset from start_ip.  */
>>     uint64_t post_commit_offset;
>>     uint64_t abort_ip;
>>   };
>>
>> It should work.
>=20
> Indeed.

OK, so let's go for that approach.

>=20
>> /* Rely on GNU extensions for older standards and tls model.  */
>> #ifdef __GNUC__
>> # ifndef rseq_alignof
>> #  define rseq_alignof(x) __alignof__ (x)
>> # endif
>> # ifndef rseq_alignas
>> #  define rseq_alignas(x) __attribute__ ((aligned (x)))
>> # endif
>> # define rseq_tls_model_ie __attribute__ ((__tls_model__ ("initial-exec"=
)))
>> #else
>> /* Specifying the TLS model on the declaration is optional.  */
>> # define rseq_tls_model_ie /* Nothing.  */
>> #endif
>>
>> /* Fall back to __thread for TLS storage class.  */
>> #ifndef rseq_tls_storage_class
>> # define rseq_tls_storage_class __thread
>> #endif
>=20
> If they are only used in the glibc headers, they should have __rseq
> prefixes, so that application code doesn't start using them (in case we
> have to change/fix them, or move the into <sys/cdefs.h> later).

OK will do.

>=20
> Rest looks fine.

One last thing I'm planning to add in sys/rseq.h to cover acessing the
rseq_cs pointers with both the UAPI headers and the glibc struct rseq
declarations:

/* The rseq_cs_ptr macro can be used to access the pointer to the current
   rseq critical section descriptor.  */
#ifdef __LP64__
# define rseq_cs_ptr(rseq) \
           ((const struct rseq_cs *) (rseq)->rseq_cs.ptr)
#else /* __LP64__ */
# define rseq_cs_ptr(rseq) \
           ((const struct rseq_cs *) (rseq)->rseq_cs.ptr.ptr32)
#endif /* __LP64__ */

Does it make sense ?

Thanks,

Mathieu

>=20
> Thanks,
> Florian

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
