Return-Path: <linux-api+bounces-1673-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 669C28FBA30
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2024 19:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 071E91F22199
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2024 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98736149C4D;
	Tue,  4 Jun 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRX8huRT"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A127148820;
	Tue,  4 Jun 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521772; cv=none; b=qWfRQmld7pB6aL0XtEou4Xno6lt2DNAan/IwsLsLwN/ZQkGOqs86fl3Q0l5mHGEgRGtLfzOdTE0kgqGLnrv8K1p94PF3SGem+N2c2QgNr+uYUlVEaWj/lhGTwi7h63ngnoc66Cv3klfdn1xuhkb2crE6nb1mtQ6AWsWBj2A5Zbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521772; c=relaxed/simple;
	bh=xKwDmlTQgHxY0OuUUcdVyJs4Yi3XufURqPsGe3qRrKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCW90HEW7M+kH7UXimY2DRI0GZc6ChIdZsDs8y7Y4gmupPZA56arLXwUjVjDa73mZgBIYIsAzpmhugO+bE4uaAVJLkw2gAFK+lboltPNL4nlmWVJBQF8Og/AaY2XW7XXCrPZ8BezvgQxmP9zYD9lyIcDcNTN22KzOGfiVymIzoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRX8huRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9BFC2BBFC;
	Tue,  4 Jun 2024 17:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717521771;
	bh=xKwDmlTQgHxY0OuUUcdVyJs4Yi3XufURqPsGe3qRrKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRX8huRTHJdpJsxH0u9OAGIOKUvWIt22seynnj5Xh6CNtBAxPPyJhJvdvj4QJaJzG
	 kiNAXice3ersyCVMJnmCcBd8MaVLhFEcpDElXyqtX3OwFHTfk8Tjw8aI4CxWjAN1D4
	 vRbXrrXLHYX//5binCIN9/yEZLKLR5PAgrCUOeRt2TuGH5p+8wyRrSA3vVAEhG5suQ
	 fissWp3QxeCp/mCSezWQ8sZvK0qaiRbxsPWLyuo1k6RvhBjAZs10ErlbpjCo7P7vtQ
	 hANCAoeWBC2WfVMcUfiDkJqwomlT3P5uY4/YFXy/+gFLSwVtBITp7hZMrJq5adIR7w
	 rcnO7MIcYIp9A==
Date: Tue, 4 Jun 2024 10:22:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Message-ID: <20240604172249.GA1566@sol.localdomain>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-3-Jason@zx2c4.com>
 <20240531035917.GD6505@sol.localdomain>
 <Zlr-aMJdAEgHOj9-@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zlr-aMJdAEgHOj9-@zx2c4.com>

On Sat, Jun 01, 2024 at 12:56:40PM +0200, Jason A. Donenfeld wrote:
> On Thu, May 30, 2024 at 08:59:17PM -0700, Eric Biggers wrote:
> > On Tue, May 28, 2024 at 02:19:51PM +0200, Jason A. Donenfeld wrote:
> > > +/**
> > > + * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
> > > + *
> > > + * @num:	   On input, a pointer to a suggested hint of how many states to
> > > + * 		   allocate, and on return the number of states actually allocated.
> > > + *
> > > + * @size_per_each: On input, must be zero. On return, the size of each state allocated,
> > > + * 		   so that the caller can split up the returned allocation into
> > > + * 		   individual states.
> > > + *
> > > + * @addr:	   Reserved, must be zero.
> > > + *
> > > + * @flags:	   Reserved, must be zero.
> > > + *
> > > + * The getrandom() vDSO function in userspace requires an opaque state, which
> > > + * this function allocates by mapping a certain number of special pages into
> > > + * the calling process. It takes a hint as to the number of opaque states
> > > + * desired, and provides the caller with the number of opaque states actually
> > > + * allocated, the size of each one in bytes, and the address of the first
> > > + * state, which may be split up into @num states of @size_per_each bytes each,
> > > + * by adding @size_per_each to the returned first state @num times, while
> > > + * ensuring that no single state straddles a page boundary.
> > > + *
> > > + * Returns the address of the first state in the allocation on success, or a
> > > + * negative error value on failure.
> > > + *
> > > + * The returned address of the first state may be passed to munmap(2) with a
> > > + * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
> > > + * memory, after which it is invalid to pass it to vDSO getrandom().
> > 
> > Wouldn't a munmap with '(size_t)num * (size_t)size_per_each' be potentially too
> > short, due to how the allocation is sized such that states don't cross page
> > boundaries?
> 
> You're right, I think. The calculation should instead be something like:
> 
>     DIV_ROUND_UP(num, PAGE_SIZE / size_per_each) * PAGE_SIZE
> 
> Does that seem correct to you?
> 

Yes, though I wonder if it would be better to give userspace the number of pages
instead of the number of states.

- Eric

