Return-Path: <linux-api+bounces-3550-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBE7A9811D
	for <lists+linux-api@lfdr.de>; Wed, 23 Apr 2025 09:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183AA188576F
	for <lists+linux-api@lfdr.de>; Wed, 23 Apr 2025 07:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC326AA84;
	Wed, 23 Apr 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw7O2SvM"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A77269AFB;
	Wed, 23 Apr 2025 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393508; cv=none; b=Og4hb2ImbPk6IQtjI/oSyopHAP0Zs9bES9HYDVIRwvWXz51Oh+J22WD4jHO/AxF5ARJqT6/JG0fpRcIFMd2SKZa4UqyxUdk/5syJOXMUMih/4t70gAq75gYc5Dk7bnBN3NqD4WJW1TWaquQlZUQdZGrcri5qgTK47MhXFqdT3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393508; c=relaxed/simple;
	bh=W27QoYWozWtPlg4CTM+qPGkbqa9JdnugfOcLmSEveHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S98aowJqdaUEOsFtoas41xL4wb2i7N5A1scbPsr/dWuEqGSTtZPCLfGEorPAuBbB1EIF7cfZIRZz7pIcx8dZCM1pJnQ8fS2ecNXhquuF9nQ7j2iJq2qF73k1szkIfQEc/par5DVOsUHOUuUW5O5UpXauVFBxDm7QfsawKbjyhjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw7O2SvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86695C4CEE2;
	Wed, 23 Apr 2025 07:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745393507;
	bh=W27QoYWozWtPlg4CTM+qPGkbqa9JdnugfOcLmSEveHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fw7O2SvMmm2uF1LyiC8TLQisXJyIMB988RU7Aa4PZYFg6vQ/6tcPrxuw0KNEcwfRv
	 nG2tAV9/cxuDCdedvZeHsUI8qZ01BYTWJo22PoRfP5KOvHqSnU3R+wT29KS15NG6bm
	 MoPKTDwn2Vz+aPDQK0FiKi7bhXXFB1UVlwfMlpvEsYJZP3D2Rn9barfHSl4gxtLpd+
	 zfppa0ufv/t4xy3j2ahzTvwMW2ZPhsHi8aw9D1TFoE4eKmp3jGtNqxEcu8RJh84gz7
	 HXMWRYMQ5Tg33GGzTpCL0kbkxyT1HOH94s2sIUZsIv/M0ZL9YrkvjzhrCvMMV4KEdW
	 MtrWchJKEs+aA==
Date: Wed, 23 Apr 2025 09:31:42 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: newlines in filenames; POSIX.1-2024
Message-ID: <3wpydsib5maytq4m4ve4b7wfbfkxwzd5m6u5woqr43qr6mickk@gw4ww6vvgyo5>
References: <iezzxq25mqdcapusb32euu3fgvz7djtrn5n66emb72jb3bqltx@lr2545vnc55k>
 <20250422222131.GE569616@mit.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlxqfgmgmh5zxyxe"
Content-Disposition: inline
In-Reply-To: <20250422222131.GE569616@mit.edu>


--vlxqfgmgmh5zxyxe
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: newlines in filenames; POSIX.1-2024
References: <iezzxq25mqdcapusb32euu3fgvz7djtrn5n66emb72jb3bqltx@lr2545vnc55k>
 <20250422222131.GE569616@mit.edu>
MIME-Version: 1.0
In-Reply-To: <20250422222131.GE569616@mit.edu>

Hi Ted,

On Tue, Apr 22, 2025 at 05:21:31PM -0500, Theodore Ts'o wrote:
> On Wed, Apr 16, 2025 at 06:50:00PM +0200, Alejandro Colomar wrote:
> >=20
> > I'm updating the manual pages for POSIX.1-2024.  One of the changes
> > in this revision is that POSIX now encourages implementations to
> > disallow using new-line characters in file names.
> >=20
> > Historically, Linux (and maybe all existing POSIX systems?) has
> > allowed new-line characters in file names.
>=20
> Do we have any information of which implementations (if any) might
> decide to disallow new-line characters?

Such a list doesn't exist.

<http://austingroupbugs.net/view.php?id=3D251>

> If the Austin Group is going to add these sorts of "encouragements"
> without engaging with us dirctly, it seems to be much like King Canute
> commanding that the tide not come in....
>=20
> Personally, I'm not convinced a newline is any different from any
> number of weird-sh*t characters, such as zero-width space Unicode
> characters, ASCII ETX or EOF characters, etc.

Newline is slightly more problematic than those, especially in scripts.

But yes, other characters (mainly control characters) were also
discussed in that bug.  From what I can read, it seems they were scared
that if they attempted to suggest banning all control characters at
once, there might be more opposition, and the standard would be toilet
paper.

> I suppose we could add a new mount option which disallows the
> weird-sh*t characters, but I bet it will break some userspace
> programs,

That's an interesting approach.  Being an opt-in mount option, users
will only break at their will, and they can always go back to old mode
when they need to do some operation with weird-sh*t characters.

TBH, while I see the chances of breaking stuff (so I don't see this
being the default in a long time; maybe ever), I think an opt-in mode
would be interesting, for those that know that don't need to handle such
broken file names, to have a tighter system.  I would enable such a mode
in my systems.

> and it also begs the question of *which* weird-sh*t
> characters should be disallowed by the kernel.

I think a mode for disallowing _any control characters_ (aka [:cntrl:],
aka 0-31) would be a good choice.

> > I guess there's no intention to change that behavior.  But I should
> > ask.  I thought of adding this paragraph to all pages that create
> > file names:
> >=20
> > 	+.SH CAVEATS
> > 	+POSIX.1-2024 encourages implementations to
> > 	+disallow creation of filenames containing new-line characters.
> > 	+Linux doesn't follow this,
> > 	+and allows using new-line characters.
> >=20
> > Are there any comments?
>=20
> I think this is giving the Austin Group way more attention/respect
> than they deserve, especially when it's an optional "encourage", but
> whatever...

I'm not worried about that, I was more worried about the churn in the
pages.  I later remembered we have a pathname(7) page, so I'll put it
there, just once.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--vlxqfgmgmh5zxyxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgIl1cACgkQ64mZXMKQ
wqmslhAAvhbTL05ZlYEhBpF5LFyyKUz9kIUb93sFyaenaNfydBgqCuH2Lreyo3yG
z8ac7C8kBtsShQ71eQU9Z98hxRxkt2qOC5m5iTLLIG/Gb6cp08xuhyMG94FNl22c
nQDVR9ETlywpUGwUfBLYeti2tf2UlOnlqkJvL9liY87PGTgdOLnJwPwoxyHw6yM5
WDRfveife0cR/k1paA5kngqm26naF7Fi0ChUiQH6PEJiwkg8ZrbiFG7QaW2MWLeS
LBzE+aFYW3ALJQGrnN9HsZ8bJoqz3YnNv/wu7J/BNXCQE/ky+uE14UxmneF6Rez0
uMvZYaKif6LYjF3C7U+iKTIYoGw46DZyNFdC6unEWVfryemM3iN3n1wLFA3rCaA6
ABPnYBcuLtRQaPJ2L0r1xnnh9hexwvagQ4C8tO4ibVo0TC6m2aPa5Y89WWpDjjsa
s2b95DJLITJpwtgUtH+sclh5YyQtSqha/Uq9q2TiOifaKG4+Oo5owmYPI7+LhWfL
A4QN1XkK8Wg6uPcgzKujJd+rNwTdNLGyUMD4qSL4W/54PEYSB2o5kJvmBAZL5u4h
OoNQoc0Q5xbrrqUq5aAfXi2BaFFAO4la0vN3K4PIiboHYjoBjwTAPG6oTJ7Uvpps
OzCmwTLFpB4O3gkU2Rp5XYwXrBa3YIW8jmyyR+HMPwNmG/WWJJ0=
=x3q5
-----END PGP SIGNATURE-----

--vlxqfgmgmh5zxyxe--

