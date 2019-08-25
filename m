Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6212B9C2C5
	for <lists+linux-api@lfdr.de>; Sun, 25 Aug 2019 11:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfHYJvJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 25 Aug 2019 05:51:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50358 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbfHYJvJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 25 Aug 2019 05:51:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 07884812E3; Sun, 25 Aug 2019 11:50:53 +0200 (CEST)
Date:   Sun, 25 Aug 2019 11:51:06 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V40 10/29] hibernate: Disable when the kernel is locked
 down
Message-ID: <20190825095106.GD1644@amd>
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-11-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline
In-Reply-To: <20190820001805.241928-11-matthewgarrett@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-08-19 17:17:46, Matthew Garrett wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
>=20
> There is currently no way to verify the resume image when returning
> from hibernate.  This might compromise the signed modules trust model,
> so until we can work with signed hibernate images we disable it when the
> kernel is locked down.
>=20
> Signed-off-by: Josh Boyer <jwboyer@fedoraproject.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: rjw@rjwysocki.net
> Cc: pavel@ucw.cz
> cc: linux-pm@vger.kernel.org
> Signed-off-by: James Morris <jmorris@namei.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1iWgoACgkQMOfwapXb+vJjIgCfUZfnFSM3yMH7xIKKwWsgpi8u
qu4An2fFN+zbwRtWr/eFuPbuIfXNlZOF
=jHC1
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
