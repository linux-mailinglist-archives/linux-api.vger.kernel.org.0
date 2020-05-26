Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9111D1E255B
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2020 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgEZPWI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 May 2020 11:22:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:33662 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728279AbgEZPWH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 May 2020 11:22:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2A2B32539DC;
        Tue, 26 May 2020 11:22:06 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id r5CHuBHdRu9w; Tue, 26 May 2020 11:22:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CCA652539D9;
        Tue, 26 May 2020 11:22:05 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CCA652539D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1590506525;
        bh=SKrOEP5pGa9ajAYrExv6tmSsQLUAXbFOGSG0aVKLqZc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=XQ2rqTUy7+LdrVi4/K9Hb9w+gbNDirUXP49Brj19U88DvQyA2NAkRNWhE6gsD0jC1
         55SbMVeAdoNddOJoNkwLXXVAjuuxTBWSWChELy3/UPfSTQgdgPGc7eLHnoBohHKOwI
         29E1D5OSTAzvLU5uxBdvsJ181bA1PC1BIWlWm77n6AtQXyy0h8JV35UiP7j2BkDBJP
         AhR9rhb0ZvOrx6DO/R0HyTroMWXsshno/D9r/LFKm9VtxEgVwiuwghVXtWATyE2xWJ
         XxXY5NcfV8FIcQ6Fwn6yNv/88tJkRv7svValKDX5kTc+Vnu6H82I2VxFTStwBuOGw6
         P7G0tdyPBKkvQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 15NWPF5usT5q; Tue, 26 May 2020 11:22:05 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BC77C253D8A;
        Tue, 26 May 2020 11:22:05 -0400 (EDT)
Date:   Tue, 26 May 2020 11:22:05 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
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
Message-ID: <1940294182.34562.1590506525684.JavaMail.zimbra@efficios.com>
In-Reply-To: <877dwypwuj.fsf@oldenburg2.str.redhat.com>
References: <20200501021439.2456-1-mathieu.desnoyers@efficios.com> <87367ovy6k.fsf@oldenburg2.str.redhat.com> <108939265.33525.1590428184533.JavaMail.zimbra@efficios.com> <87lflerhqt.fsf@oldenburg2.str.redhat.com> <1701081361.34159.1590503556923.JavaMail.zimbra@efficios.com> <87ftbmpxqi.fsf@oldenburg2.str.redhat.com> <1931644690.34207.1590504804638.JavaMail.zimbra@efficios.com> <877dwypwuj.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH glibc 1/3] glibc: Perform rseq registration at C startup
 and thread creation (v19)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: glibc: Perform rseq registration at C startup and thread creation (v19)
Thread-Index: fw53pKjM0pFKmGwjq/cBVSRtxzONcQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 26, 2020, at 10:57 AM, Florian Weimer fweimer@redhat.com wrote=
:

> * Mathieu Desnoyers:
>=20
>>> Like the attribute, it needs to come right after the struct keyword, I
>>> think.  (Trailing attributes can be ambiguous, but not in this case.)
>>
>> Nope. _Alignas really _is_ special :-(
>>
>> struct _Alignas (16) blah {
>>         int a;
>> };
>>
>> p.c:1:8: error: expected =E2=80=98{=E2=80=99 before =E2=80=98_Alignas=E2=
=80=99
>>  struct _Alignas (16) blah {
>=20
> Meh, yet another unnecessary C++ incompatibility.  C does not support
> empty structs, so I assume they didn't see the field requirement as a
> burden.

Indeed, it's weird.

>=20
>> One last thing I'm planning to add in sys/rseq.h to cover acessing the
>> rseq_cs pointers with both the UAPI headers and the glibc struct rseq
>> declarations:
>>
>> /* The rseq_cs_ptr macro can be used to access the pointer to the curren=
t
>>    rseq critical section descriptor.  */
>> #ifdef __LP64__
>> # define rseq_cs_ptr(rseq) \
>>            ((const struct rseq_cs *) (rseq)->rseq_cs.ptr)
>> #else /* __LP64__ */
>> # define rseq_cs_ptr(rseq) \
>>            ((const struct rseq_cs *) (rseq)->rseq_cs.ptr.ptr32)
>> #endif /* __LP64__ */
>>
>> Does it make sense ?
>=20
> Written this way, it's an aliasing violation.  I don't think it's very
> useful.

OK, I'll just remove it.

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
