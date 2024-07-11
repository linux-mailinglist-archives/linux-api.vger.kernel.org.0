Return-Path: <linux-api+bounces-1934-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A992EE0A
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE43283854
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B48D12D205;
	Thu, 11 Jul 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FmJad4az"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D5F12BF3A;
	Thu, 11 Jul 2024 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720720168; cv=none; b=V0gsY6k1UTa5cyI9es4LW3SWNYPPuOlAsLFxbCfn6gGTeWzIi+pWNAye10CGP60o1nrmhX6DJwHmJorCPxA+1EZLaIW/81F3p/vpXlSG3qTtdCRFgBa3y0pkBFg8A0W1g7m1tbNT+ma4NUaOnPP8J8W9qxpkB7l1ipfTdCmSpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720720168; c=relaxed/simple;
	bh=9wWabsHf2mBkKfoT6ZWCQAqlspCq6j8Ci+j1wJwEYsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekx2BpPZ3BWKSyIKGIXD/KiZQkg1u68eiTjyRTx4+ZalIyCjUh4mv9igO/5BltifyNJnxku7LfzrxqQeAqdhxWXcipkjcCHQbFMMJRuvM0a/nYnMHukSxvXfJUInji18ansyd6aH3VEI8Dg0SegdQhNBCWdJA0nJRSlxB2vcZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=FmJad4az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A3BC116B1;
	Thu, 11 Jul 2024 17:49:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FmJad4az"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720720165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wccdDHfXMw4zVJOuaNjzq/lvm3fY5fSh5A+KAajZE6M=;
	b=FmJad4az557oYsyLrhZVMyb6vL3CgQLX0+C8syQrv59sklvA/wBeyUVjYPVYAM8I7Ksl9O
	njiSxPxKkglEock0HJCyxFuoJd4gqCXOBxTNjErqYcRT3XSw4Iwr98OLozdYLmRIgjT45d
	V9zKg6tYjmFL2+Yv5JmIN2j7zJSpYoY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9a3ebd1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 17:49:24 +0000 (UTC)
Date: Thu, 11 Jul 2024 19:49:21 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZpAbIW8vzEDsGvR0@zx2c4.com>
References: <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com>
 <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>

On Thu, Jul 11, 2024 at 07:24:33PM +0200, David Hildenbrand wrote:
> On 11.07.24 19:17, Jason A. Donenfeld wrote:
> > On Thu, Jul 11, 2024 at 07:09:36PM +0200, Jason A. Donenfeld wrote:
> >> So, hmm... The swapbacked thing really seemed so simple... I wonder if
> >> there's a way of recovering that.
> > 
> > Not wanting to introduce a new bitflag, I went looking and noticed this:
> > 
> > /*
> >   * Private page markings that may be used by the filesystem that owns the page
> >   * for its own purposes.
> >   * - PG_private and PG_private_2 cause release_folio() and co to be invoked
> >   */
> > PAGEFLAG(Private, private, PF_ANY)
> > PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
> > PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
> >          TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
> > 
> > The below +4/-1 diff is pretty hacky and might be illegal in the state
> > of California, but I think it does work. The idea is that if that bit is
> > normally only used for filesystems, then in the anonymous case, it's
> > free to be used for this.
> > 
> > Any opinions about this, or a suggestion on how to do that in a less
> > ugly way?
> > 
> > Jason
> > 
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 1f9b5a9cb121..090554277e4a 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1403,6 +1403,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
> >   	 */
> >   	if (!(vma->vm_flags & VM_DROPPABLE))
> >   		__folio_set_swapbacked(folio);
> > +	else
> > +		folio_set_owner_priv_1(folio);
> 
> 
> PG_owner_priv_1 maps to PG_swapcache? :)

Oh, drat, it looks like this overloading is nothing new then.

