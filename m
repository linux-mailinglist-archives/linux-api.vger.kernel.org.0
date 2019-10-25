Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF9BE47CD
	for <lists+linux-api@lfdr.de>; Fri, 25 Oct 2019 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408360AbfJYJuL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Oct 2019 05:50:11 -0400
Received: from mout-p-102.mailbox.org ([80.241.56.152]:53530 "EHLO
        mout-p-102.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407918AbfJYJuL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 25 Oct 2019 05:50:11 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 46zzqj258lzKmZ4;
        Fri, 25 Oct 2019 11:50:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id TLtJwWbBoCxd; Fri, 25 Oct 2019 11:50:05 +0200 (CEST)
Date:   Fri, 25 Oct 2019 20:49:56 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: clone3() example code
Message-ID: <20191025094956.hvr44v2lbfxf7dfs@yavin.dot.cyphar.com>
References: <CAKgNAkgKX1Z6Uns3pAvXe-JMSmWqo2PrqeoS65aEriZsV35QmA@mail.gmail.com>
 <20191025084142.jpwypkyczehylhgv@wittgenstein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qfxueoggiia3z6jh"
Content-Disposition: inline
In-Reply-To: <20191025084142.jpwypkyczehylhgv@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--qfxueoggiia3z6jh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-10-25, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
>=20
> int main(int argc, char *argv[])
> {
> 	int pidfd =3D -1;
> 	pid_t parent_tid =3D -1, pid =3D -1;
> 	struct clone_args args =3D {0};
>=20
> 	args.parent_tid =3D ptr_to_u64(&parent_tid); /* CLONE_PARENT_SETTID */
> 	args.pidfd =3D ptr_to_u64(&pidfd); /* CLONE_PIDFD */
> 	args.flags =3D CLONE_PIDFD | CLONE_PARENT_SETTID;
> 	args.exit_signal =3D SIGCHLD;
>=20
> 	pid =3D sys_clone3(&args);

I'd suggest that

	struct clone_args args =3D {
		.flags =3D CLONE_PIDFD | CLONE_PARENT_SETTID,
		.parent_tid =3D ptr_to_u64(&parent_tid), /* CLONE_PARENT_SETTID */
		.pidfd =3D ptr_to_u64(&pidfd),           /* CLONE_PIDFD */
		.exit_signal =3D SIGCHLD,
	};

or alternatively

	pid =3D sys_clone3(&(struct clone_args) {
		.flags =3D CLONE_PIDFD | CLONE_PARENT_SETTID,
		.parent_tid =3D ptr_to_u64(&parent_tid), /* CLONE_PARENT_SETTID */
		.pidfd =3D ptr_to_u64(&pidfd),           /* CLONE_PIDFD */
		.exit_signal =3D SIGCHLD,
	});

are easier to read.

> 	if (pid < 0) {
> 		fprintf(stderr, "%s - Failed to create new process\n", strerror(errno));
> 		exit(EXIT_FAILURE);
> 	}
>=20
> 	if (pid =3D=3D 0) {
> 		printf("Child process with pid %d\n", getpid());
> 		exit(EXIT_SUCCESS);
> 	}
>=20
> 	printf("Parent process received child's pid %d as return value\n", pid);
> 	printf("Parent process received child's pidfd %d\n", *(int *)args.pidfd);
> 	printf("Parent process received child's pid %d as return argument\n",
> 	       *(pid_t *)args.parent_tid);
>=20
> 	if (0) {
> 		if (waitid(P_ALL, pid, NULL, 0) =3D=3D 0) {
> 			fprintf(stderr, "Managed to wait on CLONE_NO_WAITALL process with wait=
id(P_ALL)\n");
> 			exit(EXIT_FAILURE);
> 		}
> 		printf("Child process %d requested CLONE_NO_WAITALL\n", pid);
> 	} else {
> 		printf("Child process %d did not request CLONE_NO_WAITALL\n", pid);
> 	}
>=20
> 	if (wait_for_pid(pid))
> 		exit(EXIT_FAILURE);
>=20
> 	if (pid !=3D *(pid_t *)args.parent_tid)
> 		exit(EXIT_FAILURE);
>=20
> 	close(pidfd);
>=20
> 	return 0;
> }

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--qfxueoggiia3z6jh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXbLFQAAKCRCdlLljIbnQ
El81AP0Zq9hqMvdLZ606cwcrvwrlF1Dz1SNfa3Qr2ixC8xKfigD+OBZQIMDUhECt
fIXlzzzhuKElKrMxiI6ydgtkfRPGJgA=
=Ka/u
-----END PGP SIGNATURE-----

--qfxueoggiia3z6jh--
