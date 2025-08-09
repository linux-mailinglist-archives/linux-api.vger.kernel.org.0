Return-Path: <linux-api+bounces-4425-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D8B1F4EC
	for <lists+linux-api@lfdr.de>; Sat,  9 Aug 2025 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7258218C24EA
	for <lists+linux-api@lfdr.de>; Sat,  9 Aug 2025 14:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBC6289E23;
	Sat,  9 Aug 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhPiH1Jl"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBAA12C499;
	Sat,  9 Aug 2025 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754749528; cv=none; b=GRg0wqb5esr0Ty9nJ3zcoMO3lLr4WAFBNGhWWFBX2z90kkvyQHL+1PME86SARdAjNTQCtsVT/0ZbPCvpxVBsaWn1glbnCJWkp6AjJ1SWEE3wT8TUJMANgN0mlkSlS+jgTuPIpK2RhPsKnDlixh8ZS2OLuACyWvhVmsY0UCab9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754749528; c=relaxed/simple;
	bh=oITAnnL4pXbTCRefVuC52zFet+7k9cZryAFVCd68ykQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHhUPpYg/+TKW/E0hnOdbBk5DfKB5jJqQ2thTsrENF5N68T7FSecTKUWlKwTKwn/b4FbOtYtug3oU/lwn/ern8ginMnB2HCIOY6Qdmkwgc3uYyYpc5z+R/yfNDgeRytD5YCTXPIeieaVRnLZCPOA04Gp834RntnaMeDX3eKhTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhPiH1Jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81FCC4CEE7;
	Sat,  9 Aug 2025 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754749527;
	bh=oITAnnL4pXbTCRefVuC52zFet+7k9cZryAFVCd68ykQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lhPiH1JlOayaV8jMajfbPXRp+PJT0K/tDMTHVy9FlsjaNitJUKSthITV+aMSgYQ7Y
	 Cm4vBNyRSPvvlbsEnkFIT0XabcKcbSexsKdVA8fXH0Q3pmHeiS+xWHV/tVPtC1wDzq
	 b4FAHduYiEb083Q8qAIKcLacAdSmSpMUQH4njEd3m9wArAA9tngZcQbmj74hwKYiau
	 U9caVv1ZEwjE5U2CWoMJ9pWiqzN6AcQXgFfynGOmOIrnXjxyZslWo9Tm56nsBV2kyX
	 XaHV10+Q8M7jQt2LfxnHEjw31K//sCZzjfDL5DFMQHdPy1eSYe19MN29u5l4nyLoEN
	 CQth0XyUDiU1A==
Date: Sat, 9 Aug 2025 16:25:18 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <ekjakm6zburrawhk34smm3fd43zufzguisfean4hmv7vyjp7fq@uvy6n47qbydl>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5xmbayfvgezef2h2"
Content-Disposition: inline
In-Reply-To: <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>


--5xmbayfvgezef2h2
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
Subject: Re: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
In-Reply-To: <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

On Tue, Aug 05, 2025 at 06:31:55PM +0100, Lorenzo Stoakes wrote:
> Document the new behaviour introduced in Linux 6.17 whereby it is now
> possible to move multiple mappings in a single operation, as long as the
> operation is purely a move, that is old_size is equal to new_size and
> MREMAP_FIXED is specified.
>=20
> To make things clearer, also describe this 'pure move' operation, before
> expanding upon it to describe the newly introduced behaviour.

Can we split this further into two commits?

>=20
> This change also explains the limitations of of this method and the
> possibility of partial failure.
>=20
> Finally, we pluralise language where it makes sense to so the documentati=
on
> does not contradict either this new capability nor the pre-existing edge
> case.
>=20
> Example code is enclosed below demonstrating the behaviour which is now
> possible:
>=20
> int main(void)
> {
> 	unsigned long page_size =3D sysconf(_SC_PAGESIZE);
> 	void *ptr =3D mmap(NULL, 10 * page_size, PROT_READ | PROT_WRITE,
> 			 MAP_ANON | MAP_PRIVATE, -1, 0);
> 	void *tgt_ptr =3D mmap(NULL, 10 * page_size, PROT_NONE,
> 			     MAP_ANON | MAP_PRIVATE, -1, 0);
> 	int i;
>=20
> 	if (ptr =3D=3D MAP_FAILED || tgt_ptr =3D=3D MAP_FAILED) {
> 		perror("mmap");
> 		return EXIT_FAILURE;
> 	}
>=20
> 	/* Unmap every other page. */
> 	for (i =3D 1; i < 10; i +=3D 2)
> 		munmap(ptr + i * page_size, page_size);
>=20
> 	/* Now move all 5 distinct mappings to tgt_ptr. */
> 	ptr =3D mremap(ptr, 10 * page_size, 10 * page_size,
> 		     MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr);
> 	if (ptr =3D=3D MAP_FAILED) {
> 		perror("mremap");
> 		return EXIT_FAILURE;
> 	}
>=20
> 	return EXIT_SUCCESS;
> }
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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

I don't understand this.  What does it mean that old_address must reside
within a mapping?  It's a point, not a size, so I'm not sure I
understand it.

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

Why this blank?


Cheers,
Alex

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
> --=20
> 2.50.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--5xmbayfvgezef2h2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiXWjcACgkQ64mZXMKQ
wqklGg//SF0JLJ2EiiXam+d6ODgH9lopFyhItyfqL3G5G4HQc19RtfHsy4v2T2MD
ewK8cwOkg2e/u/ejOUi2L+/AGO8hc4ykHSxM74eivyf4O8AJs9mSB1ywZ4CJ18S1
GU/ZApYIFSExfIgY6PAywvn/Dv3PQdPfO8gG2tK9FflCfsmbSJbpN7ADVfCrA9pW
ZfeqA949CLLAiGoDTMx3K309dJeT7qTr7IQqlSJQzvrVCnukaqmoUowCvlwJdr/0
ffjCt7aTU/JCoafEg5gJOrPvunUKwd6mRbj6+wCdfe215Lw/s1MWtGURJp1qGl1T
XoNkSBO0z2+noPkEoD9N1mU7tlZRf7QLRSf3nZX8fXiIrPBk2lhhfhwoEKXGDI2F
PkFIas97LQ3XXauEmM85GGGl420Jl62VnS0lRiVHNp2c6Y71ADGi5QhbhlWIl78x
eQPmjkJJxCgCi+OeSCyUFgvrvA7VFOIaS/U2aC95yu00V+B1i3X+61z6I3snAkTI
JLV7pTNtrrY92U1f4LRHcO7d8xF1F6vL4nuH+mb97bLyWzuLIEbC1sBhtJiDNxbT
n7XMQA1v4g68Dcc0IQEgx9YlbewR14KZSm6p43kILDjM5z3CtvoORAi3wgYs+dw6
+UEfBqtc989H3Vg6QrYhdNslpgv7HIZGEEItTWHs1JGW+PEBEHQ=
=oKUk
-----END PGP SIGNATURE-----

--5xmbayfvgezef2h2--

