Return-Path: <linux-api+bounces-1918-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDE92C93A
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 05:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999A928132E
	for <lists+linux-api@lfdr.de>; Wed, 10 Jul 2024 03:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199A922F03;
	Wed, 10 Jul 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lKHfKX2H"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0150200C1;
	Wed, 10 Jul 2024 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582470; cv=none; b=q2+KJNVsxQLYT3sBRA3K60Cr+Gbo9kWh+LVAJ34+sO51GzQ6+gBpHQjWp0+y2f62JkMR9Ul7tlHC4xcodHRF6LMbbnnbs8NDnbVAPv6O5usZ/VMxUcnbP0IbQivimq/JVEHIK8ZDSdttaCWl7iKvbzDOAMTfSJ8qh5djBLMO6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582470; c=relaxed/simple;
	bh=Xr4Z6N+ZLNTCjn0mcOpsgrbnQi+pMrx8xtd5Xs8BJfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfY7iuVji75YS0zB3ZEJXdcon2q/IvejdAo5yxqg7zsILs9xKQeph+GgObcyW1yGPPVwhtHO26KRlXIXljqBfSfEWcmLhGj9xO2FiHLLY9MXZBrGrPVq/bMAQJie8wiSLRg4JfIjzSBncs6p6fMT/SHNJzRIxi0f2s1dgPFzF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=lKHfKX2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C803C32781;
	Wed, 10 Jul 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lKHfKX2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720582466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p5i/Lzo9gkW+zVOJlOn+7/krq7+rGz0YNs8CYQNCYFc=;
	b=lKHfKX2Hd1YwMf/8JrhbMnEEbz50FIzoBGgq11j6QV8Foke+nnTWukxN3KSR+lQio1Ai/p
	LK8VYTvBxZ13Oixal63xrLklzS70IEQThuvWfR9+tQQsmEjGLR1rhRxPlFoI43my/4rNMA
	txvthB06F6B2HIIvNAPnw7t8o/S24SY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 11d72e4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Jul 2024 03:34:24 +0000 (UTC)
Date: Wed, 10 Jul 2024 05:34:22 +0200
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
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Zo4BPjTIitoYSBMP@zx2c4.com>
References: <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
 <Zovv4lzM38EHtnms@zx2c4.com>
 <Zov6SZZCKrqmigua@zx2c4.com>
 <75d6c45d-deea-464d-b0fd-b36e5d73b898@redhat.com>
 <Zoyd1DYuD7cmJbgx@zx2c4.com>
 <b71d8619-1182-43b6-940b-d68f672aa379@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b71d8619-1182-43b6-940b-d68f672aa379@redhat.com>

On Wed, Jul 10, 2024 at 05:05:06AM +0200, David Hildenbrand wrote:
> On 09.07.24 04:17, Jason A. Donenfeld wrote:
> > Hi David,
> > 
> > On Mon, Jul 08, 2024 at 10:21:09PM +0200, David Hildenbrand wrote:
> >> BTW, I was just trying to understand how MADV_FREE + MAP_DROPPABLE would
> >> behave without any swap space around.
> >>
> >> Did you experiment with that?
> > 
> > You mean on a system without any swap configured? That's actually my
> > primary test environment for this. It behaves as expected: when ram
> > fills up and the scanner is trying to reclaim what it can,
> > folio_test_swapbacked(folio) is false, and the memory gets freed. After,
> > reads fault in a zero page. So it's working as expected.
> 
> Okay, just to be clear: no swap/zram/zswap. The reclaim code regarding 
> not scanning anonymous memory without swap was a bit confusing.

Right, no swap, as boring a system as can be. I've experimented with
that behavior on my swap-less 64GB thinkpad, as well as on little
special purpose VMs, where I hacked the VM_DROPPABLE test code into the
wireguard test suite.

Jason

