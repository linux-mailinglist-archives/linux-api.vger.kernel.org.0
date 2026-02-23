Return-Path: <linux-api+bounces-5875-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGQaAiZenGkUFQQAu9opvQ
	(envelope-from <linux-api+bounces-5875-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 15:03:18 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A306177A65
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 15:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5D3CB3023698
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667242773F0;
	Mon, 23 Feb 2026 14:03:12 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E44248F47
	for <linux-api@vger.kernel.org>; Mon, 23 Feb 2026 14:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855392; cv=none; b=CXflgQNdkJ1bX0Mig+glwziRvgCxXQDYHCSwVcnZ7y4P8rrurtOa04GbaEHulmlqHw2fQ2846wiRclGAoAGr7kcM/IebAsV8607gn5qjrLyg3+gHq9F/xcx5V2CCFGK1Q4ooxvRQv20iHPIOmT+umtdYeQeHIozG4towL+g7k5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855392; c=relaxed/simple;
	bh=b9EosaxnEFn0mRUvbhuomrMOjqt6GWtJDuAhe9M61rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiV48bhwgIeXmBWFsd4H4oxsCSXmGcemveh9n7pXSk0Sp4SS6X/EySlrjk2O4kmRtLcHijoxaa+mwphpTUpBcMKCYoyhs9Asj2a2w1M44fewtyxfR4l3otAAehZoEEktLmfCK1dI//EOs7TuNP3/7qvJcmLHs/Ro7reAXHh3g54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aerifal.cx; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aerifal.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Mon, 23 Feb 2026 08:47:51 -0500
From: Rich Felker <dalias@aerifal.cx>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Florian Weimer <fweimer@redhat.com>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Carlos O'Donell <carlos@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, kernel-dev@igalia.com,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	libc-alpha <libc-alpha@sourceware.org>
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
Message-ID: <20260223134751.GN6263@brightrain.aerifal.cx>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
 <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
 <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
 <lhusearzp8o.fsf@oldenburg.str.redhat.com>
 <87003e32-eae2-41c8-8b83-2530f084b3c7@efficios.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87003e32-eae2-41c8-8b83-2530f084b3c7@efficios.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[aerifal.cx];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5875-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[man7.org:server fail,sto.lore.kernel.org:server fail,brightrain.aerifal.cx:server fail];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dalias@aerifal.cx,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[linux-api];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A306177A65
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:37:13AM -0500, Mathieu Desnoyers wrote:
> On 2026-02-23 06:13, Florian Weimer wrote:
> > * Mathieu Desnoyers:
> > 
> > > Trying to find a backward compatible way to solve this may be tricky.
> > > Here is one possible approach I have in mind: Introduce a new syscall,
> > > e.g. sys_cleanup_robust_list(void *addr)
> > > 
> > > This system call would be invoked on pthread_mutex_destroy(3) of
> > > robust mutexes, and do the following:
> > > 
> > > - Calculate the offset of @addr within its mapping,
> > > - Iterate on all processes which map the backing store which contain
> > >    the lock address @addr.
> > >    - Iterate on each thread sibling within each of those processes,
> > >      - If the thread has a robust list, and its list_op_pending points
> > >        to the same offset within the backing store mapping, clear the
> > >        list_op_pending pointer.
> > > 
> > > The overhead would be added specifically to pthread_mutex_destroy(3),
> > > and only for robust mutexes.
> > 
> > Would we have to do this for pthread_mutex_destroy only, or also for
> > pthread_join?  It is defined to exit a thread with mutexes still locked,
> > and the pthread_join call could mean that the application can determine
> > by its own logic that the backing store can be deallocated.
> Let me try to wrap my head around this scenario.
> 
> AFAIU, the https://man7.org/linux/man-pages/man3/pthread_join.3.html
> NOTES section states the following for pthread_join(3):
> 
>        After a successful call to pthread_join(), the caller is
>        guaranteed that the target thread has terminated.  The caller may
>        then choose to do any clean-up that is required after termination
>        of the thread (e.g., freeing memory or other resources that were
>        allocated to the target thread).
> 
> What is the behavior when a thread exits with a mutex locked ? I would
> expect that this mutex stays locked

For a robust mutex, if the owning thread exits, the mutex enters
EOWNERDEAD state.

Otherwise, per POSIX the mutex just remains permanently locked and
undestroyable. glibc does not actually implement this for recursive or
errorchecking mutexes, as the tid might get reused and then the new
thread that got the same tid will now behave as if it were the owner
(e.g. it's allowed to take further recursive locks or observe itself
as the owner via EDEADLK). In musl we implement this by putting all
recursive and errorchecking mutexes on a robust list to reassign an
unmatchable tid to them at pthread_exit time.

> and the pthread_join(3) caller gets
> to release that mutex and eventually calls pthread_mutex_destroy(3) if
> the application logic allows it.

No other thread can release the mutex that was left locked unless it
was robust and it goes via the EOWNERDEAD/recovery process. Nor can
you legally call pthread_mutex_destroy on a mutex that's still owned.

Rich

