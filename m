Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF361E243C
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgEZOjA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 10:39:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59066 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEZOi5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 10:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590503936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6m8Lhpcoj80QhrA0ctchODA1rmDmRzPJvm9p+zbvBas=;
        b=ZavXb7ljmh6Rv38nQsSDkEA4GqKK24/Y4OJglkJLVNGRTCkWpjPhUpk3cz8Lo2fF+H390b
        xmFozgWi/5nMFxGcUt5khQHF8JdGdK1N3MT7Cn2yUnmSwsXfo1S4rScimgyK2mzQLpbXQ1
        eT2MiqAGLtzNci3F6b8WjSalI8y02jA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-KcFqvKDmMqOGUKMO9JSqPg-1; Tue, 26 May 2020 10:38:52 -0400
X-MC-Unique: KcFqvKDmMqOGUKMO9JSqPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA5131005510;
        Tue, 26 May 2020 14:38:49 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-180.ams2.redhat.com [10.36.112.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F20A84648;
        Tue, 26 May 2020 14:38:46 +0000 (UTC)
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
        <87lflerhqt.fsf@oldenburg2.str.redhat.com>
        <1701081361.34159.1590503556923.JavaMail.zimbra@efficios.com>
Date:   Tue, 26 May 2020 16:38:45 +0200
In-Reply-To: <1701081361.34159.1590503556923.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 26 May 2020 10:32:36 -0400
        (EDT)")
Message-ID: <87ftbmpxqi.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> AFAIU, the only gain here would be to make sure we don't emit useless
> ";" in the "/* nothing */" case. But does it matter ?

I don't think C allows empty constructs like this at the top level.

>>>> And something similar for _Alignas/attribute aligned,
>>>
>>> I don't see where _Alignas is needed here ?
>>>
>>> For attribute aligned, what would be the oldest supported C and C++
>>> standards ?
>>=20
>> There are no standardized attributes for C, there is only _Alignas.
>> C++11 has an alignas specifier; it's not an attribute either.  I think
>> these are syntactically similar.
>
> There appears to be an interesting difference between attribute aligned
> and alignas. It seems like alignas cannot be used on a structure declarat=
ion,
> only on fields, e.g.:
>
> struct blah {
>         int a;
> } _Alignas (16);
>
> o.c:3:1: warning: useless =E2=80=98_Alignas=E2=80=99 in empty declaration
>  } _Alignas (16);
>
> But
>
> struct blah {
>         int _Alignas (16) a;
> };

Like the attribute, it needs to come right after the struct keyword, I
think.  (Trailing attributes can be ambiguous, but not in this case.)

> is OK. So if I change e.g. struct rseq_cs to align
> the first field:
>
> struct rseq_cs
>   {
>     /* Version of this structure.  */
>     uint32_t rseq_align (32) version;
>     /* enum rseq_cs_flags.  */
>     uint32_t flags;
>     uint64_t start_ip;
>     /* Offset from start_ip.  */
>     uint64_t post_commit_offset;
>     uint64_t abort_ip;
>   };
>
> It should work.

Indeed.

> /* Rely on GNU extensions for older standards and tls model.  */
> #ifdef __GNUC__
> # ifndef rseq_alignof
> #  define rseq_alignof(x) __alignof__ (x)
> # endif
> # ifndef rseq_alignas
> #  define rseq_alignas(x) __attribute__ ((aligned (x)))
> # endif
> # define rseq_tls_model_ie __attribute__ ((__tls_model__ ("initial-exec")=
))
> #else
> /* Specifying the TLS model on the declaration is optional.  */
> # define rseq_tls_model_ie /* Nothing.  */
> #endif
>
> /* Fall back to __thread for TLS storage class.  */
> #ifndef rseq_tls_storage_class
> # define rseq_tls_storage_class __thread
> #endif

If they are only used in the glibc headers, they should have __rseq
prefixes, so that application code doesn't start using them (in case we
have to change/fix them, or move the into <sys/cdefs.h> later).

Rest looks fine.

Thanks,
Florian

