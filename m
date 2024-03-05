Return-Path: <linux-api+bounces-1099-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AF3872655
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 498B328630B
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42E017C71;
	Tue,  5 Mar 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDhnP0uT"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F717BCF;
	Tue,  5 Mar 2024 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662369; cv=none; b=PizNi2EOgI+L0j0h577WJKfBYXDvv9+mg0+IFyblBWJA6//2o7n09qcfcxbA3KdvyCGJQDdp6u6CsHOsk8jm2yYJbvJM6TmynNAVwnoqF0Pf9s3Vu36QkTuT/1WdJ1m5/Blw7AAb3mLt3yN804WNtPQMYhOZjPYG+9YHdAqmG2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662369; c=relaxed/simple;
	bh=UDGYgts7G64cZvfQjYM3Jk3nyX9GDSLqS5lteBHTrZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1mdNOfmB/zRUc38x/QcFCl1hFLb5IbIMf6Zk7JyxnGDnHT2jEIIMRVQctCGrvAX/1HXgLJ7X62Tq3okEBs8+76TZUB29tyEOT38SXhaweMbZ0ohAMa5hoiFPa0uqhhVbMeoPHWScTlIgJ0dbtOQiaysE319OZ3coDwZcVzR67E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDhnP0uT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93972C433C7;
	Tue,  5 Mar 2024 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709662369;
	bh=UDGYgts7G64cZvfQjYM3Jk3nyX9GDSLqS5lteBHTrZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vDhnP0uTgbAiOwVXqwAvD95HvcdFxYutyKXo4xM+6ouX92cfv/H4AUl+xDmcmaBDd
	 ZjWPPzm09ZcCj+Z+86enisfUg9fwbv4mZIW32eDPb2CeN3XBbyGP9A+6GiwEWuD/Aa
	 ENL/wncGnVJP3DANMceAq6Y6LPEdBROPqIlS7KsxB/NL50xQu6lfHZTJ2eb5R69RNO
	 ukCf4Up3Y+48GI+6+WpvZXR3i+ilADv6BgrvNCigV7rFNmMzdKxHVtlFRt9zQPf8kq
	 ogWtXR06hDwy6l37M8RMrBpHRW022iJ0sEvTSG4fzNAsj6qbhmUSExW7dsNBnf3fdg
	 dl7QDvGMv2A3Q==
Date: Tue, 5 Mar 2024 19:12:44 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>,
	Bruno Haible <bruno@clisp.org>, linux-man@vger.kernel.org
Cc: GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] man*/: epoll_*(), fcntl(), flock(), ioctl(),
 msgctl(), *prctl(), ptrace(), quotactl(), reboot(), semctl(), shmctl(),
 lockf(): Consistently use 'op' and 'operation'
Message-ID: <ZedgnagXMV5aTcsM@debian>
References: <ZUIlirG-ypudgpbK@debian>
 <20240303121454.16994-2-alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1yYLU1zDvj6ZA0kg"
Content-Disposition: inline
In-Reply-To: <20240303121454.16994-2-alx@kernel.org>


--1yYLU1zDvj6ZA0kg
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Mar 2024 19:12:44 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>,
	Bruno Haible <bruno@clisp.org>, linux-man@vger.kernel.org
Cc: GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] man*/: epoll_*(), fcntl(), flock(), ioctl(),
 msgctl(), *prctl(), ptrace(), quotactl(), reboot(), semctl(), shmctl(),
 lockf(): Consistently use 'op' and 'operation'

On Sun, Mar 03, 2024 at 01:15:09PM +0100, Alejandro Colomar wrote:
> Reported-by: Bruno Haible <bruno@clisp.org>
> Cc: Elliott Hughes <enh@google.com>
> Cc: Stefan Puiu <stefan.puiu@gmail.com>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  man2/arch_prctl.2          | 12 +++---
>  man2/epoll_wait.2          |  4 +-
>  man2/fcntl.2               | 70 +++++++++++++++----------------
>  man2/flock.2               |  6 +--
>  man2/ioctl.2               | 30 +++++++-------
>  man2/ioctl_console.2       |  8 ++--
>  man2/ioctl_fideduperange.2 |  2 +-
>  man2/ioctl_getfsmap.2      |  6 +--
>  man2/ioctl_ns.2            |  2 +-
>  man2/ioctl_tty.2           | 10 ++---
>  man2/ioctl_userfaultfd.2   | 10 ++---
>  man2/msgctl.2              | 16 ++++----
>  man2/prctl.2               | 84 +++++++++++++++++++-------------------
>  man2/ptrace.2              | 60 +++++++++++++--------------
>  man2/quotactl.2            | 34 +++++++--------
>  man2/reboot.2              | 19 +++++----
>  man2/semctl.2              | 22 +++++-----
>  man2/shmctl.2              | 20 +++++----
>  man3/lockf.3               | 11 ++---
>  19 files changed, 217 insertions(+), 209 deletions(-)
>=20
> diff --git a/man2/arch_prctl.2 b/man2/arch_prctl.2
> index bbb85866c..680d36395 100644
> --- a/man2/arch_prctl.2
> +++ b/man2/arch_prctl.2
> @@ -14,8 +14,8 @@ .SH SYNOPSIS
>  .BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constan=
ts */"
>  .B #include <unistd.h>
>  .P
> -.BI "int syscall(SYS_arch_prctl, int " code ", unsigned long " addr );
> -.BI "int syscall(SYS_arch_prctl, int " code ", unsigned long *" addr );
> +.BI "int syscall(SYS_arch_prctl, int " op ", unsigned long " addr );
> +.BI "int syscall(SYS_arch_prctl, int " op ", unsigned long *" addr );

[...]

Hi Elliott!

This is already in master.  Feel free to do a similar thing in bionic.
;)

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--1yYLU1zDvj6ZA0kg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXnYJwACgkQnowa+77/
2zJuQA//aSMde/Q28K1nEjLa86RS6oF8Y9lcT5y/6Dn5N/gc7YshFTUWhEJUifJM
2C+zT3txM1NVSeSw0lZaMh5XSEEAvaIxLIaiZ82f2AVytaD5SDmV3ljPb78C8LsJ
ehpj6c5y7A0J+fgatWOfHQWb29NeEw1zSHQ2YeSnN5cPho1M7NBmRv1/MCNGbYP9
mxwWgvegvC7NNFet52O0zWs+fCZPnJsi28yfQ/EYqWBBeHr2n88a9YnqlC7yvS8/
VPbOj/zi5nI3xZB/RAMmXdC0CTG9/oDC8MpBHgtqnaAaUp9kT5mHTURTQTlHPeqr
HTFAwQt7NI4PVTPvler5zwGjILCv//fqGe73J+gBzE7ZILmRhrARhyaBAUI4r4Cn
R11kIqdXZB91rkpA0bk7C/cWgqjcb3mmKcom70EknYemkMABnrEDhi4dYDluPzqk
UMkEZVT2dfyT4fabKFSeaRZzwNB+q5DrZaRSOU+lqi7s+8+gr2xeu6Xst4zDaGPN
2072/XIn2SLE2ZSbx3nPprjgszrTRUnlXDb2eLIp5a0uQIx2e7zrOU3TgvKB+G+Y
44AxeOxPH2WErNbk8w6J8F6RmRqyekxmnfZrpZc+PhJD7ADrK9A0+hNDgw0gdHyG
wzDK/ubVX6L+XNt3nrhpc/fYRvKu4GWwGSFEiUkiVKTGPNrQQvc=
=nHc/
-----END PGP SIGNATURE-----

--1yYLU1zDvj6ZA0kg--

