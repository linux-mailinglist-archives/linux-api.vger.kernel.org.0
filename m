Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68931BAA3D
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 18:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgD0QqK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 12:46:10 -0400
Received: from mail.efficios.com ([167.114.26.124]:44942 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgD0QqJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 12:46:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E793725AA2C;
        Mon, 27 Apr 2020 12:40:49 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vXigyrb4ALM5; Mon, 27 Apr 2020 12:40:48 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BE6A325A546;
        Mon, 27 Apr 2020 12:40:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BE6A325A546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588005648;
        bh=CJW2+LbckLL1pCYHO0SvRfwy4PoMUExCTJDNXYVXpKg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=p4OavsRlfLe3C/v6vsi9jFwtsY3wPI1OEzg9xgWRrRtq/mSszvqFx+tAMmEtVubyF
         kovY8q0YQBlTAY3MADliaNf3ZiODDzss/W5ppityvoSs/MuiWj2moa4y0+I03Nbfiw
         g4TNK8ph83UfyE0yoJKFL1qkex0oLPL3uILW679XNaajVSEXtBO+R8n6MXWvPPlDPS
         cVqDv/QN9bR/+qDpmbtWo5ABuidK7jU1eYsawLmrrd+6P+2T+b471ehmOJum/4HCtQ
         mhc+y6/RoEY1fXNEhqBxfPxpBKWE1/PoH6R2zIQRAtKd1FuBVDfYZUjfgQTkeYX4Ua
         yD3RFEaEgFllg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ocpc0geReoR5; Mon, 27 Apr 2020 12:40:48 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A073D25A756;
        Mon, 27 Apr 2020 12:40:48 -0400 (EDT)
Date:   Mon, 27 Apr 2020 12:40:48 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>, carlos <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
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
Message-ID: <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com>
In-Reply-To: <87ees9z417.fsf@mid.deneb.enyo.de>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <20200326155633.18236-6-mathieu.desnoyers@efficios.com> <87ees9z417.fsf@mid.deneb.enyo.de>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: /j9NkOdwpAcG2p0QWhkHsXuWBFxTSw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 27, 2020, at 5:11 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers via Libc-alpha:
>=20
>> +* Support for automatically registering threads with the Linux rseq(2)
>> +  system call has been added.  This system call is implemented starting
>> +  from Linux 4.18.  The Restartable Sequences ABI accelerates user-spac=
e
>> +  operations on per-cpu data.  It allows user-space to perform updates
>> +  on per-cpu data without requiring heavy-weight atomic operations.
>> +  Automatically registering threads allows all libraries, including lib=
c,
>> +  to make immediate use of the rseq(2) support by using the documented =
ABI.
>> +  See 'man 2 rseq' for the details of the ABI shared between libc and t=
he
>> +  kernel.
>=20
> This should refer documentation in the glibc manual.
>=20
> (It is currently a glibc project requirement to add documentation for
> new Linux interfaces, something that I do not necessarily agree with.)

A related issue here is that editing of the rseq(2) man pages has been stal=
led
since March 2019. I have been waiting for reply from Michael Kerrisk, and I
suspect he might have be side-tracked by other projects. I just bumped that
thread.

Ref.: https://lore.kernel.org/r/211707091.921.1551722548347.JavaMail.zimbra=
@efficios.com

So as of today, "man 2 rseq" does not exist in the kernel man pages, so I
suggest we remove that sentence. Would the following change be OK with you =
?

-  See 'man 2 rseq' for the details of the ABI shared between libc and the
-  kernel.
+  The GNU C Library manual has details on integration of Restartable
+  Sequences.

>=20
>> =20
>>  Deprecated and removed features, and other changes affecting compatibil=
ity:
>> =20
>> diff --git a/elf/libc_early_init.c b/elf/libc_early_init.c
>> index 1ac66d895d..30466afea0 100644
>> --- a/elf/libc_early_init.c
>> +++ b/elf/libc_early_init.c
>> @@ -18,10 +18,13 @@
>> =20
>>  #include <ctype.h>
>>  #include <libc-early-init.h>
>> +#include <rseq-internal.h>
>> =20
>>  void
>>  __libc_early_init (void)
>>  {
>>    /* Initialize ctype data.  */
>>    __ctype_init ();
>> +  /* Register rseq ABI to the kernel.   */
>> +  (void) rseq_register_current_thread ();
>>  }
>=20
> The cast to void should be removed (see below the comment about the
> return type.

OK

>=20
>> diff --git a/manual/threads.texi b/manual/threads.texi
>> index 0858ef8f92..59f634e432 100644
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
>> =20
>> =20
>> @@ -881,3 +883,27 @@ Behaves like @code{pthread_timedjoin_np} except tha=
t the
>> absolute time in
>>  @c pthread_spin_unlock
>>  @c pthread_testcancel
>>  @c pthread_yield
>> +
>> +@node Restartable Sequences
>> +@section Restartable Sequences
>> +@cindex rseq
>> +
>> +This section describes @theglibc{} Restartable Sequences integration.
>> +
>> +@deftypevar {struct rseq} __rseq_abi
>> +@standards{GNU, sys/rseq.h}
>> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with =
the
>> +Restartable Sequences system call (Linux-specific).  The layout of this
>> +structure is defined by the Linux kernel @file{linux/rseq.h} UAPI.
>> +Registration of each thread's @code{__rseq_abi} is performed by
>> +@theglibc{} at libc initialization and pthread creation.
>> +@end deftypevar
>> +
>> +@deftypevr Macro int RSEQ_SIG
>> +@standards{GNU, sys/rseq.h}
>> +Each supported architecture provide a @code{RSEQ_SIG} macro in
>> +@file{sys/rseq.h} which contains a signature.  That signature is expect=
ed to be
>> +present in the code before each Restartable Sequences abort handler.  F=
ailure
>> +to provide the expected signature may terminate the process with a Segm=
entation
>> +fault.
>> +@end deftypevr
>=20
> This should say Linux, not GNU as the standards source, given that the
> interface is not added to the GNU ABI.

Good point, done.

>=20
> Is this sufficient documentation of this feature?  What do others
> think about this?

I'll leave this question to others.

>=20
>> diff --git a/misc/rseq-internal.h b/misc/rseq-internal.h
>> new file mode 100644
>> index 0000000000..d564cf1bc3
>> --- /dev/null
>> +++ b/misc/rseq-internal.h
>> @@ -0,0 +1,33 @@
>=20
>> +static inline int
>> +rseq_register_current_thread (void)
>> +{
>> +  return -1;
>> +}
>=20
> Nothing checks the return value of this function as far as I can see,
> so it can return void.

OK

>=20
>> +static inline int
>> +rseq_unregister_current_thread (void)
>> +{
>> +  return -1;
>> +}
>=20
> This function is unused.  This also applies to the full version.  I
> believe we switched to implicit deregistration on thread exit, so I
> think you can just remove it.

OK

>=20
>> diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
>> index afd379e89a..1ff248042e 100644
>> --- a/nptl/pthread_create.c
>> +++ b/nptl/pthread_create.c
>> @@ -33,6 +33,7 @@
>>  #include <default-sched.h>
>>  #include <futex-internal.h>
>>  #include <tls-setup.h>
>> +#include <rseq-internal.h>
>>  #include "libioP.h"
>> =20
>>  #include <shlib-compat.h>
>> @@ -384,6 +385,9 @@ START_THREAD_DEFN
>>    /* Initialize pointers to locale data.  */
>>    __ctype_init ();
>> =20
>> +  /* Register rseq TLS to the kernel. */
>> +  (void) rseq_register_current_thread ();
>> +
>=20
> The cast can go.

OK

>=20
>>  #ifndef __ASSUME_SET_ROBUST_LIST
>>    if (__set_robust_list_avail >=3D 0)
>>  #endif
>> @@ -578,6 +582,14 @@ START_THREAD_DEFN
>>       process is really dead since 'clone' got passed the CLONE_CHILD_CL=
EARTID
>>       flag.  The 'tid' field in the TCB will be set to zero.
>> =20
>> +     rseq TLS is still registered at this point. Rely on implicit
>> unregistration
>> +     performed by the kernel on thread teardown. This is not a problem =
because
>> the
>> +     rseq TLS lives on the stack, and the stack outlives the thread. If=
 TCB
>> +     allocation is ever changed, additional steps may be required, such=
 as
>> +     performing explicit rseq unregistration before reclaiming the rseq=
 TLS
>> area
>> +     memory. It is NOT sufficient to block signals because the kernel m=
ay write
>> +     to the rseq area even without signals.
>> +
>>       The exit code is zero since in case all threads exit by calling
>>       'pthread_exit' the exit status must be 0 (zero).  */
>>    __exit_thread ();
>=20
> Some of these lines are too long.  Also two spaces after . at the end
> of sentences.

OK

>=20
>> diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h
>> b/sysdeps/unix/sysv/linux/rseq-internal.h
>> new file mode 100644
>> index 0000000000..5f7f02f1ec
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/rseq-internal.h
>=20
>> +static inline int
>> +rseq_register_current_thread (void)
>> +{
>> +  int rc, ret =3D 0;
>> +
>> +  if (__rseq_abi.cpu_id =3D=3D RSEQ_CPU_ID_REGISTRATION_FAILED)
>> +    return -1;
>> +  rc =3D INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq)=
,
>> +                              0, RSEQ_SIG);
>> +  if (!rc)
>> +    goto end;
>> +  if (INTERNAL_SYSCALL_ERRNO (rc) !=3D EBUSY)
>> +    __rseq_abi.cpu_id =3D RSEQ_CPU_ID_REGISTRATION_FAILED;
>> +  ret =3D -1;
>> +end:
>> +  return ret;
>> +}
>=20
> This does not seem to use INTERNAL_SYSCALL_CALL correctly.  I think
> you need to use INTERNAL_SYSCALL_ERROR_P on the result to check for an
> error, and only then use INTERNAL_SYSCALL_ERRNO to extract the error
> code.

OK

>=20
>> diff --git a/sysdeps/unix/sysv/linux/rseq-sym.c
>> b/sysdeps/unix/sysv/linux/rseq-sym.c
>> new file mode 100644
>> index 0000000000..0e33fab278
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/rseq-sym.c
>=20
>> +#include <sys/syscall.h>
>> +#include <stdint.h>
>> +#include <kernel-features.h>
>> +#include <sys/rseq.h>
>> +
>> +__thread struct rseq __rseq_abi =3D {
>> +  .cpu_id =3D RSEQ_CPU_ID_UNINITIALIZED,
>> +};
>=20
> { should go onto its own line.

OK

> I'd also add attribute_tls_model_ie,
> also it's implied by the declaration in the header.

This contradicts feedback I received from Szabolcs Nagy in September 2019:

https://public-inbox.org/libc-alpha/c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86@ar=
m.com/

"note that libpthread.so is built with -ftls-model=3Dinitial-exec

(and if it wasn't then you'd want to put the attribute on the
declaration in the internal header file, not on the definition,
so the actual tls accesses generate the right code)"

In the context of his feedback, __rseq_abi was defined within nptl/pthread_=
create.c.
It is now defined in sysdeps/unix/sysv/linux/rseq-sym.c, which is built int=
o the
csu which AFAIU ends up in libc.so. His comment still applies though, becau=
se
libc.so is also built with -ftls-model=3Dinitial-exec.

So should I apply the "initial-exec" TLS model only to the __rseq_abi
declaration, or is it preferred to apply it to both the declaration
and the definition ?

>=20
>> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h
>> b/sysdeps/unix/sysv/linux/sys/rseq.h
>> new file mode 100644
>> index 0000000000..503dce4cac
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
>> @@ -0,0 +1,186 @@
>=20
> I think there is some value in making this header compatible with
> inclusion from the assembler (including constants for the relevant
> struct offsets), but that can be a later change.

Agreed. By "later", do you mean before merging the patch, between
merge of the patch and next glibc release, or for a subsequent glibc
release ?

>=20
>> +#ifndef _SYS_RSEQ_H
>> +#define _SYS_RSEQ_H=091
>> +
>> +/* Architecture-specific rseq signature.  */
>> +#include <bits/rseq.h>
>=20
> Maybe add a newline between the above and the following, to make clear
> the comment only applies to the first #include.

OK

>=20
>> +#include <stdint.h>
>> +#include <sys/cdefs.h>
>> +
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
>> +
>> +#ifdef __GLIBC_HAVE_KERNEL_RSEQ
>> +/* We use the structures declarations from the kernel headers.  */
>> +# include <linux/rseq.h>
>> +#else
>> +/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */
>> +
>> +#include <asm/byteorder.h>
>> +
>> +enum rseq_cpu_id_state
>> +  {
>> +    RSEQ_CPU_ID_UNINITIALIZED =3D -1,
>> +    RSEQ_CPU_ID_REGISTRATION_FAILED =3D -2,
>> +  };
>> +
>> +enum rseq_flags
>> +  {
>> +    RSEQ_FLAG_UNREGISTER =3D (1 << 0),
>> +  };
>> +
>> +enum rseq_cs_flags_bit
>> +  {
>> +    RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT =3D 0,
>> +    RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT =3D 1,
>> +    RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT =3D 2,
>> +  };
>> +
>> +enum rseq_cs_flags
>> +  {
>> +    RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT =3D
>> +      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
>> +    RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL =3D
>> +      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
>> +    RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE =3D
>> +      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>> +  };
>> +
>> +/* struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
>> +   contained within a single cache-line. It is usually declared as
>> +   link-time constant data.  */
>> +struct rseq_cs
>> +  {
>> +    /* Version of this structure.  */
>> +    uint32_t version;
>> +    /* enum rseq_cs_flags.  */
>> +    uint32_t flags;
>> +    uint64_t start_ip;
>> +    /* Offset from start_ip.  */
>> +    uint64_t post_commit_offset;
>> +    uint64_t abort_ip;
>> +} __attribute__((aligned(4 * sizeof(uint64_t))));
>=20
> The comment is wrong.  32-byte alignment does not put struct rseq_cs
> on its own cache line on many (most?) CPUs.  Not using the constant 32
> looks like unnecessary obfuscation to me.

There is a difference between "being contained within a single cache-line"
and "being the only structure in a cache-line". The objective here is the
former.

For instance, if we do not enforce any minimum alignment, the compiler coul=
d
decide to align that structure on __alignof__(uint64_t) which happens to be
4 bytes on some architectures. This can cause this frequently accessed stru=
cture
to be sitting across 2 cache-lines, thus requiring the CPU to load two cach=
e
lines rather than one very frequently.

I think what you have in mind is "being the only structure in a cache-line"=
,
which is useful to eliminate false-sharing. However, considering that this =
is
a TLS variable, we don't care about false-sharing, because it is never mean=
t
to be updated concurrently by many threads or CPUs.

So I think my comment is correct.

I agree that the constant 32 may be clearer here. I will change to align(32=
).

> I still think we should avoid the alignment.  The _ip fields should
> perhaps be _pc (IP is more or less specific to x86).

I am concerned that removing an alignment attribute which is exposed
in a public Linux UAPI header can be an ABI breakage.

I am also concerned about changing field names for fields already
exposed in a public Linux UAPI header, especially if the change is
only for cosmetic reasons.

>=20
> { and } are not aligned.  Please do not forget to add spaces before
> opening parentheses, and two spaces after the . and the end of
> sentences.  The opening { should always be on its own line.  (This
> also applies to the definition of struct rseq below.)

OK. Old coding style habits die hard ;)

>=20
>> +
>> +/* struct rseq is aligned on 4 * 8 bytes to ensure it is always
>> +   contained within a single cache-line.
>> +
>> +   A single struct rseq per thread is allowed.  */
>> +struct rseq
>> +  {
>> +    /* Restartable sequences cpu_id_start field. Updated by the
>> +       kernel. Read by user-space with single-copy atomicity
>> +       semantics. This field should only be read by the thread which
>> +       registered this data structure. Aligned on 32-bit. Always
>=20
> What does =E2=80=9CAligned on 32-bit=E2=80=9D mean in this context?  Do y=
ou mean to
> reference 32-*byte* alignment here?

No. I really mean 32-bit (4-byte). Being aligned on 32-byte guarantees that
this field is aligned at least on 4-byte. This is required by single-copy
atomicity semantics.

Should I update this comment to state "Aligned on 4-byte" instead ?

>=20
>> +    /* Restartable sequences rseq_cs field.
>> +
>> +       Contains NULL when no critical section is active for the current
>> +       thread, or holds a pointer to the currently active struct rseq_c=
s.
>> +
>> +       Updated by user-space, which sets the address of the currently
>> +       active rseq_cs at the beginning of assembly instruction sequence
>> +       block, and set to NULL by the kernel when it restarts an assembl=
y
>> +       instruction sequence block, as well as when the kernel detects t=
hat
>> +       it is preempting or delivering a signal outside of the range
>> +       targeted by the rseq_cs. Also needs to be set to NULL by user-sp=
ace
>> +       before reclaiming memory that contains the targeted struct rseq_=
cs.
>> +
>> +       Read and set by the kernel. Set by user-space with single-copy
>> +       atomicity semantics. This field should only be updated by the
>> +       thread which registered this data structure. Aligned on 64-bit. =
 */
>> +    union {
>> +      uint64_t ptr64;
>> +#ifdef __LP64__
>> +      uint64_t ptr;
>> +#else
>> +      struct {
>> +#if (defined(__BYTE_ORDER) && (__BYTE_ORDER =3D=3D __BIG_ENDIAN)) ||
>> defined(__BIG_ENDIAN)
>> +        uint32_t padding; /* Initialized to zero.  */
>> +        uint32_t ptr32;
>> +#else /* LITTLE */
>> +        uint32_t ptr32;
>> +        uint32_t padding; /* Initialized to zero.  */
>> +#endif /* ENDIAN */
>> +      } ptr;
>> +#endif
>> +    } rseq_cs;
>=20
> Are these conditionals correct for x32?

Let's see. With x86 gcc:

-m64: (__x86_64__ && __LP64__)
-m32: (__i386__)
-mx32: (__x86_64__ && __ILP32__)

So with "#ifdef __LP64__" we specifically target 64-bit pointers. The rest
falls into the "else" case, which expects 32-bit pointers. Considering that
x32 has 32-bit pointers, I don't see any issue here.

> Shouldn't there be a member of type const struct rseq_cs * somewhere?

Having pointers within structures in kernel UAPI headers is frowned upon. I=
ndeed
here having it in the union could possibly make some use-cases easier in
user-space, so I'm open to it. It basically depends on how much we want the
Linux UAPI header and the glibc header to stay in sync, and if other kernel
maintainers are open to this addition.

We don't mind that user-space uses that pointer, but we never want the kern=
el
to touch that pointer rather than the 32/64-bit-aware fields. One possibili=
ty
would be to do:

    union
      {
        uint64_t ptr64;
#ifdef __LP64__
        uint64_t ptr;
#else
        struct
          {
#if (defined (__BYTE_ORDER) && (__BYTE_ORDER =3D=3D __BIG_ENDIAN)) || defin=
ed (__BIG_ENDIAN)
            uint32_t padding; /* Initialized to zero.  */
            uint32_t ptr32;
#else /* LITTLE */
            uint32_t ptr32;
            uint32_t padding; /* Initialized to zero.  */
#endif /* ENDIAN */
          } ptr;
#endif

#ifndef __KERNEL__
     const struct rseq_cs *uptr;
#endif
      } rseq_cs;

in the union, so only user-space can see that field. Thoughts ?

>=20
>> diff --git a/sysdeps/unix/sysv/linux/x86/bits/rseq.h
>> b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
>> new file mode 100644
>> index 0000000000..75f52d9788
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
>> @@ -0,0 +1,30 @@
>> +/* Restartable Sequences Linux x86 architecture header.
>> +   Copyright (C) 2019-2020 Free Software Foundation, Inc.
>=20
> Please make sure that none of the new files reference the 2019 year.
> It should be 2020, per GNU policy.

OK

>=20
> The patch needs some rebasing on top of current master.

Done.

Thanks for the review!

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
