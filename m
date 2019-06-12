Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A603242893
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 16:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408659AbfFLOQE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 10:16:04 -0400
Received: from mail.efficios.com ([167.114.142.138]:48694 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408239AbfFLOQE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 10:16:04 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E2F88249E5D;
        Wed, 12 Jun 2019 10:16:02 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id iYe_KaCN3SYQ; Wed, 12 Jun 2019 10:16:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 38826249E48;
        Wed, 12 Jun 2019 10:16:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 38826249E48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560348962;
        bh=L5XC9WXtaVzp5iRMgYdqP/JUTm6Gc6c0+kHWK68s7bM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=adUJV5Q8/Y+sjcB3KAzrkHEiS8cHT/EuD86HTYIDLFqNk30/bb1156wJukeMpHbec
         OW9GKhZtQLyoxcWOT3Gh5KRPrrZ/lgglW89+DHKypLMo9ayMJwk0jw3L5QBdW7MKDq
         wlQ8byB2+EznoZ/dzxOBI4F1Rg32KQ29gjXcRr2TfPULS+A2Ih6ymFTdhr33fUEUkX
         y0VfuQJu1QoKoRft0I9q/QNVgefBm9J97qTtBh/roVIErfj28IRyAZ3j23ij4kZl7W
         9o63ZJkh1W3Q7J5d1IRdQaZ7bfTCGgTGIoZk1o78fASBC781xOkintgA5br2bAqN3i
         bwSL6s6+SW26g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id k4WAOas13dsW; Wed, 12 Jun 2019 10:16:02 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 1C9B1249E3E;
        Wed, 12 Jun 2019 10:16:02 -0400 (EDT)
Date:   Wed, 12 Jun 2019 10:16:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1329439108.43041.1560348962006.JavaMail.zimbra@efficios.com>
In-Reply-To: <87wohzorj0.fsf@oldenburg2.str.redhat.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <875zprm4jo.fsf@oldenburg2.str.redhat.com> <732661684.21584.1559314109886.JavaMail.zimbra@efficios.com> <87muj2k4ov.fsf@oldenburg2.str.redhat.com> <1528929896.22217.1559326257155.JavaMail.zimbra@efficios.com> <87o93d4lqb.fsf@oldenburg2.str.redhat.com> <117220011.27079.1559663870037.JavaMail.zimbra@efficios.com> <87wohzorj0.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: cbg+MojW6KvB2DHzgPPhBZtXJWBfGg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jun 6, 2019, at 1:57 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
[...]
> 
>>> The final remaining case is static dlopen.  There is a copy of ld.so on
>>> the dynamic side, but it is completely inactive and has never run.  I do
>>> not think we need to support that because multi-threading does not work
>>> reliably in this scenario, either.  However, we should skip rseq
>>> registration in a nested libc (see the rtld_active function).
>>
>> So for SHARED, if (!rtld_active ()), we should indeed leave the state of
>> __rseq_handled as it is, because we are within a nested inactive ld.so.
> 
> I think we should add __rseq_handled initialization to ld.so, so it will
> only run once, ever.

OK

> 
> It's the registration from libc.so which needs some care.  In
> particular, we must not override an existing registration.

OK, so it could check if __rseq_abi.cpu_id is -1, and only
perform registration if it is the case. Or do you have another
approach in mind ?

For the main thread, "nested" unregistration does not appear to be a
problem, because we rely on program exit() to implicitly unregister.

Thanks,

Mathieu

> 
> Thanks,
> Florian

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
