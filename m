Return-Path: <linux-api+bounces-1715-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 299EF9051E8
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 14:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320981C20D92
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 12:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664616F27F;
	Wed, 12 Jun 2024 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzP5VLYm"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B116F267;
	Wed, 12 Jun 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193759; cv=none; b=TT3YRF5o8yCp7okZkvEiRl+GDHpjHkxANW6DJ6VTMQVMqFFBPgKYJgPvesRhr3w4bj9zt8gMwsGVZFCcO7QAsEDaeMq2fx9eg5ncPc1l8w5qoTjz17Myi0V7tnm698aUcR3pJpZDvTuT6kF8K42HCmKFjjSnl7bC5GJFei47EI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193759; c=relaxed/simple;
	bh=7ikxE7YKUM0cgX9yTna/sAPGY8vV4ozbWDKEo9rSOsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjDkbTrZDGXFM48IHNDVHdh9Xiyx5KJsLPsbMF2jz7Hgg92HTtykqegIKlb+eni7VQkun+FCTSylXD6eg4w505q5tg5tjUj+xp5ea1d+KMQ75qUnw/yRvaeISpsIhp9R3j+kEV3AoB1kFN9Q+ZWA3MIHMEhE4qfYxzUt9OENM78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzP5VLYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991C4C32789;
	Wed, 12 Jun 2024 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718193758;
	bh=7ikxE7YKUM0cgX9yTna/sAPGY8vV4ozbWDKEo9rSOsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UzP5VLYmsSEmKwtSE4uhcC6WUW5pX2G5rTvC9PgL8LfCRJMWArzQeZUsn7ZGyMX67
	 mgAXZM0dxparZZxyCEVRwvZJpn9XXW0HdFSbMSEam5GzEXuW7njvPCRnydMsB8/EwP
	 HtWk4CGx+TGZpl+SGwTx9Fn0NQifi0F2kecxDsGkZDM0H7IYcRDKrN9Kmh+SnpPUqP
	 rJCipWQQYyVaQVrZzZBdOpMDVhnBLVCSzEiY8uWmVzuAdynrdZHDl/iTtqpNK630b6
	 kIwpMYWijaByKgY5aBpLaaP1kdX3jRTI0W1D8UHI0OCZpIkpHGe1pnh14pNLZSo6sm
	 lX3D49DgMzL0Q==
Date: Wed, 12 Jun 2024 14:02:35 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v1 0/2] uapi/linux/prctl: Use the L and UL integer
 suffixes for certain constants
Message-ID: <5azjsve4tinayjhcm3dtcsym2yu5nxoj4ydimiqyvcbdbrwvwy@nbicn2c3y7zr>
References: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
 <20240528114750.106187-1-alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="au75557q6fu4mtbl"
Content-Disposition: inline
In-Reply-To: <20240528114750.106187-1-alx@kernel.org>


--au75557q6fu4mtbl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-man@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v1 0/2] uapi/linux/prctl: Use the L and UL integer
 suffixes for certain constants
References: <x6r3yc6l34g4k5g3tm6ywecdqux54xlpid7bp2fa7hvm43luc7@6fjgaxgm5uyj>
 <20240528114750.106187-1-alx@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240528114750.106187-1-alx@kernel.org>

[TO +=3D Andrew, Palmer]

Hi Andrew, Palmer,

On Tue, May 28, 2024 at 01:48:05PM GMT, Alejandro Colomar wrote:
>=20
> Alejandro Colomar (2):
>   uapi/linux/prctl: Use the L integer suffix for enumerations of width
>     long
>   uapi/linux/prctl: Use the UL integer suffix for bit fields of width
>     long

Ping. =20

Have a lovely day!
Alex

>  include/uapi/linux/prctl.h | 186 ++++++++++++++++++-------------------
>  1 file changed, 93 insertions(+), 93 deletions(-)
>=20
> Range-diff against v0:
> -:  ------------ > 1:  eb1cdf3e2f33 uapi/linux/prctl: Use the L integer s=
uffix for enumerations of width long
> -:  ------------ > 2:  16f5bd565191 uapi/linux/prctl: Use the UL integer =
suffix for bit fields of width long
> --=20
> 2.45.1
>=20



--=20
<https://www.alejandro-colomar.es/>

--au75557q6fu4mtbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZpjlsACgkQnowa+77/
2zLZUQ/7B1lDRGMGZqz8xvk1Y9NzcV0HS1NNQ7PFyNhbKF3DGwzPEE/tfsEZmZtO
4nqVFiOAvcItcZIPeelucglDGOvjn9LKt4obSB4SR5bdOFw387nkO6+vXUdXPpeh
PXux01U2/sHfdwaf6VUNEYez5kE+9kyBlxGFnp0DdKXM5kj34pe3w/gXpn8IXlEn
jX5wVSdGHuCkrlcjdeLAXglzOZGel85RqhNp4jItCmOWvX+AjjguFykmFadriAkI
xYn6ijSTowqjcvCCLW/RN3O2E/r5JoUQ3esr1/xqsxXCvXC/2xyusLK1GTHcByRR
LWxw3/JnC5qhcNNfQiHS+RF4/DzeI7iU/E6WlRcpWm/9qs1ucx5UMX3Rmkcm60Ww
E9/LqHCbvmME0BAAKfC2uPpuqqxJZKrAeQlIIWkXDU1zTy4ZGqVGMSMssZckECFm
bvz7FgdUP5DUvwveibyZrAfIGZinvY53CAHqk3n8r3485yapJRd+2EihIt91ZMjd
jfUHfgPzirJJ8eMgkOzBsWmjWOBiwFSh1EILPE+su6AgSoCctcE3FnM+7wnr3+Et
agjJk6hVuHCT2I3URjFHCwV9+hsHT6E7d3hx2GnnKuE1ToXgyd0AnQZlkpgefo6h
9YSgJPeVqFDONg2uA55L1ZPK/3oD6YvniuX7sl3Z/gQ0SCPyjm0=
=y9CX
-----END PGP SIGNATURE-----

--au75557q6fu4mtbl--

