Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA328D0C0D
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbfJIKAu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 06:00:50 -0400
Received: from mx2a.mailbox.org ([80.241.60.219]:41189 "EHLO mx2a.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfJIKAt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Oct 2019 06:00:49 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2a.mailbox.org (Postfix) with ESMTPS id 00312A1954;
        Wed,  9 Oct 2019 12:00:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id M1X-GLUNr7re; Wed,  9 Oct 2019 12:00:39 +0200 (CEST)
Date:   Wed, 9 Oct 2019 21:00:30 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] open.2: add O_EMPTYPATH documentation
Message-ID: <20191009100030.lnvglfvo6jcsobez@yavin>
References: <20191003145542.17490-1-cyphar@cyphar.com>
 <20191003145542.17490-3-cyphar@cyphar.com>
 <c4485b10-692d-ed24-a1d9-a047bb1054bf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="safzalfmrbpglft2"
Content-Disposition: inline
In-Reply-To: <c4485b10-692d-ed24-a1d9-a047bb1054bf@gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--safzalfmrbpglft2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-09, Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> Hello Aleksa,
>=20
> You write "5.FOO" in these patches. When do you expect these changes to=
=20
> land in the kernel?

Probably 5.6 (I'd hope for 5.5, but I don't know how the v14 review will
go). I'm not too sure though, and the magic-link changes (plus
O_EMPTYPATH) will probably land after openat2(2) since there is some
remaining work to do.

> On 10/3/19 4:55 PM, Aleksa Sarai wrote:
> > Some of the wording around empty paths in path_resolution(7) also needed
> > to be reworked since it's now legal (if you pass O_EMPTYPATH).
> >=20
> > Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> > ---
> >  man2/open.2            | 42 +++++++++++++++++++++++++++++++++++++++++-
> >  man7/path_resolution.7 | 17 ++++++++++++++++-
> >  2 files changed, 57 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/man2/open.2 b/man2/open.2
> > index b0f485b41589..7217fe056e5e 100644
> > --- a/man2/open.2
> > +++ b/man2/open.2
> > @@ -48,7 +48,7 @@
> >  .\" FIXME . Apr 08: The next POSIX revision has O_EXEC, O_SEARCH, and
> >  .\" O_TTYINIT.  Eventually these may need to be documented.  --mtk
> >  .\"
> > -.TH OPEN 2 2018-04-30 "Linux" "Linux Programmer's Manual"
> > +.TH OPEN 2 2019-10-03 "Linux" "Linux Programmer's Manual"
>=20
> No need to update the timestamp. I have scripts that handle this
> automatically.
>=20
> >  .SH NAME
> >  open, openat, creat \- open and possibly create a file
> >  .SH SYNOPSIS
> > @@ -421,6 +421,21 @@ was followed by a call to
> >  .BR fdatasync (2)).
> >  .IR "See NOTES below" .
> >  .TP
> > +.BR O_EMPTYPATH " (since Linux 5.FOO)"
> > +If \fIpathname\fP is an empty string, re-open the the file descriptor =
given as
>=20
> In general, I prefer the general form
>=20
> .I pathname
>=20
> over \fIpathname\fP.=20
>=20
> If you would be willing to cahnge that, it would  save me a little work.
> (And likewise throughout the rest of the patch.)
>=20
> > +the \fIdirfd\fP argument to
> > +.BR openat (2).
> > +This can be used with both ordinary (file and directory) and \fBO_PATH=
\fP file
> > +descriptors, but cannot be used with
> > +.BR AT_FDCWD
> > +(or as an argument to plain
> > +.BR open (2).) When re-opening an \fBO_PATH\fP file descriptor, the sa=
me "link
>=20
> There's a formatting problem here which can be fixed by inserting a=20
> newline before "When".
>=20
> > +mode" restrictions apply as with re-opening through
> > +.BR proc (5)
> > +(see
> > +.BR path_resolution "(7) and " symlink (7)
> > +for more details.)
> > +.TP
> >  .B O_EXCL
> >  Ensure that this call creates the file:
> >  if this flag is specified in conjunction with
> > @@ -668,6 +683,13 @@ with
> >  (or via procfs using
> >  .BR AT_SYMLINK_FOLLOW )
> >  even if the file is not a directory.
> > +You can even "re-open" (or upgrade) an
> > +.BR O_PATH
> > +file descriptor by using
> > +.BR O_EMPTYPATH
> > +(see the section for
> > +.BR O_EMPTYPATH
> > +for more details.)
> >  .IP *
> >  Passing the file descriptor to another process via a UNIX domain socket
> >  (see
> > @@ -958,6 +980,15 @@ is not allowed.
> >  (See also
> >  .BR path_resolution (7).)
> >  .TP
> > +.B EBADF
> > +.I pathname
> > +was an empty string (and
> > +.B O_EMPTYPATH
> > +was passed) with
> > +.BR open (2)
> > +(instead of
> > +.BR openat (2).)
> > +.TP
> >  .B EDQUOT
> >  Where
> >  .B O_CREAT
> > @@ -1203,6 +1234,15 @@ The following additional errors can occur for
> >  .I dirfd
> >  is not a valid file descriptor.
> >  .TP
> > +.B EBADF
> > +.I pathname
> > +was an empty string (and
> > +.B O_EMPTYPATH
> > +was passed), but the provided
> > +.I dirfd
> > +was an invalid file descriptor (or was
> > +.BR AT_FDCWD .)
> > +.TP
> >  .B ENOTDIR
> >  .I pathname
> >  is a relative pathname and
> > diff --git a/man7/path_resolution.7 b/man7/path_resolution.7
> > index 46f25ec4cdfa..85dd354e9a93 100644
> > --- a/man7/path_resolution.7
> > +++ b/man7/path_resolution.7
> > @@ -22,7 +22,7 @@
> >  .\" the source, must acknowledge the copyright and authors of this wor=
k.
> >  .\" %%%LICENSE_END
> >  .\"
> > -.TH PATH_RESOLUTION 7 2017-11-26 "Linux" "Linux Programmer's Manual"
> > +.TH PATH_RESOLUTION 7 2019-10-03 "Linux" "Linux Programmer's Manual"
> >  .SH NAME
> >  path_resolution \- how a pathname is resolved to a file
> >  .SH DESCRIPTION
> > @@ -198,6 +198,21 @@ successfully.
> >  Linux returns
> >  .B ENOENT
> >  in this case.
> > +.PP
> > +As of Linux 5.FOO, an empty path argument can be used to indicate the =
"re-open"
> > +an existing file descriptor if
> > +.B O_EMPTYPATH
> > +is passed as a flag argument to
> > +.BR openat (2),
> > +with the
> > +.I dfd
> > +argument indicating which file descriptor to "re-open". This is approx=
imately
> > +equivalent to opening
> > +.I /proc/self/fd/$fd
>=20
> .IR /proc/self/fd/$fd ,
>=20
> > +where
> > +.I $fd
> > +is the open file descriptor to be "re-opened".
> > +
>=20
> No blank line here.
>=20
> >  .SS Permissions
> >  The permission bits of a file consist of three groups of three bits; s=
ee
> >  .BR chmod (1)

Will fix all of the above -- thanks!


--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--safzalfmrbpglft2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZ2vugAKCRCdlLljIbnQ
EsbVAQD5xDig2A54+r7gr4A1LzNImXSFvlv/K27Oa7IcbazcggEAs50kZAq+7MdM
15Y5f1BT2jg01oMFBON7sOhBaP6dZwI=
=S8p1
-----END PGP SIGNATURE-----

--safzalfmrbpglft2--
