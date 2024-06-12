Return-Path: <linux-api+bounces-1724-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D027E9058CB
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 18:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036871C2109B
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D374413;
	Wed, 12 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooAJ6IVN"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FD1DFF0;
	Wed, 12 Jun 2024 16:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718209734; cv=none; b=tXNvrOToWuq5Ad4zlnUS0A16K2VO4rZ2tbK5dOzAKf5IhE6X4G1OATMnDfBZKK2N3NwJbftGXbLUKgblopXsJRotptU5AUA4XICpDbos02Ax434EVVqU9REpjFvjH0cEzOghjsxXShAV03qu+6TCHmouI1hGfx9o4OVKOmryxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718209734; c=relaxed/simple;
	bh=LPae+WJLd4Uh0XyD4sO1ssmu8Chnf3aXYZIxelrrKc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=si5wIJsH247/+yli4tLw4hzOZuwZzl7uzTgHO9I5SdjEE/qjPsO863J89u6iqW6HYendwLIYgW5aNdUn8MY4+nV8cBMVk0B7b+HTNSb1hWLInqmFZ1YRyMTP/QV2NkEkmQoNC2oY8ZqgGKy7GpKtrLyz/IcRnOEraredZzJNx5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooAJ6IVN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1622DC116B1;
	Wed, 12 Jun 2024 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718209734;
	bh=LPae+WJLd4Uh0XyD4sO1ssmu8Chnf3aXYZIxelrrKc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooAJ6IVNE7UJOqyjqkWWZXI6OnqFW9dqxjRLj9A8n+8jH/1w0mN0vLPhnMi4i5/01
	 dnt3LnqwQnsV4INWMHA6ak5C7NMRUen45gwPMaHvs2u1BZCpXr+CJBFNLWB4L+XPud
	 auU62y83ekkfsuOLrNt+Xeu+H+3zHU7M9wKWUbLsP/DKF56yAyVAc6gVo3yw7/ajH0
	 Qq9mi2dSQ2iBpkS0HYhS4OhIPDGg5SS3juKm7T7ng6GqVmTvAp1z8tnR8UMxL8Xv1x
	 +Rj1bWg9HQQvzDKgynG8d6Xrpu2DYaMpBTokQbBN+0hQCCkeL0ah9JITWMhofsT9EH
	 8ZoA06NJbIfLA==
Date: Wed, 12 Jun 2024 18:28:50 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, libc-alpha@sourceware.org, 
	linux-man@vger.kernel.org
Subject: Re: termios constants should be unsigned
Message-ID: <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5ef5bv676bhegop"
Content-Disposition: inline
In-Reply-To: <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>


--u5ef5bv676bhegop
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, libc-alpha@sourceware.org, 
	linux-man@vger.kernel.org
Subject: Re: termios constants should be unsigned
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
MIME-Version: 1.0
In-Reply-To: <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>

Hi Paul,

On Wed, Jun 12, 2024 at 07:55:14AM GMT, Paul Eggert wrote:
> On 2024-06-12 05:16, Alejandro Colomar wrote:
> > tcgets.c:53:24:
> >   error: implicit conversion changes signedness: 'int' to 'tcflag_t' (a=
ka
> >   'unsigned int') [clang-diagnostic-sign-conversion,-warnings-as-errors]
>=20
> This is a bug in Clang not glibc, and if you're worried about it I suggest
> sending a bug report to the Clang folks about the false positive.
>=20
> Even GCC's -Wsign-conversion, which is at least smart enough to not warn
> about benign conversions like that, is too often so chatty that it's best
> avoided.
>=20
> A lot of this stuff is pedanticism that dates back to the bad old days wh=
en
> the C standard allowed ones' complement and signed magnitude representati=
ons
> of signed integers. Although it can be amusing to worry about that
> possibility (I know I've done it) it's never been a practical worry, and
> even the motivation of pedanticism is going away now that C23 requires tw=
o's
> complement.

I know; I think I have -Weverything enabled in that run, which is known
for its pedanticity.  I usually disable it when it triggers a warning,
since they are usually nonsense.  But in this case, adding U is a net
improvement, without downsides (or I can't see them).

So, while the kernel and glibc are just fine with this implicit
conversion, they would be equally fine and even better without the
conversion.  Not a bug, but rather a slight improvement.

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--u5ef5bv676bhegop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZpzLkACgkQnowa+77/
2zIXGBAAk7UQ8dXCy714MXl59HRDggJWt4qmXRWslhy4AWT+bTYNBZKL/kM+GvUY
9C5DwOUEP1703W2tY3bZEhUo0JF6eIMgZDX2aQTx1SH+KIw/dM/GRkn7HJ4jNg6V
v5F1mGJnV0oVEXhzpoP2oFwZG/nqw9RFVY5ZCX0RrMfAUmUFmZOQNaTvsPAYStwj
Ha8YdJbXVl0fGF3B2nj9CFjj2fH96+vJJGdvqZxJpyGVnZ2uhhhfZ0A+Z5CffcrG
6++7YQrUHDMiB+likYke7ohUqZO4joAwm7D8cTgmphrX7Xps0alBUpCxjijKf84R
l8mXmzxrGzF4JGHy7vnoT2txsi+P3tm1PWrz0PRfdjTZh86/7krnu/f4N7a/trLB
pKpdxxKZCXYQskNFQOIeSPPJWFR/Ec/moo6/AECJ7a5kFAJDbkksWXyssFfXpPDD
9Z3T4VGlZaQMVoTMvrBSz+cmsTRUYwVc3ppB4+C5KPBw+7njF8ClVT5alLomh9AM
/yz/SpezE9Kr+QNYLMoQCp24gggcEnZIhCzMu2P5NQG1+kAVOeZyMkpvBx+uAn65
uaorsGqoJkRpRenjld8PWRVLX6fprLRN6rr1q4UgazBIl9Dia/MkZEqfbtHIygRI
SyQPwjwwE3i+zEwxK5tZ8VpuFTKqgQhBd1tJrBBXRz3Asi2Yrqs=
=JDn8
-----END PGP SIGNATURE-----

--u5ef5bv676bhegop--

