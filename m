Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6EF18C013
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 20:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgCSTHS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 15:07:18 -0400
Received: from albireo.enyo.de ([37.24.231.21]:52842 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbgCSTHR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Mar 2020 15:07:17 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jF0VY-00029N-1A; Thu, 19 Mar 2020 19:07:08 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jF0UB-00083N-Mg; Thu, 19 Mar 2020 20:05:43 +0100
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
        <874kukpf9f.fsf@mid.deneb.enyo.de>
        <2147217200.3240.1584633395285.JavaMail.zimbra@efficios.com>
        <87r1xo5o2s.fsf@mid.deneb.enyo.de>
        <1302331358.3965.1584641354569.JavaMail.zimbra@efficios.com>
        <87sgi4gqhf.fsf@mid.deneb.enyo.de>
        <1103782439.4046.1584642531222.JavaMail.zimbra@efficios.com>
        <87k13ggpmf.fsf@mid.deneb.enyo.de>
        <900536577.4062.1584644126425.JavaMail.zimbra@efficios.com>
Date:   Thu, 19 Mar 2020 20:05:43 +0100
In-Reply-To: <900536577.4062.1584644126425.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 19 Mar 2020 14:55:26 -0400
        (EDT)")
Message-ID: <87fte4go6w.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>> Inside glibc, you can assume __attribute__ support.
>
> OK, so the _Static_assert () could sit in sys/rseq.h

It requires a C11 compiler.  In this case, you could use _Alignas.

>
>> 
>>>>>> The struct rseq/struct rseq_cs definitions
>>>>>> are broken, they should not try to change the alignment.
>>>>>
>>>>> AFAIU, this means we should ideally not have used __attribute__((aligned))
>>>>> in the uapi headers in the first place. Why is it broken ?
>>>> 
>>>> Compilers which are not sufficiently GCC-compatible define
>>>> __attribute__(X) as the empty expansion, so you silently get a
>>>> different ABI.
>>>
>>> It is worth noting that rseq.h is not the only Linux uapi header
>>> which uses __attribute__ ((aligned)), so this ABI problem exists today
>>> anyway for those compilers.
>> 
>> Yuck.  Even with larger-than-16 alignment?
>
> There are two:
>
> target_core_user.h
> 45:#define ALIGN_SIZE 64 /* Should be enough for most CPUs */
> 58:	__u32 cmd_tail __attribute__((__aligned__(ALIGN_SIZE)));

That one is tough to figure out:

struct tcmu_mailbox {
        __u16 version;
        __u16 flags;
        __u32 cmdr_off;
        __u32 cmdr_size;

        __u32 cmd_head;

        /* Updated by user. On its own cacheline */
        __u32 cmd_tail __attribute__((__aligned__(ALIGN_SIZE)));

} __attribute__((packed));

Apparently, the expectation is that the compiler ignores __attribute__
((packed) in this context.  Ugh.

> netfilter_bridge/ebtables.h:90:	char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
> netfilter_bridge/ebtables.h:132:	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
> netfilter_bridge/ebtables.h:145:	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
> netfilter_bridge/ebtables.h:158:	unsigned char data[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
> netfilter_bridge/ebtables.h:191:	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));

I think these values are lower than max_align_t, so uncritical.

>>>> There is really no need to specify 32-byte alignment here.  Is not
>>>> even the size of a standard cache line.  It can result in crashes if
>>>> these structs are heap-allocated using malloc, when optimizing for
>>>> AVX2.
>>>
>>> Why would it be valid to allocate those with malloc ? Isn't it the
>>> purpose of posix_memalign() ?
>> 
>> It would not be valid, but I don't think we have diagnostics for C
>> like we have them for C++'s operator new.
>
> We could at least make an effort to let people know that alignment is
> required here when allocating struct rseq and struct rseq_cs on the
> heap by adding some comments to that effect in linux/rseq.h ?

We could use different types on the glibc side, then no special
programmer action will be needed.

>>>>> However, now that it is in the wild, it's a bit late to change that.
>>>> 
>>>> I had forgotten about the alignment crashes.  I think we should
>>>> seriously consider changing the types. 8-(
>>>
>>> I don't think this is an option at this stage given that it is part
>>> of the Linux kernel UAPI. I am not convinced that it is valid at all
>>> to allocate struct rseq or struct rseq_cs with malloc(), because it
>>> does not guarantee any alignment.
>> 
>> The kernel ABI doesn't change.  The kernel cannot use the alignment
>> information anyway.  Userspace struct layout may change in subtle
>> ways, though.
>
> Considering the amount of pain this can cause in user-space, and because
> it can break userspace, this is not a UAPI change I am willing to consider.
> I'm not sure why we are even discussing the possibility of breaking a Linux
> UAPI considering that those are set in stone.

Again, the kernel interface is NOT affected.  Only if the struct is
used in a non-top-level fashion across an ABI boundary in userspace.
I think making the change now is better than dealing with the breakage
in rseq users when they are built with -mavx2.
