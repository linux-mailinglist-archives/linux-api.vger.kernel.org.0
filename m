Return-Path: <linux-api+bounces-1677-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8DD8FD99E
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2024 00:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2841C21BA9
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2024 22:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6CC15FA67;
	Wed,  5 Jun 2024 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q0vBTPpB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XjjhP+xH"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C5154BE3;
	Wed,  5 Jun 2024 22:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717625404; cv=none; b=BZJXu56jn3kFVh0KG6nO6/ur7HUvMOB0xHKhOhusN2dXIRp/pR+/xgg2MQcYYv7GAEtpElLL4zQEAbXINUwe0HDRAVAc/nSdlDTZQcnrU7FN+KZd717Ye0SQjbwUEqnVjRGAogAj8nHZkxwc5jQIA2miPHHlFdsvxgbyQRAKGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717625404; c=relaxed/simple;
	bh=vm8NGhNASzRMkMaOMS4EF7ZBloPunZLMUUGqmPO/lHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2yIw17hWVz4ZxyNeH5mtgg6/ieib2KIEtPSSEf1DZXSukaX80Pbc/KM7UWWiOPxnFiDly5Bwewwun7tuxrjAjzbK5QWTI1Dq9WeReoNB7s+YzgIB0H8EDJ820cTU+vWTtyVQ6wWW8GxFrJMVncOuYRhAG7HO/9z6UmlZzFswq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q0vBTPpB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XjjhP+xH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717625401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2R7l22UwY9yFUyciye1CZnuK81vaGKmVtMpyhY7fNc=;
	b=q0vBTPpBnwtmF96XmlDkIlLdL9k3q/4F+8KN9VBJYQFohbydX/XM3NqRqDXlXYkzQkBGsh
	GuhfK8kAFHKTiAhpp3WVibbaC9Dp4eJ5TVuS+MptAv1aG2fpZBaHKFPFIkYXJbdP7qjX/v
	zj8l0/WtwrhTx+s2B8FYlV2QDERsmXKXZBCrt5g/u9v35jK+8x5T6d3sgeQdNms7l5eqkj
	XC3f6mMwYOLFeOJIRkyIzn2+phLKa1JxXnfvry9cJbAYpdN7wjo47wxjzoDSYrWNdCkPm5
	WulzyYoT4swk4DDfPukQFsPJ/O9ymePIVGRjnhSZFHxNOvpIwoXhZ9Oi3A8v4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717625401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c2R7l22UwY9yFUyciye1CZnuK81vaGKmVtMpyhY7fNc=;
	b=XjjhP+xHuaQz77lvLGuBDqKymLfoK3Trc9n5qavwAXrGCMtMeuaYL36SFUf4DrlDJMYKCP
	vAg+mTjVrptTHtCg==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-crypto@vger.kernel.org,
 linux-api@vger.kernel.org, x86@kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 4/5] random: introduce generic vDSO getrandom()
 implementation
In-Reply-To: <874ja73xx7.ffs@tglx>
References: <874ja73xx7.ffs@tglx>
Date: Thu, 06 Jun 2024 00:10:00 +0200
Message-ID: <87v82n2g93.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason!

On Wed, Jun 05 2024 at 23:03, Thomas Gleixner wrote:
> On Tue, May 28 2024 at 14:19, Jason A. Donenfeld wrote:
>> + */
>> +#ifdef CONFIG_64BIT
>> +typedef u64 vdso_kernel_ulong;
>> +#else
>> +typedef u32 vdso_kernel_ulong;
>> +#endif
>
> All of this is pointless because if a 32-bit application runs on a
> 64-bit kernel it has to use the 64-bit 'generation'. So why on earth do
> we need magic here for a 32-bit kernel?
>
> Just use u64 for both and spare all this voodoo. We're seriously not
> "optimizing" for 32-bit kernels.

All what happens on a 32-bit kernel is that the RNG will store the
unsigned long (32bit) generation into a 64bit variable:

	smp_store_release(&_vdso_rng_data.generation, next_gen + 1);

As the upper 32bit are always zero, there is no issue vs. load store
tearing at all. So there is zero benefit for this aside of slightly
"better" user space code when running on a 32-bit kernel. Who cares?

While staring at this I wonder where the corresponding
smp_load_acquire() is. I haven't found one in the VDSO code.
READ_ONCE() is only equivalent on a few architectures.

But, what does that store_release() buy at all? There is zero ordering
vs. anything in the kernel and neither against user space.

If that smp_store_release() serves a purpose then it really has to be
extensively documented especially as the kernel itself simply uses
WRITE/READ_ONCE() for base_rng.generation.

Thanks,

         tglx

