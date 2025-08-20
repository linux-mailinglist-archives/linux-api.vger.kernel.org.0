Return-Path: <linux-api+bounces-4523-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147FB2DA57
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 12:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F725C2B01
	for <lists+linux-api@lfdr.de>; Wed, 20 Aug 2025 10:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9102E1C61;
	Wed, 20 Aug 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHAR25jQ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A51C3F0C;
	Wed, 20 Aug 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755687034; cv=none; b=RgHCtk7lK9WQGNs8UpTxInp0alfpouaX09+wrwhiLmrD63BkXbjpr6IHMWUTcdeqcI553LRWVJ6YDU9taRVOAIDFRCzG++Opvjq7y0gQ6hvpkfoxfapEsM6EEPlK3ephk/8Ss09ATiScJI4Jrkpe9a21+kiV1Wc2wmxr8z3cVCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755687034; c=relaxed/simple;
	bh=gWY1s90mqkGWkH9wCn8pr68I+Bv91HSEex4Dh6PPwB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQgIXLuwlj1xHHsubGtqW36VJvBHfCVqIJY6+yu4dMW77xhxm754a3oeyir81NXKclvG/CYa433gU58Mylss1NGwqd5fAzfa6NQ4MgA1W+/WMbQZH1gR9xnEpZW+6hsmcdzAXs6D7wNHmV82dfTVzOQWHBxVu13iLudPWi8qgLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHAR25jQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AADC4CEEB;
	Wed, 20 Aug 2025 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755687034;
	bh=gWY1s90mqkGWkH9wCn8pr68I+Bv91HSEex4Dh6PPwB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHAR25jQJMzXI1NRMRA8WanTfcgs6tBSk10Oa4FMzTNqvad8AUQrmqVUtCgbjg88p
	 z+au1YAXodfjmtOO2V98+YtgrcLCqvYEe6Z8eRmGFTQ6hlTX2bJOjhYdjaEupFfnl2
	 J7Wm46UOW5imlOHmZJJOcyE0UVybthEsIXrNKm3DqTPTxfZM0w4XN3NY8USKXooZ41
	 uI9QB+7SQcO9LSBuJInlHh74X5euEge3wzoz4iNsqijRZ5RLtjDXLNVAHBuqZ3mM52
	 XhD8OW2+tpqzUbMqDlLc8EyKF7NH1xe/aNIxRl6Ovj4zC9okADcxzAfndaKzOAN1lX
	 vvYUX+uim7X3A==
Date: Wed, 20 Aug 2025 12:50:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v5 3/3] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
Message-ID: <jmjlamoqau6rs32ldggra4ojiwim7b7h7xtgzh63m64xejsid4@cdnae7mjdeh3>
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>
 <uvh2e2jjdk44tdwrhmnd46atwgdzwwmny4kczxqv2vm33gjqpp@63lsupn6y2u6>
 <fb880acd-25df-4386-a13c-9b68640477ef@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nokfytcmk76thnjv"
Content-Disposition: inline
In-Reply-To: <fb880acd-25df-4386-a13c-9b68640477ef@lucifer.local>


--nokfytcmk76thnjv
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
Subject: Re: [PATCH v5 3/3] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>
 <uvh2e2jjdk44tdwrhmnd46atwgdzwwmny4kczxqv2vm33gjqpp@63lsupn6y2u6>
 <fb880acd-25df-4386-a13c-9b68640477ef@lucifer.local>
MIME-Version: 1.0
In-Reply-To: <fb880acd-25df-4386-a13c-9b68640477ef@lucifer.local>

Hi Lorenzo,

On Tue, Aug 19, 2025 at 09:37:39PM +0100, Lorenzo Stoakes wrote:
> > > diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> > > index 6d14bf627..53d4eda29 100644
> > > --- a/man/man2/mremap.2
> > > +++ b/man/man2/mremap.2
> > > @@ -47,8 +47,35 @@ The
> > >  .B MREMAP_DONTUNMAP
> > >  flag may also be specified.
> > >  .P
> > > -If the operation is not
> > > -simply moving mappings,
> > > +Equally, if the operation performs a shrink,

I've changed s/Equally/Similarly/

> > > +that is if
> >
> > Missing comma.
>=20
> Could you fix that up? Thnks!
>=20
> >
> > > +.I old_size
> > > +is greater than
> > > +.IR new_size ,
> > > +then
> > > +.I old_size
> > > +may also span multiple mappings
> > > +which do not have to be
> > > +adjacent to one another.
> >
> > I'm wondering if there's a missing comma or not before 'which'.
> > The meaning of the sentence would be different.
> >
> > So, I should ask:
> >
> > Does old_size > new_size mean that old_size may span multiple mappings
> > and you're commenting that multiple mappings need not be adjacent?
>=20
> Yes.
>=20
> >
> > Or are multiple mappings always allowed and old_size > new_size allows
> > non-adjacent ones?
>=20
> No.
>=20
> >
> > I suspect it's the former, right?  Then, it's missing a comma, right?
>=20
> Yes could you fix that up?

Yup.

>=20
> >
> >
> > Other than this, the patch looks good.
>=20
> Thanks!

Thanks for the patch!  I've applied it with those amendments.
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D21b1c7188ce1d66ef294eb1681361315a35e8070>


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--nokfytcmk76thnjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmilqHAACgkQ64mZXMKQ
wqkzYw/+NJLLAXvOxXNL5cW7CwdtKrzPktot1mon3rehA1zrsieDoTJNXTxcL8O5
TbDMKNgfCW6FpCKHZBQOg/l+B4VjQfxBEYVxY7pDuIEqwyWHc98KdolFDkwCMfW5
rRlCAF8jaYegdjGmkvGITH4HEaoC8YFgZ/4Nw6qDYO380PBDFwBq5xUSgT0Ztxpj
XOHMgzKAyaQDuBdbT+rU+xGkxZr3zWJEUDq+bM7HcpN55xroaIwtgHTeecHameTG
otOG6pGKSD3/0DrIUPWXZ19KJOzeh5QlPyYxqDAtLF1qUx3fpKdmjSFzmSc7eInd
nTAYf3V0b/W3X/MV1ADJhiJnnDybznVvm0vGQ1SbAmEXgl0IAv/kruP3CDVEekLb
sVbkiLnDtB3ub9AWS/n/vn4SQK9m59lVDpkJoMZh3flZtAnAUNQ8CudzWKZe0IZw
lwKFVH3k+NQ9705FCbS0a7YXIcL6UcupADHVSlkZr8xMtTCbqzFxYzMBHXbF8+hS
suEtrHZ0GN7TRGVVJvsJkdl3ebRsiKmg6UlMwg0Fcj/owx6Pdh/nwKn6qiQAAqsk
DLuXkr4+Sl4np6v2ayEuI5Y10O9HakgkfMCDh8o58j+2siCnmCBwmhvKFjJYO/eN
T4XARwzsGM48Lxxt1VTAW+F3jN+TKUCM6ZuT5d9Z3vhrhyL7SOU=
=5B1m
-----END PGP SIGNATURE-----

--nokfytcmk76thnjv--

