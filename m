Return-Path: <linux-api+bounces-1723-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA5905682
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0B27B283C5
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 15:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A44181D0E;
	Wed, 12 Jun 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP/MAU2s"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4B181BB9;
	Wed, 12 Jun 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718204881; cv=none; b=sGe3nO1DarEUjF+ecsxBF1WmTcita7GYhPezTAS9O7zsDqnHQHkSTWZsRA8mF0DjG+Ug+15NbixvAIcceKqQtHIhTpWl11WrO4iqQHEd42dcwATVVHq4t4Z1g+5VFw24KtnV/+Jz8Yb5YUCFtlf1tLklfarZoaal202i4dDztNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718204881; c=relaxed/simple;
	bh=K07trwj7udv3HyR7GkYDWIorvePD6kxkcC/UqWfcFms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ri+O00WK7/ox99oNondJU+dvo2D/cBroeufz9cAmeBi0UbD26wKOsr1sVha5S20v/Nnjz6PG0Y8NsqqsZI04SH/9vQn5Y5NPEsTxh3mLGah5PwG/CoqXKK93OsotQE4jtvfHpX7F9ur7CFiqTyQg7OuYnyXKsVh+CAKkqi0ONvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP/MAU2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ED1C4AF1C;
	Wed, 12 Jun 2024 15:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718204880;
	bh=K07trwj7udv3HyR7GkYDWIorvePD6kxkcC/UqWfcFms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pP/MAU2szf5F6V6nyuYH7k/OPaxji5eYOB9b89g5jYzWFlHObGWdAsUVkVB4aR3WC
	 R4Ki5h8XOi9EOdjs0WuGj2slvsWe5MMQVoENWPYtHN/nbuzdWuiaGSCOVCm45kP25e
	 DkByqApXGXAGLIpKde+L+h3Sp/hkx9jTIfQAYcScMO+PRopQCGsiBZYix0ThGZSqlI
	 T+qzecnmFnVo0YdJ5m008PWtG5POqDQz2JQcGlRjBzSVggH2wmfTzmDYfNvLKOW70M
	 nd/kg7fqIylDuI9FSy0iMH/h/bSt5J5ZdHGFAc9awH2groT91JxR3e0TrL4as1py35
	 +jvkvmyxF+j+g==
Date: Wed, 12 Jun 2024 17:07:57 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, libc-alpha@sourceware.org
Subject: Re: [PATCH] uapi/asm/termbits: Use the U integer suffix for bit
 fields
Message-ID: <2pidbxaqueutqekele3bc5cp7l64aodvpz2sb7nmdaanxo7ado@cozt6nahapwa>
References: <2024061222-scuttle-expanse-6438@gregkh>
 <20240612131633.449937-2-alx@kernel.org>
 <2024061214-absolute-deranged-14bf@gregkh>
 <tkfp53faunf5jlszu5k6jwwxgsl72faffiux7c3pykmnowapy6@wap3bvtvoebi>
 <2024061223-saddlebag-gallantly-c35f@gregkh>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cd6ct4cnap6y5ej5"
Content-Disposition: inline
In-Reply-To: <2024061223-saddlebag-gallantly-c35f@gregkh>


--cd6ct4cnap6y5ej5
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
 <tkfp53faunf5jlszu5k6jwwxgsl72faffiux7c3pykmnowapy6@wap3bvtvoebi>
 <2024061223-saddlebag-gallantly-c35f@gregkh>
MIME-Version: 1.0
In-Reply-To: <2024061223-saddlebag-gallantly-c35f@gregkh>

Hi Greg,

On Wed, Jun 12, 2024 at 04:21:25PM GMT, Greg KH wrote:
> On Wed, Jun 12, 2024 at 04:00:18PM +0200, Alejandro Colomar wrote:
> > I expect that these specific values and the operations done on them
> > probably don't trigger UB, since the shifts are done by a controlled
> > amount, and there are justa few operations done on them.
>=20
> These, for the most part, are NOT used as shifts.

Quoting the EXAMPLES section in the manual page:

	tio.c_cflag &=3D ~(CBAUD << IBSHIFT);

(And yeah, that shift is presumably controlled, so that it doesn't
overflow, which is why I mean these are presumably just fine.)

> > TL;DR: The kernel isn't broken, but improving this would allow users to
> > enable stricter warnings, which is a good thing.
>=20
> Enable it where?

I meant in user space programs that use termbits stuff.  (That this may
also allow the kernel to eventually have stricter warnings, I don't
know.  It might help.  But mostly meant it for user space.)

So, if I have a user-space program (or more likely a library) which
wraps these ioctls, I'd prefer to be able to enable the warnings I
reported, to preclude any mistakes in my code.  That would need the
constants to be unsigned, to avoid false negatives.

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--cd6ct4cnap6y5ej5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZpucwACgkQnowa+77/
2zKIbQ//QcaN3uSVmE7y8sXus/WOQBQM4F6N/Xrz/My8l0UqqbWqzEW7Uoa2kTQO
8wqsccSxKYiGZPVf2Qf/Cjt5SSyVlHaxk/sGDga4Xnghcr8yB6ddVwwUXWenBGvD
GS8T9+ObLrCMVyId8sSJEjswxka/bqApjfJ5AtEvaXGlrYjKyzljP/eScQMIwSwW
hjL9YaKmjuoLNe5GRrhddwIvsVMcb6mge3I+un+Sq8kIylj8zKTUR2g4ivzhOgIt
JLxK3gVxCYabWpOr8zsa9VfCqDNgtHl+gaUillcOvyNJCZbkxPo3OnDRxdiCfAFE
Gt7+d6C+OCbOwWoXROuXiAyI/LOcPwk40sf9wSu7Mi8KzITLaHgTLwYMQRFfOCaH
8uVqGsh8ox1DZ1/b+Gu/d/vpyTFAFZ86tk2iqvfR64jiUlOG5Vtpp+N4afV7GdRs
yQinoWumlVvXA4g1fFA6KJqwNPAO1pScHFRZ81fwk81L56q8mC2YHtUDK40eD/On
MjeH9vd9MNldfgdZCOfg+3hXzjEHOVp9PHjFcIPnR62pg02Zk3AvmdtVjuBAs5zK
8BgkzuPcKcRMLcDUkxgsboSpAJ+mFk8jXcTpc02yp+3bcsAmYTccIUS1YyzgG3DC
19JRpIHoyPwHLR7iMT5PR59/820WLd3rx3kwRiPfFbQa2D3Carg=
=+enL
-----END PGP SIGNATURE-----

--cd6ct4cnap6y5ej5--

