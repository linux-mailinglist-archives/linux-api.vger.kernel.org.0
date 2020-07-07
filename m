Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EBA21742C
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGQiB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 12:38:01 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38352 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQiB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 12:38:01 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 70C791C0C0A; Tue,  7 Jul 2020 18:37:58 +0200 (CEST)
Date:   Tue, 7 Jul 2020 18:37:58 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        "Catangiu, Adrian Costin" <acatan@amazon.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200707163758.GA1947@amd>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAG48ez2O2z4L=n57Omwy6s1sWQkdTkPKiikhbfdVhiyd_TGRRw@mail.gmail.com>
 <20200707073823.GA3820@dhcp22.suse.cz>
 <20200707080726.GA32357@amd>
 <20200707085847.GA5913@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <20200707085847.GA5913@dhcp22.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > You can do it seqlock-style, kind of - you reserve the first byte of
> > > > the page or so as a "is this page initialized" marker, and after ev=
ery
> > > > read from the page, you do a compiler barrier and check whether that
> > > > byte has been cleared.
> > >=20
> > > This is certainly possible yet wery awkwar interface to use IMHO.
> > > MADV_EXTERNALY_VOLATILE would express the actual semantic much better.
> > > I might not still understand the expected usecase but if the target
> > > application has to be changed anyway then why not simply use a
> > > transparent and proper signaling mechanism like poll on a fd. That
> >=20
> > The goal is to have cryprographically-safe get_random_number() with 0
> > syscalls.
> >=20
> > You'd need to do:
> >=20
> >    if (!poll(did_i_migrate)) {
> >          use_prng_seed();
> > 	 if (poll(did_i_migrate)) {
> > 	       /* oops_they_migrated_me_in_middle_of_computation,
> >  	          lets_redo_it() */
> >  		  goto retry:
> > 	 }
> >    }
> >=20
> > Which means two syscalls..
>=20
> Is this a real problem though? Do we have any actual numbers? E.g. how
> often does the migration happen so that 2 syscalls would be visible in
> actual workloads?

Please go through the thread and try to understand it.

You'd need syscalls per get_randomness(), not per migration.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8EpOUACgkQMOfwapXb+vIrGQCfa8t3eRPUQJN4sgdBPhRqIXIN
Md0AoL/VSUKG0fqXzutn3A1vlMnmAH5A
=B3/F
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
