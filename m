Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 689751385CC
	for <lists+linux-api@lfdr.de>; Sun, 12 Jan 2020 11:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgALKVP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 12 Jan 2020 05:21:15 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.168]:11364 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732559AbgALKVP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 12 Jan 2020 05:21:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1578824470;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=spDiSF2kVe66KeNhBEUZtkVMiNeZ0VQUQ1+8pDQUBF0=;
        b=PAtKzfwMGJgAKz1akesGIDjKheUMH9ElOBDykgcOdY1ntnYZobk5o1XAOpZcuxGD/l
        r4DdQ4D+8llM7kzKowjqEor6czaMBn6u5+O/+MRcGJTl4AgYQwQ1+dec0Z5M5k09iLnU
        Gt17Kfd/uQg8+7viRgHh55mijK2KpqtUlk9uO51ZeQbuakHAaUO1X4c5cNsdAU9CYIDO
        H/MKxrIZ+PAJg5cN33EP0kbOKOop1FpNbrT/5fxMbNbWF8cHD8RtrWiB+AzMIHtOtobi
        MtExUzRvFI5Mx3IB5xOuIhAqIBlH/cHBv8mOFVtjhtJrsE1htAcE5NB0uuEd++152xNz
        VvfA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zXABM8C3w2hSri9QCQ=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.1.4 DYNA|AUTH)
        with ESMTPSA id u04585w0CAJlFOm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 12 Jan 2020 11:19:47 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v27 04/12] LRNG - add switchable DRNG support
Date:   Sun, 12 Jan 2020 11:12:49 +0100
Message-ID: <6344127.aaDc98gsnP@positron.chronox.de>
In-Reply-To: <202001111540.5y2emdGQ%lkp@intel.com>
References: <5087131.2PHHu6SUIE@positron.chronox.de> <202001111540.5y2emdGQ%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Samstag, 11. Januar 2020, 08:09:50 CET schrieb kbuild test robot:

Hi,

> Hi "Stephan,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on char-misc/char-misc-testing]
> [also build test WARNING on cryptodev/master crypto/master v5.5-rc5
> next-20200110] [if your patch is applied to the wrong git tree, please dr=
op
> us a note to help improve the system. BTW, we also suggest to use '--base'
> option to specify the base tree in git format-patch, please see
> https://stackoverflow.com/a/37406982]
>=20
> url:  =20
> https://github.com/0day-ci/linux/commits/Stephan-M-ller/dev-random-a-new-=
ap
> proach-with-full-SP800-90B/20200110-084934 base: =20
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> 68faa679b8be1a74e6663c21c3a9d25d32f1c079 reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-129-g341daf20-dirty
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D'-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
> >> drivers/char/lrng/lrng_internal.h:239:39: sparse: sparse: context
> >> imbalance in 'lrng_drng_switch' - unexpected unlock
> vim +/lrng_drng_switch +239 drivers/char/lrng/lrng_internal.h
>=20
> 58c283819a1e87 Stephan M=FCller 2020-01-09  233
> 58c283819a1e87 Stephan M=FCller 2020-01-09  234  /* Unlock the DRNG */
> 58c283819a1e87 Stephan M=FCller 2020-01-09  235  static __always_inline v=
oid
> lrng_drng_unlock(struct lrng_drng *drng, 58c283819a1e87 Stephan M=FCller
> 2020-01-09  236  					     unsigned long *flags)=20
58c283819a1e87 Stephan
> M=FCller 2020-01-09  237  {
> 58c283819a1e87 Stephan M=FCller 2020-01-09  238  	if
> (lrng_drng_is_atomic(drng)) 58c283819a1e87 Stephan M=FCller 2020-01-09 @2=
39=20
> 		spin_unlock_irqrestore(&drng->spin_lock, *flags); 58c283819a1e87=20
Stephan
> M=FCller 2020-01-09  240  	else
> 58c283819a1e87 Stephan M=FCller 2020-01-09  241  		mutex_unlock(&drng-
>lock);
> 58c283819a1e87 Stephan M=FCller 2020-01-09  242  }
> 58c283819a1e87 Stephan M=FCller 2020-01-09  243
>=20
> :::::: The code at line 239 was first introduced by commit
> :::::: 58c283819a1e879bc2e30d05720285f9709f7f6d Linux Random Number
> :::::: Generator
> ::::::=20
> :::::: TO: Stephan M=FCller <smueller@chronox.de>
> :::::: CC: 0day robot <lkp@intel.com>
>=20
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology
> Center https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel
> Corporation

After analyzing the issue a bit more, it seems that I have to remove=20
"unlikely" from lrng_drng_lock which seems to cause additional grief
with sparse. Note, sparse will still report a lock context imbalance as it
used to since we indeed have two lock context as documented in
lrng_drng_switch.

Ciao
Stephan


