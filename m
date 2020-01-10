Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6569A13687B
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 08:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgAJHqs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jan 2020 02:46:48 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:27982 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgAJHqs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jan 2020 02:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578642405;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=iGK7Pgzw6tKu2VK9x2Icryn9l1IuJ/TgQW4Aouj2aqc=;
        b=IEuAW6+2Q10mR3Gb6lYgkCOqpINUw9glVT/0aBTgxrOCWB4hMX4gzmOhDO19ebXC8+
        MKP8kVd/0aKIVjbwtM6grPp965sIxpVl5DHrmWQHGc0jON531pupkupZ7waVw289Yq9N
        5+lAddOiN1mhfmv6PVH5CniZHgTn5pve4LoYn+Q6rc2/Tp5xQRpt5BaGp9qqYL/hjL5e
        9boJ4BspX6MURO8P21C2GRVAqsKys8CBzWQImYgCx0EN3Ke4SfB0CdpUYJ7JVu1Y5NvC
        pHisfoXHoyl6Krtm6nRN5Yj2gsxE3MsLy7iTosB5a0OhU3OnhTeRM6GjDDvAOczN1mc2
        uQlA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0A7jN7hj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 10 Jan 2020 08:45:23 +0100 (CET)
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
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v27 09/12] LRNG - add Jitter RNG fast noise source
Date:   Fri, 10 Jan 2020 08:45:22 +0100
Message-ID: <3881936.EWlHz54Di6@tauon.chronox.de>
In-Reply-To: <0ba976fa-fed1-4720-c039-043160dbce9e@infradead.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <6341883.UacF4FzDma@positron.chronox.de> <0ba976fa-fed1-4720-c039-043160dbce9e@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Freitag, 10. Januar 2020, 01:24:47 CET schrieb Randy Dunlap:

Hi Randy,

> Hi,
>=20
> On 1/9/20 12:34 AM, Stephan M=FCller wrote:
> > ---
> >=20
> >  drivers/char/lrng/Kconfig     | 11 +++++
> >  drivers/char/lrng/Makefile    |  1 +
> >  drivers/char/lrng/lrng_jent.c | 87 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 99 insertions(+)
> >  create mode 100644 drivers/char/lrng/lrng_jent.c
> >=20
> > diff --git a/drivers/char/lrng/lrng_jent.c b/drivers/char/lrng/lrng_jen=
t.c
> > new file mode 100644
> > index 000000000000..97c0d192e9c8
> > --- /dev/null
> > +++ b/drivers/char/lrng/lrng_jent.c
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/*
> > + * LRNG Fast Noise Source: Jitter RNG
> > + *
> > + * Copyright (C) 2016 - 2020, Stephan Mueller <smueller@chronox.de>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/types.h>
> > +#include <crypto/internal/jitterentropy.h>
> > +
> > +#include "lrng_internal.h"
> > +
> > +/*
> > + * Estimated entropy of data is a 16th of
> > LRNG_DRNG_SECURITY_STRENGTH_BITS. + * Albeit a full entropy assessment =
is
> > provided for the noise source indicating + * that it provides high
> > entropy rates and considering that it deactivates + * when it detects
> > insufficient hardware, the chosen under estimation of + * entropy is
> > considered to be acceptable to all reviewers.
> > + */
> > +static u32 jitterrng =3D LRNG_DRNG_SECURITY_STRENGTH_BITS>>4;
> > +module_param(jitterrng, uint, 0644);
> > +MODULE_PARM_DESC(jitterrng, "Entropy in bits of 256 data bits from Jit=
ter
> > " +			    "RNG noise source");
> > +
> > +/**
> > + * Get Jitter RNG entropy
> > + *
> > + * @outbuf buffer to store entropy
> > + * @outbuflen length of buffer
> > + * @return > 0 on success where value provides the added entropy in bi=
ts
> > + *	   0 if no fast source was available
> > + */
>=20
> Don't begin the comment block with /**
> or convert it to Linux kernel-doc notation format.

Yes, the colons are missing and there is no @return. It will be fixed with =
the=20
next patch set.

Thank you.
>=20
> > +static struct rand_data *lrng_jent_state;
> > +
> > +u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen)
> > +{
> > +	int ret;
> > +	u32 ent_bits =3D jitterrng;
> > +	unsigned long flags;
> > +	static DEFINE_SPINLOCK(lrng_jent_lock);
> > +	static int lrng_jent_initialized =3D 0;
> > +
> > +	spin_lock_irqsave(&lrng_jent_lock, flags);
> > +
> > +	if (!ent_bits || (lrng_jent_initialized =3D=3D -1)) {
> > +		spin_unlock_irqrestore(&lrng_jent_lock, flags);
> > +		return 0;
> > +	}
> > +
> > +	if (!lrng_jent_initialized) {
> > +		lrng_jent_state =3D jent_lrng_entropy_collector();
> > +		if (!lrng_jent_state) {
> > +			jitterrng =3D 0;
> > +			lrng_jent_initialized =3D -1;
> > +			spin_unlock_irqrestore(&lrng_jent_lock, flags);
> > +			pr_info("Jitter RNG unusable on current system\n");
> > +			return 0;
> > +		}
> > +		lrng_jent_initialized =3D 1;
> > +		pr_debug("Jitter RNG working on current system\n");
> > +	}
> > +	ret =3D jent_read_entropy(lrng_jent_state, outbuf, outbuflen);
> > +	spin_unlock_irqrestore(&lrng_jent_lock, flags);
> > +
> > +	if (ret) {
> > +		pr_debug("Jitter RNG failed with %d\n", ret);
> > +		return 0;
> > +	}
> > +
> > +	/* Obtain entropy statement */
> > +	if (outbuflen !=3D LRNG_DRNG_SECURITY_STRENGTH_BYTES)
> > +		ent_bits =3D (ent_bits * outbuflen<<3) /
> > +			   LRNG_DRNG_SECURITY_STRENGTH_BITS;
> > +	/* Cap entropy to buffer size in bits */
> > +	ent_bits =3D min_t(u32, ent_bits, outbuflen<<3);
> > +	pr_debug("obtained %u bits of entropy from Jitter RNG noise source\n",
> > +		 ent_bits);
> > +
> > +	return ent_bits;
> > +}
> > +
> > +u32 lrng_jent_entropylevel(void)
> > +{
> > +	return min_t(u32, jitterrng, LRNG_DRNG_SECURITY_STRENGTH_BITS);
> > +}
>=20
> thanks.



Ciao
Stephan


