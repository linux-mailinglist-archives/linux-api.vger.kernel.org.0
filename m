Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F274445CF5D
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 22:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243408AbhKXVpP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 16:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbhKXVpP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 16:45:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715CCC061574;
        Wed, 24 Nov 2021 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtyATGG4/Tqtkd6LyCLZuHtGU7V1I4VQuaKYnkFLL2A=; b=mIJKySH7od+fNxhERGhQpBaGly
        FyK5+VivZ/jRfp26y9Iff67t1ZsvpmrnizxuoOn1J4kX0Y9mkLfvLy3Hc4PPH3g9p64328Hy7OqDN
        ASjCfl+IvmiRQV51fSkr9bJceFTzxCNYFDafRjSB0EOwV3vojfyg3hkFMF9xvREuqG19M4NR3plct
        bG9lPglbpes3e9Y/dLV4035pQaf9MM5bUO9jE271bmSmmIvgL6mSEdasD22n9h+OmhCedNEtZlIoP
        WiY8rEWD2hB1C6LiwNDTTqDa/wiNf4U+dMKL5vYZqllgLjUmGWlovgcOqB3BoeL7Ose90SEuxjMqc
        Tewcst5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq01Y-000JzV-De; Wed, 24 Nov 2021 21:41:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F2D71986843; Wed, 24 Nov 2021 22:41:51 +0100 (CET)
Date:   Wed, 24 Nov 2021 22:41:51 +0100
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
Message-ID: <20211124214151.GH721624@worktop.programming.kicks-ass.net>
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
> +	while (true) {

(you have 2 inf. loops in umcg and you chose a different expression for each)

> +		u64 umcg_state;
> +
> +		/*
> +		 * We need to read from userspace _after_ the task is marked
> +		 * TASK_INTERRUPTIBLE, to properly handle concurrent wakeups;
> +		 * but faulting is not allowed; so we try a fast no-fault read,
> +		 * and if it fails, pin the page temporarily.
> +		 */

That comment is misleading! Faulting *is* allowed, but it can scribble
__state. If faulting would not be allowed, you wouldn't be able to call
pin_user_pages_fast().

> +retry_once:
> +		set_current_state(TASK_INTERRUPTIBLE);
> +
> +		/* Order set_current_state above with get_user below. */
> +		smp_mb();

And just in case you hadn't yet seen, that smp_mb() is implied by
set_current_state().

> +		ret = -EFAULT;
> +		if (get_user_nofault(umcg_state, &self->state_ts)) {
> +			set_current_state(TASK_RUNNING);
> +
> +			if (pinned_page)
> +				goto out;
> +			else if (1 != pin_user_pages_fast((unsigned long)self,
> +						1, 0, &pinned_page))

That else is pointless, and that '1 != foo' coding style is evil.

> +					goto out;
> +
> +			goto retry_once;
> +		}

And, as you could've seen from the big patch, all that goto isn't
actually needed here, break / continue seem to be sufficient.

> +
> +		if (pinned_page) {
> +			unpin_user_page(pinned_page);
> +			pinned_page = NULL;
> +		}
