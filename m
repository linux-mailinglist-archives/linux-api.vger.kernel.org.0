Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069172160DA
	for <lists+linux-api@lfdr.de>; Mon,  6 Jul 2020 23:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgGFVIf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Jul 2020 17:08:35 -0400
Received: from mail.efficios.com ([167.114.26.124]:37790 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFVIe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Jul 2020 17:08:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 628DB2DD101;
        Mon,  6 Jul 2020 17:08:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wcJb0Pe9Wy3C; Mon,  6 Jul 2020 17:08:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 10C842DD029;
        Mon,  6 Jul 2020 17:08:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 10C842DD029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1594069713;
        bh=7UlbgTqoLJxGJTc7JZfgGNgiNlgeE1XcyfxpzisnSLI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Ut4HGaqKrQO6T3EpOnBMovq8K2Y615tarH+K2nx3/AI632yC0rCrIlL6j+1WDB6vC
         +y2UDYqunUOUGHprtKcybX2tcDyJzoBPlzMq2TdNXeWET23qaZsT091/MxPIY4gAt1
         ERSfntKDD3umpJKe5PnwappcdRrn8sOcL3s/mq35xIckVOtvcJS+ltV8waF5z8mfJB
         KLZmSAPmEgNrVFJERb4NUWYdjhHpbWne6PHFCQAa6kuHO3SuQDOJT4hgaCJfaj2cYd
         gxlTRd9b3fQUQC2oP27BEvv5AmhmXuCS8O3Rh9i2JURrvupG619199GV1aWLwee6DH
         M4bgfIHNch00w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xn5wGwpqVwc3; Mon,  6 Jul 2020 17:08:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id F34042DCD6D;
        Mon,  6 Jul 2020 17:08:32 -0400 (EDT)
Date:   Mon, 6 Jul 2020 17:08:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul Turner <pjt@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <901929746.433.1594069712898.JavaMail.zimbra@efficios.com>
In-Reply-To: <87blks344u.fsf@oldenburg2.str.redhat.com>
References: <20200629190036.26982-1-mathieu.desnoyers@efficios.com> <20200629190036.26982-3-mathieu.desnoyers@efficios.com> <877dvg4ud4.fsf@oldenburg2.str.redhat.com> <942999672.22574.1594046978937.JavaMail.zimbra@efficios.com> <1679448037.22891.1594056826859.JavaMail.zimbra@efficios.com> <87k0zg3535.fsf@oldenburg2.str.redhat.com> <1449254526.22910.1594058539512.JavaMail.zimbra@efficios.com> <87blks344u.fsf@oldenburg2.str.redhat.com>
Subject: Re: [PATCH 2/3] Linux: Use rseq in sched_getcpu if available (v9)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: Linux: Use rseq in sched_getcpu if available (v9)
Thread-Index: I6miy1IiklPsyYvl/Xr34Sz2sT8C5Q==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Jul 6, 2020, at 2:11 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
>> ----- On Jul 6, 2020, at 1:50 PM, Florian Weimer fweimer@redhat.com wrote:
>>
>>> * Mathieu Desnoyers:
>>> 
>>>> Now we need to discuss how we introduce that fix in a way that will
>>>> allow user-space to trust the __rseq_abi.cpu_id field's content.
>>> 
>>> I don't think that's necessary.  We can mention it in the glibc
>>> distribution notes on the wiki.
>>> 
>>>> The usual approach to kernel bug fixing is typically to push the fix,
>>>> mark it for stable kernels, and expect everyone to pick up the
>>>> fixes. I wonder how comfortable glibc would be to replace its
>>>> sched_getcpu implementation with a broken-until-fixed kernel rseq
>>>> implementation without any mechanism in place to know whether it can
>>>> trust the value of the cpu_id field. I am extremely reluctant to do
>>>> so.
>>> 
>>> We have already had similar regressions in sched_getcpu, and we didn't
>>> put anything into glibc to deal with those.
>>
>> Was that acceptable because having a wrong cpu number would never trigger
>> corruption, only slowdowns ?
> 
> First of all, it's a kernel bug.  It's rare that we put workarounds for
> kernel bugs into glibc.
> 
> And yes, in pretty much all cases it's just a performance issue for
> sched_getcpu.  When you know the CPU ID of a thread due to pinning to a
> single CPU, why would you call sched_getcpu?  (That's the case where you
> could get corruption in theory.)
> 
>> In the case of rseq, having the wrong cpu_id value is a real issue
>> which will lead to corruption and crashes. So I maintain my reluctance
>> to introduce the fix without any way for userspace to know whether the
>> cpu_id field value is reliable.
> 
> Yes, for rseq itself, the scenario is somewhat different.  Still, it's
> just another kernel bug.  There will be others. 8-/
> 
> From a schedule point of view, it looks tough to get the magic flag into
> the mainline kernel in time for the upcoming glibc 2.32 release.  If you
> insist on registering rseq only if the bug is not present, we'll
> probably have to back out some or all of the rseq changes.

I've just submitted the fix and a the new rseq flag as RFC to lkml:

https://lore.kernel.org/lkml/20200706204913.20347-1-mathieu.desnoyers@efficios.com/

Let's see how quickly we can come to an agreement on this on the kernel
side.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
