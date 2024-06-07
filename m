Return-Path: <linux-api+bounces-1679-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EFC900774
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 16:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1336E1F2559E
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 14:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075B71A3BC2;
	Fri,  7 Jun 2024 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QJqSFH5T"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF381A3BBF;
	Fri,  7 Jun 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771295; cv=none; b=shDxkn3RWJDlINhG6fLabiocRdvC8269Qq/rm4wbrdC4wqlqumvYsOUOtGhfvkLJ/+pERDlQPSYvqttTU2+I1107yQ/5fmLSEhjed+KG6XT5qpWJTUlSL8YMXldbu4PBAeXbbcxCXNP1u0GfIWcWaY/rzJahlcBLeV8AvpL0sBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771295; c=relaxed/simple;
	bh=67Cmjjs+mbvp8hgrTFlUcb7kFTZmWKvQEO2pH5tlXaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u58UPN4Rm4b8ciG3wS5CNo27Z0+JFqo9Vwoe4M2XZakxjHK1fck5smWWzQnhd8pyid6ULkD4/TQdveOLD0Zx5MoQbzxrmbnBgJgCn+ZDfvIgMdZjIF5E/RdKzngeLzqkGJ8TgKUb2urwLuLc8x8etZc0rDSjZ9PPCWwIVfoLteU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QJqSFH5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B968C2BBFC;
	Fri,  7 Jun 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QJqSFH5T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717771292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+EIdmtDv75Nr8Md5eadi2GKhAGUIxvk75YTwfciZiBU=;
	b=QJqSFH5TO+/pFF4xtukFEo8jhoXBzksBcr8QMsyI2rSkt3NSGB1X4F5ZqV3RGLrLUiTZHc
	ie69rXvVgoszrB2kk03OMwJUcrHB3RoC5tQUOgdZc72TU/2NAkK3nieqFD9iTnsqHSY3YZ
	FM7NCeMcTnKNjYC/pbyJ5FFPEZ+n1d8=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4df9e8cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 14:41:32 +0000 (UTC)
Date: Fri, 7 Jun 2024 16:41:26 +0200
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
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 2/5] random: add vgetrandom_alloc() syscall
Message-ID: <ZmMcFonXPVtU0moO@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-3-Jason@zx2c4.com>
 <20240531035917.GD6505@sol.localdomain>
 <Zlr-aMJdAEgHOj9-@zx2c4.com>
 <20240604172249.GA1566@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604172249.GA1566@sol.localdomain>

On Tue, Jun 04, 2024 at 10:22:49AM -0700, Eric Biggers wrote:
> On Sat, Jun 01, 2024 at 12:56:40PM +0200, Jason A. Donenfeld wrote:
> > On Thu, May 30, 2024 at 08:59:17PM -0700, Eric Biggers wrote:
> > > On Tue, May 28, 2024 at 02:19:51PM +0200, Jason A. Donenfeld wrote:
> > > > +/**
> > > > + * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
> > > > + *
> > > > + * @num:	   On input, a pointer to a suggested hint of how many states to
> > > > + * 		   allocate, and on return the number of states actually allocated.
> > > > + *
> > > > + * @size_per_each: On input, must be zero. On return, the size of each state allocated,
> > > > + * 		   so that the caller can split up the returned allocation into
> > > > + * 		   individual states.
> > > > + *
> > > > + * @addr:	   Reserved, must be zero.
> > > > + *
> > > > + * @flags:	   Reserved, must be zero.
> > > > + *
> > > > + * The getrandom() vDSO function in userspace requires an opaque state, which
> > > > + * this function allocates by mapping a certain number of special pages into
> > > > + * the calling process. It takes a hint as to the number of opaque states
> > > > + * desired, and provides the caller with the number of opaque states actually
> > > > + * allocated, the size of each one in bytes, and the address of the first
> > > > + * state, which may be split up into @num states of @size_per_each bytes each,
> > > > + * by adding @size_per_each to the returned first state @num times, while
> > > > + * ensuring that no single state straddles a page boundary.
> > > > + *
> > > > + * Returns the address of the first state in the allocation on success, or a
> > > > + * negative error value on failure.
> > > > + *
> > > > + * The returned address of the first state may be passed to munmap(2) with a
> > > > + * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
> > > > + * memory, after which it is invalid to pass it to vDSO getrandom().
> > > 
> > > Wouldn't a munmap with '(size_t)num * (size_t)size_per_each' be potentially too
> > > short, due to how the allocation is sized such that states don't cross page
> > > boundaries?
> > 
> > You're right, I think. The calculation should instead be something like:
> > 
> >     DIV_ROUND_UP(num, PAGE_SIZE / size_per_each) * PAGE_SIZE
> > 
> > Does that seem correct to you?
> > 
> 
> Yes, though I wonder if it would be better to give userspace the number of pages
> instead of the number of states.

Or maybe just the number of total bytes allocated? That would match
what's expected to be passed to munmap() and is maybe the easiest to
deal with. I'll give that a shot for v+1.

Jason

