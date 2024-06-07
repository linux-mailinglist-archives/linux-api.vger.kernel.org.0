Return-Path: <linux-api+bounces-1682-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F22FE9008D3
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC0B28475D
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29BC195804;
	Fri,  7 Jun 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JchN3m4z"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFE1847;
	Fri,  7 Jun 2024 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774078; cv=none; b=LKIYP4eHIuS4he5qL+GTJGoSe1/jGl1YNvBTLnJrdNEWhuUCOa41UOhXklesDw37BhsEFY3juFAwEgj2WvyNfhAjMsD95xV5rtaFFY8pdaL9r4DecxaUnABhM2MrMH4NAHeoIylSozndYet7NQoPTAst40fR4rLozNZWfwPH/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774078; c=relaxed/simple;
	bh=P/YbumUPM+t2AaDNeert9K+Jx7rn/xxprrOoW3WsZ9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCf9vTwo5SkeX11NvP7CxRJZkaKMK5JRkf7yZ0h5iTRMZqvCerrAbR1OjocVkHyJAsE8MhBxnv7aWfMV339BTsTcy+mC39Uo8HX4SSkLOVCosbhWZNr1NC9ecsdum7kRqc3lhmwYhx2gS6P/QG7kLSrQQ/KnEo5mFbr8kCxyxbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JchN3m4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7859C2BBFC;
	Fri,  7 Jun 2024 15:27:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JchN3m4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717774074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YsYZysmZOz+rjz2UIAQvDP7KIxMgRdVS/iAMlBqzJ08=;
	b=JchN3m4zH+7QZAb2BrkMCsdVzZfGZTRkcqyh0YZcXQMo/VAqNIDqF6RrDQZl2XWvK5VzaF
	UuM5uJKJD3YE910OtDWhyNav7RwWGU22R4hyiqU3Ar2XayG3Cpqo2jMnJglWcEFMlozuj7
	IflCKKS4ulWI0sSSTbHIK4TjvWEIkXM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 48f525ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 15:27:53 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:27:45 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>,
	Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v16 5/5] x86: vdso: Wire up getrandom() vDSO
 implementation
Message-ID: <ZmMm8Z5vx5HvME5M@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-6-Jason@zx2c4.com>
 <20240531033816.GC6505@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531033816.GC6505@sol.localdomain>

On Thu, May 30, 2024 at 08:38:16PM -0700, Eric Biggers wrote:
> On Tue, May 28, 2024 at 02:19:54PM +0200, Jason A. Donenfeld wrote:
> > diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
> > new file mode 100644
> > index 000000000000..d79e2bd97598
> > --- /dev/null
> > +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> > @@ -0,0 +1,178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/frame.h>
> > +
> > +.section	.rodata, "a"
> > +.align 16
> > +CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
> > +.text
> > +
> > +/*
> > + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> > + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> > + * counter. Importantly does not spill to the stack. Its arguments are:
> > + *
> > + *	rdi: output bytes
> > + *	rsi: 32-byte key input
> > + *	rdx: 8-byte counter input/output
> > + *	rcx: number of 64-byte blocks to write to output
> > + */
> > +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> > +
> > +.set	output,		%rdi
> > +.set	key,		%rsi
> > +.set	counter,	%rdx
> > +.set	nblocks,	%rcx
> > +.set	i,		%al
> > +/* xmm registers are *not* callee-save. */
> > +.set	state0,		%xmm0
> > +.set	state1,		%xmm1
> > +.set	state2,		%xmm2
> > +.set	state3,		%xmm3
> > +.set	copy0,		%xmm4
> > +.set	copy1,		%xmm5
> > +.set	copy2,		%xmm6
> > +.set	copy3,		%xmm7
> > +.set	temp,		%xmm8
> > +.set	one,		%xmm9
> 
> An "interesting" x86_64 quirk: in SSE instructions, registers xmm0-xmm7 take
> fewer bytes to encode than xmm8-xmm15.
> 
> Since 'temp' is used frequently, moving it into the lower range (and moving one
> of the 'copy' registers, which isn't used as frequently, into the higher range)
> decreases the code size of __arch_chacha20_blocks_nostack() by 5%.

That's a nice trick. Thank you very much for it.

Jason

