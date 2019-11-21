Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425D0105484
	for <lists+linux-api@lfdr.de>; Thu, 21 Nov 2019 15:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfKUOeS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Nov 2019 09:34:18 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:30853 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKUOeR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Nov 2019 09:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574346854;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Yl6b1XocvbNBBV5va8Fp1G9fFRDxgKp69B9+DRVJum4=;
        b=l7KSGaVGgBiyQCRwDp57o4Fs6Ru2xZyeLbLbQ6c1A/ra3kUlXfgmZ8ek4C0tnzbkMv
        uStry7xg9pmn9RvaRWeh7scRg4LA/04ThH2iWc6sZuBc9fVld1BeOIXg3Jf4qmDlkNYl
        P7rKaubg+iu4Vi/djrRpj1EZMENokjCvB3txBks65jSaNMmEKgVXDc0t0TotgDsSHUy6
        KgmwVjIR44MA4CK8PPJPMG/l/xbGTFCHbeXlDXT4xrO5TDREz1xt7ARpZTcBa1gQxJOZ
        gVRvRjPVOFqwWX0s4T0Wdrc1+jdgiP5QeYcRLVsxjUaeZDCiJ4QKdgnLZCguGqYinD+o
        KwRQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXPSIvSWlTs="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vALEX0s0c
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 21 Nov 2019 15:33:00 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Neil Horman <nhorman@redhat.com>
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
        Roman Drahtmueller <draht@schaltsekun.de>
Subject: Re: [PATCH v25 09/12] LRNG - add Jitter RNG fast noise source
Date:   Thu, 21 Nov 2019 15:33:07 +0100
Message-ID: <30355739.zM4EfPKdZ4@tauon.chronox.de>
In-Reply-To: <20191121141930.GB27405@hmswarspite.think-freely.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <1844272.AK0ElEJLVa@positron.chronox.de> <20191121141930.GB27405@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Donnerstag, 21. November 2019, 15:19:30 CET schrieb Neil Horman:

Hi Neil,

> On Wed, Nov 20, 2019 at 09:07:13PM +0100, Stephan M=FCller wrote:
> > Am Mittwoch, 20. November 2019, 14:33:03 CET schrieb Neil Horman:
> >=20
> > Hi Neil,
> >=20
> > > On Sat, Nov 16, 2019 at 10:36:52AM +0100, Stephan M=FCller wrote:
> > > > The Jitter RNG fast noise source implemented as part of the kernel
> > > > crypto API is queried for 256 bits of entropy at the time the seed
> > > > buffer managed by the LRNG is about to be filled.
> > > >=20
> > > > CC: "Eric W. Biederman" <ebiederm@xmission.com>
> > > > CC: "Alexander E. Patrakov" <patrakov@gmail.com>
> > > > CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
> > > > CC: "Theodore Y. Ts'o" <tytso@mit.edu>
> > > > CC: Willy Tarreau <w@1wt.eu>
> > > > CC: Matthew Garrett <mjg59@srcf.ucam.org>
> > > > CC: Vito Caputo <vcaputo@pengaru.com>
> > > > CC: Andreas Dilger <adilger.kernel@dilger.ca>
> > > > CC: Jan Kara <jack@suse.cz>
> > > > CC: Ray Strode <rstrode@redhat.com>
> > > > CC: William Jon McCann <mccann@jhu.edu>
> > > > CC: zhangjs <zachary@baishancloud.com>
> > > > CC: Andy Lutomirski <luto@kernel.org>
> > > > CC: Florian Weimer <fweimer@redhat.com>
> > > > CC: Lennart Poettering <mzxreary@0pointer.de>
> > > > CC: Nicolai Stange <nstange@suse.de>
> > > > Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > > > Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> > > > Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
> > > > Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > > > Tested-by: Neil Horman <nhorman@redhat.com>
> > > > Signed-off-by: Stephan Mueller <smueller@chronox.de>
> > > > ---
> > > >=20
> > > >  drivers/char/lrng/Kconfig     | 11 +++++
> > > >  drivers/char/lrng/Makefile    |  1 +
> > > >  drivers/char/lrng/lrng_jent.c | 88
> > > >  +++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 100 insertions(+)
> > > >  create mode 100644 drivers/char/lrng/lrng_jent.c
> > > >=20
> > > > diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> > > > index 03e6e2ec356b..80fc723c67d2 100644
> > > > --- a/drivers/char/lrng/Kconfig
> > > > +++ b/drivers/char/lrng/Kconfig
> > > > @@ -80,4 +80,15 @@ config LRNG_KCAPI
> > > >=20
> > > >  	  provided by the selected kernel crypto API RNG.
> > > > =20
> > > >  endif # LRNG_DRNG_SWITCH
> > > >=20
> > > > +config LRNG_JENT
> > > > +	bool "Enable Jitter RNG as LRNG Seed Source"
> > > > +	select CRYPTO_JITTERENTROPY
> > > > +	help
> > > > +	  The Linux RNG may use the Jitter RNG as noise source.=20
Enabling
> > > > +	  this option enables the use of the Jitter RNG. Its default
> > > > +	  entropy level is 16 bits of entropy per 256 data bits=20
delivered
> > > > +	  by the Jitter RNG. This entropy level can be changed at=20
boot
> > > > +	  time or at runtime with the lrng_base.jitterrng=20
configuration
> > > > +	  variable.
> > > > +
> > > >=20
> > > >  endif # LRNG
> > > >=20
> > > > diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
> > > > index 027b6ea51c20..a87d800c9aae 100644
> > > > --- a/drivers/char/lrng/Makefile
> > > > +++ b/drivers/char/lrng/Makefile
> > > > @@ -13,3 +13,4 @@ obj-$(CONFIG_SYSCTL)		+=3D lrng_proc.o
> > > >=20
> > > >  obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
> > > >  obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
> > > >  obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
> > > >=20
> > > > +obj-$(CONFIG_LRNG_JENT)		+=3D lrng_jent.o
> > > > diff --git a/drivers/char/lrng/lrng_jent.c
> > > > b/drivers/char/lrng/lrng_jent.c
> > > > new file mode 100644
> > > > index 000000000000..43114a44b8f5
> > > > --- /dev/null
> > > > +++ b/drivers/char/lrng/lrng_jent.c
> > > > @@ -0,0 +1,88 @@
> > > > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > > > +/*
> > > > + * LRNG Fast Noise Source: Jitter RNG
> > > > + *
> > > > + * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
> > > > + */
> > > > +
> > > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > > +
> > > > +#include "lrng_internal.h"
> > > > +
> > > > +/*
> > > > + * Estimated entropy of data is a 16th of
> > > > LRNG_DRNG_SECURITY_STRENGTH_BITS. + * Albeit a full entropy assessm=
ent
> > > > is
> > > > provided for the noise source indicating + * that it provides high
> > > > entropy rates and considering that it deactivates + * when it detec=
ts
> > > > insufficient hardware, the chosen under estimation of + * entropy is
> > > > considered to be acceptable to all reviewers.
> > > > + */
> > > > +static u32 jitterrng =3D LRNG_DRNG_SECURITY_STRENGTH_BITS>>4;
> > > > +module_param(jitterrng, uint, 0644);
> > > > +MODULE_PARM_DESC(jitterrng, "Entropy in bits of 256 data bits from
> > > > Jitter
> > > > " +			    "RNG noise source");
> > > > +
> > > > +/**
> > > > + * Get Jitter RNG entropy
> > > > + *
> > > > + * @outbuf buffer to store entropy
> > > > + * @outbuflen length of buffer
> > > > + * @return > 0 on success where value provides the added entropy in
> > > > bits
> > > > + *	   0 if no fast source was available
> > > > + */
> > > > +struct rand_data;
> > > > +struct rand_data *jent_lrng_entropy_collector(void);
> > > > +int jent_read_entropy(struct rand_data *ec, unsigned char *data,
> > > > +		      unsigned int len);
> > > > +static struct rand_data *lrng_jent_state;
> > > > +
> > > > +u32 lrng_get_jent(u8 *outbuf, unsigned int outbuflen)
> > > > +{
> > > > +	int ret;
> > > > +	u32 ent_bits =3D jitterrng;
> > > > +	unsigned long flags;
> > > > +	static DEFINE_SPINLOCK(lrng_jent_lock);
> > > > +	static int lrng_jent_initialized =3D 0;
> > > > +
> > > > +	spin_lock_irqsave(&lrng_jent_lock, flags);
> > > > +
> > > > +	if (!ent_bits || (lrng_jent_initialized =3D=3D -1)) {
> > > > +		spin_unlock_irqrestore(&lrng_jent_lock, flags);
> > > > +		return 0;
> > > > +	}
> > > > +
> > >=20
> > > this works, but I think you can avoid the use of the spin lock on the
> > > read
> > > calls here.  If you assign a global pointer to the value of
> > > &lrng_jent_state on init, you can just take the spinlock on assignmen=
t,
> > > and
> > > assume its stable after that (which it should be given that its only
> > > ever
> > > going to point to a static data structure).
> >=20
> > It is correct that the lock protects the assignment of the data structu=
re.
> >=20
> > But the Jitter RNG itself is not multi-threaded. So, a form of
> > serialization is needed to also "read" data from the Jitter RNG using o=
ne
> > and the same state.
> >=20
> > Granted, there is a serialization in the current code as the
> > lrng_pool_trylock() is taken before the Jitter RNG is called by
> > lrng_fill_seed_buffer which effectively serializes all requests to also
> > the
> > Jitter RNG. But this is coincidence in this case. I would think, howeve=
r,
> > that this coincidence could easily lead to programming errors further
> > down the road when the spinlock is not present and that trylock() is
> > moved to some place else considering that this trylock() is meant to
> > protect reading the entropy pool and not the Jitter RNG.
> >=20
> > As the reading of the Jitter RNG is always performed in process context=
, I
> > think having this additional spin lock against possible programming err=
ors
> > should not lead to performance regressions.
> >=20
> > What do you think?
>=20
> I take your meaning that each random device needs protection, and yes, ea=
ch
> of the random devices (trng and sdrng) have their own locking.  But it al=
so
> appears to me that each of those random devices contains its own private
> copy of the entropy_buf (they're statically declared on the stack in
> lrng_trng_seed and _lrng_sdrng_seed), so while the additional locking
> doesn't necessecarily hurt, I'm struggling to see why the additional work
> is needed.

This lock around the Jitter RNG is needed if:

1) TRNG is not configured

2) NUMA is configured, and

3) we have more than one NUMA node.

In this case it is possible that the lrng_fill_seed_buf is called in parall=
el=20
by parallel executions of the secondary DRNG seeding operation on the=20
different NUMA nodes.

In this case it is possible that the one global Jitter RNG state is used to=
=20
request random numbers in parallel. This scenario requires the lock.

Thank you.

> If ever you have a situation in which multiple rngs want want
> to share an entropy buffer, yes, you would need that lock, or some other
> protection, but I don't see the need immediately.
>=20
> Neil
>=20
> > Thank you for your review!
> >=20
> > Ciao
> > Stephan



Ciao
Stephan


