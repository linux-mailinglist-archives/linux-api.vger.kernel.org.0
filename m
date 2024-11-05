Return-Path: <linux-api+bounces-2672-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D076E9BCC64
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 13:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5341C222A7
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2024 12:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865941D514C;
	Tue,  5 Nov 2024 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T7i/zeJj"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137E1D47C8;
	Tue,  5 Nov 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808620; cv=none; b=NTXzP/tryf7nnRX7kJM1zaSvRQVNiEpe1cLB0mXNca9DNk3h+fYQJ6IaJCziOpwRchx3uddx65I28cGniw+xmgyVNYljNF/GNquefJRsOPCcpWN5emXLFs7XljtwAMCokg+elHRKKYoL0FRUnj0meJqr4MXVx5tNC9TXWo5wO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808620; c=relaxed/simple;
	bh=D/Sjnsy+/xB8yB9ivMteFWzQ4KLjCq4S2+qQfStaHW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQ5QcEQwcjtxB6K7su9g9oL4Toey3U6uAG5Dcwl18y5bvxLIFwxIJD0Z3pDBa24BuZkAUy+Fxhkh4CRXnhOuCwNU8xce9mKJVcJDskFAfPWqgmz8tQXxucopZkda2rjfWPCEtJbJUbhnbeJfp2/E7HhqwTSMXzyZEE/jR/CDDjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T7i/zeJj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JMfl+NyZcivvY2Hh7sjOcV4qti2lDbv6tUdw1BYPUR8=; b=T7i/zeJjDWLLrif0Z/0xNB0e24
	74a1VpvHrVOsx16+tD3a1rKwp8fv56k/kTwkGSlcXDC4RoX3/0WH3sIRDzYfOzeLJ/ONoJE+K+L6e
	qbsNawDJlidF1/L+/QHWOi+H5U4ANDsvPfSgfU71LDN8fgX8gAFGXnZ6pRJfczWeym98BPM/aJfJR
	4zZh2BNI9Fh5mXjGMXSaYygA2QiqN0Gn4qvy8ARch2Elsqfe7mjoL1dZHf9wVR3RA7TZC+5CsY4zj
	kYwmaO1lJ4YfgWMrw5BQP9wT5Lv4WFO+yjAjoViYTClj4jSTuSoByKk1f3CNsOpzy164GmQhiMMWS
	8NtPPjFQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8INt-00000002lvd-12FH;
	Tue, 05 Nov 2024 12:10:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7AD6A30042E; Tue,  5 Nov 2024 13:10:09 +0100 (CET)
Date: Tue, 5 Nov 2024 13:10:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 2/3] futex: Create set_robust_list2
Message-ID: <20241105121009.GH24862@noisy.programming.kicks-ass.net>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
 <20241101162147.284993-3-andrealmeid@igalia.com>
 <20241104112240.GA24862@noisy.programming.kicks-ass.net>
 <8373eb11-d61c-40c4-9289-1047ec35c4d6@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8373eb11-d61c-40c4-9289-1047ec35c4d6@igalia.com>

On Mon, Nov 04, 2024 at 06:55:45PM -0300, André Almeida wrote:
> Hi Peter,
> 
> Em 04/11/2024 08:22, Peter Zijlstra escreveu:
> > On Fri, Nov 01, 2024 at 01:21:46PM -0300, André Almeida wrote:
> > > @@ -1046,24 +1095,44 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
> > >   static void futex_cleanup(struct task_struct *tsk)
> > >   {
> > > +	struct robust_list2_entry *curr, *n;
> > > +	struct list_head *list2 = &tsk->robust_list2;
> > > +
> > >   #ifdef CONFIG_64BIT
> > >   	if (unlikely(tsk->robust_list)) {
> > > -		exit_robust_list64(tsk);
> > > +		exit_robust_list64(tsk, tsk->robust_list);
> > >   		tsk->robust_list = NULL;
> > >   	}
> > >   #else
> > >   	if (unlikely(tsk->robust_list)) {
> > > -		exit_robust_list32(tsk);
> > > +		exit_robust_list32(tsk, (struct robust_list_head32 *) tsk->robust_list);
> > >   		tsk->robust_list = NULL;
> > >   	}
> > >   #endif
> > >   #ifdef CONFIG_COMPAT
> > >   	if (unlikely(tsk->compat_robust_list)) {
> > > -		exit_robust_list32(tsk);
> > > +		exit_robust_list32(tsk, tsk->compat_robust_list);
> > >   		tsk->compat_robust_list = NULL;
> > >   	}
> > >   #endif
> > > +	/*
> > > +	 * Walk through the linked list, parsing robust lists and freeing the
> > > +	 * allocated lists
> > > +	 */
> > > +	if (unlikely(!list_empty(list2))) {
> > > +		list_for_each_entry_safe(curr, n, list2, list) {
> > > +			if (curr->head != NULL) {
> > > +				if (curr->list_type == ROBUST_LIST_64BIT)
> > > +					exit_robust_list64(tsk, curr->head);
> > > +				else if (curr->list_type == ROBUST_LIST_32BIT)
> > > +					exit_robust_list32(tsk, curr->head);
> > > +				curr->head = NULL;
> > > +			}
> > > +			list_del_init(&curr->list);
> > > +			kfree(curr);
> > > +		}
> > > +	}
> > >   	if (unlikely(!list_empty(&tsk->pi_state_list)))
> > >   		exit_pi_state_list(tsk);
> > 
> > I'm still digesting this, but the above seems particularly silly.
> > 
> > Should not the legacy lists also be on the list of lists? I mean, it
> > makes no sense to have two completely separate means of tracking lists.
> > 
> 
> You are asking if, whenever someone calls set_robust_list() or
> compat_set_robust_list() to be inserted into &current->robust_list2 instead
> of using tsk->robust_list and tsk->compat_robust_list?

Yes, that.

