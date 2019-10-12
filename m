Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595AAD4EEC
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 12:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfJLKMY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 06:12:24 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:48631 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfJLKMY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 12 Oct 2019 06:12:24 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 53317A3733;
        Sat, 12 Oct 2019 12:12:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id YvIH0-myk1cl; Sat, 12 Oct 2019 12:12:16 +0200 (CEST)
Date:   Sat, 12 Oct 2019 21:12:05 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Avoid soft lockups in test_check_nonzero_user()
Message-ID: <20191012101205.px6ocxg4lkuc3gia@yavin.dot.cyphar.com>
References: <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com>
 <20191011022447.24249-1-mpe@ellerman.id.au>
 <20191011034810.xkmz3e4l5ezxvq57@yavin.dot.cyphar.com>
 <87tv8euw44.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6w5sfp6n6zzwxgln"
Content-Disposition: inline
In-Reply-To: <87tv8euw44.fsf@mpe.ellerman.id.au>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--6w5sfp6n6zzwxgln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-12, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Aleksa Sarai <cyphar@cyphar.com> writes:
> > On 2019-10-11, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> On a machine with a 64K PAGE_SIZE, the nested for loops in
> >> test_check_nonzero_user() can lead to soft lockups, eg:
> ...
> >> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> >> index 950ee88cd6ac..9fb6bc609d4c 100644
> >> --- a/lib/test_user_copy.c
> >> +++ b/lib/test_user_copy.c
> >> @@ -47,9 +47,26 @@ static bool is_zeroed(void *from, size_t size)
> >>  static int test_check_nonzero_user(char *kmem, char __user *umem, siz=
e_t size)
> >>  {
> >>  	int ret =3D 0;
> >> -	size_t start, end, i;
> >> -	size_t zero_start =3D size / 4;
> >> -	size_t zero_end =3D size - zero_start;
> >> +	size_t start, end, i, zero_start, zero_end;
> >> +
> >> +	if (test(size < 1024, "buffer too small"))
> >> +		return -EINVAL;
> >> +
> >> +	/*
> >> +	 * We want to cross a page boundary to exercise the code more
> >> +	 * effectively. We assume the buffer we're passed has a page boundar=
y at
> >> +	 * size / 2. We also don't want to make the size we scan too large,
> >> +	 * otherwise the test can take a long time and cause soft lockups. So
> >> +	 * scan a 1024 byte region across the page boundary.
> >> +	 */
> >> +	start =3D size / 2 - 512;
> >> +	size =3D 1024;
> >
> > I don't think it's necessary to do "size / 2" here -- you can just use
> > PAGE_SIZE directly and check above that "size =3D=3D 2*PAGE_SIZE" (not =
that
> > this check is exceptionally necessary -- since there's only one caller
> > of this function and it's in the same file).
>=20
> OK, like this?

Yup -- that looks good. I'll give it a Reviewed-by once you resend it.

> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> index 950ee88cd6ac..48bc669b2549 100644
> --- a/lib/test_user_copy.c
> +++ b/lib/test_user_copy.c
> @@ -47,9 +47,25 @@ static bool is_zeroed(void *from, size_t size)
>  static int test_check_nonzero_user(char *kmem, char __user *umem, size_t=
 size)
>  {
>  	int ret =3D 0;
> -	size_t start, end, i;
> -	size_t zero_start =3D size / 4;
> -	size_t zero_end =3D size - zero_start;
> +	size_t start, end, i, zero_start, zero_end;
> +
> +	if (test(size < 2 * PAGE_SIZE, "buffer too small"))
> +		return -EINVAL;
> +
> +	/*
> +	 * We want to cross a page boundary to exercise the code more
> +	 * effectively. We also don't want to make the size we scan too large,
> +	 * otherwise the test can take a long time and cause soft lockups. So
> +	 * scan a 1024 byte region across the page boundary.
> +	 */
> +	size =3D 1024;
> +	start =3D PAGE_SIZE - (size / 2);
> +
> +	kmem +=3D start;
> +	umem +=3D start;
> +
> +	zero_start =3D size / 4;
> +	zero_end =3D size - zero_start;
> =20
>  	/*
>  	 * We conduct a series of check_nonzero_user() tests on a block of memo=
ry


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--6w5sfp6n6zzwxgln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXaGm8gAKCRCdlLljIbnQ
Emn4AP41igjRH0F5DHCfmErfNAUW5/gBhcs02P7qsfK/94ZEVQEAtLiYGeydbgdt
XejHbb0dVmtijotI9qFDCyYPp0ix4Ag=
=Wb1Y
-----END PGP SIGNATURE-----

--6w5sfp6n6zzwxgln--
