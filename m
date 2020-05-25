Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F7F1E1101
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391079AbgEYOvt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 25 May 2020 10:51:49 -0400
Received: from mail.efficios.com ([167.114.26.124]:33912 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390995AbgEYOvr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 25 May 2020 10:51:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4F0D92C34A7;
        Mon, 25 May 2020 10:51:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FQQgve8sak1V; Mon, 25 May 2020 10:51:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9BD6E2C3614;
        Mon, 25 May 2020 10:51:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9BD6E2C3614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1590418305;
        bh=6tyb0kjx6yVZMXxyTctntKXrHwgqj474Syb1WIq7Bz0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PXSWRH7gsmup6B2z5zyvA0dDjHB4v34akreggthfEYRKlKsWqx0WOte5aqilw0eAR
         Nm6ls//1gF1bP0X+sbTSvp+aHb+B+3PTkflu8q8uJj840fc23+0i9oBJ0gMR1PhCR2
         xon2ShR7PDPgmhkE8MHcinYwfHCQnIyYkfhEybIiB9Mezu1dy1YRQlmUJXOQfiK34d
         rvcyZ/TuPOeMQBQixlIc5AaCDJoZxIPXI+rwfaNuAK1E/unMp/w1eKuXt1X0ksKiRC
         /xdfbDxDv2YFtAoejUGxi9/8+Cx+XTjY+ONv+t+t6zl7MRapbaa4dX2/dFXLlD64E4
         hVdyOtvfu5/aQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6plpHy_8Qu4r; Mon, 25 May 2020 10:51:45 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7DF932C350A;
        Mon, 25 May 2020 10:51:45 -0400 (EDT)
Date:   Mon, 25 May 2020 10:51:45 -0400 (EDT)
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
Message-ID: <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com>
In-Reply-To: <87v9kqbzse.fsf@oldenburg2.str.redhat.com>
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com> <20200501021439.2456-2-mathieu.desnoyers@efficios.com> <87v9kqbzse.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v19)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v19)
Thread-Index: J0ZredkxF5q54R+vKeB0Ck/we1aEyQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 20, 2020, at 7:40 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers via Libc-alpha:
>=20
>> diff --git a/NEWS b/NEWS
>> index 141078c319..c4e0370fc4 100644
>> --- a/NEWS
>> +++ b/NEWS
>> @@ -23,6 +23,16 @@ Major new features:
>>    toolchains.  It is recommended to use GCC 8 or newer when testing
>>    this option.
>> =20
>> +* Support for automatically registering threads with the Linux rseq
>> +  system call has been added.  This system call is implemented starting
>> +  from Linux 4.18.  The Restartable Sequences ABI accelerates user-spac=
e
>> +  operations on per-cpu data.  It allows user-space to perform updates
>> +  on per-cpu data without requiring heavy-weight atomic operations.
>> +  Automatically registering threads allows all libraries, including lib=
c,
>> +  to make immediate use of the rseq(2) support by using the documented =
ABI.
>> +  The GNU C Library manual has details on integration of Restartable
>> +  Sequences.
>=20
> =E2=80=9Crseq=E2=80=9D instead =E2=80=9Crseq(2)=E2=80=9D.

OK

[...]
>=20
>> diff --git a/manual/threads.texi b/manual/threads.texi
>> index 0858ef8f92..a565095c43 100644
>> --- a/manual/threads.texi
>> +++ b/manual/threads.texi
>> @@ -9,8 +9,10 @@ This chapter describes functions used for managing thre=
ads.
>>  POSIX threads.
>> =20
>>  @menu
>> -* ISO C Threads::=09Threads based on the ISO C specification.
>> -* POSIX Threads::=09Threads based on the POSIX specification.
>> +* ISO C Threads::=09=09Threads based on the ISO C specification.
>> +* POSIX Threads::=09=09Threads based on the POSIX specification.
>> +* Restartable Sequences::=09Linux-specific Restartable Sequences
>> +=09=09=09=09integration.
>>  @end menu
>=20
> This should go into the extensions menu (@node Non-POSIX Extensions).

OK

>=20
> General comment: Please wrap the lines around 72 or so characters.
> Thanks.

OK

>=20
>> @@ -881,3 +883,63 @@ Behaves like @code{pthread_timedjoin_np} except tha=
t the
>> absolute time in
>>  @c pthread_spin_unlock
>>  @c pthread_testcancel
>>  @c pthread_yield
>> +
>> +@node Restartable Sequences
>> +@section Restartable Sequences
>> +@cindex Restartable Sequences
>> +
>> +This section describes Restartable Sequences integration for
>> +@theglibc{}.
>=20
> =E2=80=9CThis functionality is only available on Linux.=E2=80=9D  (The @s=
tandards parts
> are not visible to readers.)

OK

>=20
>> +
>> +@deftypevar {struct rseq} __rseq_abi
>> +@standards{Linux, sys/rseq.h}
>> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with =
the
>> +Restartable Sequences system call (Linux-specific).  The layout of this
>> +structure is defined by the @file{sys/rseq.h} header.  Registration of =
each
>> +thread's @code{__rseq_abi} is performed by @theglibc{} at library
>> +initialization and thread creation.
>=20
> Can drop =E2=80=9C(Linux-specific)=E2=80=9D here.

OK

>=20
>> diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
>> b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
>> new file mode 100644
>> index 0000000000..37d83fcb4a
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
>=20
>> +#ifdef __AARCH64EB__
>> +#define RSEQ_SIG_DATA=090x00bc28d4=09/* BRK #0x45E0.  */
>> +#else
>> +#define RSEQ_SIG_DATA=09RSEQ_SIG_CODE
>> +#endif
>=20
> Missing indentation on the #defines (sorry!).

Sorry! My bad!

>=20
>> diff --git a/sysdeps/unix/sysv/linux/arm/bits/rseq.h
>> b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
>> new file mode 100644
>> index 0000000000..c132f0327c
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/arm/bits/rseq.h
>=20
>> +#ifdef __ARMEB__
>> +#define RSEQ_SIG    0xf3def5e7      /* udf    #24035    ; 0x5de3 (ARMv6=
+) */
>> +#else
>> +#define RSEQ_SIG    0xe7f5def3      /* udf    #24035    ; 0x5de3 */
>> +#endif
>=20
> Likewise, missing indentation.

At least I was consistently wrong. ;-)

>=20
>> diff --git a/sysdeps/unix/sysv/linux/bits/rseq.h
>> b/sysdeps/unix/sysv/linux/bits/rseq.h
>> new file mode 100644
>> index 0000000000..014c08fe0f
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/bits/rseq.h
>> @@ -0,0 +1,29 @@
>=20
>> +/* RSEQ_SIG is a signature required before each abort handler code.
>> +
>> +   It is a 32-bit value that maps to actual architecture code compiled
>> +   into applications and libraries.  It needs to be defined for each
>> +   architecture.  When choosing this value, it needs to be taken into
>> +   account that generating invalid instructions may have ill effects on
>> +   tools like objdump, and may also have impact on the CPU speculative
>> +   execution efficiency in some cases.  */
>=20
> I wonder if we should say something somewhere that the correct way to
> check for compile-time rseq support in glibc is something like this?
>=20
> #if __has_include (<sys/rseq.h>)
> # include <sys/rseq.h>
> #endif
> #ifdef RSEQ_SIG
> =E2=80=A6
> #endif
>=20
> Or perhaps we should suppress installation of the headers if we only
> have support for the stub.
>=20
> (I think this fine tuning can be deferred to later patch.)

I would prefer we keep this for a later patch.

That being said, I notice that gcc prior to 4.9 has trouble compiling
__has_include. Therefore, I would tend to recommend the following as a
backward-compatible way of using the rseq header from external projects:

- At configure time, check for availability of sys/rseq.h to ensure the
  glibc version is recent enough. In the autotools world, this is usually
  done with a small test program which will fail to build if the header is
  not there.
- At preprocessing time, include <sys/rseq.h> and check whether RSEQ_SIG
  is defined.

If a project only aims at building with gcc 4.9 or newer, then it can use
__has_include.

>=20
>> diff --git a/sysdeps/unix/sysv/linux/mips/bits/rseq.h
>> b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
>> new file mode 100644
>> index 0000000000..cbad4290cc
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
>> @@ -0,0 +1,62 @@
>=20
>> +#if defined(__nanomips__)
>> +# ifdef __MIPSEL__
>> +#  define RSEQ_SIG=090x03500010
>> +# else
>> +#  define RSEQ_SIG=090x00100350
>> +# endif
>> +#elif defined(__mips_micromips)
>> +# ifdef __MIPSEL__
>> +#  define RSEQ_SIG=090xd4070000
>> +# else
>> +#  define RSEQ_SIG=090x0000d407
>> +# endif
>> +#elif defined(__mips__)
>> +# define RSEQ_SIG=090x0350000d
>> +#else
>> +/* Unknown MIPS architecture.  */
>> +#endif
>=20
> Please use =E2=80=9Cdefined (=E2=80=9D, with a space.

OK

>=20
>> diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h
>> b/sysdeps/unix/sysv/linux/rseq-internal.h
>> new file mode 100644
>> index 0000000000..6583691285
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/rseq-internal.h
>=20
>> +#ifdef RSEQ_SIG
>> +static inline void
>> +rseq_register_current_thread (void)
>=20
>> +      if (msg)
>> +        __libc_fatal (msg);
>> +    }
>=20
> =E2=80=9Cif (msg !=3D NULL)=E2=80=9D, please.

OK

>=20
>> +#else
>> +static inline void
>> +rseq_register_current_thread (void)
>> +{
>> +}
>> +#endif
>=20
> Maybe add /* RSEQ_SIG */ comments to #else/#endif here as well.

OK

>=20
>> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h
>> b/sysdeps/unix/sysv/linux/sys/rseq.h
>> new file mode 100644
>> index 0000000000..ea51194bf8
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
>=20
>> +#ifdef __has_include
>> +# if __has_include ("linux/rseq.h")
>> +#   define __GLIBC_HAVE_KERNEL_RSEQ
>> +# endif
>> +#else
>> +# include <linux/version.h>
>> +# if LINUX_VERSION_CODE >=3D KERNEL_VERSION (4, 18, 0)
>> +#   define __GLIBC_HAVE_KERNEL_RSEQ
>> +# endif
>> +#endif
>=20
> Too much indentation on the define line, I think.

OK

>=20
> Still missing: #ifdef __ASSEMBLER__.  .S files should be able to include
> <sys/rseq.h> to get the definition of RSEQ_SIG.  But I think this can be
> deferred to a follow-up.

Would the plan be to only do the #include <bits/rseq.h> bits in #ifdef
__ASSEMBLER__ and skip all the rest ?

>=20
>> +#ifdef __GLIBC_HAVE_KERNEL_RSEQ
>> +/* We use the structures declarations from the kernel headers.  */
>> +# include <linux/rseq.h>
>> +#else
>> +/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */
>=20
> This comment is not true, the kernel headers do not have uptr support.
>=20
> If we revert the uptr change, we also need to update the manual, I
> think.

Ah, I get to your uptr concern now! Good :)

The larger question here is: considering that we re-implement the entire
uapi header within glibc (which includes the uptr addition), do we still
care about using the header provided by the Linux kernel ?

Having different definitions depending on whether a kernel header is
installed or not when including a glibc header seems rather unexpected.

*If* we want to use the uapi header, I think something is semantically
missing. Here is the scheme I envision. We could rely on the kernel header
version.h to figure out which of glibc or kernel uapi header is more
recent. Any new concept we try to integrate into glibc (e.g. uptr)
should go into the upstream Linux uapi header first.

For the coming glibc e.g. 2.32, we use the kernel uapi header if
kernel version is >=3D 4.18.0. Within glibc, the fallback implements
exactly the API exposed by the kernel rseq.h header.

As we eventually introduce the uptr change into the Linux kernel, and
say it gets merged for Linux 5.9.0, we mirror this change into glibc
(e.g. release 2.33), and bump the Linux kernel version cutoff to 5.9.0.
So starting from that version, we use the Linux kernel header only if
version >=3D 5.9.0, else we fallback on glibc's own implementation.

This is clearly something we need to get right.

>=20
>> +/* Ensure the compiler supports __attribute__ ((aligned)).  */
>> +_Static_assert (__alignof__ (struct rseq_cs) >=3D 32, "alignment");
>> +_Static_assert (__alignof__ (struct rseq) >=3D 32, "alignment");
>=20
> This needs #ifndef __cplusplus or something like that.  I'm surprised
> that this passes the installed header tests.

Would the following be ok ?

#ifdef __cplusplus
#define rseq_static_assert      static_assert
#else
#define rseq_static_assert      _Static_assert
#endif

/* Ensure the compiler supports __attribute__ ((aligned)).  */
rseq_static_assert (__alignof__ (struct rseq_cs) >=3D 32, "alignment");
rseq_static_assert (__alignof__ (struct rseq) >=3D 32, "alignment");

>=20
>> +/* Allocations of struct rseq and struct rseq_cs on the heap need to
>> +   be aligned on 32 bytes.  Therefore, use of malloc is discouraged
>> +   because it does not guarantee alignment.  posix_memalign should be
>> +   used instead.  */
>> +
>> +extern __thread struct rseq __rseq_abi
>> +  __attribute__ ((tls_model ("initial-exec")));
>=20
> Should be __tls_model__.

OK

>=20
> We're getting really close now. 8-)

Great!

Thanks for the feedback!

Mathieu

>=20
> Thanks,
> Florian

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
