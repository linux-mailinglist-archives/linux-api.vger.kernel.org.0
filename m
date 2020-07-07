Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3349921774A
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGGS7Y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 14:59:24 -0400
Received: from mail.efficios.com ([167.114.26.124]:42542 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGS7Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 14:59:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8C53B5D63;
        Tue,  7 Jul 2020 14:59:22 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4o1Avpf2zFAc; Tue,  7 Jul 2020 14:59:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1883F6036;
        Tue,  7 Jul 2020 14:59:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1883F6036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594148362;
        bh=mzuIUnamONBoL4ResXC6afa2VgZyrH5PPsjVxccNGcY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=JerpaJ9gB5ye4m7RrcF6iMwnae2Zug9lhdh63mWwd8IXED5Yp5dKHjAD58y28Esoi
         BCphqWd4+P7ep9WIRtHKup2y7YKXed6Jx0q5CR07HG564ytafPnPuvR5bPDiSUSmZU
         xeGbnedSiLiwmPiPV99PTa01Av+YDjb2FZV+0SR+v7V0Dxsmpr+ypKnBHu8fA3sQli
         835BGwKclUWkwJDggpwf5QuRuq+8CHFKd6j3+lO6okisV4YZrkPIucKR28o3xa/+3F
         alizBYkGhK5lcMjoLwN008DAFZ8mGpbRleg1PmaaL0M1lgALfYFPOIur9eJRjwyyWW
         EnluVEikkSULA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Mp90vca1b8ka; Tue,  7 Jul 2020 14:59:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 06C496035;
        Tue,  7 Jul 2020 14:59:22 -0400 (EDT)
Date:   Tue, 7 Jul 2020 14:59:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <carlos@redhat.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Message-ID: <1834900818.710.1594148361942.JavaMail.zimbra@efficios.com>
In-Reply-To: <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com> <20200706204913.20347-4-mathieu.desnoyers@efficios.com> <87fta3zstr.fsf@mid.deneb.enyo.de> <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com> <874kqjzhkb.fsf@mid.deneb.enyo.de> <378862525.1039.1594123580789.JavaMail.zimbra@efficios.com> <d6b28b3e-9866-ce6f-659e-2c0dba4cd527@redhat.com>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce
 RSEQ_FLAG_RELIABLE_CPU_ID
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
Thread-Index: evw356kMDxgHduYKKMXQGuqC7nUxTQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 7, 2020, at 2:53 PM, Carlos O'Donell carlos@redhat.com wrote:

> On 7/7/20 8:06 AM, Mathieu Desnoyers wrote:
>> ----- On Jul 7, 2020, at 7:32 AM, Florian Weimer fw@deneb.enyo.de wrote:
>> 
>>> * Mathieu Desnoyers:
>>>
>>>> Those are very good points. One possibility we have would be to let
>>>> glibc do the rseq registration without the RSEQ_FLAG_RELIABLE_CPU_ID
>>>> flag. On kernels with the bug present, the cpu_id field is still good
>>>> enough for typical uses of sched_getcpu() which does not appear to
>>>> have a very strict correctness requirement on returning the right
>>>> cpu number.
>>>>
>>>> Then libraries and applications which require a reliable cpu_id
>>>> field could check this on their own by calling rseq with the
>>>> RSEQ_FLAG_RELIABLE_CPU_ID flag. This would not make the state more
>>>> complex in __rseq_abi, and let each rseq user decide about its own
>>>> fate: whether it uses rseq or keeps using an rseq-free fallback.
>>>>
>>>> I am still tempted to allow combining RSEQ_FLAG_REGISTER |
>>>> RSEQ_FLAG_RELIABLE_CPU_ID for applications which would not be using
>>>> glibc, and want to check this flag on thread registration.
>>>
>>> Well, you could add a bug fix level field to the __rseq_abi variable.
>> 
>> Even though I initially planned to make the struct rseq_abi extensible,
>> the __rseq_abi variable ends up being fix-sized, so we need to be very
>> careful in choosing what we place in the remaining 12 bytes of padding.
>> I suspect we'd want to keep 8 bytes to express a pointer to an
>> "extended" structure.
>> 
>> I wonder if a bug fix level "version" is the right approach. We could
>> instead have a bitmask of fixes, which the application could independently
>> check. For instance, some applications may care about cpu_id field
>> reliability, and others not.
> 
> I agree with Florian.
> 
> Developers are not interested in a bitmask of fixes.
> 
> They want a version they can check and that at a given version everything
> works as expected.
> 
> In reality today this is the kernel version.
> 
> So rseq is broken from a developer perspective until they can get a new
> kernel or an agreement from their downstream vendor that revision Z of
> the kernel they are using has the fix you've just committed.
> 
> Essentially this problem solves itself at level higher than the interfaces
> we're talking about today.
> 
> Encoding this as a bitmask of fixes is an overengineered solution for a
> problem that the downstream communities already know how to solve.
> 
> I would strongly suggest a "version" or nothing.

That's a good point.

> 
>>> Then applications could check if the kernel has the appropriate level
>>> of non-buggyness.  But the same thing could be useful for many other
>>> kernel interfaces, and I haven't seen such a fix level value for them.
>>> What makes rseq so special?
>> 
>> I guess my only answer is because I care as a user of the system call, and
>> what is a system call without users ? I have real applications which work
>> today with end users deploying them on various kernels, old and new, and I
>> want to take advantage of this system call to speed them up. However, if I
>> have to choose between speed and correctness (in other words, not crashing
>> a critical application), I will choose correctness. So if I cannot detect
>> that I can safely use the system call, it becomes pretty much useless even
>> for my own use-cases.
> 
> Yes.
> 
> In the case of RHEL we have *tons*  of users in the same predicament.
> 
> They just wait until the RHEL kernel team releases a fixed kernel version
> and check for that version and deploy with that version.
> 
> Likewise every other user of a kernel. They solve it by asking their
> kernel provider, internal or external, to verify the fix is applied to
> the deployment kernel.
> 
> If they are an ISV they have to test and deploy similar strategies for
> multiple kernel version.
> 
> By trying to automate this you are encoding into the API some level of
> package management concepts e.g. patch level, revision level, etc.
> 
> This is difficult to do without a more generalized API. Why do it just
> for rseq? Why do it with the few bits you have?
> 
> It's not a great fit IMO. Just let the kernel version be the arbiter of
> correctness.
> 
>>> It won't help with the present bug, but maybe we should add an rseq
>>> API sub-call that blocks future rseq registration for the thread.
>>> Then we can add a glibc tunable that flips off rseq reliably if people
>>> do not want to use it for some reason (and switch to the non-rseq
>>> fallback code instead).  But that's going to help with future bugs
>>> only.
>> 
>> I don't think it's needed. All I really need is to have _some_ way to
>> let lttng-ust or liburcu query whether the cpu_id field is reliable. This
>> state does not have to be made quickly accessible to other libraries,
>> nor does it have to be shared between libraries. It would allow each
>> user library or application to make its own mind on whether it can use
>> rseq or not.
> 
> That check is "kernel version > x.y.z" :-)
> 
> or
> 
> "My kernel vendor told me it's fixed."

Allright, thanks for the insight! I'll drop these patches and focus only
on the bugfix.

Thanks,

Mathieu

> 
> --
> Cheers,
> Carlos.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
