Return-Path: <linux-api+bounces-1687-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E256290099C
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 17:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3511C21D9E
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1708199255;
	Fri,  7 Jun 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c1GvCtqY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B8DDD9;
	Fri,  7 Jun 2024 15:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775541; cv=none; b=ZTV14BMwwo2wWe4bbKbBIEFX1D6JwetU1bCfm1j62oxi0/TdH3eFMIHjk59S3Nnd+ITp/UCo+6sT21YujzPqnWPW5gEO6U6gSq7m64R1FX22gjNht4n2sliEeO3AJey7Went8pUzh+SctXWLLPPrTVOmiEu8rCu1Nmf5tt0dRQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775541; c=relaxed/simple;
	bh=H+jEhDsTeSoJa3PREo5ewf9PlBRNnWWXpO7tjlti/rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbjymKmtuc5gIWF91jY2xpwyaOrcClYP14lWlGEDdBub+/c0tRkK5XDZvXGLo7Zb5uUEYy5Tr8ZrxnH5fMfesF5x2cOUtfiLNgx3lfXnHPSVZ903tHTyaBCSXkiGNLuXrXe2LaNZaz9p0AprX4TArlEaPaLCp8Hjs/yDWK6cKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=c1GvCtqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9568C2BBFC;
	Fri,  7 Jun 2024 15:52:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="c1GvCtqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717775537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqZentEsHB+VTIXa72lmbuScoE7+wMZ7RejT1HxIpTo=;
	b=c1GvCtqYeLorT7klYXeKUhlD0Sb4HPPmHB605U7lEehIJJfJEY3gwQ2C1mJ7EeTR0pr6xX
	xO3fDf1X4/xOJMDsK+z6VDFrn6rXq2hcV7xkYUWdNJC9mBR+ZE64xPYmrqtiGgnc+QeBXP
	5lLbyq5T4fZSnwl2GPyaceaCXqFj5f4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 253ee02d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 15:52:17 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:52:12 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 4/5] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <ZmMsrHWTLMS4W08w@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-5-Jason@zx2c4.com>
 <CALCETrUgPwVsMwkxkCyuqBKyqouyejikxxyGuBDxnWWKskYG8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUgPwVsMwkxkCyuqBKyqouyejikxxyGuBDxnWWKskYG8A@mail.gmail.com>

On Fri, May 31, 2024 at 04:06:37PM -0700, Andy Lutomirski wrote:
> > On May 28, 2024, at 5:25 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Provide a generic C vDSO getrandom() implementation, which operates on
> > an opaque state returned by vgetrandom_alloc() and produces random bytes
> > the same way as getrandom(). This has a the API signature:
> >
> >  ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);
> 
> > +/**
> > + * type vdso_kernel_ulong - unsigned long type that matches kernel's unsigned long
> > + *
> > + * Data shared between userspace and the kernel must operate the same way in both 64-bit code and in
> > + * 32-bit compat code, over the same potentially 64-bit kernel. This type represents the size of an
> > + * unsigned long as used by kernel code. This isn't necessarily the same as an unsigned long as used
> > + * by userspace, however.
> 
> Why is this better than using plain u64?  It’s certainly more
> complicated. It also rather fundamentally breaks CRIU on 32-bit
> userspace (although CRIU may well be unable to keep vgetrandom working
> after a restore onto a different kernel anyway).  Admittedly 32-bit
> userspace is a slowly dying breed, but still.

That came out of this conversation: https://lore.kernel.org/all/878rjs7mcx.fsf@oldenburg.str.redhat.com/
(And I'd like single instruction increments, which means long, not u64
on 32-bit machines.)

> > +{
> > +    ssize_t ret = min_t(size_t, INT_MAX & PAGE_MASK /* = MAX_RW_COUNT */, len);
> > +    struct vgetrandom_state *state = opaque_state;
> > +    size_t batch_len, nblocks, orig_len = len;
> > +    unsigned long current_generation;
> > +    void *orig_buffer = buffer;
> > +    u32 counter[2] = { 0 };
> > +    bool in_use, have_retried = false;
> > +
> > +    /* The state must not straddle a page, since pages can be zeroed at any time. */
> > +    if (unlikely(((unsigned long)opaque_state & ~PAGE_MASK) + sizeof(*state) > PAGE_SIZE))
> > +        goto fallback_syscall;
> 
> This is weird. Either the provided pointer is valid or it isn’t.
> Reasonable outcomes are a segfault if the pointer is bad or success
> (or fallback if needed for some reason) if the pointer is good.  Why
> is there specific code to catch a specific sort of pointer screwup
> here?

I guess I could make it return -EFAULT in this case, rather than
silently succeeding.

Jason

