Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0C1B9F7A
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 11:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgD0JMG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 27 Apr 2020 05:12:06 -0400
Received: from albireo.enyo.de ([37.24.231.21]:46222 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbgD0JME (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 05:12:04 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jSzno-00041P-Vh; Mon, 27 Apr 2020 09:11:48 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jSzno-0007JF-TF; Mon, 27 Apr 2020 11:11:48 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C startup and thread creation (v17)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <20200326155633.18236-6-mathieu.desnoyers@efficios.com>
Date:   Mon, 27 Apr 2020 11:11:48 +0200
In-Reply-To: <20200326155633.18236-6-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers via Libc-alpha's message of "Thu, 26 Mar 2020 11:56:29
        -0400")
Message-ID: <87ees9z417.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers via Libc-alpha:

> +* Support for automatically registering threads with the Linux rseq(2)
> +  system call has been added.  This system call is implemented starting
> +  from Linux 4.18.  The Restartable Sequences ABI accelerates user-space
> +  operations on per-cpu data.  It allows user-space to perform updates
> +  on per-cpu data without requiring heavy-weight atomic operations.
> +  Automatically registering threads allows all libraries, including libc,
> +  to make immediate use of the rseq(2) support by using the documented ABI.
> +  See 'man 2 rseq' for the details of the ABI shared between libc and the
> +  kernel.

This should refer documentation in the glibc manual.

(It is currently a glibc project requirement to add documentation for
new Linux interfaces, something that I do not necessarily agree with.)

>  
>  Deprecated and removed features, and other changes affecting compatibility:
>  
> diff --git a/elf/libc_early_init.c b/elf/libc_early_init.c
> index 1ac66d895d..30466afea0 100644
> --- a/elf/libc_early_init.c
> +++ b/elf/libc_early_init.c
> @@ -18,10 +18,13 @@
>  
>  #include <ctype.h>
>  #include <libc-early-init.h>
> +#include <rseq-internal.h>
>  
>  void
>  __libc_early_init (void)
>  {
>    /* Initialize ctype data.  */
>    __ctype_init ();
> +  /* Register rseq ABI to the kernel.   */
> +  (void) rseq_register_current_thread ();
>  }

The cast to void should be removed (see below the comment about the
return type.

> diff --git a/manual/threads.texi b/manual/threads.texi
> index 0858ef8f92..59f634e432 100644
> --- a/manual/threads.texi
> +++ b/manual/threads.texi
> @@ -9,8 +9,10 @@ This chapter describes functions used for managing threads.
>  POSIX threads.
>  
>  @menu
> -* ISO C Threads::	Threads based on the ISO C specification.
> -* POSIX Threads::	Threads based on the POSIX specification.
> +* ISO C Threads::		Threads based on the ISO C specification.
> +* POSIX Threads::		Threads based on the POSIX specification.
> +* Restartable Sequences::	Linux-specific Restartable Sequences
> +				integration.
>  @end menu
>  
>  
> @@ -881,3 +883,27 @@ Behaves like @code{pthread_timedjoin_np} except that the absolute time in
>  @c pthread_spin_unlock
>  @c pthread_testcancel
>  @c pthread_yield
> +
> +@node Restartable Sequences
> +@section Restartable Sequences
> +@cindex rseq
> +
> +This section describes @theglibc{} Restartable Sequences integration.
> +
> +@deftypevar {struct rseq} __rseq_abi
> +@standards{GNU, sys/rseq.h}
> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with the
> +Restartable Sequences system call (Linux-specific).  The layout of this
> +structure is defined by the Linux kernel @file{linux/rseq.h} UAPI.
> +Registration of each thread's @code{__rseq_abi} is performed by
> +@theglibc{} at libc initialization and pthread creation.
> +@end deftypevar
> +
> +@deftypevr Macro int RSEQ_SIG
> +@standards{GNU, sys/rseq.h}
> +Each supported architecture provide a @code{RSEQ_SIG} macro in
> +@file{sys/rseq.h} which contains a signature.  That signature is expected to be
> +present in the code before each Restartable Sequences abort handler.  Failure
> +to provide the expected signature may terminate the process with a Segmentation
> +fault.
> +@end deftypevr

This should say Linux, not GNU as the standards source, given that the
interface is not added to the GNU ABI.

Is this sufficient documentation of this feature?  What do others
think about this?

> diff --git a/misc/rseq-internal.h b/misc/rseq-internal.h
> new file mode 100644
> index 0000000000..d564cf1bc3
> --- /dev/null
> +++ b/misc/rseq-internal.h
> @@ -0,0 +1,33 @@

> +static inline int
> +rseq_register_current_thread (void)
> +{
> +  return -1;
> +}

Nothing checks the return value of this function as far as I can see,
so it can return void.

> +static inline int
> +rseq_unregister_current_thread (void)
> +{
> +  return -1;
> +}

This function is unused.  This also applies to the full version.  I
believe we switched to implicit deregistration on thread exit, so I
think you can just remove it.

> diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
> index afd379e89a..1ff248042e 100644
> --- a/nptl/pthread_create.c
> +++ b/nptl/pthread_create.c
> @@ -33,6 +33,7 @@
>  #include <default-sched.h>
>  #include <futex-internal.h>
>  #include <tls-setup.h>
> +#include <rseq-internal.h>
>  #include "libioP.h"
>  
>  #include <shlib-compat.h>
> @@ -384,6 +385,9 @@ START_THREAD_DEFN
>    /* Initialize pointers to locale data.  */
>    __ctype_init ();
>  
> +  /* Register rseq TLS to the kernel. */
> +  (void) rseq_register_current_thread ();
> +

The cast can go.

>  #ifndef __ASSUME_SET_ROBUST_LIST
>    if (__set_robust_list_avail >= 0)
>  #endif
> @@ -578,6 +582,14 @@ START_THREAD_DEFN
>       process is really dead since 'clone' got passed the CLONE_CHILD_CLEARTID
>       flag.  The 'tid' field in the TCB will be set to zero.
>  
> +     rseq TLS is still registered at this point. Rely on implicit unregistration
> +     performed by the kernel on thread teardown. This is not a problem because the
> +     rseq TLS lives on the stack, and the stack outlives the thread. If TCB
> +     allocation is ever changed, additional steps may be required, such as
> +     performing explicit rseq unregistration before reclaiming the rseq TLS area
> +     memory. It is NOT sufficient to block signals because the kernel may write
> +     to the rseq area even without signals.
> +
>       The exit code is zero since in case all threads exit by calling
>       'pthread_exit' the exit status must be 0 (zero).  */
>    __exit_thread ();

Some of these lines are too long.  Also two spaces after . at the end
of sentences.

> diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/linux/rseq-internal.h
> new file mode 100644
> index 0000000000..5f7f02f1ec
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/rseq-internal.h

> +static inline int
> +rseq_register_current_thread (void)
> +{
> +  int rc, ret = 0;
> +
> +  if (__rseq_abi.cpu_id == RSEQ_CPU_ID_REGISTRATION_FAILED)
> +    return -1;
> +  rc = INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
> +                              0, RSEQ_SIG);
> +  if (!rc)
> +    goto end;
> +  if (INTERNAL_SYSCALL_ERRNO (rc) != EBUSY)
> +    __rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
> +  ret = -1;
> +end:
> +  return ret;
> +}

This does not seem to use INTERNAL_SYSCALL_CALL correctly.  I think
you need to use INTERNAL_SYSCALL_ERROR_P on the result to check for an
error, and only then use INTERNAL_SYSCALL_ERRNO to extract the error
code.

> diff --git a/sysdeps/unix/sysv/linux/rseq-sym.c b/sysdeps/unix/sysv/linux/rseq-sym.c
> new file mode 100644
> index 0000000000..0e33fab278
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/rseq-sym.c

> +#include <sys/syscall.h>
> +#include <stdint.h>
> +#include <kernel-features.h>
> +#include <sys/rseq.h>
> +
> +__thread struct rseq __rseq_abi = {
> +  .cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
> +};

{ should go onto its own line.  I'd also add attribute_tls_model_ie,
also it's implied by the declaration in the header.

> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux/sys/rseq.h
> new file mode 100644
> index 0000000000..503dce4cac
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
> @@ -0,0 +1,186 @@

I think there is some value in making this header compatible with
inclusion from the assembler (including constants for the relevant
struct offsets), but that can be a later change.

> +#ifndef _SYS_RSEQ_H
> +#define _SYS_RSEQ_H	1
> +
> +/* Architecture-specific rseq signature.  */
> +#include <bits/rseq.h>

Maybe add a newline between the above and the following, to make clear
the comment only applies to the first #include.

> +#include <stdint.h>
> +#include <sys/cdefs.h>
> +
> +#ifdef __has_include
> +# if __has_include ("linux/rseq.h")
> +#   define __GLIBC_HAVE_KERNEL_RSEQ
> +# endif
> +#else
> +# include <linux/version.h>
> +# if LINUX_VERSION_CODE >= KERNEL_VERSION (4, 18, 0)
> +#   define __GLIBC_HAVE_KERNEL_RSEQ
> +# endif
> +#endif
> +
> +#ifdef __GLIBC_HAVE_KERNEL_RSEQ
> +/* We use the structures declarations from the kernel headers.  */
> +# include <linux/rseq.h>
> +#else
> +/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */
> +
> +#include <asm/byteorder.h>
> +
> +enum rseq_cpu_id_state
> +  {
> +    RSEQ_CPU_ID_UNINITIALIZED = -1,
> +    RSEQ_CPU_ID_REGISTRATION_FAILED = -2,
> +  };
> +
> +enum rseq_flags
> +  {
> +    RSEQ_FLAG_UNREGISTER = (1 << 0),
> +  };
> +
> +enum rseq_cs_flags_bit
> +  {
> +    RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT = 0,
> +    RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT = 1,
> +    RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT = 2,
> +  };
> +
> +enum rseq_cs_flags
> +  {
> +    RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT =
> +      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
> +    RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL =
> +      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
> +    RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE =
> +      (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
> +  };
> +
> +/* struct rseq_cs is aligned on 4 * 8 bytes to ensure it is always
> +   contained within a single cache-line. It is usually declared as
> +   link-time constant data.  */
> +struct rseq_cs
> +  {
> +    /* Version of this structure.  */
> +    uint32_t version;
> +    /* enum rseq_cs_flags.  */
> +    uint32_t flags;
> +    uint64_t start_ip;
> +    /* Offset from start_ip.  */
> +    uint64_t post_commit_offset;
> +    uint64_t abort_ip;
> +} __attribute__((aligned(4 * sizeof(uint64_t))));

The comment is wrong.  32-byte alignment does not put struct rseq_cs
on its own cache line on many (most?) CPUs.  Not using the constant 32
looks like unnecessary obfuscation to me.

I still think we should avoid the alignment.  The _ip fields should
perhaps be _pc (IP is more or less specific to x86).

{ and } are not aligned.  Please do not forget to add spaces before
opening parentheses, and two spaces after the . and the end of
sentences.  The opening { should always be on its own line.  (This
also applies to the definition of struct rseq below.)

> +
> +/* struct rseq is aligned on 4 * 8 bytes to ensure it is always
> +   contained within a single cache-line.
> +
> +   A single struct rseq per thread is allowed.  */
> +struct rseq
> +  {
> +    /* Restartable sequences cpu_id_start field. Updated by the
> +       kernel. Read by user-space with single-copy atomicity
> +       semantics. This field should only be read by the thread which
> +       registered this data structure. Aligned on 32-bit. Always

What does “Aligned on 32-bit” mean in this context?  Do you mean to
reference 32-*byte* alignment here?

> +    /* Restartable sequences rseq_cs field.
> +
> +       Contains NULL when no critical section is active for the current
> +       thread, or holds a pointer to the currently active struct rseq_cs.
> +
> +       Updated by user-space, which sets the address of the currently
> +       active rseq_cs at the beginning of assembly instruction sequence
> +       block, and set to NULL by the kernel when it restarts an assembly
> +       instruction sequence block, as well as when the kernel detects that
> +       it is preempting or delivering a signal outside of the range
> +       targeted by the rseq_cs. Also needs to be set to NULL by user-space
> +       before reclaiming memory that contains the targeted struct rseq_cs.
> +
> +       Read and set by the kernel. Set by user-space with single-copy
> +       atomicity semantics. This field should only be updated by the
> +       thread which registered this data structure. Aligned on 64-bit.  */
> +    union {
> +      uint64_t ptr64;
> +#ifdef __LP64__
> +      uint64_t ptr;
> +#else
> +      struct {
> +#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined(__BIG_ENDIAN)
> +        uint32_t padding; /* Initialized to zero.  */
> +        uint32_t ptr32;
> +#else /* LITTLE */
> +        uint32_t ptr32;
> +        uint32_t padding; /* Initialized to zero.  */
> +#endif /* ENDIAN */
> +      } ptr;
> +#endif
> +    } rseq_cs;

Are these conditionals correct for x32?  Shouldn't there be a member
of type const struct rseq_cs * somewhere?

> diff --git a/sysdeps/unix/sysv/linux/x86/bits/rseq.h b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
> new file mode 100644
> index 0000000000..75f52d9788
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/x86/bits/rseq.h
> @@ -0,0 +1,30 @@
> +/* Restartable Sequences Linux x86 architecture header.
> +   Copyright (C) 2019-2020 Free Software Foundation, Inc.

Please make sure that none of the new files reference the 2019 year.
It should be 2020, per GNU policy.

The patch needs some rebasing on top of current master.
