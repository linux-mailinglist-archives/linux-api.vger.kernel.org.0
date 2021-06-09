Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9123A150E
	for <lists+linux-api@lfdr.de>; Wed,  9 Jun 2021 15:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhFINEQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 09:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhFINEP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Jun 2021 09:04:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA10C061574;
        Wed,  9 Jun 2021 06:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hAerKgjIq4kS6ywfhPEqKwcMuutGzkYxDRK8aN/LbKc=; b=e6XPOybtBMWkskNlTkinyrzGq3
        zK59VJwsz7R4qFITyiIJ+XekQShaB0xFryNoU4WJycnF6o4C+oCCKj9esgE07OGfjCR2cxs3HgEwY
        rfqJITMByfLpH5WLnr4HZaxcYRNMI3K/Syn+gi5QrLPVaHT6MKkuR4eDhPbqkNhOqqiPneffmB0HL
        gbhy5/1dxcXJaPGgUsDHwggAYXl+5mtIBzG7bFu3L99WaIVgVE8bfoG8JiTbYCkps4NnzxqOjnvas
        RQGUgPsybamxniloaGAOkdYcyPVd/X5gpkwNC0GyO4JLFxcpm+J5TiyGa1tVLnSGWhl42qeijfouU
        mqLFdPCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lqxpQ-000WJA-Gc; Wed, 09 Jun 2021 13:01:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0229E9867D0; Wed,  9 Jun 2021 15:01:03 +0200 (CEST)
Date:   Wed, 9 Jun 2021 15:01:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Peter Oskolkov <posk@google.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Subject: Re: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
Message-ID: <20210609130103.GB68187@worktop.programming.kicks-ass.net>
References: <20210520183614.1227046-1-posk@google.com>
 <20210520183614.1227046-5-posk@google.com>
 <CAG48ez3Ur61rpOZduQRFabB9R=RbSin9Th+=0=z9FUpcZ21C=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3Ur61rpOZduQRFabB9R=RbSin9Th+=0=z9FUpcZ21C=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 11:33:14PM +0200, Jann Horn wrote:
> >  SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
> >  {
> > -       return -ENOSYS;
> > +       struct umcg_task_data *next_utd;
> > +       struct task_struct *next;
> > +       int ret = -EINVAL;
> > +
> > +       if (!next_tid)
> > +               return -EINVAL;
> > +       if (flags)
> > +               return -EINVAL;
> > +
> > +       next = find_get_task_by_vpid(next_tid);
> > +       if (!next)
> > +               return -ESRCH;
> > +       rcu_read_lock();
> 
> Wouldn't it be more efficient to replace the last 4 lines with the following?
> 
> rcu_read_lock();
> next = find_task_by_vpid(next_tid);
> if (!next) {
>   err = -ESRCH;
>   goto out;
> }

This wakeup crud needs to modify the umcg->state, which is a user
variable. That can't be done under RCU. Weirdly the proposed code
doesn't actually do any of that for undocumented raisins :/

> Then you don't need to use refcounting here...
> 
> > +       next_utd = rcu_dereference(next->umcg_task_data);
> > +       if (!next_utd)
> > +               goto out;
> > +
> > +       if (!READ_ONCE(next_utd->in_wait)) {
> > +               ret = -EAGAIN;
> > +               goto out;
> > +       }
> > +
> > +       ret = wake_up_process(next);
> > +       put_task_struct(next);
> 
> ... and you'd be able to drop this put_task_struct(), too.
> 
> > +       if (ret)
> > +               ret = 0;
> > +       else
> > +               ret = -EAGAIN;
> > +
> > +out:
> > +       rcu_read_unlock();
> > +       return ret;
> >  }
> >
> >  /**
> > @@ -139,5 +325,44 @@ SYSCALL_DEFINE2(umcg_wake, u32, flags, u32, next_tid)
> >  SYSCALL_DEFINE4(umcg_swap, u32, wake_flags, u32, next_tid, u32, wait_flags,
> >                 const struct __kernel_timespec __user *, timeout)
> >  {
> > -       return -ENOSYS;
> > +       struct umcg_task_data *curr_utd;
> > +       struct umcg_task_data *next_utd;
> > +       struct task_struct *next;
> > +       int ret = -EINVAL;
> > +
> > +       rcu_read_lock();
> > +       curr_utd = rcu_dereference(current->umcg_task_data);
> > +
> > +       if (!next_tid || wake_flags || wait_flags || !curr_utd)
> > +               goto out;
> > +
> > +       if (timeout) {
> > +               ret = -EOPNOTSUPP;
> > +               goto out;
> > +       }
> > +
> > +       next = find_get_task_by_vpid(next_tid);
> > +       if (!next) {
> > +               ret = -ESRCH;
> > +               goto out;
> > +       }
> 
> There isn't any type of access check here, right? Any task can wake up
> any other task? That feels a bit weird to me - and if you want to keep
> it as-is, it should probably at least be documented that any task on
> the system can send you spurious wakeups if you opt in to umcg.

You can only send wakeups to other UMCG thingies, per the
next->umcg_task_data check below. That said..

> In contrast, shared futexes can avoid this because they get their
> access control implicitly from the VMA.

Every task must expect spurious wakups at all times, always (for
TASK_NORMAL wakeups that is). There's plenty ways to generate them.

> > +       next_utd = rcu_dereference(next->umcg_task_data);
> > +       if (!next_utd) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
