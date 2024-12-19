Return-Path: <linux-api+bounces-2944-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EB79F8189
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2024 18:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F9F16CADD
	for <lists+linux-api@lfdr.de>; Thu, 19 Dec 2024 17:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A318E047;
	Thu, 19 Dec 2024 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RugdJjn0"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744B15442C;
	Thu, 19 Dec 2024 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734628437; cv=none; b=loxSIEUTmX/3CVIEPiPnIxdkeAk+gqNI7kZQwn35M200PftZk+kboa0ZG12DeiCatKhUnyFnlQv9cRNZFKMuosYUr2MbUD7Ri7ZBqYTA/+9pkqE6pNLB9PyI2g9FvgmZeSdp/rDgPpTl1TUeu88cALSAf9dWVrFJA/DdZmWwPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734628437; c=relaxed/simple;
	bh=aJ281mhDOqQq9dy8oZzUE33Q6YzkZAZfHWj9CkICAiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmiOSTYzoQnJQmhRzQ3ZiaJjMRflezMt6tivIu0N4+wTKYzTf3AeH+zl3p0tNjV5C0YHH6KxqV+B/1lpzxKoq96v08NNFL1R/tIoFJGylHZwleGfaQjncki/NdoePnyLlYr788S3At6GBWQtFi0ksYiWbq/dGjlxH8YT7o62Jvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RugdJjn0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=S+bfeAXqEEU9O6d6+t+M18x+vAJ2Nrs/borzGCD3Vns=; b=RugdJjn0NNjiSEWUg5w8qq7v+M
	zuvmdBylrOMJ90WQfPvtHjoPBOeLVBWyhRHzQatKVTCVe4kWbeoDq0B/oNoPtBehSCbvJREWRob7e
	oQ2uiH7PIcL1s0svEM/L1/2m6ooH/Abq4Sye5ftsgqWzgydld44chvmAq4YTSqYLQj9bRZZACLu40
	w+EE/2wS2sFrct+AgnGzc7CDIDuCzpJlPOidGpEAPXtyTluXd/PIy5h8IzZZq+zTKeWUf66Srw84k
	+nxtEesBZZyKx6ha8ajFge3yWHx5aJr5NYRm8pOw/68VY4KayIC+6HyaaFKVmukEF9DdzfzQqLK7c
	gWkyJPKQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tOK5p-00000004UUH-0yjq;
	Thu, 19 Dec 2024 17:13:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 033813003FF; Thu, 19 Dec 2024 18:13:45 +0100 (CET)
Date: Thu, 19 Dec 2024 18:13:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Vinicius Peixoto <vpeixoto@lkcamp.dev>, fweimer@redhat.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 0/3] futex: Create set_robust_list2
Message-ID: <20241219171344.GA26279@noisy.programming.kicks-ass.net>
References: <20241217174958.477692-1-andrealmeid@igalia.com>
 <20241217203140.GH11133@noisy.programming.kicks-ass.net>
 <a9b1dde0-7c29-41c3-99be-4749281e25ea@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9b1dde0-7c29-41c3-99be-4749281e25ea@igalia.com>

On Thu, Dec 19, 2024 at 11:28:27AM -0300, André Almeida wrote:
> Em 17/12/2024 17:31, Peter Zijlstra escreveu:
> > On Tue, Dec 17, 2024 at 02:49:55PM -0300, André Almeida wrote:
> > > This patch adds a new robust_list() syscall. The current syscall
> > > can't be expanded to cover the following use case, so a new one is
> > > needed. This new syscall allows users to set multiple robust lists per
> > > process and to have either 32bit or 64bit pointers in the list.
> > 
> > Last time a whole list of short comings of the current robust scheme
> > were laid bare. I feel we should address all that if we're going to
> > create a new scheme.
> > 
> 
> Are you talking about [1] or is there something else?
> 
> [1] https://lore.kernel.org/lkml/87jzdjxjj8.fsf@oldenburg3.str.redhat.com/

Correct, that thread.

So at the very least I think we should enforce natural alignment of the
robust entry -- this ensures the whole object is always on a single
page. This should then allow emulators (like QEMU) to convert things
back to native address space.

Additionally, I think we can replace the LIST_LIMIT -- whoes purpose is
to mitigate the danger of loops -- with the kernel simply destroying the
list while it iterates it. That way it cannot be caught in loops, no
matter what userspace did.

That then leaves the whole munmap() race -- and I'm not really sure what
to do about that one. I did outline two option, but they're both quite
terrible.

The mmap()/munmap() code would need to serialize against list_op_pending
without incurring undue overhead in the common case.

Ideally we make the whole thing using RSEQ such that list_op_pending
becomes atomic vs preemption -- but I've not thought that through.

