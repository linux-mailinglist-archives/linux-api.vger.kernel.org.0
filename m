Return-Path: <linux-api+bounces-2261-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBBD96724D
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 17:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCBA1C2128F
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476BB15E81;
	Sat, 31 Aug 2024 15:02:52 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6021CD2F
	for <linux-api@vger.kernel.org>; Sat, 31 Aug 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725116572; cv=none; b=QiSQB9GEIC9PbHCGccFYqZXkJvEn+qj06dAP/gQigSUnJbCSulyFTWGp3/PD9vn+09ETSdEZH0YqOzrz7wECMux6k+K8+LzQ44X1cUh71fN0T5oOzHkkoeT4jhDEneigDY+W5KV72N4z8YKnSYzqkg5ZKiPN90GwqAsz3udq5k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725116572; c=relaxed/simple;
	bh=YgEYnIFOxCRQ8sXxEqVG+/XVCfKPDEStM7YnuFh/Ygo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZddgnq86WdjUGjzwa96nEsJtgzro1Yaz1xho12Kfwuy8ZLmbm1pFWFeXlZVBk1Kz87CIkkQctgYSiNzOjd27l2fx3QuuZPiRwYSiQTQJWX9XHgHcLDONtJLDIOygbylpoUqsyrGvaqet04Z5Pqa8uzlkQwNn5GTHnjR9Jt4h1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Sat, 31 Aug 2024 11:02:42 -0400
From: Rich Felker <dalias@libc.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com
Subject: Re: [musl] AT_MINSIGSTKSZ mismatched interpretation kernel vs libc
Message-ID: <20240831150241.GP10433@brightrain.aerifal.cx>
References: <20240829205436.GA14562@brightrain.aerifal.cx>
 <20240831092902.GA2724612@port70.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831092902.GA2724612@port70.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Aug 31, 2024 at 11:29:02AM +0200, Szabolcs Nagy wrote:
> * Rich Felker <dalias@libc.org> [2024-08-29 16:54:38 -0400]:
> > As I understand it, the AT_MINSIGSTKSZ auxv value is supposed to be a
> > suitable runtime value for MINSIGSTKSZ (sysconf(_SC_MINSIGSTKSZ)),
> > such that it's safe to pass as a size to sigaltstack. However, this is
> > not how the kernel actually implements it. At least on x86 and
> > powerpc, the kernel fills it via get_sigframe_size, which computes the
> > size of the sigcontext/siginfo/etc to be pushed and uses that
> > directly, without allowing any space for actual execution, and without
> > ensuring the value is at least as large as the legacy constant
> > MINSIGSTKSZ. This leads to two problems:
> > 
> > 1. If userspace uses the value without clamping it not-below
> >    MINSIGSTKSZ, sigaltstack will fail with ENOMEM.
> > 
> > 2. If the kernel needs more space than MINSIGSTKSZ just for the signal
> >    frame structures, userspace that trusts AT_MINSIGSTKSZ will only
> >    allocate enough for the frame, and the program will immediately
> >    crash/stack-overflow once execution passes to userspace.
> > 
> > Since existing kernels in the wild can't be fixed, and since it looks
> > like the problem is just that the kernel chose a poor definition of
> > AT_MINSIGSTKSZ, I think userspace (glibc, musl, etc.) need to work
> > around the problem, adding a per-arch correction term to
> > AT_MINSIGSTKSZ that's basically equal to:
> > 
> >     legacy_MINSIGSTKSZ - AT_MINSIGSTKSZ as returned on legacy hw
> > 
> > such that adding the correction term would reproduce the expected
> > value MINSIGSTKSZ.
> > 
> > The only question is whether the kernel will commit to keeping this
> > behavior, or whether it would be "fixed" to include all the needed
> > working space when they eventually decide they want bigger stacks for
> > some new register file bloat. I think keeping the current behavior, so
> > we can just add a fixed offset, is probably the best thing to do.
> 
> i think it makes sense that the kernel sets AT_MINSIGSTKSZ
> according to what the kernel needs (signal frame size)
> anything beyond that is up to userspace requirements (e.g.
> the kernel cannot know if the libc wraps signal handlers)
> 
> it's up to the libc to adjust sysconf(_SC_MINSIGSTKSZ)
> according to posix or backward compat requirements.

I think this is a reasonable viea and means the aux key was just very
poorly named. It should have been called something like
AT_SIGFRAMESIZE to indicate to the userspace-side consumer that it's
not a suitable value for MINSIGSTKSZ, only a contributing term for it.

Rich

