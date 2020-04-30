Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F851C01D1
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 18:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgD3QLm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 12:11:42 -0400
Received: from mail.efficios.com ([167.114.26.124]:37050 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgD3QLl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 12:11:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 001A928F96E;
        Thu, 30 Apr 2020 12:11:39 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZrlHXs6onGvu; Thu, 30 Apr 2020 12:11:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4475228F96D;
        Thu, 30 Apr 2020 12:11:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4475228F96D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588263099;
        bh=2HwmJtEER070u4lBMJNXi64Ro52thqNyCskx+bYyreU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MoTfSQgeO6MWHIPVK45ojlMTg7nXX5Up9jNClABjWgb5HYvdSNfu3JLUgoIJT5e6o
         8hsHQiZhfxVcqKCVreFolKpDmYwcAZ1j0++ck80sBEidtY7nYO+Sc0spmGf1it7I7y
         QCagnVIU0QWtrQWMq7AEvGEePWE/YSKm44EJXEZmciJkePIOw5i4aYZptRUVAlmVSo
         pNHlwn+mAHXBT2sLHthapnzwr7SZULnB+VtNULyr3h7InxsDrkRVOLkHlO91HVCSuR
         w1zXyRx8oluM2Zgzfl3IhhZqRqA4+/YyVqbmFnhGvEpMNgCvwaxD29GKZlnmqo8+JU
         iAIUK4+BG0+rw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5FQtNU0dVzqx; Thu, 30 Apr 2020 12:11:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 27AE028F786;
        Thu, 30 Apr 2020 12:11:39 -0400 (EDT)
Date:   Thu, 30 Apr 2020 12:11:39 -0400 (EDT)
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
Message-ID: <1287616647.77866.1588263099045.JavaMail.zimbra@efficios.com>
In-Reply-To: <875zdhmaft.fsf@oldenburg2.str.redhat.com>
References: <20200428171513.22926-1-mathieu.desnoyers@efficios.com> <875zdhmaft.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH glibc 1/3] glibc: Perform rseq(2) registration at C
 startup and thread creation (v18)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v18)
Thread-Index: ALv7ejwfabU6s2zeyWwqXfxwmTruEg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 30, 2020, at 8:20 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
>=20
>> diff --git a/NEWS b/NEWS
>> index 0e627b3405..0b85a02c12 100644
>> --- a/NEWS
>> +++ b/NEWS
>> @@ -18,6 +18,16 @@ Major new features:
>>  * The GNU C Library now loads audit modules listed in the DT_AUDIT and
>>    DT_DEPAUDIT dynamic section entries of the main executable.
>> =20
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
>> +  The GNU C Library manual has details on integration of Restartable
>> +  Sequences.
>=20
> GNU style doesn't use (2) here, I think.

OK

>=20
>> diff --git a/manual/threads.texi b/manual/threads.texi
>> index 0858ef8f92..4754cdaeb5 100644
>> --- a/manual/threads.texi
>> +++ b/manual/threads.texi
>=20
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
>=20
> Suggest: @cindex Restartable Sequences

OK

>=20
>> +
>> +This section describes @theglibc{} Restartable Sequences integration.
>=20
> Suggest: This section describes Restartable Sequences integration for
> @theglibc{}.  (Avoids an excessively long noun phrase.)

OK

>=20
> Maybe mention which uses of the rseq syscall are permitted behind the
> back of glibc?  And that code should not leave dangling rseq cs pointers
> behind (the dlopen interaction)?

Here is the entire updated section, let me know if I missed anything:

@deftypevar {struct rseq} __rseq_abi
@standards{Linux, sys/rseq.h}
@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with the
Restartable Sequences system call (Linux-specific).  The layout of this
structure is defined by the @file{sys/rseq.h} header.  Registration of each
thread's @code{__rseq_abi} is performed by @theglibc{} at libc library
initialization and thread creation.

The main executable and shared libraries may either have an undefined
@code{__rseq_abi} TLS symbol, or define their own, with the same
declaration as the one present in @file{sys/rseq.h}.  The dynamic linker
will ensure that only one of those available symbols will be used at
runtime across the process.

If the main executable or shared libraries observe an uninitialized
@code{__rseq_abi.cpu_id} field (value @code{RSEQ_CPU_ID_UNINITIALIZED}), th=
ey
may perform rseq registration to the kernel: this means either glibc was
prevented from doing the registration, or an older glibc version, which doe=
s
not include rseq support, is in use.  When the main executable or a library
thus takes ownership of the registration, the memory used to hold the
@code{__rseq_abi} TLS variable must stay allocated, and is not re-used, unt=
il
the very end of the thread lifetime or until an explicit rseq unregistratio=
n
for that thread is performed.  It is not recommended to dlclose() libraries
owning the @code{__rseq_abi} TLS variable.

Users of the @code{__rseq_abi} TLS symbol can store the address of a
@code{struct rseq_cs} to the @code{__rseq_abi.rseq_cs.uptr.ptr} TLS variabl=
e,
thus informing the kernel that it enters a Restartable Sequence critical
section.  This pointer and the code areas it itself points to must not be l=
eft
pointing to memory areas which are freed or re-used.  Several approaches ca=
n
guarantee this.  If the application or library can guarantee that the memor=
y
used to hold the @code{struct rseq_cs} and the code areas it refers to are
never freed or re-used, no special action must be taken.  Else, before that
memory is re-used of freed, the application is responsible for setting the
@code{__rseq_abi.rseq_cs.uptr.ptr} TLS variable to @code{NULL} in each thre=
ad's
TLS to guarantee that it does not leak dangling references.  Because the
application does not typically have knowledge of libraries' use of Restarta=
ble
Sequences, it is recommended that libraries using Restartable Sequences whi=
ch
may end up freeing or re-using their memory set the
@code{__rseq_abi.rseq_cs.uptr.ptr} TLS variable to @code{NULL} before retur=
ning
from library functions which use Restartable Sequences.

>=20
>> +@deftypevar {struct rseq} __rseq_abi
>> +@standards{Linux, sys/rseq.h}
>> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with =
the
>> +Restartable Sequences system call (Linux-specific).  The layout of this
>> +structure is defined by the Linux kernel @file{linux/rseq.h} UAPI.
>=20
> The linux/rseq.h reference seems redundant, given that sys/rseq.h covers
> it as well.

OK

>=20
>> +Registration of each thread's @code{__rseq_abi} is performed by
>> +@theglibc{} at libc initialization and pthread creation.
>=20
> Suggest: library initialization and thread creation

OK

>=20
>> +@end deftypevar
>> +
>> +@deftypevr Macro int RSEQ_SIG
>> +@standards{Linux, sys/rseq.h}
>> +Each supported architecture provide a @code{RSEQ_SIG} macro in
>=20
> Typo: provides

OK

>=20
>> +@file{sys/rseq.h} which contains a signature.  That signature is expect=
ed to be
>> +present in the code before each Restartable Sequences abort handler.  F=
ailure
>> +to provide the expected signature may terminate the process with a Segm=
entation
>> +fault.
>=20
> Suggest: segmentation fault (no capitalization)

OK

>=20
>> diff --git a/misc/rseq-internal.h b/misc/rseq-internal.h
>> new file mode 100644
>> index 0000000000..16f197397f
>> --- /dev/null
>> +++ b/misc/rseq-internal.h
>=20
> Maybe this should go in to sysdeps/generic instead of misc?
> (See the recent discussion about elf_machine_sym_no_match.)

OK

>=20
>> diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h
>> b/sysdeps/unix/sysv/linux/rseq-internal.h
>> new file mode 100644
>> index 0000000000..3ecd4d0611
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/rseq-internal.h
>> @@ -0,0 +1,47 @@
>> +/* Restartable Sequences internal API.  Linux implementation.
>> +   Copyright (C) 2020 Free Software Foundation, Inc.
>> +
>> +   The GNU C Library is free software; you can redistribute it and/or
>> +   modify it under the terms of the GNU Lesser General Public
>> +   License as published by the Free Software Foundation; either
>> +   version 2.1 of the License, or (at your option) any later version.
>> +
>> +   The GNU C Library is distributed in the hope that it will be useful,
>> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> +   Lesser General Public License for more details.
>> +
>> +   You should have received a copy of the GNU Lesser General Public
>> +   License along with the GNU C Library; if not, see
>> +   <https://www.gnu.org/licenses/>.  */
>> +
>> +#ifndef RSEQ_INTERNAL_H
>> +#define RSEQ_INTERNAL_H
>> +
>> +#include <sysdep.h>
>> +#include <errno.h>
>> +#include <kernel-features.h>
>> +#include <sys/rseq.h>
>> +
>> +#ifdef RSEQ_SIG
>> +static inline void
>> +rseq_register_current_thread (void)
>> +{
>> +  int ret;
>> +
>> +  if (__rseq_abi.cpu_id =3D=3D RSEQ_CPU_ID_REGISTRATION_FAILED)
>> +    return;
>> +  ret =3D INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq=
),
>> +                              0, RSEQ_SIG);
>> +  if (INTERNAL_SYSCALL_ERROR_P (ret) &&
>> +      INTERNAL_SYSCALL_ERRNO (ret) !=3D EBUSY)
>> +    __rseq_abi.cpu_id =3D RSEQ_CPU_ID_REGISTRATION_FAILED;
>=20
> Sorry, I forgot: Please add a comment that the EBUSY error is ignored
> because registration may have already happened in a legacy library.

Considering that we now disable signals across thread creation, and that
glibc's initialization happens before other libraries' constructors
(as far as I remember even before LD_PRELOADed library constructors),
in which scenario can we expect to have EBUSY here ?

Not setting __rseq_abi.cpu_id to RSEQ_CPU_ID_REGISTRATION_FAILED in case
of EBUSY is more a way to handle "unforeseen" scenarios where somehow the
registration would already be done. But I cannot find an "expected"
scenario which would lead to this now.

So if EBUSY really is unexpected, how should we treat that ? I don't think
setting REGISTRATION_FAILED would be appropriate, because then it would
break assumption of the prior successful registration that have already
been done by this thread.

>=20
>> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h
>> b/sysdeps/unix/sysv/linux/sys/rseq.h
>> new file mode 100644
>> index 0000000000..de6600ff45
>> --- /dev/null
>> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
>=20
>> +#ifdef __GLIBC_HAVE_KERNEL_RSEQ
>> +/* We use the structures declarations from the kernel headers.  */
>> +# include <linux/rseq.h>
>> +#else
>> +/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */
>> +
>> +#include <asm/byteorder.h>
>=20
> Missing =E2=80=9C# include=E2=80=9C indentation.

OK

>=20
>> +#ifdef __LP64__
>=20
> Likewise (more indentation needed below, include double-space
> indentation).

OK

>=20
>> +/* Allocations of struct rseq and struct rseq_cs on the heap need to
>> +   be aligned on 32 bytes.  Therefore, use of malloc is discouraged
>> +   because it does not guarantee alignment.  posix_memalign should be
>> +   used instead.  */
>> +
>> +extern __thread struct rseq __rseq_abi
>> +__attribute__ ((tls_model ("initial-exec")));
>=20
> Please indent the __attribute__ with two spaces.

OK

>=20
> Actual code looks good now.  Thanks.  I don't think there are any
> remaining issues except maybe more documentation.

I raised a few questions in my reply to yours, so I'll wait for your
input on those topics before the next iteration.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
