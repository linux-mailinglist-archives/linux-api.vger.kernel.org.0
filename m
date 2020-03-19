Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF4E18BF5B
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 19:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCSS2x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 14:28:53 -0400
Received: from mail.efficios.com ([167.114.26.124]:47602 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSS2x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 14:28:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D943527A988;
        Thu, 19 Mar 2020 14:28:51 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zK-eYda64nWU; Thu, 19 Mar 2020 14:28:51 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6013C27AA00;
        Thu, 19 Mar 2020 14:28:51 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6013C27AA00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584642531;
        bh=cwjFHwy6Pt+K09h3Ht6pRaRBe2P+DnAvJM52kHJYHuE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=BhlJPQ/pBiXeTRCJrJVkk/ZGNc9e0A1elzgM7ZlQmTaKC8jvLdvV2MIEImS/zwYCs
         8twJnGagGaQ/8VEO0IzlmrPvSwwOHiAwvIhGcR1VGXl338NFKAkNRJ0J+dlOHGcL2b
         l3NlLdK7Ma75QqScPkgf1lSZQP3xt/ajyrlLJO7YRHwOYUHnAbVLYwoByjH+ycy2M0
         pDjQcHOVBWBTlEVF1CORzjbBAPKGq1G0vYaYFkonSGP2ijzd/H5bnIomgrDakUVdQx
         Qs/CnUvynNw+3vpaHN7ai3ZeVlvouS6JzyiM/RgZhES0Osy4q2RjOuRi2Xlbszbeah
         zNFw75zu0B/Hw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fKFzVRXvLoGh; Thu, 19 Mar 2020 14:28:51 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4EC0027A57F;
        Thu, 19 Mar 2020 14:28:51 -0400 (EDT)
Date:   Thu, 19 Mar 2020 14:28:51 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
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
        Joseph Myers <joseph@codesourcery.com>
Message-ID: <1103782439.4046.1584642531222.JavaMail.zimbra@efficios.com>
In-Reply-To: <87sgi4gqhf.fsf@mid.deneb.enyo.de>
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com> <20200319144110.3733-5-mathieu.desnoyers@efficios.com> <874kukpf9f.fsf@mid.deneb.enyo.de> <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com> <87r1xo5o2s.fsf@mid.deneb.enyo.de> <1302331358.3965.1584641354569.JavaMail.zimbra@efficios.com> <87sgi4gqhf.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v15)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v15)
Thread-Index: /2TWQZCOgCKTJ1+DDkj4nFJ4gTkEvg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 19, 2020, at 2:16 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
>=20
>>> You also need to add an assert that the compiler supports
>>> __attribute__ ((aligned)) because ignoring it produces an
>>> ABI-incompatible header.
>>
>> Are you aware of some helper macro I should use to do this, or
>> is it done elsewhere in glibc ?
>=20
> I don't think we have any such GCC-only types yet.  max_align_t is
> provided by GCC itself.

I was thinking of adding the following to

sysdeps/unix/sysv/linux/rseq-internal.h: rseq_register_current_thread()

+  /* Ensure the compiler supports __attribute__ ((aligned)).  */
+  _Static_assert (__alignof__ (struct rseq_cs) >=3D 4 * sizeof(uint64_t),
+                 "alignment");
+  _Static_assert (__alignof__ (struct rseq) >=3D 4 * sizeof(uint64_t),
+                 "alignment");
+

>>> The struct rseq/struct rseq_cs definitions
>>> are broken, they should not try to change the alignment.
>>
>> AFAIU, this means we should ideally not have used __attribute__((aligned=
))
>> in the uapi headers in the first place. Why is it broken ?
>=20
> Compilers which are not sufficiently GCC-compatible define
> __attribute__(X) as the empty expansion, so you silently get a
> different ABI.

It is worth noting that rseq.h is not the only Linux uapi header
which uses __attribute__ ((aligned)), so this ABI problem exists today
anyway for those compilers.

>=20
> There is really no need to specify 32-byte alignment here.  Is not
> even the size of a standard cache line.  It can result in crashes if
> these structs are heap-allocated using malloc, when optimizing for
> AVX2.

Why would it be valid to allocate those with malloc ? Isn't it the
purpose of posix_memalign() ?

>=20
> For example, clang turns
>=20
> void
> clear (struct rseq *p)
> {
>  memset (p, 0, sizeof (*p));
> }
>=20
> into:
>=20
>=09vxorps=09%xmm0, %xmm0, %xmm0
>=09vmovaps=09%ymm0, (%rdi)
>=09vzeroupper
>=09retq
>=20
> My understanding is that vmovaps will trap if the pointer is
> misaligned (=E2=80=9CWhen the source or destination operand is a memory
> operand, the operand must be aligned on a 32-byte boundary or a
> general-protection exception (#GP) will be generated.=E2=80=9D).
>=20
>> However, now that it is in the wild, it's a bit late to change that.
>=20
> I had forgotten about the alignment crashes.  I think we should
> seriously consider changing the types. 8-(

I don't think this is an option at this stage given that it is part
of the Linux kernel UAPI. I am not convinced that it is valid at all
to allocate struct rseq or struct rseq_cs with malloc(), because it
does not guarantee any alignment.

Thanks,

Mathieu

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
