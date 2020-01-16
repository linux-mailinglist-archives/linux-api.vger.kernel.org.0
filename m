Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C353613D4EB
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 08:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgAPHX2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 02:23:28 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.121]:32239 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgAPHX2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 02:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579159403;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=DLlSXgCpG03ghP7KKNwatqK2l3dHS0GX4ZWE+B3ebDc=;
        b=fYoEA8AOfDd3KlcIkmE4flgWN0SQByr0k1EB9n0CD2ous9nQviN4Yp7wVCgLHoQY4N
        nvAMfruV6GhgJMXM5MeirjY1D5gVSttnDcz9sptWtgDUODo0j1TZLw5c1PxtKnwynNV7
        kXoEaAs+y7b4+HXIKrZOhE/j3B3FpHzkA3N+6dq7eeUMB5i+dT1ivFnLjTty+Z/CBIop
        cCchv7WSxYzDuksvTUKYcY32/jyjilr+CpgGwWLh/lh5ZHlM7uMtCh2sFZD9rX14PiMU
        LbXPVvjbDO44Pmd/NxikFuj8Og6f0M1pt/28esmKHAmEY12CQpTQro+0Hwo14U3sS/ro
        8Y6Q==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0G7M5aJH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 16 Jan 2020 08:22:05 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
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
        Neil Horman <nhorman@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v28 01/12] Linux Random Number Generator
Date:   Thu, 16 Jan 2020 08:22:05 +0100
Message-ID: <5851701.o564lLvvJa@tauon.chronox.de>
In-Reply-To: <3a8d5d2d-d54f-cf18-0c93-dbe8cd91ed12@infradead.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2211028.KG5F5qfgHC@positron.chronox.de> <3a8d5d2d-d54f-cf18-0c93-dbe8cd91ed12@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Donnerstag, 16. Januar 2020, 01:11:40 CET schrieb Randy Dunlap:

Hi Randy,

> Hi,
>=20
> On 1/15/20 2:31 AM, Stephan M=C3=BCller wrote:
> > CC: "Eric W. Biederman" <ebiederm@xmission.com>
> > CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> > CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> > CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> > CC: Willy Tarreau <w@1wt.eu>
> > CC: Matthew Garrett <mjg59@srcf.ucam.org>
> > CC: Vito Caputo <vcaputo@pengaru.com>
> > CC: Andreas Dilger <adilger.kernel@dilger.ca>
> > CC: Jan Kara <jack@suse.cz>
> > CC: Ray Strode <rstrode@redhat.com>
> > CC: William Jon McCann <mccann@jhu.edu>
> > CC: zhangjs <zachary@baishancloud.com>
> > CC: Andy Lutomirski <luto@kernel.org>
> > CC: Florian Weimer <fweimer@redhat.com>
> > CC: Lennart Poettering <mzxreary@0pointer.de>
> > CC: Nicolai Stange <nstange@suse.de>
> > Mathematical aspects Reviewed-by: "Peter, Matthias"
> > <matthias.peter@bsi.bund.de> Reviewed-by: Marcelo Henrique Cerri
> > <marcelo.cerri@canonical.com>
> > Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> > Tested-by: Roman Drahtm=C3=BCller <draht@schaltsekun.de>
> > Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > Tested-by: Neil Horman <nhorman@redhat.com>
> > Signed-off-by: Stephan Mueller <smueller@chronox.de>
> > ---
> >=20
> >  MAINTAINERS                         |   7 +
> >  drivers/char/Kconfig                |   2 +
> >  drivers/char/Makefile               |   9 +-
> >  drivers/char/lrng/Kconfig           |  67 +++
> >  drivers/char/lrng/Makefile          |   9 +
> >  drivers/char/lrng/lrng_archrandom.c |  94 ++++
> >  drivers/char/lrng/lrng_aux.c        | 148 +++++++
> >  drivers/char/lrng/lrng_chacha20.c   | 265 ++++++++++++
> >  drivers/char/lrng/lrng_chacha20.h   |  25 ++
> >  drivers/char/lrng/lrng_drng.c       | 400 +++++++++++++++++
> >  drivers/char/lrng/lrng_interfaces.c | 638 ++++++++++++++++++++++++++++
> >  drivers/char/lrng/lrng_internal.h   | 296 +++++++++++++
> >  drivers/char/lrng/lrng_lfsr.h       | 152 +++++++
> >  drivers/char/lrng/lrng_pool.c       | 588 +++++++++++++++++++++++++
> >  drivers/char/lrng/lrng_sw_noise.c   | 102 +++++
> >  drivers/char/lrng/lrng_sw_noise.h   |  57 +++
> >  include/linux/lrng.h                |  63 +++
> >  17 files changed, 2921 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/char/lrng/Kconfig
> >  create mode 100644 drivers/char/lrng/Makefile
> >  create mode 100644 drivers/char/lrng/lrng_archrandom.c
> >  create mode 100644 drivers/char/lrng/lrng_aux.c
> >  create mode 100644 drivers/char/lrng/lrng_chacha20.c
> >  create mode 100644 drivers/char/lrng/lrng_chacha20.h
> >  create mode 100644 drivers/char/lrng/lrng_drng.c
> >  create mode 100644 drivers/char/lrng/lrng_interfaces.c
> >  create mode 100644 drivers/char/lrng/lrng_internal.h
> >  create mode 100644 drivers/char/lrng/lrng_lfsr.h
> >  create mode 100644 drivers/char/lrng/lrng_pool.c
> >  create mode 100644 drivers/char/lrng/lrng_sw_noise.c
> >  create mode 100644 drivers/char/lrng/lrng_sw_noise.h
> >  create mode 100644 include/linux/lrng.h
> >=20
> > diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> > new file mode 100644
> > index 000000000000..56f13efd3592
> > --- /dev/null
> > +++ b/drivers/char/lrng/Kconfig
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Linux Random Number Generator configuration
> > +#
> > +
> > +menuconfig LRNG
> > +	bool "Linux Random Number Generator"
>=20
> This should probably depend on CRYPTO and/or some other CRYPTO_xxx symbol=
s.
> Or (worst case) select them.  :(

It does not - all CRYPTO related code is limited into the lrng_drbg.c,=20
lrng_kcapi.c and lrng_jent.c which are all guarded by a Kconfig option.
>=20
> This message (when CONFIG_CRYPTO is disabled and no crypto facilities are
> enabled) should be avoidable when the correct Kconfig entries are used:
>=20
> ../drivers/char/lrng/lrng_drbg.c:38:2: error: #error "Unknown DRBG in use"
>  #error "Unknown DRBG in use"

Right - this should now be fixed with a depends on CRYPTO for the=20
aforementioned 3 C files which have an equal entry in Kconfig.
>=20
> > +	help
> > +	  The Linux Random Number Generator (LRNG) is the replacement
> > +	  of the existing /dev/random provided with drivers/char/random.c.
> > +	  It generates entropy from different noise sources and
> > +	  delivers significant entropy during boot.
> > +
> > +if LRNG
> > +
> > +choice
> > +	prompt "LRNG Entropy Pool Size"
> > +	default LRNG_POOL_SIZE_4096
> > +	help
> > +	  Select the size of the LRNG entropy pool. The size of the
> > +	  entropy pool is relevant for the amount of entropy that
> > +	  the LRNG can maintain as a maximum. The larger the size
> > +	  of the entropy pool is the more entropy can be maintained
> > +	  but the less often older entropic values are overwritten
> > +	  with new entropy.
> > +
> > +	config LRNG_POOL_SIZE_512
> > +		bool "512 bits"
> > +
> > +	config LRNG_POOL_SIZE_1024
> > +		bool "1024 bits"
> > +
> > +	config LRNG_POOL_SIZE_2048
> > +		bool "2048 bits"
> > +
> > +	config LRNG_POOL_SIZE_4096
> > +		bool "4096 bits (default)"
> > +
> > +	config LRNG_POOL_SIZE_8192
> > +		bool "8192 bits"
> > +
> > +	config LRNG_POOL_SIZE_16384
> > +		bool "16384 bits"
> > +
> > +	config LRNG_POOL_SIZE_32768
> > +		bool "32768 bits"
> > +
> > +	config LRNG_POOL_SIZE_65536
> > +		bool "65536 bits"
> > +
> > +	config LRNG_POOL_SIZE_131072
> > +		bool "131072 bits"
> > +endchoice
> > +
> > +config LRNG_POOL_SIZE
> > +	int
> > +	default 0 if LRNG_POOL_SIZE_512
> > +	default 1 if LRNG_POOL_SIZE_1024
> > +	default 2 if LRNG_POOL_SIZE_2048
> > +	default 3 if LRNG_POOL_SIZE_4096
> > +	default 4 if LRNG_POOL_SIZE_8192
> > +	default 5 if LRNG_POOL_SIZE_16384
> > +	default 6 if LRNG_POOL_SIZE_32768
> > +	default 7 if LRNG_POOL_SIZE_65536
> > +	default 8 if LRNG_POOL_SIZE_131072
> > +
> > +endif # LRNG
> >=20
> > diff --git a/drivers/char/lrng/lrng_archrandom.c
> > b/drivers/char/lrng/lrng_archrandom.c new file mode 100644
> > index 000000000000..eeba708d025f
> > --- /dev/null
> > +++ b/drivers/char/lrng/lrng_archrandom.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/*
> > + * LRNG Fast Noise Source: CPU-based noise source
> > + *
> > + * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/random.h>
> > +
> > +#include "lrng_internal.h"
> > +
> > +/*
> > + * Estimated entropy of data is a 32th of
> > LRNG_DRNG_SECURITY_STRENGTH_BITS. + * As we have no ability to review t=
he
> > implementation of those noise sources, + * it is prudent to have a
> > conservative estimate here.
> > + */
> > +#define LRNG_ARCHRANDOM_DEFAULT_STRENGTH
> > (LRNG_DRNG_SECURITY_STRENGTH_BITS>>5) +#define
> > LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH LRNG_DRNG_SECURITY_STRENGTH_BITS
> > +#ifdef CONFIG_RANDOM_TRUST_CPU
> > +static u32 archrandom =3D LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH;
> > +#else
> > +static u32 archrandom =3D LRNG_ARCHRANDOM_DEFAULT_STRENGTH;
> > +#endif
> > +module_param(archrandom, uint, 0644);
> > +MODULE_PARM_DESC(archrandom, "Entropy in bits of 256 data bits from CPU
> > noise " +			     "source (e.g. RDRAND)");
>=20
> Please put the string on one line like several other MODULE_PARM_DESC() a=
re
> done:
>=20
> +MODULE_PARM_DESC(archrandom,
> +		"Entropy in bits of 256 data bits from CPU noise source (e.g.=20
RDRAND)");

Done.
>=20
>=20
> With CONFIG_CRYPTO disabled, these warnings happen:
>=20
> WARNING: unmet direct dependencies detected for CRYPTO_DRBG_MENU
>   Depends on [n]: CRYPTO [=3Dn]
>   Selected by [m]:
>   - LRNG_DRBG [=3Dm] && LRNG [=3Dy] && LRNG_DRNG_SWITCH [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for CRYPTO_RNG
>   Depends on [n]: CRYPTO [=3Dn]
>   Selected by [m]:
>   - LRNG_KCAPI [=3Dm] && LRNG [=3Dy] && LRNG_DRNG_SWITCH [=3Dy]
>=20
> ../drivers/char/lrng/lrng_drbg.c: In function =E2=80=98lrng_hash_name=E2=
=80=99:
> ../drivers/char/lrng/lrng_drbg.c:225:1: warning: control reaches end of
> non-void function [-Wreturn-type] }
>  ^
> ../drivers/char/lrng/lrng_drbg.c: In function =E2=80=98lrng_drbg_name=E2=
=80=99:
> ../drivers/char/lrng/lrng_drbg.c:220:1: warning: control reaches end of
> non-void function [-Wreturn-type] }
>  ^
>=20
> and build errors happen also, which can be prevented with Kconfig fixes.

With the changes to the Kconfig file as explained in the other emails, I ca=
n=20
successfully compile the LRNG without the crypto API being enabled.

Thank you for pointing that one out.

Ciao
Stephan


