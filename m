Return-Path: <linux-api+bounces-4494-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C67B27DEE
	for <lists+linux-api@lfdr.de>; Fri, 15 Aug 2025 12:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70C781886525
	for <lists+linux-api@lfdr.de>; Fri, 15 Aug 2025 10:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711232FABE6;
	Fri, 15 Aug 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sy2rO7FD"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA852E06D7;
	Fri, 15 Aug 2025 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252360; cv=none; b=S4sNR4h0NyrNioX06MYTgzgR3QUo/6q459aUd56Q7+mWF5S31tha7mjn65qTiGeqqaCSX4Yt9sB7riRiTH9kup5b+sYSopuZg2g/0lyX4OyAawjpUK9P5/Xfx319Z2/h1uZb9PEodNa6+fL34z/W/3WFxpIyxdntz5uJBkzMlz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252360; c=relaxed/simple;
	bh=4kAPBiqBZAxCxAWIqIT+vr/yijIk5oAl7mKqqrCIIPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZYDWyISbHu5E/ATNmXqjoCLRLQMwLgG3kSwpCQRDGSFRlav/UonthHNYuUD+uME0SLLBePDmpPrUeQ5gmDlWbxzEKI0mEiOQZWUac5lAf03y+BWAnhJSdP3f8ESAsD2LCw9q+kNHY85gPpKoLagGedBSY8keHwiwivgUdMsf/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sy2rO7FD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87455C4CEEB;
	Fri, 15 Aug 2025 10:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755252359;
	bh=4kAPBiqBZAxCxAWIqIT+vr/yijIk5oAl7mKqqrCIIPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sy2rO7FDDu4llpFz5072JU6C/cgszHciODCkbRki++0+gQXvb6MFUExZ/dQrs6ag6
	 xS0K9396Iwmi7UJDbF0JBapKbPwhSlDQUapEhgjpef6asPhzyGrWw0USjgTARyRYON
	 vnzB1oHb337Dakjv27VeTywsm25dbCNT2sRFR9jZaYCWc1bSTXz+lwMCxhc8RzQEmt
	 jVcjMQL0BTwBbTR1AB9Ny/WC615OibK5ZGrPYvLs6sGjvLRIYova+z3PDX3EhStElz
	 1r06W6OcXZPHBd7FtEwivxo4bqd0OKhRLvSI3JLsWqO50k6sKHunnbSQZhUlBDtHLg
	 RnOu/SY4MRCCA==
Date: Fri, 15 Aug 2025 12:05:54 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/3] man/man2/mremap.2: explicitly document the simple
 move operation
Message-ID: <hxbuhtkuorfe5d5lr7wi5cny7vx6bt3kc2xaoknfz4h6vk6djv@kpgaur7636rl>
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <0a5d0d6e9f75e8e2de05506f73c41b069d77de36.1754924278.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74b6lswjh7fvdbms"
Content-Disposition: inline
In-Reply-To: <0a5d0d6e9f75e8e2de05506f73c41b069d77de36.1754924278.git.lorenzo.stoakes@oracle.com>


--74b6lswjh7fvdbms
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 1/3] man/man2/mremap.2: explicitly document the simple
 move operation
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <0a5d0d6e9f75e8e2de05506f73c41b069d77de36.1754924278.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
In-Reply-To: <0a5d0d6e9f75e8e2de05506f73c41b069d77de36.1754924278.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

On Mon, Aug 11, 2025 at 03:59:37PM +0100, Lorenzo Stoakes wrote:
> In preparation for discussing newly introduced mremap() behaviour to perm=
it
> the move of multiple mappings at once, add a section to the mremap.2 man
> page to describe these operations in general.
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!  I've applied this patch.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D6ba37b9e14f6565d0cccecb634100d7fe11d22fb>


Have a lovely day!
Alex

> ---
>  man/man2/mremap.2 | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 2168ca728..4e3c8e54e 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -25,6 +25,20 @@ moving it at the same time (controlled by the
>  argument and
>  the available virtual address space).
>  .P
> +Mappings can also simply be moved
> +(without any resizing)
> +by specifying equal
> +.I old_size
> +and
> +.I new_size
> +and using the
> +.B MREMAP_FIXED
> +flag
> +(see below).
> +The
> +.B MREMAP_DONTUNMAP
> +flag may also be specified.
> +.P
>  .I old_address
>  is the old address of the virtual memory block that you
>  want to expand (or shrink).
> --=20
> 2.50.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--74b6lswjh7fvdbms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmifBoEACgkQ64mZXMKQ
wqk7Dw//WsFue4bgugB0w/7GXyXlaPczRfrhaf0n+tv2SeXMcBgc86x8YoLB4O5g
6WGu+m2Eei9AjViA6W0UlnBIXGsWnUQHgv+8tqA1vfEcHDSfnh26kh0gMTlMPKuq
wPC+o3X6F6srlbiY2/l6YbvpgNn/V1/23h6LaiA4jBcilL5nB5lcHOInkcc4y7W3
BFnXclPsmRQGFnWrRqNJoE07RH1g0muQvpexqVi+rcaxwtW6nO7agU0BF6whMpzy
wP2dVSETSUWMBBa1pKpcsnPdE+6R84TKNFFYj6xIICN/fTWwnuVst9SOdiqUKN6+
NhPp7Vo47d73nH8levpw0VrkNY6+8kLq2Fm6bOnyqf5Xff0w7FoHJx0D3QlSqWPN
efKViQY+D2uu8tvT2PF3/goFNUH/08EE/TUjxIUbqTFzi2H314yyEWX0YNIqpZJw
/7EBDvp/yoH+GPbzol7Onz7Y/G537Z2RG+MEbazZsV7IUOVcXkrFvcVq7KR4/TlN
NgipluT+5TEClK6gyp58v4RbJm4SFeSRl3tlx6vXfK4cS3WF8QpsT6K8arwTEFnF
sLx3IpEP8cbUrxISi+hGt8VyxqkL6kFatKsWfF8pRsD2Njwe7yNBzYuG8+9SJ8dD
PZtV69UE04m/D2yfesaNy+eYsIYEtV5mlNOHMMIUZy68hv68XTQ=
=hIne
-----END PGP SIGNATURE-----

--74b6lswjh7fvdbms--

