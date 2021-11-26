Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9443945F6B5
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 23:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhKZWGI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 17:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235626AbhKZWEH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 17:04:07 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E57C061758;
        Fri, 26 Nov 2021 14:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mVe6i3/v+cqujpezlAYb0QP3ok/XczGEBz8gbXJU03U=; b=O2JWYmxJ7/f03ehjL+s7JohJC/
        ynfSXmDUkqlrleL67OukKwqmvBNMKdl3qCPsf8hgCedRMFGPTn7A7Eb1BiQDlY0DDDqrpYd0yI9/R
        HfNvz8TLPNMXLBCJxw0WFjgSopXR5Q5lwmDahpJ7kTlsHv8MVQb04YRmzEvNbx4PBlaocgeZBJUqf
        jjdUkZAtkHEJInkocwoUeava42Xe+DR8u13pxi1L4mmqXg36lPFz9vnOyEBNlWnwoAHM3CN9lYU7g
        eJQpcFcWe4lNXYzlaWAwx3zdieeWosmMQjxuLdDjVtT13IKOIafv1FFHU9lUrRlGJv5URI3LS6IQE
        2LGGE60A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqjFx-000mvv-WB; Fri, 26 Nov 2021 21:59:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0D7F43000DD;
        Fri, 26 Nov 2021 22:59:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EAA812D1EBB54; Fri, 26 Nov 2021 22:59:44 +0100 (CET)
Date:   Fri, 26 Nov 2021 22:59:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <YaFY0KqfPhmZjK7n@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <87a6hqhbgh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6hqhbgh.ffs@tglx>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26, 2021 at 10:08:14PM +0100, Thomas Gleixner wrote:
> On Fri, Nov 26 2021 at 18:09, Peter Zijlstra wrote:
> > +
> > +	if (timo) {
> > +		hrtimer_init_sleeper_on_stack(&timeout, tsk->umcg_clock,
> > +					      HRTIMER_MODE_ABS);
> > +		hrtimer_set_expires_range_ns(&timeout.timer, (s64)timo,
> > +					     tsk->timer_slack_ns);
> > +	}
> > +
> > +	for (;;) {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +		ret = -EINTR;
> > +		if (signal_pending(current))
> > +			break;
> > +
> > +		/*
> > +		 * Faults can block and scribble our wait state.
> > +		 */
> > +		pagefault_disable();
> > +		if (get_user(state, &self->state)) {
> > +			pagefault_enable();
> > +
> > +			ret = -EFAULT;
> > +			if (page) {
> > +				unpin_user_page(page);
> > +				page = NULL;
> > +				break;
> > +			}
> > +
> > +			if (pin_user_pages_fast((unsigned long)self, 1, 0, &page) != 1) {
> > +				page = NULL;
> > +				break;
> > +			}
> > +
> > +			continue;
> > +		}
> > +
> > +		if (page) {
> > +			unpin_user_page(page);
> > +			page = NULL;
> > +		}
> > +		pagefault_enable();
> > +
> > +		state &= UMCG_TASK_MASK;
> > +		if (state != UMCG_TASK_RUNNABLE) {
> > +			ret = 0;
> > +			if (state == UMCG_TASK_RUNNING)
> > +				break;
> > +
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +
> > +		if (timo)
> > +			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
> > +
> > +		freezable_schedule();
> 
> You can replace the whole hrtimer foo with
> 
>                 if (!schedule_hrtimeout_range_clock(timo ? &timo : NULL,
>                                                     tsk->timer_slack_ns,
>                                                     HRTIMER_MODE_ABS,
>                                                     tsk->umcg_clock)) {
>                 	ret = -ETIMEOUT;
>                         break;
>                 }

That seems to loose the freezable crud.. then again, since we're
interruptible, that shouldn't matter. Lemme go do that.

