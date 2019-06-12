Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF1642330
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 13:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732330AbfFLK7s (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 06:59:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39803 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbfFLK7s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 06:59:48 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id F2751802E0; Wed, 12 Jun 2019 12:59:35 +0200 (CEST)
Date:   Wed, 12 Jun 2019 12:59:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com
Subject: Re: [PATCH v2 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190612105945.GA16442@amd>
References: <20190610111252.239156-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
In-Reply-To: <20190610111252.239156-1-minchan@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> - Problem
>=20
> Naturally, cached apps were dominant consumers of memory on the system.
> However, they were not significant consumers of swap even though they are
> good candidate for swap. Under investigation, swapping out only begins
> once the low zone watermark is hit and kswapd wakes up, but the overall
> allocation rate in the system might trip lmkd thresholds and cause a cach=
ed
> process to be killed(we measured performance swapping out vs. zapping the
> memory by killing a process. Unsurprisingly, zapping is 10x times faster
> even though we use zram which is much faster than real storage) so kill
> from lmkd will often satisfy the high zone watermark, resulting in very
> few pages actually being moved to swap.

Is it still faster to swap-in the application than to restart it?


> This approach is similar in spirit to madvise(MADV_WONTNEED), but the
> information required to make the reclaim decision is not known to the app.
> Instead, it is known to a centralized userspace daemon, and that daemon
> must be able to initiate reclaim on its own without any app involvement.
> To solve the concern, this patch introduces new syscall -
>=20
>     struct pr_madvise_param {
>             int size;               /* the size of this structure */
>             int cookie;             /* reserved to support atomicity */
>             int nr_elem;            /* count of below arrary fields */
>             int __user *hints;      /* hints for each range */
>             /* to store result of each operation */
>             const struct iovec __user *results;
>             /* input address ranges */
>             const struct iovec __user *ranges;
>     };
>    =20
>     int process_madvise(int pidfd, struct pr_madvise_param *u_param,
>                             unsigned long flags);

That's quite a complex interface.

Could we simply have feel_free_to_swap_out(int pid) syscall? :-).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0A2yEACgkQMOfwapXb+vK7ngCdHTHlKgNthsiwMrKqz+jDGcDZ
sfAAn1C5KLFMD7cpycS9Ep2CWeYprU8B
=j4LI
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
