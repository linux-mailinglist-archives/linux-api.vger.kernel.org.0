Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C28B018D166
	for <lists+linux-api@lfdr.de>; Fri, 20 Mar 2020 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCTOrO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Mar 2020 10:47:14 -0400
Received: from mail.efficios.com ([167.114.26.124]:37078 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCTOrO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Mar 2020 10:47:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3AB6A280E48;
        Fri, 20 Mar 2020 10:47:12 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id suxPyYVnrqRF; Fri, 20 Mar 2020 10:47:11 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BE47F281196;
        Fri, 20 Mar 2020 10:47:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BE47F281196
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1584715631;
        bh=2iunU2dZUhpFG4YHr4G0tAZUqMAnPToZ4DCStcYLdFU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Sl5t5NPse6vfN7D2uDFbVteRf/Ago9K9aloGWAR3RwMoiBmfOLQQg4aS4BNvvWALe
         KZhfiKaThD54AdXmOqq7jEHz6U/kZR0kVV1z/UXDBNQI5UeUJrTw7R/kR2MMw5OmZw
         aFKTX4FAKgecZ/k6HpW7sCzSbacaM6YD6q/Lu63odRCPWM+FIK29+OJ2KoxP4C/WuF
         i8UzfPhEmvdXxdAxWlB08B9Oh3vh+MQMQuAokBNDpCLP/AT2zRKj36oIB38yCQLN0c
         DmkgwJpNytyXwMmRL+80+26686lG+UuNfB3GOIjF8qqVyXcchnCTBErzhZ60OKNSvO
         RmCF4CA9CSwtQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LFY6lmoKTf5Y; Fri, 20 Mar 2020 10:47:11 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AE29B28118D;
        Fri, 20 Mar 2020 10:47:11 -0400 (EDT)
Date:   Fri, 20 Mar 2020 10:47:11 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     libc-alpha <libc-alpha@sourceware.org>, carlos <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>
Message-ID: <82259847.4696.1584715631625.JavaMail.zimbra@efficios.com>
In-Reply-To: <1854222804.4643.1584711847409.JavaMail.zimbra@efficios.com>
References: <20200319144110.3733-1-mathieu.desnoyers@efficios.com> <87sgi4gqhf.fsf@mid.deneb.enyo.de> <1103782439.4046.1584642531222.JavaMail.zimbra@efficios.com> <87k13ggpmf.fsf@mid.deneb.enyo.de> <900536577.4062.1584644126425.JavaMail.zimbra@efficios.com> <87fte4go6w.fsf@mid.deneb.enyo.de> <624584479.4115.1584647163775.JavaMail.zimbra@efficios.com> <1854222804.4643.1584711847409.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH glibc 4/8] glibc: Perform rseq(2) registration at C
 startup and thread creation (v15)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v15)
Thread-Index: poZ7JQ5/Qt1CQs9uPvdRib/AmVGsDnhrNsAXpMewnwU=
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Mar 20, 2020, at 9:44 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
[...]
> Actually, here is an important clarification: the Linux kernel validates
> the struct rseq alignment on registration:
> 
>        if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
>            rseq_len != sizeof(*rseq))
>                return -EINVAL;
> 
> So removing the aligned attribute from struct rseq is actually an
> ABI-breaking change, because it would be incompatible with older
> kernels which perform the IS_ALIGNED check expecting at least at
> 32 bytes alignment.

So I plan to add the following to glibc's sys/rseq.h:

#include <sys/cdefs.h>

[...]

/* Ensure the compiler supports __attribute__ ((aligned)).  */
_Static_assert (__alignof__ (struct rseq_cs) >= 4 * sizeof(uint64_t),
                "alignment");
_Static_assert (__alignof__ (struct rseq) >= 4 * sizeof(uint64_t),
                "alignment");

/* Allocations of struct rseq and struct rseq_cs on the heap need to
   be aligned on 32 bytes. Therefore, use of malloc is discouraged
   because it does not guarantee alignment. posix_memalign should be
   used instead.  */

Does it help mitigating your concerns ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
