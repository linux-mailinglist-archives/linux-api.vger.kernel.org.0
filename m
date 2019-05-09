Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AC31951B
	for <lists+linux-api@lfdr.de>; Fri, 10 May 2019 00:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfEIWPj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 18:15:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40966 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfEIWPj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 18:15:39 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 81585802A4; Fri, 10 May 2019 00:15:25 +0200 (CEST)
Date:   Fri, 10 May 2019 00:15:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Murphy <dmurphy@ti.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v3 09/11] platform/x86: asus-wmi: Control RGB keyboard
 backlight
Message-ID: <20190509221538.GA527@amd>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com>
 <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
 <20190508171229.GA22024@amd>
 <52e73640-9fbf-437b-537a-7b3dc167052f@gmail.com>
 <2f26dd9e-ada7-8e20-c810-a647854c338c@ti.com>
 <CAHp75VcSVumVg74==bM3cBcZZ2iUNDnUao6h9Q6ktcyEuAKDew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <CAHp75VcSVumVg74==bM3cBcZZ2iUNDnUao6h9Q6ktcyEuAKDew@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-05-10 00:06:11, Andy Shevchenko wrote:
> On Thu, May 9, 2019 at 11:45 PM Dan Murphy <dmurphy@ti.com> wrote:
> > On 5/9/19 2:04 PM, Yurii Pavlovskyi wrote:
> > We are working on a framework for this.
> >
> > Please see this series
> > https://lore.kernel.org/patchwork/project/lkml/list/?series=3D390141
> >
> > It is still a work in progress
>=20
> Side question:
> Have you considered to convert existing color LED controllers? (It
> seems to me that your proposal lacks of the idea to keep back
> compatibility with the existing controllers whre user may create a
> sysfs node based on the arbitrary label, while it's good to have
> multicolor infrastructure like in your proposal. Did I miss
> something?)

That's undecided at the moment. We have enough fun trying to figure
out reasonable interface...


									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzUpooACgkQMOfwapXb+vJdigCgo3jVz3Quc3OXTEWsOVYA1oYS
f6AAoL5RxwgYeNlUWliZQo02BD1pZ2Df
=7Nn9
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
