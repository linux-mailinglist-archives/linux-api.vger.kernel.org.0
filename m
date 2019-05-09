Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F382619543
	for <lists+linux-api@lfdr.de>; Fri, 10 May 2019 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfEIWeh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 May 2019 18:34:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41484 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfEIWeh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 May 2019 18:34:37 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3BD88802A4; Fri, 10 May 2019 00:34:24 +0200 (CEST)
Date:   Fri, 10 May 2019 00:34:37 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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
Message-ID: <20190509223436.GB527@amd>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com>
 <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
 <20190508171229.GA22024@amd>
 <52e73640-9fbf-437b-537a-7b3dc167052f@gmail.com>
 <2f26dd9e-ada7-8e20-c810-a647854c338c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CUfgB8w4ZwR/yMy5"
Content-Disposition: inline
In-Reply-To: <2f26dd9e-ada7-8e20-c810-a647854c338c@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> Yes, please. We have common interface for LED drivers; this needs to
> >> use it.
> >=20
> > That is indeed a better option and I did in fact considered this first =
and
> > even did a test implementation. The discoveries were:
> > 1. The WMI methods are write-only and only written all at once in a
> > transaction manner (also invoking solely first RGB-interface method has=
 no
> > effect until some other keyboard backlight method is called).

Write-only is not a problem, right? Nor should be transaction. Just
cache the values in kernel.

> > 2. In addition to RGB there are several control values, which switch
> > effects, speed and enable or disable the backlight under specific
> > conditions or switch whether it is set temporarily or permanently (not =
that
> > these are critical functionalities, but for the sake of
> > completeness).

Yep, lets ignore that for now.

> > 3. The EC is really slow
> > # time bash -c "echo 1 > /sys/devices/platform/faustus/kbbl_set"
> >=20
> > real	0m0,691s
> > user	0m0,000s
> > sys	0m0,691s
> >=20
> > (please ignore the sysfs-path there, it's essentially the same code run=
ning
> > as in this patch). It is consistently same for both temporary and perma=
nent
> > configuration. Writing after every change would take about (6+)x of tha=
t.
> > Not that it's that unbearable though as it is not likely to be
> > done often.

Yup, this is quite ugly.

What about simply ignoring changes as they happen, and then setting
RGB channels when nothing changes for 10msec?

> > I was not quite happy with that implementation so I opted for writing s=
ort
> > of sysfs wrapper instead that would allow same sort of transactions as
> > provided by BIOS. I agree that it's non-standard solution.
> >=20
> > If I understood correctly, the typical current RGB led_class devices fr=
om
> > the Linux tree currently provide channels as separate LEDs. There are a=
lso
> > blink / pattern options present, I guess one could misuse them for sett=
ing
> > effects and speed. So one could make 3 devices for RGB + 3 for awake,
> > sleep, boot modes + 1 for setting effect / speed.

Take a look at "pattern" trigger. That should give you effect/speed
options. .. for single channel.

> > I'd guess the end solution might be also either something like combinat=
ion
> > of both approaches (RGB leds + separate sysfs interface) or some extens=
ion
> > of the led_class device interface. Dropping support of the non-essential
> > features for the sake of uniformity of ABI would also be an option to
> > consider (exposing just three RGB LEDs with brightness only), not happy=
 one
> > though.
> >=20
> > In any case this looks like it might need some additional research,
> > discussion, development, and a pair of iterations so I tend to separate
> > this patch from the series and post it extra after the others are throu=
gh
> > to avoid dragging 10+ patches around.

Separate patch certainly makes sense.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--CUfgB8w4ZwR/yMy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzUqvwACgkQMOfwapXb+vK90gCfa5VCwbhBeQ0RlMOZuDkqJBma
raAAnj+RO123XbofMN8InUVu/ER8DTMR
=EKgO
-----END PGP SIGNATURE-----

--CUfgB8w4ZwR/yMy5--
