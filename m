Return-Path: <linux-api+bounces-2060-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15759942D29
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 13:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4119B21EE3
	for <lists+linux-api@lfdr.de>; Wed, 31 Jul 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9451E1AC434;
	Wed, 31 Jul 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGXd0EH2"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC42200CD;
	Wed, 31 Jul 2024 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722424910; cv=none; b=NQwU0ve1hjErsgTDsNQZnprGEfiHNKQ1zwg7ks/5bmIiYLx4dDEBComvpe0MtWEr05uK9kPjoL5TTJ2dT782XEJxHvADgg3667WxByRpFjHDKZa9XkXTmVCAcAls7zP2H+D4vi8wWoykhlQWEyxMjnbY4SrczP+pADjy0Eh2DL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722424910; c=relaxed/simple;
	bh=YCzsKWIMLYwp9LJnDaTvR+DPD9mLOVzlBXgKcmuF6ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DazjMYN0CuJZMmNFogDSTYoWFkmJCPS7szWpRbuVfWnjiT6LjA7i3II0Qfo5mo77wH2jLsypGDTgID05XzyEe6KA2c7isNTwceX+lcbDx+9uwWswPUSpRZoe+JxKv/YaH6gHoLVwVqX+6KV2L78k2/Vk7lFR6UrL/5GNVLoO1ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGXd0EH2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24955C116B1;
	Wed, 31 Jul 2024 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722424910;
	bh=YCzsKWIMLYwp9LJnDaTvR+DPD9mLOVzlBXgKcmuF6ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FGXd0EH2d5b81Nji1SoQ2ZoGKMH3XpPK7IMMIFMDGVlPrayYrT9JFW9QMM/mjCqrV
	 3VAOWwMocFAeWcr+KfOxCH9OH8ON8bB1li2TMQhyQH5sCumd9PkR62GvMuUQ4fJ2zF
	 IxcsOCSx7lA5vDBQiOoqlQCOaW8rnF3hE6OFM+n1qNQTLUsOidu4fUCAMn6ckqTn51
	 nQWo6HazOBc7hkiqJuzTEc5swWFYo2n/eLX68wpKQwC+9gylWJ9eHEh1FnpqmbJMgs
	 RHkoBqeJ9WzSWx7XIP6NBWuJxi/71jSLMa0J97ngewjORICyPmUW61BDZlV4cGso27
	 8aoEPjhsbAPng==
Date: Wed, 31 Jul 2024 13:21:47 +0200
From: Alejandro Colomar <alx@kernel.org>
To: "i@andypan.me" <i@andypan.me>
Cc: "mtk.manpages" <mtk.manpages@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] epoll.7: clarify the event distribution under
 edge-triggered mode
Message-ID: <l5ezb77kqvbmypsvv4nek7ce46sghrm6ox6zbeq7hzd6j2ouv2@mhaihw3rkwjl>
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
 <2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
 <tencent_311E460546C884C26FB32E3C@qq.com>
 <l3suz7pnchnpnd5hhpxk5xqdikdxevp3dsybmhlcmzu6yih66s@zxuvoiunfqwl>
 <DD88B2A8DED5353D+137af5bf-158d-4e1e-b4ae-c4262434f8a6@Spark>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qn7mumwwal677ey4"
Content-Disposition: inline
In-Reply-To: <DD88B2A8DED5353D+137af5bf-158d-4e1e-b4ae-c4262434f8a6@Spark>


--qn7mumwwal677ey4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: "i@andypan.me" <i@andypan.me>
Cc: "mtk.manpages" <mtk.manpages@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] epoll.7: clarify the event distribution under
 edge-triggered mode
References: <20240730-epoll-et-desc-v3-1-6aa81b1c400d@andypan.me>
 <2yb4zrih5esl3qldowd34ojg7mjq3xqjmqvq5bb5y6ru4x7rv5@p6ahw4ztu5cf>
 <tencent_311E460546C884C26FB32E3C@qq.com>
 <l3suz7pnchnpnd5hhpxk5xqdikdxevp3dsybmhlcmzu6yih66s@zxuvoiunfqwl>
 <DD88B2A8DED5353D+137af5bf-158d-4e1e-b4ae-c4262434f8a6@Spark>
MIME-Version: 1.0
In-Reply-To: <DD88B2A8DED5353D+137af5bf-158d-4e1e-b4ae-c4262434f8a6@Spark>

Hi Andy,

On Wed, Jul 31, 2024 at 07:16:38PM GMT, i@andypan.me wrote:
> OK, I get your point now. In that case, should I start a new paragraph
> where I put the clarification? If so, where would you suggest I begin
> writing that new paragraph? Thanks!

Thank you!  I don't have an opinion at the moment.  Feel free to chose
where you want; we'll see.

Cheers,
Alex

>=20
> Best regards,
> Andy Pan

--=20
<https://www.alejandro-colomar.es/>

--qn7mumwwal677ey4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaqHkoACgkQnowa+77/
2zKOsQ/+KrAvoHGZ3R4bM8v40mWRZvNeQn95akpEYa26TM+QKu8y/yz4o/xYFqk+
UVW9BMecr9Aahb9snOAfa8tfAhVBtrUh9LmgLEoxuT8FVUWxlMHd6DBo+V4jvzGe
8DuLPSzcFeUcdR1jSUGFD3h/iRz+WOGIrCLsym12+yGOwsdQAfhYTgvSNs2b8N1H
C2G/OxTRvs3wHcaRnTQnFGMzxcv7L7FEcttxaGMBr9nuOEdiQdQDpVmDb3jZhnbe
pGFdxMQO3Plw/xYmcb89hwLs7L+qxzp24qapuShtko7jgbN4iwleRyn/TvvCWaW+
ZpuQCKf4eNXfbsLMz+UYIxyMwLg52s4fSSZrjjRPBKa/jnM5Q9pVV0QXYAlUx3gp
Is5w5cBY4o1GEOuFFte6lNzbh4h+QSmTIm4c0oX6DNJv0CVlunkRFemxkNMob/Ak
0CA8AhnqDwGDDTjtpzx+QZrcUloz6A+HW+nYvTBpWJE8YBpmnDojuQ4CjanVGJDn
wTHv9WVpBnw5Mn3os4/CSx/jGEfc8VD2H3BZdvRreDE6cphiX0fzuji3SD/gVEZJ
oUhsqAc+jnegGuhseq07f7t5vyve+Atw4599Wck9S1egM/315yseEIHnkqzpBdLy
/BZHWVqSP5L4jUk7hFfo1YqQQrQZg5X6zoIbFBJ1e7mfq8+md0k=
=kebS
-----END PGP SIGNATURE-----

--qn7mumwwal677ey4--

