Return-Path: <linux-api+bounces-2666-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474F9BB3F7
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 12:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362491C20E44
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE72B1B6CEF;
	Mon,  4 Nov 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WxMh4so+"
X-Original-To: linux-api@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623FA1B6CE4;
	Mon,  4 Nov 2024 11:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721423; cv=none; b=DA4VKslHKWSb4PnXLMwdX3Sk4NM7TBR7UPCsdx0OCE76cVFK2YRtQWu6OP6VYjaA8pldGVKPPKEKjhsN+ehE+g6vNjSrw9KmhxfLBgZ99WjJbJz+brwJGAeoGble+D8dTVtI921bOlVFC99S2jqxkkoWGwMkz4LYLfXoSKWAYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721423; c=relaxed/simple;
	bh=r1lFvwG4Ey56ZOezKIm2Mdr95YcSIwnrK8MFZ35SdaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc7R8nAckjtHu2EaLj4l5ZDeoSHOTQT2rA1xm6LR4bamjbqkENP1UE2XWnwlcyXI/O3d1KN2hoiN9dq9HK2oLWs/reXEqTV5xR6vif+A0nDPnz4i9mHlLEYKgB1mMI8Wbo6ykG+ao1G0w1GgKn1vIVPdN1XVJ5LqsJRfZa7LWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WxMh4so+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iRoEM6GEnrZLLyzbuybzBos6rr4FNF8HRb/kF1VFH7k=; b=WxMh4so+QSmYVz32LUV3DkfzVz
	/zFhobIxbaLfv1zB3HebUteR8gr/RefnUsBwlwGAJgWZd6ZXGyljPrqTFhu07Q7P7GQ+cb9FefC1H
	TrwMX5yqmyh7RCoCiD3hh2+vQINGzFqf11w6LcnPG8oTNJVUWmo+mtRI9A3cMSdhDL1WaLlxSEPNu
	v/E9SKVXXBHiKrqFpll0OHauDNmpLBFQ8Gzhbc9Md+1pXbArG0y39eEBK8/4kneM/hbGnXDuX1HLZ
	s59Anir4KzF7mCOyTtNc6rsJykySQpBs9tBCMz0otn55Wzwc0IfFNlwhqjzzIG6jj3S7/0+AngAMw
	A4sFHYoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7vhY-0000000BJVo-2xGd;
	Mon, 04 Nov 2024 11:56:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 58FBF300324; Mon,  4 Nov 2024 12:56:56 +0100 (CET)
Date: Mon, 4 Nov 2024 12:56:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	sonicadvance1@gmail.com, linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com, linux-api@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/3] futex: Create set_robust_list2
Message-ID: <20241104115656.GW33184@noisy.programming.kicks-ass.net>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
 <87ldy170x9.fsf@oldenburg.str.redhat.com>
 <20241104113240.GB24862@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104113240.GB24862@noisy.programming.kicks-ass.net>

On Mon, Nov 04, 2024 at 12:32:40PM +0100, Peter Zijlstra wrote:
> On Sat, Nov 02, 2024 at 10:58:42PM +0100, Florian Weimer wrote:
> 
> > QEMU hints towards further problems (in linux-user/syscall.c):
> > 
> >     case TARGET_NR_set_robust_list:
> >     case TARGET_NR_get_robust_list:
> >         /* The ABI for supporting robust futexes has userspace pass
> >          * the kernel a pointer to a linked list which is updated by
> >          * userspace after the syscall; the list is walked by the kernel
> >          * when the thread exits. Since the linked list in QEMU guest
> >          * memory isn't a valid linked list for the host and we have
> >          * no way to reliably intercept the thread-death event, we can't
> >          * support these. Silently return ENOSYS so that guest userspace
> >          * falls back to a non-robust futex implementation (which should
> >          * be OK except in the corner case of the guest crashing while
> >          * holding a mutex that is shared with another process via
> >          * shared memory).
> >          */
> >         return -TARGET_ENOSYS;
> 
> I don't think we can sanely fix that. Can't QEMU track the robust thing
> itself and use waitpid() to discover the thread is gone and fudge things
> from there?

Hmm, what about we mandate 'natural' alignement of the structure such
that it is always inside a single page, then QEMU can do the translation
here and hand the kernel the 'real' address.

