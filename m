Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9873B7CE2
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 07:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhF3FPn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 01:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhF3FPn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 01:15:43 -0400
X-Greylist: delayed 632 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Jun 2021 22:13:14 PDT
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050::465:103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C4C061766;
        Tue, 29 Jun 2021 22:13:14 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4GF8NY2xyHzQk3d;
        Wed, 30 Jun 2021 07:02:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id 4tliV6jmTDUS; Wed, 30 Jun 2021 07:02:33 +0200 (CEST)
Date:   Wed, 30 Jun 2021 15:02:19 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Semantics of SECCOMP_MODE_STRICT?
Message-ID: <20210630050219.nwixaloqs5oq5juy@senku>
References: <87r1gkp9i7.fsf@disp2133>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="knyuqndtsekusods"
Content-Disposition: inline
In-Reply-To: <87r1gkp9i7.fsf@disp2133>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.55 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0019D1860
X-Rspamd-UID: f361c3
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--knyuqndtsekusods
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-06-29, Eric W. Biederman <ebiederm@xmission.com> wrote:
>=20
> I am the process of cleaning up the process exit path in the kernel, and
> as part of that I am looking at the callers of do_exit.  A very
> interesting one is __seccure_computing_strict.
>=20
> Looking at the code is very clear that if a system call is attempted
> that is not in the table the thread attempting to execute that system
> call is terminated.
>=20
> Reading the man page for seccomp it says that the process is delivered
> SIGKILL.
>=20
> The practical difference is what happens for multi-threaded
> applications.
>=20
> What are the desired semantics for a multi-threaded application if one
> thread attempts to use a unsupported system call?  Should the thread be
> terminated or the entire application?
>=20
> Do we need to fix the kernel, or do we need to fix the manpages?

My expectation is that the correct action should be the equivalent of
SECCOMP_RET_KILL(_THREAD) which kills the thread and is the current
behaviour (SECCOMP_RET_KILL_PROCESS is relatively speaking quite new).

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--knyuqndtsekusods
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCYNv62AAKCRCdlLljIbnQ
EmqeAQCwE2RYKejytscSCZFsA8BmtrqPevAElfKrXqcDdvKRoQEAqAhoskdp6IIK
QTCUu1vbkKCwS4S63ntMofnCIFFKggE=
=5aqA
-----END PGP SIGNATURE-----

--knyuqndtsekusods--
