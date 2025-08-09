Return-Path: <linux-api+bounces-4426-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ACBB1F4F3
	for <lists+linux-api@lfdr.de>; Sat,  9 Aug 2025 16:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D1276252C6
	for <lists+linux-api@lfdr.de>; Sat,  9 Aug 2025 14:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6D529B796;
	Sat,  9 Aug 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtPq82xb"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0A1B0420;
	Sat,  9 Aug 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750001; cv=none; b=a5IZ3JGsKmDNOikTNpaRxzDJTO9w8taF/jntRArqGlUkElWBivSlPzkln1w0Mw8UaP1UMGynPdmcvRLmj9qyz4doSUE5rsKl0PWuzgz1nl3oOSaqdQQz3ibqN8J4hgQuWGgm/j0q4wtNdwuKGXkaymELqaf3Mz5wcPG1TxsGm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750001; c=relaxed/simple;
	bh=yxUe45wSeV1/d5Z1NivZkyntB8zfOPdyKAKqdYx4Urg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rs6cXke0YXFbwQvU1YbiRQOJIVCB5xnXdZDhX8gpSZTiT+gwOeZuKwgw3LzcJWSWJibABC7d5XSg/95fQIeB4vA+XTuUmVnZy3eNyAmKIW4R5SfjvZnZPmTwFGNHQawYN++dVhLOiuPJKtdVEqEBshtWnNf5rJRs6dD42c2MIdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtPq82xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0613C4CEE7;
	Sat,  9 Aug 2025 14:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754750001;
	bh=yxUe45wSeV1/d5Z1NivZkyntB8zfOPdyKAKqdYx4Urg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtPq82xbmmWMVaE9JNo73+i7g+5l4ZqaB82Piz/xpwHC/5wGCQi4gy1Dq0woHh9b2
	 pu6vPwS0qgJjjyzoOtvU5IshuHToi3//HzTtPR9fp3gqGaNyRCMDx8Hd4n0SjFqv5W
	 0uKGIFTKsPdHpbPomIZkHnG2wzEY9/LTOyN5aLjXuqk9pWPDZ2oRcTXSrp6PRAoRG7
	 4RgsvqlFg/ENi/3ZxYV7UiIhIryh/hPD9//D9AOge8ftYvweKpLyp5CDz8oCKQXF54
	 YDiksSn+1bNX0NWAmEMd7AEZ/Zr+At/rzLZFiMm2PCfcwz2IQ3xwTeNCBrX7KRuwQF
	 w40v+2ExNkrpA==
Date: Sat, 9 Aug 2025 16:33:12 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 2/2] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
Message-ID: <iolucvrp6is43yjulbluchhw5wy6urq2gtwmcelg5atwuv63se@ovzuthfrup26>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yb7p3rwhyim56fmd"
Content-Disposition: inline
In-Reply-To: <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>


--yb7p3rwhyim56fmd
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
Subject: Re: [PATCH v4 2/2] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

On Tue, Aug 05, 2025 at 06:31:56PM +0100, Lorenzo Stoakes wrote:
> There is pre-existing logic that appears to be undocumented for an mremap=
()
> shrink operation, where it turns out that the usual 'input range must span
> a single mapping' requirement no longer applies.
>=20
> In fact, it turns out that the input range specified by [old_address,
> old_address + old_size) may span any number of mappings.
>=20
> If shrinking in-place (that is, neither the MREMAP_FIXED nor
> MREMAP_DONTUNMAP flags are specified), then the new span may also span any
> number of VMAs - [old_address, old_address + new_size).
>=20
> If shrinking and moving, the range specified by [old_address, old_address=
 +
> new_size) must span a single VMA.
>=20
> There must be at least one VMA contained within the [old_address,
> old_address + old_size) range, and old_address must be within the range of
> a VMA.
>=20
> Explicitly document this.
>=20
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Since this is documenting old behavior, could we have this patch before
the patch documenting new behavior?  Or do you prefer it in this order?


Cheers,
Alex

> ---
>  man/man2/mremap.2 | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 6ba51310c..631c835b8 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -48,8 +48,35 @@ The
>  .B MREMAP_DONTUNMAP
>  flag may be specified.
>  .P
> -If the operation is not
> -simply moving mappings,
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
> +If this shrink is performed
> +in-place,
> +that is,
> +neither
> +.BR MREMAP_FIXED ,
> +nor
> +.B MREMAP_DONTUNMAP
> +are specified,
> +.I new_size
> +may also span multiple VMAs.
> +However, if the range is moved,
> +then
> +.I new_size
> +must span only a single mapping.
> +.P
> +If the operation is neither a
> +.B MREMAP_FIXED
> +move
> +nor a shrink,
>  then
>  .I old_size
>  must span only a single mapping.
> --=20
> 2.50.1
>=20

--=20
<https://www.alejandro-colomar.es/>

--yb7p3rwhyim56fmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiXXCgACgkQ64mZXMKQ
wqnwUg//Zbci7enPjyN3lLEYaDN/+ol7gyRscha0V1VRpTj9tJMgsD1tqcoLTIO3
gU0Zg9yvwAiJEEYHPLeK25iP2ck1PV4kDShUZa7PkFwc7gatNYdDm3n2rry48YS3
DP11MHUlCvM/hEgGAl/FPLSKqIsZgcgvx8cFQu1dRFfQSn9tSht/9dkZZk9LLKxv
drKGY9tdoUWlZn29GSkPnVPfQT4ZnvgxHebPBsm2x/ROZlGpUD6EjgxiXsqSyK6r
OneW3vfmujiQK2fXCp6GmlaM1jQswtgOFBPkYsjpV3vaxR2yhha49u7uWAb2tkDD
cN5sKZhOdC+9gupdXuqBYik38SLPTBoi4eJAFw7Z8HqEe+OhKsWWqs6k6ARReVPC
QteP+jP8bOwTjeVi/F03buaa5skPAaq/DAd639WI6285yIk7jpzpGahgpScuW4d7
lRaekYBGNEX+ixWoRsJJdmOfmne47uscG/AnRvyWECNg/Asy8KiQ6dSsqmoSro0D
EIfjCzTmggQmhepkftKTOZnH8U5KsBtJmYAnnrGGVuwxLXH7rO+uCxu22oa9OLPf
eNhuQh5PaWN1YZkPPg83v84iDj/s3i3NNFH/iYesgMRAYXQqpoxohEkYjmxt9GGK
dAWrdWPj2cpimiU04ghm6HXsYKJaPZNT7tTv62s0zKa2lekBxiU=
=p3CN
-----END PGP SIGNATURE-----

--yb7p3rwhyim56fmd--

