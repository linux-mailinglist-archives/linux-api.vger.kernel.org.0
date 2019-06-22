Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F176B4F78A
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfFVRwL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 22 Jun 2019 13:52:11 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:55265 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfFVRwL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 22 Jun 2019 13:52:11 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6BAF680689; Sat, 22 Jun 2019 19:51:58 +0200 (CEST)
Date:   Sat, 22 Jun 2019 19:52:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Josh Boyer <jwboyer@fedoraproject.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org, jikos@suse.cz
Subject: Re: [PATCH V34 10/29] hibernate: Disable when the kernel is locked
 down
Message-ID: <20190622175208.GB30317@amd>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-11-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qlTNgmc+xy1dBmNv"
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-11-matthewgarrett@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--qlTNgmc+xy1dBmNv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-06-21 17:03:39, Matthew Garrett wrote:
> From: Josh Boyer <jwboyer@fedoraproject.org>
>=20
> There is currently no way to verify the resume image when returning
> from hibernate.  This might compromise the signed modules trust model,
> so until we can work with signed hibernate images we disable it when the
> kernel is locked down.

I keep getting these...

IIRC suse has patches to verify the images.
								Pavel=20



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qlTNgmc+xy1dBmNv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0OasgACgkQMOfwapXb+vK4ZwCgroXTYUFxTOMmRgUE1WUOZBSW
BP8Ani8DLJP1nVX8/NMG2MEgT7nBMDtv
=9tFP
-----END PGP SIGNATURE-----

--qlTNgmc+xy1dBmNv--
