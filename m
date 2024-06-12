Return-Path: <linux-api+bounces-1720-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3C79054A9
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153F12838B9
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1433317D894;
	Wed, 12 Jun 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riG2BKZG"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE41E16F0E5;
	Wed, 12 Jun 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200823; cv=none; b=QOBaopDUk+inV28X5+rZhB2IrGBviNdgB0wP/g4c/5bszAOxKd5OXPVyKDQ3XEZ/LXK8qOOuOSvlAyj90jwm4V7tC5y7wEC25mTe5jWu0h3rOPeXR12DLTCF8QuiBAxTTX2J9C4lG24LnBDotIUEuyUr2olvC7xf3QdV9NiT97w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200823; c=relaxed/simple;
	bh=5k4N38Tr/Hswa6kMpbSstF0oqqJKMQs+cMJCAXycICA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQnyMR032iIY1cHFZVtdGB5aL4icpG9Q+f4ZzSRHS104VAwKlhw9SFDcQvYi4hc6J91h20FlHFiomrRUV0wBC+VrPTcJS3jPihNe/0MH2jLbY5jW8AGgfTaQf+Ro6Np8NhOIJfrCTXt3pHynjq3ru9qFkYLDY2iNzmkz80U78Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riG2BKZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17399C116B1;
	Wed, 12 Jun 2024 14:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718200822;
	bh=5k4N38Tr/Hswa6kMpbSstF0oqqJKMQs+cMJCAXycICA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=riG2BKZGPm2DY9mMII34/ZbUxbgLvTeZXwQR1ZT7uGwZ1lN6eh0Nof85+nj7mJ1ww
	 CASscqq+xP1Cj+vNuZ3sZeAchdowepUr+nILtEB/VQ8IFrLCBA5uGGGaWmj0pobQ5o
	 JWLtV7hiIOEAxywbHor0WOvE9ZLmVu+tPjr9/zFCAJI2E28170/+vd6wz6kxekm9E6
	 EwzQRD/OK6x9eC+fqg8xTpeInIps0jdrY4uua0GJxwVPgrTBQcsf/bf9mcCJmMvO5s
	 ACNSLACI5uGMWz/KvAsm5pwZVv/cV+Qx+inVC9iG4XjxwqTunbV8VGM87ZKiP7KRqv
	 7F/kZrOAqUn4Q==
Date: Wed, 12 Jun 2024 16:00:18 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, libc-alpha@sourceware.org
Subject: Re: [PATCH] uapi/asm/termbits: Use the U integer suffix for bit
 fields
Message-ID: <tkfp53faunf5jlszu5k6jwwxgsl72faffiux7c3pykmnowapy6@wap3bvtvoebi>
References: <2024061222-scuttle-expanse-6438@gregkh>
 <20240612131633.449937-2-alx@kernel.org>
 <2024061214-absolute-deranged-14bf@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zdq3wlsbswjvh5np"
Content-Disposition: inline
In-Reply-To: <2024061214-absolute-deranged-14bf@gregkh>


--zdq3wlsbswjvh5np
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, libc-alpha@sourceware.org
Subject: Re: [PATCH] uapi/asm/termbits: Use the U integer suffix for bit
 fields
References: <2024061222-scuttle-expanse-6438@gregkh>
 <20240612131633.449937-2-alx@kernel.org>
 <2024061214-absolute-deranged-14bf@gregkh>
MIME-Version: 1.0
In-Reply-To: <2024061214-absolute-deranged-14bf@gregkh>

Hi Greg,

On Wed, Jun 12, 2024 at 03:35:20PM GMT, Greg KH wrote:
> On Wed, Jun 12, 2024 at 03:16:58PM +0200, Alejandro Colomar wrote:
> > Constants that are to be used in bitwise operations should be unsigned,
> > or a user could easily trigger Undefined Behavior.
>=20
> Wait, do we really have such broken compilers out there?

I meant this as a generic statement that signed integers on bitwise ops
are bad, not as a specific statement that these values would trigger UB.

I expect that these specific values and the operations done on them
probably don't trigger UB, since the shifts are done by a controlled
amount, and there are justa few operations done on them.

For example, a left shift where a set bit overflows the type (e.g.,
1<<32), causes UB.

The reason why it's better to avoid this at all even if we know these
values work fine, is that programs using <asm/termbits.h> would need to
disable those compiler warnings, which could silence warnings on other
code which might be broken.

TL;DR: The kernel isn't broken, but improving this would allow users to
enable stricter warnings, which is a good thing.

> With this change, can the glibc versions then be dropped to just rely on
> these instead?

I don't know.  glibc is CCd, so they can answer that.

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--zdq3wlsbswjvh5np
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZpqfIACgkQnowa+77/
2zLXOhAAkSTwy78FOu8UNgM5m9D1QafYAk8Iijv6KcNIvXaFMAJyPdWaZed8h7QR
Z+pKmlbs4lqGszV8MNl/qDpJ9e4OvvmDSK91jxJc0i3sPVLWC7SoVt5MD2SWGAGe
lAHoy1aUajNkS+qzKlqzrYjOrcpersvHpq2jNhiXBRdHfUKi450N9aEC/ko5//w7
wAF3NC285BNt/w5b6p2T1RnlrwKraiomhPy/yxiIhPA1iWrJaWTHSrRWg7P1DR+d
U1lvC+pT7ju1e4cidVKwYS/qvVHrKWQ11cOhw0H0fixSvLvfSDwShHG/JZLHlt8w
zaZH9NVBwdT16ABfebWoTQoxEzjDWzHOzeWknKU6x0YDhBuVP9HSxpv9rsJ3Kopf
uYcHrBpB5njNO6nVV0Aeckpsyb894yQCLjrl1E2Y4xImr9CdNbW6cIoQPT/HyJd3
ToANE1L51QtQP0pfKrzFzwqK2HrGX83a79n4V+N1FmONxqi+z33YeAp7/hC4/pKV
Ttrpkw3o/gMYeYw6UUkq6xPduShFshMhOh4oGgkvDPb+ZUNpU9ASk18dObry+rEh
ffoKnAKVBue06Ubg5iug7hihMHa+529+mIHxcNEWXFFG8tLQmPrrKkpyUK91h9Sj
qDbBV6aJwcAO790fpDp/pKt1ry/OKELi7kxa7jYSigd14B3rnuI=
=e8/P
-----END PGP SIGNATURE-----

--zdq3wlsbswjvh5np--

