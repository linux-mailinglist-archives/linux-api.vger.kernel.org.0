Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2741E1ECFD0
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2020 14:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCMcJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Jun 2020 08:32:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54576 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725981AbgFCMcJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Jun 2020 08:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591187527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaIXrhQbCH4bOWY70sdfxk9KltjJZfTXRyPX6JUjwhI=;
        b=WSh39n0Yr5/72bOMt6qJKvWnxztkGhpdbEzK2pJUk+egDA338BJ70Jf3VWUJQG9KON+NL5
        2ZA8z7kH0pjUvXz8gdbXgdqTT3CheToiGjMVEdpcq7UkujRhJ87ObFNcu5yFid/JHU6i70
        vi+msp7zzjyNVVNGwiS5yG+OQKUY+6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-ZyHJupl8MjmPPQZToStXDA-1; Wed, 03 Jun 2020 08:32:05 -0400
X-MC-Unique: ZyHJupl8MjmPPQZToStXDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757FE9116D;
        Wed,  3 Jun 2020 12:32:03 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-181.ams2.redhat.com [10.36.112.181])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E33278EFF;
        Wed,  3 Jun 2020 12:31:56 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup and thread creation (v20)
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com>
        <20200527185130.5604-2-mathieu.desnoyers@efficios.com>
        <87d06gxsla.fsf@oldenburg2.str.redhat.com>
        <1953500643.51064.1591186963416.JavaMail.zimbra@efficios.com>
Date:   Wed, 03 Jun 2020 14:31:54 +0200
In-Reply-To: <1953500643.51064.1591186963416.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 3 Jun 2020 08:22:43 -0400
        (EDT)")
Message-ID: <87r1uwwcsl.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Jun 3, 2020, at 8:05 AM, Florian Weimer fweimer@redhat.com wrote:
>
>> * Mathieu Desnoyers:
>>=20
>>> +#ifdef __cplusplus
>>> +# if  __cplusplus >=3D 201103L
>>> +#  define __rseq_static_assert(expr, diagnostic) static_assert (expr,
>>> diagnostic)
>>> +#  define __rseq_alignof(type)                   alignof (type)
>>> +#  define __rseq_alignas(x)                      alignas (x)
>>> +#  define __rseq_tls_storage_class               thread_local
>>> +# endif
>>> +#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >=3D 201112L
>>> +# define __rseq_static_assert(expr, diagnostic)  _Static_assert (expr,
>>> diagnostic)
>>> +# define __rseq_alignof(type)                    _Alignof (type)
>>> +# define __rseq_alignas(x)                       _Alignas (x)
>>> +# define __rseq_tls_storage_class                _Thread_local
>>> +#endif
>>=20
>> This does not seem to work.  I get this with GCC 9:
>>=20
>> In file included from /tmp/cih_test_gsrKbC.cc:8:0:
>> ../sysdeps/unix/sysv/linux/sys/rseq.h:42:50: error: attribute ignored
>> [-Werror=3Dattributes]
>> #  define __rseq_alignas(x)                      alignas (x)
>>                                                  ^
>> ../sysdeps/unix/sysv/linux/sys/rseq.h:122:14: note: in expansion of macro
>> =E2=80=98__rseq_alignas=E2=80=99
>>     uint32_t __rseq_alignas (32) version;
>>              ^
>
> Is that when compiling C or C++ code ? If it's C code, I would expect
> "_Alignas" to be used, not "alignas".
>
> Which exact version of gcc do you use ?

C++ code.  CXX was set to this compiler at configure time:

gcc version 9.3.1 20200408 (Red Hat 9.3.1-2) (GCC)=20

>> In any case, these changes really have to go into the UAPI header first.
>> Only the __thread handling should remain.  Otherwise, we'll have a tough
>> situation on our hands changing the UAPI header, without introducing
>> macro definition conflicts.  I'd suggest to stick to the aligned
>> attribute for the time being, like the current UAPI headers.
>
> OK. Should I do that in a separate patch, or you do it on top of my patch=
set,
> or should I re-spin another round of the series ?

I think the initial commit should mirror the current UAPI header
contents.

Keep the macros for the UAPI patch though. 8-)  We can pick up these
changes once they have been merged into Linux.

Thanks,
Florian

