Return-Path: <linux-api+bounces-5488-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8CEC817F6
	for <lists+linux-api@lfdr.de>; Mon, 24 Nov 2025 17:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7AE924E21FF
	for <lists+linux-api@lfdr.de>; Mon, 24 Nov 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE234314D0A;
	Mon, 24 Nov 2025 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lme/2IKI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1318314D07;
	Mon, 24 Nov 2025 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764000686; cv=none; b=NPSjSew2w7B4HmGUhlioYcQ4qb8zXgvv1VgJaEfwe1Oe3jPaZeOLWC05T32zKoPhV4lriwFEpDodkEN6V4PkDE50e1VDtqk3tTD7+OdwcXf/58YUxUJBbBinfeWhUWwBgkfLcZWq1+3ZRHIy9to2+L1iO4XjaASfOw8e+7gZ0fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764000686; c=relaxed/simple;
	bh=y1Hh3Of624Exdqe/Ee178JADFctmMfim1WsfeKLKLYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH9KIcu9Rgy1Zc6H1bwcub9eZ/24BsbrThOvUMiQsI0j3f+3hKF/Kms/yhwI4gIOOOSIaQ9pnbUWk5R1ExXCBcDZZP5gB04GXKURbfp1v/Yt0RJjNKToUMpKEQd2XlJacNMAjcmhe+6CHLIS52uGFeAiFdOgnvcLxUmVWBF2StQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lme/2IKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F63AC4CEF1;
	Mon, 24 Nov 2025 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764000685;
	bh=y1Hh3Of624Exdqe/Ee178JADFctmMfim1WsfeKLKLYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lme/2IKIbY9Enz6YwuakL1UwN9T8jsMR2iZ/9clkIZ0cxioC/KeTWIeEyHC+V0yy8
	 aoXmjmfX++0dQTL0adX6PdKJrSdFGSSBZR7nYPfUP81UMYv5p9rgh4Nvq/3rumkeKV
	 SWaIAJe1Quu1o7GxpaIcVnEVtD+WqBHNV1BOUuE5j3vM+w11U/dlcXjHdWxN6d0m/y
	 VyjDARpsvVVeu1rYjQ92ERiUYhPAeNVhZANH9EGVh2vLeBVCZ94JVaFT3H6QR1qTJo
	 aB5jKAJygbkHtw4W2Cus5n5Syxz+pdl4wR+16d2KvQqgSr+SCANCBLEz/iRMCEFajW
	 44BbPZv6wo2VQ==
Date: Mon, 24 Nov 2025 17:11:21 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jakub =?utf-8?Q?G=C5=82ogowski?= <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 2/2] man/man7/ip.7: Reword IP_PKTINFO's description
Message-ID: <im2kp5dhyoqac7fs46zh2xmxcahkfy3a4qafeufakwrbezfv6j@ubfts6zwryx4>
References: <cover.1763130571.git.not@dzwdz.net>
 <38cfae87620d99ab0fa15f1970ef18d4ab5ff5a5.1763130571.git.not@dzwdz.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwhdvxucbx4sa4mm"
Content-Disposition: inline
In-Reply-To: <38cfae87620d99ab0fa15f1970ef18d4ab5ff5a5.1763130571.git.not@dzwdz.net>


--rwhdvxucbx4sa4mm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jakub =?utf-8?Q?G=C5=82ogowski?= <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 2/2] man/man7/ip.7: Reword IP_PKTINFO's description
Message-ID: <im2kp5dhyoqac7fs46zh2xmxcahkfy3a4qafeufakwrbezfv6j@ubfts6zwryx4>
References: <cover.1763130571.git.not@dzwdz.net>
 <38cfae87620d99ab0fa15f1970ef18d4ab5ff5a5.1763130571.git.not@dzwdz.net>
MIME-Version: 1.0
In-Reply-To: <38cfae87620d99ab0fa15f1970ef18d4ab5ff5a5.1763130571.git.not@dzwdz.net>

Hi Jakub,

On Fri, Nov 14, 2025 at 03:29:31PM +0100, Jakub G=C5=82ogowski wrote:
> I've heavily cut down the first paragraph (which wasn't really saying
> anything), and emphasized the difference between how recvmsg(2) and
> sendmsg(2) treat this struct.
>=20
> "This works only for datagram oriented sockets" is redundant with
> "Not supported for SOCK_STREAM", and the mention of sendmsg(2) was moved
> down.
>=20
> I called it a boolean option because that's how these were introduced at
> the start of the section.
>=20
> I've tried rewording ipi_spec_dst's effect on sendmsg to be a bit more
> clear.
>=20
> The only piece of new information which this adds is that you can use
> the structure returned by recvmsg with sendmsg, which directly follows
> from the preceding text.
>=20
> RFC 3542, Section 6, directly calls out this usecase for in6_pktinfo:
>=20
> > Some UDP servers want to respond to client
> > requests by sending their reply out the same interface on which the
> > request was received and with the source IPv6 address of the reply
> > equal to the destination IPv6 address of the request.  To do this the
> > application can enable just the IPV6_RECVPKTINFO socket option and
> > then use the received control information from recvmsg() as the
> > outgoing control information for sendmsg().  The application need not
> > examine or modify the in6_pktinfo structure at all.
>=20
> I'm not sure if this is the best place to document this, as the sendmsg
> behavior is unrelated to the IP_PKTINFO sockopt at all.  Maybe some of
> the control messages should be broken out to another manpage?
>=20
> Signed-off-by: Jakub G=C5=82ogowski <not@dzwdz.net>

This patch doesn't apply anymore.  I guess it's some of the amendments
I applied in patch 1/2.  Would you mind rebasing and sending v2?


Have a lovely day!
Alex

> ---
>  man/man7/ip.7 | 49 +++++++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
>=20
> diff --git a/man/man7/ip.7 b/man/man7/ip.7
> index a7f118b42..aa2508bc7 100644
> --- a/man/man7/ip.7
> +++ b/man/man7/ip.7
> @@ -783,20 +783,13 @@ .SS Socket options
>  .TP
>  .BR IP_PKTINFO " (since Linux 2.2)"
>  .\" Precisely: since Linux 2.1.68
> -Pass an
> -.B IP_PKTINFO
> -ancillary message that contains a
> -.I pktinfo
> -structure that supplies some information about the incoming packet.
> -This works only for datagram oriented sockets.
> -The argument is a flag that tells the socket whether the
> -.B IP_PKTINFO
> -message should be passed or not.
> -The message itself can be sent/retrieved
> -only as a control message with a packet using
> +If this boolean option is enabled,
>  .BR recvmsg (2)
> -or
> -.BR sendmsg (2).
> +outputs an
> +.B IP_PKTINFO
> +ancillary message containing an
> +.I in_pktinfo
> +structure.
>  .IP
>  .in +4n
>  .EX
> @@ -809,37 +802,37 @@ .SS Socket options
>  .EE
>  .in
>  .IP
> -When returned by
> -.BR recvmsg (2) ,
> +In this context,
>  .I ipi_ifindex
>  is the unique index of the interface the packet was received on.
>  .I ipi_spec_dst
>  is the preferred source address for replies to the given packet, and
>  .I ipi_addr
> -is the destination address in the packet header.
> +is the destination address from the packet header.
>  These addresses are usually the same,
>  but can differ for broadcast or multicast packets.
>  Note that, depending on the configured routes,
>  .I ipi_spec_dst
>  might belong to a different interface from the one that received the pac=
ket.
>  .IP
> -If
> -.B IP_PKTINFO
> -is passed to
> -.BR sendmsg (2)
> -and
> +This structure can also be passed as an ancillary message to
> +.BR sendmsg (2) .
> +In that case,
>  .\" This field is grossly misnamed
>  .I ipi_spec_dst
> -is not zero, then it is used as the local source address, for the routing
> -table lookup, and for setting up IP source route options.
> -When
> +is used as the local source address
> +(if non-zero),
> +including for the purposes of setting up IP source route options.
> +It's also used for the routing table lookup, unless
>  .I ipi_ifindex
> -is not zero, the primary local address of the interface specified by the
> -index overwrites
> -.I ipi_spec_dst
> -for the routing table lookup.
> +is non-zero \(en
> +then the primary local address of that interface is used there instead.
>  .I ipi_addr
>  is ignored.
> +The structure returned by
> +.BR recvmsg (2)
> +can be reused,
> +which effectively sends a reply to the original packet.
>  .IP
>  Not supported for
>  .B SOCK_STREAM
> --=20
> 2.47.3
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--rwhdvxucbx4sa4mm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkkg6kACgkQ64mZXMKQ
wqliRA//a7JMh0mXd0jbsTfdvUVr3wNR+4blM7J1e/9B6jZRT1CZB/CX0siEO9qy
ZwR2XUIz7AU7hrUiCQuuHeioVlaeSzIrSxO7G37qBo/ZEAYU+dNNJJwL6+ARypgB
3Ilz5s0E6XLEOjL44Zbrpr21rDtpsfVKjb8EcEKh4F7KbbjemFchodnFb7AKY478
Sir8nE45B/rio36UXcmwfmp8T1nfqrqHCnQ5UuEsJezxbTURXShL5DMsSzNwGj9Z
5C+snFBMOT85Fu0xEhYL+3TyaqibktRiTbIdahgxBMKlxC3kOgPM0H8BMnUTR9ko
4bAz8qq6Xh4F+L3LXbwfMgSPdtSdKlERpXwS0erLpQC+w+fKNkzOmoSedlsh3LX1
MoDyIf+R/nmKMe75pX6X9hOBMUWBUGQQJVHIEOuu43HgD01yIw8tUxdpRPpvyGnc
uSRVtUgTnxtumglYyz+V/fJJRMIyCISKZGirEpsKxVhgNL9lb6lzia42vPvmUIR6
SUFlVmuAt6e1GFBTFiBg8ZNKLzW4VUhncUJuiRxDZhGj7iJUlu049q4e73kIuXkl
b7CK3GZcj60Q6vtK+H7kmS4OD3uW9W8GqSlwX5LOoZwk7J06dd4H16QOGmVL/26H
nit6Abzoxor3p9FRx/Qjm55h+Zs4vfsgJiAIfH2/nVbolZx4FSk=
=MA9K
-----END PGP SIGNATURE-----

--rwhdvxucbx4sa4mm--

