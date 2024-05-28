Return-Path: <linux-api+bounces-1626-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C128D1A29
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 13:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895691F23F84
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2024 11:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58BA16D309;
	Tue, 28 May 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh73VSsR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD07113F431;
	Tue, 28 May 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896885; cv=none; b=Ayx2SI3e3QgIOob2BNJWeRs81M39wu6hHeM88+kN3eysQmGTbslgBOz7tlvquBNWB6wbfKrIv2hKnthPu+z3e1EVpSceoqIzUX5cwmBBYPybSkkT7+M2PcFASf8nAnnhh9foaHdLnrSwcwdarfCDw7cShlmkre2nL5486KWB31w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896885; c=relaxed/simple;
	bh=GzdgGk9rOCUWEGE9r3V+BUQkxDVfOj5AFZJklbVzbeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnF3LnP+2bNxy27ENMM1Bg+77UvbU7S4Wa82U+Hy/D2TJdG52K34Wnrt/8g9KmY4FYEg2bD1J0Hh3WQqL0LWPHqpQ4U27Wq04drnd1gTOyaCE6Etai98m0U5eSOX15GeVLAKeCAYJdZLlEiXRgIcDAoYGylUah8SvXKggCFJhH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh73VSsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFD8C3277B;
	Tue, 28 May 2024 11:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716896885;
	bh=GzdgGk9rOCUWEGE9r3V+BUQkxDVfOj5AFZJklbVzbeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eh73VSsReKg0cyMRe+bYjeonroJf71rAzlupl1FLqN+YPkZ3ptmOoqYaXboCq5prq
	 FmUbc1io3NlnhOmAU/WnVf/mBWOgGp37oH6UZvIynq6jpUtlfUZD0oZhUQfmc8bj7/
	 ot+BUUWtqaIum0GZJZlN2YjOj82jSG68mISGGQydmV9lh5EPb5aIjYeSJ/Qgw0eDMo
	 o+7xBoxEZvR3Y7GQsZ8LPsVcoxE16JC1JLP1DRtGxdmc28VxRIP2IJAQEK22gLcuxS
	 alaAI8YBNP4TgDCF/WRPtFqsxnMtj3x/agu19192Gx0rZObiSmx5JY7t8du0W03bIN
	 sOSnvOCwi+r4Q==
Date: Tue, 28 May 2024 13:48:02 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org, 
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v1 0/2] uapi/linux/prctl: Use the L and UL integer suffixes
 for certain constants
Message-ID: <20240528114750.106187-1-alx@kernel.org>
X-Mailer: git-send-email 2.45.1
References: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cgyn2bljkc5pggwf"
Content-Disposition: inline
In-Reply-To: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>


--cgyn2bljkc5pggwf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org, 
	Alejandro Colomar <alx@kernel.org>
Subject: [PATCH v1 0/2] uapi/linux/prctl: Use the L and UL integer suffixes
 for certain constants
References: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
MIME-Version: 1.0
In-Reply-To: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>


Alejandro Colomar (2):
  uapi/linux/prctl: Use the L integer suffix for enumerations of width
    long
  uapi/linux/prctl: Use the UL integer suffix for bit fields of width
    long

 include/uapi/linux/prctl.h | 186 ++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 93 deletions(-)

Range-diff against v0:
-:  ------------ > 1:  eb1cdf3e2f33 uapi/linux/prctl: Use the L integer suf=
fix for enumerations of width long
-:  ------------ > 2:  16f5bd565191 uapi/linux/prctl: Use the UL integer su=
ffix for bit fields of width long
--=20
2.45.1


--cgyn2bljkc5pggwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZVxHIACgkQnowa+77/
2zKgVA//cGJeI6y+z9KTFaVtjiwsh/mQutLnTUl6+syryQRBj1E1BXMovJnfBz1r
+BP8fnZcGsbspAj9NNoNrU43TiT8j7T0i55vn5AIafLRnYrvF6eR+mSrxe5MuJc3
7FEJCmaxCoGS7g8ui0iLgQT6b2bep4epzplRDokHpqvw/O26Mnluu9PC0jzS8hQH
0MuwbpkJ1X7nkvEtphHE10QZMi+5KIDrzin52gDaJnx16ODMYl4kJTUkYHPjAQOs
Uo0JT6yk8RL1e4QsW42d/Ik7U23PkREWN85iMRTrH9lj2ws9nrxiGOebEkyl8r61
pokwFyYCx3IPEpPYXWh32wJC9grCYNOnhqVWFr/p1+BR/lKDGYChNEMh6jzjo/xU
8SsC7DfeD71oqtEezgQNygkSpt3WAzZQr4bsVDF7GLME0ajH/YVglcvrk367Oxw6
rwIkF86Z3oLsB5gW4Nb9rk7voC2QE7daEcjQVYvbb3qDEsKPoim6mwlixTdD/5Ur
qUzIC2IK4CMN+9vxT9rPRRWdfsFERzPt6KR0NfrPYoI7NEYUSqqPizE6nflplX0N
vEnUdhs1XvDGQ4aXVCaDGOkVx2AoZmDJI/litXEjItD8v20MkIFWhgJbYeNIs+CN
YMxscF2J2xEJUk3fmN099h+jLiE4K+toj03KXeVWKjYspHwaZJ8=
=jubp
-----END PGP SIGNATURE-----

--cgyn2bljkc5pggwf--

