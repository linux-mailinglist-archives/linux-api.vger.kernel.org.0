Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3E1DB1F2
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2020 13:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETLkS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 May 2020 07:40:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30475 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726435AbgETLkR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 May 2020 07:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589974814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELjO0rPwtfdpBvjL9XPR01jYDS6j/xovbDiD9cxEBFs=;
        b=ZaFt4nV0NyO8pinKW/tzzGRJALqXQJaJX4v9S6K9+QtnPw9wDnDlWplArvvzsYXhq3koGu
        CAj8x48cim38xrr7FzZdMsbokhdNn307kZ/BTny9WFGvNbVJKdoq3HVYoXzwwZYfpNdXoP
        GToiGeqQ/GiJJdeHFXDhT4I2haRvAts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-HvthDmKXPGutwaYud4ksvA-1; Wed, 20 May 2020 07:40:08 -0400
X-MC-Unique: HvthDmKXPGutwaYud4ksvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A57498014D7;
        Wed, 20 May 2020 11:40:06 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-191.ams2.redhat.com [10.36.113.191])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D7A46E9EA;
        Wed, 20 May 2020 11:40:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rich Felker <dalias@libc.org>, linux-api@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup and thread creation (v19)
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com>
        <20200501021439.2456-2-mathieu.desnoyers@efficios.com>
Date:   Wed, 20 May 2020 13:40:01 +0200
In-Reply-To: <20200501021439.2456-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers via Libc-alpha's message of "Thu, 30 Apr 2020 22:14:37
        -0400")
Message-ID: <87v9kqbzse.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers via Libc-alpha:

> diff --git a/NEWS b/NEWS
> index 141078c319..c4e0370fc4 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -23,6 +23,16 @@ Major new features:
>    toolchains.  It is recommended to use GCC 8 or newer when testing
>    this option.
>=20=20
> +* Support for automatically registering threads with the Linux rseq
> +  system call has been added.  This system call is implemented starting
> +  from Linux 4.18.  The Restartable Sequences ABI accelerates user-space
> +  operations on per-cpu data.  It allows user-space to perform updates
> +  on per-cpu data without requiring heavy-weight atomic operations.
> +  Automatically registering threads allows all libraries, including libc,
> +  to make immediate use of the rseq(2) support by using the documented A=
BI.
> +  The GNU C Library manual has details on integration of Restartable
> +  Sequences.

=E2=80=9Crseq=E2=80=9D instead =E2=80=9Crseq(2)=E2=80=9D.

> diff --git a/elf/libc_early_init.c b/elf/libc_early_init.c
> index e6c64fb526..f0fcf6448e 100644
> --- a/elf/libc_early_init.c
> +++ b/elf/libc_early_init.c
> @@ -18,10 +18,14 @@
>=20=20
>  #include <ctype.h>
>  #include <libc-early-init.h>
> +#include <rseq-internal.h>
>=20=20
>  void
>  __libc_early_init (_Bool initial)
>  {
>    /* Initialize ctype data.  */
>    __ctype_init ();
> +  /* Register rseq ABI to the kernel for the main program's libc.   */
> +  if (initial)
> +    rseq_register_current_thread ();
>  }

Okay.

> diff --git a/manual/threads.texi b/manual/threads.texi
> index 0858ef8f92..a565095c43 100644
> --- a/manual/threads.texi
> +++ b/manual/threads.texi
> @@ -9,8 +9,10 @@ This chapter describes functions used for managing threa=
ds.
>  POSIX threads.
>=20=20
>  @menu
> -* ISO C Threads::	Threads based on the ISO C specification.
> -* POSIX Threads::	Threads based on the POSIX specification.
> +* ISO C Threads::		Threads based on the ISO C specification.
> +* POSIX Threads::		Threads based on the POSIX specification.
> +* Restartable Sequences::	Linux-specific Restartable Sequences
> +				integration.
>  @end menu

This should go into the extensions menu (@node Non-POSIX Extensions).

General comment: Please wrap the lines around 72 or so characters.
Thanks.

> @@ -881,3 +883,63 @@ Behaves like @code{pthread_timedjoin_np} except that=
 the absolute time in
>  @c pthread_spin_unlock
>  @c pthread_testcancel
>  @c pthread_yield
> +
> +@node Restartable Sequences
> +@section Restartable Sequences
> +@cindex Restartable Sequences
> +
> +This section describes Restartable Sequences integration for
> +@theglibc{}.

=E2=80=9CThis functionality is only available on Linux.=E2=80=9D  (The @sta=
ndards parts
are not visible to readers.)

> +
> +@deftypevar {struct rseq} __rseq_abi
> +@standards{Linux, sys/rseq.h}
> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with t=
he
> +Restartable Sequences system call (Linux-specific).  The layout of this
> +structure is defined by the @file{sys/rseq.h} header.  Registration of e=
ach
> +thread's @code{__rseq_abi} is performed by @theglibc{} at library
> +initialization and thread creation.

Can drop =E2=80=9C(Linux-specific)=E2=80=9D here.

> diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h b/sysdeps/unix/s=
ysv/linux/aarch64/bits/rseq.h
> new file mode 100644
> index 0000000000..37d83fcb4a
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h

> +#ifdef __AARCH64EB__
> +#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
> +#else
> +#define RSEQ_SIG_DATA	RSEQ_SIG_CODE
> +#endif

Missing indentation on the #defines (sorry!).

> diff --git a/sysdeps/unix/sysv/linux/arm/bits/rseq.h b/sysdeps/unix/sysv/=
linux/arm/bits/rseq.h
> new file mode 100644
> index 0000000000..c132f0327c
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/arm/bits/rseq.h

> +#ifdef __ARMEB__
> +#define RSEQ_SIG    0xf3def5e7      /* udf    #24035    ; 0x5de3 (ARMv6+=
) */
> +#else
> +#define RSEQ_SIG    0xe7f5def3      /* udf    #24035    ; 0x5de3 */
> +#endif

Likewise, missing indentation.

> diff --git a/sysdeps/unix/sysv/linux/bits/rseq.h b/sysdeps/unix/sysv/linu=
x/bits/rseq.h
> new file mode 100644
> index 0000000000..014c08fe0f
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/bits/rseq.h
> @@ -0,0 +1,29 @@

> +/* RSEQ_SIG is a signature required before each abort handler code.
> +
> +   It is a 32-bit value that maps to actual architecture code compiled
> +   into applications and libraries.  It needs to be defined for each
> +   architecture.  When choosing this value, it needs to be taken into
> +   account that generating invalid instructions may have ill effects on
> +   tools like objdump, and may also have impact on the CPU speculative
> +   execution efficiency in some cases.  */

I wonder if we should say something somewhere that the correct way to
check for compile-time rseq support in glibc is something like this?

#if __has_include (<sys/rseq.h>)
# include <sys/rseq.h>
#endif
#ifdef RSEQ_SIG
=E2=80=A6
#endif

Or perhaps we should suppress installation of the headers if we only
have support for the stub.

(I think this fine tuning can be deferred to later patch.)

> diff --git a/sysdeps/unix/sysv/linux/mips/bits/rseq.h b/sysdeps/unix/sysv=
/linux/mips/bits/rseq.h
> new file mode 100644
> index 0000000000..cbad4290cc
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/mips/bits/rseq.h
> @@ -0,0 +1,62 @@

> +#if defined(__nanomips__)
> +# ifdef __MIPSEL__
> +#  define RSEQ_SIG	0x03500010
> +# else
> +#  define RSEQ_SIG	0x00100350
> +# endif
> +#elif defined(__mips_micromips)
> +# ifdef __MIPSEL__
> +#  define RSEQ_SIG	0xd4070000
> +# else
> +#  define RSEQ_SIG	0x0000d407
> +# endif
> +#elif defined(__mips__)
> +# define RSEQ_SIG	0x0350000d
> +#else
> +/* Unknown MIPS architecture.  */
> +#endif

Please use =E2=80=9Cdefined (=E2=80=9D, with a space.

> diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/=
linux/rseq-internal.h
> new file mode 100644
> index 0000000000..6583691285
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/rseq-internal.h

> +#ifdef RSEQ_SIG
> +static inline void
> +rseq_register_current_thread (void)

> +      if (msg)
> +        __libc_fatal (msg);
> +    }

=E2=80=9Cif (msg !=3D NULL)=E2=80=9D, please.

> +#else
> +static inline void
> +rseq_register_current_thread (void)
> +{
> +}
> +#endif

Maybe add /* RSEQ_SIG */ comments to #else/#endif here as well.

> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux=
/sys/rseq.h
> new file mode 100644
> index 0000000000..ea51194bf8
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h

> +#ifdef __has_include
> +# if __has_include ("linux/rseq.h")
> +#   define __GLIBC_HAVE_KERNEL_RSEQ
> +# endif
> +#else
> +# include <linux/version.h>
> +# if LINUX_VERSION_CODE >=3D KERNEL_VERSION (4, 18, 0)
> +#   define __GLIBC_HAVE_KERNEL_RSEQ
> +# endif
> +#endif

Too much indentation on the define line, I think.

Still missing: #ifdef __ASSEMBLER__.  .S files should be able to include
<sys/rseq.h> to get the definition of RSEQ_SIG.  But I think this can be
deferred to a follow-up.

> +#ifdef __GLIBC_HAVE_KERNEL_RSEQ
> +/* We use the structures declarations from the kernel headers.  */
> +# include <linux/rseq.h>
> +#else
> +/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */

This comment is not true, the kernel headers do not have uptr support.

If we revert the uptr change, we also need to update the manual, I
think.

> +/* Ensure the compiler supports __attribute__ ((aligned)).  */
> +_Static_assert (__alignof__ (struct rseq_cs) >=3D 32, "alignment");
> +_Static_assert (__alignof__ (struct rseq) >=3D 32, "alignment");

This needs #ifndef __cplusplus or something like that.  I'm surprised
that this passes the installed header tests.

> +/* Allocations of struct rseq and struct rseq_cs on the heap need to
> +   be aligned on 32 bytes.  Therefore, use of malloc is discouraged
> +   because it does not guarantee alignment.  posix_memalign should be
> +   used instead.  */
> +
> +extern __thread struct rseq __rseq_abi
> +  __attribute__ ((tls_model ("initial-exec")));

Should be __tls_model__.

We're getting really close now. 8-)

Thanks,
Florian

