Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476EA18BF2C
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 19:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSSRr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 19 Mar 2020 14:17:47 -0400
Received: from albireo.enyo.de ([37.24.231.21]:51982 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgCSSRr (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Mar 2020 14:17:47 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jEzjc-000123-KO; Thu, 19 Mar 2020 18:17:36 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jEziG-0006VC-Ak; Thu, 19 Mar 2020 19:16:12 +0100
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
Date:   Thu, 19 Mar 2020 19:16:12 +0100
In-Reply-To: <1302331358.3965.1584641354569.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Thu, 19 Mar 2020 14:09:14 -0400
        (EDT)")
Message-ID: <87sgi4gqhf.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>> You also need to add an assert that the compiler supports
>> __attribute__ ((aligned)) because ignoring it produces an
>> ABI-incompatible header.
>
> Are you aware of some helper macro I should use to do this, or
> is it done elsewhere in glibc ?

I don't think we have any such GCC-only types yet.  max_align_t is
provided by GCC itself.

>> The struct rseq/struct rseq_cs definitions
>> are broken, they should not try to change the alignment.
>
> AFAIU, this means we should ideally not have used __attribute__((aligned))
> in the uapi headers in the first place. Why is it broken ?

Compilers which are not sufficiently GCC-compatible define
__attribute__(X) as the empty expansion, so you silently get a
different ABI.

There is really no need to specify 32-byte alignment here.  Is not
even the size of a standard cache line.  It can result in crashes if
these structs are heap-allocated using malloc, when optimizing for
AVX2.

For example, clang turns

void
clear (struct rseq *p)
{
  memset (p, 0, sizeof (*p));
}

into:

	vxorps	%xmm0, %xmm0, %xmm0
	vmovaps	%ymm0, (%rdi)
	vzeroupper
	retq

My understanding is that vmovaps will trap if the pointer is
misaligned (“When the source or destination operand is a memory
operand, the operand must be aligned on a 32-byte boundary or a
general-protection exception (#GP) will be generated.”).

> However, now that it is in the wild, it's a bit late to change that.

I had forgotten about the alignment crashes.  I think we should
seriously consider changing the types. 8-(
