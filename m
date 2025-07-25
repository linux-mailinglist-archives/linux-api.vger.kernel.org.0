Return-Path: <linux-api+bounces-4246-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A4CB125C2
	for <lists+linux-api@lfdr.de>; Fri, 25 Jul 2025 22:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946FC1CC10F6
	for <lists+linux-api@lfdr.de>; Fri, 25 Jul 2025 20:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0931325B69F;
	Fri, 25 Jul 2025 20:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkW6DJXA"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AEE25B30E;
	Fri, 25 Jul 2025 20:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476305; cv=none; b=MzUiq3MeD3owORD1zKd7LP7P8oUrmXMIvbCz8SfExeVax7nQK580pPSLiNvx9FoEwEXbE9VLWpdbFCe4yC0rIQonQihvPj99kSDE0X5wRg0tAVLinBV8x0ow9ABB+d0EGORHuOlqNj0BH0FjRRhLAjli6h/rcd/z8vzOp6OprfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476305; c=relaxed/simple;
	bh=TSv9glcM2lIp/pJtvRRP9I3bMN+OB/xZq/jx8F38Ks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Shbq3EajpPpDSs6zyTbJaJ1ZkAgn71BZA4w7Mn05wKqipGZSe9bHuIAD4Wo7GIXfE+dKvVkWfEli5mmdwzgNWKUeoQtZu7Qw4j+pqHJn7Qj+CrgZ1M2PMi60jYl3Nv8jAkkAOeWtNvVe3l2My7ibVqKEvGTMhcSHZq5ibQVx1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkW6DJXA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B2CC4CEE7;
	Fri, 25 Jul 2025 20:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753476305;
	bh=TSv9glcM2lIp/pJtvRRP9I3bMN+OB/xZq/jx8F38Ks0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tkW6DJXAKDLsx1l+RBedjJ0vpWFngIwAedKAK5fwco8NppOqSVQER76cRMKSHubT6
	 pri7WPQFezqRSuk8Xj9YBSXIDpmDRiXnwfEQZ3VA8HUUYrSp0p0llwR1i8dkuKGRSJ
	 XzSL49Zt4mTQvBluYsTyXiBKMQ0g70mAU3p6935HKrQaVDtYqXEspUGalAsbb2zr9K
	 4O/DU6bMBbE9CjlBTj0EgM73Vhz5sq3NHIR61+xWFIgjrLf8B9ppQEqpqfOattaSwV
	 PZE6uz0Wuv4kongxFFalADK0pbsUCMNBcLrQjwfiARgox0XF6SugndVdew6rbYCVG3
	 hFbwUd/bCnEoQ==
Date: Fri, 25 Jul 2025 22:44:59 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] man/man2/mremap.2: describe multiple mapping move, shrink
Message-ID: <siwe6k4ks44mvdzy7rmir2pmf7547gqxknuoppcn54pkh4lwdb@lko3ecfdjtda>
References: <20250723174634.75054-1-lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q2kjujlkwk6vx2gp"
Content-Disposition: inline
In-Reply-To: <20250723174634.75054-1-lorenzo.stoakes@oracle.com>


--q2kjujlkwk6vx2gp
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
Subject: Re: [PATCH] man/man2/mremap.2: describe multiple mapping move, shrink
References: <20250723174634.75054-1-lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20250723174634.75054-1-lorenzo.stoakes@oracle.com>

Hi Lorenzo,

On Wed, Jul 23, 2025 at 06:46:34PM +0100, Lorenzo Stoakes wrote:
> There is pre-existing logic that appears to be undocumented for an mremap=
()
> shrink operation, where it turns out that the usual 'input range must span
> a single mapping' requirement no longer applies.
>=20
> In fact, it turns out that the input range specified by [old_address,
> old_size) may span any number of mappings, as long old_address resides at
> or within a mapping and [old_address, new_size) spans only a single
> mapping.
>=20
> Explicitly document this.
>=20
> In addition, document the new behaviour introduced in Linux 6.17 whereby =
it
> is now possible to move multiple mappings in a single operation, as long =
as
> the operation is purely a move, that is old_size is equal to new_size and
> MREMAP_FIXED is specified.

Please separate the new behavior into a separate patch.  Each patch
should change one thing only.


Have a lovely night!
Alex

>=20
> To make things clearer, also describe this 'pure move' operation, before
> expanding upon it to describe the newly introduced behaviour.
>=20
> This change also explains the limitations of of this method and the
> possibility of partial failure.
>=20
> Finally, we pluralise language where it makes sense to so the documentati=
on
> does not contradict either this new capability nor the pre-existing edge
> case.
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  man/man2/mremap.2 | 93 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 82 insertions(+), 11 deletions(-)
>=20
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 2168ca728..c1a9e7397 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -25,18 +25,56 @@ moving it at the same time (controlled by the
>  argument and
>  the available virtual address space).
>  .P
> +Mappings can simply be moved by specifying equal
> +.I old_size
> +and
> +.I new_size
> +and specifying
> +.IR new_address ,
> +see the description of
> +.B MREMAP_FIXED
> +below.
> +Since Linux 6.17,
> +while
>  .I old_address
> -is the old address of the virtual memory block that you
> -want to expand (or shrink).
> +must reside within a mapping,
> +.I old_size
> +may span multiple mappings
> +which do not have to be
> +adjacent to one another.
> +.P
> +Equally, if the operation performs a shrink,
> +that is if
> +.I old_size
> +is greater than
> +.IR new_size ,
> +then
> +.I old_size
> +may also span multiple mappings
> +which do not have to be
> +adjacent to one another.
> +However in this case,
> +.I new_size
> +must span only a single mapping.
> +.P
> +If the operation is neither a simple move
> +nor a shrink,
> +then
> +.I old_size
> +must span only a single mapping.
> +.P
> +.I old_address
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
> @@ -105,13 +143,43 @@ If
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
> @@ -149,13 +217,13 @@ mapped.
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
> @@ -188,7 +256,10 @@ virtual memory address for this process.
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
>=20

--=20
<https://www.alejandro-colomar.es/>

--q2kjujlkwk6vx2gp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiD7MsACgkQ64mZXMKQ
wqmHXA/8DAG8114OPhYz3ll89YdJ+SrCt45AJseHz/iZJXbsN8/SKPG5D3kIjRkd
fh9AkafnjJB6W7CVCdIggNBh/elaL9rS6tKHckRE1LPGHfnT39Qt4nMovwXFTfhr
IfGKpuRo6pC2icAWYw/2D1TRG3kWHwueO5IXQY8aRS/KYtBFjj3+k8MSVmiP/BK7
ZsTKGcd8G1UMpa2u8pmMmI3GJy1PFaog1WJV30pkW3TybTalzaLjQ5Csr4NZO1fD
7U8KgE2KZrCc+/qoZPC733NH6sMn3TWeiQnn9R4a5dQ4lJeSWsr7FI5094AN/eVI
0V2Lh9jUIEJXWCFdiS3f+gfg0MWvVGdqh9HQOFQJi8fNNQJy6/BUrrlofc1k90IM
cCMNeqrzGPuDrkBEC7hL6+WYu7ag9ONTinAWUs6R0Zi68ovJbFg/EVlvbt3EPOtd
8Bd4yXhp/5iG83Nlov7KKQjoq/5OVoaWpRBqgQ/Xr72DHkfVeeiK7UdV92tZW4mv
e+avwcX6F74xeIWCKsB6+1pXMKzmBhh5pAa6cJF2VuCC9EJcCQ03wSQqzJyoBO1s
Qf8koa58XPykw/mPFK1AlEfuCF0RNjCO9mbvWLjjTcsDhJPPI77+WR2S8gutiU5r
Q5AflQJCJnxjx2SCRkX9y6+exnODS8anHnKi7o3gYp8n93cFAiw=
=AP9b
-----END PGP SIGNATURE-----

--q2kjujlkwk6vx2gp--

