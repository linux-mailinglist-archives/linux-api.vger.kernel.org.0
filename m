Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707A0BFC95
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2019 03:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfI0BH5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Sep 2019 21:07:57 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:62680 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfI0BH5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Sep 2019 21:07:57 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 392C0A16F2;
        Fri, 27 Sep 2019 03:07:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id IOcJDIfveQSW; Fri, 27 Sep 2019 03:07:49 +0200 (CEST)
Date:   Fri, 27 Sep 2019 11:07:36 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20190927010736.gy3vvvkjhwlybosj@yavin.dot.cyphar.com>
References: <20190925230332.18690-1-cyphar@cyphar.com>
 <20190925230332.18690-2-cyphar@cyphar.com>
 <20190925232139.45sbhj34fj7yvxer@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ningxfpyii3awxw6"
Content-Disposition: inline
In-Reply-To: <20190925232139.45sbhj34fj7yvxer@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--ningxfpyii3awxw6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-26, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> On Thu, Sep 26, 2019 at 01:03:29AM +0200, Aleksa Sarai wrote:
> > +int is_zeroed_user(const void __user *from, size_t size)
> > +{
> > +	unsigned long val;
> > +	uintptr_t align =3D (uintptr_t) from % sizeof(unsigned long);
> > +
> > +	if (unlikely(!size))
> > +		return true;
>=20
> You're returning "true" and another implicit boolean with (val =3D=3D 0)
> down below but -EFAULT in other places. But that function is int
> is_zeroed_user() Would probably be good if you either switch to bool
> is_zeroed_user() as the name suggests or rename the function and have
> it return an int everywhere.

I just checked, and in C11 (and presumably in older specs) it is
guaranteed that "true" and "false" from <stdbool.h> have the values 1
and 0 (respectively) [=A77.18]. So this is perfectly well-defined.

Personally, I think it's more readable to have:

  if (unlikely(size =3D=3D 0))
    return true;
  /* ... */
  return (val =3D=3D 0);

compared to:

  if (unlikely(size =3D=3D 0))
    return 1;
  /* ... */
  return val ? 0 : 1;

But I will change the function name (to check_zeroed_user) to make it
clearer that it isn't returning a boolean and that you need to check for
negative returns.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ningxfpyii3awxw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXY1g0wAKCRCdlLljIbnQ
EmniAP96l+2UHf1KZUsjmkF+ni1i3z9S8CcAMfeKjnFvKTEOmAD+Kamb7z8aEEP6
x2hEUZydsZf2ME41Ml2G9Z9uGlezWgM=
=zhm8
-----END PGP SIGNATURE-----

--ningxfpyii3awxw6--
