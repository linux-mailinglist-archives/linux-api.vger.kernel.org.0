Return-Path: <linux-api+bounces-1875-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E9D92A42B
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 15:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4259F1F21BE9
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364613B7A3;
	Mon,  8 Jul 2024 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SnMYoczp"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533C913B5B0;
	Mon,  8 Jul 2024 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720447047; cv=none; b=G5GK5iH0EbHVJzMTRl1OFOzwTbGm6jQse7zyJN+JKIP+9/jni6WbUjjQw4GWQzjw33eBdVtRUmkNS6ywJEmmtvoRfex65IZZ7YyyKWxlsdAND+fE/M9etsiNIcV/7OzV5wy2yCiGwJOGPCwQRgcwS/cJNIZMcpjMWWqcNbT3jts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720447047; c=relaxed/simple;
	bh=KSSrR7qGwTlnhGxF/OI1532hLGUrE9uEYAyW05fv5Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ7aqUoD4YXD22TxC1xk/Y346ja/CelaA/3KawjwitvkcDT5wK5BD4M96Wx37+F9hhs0ovqP+teWbTbAD6qhJdfHidW3S4siAFV1u1TknLwGc78GnZfylnXGPwjbJ3OfeFCMz5E58J5eQdygtsZ3U8BAT+gAIu7ttfxGt/ZUtBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=SnMYoczp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A9EC116B1;
	Mon,  8 Jul 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SnMYoczp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720447043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQS7o58P8S+fD6b6Xl0FX6qQoG7SltctZM9n2MeErPs=;
	b=SnMYoczpIqtVETwJZjcPvUi1E4GJvhKnnduPkqxwOF+4q1XAKAl7L8prIQgXO9aveN+mWe
	uc76z7aEtLFPzORTo6uo6uqht3WmJwe7bCzzJ7fn2uVUyapZvYTJL6xtIanEXfzjFjYa/S
	08iAL3feVEh70xvG3TE1qjpqjUz9khU=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8c531bf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jul 2024 13:57:22 +0000 (UTC)
Date: Mon, 8 Jul 2024 15:57:15 +0200
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
Message-ID: <ZovwO8KJ5Cv5fa26@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
 <8bf64731-9e5c-4c8c-b46b-5b18ae3110a1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bf64731-9e5c-4c8c-b46b-5b18ae3110a1@redhat.com>

On Mon, Jul 08, 2024 at 10:23:10AM +0200, David Hildenbrand wrote:
> > As a side note, I'll raise that I am not a particular fan of the
> > "droppable" terminology, at least with the "read 0s" approach.
> > 
> >   From a user perspective, the memory might suddenly lose its state and
> > read as 0s just like volatile memory when it loses power. "dropping
> > pages" sounds more like an implementation detail.
>
> Long story short: it's the hypervisor that could be effectively 
> dropping/zeroing out that memory, not the guest VM. "NONVOLATILE" might 
> be clearer than "DROPPABLE".

Surely you mean "VOLATILE", not "NONVOLATILE", right?

Jason

