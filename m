Return-Path: <linux-api+bounces-1754-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E652C90D303
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F5E1F20986
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6359F15B99B;
	Tue, 18 Jun 2024 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YOnvFoSI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B2B154C02;
	Tue, 18 Jun 2024 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717529; cv=none; b=L7sp+3bUIzdk+fHyJJs+anxVwLdHl04u/pCbUsARJQsz4Kc1hhKCFz/cOnvG+yzmGAr7dq6YBD5T6bAteMS1sEjnhB457HiAqkETtqFsQySj7DhxWhVOYs7ngWKzCdqPZADozg2stbWgUKWRZWsbMXUowUzxnNjDSbDu66tF6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717529; c=relaxed/simple;
	bh=qEkj4//U6KG8xRAeMon7L+0J8zZLN/mZEyxTlEPRTbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LF+4HMrwpLhnONS50GjP4nzimr/zK4Pqo0QXBn7eFJ4gCzKjMzaL3Qf2DB68U4dKGbgCAjS8FydVePseNCTrRd+l8dWMc614nUtRcgNciqMiCeR0MImb/k0k0SDeTybukCFBq+AQC96wa9pXz+RrOiU129Ee1qWwxp4EmHOCMr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=YOnvFoSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C43C3277B;
	Tue, 18 Jun 2024 13:32:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YOnvFoSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718717524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dXgTJ+f0QK4xyk6S0WAzQZ56fTF02lsoZfvyGwGUpGA=;
	b=YOnvFoSIHAUfloRtGqwbXjuzFNL49AdMN7f7g+JamurOUujx5DTbMwqEd2kCTOHFNgw8gS
	C3qtfplIVATyyxO2mxH9UT7I/5iPeVarelvrWYxONiGjErUIoXwZ7Wqtgt0hfIdSy+/g/M
	2vwm/uY3OfvrQrq4qeYpmRW1lugCyws=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 53381528 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 13:32:03 +0000 (UTC)
Date: Tue, 18 Jun 2024 15:32:00 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v17 4/5] random: introduce generic vDSO getrandom()
 implementation
Message-ID: <ZnGMUMf73dMdaZWv@zx2c4.com>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-5-Jason@zx2c4.com>
 <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>
 <ZnDQ-HQH8NlmCcIr@zx2c4.com>
 <20240618084548.GE31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240618084548.GE31592@noisy.programming.kicks-ass.net>

On Tue, Jun 18, 2024 at 10:45:48AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 18, 2024 at 02:12:40AM +0200, Jason A. Donenfeld wrote:
> > Hi Andy,
> > 
> > On Mon, Jun 17, 2024 at 05:06:22PM -0700, Andy Lutomirski wrote:
> > > On Fri, Jun 14, 2024 at 12:08 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > >
> > > > Provide a generic C vDSO getrandom() implementation, which operates on
> > > > an opaque state returned by vgetrandom_alloc() and produces random bytes
> > > > the same way as getrandom(). This has a the API signature:
> > > >
> > > >   ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);
> > > 
> > > Last time around, I mentioned some potential issues with this function
> > > signature, and I didn't see any answer.  My specific objection was to
> > > the fact that the caller passes in a pointer but not a length, and
> > > this potentially makes reasoning about memory safety awkward,
> > > especially if anything like CRIU is involved.
> > 
> > Oh, I understood this backwards last time - I thought you were
> > criticizing the size_t len argument, which didn't make any sense.
> > 
> > Re-reading now, what you're suggesting is that I add an additional
> > argument called `size_t opaque_len`, and then the implementation does
> > something like:
> 
> Exactly, that's how I read amluto's suggestion as well. Also, I recently
> ran into this clang rfc:
> 
>   https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/70854

Alright, I'll have this for v+1. Patches already written now, for both
kernel and libc, and I'm dogfooding it.

Jason

