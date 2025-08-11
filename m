Return-Path: <linux-api+bounces-4433-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5337B20329
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 11:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D6718C15E9
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999082BE7C2;
	Mon, 11 Aug 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oksEQOqM"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1EC1DED53;
	Mon, 11 Aug 2025 09:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904058; cv=none; b=Vtd7uSue/micMCcFNbnGEdkuc2QJHqWI3JsHyTlGChCSgad6Corh9HvdCTTgE0I0mt/qCe0mVemp14GxGZ9kw0+22R+FM7IeZ5tv/nGU/IEp3hbCGPloeqp2tCRSwyjQFfvd1JLIqNapcdpO5/7pEl2bPr89+3zXpNwUG1+JxjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904058; c=relaxed/simple;
	bh=zVWx4ZTneBogMsOlcaZR03vsIq0ezyb2I7LWj7kgLSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrDH/PHrxNNtjyY3SJFChbfpENbLH9fqcp/eAs9u/iFeTUK7M9Ax9NxVkQubkCSCFKL/FsFPEATbs6D8GyVtmqE7ZaIYlFpaNrC6T8O+FCrHnglylALPY8tO2ZRzaJ1NmLfGSfR2WlYBSRMHIZ+AqCGZfV769eBCAdemTmYtYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oksEQOqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953FCC4CEF7;
	Mon, 11 Aug 2025 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754904058;
	bh=zVWx4ZTneBogMsOlcaZR03vsIq0ezyb2I7LWj7kgLSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oksEQOqMUdyBxuwfuLKe37pFoOb6VRj3GDQarDMsJbDnBbc/9AwEbBuijT6yE5gjX
	 Aza7iUY+J8HW+ykZdsXkx1WgmVMRM3m3dIm1IJ+Qj+zZy79pMGLdum9EgqQFdkI/bP
	 XJLAcgxv74KTK+drCslPeAHb0IhVk41s1KqERWrzDoKJpExThxKw0qaYhINetJr5NG
	 Rp3xwx0tmN4m+mPzFMQUnIf4y0XLSttdNCMRAPFeU+023/YRULigbX1alYCc2T1wQ5
	 /KEYWWQk3a8mJiTdEm3cGp9HtqffW7Qa143N0XfozT1jl+1/PvvhfodGx58uFRZgOy
	 zDYZZPN6DXr7Q==
Date: Mon, 11 Aug 2025 11:20:48 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 2/2] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
Message-ID: <ac37lpfte2my6wlrk7omoeaul5spekd4pjzhutlmzanxtshneu@dsxs65meb74r>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>
 <iolucvrp6is43yjulbluchhw5wy6urq2gtwmcelg5atwuv63se@ovzuthfrup26>
 <0b0928a3-03b0-4a36-817b-b75c1f5c78f9@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lgj4tlj4klqgw6oe"
Content-Disposition: inline
In-Reply-To: <0b0928a3-03b0-4a36-817b-b75c1f5c78f9@lucifer.local>


--lgj4tlj4klqgw6oe
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
Subject: Re: [PATCH v4 2/2] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>
 <iolucvrp6is43yjulbluchhw5wy6urq2gtwmcelg5atwuv63se@ovzuthfrup26>
 <0b0928a3-03b0-4a36-817b-b75c1f5c78f9@lucifer.local>
MIME-Version: 1.0
In-Reply-To: <0b0928a3-03b0-4a36-817b-b75c1f5c78f9@lucifer.local>

On Mon, Aug 11, 2025 at 06:31:25AM +0100, Lorenzo Stoakes wrote:
> > Since this is documenting old behavior, could we have this patch before
> > the patch documenting new behavior?  Or do you prefer it in this order?
>=20
> I think it's fine in this order, it's more convenient for me as it'd be a=
 pain
> to re-order otherwise, and we've waited ~20 years (or longer?) to documen=
t this
> so a delay in ordering is probably fine :P
>=20
> Cheers, Lorenzo

Okay, that's fine.  Thanks!


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--lgj4tlj4klqgw6oe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiZte8ACgkQ64mZXMKQ
wqkvnw/+IdbsJsVOUcmRIygS4HeChREWaNfeJQO7+UgsDPRw4CHPhxXhQyBGepCG
fY6zcpBYX69RhF/1zNj9hDHSY7a4YlXQIVC4qs+AaAucT9IOzTH2hyykYU7O/gfu
ltdePdwvQ7qs7PSkKgmwbOYEUODi0WmZrTJT4Jt8OW9C2sPGZ01IWE+7DsZYITIv
awdWYSPkeSe0oeGAsQ33ZyP/kN/jRt+pHFbPE5dcbCxBkOFOCq8z5RcXtebrgq+T
HBYO4J+OMjwkGqNMTY5DIry731B19BwvmI03NbcMApuMuEx6kK8HtDRfO3000hs3
kRtR+glT+9RvfgzKcz/gadkFfVlhk/rMzFjQGCRD0FjSAlgbvIzPujM80Lgljk9Y
FGQ///2DeH+Mf2vk9+WweEj+ciTFCPeok2i6rnNofTjq+cbaijpEny+c4ra4mJeH
+AwxzrWdNjhxUZnr50B/WTT61bXBTVIHQuSnyHGbq/zSU8zuJiY2q7FFprgMnLq1
pMWdkf1/cladI86zQH3d5QeX8BQN0MazjTNSV+FRECLrJJOSeLn1a5ip5nY+nJs4
0U9WVtJhQ5MZcwNfPVEZp8aNqO2hTxS7OUYBjmiEWdLD+CKYmFJi8ygDy931sk7Y
PEFHGbRwkh3vnLgGk/mTFFuCGbxEbTfC2a1lN+7xbdEuiYb2iRI=
=0pEu
-----END PGP SIGNATURE-----

--lgj4tlj4klqgw6oe--

