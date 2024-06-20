Return-Path: <linux-api+bounces-1769-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1D49103D8
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 14:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB2651F217F5
	for <lists+linux-api@lfdr.de>; Thu, 20 Jun 2024 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9B170826;
	Thu, 20 Jun 2024 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aboSZd6u"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4446BF;
	Thu, 20 Jun 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885906; cv=none; b=jVlMvEEAPwkPLPylPAEA21h34UNOPTYRC4XADccnvfdhTCf2X8xR3y6bCmBxWPg2zGXvcoZSm8yJedcO7Y1fT1dy+LIGq1picERz+gb4ufuTl278l8AnOkUni6dRzyFfbZXvCgKwAZ/inY4jdGDawpAIuI5fRsgjUwT+Wp9VkJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885906; c=relaxed/simple;
	bh=m23wviM+nDSXF6oazxRjci1uVGHzXcEbpfM7cuR6PK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asZAY4x308vPsmy5Ng2iJZX70AokdXzJLOOubnGwgoXw9kZ1muZPdFNcD7Aaj7C9jFo2FAVqbOGbibpD+AwpSkY8Gb5YXAU2+TiKVDZXEX5ZPf2KTp3pPP+n0OZrPd64NGcm4hqj3sIcmOe05i6acNpqUgX4tJLVRo/zZHdSB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=aboSZd6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7064DC2BD10;
	Thu, 20 Jun 2024 12:18:24 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aboSZd6u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718885900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m23wviM+nDSXF6oazxRjci1uVGHzXcEbpfM7cuR6PK0=;
	b=aboSZd6uL21FxB4j1vA5liGJeAwbow1aX8teBrnVa7pe73ANLZxHScBS/bywZR1LvoRLTu
	EEIxN8pK/+rCTX9XbwhjbzlIwIYF4mMyZywSLtOsVWpGUuHF8KYKnQWrNl17zN3krfjsm+
	Jj/qL9Sh3lK43R9rcNFkiMU3ejZFu6A=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 650c02c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Jun 2024 12:18:20 +0000 (UTC)
Date: Thu, 20 Jun 2024 14:18:17 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Aleksa Sarai <cyphar@cyphar.com>
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
Subject: Re: [PATCH v18 2/5] random: add vgetrandom_alloc() syscall
Message-ID: <ZnQeCRjgNXEAQjEo@zx2c4.com>
References: <20240620005339.1273434-1-Jason@zx2c4.com>
 <20240620005339.1273434-3-Jason@zx2c4.com>
 <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240620.020423-puny.wheat.mobile.arm-1wWnJHwWYyAl@cyphar.com>

Hey Aleksa,

On Wed, Jun 19, 2024 at 07:13:26PM -0700, Aleksa Sarai wrote:
> Then again, I guess since libc is planned to be the primary user,
> creating a new syscall in a decade if necessary is probably not that big
> of an issue.

I'm not sure going the whole big struct thing is really necessary, and
for an additional reason: this is only meant to be used with the vDSO
function, which is also coupled with the kernel. It doesn't return
information that's made to be used (or allowed to be used) anywhere
else. So both the vdso code and the syscall code are part of the same
basic thing that will evolve together. So I'm not convinced extensible
struct really makes sense for this, as neat as it is.

If there's wide consensus that it's desirable, in contrast to what I'm
saying, I'm not vehemently opposed to it and could do it, but it just
seems like massive overkill and not at all necessary. Things are
intentionally as simple and straightforward as can be.

Jason

