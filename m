Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC5393BED77
	for <lists+linux-api@lfdr.de>; Wed,  7 Jul 2021 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGGRzX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Jul 2021 13:55:23 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:61214 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbhGGRzW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Jul 2021 13:55:22 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2021 13:55:22 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1625680362; x=1657216362;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=mejge8f99UcFMQhRJaVzjkTNPr7rJMW1K2b4GV5Rlkk=;
  b=up0sGsm0IIVyupykV4Z87IsGQdd6cI2hE5a9gczAyCkfjOXPEYPy7i1q
   uRkpgAfHImzd6vl0+3Ws3bUu3hOvm3ymhLouMx6S52X3vX/+qeRN5gH0r
   sLZVH1/WxTS/tbS8XcnVwMKdNHL19w2khAK6NJZPBKvitSFTdpzzTFvFY
   M=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jul 2021 13:45:30 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 7 Jul
 2021 13:45:29 -0400
To:     <peterz@infradead.org>
CC:     <akpm@linux-foundation.org>, <avagin@google.com>,
        <bsegall@google.com>, <jnewsome@torproject.org>,
        <joel@joelfernandes.org>, <linux-api@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <pjt@google.com>, <posk@google.com>, <posk@posk.io>,
        <tglx@linutronix.de>, Peter Buhr <pabuhr@uwaterloo.ca>,
        Martin Karsten <mkarsten@uwaterloo.ca>
References: <YMJTyVVdylyHtkeW@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
In-Reply-To: <YMJTyVVdylyHtkeW@hirez.programming.kicks-ass.net>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <96842d90-7d3b-efac-fe1f-6e90b6a83ee5@uwaterloo.ca>
Date:   Wed, 7 Jul 2021 13:45:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm04.connect.uwaterloo.ca (172.16.137.68) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,
I wanted to way-in on this. I am one of the main developer's on the Cforall
programming language (https://cforall.uwaterloo.ca), which implements 
its own
M:N user-threading runtime. I want to state that this RFC is an interesting
feature, which we would be able to take advantage of immediately, assuming
performance and flexibility closely match state-of-the-art implementations.

Precisely, we would benefit from two aspects of User Managed Control Groups:

1. user-level threads would become regular pthreads, so that gdb, valgrind,
    ptrace and TLS works normally, etc.

2. The user-space scheduler can react on user-threads blocking in the 
kernel.

However, we would need to look at performance issues like thread 
creation and
context switch to know if your scheme is performant with user-level 
threading.
We are also conscious about use cases that involve a very high (100Ks to 
1Ms)
number of concurrent sessions and thus threads.

Note, our team published a comprehensive look at M:N threading in ACM
Sigmetrics 2020: https://doi.org/10.1145/3379483, which highlights the
expected performance of M:N threading, and another look at high-performance
control flow in SP&E 2021: 
https://onlinelibrary.wiley.com/doi/10.1002/spe.2925


  > > Yes, UNBLOCKED it a transitory state meaning the worker's blocking
  > > operation has completed, but the wake event hasn't been delivered to
  > > the userspace yet (and so the worker it not yet RUNNABLE)
  >
  > So if I understand the proposal correctly the only possible option is
  > something like:
  >
  >     for (;;) {
  >         next = user_sched_pick();
  >         if (next) {
  >             sys_umcg_run(next);
  >             continue;
  >         }
  >
  >         sys_umcg_poll(&next);
  >         if (next) {
  >             next->state = RUNNABLE;
  >             user_sched_enqueue(next);
  >         }
  >     }
  >
  > This seems incapable of implementing generic scheduling policies and has
  > a hard-coded FIFO policy.
  >
  > The poll() thing cannot differentiate between: 'find new task' and 'go
  > idle'. So you cannot keep running it until all new tasks are found.
  >
  > But you basically get to do a syscall to discover every new task, while
  > the other proposal gets you a user visible list of new tasks, no
  > syscalls needed at all.

I agree strongly with this comment, sys_umcg_poll() does not appear to be
flexible enough for generic policies. I also suspect it would become a
bottleneck in any SMP scheduler due to this central serial data-structure.


  > But you basically get to do a syscall to discover every new task, while
  > the other proposal gets you a user visible list of new tasks, no
  > syscalls needed at all.
  >
  > It's also not quite clear to me what you do about RUNNING->BLOCKED, how
  > does the userspace scheduler know to dequeue a task?

In the schedulers we have implemented, threads are dequeued *before* being
run. That is, the head of the queue is not the currently running thread.

If the currently running threads need to be in the scheduler data-structure,
I believe it can be dequeued immediately after sys_umcg_run() has returned.
More on this below.


  > My proposal gets you something like:
  >
  > [...]
  >
  > struct umcg_task {
  >    u32 umcg_status;            /* r/w */
  >    u32 umcg_server_tid;        /* r   */
  >    u32 umcg_next_tid;          /* r   */
  >    u32 umcg_tid;               /* r   */
  >    u64 umcg_blocked_ptr;       /*   w */
  >    u64 umcg_runnable_ptr;      /*   w */
  > };

I believe this approach may work, but could you elaborate on it? I 
wasn't able
to find a more complete description.

For example, I fail to see what purpose the umcg_blocked_ptr serves. 
When could
it contain anything other then a single element that is already pointed
to by "n" in the proposed loop? The only case I can come up with, is if a
worker thread tries to context switch directly to another worker thread. 
But in
that case, I do not know what state that second worker would need to be 
in for
this operation to be correct. Is the objective to allow the scheduler to be
invoked from worker threads?

Also, what is the purpose of umcg_status being writable by the user-space?
(I'm assuming status == state)? The code in sys_umcg_wait suggests it is for
managing potential out-of-order wakes and waits, but the kernel should 
be able
to handle them already, the same way FUTEX_WAKE and FUTEX_WAIT are handled.
When would these state transition not be handled by the kernel?

I would also point out that creating worker threads as regular pthreads and
then converting them to worker threads sounds less then ideal. It would
probably be preferable directly appended new worker threads to the
umcg_runnable_ptr list without scheduling them in the kernel. It makes the
placement of the umcg_task trickier but maintains a stronger M:N model.

Finally, I would recommend adding a 64-bit user pointer to umcg_task that is
neither read nor written from the kernel. These kind of fields are always
useful for implementers.

Thank you for your time,

Thierry

