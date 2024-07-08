Return-Path: <linux-api+bounces-1873-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3FE92A40F
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61B22840EE
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 13:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DC13B285;
	Mon,  8 Jul 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ltc/kfe5"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E713A3FF;
	Mon,  8 Jul 2024 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446686; cv=none; b=jG4O44GrUUS1Ikh0T2QVDv+caRwUueWWV+lCw3IB3ivwOUOXx47b6W7SvtWS60T5d6TKMxbzEVwqNsZuvHHcWzeZp4PyEvdGqwVWO3y4gcgsYVyFZ4aLkb2JcIIXhkovpKb4F0X+NxaeuM9L7l3flpcIr9LdCX69HmjmbZWDhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446686; c=relaxed/simple;
	bh=G87kDnZnqvGSMs4uyhWZ60F6IU9JHQtUsJOPR1HoP5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQUf8Q8Jikni7d9Cd5X0vyA/QEyszSbAXYksJVf8+hbuNZpaTMWwURpkdNPR5+TY62L1j9JbD/RTKZ4ZPAZwUSnskUiVDpsrSF3KQ/oUn+JMX+YO37AxP6wkjw+o/kq3hMb8zS4LTUpxjQA3BzTHnwBpb6oEmoxdn4+FYHcDQ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=Ltc/kfe5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D134FC116B1;
	Mon,  8 Jul 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Ltc/kfe5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720446682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wmWJs2g1W7bIdx4gchsYMHASAqH5Nl1Wal5e/OBuZ4E=;
	b=Ltc/kfe55weFCdOPd0v5+eIU/rru8g1L280RLc2zXVS6Gdi2G5cohudgE4+0timl4c4NpZ
	Sk6U7XWXuosGL3CAcmi9GVlppDikr4+SBsuWnFkL8ljOP1yXMGhK/dY+nnIxyUlybiKT1s
	sJy1/yE9zue6HOFfwY78jZt9CLz7nyE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 173f7d39 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jul 2024 13:51:20 +0000 (UTC)
Date: Mon, 8 Jul 2024 15:50:57 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Zovuwesu_RaSixe6@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>

Hi Linus,

On Sun, Jul 07, 2024 at 05:08:29PM -0700, Linus Torvalds wrote:
>    +                    vm_flags |= VM_DROPPABLE;
>    +                    vm_flags |= VM_WIPEONFORK | VM_DONTDUMP;
> which looks rather simple.

That is nice, though I would add that if we're implying things that are
sensible to imply, it really also needs to add VM_NORESERVE too.
DROPPABLE doesn't make sense semantically without it.

Anyway, rather than adding PROT_xyz for v+1, I'll try adding this
MAP_DROPPABLE (or a different name for David) with the implications as
you've suggested.

Jason

