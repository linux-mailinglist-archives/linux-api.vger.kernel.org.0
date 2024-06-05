Return-Path: <linux-api+bounces-1676-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F385B8FD94C
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2024 23:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198B71C25635
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2024 21:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849315F41E;
	Wed,  5 Jun 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gx1iWzgT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtHx48XW"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7861213A87A;
	Wed,  5 Jun 2024 21:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623707; cv=none; b=P7qAqAObnu+LXUSrOfMTNXvKIUB9MdoQzbhRKzWzXf4zfE9SxQMK2cPCUiAjRkKzXnt8iJH5QeAqfFhOUyBp+TMX36cxTTPtcVSS5at4MnVrjzYkL0GbsxgvJVRKyhZanEjfiUJRX1pHuW6MtruJbuV567miEa3rl1OI8rVDCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623707; c=relaxed/simple;
	bh=m/okp4LUNPy9iC8VpIelYhrBq5Bzu3Me1uCGiBay1UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T8k6Pzv0YhT3Fuhn8lTznIplXfXDaraZ4UnmfuZ9i2PQ/8ZSULW+Q5zk9nVokM8dznvhouiuhdMhfKsN0sNxEjXAxWwkFJnVr3StFPhcJY2yDUoaubMFkQbC9f98AsVwiIdx6AGGFZx7iVsHxPy4mWvctKqq9+4yS6tcWG9I4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gx1iWzgT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtHx48XW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717623704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMaEgKRTCDlNySpYj41VqXw4r1dDo5g5VEmGt4FNdnE=;
	b=Gx1iWzgTX0o8ADRd6eAhWRdaw8KXSRR7QkzG/7kanVTpqiDlZTNDYD6c9Pj4vMqiSqVvW6
	waJ3TIx6C4gRFJ6kLumfJVF+iQIKnjSbSk9MmcxpV/FiEVZl9oG+rLW4PZB5iAm55qpH37
	VQqPiI+P4dfRQtdfuDbPXgenUewddcsAVN3ijs4UDMd5wihw/YM8ihrRfp+/OSNpVz4KgC
	vhSKaGL1vv+ThKOW9p0MbLK8irlk8DhzWsqn2aXDrJQbra4cRQ/waEoo8vovW19KGoZCZv
	Bd4czcoC5I1BjMIy4jLKO1Si6cFOSBneHqSFi5B1P32BZvtH8b71uObeOQEBaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717623704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMaEgKRTCDlNySpYj41VqXw4r1dDo5g5VEmGt4FNdnE=;
	b=ZtHx48XWJqTKoECYXNN6PcoyyGXqNPkylnSFnwUYTP4Dr/UG3RwteEbcFNRjKTC86kbbo0
	4hp+lFhJW9V2AdAA==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>, Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v16 5/5] x86: vdso: Wire up getrandom() vDSO implementation
In-Reply-To: <20240528122352.2485958-6-Jason@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-6-Jason@zx2c4.com>
Date: Wed, 05 Jun 2024 23:41:44 +0200
Message-ID: <87y17j2hk7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 28 2024 at 14:19, Jason A. Donenfeld wrote:
> +
> +static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
> +{
> +	if (__vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)

Lacks an IS_ENABLED(CONFIG_TIMENS)

> +		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&__vdso_data);
> +	return &__vdso_rng_data;
> +}

Thanks,

        tglx

