Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB003EF1DC
	for <lists+linux-api@lfdr.de>; Tue, 17 Aug 2021 20:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhHQSdI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Aug 2021 14:33:08 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43702 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhHQSdI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Aug 2021 14:33:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B91051C0B77; Tue, 17 Aug 2021 20:32:33 +0200 (CEST)
Date:   Tue, 17 Aug 2021 20:32:33 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Enable suspend-only swap spaces
Message-ID: <20210817183233.GA14518@amd>
References: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <d6668437-5c3b-2dff-bb95-4e3132d13711@redhat.com>
 <6ff28cfe-1107-347b-0327-ad36e256141b@redhat.com>
 <CAE=gft7567-2Lq7raJKrOpQ8UAvXTFWwPci=_GCRPET3nS=9SA@mail.gmail.com>
 <20210727141832.86695e7181eb10c6e8fd0191@linux-foundation.org>
 <CAE=gft6LmTKx2JHAj7GBmph_1BrioXhmtn_xQEHtRhK+tPa6qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <CAE=gft6LmTKx2JHAj7GBmph_1BrioXhmtn_xQEHtRhK+tPa6qw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > Pavel just mentioned uswsusp, and I wonder if it would be a possible
> > > > alternative to this patch.
> > >
> > > I think you're right that it would be possible to isolate the
> > > hibernate image with uswsusp if you avoid using the SNAPSHOT_*SWAP*
> > > ioctls. But I'd expect performance to suffer noticeably, since now
> > > every page is making a round trip out to usermode and back. I'd still
> > > very much use the HIBERNATE_ONLY flag if it were accepted, I think
> > > there's value to it.
> >
> > The uswsusp option makes your patch a performance optimization rather
> > than a feature-add.  And we do like to see quantitative testing results
> > when considering a performance optimization.  Especially when the
> > performance optimization is a bit icky, putting special-case testing
> > all over the place, maintenance cost, additional testing effort, etc.
> >
> > I do think that diligence demands that we quantify the difference.  Is
> > this a thing you can help with?
>=20
> I'm wrong about the performance. Uswsusp is just as fast, and possibly
> faster in my use case than kernel-driven hibernate. What's more,
> uswsusp also helps me solve several additional problems I hadn't
> tackled yet that were looming in front of me. Thanks all for your
> patience and thoughtful review on this.

Great to see uswsusp being used :-).

Thanks,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEcAMEACgkQMOfwapXb+vKT/QCghbi3ZypdUeEfrA2k0why8r3r
USoAnjPivJsELW4o50xScy0FwXbf1B7w
=MuBX
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
