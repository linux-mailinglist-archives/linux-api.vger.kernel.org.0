Return-Path: <linux-api+bounces-1957-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F3592F369
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2024 03:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564511C218A8
	for <lists+linux-api@lfdr.de>; Fri, 12 Jul 2024 01:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF279F6;
	Fri, 12 Jul 2024 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WUkzWDQ4"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114C79D0;
	Fri, 12 Jul 2024 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747324; cv=none; b=bgmSA61WpnsfFyJ3VaIBx1YI/GdD4kyyYGLGmmrOXIJJmb3S2czP4n0zVxrp5XHVH9n7UQEcKOOGU9PAiBJXyFYqlY+IwffKPp5cVkTrtRNC1dxYRwM2yGHhYdb1vbY9ox5ERd4q2vO9LQ3i/hCUfa5X/RpW3xupdwanH7bh3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747324; c=relaxed/simple;
	bh=dTBSXX4hldEV6E/8Mkykp19IfJ3WJRarA59YTkKILMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kv8+vq3yEKMvkjk0EPCoAFO6CcClOSAXcrNZc71yx/MUYvOlp/xuCL+iHhFjNd5qUgFSQsr1CpgiFISKw3rMa/5Bg9etfo7QHt69aXyUKUEc/6USIN/a/OnUrKPaba3kxoy5NvzwLHSbM3r2M7A4kNO2awx1ERhUxj81QYTdQ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WUkzWDQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B04FC116B1;
	Fri, 12 Jul 2024 01:22:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WUkzWDQ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720747320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vyt2PhgTl2/lcxLnHuVCD7bBc8rUbtA1ocfd2dkczEI=;
	b=WUkzWDQ4H72rOQrfYXBzv2Fy4QqEVW6ZNam5iC3qKQjmvFJL6T0fG91Ry8rwzVuTBFrNeA
	UT451cR3hgre90cMumR03BOsPaNtjH617Bh/Lmy9myVg+EIeUAvFUSbKprkJFrYJdkGECh
	flULe4Uo+6LqX8A7huoEeWhVwawPuN0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 251cd471 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 12 Jul 2024 01:22:00 +0000 (UTC)
Date: Fri, 12 Jul 2024 03:21:56 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZpCFNA2VDoB_7waS@zx2c4.com>
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com>

On Fri, Jul 12, 2024 at 12:29:17AM +0200, David Hildenbrand wrote:
> > I'll try to think of some corner cases we might be missing.
> 
> Sorry that I keep coming up with corner cases :) But these should be easy to handle:

Thank you for coming up with them!

> We don't want to suddenly get pages that are swapbacked.
 
> Otherwise someone could place swapbacked pages in there (using UFFDIO_MOVE)

Both seem like reasonable concerns. Added to v+1.

Jason

