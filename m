Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01061ECFAF
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2020 14:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgFCMWp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Jun 2020 08:22:45 -0400
Received: from mail.efficios.com ([167.114.26.124]:46328 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCMWp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Jun 2020 08:22:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 05EB22BB52D;
        Wed,  3 Jun 2020 08:22:44 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SoAZOJHovtgo; Wed,  3 Jun 2020 08:22:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 936A32BB70D;
        Wed,  3 Jun 2020 08:22:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 936A32BB70D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1591186963;
        bh=rdHO25JTPUux1QRiP8eQL4NjJR+TM6Hs9XXZEI9NbcE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=E9yPN5mFCA4QWBJXMZFlTG+7K10V/RE5uJoGtqBvL9RBymhrVXBtfgQqd1qDJ/H6I
         k2LwVpoWPerkSSIhCoIEDNe0U2mOqjrWDFePSzHnPaHpqO4P+XSjgp2kRzSQPULaZ0
         FtHgXBIoOkmtbWFS8Ez9FFcIyR6TTY4MNH8DuX1yP5UhDoYhU8MRP8t7S8n7pntRyj
         xbiZ0OjQi/phSCreDYLVwMfplVVxkjEpwE2iinrRfavny2LLamrRQgnTOOV5Rcd2Ja
         h4SDX00QgkHVPpQr3QnLAaWuUfq00QaCgKHBjxVv3Cot+JXLbAp2KbbT7HejobInsc
         yy86diWOT7KSw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mdVrHRNhgPJV; Wed,  3 Jun 2020 08:22:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 80AFF2BB70C;
        Wed,  3 Jun 2020 08:22:43 -0400 (EDT)
Date:   Wed, 3 Jun 2020 08:22:43 -0400 (EDT)
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
Message-ID: <1953500643.51064.1591186963416.JavaMail.zimbra@efficios.com>
In-Reply-To: <87d06gxsla.fsf@oldenburg2.str.redhat.com>
References: <20200527185130.5604-1-mathieu.desnoyers@efficios.com> <20200527185130.5604-2-mathieu.desnoyers@efficios.com> <87d06gxsla.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v20)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v20)
Thread-Index: JjnqmhZtAhK7Ohdp5xp6UQAQci2wtA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 3, 2020, at 8:05 AM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
>=20
>> +#ifdef __cplusplus
>> +# if  __cplusplus >=3D 201103L
>> +#  define __rseq_static_assert(expr, diagnostic) static_assert (expr,
>> diagnostic)
>> +#  define __rseq_alignof(type)                   alignof (type)
>> +#  define __rseq_alignas(x)                      alignas (x)
>> +#  define __rseq_tls_storage_class               thread_local
>> +# endif
>> +#elif (defined __STDC_VERSION__ ? __STDC_VERSION__ : 0) >=3D 201112L
>> +# define __rseq_static_assert(expr, diagnostic)  _Static_assert (expr,
>> diagnostic)
>> +# define __rseq_alignof(type)                    _Alignof (type)
>> +# define __rseq_alignas(x)                       _Alignas (x)
>> +# define __rseq_tls_storage_class                _Thread_local
>> +#endif
>=20
> This does not seem to work.  I get this with GCC 9:
>=20
> In file included from /tmp/cih_test_gsrKbC.cc:8:0:
> ../sysdeps/unix/sysv/linux/sys/rseq.h:42:50: error: attribute ignored
> [-Werror=3Dattributes]
> #  define __rseq_alignas(x)                      alignas (x)
>                                                  ^
> ../sysdeps/unix/sysv/linux/sys/rseq.h:122:14: note: in expansion of macro
> =E2=80=98__rseq_alignas=E2=80=99
>     uint32_t __rseq_alignas (32) version;
>              ^

Is that when compiling C or C++ code ? If it's C code, I would expect
"_Alignas" to be used, not "alignas".

Which exact version of gcc do you use ?

>=20
> In any case, these changes really have to go into the UAPI header first.
> Only the __thread handling should remain.  Otherwise, we'll have a tough
> situation on our hands changing the UAPI header, without introducing
> macro definition conflicts.  I'd suggest to stick to the aligned
> attribute for the time being, like the current UAPI headers.

OK. Should I do that in a separate patch, or you do it on top of my patchse=
t,
or should I re-spin another round of the series ?
>=20
> The resut looks okay to me.
>=20
> I'm still waiting for feedback from other maintainers whether the level
> of documentation and testing is appropriate.

OK.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
