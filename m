Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A704207BE1
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 21:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406188AbgFXTAG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 15:00:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:47884 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404079AbgFXTAG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 15:00:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5B7182C3FC9;
        Wed, 24 Jun 2020 15:00:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ckXT-CuOZLLN; Wed, 24 Jun 2020 15:00:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C82C72C3C73;
        Wed, 24 Jun 2020 15:00:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C82C72C3C73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1593025203;
        bh=DGH1GYSZBoon4ZWwCZH/B+1D5oPNjfnq5dqQoCBvZzU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cyDE02eHz1qW1JNlNRD6qHzjFRJhkh/+QUTsNRqwzbsuxoWykluJo+dpCU07r840c
         zeQZxTyoqYqa04/piJ/2qWPQVKV1VJ/pavhHP4hlNV7CEEDzG4ezlplNMwSfceFStq
         tZxc0/c8TeB5DQAjgjkeqxxZskmN9oWT8qHGOfL5hO6xmMCrj3EZ4qWnFsUDwBH+or
         kAtgC4luBOgsmti2kArltg6TxqF2YjEVMWxk5qPPxQOAqvDQvaEYVcNRuprC3gKADB
         8kWT7pqYa8zzLMRG9WQCTkyt3FgJFHsgBPS/mj4OuyRzORBrqobnOrVv83yFuZS8EK
         iF/zZTt+2PlfA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 66nNyDA9j72v; Wed, 24 Jun 2020 15:00:03 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 93DA42C4048;
        Wed, 24 Jun 2020 15:00:03 -0400 (EDT)
Date:   Wed, 24 Jun 2020 15:00:03 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1158112159.11628.1593025203438.JavaMail.zimbra@efficios.com>
In-Reply-To: <87d05obl4w.fsf@oldenburg2.str.redhat.com>
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com> <20200622180803.1449-2-mathieu.desnoyers@efficios.com> <87d05obl4w.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and
 thread creation (v21)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3945 (ZimbraWebClient - FF77 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v21)
Thread-Index: mL9vamfSXFjzYkqlBsqyTfQOebVEtA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 24, 2020, at 10:20 AM, Florian Weimer fweimer@redhat.com wrote=
:

> * Mathieu Desnoyers:
>=20
>> diff --git a/manual/threads.texi b/manual/threads.texi
>> index bb7a42c655..d5069d5581 100644
>> --- a/manual/threads.texi
>> +++ b/manual/threads.texi
>=20
>> +@deftypevar {struct rseq} __rseq_abi
>> +@standards{Linux, sys/rseq.h}
>> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with
>> +the Restartable Sequences system call.  The layout of this structure is
>> +defined by the @file{sys/rseq.h} header.  Registration of each thread's
>> +@code{__rseq_abi} is performed by @theglibc{} at library initialization
>> +and thread creation. The manual for the rseq system call can be found
>> +at
>> @uref{https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/doc/m=
an/rseq.2}.
>=20
> Should be =E2=80=9Ccreation.  The=E2=80=9D (two spaces after a sentence-e=
nding period).

OK

>=20
>> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h
>> b/sysdeps/unix/sysv/linux/sys/rseq.h
>> new file mode 100644
>> index 0000000000..5e118c1781
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
>=20
>> +#ifdef __cplusplus
>> +# if  __cplusplus >=3D 201103L
>> +#  define __rseq_static_assert(expr, diagnostic) static_assert (expr,
>> diagnostic)
>> +#  define __rseq_alignof(type)                   alignof (type)
>> +#  define __rseq_tls_storage_class               thread_local
>> +# endif
>> +#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >=3D 201112L
>> +# define __rseq_static_assert(expr, diagnostic)  _Static_assert (expr,
>> diagnostic)
>> +# define __rseq_alignof(type)                    _Alignof (type)
>> +# define __rseq_tls_storage_class                _Thread_local
>> +#endif
>> +
>> +#ifndef __rseq_static_assert
>> +/* Try to use _Static_assert macro from sys/cdefs.h.  */
>> +# ifdef _Static_assert
>> +#  define __rseq_static_assert(expr, diagnostic) _Static_assert (expr,
>> diagnostic)
>> +# else
>> +#  define __rseq_static_assert(expr, diagnostic) /* Nothing.  */
>> +# endif
>> +#endif
>> +
>> +/* Rely on GNU extensions for older standards and tls model.  */
>> +#ifdef __GNUC__
>> +# ifndef __rseq_alignof
>> +#  define __rseq_alignof(x) __alignof__ (x)
>> +# endif
>> +# define __rseq_tls_model_ie __attribute__ ((__tls_model__ ("initial-ex=
ec")))
>> +#else
>> +/* Specifying the TLS model on the declaration is optional.  */
>> +# define __rseq_tls_model_ie /* Nothing.  */
>> +#endif
>=20
> I'm still worried that __rseq_static_assert and __rseq_alignof will show
> up in the UAPI with textually different definitions.  (This does not
> apply to __rseq_tls_model_ie.)

What makes this worry not apply to __rseq_tls_model_ie ?

>=20
> Is my worry unfounded?

So AFAIU you worry that eventually sys/rseq.h and linux/rseq.h carry differ=
ent
definitions of __rseq_static_assert and __rseq_alignof.

Indeed, I did not surround those #define with #ifndef/#endif. Maybe we shou=
ld ?

Just in case the definitions end up being different (worse case scenario), =
we
should expect their behavior to be pretty much equivalent. So going for the
following should address your concern I think:

#ifdef __cplusplus
# if  __cplusplus >=3D 201103L
#  ifndef __rseq_static_assert
#   define __rseq_static_assert(expr, diagnostic) static_assert (expr, diag=
nostic)
#  endif
#  ifndef __rseq_alignof
#   define __rseq_alignof(type)                   alignof (type)
#  endif
#  ifndef __rseq_tls_storage_class
#   define __rseq_tls_storage_class               thread_local
#  endif
# endif
#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >=3D 201112L
# ifndef __rseq_static_assert
#  define __rseq_static_assert(expr, diagnostic)  _Static_assert (expr, dia=
gnostic)
# endif
# ifndef __rseq_alignof
#  define __rseq_alignof(type)                    _Alignof (type)
# endif
# ifndef __rseq_tls_storage_class
#  define __rseq_tls_storage_class                _Thread_local
# endif
#endif

#ifndef __rseq_static_assert
/* Try to use _Static_assert macro from sys/cdefs.h.  */
# ifdef _Static_assert
#  define __rseq_static_assert(expr, diagnostic) _Static_assert (expr, diag=
nostic)
# else
#  define __rseq_static_assert(expr, diagnostic) /* Nothing.  */
# endif
#endif

/* Rely on GNU extensions for older standards and tls model.  */
#ifdef __GNUC__
# ifndef __rseq_alignof
#  define __rseq_alignof(x) __alignof__ (x)
# endif
# ifndef __rseq_tls_model_ie
#  define __rseq_tls_model_ie __attribute__ ((__tls_model__ ("initial-exec"=
)))
# endif
#else
/* Specifying the TLS model on the declaration is optional.  */
# ifndef __rseq_tls_model_ie
#  define __rseq_tls_model_ie /* Nothing.  */
# endif
#endif

/* Fall back to __thread for TLS storage class.  */
#ifndef __rseq_tls_storage_class
# define __rseq_tls_storage_class __thread
#endif

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
