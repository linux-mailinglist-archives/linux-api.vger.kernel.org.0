Return-Path: <linux-api+bounces-1096-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E12358711BD
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 01:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF721C21B39
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 00:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F002F34;
	Tue,  5 Mar 2024 00:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8ocmm/C"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DDD7F;
	Tue,  5 Mar 2024 00:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598860; cv=none; b=jsL92FQj+qpNSNpPQCDOhT/WpW9bD3SYtJVorja2ZFX4IUsSfMl0F4ptLfgZ9vrWfB0FXIyptrsslhEZ6Zil5WWQOrwJybYaxcfIZXtn9VPgZsFjt8bG6PniAckuhavlFqgbLwYpiU9IHNnp/Hm2SfxQO05UaUGTVIoQMc5WkT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598860; c=relaxed/simple;
	bh=Y7xIjAkHwqx73u3Wv9gdknrkSHg9jkJ0h1PMwhNRtlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PwTvmJTVrBBxDpE2sqZmN7fz6PK4B0ACSxD7BOPWBG9ngacVvcP95uLgBnXhXp9X7cVg+pOrG6fQ2Nbqd7/klLGgqYySWIJZ04vRZJDwNnK+Tbg+ZLelcXi6po7lo2V30S8d9gQMqYpANi4V2AF10hn3HzlCtP6QM17eRtVvv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8ocmm/C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57875C433C7;
	Tue,  5 Mar 2024 00:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709598859;
	bh=Y7xIjAkHwqx73u3Wv9gdknrkSHg9jkJ0h1PMwhNRtlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8ocmm/CcfiYXZfs0zm50fEc0kIumiPohWpHOvSJnmXqA/XKFxkwW6C6EEonrcW7W
	 g2ihFCAUYJyfAqj3NS8QVkq74mabkrd7h4Jh5pJqTaEe389X0k7a1r8nWhndqW4Zmm
	 dWsiBEhJ6jVIPJDmCFnh491NHBlMEfDnVOcIcSd8Q6plvwZJoLO/afrsXofHImDP12
	 TuISVQhtFZK1K4lJ4zN46P+CwgpaPnMcHxfsQfir2Uu13GU8XKlqNnE5IxIUJ9/ji3
	 KHwfZO9se35YMkznozpbRJFFK0i4sNMvzS+ZWQALq3C7kQ49sl5UPBkcTAZ3cWbSAM
	 A/w7WE9f1CY6g==
Date: Tue, 5 Mar 2024 01:34:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Bruno Haible <bruno@clisp.org>, Stefan Puiu <stefan.puiu@gmail.com>,
	linux-man@vger.kernel.org,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration'
 rather than 'request'
Message-ID: <ZeZohz1sLcIN6kxA@debian>
References: <ZUIlirG-ypudgpbK@debian>
 <20240303121454.16994-3-alx@kernel.org>
 <5882437.otsE0voPBg@nimes>
 <ZeRzS6mENO8kOh1W@debian>
 <CAJgzZor8TTSysM=TiTXQdVtHMZPQWu5YOhPmb8PAevdVd-c31Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jHmzEy/ZZyJFCVCp"
Content-Disposition: inline
In-Reply-To: <CAJgzZor8TTSysM=TiTXQdVtHMZPQWu5YOhPmb8PAevdVd-c31Q@mail.gmail.com>


--jHmzEy/ZZyJFCVCp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 Mar 2024 01:34:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Bruno Haible <bruno@clisp.org>, Stefan Puiu <stefan.puiu@gmail.com>,
	linux-man@vger.kernel.org,
	GNU C Library <libc-alpha@sourceware.org>,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration'
 rather than 'request'

Hi Elliott,

On Mon, Mar 04, 2024 at 04:18:28PM -0800, enh wrote:
> thanks! https://android-review.googlesource.com/c/platform/bionic/+/29870=
70
> changes to
>=20
> /**
>  * [clock_nanosleep(2)](http://man7.org/linux/man-pages/man2/clock_nanosl=
eep.2.html)
>  * sleeps for the given time (or until the given time if the TIMER_ABSTIM=
E flag
>  * is used), as measured by the given clock.
>  *
>  * Returns 0 on success, and returns -1 and returns an error number on fa=
ilure.
>  * If the sleep was interrupted by a signal, the return value will be `EI=
NTR`
>  * and `remainder` will be the amount of time remaining.
>  */
> int clock_nanosleep(clockid_t __clock, int __flags, const struct
> timespec* _Nonnull __time, struct timespec* _Nullable __remainder);

Hmmmm, that's the best name, meaningfully, I think.  But I've been
trying to avoid it.  I don't like using names of standard functions in
identifiers; it might confuse.  As an alternative, I thought of 't'.
What do you think?

Have a lovely night!

Alex

--=20
<https://www.alejandro-colomar.es/>
Looking for a remote C programming job at the moment.

--jHmzEy/ZZyJFCVCp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmXmaIEACgkQnowa+77/
2zLRFQ/9H4o2zyHRYlCxmNZo9/g++mxVJc1W16zvuYjlCBvHwV/J7NMfFHtlv/B8
FpV3CxgDcg6kwjqDjyDQ6yP15jCrOJxyGIGJzX0+t5IgbowBwsmv0W208yEADWE6
EAySaxF/cW1UebNfgUHR/OIUMWtmyF02EZbnyvVd+2ioW/AG/tVaulgKnF+O/DzZ
DQPL/uIqECojCvBxgl1ujqmLv8DmLVMD4yksZ74UDW1Kv3ZBVa3D3qyMvqppFOdc
0JZ/cPSAllntncs6aSShCalw0/rAQDLYfRj5u4X0vYsEA5pEuSkS9fBR7uWFyecg
jMkdBZOe0fAyDjbmXVtj/czvqc8sHIk7XuO2kZ3j4wghY7ah680kTVD7ROvoyznD
bQvANHkl8R9I3GEjBlqzgf690IgcpB/T2LSdENqx1QG6T/bHLjb0uNK/O18Sf7Z/
IGCkZlapdvq6b0di4j/WbFCkmxyMVaaJNLIRHlZ3t4LPDxzWkf+v2xUQAiFqyiOq
w4mBcDT3+2T6p20X/t9oD1TSiVl639Qt+792Dk7wik0DKEX3SOFO7IXyCgR/2f4W
dAra0SJlyXXHczbD4Qv1jfZwFByofDR5aziaqPNyzVJNFoBYVLD2aad1SPClOopV
KC3Szl6RWOXGM9NJxZrEEcTDVz6I/pNZ73yek49g4G5JMLS/AHo=
=yMfe
-----END PGP SIGNATURE-----

--jHmzEy/ZZyJFCVCp--

