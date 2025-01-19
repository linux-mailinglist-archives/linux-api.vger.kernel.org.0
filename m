Return-Path: <linux-api+bounces-3065-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E1A16234
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F657164601
	for <lists+linux-api@lfdr.de>; Sun, 19 Jan 2025 14:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283531DDC2D;
	Sun, 19 Jan 2025 14:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="FbBp/M2A"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E319D070;
	Sun, 19 Jan 2025 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737297534; cv=none; b=pYLbAlR0fMJ+rMw53VHxkbSQ99bXV7fNFh1AXsNrq7rB61iBgiVlHPNGnU06O0DlIGp+vZFwCY7kx5cm3/qreo313mCcXaW0e/1M6u2AEC70ZJxQBObXocJS0DpDrp9sBBqd/+BkVPyrbgcp6hiMEB4rppebQRYSyZY+756zXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737297534; c=relaxed/simple;
	bh=MZgk6rC+u5nWLo8t10B58Irih6xOkYKfBIjzCnQJYmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtVu8H0UyLi3Lg0e7JDIdn016agdICuUtk4sfW7lbRBu0r8bZ3oRxQUXD5KYqCOHcaLq/P8UAnKReLlBE8kHbWw9gOz6MAG2bVkPHABKgpyD5zosPeMEGx2UpZUwqGki/1oR6KCOgIzOnevlGxwuAlFZrybQXn3fdMN0thj20E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=FbBp/M2A; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Ybbgk2d7Mz9sRK;
	Sun, 19 Jan 2025 15:38:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1737297522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+RAr2AZAoklf3kKW/dRysmBUU1C7CX1sQI8y62h5DSM=;
	b=FbBp/M2AeY+3/AjLgB8LGUHs8E2trkx/qZNUekC2MitoNHVWj+IU3SZsqzLQwpwT2HKIF0
	b3yu8m3hXocm2LNEgSzltVBECTNaQzfUIkusRnY7hikT3JkxyxYuT0FTff4OhN4DX4FbTR
	pbCFV/9FkDk5c9CtLNlWTmvRA07q6FYm6MzlsGSw3XheLrXZgfgUwHgJ2PdeiJDzC8iXZk
	KB3MTT/qAGLZ6eDK+h2Tko2/DLefqvhp64QHEIHeFnaoTCD7fOJJWuBkfC5m6piJPOJiCS
	2bsKJUXEfH9eo2jQyOxF5KE3MeKvS0GVolWF8bFVU7mZa/HLo7iMhDFkCLHIWQ==
Date: Mon, 20 Jan 2025 01:38:29 +1100
From: Aleksa Sarai <cyphar@cyphar.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, 
	Eugene Syromyatnikov <evgsyr@gmail.com>, Mike Frysinger <vapier@gentoo.org>, 
	Renzo Davoli <renzo@cs.unibo.it>, Davide Berardi <berardi.dav@gmail.com>, 
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
Message-ID: <20250119.143414-eroded.armpit.sloppy.grease-vqf6G59KM5e@cyphar.com>
References: <20250113170925.GA392@strace.io>
 <20250113171208.GF589@strace.io>
 <20250116152137.GE21801@redhat.com>
 <20250116160403.GA3554@strace.io>
 <20250117144556.GB21203@redhat.com>
 <20250117150627.GA15109@strace.io>
 <20250117153258.GC21203@redhat.com>
 <20250117162255.GA15597@strace.io>
 <20250118141341.GA21464@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cybarqkfk2vtf2dv"
Content-Disposition: inline
In-Reply-To: <20250118141341.GA21464@redhat.com>
X-Rspamd-Queue-Id: 4Ybbgk2d7Mz9sRK


--cybarqkfk2vtf2dv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 6/7] ptrace: introduce PTRACE_SET_SYSCALL_INFO request
MIME-Version: 1.0

On 2025-01-18, Oleg Nesterov <oleg@redhat.com> wrote:
> On 01/17, Dmitry V. Levin wrote:
> >
>=20
> (reordered)
>=20
> > struct ptrace_syscall_info has members of type __u64, and it currently
> > ends with "__u32 ret_data".  So depending on the alignment, the structu=
re
> > either has extra 4 trailing padding bytes, or it doesn't.
>=20
> Ah, I didn't realize that the last member is __u32, so I completely
> misunderstood your "it depends on the alignment of __u64" note.
>=20
> > For example, on x86_64 sizeof(struct ptrace_syscall_info) is currently =
88,
> > while on x86 it is 84.
>=20
> Not good, but too late to complain...
>=20
> OK, I see your point now and I won't argue with approach you outlined in =
your
> previous email
>=20
>         size_t min_size =3D offsetofend(struct ptrace_syscall_info, secco=
mp.ret_data);
>         size_t copy_size =3D min(sizeof(info), user_size);
>=20
>         if (copy_size < min_size)
>                 return -EINVAL;
>=20
>         if (copy_from_user(&info, datavp, copy_size))
>                 return -EFAULT;
>=20
> -------------------------------------------------------------------------=
------
> Thats said... Can't resist,
>=20
> > An absolutely artificial example: let's say we're adding an optional
> > 64-bit field "artificial" to ptrace_syscall_info.seccomp, this means
> > sizeof(ptrace_syscall_info) grows by 8 bytes.  When userspace wants
> > to set this optional field, it sets a bit in ptrace_syscall_info.flags,
> > this tells the kernel to look into this new "artificial" field.
> > When userspace is not interested in setting new optional fields,
> > it just keeps ptrace_syscall_info.flags =3D=3D 0.  Remember, however, t=
hat
> > by adding the new optional field sizeof(ptrace_syscall_info) grew by 8 =
bytes.
> >
> > What we need is to make sure that an older kernel that has no idea of t=
his
> > new field would still accept the bigger size, so that userspace would be
> > able to continue doing its
> > 	ptrace(PTRACE_SET_SYSCALL_INFO, pid, sizeof(info), &info)
> > despite of potential growth of sizeof(info) until it actually starts us=
ing
> > new optional fields.
>=20
> This is clear, but personally I don't really like this pattern... Consider
>=20
> 	void set_syscall_info(int unlikely_condition)
> 	{
> 		struct ptrace_syscall_info info;
>=20
> 		fill_info(&info);
> 		if (unlikely_condition) {
> 			info.flags =3D USE_ARTIFICIAL;
> 			info.artificial =3D 1;
> 		}
>=20
> 		assert(ptrace(PTRACE_SET_SYSCALL_INFO, sizeof(info), &info) =3D=3D 0);
> 	}
>=20
> Now this application (running on the older kernel) can fail or not, depen=
ding
> on "unlikely_condition". To me it would be better to always fail in this =
case.
>=20
> That is why I tried to suggest to use "user_size" as a version number.
> Currently we have PTRACE_SYSCALL_INFO_SIZE_VER0, when we add the new
> "artificial" member we will have PTRACE_SYSCALL_INFO_SIZE_VER1. Granted,
> this way set_syscall_info() can't use sizeof(info), it should do

user_size *is* a version number, it's just that copy_struct_from_user()
allows programs built with newer headers to run on older kernels (if
they don't use the new features). The alternative is that programs that
build with a newer set of kernel headers will implicitly have a larger
ptrace_syscall_info struct, which will cause them to start failing after
the binary is rebuilt.

*Strictly speaking* this wouldn't be a kernel regression (because it's a
new binary, the old binary would still work), but the risk of these
kinds of APIs being incredibly fragile is the reason why I went with the
check_zeroed_user() approach in copy_struct_from_user().

(I haven't looked at the details of this patchset, this is just a
general comment about copy_struct_from_user() and why this feature is
useful to userspace programs. Not all APIs need the extensibility of
copy_struct_from_user().)

> 	ptrace(PTRACE_SET_SYSCALL_INFO, PTRACE_SYSCALL_INFO_SIZE_VER1, info);
>=20
> and the kernel needs more checks, but this is what I had in mind when I s=
aid
> that the 1st version can just require "user_size =3D=3D PTRACE_SYSCALL_IN=
FO_SIZE_VER0".
>=20
> But I won't insist, I do not pretend I understand the user-space needs.
>=20
> Thanks!
>=20
> Oleg.
>=20
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--cybarqkfk2vtf2dv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZ40OZQAKCRAol/rSt+lE
b6qZAP0Z6o6QgbGGhDyMap9a89Vor8PD0NrYB+ldRYt4in9JmQEA5vZwLFN5I3U/
0xtHGefEzaGJTiAg7deEbaj1mCef7gs=
=3rri
-----END PGP SIGNATURE-----

--cybarqkfk2vtf2dv--

