Return-Path: <linux-api+bounces-4642-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52505B3974C
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 10:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12E5F3A4F69
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C122D29B7;
	Thu, 28 Aug 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ALiNNWAe"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471A32C8B
	for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 08:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370603; cv=none; b=dDfqhHTPESL65UMGrajVQU43OeJimcbbRUg9Q5triQVJj0Fg7aCk2mUy6Aw3/bzN0qrnWsqCCvrwggQrIgEH9+KroncdFri66DZM+2yGE0xOAgYnyJr1nSpgte9MdSuWqDKmMuzaUCwx0j67LtBVIaiSgIUsC5R6FFMUP3Gy6ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370603; c=relaxed/simple;
	bh=+oOxdBT4OkUn6ezwiccY1TENdg29/a7CwdRZF6Fk9WA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n95i17RRwcmBgPK2Nepagau9+gGyE907xBfa2eJBNRyQfRVlB1RdtxtDKv0i0Ve52832KYr3E9OK0GSL+SkKwzPwX8QCZ5owyv71+yMoQIRlllcBB4UgvVTENB7up6h26ZiRavBCrTa74+8s9ATBGeraGMGvY1ytyTThefDj2C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ALiNNWAe; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cCFKW0fBsz9thm;
	Thu, 28 Aug 2025 10:43:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1756370591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oOxdBT4OkUn6ezwiccY1TENdg29/a7CwdRZF6Fk9WA=;
	b=ALiNNWAetZnEf7Q2A91AcZW9nqbaDYFZXz1b4OjD+F+LZ5he6X16CK06ClDkvGWRu9e95W
	/g4VJ2XJikkkOme93BROgIJ63FRnsdIGfxX6SGjjDx3fGVFm0eXi/JTVBWMtIQag4NZFfr
	HZWWPmG6LV2AYSW6HxmJdCdaudu0CH49ENkhb9adKEvRaMz44hNivKU1sO0GovecBPpNmG
	H6PLdupMy7Cx2pbHy77BhcpHA02fnTLv0hqFdmjEO6i/4qRuq94cJPx9h6gbh4crK4C1lg
	FZaM3RKWn4HONHw6xPzyPfWR4T/xsgZTIxNScEfJsRvxo3yDty/O5ZML3jk6DA==
Date: Thu, 28 Aug 2025 18:42:58 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Arjun Shankar <arjun@redhat.com>, libc-alpha@sourceware.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
Message-ID: <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
References: <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org>
 <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu>
 <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu>
 <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu>
 <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
 <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xhjdcce3t6jua43y"
Content-Disposition: inline
In-Reply-To: <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu>


--xhjdcce3t6jua43y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
MIME-Version: 1.0

On 2025-08-27, Paul Eggert <eggert@cs.ucla.edu> wrote:
> On 2025-08-27 15:48, Aleksa Sarai wrote:
> > On 2025-08-27, Paul Eggert <eggert@cs.ucla.edu> wrote:
> > > What specific scenario would make the "give me supported flags" flag =
worth
> > > the hassle of supporting and documenting and testing such a flag?
> >=20
> > "Just try it" leads to programs that have to test dozens of flag
> > combinations for syscalls at startup,
>=20
> Although that sort of thing can indeed be a problem in general, I don't s=
ee
> how it's a problem for openat2 in particular.

While O_* and RESOLVE_* flags are trivial to detect (since you can
always pass -EBADF to force a non-EINVAL error), my goal was to have a
unified interface for extensible-struct syscalls in this department.

> The issue here is whether openat2's API should reflect current behavior
> (where the HOW argument is pointer-to-const) or a potential future behavi=
or
> (where the kernel might modify the struct that HOW points to, if some
> hypothetical future flag is set in that struct). I am skeptical that this
> hypothetical situation is so plausible that it justifies the maintenance
> hassle of a glibc API that doesn't correspond to how openat2 currently
> behaves.

I mean, the kernel definition doesn't mark the syscall argument as
"const" so making it const in glibc also means maintaining a divergence
=66rom the kernel. Of course, glibc does this for plenty of other
syscalls so it's not my place to say which is better.

My intention was just to say that this *was* intentiona (which was how I
understood the initial question that I was Cc'd onl, and if you feel
that intention is misguided / doesn't mesh with what glibc wants then
that's your call.

> > A simple example would be mounts -- if MOUNT_BENEATH is not supported
>
> I don't understand this example. Are you talking about <linux/mount.h>'s
> MOVE_MOUNT_BENEATH? That's a move_mount flag, and I don't see what that h=
as
> to do with openat2. Or are you saying that openat2 might not support
> <linux/openat2.h>'s RESOLVE_BENEATH flag? Under what conditions might that
> be, exactly? Can you give some plausible user code to illustrate the open=
at2
> example you're thinking of?

I was just giving it as an example where "just try it" is not really
ideal for userspace today. clone3(2) is an extensible-struct syscall
that needs this.

> I still fail to understand how a hypothetical "give me the supported flag=
s"
> openat2 flag would be useful enough to justify complicating the openat2 A=
PI
> today.

My only concern is that it would break recompiles if/when we change it
back. If that is not a concern for glibc as a project then you are of
course free to do whatever makes sense for glibc.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--xhjdcce3t6jua43y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaLAWhRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+LzAD+KxXlKtNBD0CrWOfa/tsL
M7kDWDq5f1dU5mjlxq2hs98BAMWpwyJNiI5BNYSp0uqwwXacDzhSQFw93DFUPp2U
ix8I
=UOYN
-----END PGP SIGNATURE-----

--xhjdcce3t6jua43y--

