Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED8FFBD9D
	for <lists+linux-api@lfdr.de>; Thu, 14 Nov 2019 02:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfKNBsb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 13 Nov 2019 20:48:31 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:10612 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfKNBsb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 13 Nov 2019 20:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573696107;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=4ffHBB9/52/MY1Qf33VviaYK3WPUsckkWp5OkQvLBKk=;
        b=hZQdzgZwHaGgItIc9B9grvhZCeZhYRZgT6opVmlgknaj6J5zNebynbpQOOKDWwQcF/
        sLkq2R+NtiS3ZpnT3+JX6Y25kS43R3NcXYTpv0nZWqMRQoXkZuDxyxfp5CER4qMG8imx
        KiXuyQYJdoWkgFOsogSnsyXnd4A3tqGm1eqhvdZ5Z6ujrdtSziESK1vwff+RH1PGYgFD
        31pJTZJ2Kaenekgq6KTNE6qIFhs1d6VM66JWoK51qUZ8Y7pkQL/MUmhbSrUQwZEF+AkZ
        9uihgNOCSjjM8ovrSJKINlUEnYmbZzpI8dlTOE8Q9PxdTd35i/t9VLf9NOzoBeJ7L50u
        Unfg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zmwdNLqV/Nz7PsNPEA=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 SBL|AUTH)
        with ESMTPSA id N09a57vAE1kfGBt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 14 Nov 2019 02:46:41 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     "Alexander E. Patrakov" <patrakov@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v24 11/12] LRNG - add SP800-90B compliant health tests
Date:   Thu, 14 Nov 2019 02:46:38 +0100
Message-ID: <7132090.9rmkJY1zsi@positron.chronox.de>
In-Reply-To: <CAN_LGv3LUjJ=8ZZxaJ=c7uDPb=ayvCNPE-UshxgBUK-Jf7qNmQ@mail.gmail.com>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <9152597.fJySsU3eCD@positron.chronox.de> <CAN_LGv3LUjJ=8ZZxaJ=c7uDPb=ayvCNPE-UshxgBUK-Jf7qNmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Mittwoch, 13. November 2019, 07:02:40 CET schrieb Alexander E. Patrakov:

Hi Alexander,

> =D1=81=D1=80, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2019 =D0=B3. =D0=B2 05:38, Ste=
phan M=C3=BCller <smueller@chronox.de>:
> > Am Dienstag, 12. November 2019, 20:58:32 CET schrieb Alexander E.
> > Patrakov:
> >=20
> > Hi Alexander,
> >=20
> > > > +config LRNG_HEALTH_TESTS
> > > > +   bool "Enable noise source online health tests"
> > > > +   help
> > > > +     The online health tests validate the noise source at
> > > > +     runtime for fatal errors. These tests include SP800-90B
> > > > +     compliant tests which are invoked if the system is booted
> > > > +     with fips=3D1. In case of fatal errors during active
> > > > +     SP800-90B tests, the issue is logged and the noise
> > > > +     data is discarded. These tests are required for full
> > > > +     compliance with SP800-90B.
> > >=20
> > > How have you tested that these tests work at runtime? Maybe add some
> > > code under a new CONFIG item that depends on CONFIG_BROKEN that
> > > deliberately botches the RNG and triggers failures?
> >=20
> > I am unable to find sensible information about CONFIG_BROKEN in the rec=
ent
> > kernel tree.
> >=20
> > Do you happen to have a pointer on how that option is to be used?
>=20
> This option is not used on its own. You create a new option,
> CONFIG_TEST_LRNG_FAILURE_MODE or something like that, and put your
> code under the ifdef guarded by that option. And then, to prevent
> ordinary users and allyesconfig from selecting it, in Kconfig you say:
> "depends on BROKEN". This way, the option becomes unselectable in
> menuconfig but still works as intended when added manually to .config
> (obviously, with the BROKEN dependency removed locally).
>=20
> Definition:
> https://github.com/torvalds/linux/blob/9c7db5004280767566e91a33445bf93aa4=
79
> ef02/init/Kconfig#L68 Example usage:
> https://github.com/torvalds/linux/blob/c87237110f2553b4200a8b3401a01198ed=
fc
> f0d9/drivers/gpu/drm/i915/Kconfig.debug#L166

I added such support to the LRNG.

Thank you for your suggestion.
>=20
> --
> Alexander E. Patrakov


Ciao
Stephan


