Return-Path: <linux-api+bounces-1730-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0698C905B8F
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 20:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97BCE1F212C6
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31AD7CF1F;
	Wed, 12 Jun 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxH9jh6y"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992E5FB8A;
	Wed, 12 Jun 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218528; cv=none; b=s2XX9wdCOXZvKKdR6skcmRA3rHWRGqYrUe3vtu/XrIG7b0gM1AzZ1bFAsVF+vSbE6wFX3zGWxFU/CxoY4IubOTUsbjaEbLeRAvr2sR7y0V7OpKi0ZxfR8XN/pUdaB7zphmtqvYYTqAfwg9V39lS/3FpQUiSICforWoRphwettLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218528; c=relaxed/simple;
	bh=HXYaA++UyGiZaMWjHlqX9NeGeQZ6uv6qhMclMOTLE00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJ/ljhIXqHWLMq7LjTC5n7A5huetZIVxXkJzLz7IXywal1nDaZCmfYV50ib88dUloUBcubiT5FpONZrRHSRPCiUW5FmVdcE5KXWH8qh5oPe8WQJlzp1VEdaBNnYH8RnRl2FQhpyTyeUZMNFfV4snTl4lD/kC1QUlYoIICE847ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxH9jh6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC93C32786;
	Wed, 12 Jun 2024 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718218528;
	bh=HXYaA++UyGiZaMWjHlqX9NeGeQZ6uv6qhMclMOTLE00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxH9jh6yeXNScg5OlcVQ8y5phm063dyFmRKDE6yS1QImN+UDcSwoJNlfEVr/k2nUI
	 QzNWXSFuD/3SdkssdeNt6Nt6xNWdK9Yj1/pCqv8XsT2kEBwg9f6GFyUV+byMaS7rlE
	 ouhuEx+7Q/jmJGeQYIzsPRJ3VJ3Oeb8sOCH1mIQ6m66+/8OuED9LhZHYEAx57yV1RM
	 sch8GL7hT0cz/JYqQcK7Ta1eDN9nA/k1hrEqAKDRAjGzki+NbGx5/tye1HraG/8kMa
	 1P5wzRNKSXVu1HHiwivvqs+2gHY8tk5294y8xzqo7JoPpzfnVXIEGQRRhbHNls2r2q
	 VKix30fRv2dqA==
Date: Wed, 12 Jun 2024 20:55:24 +0200
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, 
	libc-alpha@sourceware.org, linux-man@vger.kernel.org
Subject: Re: termios constants should be unsigned
Message-ID: <yef55tgzml7xn72gxwhqzrqlv2hoiiy4bbyylyxcbf5xkbd5co@j75x5tpc3azy>
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
 <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
 <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gj2wkfl7t66xikld"
Content-Disposition: inline
In-Reply-To: <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com>


--gj2wkfl7t66xikld
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, 
	libc-alpha@sourceware.org, linux-man@vger.kernel.org
Subject: Re: termios constants should be unsigned
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
 <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
 <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com>

Hi Elliott, Paul,

On Wed, Jun 12, 2024 at 01:47:03PM GMT, enh wrote:
> well, any change like this is a potential source incompatibility ... i
> hacked these changes into AOSP, and it did break one bit of existing
> code that was already working around the sign differences --- this
> warning was enabled but the code had a cast to make the _other_ side
> of the comparison signed (rather than make this side of the comparison
> unsigned).
>=20
> Android's libc [bionic] uses the uapi headers directly, so we would be
> affected, but to be clear --- i'm fine with this if the consensus is
> to go this way.

Hmmm; I see.  I guess for this already-existent case we can just live
with it.  Then I'll just ask to consider using unsigned constants for
new stuff that is a bit pattern and not just a number.

Let's drop the patch.

Have a lovely day!
Alex

> (but, yeah, i'm with the "how about we fix the language and compiler
> rather than all the extant code?" sentiment from Paul Eggert.)

Hmmm, can agree to that.  At least if we don't continue writing bad code
for the new one.  :)

--=20
<https://www.alejandro-colomar.es/>

--gj2wkfl7t66xikld
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZp7xwACgkQnowa+77/
2zKJ7w//YkYqOdwUXO56+lUK4rm+tRwiMqd17YLGcUMy0mzukoWEPYqoev2gursZ
rNLKUf0VGrhKjoXrb0bwiJEExgY1noML88Zn/wqEV/XGsacNWrZidxA/kICD0m90
7NL0RONJBvibxpIpKPCS6kpEK+5FS/tjdv5EPmdeo+F6wwDhcwjav4JptPXLO9lZ
fKdTHwvFkBmvIWDC23B6EmOYKvpb6KWfpW2LUQg29+edQb8bYS6wu+my0rdS3bXz
VdQjn0rYp+jRa5cAHVZjZ4D//2qaKzufGdA0x7+Ed0viUhIQJx5aKDG6tWJbAfrP
9Tvbe0VFi6yRrHhb5KgiUWoRPdS/Gxr2S6a0OBaH6+TSv88s918KVUAZcRaa7qtk
KYWsou0I+VvzY2BOnh6psyD7YJvaO3xmeicW4Mxh7FzxVouGmNmiEJ2Y7za22V/B
6eOnRmg8jlnBXahu96zT7TIaMPXncojLDEXGuT66CuQXh2GEej7IH6+AtkdTX9M0
S2g43wizCI5IjcUS9J1c6YPzNqBW/ehkkZLKd6tG0YXtBGHD8Ulxk1x+eeaG7oMH
nAnEJ9XGreRl7hytyrJUIMuKsZ852hTEIGWsozRX/NKkbRZB9hssPbkmeDfI81Oa
4ZFOQ3/gotrrDliSZotSI9beHqWj57A0f/OOguMSbjGYbMiGkJY=
=ydTo
-----END PGP SIGNATURE-----

--gj2wkfl7t66xikld--

