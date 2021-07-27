Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92C53D74C2
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 14:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbhG0MKL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 08:10:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59568 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhG0MKL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Jul 2021 08:10:11 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id BD1AF1C0B76; Tue, 27 Jul 2021 14:10:09 +0200 (CEST)
Date:   Tue, 27 Jul 2021 14:10:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evan Green <evgreen@chromium.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-ID: <20210727121009.GC32265@duo.ucw.cz>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
 <CAE=gft7Qd3NSnoFYaXv=FkP0=Je85mNOKojuW5rhg6HkS=usLA@mail.gmail.com>
 <YO55FCfsjalGicMo@dhcp22.suse.cz>
 <CAE=gft5L062V_xE+Nj5UqNrjK9ET6PPtekJpnurzPGobWjpeUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline
In-Reply-To: <CAE=gft5L062V_xE+Nj5UqNrjK9ET6PPtekJpnurzPGobWjpeUQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > If I have
> > > different security designs for swap space and hibernate, then even a
> > > chance of some swap leaking into this region is a problem.
> >
> > Could you expand some more about the this part please?
>=20
> Offline attacks (ie manipulating storage from underneath the machine)
> are a major concern when enabling both swap and hibernate. But the
> approach of adding integrity to mitigate offline attacks may differ
> between swap and hibernate in the interest of performance. Swap for
> instance essentially needs a per-page dictionary of hashes for
> integrity, since pages can be added and removed arbitrarily. Hibernate
> however just needs a single hash across the entire image to provide
> integrity. If you have swap leaking onto a region where you don't have
> integrity enabled (because say you handled integrity at the image
> level for hibernate, and at the block layer for swap), your swap
> integrity story is compromised.

If you want to encrypt/sign the hibernation, you likely should use
uswsusp, and that means you can store hibernation image where (and
how) you want it, without modifying kernel.

See kernel/power/user.c .

> I don't think this digs the design hole deeper. Yes, the ship on this
> design has long ago sailed. But if we ever did try to dig ourselves
> out of the swap/hibernate hole by providing new APIs to handle them
> separately, this flag would serve as a good cutover to divert out of
> the swap code and into the new shiny hibernate-only code. The APIs are
> never going to be totally disentangled, so a clean cutover opportunity
> is the best one can hope for.

Is uswsusp the place that should provide clean cutover?

Anyway, I acked the patch before, but it looks like it was
mistake. I withdraw the ack.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYP/3oQAKCRAw5/Bqldv6
8uTJAKCXT792Z09f+xBOfKt2W3D1q0/7swCfTgTOXUu8wbDT/wEminQRGN7O1vk=
=h3cE
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
