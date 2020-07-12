Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD4D21C7D9
	for <lists+linux-api@lfdr.de>; Sun, 12 Jul 2020 09:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgGLHWd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 12 Jul 2020 03:22:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:46806 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgGLHWd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 12 Jul 2020 03:22:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AC44D1C0BD5; Sun, 12 Jul 2020 09:22:28 +0200 (CEST)
Date:   Sun, 12 Jul 2020 09:22:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Colm MacCarthaigh <colmmacc@amazon.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>, linux-mm@kvack.org,
        linux-pm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-api@vger.kernel.org, akpm@linux-foundation.org,
        rjw@rjwysocki.net, len.brown@intel.com, fweimer@redhat.com,
        keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        mingo@kernel.org, bonzini@gnu.org,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200712072228.GB4721@duo.ucw.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200707073823.GA3820@dhcp22.suse.cz>
 <20200707080726.GA32357@amd>
 <20200707085847.GA5913@dhcp22.suse.cz>
 <20200707163758.GA1947@amd>
 <E6B41570-E206-4458-921B-465B9EF74949@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <E6B41570-E206-4458-921B-465B9EF74949@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-07-07 12:00:41, Colm MacCarthaigh wrote:
>=20
>=20
> On 7 Jul 2020, at 9:37, Pavel Machek wrote:
> > Please go through the thread and try to understand it.
> >=20
> > You'd need syscalls per get_randomness(), not per migration.
>=20
> I think one check per get_randomness() is sufficient, though putting it at
> the end of the critical section rather than the beginning helps.

Yeah, well, one syscall is still enough to make it useless.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXwq6NAAKCRAw5/Bqldv6
8uuCAJ9LrEaAGhXBNhJwHuvAzGcY9PEKpACgo6pz2brnyUlPHZvcCAbvR8lQRLk=
=jD89
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
