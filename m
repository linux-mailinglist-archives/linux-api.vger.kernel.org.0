Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A362918BFB5
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 19:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCSSz2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 14:55:28 -0400
Received: from mail.efficios.com ([167.114.26.124]:59908 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgCSSz2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 14:55:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 43E0727AA9C;
        Thu, 19 Mar 2020 14:55:27 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YZvzRANsrTpZ; Thu, 19 Mar 2020 14:55:26 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9AA7827A93F;
        Thu, 19 Mar 2020 14:55:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9AA7827A93F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584644126;
        bh=ZWNiGqU2Ab0xVGCjTKpkcmtfdONYw9vZUUAGyB1yU84=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=A4UXQGkT0v97L9oJ7OGXaT+UczjRmvuOJhXj7Aj+hT+RqMjAQUVGsVcTNjzel/Zwk
         65JA8jEI61fHGqUj3Q4Z96Vf0wMb2MWFElu5mivA3uiTZEpaqO395hdvF93nbiACbp
         Epv2VUOQV/QRyDcrpTpk2DdLl2kFMQbpkysSYGpgcSrlB7QDG5NXUglAji+52xSxXv
         L+ohqYyC6LaR6B6vggWs2l713w1Iub7haBQzOtC7qXnmntKuYsCAe23JRdPwXyCH4S
         zeq1prOFAHPEj2V909SaV7KLnGiHqXdPhpEOKyficJkXNCTBtE639JMJ7qa3Ypd3zk
         E6vYrVnGDT3AA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5P-5zr0GCowB; Thu, 19 Mar 2020 14:55:26 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 87BA327AB97;
        Thu, 19 Mar 2020 14:55:26 -0400 (EDT)
Date:   Thu, 19 Mar 2020 14:55:26 -0400 (EDT)
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
Message-ID: <900536577.4062.1584644126425.JavaMail.zimbra@efficios.com>
In-Reply-To: <87k13ggpmf.fsf@mid.deneb.enyo.de>
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com> <874kukpf9f.fsf@mid.deneb.enyo.de> <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com> <87r1xo5o2s.fsf@mid.deneb.enyo.de> <1302331358.3965.1584641354569.JavaMail.zimbra@efficios.com> <87sgi4gqhf.fsf@mid.deneb.enyo.de> <1103782439.4046.1584642531222.JavaMail.zimbra@efficios.com> <87k13ggpmf.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v15)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v15)
Thread-Index: R1unvLHgJY+0+0/DqhqCog6T/iuOvg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 19, 2020, at 2:34 PM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Mar 19, 2020, at 2:16 PM, Florian Weimer fw@deneb.enyo.de wrote:
>>
>>> * Mathieu Desnoyers:
>>> 
>>>>> You also need to add an assert that the compiler supports
>>>>> __attribute__ ((aligned)) because ignoring it produces an
>>>>> ABI-incompatible header.
>>>>
>>>> Are you aware of some helper macro I should use to do this, or
>>>> is it done elsewhere in glibc ?
>>> 
>>> I don't think we have any such GCC-only types yet.  max_align_t is
>>> provided by GCC itself.
>>
>> I was thinking of adding the following to
>>
>> sysdeps/unix/sysv/linux/rseq-internal.h: rseq_register_current_thread()
>>
>> +  /* Ensure the compiler supports __attribute__ ((aligned)).  */
>> +  _Static_assert (__alignof__ (struct rseq_cs) >= 4 * sizeof(uint64_t),
>> +                 "alignment");
>> +  _Static_assert (__alignof__ (struct rseq) >= 4 * sizeof(uint64_t),
>> +                 "alignment");
>> +
> 
> Something like it would have to go into the *public* header.
> 
> Inside glibc, you can assume __attribute__ support.

OK, so the _Static_assert () could sit in sys/rseq.h

> 
>>>>> The struct rseq/struct rseq_cs definitions
>>>>> are broken, they should not try to change the alignment.
>>>>
>>>> AFAIU, this means we should ideally not have used __attribute__((aligned))
>>>> in the uapi headers in the first place. Why is it broken ?
>>> 
>>> Compilers which are not sufficiently GCC-compatible define
>>> __attribute__(X) as the empty expansion, so you silently get a
>>> different ABI.
>>
>> It is worth noting that rseq.h is not the only Linux uapi header
>> which uses __attribute__ ((aligned)), so this ABI problem exists today
>> anyway for those compilers.
> 
> Yuck.  Even with larger-than-16 alignment?

There are two:

target_core_user.h
45:#define ALIGN_SIZE 64 /* Should be enough for most CPUs */
58:	__u32 cmd_tail __attribute__((__aligned__(ALIGN_SIZE)));

netfilter_bridge/ebtables.h:90:	char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
netfilter_bridge/ebtables.h:132:	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
netfilter_bridge/ebtables.h:145:	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
netfilter_bridge/ebtables.h:158:	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
netfilter_bridge/ebtables.h:191:	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));


> 
>>> There is really no need to specify 32-byte alignment here.  Is not
>>> even the size of a standard cache line.  It can result in crashes if
>>> these structs are heap-allocated using malloc, when optimizing for
>>> AVX2.
>>
>> Why would it be valid to allocate those with malloc ? Isn't it the
>> purpose of posix_memalign() ?
> 
> It would not be valid, but I don't think we have diagnostics for C
> like we have them for C++'s operator new.

We could at least make an effort to let people know that alignment is
required here when allocating struct rseq and struct rseq_cs on the
heap by adding some comments to that effect in linux/rseq.h ?

> 
>>>> However, now that it is in the wild, it's a bit late to change that.
>>> 
>>> I had forgotten about the alignment crashes.  I think we should
>>> seriously consider changing the types. 8-(
>>
>> I don't think this is an option at this stage given that it is part
>> of the Linux kernel UAPI. I am not convinced that it is valid at all
>> to allocate struct rseq or struct rseq_cs with malloc(), because it
>> does not guarantee any alignment.
> 
> The kernel ABI doesn't change.  The kernel cannot use the alignment
> information anyway.  Userspace struct layout may change in subtle
> ways, though.

Considering the amount of pain this can cause in user-space, and because
it can break userspace, this is not a UAPI change I am willing to consider.
I'm not sure why we are even discussing the possibility of breaking a Linux
UAPI considering that those are set in stone.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
