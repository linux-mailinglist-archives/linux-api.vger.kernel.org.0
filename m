Return-Path: <linux-api+bounces-4279-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32007B18F58
	for <lists+linux-api@lfdr.de>; Sat,  2 Aug 2025 18:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF0817D00C
	for <lists+linux-api@lfdr.de>; Sat,  2 Aug 2025 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57A248868;
	Sat,  2 Aug 2025 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qirtRJzu"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5722759B;
	Sat,  2 Aug 2025 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754151281; cv=none; b=puwBBU2t70H2RGsjgjQJ52q8D0r/H/XSXUClarXmxjGlUjyBK4Xgtvk+SE1wzvdQ827TcsU6D6C2aZ3NT9VExzE1L2q02Asfnd0kaBJvl0Dqurl9YY3PBeFveVDdIVNc/065vC0arbbaRyXVcAHh9U3/xBszs71EcrOZUogG/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754151281; c=relaxed/simple;
	bh=cfIzk7b2hMmb2yuGteNfAWnIPFAYZAQL4GuFIxDTKr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBCOJngZLb8e2BavC8w/Kd1XKII7zNrmTZ0WIT5BuoQuyozyCk8RR5ccKHK/2ivWqQOqUQndBXjoxxBaFPGtmwoOm6rmwC7AfvDSGsry6ohQaM/vDjKWWXrPQHOZW9vjTgYVS23rErT1YZmRDUJQNCvlnqFB+fYOo7x9qSwozxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qirtRJzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7305C4CEEF;
	Sat,  2 Aug 2025 16:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754151280;
	bh=cfIzk7b2hMmb2yuGteNfAWnIPFAYZAQL4GuFIxDTKr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qirtRJzuaVFN2hHIijBX4dukz0mPUAzNI1OLrpc1c9nHnf6mDbOfaNLwDoLVd1zPo
	 GBN05msXr9H0XyK9K2d4bZDQIP07hydBo3IoZDK4eitc4Xl49SfdqRzSud8QvkV8UA
	 x+Ek4F8h6I9lgK9NpzmCCydIEtnTmeuuYCY+RODgDyp6ceP7fvJYXp0mvm3JBaCoPd
	 4yf2uOYgQhT6WvJBd4dy3tqpZ9hgMP4Ihi2iIUpsj9u6f7y3P3aRYW5Sh2byEto3NE
	 +ZEPnPdv2HJynBYtvTkMiHpGfe8a9RMtyFyMgoDEXDFiiKiBDUKUbgCCGQSLZ0hxd6
	 Xi8xRi01QdA1Q==
Date: Sat, 2 Aug 2025 18:14:32 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jan Kara <jack@suse.cz>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <c7aoiolzxs2yiq7gocjhsaxg4nsjej7bqcy2cfkfynkwwiwd7l@dfz5sq7hylgi>
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
 <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mfr5qafpnm3rr7ah"
Content-Disposition: inline
In-Reply-To: <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>


--mfr5qafpnm3rr7ah
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Jan Kara <jack@suse.cz>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
 <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo, Jann,

On Tue, Jul 29, 2025 at 02:47:35PM +0100, Lorenzo Stoakes wrote:
> Document the new behaviour introduced in Linux 6.17 whereby it is now
> possible to move multiple mappings in a single operation, as long as the
> operation is simply an MREMAP_FIXED move - that is old_size is equal to
> new_size and MREMAP_FIXED is specified.
>=20
> To make things clearer, also describe this kind of move operation, before
> expanding upon it to describe the newly introduced behaviour.
>=20
> This change also explains the limitations of of this method and the
> possibility of partial failure.
>=20
> Finally, we pluralise language where it makes sense to do so such that the
> documentation does not contradict either this new capability nor the
> pre-existing edge case.
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

I see some very minor formatting or punctuation issues, but I'll fix
them while applying.  Jann, do you plan to review this?


Have a lovely day!
Alex

> ---
>  man/man2/mremap.2 | 84 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 11 deletions(-)
>=20
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 2168ca728..6ba51310c 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -25,18 +25,47 @@ moving it at the same time (controlled by the
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
> +Since Linux 6.17,
> +while
> +.I old_address
> +must reside within a mapping,
> +.I old_size
> +may span multiple mappings
> +which do not have to be
> +adjacent to one another when
> +performing a move like this.
> +The
> +.B MREMAP_DONTUNMAP
> +flag may be specified.
> +.P
> +If the operation is not
> +simply moving mappings,
> +then
> +.I old_size
> +must span only a single mapping.
> +.P
>  .I old_address
> -is the old address of the virtual memory block that you
> -want to expand (or shrink).
> +is the old address of the first virtual memory block that you
> +want to expand, shrink, and/or move.
>  Note that
>  .I old_address
>  has to be page aligned.
>  .I old_size
> -is the old size of the
> -virtual memory block.
> +is the size of the range containing
> +virtual memory blocks to be manipulated.
>  .I new_size
>  is the requested size of the
> -virtual memory block after the resize.
> +virtual memory blocks after the resize.
>  An optional fifth argument,
>  .IR new_address ,
>  may be provided; see the description of
> @@ -105,13 +134,43 @@ If
>  is specified, then
>  .B MREMAP_MAYMOVE
>  must also be specified.
> +.IP
> +Since Linux 6.17,
> +if
> +.I old_size
> +is equal to
> +.I new_size
> +and
> +.B MREMAP_FIXED
> +is specified, then
> +.I old_size
> +may span beyond the mapping in which
> +.I old_address
> +resides.
> +In this case,
> +gaps between mappings in the original range
> +are maintained in the new range.
> +The whole operation is performed atomically
> +unless an error arises,
> +in which case the operation may be partially
> +completed,
> +that is,
> +some mappings may be moved and others not.
> +.IP
> +
> +Moving multiple mappings is not permitted if
> +any of those mappings have either
> +been registered with
> +.BR userfaultfd (2) ,
> +or map drivers that
> +specify their own custom address mapping logic.
>  .TP
>  .BR MREMAP_DONTUNMAP " (since Linux 5.7)"
>  .\" commit e346b3813067d4b17383f975f197a9aa28a3b077
>  This flag, which must be used in conjunction with
>  .BR MREMAP_MAYMOVE ,
> -remaps a mapping to a new address but does not unmap the mapping at
> -.IR old_address .
> +remaps mappings to a new address but does not unmap them
> +from their original address.
>  .IP
>  The
>  .B MREMAP_DONTUNMAP
> @@ -149,13 +208,13 @@ mapped.
>  See NOTES for some possible applications of
>  .BR MREMAP_DONTUNMAP .
>  .P
> -If the memory segment specified by
> +If the memory segments specified by
>  .I old_address
>  and
>  .I old_size
> -is locked (using
> +are locked (using
>  .BR mlock (2)
> -or similar), then this lock is maintained when the segment is
> +or similar), then this lock is maintained when the segments are
>  resized and/or relocated.
>  As a consequence, the amount of memory locked by the process may change.
>  .SH RETURN VALUE
> @@ -188,7 +247,10 @@ virtual memory address for this process.
>  You can also get
>  .B EFAULT
>  even if there exist mappings that cover the
> -whole address space requested, but those mappings are of different types.
> +whole address space requested, but those mappings are of different types,
> +and the
> +.BR mremap ()
> +operation being performed does not support this.
>  .TP
>  .B EINVAL
>  An invalid argument was given.
> --
> 2.50.1

--=20
<https://www.alejandro-colomar.es/>

--mfr5qafpnm3rr7ah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiOOWcACgkQ64mZXMKQ
wqkkKQ//UZnrcUQhjHzoPuHujQSIONo7V3EXvdkY+B88iP2nWGGtJ0hv+yOClegO
KmQtES8Tw3JB41eFh09zq9G5/xdmZeBHkAiVRoWkog/lnn4O5jd2mWHPMVSX6nbI
SaeJ8tjAg/XF7+97bT8qMcZ/MdYX3FCAbPl469IR5eri9+P6gDn3f3vfYm4lRykt
mpGybr3T2f+iEBba318dN04UImNcuvJr+IaS60Xh2KJOmSE/fofhNQIVgDwNgwkB
U0qvYwvtXx24/Lj1s24tXCYX1PyaeFJn5Wrd3cmdN1m5sAIat5VgHNA/ifq74oiA
C8iqNZasJJluJInuoviDF0M32hgZH6CDToCZobl41m0nygXMctFOQW3+I2JjWdSu
Bn5cGwZyc8opWTO/9uzBUpuj/gM2WI4jXIxIafug8VnF63D1baku5r1sxfW7W+9L
uu8e0SB2BjOhpmcicDa5pKZ7HYnl3m4TfnsVIiVlcTwcWMSHMbY3zHEgXj8icXWx
rtli7Ar4aEnUzRr5uvjeoo6RMWhZVvtb0gXfiKKYI/FUIEb5vilBmuRxz7NL7XyH
v2pJiybdbJA43n7WXZcNXnJd/munjHcdq8eiUz7FSFtAGSOV4BpCSddTPyG+rlY5
JQS92f/jTdzrDp7HFsc8/1xfD7joH9GHvxOoZTltGFrvBoCnbqs=
=c3Kf
-----END PGP SIGNATURE-----

--mfr5qafpnm3rr7ah--

