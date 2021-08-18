Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA783F08F9
	for <lists+linux-api@lfdr.de>; Wed, 18 Aug 2021 18:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHRQXV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Aug 2021 12:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhHRQXV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Aug 2021 12:23:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D591C061764;
        Wed, 18 Aug 2021 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HwP/nMh1cO8cF7GObYL+nv9FmhI1pvtnORa3FRBGMnE=; b=dRRewrHMhqhelJiynY40+Jt/8X
        CEXQEFp13ZKVcdj7C+ptF0cC1ssJADzlz1h6gin+O7U+8mzDpwt0p4fDsGKUuspm4w+ndmOlwhElk
        IDh50Gk8NXoNBZ0hgxx02xW1ZrBn8n5p+GjmjrdPyckwuJ1RXtLCUMmrGBQs3DCEIgqGDNH3cNgt/
        vccEXuajJuGJE1wwtPzSz3Xl9xcSxCo9jDFrqm+25yU/Q69SQ+fUnCX+MGxqRppXjmptDurJDgW5N
        0ni9VP89jyoJLu7O8BLM7Oq3lYLkw4BJbldk4F8Tl/2NknLBTTPIPJx8bkHiEdIftbwGreIpKAzPp
        j0A+dhhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGOIu-00421p-8q; Wed, 18 Aug 2021 16:20:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C955F981DD4; Wed, 18 Aug 2021 18:20:34 +0200 (CEST)
Date:   Wed, 18 Aug 2021 18:20:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH 2/4] futex2: Implement vectorized wait
Message-ID: <20210818162034.GA26408@worktop.programming.kicks-ass.net>
References: <20210805190405.59110-1-andrealmeid@collabora.com>
 <20210805190405.59110-3-andrealmeid@collabora.com>
 <87v94310gm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v94310gm.ffs@tglx>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 18, 2021 at 01:00:57PM +0200, Thomas Gleixner wrote:
> > +/**
> > + * struct futex_waitv - A waiter for vectorized wait
> > + * @val:   Expected value at uaddr
> > + * @uaddr: User address to wait on
> > + * @flags: Flags for this waiter
> > + */
> > +struct futex_waitv {
> > +	__u64 val;
> 
> Again. Why u64?

So I think the idea was that if we're going to do new syscalls, we
should cater for future extentions, one of which was 64bit futexes (for
64bit archs) (along with u{8,16,32})

The previous set of patches implemented a more complete replacement ABI
-- which I rather liked, however the implementation was completely
disjoint from the existing futexes, which was a non-starter for me.

Anyway, yes, current futexes are u32, but if we want to ever do u64
futexes, we should either do this syscall with a u64, or already plan to
retire the whole syscall.

Obiously this would've made good Changelog material, but alas it wasn't
there.

