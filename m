Return-Path: <linux-api+bounces-2673-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C07D9BCC89
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 13:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A26283B52
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419031D5145;
	Tue,  5 Nov 2024 12:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S8Sg6QNz"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51901D2B35;
	Tue,  5 Nov 2024 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809127; cv=none; b=Zs8r1kX0Lv8q4GtJSAvdkvNRPYGEuFimHxdqQnYlVyjiUtL3d2VOco3X1MFCYDVKaI/yH9oZmp+ioGUtTsfAqBphgLjrEfgL6E05h8ms/mWoV3F6NG5/YjvVRrZhj3Du6OezKM6h4sAniZ63GIvLwUR6qWKRcTPBY72PgxD9a/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809127; c=relaxed/simple;
	bh=/Lhrpkq7dhXBZGgeynPZ3NqBreA6DlOx3kN7C7kt/7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orQxZDaKvicVZUVrIjHWzlsxayjR0m4qZFEWC4qR8VX/mH4MUCjNDP2Z6jLdvsgBmtafwFfLkkqJkxQgFyO4CyjRr9NrkXa+xS/Gi1spWtnsGjYLfGYyPd8uZBHOmhgpnMVhe9rnCGZBhMwxQRGUq6M3uEpwzaD09O7akEO/zpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S8Sg6QNz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QUR5VQsHB/rsr5bf/y9zlVTtMJzBF3Qt2eivBnUCfIQ=; b=S8Sg6QNzBM7dx0D3XKfKnO5xLq
	nyTBM9AKP0LH9EE+C6OaGRS+nxSJLzWpqwO3nOKUlLHq2FR+PUJ+Wk5eaguFTXz5KpiSKcQBsuJCj
	n/95GM9/orW9H2YzRTca0zYJBhObiYQiFrX2ZSyMdi/vzQrGbXDB0B8v+s1S2YfkcMC+EaT4/y+lU
	5ggwIg/fM+EoDWAhoQiMwEM8dws3LPO8aVPWLym4mhJJ+fKl8x2fQoua4kYJz2MpgaDajYrB+a2LR
	HfPl+H4bL6CabGDscHK94yBq8w/OdW8dc9UaMuFBNPxQWepvB4l+sEbdj2Kl+oi535W11kKZMhaQG
	u76s2v5w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8IW6-00000002nc4-0ETY;
	Tue, 05 Nov 2024 12:18:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id DF01A30042E; Tue,  5 Nov 2024 13:18:37 +0100 (CET)
Date: Tue, 5 Nov 2024 13:18:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 0/3] futex: Create set_robust_list2
Message-ID: <20241105121837.GI24862@noisy.programming.kicks-ass.net>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
 <87ldy170x9.fsf@oldenburg.str.redhat.com>
 <20241104113240.GB24862@noisy.programming.kicks-ass.net>
 <87jzdjxjj8.fsf@oldenburg3.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzdjxjj8.fsf@oldenburg3.str.redhat.com>

On Mon, Nov 04, 2024 at 01:36:43PM +0100, Florian Weimer wrote:
> * Peter Zijlstra:
> 
> > On Sat, Nov 02, 2024 at 10:58:42PM +0100, Florian Weimer wrote:
> >
> >> QEMU hints towards further problems (in linux-user/syscall.c):
> >> 
> >>     case TARGET_NR_set_robust_list:
> >>     case TARGET_NR_get_robust_list:
> >>         /* The ABI for supporting robust futexes has userspace pass
> >>          * the kernel a pointer to a linked list which is updated by
> >>          * userspace after the syscall; the list is walked by the kernel
> >>          * when the thread exits. Since the linked list in QEMU guest
> >>          * memory isn't a valid linked list for the host and we have
> >>          * no way to reliably intercept the thread-death event, we can't
> >>          * support these. Silently return ENOSYS so that guest userspace
> >>          * falls back to a non-robust futex implementation (which should
> >>          * be OK except in the corner case of the guest crashing while
> >>          * holding a mutex that is shared with another process via
> >>          * shared memory).
> >>          */
> >>         return -TARGET_ENOSYS;
> >
> > I don't think we can sanely fix that. Can't QEMU track the robust thing
> > itself and use waitpid() to discover the thread is gone and fudge things
> > from there?
> 
> There are race conditions with munmap, I think, and they probably get a
> lot of worse if QEMU does that.
> 
> See Rich Felker's bug report:
> 
> | The corruption is performed by the kernel when it walks the robust
> | list. The basic situation is the same as in PR #13690, except that
> | here there's actually a potential write to the memory rather than just
> | a read.
> | 
> | The sequence of events leading to corruption goes like this:
> | 
> | 1. Thread A unlocks the process-shared, robust mutex and is preempted
> |    after the mutex is removed from the robust list and atomically
> |    unlocked, but before it's removed from the list_op_pending field of
> |    the robust list header.
> | 
> | 2. Thread B locks the mutex, and, knowing by program logic that it's
> |    the last user of the mutex, unlocks and unmaps it, allocates/maps
> |    something else that gets assigned the same address as the shared mutex
> |    mapping, and then exits.
> | 
> | 3. The kernel destroys the process, which involves walking each
> |   thread's robust list and processing each thread's list_op_pending
> |   field of the robust list header. Since thread A has a list_op_pending
> |   pointing at the address previously occupied by the mutex, the kernel
> |   obliviously "unlocks the mutex" by writing a 0 to the address and
> |   futex-waking it. However, the kernel has instead overwritten part of
> |   whatever mapping thread A created. If this is private memory it
> |   (probably) doesn't matter since the process is ending anyway (but are
> |   there race conditions where this can be seen?). If this is shared
> |   memory or a shared file mapping, however, the kernel corrupts it.
> | 
> | I suspect the race is difficult to hit since thread A has to get
> | preempted at exactly the wrong time AND thread B has to do a fair
> | amount of work without thread A getting scheduled again. So I'm not
> | sure how much luck we'd have getting a test case.
> 
> 
> <https://sourceware.org/bugzilla/show_bug.cgi?id=14485#c3>

So I've only managed to conjure up two horrible solutions for this:

 - put the robust futex operations under user-space RCU, and mandate a
   matching synchronize_rcu() before any munmap() calls.

 - add a robust-barrier syscall that waits until all list_op_pending are
   either NULL or changed since invocation. And mandate this call before
   munmap().

Neither are particularly pretty I admit, but at least they should work.

But doing this and mandating the alignment thing should at least make
this qemu thing workable, no?

> We also have a silent unlocking failure because userspace does not know
> about ROBUST_LIST_LIMIT:
> 
>   Bug 19089 - Robust mutexes do not take ROBUST_LIST_LIMIT into account
>   <https://sourceware.org/bugzilla/show_bug.cgi?id=19089>
> 
> (I think we may have discussed this one before, and you may have
> suggested to just hard-code 2048 in userspace because the constant is
> not expected to change.)
> 
> So the in-mutex linked list has quite a few problems even outside of
> emulation. 8-(

It's futex, ofcourse its a pain in the arse :-)

And yeah, no better ideas on that limit for now...

