Return-Path: <linux-api+bounces-4435-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B911B203E4
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 11:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE293A4FE3
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 09:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAFF22127B;
	Mon, 11 Aug 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqRU4AKC"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30C21C190;
	Mon, 11 Aug 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754905062; cv=none; b=qXJy5MQPNMN9md39OPuxiqtQljO++5ziDadbtjFiNTaK43bNoV2Z/4tCp9D/ywVzGH1eRUWSMqtgddwkTIBHfsZtUB8fcyJ8C9FmRRNSMIy9g96rvqAfNTKBjBv2rLRgkSTORiNE50h95QROP0L6CzmqwObUsr6EGSOgEw8bovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754905062; c=relaxed/simple;
	bh=/6rqaVzkcLqKJt+RONzwleWy3O1JwLSdS+WsTVizHyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYNABGQzRL5x5HHuQNt/wpVdpTS1fDMXnolS6S0U3AE1N17V8EmA6WsEet82g5ghf0NisNmRbLE8wzWopOrapWNhTnPkcZ4imGuj+bTmKh3Q7P+0RK2qfi46ayihAPyf51y7nVqq6ZxpfR6v8YthPBm2i4fR1jLCr4rz+uMz8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqRU4AKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F5BC4CEED;
	Mon, 11 Aug 2025 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754905062;
	bh=/6rqaVzkcLqKJt+RONzwleWy3O1JwLSdS+WsTVizHyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DqRU4AKChCeCXcAUEBbuEgv5eIzCLDRq+eEVCCwFshbb+yaKivcXn0h1hJPpLuE2L
	 XUiK7OtQb9QiWROoqkLxg9ks5w/DgkZK0++fF+9rwVZf12xb7i3c7FVrOUoJrhef0A
	 Yfv0nXpD+NTl++CFUiSHCGnsuZwpHFHqMyVM3HOo7WKiyEOonHxwy5LhGvNnfaTCcd
	 TLbr4gtlCk88lLGyLIGlNZ+LaezjlTovdORwRzVEGtsAq90eFGvhIEzjeP/piNvs62
	 W9qx3RJPXYDqApCLczBHLuwbpPeQ1FqiMAUBL5com96oOy54mhwKnC7jmEBdD3Ex0A
	 0tZ0ioKOBtlQw==
Date: Mon, 11 Aug 2025 11:37:35 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <s2lpafv4ldpmwkx2455t3l566fnkrlid7upwfuebod3lyy25hm@lvokcxytqow7>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
 <ekjakm6zburrawhk34smm3fd43zufzguisfean4hmv7vyjp7fq@uvy6n47qbydl>
 <664b00e3-69a0-498a-a7dd-a3d294c0c188@lucifer.local>
 <iny6ro5f37vcthqwscklqx73jscahodilug5d6umleyzq6a67k@ecoey5ud3aer>
 <39fb9e1b-b806-47da-a711-20c6cc12913a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="plqexovqttxwvaev"
Content-Disposition: inline
In-Reply-To: <39fb9e1b-b806-47da-a711-20c6cc12913a@lucifer.local>


--plqexovqttxwvaev
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
 <iny6ro5f37vcthqwscklqx73jscahodilug5d6umleyzq6a67k@ecoey5ud3aer>
 <39fb9e1b-b806-47da-a711-20c6cc12913a@lucifer.local>
MIME-Version: 1.0
In-Reply-To: <39fb9e1b-b806-47da-a711-20c6cc12913a@lucifer.local>

On Mon, Aug 11, 2025 at 10:25:56AM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 11, 2025 at 11:20:05AM +0200, Alejandro Colomar wrote:
> > Hi Lorenzo,
> >
> > On Mon, Aug 11, 2025 at 06:30:38AM +0100, Lorenzo Stoakes wrote:
> > > > > +Mappings can also simply be moved
> > > > > +(without any resizing)
> > > > > +by specifying equal
> > > > > +.I old_size
> > > > > +and
> > > > > +.I new_size
> > > > > +and using the
> > > > > +.B MREMAP_FIXED
> > > > > +flag
> > > > > +(see below).
> > > > > +Since Linux 6.17,
> > > > > +while
> > > > > +.I old_address
> > > > > +must reside within a mapping,
> > > >
> > > > I don't understand this.  What does it mean that old_address must r=
eside
> > > > within a mapping?  It's a point, not a size, so I'm not sure I
> > > > understand it.
> > >
> > > I think if it were a size it would be more confusing no?
> > >
> > > It's an address, the address must be located within an existing memor=
y mapping.
> >
> > What I don't understand is: how could you not comply with that?  Could
> > you pass some old_address that is in two mappings?  Being a single
> > address, that would be impossible, right?
>=20
> It can be in an unmapped area. It's either in an unmapped area or a mappe=
d one.
>=20
> I could simply reword this as 'old_address must be mapped'?

Yup, that seems better.  Thanks!

Cheers,
Alex

> > > Will replace with 'located' for clarity.
> > >
> > > >
> > > > > +.I old_size
> > > > > +may span multiple mappings
> > > > > +which do not have to be
> > > > > +adjacent to one another when
> > > > > +performing a move like this.
> >
> >
> > Have a lovely day!
> > Alex
> >
> > --
> > <https://www.alejandro-colomar.es/>

--=20
<https://www.alejandro-colomar.es/>

--plqexovqttxwvaev
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiZud8ACgkQ64mZXMKQ
wqlkrA/9HAR2TApLusgtvOtIEcmvr4OYlHs/NINEq18TtxegAhOR+eqw3RgcWSq5
PcISRO1HRAXmI1HosvRBCncEWWByjgZapSkVkePnr/B0TlOvB4uORY6pErLZEiCc
W5f0n8ZADVwuZJk4Bn13mk4i024SMdbBqpz9L9i/vLB2SsqffZkJ+s3G4oCMyjId
aUejJ4wN0+yNHBIA0uDECodHjLONBm5DFMrw7JGP88jwT6lV8oEHRdcpzPEuvqWk
Oq8R59G34BqkuBKL6yYADGl6iJwY0wcLJts1GT11++ZUqUokd/Nc4RQyHg9tYZOm
OgNCg2RhL/Atpv3ReCoyVYpe3ua0etI0HXk+yC8GU8MfcVEYsE2ORf6Dg9cLONu9
Zx961jOxrNFqmFWV5UZ3c7XBdX7WjlTZHwq2bblbzeJxcz0tYJicePrOWVPtmAb4
D5eisEdofSjNXLoS4QzTpGvwGXxj4n4LYvrXWdShhm+B8NojdNxw8eIZy7dBvzpC
rrbBN1DHwbT26Sp6kcZok3nflq06f0RKzcfypdwkVIBQQ9b5NNMpo3qPEegUtuCS
B5odiQcif7jiIZuwh1BhDeQHNxmQ/gyT+Ioh8AitjU0m56aM3KWbLNh/Ow9MPO0E
72Kw79HZxpm8d228vOzwmpEjoMAwvZnoX+rHzLEpxrJXrQYZNAE=
=QY0W
-----END PGP SIGNATURE-----

--plqexovqttxwvaev--

