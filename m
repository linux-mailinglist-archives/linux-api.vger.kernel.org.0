Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC3EB18BF7B
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 19:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgCSSg2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 14:36:28 -0400
Received: from albireo.enyo.de ([37.24.231.21]:52338 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSSg2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Mar 2020 14:36:28 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jF01j-0001Sy-Qw; Thu, 19 Mar 2020 18:36:19 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jF00G-0006ml-Aj; Thu, 19 Mar 2020 19:34:48 +0100
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C startup and thread creation (v15)
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com>
        <20200319144110.3733-5-mathieu.desnoyers@efficios.com>
        <874kukpf9f.fsf@mid.deneb.enyo.de>
        <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com>
        <87r1xo5o2s.fsf@mid.deneb.enyo.de>
        <1302331358.3965.1584641354569.JavaMail.zimbra@efficios.com>
        <87sgi4gqhf.fsf@mid.deneb.enyo.de>
        <1103782439.4046.1584642531222.JavaMail.zimbra@efficios.com>
Date:   Thu, 19 Mar 2020 19:34:48 +0100
In-Reply-To: <1103782439.4046.1584642531222.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 19 Mar 2020 14:28:51 -0400
        (EDT)")
Message-ID: <87k13ggpmf.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> ----- On Mar 19, 2020, at 2:16 PM, Florian Weimer fw@deneb.enyo.de wrote:
>
>> * Mathieu Desnoyers:
>> 
>>>> You also need to add an assert that the compiler supports
>>>> __attribute__ ((aligned)) because ignoring it produces an
>>>> ABI-incompatible header.
>>>
>>> Are you aware of some helper macro I should use to do this, or
>>> is it done elsewhere in glibc ?
>> 
>> I don't think we have any such GCC-only types yet.  max_align_t is
>> provided by GCC itself.
>
> I was thinking of adding the following to
>
> sysdeps/unix/sysv/linux/rseq-internal.h: rseq_register_current_thread()
>
> +  /* Ensure the compiler supports __attribute__ ((aligned)).  */
> +  _Static_assert (__alignof__ (struct rseq_cs) >= 4 * sizeof(uint64_t),
> +                 "alignment");
> +  _Static_assert (__alignof__ (struct rseq) >= 4 * sizeof(uint64_t),
> +                 "alignment");
> +

Something like it would have to go into the *public* header.

Inside glibc, you can assume __attribute__ support.

>>>> The struct rseq/struct rseq_cs definitions
>>>> are broken, they should not try to change the alignment.
>>>
>>> AFAIU, this means we should ideally not have used __attribute__((aligned))
>>> in the uapi headers in the first place. Why is it broken ?
>> 
>> Compilers which are not sufficiently GCC-compatible define
>> __attribute__(X) as the empty expansion, so you silently get a
>> different ABI.
>
> It is worth noting that rseq.h is not the only Linux uapi header
> which uses __attribute__ ((aligned)), so this ABI problem exists today
> anyway for those compilers.

Yuck.  Even with larger-than-16 alignment?

>> There is really no need to specify 32-byte alignment here.  Is not
>> even the size of a standard cache line.  It can result in crashes if
>> these structs are heap-allocated using malloc, when optimizing for
>> AVX2.
>
> Why would it be valid to allocate those with malloc ? Isn't it the
> purpose of posix_memalign() ?

It would not be valid, but I don't think we have diagnostics for C
like we have them for C++'s operator new.

>>> However, now that it is in the wild, it's a bit late to change that.
>> 
>> I had forgotten about the alignment crashes.  I think we should
>> seriously consider changing the types. 8-(
>
> I don't think this is an option at this stage given that it is part
> of the Linux kernel UAPI. I am not convinced that it is valid at all
> to allocate struct rseq or struct rseq_cs with malloc(), because it
> does not guarantee any alignment.

The kernel ABI doesn't change.  The kernel cannot use the alignment
information anyway.  Userspace struct layout may change in subtle
ways, though.
