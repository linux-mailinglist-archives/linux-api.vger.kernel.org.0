Return-Path: <linux-api+bounces-2023-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009293DF72
	for <lists+linux-api@lfdr.de>; Sat, 27 Jul 2024 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2E21F217F7
	for <lists+linux-api@lfdr.de>; Sat, 27 Jul 2024 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C577EEF5;
	Sat, 27 Jul 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMp6oOiZ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABD1E52C;
	Sat, 27 Jul 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722085008; cv=none; b=tKH1u+pzvYxaTLvS+IMZ5r3z99pqwFyYSF+mCSZG+ucqyV6YmJjaMCGSvGADhk6cAYSwzka6JNdB4PQYlftY6dJtrF02GtdJd73zzZq9CswnCn5QYPK1AyAFGDP3mm8jIptjin+Q6JLjI2QIJxn557I5ZRr3TAgaS+GgW8W6Qv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722085008; c=relaxed/simple;
	bh=2J9OrvkoRz49HGsQoHpzgQTYToUx2+WOKj4PXB1ttb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D03+FNEYS829VFherX4+pnX+c+g5Hq2/6BrNcu6PK2mJ24DVd3wCRNyog9ODRSpH6vnZAdggNdlOoHUL3WlrWLkYWKQgiAUP92xAO+1c8rfUIFXo6tKr8X0RRGnZGsEzy40NV6ZYv+/rfbWAHPH5bEqdcvAG2r5vGCai4WGhypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMp6oOiZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069C1C32781;
	Sat, 27 Jul 2024 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722085007;
	bh=2J9OrvkoRz49HGsQoHpzgQTYToUx2+WOKj4PXB1ttb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qMp6oOiZDQuGQq8zPOETu3Qg2VsJnzmniEw65Hq26Y6ZtEKV2MueSVm4D372rcL/T
	 fcKc/5/umAKBP0mHhSjaAWFFwmTgoUr72XTR+5lKaqncoKktvuw7uOGb2CqSvkXedr
	 PeZaHcdAHUuYsAAOKxkgJvERI5lihTYZP1jXY6aO7d3gfaUVszR9ewDCFsYrbQzmdH
	 CUzV6jsO40/f6DKtNBEp552zcDwKJPfVxupGMrDI4R02sz31WIuLvnlcHZRxsLGf3s
	 dVZpDD4FKVX5xQhjJIydA2U9+QM0GRckdJW0l9QV90cLX+2PRqJYuLD/tUWLtpm7T1
	 SuJfE+kkd+3RA==
Date: Sat, 27 Jul 2024 14:56:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: i@andypan.me
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] epoll.7: clarify the event distribution under
 edge-triggered mode
Message-ID: <winuqsb2qne3nv343e5gaa67ww4fyra6urkghk5ft3vnz2gled@lxzxu5ttwvt2>
References: <20240727-epoll-et-desc-v1-1-390bafc678b9@andypan.me>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jtw2ni5dof6aqfcz"
Content-Disposition: inline
In-Reply-To: <20240727-epoll-et-desc-v1-1-390bafc678b9@andypan.me>


--jtw2ni5dof6aqfcz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: i@andypan.me
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] epoll.7: clarify the event distribution under
 edge-triggered mode
References: <20240727-epoll-et-desc-v1-1-390bafc678b9@andypan.me>
MIME-Version: 1.0
In-Reply-To: <20240727-epoll-et-desc-v1-1-390bafc678b9@andypan.me>

On Sat, Jul 27, 2024 at 12:36:29PM GMT, Andy Pan via B4 Relay wrote:
> From: Andy Pan <i@andypan.me>

Hi Andy,

>=20
> ---

I think the text below should go into the commit message.

> For the moment, the edge-triggered epoll generates an event for each
> receipt of a chunk of data, that is to say, epoll_wait() will return
> and tell us a monitored file descriptor is ready whenever there is a
> new activity on that FD since we were last informed about that FD.
> This is not a real _edge_ implementation for epoll, but it's been
> working this way for years and plenty of projects are relying on it.=20
>=20
> There are several renowned open-source projects relying on this feature
> for notification function (with eventfd), such as nginx [1], netty [2],
> tokio [3], libevent [4], ect. [5] These projects are widely used in today=
's
> Internet infrastructures. Thus, changing this behavior of epoll ET will
> fundamentally break them and cause a significant negative impact.
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

You should CC <linux-api@vger.kernel.org>.

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
>  multiple events can be generated upon receipt of multiple chunks of data,
> +that is, an event will be generated upon each receipt of a chunk of data,
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

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--jtw2ni5dof6aqfcz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmak7owACgkQnowa+77/
2zKefA//Un4dKCW9svWnf8uES5cvkZF+p4TeDD8FCR91jijeC5MJcgBLlK0xLeIz
rVMRhOsGCYwz+zyroIuyNFq5W8ETFdAga+TNMuFFlpot3CcfVETe+0gNdsXthN07
+PUXIOE/58lEPJohRnmAoCVk13ig9EI1oaKxzu9E6m1IPLNnRUAFc4G9zSV4eMI0
5+RLovdCB/QILcmMJ6/LpVypV/UiNX3fvpIwummacBkp98Wf+zhBUX+nv8/+qzMn
oPNgG53SEPmvqImI3cAWXhsw05oc3fYC9phxaASlqfecFeP1g17DqNQL8YSvUqxM
9kxLdBEcy8JmGx+iX25PaEXvMlcRQlrX8i8gkdXKz35+faiRU7esn+W+ricRYrRa
I0XgRzaq9FTPiWB09ITKrYl4qSO3QIbiUaLasTw8GUQ9a5sAfsIkWGDpwjpDHOaB
RDdR45IKfMsCYox/hw9tmVMAPi0YQ4GjLk29ExpxD1BZjhzJfEy+dQrDY6t3A56B
wcIyhiGaFDqYlmkCaf0/h90OZBzB5vH8B2K8BIjduHmgJj+zDZ17FOHuFsvr9RGU
ggqheOg1UPjJ1n5CXiM7IPOIQu2xdlRmSI9HfJrGvaWp9od3HtZsDdGOR9VbxB6n
COhCzUXAKNBJD+E51dz8ROINxdqES0uZUDvPh4x6m/+AFEAQEpo=
=9ISM
-----END PGP SIGNATURE-----

--jtw2ni5dof6aqfcz--

