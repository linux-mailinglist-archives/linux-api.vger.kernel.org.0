Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C3C446B58
	for <lists+linux-api@lfdr.de>; Sat,  6 Nov 2021 00:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhKEXvH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Nov 2021 19:51:07 -0400
Received: from esa.hc503-62.ca.iphmx.com ([216.71.131.47]:15715 "EHLO
        esa.hc503-62.ca.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbhKEXvG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 5 Nov 2021 19:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1636156106; x=1667692106;
  h=subject:to:cc:references:in-reply-to:from:message-id:
   date:mime-version:content-transfer-encoding;
  bh=0czp8HPimoHrpAqsPvqIllMPMs8etJtDQEcHMcp5MUU=;
  b=+djJ3CYv3sf/LJ+uLrsxAT5W6tiHdeFB/AVX0scsUkZ2QvGOm/HP/QHo
   M9zPqTF8/mFuA3tbpGDFzio2bY2IUr3xp7N1txafJwdy4iXfxcgoPhUP0
   gdbdBitSkbFy3qk4RIu4TtslKRN6iJVlu9QDc9khmI3Jm51I+T1+lYFTH
   w=;
IronPort-Data: A9a23:bpprgq8fh9aiqbfFR6w0DrUDO3+TJUtcMsCJ2f8bNWPcYEJGY0x3z
 mofDDzQaPyPZ2GmKdpybovlpElTsMfXxocxSgo5/HhEQiMRo6IpJzg4wmQcnc+2BpeeJK6yx
 5xGMrEsCuhqFieEzvuKGue99iYUOZllwtMQMcacUsxLbVYMpBwJ1FQzxIbVvqYy2YLgWlrV5
 IupyyHiEAbNNwBcYzN8B52r9UsHUMTa4Fv0aXRnOJinFHeH/5UkJMp3yZOZdhMUcaEIdgKOf
 Nsv+Znilo/vE7XBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XnRfTAKtao2zhojx/9
 DlCnYyNFxoyALTUouFDUxZfHw09ErcB24aSdBBTseTLp6HHW3DrxfNuCRlqe4Yf/OB6Cn0I6
 OMRND0XaheEwem/qF65YrA214Jyc4+xZNNZ5ioIITLxVJ7KRbjfT6jO5MRc0R8tmclSEOzaY
 M1fYjMHgBHoOUcQYgxMWcNWcOGAxST1Ug9foVCsnbM6/mbhyjZB06jUGY+AEjCNbYAP9qqCn
 UrE9mL/AjkVM9uQzTfD+XWp7sfGgyr0WYQ6G7q/+fpnxlaUwwQ7EBoNVnO0pv62jkP4UNVaQ
 2Qe4SchpKw23EOsSdb5Uluzp3vslgYeR/JfFOo17AzLwa3Riy6dB24ZXntIcN0OqsA7X3op2
 0WPktevAiZg2JWRSHSA5vKXoCm0NCw9M2APf2kHQBED7t2lp5s85jrLT9B+AOuwi/X2Bzj7w
 HaNtidWr7EOkckj1Kih+13DxTW2qfDhQgcr60PXV2S+4wVRYI+jepzu6F7H4PIGJ4GcJnGIv
 2ABs8yf6v0eSJ+KiSqBSfkMG7fv4OyKWBXAjlp/N50g8Smx4XmlfJAW7DwWDEJoNMkDUSXkb
 E/apUVa45o7FGOncaJtcaqwDcowxKTtHNijUerbBvJWZYNyXBeA5yIoZEn44oz2uEMrl6cyM
 ovdbNmlEXsADaNgijG/LwsA7YIWKukF7Tu7bfjGI96PiNJyuFb9pW85DWaz
Received: from connect.uwaterloo.ca (HELO connhm04.connect.uwaterloo.ca) ([129.97.208.43])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Nov 2021 19:48:22 -0400
Received: from [10.42.0.123] (10.32.137.240) by connhm04.connect.uwaterloo.ca
 (172.16.137.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 5
 Nov 2021 19:48:21 -0400
Subject: Re: [PATCH v0.8 3/6] sched/umcg: implement UMCG syscalls
To:     Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
CC:     Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
References: <20211104195804.83240-1-posk@google.com>
 <20211104195804.83240-4-posk@google.com>
In-Reply-To: <20211104195804.83240-4-posk@google.com>
From:   Thierry Delisle <tdelisle@uwaterloo.ca>
Message-ID: <ec84f37d-da30-8f03-3864-0c94078f6e21@uwaterloo.ca>
Date:   Fri, 5 Nov 2021 19:48:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.32.137.240]
X-ClientProxiedBy: connhm02.connect.uwaterloo.ca (172.16.137.66) To
 connhm04.connect.uwaterloo.ca (172.16.137.68)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2021-11-04 3:58 p.m., Peter Oskolkov wrote:
 > +/*
 > + * Try to wake up. May be called with preempt_disable set. May be called
 > + * cross-process.
 > + *
 > + * Note: umcg_ttwu succeeds even if ttwu fails: see wait/wake state
 > + *       ordering logic.
 > + */
 > +static int umcg_ttwu(u32 next_tid, int wake_flags)
 > +{
 > +    struct task_struct *next;
 > +
 > +    rcu_read_lock();
 > +    next = find_task_by_vpid(next_tid);
 > +    if (!next || !umcg_wakeup_allowed(next)) {
 > +        rcu_read_unlock();
 > +        return -ESRCH;
 > +    }
 > +
 > +    /* The result of ttwu below is ignored. */
 > +    try_to_wake_up(next, TASK_NORMAL, wake_flags);
 > +    rcu_read_unlock();
 > +
 > +    return 0;
 > +}

Doesn't try_to_wake_up return different values based on whether or not a 
task
was woken up? I think it could be useful to propagate that result instead of
always returning zero. Even if it only helps for debugging.



 > +static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
 > +{
 > +    u64 __user *node = &ut_worker->idle_workers_ptr;
 > +    u64 __user *head_ptr;
 > +    u64 first = (u64)node;
 > +    u64 head;
 > +
 > +    if (get_user(head, node) || !head)
 > +        return false;
 > +
 > +    head_ptr = (u64 __user *)head;
 > +
 > +    /* Mark the worker as pending. */
 > +    if (put_user(UMCG_IDLE_NODE_PENDING, node))
 > +        return false;
 > +
 > +    /* Make the head point to the worker. */
 > +    if (xchg_user_64(head_ptr, &first))
 > +        return false;
 > +
 > +    /* Make the worker point to the previous head. */
 > +    if (put_user(first, node))
 > +        return false;
 > +
 > +    return true;
 > +}

If the last two operation return false, whichever task tries to consume the
list could deadlock, depending on whether or not the ensuing
force_sig(SIGKILL); reaches the consuming task. Does the force_sig kill
the task or the entire process. Is it possible to consume this list from a
different process that shares the memory? I'm wondering if the last
two "return false" should attempt to retract the
UMCG_IDLE_NODE_PENDING.
