Return-Path: <linux-api+bounces-1659-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 988028D6179
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB801F221FA
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40A31581FB;
	Fri, 31 May 2024 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NmsH7RWJ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C21581F7;
	Fri, 31 May 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157602; cv=none; b=Zit1bihTmnI9BRairFFoA6eVrBMOt2EUj21WLIZQt+gA894/Sv+vaED/8PuOfyr4jPV0knL/UGPvXzeNeVS04ypBPLjuEuOqzaqS5TpOFAxt8dK0yS89nT+HKjy2zxcOKANgrJ4w2fYVxVMK1L5MaG1sRPPM5z1HWQNcCnC8PIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157602; c=relaxed/simple;
	bh=pEk6KhSitAdG3WGeUhmwDaMCiS6rCqAE9GvzL8jnLW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtPw4/BGq/zzZTSzRj/YMPHAyK4di8NDMfmLsEPFcCxDFhyjvsUB0shBNxnF1BnTnSGeukiIAOkb+DtmQ9uplXmb5Q4vj4PqXrwE1jiQYXdMAZEQ2KZBgKlYnCH3mP/FzYZvKxUyBZbthJFl371fX0aNVVyjFfFoy6iG8iIEf8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=NmsH7RWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8895DC116B1;
	Fri, 31 May 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NmsH7RWJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717157598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IV/gUlFTczwkw63MVUJ0IOnRq1Gl4NdBa5kuDrSn6iw=;
	b=NmsH7RWJ9ZrOgR/Eqt4Mp8/kZUcNm/VXQDo7eL3+4tjJeLE1VV7M6J7f45g2TbdFYf2p1G
	K5SnFr1i/TrSEc3/FqZG44P1ju1b3hSm6RNVBwh4JuxDhmtXiPkeacOda94Ah3CXelPhu5
	JlVInX41OuD4+LxdVPUgLipVozEIcko=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 790e363e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 May 2024 12:13:18 +0000 (UTC)
Date: Fri, 31 May 2024 14:13:15 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Jann Horn <jannh@google.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Zlm-26QuqOSpXQg7@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-2-Jason@zx2c4.com>
 <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>

On Fri, May 31, 2024 at 12:48:58PM +0200, Jann Horn wrote:
> On Tue, May 28, 2024 at 2:24 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > c) If there's not enough memory to service a page fault, it's not fatal.
> [...]
> > @@ -5689,6 +5689,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> >
> >         lru_gen_exit_fault();
> >
> > +       /* If the mapping is droppable, then errors due to OOM aren't fatal. */
> > +       if (vma->vm_flags & VM_DROPPABLE)
> > +               ret &= ~VM_FAULT_OOM;
> 
> Can you remind me how this is supposed to work? If we get an OOM
> error, and the error is not fatal, does that mean we'll just keep
> hitting the same fault handler over and over again (until we happen to
> have memory available again I guess)?

Right, it'll just keep retrying. I agree this isn't great, which is why
in the 2023 patchset, I had additional code to simply skip the faulting
instruction, and then the userspace code would notice the inconsistency
and fallback to the syscall. This worked pretty well. But it meant
decoding the instruction and in general skipping instructions is weird,
and that made this patchset very very contentious. Since the skipping
behavior isn't actually required by the /security goals/ of this, I
figured I'd just drop that. And maybe we can all revisit it together
sometime down the line. But for now I'm hoping for something a little
easier to swallow.

Jason

