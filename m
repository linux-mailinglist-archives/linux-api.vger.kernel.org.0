Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4187F020A
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390006AbfKEQAL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:00:11 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:37196 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389843AbfKEQAL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 11:00:11 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 476vWY3wLrzKmTQ;
        Tue,  5 Nov 2019 17:00:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 4Qo0IpOlKh2j; Tue,  5 Nov 2019 17:00:05 +0100 (CET)
Date:   Wed, 6 Nov 2019 02:59:53 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for
 UFFD_FEATURE_EVENT_FORK
Message-ID: <20191105155953.3i7fvzm76aublkbi@yavin.dot.cyphar.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="j7e2vn3qawbuf4kk"
Content-Disposition: inline
In-Reply-To: <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--j7e2vn3qawbuf4kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-05, Mike Rapoport <rppt@linux.ibm.com> wrote:
> Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
> descriptor table from the read() implementation of uffd, which may have
> security implications for unprivileged use of the userfaultfd.
>=20
> Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that have
> CAP_SYS_PTRACE.
>=20
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  fs/userfaultfd.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index f9fd18670e22..d99d166fd892 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1834,13 +1834,12 @@ static int userfaultfd_api(struct userfaultfd_ctx=
 *ctx,
>  	if (copy_from_user(&uffdio_api, buf, sizeof(uffdio_api)))
>  		goto out;
>  	features =3D uffdio_api.features;
> -	if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API_FEATURES)) {
> -		memset(&uffdio_api, 0, sizeof(uffdio_api));
> -		if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))
> -			goto out;
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> +	ret =3D -EINVAL;
> +	if (uffdio_api.api !=3D UFFD_API || (features & ~UFFD_API_FEATURES))
> +		goto err_out;
> +	ret =3D -EPERM;
> +	if ((features & UFFD_FEATURE_EVENT_FORK) && !capable(CAP_SYS_PTRACE))
> +		goto err_out;
>  	/* report all available features and ioctls to userland */
>  	uffdio_api.features =3D UFFD_API_FEATURES;
>  	uffdio_api.ioctls =3D UFFD_API_IOCTLS;
> @@ -1853,6 +1852,11 @@ static int userfaultfd_api(struct userfaultfd_ctx =
*ctx,
>  	ret =3D 0;
>  out:
>  	return ret;
> +err_out:
> +	memset(&uffdio_api, 0, sizeof(uffdio_api));
> +	if (copy_to_user(buf, &uffdio_api, sizeof(uffdio_api)))

Wouldn't it be simpler to do clear_user()?

> +		ret =3D -EFAULT;
> +	goto out;
>  }
> =20
>  static long userfaultfd_ioctl(struct file *file, unsigned cmd,

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--j7e2vn3qawbuf4kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXcGcdgAKCRCdlLljIbnQ
EtmWAP0U2MY1jEsu7TOdY/A7q911zdaus5bq2247WlYAOn4eWAEAlHxHE9/GMIb9
2Uajs/uTqNYLhx1hpZCCzmPJS/v5YwA=
=BEI+
-----END PGP SIGNATURE-----

--j7e2vn3qawbuf4kk--
