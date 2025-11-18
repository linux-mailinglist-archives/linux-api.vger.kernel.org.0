Return-Path: <linux-api+bounces-5356-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 025F0C6A0F3
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 15:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 97FE82D125
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 14:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBA73624BD;
	Tue, 18 Nov 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOHsMf6O"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C235BDBA;
	Tue, 18 Nov 2025 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476273; cv=none; b=cuI0jkPZDI+A56h1l+jcFIzrb1R3QfB+cmOQ8DCQDfAU1QVcCjxCGccUUtkx5EguzaI20939Ue6QGg6U3oGWbgvH09Na78UNxnYZUBkwljDvgWy6vNHWIbJw3Ho7AOfoWW6nfgAQHbfmKqB2BQsNOa5gpHWmYBB1yRPz9zpFUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476273; c=relaxed/simple;
	bh=0ou25Q2DQ7q379usZUoNBQWK9SmVYrHUyrMzX8z1FTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4hsQwugGr3eaGYSewYV7LPsFI60beILOCo1XoF579zA9p2LeTMEfMQge4/GzPdUl3Zt3hqVwBFZOfq/Exu7F2MjmOzcefHGZVkcM5ge4sSmJrc/46qSAtWaRbX//i68W2KWfbDdHxO6ME0cv9MO+5c4RhPLOCVUQUgxHvR0nRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOHsMf6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1682C116D0;
	Tue, 18 Nov 2025 14:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763476273;
	bh=0ou25Q2DQ7q379usZUoNBQWK9SmVYrHUyrMzX8z1FTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eOHsMf6OOIfZQ3A/EeJszSNh6S+n84qyuATMxr2zwBXuTgECcQff4c9+aWEvVhUgS
	 tRrGWgk7EdaN9nRlgvkob0ntcTIclH5xr9viuUGz+2DJQWOhdGQyt+jJUbIiYPJnTa
	 c/6zNIsP4JSJoVJEPnEQLuZbX9dAKOOOL0yKlpjDEmodMvV7QNIF4XC12yVWmQwlTL
	 qcZ1AIzHdLC/xz6y7bkJ+K7scBhkHDxPlyucUFgw2bvOX0FkcyblxSmnMjMbiX20Qw
	 fPrVHV8SnVjMS5b8vrwNlk32QQHvlZJjJjZ5N5r+JtEP9iWAkDTnG4bZ84bjifZmeE
	 n9WGJMBxjRm6g==
Date: Tue, 18 Nov 2025 15:31:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jakub =?utf-8?Q?G=C5=82ogowski?= <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 1/2] man/man7/ip.7: Clarify PKTINFO's semantics depending
 on packet direction
Message-ID: <wf7rcischdpj6vbmchen6g7qynemfhyhgfx5uiezyun65qm5oi@3icznxytufar>
References: <cover.1763130571.git.not@dzwdz.net>
 <fb3980b64d1c827ad59726bb30761d735396e109.1763130571.git.not@dzwdz.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72t2sbwmsglquxyw"
Content-Disposition: inline
In-Reply-To: <fb3980b64d1c827ad59726bb30761d735396e109.1763130571.git.not@dzwdz.net>


--72t2sbwmsglquxyw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jakub =?utf-8?Q?G=C5=82ogowski?= <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 1/2] man/man7/ip.7: Clarify PKTINFO's semantics depending
 on packet direction
Message-ID: <wf7rcischdpj6vbmchen6g7qynemfhyhgfx5uiezyun65qm5oi@3icznxytufar>
References: <cover.1763130571.git.not@dzwdz.net>
 <fb3980b64d1c827ad59726bb30761d735396e109.1763130571.git.not@dzwdz.net>
MIME-Version: 1.0
In-Reply-To: <fb3980b64d1c827ad59726bb30761d735396e109.1763130571.git.not@dzwdz.net>

Hi Jakub,

On Fri, Nov 14, 2025 at 03:29:30PM +0100, Jakub G=C5=82ogowski wrote:
> For recvmsg(2), ipi_spec_dst is set by ipv4_pktinfo_prepare() to the
> result of fib_compute_sec_dst().  The latter was introduced in
> 	linux.git 35ebf65e851c6d97 ("ipv4: Create and use fib_compute_spec_dst()=
 helper.").
>=20
> Quoting its commit message:
>=20
> > The specific destination is the host we direct unicast replies to.
> > Usually this is the original packet source address, but if we are
> > responding to a multicast or broadcast packet we have to use something
> > different.
> >
> > Specifically we must use the source address we would use if we were to
> > send a packet to the unicast source of the original packet.
>=20
> Experimentation seems to confirm that behavior.
>=20
> As for the note about ipi_spec_dst being on a different interface:
> - For unicast packets (for which ipi_spec_dst is the original
>   destination address), I believe this is trivially true because Linux
>   uses the weak host model (unless there's some interaction with
>   RTCF_LOCAL that I'm missing).
> - For multicast/broadcast packets, fib_compute_sec_dst() only passes the
>   original interface to the lookup in the context of L3M.  In
>   particular, the original implementation (cited above) set iif and oof
>   to 0. Also, citing
> 	linux.git e7372197e15856ec ("net/ipv4: Set oif in fib_compute_spec_dst"),
>   > If the device is not enslaved, oif is still 0 so no affect.
>=20
> It doesn't seem like using an address specifically from the interface
> the packet was received on was ever the intention.  I've also confirmed
> this behavior (sending a multicast packet from another machine, whose IP
> I've routed to a dummy interface).
>=20
> I'm focusing on this because that's a misconception I've had before
> digging into the code - the sendmsg behavior explained in the same
> paragraph made me think ipi_spec_dst was the (primary?) address of
> ipi_ifindex.  I think this is worth clarifying.
>=20
> I've made it explicit that ipi_addr isn't used by sendmsg because that's
> another possible misconception.
>=20
> The (first) extra comma in sendmsg's ipi_spec_dst's description is meant
> to emphasize that it's used as the local source address _and_ for the
> routing table lookup, as opposed to just affecting the routing table
> lookup.
> Stylistically it might be a bit weird but idk how to convey this better.
>=20
> Apart from the cited commits I was referencing the linux-6.17.7 tarball.
>=20
> __fib_validate_source (and the comment near it) might also be of
> interest to people trying to figure out what "specific destinations"
> are, exactly.
>=20
> Signed-off-by: Jakub G=C5=82ogowski <not@dzwdz.net>

Thanks!  I've applied the patch.  I've added CC tags (please, copy those
yourself in future patches).

I've also s/PKTINFO/IP_PKTINFO/ in the subject.

And I've applied minor wording and source improvements.

I've pushed here:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3Db8f472450f6607e2d5bd68a1b60615a91ed3d111>
(use port 80).

> ---
>  man/man7/ip.7 | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/man/man7/ip.7 b/man/man7/ip.7
> index a92939cd0..a7f118b42 100644
> --- a/man/man7/ip.7
> +++ b/man/man7/ip.7
> @@ -809,12 +809,20 @@ .SS Socket options
>  .EE
>  .in
>  .IP
> +When returned by
> +.BR recvmsg (2) ,
>  .I ipi_ifindex
>  is the unique index of the interface the packet was received on.
>  .I ipi_spec_dst
> -is the local address of the packet and
> +is the preferred source address for replies to the given packet, and
>  .I ipi_addr
>  is the destination address in the packet header.
> +These addresses are usually the same,
> +but can differ for broadcast or multicast packets.
> +Note that, depending on the configured routes,

I've removed 'Note that,'.  It's redundant.  Everything in a manual page
should be noteworthy.


Have a lovely day!
Alex

> +.I ipi_spec_dst
> +might belong to a different interface from the one that received the pac=
ket.
> +.IP
>  If
>  .B IP_PKTINFO
>  is passed to
> @@ -822,14 +830,16 @@ .SS Socket options
>  and
>  .\" This field is grossly misnamed
>  .I ipi_spec_dst
> -is not zero, then it is used as the local source address for the routing
> -table lookup and for setting up IP source route options.
> +is not zero, then it is used as the local source address, for the routing
> +table lookup, and for setting up IP source route options.
>  When
>  .I ipi_ifindex
>  is not zero, the primary local address of the interface specified by the
>  index overwrites
>  .I ipi_spec_dst
>  for the routing table lookup.
> +.I ipi_addr
> +is ignored.
>  .IP
>  Not supported for
>  .B SOCK_STREAM
> --=20
> 2.47.3
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--72t2sbwmsglquxyw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkcgy0ACgkQ64mZXMKQ
wqn9iQ//dCLxXgyCdcInXuuKTQJK9jh0PtVJRiB+cdyakmwby6TqjWx/nW91c6f0
7ACmEXjr7BWfmOnjbQCKLksmE1km0sbVy6UIr2noHsJixJGL/RVShCKimo8ZO7Sh
aTGYIYiOxtbe3J6JBphIEKDmfhJgA/4XWsRuHhlGKN4tpzZDO9go05Ydp2y1KOxq
UwmdDDv9a0JMTJRV1IhNNOyUOIYSRVz+Y50PFv2KQ28hhwTpgFNcCexcguh0CwE9
h6Ec+WeOWQ4Nq4SdXt9hzetv+v9qeCs5ZR1a4+WDm17hfFDjYTmadwLz4Y4tMyaJ
1s3KTUJSJJ4V8lCdiFQvb3qlmXV8ifOrLDeE04i1yX5WQ29CpPXYy//Y5j49d4J8
Ju0ldewHPdftRGFRXNAcm8uFoEq9GWZHw/wpPCzJoKptVbqSG9vTucsl1CazRF6M
0ruw5t752AzKLwExCbUBwyOM7wuAdiJHaG3vsWrfzV7WBbHSZjihFokMlrSxT7IR
uY2xWYJHLTH1J3s8RqJ0hjoiUWVrxAW0LkPTjIFQDLo+9MRbwfqLpxN5Wo8Yldw3
MzvPFVCUv/PZ//P/xfPKb1OmrpRZjgK6FzZYivDJY4CPatU7PfKlsKD6zPJe/mDp
OdVXJ84pWRrPBf6eVhw9Dq9f3Uw8Wbb4cS3aeeQ8QJcyFPu2h6A=
=Uz8l
-----END PGP SIGNATURE-----

--72t2sbwmsglquxyw--

