Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36745F6AA
	for <lists+linux-api@lfdr.de>; Fri, 26 Nov 2021 22:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbhKZV5w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Nov 2021 16:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241843AbhKZVzw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Nov 2021 16:55:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7E0C061746;
        Fri, 26 Nov 2021 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=go92kDNk8htS9RciSYEL5olMCBjzci3dlAvsk/icQJ8=; b=mZp5Z8vaGZJK8cG0vOg3h2MB3A
        6HAWjKLwhiRVFzFswrhpyL3h1pBw19hVrCf8CftPE5f7YhZ+URYPboMAlTyg4EuJ9OdI1N9D+Y2l/
        KeOoXkvEwW8ultlrRPuA6TvNSKCftl/GZ/5QgNK63dDgLHQITYNcwDUqV2/v8b9v0e06FpLKIz1DN
        oAXE+/+BNDitd+raU5VeXBVzmLS8LgyPjEihPmndfuojQf7rtu5cjKWPOwhKBMI2PIhIygxuK3+A+
        wHPXJnCYKrKViMJ6tmin8nXapVnXicQXMFHn8ZTMQgtN7MUhEMQtSgS+aYF0Y1ArFAsYMhR1N9E3L
        4j2AnYtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqj8h-00CITn-2X; Fri, 26 Nov 2021 21:52:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A8E873000DD;
        Fri, 26 Nov 2021 22:52:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BBD82DC6C83F; Fri, 26 Nov 2021 22:52:13 +0100 (CET)
Date:   Fri, 26 Nov 2021 22:52:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YaFXDYm7s7A6HDTG@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124211927.GG721624@worktop.programming.kicks-ass.net>
 <877dcuhbbe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dcuhbbe.ffs@tglx>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 26, 2021 at 10:11:17PM +0100, Thomas Gleixner wrote:
> On Wed, Nov 24 2021 at 22:19, Peter Zijlstra wrote:
> > On Mon, Nov 22, 2021 at 01:13:24PM -0800, Peter Oskolkov wrote:
> >
> >> +	 * Timestamp: a 46-bit CLOCK_MONOTONIC timestamp, at 16ns resolution.
> >
> >> +static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
> >> +				bool may_fault)
> >> +{
> >> +	u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> >> +	u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;
> >
> > I'm still very hesitant to use ktime (fear the HPET); but I suppose it
> > makes sense to use a time base that's accessible to userspace. Was
> > MONOTONIC_RAW considered?
> 
> MONOTONIC_RAW is not really useful as you can't sleep on it and it won't
> solve the HPET crap either.

But it's ns are of equal size to sched_clock(), if both share TSC IIRC.
Whereas MONOTONIC, being subject to ntp rate stuff, has differently
sized ns.

The only time that's relevant though is when you're going to mix these
timestamps with CLOCK_THREAD_CPUTIME_ID, which might just be
interesting.

But yeah, not being able to sleep on it ruins the party.
