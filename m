Return-Path: <linux-api+bounces-2263-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584796726D
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 17:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3FA1C206A5
	for <lists+linux-api@lfdr.de>; Sat, 31 Aug 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7B225D7;
	Sat, 31 Aug 2024 15:41:06 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AA1CD2C
	for <linux-api@vger.kernel.org>; Sat, 31 Aug 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725118866; cv=none; b=P6fyRz2U7+vmCPvC6NF/3tfx4qj3qNkMap6CUMAHiIQ1V0zUoGXcpXGhxSzoqfT6HHs3pMv2RGxz2TKTk+QuuCFfx44vD56JA1poHpipW+q4DKQ/dlwAd289XWSZ4Wrly+4a/ytn08zPSch5WkHc3VM2eeuvhSXHk5iWiLJhny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725118866; c=relaxed/simple;
	bh=oKuk+uihC8+lyCJlbGXjelix1Nmfbn5hwmhJYOV5Pd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBjiMajCLghYn8MWbu5ihlyaJEil6zHWBwIZ/Jb39Rz9DtuD8OCoW5gOTlOaRdXPtB5yNHGNOIebm0Iq9ZCSInV6bzbPEkzSFzFXlIKYj6lzYR3xGwrUFGrNtX5n0pzDEN9/XkYz0/RT85tb+FVIzg4Qq/V5etR8zIUWBMzBwc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Sat, 31 Aug 2024 11:41:02 -0400
From: Rich Felker <dalias@libc.org>
To: "H.J. Lu" <hjl.tools@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org, libc-alpha@sourceware.org,
	musl@lists.openwall.com
Subject: Re: [musl] AT_MINSIGSTKSZ mismatched interpretation kernel vs libc
Message-ID: <20240831154101.GN32249@brightrain.aerifal.cx>
References: <20240829205436.GA14562@brightrain.aerifal.cx>
 <20240831092902.GA2724612@port70.net>
 <20240831150241.GP10433@brightrain.aerifal.cx>
 <CAMe9rOqSSX_YP7dq5WK7vDyrQ5RP6nUNrim-8FjJi1X_8NfAvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMe9rOqSSX_YP7dq5WK7vDyrQ5RP6nUNrim-8FjJi1X_8NfAvg@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)

On Sat, Aug 31, 2024 at 08:09:49AM -0700, H.J. Lu wrote:
> On Sat, Aug 31, 2024 at 8:03 AM Rich Felker <dalias@libc.org> wrote:
> >
> > On Sat, Aug 31, 2024 at 11:29:02AM +0200, Szabolcs Nagy wrote:
> > > * Rich Felker <dalias@libc.org> [2024-08-29 16:54:38 -0400]:
> > > > As I understand it, the AT_MINSIGSTKSZ auxv value is supposed to be a
> > > > suitable runtime value for MINSIGSTKSZ (sysconf(_SC_MINSIGSTKSZ)),
> > > > such that it's safe to pass as a size to sigaltstack. However, this is
> > > > not how the kernel actually implements it. At least on x86 and
> > > > powerpc, the kernel fills it via get_sigframe_size, which computes the
> > > > size of the sigcontext/siginfo/etc to be pushed and uses that
> > > > directly, without allowing any space for actual execution, and without
> > > > ensuring the value is at least as large as the legacy constant
> > > > MINSIGSTKSZ. This leads to two problems:
> > > >
> > > > 1. If userspace uses the value without clamping it not-below
> > > >    MINSIGSTKSZ, sigaltstack will fail with ENOMEM.
> > > >
> > > > 2. If the kernel needs more space than MINSIGSTKSZ just for the signal
> > > >    frame structures, userspace that trusts AT_MINSIGSTKSZ will only
> > > >    allocate enough for the frame, and the program will immediately
> > > >    crash/stack-overflow once execution passes to userspace.
> > > >
> > > > Since existing kernels in the wild can't be fixed, and since it looks
> > > > like the problem is just that the kernel chose a poor definition of
> > > > AT_MINSIGSTKSZ, I think userspace (glibc, musl, etc.) need to work
> > > > around the problem, adding a per-arch correction term to
> > > > AT_MINSIGSTKSZ that's basically equal to:
> > > >
> > > >     legacy_MINSIGSTKSZ - AT_MINSIGSTKSZ as returned on legacy hw
> > > >
> > > > such that adding the correction term would reproduce the expected
> > > > value MINSIGSTKSZ.
> > > >
> > > > The only question is whether the kernel will commit to keeping this
> > > > behavior, or whether it would be "fixed" to include all the needed
> > > > working space when they eventually decide they want bigger stacks for
> > > > some new register file bloat. I think keeping the current behavior, so
> > > > we can just add a fixed offset, is probably the best thing to do.
> > >
> > > i think it makes sense that the kernel sets AT_MINSIGSTKSZ
> > > according to what the kernel needs (signal frame size)
> > > anything beyond that is up to userspace requirements (e.g.
> > > the kernel cannot know if the libc wraps signal handlers)
> > >
> > > it's up to the libc to adjust sysconf(_SC_MINSIGSTKSZ)
> > > according to posix or backward compat requirements.
> >
> > I think this is a reasonable viea and means the aux key was just very
> > poorly named. It should have been called something like
> > AT_SIGFRAMESIZE to indicate to the userspace-side consumer that it's
> > not a suitable value for MINSIGSTKSZ, only a contributing term for it.
> >
> > Rich
> 
> glibc manual has
> 
> ‘_SC_MINSIGSTKSZ’
> 
>      Inquire about the minimum number of bytes of free stack space
>      required in order to guarantee successful, non-nested handling of a
>      single signal whose handler is an empty function.
> 
>           ‘MINSIGSTKSZ’
>                This is the amount of signal stack space the operating
>                system needs just to implement signal delivery.  The size
>                of a signal stack *must* be greater than this.
> 
>                For most cases, just using ‘SIGSTKSZ’ for ‘ss_size’ is
>                sufficient.  But if you know how much stack space your
>                program's signal handlers will need, you may want to use
>                a different size.  In this case, you should allocate
>                ‘MINSIGSTKSZ’ additional bytes for the signal stack and
>                increase ‘ss_size’ accordingly.

This is ambiguously worded (does "operating system" mean kernel?) and
does not agree with POSIX, which defines it as:

    Minimum stack size for a signal handler.

And otherwise just specifies that sigaltstack shall fail if given a
smaller size.

The POSIX definition is also underspecified but it's clear that it
should be possible to execute at least a do-nothing signal handler
(like one which immediately returns and whose sole purpose is to
induce EINTR when intalled without SA_RESTART), or even a minimal one
that does something like storing to a global variable, with such a
small stack. Allowing a size where even a do-nothing signal handler
results in a memory-clobbering overflow or access fault seems
non-conforming to me.

The historical sizes all allowed for 1k of execution space on top of
what the historical signal frames consumed, and more for some archs. I
don't think there's a POSIX contract to include that much, but I think
there is a backwards-compatibility motivation to do so. Otherwise
there will be application that were working when
sysconf(_SC_MINSIGSTKSZ) historical_val as the result of
max(value_from_aux,historial_val), but which break catastrophically as
soon as value_from_aux is bigger than historical_val-sigframe_size.

Rich

