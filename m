Return-Path: <linux-api+bounces-1092-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C9586F4E6
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 13:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C2E2834B7
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 12:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEBBE5A;
	Sun,  3 Mar 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evzYQKTG"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC385BA28;
	Sun,  3 Mar 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709470544; cv=none; b=aLHTH8RDjI9feU0XZUWNPkRip97WNSXZcRE53YUnuYd5ZA+mvwYUs4ulymvucaKE4W9cla6v4JMOHv7Lz74BMO+F+j86FSh6LIZmhcDoQzfk2JLPeVtqbHwSiDGNBEU/1t47uo8Np0GQFrYgZBTg1qq3O/1LdngY0mC5iVWCbSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709470544; c=relaxed/simple;
	bh=tbjznQp1TMa3qa6QttUuQeP3JuKn9zY+RcB0hJaCAtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBkp3n2gHHuutyf+6dzQmkEupXz6rmlxOfL3LdP8hVnvNrSFiTJGxhqlkI/n6kX7obhNCg62VjXhRQBsnS1jU2tPKBUBFLJEGiQEMvYxl0OEQmRk+Bmf6QKXMRjuMmdzHeAGCRiq78ytqm6SOdwipDj3Mnpc7bQA3c+v67rZ5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evzYQKTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15716C433F1;
	Sun,  3 Mar 2024 12:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709470543;
	bh=tbjznQp1TMa3qa6QttUuQeP3JuKn9zY+RcB0hJaCAtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evzYQKTGsDsZkVOFj7yL7ZxUuzJK/e4AIoWhRTB3X67en29FTkloABq6UGNeTrL0G
	 4bMBdLYS2PsLco34Y/zWX2Gb2pC4Qf4y8gu/+AnhIE6ueoCvWMwtJUscp41J4ArRqr
	 QiSd6twCiOGbqiUFHk8yNxNLeZfz/g6z9ASN9EbmKq+1z04xM77zoa2cIVSvHLWzYJ
	 j0aeSTnmMe1ZescRqEB3r+OoZYn/yvjsGUToALqOc4XopAFA6ovwXIAjgGRLfq0dc4
	 05HoOeF5L4qDNGzhomuP2cjIhS1E6fdUTSZXMpJr6bMnyKC3Kp/aRavPnTCv8CuUDo
	 saUzzKmBqUDVQ==
Date: Sun, 3 Mar 2024 13:55:39 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Bruno Haible <bruno@clisp.org>
Cc: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>,
	linux-man@vger.kernel.org,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration'
 rather than 'request'
Message-ID: <ZeRzS6mENO8kOh1W@debian>
References: <ZUIlirG-ypudgpbK@debian>
 <20240303121454.16994-3-alx@kernel.org>
 <5882437.otsE0voPBg@nimes>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="foKSLDGBnwV0KX7b"
Content-Disposition: inline
In-Reply-To: <5882437.otsE0voPBg@nimes>


--foKSLDGBnwV0KX7b
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Sun, 3 Mar 2024 13:55:39 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Bruno Haible <bruno@clisp.org>
Cc: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>,
	linux-man@vger.kernel.org,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration'
 rather than 'request'

Hi Bruno,

On Sun, Mar 03, 2024 at 01:45:37PM +0100, Bruno Haible wrote:
> Alejandro Colomar wrote:
> >  man2/clock_nanosleep.2 | 20 ++++++++++----------
> >  man2/nanosleep.2       | 12 ++++++------
>=20
> The change to nanosleep.2 seems mostly fine. Except that the
> term "requested relative duration" (line 142) raises questions;
> what about changing that to "requested duration"?

Yeah, I had doubts about that one.  Probably I should drop 'relative'.

>=20
> The change to clock_nanosleep.2 seems wrong. There are two cases
> (quoting the old text):
>=20
>        If flags is 0, then the value specified in request is interpreted
>        as an interval relative to the  current  value  of  the  clock
>        specified by clockid.
>=20
>        If  flags  is  TIMER_ABSTIME,  then request is interpreted as an
>        absolute time as measured by the clock, clockid.  If request is
>        less than or equal to the current value of the clock, then
>        clock_nanosleep() returns immediately without suspending the  call=
ing
>        thread.
>=20
> In the first case, the argument is a duration. In the second case, the
> argument is an absolute time point; it would be wrong and very confusing
> to denote it as "duration".

Hmm, thanks!  I guess we'll have to keep 'request' in clock_nanosleep(3)
unless someone comes up with a better name.  Elliott, you may want to
partially revert that change in bionic.

Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--foKSLDGBnwV0KX7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXkc0sACgkQnowa+77/
2zJcPRAAoDaclkiNtALSBk51/1ZsB1MtmAWXjJFFA5p5HSNTmcNZ+0Bg+sXTXTpk
ypiQ4WZ6Wrd7gSgfeTj1ROQ7qycCwH3L5f8eYNMl9KtSSHmGDEbvTUkzUk+S1uKq
pVCnmx72Enh/jQ+vkHuP2APDWauH9THIPQhvDDgiEXpUMAGoFBS4SdBNrUf5id6P
eP7YzJXNqZF+ZpSpAI7jnMAOajPZSvyS0SnkZHn/ZJzOWz7cz4fZ82to7j3RZJuP
bMXu/E9Q4uJpf1wj2vV1yOfvIeCb0+YfAE/dNZjyaYn29TxRYFd8UQN0oHc9+5Ru
y/zVnG5fvXsRwu6jEG1v3pb7EbAJPeiMTL9Uk2L2uO3erqgJzD3QVqwrl3V5PCD/
qKWHDqP61gls7GjGsYO0nFw4Hg9L1GNV1PrbU6uZiF/DNZhyQQC15ykTJClzIUHr
cPIlurm+HPtKKOeVoMJLJawPuGA7/idgB3SbOACJmNE9KRfuQ+mMGIo2Vi1EiS2g
I5UP39SutuNx5dhLG4FSYskMAYmY3x9UKWenfAuHvBjhsDZAxXyjzwL23cJloZD0
xFfEBsOHY4w2R/r1uck94g+8nMt6O13HqOx0MXMwUS3E9tngZRMJrZEN93+zaY5O
CLRNVE6l+vEnP31q4U54Dhc9OjOd3m85hG0OlPx7lsjyFJ3jM1Q=
=XkhR
-----END PGP SIGNATURE-----

--foKSLDGBnwV0KX7b--

