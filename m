Return-Path: <linux-api+bounces-2097-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AA3945818
	for <lists+linux-api@lfdr.de>; Fri,  2 Aug 2024 08:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0ADC2818F8
	for <lists+linux-api@lfdr.de>; Fri,  2 Aug 2024 06:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848953BBE1;
	Fri,  2 Aug 2024 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+KbTjsS"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9272C9D;
	Fri,  2 Aug 2024 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722580696; cv=none; b=uQqwYgb+rq1HdD95BlQg33DVTSzii2WBabvaBEeWjwfWBdC08SUe50NFsqhjWR7mY7R+6a2359dyFyBoZkSb4DiOOuASFzD15bA32OCcUpHTSQdPRpgJs4ivaDpFuqNyzyoLmOGHuOafuCvfZKYk1FDTdkwkNpOQWZYsvRVKHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722580696; c=relaxed/simple;
	bh=ZZBVOPNyMEy9y5bO0sw5ynRMO6AGAD3JMo1sUXjcGtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5fbhjLRxLub3nIJ1oUa/7ZZ5bjrUFq72UiMoJX8C5pUn/DWAVlTD23OiL9IpNnaJoUlGF6NpsNVqwTr4yx2NdU/KiFREOXFRDhdhOSNjz/r8VklN8sAWoacPwijyQWQ+Wrvd1G1IjQiy0+sS9xMSBqLLfuVZ0Ksq9AvCJKCG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+KbTjsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8F9C32782;
	Fri,  2 Aug 2024 06:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722580695;
	bh=ZZBVOPNyMEy9y5bO0sw5ynRMO6AGAD3JMo1sUXjcGtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+KbTjsS94Kh8hDswxP6wXJiN23JJs1jAB/lDCSER0AMP5xqUTINS3GYB5m/gqxAl
	 4vQ/K/+msyKb6lw3nB9mQ6otmRkjhNf8yc2ZNYLwd/v1p1QW7AbqkZcd/6/d+u2FV+
	 7w+SZs+jya/efW1USZP8RE9wbDPYKsX3tWgpR8BdJ2n4d5IFaDZ16cTKcs9CEnMG9w
	 3fCxrqC9EBxrKIr1F9Jf02MRTmHj4JutIHf0gIWeLALZra8BMSgK43w/IKh2qL/Dr7
	 z4NBleeR/9vkqASBbD+stFNWEMjw0FACcApaveCRZRboLheosq5O2kpJje2xjjPTQV
	 Cr70a9MTjsCJQ==
Date: Fri, 2 Aug 2024 08:38:12 +0200
From: Alejandro Colomar <alx@kernel.org>
To: i@andypan.me
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	"mtk.manpages" <mtk.manpages@gmail.com>, Andy Pan <panjf2000@gmail.com>
Subject: Re: [PATCH v5] epoll.7: clarify the event distribution under
 edge-triggered mode
Message-ID: <4zemhoksplppb35pvpm7cahmaar45hhn3s7tne5pqbgx5bmtg5@jj6hz5yetm4z>
References: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="blkvjcib5ljwj224"
Content-Disposition: inline
In-Reply-To: <20240801-epoll-et-desc-v5-1-7fcb9260a3b2@andypan.me>


--blkvjcib5ljwj224
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

LGTM.  Thanks for the patch, and the detailed commit message!
I'll probably merge it later today (I'll let you know).

Have a lovely day!
Alex

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

--blkvjcib5ljwj224
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmasftQACgkQnowa+77/
2zLhtg/9F81xKnjxexE4KRRRhBYKvSI98JPZhs/Hvz1+J8JF1q8/SqDYXrnp4gsm
reSa2rQQzHq8+L3yBJZxZyQMT+FSBhPx3WxnckLq+Ks6V4izZmQk8XTRKuuA+Dr6
6sklAvIElOUevDxvtUc6MA/OKH1Un9fmbZnum1+XjFkZt9/xabN8teSZ0fJV7JEO
5+GlNVntYIG85I+aRs2KPFrUZm65XGbpCq2Tpu4wo8lSeb8MexweNM8I9Kzhj9NX
OpD8NNHqA8PgG8MkmbRdoKPLOSTBoUM0ohNLvXU6D4bMAX/LJd8G0F+RYugd1dW3
SoN0bogBJZvZDEjvIYlEj1hJH0jhlOy94ctQrqfs3j1O95UE0wXabG90JHytGKCA
WY9qyy+Dl2xEIe3nC1SLtLNU3zGw6OrIVEDOT1gkbxP/of1wEy7S5THlKARB9bC7
8AWm9jUPWCESj3vY+LQ+B/noEWiIrhbyk1dB2O5ZF0y4Jt66bJWSBAQRSEiEUhVN
RfUYtjHgv9ZZFXSAwTI4SzqqizMqsGZ+demWz4GVvU+iiky1WJk1o3TaW8v5X3o3
u8BZ1U9Iwc8vxj1bTACJ4ZE3Pn3PyqA5Xi6Mokv7UmWMTnZhEPeB8SzMmLtmbw5V
eTAzoYjv6x2QrJQ8NXmVE1KlZ8VqgFT74JxMRmdZzMpo0eWj0zk=
=lPKp
-----END PGP SIGNATURE-----

--blkvjcib5ljwj224--

