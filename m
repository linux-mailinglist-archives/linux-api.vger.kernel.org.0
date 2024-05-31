Return-Path: <linux-api+bounces-1654-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5204F8D5915
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 05:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF5CB23607
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 03:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72117C64;
	Fri, 31 May 2024 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ5K4q+b"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDF233CA;
	Fri, 31 May 2024 03:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717126699; cv=none; b=CBJ1IVAXJYb8p9gR1sQ+asmYvJN+9xMezZ0ydMjP4VtMutO5FPoVO0KpItW4wNlZbDL+S4/rw1RIA53wnYRjSG3vLQ1uVgaIBtyf1yJVR0KvOUX+nYlSveC04L91uErXNCnzbLagao8apadAuVUe//dLOBUAhYpjsifhix6uTbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717126699; c=relaxed/simple;
	bh=OsDFLTLpZ1xDmxXSxiqSNvwZOyTuFsruHCWinP/HdHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyg66jxR/CnU73fbcnT4Y1QVZHwjclCRVAoSA95W/D1uY9DQP8ZVv9uVrqGb74X/Pu0PnpyjaMKIYqzf7w9Wj+/Q3jLa23k9xW73SHTH24kTrF7FlsTqw8ydLUuDwLcc/o02S3FwjcXdnePPw/gRid4WOdPwnAS1ITPPesR2Y1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ5K4q+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D282C116B1;
	Fri, 31 May 2024 03:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717126698;
	bh=OsDFLTLpZ1xDmxXSxiqSNvwZOyTuFsruHCWinP/HdHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJ5K4q+bmmojIFI35pyKTSDKDxnB3B78WU+PupaHX988+tYD2HlVBQTkfa50qdBzP
	 u/CE0LJ7FgYND/gFowIP3juvPtuoP2lGx4sxseAPMErRQGdYx5fzuU7oOaTUrNpmUE
	 VdkepWcrZDu7vkzAhvmdT0YVwS1/aHqkiuQg3E10zK8WtIZnvRIceopESOHe5VxFO9
	 P3Qfyvx0L2ZGrC2i99nKb2+flLBOEloU5tqRKXPfuero8shZCSLWf5i1n1nN62l2pw
	 ezK9xkhlSx8ot3x6lD+jziHYx2kRLjIglamhNl30+8pSkFEwwp5pBtjsrDfZp+N5lA
	 Vbsj/L9+g64CA==
Date: Thu, 30 May 2024 20:38:16 -0700
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
	David Hildenbrand <dhildenb@redhat.com>,
	Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v16 5/5] x86: vdso: Wire up getrandom() vDSO
 implementation
Message-ID: <20240531033816.GC6505@sol.localdomain>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-6-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528122352.2485958-6-Jason@zx2c4.com>

On Tue, May 28, 2024 at 02:19:54PM +0200, Jason A. Donenfeld wrote:
> diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
> new file mode 100644
> index 000000000000..d79e2bd97598
> --- /dev/null
> +++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <linux/linkage.h>
> +#include <asm/frame.h>
> +
> +.section	.rodata, "a"
> +.align 16
> +CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
> +.text
> +
> +/*
> + * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
> + * of blocks of output with a nonce of 0, taking an input key and 8-byte
> + * counter. Importantly does not spill to the stack. Its arguments are:
> + *
> + *	rdi: output bytes
> + *	rsi: 32-byte key input
> + *	rdx: 8-byte counter input/output
> + *	rcx: number of 64-byte blocks to write to output
> + */
> +SYM_FUNC_START(__arch_chacha20_blocks_nostack)
> +
> +.set	output,		%rdi
> +.set	key,		%rsi
> +.set	counter,	%rdx
> +.set	nblocks,	%rcx
> +.set	i,		%al
> +/* xmm registers are *not* callee-save. */
> +.set	state0,		%xmm0
> +.set	state1,		%xmm1
> +.set	state2,		%xmm2
> +.set	state3,		%xmm3
> +.set	copy0,		%xmm4
> +.set	copy1,		%xmm5
> +.set	copy2,		%xmm6
> +.set	copy3,		%xmm7
> +.set	temp,		%xmm8
> +.set	one,		%xmm9

An "interesting" x86_64 quirk: in SSE instructions, registers xmm0-xmm7 take
fewer bytes to encode than xmm8-xmm15.

Since 'temp' is used frequently, moving it into the lower range (and moving one
of the 'copy' registers, which isn't used as frequently, into the higher range)
decreases the code size of __arch_chacha20_blocks_nostack() by 5%.

- Eric

