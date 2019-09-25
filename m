Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE833BE34A
	for <lists+linux-api@lfdr.de>; Wed, 25 Sep 2019 19:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442958AbfIYRVB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Sep 2019 13:21:01 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:58148 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732997AbfIYRVA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 25 Sep 2019 13:21:00 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 07A44A20C4;
        Wed, 25 Sep 2019 19:20:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id XpjdrVYPuLr1; Wed, 25 Sep 2019 19:20:52 +0200 (CEST)
Date:   Wed, 25 Sep 2019 19:20:49 +0200
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] lib: introduce copy_struct_from_user() helper
Message-ID: <20190925172049.skm6ohnnxpofdkzv@yavin>
References: <20190925165915.8135-1-cyphar@cyphar.com>
 <20190925165915.8135-2-cyphar@cyphar.com>
 <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d7zsgn6gfbe7cd4l"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjFeNjhtUxQ8npmXORz5RLQU7B_3wD=45eug1+MXnuYvA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--d7zsgn6gfbe7cd4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-09-25, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, Sep 25, 2019 at 10:00 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > +int is_zeroed_user(const void __user *from, size_t size)
>=20
> I like how you've done this, but it's buggy and only works on 64-bit.
>=20
> All the "u64" and "8" cases need to be "unsigned long" and
> "sizeof(unsigned long)".
>=20
> Part of that requirement is:
>=20
> > +               unsafe_get_user(val, (u64 __user *) from, err_fault);
>=20
> This part works fine - although 64-bit accesses migth be much more
> expensive and the win of unrolling might not be sufficient - but:
>=20
> > +               if (align) {
> > +                       /* @from is unaligned. */
> > +                       val &=3D ~aligned_byte_mask(align);
> > +                       align =3D 0;
> > +               }
>=20
> This part fundamentally only works on 'unsigned long'.

Just to make sure I understand, the following diff would this solve the
problem? If so, I'll apply it, and re-send in a few hours.

--8<-----------------------------------------------------------------------=
---

 int is_zeroed_user(const void __user *from, size_t size)
 {
-       u64 val;
-       uintptr_t align =3D (uintptr_t) from % 8;
+       unsigned long val;
+       uintptr_t align =3D (uintptr_t) from % sizeof(unsigned long);
=20
        if (unlikely(!size))
                return true;
@@ -150,8 +150,8 @@ int is_zeroed_user(const void __user *from, size_t size)
        if (!user_access_begin(from, size))
                return -EFAULT;
=20
-       while (size >=3D 8) {
-               unsafe_get_user(val, (u64 __user *) from, err_fault);
+       while (size >=3D sizeof(unsigned long)) {
+               unsafe_get_user(val, (unsigned long __user *) from, err_fau=
lt);
                if (align) {
                        /* @from is unaligned. */
                        val &=3D ~aligned_byte_mask(align);
@@ -159,12 +159,12 @@ int is_zeroed_user(const void __user *from, size_t si=
ze)
                }
                if (val)
                        goto done;
-               from +=3D 8;
-               size -=3D 8;
+               from +=3D sizeof(unsigned long);
+               size -=3D sizeof(unsigned long);
        }
        if (size) {
                /* (@from + @size) is unaligned. */
-               unsafe_get_user(val, (u64 __user *) from, err_fault);
+               unsafe_get_user(val, (unsigned long __user *) from, err_fau=
lt);
                val &=3D aligned_byte_mask(size);
        }

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--d7zsgn6gfbe7cd4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXYuhzgAKCRCdlLljIbnQ
EoTkAP4y5leltK1ihQabd2Qeo0xNwWS4A1sSxNc6gZyek3TIbgD/ZTWvBM6ezLu7
TNEGtnXD7IhbdLW9QNtPAVYBWJhK6AI=
=DQmi
-----END PGP SIGNATURE-----

--d7zsgn6gfbe7cd4l--
