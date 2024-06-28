Return-Path: <linux-api+bounces-1802-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A585691C017
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 15:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48D5A284954
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 13:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127D21BE845;
	Fri, 28 Jun 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X48moTLe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s3g8O5Kb"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F049015D5A1;
	Fri, 28 Jun 2024 13:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583072; cv=none; b=fU4cqzELeQJh/UGD5XP3UyxkX24Jt5A9y/zIslWf8LwgsmIseTee2qTN9GCrMGLlvI0nsfBzChXCtl19ZdyB0bUV/jorzETUX/EbYAYW40f/ndYpKIU2e4psx9mkExl8Zl3LSyKpgwvd7y0iiPaHQ5yC8vfRkm73i5Z1ZPCJcfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583072; c=relaxed/simple;
	bh=6dB9gyixxZaNNrLZkws68I/STGMKTO/uLclTGj6eKhE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HBsB3p153OR+G8L7LpYyokw8InUsZFoQbPm9zcyqLqhjcUzC3sm8/Ov0bhsa0/4m4JEsmnRs8mqvI81JEG8UIflt5vQEJiJOhKSY//JEzE/xz+cXqTVNrp1iSTSBxWxbngSKyCYcO+35NDPtTH9mtuvmdAQv7gY9wpgOqrHojXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X48moTLe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s3g8O5Kb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719583067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dB9gyixxZaNNrLZkws68I/STGMKTO/uLclTGj6eKhE=;
	b=X48moTLewdTFXTRsJNnCKnwLBaQvCaLc6Ogsy7zmy4Lyhw9iJQ2JgLiX0RxTsrB2lEOiXr
	Byl7Ozl0URCKHHvxGIyh4Y2ef26qJnBQWerRSppEvR1Y+DWHpoWcn+ABYU/sj7zFi92RuL
	MyQJjlP77tH1hvnJBmWvWsL1KlGncc5Gw6rgoWxdIGWXCzocRV+e9s51Vn0XzhpGrnsBmP
	42uivhJfGVYUmtasn+Ksxyk/90d8OO8tHkbGW+UE+aAVxktMiKLUZW2wiV8KvU7IEJ97Bx
	Yie5Mb0hyOVy13pq745MQjpaGFVCG8o40VICgsPqJyiwHwegq2SPS7IF7+AwmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719583067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6dB9gyixxZaNNrLZkws68I/STGMKTO/uLclTGj6eKhE=;
	b=s3g8O5KbccSbxbx6A2UqbfeRrrmPK26QrZ+tgBUHBqEMj++emV8ZPnJeqmuRsyvUt6lOY/
	dXRLWKiQnj7cfZBw==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>, Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v18 5/5] x86: vdso: Wire up getrandom() vDSO implementation
In-Reply-To: <20240620005339.1273434-6-Jason@zx2c4.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
 <20240620005339.1273434-6-Jason@zx2c4.com>
Date: Fri, 28 Jun 2024 15:57:47 +0200
Message-ID: <87pls1xj8k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 20 2024 at 02:53, Jason A. Donenfeld wrote:
> Hook up the generic vDSO implementation to the x86 vDSO data page. Since
> the existing vDSO infrastructure is heavily based on the timekeeping
> functionality, which works over arrays of bases, a new macro is
> introduced for vvars that are not arrays.
>
> The vDSO function requires a ChaCha20 implementation that does not write
> to the stack, yet can still do an entire ChaCha20 permutation, so
> provide this using SSE2, since this is userland code that must work on
> all x86-64 processors. There's a simple test for this code as well.
>
> Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

