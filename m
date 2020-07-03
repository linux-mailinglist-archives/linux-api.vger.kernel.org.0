Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4FA21419B
	for <lists+linux-api@lfdr.de>; Sat,  4 Jul 2020 00:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGCWjK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 18:39:10 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38894 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGCWjK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 18:39:10 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id ECCA91C0C0F; Sat,  4 Jul 2020 00:39:05 +0200 (CEST)
Date:   Sat, 4 Jul 2020 00:39:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20200703223905.GB25072@amd>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
 <20200703113026.GT18446@dhcp22.suse.cz>
 <CAJZ5v0g+ip-EuUsoK646W-jVSSUhbnvHKsWmFH0+F1w0oYSmGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g+ip-EuUsoK646W-jVSSUhbnvHKsWmFH0+F1w0oYSmGw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2020-07-03 14:17:50, Rafael J. Wysocki wrote:
> On Fri, Jul 3, 2020 at 1:30 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> > > This patch adds logic to the kernel power code to zero out contents of
> > > all MADV_WIPEONSUSPEND VMAs present in the system during its transiti=
on
> > > to any suspend state equal or greater/deeper than Suspend-to-memory,
> > > known as S3.
> >
> > How does the application learn that its memory got wiped? S2disk is an
> > async operation and it can happen at any time during the task execution.
> > So how does the application work to prevent from corrupted state - e.g.
> > when suspended between two memory loads?
>=20
> This doesn't affect hibernation AFAICS, but system suspend
> (suspend-to-RAM or suspend-to-idle, or standby) is async too.
>=20
> I guess this calls for an interface to notify user space (that opted
> in to receive such notifications) on system-wide suspend start and
> finish.

We could simply provide a file that would produce single byte 'e' when
entering the suspend and different byte 'x' when exiting...

Not sure how useful that would be for the crypto stuff...

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7/s4kACgkQMOfwapXb+vIUJQCfZyt+lUVQmqy5smyeJI74Hz2s
FDAAoJdmlYDuJFsp9s0LjrrhyUvYHQG+
=XPvj
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
