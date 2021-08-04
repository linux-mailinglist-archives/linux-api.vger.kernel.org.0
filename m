Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AACC3E0A3B
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhHDWFM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 18:05:12 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51]:8674 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhHDWFM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 18:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1628114699; x=1659650699;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version;
  bh=L9nJV2YSSJWQgya0qOZuNRNyTlFsERQnSEL4wHqvqwI=;
  b=DtRX71VVpT2PqDuVh4qrFL4Ch2rGWx/gVv99H+6yVDl53YjYXYQzh69e
   2YTHFRgPAEf3One9DKxrOu1sQAMaBcjVkx1KenOdAmBvsk0aXaJhmtkmR
   sLDPUikcuITz2O+zlJRUXfl24LLDreeU3tpwOT3jxrLAcur0BlW8NFOAz
   Q=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Aug 2021 18:04:57 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 18:04:57 -0400
To:     <posk@posk.io>
CC:     <avagin@google.com>, <bsegall@google.com>, <jannh@google.com>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <posk@google.com>, <tdelisle@uwaterloo.ca>, <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>
References: <20210801200617.623745-5-posk@google.com>
Subject: Re: [PATCH 4/4 v0.4] sched/umcg: RFC: implement UMCG syscalls
In-Reply-To: <20210801200617.623745-5-posk@google.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <3530714d-125b-e0f5-45b2-72695e2fc4ee@uwaterloo.ca>
Date:   Wed, 4 Aug 2021 18:04:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------80684090183B5F7F3FBA5261"
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm03.connect.uwaterloo.ca (172.16.137.67) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

--------------80684090183B5F7F3FBA5261
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

I have attached an atomic stack implementation I wrote. I believe it would
be applicable here. It is very similar except the kernel side no longer
needs a retry loop, the looping is moved to the user-space after the pop.
Using it instead of the code you have in enqueue_idle_worker means the
timeout is no longer needed.

 > - ``uint64_t idle_server_tid_ptr``: points to a pointer variable in the
 >   userspace that points to an idle server, i.e. a server in IDLE 
state waiting
 >   in sys_umcg_wait(); read-only; workers must have this field set; 
not used
 >   in servers.
 >
 >   When a worker's blocking operation in the kernel completes, the kernel
 >   changes the worker's state from ``BLOCKED`` to ``IDLE``, adds the 
worker
 >   to the list of idle workers, and checks whether
 >   ``*idle_server_tid_ptr`` is not zero. If not, the kernel tries to 
cmpxchg()
 >   it with zero; if cmpxchg() succeeds, the kernel will then wake the 
server.
 >   See `State transitions`_ below for more details.

In this case, I believe cmpxchg is not necessary and xchg suffices.


--------------80684090183B5F7F3FBA5261
Content-Type: text/x-csrc; charset="UTF-8"; name="atomic_stack.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="atomic_stack.c"

// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// For more information, please refer to <https://unlicense.org>

#include <assert.h>
#include <stdbool.h>

struct node {
	struct node * volatile next;
};

// Two sentinels, the values do not matter but must be different
// and unused by real addresses.
static struct node * const STACK_NO_VAL  = 0;
static struct node * const STACK_PENDING = 1;

// push a node to the stack
static inline void atomic_stack_push(struct node * volatile * head, struct node * n) {
	/* paranoid */ assert( n->next == STACK_NO_VAL );
	// Mark as pending so if it gets poped before the assignment to next
	// the reader knows this isn't necessarily the end of the list
	n->next = STACK_PENDING;

	// actually add the node to the list
	struct node * e = __atomic_exchange_n(head, n, __ATOMIC_SEQ_CST);

	// update the next field
	__atomic_store_n(&n->next, e, __ATOMIC_RELAXED);
}

// Pop all nodes from the stack
// Once popped, nodes should be iterate on using atomic_stack_next
static inline struct node * atomic_stack_pop_all(struct node * volatile * head) {
	// Steal the entire list for ourselves atomically
	// Nodes can still have pending next fields but everyone should agree
	// the nodes are ours.
	return __atomic_exchange_n(head, STACK_NO_VAL, __ATOMIC_SEQ_CST);
}

// from a given node, advance to the next node, waiting for pending nodes
// to be resolved
// if clear is set, the nodes that are advanced from are unlinked before the
// previous node is returned
static inline struct node * atomic_stack_next(struct node * n, bool clear) {
	// Wait until the next field is pending
	while(STACK_PENDING == __atomic_load_n(&n->next, __ATOMIC_RELAXED)) asm volatile("pause" : : :);

	// The field is no longer pending, any subsequent concurrent write to that field
	// should now be dependent on the next read.
	struct node * r = n->next;

	// For convenience, unlink the node if desired and return.
	if(clear) n->next = STACK_NO_VAL;
	return r;
}

--------------80684090183B5F7F3FBA5261--
