Return-Path: <linux-api+bounces-2238-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0295A769
	for <lists+linux-api@lfdr.de>; Wed, 21 Aug 2024 23:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FD11F21281
	for <lists+linux-api@lfdr.de>; Wed, 21 Aug 2024 21:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5CD17B505;
	Wed, 21 Aug 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRBotNrX"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7C17B401;
	Wed, 21 Aug 2024 21:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277537; cv=none; b=gYP9SelwFuFeI8da8NWM87bpC06Vy12eDE24+8q3LAboKWeRayK9smbgzjO03t5c4gVNfpFLp30GwLGJ547hYMwV46lo699LmHMyybDCQSNpSOaq9Ro0wvQ/H72FekQkMPy4tQikUeJ2p+WPXcjqU3l2cjWq+SuXOU+6vdYtzNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277537; c=relaxed/simple;
	bh=bWjImAZMqivQMCaCZXfjmEf6FQqQXEvyO9C8lKG68d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2GY/4AADK4uwXUbk0KcWCBY4LusnFwqBsXwK669QxFEhhSCV/Yy8SLPZpH8i5z+SWiHOI0lULyOK62Y2/QEaKuVoEg/rCvaYAwFRGgT5FCQf4V2MZmk9MHOKG82egPKwQBtU4RWGpwj5N+yu9mmkFxxqbQfx5OZ1HVZxtciI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRBotNrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C33C32781;
	Wed, 21 Aug 2024 21:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724277537;
	bh=bWjImAZMqivQMCaCZXfjmEf6FQqQXEvyO9C8lKG68d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TRBotNrXL8JVzhgdjl6gp+49SG59TXrT4do8VyARHTTigCdpPe3mjhAQs2FpgdlFu
	 Vg+sQ16z7h9/ehb5I270dE0aLe/GU5z+w7GPL+cAK10BQYcpKPHsTVjc2feJB6NZZY
	 0VGvhnp8TswowaBkfIiSITt31we8AeRegjGS0Pnf2slBuvTN6W3pT9DywYwuKaHxsE
	 VDeWr/vYMlW0xxwkWQUi/y+vUy7cpFE/Hc+B668+bAJxEqvisZe6sqhcwGgFpQNh1s
	 uDHkTjpeJloobP4K87+x2uLeKZ1GT2zk1xdJ3iPTKPfy/TLmoAghCEXVqixJAz2Eia
	 nQTSOsKUYin4w==
Date: Wed, 21 Aug 2024 23:58:53 +0200
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?B?5r2Y5bCR?= <i@andypan.me>
Cc: linux-man <linux-man@vger.kernel.org>, 
	linux-api <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, 
	panjf2000 <panjf2000@gmail.com>
Subject: Re: [PATCH v5] epoll.7: clarify the event distribution under
 edge-triggered mode
Message-ID: <u2duuhzmc7ht57qwwzsei2p2f6da424pjshyswfmtman3kvmdp@slfra5g3k5q2>
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
 <3d4xkgo7fr6mrlnbcocstjs4ctrh3sutcyrxtgqseiwdjoino5@i3bbqxzii3vx>
 <tencent_45987B697E98024524D8BF8C@qq.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hj4gbivmhn3wtpyy"
Content-Disposition: inline
In-Reply-To: <tencent_45987B697E98024524D8BF8C@qq.com>


--hj4gbivmhn3wtpyy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?B?5r2Y5bCR?= <i@andypan.me>
Cc: linux-man <linux-man@vger.kernel.org>, 
	linux-api <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, 
	panjf2000 <panjf2000@gmail.com>
Subject: Re: [PATCH v5] epoll.7: clarify the event distribution under
 edge-triggered mode
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
 <3d4xkgo7fr6mrlnbcocstjs4ctrh3sutcyrxtgqseiwdjoino5@i3bbqxzii3vx>
 <tencent_45987B697E98024524D8BF8C@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_45987B697E98024524D8BF8C@qq.com>

Hi Andy,

On Sat, Aug 03, 2024 at 10:15:10PM GMT, =E6=BD=98=E5=B0=91 wrote:
> Thank you for the updates!
> Please also update this email thread after merging this patch, thanks in =
advance.

I've pushed everything now.

>=20
> Sorry again for interrupting your weekend. Have a great weekend!

\:)

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--hj4gbivmhn3wtpyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbGYx0ACgkQnowa+77/
2zJ+OxAAoAnWbkHhfqnME6he/eiOSKlPqH5a4o14ofmnUbWx2LbQRBzQ5u6UHZFY
LwLyvYnzoBf9PNIWuSxQP2wCa9bYcYW00PotqV9dHN+t44hYhjKbHbQEcz9FqDOj
oFFR0nmpUIH5hH690PApmDbQ5HJYtKk1J4ioii6jbg5t8JdU9PxSMllP9krRkENf
QVumeONsDZpKkxXxpd1HaERZ/S8xy8f0e4SU8HfkjA+8MzmR3mPBLbGNox2LWBDI
kETF65lbsX8SYuhT+QF9A+C1MWK3x2v0hkCeIL6/vuMTmWRutbxWYtLFSd4cpXWE
kVhgPsg/QOEk/EKeewCWWuGPDkJjUrUtXBt0YWW/c2celqlLEJREWbJ90fdGyV4n
gN6KUYtPv/OfqxXSW9beRsa5/iyTvwOiyUzTHL/ex1eM072YLYgDf5u/4i7zfqfw
JJT1e3KbmWJQVtGLNgQU0JIFotKTGM8DzaPKUjjj+1B5SK7ml0IZgfp4yHb9R0Aq
twwOjd9aFglFL4e+WJFifyJBecJ2ku2JuH5UMNr0JTgZ8CZ8wFObDu7DnRBIKlX7
isZxe2FQhyewo50mOR/sxA1HYbVB58l1cJHZxKQQ25Y2h6TWhYWEBTs2bEpKeyQ/
EGCAks6693n9wTUiQrcwtKTSGgO1s4M6HhKftllktGxRQsPZ8Jc=
=xwuB
-----END PGP SIGNATURE-----

--hj4gbivmhn3wtpyy--

