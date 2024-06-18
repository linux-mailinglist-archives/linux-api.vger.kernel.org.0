Return-Path: <linux-api+bounces-1757-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA890DC61
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 21:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3AEE1C2283D
	for <lists+linux-api@lfdr.de>; Tue, 18 Jun 2024 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF2161901;
	Tue, 18 Jun 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KY6RjJcv"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45B15747F;
	Tue, 18 Jun 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738876; cv=none; b=uPbC8FADph8QOFhsvOkW/+EztTsXV2OWitC7q6yAHMeTXHvi3oxCRS+oiqEVRFmNeJZgM3SJBSplGMFYgxsZIc7JoFdeo/xiJZ96zqbisabdGut1FVpU0zO7vb+NqFALQObtrH0a7NqyLWpRHd2Hv4BCw0Fu8SExBtUyxDjXy1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738876; c=relaxed/simple;
	bh=heR/isSr78VcW/VYrPWTjRfQ7W1E6j/MQUID0htM5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUi9KVbwbXrMat+aob2NozU2IpBZS2wB1XSWUoQ9puHSkgTI6c2YfuPJRVpJzO1vElhnlBerIY+dDIr7QyU+x2kj6rgFLp7DlaIPFPvbn8nOhwGxNkh0IKFg2g2yex8Q8g1pOcmJVn8Ck524zEEtoUAlIFFzNWAgPvrxxZUKpsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=KY6RjJcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5F3C3277B;
	Tue, 18 Jun 2024 19:27:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="KY6RjJcv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1718738873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+M43ijHJAES43FqmOh139eqeLQGGZwedR3F/gwSFa4=;
	b=KY6RjJcvm/x40m75gOjTtS5zZeqJn6Hk6z5rySRNMI1VIx5Dc65xsL/Ek3fQwB70rHmUra
	mdhDiYsVZr2fEVMCyZ248m8uSfIio4SolEXXEchZDvepYgd4DmrhwyTsyKYp0Zw/BAfWRW
	GrTqF8l+K33DEyV9p1Lhegiix3TzTqg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fbae344a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Jun 2024 19:27:52 +0000 (UTC)
Date: Tue, 18 Jun 2024 21:27:50 +0200
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
Message-ID: <ZnHftrP3H410gScf@zx2c4.com>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-5-Jason@zx2c4.com>
 <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>
 <ZnDQ-HQH8NlmCcIr@zx2c4.com>
 <CALCETrWzXQMXjvL+nGq-+aLVUeiABJ46DACtLnrLXxmwh9s_dg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWzXQMXjvL+nGq-+aLVUeiABJ46DACtLnrLXxmwh9s_dg@mail.gmail.com>

On Tue, Jun 18, 2024 at 10:55:17AM -0700, Andy Lutomirski wrote:
> On Mon, Jun 17, 2024 at 5:12 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
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
> >
> >     if (opaque_len != sizeof(struct vgetrandom_state))
> >         goto fallback_syscall;
> >
> > With the reasoning that falling back to syscall is better than returning
> > -EINVAL, because that could happen in a natural way due to CRIU. In
> > contrast, your objection to opaque_state not being aligned falling back
> > to the syscall was that it should never happen ever, so -EFAULT is more
> > fitting.
> >
> > Is that correct?
> 
> My alternative suggestion, which is far less well formed, would be to
> make the opaque argument be somehow not pointer-like and be more of an
> opaque handle.  So it would be uintptr_t instead of void *, and the
> user API would be built around the user getting a list of handles
> instead of a block of memory.
> 
> The benefit would be a tiny bit less overhead (potentially), but the
> API would need substantially more rework.  I'm not convinced that this
> would be worthwhile.

I'd thought about this too -- a Windows-style handle system -- but
it seemed complicated and just not worth it, so the simplicity here
seems more appealing. I'm happy to take your suggestion of an opaque_len
argument (and it's already implemented in my "vdso" branch), and
leaving it at that.

Jason

