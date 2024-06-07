Return-Path: <linux-api+bounces-1678-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA69B9006C1
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FF51F246AB
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 14:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47F19751B;
	Fri,  7 Jun 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BBV00V0r"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB619643F;
	Fri,  7 Jun 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770915; cv=none; b=Z4fcXb8nDXaAoTVw3nYINDJj9vwKc0pikrna9+I2Py+RNj87mJLAexOncaM7V8DmGfQ+nY+AO6wgyVmaHKULPG/7BquNwQdWHR0Ri/xfVzs0RvWm+9Cvd+443p0JIXGlLTm2hqnSnLIjyXu355QWWpFXPL4pSWwlupIu7Btbbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770915; c=relaxed/simple;
	bh=mVgfio4EymRsdXfQ08fuEVop3EuHqiClvYLIu828s4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLiEmw8JLrWjVDJS0GlGUs+sSEJBBIwxYjqH2bMnfqLGAM42M6W51IIdrU1+IAWcm35Hki+na8und6/VNIopUYthXY95Lee5USUr0qZT6gesxh8cZs4oa0sFOS0vETXaCqiiB0xdgQRCOhzf2qJP59CLJk5YfC1xjTdTSH3eG4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=BBV00V0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53995C3277B;
	Fri,  7 Jun 2024 14:35:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BBV00V0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717770911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajPZqckOBJFHBstUW7T2O0UQJC/naoL0j9njP215Xzs=;
	b=BBV00V0rOVi6HrMqRiRVMBCf116AxoPzpLtxDhj5y+tsyMd3Ym3ffI3cnLv8dHVT5N405b
	VvhpMa4UmoOiBZt/mGdrFWTc2f3MuBriCR9lDODxjJx4qa7Kzoi9sOnhwxM3+615q3OZXt
	qRoQv2RdtEaMVDJt1qoRdCuTADRmaYM=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 26266bc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 14:35:11 +0000 (UTC)
Date: Fri, 7 Jun 2024 16:35:06 +0200
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
Message-ID: <ZmMamtll1Yq1yfxc@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-2-Jason@zx2c4.com>
 <CAG48ez0P3EDXC0uLLPjSjx3i6qB3fcdZbL2kYyuK6fZ_nJeN5w@mail.gmail.com>
 <Zlm-26QuqOSpXQg7@zx2c4.com>
 <CAG48ez3VhWpJnzHHn4NAJdrsd1Ts9hs0zvHa6Pqwatu4wV63Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3VhWpJnzHHn4NAJdrsd1Ts9hs0zvHa6Pqwatu4wV63Kw@mail.gmail.com>

On Fri, May 31, 2024 at 03:00:26PM +0200, Jann Horn wrote:
> On Fri, May 31, 2024 at 2:13 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > On Fri, May 31, 2024 at 12:48:58PM +0200, Jann Horn wrote:
> > > On Tue, May 28, 2024 at 2:24 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > c) If there's not enough memory to service a page fault, it's not fatal.
> > > [...]
> > > > @@ -5689,6 +5689,10 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
> > > >
> > > >         lru_gen_exit_fault();
> > > >
> > > > +       /* If the mapping is droppable, then errors due to OOM aren't fatal. */
> > > > +       if (vma->vm_flags & VM_DROPPABLE)
> > > > +               ret &= ~VM_FAULT_OOM;
> > >
> > > Can you remind me how this is supposed to work? If we get an OOM
> > > error, and the error is not fatal, does that mean we'll just keep
> > > hitting the same fault handler over and over again (until we happen to
> > > have memory available again I guess)?
> >
> > Right, it'll just keep retrying. I agree this isn't great, which is why
> > in the 2023 patchset, I had additional code to simply skip the faulting
> > instruction, and then the userspace code would notice the inconsistency
> > and fallback to the syscall. This worked pretty well. But it meant
> > decoding the instruction and in general skipping instructions is weird,
> > and that made this patchset very very contentious. Since the skipping
> > behavior isn't actually required by the /security goals/ of this, I
> > figured I'd just drop that. And maybe we can all revisit it together
> > sometime down the line. But for now I'm hoping for something a little
> > easier to swallow.
> 
> In that case, since we need to be able to populate this memory to make
> forward progress, would it make sense to remove the parts of the patch
> that treat the allocation as if it was allowed to silently fail (the
> "__GFP_NOWARN | __GFP_NORETRY" and the "ret &= ~VM_FAULT_OOM")? I
> think that would also simplify this a bit by making this type of
> memory a little less special.

The whole point, though, is that it needs to not fail or warn. It's
memory that can be dropped/zeroed at any moment, and the code is
deliberately robust to that.

Jason

