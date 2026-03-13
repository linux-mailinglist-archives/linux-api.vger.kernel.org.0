Return-Path: <linux-api+bounces-5941-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qERHMJAftGnahgAAu9opvQ
	(envelope-from <linux-api+bounces-5941-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:30:40 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C59285031
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0A18301C3E8
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0839A06D;
	Fri, 13 Mar 2026 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8HoT/+A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fdfUmA/T"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3236C0C6;
	Fri, 13 Mar 2026 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411856; cv=none; b=QwSVKOBLBaCtLLWMcPTmRbyAo05cyJpyfOFdZ9qCnvM7++ca8RIpBXMmlvJAWG00yNrPWXYUOI2vfvI+hDuAS3tzq4ihDkUzaV4JRjtLyhXNWiSpDYUBBIzUGiZnDjy72Ik8hnVsWCdNSC0bk1LgATglCZAlFTMMI5L3nDghmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411856; c=relaxed/simple;
	bh=etaSoMUQgmERrLvv1mmnLYahdrrDeIWdGGvXt0LAVHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnrskrLGAoiw0Rx1kbReNk9beMVLkcJTKJP4nNNEMx+6siZviH36LUp207qBFmEdKxFHPcNKmoTOupmxZ13JkQ4ABkLz2PM/V6d5IkT3l4wuEdKrwa+POE2OACzth78YKrsX0xxLYPq6NitcAMOYg+t7q5goTZQF+Rp6Jr7cKUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8HoT/+A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fdfUmA/T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Mar 2026 15:24:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773411852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CxBbyKHOZ/3WfKU+JXvCeC5L+J7e0qC13VHoXIr/qkE=;
	b=h8HoT/+A4ybTCEuhk2Y3CWXhcErfz45yoCMZQoKLC/skGveq2ZZmNoixjTRYUG69Myi/gC
	NNoIcFPsqF6bsGbBRbHaDAAuwvx5C5IkS/CJBjMy9HAUEx1dm84YXtVkr5oOF0K46cpaTr
	L7vQuLeDUh1U0d7jDbj5Uf3cZ0k8eFHECy+Ac1rIoimrFMh3g5wcs95aPb8+kOf2kaaG4Y
	MRA5LzQ1UYPLFp6et530IfY2ivjoU51Kx5Xb4rPxWHxbAw0uZ7ouON6BoQVKTpG8Mcd5FG
	Gb6AwHNvNlWYpjLipVNM70xymJN1HaX7rnRM8L65rFm+JeDAunN+JQJOvOjddw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773411852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CxBbyKHOZ/3WfKU+JXvCeC5L+J7e0qC13VHoXIr/qkE=;
	b=fdfUmA/TF2aVQHAFaz7p1xL+IKfpbUOVA3qBv0TfaE/Ya4Oy/UQrUOHVvyqmICbN3qmzg3
	VvXMTbYueHwnceCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
	linux-kernel@vger.kernel.org, Carlos O'Donell <carlos@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, 
	Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
	Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH v4] futex: Introduce __vdso_robust_futex_unlock and
 __vdso_robust_pi_futex_try_unlock
Message-ID: <20260313150111-64c38feb-825d-433e-9c71-f4f109b8cbfb@linutronix.de>
References: <20260313133903.2202079-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313133903.2202079-1-mathieu.desnoyers@efficios.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5941-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thomas.weissschuh@linutronix.de,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,checkpatch.pl:url,linutronix.de:dkim,linutronix.de:mid,efficios.com:email]
X-Rspamd-Queue-Id: 27C59285031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mathieu,

some small remarks around the vDSO code.

On Fri, Mar 13, 2026 at 09:39:03AM -0400, Mathieu Desnoyers wrote:

(...)

> The approach taken to fix this is to introduce two vDSO and extend the
> x86 vDSO exception table to track the relevant ip ranges: one for non-PI
> robust futexes, and one for PI robust futexes.

One of the central points behind the vDSO so far was that it is only a
performance optimization. It is never required for correctness.
What are applications supposed to do when the vDSO is disabled?

(...)

> diff --git a/arch/x86/entry/vdso/common/vfutex.c b/arch/x86/entry/vdso/common/vfutex.c
> new file mode 100644
> index 000000000000..336095b04952
> --- /dev/null
> +++ b/arch/x86/entry/vdso/common/vfutex.c
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + */
> +#include <linux/types.h>
> +#include <linux/futex.h>

This should be uapi/linux/futex.h. Headers from the linux/ namespace should
not be used in vDSO code. The definitions from them may end up being wrong
in the compat vDSO. Either use uapi/ or vdso/ headers. (linux/types.h is a bit
of an exception for historic reasons, it could be replaced by uapi/linux/types.h)

> +#include <vdso/futex.h>
> +#include "extable.h"

> +
> +#ifdef CONFIG_X86_64

This only works because of the ugly hacks in fake_32bit_build.h.
Testing for '#ifdef __x86_64__' is simpler and nicer to read.

> +# define ASM_PTR_BIT_SET	"btsq "
> +# define ASM_PTR_SET		"movq "
> +#else
> +# define ASM_PTR_BIT_SET	"btsl "
> +# define ASM_PTR_SET		"movl "
> +#endif
> +
> +u32 __vdso_robust_futex_unlock(u32 *uaddr, struct robust_list_head *robust_list_head)
> +{
> +	u32 val = 0;
> +
> +	/*
> +	 * Within the ip range identified by the futex exception table,
> +	 * the register "eax" contains the value loaded by xchg. This is
> +	 * expected by futex_vdso_exception() to check whether waiters
> +	 * need to be woken up. This register state is transferred to
> +	 * bit 1 (NEED_ACTION) of *op_pending_addr before the ip range
> +	 * ends.
> +	 */
> +	asm volatile (
> +		_ASM_VDSO_EXTABLE_FUTEX_HANDLE(1f, 3f)
> +		/* Exchange uaddr (store-release). */
> +		"xchg %[uaddr], %[val]\n\t"
> +		"1:\n\t"
> +		/* Test if FUTEX_WAITERS (0x80000000) is set. */
> +		"test %[val], %[val]\n\t"
> +		"js 2f\n\t"
> +		/* Clear *op_pending_addr if there are no waiters. */
> +		ASM_PTR_SET "$0, %[op_pending_addr]\n\t"
> +		"jmp 3f\n\t"
> +		"2:\n\t"
> +		/* Set bit 1 (NEED_ACTION) in *op_pending_addr. */
> +		ASM_PTR_BIT_SET "$1, %[op_pending_addr]\n\t"
> +		"3:\n\t"
> +		: [val] "+a" (val),
> +		  [uaddr] "+m" (*uaddr)
> +		: [op_pending_addr] "m" (robust_list_head->list_op_pending)
> +		: "memory"
> +	);
> +	return val;
> +}
> +
> +u32 robust_futex_unlock(u32 *, struct robust_list_head *)
> +	__attribute__((weak, alias("__vdso_robust_futex_unlock")));

__weak and __alias() as per checkpatch.pl.

The entries in the linkerscripts are missing.

(...)

> --- /dev/null
> +++ b/include/vdso/futex.h
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> + */
> +
> +#ifndef _VDSO_FUTEX_H
> +#define _VDSO_FUTEX_H
> +
> +#include <linux/types.h>
> +#include <linux/futex.h>

Same remarks about the linux/ namespace as before.

> +/**
> + * __vdso_robust_futex_unlock - Architecture-specific vDSO implementation of robust futex unlock.
> + * @uaddr:		Lock address (points to a 32-bit unsigned integer type).
> + * @robust_list_head:	The thread-specific robust list that has been registered with set_robust_list.
> + *
> + * This vDSO unlocks the robust futex by exchanging the content of
> + * *@uaddr with 0 with a store-release semantic. If the futex has
> + * waiters, it sets bit 1 of *@robust_list_head->list_op_pending, else
> + * it clears *@robust_list_head->list_op_pending. Those operations are
> + * within a code region known by the kernel, making them safe with
> + * respect to asynchronous program termination either from thread
> + * context or from a nested signal handler.
> + *
> + * Returns:	The old value present at *@uaddr.
> + *
> + * Expected use of this vDSO:
> + *
> + * robust_list_head is the thread-specific robust list that has been
> + * registered with set_robust_list.
> + *
> + * if ((__vdso_robust_futex_unlock((u32 *) &mutex->__data.__lock, robust_list_head)
> + *     & FUTEX_WAITERS) != 0)
> + *         futex_wake((u32 *) &mutex->__data.__lock, 1, private);
> + * WRITE_ONCE(robust_list_head->list_op_pending, 0);
> + */
> +extern u32 __vdso_robust_futex_unlock(u32 *uaddr, struct robust_list_head *robust_list_head);

Drop the extern.

(...)

> +#endif /* _VDSO_FUTEX_H */

(...)

