Return-Path: <linux-api+bounces-3868-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF8BACDC4B
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 13:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A40C1746A9
	for <lists+linux-api@lfdr.de>; Wed,  4 Jun 2025 11:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A0728D8D0;
	Wed,  4 Jun 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyvx8Ew2"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83B756B81;
	Wed,  4 Jun 2025 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035130; cv=none; b=b3+lgpTNtMwU8DjVFKsvHP4dzlgkx3kAX3qQMXFsgsQl1CYlHnUTLo4EWDgYbd1du7nMvYPvDCZiiWdbaENu/b8ahKYdE+tFC+ySTSrB238uT4UOB75IMSiDUgim0XRh1QAoelxjGYmCU7fZg8WZMH46FHVD4S/3Hz2htqWzPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035130; c=relaxed/simple;
	bh=cg0T1yIQI7Ucejk4Gmh/4YQZt5t7iZ3WyH3OyMfASgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9PVAqBRfKJmm70vEioVYDf5PEe4BV/v500sixHSkp+lNJsnuvtF7ynR6uwBN3J/mpLGRHjp1+jRJuvFA4ksmVO/OGdjQgvitAN9nSWTaLKyXt2nXwlmXgFvT19ve127abTH1uc4374Cpx9N3v8X8NbjQ9QLAn2u18SirVKo/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyvx8Ew2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3162C4CEE7;
	Wed,  4 Jun 2025 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749035130;
	bh=cg0T1yIQI7Ucejk4Gmh/4YQZt5t7iZ3WyH3OyMfASgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vyvx8Ew2CRsTvABqXjBD2PDGfEkQeZfMXE2RMWvgldcItEE7Awc99YdCCJqzkruPg
	 AxphnFJauUA7oIuZKGY19P81rZQyYDzMAhe7PBQ1B2fgW5M6NX9TC5OgxfPTico+R2
	 5uEbStFKtnDG76ucSmEEB7HOy4lMN5VCvQZ89ovTYcAusJBqStYckBZ7+jIuKlILmI
	 nStTOwil5DY2tRKvyyAVaSI9wumTHHf655ERj1yVQJISKer3IYn7lvxFTq6dELezNu
	 IYqgPN3OO7neFEDPPOY8QqRzRDWnA+9j5/GCQwSVAaRwjqfz7bIHSK5j4ZBlB7wfQZ
	 9oI4OJEoshAAg==
Date: Wed, 4 Jun 2025 12:05:25 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yury Khrustalev <yury.khrustalev@arm.com>, linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-api@vger.kernel.org
Subject: Re: Extending clone_args for clone3()
Message-ID: <069a9c63-3cb4-4fc4-9566-bfffb6d07cc5@sirena.org.uk>
References: <aCs65ccRQtJBnZ_5@arm.com>
 <71c9bd77-85fd-4f00-a36a-8621640ebbb5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LuHmAmRYU6fI7wQl"
Content-Disposition: inline
In-Reply-To: <71c9bd77-85fd-4f00-a36a-8621640ebbb5@app.fastmail.com>
X-Cookie: Non-sequiturs make me eat lampshades.


--LuHmAmRYU6fI7wQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 04, 2025 at 10:29:48AM +0200, Arnd Bergmann wrote:

> As I understand the shadow stack feature, we want this to be enabled
> whenever the kernel and hardware supports it, completely transparent
> to an application, right?

Slightly more involved, but roughly.  The application and all libraries
linked into it should be built targeting shadow stacks (most binaries
will already be compatible but it's possible they wouldn't be so we
can't just asssume that) then if everything is compatible shadow stacks
will be enabled transparently by libc if the system supports them.

> I think ideally we'd check for HWCAP_GCS on arm64 or the equivalent
> feature on other architectures and expect clone3 to support the
> longer argument whenever that is set, but it looks like that would
> break on current kernels that already support HWCAP_GCS but not
> the clone3 argument.

> Adding one more hwcap flag would be ugly, but that seems to be
> the easiest way. That way, glibc can just test for the new hwcap
> flag only use the extra clone3 word if all prerequisites (hardware
> support, kernel gcs support, clone3 argument support) are there.

We'd also have to add something similar for x86 since that's had the
support even longer, and the RISC-V series looks like it's getting near
to being merged too so we'll likely have the same problem there given
that the clone3() series is not progressing super fast.

--LuHmAmRYU6fI7wQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhAKHUACgkQJNaLcl1U
h9BwdQf+MCEl2EhpjZORAr4HEpjhBRMRrwiL5qIKtHRy52EhAgX/Uni52uItWG9G
67x2Mdaqk4ow2SkawYCT3aTxpccLCmQuXu/hEcvwE0d+MDe8HAhA3CH4kphgTy1d
3l1LF7Nyz+bwMhRX9FxE2UEAw4cWssEt85vOdCwaA9piZ1mPO7kAKM9zEGg1JnjI
D3USaqin4rRGqEZDbNW5MVit52App8J1IRHtG2YJn+nYkekp0tl0IH9tFPDJ5bVH
Z7fQgIbdR4SOebI3WhD7z2Uq4rDTPnJJHoMOmluHuyBi7po9dhZCNQ3XopGiCC/8
97EyU3KMT/Hdm3w1PRFgPVzMMIeG4g==
=SyAz
-----END PGP SIGNATURE-----

--LuHmAmRYU6fI7wQl--

