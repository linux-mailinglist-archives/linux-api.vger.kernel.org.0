Return-Path: <linux-api+bounces-1869-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7E2929A9F
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 03:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E971C20912
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 01:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAC5EDB;
	Mon,  8 Jul 2024 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M54NpJDR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096D779C2;
	Mon,  8 Jul 2024 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720403993; cv=none; b=LBCdyXLf1IrIwlPv1WK5yyNfv63NzhfYV7HJV+6fGcjBeYZhPjweNrKNRcG/D+P6AiAtbKTZwsW8GH8QrBJvenjHGKBlG7SLIDubSl8acaRz5jFS2klm5wTbhghWnynQuNcZN0FM76HufS2CX2OEa5dbow1lDfVQzaWNdtlRTW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720403993; c=relaxed/simple;
	bh=j2FbQMEigcuhU0tDg3vutUj4NnCjRD7ylO94TNaIcNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+ke1BrjjO0J17BdWFui2xon2vdpjikbYPXwCg0i9K3CWmmg4dRG3iPHA0IypmMtbag4rWIqnnXD4oJqHgQDvEgTStFXGXikceq+LqrTU6olfjPhHgebdeMKcpTAqIvr5eOOqi9FHAg5FMSLupDmSPtA6bz9FjV8JHhjxGQvXvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=M54NpJDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090D3C3277B;
	Mon,  8 Jul 2024 01:59:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="M54NpJDR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720403989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n4cCQuWztdSIfQ492l8tJFqxNnyuIv8Y+chaiokzYoA=;
	b=M54NpJDR8YpmMAE0NIzO6pSjJl2GHnspS2wmlAMkCkFYGRuEM2dCuP8ZaJ/lApAUjoHcqp
	pp4OL+s9vycmz0NNLn/LuMMNJ1Dwn5+CF1j2EuVasciiWTB2jHTkUGXpdtkfqp/7jEQq7X
	SfBAwl7CJD0+pqrAIANMGiWYoLN1I10=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9f6d4916 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jul 2024 01:59:49 +0000 (UTC)
Date: Mon, 8 Jul 2024 03:59:46 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZotIEhO86_RRNOgy@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>

Hi Linus,

On Sun, Jul 07, 2024 at 11:19:46AM -0700, Linus Torvalds wrote:
>  (c) we could actually use the PROT_xyz bits, which we have a ton of

As I just wrote to David, I'll move this to PROT_xyz.

By the way, in addition to the PROT_SEM historical artifact, there's
also architecture specific ones like PROT_ADI on SPARC, PROT_SAO on
PowerPC, and PROT_BTI and PROT_MTE on arm64. So the MAP_ vs PROT_
distinction seems kind of blurred anyway.

> And we actually have had the "get signal on access" before: that's
> what VM_DONTCOPY is.
> 
> And it was the *less* useful model, which is why we added
> VM_WIPEONCOPY, because that's the semantics people actually wanted.
> 
> So I think the "signal on thrown out data access" is interesting, but
> not necessarily the *more* interesting case.

FYI, I looked into using VM_DONTCOPY/MADV_DONTFORK for my purposes,
because it could possibly make another problem easier, but I couldn't
figure out how to make it smoothly work.

Specifically, a program has a bunch of threads, and some of them have a
vgetrandom state in use, carved out of the same page. One of the threads
forks. In the VM_WIPEONFORK case, the fork child has to reclaim the
states that were in use by other threads at the time of the fork and
return them to the pool of available slices. In the VM_DONTCOPY case,
that's not necessary, which is kind of nice. But if the program forked
in the signal handler and then returned to an in progress vgetrandom
operation, now there's a signal that needs to be handled internally,
identified as belonging to the internal state areas, and not bubbled up
to other code. This seems difficult and fraught. It's far easier to just
have the memory be zeroed and have the code unconditionally check for
that at the same time it's doing other consistency checks.

So yea it just seems a lot more desirable to have the behavior be
zeroing rather than an asynchronous signal, because code can
straightforwardly deal with that inline.

Jason

