Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F013D47D
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 07:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgAPGoq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 01:44:46 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.84]:19158 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAPGoq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 01:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579157083;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=UsvSHT+Frq805jA7Se9Q9c/wAlk9BYIYlR1+Hqd6k74=;
        b=lwBKeC3OK11AlDdc0lm8H7gOlHRbh9pdJfAmBJmFQ5LwOMQ+u6uJI1eIxDs6XhmpSl
        yVuQUNGBEjQy1cnqudk/csbZr0pgU0m0HYKLqqKAz8/ETRGG2yEoHbcXvVCD5ayVk6qH
        pAzLKh/pAaFgpV7XDaPNoPrVg6Li2lvxIKYOZPFWX8CZ0SEH+3LVeM8eydgzXBmzvJUU
        enMEp0YZN1C5oZ2vksmC1nETJdpyXpeu4RYuHZdgJNgWzeHOKqHV4ETuawNfs8h7L89X
        ZC86JatPqIX2uOg4+JkGTlF2Bc5tf3/MlXMSzFG0reGJICp5phTojCByFaJzLXmDwdPn
        A9aQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0G6hXa7Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 16 Jan 2020 07:43:33 +0100 (CET)
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
Subject: Re: [PATCH v28 11/12] LRNG - add interface for gathering of raw entropy
Date:   Thu, 16 Jan 2020 07:43:33 +0100
Message-ID: <9116265.6Va6cPe1zF@tauon.chronox.de>
In-Reply-To: <abde84fe-2599-0db8-2bad-d2ff29a3c4f0@infradead.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2048458.ADJAtTWDj8@positron.chronox.de> <abde84fe-2599-0db8-2bad-d2ff29a3c4f0@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Donnerstag, 16. Januar 2020, 01:18:18 CET schrieb Randy Dunlap:

Hi Randy,

> On 1/15/20 2:35 AM, Stephan M=FCller wrote:
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
> > Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> > Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
> > Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > Tested-by: Neil Horman <nhorman@redhat.com>
> > Signed-off-by: Stephan Mueller <smueller@chronox.de>
> > ---
> >=20
> >  drivers/char/lrng/Kconfig        |  16 ++
> >  drivers/char/lrng/Makefile       |   1 +
> >  drivers/char/lrng/lrng_testing.c | 271 +++++++++++++++++++++++++++++++
> >  3 files changed, 288 insertions(+)
> >  create mode 100644 drivers/char/lrng/lrng_testing.c
> >=20
> > diff --git a/drivers/char/lrng/lrng_testing.c
> > b/drivers/char/lrng/lrng_testing.c new file mode 100644
> > index 000000000000..0e287eccd622
> > --- /dev/null
> > +++ b/drivers/char/lrng/lrng_testing.c
> > @@ -0,0 +1,271 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/*
> > + * Linux Random Number Generator (LRNG) Raw entropy collection tool
> > + *
> > + * Copyright (C) 2019 - 2020, Stephan Mueller <smueller@chronox.de>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/atomic.h>
> > +#include <linux/bug.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/module.h>
> > +#include <linux/sched.h>
> > +#include <linux/sched/signal.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/workqueue.h>
> > +#include <asm/errno.h>
> > +
> > +#include "lrng_internal.h"
> > +
> > +#define LRNG_TESTING_RINGBUFFER_SIZE	1024
> > +#define LRNG_TESTING_RINGBUFFER_MASK	(LRNG_TESTING_RINGBUFFER_SIZE - 1)
> > +
> > +static u32 lrng_testing_rb[LRNG_TESTING_RINGBUFFER_SIZE];
> > +static u32 lrng_rb_reader =3D 0;
> > +static u32 lrng_rb_writer =3D 0;
> > +static atomic_t lrng_testing_enabled =3D ATOMIC_INIT(0);
> > +
> > +static DECLARE_WAIT_QUEUE_HEAD(lrng_raw_read_wait);
> > +static DEFINE_SPINLOCK(lrng_raw_lock);
> > +
> > +/*
> > + * 0 =3D=3D> No boot test, gathering of runtime data allowed
> > + * 1 =3D=3D> Boot test enabled and ready for collecting data, gathering
> > runtime + *	 data is disabled
> > + * 2 =3D=3D> Boot test completed and disabled, gathering of runtime da=
ta is
> > + *	 disabled
> > + */
> > +static u32 boot_test =3D 0;
> > +module_param(boot_test, uint, 0644);
> > +MODULE_PARM_DESC(boot_test, "Enable gathering boot time entropy of the
> > first" +			    " entropy events");
>=20
> One line for the string, please.

may I ask the question whether this should be done for all lines with print=
k=20
statements? As checkpatch.pl will complain if you have lines larger than 80=
=20
chars and complains about line-broken printk statements, I am always unsure=
=20
which way to go.

All printk statements in the patch series have line-broken printk statement=
s.

Ciao
Stephan


