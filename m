Return-Path: <linux-api+bounces-5935-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA9+HmeCsmm6NAAAu9opvQ
	(envelope-from <linux-api+bounces-5935-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 10:07:51 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0026F5E0
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 10:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C127D305D1D4
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475923A6F04;
	Thu, 12 Mar 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nBRH5hs7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfVvNFlx"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771B3A4538;
	Thu, 12 Mar 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773306291; cv=none; b=l9FH93DjUGzWOUXcADgZnQQv6fK+JwJGV7U28ymx3DU2qdz7+BvCyksVy+xd0PsTGcB98yLN5zbmvIe3d2V26Cga+ngsZSYxC0IZJ6LBZPyL4k55xBoZu/OG7fMAyAxXid7wn/rMmNQhYUHu60MYEeYkfqswEhHH29+E6QAFAo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773306291; c=relaxed/simple;
	bh=zUt/73sadgv2n0eoVhubMQUQr0P527V+yQgNTJAj5MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J53TmcZV7lbgWyo9z+/HGdSiZbHOlN9/H5VtNdxu5Eb5Pq/uTbK9jgqSmUYX64jxrArthWKrgFCUkcHXCqNbUGhtO9Wet7fYTFwRRIEM/Vl/1eXgRvxZiAtYYsTTkAbT2mij5Mwb4K+x6k/BzffwPbnLOmJQEH4bTFtprRqnUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nBRH5hs7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SfVvNFlx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 12 Mar 2026 10:04:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773306286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCM2GTtTve8DoP3IS8jDJxJSSfxuficzqGbhXkXGk14=;
	b=nBRH5hs7fhUyiIJiNOq9hmt1qw71ncr3ntkZaVnckSa59kcGjS+O5RiBCuZhVQS0sy1hpH
	reA0MBVf4MyHeWBwSMlbmpguBw0lBlX9C4Pt/wbxO79iIZmWIF9NB1yQP7b1JcLc3UcQUb
	OZ2fi3zsHAPkwdv1HyqfUCLdyOuf6346xUEla2oY2Pc0D8NKxdJlmGh3FXJeCU8jzlHk+A
	5x6+oQKr61DDVoHvEsoCvI1TILqsyuPbg7QGxMupvI6RAMUJmSbY3CKpZkeR/0tZYe1B2X
	UIqcjPWm4Z6fMcBbp3O7fJGpUSK+dIbxCC6HFhgcf0M70HYki+xaMXks84qHjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773306286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCM2GTtTve8DoP3IS8jDJxJSSfxuficzqGbhXkXGk14=;
	b=SfVvNFlx6BUFFtreRlTnJwIDzWskehA3gy3jVD3xn74IEBI6AR5RjiLUiph2bRzrEEkYQI
	DtP9IN/D8OPckcCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Carlos O'Donell <carlos@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Florian Weimer <fweimer@redhat.com>,
	Rich Felker <dalias@aerifal.cx>,
	Torvald Riegel <triegel@redhat.com>,
	Darren Hart <dvhart@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, kernel-dev@igalia.com,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] futex: Create reproducer for robust_list race
 condition
Message-ID: <20260312090445.4Zabebfp@linutronix.de>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <20260220202620.139584-2-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260220202620.139584-2-andrealmeid@igalia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5935-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: F3C0026F5E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-02-20 17:26:19 [-0300], Andr=C3=A9 Almeida wrote:
> --- /dev/null
> +++ b/robust_bug.c
=E2=80=A6
> +	new->value =3D ((uint64_t) value << 32) + value;
> +
> +	/* Create a backup of the current value */
> +	original_val =3D new->value;

Now that I finally got it and I might have understood the issue.

You exit before unlocking the futex. You free this block and this new
memory (address) is the same as the old one. Your corruption comes from
the fact that the old content is the same as the new content.

If the thread does unlock in userland (or kernel) but the lock remains
on the robust_list while it gets killed then the kernel will attempt to
unlock the lock. But this requires that the futex value matches the
value.
So if it is unlocked (0x0) or used again then nothing happens. Unless
the new memory gets the same value assigned as the pid value by
accident. Then it gets changed=E2=80=A6

If the unlock did not happen and is still owned by the thread, that is
killed, then the "fixup" here is the right thing to do. The memory
should not be free()ed because the lock was still owned by the thread.
The misunderstanding here might be "once the thread is gone, the lock is
free we can throw away the memory". At the very least, it was a locked
mutex and I think pthread_mutex_destroy() would complain here.

So is the issue here that the "new" value is the same as the "old" value
and the robust-death-handle part in the kernel does its job? Or did I
over simplify something?
Let me continue with the thread=E2=80=A6

Sebastian

