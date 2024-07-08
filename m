Return-Path: <linux-api+bounces-1874-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1255692A425
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 15:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4339D1C212A2
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 13:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A503B13A407;
	Mon,  8 Jul 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fKEF+5bg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB47F490;
	Mon,  8 Jul 2024 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446957; cv=none; b=tj0Wc9uIMZzdXEThazGHdroUXs4uwAQ23LcYb/nMHHl0mpIid0MhbK/sYBfjP8CfnKuv43A6HoQsPoA8ekV17bljDRXEk3muQtse81cqw1g05SHZPhCwgWqBmhFZ0pEAihSPjo23dmUOgLCndYOjrtinZ7RZ7Q+w2/xp+inX838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446957; c=relaxed/simple;
	bh=Ix+CY7nDRbdObz8mmrJCCRjvbh7+LChLXk0TnsBGW6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RywdKlDzC+72WCQR4Gr3C10AvV1G6IublPtaXZDHalxHb/flPWvWREm/l3qD2HNopcA9iVjPnErDY/Ab9OnKfOxDwwpzlVJj7+6xJbvA5d7LVEYgCaVNy+1yTwoIgLDVIWZ51N6RF4flJQES8PlYwiT+UYg2W6KmUePQQOzILjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=fKEF+5bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C058C116B1;
	Mon,  8 Jul 2024 13:55:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fKEF+5bg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720446953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Iu6qhhCoMzUJkFRbUZLPznGqNINA8RQkyC6Q++VnYXI=;
	b=fKEF+5bgvuym74Awlfw6+rIloM7/boI8OJjwFPIg6g1nMLKqYvnDY5N+gaL+OOHRNyujht
	o88kxldv7C1LwvNlGdWlyaztkLchIGGBNdfgdMccAxG/iKlNQ9HX0WEhiGEIGEZLQQvLsU
	uq8SAjGuRr4l647sMPUUcGy2iR+StF4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7bef63ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jul 2024 13:55:53 +0000 (UTC)
Date: Mon, 8 Jul 2024 15:55:46 +0200
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
Message-ID: <Zovv4lzM38EHtnms@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>

Hi David,

On Mon, Jul 08, 2024 at 10:11:24AM +0200, David Hildenbrand wrote:
> The semantics are much more intuitive. No need for separate mmap flags.

Agreed.
 
> Likely we'll have to adjust mlock() as well. Also, I think we should 
> just bail out with hugetlb as well.

Ack.

> Further, maybe we want to disallow madvise() clearing these flags here, 
> just to be consistent.

Good thinking.

> As a side note, I'll raise that I am not a particular fan of the 
> "droppable" terminology, at least with the "read 0s" approach.
> 
>  From a user perspective, the memory might suddenly lose its state and 
> read as 0s just like volatile memory when it loses power. "dropping 
> pages" sounds more like an implementation detail.
> 
> Something like MAP_VOLATILE might be more intuitive (similar to the 
> proposed MADV_VOLATILE).
> 
> But naming is hard, just mentioning to share my thought :)

Naming is hard, but *renaming* is annoying. I like droppable simply
because that's what I've been calling it in my head. MAP_VOLATILE is
fine with me though, and seems reasonable enough. So I'll name it that,
and then please don't change your mind about it later so I won't have to
rename everything again. :)

Jason

