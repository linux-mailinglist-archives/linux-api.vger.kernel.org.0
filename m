Return-Path: <linux-api+bounces-1800-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F51E91C008
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 15:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EAF1F213BE
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2024 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB8F1BE25F;
	Fri, 28 Jun 2024 13:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TQgy6sC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9hT6haFB"
X-Original-To: linux-api@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2815D5A1;
	Fri, 28 Jun 2024 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582975; cv=none; b=eZVv4+mSkJcCTww037w2l4T2s3MHfGeMHaXnGYnYegGjKMmnsfdR14WfUUdySukNWI9dagiHBT+34WeZg68uxScgbS/Vb4e7Hvs2iMpzm9hsVgCR5eujGADUpvVrD4tbfkdwZrvqcSJC/q9DzO+6J43qcG2UZg86bcatgK/XU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582975; c=relaxed/simple;
	bh=YwsaHrOzPvhBj063sIEundMu75Zcsby1a7cfcxtbVCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDWzE9norvg01WgMdz/ZSKDDian5Sk8z3hmj0Ti7nthmFPaTNYbaaBGH+qxmUwVsgdZ2hXlebwLvrxOQQXX5h4/kmubHFAJKUF8K4A5bNZuqwE5lFsntzbcZkbM75cH2I9WUFYwTa6lXNcOb4Q4n5zJqm40JcSpEBN+Q8OQ5SJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TQgy6sC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9hT6haFB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719582972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0I16KSpDuZeoDhB1Yd2cM6pzj9GT5uR+PgHOxVDH1co=;
	b=1TQgy6sCUUCHUJ22HcBZ3+yTp0qQsDGGFWy88Zp21iDRkETrhKlK9HI8oYG6r23qQ6VyAj
	90M6THlVoGSq5I5ENtegYYlOSRcLMyd/SQgPJRKQQmhr+TaPPL9cUolXxmUblrhyRD4LCF
	FbCBfpZbY8i20NNmVc91gWvPg+kHBZHfzrOmeGmItmC3qxt1MlLrPaaQ4sLaGTSPqRlxZR
	uRJGkRPCSQBQ52hPf9gP7xR7DL5qw9O9rInkRH3xhGCc0HbyI0NvSlP0R/vfnLAawI3jmU
	Z5A4JVOSUwqvC1PTked86oGXHSJZNiSBVJ6f0fVJTDh/7W8bvzDvL45hCZXTqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719582972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0I16KSpDuZeoDhB1Yd2cM6pzj9GT5uR+PgHOxVDH1co=;
	b=9hT6haFBPNQuDLiNL3jknk1S40faMnJp6rLW6MBxSaEb0GjnoSfuKHQCSjCTzzFUPCpJEE
	cUoJzhIWfczTftAA==
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
 linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adhemerval Zanella Netto
 <adhemerval.zanella@linaro.org>, Carlos O'Donell <carlos@redhat.com>,
 Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann
 Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>, David
 Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v18 2/5] random: add vgetrandom_alloc() syscall
In-Reply-To: <ZnQeCRjgNXEAQjEo@zx2c4.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
 <20240620005339.1273434-3-Jason@zx2c4.com>
 <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>
 <ZnQeCRjgNXEAQjEo@zx2c4.com>
Date: Fri, 28 Jun 2024 15:56:12 +0200
Message-ID: <87v81txjb7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jason!

On Thu, Jun 20 2024 at 14:18, Jason A. Donenfeld wrote:
> On Wed, Jun 19, 2024 at 07:13:26PM -0700, Aleksa Sarai wrote:
>> Then again, I guess since libc is planned to be the primary user,
>> creating a new syscall in a decade if necessary is probably not that big
>> of an issue.
>
> I'm not sure going the whole big struct thing is really necessary, and
> for an additional reason: this is only meant to be used with the vDSO
> function, which is also coupled with the kernel. It doesn't return
> information that's made to be used (or allowed to be used) anywhere
> else. So both the vdso code and the syscall code are part of the same
> basic thing that will evolve together. So I'm not convinced extensible
> struct really makes sense for this, as neat as it is.
>
> If there's wide consensus that it's desirable, in contrast to what I'm
> saying, I'm not vehemently opposed to it and could do it, but it just
> seems like massive overkill and not at all necessary. Things are
> intentionally as simple and straightforward as can be.

Right, but the problem is that this is a syscall, so people are free to
explore it even without the vdso part. Now when you want to change it
later then you are caught in the no-regression trap.

So making it extensible with backwards compability in place (add the
unused flag field and check for 0) will allow you to expand without
breaking users.

Thanks,

        tglx

