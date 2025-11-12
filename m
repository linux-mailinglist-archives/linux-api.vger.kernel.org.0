Return-Path: <linux-api+bounces-5238-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED65C51F4F
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 12:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900651886F20
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E62EFD9E;
	Wed, 12 Nov 2025 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caa79Mnz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0462F2914;
	Wed, 12 Nov 2025 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946596; cv=none; b=oiJaNR7RegK2xnOqtDKBFtR8F+3CzLtt7B85UrXX6YJxNP/ddjZCub1fCFJwKg8x3yCPtlCVc7HxZuYWVFfNBvwf8gO3Zkm2qM7tnwGaDbgOTFod5idkQ+p/cRkpg4FoCFPC7r83AnWYE+oYrHB+PWjt0o9I1+AH86HLcw0MI0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946596; c=relaxed/simple;
	bh=bSNcyT/ZtZVDvtc9REjktWiRGmnKOUu4x5Vw7X2+x3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coHrKH/NZugzLA/NvhSfET7illMv+g9gNd4XWbgMKblZV1ij21KuCqr4EzxcBy2ct98HeegXDrjhmvEF75wd8Xf4+UZLNeXAjYxirI29f17Gl+JJ5taE0/SxJtuT8jZvFcFdhoMSGWVmUeuSAjlFdsc8qhGeDudQ/kriiNaDIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caa79Mnz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C795C4CEF7;
	Wed, 12 Nov 2025 11:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762946595;
	bh=bSNcyT/ZtZVDvtc9REjktWiRGmnKOUu4x5Vw7X2+x3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=caa79MnzuRCB47I8wqlrl03jC+Hbhy8QHYueZXVJl0bTyq64v8ZKdtX9+6ccoT/IM
	 U2Myw/tqVsnhGNj8Kxg7tkQqEEyV1Y1lQ6O5OqV0LpdYAwMuQVQp3JWsxqeflYRxYQ
	 aThy3Qix973opKDLCqInCLbixE/SJImorED2TqxLbKKcDmi8FyqvIHKNIQWU+p8lBl
	 G/e6RuLDug/40CEBdEBGM7v5t7Kd16k1M2XFRrCpXMajgWFGOwlFM5lvxtclzLVyiS
	 KkvdFqwwu6Mj9g5UhNBE20X3zpmq2iVKVgrmUV25inERSCcIWU//5ym/9OF9cagzT1
	 339GznedmOOMg==
Date: Wed, 12 Nov 2025 12:23:11 +0100
From: Alejandro Colomar <alx@kernel.org>
To: hoodit dev <devhoodit@gmail.com>
Cc: Carlos O'Donell <carlos@redhat.com>, linux-man@vger.kernel.org, 
	linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] man/man2/clone.2: Document CLONE_NEWPID and
 CLONE_NEWUSER flag
Message-ID: <frpbzpltwr34qs3v4mluajb2czznm3ebog34uhuj4a4qi7yft3@h6rj3y7c32qu>
References: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>
 <e2wxznnsnew5vrlhbvvpc5gbjlfd5nimnlwhsgnh6qanyjhpjo@2hxdsmag3rsk>
 <CAFvyz33t9gYOi2HtNFNC_YAPS-_0QHiqJQwatc7YsGppstiZ7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tejtrw63odgt3jwm"
Content-Disposition: inline
In-Reply-To: <CAFvyz33t9gYOi2HtNFNC_YAPS-_0QHiqJQwatc7YsGppstiZ7A@mail.gmail.com>


--tejtrw63odgt3jwm
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: hoodit dev <devhoodit@gmail.com>
Cc: Carlos O'Donell <carlos@redhat.com>, linux-man@vger.kernel.org, 
	linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] man/man2/clone.2: Document CLONE_NEWPID and
 CLONE_NEWUSER flag
Message-ID: <frpbzpltwr34qs3v4mluajb2czznm3ebog34uhuj4a4qi7yft3@h6rj3y7c32qu>
References: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>
 <e2wxznnsnew5vrlhbvvpc5gbjlfd5nimnlwhsgnh6qanyjhpjo@2hxdsmag3rsk>
 <CAFvyz33t9gYOi2HtNFNC_YAPS-_0QHiqJQwatc7YsGppstiZ7A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFvyz33t9gYOi2HtNFNC_YAPS-_0QHiqJQwatc7YsGppstiZ7A@mail.gmail.com>

Hi,

On Wed, Oct 29, 2025 at 06:00:50PM +0900, hoodit dev wrote:
> Hi, Alejandro Colomar and Carlos
>=20
> Just a friendly ping to check if you had a chance to review this patch.

I don't know enough of clone(2) to review this.  I'll wait for Carlos's
review.


Have a lovely day!
Alex

>=20
> Thanks
>=20
> 2025=EB=85=84 5=EC=9B=94 2=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 6:30, =
Alejandro Colomar <alx@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Hi Carlos,
> >
> > On Mon, Apr 21, 2025 at 04:16:03AM +0900, devhoodit wrote:
> > > CLONE_NEWPID and CLONE_PARENT can be used together, but not CLONE_THR=
EAD.  Similarly, CLONE_NEWUSER and CLONE_PARENT can be used together, but n=
ot CLONE_THREAD.
> > > This was discussed here: <https://lore.kernel.org/linux-man/06febfb3-=
e2e2-4363-bc34-83a07692144f@redhat.com/T/>
> > > Relevant code: <https://github.com/torvalds/linux/blob/219d54332a09e8=
d8741c1e1982f5eae56099de85/kernel/fork.c#L1815>
> > >
> > > Cc: Carlos O'Donell <carlos@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Signed-off-by: devhoodit <devhoodit@gmail.com>
> >
> > Could you please review this patch?
> >
> >
> > Have a lovely night!
> > Alex
> >
> > > ---
> > >  man/man2/clone.2 | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/man/man2/clone.2 b/man/man2/clone.2
> > > index 1b74e4c92..b9561125a 100644
> > > --- a/man/man2/clone.2
> > > +++ b/man/man2/clone.2
> > > @@ -776,9 +776,7 @@ .SS The flags mask
> > >  no privileges are needed to create a user namespace.
> > >  .IP
> > >  This flag can't be specified in conjunction with
> > > -.B CLONE_THREAD
> > > -or
> > > -.BR CLONE_PARENT .
> > > +.BR CLONE_THREAD .
> > >  For security reasons,
> > >  .\" commit e66eded8309ebf679d3d3c1f5820d1f2ca332c71
> > >  .\" https://lwn.net/Articles/543273/
> > > @@ -1319,11 +1317,10 @@ .SH ERRORS
> > >  mask.
> > >  .TP
> > >  .B EINVAL
> > > +Both
> > >  .B CLONE_NEWPID
> > > -and one (or both) of
> > > +and
> > >  .B CLONE_THREAD
> > > -or
> > > -.B CLONE_PARENT
> > >  were specified in the
> > >  .I flags
> > >  mask.
> > > --
> > > 2.49.0
> > >
> >
> > --
> > <https://www.alejandro-colomar.es/>
>=20

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--tejtrw63odgt3jwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkUbh8ACgkQ64mZXMKQ
wqlTCg/+JmoIKjs77NkyQp7jilf4VOeJBblO7jx8yjgz9nHCUQQO/X3T8jkEbyx/
FxuVUDX5TmoWkez/3LXyKHoqHEYtxmca9ZlMgHkhMPYrwbQAkGTw43Q2OTUxDqcM
I4bVAZfkxCWZKoti+RcquAdwVNtBuC9aIvmXQxtqh6h9F6gpMlv3kIiseG9fYzIr
p/JmwBzyzylpwnFVvpt5kMb9pCUpx2jd2hRAjtmJWOSL17VmMEJH1aU0o/3s4Ldi
YMEErB7MF42Q3llCLfstFpCVWRwGs5PirxpGYb3MqLxckTvXEFpOoVP6ryenkZOV
xhlW3Tcd3NoSZI0PWK7F2q0XhxId0ik0MYvOW0kWQI9xM46li1YmM9GnQzkELjpc
kdSCecuw0NFfinJzmlLkpzjEaMtAWrizBEXB5xWHTjUcZ9swZbsqGZNAfwoDyS2w
A+fAF7pgu9LrspoxaEYaZshCklL9Q6/E89YTZcHgwlBIr/L6C8+iGGHth1NBeuEK
x65TLlSObO2B6I4iDksA8zOdkw8mmOwP5gPgaSu+HQhbMFwjoEycJJadzofwRI0c
QW3fVNm/J2N8gCJoZEAeXPouBMdiu7FQhoe7Wdvbhh2Lz8xEFCX00lJJcwb0Kgrd
ne0U8hwdwZA0nuKVbqUIqGR2HBRbdeOxdcLWV1U3d2jSibfO2gE=
=2lMw
-----END PGP SIGNATURE-----

--tejtrw63odgt3jwm--

