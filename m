Return-Path: <linux-api+bounces-4500-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFACB287D5
	for <lists+linux-api@lfdr.de>; Fri, 15 Aug 2025 23:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D121D05B01
	for <lists+linux-api@lfdr.de>; Fri, 15 Aug 2025 21:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF5D28D84F;
	Fri, 15 Aug 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2A9s5SO"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50427FB2D;
	Fri, 15 Aug 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755293793; cv=none; b=ur8+fvGpKPl9uvIwEZl/I3r87xj1fb9evGDoLbeCXO5CPRY7h4zzIcxSRTGgLcrJ2+IBxrfFcZyc9kpGPdQKOh+Bs+9OZyxr7KeM/3oOpUvi8vSPrDg0JFgtKEM+2fCX8+W8r3fJJ3ON4jv8jMUYIdHy/eCTuEMdQHnkd1No2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755293793; c=relaxed/simple;
	bh=U0tpozaKDQBPba9WDp+NiZ8JiSwtUymVIkmMJFBx268=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mui+FSoKHTGQN8BCf4gfvI+ci1W7GmgJqbjhXTVYbBUpPL0FEMXFePmEHH3zUXSlAsGv71OH1riNX6Y2RzZj8qdJC0GQZNcYl0RjrjeTc90hQK28D4JuX9cN5buWNbiKdUgy90uH06e6Vyg5yX3n+odvdDcPvEeBspBqbzotY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2A9s5SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7353C4CEF6;
	Fri, 15 Aug 2025 21:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755293791;
	bh=U0tpozaKDQBPba9WDp+NiZ8JiSwtUymVIkmMJFBx268=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u2A9s5SOh0Xn7c07Jk6kYr5WnS+j1MhD4i3MBJJZGBxAu49VawaAquZQHjf8zdZAa
	 6JeYu6Vh1f3A2cXfgupqVE9vQ4VBLkTHNDkKHm1WYKaO8n7sYP4pY/2p0a4jniXuK5
	 vkPjet1vsi/KNFD19x2gI4c/5MMgf1yWvV4ExUsC9j3JCtQtjTLcaBtbHrDatK1509
	 0PZYckymAyG776qQO4xc5xIrGj4ZWyMueO5sSIMvdjTXPFj6sYqu0bVhQN94a88RqO
	 Z/xgem4ozYg3xZbI2O94V5vAeDpQRbqPEje8BRT/KetJuHK3egosh1LnQob3do2LAp
	 LDSjzjtH8EbQw==
Date: Fri, 15 Aug 2025 23:36:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 3/3] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
Message-ID: <uvh2e2jjdk44tdwrhmnd46atwgdzwwmny4kczxqv2vm33gjqpp@63lsupn6y2u6>
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="buoh4y3nl2ltwkym"
Content-Disposition: inline
In-Reply-To: <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>


--buoh4y3nl2ltwkym
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
Subject: Re: [PATCH v5 3/3] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>

Hi Lorenzo,

On Mon, Aug 11, 2025 at 03:59:39PM +0100, Lorenzo Stoakes wrote:
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
> ---
>  man/man2/mremap.2 | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> index 6d14bf627..53d4eda29 100644
> --- a/man/man2/mremap.2
> +++ b/man/man2/mremap.2
> @@ -47,8 +47,35 @@ The
>  .B MREMAP_DONTUNMAP
>  flag may also be specified.
>  .P
> -If the operation is not
> -simply moving mappings,
> +Equally, if the operation performs a shrink,
> +that is if

Missing comma.

> +.I old_size
> +is greater than
> +.IR new_size ,
> +then
> +.I old_size
> +may also span multiple mappings
> +which do not have to be
> +adjacent to one another.

I'm wondering if there's a missing comma or not before 'which'.
The meaning of the sentence would be different.

So, I should ask:

Does old_size > new_size mean that old_size may span multiple mappings
and you're commenting that multiple mappings need not be adjacent?

Or are multiple mappings always allowed and old_size > new_size allows
non-adjacent ones?

I suspect it's the former, right?  Then, it's missing a comma, right?


Other than this, the patch looks good.


Have a lovely night!
Alex

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

--buoh4y3nl2ltwkym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmifqFMACgkQ64mZXMKQ
wqnXURAAmhC7nlLe2VS4LJ2byHc2MqG2Eedkuvp/uWEx1SzqdTojtI/Yl6n6uvQa
JF/vI4VMca73f2g6FjXoW05aSTmVqmSV/ozGgNnzLI42rPSBBNmj4cmCL2ohabYO
Ellsndg1F1QEBscQzpjNcb0SXdjopomMBC1mtBnY8lEYSfqzS0PBOUyLwx3IjAzP
qjUQKmjHb0vrLFywkTwJ1PME48DlSrJV+R87Vpw6B6HVTNjDQGs9UnQEyDYZPnPk
3UtJZpeZJzo8FV0qqfLKfeO7RTWZz3p0abzL0K3mMfJiYExyBeUEKOAHRi8qskrU
4oq+aqPXX0OioXC8Wooro5d2QWCifwAZ+KKPGJ2C9v3z9fmk0xMruZifm8G1YFFr
5BpxVExXZm1f9eyg+M9iVuFEYQ5nnRXx9tLGNNdq2UsoCI20sSmR3TJ1O9tEoVnf
cHd9XaZjwowAWypj4QXmficy8O8daf64h9aTxrWLF90ebzkUuAIZfd8vQ2xSO49t
++GPqZLNRG8qLC8Is3rNwxNksaMo+qoFYM0fyPkMjppcMo0iaNPmp1gC+QSIkVgN
thD36RsVD2U5JidQl756IjZoOgVZrDFxUjT+RMPFYN6j4qrMkUob2V/WdWPVmb3L
yEW9hUpV15jgCzgvJ4rGiNtnaO4+Q7LlSfmDc9YthFgS/Nwi8KU=
=IxjY
-----END PGP SIGNATURE-----

--buoh4y3nl2ltwkym--

