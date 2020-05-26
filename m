Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05C1E2214
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 14:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbgEZMl1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 08:41:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51784 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388675AbgEZMl0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 08:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590496885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WsRwgk9yIsXFnSEXFT2w5jAISXwAreFSORAIbunvzRM=;
        b=box0P1woWfbLxR0QIIWWDJCdxQ5bkHvcGarHEVFAc/LXlSE0F5ek9mS9AxM+cbjngvPeT4
        buZ1GVpvHabdyStErkTf1YZn2VKpyKpuSZkSylKfKYf3LixLF7DtJCXAQzu2qpIf3ZYZzQ
        /NOpBTUxp+IFOb8atvRQsUsgdsc2dSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-J_sAvGetPgm4HTtpzu6Dxw-1; Tue, 26 May 2020 08:41:21 -0400
X-MC-Unique: J_sAvGetPgm4HTtpzu6Dxw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BAAE1800D42;
        Tue, 26 May 2020 12:41:19 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-180.ams2.redhat.com [10.36.112.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DB661CA;
        Tue, 26 May 2020 12:41:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup and thread creation (v19)
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com>
        <20200501021439.2456-2-mathieu.desnoyers@efficios.com>
        <87v9kqbzse.fsf@oldenburg2.str.redhat.com>
        <941087675.33347.1590418305398.JavaMail.zimbra@efficios.com>
        <87367ovy6k.fsf@oldenburg2.str.redhat.com>
        <108939265.33525.1590428184533.JavaMail.zimbra@efficios.com>
Date:   Tue, 26 May 2020 14:41:14 +0200
In-Reply-To: <108939265.33525.1590428184533.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 25 May 2020 13:36:24 -0400
        (EDT)")
Message-ID: <87lflerhqt.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> Something like this ?
>
> #ifdef __cplusplus
> # if  __cplusplus >= 201103L
> #  define rseq_static_assert (expr, diagnostic)         static_assert (expr, diagnostic)
> #  define rseq_alignof                                  alignof
> # endif
> #elif __STDC_VERSION__ >= 201112L
> # define rseq_static_assert (expr, diagnostic)          _Static_assert (expr, diagnostic)
> # define rseq_alignof                                   _Alignof
> #endif
>
> #ifndef rseq_static_assert
> # define rseq_static_assert (expr, diagnostic)          /* nothing */
> #endif

You can't have a space in #defines like that, no matter what GNU style
says. 8-)

> /* Ensure the compiler supports __attribute__ ((aligned)).  */
> rseq_static_assert ((rseq_alignof (struct rseq_cs) >= 32, "alignment"));
> rseq_static_assert ((rseq_alignof (struct rseq) >= 32, "alignment"));

You need to move the ; into rseq_static_assert.  And if you use explicit
arguments, you can't use double parentheses.

>> And something similar for _Alignas/attribute aligned,
>
> I don't see where _Alignas is needed here ?
>
> For attribute aligned, what would be the oldest supported C and C++
> standards ?

There are no standardized attributes for C, there is only _Alignas.
C++11 has an alignas specifier; it's not an attribute either.  I think
these are syntactically similar.

>> with an error for
>> older standards and !__GNUC__ compilers (because neither the type nor
>> __thread can be represented there).
>
> By "type" you mean "struct rseq" here ? What does it contain that requires
> a __GNUC__ compiler ?

__attribute__ and __thread support.

> About __thread, I recall other compilers have other means to declare it.
> In liburcu, I end up with the following:
>
> #if defined (__cplusplus) && (__cplusplus >= 201103L)
> # define URCU_TLS_STORAGE_CLASS thread_local
> #elif defined (__STDC_VERSION__) && (__STDC_VERSION__ >= 201112L)
> # define URCU_TLS_STORAGE_CLASS _Thread_local
> #elif defined (_MSC_VER)
> # define URCU_TLS_STORAGE_CLASS __declspec(thread)
> #else
> # define URCU_TLS_STORAGE_CLASS __thread
> #endif
>
> Would something along those lines be OK for libc ?

Yes, it would be okay (minus the Visual C++ part).  This part does not
have to go into UAPI headers first.  A fallback definition of __thread
should be okay.  Outside glibc, the TLS model declaration is optional, I
think.  The glibc *definition* ensures that the variable is
initial-exec.

Thanks,
Florian

