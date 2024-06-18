Return-Path: <linux-api+bounces-1751-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C0E90C031
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 02:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96494B21A9C
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E9EA50;
	Tue, 18 Jun 2024 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oAxr+WEO"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376B28F7;
	Tue, 18 Jun 2024 00:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669568; cv=none; b=gu+JWFx6sXuRCTHiLn3nla/ZWBZpq8NBnLYgXneeAF5c9+sKSeiyKwophsk2j1YZqO5DCKBWZQaEKS48mI87e3Ivb9uILYOCfTa/YcgH6D6dEiX4mgIaoBpR9zgMN7dHg8nW6rYoZQuP06svnoCiMTGdRwCrWOH2nOns9jPTEDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669568; c=relaxed/simple;
	bh=FcbNVrUMnZi/mZuzhqR2r0VaWfJxlre1Mz0Wg1Whmkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddS/Z/8YpB5OBe7U1ywYSZh8dtbgD5nm9BDdPLZNh24FmXVH87mXsiurhIaudbJSOI0iEm6XwSfzLuxTZn5DbFXyDcxw6L622lhkxXzlp6vOGxhcyI9joCU8z0sTSU7donEB+cl735zQCcWOLmtOVeHA87JFFIMsgfHIzP2YbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=oAxr+WEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AEBC2BD10;
	Tue, 18 Jun 2024 00:12:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="oAxr+WEO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718669564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cwp0ubc/ArO8COke8OVC8H2CveQBcjJ5ljKpKuNxpG8=;
	b=oAxr+WEO11MY0ENqHNEph1lfCn63lgckX0D+iOsl1phmagv8HePcj7kgCnmRCTAugTMfSa
	9QC1VU0vcTEe1O7mlA877cvdRwEIBD88SdQ35teBSeTVsnAPwdm6Hr2zpOlPPql2+VVHh1
	MSy7csgDILU3JaCBpR8rdJxTvUmcH5Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 72c2e0f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 00:12:43 +0000 (UTC)
Date: Tue, 18 Jun 2024 02:12:40 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v17 4/5] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <ZnDQ-HQH8NlmCcIr@zx2c4.com>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-5-Jason@zx2c4.com>
 <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>

Hi Andy,

On Mon, Jun 17, 2024 at 05:06:22PM -0700, Andy Lutomirski wrote:
> On Fri, Jun 14, 2024 at 12:08 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Provide a generic C vDSO getrandom() implementation, which operates on
> > an opaque state returned by vgetrandom_alloc() and produces random bytes
> > the same way as getrandom(). This has a the API signature:
> >
> >   ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);
> 
> Last time around, I mentioned some potential issues with this function
> signature, and I didn't see any answer.  My specific objection was to
> the fact that the caller passes in a pointer but not a length, and
> this potentially makes reasoning about memory safety awkward,
> especially if anything like CRIU is involved.

Oh, I understood this backwards last time - I thought you were
criticizing the size_t len argument, which didn't make any sense.

Re-reading now, what you're suggesting is that I add an additional
argument called `size_t opaque_len`, and then the implementation does
something like:

    if (opaque_len != sizeof(struct vgetrandom_state))
    	goto fallback_syscall;

With the reasoning that falling back to syscall is better than returning
-EINVAL, because that could happen in a natural way due to CRIU. In
contrast, your objection to opaque_state not being aligned falling back
to the syscall was that it should never happen ever, so -EFAULT is more
fitting.

Is that correct?

If I've gotten you right this time, I'll add that argument as described.
Seems straight forward to do. It's a bit annoying from a libc
perspective, as the length has to be stored, but that's not impossible.

Jason

