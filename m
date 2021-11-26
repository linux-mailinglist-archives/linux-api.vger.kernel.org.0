Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7242145F6CA
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 23:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhKZWWI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 17:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243532AbhKZWUH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 17:20:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85BAC06173E;
        Fri, 26 Nov 2021 14:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EntB1bbOJyfmGweu3RU+T8l6UeFUccPmGGuVsMlG2Eo=; b=AC8lhUU5E49eFZoE4e2sHAnAX9
        kHHIAqB6luQZYLE4LWZ7ew4taByaDQ3nIwp6HUbjkeIXIYYgmmvQyL++HpXPPAuEoWjKaVtpuUv0J
        hDRUuMHv3vB6OavPVAlSbd8/4HJNbAj7iGK8yieFViHswVFTxtksTJZiwGFqbhpneWAr3PTa5BBq5
        cXM7HmcBycjUxcQ73JPFl0lFgYBu+hi3Be2LqMatUPmHoWKFaBNHeb3mn7R7UQBMcP8MuOo3H/d1D
        paiCR2xp77kYzrGSFDvuDHl6XvX6ujijYsTZOu2obCZpfqqjmUiurJR2T6IOuSr/GsmMrTSNQFSlW
        JMOb6tZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqjWN-00CN1H-DW; Fri, 26 Nov 2021 22:16:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4E2D83000DD;
        Fri, 26 Nov 2021 23:16:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 338A52DC5775F; Fri, 26 Nov 2021 23:16:43 +0100 (CET)
Date:   Fri, 26 Nov 2021 23:16:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YaFcyzq0WpnXu+2R@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26, 2021 at 06:09:10PM +0100, Peter Zijlstra wrote:

> @@ -155,8 +159,7 @@ static unsigned long exit_to_user_mode_l
>  	 * Before returning to user space ensure that all pending work
>  	 * items have been completed.
>  	 */
> -	while (ti_work & EXIT_TO_USER_MODE_WORK) {
> -
> +	do {
>  		local_irq_enable_exit_to_user(ti_work);
>  
>  		if (ti_work & _TIF_NEED_RESCHED)
> @@ -168,6 +171,10 @@ static unsigned long exit_to_user_mode_l
>  		if (ti_work & _TIF_PATCH_PENDING)
>  			klp_update_patch_state(current);
>  
> +		/* must be before handle_signal_work(); terminates on sigpending */
> +		if (ti_work & _TIF_UMCG)
> +			umcg_notify_resume(regs);
> +
>  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>  			handle_signal_work(regs, ti_work);
>  
> @@ -188,7 +195,7 @@ static unsigned long exit_to_user_mode_l
>  		tick_nohz_user_enter_prepare();
>  
>  		ti_work = READ_ONCE(current_thread_info()->flags);
> -	}
> +	} while (ti_work & EXIT_TO_USER_MODE_WORK);
>  
>  	/* Return the latest work state for arch_exit_to_user_mode() */
>  	return ti_work;
> @@ -203,7 +210,7 @@ static void exit_to_user_mode_prepare(st
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
>  	tick_nohz_user_enter_prepare();
>  
> -	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
> +	if (unlikely(ti_work & (EXIT_TO_USER_MODE_WORK | _TIF_UMCG)))
>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
>  
>  	arch_exit_to_user_mode_prepare(regs, ti_work);

Thomas, since you're looking at this. I'm not quite sure I got this
right. The intent is that when _TIF_UMCG is set (and it is never cleared
until the task unregisters) it is called at least once.

The thinking is that if umcg_wait() gets interrupted, we'll drop out,
handle the signal and then resume the wait, which can obviously happen
any number of times.

It's just that I'm never quite sure where signal crud happens; I'm
assuming handle_signal_work() simply mucks about with regs (sets sp and
ip etc.. to the signal stack) and drops out of kernel mode, and on
re-entry we do this whole merry cycle once again. But I never actually
dug that deep.


