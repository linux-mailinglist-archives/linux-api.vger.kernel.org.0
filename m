Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768022C26A8
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 14:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387756AbgKXM6W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 07:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387752AbgKXM6W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 07:58:22 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BFFC0613D6;
        Tue, 24 Nov 2020 04:58:21 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4CgPG25vMCzQlXR;
        Tue, 24 Nov 2020 13:58:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id BpMW7ohxcsl4; Tue, 24 Nov 2020 13:58:14 +0100 (CET)
Date:   Tue, 24 Nov 2020 23:58:06 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
Message-ID: <20201124125806.nud2x5kfvnxdagqk@yavin.dot.cyphar.com>
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="menhpnrtnm2uuh3t"
Content-Disposition: inline
In-Reply-To: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -9.04 / 15.00 / 15.00
X-Rspamd-Queue-Id: 07991665
X-Rspamd-UID: 47ba3d
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--menhpnrtnm2uuh3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-24, Florian Weimer <fweimer@redhat.com> wrote:
> This documents a way to safely use new security-related system calls
> while preserving compatibility with container runtimes that require
> insecure emulation (because they filter the system call by default).
> Admittedly, it is somewhat hackish, but it can be implemented by
> userspace today, for existing system calls such as faccessat2,
> without kernel or container runtime changes.
>=20
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>=20
> ---
>  Documentation/process/adding-syscalls.rst | 37 +++++++++++++++++++++++++=
++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/pr=
ocess/adding-syscalls.rst
> index a3ecb236576c..7d1e578a1df1 100644
> --- a/Documentation/process/adding-syscalls.rst
> +++ b/Documentation/process/adding-syscalls.rst
> @@ -436,6 +436,40 @@ simulates registers etc).  Fixing this is as simple =
as adding a #define to
> =20
>      #define stub_xyzzy sys_xyzzy
> =20
> +Container Compatibility and seccomp
> +-----------------------------------
> +
> +The Linux Foundation Open Container Initiative Runtime Specification
> +requires that by default, implementations install seccomp system call
> +filters which cause system calls to fail with ``EPERM``.  As a result,
> +all new system calls in such containers fail with ``EPERM`` instead of
> +``ENOSYS``.  This design is problematic because ``EPERM`` is a
> +legitimate system call result which should not trigger fallback to a
> +userspace emulation, particularly for security-related system calls.
> +(With ``ENOSYS``, it is clear that a fallback implementation has to be
> +used to maintain compatibility with older kernels or container
> +runtimes.)
> +
> +New system calls should therefore provide a way to reliably trigger an
> +error distinct from ``EPERM``, without any side effects.  Some ways to
> +achieve that are:
> +
> + - ``EBADFD`` for the invalid file descriptor -1
> + - ``EFAULT`` for a null pointer
> + - ``EINVAL`` for a contradictory set of flags that will remain invalid
> +   in the future
> +
> +If a system call has such error behavior, upon encountering an
> +``EPERM`` error, userspace applications can perform further
> +invocations of the same system call to check if the ``EPERM`` error
> +persists for those known error conditions.  If those also fail with
> +``EPERM``, that likely means that the original ``EPERM`` error was the
> +result of a seccomp filter, and should be treated like ``ENOSYS``
> +(e.g., trigger an alternative fallback implementation).  If those
> +probing system calls do not fail with ``EPERM``, the error likely came
> +from a real implementation, and should be reported to the caller
> +directly, without resorting to ``ENOSYS``-style fallback.
> +

As I mentioned in the runc thread[1], this is really down to Docker's
default policy configuration. The EPERM-everything behaviour in OCI was
inherited from Docker, and it boils down to not having an additional
seccomp rule which does ENOSYS for unknown syscall numbers (Docker can
just add the rule without modifying the OCI runtime-spec -- so it's
something Docker can fix entirely on their own). I'll prepare a patch
for Docker this week.

IMHO it's also slightly overkill to change the kernel API design
guidelines in response to this issue.

[1]: https://github.com/opencontainers/runc/issues/2151

>  Other Details
>  -------------
> @@ -575,3 +609,6 @@ References and Sources
>   - Recommendation from Linus Torvalds that x32 system calls should prefer
>     compatibility with 64-bit versions rather than 32-bit versions:
>     https://lkml.org/lkml/2011/8/31/244
> + - Linux Configuration section of the Open Container Initiative
> +   Runtime Specification:
> +   https://github.com/opencontainers/runtime-spec/blob/master/config-lin=
ux.md

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--menhpnrtnm2uuh3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX70DWwAKCRCdlLljIbnQ
Eh02AQDqe/cbtRujqSD6iqI1h/NzdVqiyVSfQha2lM/csdR84AD/fY8Z+EramNW4
2GU3nD2K8K/evERqIV3wX4ODDpQFUQ4=
=8C+9
-----END PGP SIGNATURE-----

--menhpnrtnm2uuh3t--
