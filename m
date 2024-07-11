Return-Path: <linux-api+bounces-1953-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A4392F03F
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 22:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15321F22813
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 20:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C6D186E33;
	Thu, 11 Jul 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B08k7FoK"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8216E88D;
	Thu, 11 Jul 2024 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720729233; cv=none; b=i/UDbqUyr15PuplBDksjXuas/vIF9yzgoH33JIkXG5npZPzqfn2jGu4U/MBCkLDfBb2vlr/b5U/2bGx+MAPeF3x4Oo2W+jipOOBUYT+UA3CwZUTcYny4VsNlO1C+B6E7uXeweSjv/222I5dLFg0Qw3CbBEegbqM5beJdzR7kocU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720729233; c=relaxed/simple;
	bh=xa+rT4VmJOOY+hkHlExT68aShODjIMJJ+OQfbpBQ3fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAbJi4eIYTB7ZLaebuKmGKQXT4kKGHA+Udb3CsG4KjaU0m1qEkYcIKyiGlOHSa7LufeUy+2/w05KaU7LHvLZwk6f6lQVUXuAFe699MldaUAoIF1V455UDmvouJMWh0KVwu4NRrNv5zlCWGfI71IEwhBAeGsbPxKUZYxNo28GG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=B08k7FoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45713C116B1;
	Thu, 11 Jul 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="B08k7FoK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720729229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt6QePxaysQIEy2W33NFuV82FH1yOwTPMayUT9I0nRc=;
	b=B08k7FoKM2lth8Goud21+qdX9b42LABqtbFegs2oLDnZEvSCsNyDg1bmjyhL5o8Z9rok38
	0bDYNxgm6Q6JMUOebYHP2hMK+PLa6CubiFXMr8PKb3jvY6/5lUdoVrvXPIB35+82ogkpdJ
	pJFYgPAVaSkR/6oG//+B/wc8s6FL04E=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ffe4054 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 20:20:29 +0000 (UTC)
Date: Thu, 11 Jul 2024 22:20:26 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Yu Zhao <yuzhao@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <ZpA-iuAItDxBSfBS@zx2c4.com>
References: <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com>
 <ZpAc118_U7p3u2gZ@zx2c4.com>
 <ZpAfigBHfHdVeyNO@zx2c4.com>
 <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
 <ZpAqbh3TnB9hIRRh@zx2c4.com>
 <443146f4-9db8-4a19-91f1-b6822fad8ce8@redhat.com>
 <1c8632b4-06a5-49da-be0c-6fc7ac2b3257@redhat.com>
 <2c464271-1c61-4cd8-bd4e-4bd8aa01fa00@redhat.com>
 <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufYsxCb=taWWfUbuzi1Hmmug=ThQMoTjsxrtFkt=UXEu6w@mail.gmail.com>

Hi David,

On Thu, Jul 11, 2024 at 01:49:42PM -0600, Yu Zhao wrote:
> On Thu, Jul 11, 2024 at 1:20 PM David Hildenbrand <david@redhat.com> wrote:
> > > -       /* dirty lazyfree */
> > > -       if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
> > > -               success = lru_gen_del_folio(lruvec, folio, true);
> > > -               VM_WARN_ON_ONCE_FOLIO(!success, folio);
> > > -               folio_set_swapbacked(folio);
> > > -               lruvec_add_folio_tail(lruvec, folio);
> > > -               return true;
> > > -       }

> This is an optimization to avoid an unnecessary trip to
> shrink_folio_list(), so it's safe to delete the entire 'if' block, and
> that would be preferable than leaving a dangling 'if'.

Alright, I'll just remove that entire chunk then, for v+1 of this patch?
That sounds prettttty okay.

Jason

