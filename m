Return-Path: <linux-api+bounces-1753-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E920790C75F
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 12:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F4FB2316B
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB41B29A7;
	Tue, 18 Jun 2024 08:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Er5Bnz/W"
X-Original-To: linux-api@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9590A1527B9;
	Tue, 18 Jun 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700378; cv=none; b=JUzykseC7IDSeDDrpv4kfzpdfh8uKe0LGh5KzcmTkAofn/v6xNCiaxG2xbIqHk7owPV1v3TwcXTtfI2LU8YIsP+LJUxCkm/2OlV/CBtYzWn8zWc3QC281dxCQK7HAi/CNwfzvDa8+YChyS99/prxN9F3N4EsBJs0RED5BF53C3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700378; c=relaxed/simple;
	bh=Ss8TNFVqnuGABYJsbuJPzNJXJH3S14DqdVq9lZzErZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyZKRyGClZNx9jI/cPI4AuC48OmGXpA/usUdjoEZFntEZ3ehTTRoTvMJoshfm7QlBpoOyfo3nEAoMXsS/NbU0c1lGqksW5YuBhqsDrZ+HUMOwb6DUjNe6Yk6rcjzLhsKLdEHhanWqtCjl+XG0qkqMGsVyyi0c89QnRtRMK9eX34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Er5Bnz/W; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=zIHDqg4NPWkZl96KD/WOqKYjN1qtBnxJUKffnMyzQ40=; b=Er5Bnz/WScS03rc7NF9KCx4m78
	28rrMmcIFowoGeA+QRDAU2LTWurV+iS5YP1ZWBfU07S8gt2gCtpcPx55uyRn6M1NYKUxYwX3cQAHf
	SptP8j/szqTuLTIsBQ2tF9cPUGX3MfNvjF0Kxx247DcLu8Ax0OvKkAAi9XtfKKpywEd8xzH9+BZL5
	1aRpzJVNQVknZzHDsWKP5zQ2a7O8ROtaPG7RkwTRH6AFf9ID+ViBU9MneqxxqEfRQh57QldICLwOv
	hys+w6nmCMhGFgINDxEhlR6M9Ud878qUEqetAKjj4CDI0MIYk6zniaRE/ehIeRwYWh6yamNxIqhr0
	rIc38ZMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJUTN-000000070lB-2ZIy;
	Tue, 18 Jun 2024 08:45:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 14C9A300886; Tue, 18 Jun 2024 10:45:49 +0200 (CEST)
Date: Tue, 18 Jun 2024 10:45:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Message-ID: <20240618084548.GE31592@noisy.programming.kicks-ass.net>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-5-Jason@zx2c4.com>
 <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>
 <ZnDQ-HQH8NlmCcIr@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnDQ-HQH8NlmCcIr@zx2c4.com>

On Tue, Jun 18, 2024 at 02:12:40AM +0200, Jason A. Donenfeld wrote:
> Hi Andy,
> 
> On Mon, Jun 17, 2024 at 05:06:22PM -0700, Andy Lutomirski wrote:
> > On Fri, Jun 14, 2024 at 12:08 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > Provide a generic C vDSO getrandom() implementation, which operates on
> > > an opaque state returned by vgetrandom_alloc() and produces random bytes
> > > the same way as getrandom(). This has a the API signature:
> > >
> > >   ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state);
> > 
> > Last time around, I mentioned some potential issues with this function
> > signature, and I didn't see any answer.  My specific objection was to
> > the fact that the caller passes in a pointer but not a length, and
> > this potentially makes reasoning about memory safety awkward,
> > especially if anything like CRIU is involved.
> 
> Oh, I understood this backwards last time - I thought you were
> criticizing the size_t len argument, which didn't make any sense.
> 
> Re-reading now, what you're suggesting is that I add an additional
> argument called `size_t opaque_len`, and then the implementation does
> something like:

Exactly, that's how I read amluto's suggestion as well. Also, I recently
ran into this clang rfc:

  https://discourse.llvm.org/t/rfc-enforcing-bounds-safety-in-c-fbounds-safety/70854



