Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD145F7DA
	for <lists+linux-api@lfdr.de>; Sat, 27 Nov 2021 02:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbhK0BWB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 20:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbhK0BUA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 20:20:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54EC06174A;
        Fri, 26 Nov 2021 17:16:47 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637975804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DT9TnAjJN6p5cb67DY6dvVqAC4VHB/JbDn7hMhDJt80=;
        b=Q+8iBjG3F/zb99AbBGK+dFF02kU49RvpUvrTC9euWPcfCWynjkaNUWN0xY4JEuZJz62cCu
        VHHWgHLrGcDEkOZL3cypR9N+qqnO6H8ND9+VCgQ58PWX/tR10V4aqUHNQRdpEvfmdS/3aS
        8ys2Aj+5ZJokVLrq4apn7E3sZNuZS76ca+YB0u58jzc/uiKSmMWEhPh6e//e7qQrK0KMr6
        cQ+9MUNYvP6POJFTNWyeZFgtU/CHDF/u9qJtzE/8T8Vafgfu1e2PGez+ceUlQ8/EB91Rzf
        eqxt3+lJmVOz+A6FJmcvbYxYZfJ6axE3hphjk8tfcOit70bfYzqdAIXOfdOlGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637975804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DT9TnAjJN6p5cb67DY6dvVqAC4VHB/JbDn7hMhDJt80=;
        b=IZNHyB3f6u118NoaaChJJEbVl5AN4UTNZOgNIG1dYm6Tql1zO+WAlih9sJIUvZ4T8A53mc
        Dxlq5DTeyq5MNqBw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
In-Reply-To: <YaFcyzq0WpnXu+2R@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <YaFcyzq0WpnXu+2R@hirez.programming.kicks-ass.net>
Date:   Sat, 27 Nov 2021 02:16:43 +0100
Message-ID: <87r1b2fldw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26 2021 at 23:16, Peter Zijlstra wrote:
> On Fri, Nov 26, 2021 at 06:09:10PM +0100, Peter Zijlstra wrote:
>>  
>> -	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>> +	if (unlikely(ti_work & (EXIT_TO_USER_MODE_WORK | _TIF_UMCG)))
>>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
>>  
>>  	arch_exit_to_user_mode_prepare(regs, ti_work);
>
> Thomas, since you're looking at this. I'm not quite sure I got this
> right. The intent is that when _TIF_UMCG is set (and it is never cleared
> until the task unregisters) it is called at least once.

Right.

> The thinking is that if umcg_wait() gets interrupted, we'll drop out,
> handle the signal and then resume the wait, which can obviously happen
> any number of times.

Right.

> It's just that I'm never quite sure where signal crud happens; I'm
> assuming handle_signal_work() simply mucks about with regs (sets sp and
> ip etc.. to the signal stack) and drops out of kernel mode, and on
> re-entry we do this whole merry cycle once again. But I never actually
> dug that deep.

Yes. It sets up the signal frame and once the loop is left because there
are no more TIF flags to handle it drops back to user space into the
signal handler. That returns to the kernel via sys_[rt_]sigreturn()
which undoes the regs damage either by restoring the previous state or
fiddling it to restart the syscall instead of dropping back to user
space.

So yes, this should work, but I hate the sticky nature of TIF_UMCG. I
have no real good idea how to avoid that yet, but let me think about it
some more.

Thanks,

        tglx
