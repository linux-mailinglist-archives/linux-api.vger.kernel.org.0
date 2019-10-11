Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29397D3802
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 05:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfJKDsa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 23:48:30 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:54977 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfJKDsa (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 10 Oct 2019 23:48:30 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 4C0B5A184E;
        Fri, 11 Oct 2019 05:48:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id FAJIvPNj8lRh; Fri, 11 Oct 2019 05:48:21 +0200 (CEST)
Date:   Fri, 11 Oct 2019 14:48:10 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     mingo@redhat.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, christian@brauner.io, keescook@chromium.org,
        linux@rasmusvillemoes.dk, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usercopy: Avoid soft lockups in test_check_nonzero_user()
Message-ID: <20191011034810.xkmz3e4l5ezxvq57@yavin.dot.cyphar.com>
References: <20191010114007.o3bygjf4jlfk242e@yavin.dot.cyphar.com>
 <20191011022447.24249-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xu7xtsni3al6cjf6"
Content-Disposition: inline
In-Reply-To: <20191011022447.24249-1-mpe@ellerman.id.au>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--xu7xtsni3al6cjf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-11, Michael Ellerman <mpe@ellerman.id.au> wrote:
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
> ---
>  lib/test_user_copy.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>=20
> How does this look? It runs in < 1s on my machine here.
>=20
> cheers
>=20
> diff --git a/lib/test_user_copy.c b/lib/test_user_copy.c
> index 950ee88cd6ac..9fb6bc609d4c 100644
> --- a/lib/test_user_copy.c
> +++ b/lib/test_user_copy.c
> @@ -47,9 +47,26 @@ static bool is_zeroed(void *from, size_t size)
>  static int test_check_nonzero_user(char *kmem, char __user *umem, size_t=
 size)
>  {
>  	int ret =3D 0;
> -	size_t start, end, i;
> -	size_t zero_start =3D size / 4;
> -	size_t zero_end =3D size - zero_start;
> +	size_t start, end, i, zero_start, zero_end;
> +
> +	if (test(size < 1024, "buffer too small"))
> +		return -EINVAL;
> +
> +	/*
> +	 * We want to cross a page boundary to exercise the code more
> +	 * effectively. We assume the buffer we're passed has a page boundary at
> +	 * size / 2. We also don't want to make the size we scan too large,
> +	 * otherwise the test can take a long time and cause soft lockups. So
> +	 * scan a 1024 byte region across the page boundary.
> +	 */
> +	start =3D size / 2 - 512;
> +	size =3D 1024;

I don't think it's necessary to do "size / 2" here -- you can just use
PAGE_SIZE directly and check above that "size =3D=3D 2*PAGE_SIZE" (not that
this check is exceptionally necessary -- since there's only one caller
of this function and it's in the same file).

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

--xu7xtsni3al6cjf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZ/7dgAKCRCdlLljIbnQ
EgboAQDJ8CE0F2TLUINi1TVmrSnff05vx9rNqKgWqX6FRhmwZQD/fTHxCU6/MBBj
t/OvAUCvDgAeGUi++GX8ZCl5uljK2AE=
=DY8J
-----END PGP SIGNATURE-----

--xu7xtsni3al6cjf6--
