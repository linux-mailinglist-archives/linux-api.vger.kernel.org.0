Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174292141C7
	for <lists+linux-api@lfdr.de>; Sat,  4 Jul 2020 00:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgGCWoN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 18:44:13 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39268 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCWoN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 18:44:13 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 821251C0C0F; Sat,  4 Jul 2020 00:44:11 +0200 (CEST)
Date:   Sat, 4 Jul 2020 00:44:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
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
Message-ID: <20200703224411.GC25072@amd>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Cryptographic libraries carry pseudo random number generators to
> quickly provide randomness when needed. If such a random pool gets
> cloned, secrets may get revealed, as the same random number may get
> used multiple times. For fork, this was fixed using the WIPEONFORK
> madvise flag [1].

> Unfortunately, the same problem surfaces when a virtual machine gets
> cloned. The existing flag does not help there. This patch introduces a
> new flag to automatically clear memory contents on VM suspend/resume,
> which will allow random number generators to reseed when virtual
> machines get cloned.

Umm. If this is real problem, should kernel provide such rng in the
vsdo page using vsyscalls? Kernel can have special interface to its
vsyscalls, but we may not want to offer this functionality to rest of
userland...

>  - Provides a simple mechanism to avoid RAM exfiltration during
>    traditional sleep/hibernate on a laptop or desktop when memory,
>    and thus secrets, are vulnerable to offline tampering or
>    inspection.

This second use has nothing to do with RNGs, right?

And I don't think we should do this in kernel.

It is userspace that initiates the suspend transition. Userspace
should lock the screen _before_ starting it, for example. Userspace
should also get rid of any secrets, first...

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7/tLsACgkQMOfwapXb+vKLKwCeJYf9jINarjpOcvkWGapwUdIa
uagAnjDEdee4JzvzUfcuKH+WBY/IbjHX
=2u6r
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
