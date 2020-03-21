Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A0418DDD1
	for <lists+linux-api@lfdr.de>; Sat, 21 Mar 2020 04:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCUD5L (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Mar 2020 23:57:11 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172]:50284 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgCUD5L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Mar 2020 23:57:11 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 48kn0446HYzQlFS;
        Sat, 21 Mar 2020 04:57:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id XfvDeWEXw3H2; Sat, 21 Mar 2020 04:57:05 +0100 (CET)
Date:   Sat, 21 Mar 2020 14:56:57 +1100
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Eric Rannaud <eric.rannaud@gmail.com>
Cc:     linux-api@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: clock_settime(2) error for non-settable clocks
Message-ID: <20200321035657.6baexoov65dkpmsb@yavin.dot.cyphar.com>
References: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kzmu4bo7chcvjthj"
Content-Disposition: inline
In-Reply-To: <CA+zRj8U5_NaY4ZQXj9r=f58KcO3pq5k9HZt9KxRYHnOOk=e1WQ@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--kzmu4bo7chcvjthj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-03-20, Eric Rannaud <eric.rannaud@gmail.com> wrote:
> Should we update the manpage to more fully explain the range of
> possible errors or instead try to have more consistent errors? For
> syscalls, what's the backward-compatibility contract for errno values?

It's the same as everything else -- "if it breaks an existing
application, it's a regression". There was an infamous case of this
exact scenario happening (changing the errno returned from an ioctl
broke pulseaudio) in 2012[1].

[1]: https://lore.kernel.org/lkml/CA+55aFzX56kPPwSO97X=3DUyPaMzV5QRNG9ScN=
=3DnxnHFjmz=3D_8yA@mail.gmail.com/

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--kzmu4bo7chcvjthj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCXnWQhgAKCRCdlLljIbnQ
EqYCAQDjcZTklhc1vemF4cPQj5xLzAMOmEkkXWwbAikPkPZtVwEA5+o3SQiZm7Zi
bSOBdZoOotaxgIYpE1MR1KRl2eFoyg4=
=c/WG
-----END PGP SIGNATURE-----

--kzmu4bo7chcvjthj--
