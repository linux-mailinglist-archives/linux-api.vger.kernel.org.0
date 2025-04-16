Return-Path: <linux-api+bounces-3504-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27952A90956
	for <lists+linux-api@lfdr.de>; Wed, 16 Apr 2025 18:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D7D444D1D
	for <lists+linux-api@lfdr.de>; Wed, 16 Apr 2025 16:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D4E211276;
	Wed, 16 Apr 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9VhNfAS"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B818870C;
	Wed, 16 Apr 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822205; cv=none; b=DCtXqbk85ZkDWWzHON4LvLAkFYsbmvReYtCXjt/S3Jny2IjgKna5TUz7gFBLYBiD151rmXkeT8VD0srCY9stGqMCxA/YIJdRKOwqHSVIkgPHccHl0zP0BIOnVnN8x97Z1cyzD6Pc8Y4/AoKOVkdtZuJErMC2+TWSpUEs/qvxz9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822205; c=relaxed/simple;
	bh=1+ifTZyI53YM2GlAgIO+mtfpNgSWUgqm+FdbCehVshk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j/xUFgQf2CVWmiEX38N8FNSXSCkW6GVcffxw8vA/b0E+OIBrFdAoQ+DeSG/VfcSnXJ09JPYihkWFnMksy41/szJ20+fvULvhZf/m2dqeVDZmTHSOjrOyZSbBUtDAGdw0vaXPT2h1JXFPmpqeizoX+j9QBhfRJ90CA/0pJg/pPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9VhNfAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6212C4CEE9;
	Wed, 16 Apr 2025 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744822205;
	bh=1+ifTZyI53YM2GlAgIO+mtfpNgSWUgqm+FdbCehVshk=;
	h=Date:From:To:Subject:From;
	b=W9VhNfASEB7fM/Cz84q841fLePLdO4yeUm58f2tNIwFtXAy64jxI5wuaRlZmrgMUI
	 rRgUNNOd8oxAMPtjlnZQaT6ga1ioDt9O78txcbxVLbPTYPEIC5coUjT9GPbSHNLKse
	 IJaidwvybajxom7lq2j9wplvZUVRb27g5GHt0ZwjG5g2JesE62flY7er1cwYm9DZVF
	 NL79wvwwF9fxBSVwTuWfKMZPIYPcviJRuD+Oa1gg/MVlOSAyTOKXCnM6rNvv/BEKcr
	 a8Cn6Tx1+lfFGTbSQqzZfqc9ZB+5TbeUzLi3806lkDnqj0aea3NEZBnSMEcFUfbFYI
	 0pUb0uxEJ098w==
Date: Wed, 16 Apr 2025 18:50:00 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: newlines in filenames; POSIX.1-2024
Message-ID: <iezzxq25mqdcapusb32euu3fgvz7djtrn5n66emb72jb3bqltx@lr2545vnc55k>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2lojv22jhdhxnsjb"
Content-Disposition: inline


--2lojv22jhdhxnsjb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org
Subject: newlines in filenames; POSIX.1-2024
MIME-Version: 1.0

Hi,

I'm updating the manual pages for POSIX.1-2024.  One of the changes in
this revision is that POSIX now encourages implementations to disallow
using new-line characters in file names.

Historically, Linux (and maybe all existing POSIX systems?) has allowed
new-line characters in file names.

I guess there's no intention to change that behavior.  But I should ask.
I thought of adding this paragraph to all pages that create file names:

	+.SH CAVEATS
	+POSIX.1-2024 encourages implementations to
	+disallow creation of filenames containing new-line characters.
	+Linux doesn't follow this,
	+and allows using new-line characters.

Are there any comments?


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es/>

--2lojv22jhdhxnsjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmf/37AACgkQ64mZXMKQ
wqm0oA//XdtiN62u+4Hl1dowNTe1wL3mQ4PkoRlVX8HZZ6bKn2veSSENQScZtFRd
yTmH0XKcz0a7lgbllIX8TwS1ROdCNTwuFBITB/+s8CP4x9vqC0ufEI8l/Ebn9OwG
acsQ3Jg1sdFdvbHg7997uSMsi1NV+QxzK7DKdP4L5QQGkyohw6PJelYoL7NHeEZr
HIU84cvqeiihkPoQtXelYCdD5JCC2BJdAtQJOprKEANTH5+Ko9z/yhWKWQ0HsHIe
IV9PMpnILwtbnh0/n2QtKX1/vTowj8mP3paMm5ov0Uc5mRVUEpe7YIk3MrEHyQj7
lpyEXF02auuCR2zhLziOdakpuHhxZsxqhdkKJkcskKjdKkMWTLtc/VVwlXyUAT+Z
01p9LvZMVKwA75BQu6vUnZnSMa7v7HxSuik6M0GqKkfLjUvcPeCGpbdFG8vEeGgl
KmnRmK6oq57R2myBRLtl+C/qzM7IttO2iBjiE600vk1zHpAzYA28qEn2o9TtsKRK
kAZhFK9fC9JhbozT2cSNwEBCO3JQ26tnSLBWRiOnFpcaPN8eTpTvyGdxyjCwWecs
ZDJjt5Ja6enGtDwChmbMYa2WNhdrTNveboHj1um4aD8qONUF3guyV96OBOIw/0Mu
mTp0CPwj4pNLpMdT4Ah64wox+uduLZ0Cfh8jXoCdQ85c4OCbJfg=
=7SQM
-----END PGP SIGNATURE-----

--2lojv22jhdhxnsjb--

