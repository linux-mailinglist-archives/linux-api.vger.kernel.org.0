Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93083207268
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 13:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389075AbgFXLop (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 07:44:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:39432 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388844AbgFXLop (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Jun 2020 07:44:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 892C4AF63;
        Wed, 24 Jun 2020 11:44:42 +0000 (UTC)
Date:   Wed, 24 Jun 2020 13:44:37 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Serge Hallyn <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        systemd-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 2/3] nsproxy: attach to namespaces via pidfds
Message-ID: <20200624114437.GA117125@blackbook>
References: <20200505140432.181565-1-christian.brauner@ubuntu.com>
 <20200505140432.181565-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20200505140432.181565-3-christian.brauner@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

On Tue, May 05, 2020 at 04:04:31PM +0200, Christian Brauner <christian.brau=
ner@ubuntu.com> wrote:
> -SYSCALL_DEFINE2(setns, int, fd, int, nstype)
> +SYSCALL_DEFINE2(setns, int, fd, int, flags)
> [...]
> -	file =3D proc_ns_fget(fd);
> -	if (IS_ERR(file))
> -		return PTR_ERR(file);
> +	int err =3D 0;
> =20
> -	err =3D -EINVAL;
> -	ns =3D get_proc_ns(file_inode(file));
> -	if (nstype && (ns->ops->type !=3D nstype))
> +	file =3D fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	if (proc_ns_file(file)) {
> +		ns =3D get_proc_ns(file_inode(file));
> +		if (flags && (ns->ops->type !=3D flags))
> +			err =3D -EINVAL;
> +		flags =3D ns->ops->type;
> +	} else if (pidfd_pid(file)) {
> +		err =3D check_setns_flags(flags);
> +	} else {
> +		err =3D -EBADF;
> +	}
> +	if (err)
>  		goto out;
> =20
> -	err =3D prepare_nsset(ns->ops->type, &nsset);
> +	err =3D prepare_nsset(flags, &nsset);
>  	if (err)
>  		goto out;
This modification changed the returned error when a valid file
descriptor is passed but it doesn't represent a namespace (nor pidfd).
The error is now EBADF although originally and per man page it
was/should be EINVAL.

A change like below would restore it, however, I see it may be less
consistent with other pidfd calls(?), then I'd suggest updating the
manpage to capture this.

--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -531,7 +531,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
        } else if (!IS_ERR(pidfd_pid(file))) {
                err =3D check_setns_flags(flags);
        } else {
-               err =3D -EBADF;
+               err =3D -EINVAL;
        }
        if (err)
                goto out;

I noticed this breaks systemd self tests [1].

Regards,
Michal


[1] https://github.com/systemd/systemd/blob/a1ba8c5b71164665ccb53c9cec384e5=
eef7d3689/src/test/test-seccomp.c#L246

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl7zPKAACgkQia1+riC5
qShOGhAAhxWTA7xASA29DshSor6gE8MSsisAOLrbdcAJxcTpEjK7SGBfiIAzRSqM
ojDNJab5BA7AplrWQMI5dTvNC5OsdObhRe6HCzXeK/DL4st5WCHkGv084jGVtJkF
t3uUc5yphr7K7Wyv5pTydMDYbPgVdtMLCMAJCzSSAm464cXc7yFUtLiuJTx4dWMS
wj+dRMYjxqo8PMTo78lAOeo0Xga2sWunsc2RrvmCde1HAqEfX26xko2at3AhxJWI
mA1qK4gYl0/0kRBKKbVH/Vc9cE3hVTwAKgLxm9JUJJoV/7zs61XPfGZZ1i1NUBJ5
ES1ybt5h1C5rtmpBGiH1Dd+D7i1ckdqEPupwJNzYze5y2QiEVVoF7csegk30Vdq7
0SQ9SAXOtRmfQC8VQXkWDOoqZarxPSgktRBfMZ3h18neURCFlmU0xcAY52mJODSf
lyJPQmYUfCehLasPJJ3eUG9fhdSNuFH3Z6V2KfIjo2qKPbbEJONxb24OthyQzr6v
kt3B/m7aseGZCxRu21SkkRIMa9aIngbkaOOiEwUd66wJtHKWJIn/D7sdcQvUGYpg
e8J5uFPR7A0wJey2TZltEDF9nuuZarORd7BNREmm4nG1w3X3vsgUXXLfk9x8HQtg
EG/+7T4HFcQXgeR/UBieyk0FQ98KRnJaSK6RJiShfEM2HIyvrZU=
=zb4j
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
