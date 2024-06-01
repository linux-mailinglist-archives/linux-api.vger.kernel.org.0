Return-Path: <linux-api+bounces-1668-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B5A8D6F6C
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2024 12:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2522B282EF6
	for <lists+linux-api@lfdr.de>; Sat,  1 Jun 2024 10:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB68814EC46;
	Sat,  1 Jun 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eYq1ylhk"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1C9208A4;
	Sat,  1 Jun 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717239494; cv=none; b=st3J9CPOzNyHo952QpuE/DoSLgG3c0MmZAB86BT/r6YcERBMJs85bDxxRsg/ljCImKsEGNssPsWsMRjryk3tM/vrvNg7hFksSDIGTQc3ix5AkqcATMmC5gOH4eMJHKWSM+B28pjsNSFQkEd+aU1+zwEKpFgJGDhqiSO/iHkKN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717239494; c=relaxed/simple;
	bh=wlnpLq+45J4tfLZFkhftuMQPmEq2WrajzpJIs6Fj/hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRfg4n+U/gaZ/bF1Z/JYgkLdCcvtMAW1AEaCm9JyNEyzMdGtQTIbqqC/2GR2bRkS7AelJdgHH1qqz7vneIuYJxlMTcOAtMhmNVM9ekN4PkJcWmcgPBdcH5Z4i3tDGScFHbXxA7iT2m+5kRQlhoyBfz168cVXQsCQlYVzP5ENR94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=eYq1ylhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD51AC116B1;
	Sat,  1 Jun 2024 10:58:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eYq1ylhk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717239490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rRRJ0TcbQymOl5qbgMPazXzODCKq3LQRPQG3lk7mexg=;
	b=eYq1ylhkfkVMl4Wa2klcb9OTPRym7AB6TOi2siOM5nXpkbGtlvmG1alalBB48r18P1GcFu
	pfO1CtOvigwoTmajePI63BjHo3mY8um8toV9l+aa8+CBRsmRxBnCcN10pj/nWKxp4/LpiP
	FUulbAb9ZnxwjoXbxnwI3ueWWtUXM0Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 386d20b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 1 Jun 2024 10:58:10 +0000 (UTC)
Date: Sat, 1 Jun 2024 12:58:07 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v16 3/5] arch: allocate vgetrandom_alloc() syscall number
Message-ID: <Zlr-v8vd0JHKYtM-@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-4-Jason@zx2c4.com>
 <CAMuHMdVJ8KpaqnWeHCMbJdf-Am6uY0N+uFM+OVxWTZH37TQvxw@mail.gmail.com>
 <ZlXX0cFl5RANHNOQ@zx2c4.com>
 <CAHmME9qZ2Xm68HQqfOmasWRoaW4xfAFAiLfw-pFbhq2i0rHz=w@mail.gmail.com>
 <20240531022621.GC1502@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531022621.GC1502@sol.localdomain>

On Thu, May 30, 2024 at 07:26:21PM -0700, Eric Biggers wrote:
> On Tue, May 28, 2024 at 03:28:58PM +0200, Jason A. Donenfeld wrote:
> > On Tue, May 28, 2024 at 3:10 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >
> > > On Tue, May 28, 2024 at 03:08:00PM +0200, Geert Uytterhoeven wrote:
> > > > Hi Jason,
> > > >
> > > > On Tue, May 28, 2024 at 2:24 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > > Add vgetrandom_alloc() as syscall 462 (or 572 on alpha) by adding it to
> > > > > all of the various syscall.tbl and unistd.h files.
> > > > >
> > > > > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > > >
> > > > As of commit ff388fe5c481d39c ("mseal: wire up mseal syscall") in
> > > > v6.10-rc1, 462 is already taken.
> > > >
> > > > v17 ++ ;-)
> > >
> > > Oy! Thanks. I should have thought to rebase on rc1 anyway before posting
> > > this.
> > 
> > Sorted in https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/?h=vdso
> > for the time being.
> > 
> 
> Please also get in the habit of using the --base option to git format-patch, so
> that it's actually possible to apply patches without guessing the base commit.

I recall you mentioning this to me in the past. I'll experiment with it
for the v+1.

Jason

