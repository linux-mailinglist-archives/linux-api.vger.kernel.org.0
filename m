Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2245CF16
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 22:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhKXVfu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 16:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhKXVfu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 16:35:50 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4FC061574;
        Wed, 24 Nov 2021 13:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MD9gDqn477L4qvEwrrJOawMxQWEnHDvjZ5lo8c6MkO8=; b=ZqpstrFkaDOyjrWUwoTpwpnqq9
        SuhLVa8rM5anBPQVpBU11P17l/1TDo4BSHTkL8cV2UiHD0NoU5JIkwo4Jo0HyEAPCkIA28KWSb3Di
        8MD7w0qvX66CrcXbbejAPZbtszK3rSdmPlHh27EYJwo49zaUH4vwkKGA4Q+qa+HxIxXnrse49FZ1n
        2s/1Lb4RgESeo6UMM3gIZwiKo4Nf7DecIMMwPi/3qbjkYkVy7vlYlEDCvsygZB98NxefTn9q3o3MD
        ao2n9DaWXfcV1BGhGwieOHhkgXlMZ6PARBSf641fpbJTfdDQbetOElWPXRuLZaweJ6hwIhaElAoei
        UckDKJbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpzsO-003Sxq-Tv; Wed, 24 Nov 2021 21:32:25 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98EE2986843; Wed, 24 Nov 2021 22:32:24 +0100 (CET)
Date:   Wed, 24 Nov 2021 22:32:24 +0100
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
Message-ID: <20211124213224.GA735260@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124200822.GF721624@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 24, 2021 at 09:08:23PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 22, 2021 at 01:13:24PM -0800, Peter Oskolkov wrote:
> > +/**
> > + * struct umcg_task - controls the state of UMCG tasks.
> > + *
> > + * The struct is aligned at 64 bytes to ensure that it fits into
> > + * a single cache line.
> > + */
> > +struct umcg_task {
> > +	/**
> > +	 * @state_ts: the current state of the UMCG task described by
> > +	 *            this struct, with a unique timestamp indicating
> > +	 *            when the last state change happened.
> > +	 *
> > +	 * Readable/writable by both the kernel and the userspace.
> > +	 *
> > +	 * UMCG task state:
> > +	 *   bits  0 -  5: task state;
> > +	 *   bits  6 -  7: state flags;
> > +	 *   bits  8 - 12: reserved; must be zeroes;
> > +	 *   bits 13 - 17: for userspace use;
> > +	 *   bits 18 - 63: timestamp (see below).
> > +	 *
> > +	 * Timestamp: a 46-bit CLOCK_MONOTONIC timestamp, at 16ns resolution.
> > +	 * See Documentation/userspace-api/umcg.txt for detals.
> > +	 */
> > +	__u64	state_ts;		/* r/w */
> > +
> > +	/**
> > +	 * @next_tid: the TID of the UMCG task that should be context-switched
> > +	 *            into in sys_umcg_wait(). Can be zero.
> > +	 *
> > +	 * Running UMCG workers must have next_tid set to point to IDLE
> > +	 * UMCG servers.
> > +	 *
> > +	 * Read-only for the kernel, read/write for the userspace.
> > +	 */
> > +	__u32	next_tid;		/* r   */
> > +
> > +	__u32	flags;			/* Reserved; must be zero. */
> > +
> > +	/**
> > +	 * @idle_workers_ptr: a single-linked list of idle workers. Can be NULL.
> > +	 *
> > +	 * Readable/writable by both the kernel and the userspace: the
> > +	 * kernel adds items to the list, the userspace removes them.
> > +	 */
> > +	__u64	idle_workers_ptr;	/* r/w */
> > +
> > +	/**
> > +	 * @idle_server_tid_ptr: a pointer pointing to a single idle server.
> > +	 *                       Readonly.
> > +	 */
> > +	__u64	idle_server_tid_ptr;	/* r   */
> > +} __attribute__((packed, aligned(8 * sizeof(__u64))));
> 
> The thing is; I really don't see how this is supposed to be used. Where
> did the blocked and runnable list go ?
> 
> I also don't see why the kernel cares about idle workers at all; that
> seems something userspace can sort itself just fine.
> 
> The whole next_tid thing seems confused too, how can it be the next task
> when it must be the server? Also, what if there isn't an idle server?
> 
> This just all isn't making any sense to me.

Oooh, someone made things super confusing by doing s/runnable/idle/ on
the whole thing :-( That only took me most of the day to figure out.
Naming is important, don't mess about with stuff like this.
