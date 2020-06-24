Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0472072B7
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 14:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390682AbgFXMBG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 08:01:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:49312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389396AbgFXMBG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Jun 2020 08:01:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0EC52AED7;
        Wed, 24 Jun 2020 12:01:04 +0000 (UTC)
Date:   Wed, 24 Jun 2020 14:01:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        systemd-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/3] nsproxy: attach to namespaces via pidfds
Message-ID: <20200624120102.GD23220@blackbook>
References: <20200505140432.181565-1-christian.brauner@ubuntu.com>
 <20200505140432.181565-3-christian.brauner@ubuntu.com>
 <20200624114437.GA117125@blackbook>
 <20200624115456.rvzlgn77jol2a2oc@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EY/WZ/HvNxOox07X"
Content-Disposition: inline
In-Reply-To: <20200624115456.rvzlgn77jol2a2oc@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--EY/WZ/HvNxOox07X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2020 at 01:54:56PM +0200, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> Yep, I already have a fix for this in my tree based on a previous
> report from LTP.
Perfect. (Sorry for the noise then.)

Thanks,
Michal

--EY/WZ/HvNxOox07X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl7zQHQACgkQia1+riC5
qSjp+hAAhpLLgI1sSq8gt/a4kkCyQdU72Rlx8DCV2a1CQsMKKvxVinCcvmU4I+IA
EPhBiLuVoohS6h+qJtovzPBEWaMeLuqcRxlusj+vimpQffvTSXoYZ35lce2W5xKd
mKT9G6LnGaij3LIS7B4JqyHKns43zQapO8yzlgOZ/5oGtAMlmnzOxzO2jsuWQa89
5+GrYFGoT30Fx2yXB3znSyMi66O+aYuxdZW94te+t9cv94yPriCSfogpJsmxJUv/
XANi72AZi9ECNdTSxcZOg+5CxVryO7p01R5Lqjk6jQIo5EWHOfPjnambU6i3YoFb
2Sbbg18klQ99nN9rQBRlR0ybYTkfaY+kebsxlug07nwNwdaznIIkVROz40hG5CRe
7A09DcETbH9NaKfJEPudw/UaXZ0YkW9OCRl5K4MVkn5f8T7yOuk3jg2hJnYUkiIW
cpnBNczHwyYt4ES3os0DOcMl/BoQvBh6RU4R8snzGQLCmB6G01RFTqLhC+NhCy83
wF6IdRoWu+HP2OsxYOjQwDfYj0lwk39sEhAOQ0XIZvkb2Sls+sMB4zk6qbbarpaG
sBeLQN+xECle5yvlcOHNzZyuF5JP/ER2BwTawPMwhd5s1Mn0FDUiGp1T23WKiINP
k7dthyuXOb668yeKULDASwvuCSvvCZpftxTI0AmGGeUIHsfb1c0=
=Vo8b
-----END PGP SIGNATURE-----

--EY/WZ/HvNxOox07X--
