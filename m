Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9639E4070B1
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIJR5I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 13:57:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:37242 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJR5I (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 13:57:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8276B380BB7;
        Fri, 10 Sep 2021 13:55:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IuMMT8J-4IRd; Fri, 10 Sep 2021 13:55:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 02421380BB6;
        Fri, 10 Sep 2021 13:55:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 02421380BB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1631296556;
        bh=5+hAG8XNzsa04MG+fqOR9+Yfgc7sEdxUWr0qmmVfCfY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=D2Y/BDbCbe3M+6qV+k1Ku+t9zQP6MKY9svVkACnUBAxoa6TPj3ucPG6abAXe+G3HL
         tZz0TPPyvqbl9zwjLKyElCw+aNQKcUFampR72oaEiGDyrhXE/QaieXV6W1gKYo1n9s
         f285Abk/Q74G/4sRi96Yy46x7bEPUhguUfyMGy5EiAcMXcleRRPntVs7ozASxZMQ2i
         zQqziskxboGMELSktXPskxE5geC8+oXc3ijBU7bpVZdgNgqHyGpDVwaYhrk7UY5SNN
         hl/JI44yuWz1aT4lAIw6fiO+EwxsIqJQk6ZMq55qw3n7UVBAoNyplrq5tCJcCAKMpW
         7A11IyMoYIojA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FVcMjE_yDwv4; Fri, 10 Sep 2021 13:55:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E492C380BB5;
        Fri, 10 Sep 2021 13:55:55 -0400 (EDT)
Date:   Fri, 10 Sep 2021 13:55:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Oskolkov <posk@google.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <872090791.15342.1631296555821.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAPNVh5d0jd=ks6WBnsheiAE394=31X963X+ZUG6x=ZZLHZ=jbQ@mail.gmail.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com> <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com> <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com> <8735qcgzdu.fsf@oldenburg.str.redhat.com> <1297400717.15316.1631295199656.JavaMail.zimbra@efficios.com> <CAPNVh5d0jd=ks6WBnsheiAE394=31X963X+ZUG6x=ZZLHZ=jbQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific
 data
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4125 (ZimbraWebClient - FF91 (Linux)/8.8.15_GA_4059)
Thread-Topic: Provide fast access to thread specific data
Thread-Index: cCPc3M0lsPgAFLR7AFntnYw+6ICTsA==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Sep 10, 2021, at 1:48 PM, Peter Oskolkov posk@google.com wrote:

> On Fri, Sep 10, 2021 at 10:33 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Sep 10, 2021, at 12:37 PM, Florian Weimer fweimer@redhat.com wrote:
>>
>> > * Peter Oskolkov:
>> >
>> >> In short, due to the need to read/write to the userspace from
>> >> non-sleepable contexts in the kernel it seems that we need to have some
>> >> form of per task/thread kernel/userspace shared memory that is pinned,
>> >> similar to what your sys_task_getshared does.
>> >
>> > In glibc, we'd also like to have this for PID and TID.  Eventually,
>> > rt_sigprocmask without kernel roundtrip in most cases would be very nice
>> > as well.  For performance and simplicity in userspace, it would be best
>> > if the memory region could be at the same offset from the TCB for all
>> > threads.
>> >
>> > For KTLS, the idea was that the auxiliary vector would contain size and
>> > alignment of the KTLS.  Userspace would reserve that memory, register it
>> > with the kernel like rseq (or the robust list pointers), and pass its
>> > address to the vDSO functions that need them.  The last part ensures
>> > that the vDSO functions do not need non-global data to determine the
>> > offset from the TCB.  Registration is still needed for the caches.
>> >
>> > I think previous discussions (in the KTLS and rseq context) did not have
>> > the pinning constraint.
>>
>> If this data is per-thread, and read from user-space, why is it relevant
>> to update this data from non-sleepable kernel context rather than update it as
>> needed on return-to-userspace ? When returning to userspace, sleeping due to a
>> page fault is entirely acceptable. This is what we currently do for rseq.
>>
>> In short, the data could be accessible from the task struct. Flags in the
>> task struct can let return-to-userspace know that it has outdated ktls
>> data. So before returning to userspace, the kernel can copy the relevant data
>> from the task struct to the shared memory area, without requiring any pinning.
>>
>> What am I missing ?
> 
> I can't speak about other use cases, but in the context of userspace
> scheduling, the information that a task has blocked in the kernel and
> is going to be removed from its runqueue cannot wait to be delivered
> to the userspace until the task wakes up, as the userspace scheduler
> needs to know of the even when it happened so that it can schedule
> another task in place of the blocked one. See the discussion here:
> 
> https://lore.kernel.org/lkml/CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com/

OK, just to confirm my understanding, so the use-case here is per-thread
state which can be read by other threads (in this case the userspace scheduler) ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
