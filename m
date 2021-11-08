Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CEF447920
	for <lists+linux-api@lfdr.de>; Mon,  8 Nov 2021 05:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbhKHEL7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Nov 2021 23:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbhKHEL7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Nov 2021 23:11:59 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB519C061714
        for <linux-api@vger.kernel.org>; Sun,  7 Nov 2021 20:09:15 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id b17so29057973uas.0
        for <linux-api@vger.kernel.org>; Sun, 07 Nov 2021 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ht1a7BHorlhsE8dC2GuUzDtj79AIkNJ784TbJlxLVrc=;
        b=hEpZGtyPHSeODH2+z3tM2pL2kZdsRw6MkBcSLD1h50yio+oDm2Cwoy97zfiHNmYEvk
         haP5bd0VlBqkKPQmgtpp2mgMPdM+Jh3dmFSmMXCh9tLXao5vu1BLa++B77FnkohwBEQk
         E3y5nsN70+m2w0lTYZzaUPYlxC1UkkkqMMnow0D+fvRi6tuR47ETSDJXJWME4zBbAwGn
         /fX14irruZ9MzIUm5GRhmTV7tCdw+3/x6FkdtXUa8+CT8ZXyRg+InwsNdQTAKAxpM4ao
         CLdAbav/wyHeHVbQswqb0lLCH7XMaMFbhkM2DC1u9dde7S1o3VKm8CHYCzdj9ijM0JN1
         TUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ht1a7BHorlhsE8dC2GuUzDtj79AIkNJ784TbJlxLVrc=;
        b=ol9MCu+JYk/N/ChXLaH+SDtV3JXNesq9JSaN+5YbRpmjGTt8B8rjYtanN2G7I4JhVz
         tEJQbCKTjhWmKuKLxj8wqq7kdnAesbQsdISHVOeVAbpDPtnDrWbUX6DGTPNFmGnC35vK
         wJa8KfXplp4XRERFUvtYyzW345Df9LYw+CLYQrMtm082BD8j9GWG2X9LguyDltS011RU
         LBl8xDFCYYluR9zC/B1VjDGDZrmJyRX7wfIIXTdPaEI1DujvfivPnttCDsC9XWwfjjU2
         TOOKqFKh7X5dBUp7k6gxswLrTkzIwWKbyXlQU2XnWz9678zLPJZdkGSJqgGFyATNxnU8
         2LZA==
X-Gm-Message-State: AOAM531y33jNAOqJJRUwnDp6Qe/C2kCXgyhU85a/K9sDNU/fig6hpUiK
        sjQxOho853wMRUioFlcEeezYZsXuFFPZXSH+H4sBmw==
X-Google-Smtp-Source: ABdhPJy4sFP5Rd4WqLzOYU+KqsxywfbN2kHNY7KPnD9rSyvbVDu+X+nYjpnPfnRxztF3BGa/RKHiuhaerSgi0/5fPBI=
X-Received: by 2002:a05:6102:dce:: with SMTP id e14mr48258555vst.21.1636344554818;
 Sun, 07 Nov 2021 20:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20211104195804.83240-1-posk@google.com> <20211104195804.83240-4-posk@google.com>
 <ec84f37d-da30-8f03-3864-0c94078f6e21@uwaterloo.ca>
In-Reply-To: <ec84f37d-da30-8f03-3864-0c94078f6e21@uwaterloo.ca>
From:   Peter Oskolkov <posk@posk.io>
Date:   Sun, 7 Nov 2021 20:09:04 -0800
Message-ID: <CAFTs51XU1rKqSscdFK69RUCtaKrLJ1r5pdXSBJ1qc3=ZMNorBw@mail.gmail.com>
Subject: Re: [PATCH v0.8 3/6] sched/umcg: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 5, 2021 at 4:48 PM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
> On 2021-11-04 3:58 p.m., Peter Oskolkov wrote:
>  > +/*
>  > + * Try to wake up. May be called with preempt_disable set. May be called
>  > + * cross-process.
>  > + *
>  > + * Note: umcg_ttwu succeeds even if ttwu fails: see wait/wake state
>  > + *       ordering logic.
>  > + */
>  > +static int umcg_ttwu(u32 next_tid, int wake_flags)
>  > +{
>  > +    struct task_struct *next;
>  > +
>  > +    rcu_read_lock();
>  > +    next = find_task_by_vpid(next_tid);
>  > +    if (!next || !umcg_wakeup_allowed(next)) {
>  > +        rcu_read_unlock();
>  > +        return -ESRCH;
>  > +    }
>  > +
>  > +    /* The result of ttwu below is ignored. */
>  > +    try_to_wake_up(next, TASK_NORMAL, wake_flags);
>  > +    rcu_read_unlock();
>  > +
>  > +    return 0;
>  > +}
>
> Doesn't try_to_wake_up return different values based on whether or not a
> task
> was woken up? I think it could be useful to propagate that result instead of
> always returning zero. Even if it only helps for debugging.
>

The protocol is to mark the wakee as UMCG_TASK_RUNNING and call ttwu;
if you look at umcg_idle_loop(), you will see that the ordering is set
so that the wakee will indeed either wake or not go to sleep at all,
regardless of whether ttwu succeeds. So in terms of correctness we do
not need to check ttwu result; returning anything different here "for
debugging"? Maybe. If/when this is merged, feel free to send a patch.
Or maybe I'll add this in a next patchset version...

>
>
>  > +static bool enqueue_idle_worker(struct umcg_task __user *ut_worker)
>  > +{
>  > +    u64 __user *node = &ut_worker->idle_workers_ptr;
>  > +    u64 __user *head_ptr;
>  > +    u64 first = (u64)node;
>  > +    u64 head;
>  > +
>  > +    if (get_user(head, node) || !head)
>  > +        return false;
>  > +
>  > +    head_ptr = (u64 __user *)head;
>  > +
>  > +    /* Mark the worker as pending. */
>  > +    if (put_user(UMCG_IDLE_NODE_PENDING, node))
>  > +        return false;
>  > +
>  > +    /* Make the head point to the worker. */
>  > +    if (xchg_user_64(head_ptr, &first))
>  > +        return false;
>  > +
>  > +    /* Make the worker point to the previous head. */
>  > +    if (put_user(first, node))
>  > +        return false;
>  > +
>  > +    return true;
>  > +}
>
> If the last two operation return false, whichever task tries to consume the
> list could deadlock, depending on whether or not the ensuing
> force_sig(SIGKILL); reaches the consuming task. Does the force_sig kill
> the task or the entire process. Is it possible to consume this list from a
> different process that shares the memory? I'm wondering if the last
> two "return false" should attempt to retract the
> UMCG_IDLE_NODE_PENDING.

The function will return false only on a memory access error, and the
whole process will be killed as a result. At least this is the
intention. Do you think the code does anything different?
