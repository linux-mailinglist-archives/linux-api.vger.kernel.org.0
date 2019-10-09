Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07BEAD0BF5
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfJIJ5o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 05:57:44 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:35551 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729742AbfJIJ5o (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Oct 2019 05:57:44 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id BE529A1A7B;
        Wed,  9 Oct 2019 11:57:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id NafKbfNF4tGm; Wed,  9 Oct 2019 11:57:33 +0200 (CEST)
Date:   Wed, 9 Oct 2019 20:57:21 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] symlink.7: document magic-links more completely
Message-ID: <20191009095721.ruheswshfxcgbbkp@yavin>
References: <20191003145542.17490-1-cyphar@cyphar.com>
 <20191003145542.17490-2-cyphar@cyphar.com>
 <2fd9e82d-2a9c-cda9-0c17-3a20034eca1d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cllqcbo6bs3bqn24"
Content-Disposition: inline
In-Reply-To: <2fd9e82d-2a9c-cda9-0c17-3a20034eca1d@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--cllqcbo6bs3bqn24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-09, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> On 10/3/19 4:55 PM, Aleksa Sarai wrote:
> > Traditionally, magic-links have not been a well-understood topic in
> > Linux. Given the new changes in their semantics (related to the link
> > mode of trailing magic-links), it seems like a good opportunity to shine
> > more light on magic-links and their semantics.
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>=20
> Thanks for doing this. Some comments below.

No problem -- just a heads-up that I'm going to split off the magic-link
changes from the openat2(2) series (there are quite a few things that
need to be done). So I will drop this man page for now.

> > ---
> >  man7/path_resolution.7 | 15 +++++++++++++++
> >  man7/symlink.7         | 39 ++++++++++++++++++++++++++++++---------
> >  2 files changed, 45 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
> > index 07664ed8faec..46f25ec4cdfa 100644
> > --- a/man7/path_resolution.7
> > +++ b/man7/path_resolution.7
> > @@ -136,6 +136,21 @@ we are just creating it.
> >  The details on the treatment
> >  of the final entry are described in the manual pages of the specific
> >  system calls.
> > +.PP
> > +Since Linux 5.FOO, if the final entry is a "magic-link" (see
>=20
> "magic link". As Jann points out, this is more normal English usage.
>=20
> > +.BR symlink (7)),
> > +and the user is attempting to
> > +.BR open (2)
> > +it, then there is an additional permission-related restriction applied=
 to the
> > +operation: the requested access mode must not exceed the "link mode" o=
f the
> > +magic-link (unlike ordinary symlinks, magic-links have their own file =
mode.)
>=20
> Remove the hyphens (magic link). And also, as someone else pointed out,
> manual pages fairly consistently uses the term "symbolic link"
> (written in full).

Will do.

> You use the term "file mode" here. Do you mean the file permissions bits?

Yes.

> If yes, it is a bit misleading to suggest that symbolic links don't
> have these mode bits. They do, but--as noted in the existing symlink(7)
> manual page text--these bits are ignored. I suggest just removing the
> parenthesized text.

I was trying to say that their file mode can be non-0777 -- but I can
just drop the entire thing.

> > +For example, if
> > +.I /proc/[pid]/fd/[num]
> > +has a link mode of
> > +.BR 0500 ,
> > +unprivileged users are not permitted to
> > +.BR open ()
> > +the magic-link for writing.
> >  .SS . and ..
> >  By convention, every directory has the entries "." and "..",
> >  which refer to the directory itself and to its parent directory,
> > diff --git a/man7/symlink.7 b/man7/symlink.7
> > index 9f5bddd5dc21..33f0ec703acd 100644
> > --- a/man7/symlink.7
> > +++ b/man7/symlink.7
> > @@ -84,6 +84,25 @@ as they are implemented on Linux and other systems,
> >  are outlined here.
> >  It is important that site-local applications also conform to these rul=
es,
> >  so that the user interface can be as consistent as possible.
> > +.SS Magic-links
> > +There is a special class of symlink-like objects known as "magic-links=
" which
>=20
> "magic links" (and through the rest of the page).
>=20
> > +can be found in certain pseudo-filesystems such as
>=20
> pseudofilesystems
>=20
> > +.BR proc (5)
> > +(examples include
> > +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
> > +Unlike normal symlinks, magic-links are not resolved through
>=20
> symbolic links
>=20
> > +pathname-expansion, but instead act as direct references to the kernel=
's own
>=20
> pathname expansion

Will do all of the above.

> > +representation of a file handle. As such, these magic-links allow user=
s to
> > +access files which cannot be referenced with normal paths (such as unl=
inked
> > +files still referenced by a running program.)
> > +.PP
> > +Because they can bypass ordinary
> > +.BR mount_namespaces (7)-based
> > +restrictions, magic-links have been used as attack vectors in various =
exploits.
> > +As such (since Linux 5.FOO), there are additional restrictions placed =
on the
> > +re-opening of magic-links (see
> > +.BR path_resolution (7)
> > +for more details.)
> >  .SS Symbolic link ownership, permissions, and timestamps
> >  The owner and group of an existing symbolic link can be changed
> >  using
> > @@ -99,16 +118,18 @@ of a symbolic link can be changed using
> >  or
> >  .BR lutimes (3).
> >  .PP
> > -On Linux, the permissions of a symbolic link are not used
> > -in any operations; the permissions are always
> > -0777 (read, write, and execute for all user categories),
> >  .\" Linux does not currently implement an lchmod(2).
> > -and can't be changed.
> > -(Note that there are some "magic" symbolic links in the
> > -.I /proc
> > -directory tree\(emfor example, the
> > -.IR /proc/[pid]/fd/*
> > -files\(emthat have different permissions.)
> > +On Linux, the permissions of an ordinary symbolic link are not used in=
 any
> > +operations; the permissions are always 0777 (read, write, and execute =
for all
> > +user categories), and can't be changed.
> > +.PP
> > +However, magic-links do not follow this rule. They can have a non-0777=
 mode,
> > +which is used for permission checks when the final
> > +component of an
> > +.BR open (2)'s
> > +path is a magic-link (see
> > +.BR path_resolution (7).)
> > +
> >  .\"
> >  .\" The
> >  .\" 4.4BSD

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--cllqcbo6bs3bqn24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZ2u/gAKCRCdlLljIbnQ
EjRSAQD3mdmhcqPvPn9QRxIs/5ozFNFVHki8T6u+CFbUm3DsCQD+LtXhgKHyrZ9s
KEbVGN3G7nFnzi2ZDaPYj7apZfVNCgI=
=THxq
-----END PGP SIGNATURE-----

--cllqcbo6bs3bqn24--
