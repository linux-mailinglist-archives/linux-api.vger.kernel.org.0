Return-Path: <linux-api+bounces-3577-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBAA9A2BE
	for <lists+linux-api@lfdr.de>; Thu, 24 Apr 2025 09:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E9FC1945D11
	for <lists+linux-api@lfdr.de>; Thu, 24 Apr 2025 07:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897C91EDA1E;
	Thu, 24 Apr 2025 07:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7+fxU0W"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD11E9B00;
	Thu, 24 Apr 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745478006; cv=none; b=b6V/WuRtVl4eFDlsbnvEKpmg58W4/5eLeG0N5L5SQ67f0TAS+szmaftGkX5vdC+JqOufIGQ0NrT4SPpq6bw1G+kGL6hW43Y5x2k/WdzkQX6BxKPmJJAs/MxJrsG6aSy6Yy2wrDN9B7Mz33F/6ZlSVw+BM++j7laftNcrqeX6+ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745478006; c=relaxed/simple;
	bh=dXgeh9BQ239dSLOAJtwEOYONOG0D+bAje9JvKYXxTuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1gJyXQAhxanLJanVNZ+Fj1hrfVwLvikTvqwrmG8PBGUwQENOE3PhbDr1hYqfR7tFd6ThKdNohe5Sef+artxtGA5R36PHzPiqoNnfbk5OH1BbjLynfG2Ize6tIE2H6KYHNkh2EKRkjmvNMBUO/MyS8I4QAFzbbPSlgi4MqpU7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7+fxU0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49303C4CEE3;
	Thu, 24 Apr 2025 07:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745478004;
	bh=dXgeh9BQ239dSLOAJtwEOYONOG0D+bAje9JvKYXxTuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M7+fxU0W69+EtYNS1eeS/VO/RtKc09i5Z8JS/2/RxVuhby8yfBCaEshh+9cya4LSn
	 lNkfZyUXuACT3KcWJFx/IClMjCZQeXVKO7IlTPqq1ArMiAw3wdiRQtA/42HT5eCl/7
	 RwKEgPtrOOvOkwTeMj63qIcG3Bj05EofWVCebJx7WJW93LzYPJjFvflGXvH3XmPoMo
	 mLWm/TI4QoocXLOUccbCYfybT6QNPZaL/dENRLSQReU9AcSY/DcV5U9O1sfPk8SgTN
	 CKK3nHzOMmbQpW1FkAb+NiOW0QJEf4qAqzm6T+YDzZqfERx+j/6qbWOMr//vJkT1Nj
	 eiv4wZ1iZ/HVw==
Date: Thu, 24 Apr 2025 09:00:00 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: newlines in filenames; POSIX.1-2024
Message-ID: <xv6zdpdkni6562xmkmspvydncwez25jppsh7gfo64ngm2jkgjh@isyqz2jz3l2i>
References: <iezzxq25mqdcapusb32euu3fgvz7djtrn5n66emb72jb3bqltx@lr2545vnc55k>
 <20250422222131.GE569616@mit.edu>
 <3wpydsib5maytq4m4ve4b7wfbfkxwzd5m6u5woqr43qr6mickk@gw4ww6vvgyo5>
 <20250424000534.GB765145@mit.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irphm5l5gmnurx7s"
Content-Disposition: inline
In-Reply-To: <20250424000534.GB765145@mit.edu>


--irphm5l5gmnurx7s
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: Re: newlines in filenames; POSIX.1-2024
References: <iezzxq25mqdcapusb32euu3fgvz7djtrn5n66emb72jb3bqltx@lr2545vnc55k>
 <20250422222131.GE569616@mit.edu>
 <3wpydsib5maytq4m4ve4b7wfbfkxwzd5m6u5woqr43qr6mickk@gw4ww6vvgyo5>
 <20250424000534.GB765145@mit.edu>
MIME-Version: 1.0
In-Reply-To: <20250424000534.GB765145@mit.edu>

Hi Ted,

On Wed, Apr 23, 2025 at 07:05:34PM -0500, Theodore Ts'o wrote:
> On Wed, Apr 23, 2025 at 09:31:42AM +0200, Alejandro Colomar wrote:
> >=20
> > <http://austingroupbugs.net/view.php?id=3D251>
>=20
> Ugh.  Reading through that bug, despite the fact that the original
> proposal was *significantly* bared down, has greatly reduced my
> respect for the Austin Group.
>=20
> One of the people in that bug argued unironically that using pipes
> should be deprecated.  i.e., that somehow "find . ... -print0 | xargs
> -0 ..." was a security problem.

Huh!  I hadn't read that part.

> <<Sigh>>
>=20
> Other people pointed out that creating proscriptions that were not
> implemented by many/most historical implementations would fragment the
> standard and decrease the respect people would have towards the POSIX
> specification.  That was the "toilet paper" comment which you
> referenced.
>=20
> Well, they got that right.
>=20
> > I think a mode for disallowing _any control characters_ (aka
> > [:cntrl:], aka 0-31) would be a good choice.
>=20
> As the Austin Group Bug pointed out, the problem is that the control
> characters can be printable characters, depending on the code page
> that you might be using.  The example that was given was cp437.
>=20
> The problem is that historically speaking, the kernel does *not* know
> about what locale that is in use.  We made an exception to handle case
> folding, where we added Unicode tables into the kernel.  Some would
> say that was a major mistake, and it's certainly been a headache.

Hmmmm, I'm not too worried about that code page for my own system, and
most people aren't either.  I still believe it would be good to have the
option to forbid 0-31, and let those users who need access file systems
with such weird conventions continue using the default (that is, not
enabling the new mode).  I think ASCII has won the character wars;
especially in POSIX systems.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--irphm5l5gmnurx7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmgJ4WkACgkQ64mZXMKQ
wqnKQxAAiRiUuOhd/mFBZYxCgo7HVnTi7qWsb52VoWrnujTTtTk76NTtt+q/4dsL
m29hg4l6fLpGcrFH7caKzv3fEUAKnNATv9z7gRS4Au1lUDrH7/KdEGqLxmZlRcy6
OdX+ZAQTze0VR1fd1xR86f0V0AIdfA9Gqrcvh9kKOxjN2xYhGW7Cvt979EkKfNXc
r73M8a/H2X89tvKMc6b1mgd0CmJzyxGVXRqRhUBQDsy4BiK6pWOE0j8H3duUaGHk
PAGBBIMDcVAKKbO2kq04MvILCVU3XGSNNtgAp0TR9FbMJxkMYYfMpEsA1zMEQoUD
ImYLQI/6v+mlnqiiMlNubR32UxDkHL1DHEAOz7DTDbzXQWCq9SZI9yuCo3cieXOP
WZoShb109We8LYz3O5fGtB0EE2EobSCEC2qf047ruQIPgMHh1QNkNdZXT8pwwrRQ
TEpYpxLQKYRcHseU4n/Z1+Cg26KJL4QNuVTThKBHTWATadQzrqNUYYDam3V83pX7
MtuVsQvDyT1d+Hpy0XMyVmfh2XEAfPbQG7K9JXLMjKddlo2+io+cJ817TELri2Tn
fhZ8TqmBN5/QpdZ24nXLTDrsVb8+0hCNCC0vk1YEgH3ywEiGuOiAfdFGZ5E1zLiH
7ZqLfhxknNP40Hy9O+M1IS8cUuFDtUy/VmaePWHxQ3AXjxAPt+c=
=qT9M
-----END PGP SIGNATURE-----

--irphm5l5gmnurx7s--

