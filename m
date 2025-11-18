Return-Path: <linux-api+bounces-5354-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27BC69B9F
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 151192BE8C
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CBE2D7817;
	Tue, 18 Nov 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDdd6+k8"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A83587D2;
	Tue, 18 Nov 2025 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473886; cv=none; b=DLK/KtqayiXcQfIpl0QvqpzT7AXiSAAuekEergwxBb3PykyKouzinTLfaDvxRUr47We8T+8CzIbbhiFZAxNiKUlm+zEiuKCK0Fs5TIqGBsww/xrvXDNycVeqHnuWOwMnZmXDE+khpogwkc+vBGK50ngxOLVUo8z90OhFzbQWKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473886; c=relaxed/simple;
	bh=xAU9zpvqzPcvtEu2/LCN92HQeLPzmiIprKa2GpmFbog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOLKZBQizogQpwBovhewgaaHQo0HYgz1ElLj02mFda9QUOgKbsGKsH0/HHce0t1BLqWwLol7SFknjJoYd3lGZPy4NxxAlAVMsTBUaqaLlCr8pl+KvUhQe7QS+stxg99Hc3/xuLhFmtxNxBs/bq0sWMS5XMue2nlklxzg2u/VKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDdd6+k8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD34DC19422;
	Tue, 18 Nov 2025 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763473886;
	bh=xAU9zpvqzPcvtEu2/LCN92HQeLPzmiIprKa2GpmFbog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDdd6+k80HFqFpMUWqlf/vIu0hqmIEm286G4WhqZTYVw3qdgFooXsIZBPGNmjHaaq
	 BJVt0Za6wLDNazh0lduri8U+j6hNM5+fk+zqZFaY4JYFrPTL03rFwkRI6vDSepyXoX
	 kU+Mii84A09avKtT70HQP8R5VWIz+/04CFk2Lo6TlRm/XSA9AZNeoumEf68rTYHgl+
	 PaX57wXooZp2f3+KHdDZKldX/rKx9qEa4tBOkHPlCJ4wFEr2+qxOycoqNtIAFIi+H5
	 CHTQ1k6eK7egBav3kvV2Z48t3eNmoWBg0216++z+bsTGU4luhU6oBFOpsLfYHe2tSt
	 0TDtUZ+qJfM3w==
Date: Tue, 18 Nov 2025 14:51:22 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jakub =?utf-8?Q?G=C5=82ogowski?= <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
Message-ID: <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
References: <cover.1763130571.git.not@dzwdz.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kexlxzcjisnkdles"
Content-Disposition: inline
In-Reply-To: <cover.1763130571.git.not@dzwdz.net>


--kexlxzcjisnkdles
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jakub =?utf-8?Q?G=C5=82ogowski?= <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
Message-ID: <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
References: <cover.1763130571.git.not@dzwdz.net>
MIME-Version: 1.0
In-Reply-To: <cover.1763130571.git.not@dzwdz.net>

Hi Jakub,

On Fri, Nov 14, 2025 at 03:29:29PM +0100, Jakub G=C5=82ogowski wrote:
> I found the PKTINFO docs pretty confusing, so I tried clarifying them:
> - being more specific about each field in the struct
>   (e.g. "local address of the packet" for a received packet could've
>   been interpreted in myriad ways),
> - making the differences between sendmsg(2)'s and recvmsg(2)'s handling
>   of that struct more explicit,
> - and some other slight rewording to make it (IMO) more readable - I cut
>   out most of a paragraph that wasn't really saying anything, etc.
>=20
> I'm not sure if this should even be documented in ip(7) together with
> the other sockopts, though?  sendmsg(2)'s handling of in_pktinfo is
> completely unrelated to the IP_PKTINFO sockopt.  Documenting it in its
> own manual page would also give us more room for subsection headings and
> other formatting, examples, etc - instead of trying to cram it into
> what's already an enormous manpage.
>=20
> Same goes for some of the other more complex sockopts, I guess.

Do you suggest moving each socket option to a manual page under
man2const/?  I think I agree with that.  There's precedent, and it makes
the pages more readable.

I'll try to do that soon.  I'll ping you when I've finished, in case you
want to apply further changes.

> PS. sorry for not signing this email, but neomutt didn't want to
> cooperate :/  I'll try to figure it out for any followup patches.

Ok.


Have a lovely day!
Alex

> Jakub G=C5=82ogowski (2):
>   man/man7/ip.7: Clarify PKTINFO's semantics depending on packet
>     direction
>   man/man7/ip.7: Reword IP_PKTINFO's description
>=20
>  man/man7/ip.7 | 57 +++++++++++++++++++++++++++------------------------
>  1 file changed, 30 insertions(+), 27 deletions(-)
>=20
> --=20
> 2.47.3
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--kexlxzcjisnkdles
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkcedMACgkQ64mZXMKQ
wqknWw/+N9pmp/N2ul5Ix4kzgwy3ILw6Y5RdWIGE/uvQpMV0uIv2sC7xjcvZf66X
A6nsfbW0Ihz6PyeNA16ByfUu8CZNXd658WPwDqwQU8coQ21PRk43XfpLLSULzfYB
Pk2fHv5Br/HlTWMTUfRD80EzsTFQ2NaWnyCxnW83tB2LW7hSe07Pi7vayb1cptxe
3Ev9X4JpzWX9pzgMW53AdQQfvQ9Yxw7lMdT6v/sgvzAxkbLyPSGu0QWFoa60ZEt9
/i/UM8rnvWcnJwC6A029w6+dQEXZN96xCMhS8clE3W83dG2qaIY/NkEYK4VE6rC0
vSZ1j1wS5S1G48cVEwDK0hHRZle18zv4vi4iedyljWzVM765MJRm/ZiZOzsEnsjb
7aeFtGB8viq7Tn5JQi2W7nSIvz0Qa9A7keiCEoVlzQv/amWD86/X1VkkwRO+oJ36
pJbkQGn+WQVZ1zH7OopCyymQOQcTFyy0RCv3K7Ufq35VG+nraxPuFDKIBRoUIbJP
iIDA2sqhNzwrX7USFidChJLeyAjo4N+rVBk16YZw3G8+Erw6fZtzuzLpFLaaSlO9
iRu3NsW0aD6qExMVzk43rlOXC+TWgIdYWFBpA1Po7rMgUEYK1kMLjET7k3TIML7+
2I4/WRSeuhVVWgdKUrtH48qsz+JksNL7M4VAjYC2YVGW42IJhh4=
=iy8z
-----END PGP SIGNATURE-----

--kexlxzcjisnkdles--

