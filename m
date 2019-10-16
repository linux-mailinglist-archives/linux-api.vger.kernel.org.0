Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D0D9115
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733007AbfJPMgv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 08:36:51 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:62423 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfJPMgv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 16 Oct 2019 08:36:51 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 77995A342B;
        Wed, 16 Oct 2019 14:36:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id tTmkL1ywM9Xd; Wed, 16 Oct 2019 14:36:44 +0200 (CEST)
Date:   Wed, 16 Oct 2019 23:36:30 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usercopy: Avoid soft lockups in
 test_check_nonzero_user()
Message-ID: <20191016123630.xxrw7ps5lddnscti@yavin.dot.cyphar.com>
References: <20191011022447.24249-1-mpe@ellerman.id.au>
 <20191016122732.13467-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="stviwchrcmtw4mh2"
Content-Disposition: inline
In-Reply-To: <20191016122732.13467-1-mpe@ellerman.id.au>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--stviwchrcmtw4mh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-16, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On a machine with a 64K PAGE_SIZE, the nested for loops in
> test_check_nonzero_user() can lead to soft lockups, eg:
>=20
>   watchdog: BUG: soft lockup - CPU#4 stuck for 22s! [modprobe:611]
>   Modules linked in: test_user_copy(+) vmx_crypto gf128mul crc32c_vpmsum =
virtio_balloon ip_tables x_tables autofs4
>   CPU: 4 PID: 611 Comm: modprobe Tainted: G             L    5.4.0-rc1-gc=
c-8.2.0-00001-gf5a1a536fa14-dirty #1151
>   ...
>   NIP __might_sleep+0x20/0xc0
>   LR  __might_fault+0x40/0x60
>   Call Trace:
>     check_zeroed_user+0x12c/0x200
>     test_user_copy_init+0x67c/0x1210 [test_user_copy]
>     do_one_initcall+0x60/0x340
>     do_init_module+0x7c/0x2f0
>     load_module+0x2d94/0x30e0
>     __do_sys_finit_module+0xc8/0x150
>     system_call+0x5c/0x68
>=20
> Even with a 4K PAGE_SIZE the test takes multiple seconds. Instead
> tweak it to only scan a 1024 byte region, but make it cross the
> page boundary.
>=20
> Fixes: f5a1a536fa14 ("lib: introduce copy_struct_from_user() helper")
> Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks Michael.

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> ---
>  lib/test_user_copy.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> v2: Rework calculation to just use PAGE_SIZE directly.
>     Rebase onto Christian's tree.
>=20
> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> index ad2372727b1b..5ff04d8fe971 100644
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
>  	 * We conduct a series of check_nonzero_user() tests on a block of
> --=20
> 2.21.0
>=20


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--stviwchrcmtw4mh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXacOywAKCRCdlLljIbnQ
EjunAPwLT7OICYkWWCIWoyKSKO1WnDSAl2fybcz9swr6rtyU9wEA4DqowbsTnje6
s3FRWj7E/3ijrEYKiOgqxM4TXu373Ak=
=xkKe
-----END PGP SIGNATURE-----

--stviwchrcmtw4mh2--
