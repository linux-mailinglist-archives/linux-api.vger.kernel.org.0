Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C28012BC33
	for <lists+linux-api@lfdr.de>; Sat, 28 Dec 2019 03:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfL1CG7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Dec 2019 21:06:59 -0500
Received: from mout-p-101.mailbox.org ([80.241.56.151]:43742 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfL1CG7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Dec 2019 21:06:59 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 47l6Wh5jNVzKmbc;
        Sat, 28 Dec 2019 03:06:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 3Fcw9sovV883; Sat, 28 Dec 2019 03:06:51 +0100 (CET)
Date:   Sat, 28 Dec 2019 13:06:43 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        tycho@tycho.ws, jannh@google.com, christian.brauner@ubuntu.com,
        keescook@chromium.org
Subject: Re: [PATCH v2 2/2] seccomp: Check that seccomp_notif is zeroed out
 by the user
Message-ID: <20191228020643.jb2kn5wztwnrpr74@yavin.dot.cyphar.com>
References: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="54mmka6dnelc3rwm"
Content-Disposition: inline
In-Reply-To: <20191228014849.GA31783@ircssh-2.c.rugged-nimbus-611.internal>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--54mmka6dnelc3rwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-12-28, Sargun Dhillon <sargun@sargun.me> wrote:
> This patch is a small change in enforcement of the uapi for
> SECCOMP_IOCTL_NOTIF_RECV ioctl. Specifically, the datastructure which
> is passed (seccomp_notif) must be zeroed out. Previously any of its
> members could be set to nonsense values, and we would ignore it.
>=20
> This ensures all fields are set to their zero value.
>=20
> This relies on the seccomp_notif datastructure to not have
> any unnamed padding, as it is valid to initialize the datastructure
> as:
>=20
>   struct seccomp_notif notif =3D {};
>=20
> This only initializes named members to their 0-value [1].
>=20
> [1]: https://lore.kernel.org/lkml/20191227023131.klnobtlfgeqcmvbb@yavin.d=
ot.cyphar.com/
>=20
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Cc: Kees Cook <keescook@chromium.org>

Looks good.

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>  kernel/seccomp.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 12d2227e5786..4fd73cbdd01e 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1026,6 +1026,12 @@ static long seccomp_notify_recv(struct seccomp_fil=
ter *filter,
>  	struct seccomp_notif unotif;
>  	ssize_t ret;
> =20
> +	ret =3D check_zeroed_user(buf, sizeof(unotif));
> +	if (ret < 0)
> +		return ret;
> +	if (!ret)
> +		return -EINVAL;
> +
>  	memset(&unotif, 0, sizeof(unotif));
> =20
>  	ret =3D down_interruptible(&filter->notif->request);
> --=20
> 2.20.1
>=20


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--54mmka6dnelc3rwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXga4rwAKCRCdlLljIbnQ
EnMAAP9Xs8l4Hin1hWv97QM7HT0Sw7QrXAEhmfu1n2Kz+eMk3AD/YAtD/Zr4L7OC
hJdpl7t6/Bega+Lr5/MbnPjfDdjANQ8=
=TLug
-----END PGP SIGNATURE-----

--54mmka6dnelc3rwm--
