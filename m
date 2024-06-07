Return-Path: <linux-api+bounces-1688-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AC9009CB
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 17:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B891F24CB7
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 15:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5DE199EA0;
	Fri,  7 Jun 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EOhL2dP6"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D073196C6C;
	Fri,  7 Jun 2024 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775994; cv=none; b=QnOm838GUz1u80n+hGsbMVCYPmNpXYnwPibsd0TZZd5w+Ym8GhjpVDygmWR3pqVfQ01mE1a3j9gsZWKDt/omgLM0fmnpRbnwII7rFzLGBV8lZoGBOwra32p/H4Lsq5R8C12JWPPE/GnzW0S3R+qEESeD1x0OuIFgIggDcCwbEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775994; c=relaxed/simple;
	bh=QMZv3PmaJBSN0Uisj1+0w3LHLVgBya6v9buH33ICul8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NacEKKn3Zpt5DKqXmGbRWgZ2K6jXuPiwQRylSjV8CWqnb0j1fYIt3zXl2obc4BvMbJR2hNf0tozferuueixDtl5RT6ISfaBwz+pVzJ/ZTHHN+f2omMNQVD1e2+DANmHFbLuHHFzqhBSXJci6OnXAENn4s6+hSWyvE/TJwiCLWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EOhL2dP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D401AC2BBFC;
	Fri,  7 Jun 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EOhL2dP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717775991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IrCcKC3zcgq1LVkSXlbN/JqWlpCIyvXtoMLRLkbBI24=;
	b=EOhL2dP6PnCvESjNvrDDLZejKvEB0F+xEKh6KPAO3FPzz5Z1DsusxWuX9cHZgxOd+4RV9Q
	bn9apsGlLAvnBQFctmoyLY0AbwPf3mbTLQI67XAYE4cY/owzZQiQtEWMlOc+ALm88vKt4w
	DDCU3QveswwRGR8JDvkSbp4cr7fPlmU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 34f78f04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 15:59:50 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:59:42 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 4/5] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <ZmMubnTe6m_ET-9w@zx2c4.com>
References: <874ja73xx7.ffs@tglx>
 <87v82n2g93.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v82n2g93.ffs@tglx>

On Thu, Jun 06, 2024 at 12:10:00AM +0200, Thomas Gleixner wrote:
> Jason!
> 
> On Wed, Jun 05 2024 at 23:03, Thomas Gleixner wrote:
> > On Tue, May 28 2024 at 14:19, Jason A. Donenfeld wrote:
> >> + */
> >> +#ifdef CONFIG_64BIT
> >> +typedef u64 vdso_kernel_ulong;
> >> +#else
> >> +typedef u32 vdso_kernel_ulong;
> >> +#endif
> >
> > All of this is pointless because if a 32-bit application runs on a
> > 64-bit kernel it has to use the 64-bit 'generation'. So why on earth do
> > we need magic here for a 32-bit kernel?
> >
> > Just use u64 for both and spare all this voodoo. We're seriously not
> > "optimizing" for 32-bit kernels.
> 
> All what happens on a 32-bit kernel is that the RNG will store the
> unsigned long (32bit) generation into a 64bit variable:
> 
> 	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);
> 
> As the upper 32bit are always zero, there is no issue vs. load store
> tearing at all. So there is zero benefit for this aside of slightly
> "better" user space code when running on a 32-bit kernel. Who cares?

Oh yea. Okay, great. I was concerned about the tearing, but I guess it's
really a non issue. So I'll just make it a u64 and all of this
complexity can just go away. Thanks for thinking about it in a less
convoluted way than me.

> While staring at this I wonder where the corresponding
> smp_load_acquire() is. I haven't found one in the VDSO code.
> READ_ONCE() is only equivalent on a few architectures.
> 
> But, what does that store_release() buy at all? There is zero ordering
> vs. anything in the kernel and neither against user space.
> 
> If that smp_store_release() serves a purpose then it really has to be
> extensively documented especially as the kernel itself simply uses
> WRITE/READ_ONCE() for base_rng.generation.

This came up here too: https://lore.kernel.org/all/Y3l6ocn1dTN0+1GK@zx2c4.com/

It's to order the writes to the generation counter and is_ready.

Jason

