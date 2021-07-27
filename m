Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E13D74B7
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 14:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbhG0MEO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 08:04:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58922 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhG0MEO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Jul 2021 08:04:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A88A81C0B76; Tue, 27 Jul 2021 14:04:13 +0200 (CEST)
Date:   Tue, 27 Jul 2021 14:04:13 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>, Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-ID: <20210727120413.GB32265@duo.ucw.cz>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
 <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
 <YO55ZIrgkLXI4BbS@dhcp22.suse.cz>
 <b84dfb7b-9ae7-8cd7-ce65-0b1952e30e8e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <b84dfb7b-9ae7-8cd7-ce65-0b1952e30e8e@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Let's take a look at hibernate() callers:
>=20
> drivers/mfd/tps65010.c: calls hibernate() from IRQ contex, based on HW
>                         event

No it does not. Look again.

> kernel/power/autosleep.c: calls hibernate() when it thinks it might be
>  			  a good time to go to sleep

Ok, you are right, it is there. But I don't believe anyone uses this
configuration.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYP/2PQAKCRAw5/Bqldv6
8t0DAKCr+H62AWwU7hlQPxiFE3r6Q/k46wCgqJGkAHYArzZ/clI1dsQrc9Vij0o=
=6EnC
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
