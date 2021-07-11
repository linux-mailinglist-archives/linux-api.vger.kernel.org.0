Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8245C3C3EC6
	for <lists+linux-api@lfdr.de>; Sun, 11 Jul 2021 20:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbhGKSje (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 11 Jul 2021 14:39:34 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.135.51]:33353 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhGKSje (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 11 Jul 2021 14:39:34 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Jul 2021 14:39:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1626028607; x=1657564607;
  h=to:cc:references:subject:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=l8PuGoPMNTSs7wgUV+e+eaDnUAK/vLI5wMbtdje7hW0=;
  b=DsaZjNb9vTQSu5f0at8dQzVNSDA83XCN3LYl5q7zH8dTUFA/qyfYqqt/
   oQqg/icZERZqG7jom9oogz2+kJzTnDDaUlFJ0oVUOTIoTrgp5ERLH6Oj/
   xUZu6X96yjIJOhSrBSWb/TfWeL/yORyY2CfuzZg+SLK0PQNvi7yNuzckL
   w=;
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jul 2021 14:29:40 -0400
Received: from [10.42.0.123] (10.32.139.159) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Sun, 11
 Jul 2021 14:29:39 -0400
To:     <posk@posk.io>
CC:     <avagin@google.com>, <bsegall@google.com>, <jannh@google.com>,
        <jnewsome@torproject.org>, <joel@joelfernandes.org>,
        <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <posk@google.com>, <tglx@linutronix.de>,
        Peter Buhr <pabuhr@uwaterloo.ca>,
        Martin Karsten <mkarsten@uwaterloo.ca>
References: <20210708194638.128950-4-posk@google.com>
Subject: Re: [RFC PATCH 3/3 v0.2] sched/umcg: RFC: implement UMCG syscalls
In-Reply-To: <20210708194638.128950-4-posk@google.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <bb30216c-4339-2703-9d87-9326af86a7b0@uwaterloo.ca>
Date:   Sun, 11 Jul 2021 14:29:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.139.159]
X-ClientProxiedBy: connhm03.connect.uwaterloo.ca (172.16.137.67) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

 > Let's move the discussion to the new thread.

I'm happy to start a new thread. I'm re-responding to my last post 
because many
of my questions are still unanswered.

 > + * State transitions:
 > + *
 > + * RUNNING => IDLE:   the current RUNNING task becomes IDLE by calling
 > + *                    sys_umcg_wait();
 >
 > [...]
 >
 > +/**
 > + * enum umcg_wait_flag - flags to pass to sys_umcg_wait
 > + * @UMCG_WAIT_WAKE_ONLY: wake @self->next_tid, don't put @self to sleep;
 > + * @UMCG_WF_CURRENT_CPU: wake @self->next_tid on the current CPU
 > + *                       (use WF_CURRENT_CPU); @UMCG_WAIT_WAKE_ONLY 
must be set.
 > + */
 > +enum umcg_wait_flag {
 > +    UMCG_WAIT_WAKE_ONLY = 1,
 > +    UMCG_WF_CURRENT_CPU = 2,
 > +};

What is the purpose of using sys_umcg_wait without next_tid or with
UMCG_WAIT_WAKE_ONLY? It looks like Java's park/unpark semantics to me, 
that is
worker threads can use this for synchronization and mutual exclusion. In 
this
case, how do these compare to using FUTEX_WAIT/FUTEX_WAKE?


 > +struct umcg_task {
 > [...]
 > +    /**
 > +     * @server_tid: the TID of the server UMCG task that should be
 > +     *              woken when this WORKER becomes BLOCKED. Can be zero.
 > +     *
 > +     *              If this is a UMCG server, @server_tid should
 > +     *              contain the TID of @self - it will be used to find
 > +     *              the task_struct to wake when pulled from
 > +     *              @idle_servers.
 > +     *
 > +     * Read-only for the kernel, read/write for the userspace.
 > +     */
 > +    uint32_t    server_tid;        /* r   */
 > [...]
 > +    /**
 > +     * @idle_servers_ptr: a single-linked list pointing to the list
 > +     *                    of idle servers. Can be NULL.
 > +     *
 > +     * Readable/writable by both the kernel and the userspace: the
 > +     * userspace adds items to the list, the kernel removes them.
 > +     *
 > +     * TODO: describe how the list works.
 > +     */
 > +    uint64_t    idle_servers_ptr;    /* r/w */
 > [...]
 > +} __attribute__((packed, aligned(8 * sizeof(__u64))));

 From the comments and by elimination, I'm guessing that idle_servers_ptr is
somehow used by servers to block until some worker threads become idle. 
However,
I do not understand how the userspace is expected to use it. I also do not
understand if these link fields form a stack or a queue and where is the 
head.


 > +/**
 > + * sys_umcg_ctl: (un)register a task as a UMCG task.
 > + * @flags:       ORed values from enum umcg_ctl_flag; see below;
 > + * @self:        a pointer to struct umcg_task that describes this
 > + *               task and governs the behavior of sys_umcg_wait if
 > + *               registering; must be NULL if unregistering.
 > + *
 > + * @flags & UMCG_CTL_REGISTER: register a UMCG task:
 > + *         UMCG workers:
 > + *              - self->state must be UMCG_TASK_IDLE
 > + *              - @flags & UMCG_CTL_WORKER
 > + *
 > + *         If the conditions above are met, sys_umcg_ctl() 
immediately returns
 > + *         if the registered task is a RUNNING server or basic task; 
an IDLE
 > + *         worker will be added to idle_workers_ptr, and the worker 
put to
 > + *         sleep; an idle server from idle_servers_ptr will be 
woken, if any.

This approach to creating UMCG workers concerns me a little. My 
understanding
is that in general, the number of servers controls the amount of parallelism
in the program. But in the case of creating new UMCG workers, the new 
threads
only respect the M:N threading model after sys_umcg_ctl has blocked. 
What does
this mean for applications that create thousands of short lived tasks? Are
users expcted to create pools of reusable UMCG workers?


I would suggest adding at least one uint64_t field to the struct 
umcg_task that
is left as-is by the kernel. This allows implementers of user-space
schedulers to add scheduler specific data structures to the threads without
needing some kind of table on the side.

