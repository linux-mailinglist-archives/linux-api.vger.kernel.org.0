Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44B5D4ED8D
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFURGR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 13:06:17 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:51860 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFURGR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 13:06:17 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 28B4972CC6C;
        Fri, 21 Jun 2019 20:06:14 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 16D7C7CCE2E; Fri, 21 Jun 2019 20:06:14 +0300 (MSK)
Date:   Fri, 21 Jun 2019 20:06:14 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: make pidfd-metadata fail gracefully on older
 kernels
Message-ID: <20190621170613.GA26182@altlinux.org>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2019 at 01:10:37PM +0200, Christian Brauner wrote:
> On Thu, Jun 20, 2019 at 02:00:37PM +0300, Dmitry V. Levin wrote:
> > Cc'ed more people as the issue is not just with the example but
> > with the interface itself.
> >=20
> > On Thu, Jun 20, 2019 at 12:31:06PM +0200, Christian Brauner wrote:
> > > On Thu, Jun 20, 2019 at 06:11:44AM +0300, Dmitry V. Levin wrote:
> > > > Initialize pidfd to an invalid descriptor, to fail gracefully on
> > > > those kernels that do not implement CLONE_PIDFD and leave pidfd
> > > > unchanged.
> > > >=20
> > > > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> > > > ---
> > > >  samples/pidfd/pidfd-metadata.c | 8 ++++++--
> > > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-m=
etadata.c
> > > > index 14b454448429..ff109fdac3a5 100644
> > > > --- a/samples/pidfd/pidfd-metadata.c
> > > > +++ b/samples/pidfd/pidfd-metadata.c
> > > > @@ -83,7 +83,7 @@ static int pidfd_metadata_fd(pid_t pid, int pidfd)
> > > > =20
> > > >  int main(int argc, char *argv[])
> > > >  {
> > > > -	int pidfd =3D 0, ret =3D EXIT_FAILURE;
> > > > +	int pidfd =3D -1, ret =3D EXIT_FAILURE;
> > >=20
> > > Hm, that currently won't work since we added a check in fork.c for
> > > pidfd =3D=3D 0. If it isn't you'll get EINVAL.
> >=20
> > Sorry, I must've missed that check.  But this makes things even worse.
> >=20
> > > This was done to ensure that
> > > we can potentially extend CLONE_PIDFD by passing in flags through the
> > > return argument.
> > > However, I find this increasingly unlikely. Especially since the
> > > interface would be horrendous and an absolute last resort.
> > > If clone3() gets merged for 5.3 (currently in linux-next) we also have
> > > no real need anymore to extend legacy clone() this way. So either wait
> > > until (if) we merge clone3() where the check I mentioned is gone anyw=
ay,
> > > or remove the pidfd =3D=3D 0 check from fork.c in a preliminary patch.
> > > Thoughts?
> >=20
> > Userspace needs a reliable way to tell whether CLONE_PIDFD is supported
> > by the kernel or not.
>=20
> Right, that's the general problem with legacy clone(): it ignores
> unknown flags... clone3() will EINVAL you if you pass any flag it
> doesn't know about.
>=20
> For legacy clone you can pass
>=20
> (CLONE_PIDFD | CLONE_DETACHED)
>=20
> on all relevant kernels >=3D 2.6.2. CLONE_DETACHED will be silently
> ignored by the kernel if specified in flags. But if you specify both
> CLONE_PIDFD and CLONE_DETACHED on a kernel that does support CLONE_PIDFD
> you'll get EINVALed. (We did this because we wanted to have the ability
> to make CLONE_DETACHED reuseable with CLONE_PIDFD.)
> Does that help?

Yes, this is feasible, but the cost is extra syscall for new kernels
and more complicated userspace code, so...

> > If CLONE_PIDFD is not supported, then pidfd remains unchanged.
> >=20
> > If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd =
=3D=3D 0
> > also remains unchanged, which effectively means that userspace must ens=
ure
> > that fd 0 is not closed when invoking CLONE_PIDFD.  This is ugly.
> >=20
> > If we can assume that clone(CLONE_PIDFD) is not going to be extended,
> > then I'm for removing the pidfd =3D=3D 0 check along with recommending
> > userspace to initialize pidfd with -1.
>=20
> Right, I'm ok with that too.

=2E.. I'd prefer this variant.


--=20
ldv

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdDQ6FAAoJEAVFT+BVnCUIYXwQAIKbUhvT4Z2vjgR254TQyg7z
USsWogmcsXA9rUf2n1UYOw40Ekm263RDwe0EcR+5OExFPAl6cLoVCUeN12Uyzp1+
U0kKp8KEiMkPXscso2KOJorhBD8asyVtrSmk8STcfvpNJ4YpH/Y5MBGetRylmfU0
0s56mpXoN5khbF6pfm7LnCGu98GZUPuidwGZXPprnnXlMGdvHX/bDvDzzeE0A+u5
BqPGrJ7gt70Urzij7W/57i6KHMYwT5YQS+jxrZM3NlB8cHjI4LBRBMMT7s/KVaKn
SCUyCJyTuSL6/plT8i0gOQp9wfmUwaNVvBGcnwGl15qS7q/J0FXqtnmoz049JloB
dbuS3+ZV82umgmVj5zgfJyBkCXN5zFi5gkZ3yS/16+74Fin/8h/Ouv05YcNOKUDi
Zdb2i7r5LaHFcLGT82TLRp0jMsVkhSSs83idFo7BjNXYA84wP+HmmsBbitlFtUpA
MXvhLgfg0pw/Lj0vaAMRiqqad92NMHZGN8r342RH6DJqyBBJPL1P75HL4Aw1TqZz
48s8brt/dR79UN5i8f7KKBUulXVwimzX7WCs6v3whH1lvA4tI5WlqAwSFCjSTY9Z
h0Kpw4Huv6qL1oelIp9qiPdxcMllfnsxUtgNE4MY1uZvnh8a7H7YlXGPCTY5I4v3
lxdOqIClduB5NK+VMHdO
=S7AN
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
