Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5130E40A8EE
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhINIL6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhINIL6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 04:11:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34396C061574;
        Tue, 14 Sep 2021 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZELYicw1akr9KH3zH9mr6S5GTKctUyhkTss9Ht1dvsM=; b=TKPgpA8nid+6oPxrRgNdT2vu2U
        CwG372BFoe8zI122HiN2hdhmQOKs1VcDGv5ZWCKTvYxgTN3mj1LxKCpZ1A7ptGjPswDIcsBh5tBQ5
        USkq8kU59W5MGoNnRlan5NBYh87AuSoFqIZcBZ0ftbqfzEXHx8+jhimsbqNZMzJzxxD2R5pKNeyuO
        bFScG29Y3WHgfzaCZw3uhmgfYM38iE8/bbH7yoMySr7B0cDmI2AkfA+meo6kMTPLBL3DPZZGJ2KkM
        9t1N7sYY0amotrETbQ4djT79YjO25G0nCfRJwyUs++AlNA507BJ6v3RKAcdEeqnp0mO0ImUjQijNt
        aUVuQkBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ3T4-00EQcm-0F; Tue, 14 Sep 2021 08:07:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 882AF30026F;
        Tue, 14 Sep 2021 10:07:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67FBD233CAE6B; Tue, 14 Sep 2021 10:07:00 +0200 (CEST)
Date:   Tue, 14 Sep 2021 10:07:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
Message-ID: <YUBYJLCYpy3yJO5F@hirez.programming.kicks-ass.net>
References: <20210908184905.163787-1-posk@google.com>
 <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 09, 2021 at 12:06:58PM -0700, Peter Oskolkov wrote:
> On Wed, Sep 8, 2021 at 4:39 PM Jann Horn <jannh@google.com> wrote:
> 
> Thanks a lot for the reviews, Jann!
> 
> I understand how to address most of your comments. However, one issue
> I'm not sure what to do about:
> 
> [...]
> 
> > If this function is not allowed to sleep, as the comment says...
> 
> [...]
> 
> > ... then I'm pretty sure you can't call fix_pagefault() here, which
> > acquires the mmap semaphore (which may involve sleeping) and then goes
> > through the pagefault handling path (which can also sleep for various
> > reasons, like allocating memory for pagetables, loading pages from
> > disk / NFS / FUSE, and so on).
> 
> <quote from peterz@ from
> https://lore.kernel.org/lkml/20210609125435.GA68187@worktop.programming.kicks-ass.net/>:
>   So a PF_UMCG_WORKER would be added to sched_submit_work()'s PF_*_WORKER
>   path to capture these tasks blocking. The umcg_sleeping() hook added
>   there would:
> 
>     put_user(BLOCKED, umcg_task->umcg_status);
>     ...
> </quote>
> 
> Which is basically what I am doing here: in sched_submit_work() I need
> to read/write to userspace; and we cannot sleep in
> sched_submit_work(), I believe.
> 
> If you are right that it is impossible to deal with pagefaults from
> within non-sleepable contexts, I see two options:
> 
> Option 1: as you suggest, pin pages holding struct umcg_task in sys_umcg_ctl;
> 
> or
> 
> Option 2: add more umcg-related kernel state to task_struct so that
> reading/writing to userspace is not necessary in sched_submit_work().

Durr.. so yeah this is a bit of a chicken and egg problem here. We need
a userspace page to notify we're blocked, but at the same time,
accessing said page can get us blocked.

And then worse, as Jann said, we cannot do this in the appropriate spot
because we could be blocking on mmap_sem, so we must not require
mmap_sem to make progress etc.. :/

Now, in reality actually taking a fault for these pages is extremely
unlikely, but if we do, there's really no option but to block and wait
for it without notification. Tought luck there.

So what we can do, is use get_user_page() on the appropriate pages
(alignment ensure the whole umcg struct must be in a single page etc..)
the moment a umcg task enters the kernel. For this we need some
SYSCALL_WORK_ENTER flag.

So normally a task would have ->umcg_page and ->umcg_server_page be
NULL, the above SYSCALL_WORK_SYSCALL_UMCG flag would get_user_page() the
self and server pages. If get_user_page() blocks, these fields would
still be NULL and sched_submit_work() would not do anything, c'est la
vie.

Once we have the pages, any actual blocking hitting sched_submit_work()
can do the updates without further blocking. It can then also put_page()
and clear the ->umcg_{,server_}page pointers, because the task_work that
will set RUNNABLE *can* suffer mmap_sem (again, unlikely, again tough
luck if it does).

The reason for put'ing the pages on blocking, is that this guarantees
the pages are only pinned for a short amount of time, and 'never' by a
blocked task. IOW, it's a proper transient pin and doesn't require extra
special care or accounting.



Also, can you *please* convert that RST crud to a text file, it's
absolutely unreadable gunk. Those documentation files should be readable
as plain text first and foremost. That whole rendering to html crap is
nonsense. Using a browser to read a test file is insane.
