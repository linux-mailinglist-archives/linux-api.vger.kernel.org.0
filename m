Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1711F45CF82
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbhKXWBy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 17:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhKXWBx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 17:01:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AAEC061574;
        Wed, 24 Nov 2021 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=//KBPE5SMQ1jDsaGVvNOxvpTpPtfZdPZBVxETIdKBt8=; b=JN+wvFOSa2W3XyDr9iLxgj4/pS
        NwuN2DNqNv7gFzkJL2sGkYlyyGRoBUbWOrIBHaXPDm1iGvcLRKqiJ/bZiEfD/fjP7Z2UnYoBeyGas
        oPspTxjI/X6mKEnEtEG+QLUSXkzSnenabR/+zy6if4GgwnayuZUr5yqzzbc5WgXY1PYORsrH95QU9
        C3SLvF1geJCwyR2NmF5ksA1ir51KbssWpKzFpRUsjwDyqytal+WsPalPuiBKoL/zZMObjPw2Jp4e2
        vh++WDRJraJ8dTjmENAyrfMk+nxmcXMDxJEnVKMhaklvLXCZJKox0NZ8rX+ZfnAdHOSzf+ySD9gUE
        m5YdKJxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq0Hh-003Y3o-Tr; Wed, 24 Nov 2021 21:58:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E62C986843; Wed, 24 Nov 2021 22:58:34 +0100 (CET)
Date:   Wed, 24 Nov 2021 22:58:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <20211124215834.GI721624@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122211327.5931-4-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 22, 2021 at 01:13:24PM -0800, Peter Oskolkov wrote:
> +	if (abs_timeout) {
> +		hrtimer_init_sleeper_on_stack(&timeout, CLOCK_REALTIME,
> +				HRTIMER_MODE_ABS);

Using CLOCK_REALTIME timers while the rest of the thing runs off of
CLOCK_MONOTONIC doesn't seem to make sense to me. Why would you want to
have timeouts subject to DST shifts and crap like that?
