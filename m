Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE0B5136882
	for <lists+linux-api@lfdr.de>; Fri, 10 Jan 2020 08:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgAJHtb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Jan 2020 02:49:31 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:12443 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgAJHtb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Jan 2020 02:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578642569;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=pcvtRMbzQeKjX8VK6T3YxfN1eTZUyf6gjoO45RlPAAM=;
        b=EdWDeVOX03zzqym/0sFGoCil9l2pndZrWbjVoeH7qBAuM6kxu5sY7MZ8Y56saZ8asP
        dBCcFjSKd5n0xTGx9XF6y0eudjkDUk+4jpPh+exGVUAW/KdKTR+2hu3avK3BfvjPrMxP
        YBGVxKsQjhn2asqgm0JDQ27R9F9CcZDy6v7HRSZ+Hf3ZCnDWqKPMd5AgCUvkWJDY7O0i
        RjiSQoGLam+9a83iIFu/9bYfcWeTXIJLCh8pqt3dHk0bj7Ft9zbucLG9F/3SFQ5nzmYU
        lhTKPYDCgl2aWdS5NeqIBE+Y4hQSaXwsOzRhllZMTnIblHtGR25a6ZhEQ2uZgiEKDSXR
        fSkQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJPScHivh"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0A7mN7ic
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 10 Jan 2020 08:48:23 +0100 (CET)
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
Subject: Re: [PATCH v27 12/12] LRNG - add power-on and runtime self-tests
Date:   Fri, 10 Jan 2020 08:48:22 +0100
Message-ID: <4114256.cnP6sY5xnJ@tauon.chronox.de>
In-Reply-To: <2f225250-c1e1-c6e1-026c-9c63853ab7d1@infradead.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2355906.JbblJTOqSk@positron.chronox.de> <2f225250-c1e1-c6e1-026c-9c63853ab7d1@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Freitag, 10. Januar 2020, 01:22:51 CET schrieb Randy Dunlap:

Hi Randy,

> Hi,
>=20
> On 1/9/20 12:35 AM, Stephan M=FCller wrote:
> > ---
> >=20
> >  drivers/char/lrng/Kconfig         |  25 ++
> >  drivers/char/lrng/Makefile        |   1 +
> >  drivers/char/lrng/lrng_selftest.c | 418 ++++++++++++++++++++++++++++++
> >  3 files changed, 444 insertions(+)
> >  create mode 100644 drivers/char/lrng/lrng_selftest.c
> >=20
> > diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
> > index 394066aa5a86..e9827e7df715 100644
> > --- a/drivers/char/lrng/Kconfig
> > +++ b/drivers/char/lrng/Kconfig
> > @@ -175,4 +175,29 @@ config LRNG_TESTING
> >=20
> >  	  If unsure, say N.
> >=20
> > +config LRNG_SELFTEST
> > +	bool "Enable power-on and on-demand self-tests"
> > +	help
> > +	  The power-on self tests are executed during boot time
>=20
> 	               self-tests

=46ixed in all occurrences. Thank you.
>=20
> > +	  covering the ChaCha20 DRNG, the LFSR processing and the
> > +	  time stamp management of the LRNG.
> > +
> > +	  The on-demand self-tests are triggered by writing any
> > +	  value into the SysFS file selftest_status. At the same
> > +	  time, when reading this file, the test status is
> > +	  returned. A zero indicates that all tests were executed
> > +	  successfully.
> > +
> > +	  If unsure, say Y.
> > +
> > +if LRNG_SELFTEST
> > +
> > +config LRNG_SELFTEST_PANIC
> > +	bool "Panic the kernel upon self-test failure"
> > +	help
> > +	  If the option is enabled, the kernel is terminated if an
> > +	  LRNG power-on self-test failure is detected.
> > +
> > +endif # LRNG_SELFTEST
> > +
> >=20
> >  endif # LRNG



Ciao
Stephan


