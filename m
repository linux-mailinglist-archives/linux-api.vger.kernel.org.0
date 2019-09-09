Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE45AD5ED
	for <lists+linux-api@lfdr.de>; Mon,  9 Sep 2019 11:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfIIJme (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Sep 2019 05:42:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33266 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfIIJme (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Sep 2019 05:42:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3BD0D807DB; Mon,  9 Sep 2019 11:42:18 +0200 (CEST)
Date:   Mon, 9 Sep 2019 11:42:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Theodore Tso <tytso@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 0/7] Rework random blocking
Message-ID: <20190909094230.GB27626@amd>
References: <cover.1567126741.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <cover.1567126741.git.luto@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2019-08-29 18:11:35, Andy Lutomirski wrote:
> This makes two major semantic changes to Linux's random APIs:
>=20
> It adds getentropy(..., GRND_INSECURE).  This causes getentropy to
> always return *something*.  There is no guarantee whatsoever that
> the result will be cryptographically random or even unique, but the
> kernel will give the best quality random output it can.  The name is
> a big hint: the resulting output is INSECURE.
>=20
> The purpose of this is to allow programs that genuinely want
> best-effort entropy to get it without resorting to /dev/urandom.
> Plenty of programs do this because they need to do *something*
> during boot and they can't afford to wait.  Calling it "INSECURE" is
> probably the best we can do to discourage using this API for things
> that need security.
>=20
> This series also removes the blocking pool and makes /dev/random
> work just like getentropy(..., 0) and makes GRND_RANDOM a no-op.  I
> believe that Linux's blocking pool has outlived its usefulness.
> Linux's CRNG generates output that is good enough to use even for
> key generation.  The blocking pool is not stronger in any material
> way, and keeping it around requires a lot of infrastructure of
> dubious value.

Could you give some more justification? If crng is good enough for
you, you can use /dev/urandom...


are=20

> This series should not break any existing programs.  /dev/urandom is
> unchanged.  /dev/random will still block just after booting, but it
> will block less than it used to.  getentropy() with existing flags
> will return output that is, for practical purposes, just as strong
> as before.

So what is the exact semantic of /dev/random after your change?
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl12HoYACgkQMOfwapXb+vKGdACfbyQrNBFgA8TPw3BNsZDnNW9L
jwIAniwUsIa4ppyFvofYamZuYigUnLNJ
=1fQs
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
