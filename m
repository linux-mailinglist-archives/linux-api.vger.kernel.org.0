Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936CD1BBCF6
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 14:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgD1MC3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 28 Apr 2020 08:02:29 -0400
Received: from albireo.enyo.de ([37.24.231.21]:47708 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgD1MC3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 28 Apr 2020 08:02:29 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jTOwI-0000kx-RO; Tue, 28 Apr 2020 12:02:14 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jTOwI-0003qD-Mx; Tue, 28 Apr 2020 14:02:14 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C startup and thread creation (v17)
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com>
        <20200326155633.18236-6-mathieu.desnoyers@efficios.com>
        <87ees9z417.fsf@mid.deneb.enyo.de>
        <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com>
        <87zhawvphv.fsf@mid.deneb.enyo.de>
        <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
Date:   Tue, 28 Apr 2020 14:02:14 +0200
In-Reply-To: <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Mon, 27 Apr 2020 13:26:17 -0400
        (EDT)")
Message-ID: <87ftcnrf7d.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>>>>> +/* struct rseq is aligned on 4 * 8 bytes to ensure it is always
>>>>> +   contained within a single cache-line.
>>>>> +
>>>>> +   A single struct rseq per thread is allowed.  */
>>>>> +struct rseq
>>>>> +  {
>>>>> +    /* Restartable sequences cpu_id_start field. Updated by the
>>>>> +       kernel. Read by user-space with single-copy atomicity
>>>>> +       semantics. This field should only be read by the thread which
>>>>> +       registered this data structure. Aligned on 32-bit. Always
>>>> 
>>>> What does “Aligned on 32-bit” mean in this context?  Do you mean to
>>>> reference 32-*byte* alignment here?
>>>
>>> No. I really mean 32-bit (4-byte). Being aligned on 32-byte guarantees that
>>> this field is aligned at least on 4-byte. This is required by single-copy
>>> atomicity semantics.
>>>
>>> Should I update this comment to state "Aligned on 4-byte" instead ?
>> 
>> I think this is implied by all Linux ABIs.  And the explicit alignment
>> specification for struct rseq makes the alignment 32 bytes.
>
> Unless a structure ends up being packed, which is of course not the case
> here.
>
> I would prefer to keep the comment about 32-bit alignment requirement on
> the specific fields, because the motivation for alignment requirement is
> much more strict for fields (correctness) than the motivation for alignment
> of the structure (performance).

But the correctness is already enforced by the compiler, so I fail to
see point of mentioning this in the comment.

Anyway, I don't want to make a big deal of it.  Please leave it in if
you think it is ehlpful.

> x32 should not be an issue as explained above, so I'm very open to
> add this "uptr" for user-space only.

Okay, then please use anonymous unions and structs as necessary, to
ensure that the uptr field can be reached on all platforms in the same
way.
