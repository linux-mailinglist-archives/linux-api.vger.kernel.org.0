Return-Path: <linux-api+bounces-4285-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E601B1942E
	for <lists+linux-api@lfdr.de>; Sun,  3 Aug 2025 16:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CDD1707A1
	for <lists+linux-api@lfdr.de>; Sun,  3 Aug 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2C7155CBD;
	Sun,  3 Aug 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fb5TUiPK"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC762CCDB;
	Sun,  3 Aug 2025 14:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754230668; cv=none; b=YDJmHjMKt5PxDtsEcS6susM9H3piO+jTCb2QVC+SQNteSl0HU8ewenSimM0leVhN5yXm7Bo+eAMH0Xv3x9E98+0od7yESIE6i3L3aeXml1S/P6wXpbj3VWRM+dig/w2QUlpLUol6GLS14/4BocSA1Zd7LXtoEByf2+/OSCBeS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754230668; c=relaxed/simple;
	bh=FbgQNoGCHeLVLQVUAZFP0ow2FoSrn4GCKNnKX4Sc35M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5n7iF5whdobCOX7djcE8q0PnOPPZdDekr7KlUUVPuu460rHWZwVq+q2ysXpBfOGGv4s07tfjLH/8A7vyuMHemtn2a4m9oEUB8y3PM+X0UYOpZ5TB/vtEixZdlayLFjhXDkc6noHNFXc8HRNyyrL25fSIF4/siwNWakPZwsK7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fb5TUiPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9FFC4CEEB;
	Sun,  3 Aug 2025 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754230667;
	bh=FbgQNoGCHeLVLQVUAZFP0ow2FoSrn4GCKNnKX4Sc35M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fb5TUiPKw60N/I/aG9k0oAaYyL7H5YJFfH2eaAT9UlGnDYdh65i7TuFV69owRmjmE
	 moNVeK29xw0rhqtWVgUc6epzImQFlFh4c6zoLkxTuIT5UYZmy6r+523mJBnEBlh9hA
	 zEYz2d76fDIl3Q+RlG6FABiLFtT0GqUi/8l6bPoClEH2vceJ1Pf6BOv3TKkFpri7bI
	 V6LtmEzsWMv8iVRXX5m57lVB3fDTLvaQy4pxu0VibxE5R+oPDvq9NKdwidgpaXLBHh
	 igQJXY6+IyZQNuVDAi+yxEsNDMDxW3NK3ta3NFxuJPD4irr0S5VBYtS5MgzHrAylIC
	 mtGSLZZqUMEww==
Date: Sun, 3 Aug 2025 16:17:39 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <dizfk5jqwwzozotvkk6phb36blcpsve3yw53xrdjwqeut27djt@rftbd7lkgsjp>
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
 <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
 <ngytuoex4uvu5epsdqhvhypnhqidkr7cpwmmcxrml6kpftgusb@jo5ql6eko2ir>
 <0e3d0dd8-994f-4665-969c-6daf332c5b94@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7kp2dlmi2ws6pkwy"
Content-Disposition: inline
In-Reply-To: <0e3d0dd8-994f-4665-969c-6daf332c5b94@lucifer.local>


--7kp2dlmi2ws6pkwy
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
Subject: Re: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
 <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
 <ngytuoex4uvu5epsdqhvhypnhqidkr7cpwmmcxrml6kpftgusb@jo5ql6eko2ir>
 <0e3d0dd8-994f-4665-969c-6daf332c5b94@lucifer.local>
MIME-Version: 1.0
In-Reply-To: <0e3d0dd8-994f-4665-969c-6daf332c5b94@lucifer.local>

Hi Lorenzo,

On Sun, Aug 03, 2025 at 12:15:15PM +0100, Lorenzo Stoakes wrote:
> On Sun, Aug 03, 2025 at 08:47:28AM +0200, Alejandro Colomar wrote:
> > Would it be possible to write a small C program that uses this new
> > feature?
>=20
> I could do, but it's an unusual use of mremap() and we don't currently ha=
ve
> example C code for the _general_ usage so I wonder if it might be somewhat
> misleading to have example code only for this?

I didn't mean for the manual page.  It was more for helping review the
changes.  If it's very small, it would be useful to include it in the
commit message.  What do you think?


Have a lovely day!
Alex

>=20
> Cheers, Lorenzo

--=20
<https://www.alejandro-colomar.es/>

--7kp2dlmi2ws6pkwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiPb4IACgkQ64mZXMKQ
wqm7ehAAq+62D9otkxXDciEZdNgfKcKYwXmnmx/aanrSC+e1o02i9wrRYgzlFzkA
w22NDz2V7FPZhnZ3bGnuk5wrygmPWprtOJ0ux8p4qfKKScaGdPCmGcZbYDpoeUoQ
pt8GOYPu2jDF4yAnfJOWtw3aU9tTvtju5UsZAdHIwbdRGMcbuxX6cZvre7pLKHN+
kXijWJsuPKq6EbR/wiTRLJuNznpUpFAO7Stp8CkDrFOsM6KSDzgnPcL4MqXAieiQ
ymgGsspvEyi0SBmaUlo9qlabHiyMqOtcGKSBuc0s9NicXoUJ4Gsq5F7dmGX0rDJn
NihsZZ1PCFM+cWuoVIlXTNM6Ka2JEE5u8U4gapGVZs/QTpjuUNqBY8xnIchtErXf
Dlj8RqzXCY5iZBpT53WkUZFx+DTD/hI4uHBe2bxtvO1ojZbIkczXYnEyiTngWm1p
V8Tk27YGd+Wu3fPg/xtmpuO+rs3evYWDr34JBa9LnJjzWB0mkGDlfG4gb+HTdecV
jNm97xJH37d+1a/dq7uniOQLxUb6f/RzbnEHUh0MqLcpYr7amjzDOPZpRJzYDugT
mHpf2NAG2srrUhYnNVfOvbt2Hj4EurnfNABFm4sPosO4+6m6+GXj5HrmYb58BF9F
ZnEl50IluTkiAa4dv/n4zr5p7a/FqnsF12PB4SZhMME8OlG3WMc=
=Mknw
-----END PGP SIGNATURE-----

--7kp2dlmi2ws6pkwy--

