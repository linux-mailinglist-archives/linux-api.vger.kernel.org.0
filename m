Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25763C73E7
	for <lists+linux-api@lfdr.de>; Tue, 13 Jul 2021 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhGMQNc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Jul 2021 12:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbhGMQNb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Jul 2021 12:13:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADE3C0613DD;
        Tue, 13 Jul 2021 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zWIeSAOesk6PTxxPT2bnKuhH4ukKa6k6TAxEmP4Dn4E=; b=D+wBEy4C9FSPgE2ZMTD1JxSWN2
        wya20X3j40bsHZbPMX7I2YFWSNuLmMIdsAdHMtJ9rIQGo3xFfeu1mcAW/scNAfHTQrglmpkP0y9n5
        p8iLFw5qQs8B6EhIuaM8X3vfCx6lOXvJeINmnzvJiNBt7Mpf7aZaIoWUdpFogkSLMtFUeQBpF9HRK
        3bVdN0coqru0NTk52TGZnOwOfuSTR2jhcasXlNliDvBhJ+T/2bQwdaqTKacBY3bNUC/v+g+6L9PoE
        BbGKIYxcxsTGvZH0xrNXRTAu/DqoJWo36o0i0k6QNxQYzNjGd2K8AbHE3fbraFAiGb6xqVx5oZXjJ
        1s47ydow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3KzQ-00HBqf-Ee; Tue, 13 Jul 2021 16:10:32 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C0CF986904; Tue, 13 Jul 2021 18:10:31 +0200 (CEST)
Date:   Tue, 13 Jul 2021 18:10:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH 2/3 v0.2] sched/umcg: RFC: add userspace atomic
 helpers
Message-ID: <20210713161030.GA2591@worktop.programming.kicks-ass.net>
References: <20210708194638.128950-1-posk@google.com>
 <20210708194638.128950-3-posk@google.com>
 <YOgCdMWE9OXvqczk@hirez.programming.kicks-ass.net>
 <CAPNVh5fbDTNPCnSoQFia_VSuDcLsReGey+7iouK6V=p1S7v=sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5fbDTNPCnSoQFia_VSuDcLsReGey+7iouK6V=p1S7v=sg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 09, 2021 at 09:57:32AM -0700, Peter Oskolkov wrote:
> On Fri, Jul 9, 2021 at 1:02 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > This is horrible... Jann is absolutely right, you do not, *ever* do
> > userspace spinlocks. What's wrong with the trivial lockless single
> > linked list approach?.
> 
> I'm not sure how to get around the ABA problem with a lockless single
> linked list: https://en.wikipedia.org/wiki/ABA_problem

I'm familiar with the problem. I'm just not sure how we got there.

Last time we had umcg_blocked_ptr / umcg_runnable_ptr which were kernel
append, user clear single linked lists used for RUNNING->BLOCKED and
BLOCKED->RUNNABLE notifications.

But those seem gone, instead we now have idle_servers_ptr /
idle_workers_ptr. I've not yet fully digested things, but they seem to
implement some 'SMP' policy. Can we please forget about the whole SMP
thing for now and focus on getting the basics sorted?

So if we implement the bits outlined here:

  https://lore.kernel.org/linux-api/20210609125435.GA68187@worktop.programming.kicks-ass.net/
  https://lore.kernel.org/linux-api/YMJTyVVdylyHtkeW@hirez.programming.kicks-ass.net/

Then what is mising for full N:1 (aka UP) ?

One thing I've considered is that we might want to add u64 timestamps
for the various state transitions, such that userspace can compute
elapsed time which is useful for more dynamic scheduling policies.

Another is preemption; I'm thinking we can drive that with signals, but
that does give complications -- signals are super gross API wise.
Another method would be much preferred I think. We could add another
syscall which allows userspace (from eg. SIGALRM/SIGPROF/SIGVTALRM) to
force a worker to do a RUNNING->RUNNABLE transition and schedule back to
the server.


Then lets consider N:M (aka SMP). The basics of SMP is sharing work
between servers. For a large part userspace can already do that by
keeping a shared ready queue. Servers that go idle pick up a work,
re-assign it to themselves and go.

The pain-point seems to be *efficient* BLOCKED->RUNNABLE notifications
across servers. Inefficient options include the userspace servers
iterating all known other servers and trying to steal their
umcg_runnable_ptr and processing it. This is 'difficult' in that there
is no natural wakeup and hence letting a server do IDLE will increase
latency and destroy work concervance.

The alternative seems to be to let the kernel do the server iteration,
looking for a RUNNING one and using that umcg_runnable_ptr field and
kicking it. For that we can set up an immutable linked list between
struct umcg_task's, a circular single linked list that the kernel
iterates until it's back where it started. Then there is no dymaic
state.

Hmm?
