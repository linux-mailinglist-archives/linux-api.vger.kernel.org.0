Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5631BF825
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 14:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgD3MVP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 08:21:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44113 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726550AbgD3MVP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 08:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588249274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9Oy7Lkbf5iDQCQG90qiSeeLh3uqoFDlnoF97dVTF3o=;
        b=gaKsX0FZajwMn4nSnqJrxUz8QnGkQnyd6qdau/Cpdj4NklYk+vw43xvi+iYZsb4Xlfugms
        8gLOy3vkjgwDR53QX0oDSK5UVI+G68C7eRiX+PZy2qhOeeWBqZme3xKspOhDunrXAhly8F
        RVKfzCqoQylPbYlK2Q3J1nfevwkVCrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-T0oUkGWxMNW9P4uX0NQIKw-1; Thu, 30 Apr 2020 08:21:05 -0400
X-MC-Unique: T0oUkGWxMNW9P4uX0NQIKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500AC83DE6B;
        Thu, 30 Apr 2020 12:21:03 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-72.ams2.redhat.com [10.36.113.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 485DE1010403;
        Thu, 30 Apr 2020 12:20:56 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Carlos O'Donell <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH glibc 1/3] glibc: Perform rseq(2) registration at C startup and thread creation (v18)
References: <20200428171513.22926-1-mathieu.desnoyers@efficios.com>
Date:   Thu, 30 Apr 2020 14:20:54 +0200
In-Reply-To: <20200428171513.22926-1-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Tue, 28 Apr 2020 13:15:11 -0400")
Message-ID: <875zdhmaft.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> diff --git a/NEWS b/NEWS
> index 0e627b3405..0b85a02c12 100644
> --- a/NEWS
> +++ b/NEWS
> @@ -18,6 +18,16 @@ Major new features:
>  * The GNU C Library now loads audit modules listed in the DT_AUDIT and
>    DT_DEPAUDIT dynamic section entries of the main executable.
>=20=20
> +* Support for automatically registering threads with the Linux rseq(2)
> +  system call has been added.  This system call is implemented starting
> +  from Linux 4.18.  The Restartable Sequences ABI accelerates user-space
> +  operations on per-cpu data.  It allows user-space to perform updates
> +  on per-cpu data without requiring heavy-weight atomic operations.
> +  Automatically registering threads allows all libraries, including libc,
> +  to make immediate use of the rseq(2) support by using the documented A=
BI.
> +  The GNU C Library manual has details on integration of Restartable
> +  Sequences.

GNU style doesn't use (2) here, I think.

> diff --git a/manual/threads.texi b/manual/threads.texi
> index 0858ef8f92..4754cdaeb5 100644
> --- a/manual/threads.texi
> +++ b/manual/threads.texi

> @@ -881,3 +883,27 @@ Behaves like @code{pthread_timedjoin_np} except that=
 the absolute time in
>  @c pthread_spin_unlock
>  @c pthread_testcancel
>  @c pthread_yield
> +
> +@node Restartable Sequences
> +@section Restartable Sequences
> +@cindex rseq

Suggest: @cindex Restartable Sequences

> +
> +This section describes @theglibc{} Restartable Sequences integration.

Suggest: This section describes Restartable Sequences integration for
@theglibc{}.  (Avoids an excessively long noun phrase.)

Maybe mention which uses of the rseq syscall are permitted behind the
back of glibc?  And that code should not leave dangling rseq cs pointers
behind (the dlopen interaction)?

> +@deftypevar {struct rseq} __rseq_abi
> +@standards{Linux, sys/rseq.h}
> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with t=
he
> +Restartable Sequences system call (Linux-specific).  The layout of this
> +structure is defined by the Linux kernel @file{linux/rseq.h} UAPI.

The linux/rseq.h reference seems redundant, given that sys/rseq.h covers
it as well.

> +Registration of each thread's @code{__rseq_abi} is performed by
> +@theglibc{} at libc initialization and pthread creation.

Suggest: library initialization and thread creation

> +@end deftypevar
> +
> +@deftypevr Macro int RSEQ_SIG
> +@standards{Linux, sys/rseq.h}
> +Each supported architecture provide a @code{RSEQ_SIG} macro in

Typo: provides

> +@file{sys/rseq.h} which contains a signature.  That signature is expecte=
d to be
> +present in the code before each Restartable Sequences abort handler.  Fa=
ilure
> +to provide the expected signature may terminate the process with a Segme=
ntation
> +fault.

Suggest: segmentation fault (no capitalization)

> diff --git a/misc/rseq-internal.h b/misc/rseq-internal.h
> new file mode 100644
> index 0000000000..16f197397f
> --- /dev/null
> +++ b/misc/rseq-internal.h

Maybe this should go in to sysdeps/generic instead of misc?
(See the recent discussion about elf_machine_sym_no_match.)

> diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/=
linux/rseq-internal.h
> new file mode 100644
> index 0000000000..3ecd4d0611
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/rseq-internal.h
> @@ -0,0 +1,47 @@
> +/* Restartable Sequences internal API.  Linux implementation.
> +   Copyright (C) 2020 Free Software Foundation, Inc.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library; if not, see
> +   <https://www.gnu.org/licenses/>.  */
> +
> +#ifndef RSEQ_INTERNAL_H
> +#define RSEQ_INTERNAL_H
> +
> +#include <sysdep.h>
> +#include <errno.h>
> +#include <kernel-features.h>
> +#include <sys/rseq.h>
> +
> +#ifdef RSEQ_SIG
> +static inline void
> +rseq_register_current_thread (void)
> +{
> +  int ret;
> +
> +  if (__rseq_abi.cpu_id =3D=3D RSEQ_CPU_ID_REGISTRATION_FAILED)
> +    return;
> +  ret =3D INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
> +                              0, RSEQ_SIG);
> +  if (INTERNAL_SYSCALL_ERROR_P (ret) &&
> +      INTERNAL_SYSCALL_ERRNO (ret) !=3D EBUSY)
> +    __rseq_abi.cpu_id =3D RSEQ_CPU_ID_REGISTRATION_FAILED;

Sorry, I forgot: Please add a comment that the EBUSY error is ignored
because registration may have already happened in a legacy library.

> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux=
/sys/rseq.h
> new file mode 100644
> index 0000000000..de6600ff45
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h

> +#ifdef __GLIBC_HAVE_KERNEL_RSEQ
> +/* We use the structures declarations from the kernel headers.  */
> +# include <linux/rseq.h>
> +#else
> +/* We use a copy of the include/uapi/linux/rseq.h kernel header.  */
> +
> +#include <asm/byteorder.h>

Missing =E2=80=9C# include=E2=80=9C indentation.

> +#ifdef __LP64__

Likewise (more indentation needed below, include double-space
indentation).

> +/* Allocations of struct rseq and struct rseq_cs on the heap need to
> +   be aligned on 32 bytes.  Therefore, use of malloc is discouraged
> +   because it does not guarantee alignment.  posix_memalign should be
> +   used instead.  */
> +
> +extern __thread struct rseq __rseq_abi
> +__attribute__ ((tls_model ("initial-exec")));

Please indent the __attribute__ with two spaces.

Actual code looks good now.  Thanks.  I don't think there are any
remaining issues except maybe more documentation.

Florian

