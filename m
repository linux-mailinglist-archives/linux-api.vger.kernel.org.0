Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2650C3C
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2019 15:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfFXNpg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 24 Jun 2019 09:45:36 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57254 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfFXNpg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 24 Jun 2019 09:45:36 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 1294772CC58;
        Mon, 24 Jun 2019 16:45:32 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 088B57CCE32; Mon, 24 Jun 2019 16:45:31 +0300 (MSK)
Date:   Mon, 24 Jun 2019 16:45:31 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] CLONE_PIDFD: do not use the value pointed by
 parent_tidptr
Message-ID: <20190624134531.GB6010@altlinux.org>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
 <20190623112717.GA20697@altlinux.org>
 <20190624094940.24qrteybbcp25wq7@brauner.io>
 <20190624115942.g6vyis3zy4ptt3fc@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline
In-Reply-To: <20190624115942.g6vyis3zy4ptt3fc@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 01:59:43PM +0200, Christian Brauner wrote:
> On Mon, Jun 24, 2019 at 11:49:40AM +0200, Christian Brauner wrote:
> > On Sun, Jun 23, 2019 at 02:27:17PM +0300, Dmitry V. Levin wrote:
> > > Userspace needs a cheap and reliable way to tell whether CLONE_PIDFD
> > > is supported by the kernel or not.
> > >=20
> > > While older kernels without CLONE_PIDFD support just leave unchanged
> > > the value pointed by parent_tidptr, current implementation fails with
> > > EINVAL if that value is non-zero.
> > >=20
> > > If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd =
=3D=3D 0
> > > pointed by parent_tidptr also remains unchanged, which effectively
> > > means that userspace must either check CLONE_PIDFD support beforehand
> > > or ensure that fd 0 is not closed when invoking CLONE_PIDFD.
> > >=20
> > > The check for pidfd =3D=3D 0 was introduced during v5.2 release cycle
> > > by commit b3e583825266 ("clone: add CLONE_PIDFD") to ensure that
> > > CLONE_PIDFD could be potentially extended by passing in flags through
> > > the return argument.
> > >=20
> > > However, that extension would look horrendous, and with introduction =
of
> > > clone3 syscall in v5.3 there is no need to extend legacy clone syscall
> > > this way.
> > >=20
> > > So remove the pidfd =3D=3D 0 check.  Userspace that needs to be porta=
ble
> > > to kernels without CLONE_PIDFD support is advised to initialize pidfd
> > > with -1 and check the pidfd value returned by CLONE_PIDFD.
> > >=20
> > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> >=20
> > Reviewed-by: Christian Brauner <christian@brauner.io>
> >=20
> > Thank you Dmitry, queueing this up for rc7.
>=20
> This is now sitting in
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/=
?h=3Dfixes&id=3D43754d05f235dd1b6c7f8ab9f42007770d721f10
>=20
> I reformulated the commit message a bit and gave it a Fixes tag. Dmitry,
> if you want you can take a look and tell me if that's acceptable to you.

s/Old kernel that only support/Old kernels that only support/

Besides that, fine with me.  Thanks.


--=20
ldv

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdENP7AAoJEAVFT+BVnCUIrgIP/1sgLmygdF42/bB1S8h0pKru
c98crUZv9Ws1hDC3tW4+8ZxI9c2iV/qCiyZo3N4dkS06nWcJJbPR35ZlTCS4u8zd
OszHMNqeusLo5iU+lhmiOXGu45R9i3QEb+Egk4TAENeCOZCPOVPBrscM/smUSxAD
uZQtDuf73zq/9fs+2ePbZ15NE2o98/hYRHEkZx39mmOPhVwMSg3eI9m+mdi0M0Km
Yxor/sAPasFakCaUeNrayK9Rv7q+a3V5awO2PmQk8fOGi+67EDrAraGjPjAYTxtX
/IrTDNf6KbK2rBJWIKD9cHpQAXTGMkTbYQ9Gspki1QdTu7PUz8RLYM4hpHrULTq0
6VFAH95ccMH7XabUr+C54aZH8QAuXokf3w5heRWsVVa0NnjvBvJMIQA8GtUlZVSR
omYxd/PDdJiNG+UAB4yzqyliMQfhJSLdyYIN6MtoloRw+5BzQY78gXad3vVItyCA
GW1f3wufQ2xdv/irt6DMHtxbJfNLjIiWtUvmafI/iJcG9vJ0Ymkqg7mcxhEOi2P5
whk94r7dQ8gqsbQkcIMZmyZxhGn7776vPt6L/ZDZg1yenOKV8r4vm+ERqqrKAHrG
Avpm+9B6WUHhx35xJdV7/EDcOp8bwz2tXWhh7eemrw3j0ay1LW8us49A8UFlJ6/7
lwACNg07XV9tLqMqHjJ+
=bvRp
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
