Return-Path: <linux-api+bounces-1900-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF992AE1D
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 04:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6061F219AB
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 02:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67F4347A2;
	Tue,  9 Jul 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KN/jvw/U"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5612C1AC;
	Tue,  9 Jul 2024 02:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720491487; cv=none; b=cDxhICgKPMuA9KRMPiTSww0LbukDvG3C84TyvbE/p5HINmJKAhLsbRyI3S1XlB6whAvg1pXbGFaC9HoZZIjsC3eSHAnmdy6Q2yDH1rkuhzwhejEW+/dWFDqs8wZt/lp4VQkxgwbfdKKtzJLI97njoeWrZ81wifZhlNCHNFWkD0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720491487; c=relaxed/simple;
	bh=sQpw2n0NaOOsrwQoFWy5PaDNmaERqzAgtz/ScLWKs7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEHSbOTSVMf7RvPF7+jeSqHGweQtgNSREh12ZLsUHxKjkEN1bZSQGsixzZXRZVH/vFRE5ohsshAEgAQgQ/sf3OE0+IpaC84LVvAG7srVTTKRmtbUJdiikld0inqZC/lYarxnbiUFka6xkStMTu0FpT5yb+HUb80AANQCDUwvR9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KN/jvw/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6D6C116B1;
	Tue,  9 Jul 2024 02:18:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KN/jvw/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720491483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SG/nhRJ5sb1lI6oh+MAWi0fczWmHK6PqjjxjYpcpOV4=;
	b=KN/jvw/Uc89zg8Kt77Xfog7E285Xcl2tdf9W0YRz3BOiCS3+imXctZmnwPAmIUpCSBfK6e
	n6mdgXUPFPORrbaOWCG/Hcm8MvCU+4PyDTyIZ80b4goZ00TRfM4l+fBEvYkg6/BiYID8rE
	ad8gUp/6uXjU8SeH0RZVPZgBm3p2y6o=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2946a661 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jul 2024 02:18:03 +0000 (UTC)
Date: Tue, 9 Jul 2024 04:17:56 +0200
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
Message-ID: <Zoyd1DYuD7cmJbgx@zx2c4.com>
References: <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
 <Zovv4lzM38EHtnms@zx2c4.com>
 <Zov6SZZCKrqmigua@zx2c4.com>
 <75d6c45d-deea-464d-b0fd-b36e5d73b898@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75d6c45d-deea-464d-b0fd-b36e5d73b898@redhat.com>

Hi David,

On Mon, Jul 08, 2024 at 10:21:09PM +0200, David Hildenbrand wrote:
> BTW, I was just trying to understand how MADV_FREE + MAP_DROPPABLE would 
> behave without any swap space around.
> 
> Did you experiment with that?

You mean on a system without any swap configured? That's actually my
primary test environment for this. It behaves as expected: when ram
fills up and the scanner is trying to reclaim what it can,
folio_test_swapbacked(folio) is false, and the memory gets freed. After,
reads fault in a zero page. So it's working as expected.

Jason

