Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED132B8A56
	for <lists+linux-api@lfdr.de>; Thu, 19 Nov 2020 04:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKSDJB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 22:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKSDJB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 22:09:01 -0500
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050::465:202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA8C0613D4
        for <linux-api@vger.kernel.org>; Wed, 18 Nov 2020 19:09:01 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Cc4QK5x7PzQlR6;
        Thu, 19 Nov 2020 04:08:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id oVekRNUISgu7; Thu, 19 Nov 2020 04:08:52 +0100 (CET)
Date:   Thu, 19 Nov 2020 14:08:44 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: Is adding an argument to an existing syscall okay?
Message-ID: <20201119030844.unaet2doe6wb3sbr@yavin.dot.cyphar.com>
References: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctfkgmddkxiypadq"
Content-Disposition: inline
In-Reply-To: <CALCETrXU2KcH0nsH_vd-fmvpZt_yW2+=VnYtN_BQJ6xsSvm+6A@mail.gmail.com>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -7.48 / 15.00 / 15.00
X-Rspamd-Queue-Id: 491B3665
X-Rspamd-UID: 32e0e3
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--ctfkgmddkxiypadq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-11-16, Andy Lutomirski <luto@kernel.org> wrote:
> Linux 5.10 contains this patch:
>=20
> commit 2a36ab717e8fe678d98f81c14a0b124712719840
> Author: Peter Oskolkov <posk@google.com>
> Date:   Wed Sep 23 16:36:16 2020 -0700
>=20
>     rseq/membarrier: Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
>=20
> This adds an argument to an existing syscall.  Before the patch,
> membarrier had 2 parameters; now it has 3.  Is this really okay?  At
> least the patch is careful and ignores the third parameter unless a
> previously unused flag bit is set.

This change is not wrong from a correctness perspective but this kind of
pattern is (in my view at least) an anti-pattern -- as Florian has
mentioned, adding new arguments to an existing syscall can lead to libc
complications for wrappers, as well as more explicit issues like the
O_TMPFILE example.

This all harkens back to the whole "what extensibility system we want to
have" question Christian and I discussed at LPC this year[1]. This setup
(add a new flag to enable the new argument) is one of the approaches we
listed, but the only question is whether it's one we want to encourage.

In fairness, we can't retro-fit extensible structs to membarrier(2) so
there isn't a nice way to do this other than adding membarrier2(2). And
it seems to me the real issue is that membarrier(2) is a multiplexer
which inevitably means it has its own host of extensibility issues
(which we covered in the talk as well). *shrug*

[1]: https://lwn.net/Articles/830666/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ctfkgmddkxiypadq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX7XhuQAKCRCdlLljIbnQ
EsR5AP9+rGwzyvZQIzuYzxRBAmyVnFPhDC6pbgvs4hxsLdo73gD/U7m8rSkLwy4/
g8ieC1SgLTJYUXOAqeF+1DzaT5uO4Ag=
=1niy
-----END PGP SIGNATURE-----

--ctfkgmddkxiypadq--
