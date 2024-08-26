Return-Path: <linux-api+bounces-2247-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1609395E941
	for <lists+linux-api@lfdr.de>; Mon, 26 Aug 2024 08:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B62B20B6F
	for <lists+linux-api@lfdr.de>; Mon, 26 Aug 2024 06:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEF824AF;
	Mon, 26 Aug 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lY/7RmRz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBB1757F8;
	Mon, 26 Aug 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724655195; cv=none; b=BZfdpMcNEhPJXv7GXq9iVyvlwgNR9l3tabiHgB8A2QKBmPdlfq4qEzhyg0zf3u2EPeDBIaNJH5PbWVgRI68MdpNo4KGS0lgtv/koEU972vLmmOqqYhMFCnmqCtzTJSpLngkp+krNyQxxetVVkG+Zgly+J1MTnYyoDioMrWb8XRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724655195; c=relaxed/simple;
	bh=auXzr8K9fChv0/IWRs3P9xIkyj7vhiQiVkI002D42xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHngx4btV/NcIbuBSpMlPE/SUcKZTAtokL4KYtmPGCMB5A0cyZaVFvPyOlsgp0rDB3DLFWhK8zcjnf7HJhUuG9evGfgDLui4UIsmjrYN9SRh9MV3ghfk8QHMHr1haoLiY5l4WGdXa6RWmfE6UeJP3Ub8Ol7rty/fSyOHB0BOK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lY/7RmRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A54DC582B2;
	Mon, 26 Aug 2024 06:53:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lY/7RmRz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724655191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yuYNljZmRhiAAg/0TQBVxJOuv2J1dxM24TN804epaiw=;
	b=lY/7RmRzXI7z+jraqxmYSEYCaupr6p0SICWk+QbMa7iT1AMOX16jrGyLyRGrO0xaz++Tf8
	w38jGHFgJmX1tFoenoEYPoZ1PtRQyhtfj5JBedBKVrRcNU2MwHEl1+AajBvQotTvl0mEep
	VU2krc4QDZRfjcsNNmT5Sjyh3duWZtA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 441b4f56 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Aug 2024 06:53:10 +0000 (UTC)
Date: Mon, 26 Aug 2024 08:53:00 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Yann Droneaud <yann@droneaud.fr>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH] random: vDSO getrandom() must reject invalid flag
Message-ID: <ZswmTJf1asZUJ-5Z@zx2c4.com>
References: <20240712014009.281406-3-Jason@zx2c4.com>
 <20240825144758.325298-1-yann@droneaud.fr>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240825144758.325298-1-yann@droneaud.fr>

Hi Yann,

On Sun, Aug 25, 2024 at 04:47:50PM +0200, Yann Droneaud wrote:
> Like getrandom() syscall, vDSO getrandom() must not let
> unknown flags unnoticed [1].
> 
> It could be possible to return -EINVAL from vDSO, but
> in the likely case a new flag is added to getrandom()
> syscall in the future, it would be nicer to get the
> behavior from the syscall, instead of an error until
> the vDSO is extended to support the new flag.

Thanks, that seems right to me.

Currently the @flags only matter if the RNG isn't initialized yet, so we
fallback if it's not initialized. But if it is initialized, all of the
flags behave the same way, so it didn't bother checking them. But that
doesn't account for invalid flags, and you're right to point out that
accepting them silently is an API problem.

I've applied this here, and I'll send it in as a fix soon:

    https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=ed9fbbeb29


Thanks for the patch,
Jason

