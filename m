Return-Path: <linux-api+bounces-1820-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 086149241E9
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 17:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B758F287295
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05B1BB69D;
	Tue,  2 Jul 2024 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JD42hutR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48B1BB685;
	Tue,  2 Jul 2024 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932923; cv=none; b=e7c/sSb1au5Hb/OOX41JXYmeNjU/YlFZ+D22yku45x6z7oUuhM3d8OwuhhfGvRB9u2h+vkFkYbSKXbU2OzZXfwXHjvRLM0vK1GBrvldsI1HyEAH/Kdwu4fwYCHziksAUDt4nv3/GodsQhdGIFhGbLTtuwkko9Ujf/Qmwa+Ha7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932923; c=relaxed/simple;
	bh=r+3+y5Bqpte3FWzeov5eAIYc0Xj4txwX8QQ/c1nIrT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkVy5cevC2TSe/gvZZtWZPpTINwajMcFpGCvUuXBAeFwF00guAgUdGvzUkliLcswPkYxLy4LClah6zjoxhmYdwyEiaNWRKXN5j+XhXy8ZnXufXI6XLz0+Ae8+UVTbXhZzPcSNpGU9y4f8CsRLbNMfjtDjqqmw1MNSmspsDvIFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JD42hutR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C49C116B1;
	Tue,  2 Jul 2024 15:08:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JD42hutR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1719932919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vn+Q8NW4bbMGozhTyvScvIPS122WxS7dCXcrNrQNePA=;
	b=JD42hutR8R9eR9bl8Mk9GlUUg7WChrnYNR0XMRMyM5jMhIXnhl7DWdPNmEvbXrCX9i+vDC
	PmuqcG+oBdx+PogQ+NgfsDLGKhSbnkXlG43fhSEoEglUgS/0rRzPwrMoOzTTQp19JTTK1b
	gFb9GX3U+wwhcbEKl/8tXeob2erGp1c=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6661eee5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Jul 2024 15:08:37 +0000 (UTC)
Date: Tue, 2 Jul 2024 17:08:34 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v19 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZoQX8uxqww6Zkq2C@zx2c4.com>
References: <20240701135801.3698-1-Jason@zx2c4.com>
 <20240701135801.3698-2-Jason@zx2c4.com>
 <20240702004254.3ab2db4a98cb7fdd245407cb@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702004254.3ab2db4a98cb7fdd245407cb@linux-foundation.org>

Hey Andrew,

On Tue, Jul 02, 2024 at 12:42:54AM -0700, Andrew Morton wrote:
> The patch is impressively comment-free.  It is a little harsh to make
> readers go poking around in the git history to figure out what
> VM_DROPPABLE is, and why it exists.

Sure, I'll add some comments to the conditionals added to make it more
clear.

> Seems hard to test that this mode is working correctly.  Can you think
> of a way for userspace to check this?  And if so, add it to selftests?

I've got a pretty straight forward test I've been using during my own
testing that I can add to the vgetrandom_alloc() selftest (which exposes
these code paths). It works fairly reliably. Basically, one process
keeps checking to see if the memory has been dropped, while the other
consumes memory a page at a time. Pretty soon (depending on how much ram
you have), the memory gets dropped, and this is detected, and the test
completes with a pass. I'll have this in v+1 of this series.

Jason

