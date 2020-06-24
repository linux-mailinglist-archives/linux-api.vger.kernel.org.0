Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224C207591
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 16:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391196AbgFXOVD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 10:21:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52669 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388864AbgFXOVC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 10:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593008460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=92CRg7/XrXcME80ros9TCvbAqAcJmchKORDBQXOuZmQ=;
        b=HLcgCOIELn+IGZVE9LPD4O2+GylIo9NaIQLPMGf9YZDPIVKNpBVSPFJbPnpMSUlaWXHEu1
        WPb3KZmwhh8GMUJ7NlHEAohx33YeTHF2HZxcM0C+DSHAsCjJoZ5ELwiCGWZcTzjLSVgPPm
        CFiGolpXW0jKDLWkINV0433orrNHLc8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Bb8cjwniOn2RRxk4fH1gAg-1; Wed, 24 Jun 2020 10:20:58 -0400
X-MC-Unique: Bb8cjwniOn2RRxk4fH1gAg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36C558064AE;
        Wed, 24 Jun 2020 14:20:55 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-18.ams2.redhat.com [10.36.113.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F73019D7D;
        Wed, 24 Jun 2020 14:20:49 +0000 (UTC)
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
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and thread creation (v21)
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com>
        <20200622180803.1449-2-mathieu.desnoyers@efficios.com>
Date:   Wed, 24 Jun 2020 16:20:47 +0200
In-Reply-To: <20200622180803.1449-2-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 22 Jun 2020 14:08:01 -0400")
Message-ID: <87d05obl4w.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> diff --git a/manual/threads.texi b/manual/threads.texi
> index bb7a42c655..d5069d5581 100644
> --- a/manual/threads.texi
> +++ b/manual/threads.texi

> +@deftypevar {struct rseq} __rseq_abi
> +@standards{Linux, sys/rseq.h}
> +@Theglibc{} implements a @code{__rseq_abi} TLS symbol to interact with
> +the Restartable Sequences system call.  The layout of this structure is
> +defined by the @file{sys/rseq.h} header.  Registration of each thread's
> +@code{__rseq_abi} is performed by @theglibc{} at library initialization
> +and thread creation. The manual for the rseq system call can be found
> +at @uref{https://git.kernel.org/pub/scm/libs/librseq/librseq.git/tree/do=
c/man/rseq.2}.

Should be =E2=80=9Ccreation.  The=E2=80=9D (two spaces after a sentence-end=
ing period).

> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h b/sysdeps/unix/sysv/linux=
/sys/rseq.h
> new file mode 100644
> index 0000000000..5e118c1781
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h

> +#ifdef __cplusplus
> +# if  __cplusplus >=3D 201103L
> +#  define __rseq_static_assert(expr, diagnostic) static_assert (expr, di=
agnostic)
> +#  define __rseq_alignof(type)                   alignof (type)
> +#  define __rseq_tls_storage_class               thread_local
> +# endif
> +#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >=3D 201112L
> +# define __rseq_static_assert(expr, diagnostic)  _Static_assert (expr, d=
iagnostic)
> +# define __rseq_alignof(type)                    _Alignof (type)
> +# define __rseq_tls_storage_class                _Thread_local
> +#endif
> +
> +#ifndef __rseq_static_assert
> +/* Try to use _Static_assert macro from sys/cdefs.h.  */
> +# ifdef _Static_assert
> +#  define __rseq_static_assert(expr, diagnostic) _Static_assert (expr, d=
iagnostic)
> +# else
> +#  define __rseq_static_assert(expr, diagnostic) /* Nothing.  */
> +# endif
> +#endif
> +
> +/* Rely on GNU extensions for older standards and tls model.  */
> +#ifdef __GNUC__
> +# ifndef __rseq_alignof
> +#  define __rseq_alignof(x) __alignof__ (x)
> +# endif
> +# define __rseq_tls_model_ie __attribute__ ((__tls_model__ ("initial-exe=
c")))
> +#else
> +/* Specifying the TLS model on the declaration is optional.  */
> +# define __rseq_tls_model_ie /* Nothing.  */
> +#endif

I'm still worried that __rseq_static_assert and __rseq_alignof will show
up in the UAPI with textually different definitions.  (This does not
apply to __rseq_tls_model_ie.)

Is my worry unfounded?

Thanks,
Florian

