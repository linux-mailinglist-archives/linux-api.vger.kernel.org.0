Return-Path: <linux-api+bounces-3636-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 362ECAA657C
	for <lists+linux-api@lfdr.de>; Thu,  1 May 2025 23:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF533B8511
	for <lists+linux-api@lfdr.de>; Thu,  1 May 2025 21:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891F288DA;
	Thu,  1 May 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gbf2+5C0"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDFF20EB;
	Thu,  1 May 2025 21:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135013; cv=none; b=kWELMD49qvItgMW/L70NQGagsTYR3TffIigEx/Q5eioLDtWpBL+VpL+qIUqhvexEz6tZdjBPuumC0Clw1d3rOcAyIGqvmyGU1Lo6zbFzCrcxCch272L8YqabexbQ7+5Btb86Gj7yBcxIfknFYfR9wFNCzT2WNm+aDpC2A7128KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135013; c=relaxed/simple;
	bh=g+49zlVnfqLLpX+3cIMgHETxR66bAaSMqa7oRRtLsZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcPI4bUuhF9c+twZjeN6fb8HIthpugIiU4++KQx7ZEba4Pxpva+xvIcPXmz4wCHu6EJzUlOY7L/xreHWXiECOV60xyho0YydfvKrdNdXfPGNNUGbyjyD4URIJZAKtRRHa3UZB0765Obwc2QbsiJo9c2UeoGBvQuGeu+zwO8WUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gbf2+5C0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC404C4CEE3;
	Thu,  1 May 2025 21:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746135013;
	bh=g+49zlVnfqLLpX+3cIMgHETxR66bAaSMqa7oRRtLsZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gbf2+5C0j/tKtTjlADO7Yt2E0p39Oo3Guo1jxtq+p+mo8KJj+aKobyFLrH2E5jVPN
	 vW3XwoOCZqcdO0KXfvdlz6i7wDcHGV+s4+uFNVRHHb9uII3P1MHCYiacA2avG+Jd8k
	 4bScrlSHtV/qfCsZGlRamD1O6Tw0ZHglidqh6seXVGPzk7qb/WncGSjx7WTUJ2C6R5
	 yGoLrld7HW1fnwTcpKoN6p4f+nNaAFe6YDbaWApKBCmWEKqMLf1dN2G67rL4bzx3ow
	 FeP91UWoLldRoNpqpsYOO9Oyz24BheG13LT1AXuR8y1zHmuq/ggF1OLSmMIpjNQFJH
	 OKEivWUyl8VEQ==
Date: Thu, 1 May 2025 23:30:09 +0200
From: Alejandro Colomar <alx@kernel.org>
To: devhoodit <devhoodit@gmail.com>
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	Carlos O'Donell <carlos@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] man/man2/clone.2: Document CLONE_NEWPID and
 CLONE_NEWUSER flag
Message-ID: <e2wxznnsnew5vrlhbvvpc5gbjlfd5nimnlwhsgnh6qanyjhpjo@2hxdsmag3rsk>
References: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ijle2fdzb2f3bast"
Content-Disposition: inline
In-Reply-To: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>


--ijle2fdzb2f3bast
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: devhoodit <devhoodit@gmail.com>
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	Carlos O'Donell <carlos@redhat.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] man/man2/clone.2: Document CLONE_NEWPID and
 CLONE_NEWUSER flag
References: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>

Hi Carlos,

On Mon, Apr 21, 2025 at 04:16:03AM +0900, devhoodit wrote:
> CLONE_NEWPID and CLONE_PARENT can be used together, but not CLONE_THREAD.=
  Similarly, CLONE_NEWUSER and CLONE_PARENT can be used together, but not C=
LONE_THREAD.
> This was discussed here: <https://lore.kernel.org/linux-man/06febfb3-e2e2=
-4363-bc34-83a07692144f@redhat.com/T/>
> Relevant code: <https://github.com/torvalds/linux/blob/219d54332a09e8d874=
1c1e1982f5eae56099de85/kernel/fork.c#L1815>
>=20
> Cc: Carlos O'Donell <carlos@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: devhoodit <devhoodit@gmail.com>

Could you please review this patch?


Have a lovely night!
Alex

> ---
>  man/man2/clone.2 | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/man/man2/clone.2 b/man/man2/clone.2
> index 1b74e4c92..b9561125a 100644
> --- a/man/man2/clone.2
> +++ b/man/man2/clone.2
> @@ -776,9 +776,7 @@ .SS The flags mask
>  no privileges are needed to create a user namespace.
>  .IP
>  This flag can't be specified in conjunction with
> -.B CLONE_THREAD
> -or
> -.BR CLONE_PARENT .
> +.BR CLONE_THREAD .
>  For security reasons,
>  .\" commit e66eded8309ebf679d3d3c1f5820d1f2ca332c71
>  .\" https://lwn.net/Articles/543273/
> @@ -1319,11 +1317,10 @@ .SH ERRORS
>  mask.
>  .TP
>  .B EINVAL
> +Both
>  .B CLONE_NEWPID
> -and one (or both) of
> +and
>  .B CLONE_THREAD
> -or
> -.B CLONE_PARENT
>  were specified in the
>  .I flags
>  mask.
> --=20
> 2.49.0
>=20

--=20
<https://www.alejandro-colomar.es/>

--ijle2fdzb2f3bast
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgT5+EACgkQ64mZXMKQ
wqlxIA//a3T/CsDruQhANJ6jm98fhUlfXEMCddNlnVrlzKdbmb9uWpjmY9r+l8R7
jity3F2bYhJbAr4AIpSwPh8JqbZSV3tSPecK/k3sFCbqXxPEHB/surK6x6SvM+E2
nCzITLBawhlZAAWSxvse/NQ0QiqcwpWKfBCQU1OSrKIYJZJWLib5yPdGQDerupVe
YhfBo5t+w8toIjCxEDSIi9PsNUw3DvQrGU5/Yun2e0D7Y2BskkPvbck03zOzypx6
xxMlMdYQlV+RqVN/WihWlzNOpPdFk66gcGixooW3sgoGVmil9Cp02yyy4nLwPnW8
/I6qzp2KlaUqxii2iNjJLNdT54Ru7j2gkqYhlfmQRLMigAaQJpOJlHhfrpFyJW2R
lhCIbVQX4jVoeUMsWMlN9VJoLukMK7bsu8kSpD+SgTiR1ml25Va+SPtCfvLRGAwD
b8Dmmo9HoYThbSp6YC6sxnFkQM/IST9Wus31gHdgwv4VZel4wLeQoNHa1XmPuN9I
g26sd8riA3hwo9yukBRXpehQ2xL+LE/Kixu1grOQ0406ifhG5YCkGSAr4zpKVo1K
KsnQFEnvZCaAa62MzHJOP/yWnTPhxMgzQh+VTGIDbgasuSFd3NtzZNKaxgdXTHoH
K26DWtEo2GQs8GvyUrRHhhorD1QMzSFZ4Y74s2mu39cPf7555m8=
=HQhQ
-----END PGP SIGNATURE-----

--ijle2fdzb2f3bast--

