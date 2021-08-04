Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDD83E0A23
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhHDVse (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 17:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbhHDVsd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 17:48:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B696C0613D5
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 14:48:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y7so4261155ljp.3
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 14:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p61PC16bUuso/Amoh3NYJjFdJNg2Vvrhz9NsPLJI2kI=;
        b=rvH4kgg0GfGFnEqKfX34PZtd4ehblaAK7jJ9hyMOOGjVH+azWRtio4V2hO76ltXawm
         I0l+U5lkfhILEgFrFhOdJTeWg0PQTfkwCjIapcPmvhX7ztYsdP73TtGkdGjd8oxtDa3z
         7AXLy8EEvJyiJYDX5NA8ik/RnHMGGKMh+5qV7rzmdz1DQncFm+SdXJTPs46Aj66RFWYv
         rnDHtR7lWptKqcCbkeEiPh7DbVVOrNlL0bGh45HkONt82MA8ndGc2tlEcpXEGKEuiUr6
         ud42MPgiwPzmCXvss7OVmDfvE3zkTgQAX+hn0I5kTHVP2WxXNw4a4KPDc/fn9G+C/rEh
         OUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p61PC16bUuso/Amoh3NYJjFdJNg2Vvrhz9NsPLJI2kI=;
        b=aS84BXDHXZB9WFMtf/Tnv/IpRcfIlkjyl2r+Siues5xKMEGTBkmsRlEGa1XSz0GcVv
         mle6nbrUxe1uqK5IrUeW2D15E4b1+Ng/cUgVa4qxGbGvVXaDyEDWesV6HBNA3TZtu5bi
         VWdcFhN4vXCLtZM+NNMt4hO4+LIxe/XRpf7DIxYZ21Sl+qJlS/7Brf7UV9R5pJAz1LQq
         +2hlR1OPl9t5/FyEo/LWg8pQh5dBjWJnbNiCo4PeI/Obc0kkZyw/csskZmW6F8yKfJ82
         QGxiFvTFff5IcTzJYnBwKusNtLcaKHlfFPoqnE/ocUFD6LOAbCLQUEoLpPAa5FyTsPwZ
         4zKQ==
X-Gm-Message-State: AOAM531nCeEmGvAaaEGEbvk59WFIVPjLbwo9mRUsjzlQ46ozgxiO0r7v
        LDIiBjo6jOsj/pIHw9y4ammWqosbEqszm6pb7lIjUQ==
X-Google-Smtp-Source: ABdhPJwGgHKbETvILP+pVn9YEjSNQhACoXNI8lG+ruWmThNwylH3Op3qp1odulRPt5jvlWyOgQyUV9eqUIcRkkoQkZs=
X-Received: by 2002:a2e:95cc:: with SMTP id y12mr859265ljh.387.1628113697696;
 Wed, 04 Aug 2021 14:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210801200617.623745-4-posk@google.com> <605a9d20-8fe4-ec9a-97b4-bc6db38da62f@uwaterloo.ca>
In-Reply-To: <605a9d20-8fe4-ec9a-97b4-bc6db38da62f@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Wed, 4 Aug 2021 14:48:06 -0700
Message-ID: <CAPNVh5fjcJHKJOuQP+UebpYf+GBMDkj5me1c=EzS9cpDSTbzfA@mail.gmail.com>
Subject: Re: [PATCH 3/4 v0.4] sched/umcg: add Documentation/userspace-api/umcg.rst
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     posk@posk.io, avagin@google.com, bsegall@google.com,
        jannh@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, pjt@google.com, tglx@linutronix.de,
        Peter Buhr <pabuhr@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 4, 2021 at 12:13 PM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
> These state transition descriptions are very helpful, but what is not
> clear is the details of these transitions when there are concurrent
> wake/waits. I do not know enough about the kernel code to be able to
> read the implementation and answer my own questions.
>
> For example, imagine two worker threads W1 and W2. W1 adds itself to a
> concurrent list and calls umcg_wait(next_tid = 0). W2 pops from the list
> and calls umcg_wait(UMCG_WAIT_WAKE_ONLY | UMCG_WAIT_WF_CURRENT_CPU) on the
> popped worker, W1 in this example.

All _umcg_ state changes here happen in the userspace before
sys_umcg_wait() is called. So:

W1: cmpxchg W1:RUNNING => W1:IDLE
 - if OK, call sys_umcg_wait()
 - if failed, do something else (notes below)

W2: cmpxchg W1:IDLE => W1:RUNNING
 - if OK, lock itself, set W2:next_tid to W1, call sys_umcg_wait()
(will not block nor spin), restore next_tid and state/unlock upon
syscall return
 - if failed, do something else

So assuming the cmpxchg() calls succeeded, sys_umcg_wait() will be called.

W1 sys_umcg_wait(): (W1 sleeping):
- (1) mark itself as TASK_INTERRUPTIBLE (sleeping)
- (2) check _umcg_ state
  - (a) if UMCG_RUNNING, mark itself as TASK_RUNNING, return to userspace
  - (b) if still UMCG_IDLE, sleep
- (3) upon wakeup, go to step (1)

W2 sys_umcg_wait(): (wake W1):
- call try_to_wake_up(W1): if W1 is INTERRUPTIBLE, change it to
TASK_RUNNING, wake
- return

Note the ordering and interplay of UMCG state changes
(UMCG_IDLE/UMCG_RUNNING) and TASK state changes
(TASK_INTERRUPTIBLE/TASK_RUNNING).

As you can see, W2 does not block nor spin. W1 will either catch
_umcg_ state change to UMCG_RUNNING and abort, or ttwu() will wake it
_after_ it is marked as UMCG_RUNNING.

Now what happens if cmpxchg() calls above fail? That means that W1 is
still running when W2 tries to change its state RUNNING => IDLE. This
is a race in the userspace, and two options are available:
- the userspace spins waiting for W1 to become IDLE (note that the
userspace spins, not the kernel)
- the userspace "queues the wakeup" and returns; the sleeper (W1) sees
wakeup_queued and does not go to sleep; this is the solution I
have/use. See the previous version here:
https://lore.kernel.org/patchwork/patch/1433971/, search for
UMCG_TF_WAKEUP_QUEUED.

In the current version 0.4 WAKEUP_QUEUED is a purely userspace flag,
so it is not documented in the _kernel API_ doc. I'll post the
userspace parts (libumcg, selftests) a bit later. In short, wait/wake
races do not result in spinning, and sometimes even elide syscalls by
using WAKEUP_QUEUED userspace state flag.

>
> If W1 calls umcg_wait first, W2 context-switches to W1 and W2's state
> changes to IDLE. My understanding is that wake detection/block does not
> apply to this case.
>
> If W2 calls umcg_wait first, what happens? I can imagine two different
> behaviour in this case:
>
> 1. W2 waits for W1 to call umcg_wait, by spinning or blocking, and then
>     execution proceed like the first ordering.
>
> 2. W2 sets W1's state to RUNNING. When W1 eventually calls umcg_wait, it
>     simply notices the state change and returns without context-switching.
>     In this case, W1 is not migrated to W2's CPU.
>
> Behaviour 1 makes me uncomfortable since it means umcg_wait must wait for
> cooperation that potentially never comes.
>
> But in Behaviour 2, the state of W2 after both calls to umcg_wait is not
> clear to me, either. I could imagine that W2 is set to IDLE, but since W1
> is not migrated, W2 could also simply be left RUNNING.
>
> Which behaviour is correct and in what state does W2 end up?

W2 will always end up RUNNING, as everything here is about W1. W2 will
never sleep nor spin. Just a couple of atomic ops and maybe a syscall
that does the same.

>
> Thierry
>
