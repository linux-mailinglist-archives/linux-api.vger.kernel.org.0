Return-Path: <linux-api+bounces-1680-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA77900795
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3311C23624
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 14:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B819AD9E;
	Fri,  7 Jun 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hwxz4S60"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816975465B;
	Fri,  7 Jun 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771513; cv=none; b=thNvx5wTg+EOYMkI9a2ukxOhEiFBhxiYpogRvt6BewIGLOwP4YWEGlOEid2mFw/qFJiCvfdu1B+qPpxeKSKP1Oi753K36zeoxkplvGMzROCPEKs9DJthHJxjwXCOG6BQE7l+PEB53zstJvTSxuXvtICnsymJW0UWnoFDYZ54Lo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771513; c=relaxed/simple;
	bh=MDofwAXepnX5w1Xp3fTdja2xd1Wu/zbRCc01yrBXc3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1ruo/xf8MQCmnbNF0pkj/LRQqg0dqah0txaUZ/laSMi10NLeLZIItw7deXchgY4QviNrZkdWYYaatzvkoeZXhz6TgaV//P1LtRjoLTslobaqUrddGlDpLjC4BnXsAgNg4xQarhIfTpucf9DulEnqEXizMH+J2kNPJJG2PdFfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Hwxz4S60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6668EC2BBFC;
	Fri,  7 Jun 2024 14:45:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Hwxz4S60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717771510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bDacixIrBWfVmsMZ4G2zcBRlCAJOLZ4a0Zmmv7o0EkY=;
	b=Hwxz4S60Bgb7ppeABfv4VUsOxv4HsmRAsAL9M4ub8QoNfb+yQ7H6ImBo99a6vFI0zfVaOb
	qxZI1BFQBNJlJ8mB4lL5vZE0hoxlUaAF207N2gZvS+/aJ/Iy0DLgpZCLz93DbIJg2zwo8k
	6taQnNCVQ6nc+LOkdEkc6P2zk/SWVVw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 428e2fd8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 14:45:09 +0000 (UTC)
Date: Fri, 7 Jun 2024 16:45:03 +0200
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
Message-ID: <ZmMc7wfe3ItVVlRn@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-3-Jason@zx2c4.com>
 <20240531035917.GD6505@sol.localdomain>
 <Zlr-aMJdAEgHOj9-@zx2c4.com>
 <20240604172249.GA1566@sol.localdomain>
 <ZmMcFonXPVtU0moO@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZmMcFonXPVtU0moO@zx2c4.com>

On Fri, Jun 07, 2024 at 04:41:26PM +0200, Jason A. Donenfeld wrote:
> On Tue, Jun 04, 2024 at 10:22:49AM -0700, Eric Biggers wrote:
> > On Sat, Jun 01, 2024 at 12:56:40PM +0200, Jason A. Donenfeld wrote:
> > > On Thu, May 30, 2024 at 08:59:17PM -0700, Eric Biggers wrote:
> > > > On Tue, May 28, 2024 at 02:19:51PM +0200, Jason A. Donenfeld wrote:
> > > > > +/**
> > > > > + * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
> > > > > + *
> > > > > + * @num:	   On input, a pointer to a suggested hint of how many states to
> > > > > + * 		   allocate, and on return the number of states actually allocated.
> > > > > + *
> > > > > + * @size_per_each: On input, must be zero. On return, the size of each state allocated,
> > > > > + * 		   so that the caller can split up the returned allocation into
> > > > > + * 		   individual states.
> > > > > + *
> > > > > + * @addr:	   Reserved, must be zero.
> > > > > + *
> > > > > + * @flags:	   Reserved, must be zero.
> > > > > + *
> > > > > + * The getrandom() vDSO function in userspace requires an opaque state, which
> > > > > + * this function allocates by mapping a certain number of special pages into
> > > > > + * the calling process. It takes a hint as to the number of opaque states
> > > > > + * desired, and provides the caller with the number of opaque states actually
> > > > > + * allocated, the size of each one in bytes, and the address of the first
> > > > > + * state, which may be split up into @num states of @size_per_each bytes each,
> > > > > + * by adding @size_per_each to the returned first state @num times, while
> > > > > + * ensuring that no single state straddles a page boundary.
> > > > > + *
> > > > > + * Returns the address of the first state in the allocation on success, or a
> > > > > + * negative error value on failure.
> > > > > + *
> > > > > + * The returned address of the first state may be passed to munmap(2) with a
> > > > > + * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
> > > > > + * memory, after which it is invalid to pass it to vDSO getrandom().
> > > > 
> > > > Wouldn't a munmap with '(size_t)num * (size_t)size_per_each' be potentially too
> > > > short, due to how the allocation is sized such that states don't cross page
> > > > boundaries?
> > > 
> > > You're right, I think. The calculation should instead be something like:
> > > 
> > >     DIV_ROUND_UP(num, PAGE_SIZE / size_per_each) * PAGE_SIZE
> > > 
> > > Does that seem correct to you?
> > > 
> > 
> > Yes, though I wonder if it would be better to give userspace the number of pages
> > instead of the number of states.
> 
> Or maybe just the number of total bytes allocated? That would match
> what's expected to be passed to munmap() and is maybe the easiest to
> deal with. I'll give that a shot for v+1.

Hmm, though, on second thought,

 * @num:           On input, a pointer to a suggested hint of how many states to
 *                 allocate, and on return the number of states actually allocated.

This is kind of elegant -- it's an in/out param. Changing the semantics
of the out param isn't super obvious. And bytes means it should probably
be a long too. So maybe I'll keep it as is, and fix the documentation to
have the right calculation.

Jason

