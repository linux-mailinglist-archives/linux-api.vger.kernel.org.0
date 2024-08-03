Return-Path: <linux-api+bounces-2105-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739FC9469F8
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 16:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC78B2128B
	for <lists+linux-api@lfdr.de>; Sat,  3 Aug 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BD139CFA;
	Sat,  3 Aug 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHK1Ah8F"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F8136E18;
	Sat,  3 Aug 2024 14:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693708; cv=none; b=foHvh3wlJ6HU0qxGbauUqFgqZCMsKWImazydcYnMwIuTTJU+Va8yEMuVZYk+hGKfMX6xMuQhbfnEQzmimSGApdkFbetb52aJX9513DmxACwV8SUp/4xC/3eSbAruREJ/AJXN0D7eMeuCjBC0YktkRhw3CD2E3bjlbjvSNjsBLSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693708; c=relaxed/simple;
	bh=i3FzjpTPLCfnyMUoQt88dDW460PbGtwDn7+2PT1V/aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dof6hlolthvUjRGesRxT++lMp7caIprTOGaF+aBAjKOA/SB/lYt3ZHDoeH6kGgLRnroQIMWnXXkGhsKBFjZqPJ+u89HxrKkrDA7Z55P7HqCnzqDedrh51y9nn7X07txXRs7y/hlYFFrZpJOSBdP7dTmjkWB/xiU0g4uZ+x4y1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHK1Ah8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D52C4AF09;
	Sat,  3 Aug 2024 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722693708;
	bh=i3FzjpTPLCfnyMUoQt88dDW460PbGtwDn7+2PT1V/aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dHK1Ah8FRS3rx2fUlvi9Ju3AR06qTT5AMej71NlJCsvI1JM8qiHh1JtUiSgv5G0v8
	 wATTPxgRjZuqBiDDF/9CQGmtDIYpChBryu+Be6Ys/JLXqX44pfqUE8shFG+s7tZ8hQ
	 5xMfAckMND9CtiXQOopTTMWYShAuse4LzjQPZR8C5V+Ep4W48yXLjJ0CNMszPKjd6X
	 DxK8lvCHRdzBzrmRBluoC0tukbb4ZEdTSuVlFX0TQ6eU5c2nO3MW78RGtfYmCGlsjn
	 x6SlHJdqwsnM5D36g/0sIssmgZzqQZKn+2zmgo+7Y4SHS+iPfPYMizvp+WrP1J2o0U
	 MHoxdVfqItpEQ==
Date: Sat, 3 Aug 2024 16:01:44 +0200
From: Alejandro Colomar <alx@kernel.org>
To: i@andypan.me
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	"mtk.manpages" <mtk.manpages@gmail.com>, Andy Pan <panjf2000@gmail.com>
Subject: Re: [PATCH v5] epoll.7: clarify the event distribution under
 edge-triggered mode
Message-ID: <3d4xkgo7fr6mrlnbcocstjs4ctrh3sutcyrxtgqseiwdjoino5@i3bbqxzii3vx>
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvqwioilpfcoerbh"
Content-Disposition: inline
In-Reply-To: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>


--nvqwioilpfcoerbh
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: i@andypan.me
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	"mtk.manpages" <mtk.manpages@gmail.com>, Andy Pan <panjf2000@gmail.com>
Subject: Re: [PATCH v5] epoll.7: clarify the event distribution under
 edge-triggered mode
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
MIME-Version: 1.0
In-Reply-To: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>

Hi Andy,

On Thu, Aug 01, 2024 at 11:38:38AM GMT, Andy Pan via B4 Relay wrote:
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

Thanks for the patch.  I've applied it, and pushed to my branch:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Dda20f7834879cf28ad1d4621f9f1bc421d9c04bf>.

I will take some days before pushing to master, as I'm waiting for a
review of another patch that's before in the queue.

Have a lovely day!
Alex

> Changes in v5:
> - Update the sentence of clarifying the epoll ET
> - Link to v4: https://lore.kernel.org/r/20240731-epoll-et-desc-v4-1-7eb81=
9bdde0d@andypan.me
>=20
> Changes in v4:
> - Move the added sentence elsewhere to make more sense
> - Link to v3: https://lore.kernel.org/r/20240730-epoll-et-desc-v3-1-6aa81=
b1c400d@andypan.me
>=20
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
>  man/man7/epoll.7 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/man/man7/epoll.7 b/man/man7/epoll.7
> index 951500131..86e5f8363 100644
> --- a/man/man7/epoll.7
> +++ b/man/man7/epoll.7
> @@ -121,7 +121,8 @@ .SS Level-triggered and edge-triggered
>  meanwhile the remote peer might be expecting a response based on the
>  data it already sent.
>  The reason for this is that edge-triggered mode
> -delivers events only when changes occur on the monitored file descriptor.
> +delivers events only when changes occur on the monitored file descriptor,
> +that is, an event will be generated upon each receipt of a chunk of data.
>  So, in step
>  .B 5
>  the caller might end up waiting for some data that is already present in=
side
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

--nvqwioilpfcoerbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmauOEgACgkQnowa+77/
2zKWmA//VFOl6+9NanxRAlriMbvMQMurGa6mn/JC1nD666cyorY9bzQCK+uUTl1+
nzF2z30tfTTKoxS+qv/6+x7SoFV3KmEfMcjB9F/SqoTEGdtdYttkuQsE3QwhZHjN
tPeAjGclTiFbx0BIaDVBlWAlaAd4t+0CtS7kILoBB3CQsjEw+CnnIeJu5HaHDVEU
Xc4mu6S9qxYpLuk2ZaHYlSdsbVjhaL+u1a1bXHK6k64gr1RPsZIpFW3Gd+bqvJGb
Yj6LX32nCPqjgN15apD5R3mcqtr55Vwnf1cQWu3xMeD44vGS7vHml8zgVBSnUM0U
TG7IGCEts9dapyje7PmYNBIEDZ+KFjZhfje8bNGwJrsO88xCshI3q/y7zLImBdbK
L6th/F3VtWvEp0CHMxW/7VN4e1ATaXSx3Y1t7RjuBB0lBHnCAGDPuEjRwqutJfpw
4YsN2nqjXRucH6RodP1xC652meCkzGxMR2mR81wetoETTeTWUQaU2LcoVBdI4wYv
HEZHMODg6xvpqoO3yXMdNyAjfacENveCEwDUWtSg5C5C+G7tKUhFFcyVwTNKjhAh
YWG6lN09T0Y5jVY6VsqxiV67romQeBzR2vGm2nUWFCCGPAQkhJiIa00oWXNQ5wJC
2fLHjFf9jGQjv5sGsjkg3Let78aEkpK60lu6oauSXH88rp7B2NM=
=xOpe
-----END PGP SIGNATURE-----

--nvqwioilpfcoerbh--

