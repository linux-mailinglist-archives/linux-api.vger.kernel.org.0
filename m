Return-Path: <linux-api+bounces-1736-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994C907E3C
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2024 23:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3144B1F25C29
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2024 21:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B05143C59;
	Thu, 13 Jun 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxpZfHPL"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E913A260;
	Thu, 13 Jun 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718314682; cv=none; b=nUkRlypcV612A6ZbUJjHNUP8we7H2i99fNuG1b00uKYkj4cmaGk3sjfySxHclBts/C8kvAIzjT9XZ+CoKJ18gVUASGrIOwyWHi68ofQ33n5gqrXOzPoc4IO/196L1gEZ068+90XKfkJpfpWbz9hhVhEVAF/iGZXGRr+RNkw1b0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718314682; c=relaxed/simple;
	bh=zrwrgkHgf0k/mz0fO/ZrJHsn5zLm+HmD7za2NfmLHYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFLqm1CcwDRMEWySVKIsYLW3mW/sq+aL+2A7atcqkts0n9G5ZdX0awXVFDVdk+uhXA2pfK0ilStKVVat3kKfPdDvZMJNnsbZARLfPTfQqmwlsHuxpj2VAbVT9RjueiRkLL3Q+zJwFb8ZqCRVqD3ImASbv4Xu6ZUESXIjUQnaWDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxpZfHPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8965C2BBFC;
	Thu, 13 Jun 2024 21:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718314682;
	bh=zrwrgkHgf0k/mz0fO/ZrJHsn5zLm+HmD7za2NfmLHYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxpZfHPLlkF+MlHFCDCAZQWy1a1jT3xKcA9FaXyunVY5qvjzUM4UjW/mNcgmB5kXu
	 X6os4x6E/kjwCnxVSFK8SGiVBZtMtrXWY24n2YyuHqChMbBS0U0rVm2T2oWssZHDk2
	 kqLqik38S6XbJBGbdPlUj1m/j5NhJdK0Ymo36q90sSDFzEvg8jpfTz1lC37KaRmDc/
	 a3atldTXKwL4Q1pwJa+1tRtKysfaMH1h2W0h22AvaSGmruUDv7iYNgU2zeOoyNhKGd
	 +KVf+PGtdvpGbRmLzw9ivaQdYF3MfNrVpC75a2iaw3/SfviKTSy4jbgl1LCnH/WF0Y
	 HqyNd4QcY/r2Q==
Date: Thu, 13 Jun 2024 23:37:58 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Zack Weinberg <zack@owlfolio.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>, 'linux-man' <linux-man@vger.kernel.org>
Subject: Re: termios constants should be unsigned
Message-ID: <bvmbf4j5cbppljoayzyhuoj5jbgzep5o73e5ilcawjvatzzylt@fm5uwa6s7e3w>
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
 <f6ee2bd3-c1b7-4769-a313-b62f42c450ca@app.fastmail.com>
 <6ce7434a-56bd-4e95-80f1-b2857834b0d4@cs.ucla.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mqtdpz6dokvbci4v"
Content-Disposition: inline
In-Reply-To: <6ce7434a-56bd-4e95-80f1-b2857834b0d4@cs.ucla.edu>


--mqtdpz6dokvbci4v
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Paul Eggert <eggert@cs.ucla.edu>
Cc: Zack Weinberg <zack@owlfolio.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, 
	GNU libc development <libc-alpha@sourceware.org>, 'linux-man' <linux-man@vger.kernel.org>
Subject: Re: termios constants should be unsigned
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
 <f6ee2bd3-c1b7-4769-a313-b62f42c450ca@app.fastmail.com>
 <6ce7434a-56bd-4e95-80f1-b2857834b0d4@cs.ucla.edu>
MIME-Version: 1.0
In-Reply-To: <6ce7434a-56bd-4e95-80f1-b2857834b0d4@cs.ucla.edu>

On Thu, Jun 13, 2024 at 02:12:20PM GMT, Paul Eggert wrote:
> Part of the issue here is that GCC and Clang often do a better job of
> warning when constants are signed, not unsigned. For example, suppose a
> program mistakenly packages termios flags along with three other bits into
> an 'unsigned long', with code like this:
>=20
>   unsigned long
>   tagged_pendin (unsigned tag)
>   {
>     return (PENDIN << 3) | tag;
>   }
>=20
> Since PENDIN is 0x20000000 Clang and GCC by default warn about the mistak=
e,
> as the signed integer overflow has undefined behavior. But if PENDIN were
> changed to 0x20000000U the behavior would be well-defined, there would be=
 no
> warning even with -Wall -Wextra -Wsign-conversion, and the code would
> silently behave as if PENDIN were zero, which is not intended.
>=20
> This is another reason why appending "U" to PENDIN's value would have
> drawbacks as well as advantages.

Hmmmm, very interesting point!  I'll have that in mind when doing
bitwise stuff with constants.

--=20
<https://www.alejandro-colomar.es/>

--mqtdpz6dokvbci4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZrZrYACgkQnowa+77/
2zJe0g/9Hv8eurYUnke/u0UTskLN1aGVyuI5aB38XosdVlLr4kHI/DGdJsWwTjVY
NFPH4SfN3IdEm8dnywhjt9iH2NYramTHuE7mRnosdTBKU1ibFgvFuGzYr4fCoAMU
9nxM44DItUjM8uQPsjp5TSgRFhpCQlH27qusqp/nhYlnBhP/Dhajz9rBDDvYsP/y
m2rysWRxWZ6Fwq3wJ4YrGddtun+9qpMmXJtT9ETyl904x3h8ACfjGrRY/KDY9w/r
9HNNySrb9AwAHv5zL0koswf/VO1DqxOi2DgB0jhORYuxWqZ7CU30Lw74+g4osmKI
DtrCbHeQaopU5wmt4FXrl65c1aREVTSPI4SHaFXgiH59Ypf/AsDSMdpkyzhzr9Oe
wlMGZ+zd75ZM63m0bn89cw8ES5gavL5EjCgUBK3IYQCN/bfvzSICKUDDXNEmzPgi
BNvIjIGk3MWp9LXuOGzVupMAMZtU62++XFjxYyTTLwMZolNWEApo7zmU32ocp/xP
fU7QGkFo5z7AQQn9+22VuK+qslmqagAwDfAoE78+kP0NLUG4xyPn7agxelkTbfBU
Z21bBbYO03ziCL7vmZs6/AsKutV63VSbbu4h4duR5fsdJFj7lv2JTDU/emfkY+dl
sAYD6rzweGbFFACSOfHlR5zwedSgczYGC78+TGmYQn30JSiXLpY=
=jUk/
-----END PGP SIGNATURE-----

--mqtdpz6dokvbci4v--

