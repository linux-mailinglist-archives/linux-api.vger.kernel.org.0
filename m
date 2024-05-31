Return-Path: <linux-api+bounces-1653-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DF38D589C
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 04:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E883AB237B2
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2024 02:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8F7711F;
	Fri, 31 May 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oe6uV8JS"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DA20DC4;
	Fri, 31 May 2024 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122383; cv=none; b=q+yCruVXI9qsOaNMujDhDKSUzZuf+NIXE5U+cINBvuyeDs5wkortcKDdD8Axrsx5ep35VH5zXDh/9frIBCqXjrYzKsmtwARpIV/B7HOJ8wvFarhrZ+imdVRjTFouvqPsczv1ZqqdcJjXtFHYET1jo6iP5iyIobi/VEkrcxWa37w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122383; c=relaxed/simple;
	bh=fVi4ylKay0KL6bu7GgnrHfpmzXR1Mdq7vr4bBw59r6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzr28kRqN8lJUqOZKd9YJEcnNZLbajdE6TB+dd4FJaZemBrfRohGHO24VnPXzWVH8e3mmJgFTNZw4vk/b9ky8ExaGG2eqFkc+MCwz4p6W+cHDfsreSh4HWEORi+lyvNRcW0Mzu3XWdww16xHqeFNQfKj0y1zOSdX4tTVPUL+fvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oe6uV8JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D58C2BBFC;
	Fri, 31 May 2024 02:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717122383;
	bh=fVi4ylKay0KL6bu7GgnrHfpmzXR1Mdq7vr4bBw59r6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oe6uV8JSRGa8e2ZUcG+vT8hQ43JHZixjCFJdKv/kU7pBFHTdFFZ7uSxhnEORNm3QY
	 MKjZcZzPzRQ+Kqe185HPmR0mLsMU2ottkByVGgW92yP7XJX7rsrzKredB25rGzwF5Y
	 MqJiW3C0O5ZfNugL4npzB7l5ks/lRHXcMmzPpOrvKCvrUBAh7Tpw4Byn42jptcaoHf
	 HUYzp7bSlLS+IV+c+A39n3Z34ErPSxvJ9gpSQ8HjSe2Pr3kEqSvmQzUHhLXep4QJIZ
	 1baplJ9Gkqq6IZzYX8tws1lZXzR5zCw4+UUbQ+8FJxcYk05zf1ks5wjT3MqR5b+S1m
	 4wpJjx8IZ1DNQ==
Date: Thu, 30 May 2024 19:26:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
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
Message-ID: <20240531022621.GC1502@sol.localdomain>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-4-Jason@zx2c4.com>
 <CAMuHMdVJ8KpaqnWeHCMbJdf-Am6uY0N+uFM+OVxWTZH37TQvxw@mail.gmail.com>
 <ZlXX0cFl5RANHNOQ@zx2c4.com>
 <CAHmME9qZ2Xm68HQqfOmasWRoaW4xfAFAiLfw-pFbhq2i0rHz=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9qZ2Xm68HQqfOmasWRoaW4xfAFAiLfw-pFbhq2i0rHz=w@mail.gmail.com>

On Tue, May 28, 2024 at 03:28:58PM +0200, Jason A. Donenfeld wrote:
> On Tue, May 28, 2024 at 3:10 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > On Tue, May 28, 2024 at 03:08:00PM +0200, Geert Uytterhoeven wrote:
> > > Hi Jason,
> > >
> > > On Tue, May 28, 2024 at 2:24 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > > > Add vgetrandom_alloc() as syscall 462 (or 572 on alpha) by adding it to
> > > > all of the various syscall.tbl and unistd.h files.
> > > >
> > > > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > >
> > > As of commit ff388fe5c481d39c ("mseal: wire up mseal syscall") in
> > > v6.10-rc1, 462 is already taken.
> > >
> > > v17 ++ ;-)
> >
> > Oy! Thanks. I should have thought to rebase on rc1 anyway before posting
> > this.
> 
> Sorted in https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/log/?h=vdso
> for the time being.
> 

Please also get in the habit of using the --base option to git format-patch, so
that it's actually possible to apply patches without guessing the base commit.

Thanks,

- Eric

