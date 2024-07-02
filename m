Return-Path: <linux-api+bounces-1818-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B10691F06D
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 09:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC4E1F23F9D
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 07:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A271422B6;
	Tue,  2 Jul 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OshYRO+R"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B9D4CB23;
	Tue,  2 Jul 2024 07:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906176; cv=none; b=V7YH7+VRLODwSvZI1MV0RI/rxMnODh+MHue0SsPKfzFhYo/GwGRpoxaBGooy5djsB63npcrsrmgeENQVYsV5m9lRLCoYnoMCa1Dn7y6weGLbavQZ/mIYmtMmyHw6Un26Efs2jF4TWl5y4gpU7gjqAR7pcKB1OI4FCceVXBnibwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906176; c=relaxed/simple;
	bh=b9oO32qfFgklf7sETD8/dcIhc/Mu840qILzRUiMTpP4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SRVdjxAvNkRauoJP4T7ggZiLCyzJ1I7ArehIkiYDZF2JytK6u6QVs7sq15Od0/xAxs/FnnoLm/0X4cWcofnHuWtxdFOM+vYcdJbWBN4f27gDQMgbIz+6w6jI3EwnWlcLshxm/QG/5ovD1MQAHGFLv01HSbYlkUTgaUmdPDF/zMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OshYRO+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9194C116B1;
	Tue,  2 Jul 2024 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719906175;
	bh=b9oO32qfFgklf7sETD8/dcIhc/Mu840qILzRUiMTpP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OshYRO+RqtW//uVs0njfZO7RS9kJp7HLUpkuV1+ecHPNjZ4TMDFd+ugEBS0Pi7c1j
	 4NzTC/LyznWWg2EQLbG1xW5vZ28wBuRKvTHc7rpWhFih0+wqUumCbAP7TXxdJ0vmlT
	 +XaG2OR5kNm6vFn4gpH1YXOJO7gEKW7cQ4RcGDmU=
Date: Tue, 2 Jul 2024 00:42:54 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 tglx@linutronix.de, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v19 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-Id: <20240702004254.3ab2db4a98cb7fdd245407cb@linux-foundation.org>
In-Reply-To: <20240701135801.3698-2-Jason@zx2c4.com>
References: <20240701135801.3698-1-Jason@zx2c4.com>
	<20240701135801.3698-2-Jason@zx2c4.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Jul 2024 15:57:55 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

> The vDSO getrandom() implementation works with a buffer allocated with a
> new system call that has certain requirements:
> 
> - It shouldn't be written to core dumps.
>   * Easy: VM_DONTDUMP.
> - It should be zeroed on fork.
>   * Easy: VM_WIPEONFORK.
> 
> - It shouldn't be written to swap.
>   * Uh-oh: mlock is rlimited.
>   * Uh-oh: mlock isn't inherited by forks.
> 
> It turns out that the vDSO getrandom() function has three really nice
> characteristics that we can exploit to solve this problem:
> 
> 1) Due to being wiped during fork(), the vDSO code is already robust to
>    having the contents of the pages it reads zeroed out midway through
>    the function's execution.
> 
> 2) In the absolute worst case of whatever contingency we're coding for,
>    we have the option to fallback to the getrandom() syscall, and
>    everything is fine.
> 
> 3) The buffers the function uses are only ever useful for a maximum of
>    60 seconds -- a sort of cache, rather than a long term allocation.
> 
> These characteristics mean that we can introduce VM_DROPPABLE, which
> has the following semantics:
> 
> a) It never is written out to swap.
> b) Under memory pressure, mm can just drop the pages (so that they're
>    zero when read back again).
> c) It is inherited by fork.
> d) It doesn't count against the mlock budget, since nothing is locked.
> 
> This is fairly simple to implement, with the one snag that we have to
> use 64-bit VM_* flags, but this shouldn't be a problem, since the only
> consumers will probably be 64-bit anyway.
> 
> This way, allocations used by vDSO getrandom() can use:
> 
>     VM_DROPPABLE | VM_DONTDUMP | VM_WIPEONFORK | VM_NORESERVE
> 
> And there will be no problem with using memory when not in use, not
> wiping on fork(), coredumps, or writing out to swap.

The patch is impressively comment-free.  It is a little harsh to make
readers go poking around in the git history to figure out what
VM_DROPPABLE is, and why it exists.

Seems hard to test that this mode is working correctly.  Can you think
of a way for userspace to check this?  And if so, add it to selftests?


