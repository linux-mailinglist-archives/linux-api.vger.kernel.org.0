Return-Path: <linux-api+bounces-1667-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BA28D6F67
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2024 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DDFB20CEF
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2024 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD414EC41;
	Sat,  1 Jun 2024 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jxWlgk+Z"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E5A208A4;
	Sat,  1 Jun 2024 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717239409; cv=none; b=LuVD/gsEYlVkpfF5/3r6BmZ12r23hMeNMaZxSQT0JmfV0tWgizr4SEeRx0ABykp7xjgvN5xM0pdm+UJocHjgQHs3qSZvGncACnF1Egv3zeTtvepGsUuHNFv+8loTrQde5/ejdnQixwzF8RCpJ3cZJTCFpPxBY9vzVlhlLkg2oj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717239409; c=relaxed/simple;
	bh=41DY8TV8S+YxvFiEAbKmnGhANeol4FJ3Mp4MdCpmIck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l71T74QMv8ruHcPdlJ3OYw4jLXLBqTIMODQ5BJTIfjAb7jlOMz7G0AXbczP7CdlBzmukeilcRMZKn7Rwi718Rx5Pm//m2YKTp0NG13JmarfF35Lk7aoLGyTe5Ese/bAjtZou7CZzP0U/vS86GBee1ocUgjE1AgKylqyvQiyGJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=jxWlgk+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF40C116B1;
	Sat,  1 Jun 2024 10:56:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jxWlgk+Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717239405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F3C8N1q5G5CmnDvpi3COJ8xyMm2eULKtCWXP4Sq6GaE=;
	b=jxWlgk+ZWOpZZh5mjiYsYeT/ujL0Csc153a4DS7n5KhpFm2UZaHWVIpItNQEQwnh76T0Vp
	VN/fbYyhjP/HQWQEvumkcMGyMOUQjoLcxrXSQSoVRzyBcc0pSpukUXkcdDReiYMpvZ9t5N
	qRJXEQKGpsiYqCh4XdXcwNEkBWpL4zw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c390d7bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 1 Jun 2024 10:56:43 +0000 (UTC)
Date: Sat, 1 Jun 2024 12:56:40 +0200
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
Message-ID: <Zlr-aMJdAEgHOj9-@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-3-Jason@zx2c4.com>
 <20240531035917.GD6505@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531035917.GD6505@sol.localdomain>

On Thu, May 30, 2024 at 08:59:17PM -0700, Eric Biggers wrote:
> On Tue, May 28, 2024 at 02:19:51PM +0200, Jason A. Donenfeld wrote:
> > +/**
> > + * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
> > + *
> > + * @num:	   On input, a pointer to a suggested hint of how many states to
> > + * 		   allocate, and on return the number of states actually allocated.
> > + *
> > + * @size_per_each: On input, must be zero. On return, the size of each state allocated,
> > + * 		   so that the caller can split up the returned allocation into
> > + * 		   individual states.
> > + *
> > + * @addr:	   Reserved, must be zero.
> > + *
> > + * @flags:	   Reserved, must be zero.
> > + *
> > + * The getrandom() vDSO function in userspace requires an opaque state, which
> > + * this function allocates by mapping a certain number of special pages into
> > + * the calling process. It takes a hint as to the number of opaque states
> > + * desired, and provides the caller with the number of opaque states actually
> > + * allocated, the size of each one in bytes, and the address of the first
> > + * state, which may be split up into @num states of @size_per_each bytes each,
> > + * by adding @size_per_each to the returned first state @num times, while
> > + * ensuring that no single state straddles a page boundary.
> > + *
> > + * Returns the address of the first state in the allocation on success, or a
> > + * negative error value on failure.
> > + *
> > + * The returned address of the first state may be passed to munmap(2) with a
> > + * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
> > + * memory, after which it is invalid to pass it to vDSO getrandom().
> 
> Wouldn't a munmap with '(size_t)num * (size_t)size_per_each' be potentially too
> short, due to how the allocation is sized such that states don't cross page
> boundaries?

You're right, I think. The calculation should instead be something like:

    DIV_ROUND_UP(num, PAGE_SIZE / size_per_each) * PAGE_SIZE

Does that seem correct to you?

Jason

