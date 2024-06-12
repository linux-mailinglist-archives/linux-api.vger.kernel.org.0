Return-Path: <linux-api+bounces-1731-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621C9905B9B
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 21:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896ED1C22953
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 19:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB78823D9;
	Wed, 12 Jun 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uo/XUOIQ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4629823AF;
	Wed, 12 Jun 2024 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218904; cv=none; b=OgF9ItHi6ozHqYeL2dTezkylka/+E0fL6YfpFHc6ba0iE8sCRGZe6xgR7FBd4Kcewr5Lz9ZsZURjJuDEmgqo/26tRmbuPylOI8bFx5wPGmSfUAm8bx1uE1Hu3sGp7zbU4bc7Ki1/3VR07HPQyWuwYkkkV5obG/6gKvN0UDuY8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218904; c=relaxed/simple;
	bh=FNP51z8mhec744uH0WqqF+8amWQAFNxf2en/E76LhMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUnaAeMMseL6mJhq3rFgqX7xiKzsldTNOTYWa9AFDAjwS8Fq7puf17oKpxH27pNWmkn4jBFrkCZQUZhxCevCp8G7eRtN5jlRDKvkUsHgVPjgzSvB5w3cU5ezMKm8WMr0qLBkEWn/U2Lqj8fsWM4FpQo07azeqYP6xurCP4m1/UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uo/XUOIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 197AAC32786;
	Wed, 12 Jun 2024 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718218904;
	bh=FNP51z8mhec744uH0WqqF+8amWQAFNxf2en/E76LhMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uo/XUOIQ4tj2b3MRSwdCEizyzDTuTn3BlL4M07+5pRNPnrHKLe2/A5TS069OWr7v2
	 fFPFXATuTJMzw5HUGfo+OMM+vh9DBpJngGnohSJcHsreBXcqzgurV+FTNsQqUtRLba
	 TnJXcJb8Pucxitba9/MpkjDdbdbLIoJ2DOGXciTLCSEZ8NaCWUEhY+XfuTlvLfnhA9
	 hJ6EJAVeOpTmZSYjDnoi+V2ZVDzYT38GPcUuZbgqmYqC21ZgomL95KroLwbsb8zwkS
	 yP9DP78MnoSemHjPl5mN59HpzB1aM2uvUfw4aGxNLfzuA81dkoT1fBi542qiQD1sCq
	 10jVfV3y+eVmw==
Date: Wed, 12 Jun 2024 21:01:41 +0200
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, 
	libc-alpha@sourceware.org, linux-man@vger.kernel.org
Subject: Re: termios constants should be unsigned
Message-ID: <5rfohnr4rs3tkfs7y3f7rth36c67pvcwv4q52onrjohdjtpo7m@stvcsncq7z4f>
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
	protocol="application/pgp-signature"; boundary="evs6mkqyhujudyri"
Content-Disposition: inline
In-Reply-To: <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com>


--evs6mkqyhujudyri
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

On Wed, Jun 12, 2024 at 01:47:03PM GMT, enh wrote:
> hacked these changes into AOSP, and it did break one bit of existing
> code that was already working around the sign differences --- this
> warning was enabled but the code had a cast to make the _other_ side
> of the comparison signed (rather than make this side of the comparison
> unsigned).

BTW, that seems to be a bogus way to workaround this; the cast should
have been on the other side.  I'd say whoever maintains that code should
probably fix that to use unsigned types.  These constants are meant to
be 'tcflag_t', so a cast should be to that type, or the type of the
other side of the comparison, but casting to 'int' just for silencing a
waring seems nuts.

This makes me wonder if breaking _those_ users could be a good thing...

--=20
<https://www.alejandro-colomar.es/>

--evs6mkqyhujudyri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZp8JQACgkQnowa+77/
2zJP6xAAiLFOKN9/qUBkvHBgR5hjD9Mg3m1Mp2/UuQbxRvYUFodp0P3zTOVmCf9V
0TySz8pVRCGxNaCg/XzXQzQok2q+OvdqGtpuN5DC+WLzQATNNU2P58Gpo9WgVnri
ExtBYYU8SHhv8noslql630EGR12ZJicqIAJ3H3x3EXrvNX8ZIxvXeN3YeNX/up3m
AnMGVbj7yYHzfZ5PQwrbaIM3blXNjbUEy+KxapWTUFOZyxjqr5j8cR1kLPuhgXAK
VImvLkeV5qEpg0CgwCOhAcVn53s3Xpq/EwZv2c4sI8XEr8beVDkT9vNrgw7mTllJ
BLQnytMsrs8VE5JRaNHY06AqUsvaxkNmJZQWLlqvZ82Lhcytmlthc2rVJGyt76e0
pxvTOSA0TJzWLtIDGWPUD+N8amZCHaWxR8P2btq2K4eReZCb2F6g5VKsHEv98VBR
O9sYWJAl/+BBEu6RUEIeSZN55ORAyvF4o8+b0d/B3XLSC8Un090gZgOWZaMQDfk2
cozK3bxO7WZ3i0IZhxOUJqHh4gZP8G9nVrEMDaBXRtabks9JWuhiLPP5fflFpSnb
EzL8kVa5h6jMl2Vl5WdCvFwmZuy+y5KzapPAX0tB+hDuk4I8/Y6efXGURy9hkZai
AuLcezpaE9pSOyzYrLvIL2/lnrT16MTtdVjOSnc3UOKbhvX3CwQ=
=MJAS
-----END PGP SIGNATURE-----

--evs6mkqyhujudyri--

