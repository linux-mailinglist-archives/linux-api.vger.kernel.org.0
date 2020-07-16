Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D27222614
	for <lists+linux-api@lfdr.de>; Thu, 16 Jul 2020 16:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGPOpX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jul 2020 10:45:23 -0400
Received: from mail.efficios.com ([167.114.26.124]:51574 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOpW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jul 2020 10:45:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5E103295147;
        Thu, 16 Jul 2020 10:45:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cSaM-x66oxNT; Thu, 16 Jul 2020 10:45:21 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ECCB62950B0;
        Thu, 16 Jul 2020 10:45:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ECCB62950B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594910721;
        bh=h1/Cf0DkBhdvrMDUfv23qlmdBWwetW3gntyUfIcpO78=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=PN8u/mqOfmZCqn0kbRTP2Bs0m+iEOdKV4/rJ2uesUCcRQqU7tKVvOmWt9UgxD5LtT
         UdaLDYb6YjlH0bZvf8XxdJiNdAF7jw0CYf18gsmuGbJMl0IFDDs9KDJke7l/r6p79v
         bX+cr+xfPz8TJ0iDY6Jxf2zp5qY9teV28rXPETg+QUp8lDPXV+Dfz4aKjew8LxxdrN
         Suzjjt0c8180J8vsTuiJunvp0qw6bqjnUba8/jIghKvQ1zUCs1Qk2ZVy89pTMT0KnG
         wWt/w7DCHPdiSqkjk6OD4D91hKeRxMAxxJT0gy0/9iEZGHFAwoLn87EKqUhnOzDmTS
         YV4zIVLYtTFUg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pn2XPYT_nyEs; Thu, 16 Jul 2020 10:45:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D8F9C294AD7;
        Thu, 16 Jul 2020 10:45:20 -0400 (EDT)
Date:   Thu, 16 Jul 2020 10:45:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Chris Kennelly <ckennelly@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <944502665.15688.1594910720789.JavaMail.zimbra@efficios.com>
In-Reply-To: <9f747c44-be54-c547-7e4c-a978499f06c0@redhat.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <e7ede994-ebec-8022-b12b-ac7147641ffb@redhat.com> <1190016739.14119.1594818179014.JavaMail.zimbra@efficios.com> <9f747c44-be54-c547-7e4c-a978499f06c0@redhat.com>
Subject: Re: [RFC PATCH 0/4] rseq: Introduce extensible struct rseq
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce extensible struct rseq
Thread-Index: d/IRYjqcrblixO7jK8iG9PCSWfN0GA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 16, 2020, at 9:39 AM, carlos carlos@redhat.com wrote:

> On 7/15/20 9:02 AM, Mathieu Desnoyers wrote:
>> At this point, the main question I would like answered is whether
>> it would be acceptable to increase the size and alignment of
>> the __rseq_abi symbol (which will be exposed by glibc) between
>> e.g. glibc 2.32 and 2.33. If it's not possible, then we can
>> find other solutions, for instance using an indirection with
>> a pointer to an extended structure, but this appears to be
>> slightly less efficient.
> 
> The answer is always a soft "maybe" because it depends exactly
> on how we do it and what consequences we are willing to accept
> in the design.
> 
> For example, static applications that call dlopen will fail if
> we increase the alignment beyond 32 because we had to special
> case this scenario. Why did we have to special case it? Because
> the "static" part of the runtime needs to create the initial
> thread's static TLS space, and since it doesn't know apriori
> what will be loaded in the shared library, it needs to make a
> "best guess" at the alignment requirement at startup.
> We need to discuss this and agree that it's OK. We already want
> to deprecate dynamic loading from static applications, so this
> may not be a problem in general, but I hope you see my point.
> That there are corner cases to be considered and ironed out.

Note that I don't foresee we will explicitly need to increase
the alignment value for __rseq_abi beyond 32, but I was merely
asking this for sake of completeness, in case extending struct rseq
beyond a certain limit ever happens to increase the minimum
alignment.

> 
> I want to see a detailed design document explaining the various
> compatibility issues and how we solve them along with the way
> the extension mechanism would work and how it would be compliant
> with C/C++ language rules in userspace without adding undue burden
> of potentially having to use atomic instructions all the time.
> This includes discussing how the headers change. We should also
> talk out the options for symbol versioning and their consequences.
>  
> I haven't seen enough details, and there isn't really enough
> time to discuss this. I think it is *great* that we are discussing
> it, but it's safest if we revert rseq, finish the discussion,
> and then finalize the inclusion for 2.33 with these details
> ironed out.

Yes, absolutely.

> 
> I feel like we've made all the technical process we need to actually
> include rseq in glibc, but this discussion, and the google example
> (even if it doesn't match our use case) shows that if we spend another
> month hammering out the extension details could yield something we
> can use for years to come while we work out other details e.g. cpu_opv.

Indeed. Note that the current approach proposed to replace cpu_opv
is "sched_pair_cpu", ref. https://lore.kernel.org/lkml/20200619202516.7109-1-mathieu.desnoyers@efficios.com/

> I can set aside time in the next month to write up such a document
> and discuss these issues with you and Florian. The text would form
> even more of the language we'd have to include in the man page for
> the feature.

I'll do my best to secure some time to work with you on this in the
next month, but I will really have to focus on other projects which
I had to delay to make sure the rseq integration was ready for glibc
2.32.

> In the meantime I think we should revert rseq in glibc and take
> our time to hash this out without the looming deadline of August 1st
> for the ABI going out the door.
> 
> I know this is disappointing, but I think in a month you'll look
> back at this, we'll have Fedora Rawhide using the new extensible
> version (and you'll be able to point people at that), and we'll
> only be 5 months away from an official release with extensible
> rseq.

If this delay gives us a future-proof extensible rseq ABI, I'm absolutely
for it!

> Could you please respond to Florian's request to revert here?
> https://sourceware.org/pipermail/libc-alpha/2020-July/116368.html
> 
> I'm looking for a Signed-off-by from you that you're OK with
> reverting.

Will do, thanks!

Mathieu


> 
> --
> Cheers,
> Carlos.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
