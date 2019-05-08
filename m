Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D84517EEA
	for <lists+linux-api@lfdr.de>; Wed,  8 May 2019 19:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfEHRMb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 May 2019 13:12:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57972 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfEHRMb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 May 2019 13:12:31 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D33C180260; Wed,  8 May 2019 19:12:16 +0200 (CEST)
Date:   Wed, 8 May 2019 19:12:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
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
Message-ID: <20190508171229.GA22024@amd>
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <c953b43b-6186-77e9-54b1-b1cd1d7d1eb6@gmail.com>
 <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <CAHp75Vf9uPG7_K0P26nHYCH0WB6LFX3wk8aJBpLWQ-r46kDw9w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > The WMI exposes two methods for controlling RGB keyboard backlight, whi=
ch
> > allows controlling:
> > * RGB components in range 00 - ff,
> > * Switch between 4 effects,
> > * Switch between 3 effect speed modes,
> > * Separately enable the backlight on boot, in the awake state (after dr=
iver
> >   load), in sleep mode, and probably in something called shutdown mode =
(no
> >   observable effects of enabling it are known so far).
> >
> > The configuration should be written to several sysfs parameter buffers
> > which are then written via WMI by writing either 1 or 2 to the "kbbl_se=
t"
> > parameter. When reading the buffers the last written value is returned.
> >
> > If the 2 is written to "kbbl_set", the parameters will be reset on rebo=
ot
> > (temporary mode), 1 is permanent mode, parameters are retained.
> >
> > The calls use new 3-dword input buffer method call.
> >
> > The functionality is only enabled if corresponding DSTS methods return
> > exact valid values.
> >
> > The following script demonstrates usage:
> >
> > echo Red [00 - ff]
> > echo 33 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_red
> > echo Green [00 - ff]
> > echo ff > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_green
> > echo Blue [00 - ff]
> > echo 0 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_blue
> > echo Mode: 0 - static color, 1 - breathing, 2 - color cycle, 3 - strobi=
ng
> > echo 0 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_mode
> > echo Speed for modes 1 and 2: 0 - slow, 1 - medium, 2 - fast
> > echo 0 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_speed
> > echo Enable: 02 - on boot, before module load, 08 - awake, 20 - sleep,
> > echo 2a or ff to set all
> > echo 2a > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_flags
> > echo Save: 1 - permanently, 2 - temporarily, reset after reboot
> > echo 1 > /sys/devices/platform/asus-nb-wmi/kbbl/kbbl_set
> >
>=20
> Shouldn't be the LED subsystem driver for this?

Yes, please. We have common interface for LED drivers; this needs to
use it.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzTDf0ACgkQMOfwapXb+vJFGACfSBV9DLzKArrDcy1WFTMiUIRD
adwAoKGN8uwzERJIj5yAWDJcBhtOauT3
=Pemh
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
