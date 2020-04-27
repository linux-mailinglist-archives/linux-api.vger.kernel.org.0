Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2441BAB24
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 19:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgD0R0T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 13:26:19 -0400
Received: from mail.efficios.com ([167.114.26.124]:37564 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgD0R0T (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 13:26:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 15F5E25AB7F;
        Mon, 27 Apr 2020 13:26:18 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vyE-AKT5Yyo9; Mon, 27 Apr 2020 13:26:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8011B25B48F;
        Mon, 27 Apr 2020 13:26:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8011B25B48F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588008377;
        bh=4CDxUYdzmcopBG0/OPLT4vxX3lvaRe8HqEPYDfAllDQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fGHnEnyfSSb1yhiMxCDx0oZgEYV7FBFlcvAxf3Y+/oM4mN0ueOWrwr9eyVq5a+rT0
         +jRqi2+IuSsNW7PiQUOCthc1gu6lsMhpt4S9wN8XY47UTud9Uj4kWlRRiv1/kKd83d
         WfVU9pUuiZ8wziBtMZuif2X4tYwfD1JKYFcJrdji1/vADYlf4QrQtWUBSVzI/TEgYE
         aYs8yCCsxnT/LbXA67n+s6q0fG1k1m8Kdfm5lwZaVKMdShD/Vlvj5/B+uiSQk97nyD
         Rqih1UJZ6d+b4YkqlmOwfWPIcItLjJKHmNtwB8S3FE3DwcZkTKgL1NeAi/aPedKwY2
         RfOXugXFWnwug==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zj3X43GAeTna; Mon, 27 Apr 2020 13:26:17 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 6031B25B336;
        Mon, 27 Apr 2020 13:26:17 -0400 (EDT)
Date:   Mon, 27 Apr 2020 13:26:17 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
In-Reply-To: <87zhawvphv.fsf@mid.deneb.enyo.de>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <20200326155633.18236-6-mathieu.desnoyers@efficios.com> <87ees9z417.fsf@mid.deneb.enyo.de> <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com> <87zhawvphv.fsf@mid.deneb.enyo.de>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: NB5tGkGbwSwj6uwD4kCQxwPloIWw0w==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



----- On Apr 27, 2020, at 12:54 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
>=20
>>>> +#include <sys/syscall.h>
>>>> +#include <stdint.h>
>>>> +#include <kernel-features.h>
>>>> +#include <sys/rseq.h>
>>>> +
>>>> +__thread struct rseq __rseq_abi =3D {
>>>> +  .cpu_id =3D RSEQ_CPU_ID_UNINITIALIZED,
>>>> +};
>>>=20
>>> { should go onto its own line.
>>
>> OK
>>
>>> I'd also add attribute_tls_model_ie,
>>> also it's implied by the declaration in the header.
>>
>> This contradicts feedback I received from Szabolcs Nagy in September 201=
9:
>>
>> https://public-inbox.org/libc-alpha/c58d4d6e-f22a-f5d9-e23a-5bd72cec1a86=
@arm.com/
>>
>> "note that libpthread.so is built with -ftls-model=3Dinitial-exec
>>
>> (and if it wasn't then you'd want to put the attribute on the
>> declaration in the internal header file, not on the definition,
>> so the actual tls accesses generate the right code)"
>>
>> In the context of his feedback, __rseq_abi was defined within
>> nptl/pthread_create.c.
>> It is now defined in sysdeps/unix/sysv/linux/rseq-sym.c, which is built =
into the
>> csu which AFAIU ends up in libc.so. His comment still applies though, be=
cause
>> libc.so is also built with -ftls-model=3Dinitial-exec.
>>
>> So should I apply the "initial-exec" TLS model only to the __rseq_abi
>> declaration, or is it preferred to apply it to both the declaration
>> and the definition ?
>=20
> I do not have a strong preference here.  Technically, the declaration
> in the header file should be enough.

OK, so I'll just keep the attribute on the declaration in the header.

>=20
>>>> diff --git a/sysdeps/unix/sysv/linux/sys/rseq.h
>>>> b/sysdeps/unix/sysv/linux/sys/rseq.h
>>>> new file mode 100644
>>>> index 0000000000..503dce4cac
>>>> --- /dev/null
>>>> +++ b/sysdeps/unix/sysv/linux/sys/rseq.h
>>>> @@ -0,0 +1,186 @@
>>>=20
>>> I think there is some value in making this header compatible with
>>> inclusion from the assembler (including constants for the relevant
>>> struct offsets), but that can be a later change.
>>
>> Agreed. By "later", do you mean before merging the patch, between
>> merge of the patch and next glibc release, or for a subsequent glibc
>> release ?
>=20
> It can happen some time after merging the patch, preferably for this
> release.  But I don't think it's release-critical.

OK

>=20
>>>> +/* struct rseq is aligned on 4 * 8 bytes to ensure it is always
>>>> +   contained within a single cache-line.
>>>> +
>>>> +   A single struct rseq per thread is allowed.  */
>>>> +struct rseq
>>>> +  {
>>>> +    /* Restartable sequences cpu_id_start field. Updated by the
>>>> +       kernel. Read by user-space with single-copy atomicity
>>>> +       semantics. This field should only be read by the thread which
>>>> +       registered this data structure. Aligned on 32-bit. Always
>>>=20
>>> What does =E2=80=9CAligned on 32-bit=E2=80=9D mean in this context?  Do=
 you mean to
>>> reference 32-*byte* alignment here?
>>
>> No. I really mean 32-bit (4-byte). Being aligned on 32-byte guarantees t=
hat
>> this field is aligned at least on 4-byte. This is required by single-cop=
y
>> atomicity semantics.
>>
>> Should I update this comment to state "Aligned on 4-byte" instead ?
>=20
> I think this is implied by all Linux ABIs.  And the explicit alignment
> specification for struct rseq makes the alignment 32 bytes.

Unless a structure ends up being packed, which is of course not the case
here.

I would prefer to keep the comment about 32-bit alignment requirement on
the specific fields, because the motivation for alignment requirement is
much more strict for fields (correctness) than the motivation for alignment
of the structure (performance).

>=20
>>>> +    /* Restartable sequences rseq_cs field.
>>>> +
>>>> +       Contains NULL when no critical section is active for the curre=
nt
>>>> +       thread, or holds a pointer to the currently active struct rseq=
_cs.
>>>> +
>>>> +       Updated by user-space, which sets the address of the currently
>>>> +       active rseq_cs at the beginning of assembly instruction sequen=
ce
>>>> +       block, and set to NULL by the kernel when it restarts an assem=
bly
>>>> +       instruction sequence block, as well as when the kernel detects=
 that
>>>> +       it is preempting or delivering a signal outside of the range
>>>> +       targeted by the rseq_cs. Also needs to be set to NULL by user-=
space
>>>> +       before reclaiming memory that contains the targeted struct rse=
q_cs.
>>>> +
>>>> +       Read and set by the kernel. Set by user-space with single-copy
>>>> +       atomicity semantics. This field should only be updated by the
>>>> +       thread which registered this data structure. Aligned on 64-bit=
.  */
>>>> +    union {
>>>> +      uint64_t ptr64;
>>>> +#ifdef __LP64__
>>>> +      uint64_t ptr;
>>>> +#else
>>>> +      struct {
>>>> +#if (defined(__BYTE_ORDER) && (__BYTE_ORDER =3D=3D __BIG_ENDIAN)) ||
>>>> defined(__BIG_ENDIAN)
>>>> +        uint32_t padding; /* Initialized to zero.  */
>>>> +        uint32_t ptr32;
>>>> +#else /* LITTLE */
>>>> +        uint32_t ptr32;
>>>> +        uint32_t padding; /* Initialized to zero.  */
>>>> +#endif /* ENDIAN */
>>>> +      } ptr;
>>>> +#endif
>>>> +    } rseq_cs;
>>>=20
>>> Are these conditionals correct for x32?
>>
>> Let's see. With x86 gcc:
>>
>> -m64: (__x86_64__ && __LP64__)
>> -m32: (__i386__)
>> -mx32: (__x86_64__ && __ILP32__)
>>
>> So with "#ifdef __LP64__" we specifically target 64-bit pointers. The re=
st
>> falls into the "else" case, which expects 32-bit pointers. Considering t=
hat
>> x32 has 32-bit pointers, I don't see any issue here.
>=20
> Does the kernel have a separate 32-bit entry point for rseq on x32?
> If not, it will expect the 64-bit struct layout.

No, there is a single entry point into rseq covering all of 32-bit, 64-bit =
and x32.
We achieve this by ensuring the layout of the linux/rseq.h structures
uses the union representation for pointers. Therefore, the kernel does not =
care
whether it reads a pointer from a 32-bit or 64-bit process. This is becomin=
g the
preferred way to design Linux kernel ABIs nowadays.

>=20
>> We don't mind that user-space uses that pointer, but we never want the k=
ernel
>> to touch that pointer rather than the 32/64-bit-aware fields. One possib=
ility
>> would be to do:
>>
>>     union
>>       {
>>         uint64_t ptr64;
>> #ifdef __LP64__
>>         uint64_t ptr;
>> #else
>>         struct
>>           {
>> #if (defined (__BYTE_ORDER) && (__BYTE_ORDER =3D=3D __BIG_ENDIAN)) || de=
fined
>> (__BIG_ENDIAN)
>>             uint32_t padding; /* Initialized to zero.  */
>>             uint32_t ptr32;
>> #else /* LITTLE */
>>             uint32_t ptr32;
>>             uint32_t padding; /* Initialized to zero.  */
>> #endif /* ENDIAN */
>>           } ptr;
>> #endif
>>
>> #ifndef __KERNEL__
>>      const struct rseq_cs *uptr;
>> #endif
>>       } rseq_cs;
>>
>> in the union, so only user-space can see that field. Thoughts ?
>=20
> I think this depends on where the x32 question lands.

x32 should not be an issue as explained above, so I'm very open to
add this "uptr" for user-space only.

Thanks,

Mathieu


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
