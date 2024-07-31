Return-Path: <linux-api+bounces-2057-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDDF942C1A
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 12:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2671C21E15
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 10:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6981AAE20;
	Wed, 31 Jul 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alFEDCuz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFE1A8C02;
	Wed, 31 Jul 2024 10:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422381; cv=none; b=CM+w8rXw6mzzcHKj33D7QO+ja7ENSeskFizOxV2eOOVJZywqfBDAjevYlJNzk/ywHi6flvfg2YPdJyMniYGZF3HsjoZ4pECm5GYEtlZlRkjs6gVBFWEIl5GI86zmD5RhxThEI92+iJ8eN6njaJvkZNIpKFaVPo8Wrypow+8Nju8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422381; c=relaxed/simple;
	bh=hmY49EYIkEU0IIjY/bJn1AptTT8L7M7DbX3tRtiCYWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN4V8sqP1L6GLY+idssxBSkyqYiylxuKbR9Pubo9ePVZaGw20BGQCCC8NTMDkdsYIT55QRVav21vM1OeFzBSRo5PL4V5ynu64xZCQHD3zoTZ2hSHWzvQEN8l/ZPNJo8oouDnptUwdibH4Bwv5gHvFUhRNZmQKhNtBTrH44WLS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alFEDCuz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C85C4AF0C;
	Wed, 31 Jul 2024 10:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722422380;
	bh=hmY49EYIkEU0IIjY/bJn1AptTT8L7M7DbX3tRtiCYWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=alFEDCuzMGme0gfI3Y0W+uW/hgZIGCfoB8j/R3gbrG3vgvMuOtOJfmYhZU08gBMGZ
	 9zteapRfPG+WkE2oDnv7vA8OWIaSfJBorrEdS+biMTYxZH9vnzPrYB6y2/Y+7wGy5t
	 0QU3OT3GZE70IFQyf9wtvibq+9aF81OOTW/nk0Xjdd+oyKj/tWwLAqk8UEzOipb0uo
	 /aaCVxbdnmsmXvWBYy5vRq40xrtsSJhpK4beBvmSJg2wqoY9cZ+FbaLfe7tACvbIc3
	 J7Vx05dQo/aQqLxg62/lpXyxbjJjC4PpeQbuq2VMPZaypv4++AmSAj9OlH/io/In53
	 XfLkiGd++XJeg==
Date: Wed, 31 Jul 2024 12:39:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: i@andypan.me
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3] epoll.7: clarify the event distribution under
 edge-triggered mode
Message-ID: <2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="porat6pdyflkro4y"
Content-Disposition: inline
In-Reply-To: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>


--porat6pdyflkro4y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: i@andypan.me
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3] epoll.7: clarify the event distribution under
 edge-triggered mode
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
MIME-Version: 1.0
In-Reply-To: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>

Hi Andy,

On Tue, Jul 30, 2024 at 10:48:28AM GMT, Andy Pan via B4 Relay wrote:
> From: Andy Pan <i@andypan.me>
>=20
> For the moment, the edge-triggered epoll generates an event for each
> receipt of a chunk of data, that is to say, epoll_wait() will return
> and tell us a monitored file descriptor is ready whenever there is a
> new activity on that FD since we were last informed about that FD.
> This is not a real _edge_ implementation for epoll, but it's been
> working this way for years and plenty of projects are relying on it
> to eliminate the overhead of one system call of read(2) per wakeup event.
>=20
> There are several renowned open-source projects relying on this feature
> for notification function (with eventfd): register eventfd with EPOLLET
> and avoid calling read(2) on the eventfd when there is wakeup event (even=
tfd being written).
> Examples: nginx [1], netty [2], tokio [3], libevent [4], ect. [5]
> These projects are widely used in today's Internet infrastructures.
> Thus, changing this behavior of epoll ET will fundamentally break them
> and cause a significant negative impact.
> Linux has changed it for pipe before [6], breaking some Android libraries,
> which had got "reverted" somehow. [7] [8]
>=20
> Nevertheless, the paragraph in the manual pages describing this
> characteristic of epoll ET seems ambiguous, I think a more explict
> sentence should be used to clarify it. We're improving the notification
> mechanism for libuv recently by exploiting this feature with eventfd,
> which brings us a significant performance boost. [9]
>=20
> Therefore, we (as well as the maintainers of nginx, netty, tokio, etc.)
> would have a sense of security to build an enhanced notification function
> based on this feature if there is a guarantee of retaining this implement=
ation
> of epoll ET for the backward compatibility in the man pages.
>=20
> [1]: https://github.com/nginx/nginx/blob/efc6a217b92985a1ee211b6bb7337cd2=
f62deb90/src/event/modules/ngx_epoll_module.c#L386-L457
> [2]: https://github.com/netty/netty/pull/9192
> [3]: https://github.com/tokio-rs/mio/blob/309daae21ecb1d46203a7dbc0cf4c80=
310240cba/src/sys/unix/waker.rs#L111-L143
> [4]: https://github.com/libevent/libevent/blob/525f5d0a14c9c103be750f2ca1=
75328c25505ea4/event.c#L2597-L2614
> [5]: https://github.com/libuv/libuv/pull/4400#issuecomment-2123798748
> [6]: https://lkml.iu.edu/hypermail/linux/kernel/2010.1/04363.html
> [7]: https://github.com/torvalds/linux/commit/3a34b13a88caeb2800ab44a4918=
f230041b37dd9
> [8]: https://github.com/torvalds/linux/commit/3b844826b6c6affa80755254da3=
22b017358a2f4
> [9]: https://github.com/libuv/libuv/pull/4400#issuecomment-2103232402
>=20
> Signed-off-by: Andy Pan <i@andypan.me>
> ---
> Changes in v3:
> - Updated the git commit description
> - Link to v2: https://lore.kernel.org/r/20240727-epoll-et-desc-v2-1-c99b2=
ac66775@andypan.me
>=20
> Changes in v2:
> - Added the git commit description based on feedback
> - Link to v1: https://lore.kernel.org/r/20240727-epoll-et-desc-v1-1-390ba=
fc678b9@andypan.me
> ---
>  man/man7/epoll.7 | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/man/man7/epoll.7 b/man/man7/epoll.7
> index 951500131..361d9db99 100644
> --- a/man/man7/epoll.7
> +++ b/man/man7/epoll.7
> @@ -172,6 +172,7 @@ .SS Level-triggered and edge-triggered
>  Since even with edge-triggered
>  .BR epoll ,

This paragraph is not only about EPOLLET.

>  multiple events can be generated upon receipt of multiple chunks of data,
> +that is, an event will be generated upon each receipt of a chunk of data,

Is this strictly true in all modes?  The commit message seems to say
that this is the behavior of EPOLLET, but this paragraph is not only
about EPOLLET.  Is this correct here, or should it go somewhere else?

Have a lovely day!
Alex

>  the caller has the option to specify the
>  .B EPOLLONESHOT
>  flag, to tell
>=20
> ---
> base-commit: cbc0a111e4dceea2037c51098de33e6bc8c16a5c
> change-id: 20240727-epoll-et-desc-04ea9a590f3b
>=20
> Best regards,
> --=20
> Andy Pan <i@andypan.me>
>=20
>=20

--=20
<https://www.alejandro-colomar.es/>

--porat6pdyflkro4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaqFGMACgkQnowa+77/
2zL4tA//dBMK8dx6Kp1ZPeRX3l4ZLP5zp+7keNRFAytyOn4FF3Nq57BgRb6Ll+IJ
EAly8NlAYy5lpFM5V3XWdbgLeYFwFGP1uD6GqduvVdK4jtUMCh5q+7qCyQuMCyKV
TlH7GDq9Oh62EMNvjYKaIHQIrtaS2YjjzizIEHFBRF945srlu9Oy6LztQIRjDiiT
pTTrNxbaYOV0Q30DROpjO5YPDZq0V0QemnuNaSJH2ffLhOgysndEgbrUvek+QQ+4
TaTtbI87u/a0ddEsimpTXuDOLckhJuXvBmLUlwmy7MDQxnS2j/7472QqqF1a71V5
c5d9qzJsbv0gywNnnd/JVs36gVrgFBcvLar8YL+fhI+8EprTrTwNI28lQsJxCA44
OwEnkotXfs5Eemoj4pHWhHZjP3hltUxt1/qXE3FQD7H83KvnAjm0KMcOj/wwJ31R
OWcWb1QraTZeySRaKs1zrtam4n3TFnReQOdgokkgb4ErdIjYdgeQ7QS907H99kJF
0cnTB3PdcjjNF5aMu3Ja6ZNHbPcwR1quLiprr0kETDHpzdmPJDJlxaCl/aEBMiw3
n37OQnPo06/XSmKjnO5mkiyY0fQHDxeR+3LS4y6jwHU/PrfOmklGOr/eH2wT92/i
9ZMLE3dI0vNHwiVb9keRS2AIvTdlagM7P57EDl3X1DWmkSPYbyE=
=Q1K0
-----END PGP SIGNATURE-----

--porat6pdyflkro4y--

