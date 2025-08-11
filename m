Return-Path: <linux-api+bounces-4432-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44195B20323
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 11:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC02C1882970
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 09:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427872DE6F6;
	Mon, 11 Aug 2025 09:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us2Nv7Wy"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E02DE216;
	Mon, 11 Aug 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904016; cv=none; b=bSg24e15AgMDJ9qmowWzV6gRLqo/r5GlfrUgG1DI4ki76e2WQw5NCQm6nwBgOnfK9ZxxoVRNKz7pq8jj4wxHstMpRqDnGtSyuKogzfkzne2VEAeJWfneu5ByrnTTGFET49hxvwumwzP4dEherQ5QHpS/8YcWkfQv3HyrzpkDGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904016; c=relaxed/simple;
	bh=IisbMyFzOG6KFUHxBroQ9SRvxbYwsiMzA2NJsWQimZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQhv0HPnSF5gNRHtdLTG18m/yZpIWZ1+wptFyLvw2zfbC4vsBTTTBDmtaM+6gnK7I+OlQ0GSLP6xgGHvt51UYrBTaEAxuztzR1GwrFTMWaJQ410zekBM+hFD9exrFEEP/NYX4zO850WJBlT+sYptbqMaedd2jUBa6RcB8gjte5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us2Nv7Wy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8B9C4CEF1;
	Mon, 11 Aug 2025 09:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754904014;
	bh=IisbMyFzOG6KFUHxBroQ9SRvxbYwsiMzA2NJsWQimZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=us2Nv7Wy6katcp580pTEPrY1kWZQXR+xMd1P09aJ0eldB//eTqvUA25zKrLOs9L1J
	 sXvQ6jUhIpG5Mhl2j5F/4Of7ukYmCGbasgKPVxmS4W9mUKXA05r9VzUWobBRc70f/v
	 ZmmWlDiO4JNPt9RgMFfsdRx7euCE1s9/JJRUDg6TN0cvkKCHnvyrFG2IfFzEytcgI8
	 yXnJk9E37oBjlsU+gpZoYJJvchHYNtlfYdBwOk8ZjsUK8+Cjxrk2rM85xtpuDO0kB+
	 oBUVkq6R90jM5XW76uVmZCMdJRPN8hRMKtZyWdNPfumR7m35ZbtRN9Qybmy3p7TqcY
	 93NdBt4s1PfLA==
Date: Mon, 11 Aug 2025 11:20:05 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <iny6ro5f37vcthqwscklqx73jscahodilug5d6umleyzq6a67k@ecoey5ud3aer>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
 <ekjakm6zburrawhk34smm3fd43zufzguisfean4hmv7vyjp7fq@uvy6n47qbydl>
 <664b00e3-69a0-498a-a7dd-a3d294c0c188@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k342krn5dolsa74h"
Content-Disposition: inline
In-Reply-To: <664b00e3-69a0-498a-a7dd-a3d294c0c188@lucifer.local>


--k342krn5dolsa74h
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
 <ekjakm6zburrawhk34smm3fd43zufzguisfean4hmv7vyjp7fq@uvy6n47qbydl>
 <664b00e3-69a0-498a-a7dd-a3d294c0c188@lucifer.local>
MIME-Version: 1.0
In-Reply-To: <664b00e3-69a0-498a-a7dd-a3d294c0c188@lucifer.local>

Hi Lorenzo,

On Mon, Aug 11, 2025 at 06:30:38AM +0100, Lorenzo Stoakes wrote:
> > > +Mappings can also simply be moved
> > > +(without any resizing)
> > > +by specifying equal
> > > +.I old_size
> > > +and
> > > +.I new_size
> > > +and using the
> > > +.B MREMAP_FIXED
> > > +flag
> > > +(see below).
> > > +Since Linux 6.17,
> > > +while
> > > +.I old_address
> > > +must reside within a mapping,
> >
> > I don't understand this.  What does it mean that old_address must reside
> > within a mapping?  It's a point, not a size, so I'm not sure I
> > understand it.
>=20
> I think if it were a size it would be more confusing no?
>=20
> It's an address, the address must be located within an existing memory ma=
pping.

What I don't understand is: how could you not comply with that?  Could
you pass some old_address that is in two mappings?  Being a single
address, that would be impossible, right?

> Will replace with 'located' for clarity.
>=20
> >
> > > +.I old_size
> > > +may span multiple mappings
> > > +which do not have to be
> > > +adjacent to one another when
> > > +performing a move like this.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--k342krn5dolsa74h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiZtb4ACgkQ64mZXMKQ
wqn49Q/+NB8XLwGQzYhv4WN/bq4ZSt0ZGgTcrkoQ4WoYE7viHa9oedvqtA7Hr+KN
SCvHXNO2bKEuYfFmrySCT5e+Qjc1G5EwK8ChVJSj0mNuwX9vxEmCHIYW4+OgU05r
pIqGrg05z5xjZxkDjvXuZgmfjU1q3SgM3GU39vDS64j2jWPhff/tWKPNt+oV+54w
o75W1lDsQcyPVvAOX7ge74+JUeKBG9x1P1+9Ou67ruZidsXPxOWtB8rvD/3BPGXO
LiyxA8q0YnM4SeJaHKAfg2xNGFJkv9GLNp2VZE01ZTGjLlWl1znMnOW1uq51dzhj
XvtL9cZNrVc5r/lRUs2lTF3B5GJ8HnLi6dDZ7nIqB7wscLzSeSMea9rbcyrqLm+o
BtWg0kxnu1BLG77HH484MA+R04fN9+/eN3D+iiw/5Dj/pTmWVFu4Ht0PyycJywKa
1SrT3tSfjCe1CPcSAPO8bt8bFNNVO0MsoyYLKdPfXL1g/ePKzDR0kOmzqRyvOulv
omW3lTp6Dmh3B/cMxZ0gy8LhYLWgWZq2FCpoDHfwgoWJtcJhqpSLJIklfiWoi6Ol
4SsCBs6odpUlhdnd6QV+BFYWnauU2vLfJtZ3nMZt4MvUudg1FHkee5dPf55DGNk9
XHrTt5vNlUzrABzJiWwZLBeVDZjyDi3QCmE75IjrUtMxycgFYDw=
=zIS3
-----END PGP SIGNATURE-----

--k342krn5dolsa74h--

