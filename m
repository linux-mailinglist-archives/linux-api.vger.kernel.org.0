Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32AB1D67AB
	for <lists+linux-api@lfdr.de>; Sun, 17 May 2020 13:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgEQLWG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 May 2020 07:22:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:43750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbgEQLWG (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 17 May 2020 07:22:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 96586AC53;
        Sun, 17 May 2020 11:22:07 +0000 (UTC)
Date:   Sun, 17 May 2020 21:21:56 +1000
From:   Aleksa Sarai <asarai@suse.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nwxvb3yzfbh4rrle"
Content-Disposition: inline
In-Reply-To: <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--nwxvb3yzfbh4rrle
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-05-17, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> Or... And that's more invasive but ultimately cleaner we v2 the whole
> thing so e.g. SECCOMP_IOCTL_NOTIF_RECV2, SECCOMP_IOCTL_NOTIF_SEND2, and
> embedd the size argument in the structs. Userspace sets the size
> argument, we use get_user() to get the size first and then
> copy_struct_from_user() to handle it cleanly based on that. A similar
> model as with sched (has other unrelated quirks because they messed up
> something too):
>=20
> static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_=
attr *attr)
> {
> 	u32 size;
> 	int ret;
>=20
> 	/* Zero the full structure, so that a short copy will be nice: */
> 	memset(attr, 0, sizeof(*attr));
>=20
> 	ret =3D get_user(size, &uattr->size);
> 	if (ret)
> 		return ret;
>=20
> 	/* ABI compatibility quirk: */
> 	if (!size)
> 		size =3D SCHED_ATTR_SIZE_VER0;
> 	if (size < SCHED_ATTR_SIZE_VER0 || size > PAGE_SIZE)
> 		goto err_size;
>=20
> 	ret =3D copy_struct_from_user(attr, sizeof(*attr), uattr, size);
> 	if (ret) {
> 		if (ret =3D=3D -E2BIG)
> 			goto err_size;
> 		return ret;
> 	}
>=20
> We're probably the biggest user of this right now and I'd be ok with
> that change. If it's a v2 than whatever. :)

I'm :+1: on a new version and switch to copy_struct_from_user(). I was a
little surprised when I found out that user_notif doesn't do it this
way a while ago (and although in theory it is userspace's fault, ideally
we could have an API that doesn't have built-in footguns).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--nwxvb3yzfbh4rrle
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEXzbGxhtUYBJKdfWmnhiqJn3bjbQFAl7BHlEACgkQnhiqJn3b
jbR9pRAAnO1r26da3EnqUIDsjxOHWMLuwpB3QN+k925fWG47jt706mzLU1duX8EG
V8hWXeSYIX8Fk+tWv7dbb6xl4uYF18wvZUX3EZFROQUZKiLqjQSSJUKs05IpdZwl
cvXwIvzMM3xv9qc8NHQoK8D0GQkbdem8Oaxd8n2VNHL2eYirDENb62xcr1vLjp2b
psvcpgXWoPKr8m8wyY3NZsXcbJwLg77qQDN+1jjHjnBLXhSVugnMbR1aXFtWsYh8
bAYFv7Rq0nv0+bqnyxKSL3lfgyuraZCz4ZF8NlyTnFIbUmtJrHEAF7ykT1wvfjXk
SP/gntWDRKm2QLLr8JnAPtrp1sXXEqRBLmltK8BRtc597YSG5jrz+Lwt4mwRbpf8
EvfLqeBXZNVEZSdS5Zvjl93ryCK9yyE9eiRdZPsKFuoUPmipXlp52WRp9ldCj9Rm
JF7P4qarU5MSWLNMb8V1LC6BSPUDd88EfbsA6OaQ/HSkVaV2ueNzyJRxIYChu/se
20gfe9+VR4nS4Iys0AL1pzeg18yKJdCNqR0rg+Iaj64gjANmEX6QiJwluaOcw8Dh
fl60XE5LZzOe5N2wy1vKaRkcAP/IMmm7OFGd97QWrG2bPoX/VDpDE59pTpkaHk2H
rhR+vla/f6OXERSCd0F4QWYIxcNSs9Um0STXyT7iQhWDpLM/IKY=
=Huyx
-----END PGP SIGNATURE-----

--nwxvb3yzfbh4rrle--
