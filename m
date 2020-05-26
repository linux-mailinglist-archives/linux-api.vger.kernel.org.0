Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3D9B1E2424
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgEZOcj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 10:32:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:38322 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgEZOcj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 10:32:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 95B4D252C51;
        Tue, 26 May 2020 10:32:37 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Bl4TVJzCQt3W; Tue, 26 May 2020 10:32:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1DD32252C4E;
        Tue, 26 May 2020 10:32:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1DD32252C4E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1590503557;
        bh=GF2obO+VgsHTG0XENOWXkGrEmTFc90oxfInrENuMGe0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rXQQ6PTO4QxyvPLZ+TN0Hc/sQILLKdv1QYbBERhf2MYfPejKGEgGU5gEbA5cfKC3L
         TTlXCl/5Fz8ZkoW4TwHuYz3olt55XaaCDwznOaO5AS9j+8HbKC08fzZIgJHw0GpUbB
         iIwMytJQf4LsotfZW8Et46SDlQOSJvdg8PmXW4nKQ4Zq/jNC38SjPrVFGXwXAaq9m6
         EzQv2FnEeAjow9E9ek45plIGgkZZ6NWFnhKAlC5T9g1joijy7CBZN+DHPatv06zXzx
         71+e2t1J4qybHA7nNTntXEHTMUzANNN0ao23qtsQ13z0CCZLSI9Vl4NZqsdHmY4nff
         bdQ9CeohneLPA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2ni_ItOGEx50; Tue, 26 May 2020 10:32:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 02548252F1B;
        Tue, 26 May 2020 10:32:37 -0400 (EDT)
Date:   Tue, 26 May 2020 10:32:36 -0400 (EDT)
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
Message-ID: <1701081361.34159.1590503556923.JavaMail.zimbra@efficios.com>
In-Reply-To: <87lflerhqt.fsf@oldenburg2.str.redhat.com>
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com> <20200501021439.2456-2-mathieu.desnoyers@efficios.com> <87v9kqbzse.fsf@oldenburg2.str.redhat.com> <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com> <87367ovy6k.fsf@oldenburg2.str.redhat.com> <108939265.33525.1590428184533.JavaMail.zimbra@efficios.com> <87lflerhqt.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v19)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v19)
Thread-Index: 9Bb1L4ZyHRACPWplaZt58Bc2uwCz3w==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 26, 2020, at 8:41 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
>=20
>> Something like this ?
>>
>> #ifdef __cplusplus
>> # if  __cplusplus >=3D 201103L
>> #  define rseq_static_assert (expr, diagnostic)         static_assert (e=
xpr,
>> diagnostic)
>> #  define rseq_alignof                                  alignof
>> # endif
>> #elif __STDC_VERSION__ >=3D 201112L
>> # define rseq_static_assert (expr, diagnostic)          _Static_assert (=
expr,
>> diagnostic)
>> # define rseq_alignof                                   _Alignof
>> #endif
>>
>> #ifndef rseq_static_assert
>> # define rseq_static_assert (expr, diagnostic)          /* nothing */
>> #endif
>=20
> You can't have a space in #defines like that, no matter what GNU style
> says. 8-)

Yes, I noticed when failing to build this ;)

>=20
>> /* Ensure the compiler supports __attribute__ ((aligned)).  */
>> rseq_static_assert ((rseq_alignof (struct rseq_cs) >=3D 32, "alignment")=
);
>> rseq_static_assert ((rseq_alignof (struct rseq) >=3D 32, "alignment"));
>=20
> You need to move the ; into rseq_static_assert.  And if you use explicit
> arguments, you can't use double parentheses.

Why move the ";" into the macro ?

AFAIU, the only gain here would be to make sure we don't emit useless
";" in the "/* nothing */" case. But does it matter ?

Examples I can find of "static_assert" explicitly have the ";" at the
end, so I find it weird to integrate it into the rseq_static_assert
macro, which makes it different from static_assert.

Agreed on the need to remove the double-parentheses.

>=20
>>> And something similar for _Alignas/attribute aligned,
>>
>> I don't see where _Alignas is needed here ?
>>
>> For attribute aligned, what would be the oldest supported C and C++
>> standards ?
>=20
> There are no standardized attributes for C, there is only _Alignas.
> C++11 has an alignas specifier; it's not an attribute either.  I think
> these are syntactically similar.

There appears to be an interesting difference between attribute aligned
and alignas. It seems like alignas cannot be used on a structure declaratio=
n,
only on fields, e.g.:

struct blah {
        int a;
} _Alignas (16);

o.c:3:1: warning: useless =E2=80=98_Alignas=E2=80=99 in empty declaration
 } _Alignas (16);

But

struct blah {
        int _Alignas (16) a;
};

is OK. So if I change e.g. struct rseq_cs to align
the first field:

struct rseq_cs
  {
    /* Version of this structure.  */
    uint32_t rseq_align (32) version;
    /* enum rseq_cs_flags.  */
    uint32_t flags;
    uint64_t start_ip;
    /* Offset from start_ip.  */
    uint64_t post_commit_offset;
    uint64_t abort_ip;
  };

It should work.

>=20
>>> with an error for
>>> older standards and !__GNUC__ compilers (because neither the type nor
>>> __thread can be represented there).
>>
>> By "type" you mean "struct rseq" here ? What does it contain that requir=
es
>> a __GNUC__ compiler ?
>=20
> __attribute__ and __thread support.

OK

>=20
>> About __thread, I recall other compilers have other means to declare it.
>> In liburcu, I end up with the following:
>>
>> #if defined (__cplusplus) && (__cplusplus >=3D 201103L)
>> # define URCU_TLS_STORAGE_CLASS thread_local
>> #elif defined (__STDC_VERSION__) && (__STDC_VERSION__ >=3D 201112L)
>> # define URCU_TLS_STORAGE_CLASS _Thread_local
>> #elif defined (_MSC_VER)
>> # define URCU_TLS_STORAGE_CLASS __declspec(thread)
>> #else
>> # define URCU_TLS_STORAGE_CLASS __thread
>> #endif
>>
>> Would something along those lines be OK for libc ?
>=20
> Yes, it would be okay (minus the Visual C++ part).  This part does not
> have to go into UAPI headers first.  A fallback definition of __thread
> should be okay.  Outside glibc, the TLS model declaration is optional, I
> think.  The glibc *definition* ensures that the variable is
> initial-exec.

AFAIU you are technically correct when stating that the tls model
on the declaration is optional, but I think it's a good thing to have
it there rather than only at the definition. It makes it clear to all
users of this variable that its model is IE. Especially in scenarios where
early-adopter libraries and applications can define their own __rseq_abi
symbol, I think it's good to explicitly keep the IE tls model attribute in
the header.

I end up with the following:

#ifdef __cplusplus
# if  __cplusplus >=3D 201103L
#  define rseq_static_assert(expr, diagnostic) static_assert (expr, diagnos=
tic)
#  define rseq_alignof(type)                   alignof (type)
#  define rseq_alignas(x)                      alignas (x)
#  define rseq_tls_storage_class               thread_local
# endif
#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >=3D 201112L
# define rseq_static_assert(expr, diagnostic)  _Static_assert (expr, diagno=
stic)
# define rseq_alignof(type)                    _Alignof (type)
# define rseq_alignas(x)                       _Alignas (x)
# define rseq_tls_storage_class                _Thread_local
#endif

#ifndef rseq_static_assert
/* Try to use _Static_assert macro from sys/cdefs.h.  */
# ifdef _Static_assert
#  define rseq_static_assert(expr, diagnostic) _Static_assert (expr, diagno=
stic)
# else
#  define rseq_static_assert(expr, diagnostic) /* Nothing.  */
# endif
#endif

/* Rely on GNU extensions for older standards and tls model.  */
#ifdef __GNUC__
# ifndef rseq_alignof
#  define rseq_alignof(x) __alignof__ (x)
# endif
# ifndef rseq_alignas
#  define rseq_alignas(x) __attribute__ ((aligned (x)))
# endif
# define rseq_tls_model_ie __attribute__ ((__tls_model__ ("initial-exec")))
#else
/* Specifying the TLS model on the declaration is optional.  */
# define rseq_tls_model_ie /* Nothing.  */
#endif

/* Fall back to __thread for TLS storage class.  */
#ifndef rseq_tls_storage_class
# define rseq_tls_storage_class __thread
#endif

[...]

/* Ensure the compiler supports rseq_align.  */
rseq_static_assert (rseq_alignof (struct rseq_cs) >=3D 32, "alignment");
rseq_static_assert (rseq_alignof (struct rseq) >=3D 32, "alignment");

/* Allocations of struct rseq and struct rseq_cs on the heap need to
   be aligned on 32 bytes.  Therefore, use of malloc is discouraged
   because it does not guarantee alignment.  posix_memalign should be
   used instead.  */

extern rseq_tls_storage_class struct rseq __rseq_abi rseq_tls_model_ie;

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
