Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3481113D4B6
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 07:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgAPGzL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 01:55:11 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.103]:23013 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgAPGzL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 01:55:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579157709;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=TuMGu6eCqVUYEoh3TD5lXbSvO6CM/wB9pqQh/ZoBuBY=;
        b=qf3BehJPpMWMEjAwpc96RMiqDWboEbHi5clMZpC1MST7Yg7oy0iKqTHNK1+9TZyGu/
        Hlq9sTs1Li8OBhaQfdEmXDl+zsKtgwHB3k0/g5UPxsWqw0lnt1GYcPtAIe6qIPL6mukG
        /q4KHUWWqOc1CTaclppIc44Q+NX/91zxdGoUh21ahTYFRfchJzQoip8QcOKMI37YbHMb
        m1tqcxd20sOGvC8YkaGD6ROPzIytEUOqD0+T1umh1MhgTEdFkdFl/qE8vDrtEt2sE3Qk
        1E3r06Yw4kYSdh75YysZ0/YWIkpN0eBsVqkD9kn/yd3zcXpcMnylJm7QSkEEh1SZCDgI
        qbUw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0G6s1aB2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 16 Jan 2020 07:54:01 +0100 (CET)
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
Subject: Re: [PATCH v28 07/12] LRNG - add kernel crypto API PRNG extension
Date:   Thu, 16 Jan 2020 07:54:00 +0100
Message-ID: <6088699.12EYreDE7o@tauon.chronox.de>
In-Reply-To: <d98e7a45-3d1b-8119-1ed0-87aea0f3c6f3@infradead.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <526421170.FD02tCEzJt@positron.chronox.de> <d98e7a45-3d1b-8119-1ed0-87aea0f3c6f3@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Donnerstag, 16. Januar 2020, 01:15:46 CET schrieb Randy Dunlap:

Hi Randy,

> On 1/15/20 2:34 AM, Stephan M=FCller wrote:
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
> > Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
> > Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
> > Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> > Tested-by: Neil Horman <nhorman@redhat.com>
> > Signed-off-by: Stephan Mueller <smueller@chronox.de>
> > ---
> >=20
> >  drivers/char/lrng/Kconfig      |  10 +
> >  drivers/char/lrng/Makefile     |   1 +
> >  drivers/char/lrng/lrng_kcapi.c | 327 +++++++++++++++++++++++++++++++++
> >  3 files changed, 338 insertions(+)
> >  create mode 100644 drivers/char/lrng/lrng_kcapi.c
> >=20
> > diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> > index 15fb623d9d1f..0d070a3897dd 100644
> > --- a/drivers/char/lrng/Kconfig
> > +++ b/drivers/char/lrng/Kconfig
> > @@ -80,6 +80,16 @@ config LRNG_DRBG
> >=20
> >  	  Enable the SP800-90A DRBG support for the LRNG. Once the
> >  	  module is loaded, output from /dev/random, /dev/urandom,
> >  	  getrandom(2), or get_random_bytes is provided by a DRBG.
> >=20
> > +
> > +config LRNG_KCAPI
> > +	tristate "Kernel Crypto API support for the LRNG"
> > +	select CRYPTO_RNG
>=20
> Don't select CRYPTO_RNG unless you know that CRYPTO is set/enabled.

I added "depends on CRYPTO"
>=20
> > +	help
> > +	  Enable the support for generic pseudo-random number
> > +	  generators offered by the kernel crypto API with the
> > +	  LRNG. Once the module is loaded, output from /dev/random,
> > +	  /dev/urandom, getrandom(2), or get_random_bytes is
> > +	  provided by the selected kernel crypto API RNG.
> >=20
> >  endif # LRNG_DRNG_SWITCH
> > =20
> >  endif # LRNG

Thank you.

Ciao
Stephan


