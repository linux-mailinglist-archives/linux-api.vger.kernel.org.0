Return-Path: <linux-api+bounces-1685-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CAD90094A
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D701C214AF
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3638197544;
	Fri,  7 Jun 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i3V0bmVM"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BAD61FDD;
	Fri,  7 Jun 2024 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774685; cv=none; b=sdGsfLdOQxWRFoTXtLekGtCnnIflUgtFq/da8i7bqiQsSCPkH1K1XEDjJmxYe5CYTG4EQmmJ3GwQ0B8O/8bok4rnVS33y6dVWvzUMJPenI+uyWx+QdSJyahg6zsIrZ5nmi7xilKTxsbM+CXQmbDlhwBInE29ZkTlNcSXGfQb1uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774685; c=relaxed/simple;
	bh=Il9y63ujbF3nbi7YEEuhQJ7RdIMFbVF8NRlUr4A3cdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpMqvh1o/m/1ayf6XiiDa3GywkKAL/7qe55VungMZNP3tn9scjY7ukFI8Duih2YoQZOZwmxUG1bhoa9YaXVjycaHBeuJ9WY06RabvcCaKhE817TgiRAChz41/jWG5DCvtwKlyU3O47tBqyZVNShfxhszR5A9KU9MUVjemwz4s7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=i3V0bmVM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9163C2BBFC;
	Fri,  7 Jun 2024 15:38:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="i3V0bmVM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717774682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VdaGblx7cL5MU4wq83z4MFvGPW2Ec6PER4ig9UlfUIU=;
	b=i3V0bmVMvJ33qmlfTcRb7iBAdeclk+HZiq3BXLZHOQvsgY0dh8qjRajQ3/ICbNZuNaLILc
	IAcOap4dKE8o79NX7E911c/1d77t7tlWt4I57NtloaVtIbNhZapuLhLdf1C9QyRWm6x/J2
	ZKxQFpb7uy9QJXd+IwOL10HqEN1KSJ4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0fa858e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 15:38:01 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:37:55 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Randy Dunlap <rdunlap@infradead.org>
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
Message-ID: <ZmMpUxEUwnfFpiry@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-5-Jason@zx2c4.com>
 <d3f7e1c5-5945-48c0-b263-e09979a987a3@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d3f7e1c5-5945-48c0-b263-e09979a987a3@infradead.org>

On Fri, May 31, 2024 at 12:15:16PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/28/24 5:19 AM, Jason A. Donenfeld wrote:
> > +/**
> > + * __cvdso_getrandom_data - Generic vDSO implementation of getrandom() syscall.
> > + * @rng_info:		Describes state of kernel RNG, memory shared with kernel.
> > + * @buffer:		Destination buffer to fill with random bytes.
> > + * @len:		Size of @buffer in bytes.
> > + * @flags:		Zero or more GRND_* flags.
> > + * @opaque_state:	Pointer to an opaque state area.
> > + *
> > + * This implements a "fast key erasure" RNG using ChaCha20, in the same way that the kernel's
> > + * getrandom() syscall does. It periodically reseeds its key from the kernel's RNG, at the same
> > + * schedule that the kernel's RNG is reseeded. If the kernel's RNG is not ready, then this always
> > + * calls into the syscall.
> > + *
> > + * @opaque_state *must* be allocated using the vgetrandom_alloc() syscall.  Unless external locking
> > + * is used, one state must be allocated per thread, as it is not safe to call this function
> > + * concurrently with the same @opaque_state. However, it is safe to call this using the same
> > + * @opaque_state that is shared between main code and signal handling code, within the same thread.
> > + *
> > + * Returns the number of random bytes written to @buffer, or a negative value indicating an error.
> 
>     * Returns:

Ack. Thanks.

