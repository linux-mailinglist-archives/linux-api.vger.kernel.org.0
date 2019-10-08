Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295ABCF090
	for <lists+linux-api@lfdr.de>; Tue,  8 Oct 2019 03:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfJHBeF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Oct 2019 21:34:05 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:31464 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726917AbfJHBeF (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Oct 2019 21:34:05 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id D7967A33B3;
        Tue,  8 Oct 2019 03:34:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id oK7UU0kzyVpP; Tue,  8 Oct 2019 03:33:57 +0200 (CEST)
Date:   Tue, 8 Oct 2019 12:33:46 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Jann Horn <jannh@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] symlink.7: document magic-links more completely
Message-ID: <20191008013346.7qft2qqz4wz7ld35@yavin.dot.cyphar.com>
References: <20191003145542.17490-1-cyphar@cyphar.com>
 <20191003145542.17490-2-cyphar@cyphar.com>
 <CAG48ez2LuOGAXgKftZKfDKxhdb6xcBTdoK468-HXdcpxCW4r4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2q45tajd22yttzl5"
Content-Disposition: inline
In-Reply-To: <CAG48ez2LuOGAXgKftZKfDKxhdb6xcBTdoK468-HXdcpxCW4r4w@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--2q45tajd22yttzl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-07, Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 3, 2019 at 4:56 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > Traditionally, magic-links have not been a well-understood topic in
> > Linux. Given the new changes in their semantics (related to the link
> > mode of trailing magic-links), it seems like a good opportunity to shine
> > more light on magic-links and their semantics.
> [...]
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
> I think names like that normally aren't hypenated in english, and
> instead of "magic-links", it'd be "magic links"? Just like how you
> wouldn't write "symbolic-link", but "symbolic link". But this is
> bikeshedding, and if you disagree, feel free to ignore this comment.

Looking at it now, I think you're right -- I hyphenated it here because
that's how I wrote it when documenting the feature in comments. But I
think that's because "symlink" and "magic-link" (the "abbreviated"
versions) seem to match better than "symlink" and "magic link".

I'll use "magic link" in documentation, but "magic-link" for all cases
where I would normally write "symlink".

> > +can be found in certain pseudo-filesystems such as
> > +.BR proc (5)
> > +(examples include
> > +.IR /proc/[pid]/exe " and " /proc/[pid]/fd/* .)
> > +Unlike normal symlinks, magic-links are not resolved through
>=20
> nit: AFAICS symlinks are always referred to as "symbolic links"
> throughout the manpages.

:+1:

> > +pathname-expansion, but instead act as direct references to the kernel=
's own
> > +representation of a file handle. As such, these magic-links allow user=
s to
> > +access files which cannot be referenced with normal paths (such as unl=
inked
> > +files still referenced by a running program.)
>=20
> Could maybe add "and files in different mount namespaces" as another
> example here; at least for me, that's the main usecases for
> /proc/*/root.

Will do.

> [...]
> > +However, magic-links do not follow this rule. They can have a non-0777=
 mode,
> > +which is used for permission checks when the final
> > +component of an
> > +.BR open (2)'s
>=20
> Maybe leave out the "open" part, since the same restriction has to
> also apply to other syscalls operating on files, like truncate() and
> so on?

Yes (though I've just realised I hadn't implemented that -- oops.) Given
how expansive this patchset will get -- I might end up splitting it into
the magic-link stuff (and O_EMPTYPATH) and a separate series for
openat2(2) and the path resolution restrictions.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--2q45tajd22yttzl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXZvndgAKCRCdlLljIbnQ
Em8rAP9zDYU4BspEqrhHWm9St1g7MKKDDBGjzIBK742FA4EA6gD9FXqkmZPXhZHY
m/PlSBGP4lC67Pms1YwaoDM1pk2x+Ak=
=dsvW
-----END PGP SIGNATURE-----

--2q45tajd22yttzl5--
