Return-Path: <linux-api+bounces-2665-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C49BB381
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 12:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533DF1F23269
	for <lists+linux-api@lfdr.de>; Mon,  4 Nov 2024 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ED01B0F26;
	Mon,  4 Nov 2024 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k0a7qXn5"
X-Original-To: linux-api@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92115B97D;
	Mon,  4 Nov 2024 11:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730719972; cv=none; b=n3RMIZp7+QbSl7oPGVg8iFJSxuLXiekcOvEG8PRzRrz+oPmFzjHOyTY7Fwc5Une7fQ6M/hQUyKvT9DvmKZLpkjsHgY812RyWuvUuvGwo6kD/ZAAefOoB6F38b8M3c9XrCqGfXn+l2UWmuwm5WaYfsZkslbY9JcLRuIwfnq7YCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730719972; c=relaxed/simple;
	bh=rBO7w7nz8IYviAX1BUMrSFsTKK2vbG0eTeURGUP/aIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP/1ZvR8cNSKTOlHYC5GCCGQtlcvGNvQkevwB5gbX8Qwfr3XUCry5Lx+3zzM0R2su9eOA6N+ORlJAwydbpk6panxpQ0Pw4iPxHaAVDfFUJubPS3K8wTAlmSqm5XJHh/+36irfZVTqtT4XUiaTcHkbasOI8XpnVMbS/MhtOYO/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k0a7qXn5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BHpl1stRNcKUhfO8nh0FsJ9Z+el0uh1zfXKfLPvp/aE=; b=k0a7qXn5V4Zlb6eq+YMJGtAHwo
	1lFqnfoakT4Iv4GM5pYF95r1JA9Ga2IMWi6t6IiieB6x3IhH7AMqCHA7ZxNgeeJngrQK7A/QEJLQz
	5gdbgSQ1A/b/wuh1EKaSmmPWi4KpOMw0BIDHA3ENhggeGgEfpIRboN9m6mkm7QE85viDBgLWs/Qvk
	CpwMQqqsr5vxookhrcmxMyj8xB69MROGxy+CL81P4CUgiUVkB+JPqOULjNSopuupy7ulqFiei2HRX
	Nb4InjtU7kfpj2RFlaCCl8QmT/dbCVKITjhihkNnMbKHPzQEeSHuIYK1LEpzsqql26mUvCflrKLaE
	vcDTi0Ng==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t7vK6-0000000BJJu-044J;
	Mon, 04 Nov 2024 11:32:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5EB33006AB; Mon,  4 Nov 2024 12:32:40 +0100 (CET)
Date: Mon, 4 Nov 2024 12:32:40 +0100
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
Message-ID: <20241104113240.GB24862@noisy.programming.kicks-ass.net>
References: <20241101162147.284993-1-andrealmeid@igalia.com>
 <87ldy170x9.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldy170x9.fsf@oldenburg.str.redhat.com>

On Sat, Nov 02, 2024 at 10:58:42PM +0100, Florian Weimer wrote:

> QEMU hints towards further problems (in linux-user/syscall.c):
> 
>     case TARGET_NR_set_robust_list:
>     case TARGET_NR_get_robust_list:
>         /* The ABI for supporting robust futexes has userspace pass
>          * the kernel a pointer to a linked list which is updated by
>          * userspace after the syscall; the list is walked by the kernel
>          * when the thread exits. Since the linked list in QEMU guest
>          * memory isn't a valid linked list for the host and we have
>          * no way to reliably intercept the thread-death event, we can't
>          * support these. Silently return ENOSYS so that guest userspace
>          * falls back to a non-robust futex implementation (which should
>          * be OK except in the corner case of the guest crashing while
>          * holding a mutex that is shared with another process via
>          * shared memory).
>          */
>         return -TARGET_ENOSYS;

I don't think we can sanely fix that. Can't QEMU track the robust thing
itself and use waitpid() to discover the thread is gone and fudge things
from there?



