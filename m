Return-Path: <linux-api+bounces-1801-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A6C91C014
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 15:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95261C21CE8
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 13:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9721BE844;
	Fri, 28 Jun 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nv5TNJtG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QpB/r0sB"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12315B98D;
	Fri, 28 Jun 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583049; cv=none; b=qpCV1QCdIfN4hVmItW/46znWRUhMM5NufhLi5cnjtU9IzdU3zl82KzA8vTv4r/Py4Aj9P3ewGkOPwCnUwA/ARYJ6w54a37UkyfJM7Kw2bNGiYiS5B7oXdaNh6N6qiezOCozR2YnPkurcNKJ8AO5DmQ5+KaoFStO5VSynB80FIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583049; c=relaxed/simple;
	bh=dd3XuLdWn+2DEQRIFIIEPEyiNfs/uNZbOJ3D+9u4ivw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iofDsrPWzHLGGR+9pmuh1SHFfFQHebVvXEN6Yn3Wm87G518NWJCeHyc9GgrVGUFdnZg7VW2mVN7jKfL2cjF31P/BQ2w6i7dZJGxkOxQMwUgyGdvQ0sfkmKTyUM8vIFct9cfhfw5MmI+6BoyOQJMcoxfsW0ZxW4vbibhtEh8vo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nv5TNJtG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QpB/r0sB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719583047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlwf/7TRlRrmmnPlqSzOyvgQVcgyWjkojMXGq41OTLc=;
	b=Nv5TNJtGreU5aRpmB7WuzPFsw47OVVDpuc+UJ+ypayp5GU1U10adxDthfHTgTWhe9Cnbo5
	d0FYI896a+xk6U2mALf2OWEyrMl2IDiT1FyDVs0W5Jj7YnmhDAyUbmRL3SlWZSD7WtRpw8
	UYmPDTDvdjJwVN4ePRPJCwfZKxx/GBWEybzU5vxThTkBte8bEi88G13K0Por8mJVrFpTDC
	HLoGxfUg2xXIsIH0gFlXO0/qrCrnQ78md9G9ND7eK7EoVr7xpAvj6DB6CeHzxwl7fzi7NR
	/Q8g58vDhwDvLNSuacRiv1I7kN3NjBIet+i8w8iTVPzDi4/MkK4+FWXGBGNzow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719583047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jlwf/7TRlRrmmnPlqSzOyvgQVcgyWjkojMXGq41OTLc=;
	b=QpB/r0sBq/SKQn17tcpD+PAkRdtPzpzGvfho8ru+3w/WUqiGM2JsMnyZYwOat+1yuwUz4o
	MTeLmP2Q+yRurUBA==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v18 4/5] random: introduce generic vDSO getrandom()
 implementation
In-Reply-To: <20240620005339.1273434-5-Jason@zx2c4.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
 <20240620005339.1273434-5-Jason@zx2c4.com>
Date: Fri, 28 Jun 2024 15:57:26 +0200
Message-ID: <87sewxxj95.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 20 2024 at 02:53, Jason A. Donenfeld wrote:
>     return grnd_ctx.fn(buf, len, flags, state, grnd_allocator.size_per_each);
>   }
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

