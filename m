Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960C2216C7E
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 14:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgGGMGX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 08:06:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:42400 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGMGW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 08:06:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6C6C12EED;
        Tue,  7 Jul 2020 08:06:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XVIT9bVn-vr1; Tue,  7 Jul 2020 08:06:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ECE0D2DDE;
        Tue,  7 Jul 2020 08:06:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ECE0D2DDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594123581;
        bh=R1Sxn+P3gozzJcMY/YSkvRzlXSDvvg/0BB8OWSVSc5I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gez1hgpyjo1rJm+SO3IxLu5rWLfJpoVNYVTJswwo6gyFlfFG1jbNX0QlCivSi+ghR
         Dq0LA8i7OSpJyq85GReTZJzyPGng0AI6Ung9+7we8SxowX6BqSdMwK+kj+uKUFjv/F
         ZioUEc6yXge4eJ4+mcT9ZxxMGUzn/ueN2JNyQsqs3f8wgEMOPNjT5LF1HbsfxOwSFB
         6FkULQpeBcTllWn3F3hw7Lhime3nPfJRSdBNbRcQa//is72u5CuvlS81IXWoa5rpyf
         YByaLEQvtDHrBoRwoRpulvDACqTJr3kowRGafv5l3YtUnxhtMwmw/f/Rc7MixCw1GK
         Pu5MYCtMbsFQg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NAQ7EFEsqPUS; Tue,  7 Jul 2020 08:06:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D9E282DDB;
        Tue,  7 Jul 2020 08:06:20 -0400 (EDT)
Date:   Tue, 7 Jul 2020 08:06:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Message-ID: <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com>
In-Reply-To: <874kqjzhkb.fsf@mid.deneb.enyo.de>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com> <20200706204913.20347-4-mathieu.desnoyers@efficios.com> <87fta3zstr.fsf@mid.deneb.enyo.de> <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com> <874kqjzhkb.fsf@mid.deneb.enyo.de>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce
 RSEQ_FLAG_RELIABLE_CPU_ID
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
Thread-Index: necjClEjKCrHFicK9OlbqryGqXBZRA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 7, 2020, at 7:32 AM, Florian Weimer fw@deneb.enyo.de wrote:

> * Mathieu Desnoyers:
> 
>> Those are very good points. One possibility we have would be to let
>> glibc do the rseq registration without the RSEQ_FLAG_RELIABLE_CPU_ID
>> flag. On kernels with the bug present, the cpu_id field is still good
>> enough for typical uses of sched_getcpu() which does not appear to
>> have a very strict correctness requirement on returning the right
>> cpu number.
>>
>> Then libraries and applications which require a reliable cpu_id
>> field could check this on their own by calling rseq with the
>> RSEQ_FLAG_RELIABLE_CPU_ID flag. This would not make the state more
>> complex in __rseq_abi, and let each rseq user decide about its own
>> fate: whether it uses rseq or keeps using an rseq-free fallback.
>>
>> I am still tempted to allow combining RSEQ_FLAG_REGISTER |
>> RSEQ_FLAG_RELIABLE_CPU_ID for applications which would not be using
>> glibc, and want to check this flag on thread registration.
> 
> Well, you could add a bug fix level field to the __rseq_abi variable.

Even though I initially planned to make the struct rseq_abi extensible,
the __rseq_abi variable ends up being fix-sized, so we need to be very
careful in choosing what we place in the remaining 12 bytes of padding.
I suspect we'd want to keep 8 bytes to express a pointer to an
"extended" structure.

I wonder if a bug fix level "version" is the right approach. We could
instead have a bitmask of fixes, which the application could independently
check. For instance, some applications may care about cpu_id field
reliability, and others not.

> Then applications could check if the kernel has the appropriate level
> of non-buggyness.  But the same thing could be useful for many other
> kernel interfaces, and I haven't seen such a fix level value for them.
> What makes rseq so special?

I guess my only answer is because I care as a user of the system call, and
what is a system call without users ? I have real applications which work
today with end users deploying them on various kernels, old and new, and I
want to take advantage of this system call to speed them up. However, if I
have to choose between speed and correctness (in other words, not crashing
a critical application), I will choose correctness. So if I cannot detect
that I can safely use the system call, it becomes pretty much useless even
for my own use-cases.

> It won't help with the present bug, but maybe we should add an rseq
> API sub-call that blocks future rseq registration for the thread.
> Then we can add a glibc tunable that flips off rseq reliably if people
> do not want to use it for some reason (and switch to the non-rseq
> fallback code instead).  But that's going to help with future bugs
> only.

I don't think it's needed. All I really need is to have _some_ way to
let lttng-ust or liburcu query whether the cpu_id field is reliable. This
state does not have to be made quickly accessible to other libraries,
nor does it have to be shared between libraries. It would allow each
user library or application to make its own mind on whether it can use
rseq or not.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
