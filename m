Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44723C658D
	for <lists+linux-api@lfdr.de>; Mon, 12 Jul 2021 23:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhGLVrM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jul 2021 17:47:12 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:55736 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGLVrM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jul 2021 17:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1626126263; x=1657662263;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=seij5sVjCpiZ5ThWMz7niqAvKuxJMkBdQqYc7ftubO4=;
  b=C30j/v9CzCtrUJvxKP1sQN4vMa3ayY0szBvfzDXZSDhnWJaB33cA8AbH
   QIpDfEZ0M8OAmFde95AnFao8E4Z1D5TM3qt+iwX0b5OsY0Jac21hceMrA
   HshPYpdguDOlC6G1gqi77wGst92/QaN4+/DUhn2Dd1tRrfk1phA+V/AMQ
   k=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Jul 2021 17:44:19 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 12
 Jul 2021 17:44:18 -0400
To:     <posk@google.com>
CC:     <avagin@google.com>, <bsegall@google.com>, <jannh@google.com>,
        <jnewsome@torproject.org>, <joel@joelfernandes.org>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <mkarsten@uwaterloo.ca>, <pabuhr@uwaterloo.ca>,
        <peterz@infradead.org>, <pjt@google.com>, <posk@posk.io>,
        <tdelisle@uwaterloo.ca>, <tglx@linutronix.de>
References: <CAPNVh5f3H7Gor-Dph7=2jAdme-4mRfCCb0gv=wjgHQtd7Cad=Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3 v0.2] sched/umcg: RFC: implement UMCG syscalls
In-Reply-To: <CAPNVh5f3H7Gor-Dph7=2jAdme-4mRfCCb0gv=wjgHQtd7Cad=Q@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <acad5960-30b2-3693-9117-e0b054ee97a7@uwaterloo.ca>
Date:   Mon, 12 Jul 2021 17:44:18 -0400
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

 > sys_umcg_wait without next_tid puts the task in UMCG_IDLE state; wake
 > wakes it. These are standard sched operations. If they are emulated
 > via futexes, fast context switching will require something like
 > FUTEX_SWAP that was NACKed last year.

I understand these wait and wake semantics and the need for the fast
context-switch(swap). As I see it, you need 3 operations:

- SWAP: context-switch directly to a different thread, no scheduler involved
- WAIT: block current thread, go back to server thread
- WAKE: unblock target thread, add it to scheduler, e.g. through
         idle_workers_ptr

There is no existing syscalls to handle SWAP, so I agree sys_umcg_wait is
needed for this to work.

However, there already exists sys_futex to handle WAIT and WAKE. When a 
worker
calls either sys_futex WAIT or sys_umcg_wait next_tid == NULL, in both case
the worker will block, SWAP to the server and wait for FUTEX_WAKE,
UMCG_WAIT_WAKE_ONLY respectively. It's not obvious to me that there 
would be
performance difference and the semantics seem to be the same to me.

So what I am asking is: is UMCG_WAIT_WAKE_ONLY needed?

Is the idea to support workers directly context-switching among each other,
without involving server threads and without going through idle_servers_ptr?

If so, can you explain some of the intended state transitions in this case.


 > > However, I do not understand how the userspace is expected to use 
it. I also
 > > do not understand if these link fields form a stack or a queue and 
where is
 > > the head.
 >
 > When a server has nothing to do (no work to run), it is put into IDLE
 > state and added to the list. The kernel wakes an IDLE server if a
 > blocked worker unblocks.

 From the code in umcg_wq_worker_running (Step 3), I am guessing users are
expected to provide a global head somewhere in memory and
umcg_task.idle_servers_ptr points to the head of the list for all workers.
Servers are then added in user space using atomic_stack_push_user. Is this
correct? I did not find any documentation on the list head.

I like the idea that each worker thread points to a given list, it 
allows the
possibility for separate containers with their own independent servers, 
workers
and scheduling. However, it seems that the list itself could be implemented
using existing kernel APIs, for example a futex or an event fd. Like so:

struct umcg_task {
      [...]

      /**
       * @idle_futex_ptr: pointer to a futex user for idle server threads.
       *
       * When waking a worker, the kernel decrements the pointed to 
futex value
       * if it is non-zero and wakes a server if the decrement occurred.
       *
       * Server threads that have no work to do should increment the futex
       * value and FUTEX_WAIT
       */
      uint64_t    idle_futex_ptr;    /* r/w */

      [...]
} __attribute__((packed, aligned(8 * sizeof(__u64))));

I believe the futex approach, like the list, has the advantage that when 
there
are no idle servers, checking the list requires no locking. I don't know if
that can be achieved with eventfd.

