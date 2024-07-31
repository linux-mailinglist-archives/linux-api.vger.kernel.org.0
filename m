Return-Path: <linux-api+bounces-2059-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C28F942CE5
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9861C21EAD
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EB91AD9C2;
	Wed, 31 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWnkz5BV"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CA51AD9C1;
	Wed, 31 Jul 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424048; cv=none; b=CnGOKgeWzcFsOH8D//BGiOM6KMUx0LeydeT2ubNp3cMeys0VqEAx1ScjmUEGZSPz8ranZJr0XJKnHCWxxmEeD1dMTwFGKZ11XOyVARQ5uVsUPfdpFt/eoXIfYIui1l/J4CBySZsWoFpsVrphqz5eyWpcOLMzglJMXhR0IFMiMEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424048; c=relaxed/simple;
	bh=DKqWK8w0fDRanspTpttIs+NKqSbZLMGMLxtXLXXU28w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjyju+mJO7oCBgIeF7VIm+eI3N+e5OP3XsaFTxDf9D60lrNQ5m8Qelad7dAJ8v+9WKeRu/6UMqCx+W9d3BFy+pSyVaqdGep0FW3n+bOkc2N4P6DA1nERXMzY8E1pOu3IRU6qDn9nHKYcGMNw2prCIuxxmkvQLtje4282iaJ0/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWnkz5BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A103C116B1;
	Wed, 31 Jul 2024 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722424048;
	bh=DKqWK8w0fDRanspTpttIs+NKqSbZLMGMLxtXLXXU28w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IWnkz5BV7KhzbrA0cgSxbocEjf3F9aaK9nrZq/ZBadpwvuPNTEfnhCt5yQ7w+Jsz0
	 5Jh/7cdEBMps/7ftD5jEBHpP1trquP3Nxa0mPj8kEIdiqmrMomJ2Q2M3VCOWr8JnCy
	 bQLBxSBwo4GxvWHTmMsFBki+bydpC11/ladqbm4zUSqLPlBZGXETN3SgpJp9DQsZSV
	 6b7U3tBJnxYIy+HA7VdGSD8QRNxRDvpDXYa6hF+CD2Zu+TorahSoXLmQNsdkoQdoJ9
	 z5Oqh6oe1140p8BKteNEQoAcJSVUpDrU7jpKQYStB0s3al66CwUcR7VfcP37nik0Ar
	 bbjJyadutnRvw==
Date: Wed, 31 Jul 2024 13:07:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?B?5r2Y5bCR?= <i@andypan.me>, 
	Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man <linux-man@vger.kernel.org>, 
	linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] epoll.7: clarify the event distribution under
 edge-triggered mode
Message-ID: <l3suz7pnchnpnd5hhpxk5xqdikdxevp3dsybmhlcmzu6yih66s@zxuvoiunfqwl>
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
 <2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
 <tencent_311E460546C884C26FB32E3C@qq.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vkejb3smn2gjb2q"
Content-Disposition: inline
In-Reply-To: <tencent_311E460546C884C26FB32E3C@qq.com>


--5vkejb3smn2gjb2q
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: =?utf-8?B?5r2Y5bCR?= <i@andypan.me>, 
	Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-man <linux-man@vger.kernel.org>, 
	linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] epoll.7: clarify the event distribution under
 edge-triggered mode
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
 <2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
 <tencent_311E460546C884C26FB32E3C@qq.com>
MIME-Version: 1.0
In-Reply-To: <tencent_311E460546C884C26FB32E3C@qq.com>

[TO +=3D mtk]

Archive: <https://lore.kernel.org/linux-man/tencent_311E460546C884C26FB32E3=
C@qq.com/T/>

Hi,

On Wed, Jul 31, 2024 at 06:54:26PM GMT, =E6=BD=98=E5=B0=91 wrote:
> Hi Alejandro,
> > Since even with edge-triggered epoll, multiple events can be
> > generated upon receipt of multiple chunks of data, the caller has
> > the option to specify the EPOLLONESHOT flag, to tell epoll to
> > disable the associated file descriptor after the receipt of an
> > event with epoll_wait(2).  When the EPOLLONESHOT flag is
> > specified, it is the caller's responsibility to rearm the file
> > descriptor using epoll_ctl(2) with EPOLL_CTL_MOD.
>=20
> This paragraph in man pages of epoll starts with "Since even with
> edge-triggered epoll", thus I assume the following sentences of
> "multiple events can be generated upon receipt of multiple chunks of
> data" and "that is, an event will be generated upon each receipt of a
> chunk of data" ought to be talking about EPOLLET naturally. Have I
> misunderstood something?

I understand it as:

	Since _even_ with edge-triggered epoll [and thus also with other
	epolls], multiple events can be generated ...

the stuff after the comma applied to at least more than one epoll typer.;
That's maybe why it's so generic.

However, I think a clarification like to one you suggest could be
appropriate in the page.  I've added Michael to this mail, who may be
better placed to help with these APIs.

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--5vkejb3smn2gjb2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaqGu0ACgkQnowa+77/
2zLKKhAAkSi76XvMU6F+eQPn/Tz3ChDRyVNRFKDuFBFLpFzHEk67BTu85+McDlws
6jIc6dwyNfMkqI9yaRkh/hrNSbRs+SKL1vCRl7cDxtoRL+p2PEAhmnc5VT0vi1k9
APc05at6BsyV2nrafljaOITkSVQuftq5Q6tWcWAdKBvMZ153/MHdAl8NI9QOEhpy
oRiPbs5lt8WeU7Qk693+iRtgOylj6W115rvRcllWqaLcub+OEOYXB41xZ51dFy0C
d/cQtdR+/f5BgDQr7sM7t3qo0drLMRutQrFcDyuSIZSh8+KDHr09UIQcxRchrC/i
Xa872Gha6vEDccJ0gxi9WvPhZhG3H7rYMJYhJBioDjtEr9pA2cktikVVrPDFOoHP
Vs6RGQr5WSIQ7qzyk5sF0fsKT7M6Uq2RAySqu/1f8pwgXb7tu9/YcEOQR9wPttpr
F+OA+qnKVDnZ+MK0Wz/Iyl+QVBrfyrXASnpETNCN9/w7mGyG2jve7605t+dB9z03
sVwF9aYmngNhpPeef+iDmUe21aQnf2j0R5foyz6tK+VGMpjWdxpGOL/3Bb+rExl9
+rqAi03k5DWFo9V3NEUHca62g6UfE1KCfV2bD1sNED/eRt/SsZpo1kCtXy496urB
uNlH4nBhuSt8Xh22lD7mhSuvfBytOv5/ACwJM+DsmUXkFBnAg6A=
=mlfe
-----END PGP SIGNATURE-----

--5vkejb3smn2gjb2q--

