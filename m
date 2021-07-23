Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B83D4084
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 21:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhGWSZj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 14:25:39 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51]:37027 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhGWSZj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 14:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1627067172; x=1658603172;
  h=subject:to:cc:references:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=zZZQonlNSBB99BtqX/NXnblHqjrWwtAj9PnBhLitA7Q=;
  b=8Mf1FR/1LviLjBgz1C0eBgau77x6+rryNx+iyb/lD/vQm85mxx1enHht
   /49QFyjWdwbsdzsH5t1jF9FAromT9Ow3Pt1nRqC4UesleEKHDc8z9jE8C
   QNHfaBODhaejIagJfpKAzRxKISQXr0QoQotjr3QD5Th4ugj1N7NKNSfjB
   0=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jul 2021 15:06:10 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 23
 Jul 2021 15:06:10 -0400
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Peter Oskolkov <posk@google.com>
CC:     Peter Oskolkov <posk@posk.io>, Andrei Vagin <avagin@google.com>,
        Ben Segall <bsegall@google.com>, Jann Horn <jannh@google.com>,
        Jim Newsome <jnewsome@torproject.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
References: <20210716184719.269033-5-posk@google.com>
 <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
 <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
 <c8ea4892-51e5-0dc2-86c6-b705e8a23cde@uwaterloo.ca>
 <CAFTs51XW0H1UJKv0t2tq+5VLfgPMtZmDcxQVUQ5HkgDe38jHpw@mail.gmail.com>
 <5790661b-869c-68bd-86fa-62f580e84be1@uwaterloo.ca>
 <CAPNVh5ecidSmKFW2ck0ASw44GUnP20m7baSP1+KXnGfkM8FLLg@mail.gmail.com>
In-Reply-To: <CAPNVh5ecidSmKFW2ck0ASw44GUnP20m7baSP1+KXnGfkM8FLLg@mail.gmail.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <e1403574-1151-8399-0ce9-bb80852ec56b@uwaterloo.ca>
Date:   Fri, 23 Jul 2021 15:06:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm02.connect.uwaterloo.ca (172.16.137.66) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 > In my tests reclaimed nodes have their next pointers immediately set
 > to point to the list head. If the kernel gets a node with its @next
 > pointing to something else, then yes, things break down (the kernel
 > kills the process); this has happened occasionally when I had a bug in
 > the userspace code.

I believe that approach is fine for production, but for testing it may
not detect some bugs. For example, it may not detect the race I detail
below.


 > Could you, please, provide a bit more details on when/how the race can
 > happen? Servers add themselves to the list, so there can be no races
 > there (servers going idle: add-to-the-list; wait; gc (under a lock);
 > restore @next; do stuff).

I believe the race can happen if the kernel attempts to wake an idle
server concurrently with a call to gc.

Here's an example list where the head points to a list of 3 items denoted
A, B, C, and the second character denotes whether the element is marked
for deletion: 'x' means marked, 'o' means unmarked. 'H' denotes the head.

         H -> Ax -> Bo -> Co

Now, atomic_stack_gc is expected to unlink node 'A' so it can be reclaimed,
leading to "H -> Bo -> Co". Once 'A' is unlinked it can be either deleted
or pushed back on the list at a later time.

In the following snippet of the atomic_stack_pop function (trimmed for
space):

      static inline uint64_t* atomic_stack_pop(uint64_t *head)
      {
          uint64_t *curr = (uint64_t *)atomic_load_explicit(head);

          do {
              if (!curr) return NULL;

              // <--- Pause
              uint64_t next = atomic_load_explicit(curr);

At the location marked "<--- Pause", assume the code has the address of
node 'A' and is about to dereference it to get the address of node 'B'. If
the thread running this code pauses for any reason, a different CPU can
run atomic_stack_gc and delete node 'A'. At that point, the pop function
resumes and dereferences a node that no longer exists.

The thread pause can have many causes; in user-space, preemption is the
most obvious, but hardware interrupts or even last-level cache misses can
cause enough of a slowdown for this to happen.

The fundamental problem is that there is nothing to prevent multiple
threads from manipulating the list AND concurrently attempting to reclaim
nodes. As far as I know, this requires locking or a lock-free memory
reclamation scheme where nodes are unlinked and then consensus is
established that no thread can reach the unlinked data before reclaiming
the unlinked node. While both approaches are do-able, it requires extra
communication between the kernel and user-space.

In general, the kernel needs to be robust to misbehaving users and their
concurrent operations. Hence, I would be wary of any looping in kernel
involving an atomic operation, which requires cooperation among threads
to avoid starvation.


 > Workers are trickier, as they can be woken by signals and then block
 > again, but stray signals are so bad here that I'm thinking of actually
 > not letting sleeping workers wake on signals. Other than signals
 > waking queued/unqueued idle workers, are there any other potential
 > races here?

Timeouts on blocked threads is virtually the same as a signal I think. I
can see that both could lead to attempts at waking workers that are not
blocked.

I haven't looked too much at the state transitions yet. I think the
guarantees offered by the two lists will result in potential races in the
rest of the code.

Thierry

