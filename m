Return-Path: <linux-api+bounces-1655-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0DA8D592C
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 05:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AC70286E50
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 03:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E8357CA2;
	Fri, 31 May 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHuUihYY"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714A9208B0;
	Fri, 31 May 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717127960; cv=none; b=pQCzfh/xCKfhh5+74Isq9nSXKzYQxQDehEjejzlnDdD/XjfhF87+R2IUew2yWI77Ts+GYen1bMHPuCGlT14WpDN0NJB1rQkbthS+KgI+7DnmzxA+pZx91UM3IpoDe2BRFdOYZO2q40ynOgF18nhXaePE+LjC2yUtoVTYQbJ4KVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717127960; c=relaxed/simple;
	bh=ij84ftjLq17UMND5+v6nnm7ghMRL7JGp0DPy0qootgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pn8Htg3AWQ77SvgR/GpUaYuJpdF7+JAEk4UDJe8JroFACKRcBnE6NuUSHjtjty2ZCFjLonFKmfP3xfD8oPxRnxlMTY3be2e+Vf9db76b+GKO9oHePHnBmb9+QFrQ7n0V99BhoNBJY4rwNdQZAttBQkshFMKEJqwA5FkrlG0ZIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHuUihYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F39C116B1;
	Fri, 31 May 2024 03:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717127960;
	bh=ij84ftjLq17UMND5+v6nnm7ghMRL7JGp0DPy0qootgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHuUihYY3H1mZo+OnyfBgJCQi6EDgy2Hus3yDQojqJxyJHM72Le9e9JXg9PE8D29Q
	 hi9L33nMEg4Pq0iI+zKB8zG708Qp7bfpuRDSWmp3YSMtCX141hqhHryS0DvD8CVm4L
	 fv0Q3CmTmnsQJyL1dOAtpRwAxCZDEVIgxWwo3U8WlE9FcGqdIasY3DOgPxOD0i8aJP
	 TGx5XnzU9zB5Pkpu59XKmKfLSwEb7SlHehrvO9+WZJZIr8TcKGGqXW75ODNvCERoyN
	 73ntDcXnJJYp3O4xRVHHyPA1mdpcRjgLSujSiX4Y82V/+0m89IGsnNagoBr77K+UCP
	 Xu59fDNYqwqJA==
Date: Thu, 30 May 2024 20:59:17 -0700
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
Message-ID: <20240531035917.GD6505@sol.localdomain>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-3-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528122352.2485958-3-Jason@zx2c4.com>

On Tue, May 28, 2024 at 02:19:51PM +0200, Jason A. Donenfeld wrote:
> +/**
> + * sys_vgetrandom_alloc - Allocate opaque states for use with vDSO getrandom().
> + *
> + * @num:	   On input, a pointer to a suggested hint of how many states to
> + * 		   allocate, and on return the number of states actually allocated.
> + *
> + * @size_per_each: On input, must be zero. On return, the size of each state allocated,
> + * 		   so that the caller can split up the returned allocation into
> + * 		   individual states.
> + *
> + * @addr:	   Reserved, must be zero.
> + *
> + * @flags:	   Reserved, must be zero.
> + *
> + * The getrandom() vDSO function in userspace requires an opaque state, which
> + * this function allocates by mapping a certain number of special pages into
> + * the calling process. It takes a hint as to the number of opaque states
> + * desired, and provides the caller with the number of opaque states actually
> + * allocated, the size of each one in bytes, and the address of the first
> + * state, which may be split up into @num states of @size_per_each bytes each,
> + * by adding @size_per_each to the returned first state @num times, while
> + * ensuring that no single state straddles a page boundary.
> + *
> + * Returns the address of the first state in the allocation on success, or a
> + * negative error value on failure.
> + *
> + * The returned address of the first state may be passed to munmap(2) with a
> + * length of `(size_t)num * (size_t)size_per_each`, in order to deallocate the
> + * memory, after which it is invalid to pass it to vDSO getrandom().

Wouldn't a munmap with '(size_t)num * (size_t)size_per_each' be potentially too
short, due to how the allocation is sized such that states don't cross page
boundaries?

- Eric

