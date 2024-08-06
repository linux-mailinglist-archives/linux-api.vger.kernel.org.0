Return-Path: <linux-api+bounces-2127-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1629D948725
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 04:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0F4B20991
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 02:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B328F6D;
	Tue,  6 Aug 2024 02:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="DyjuYawi"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD4F184D;
	Tue,  6 Aug 2024 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722909675; cv=none; b=hXhRQGE9b6GlkuObHlYOMDOQPMGGigvps6dusjMd5tcY8jnIy4s15f9Md1zPLew2tk8+uh3MkzVWytgWWMyrKKX0fDAb0C2WH7fdu6y83R2qwgyTuMjU/Y+1EENhxj6Cf05hnLlTRUcNLBrYR6kCESBHaDJOmJrs7nKlsFcRtMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722909675; c=relaxed/simple;
	bh=+G3dYnQ0cpfsMR46ZgVaWGrkRceqV/ppO50AvX/RlDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FEVdaQFyvs2J6A/6WhSrj77KNxdK5dCWNEESQwLerdD1ZrnXe3xP9Uku1rTBgckYIuOQUxdfc80q9IHq49MSESc/CbDPQIHyeBEVDYQbixnRxv0HxdVjQVQJUR42OoOKYfE1q1Bt5Wo/+x9zp2WU49aG2n/JJhbZsYszVetpIDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=DyjuYawi; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1722909671;
	bh=bg4E/qAsWu2tlT5JbHkQmtf9JeB5TlVVndOX9oUBJns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DyjuYawiAIBzg/xqvIdkFxKg5M3pB84GhEJNimx33sHPmy8ncPLLj1b4r24T1P3SR
	 /kCdawSJrpAKLyHAqLIXmhdpmqYbd6ORqggGac5jhoXpUvy0lFjSTTcx9XkGlaKG4i
	 j2YCTDy0tugHgb37/rrhlZ/KUSV5bQZDlT0Zg8tMup4594CnFomaYHRZc7LNdv2cN5
	 Lpgq9eqCfPdMcp22by2kuaxDPI3+aQA5Y68Txl1fpBKtkbOf/6Ln9+o4TA//4G4knQ
	 n+Xp0IRRTs0FcOi6HtW+KZLORZ8MCEI8GuSNmgGKhXZe53XwBemCGx7N6DOLPzOPrY
	 oq6R3OnEHh+Lw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WdGkD0kZtz4w2F;
	Tue,  6 Aug 2024 12:01:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>, Nicholas Piggin
 <npiggin@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>,
 kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>,
 oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook
 <keescook@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave
 Hansen <dave.hansen@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, Jann
 Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Jorge Lucangeli
 Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>, Stephen =?utf-8?Q?R?=
 =?utf-8?Q?=C3=B6ttger?=
 <sroettger@google.com>, Suren Baghdasaryan <surenb@google.com>, Amer Al
 Shanawany <amer.shanawany@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com,
 feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
In-Reply-To: <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
 <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com>
 <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
Date: Tue, 06 Aug 2024 12:01:06 +1000
Message-ID: <87r0b2if4t.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, 5 Aug 2024 at 16:25, Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Can userspace on other archs not unmap their vdsos?
>
> I think they can, and nobody cares. The "context.vdso" value stays at
> some stale value, and anybody who tries to use it will just fail.
>
> So what makes powerpc special is not "you can unmap the vdso", but
> "powerpc cares".
>
> I just don't quite know _why_ powerpc cares.

AFAIK for CRIU the problem is signal delivery:

arch/powerpc/kernel/signal_64.c:

int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
		struct task_struct *tsk)
{
        ...
	/* Set up to return from userspace. */
	if (tsk->mm->context.vdso) {
		regs_set_return_ip(regs, VDSO64_SYMBOL(tsk->mm->context.vdso, sigtramp_rt64));


ie. if the VDSO is moved but mm->context.vdso is not updated, signal
delivery will crash in userspace.

x86-64 always uses SA_RESTORER, and arm64 & s390 can use SA_RESTORER, so
I think CRIU uses that to avoid problems with signal delivery when the
VDSO is moved.

riscv doesn't support SA_RESTORER but I guess CRIU doesn't support riscv
yet so it's not become a problem.

There was a patch to support SA_RESTORER on powerpc, but I balked at
merging it because I couldn't find anyone on the glibc side to say
whether they wanted it or not. I guess I should have just merged it.

There was an attempt to unify all the vdso stuff and handle the
VDSO mremap case in generic code:

  https://lore.kernel.org/lkml/20210611180242.711399-17-dima@arista.com/

But I think that series got a bit big and complicated and Dmitry had to
move on to other things.

cheers

