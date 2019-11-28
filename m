Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA8B10C9EC
	for <lists+linux-api@lfdr.de>; Thu, 28 Nov 2019 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfK1NzY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Nov 2019 08:55:24 -0500
Received: from mout-p-102.mailbox.org ([80.241.56.152]:42482 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK1NzY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Nov 2019 08:55:24 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 47Nzfy3ZzczKmhq;
        Thu, 28 Nov 2019 14:55:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter05.heinlein-hosting.de (spamfilter05.heinlein-hosting.de [80.241.56.123]) (amavisd-new, port 10030)
        with ESMTP id e3jMDduX6ve0; Thu, 28 Nov 2019 14:55:18 +0100 (CET)
Date:   Fri, 29 Nov 2019 00:55:06 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched_getattr.2: update to include changed size semantics
Message-ID: <20191128135506.yo7432egjsg5ha5a@yavin.dot.cyphar.com>
References: <20191128120140.20367-1-cyphar@cyphar.com>
 <20191128130840.GA3719@calabresa>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="krryx2b7irtzsnkl"
Content-Disposition: inline
In-Reply-To: <20191128130840.GA3719@calabresa>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--krryx2b7irtzsnkl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-11-28, Thadeu Lima de Souza Cascardo <cascardo@canonical.com> wrote:
> On Thu, Nov 28, 2019 at 11:01:40PM +1100, Aleksa Sarai wrote:
> > Due to a userspace breakage, commit 1251201c0d34 ("sched/core: Fix
> > uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and
> > code") changed the semantics of sched_getattr(2) when the userspace
> > struct is smaller than the kernel struct. Now, any trailing non-zero
> > data in the kernel structure is ignored when copying to userspace.
> >=20
> > Ref: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
> >                     robustify sched_read_attr() ABI logic and code")
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  man2/sched_setattr.2 | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
> > index 76ffa14eba85..fbb67b8eb98b 100644
> > --- a/man2/sched_setattr.2
> > +++ b/man2/sched_setattr.2
> > @@ -284,10 +284,8 @@ structure,
> >  the additional bytes in the user-space structure are not touched.
> >  If the caller-provided structure is smaller than the kernel
> >  .I sched_attr
> > -structure and the kernel needs to return values outside the provided s=
pace,
> > -.BR sched_getattr ()
> > -fails with the error
> > -.BR E2BIG .
> > +structure, the kernel will silently not return any values which would =
be stored
> > +outside the provided space.
> >  As with
> >  .BR sched_setattr (),
> >  these semantics allow for future extensibility of the interface.
> > --=20
> > 2.24.0
> >=20
>=20
> I was thinking about documenting the difference in behavior of older kern=
els,
> before uclamp support.
>=20
> However, in practice, for sched_getattr, the kernel never returned E2BIG =
(the
> code uses EFBIG incorrectly, in fact). It does, however, return EINVAL for
> sizes smaller than SCHED_ATTR_SIZE_VER0.

I've been told the EFBIG was actually a typo and it was always meant to
be E2BIG. But yes, the precise problem with the old semantics was that
they weren't tested "in the wild" with a proper struct upgrade -- hence
all of the headaches.

If we ever do implement a copy_struct_to_user() we are almost certainly
going to implement it with the new sched_getattr() semantics. To be
honest, I'm not sure I can imagine a case where an old userspace program
would benefit from being given an error saying that the kernel has some
properties that it doesn't understand. (sched_getattr() is also weird
for other reasons, such as the fact it takes a separate size argument.)

> However, E2BIG is still mentioned below as a possible return value for
> sched_getattr. Can you remove that too?

Will do.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--krryx2b7irtzsnkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXd/RtgAKCRCdlLljIbnQ
EnADAP4xogLVJtGGpCCU6ph1lA5SfptwUStHYctiu/d1hLBpzAEApwB53SCLNQVA
Vpa8UIi1mcKXlDmepMnDbcB15mOyfAM=
=3N/i
-----END PGP SIGNATURE-----

--krryx2b7irtzsnkl--
