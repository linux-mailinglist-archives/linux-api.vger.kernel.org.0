Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 429D818C0AA
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 20:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbgCSTqG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 15:46:06 -0400
Received: from mail.efficios.com ([167.114.26.124]:55566 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCSTqG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 15:46:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C2FB327AEB7;
        Thu, 19 Mar 2020 15:46:04 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id N2Sgnom2LQQB; Thu, 19 Mar 2020 15:46:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F13CB27ACEB;
        Thu, 19 Mar 2020 15:46:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F13CB27ACEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584647164;
        bh=mPayiUoTJ4CXFxP07c55XGHAyo6rbWCRF8IfmBCmuac=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oAHmm+nJ7bNdAcBo63xyq7h3/sR+93guwx0RGjIl37TheaCNn4bGtv6FM/ZjLXFFP
         AhsE59Sp1+SnVXfQDelS3SU1Ja2c7u/L+bmz0c7hrdFg8eqsaF97IZRhsuKhPoTMP8
         KHKfP5EO7MzF467pCek3A61se0nuLZurAwKOzB5oYc8VGEIx/SmD1q66uGer2vKZMs
         FIjgd7rMe9n+C8FvYlu/FFOe/FcxOuav4Bi+glgwPFaCASsE/dWLpYFeKxvAzAz/Vk
         tjEJcDH3p1GiFP7BIpBmiY1Iz/s7RCGTgeP6fszTzJ/3sTdKfgDtUsHSHgzmY5qat5
         nYnvj50hIQvDw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Qy-7PsmrF1sc; Thu, 19 Mar 2020 15:46:03 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id DA19527B0A9;
        Thu, 19 Mar 2020 15:46:03 -0400 (EDT)
Date:   Thu, 19 Mar 2020 15:46:03 -0400 (EDT)
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
Message-ID: <624584479.4115.1584647163775.JavaMail.zimbra@efficios.com>
In-Reply-To: <87fte4go6w.fsf@mid.deneb.enyo.de>
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com> <87r1xo5o2s.fsf@mid.deneb.enyo.de> <1302331358.3965.1584641354569.JavaMail.zimbra@efficios.com> <87sgi4gqhf.fsf@mid.deneb.enyo.de> <1103782439.4046.1584642531222.JavaMail.zimbra@efficios.com> <87k13ggpmf.fsf@mid.deneb.enyo.de> <900536577.4062.1584644126425.JavaMail.zimbra@efficios.com> <87fte4go6w.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v15)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v15)
Thread-Index: poZ7JQ5/Qt1CQs9uPvdRib/AmVGsDg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 19, 2020, at 3:05 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>>> Inside glibc, you can assume __attribute__ support.
>>
>> OK, so the _Static_assert () could sit in sys/rseq.h
> 
> It requires a C11 compiler.  In this case, you could use _Alignas.

How would _Alignas replace:

+_Static_assert (__alignof__ (struct rseq_cs) >= 4 * sizeof(uint64_t),
+                "alignment");
+_Static_assert (__alignof__ (struct rseq) >= 4 * sizeof(uint64_t),
+                "alignment");

?

Moreover, I notice that sys/cdefs.h implements a fallback for _Static_assert
for cases where it is not supported by the compiler. So I do not think it
strictly depends on C11 if I include sys/cdefs.h from sys/rseq.h.

>>>>>>> The struct rseq/struct rseq_cs definitions
>>>>>>> are broken, they should not try to change the alignment.
>>>>>>
>>>>>> AFAIU, this means we should ideally not have used __attribute__((aligned))
>>>>>> in the uapi headers in the first place. Why is it broken ?
>>>>> 
>>>>> Compilers which are not sufficiently GCC-compatible define
>>>>> __attribute__(X) as the empty expansion, so you silently get a
>>>>> different ABI.
>>>>

[...]

>>>>> There is really no need to specify 32-byte alignment here.  Is not
>>>>> even the size of a standard cache line.  It can result in crashes if
>>>>> these structs are heap-allocated using malloc, when optimizing for
>>>>> AVX2.
>>>>
>>>> Why would it be valid to allocate those with malloc ? Isn't it the
>>>> purpose of posix_memalign() ?
>>> 
>>> It would not be valid, but I don't think we have diagnostics for C
>>> like we have them for C++'s operator new.
>>
>> We could at least make an effort to let people know that alignment is
>> required here when allocating struct rseq and struct rseq_cs on the
>> heap by adding some comments to that effect in linux/rseq.h ?
> 
> We could use different types on the glibc side, then no special
> programmer action will be needed.

Can't this lead to problems when mixing up compile units which have
been compiled with linux/rseq.h with compile units compiled against
sys/rseq.h ?

Let me take a step back and try to understand.

So far, there appears to be two scenarios where having a 64-byte
alignment attribute on struct rseq and struct rseq_cs can cause
problems:

1) A user-space programmer uses malloc() to dynamically allocate
   struct rseq or struct rseq_cs, which does not satisfy any of
   the alignment requirement of the structure. Combining this with
   compiler expectations that the structure needs to be aligned
   on 64-byte (e.g. -mavx2) breaks things.

   For this first scenario, I am proposing that we document that
   the programmer should have used posix_memalign(), which provides
   the required alignment guarantees.

2) A user-space programmer mixes code compiled with compilers
   honouring the aligned attribute with other compile units compiled
   with compilers which discard those GCC extension attributes silently,
   embeds those into a structure, and get different struct layouts.

   The _Static_assert in sys/rseq.h should detect the case where a
   compiler is not honouring the aligned attribute, right ?

> 
>>>>>> However, now that it is in the wild, it's a bit late to change that.
>>>>> 
>>>>> I had forgotten about the alignment crashes.  I think we should
>>>>> seriously consider changing the types. 8-(
>>>>
>>>> I don't think this is an option at this stage given that it is part
>>>> of the Linux kernel UAPI. I am not convinced that it is valid at all
>>>> to allocate struct rseq or struct rseq_cs with malloc(), because it
>>>> does not guarantee any alignment.
>>> 
>>> The kernel ABI doesn't change.  The kernel cannot use the alignment
>>> information anyway.  Userspace struct layout may change in subtle
>>> ways, though.
>>
>> Considering the amount of pain this can cause in user-space, and because
>> it can break userspace, this is not a UAPI change I am willing to consider.
>> I'm not sure why we are even discussing the possibility of breaking a Linux
>> UAPI considering that those are set in stone.
> 
> Again, the kernel interface is NOT affected.  Only if the struct is
> used in a non-top-level fashion across an ABI boundary in userspace.
> I think making the change now is better than dealing with the breakage
> in rseq users when they are built with -mavx2.

What I am missing is what are the issues that persist once we add proper
documentation of alignment requirements for heap allocation and a static
assert to fail early when compiled with a compiler dismissing the
aligned attribute ?

As you point out, changing the currently public linux/rseq.h UAPI header
to remove those attributes ends up breaking user-space in scenarios of
non-top-level use across ABI boundary. This is not kernel-vs-userspace
ABI, but an ABI exposed by the kernel which ends up being used to
coordinate user-space objects within a program. Breaking that does not
appear to be any more acceptable. As I recall, the hard requirement for
Linux ABIs is to do not break userspace, period. There is not mention
of kernel-vs-userspace or userspace-vs-userspace. So if the end result
of this change is to break user-space, it should not be changed.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
