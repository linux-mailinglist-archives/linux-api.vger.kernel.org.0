Return-Path: <linux-api+bounces-1733-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227ED905E5B
	for <lists+linux-api@lfdr.de>; Thu, 13 Jun 2024 00:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C052F1F219C9
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 22:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8353786277;
	Wed, 12 Jun 2024 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy3kd3ru"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C71DFF0;
	Wed, 12 Jun 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718230965; cv=none; b=fH355OV3FY/lRvRWNIaM2jKdh6tRacx5tL3mffhSMG4xK4YVFOdpfDn2muT+Ccnz1M2gNMyFkVvGOO+6d08fhr4aKX7cRMLANcpTA+4Vvwfmjlw9Sle+UOV73IQpVL0Qq+NyDUPI1XnQuOOTzqgAlCymz2EBwS1OxHuGKwzRSLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718230965; c=relaxed/simple;
	bh=wora6/GK3AC9I3pp/xG4QqMLwFqaBLUohknys16mO9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYiKfQm6jqyKnJKrT0u3LmKr6w8h9+RNb/1iOICmkpPCKijnDeY3xQvn5BSfAK2MYojllD572pRAkzpwRkftDa+FUVt+JAzMVhPak1xIpExU1gUgmOxAolOd7he6IDt/EAG9a/PNDPw4wV+YXTL9WaGFlkSK2+kw0BCj5Hz0xes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy3kd3ru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F80FC116B1;
	Wed, 12 Jun 2024 22:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718230964;
	bh=wora6/GK3AC9I3pp/xG4QqMLwFqaBLUohknys16mO9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oy3kd3ruXyPZpI4hd5nCd7+5EEOcj0J5TxmCsBNMpGAPpCobIKj1BWo6UytR8gj2G
	 ujNtR8O9STuTHFZgXg5VcoIrTpsqMIUrym486VvnkymvjnPimgDEE0FirGbTVpmAb3
	 MY0O22vDR7dp600sy9PPw1bQMWQjFlQUaZQcBmbb+lJDig4EgeLAHTrhkPuQNRlpRi
	 U6j00lHFc7XW6hrnuQMr8fzjcR/0y7I2g3Ynr5OpiDR21hCtJIMXMx1ZDgN74C2ZMF
	 3ZU23N6NULQd7zR96NtvbX/svO7AxWjNxbs9uYmr+RpG+n2RKOoPuavRuctBVnTsvo
	 ncyNY2n3B42KA==
Date: Thu, 13 Jun 2024 00:22:41 +0200
From: Alejandro Colomar <alx@kernel.org>
To: enh <enh@google.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Palmer Dabbelt <palmer@rivosinc.com>, linux-api@vger.kernel.org, 
	libc-alpha@sourceware.org, linux-man@vger.kernel.org
Subject: Re: termios constants should be unsigned
Message-ID: <bb5dmeeekrlmrah4f3tvuw7qopsmbzq66vvh5k4vr4pamztuv7@dojfexrz545o>
References: <a7kfppfptkzvqys6cblwjudlpoghsycjglw57hxe2ywvruzkbd@e6nqpnxgwfnq>
 <87af5e8f-0dcb-44a0-94de-757cad7d5ded@cs.ucla.edu>
 <mdidkojqnhvf5b22vh3c4b6ajmq5miuyr3ole26kx2qkmnbfh3@woy2ghe5eyve>
 <CAJgzZorNc3gNVbiibz+DibrMLxc2dQoOS5NtL+RQUkSD-GMYaA@mail.gmail.com>
 <5rfohnr4rs3tkfs7y3f7rth36c67pvcwv4q52onrjohdjtpo7m@stvcsncq7z4f>
 <CAJgzZorzcAP5wNa-UCMyarmjgwVBveg0c0Dj36ByVEacnOHrnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gv3msdy22qpr4hpq"
Content-Disposition: inline
In-Reply-To: <CAJgzZorzcAP5wNa-UCMyarmjgwVBveg0c0Dj36ByVEacnOHrnw@mail.gmail.com>


--gv3msdy22qpr4hpq
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
 <5rfohnr4rs3tkfs7y3f7rth36c67pvcwv4q52onrjohdjtpo7m@stvcsncq7z4f>
 <CAJgzZorzcAP5wNa-UCMyarmjgwVBveg0c0Dj36ByVEacnOHrnw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJgzZorzcAP5wNa-UCMyarmjgwVBveg0c0Dj36ByVEacnOHrnw@mail.gmail.com>

Hi Elliott,

On Wed, Jun 12, 2024 at 05:54:43PM GMT, enh wrote:
> > BTW, that seems to be a bogus way to workaround this; the cast should
> > have been on the other side.  I'd say whoever maintains that code should
> > probably fix that to use unsigned types.
>=20
> indeed. i've already sent out such a change :-)
>=20
> >  These constants are meant to
> > be 'tcflag_t', so a cast should be to that type, or the type of the
> > other side of the comparison, but casting to 'int' just for silencing a
> > waring seems nuts.
>=20
> i suspect the reasoning was one of readability --- keeping the [short]
> constants legible at the cost of making the expression slightly
> longer.
>=20
> > This makes me wonder if breaking _those_ users could be a good thing...
>=20
> like Paul Eggert said somewhere else today --- only if we're finding
> real bugs. and so far we're not.
>=20
> it's like the warn_unused_result argument. a purist would argue that
> every function should have that annotation, because you should always
> check for errors, and if you're not already doing so, your code is
> already broken. whereas a pragmatist would argue that most people are
> just going to add the "shut up, compiler" cast (or disable the warning
> entirely) if their already-working code suddenly starts spamming
> warnings next time they build it.
>=20
> while my bar for that might not be as high as my bar for ABI breakage,
> my source compatibility bar is still pretty high. it would be almost
> unethical of me to make app developers do random busywork. i have to
> be pretty confident (as with, say, "you just passed an fd > 1024 to an
> fd_set function/macro and thus corrupted memory") that their code is
> _definitely_ wrong. (and even there, that's going to have to be a
> runtime check!)

Yeah, I can agree with that.  I'm that kind of pedantic purist for my
own code, and it's painful that historic accidents like this one don't
allow me to be so in my own code.  But I agree that fixing the entire
world when their code is braindamaged but works is asking too much.

I'll just disable that pedantic warning when I use termbits.  :)

Btw, thanks for fixing that brain-damaged cast.  ;-)

Have a lovely night!
Alex

--=20
<https://www.alejandro-colomar.es/>

--gv3msdy22qpr4hpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmZqH7AACgkQnowa+77/
2zKZbQ//bnQoFyceZ3KOQPPBeNP+onIPQDyehc/PbqnMveyhtSe+49gozKi+NdPC
Vs9XW6EayZ1SNTdABXMIX7AySXR4UPtS85Nw97M4vinRTy4iBtICupx465J72Pkx
QhoGvBoVk9WiuzsDS/eI6zmj/flvwATBjHFF78Kmq2ZP+Q/ij9nb9VGEri0bOX/D
rdFwhN+fbO9PwUoaC2PakL+PPlatnaXbqrqPu548FZp+gZEJK/t/XHXVMf/kASjp
S45T+sdhfGKbtbeRcyCfAunn7JwUSNcDUCe8Jj/7Z+TqvDcX/T0+MIB2lckYtnOI
GcS586u/4VmlSbakez+65hXzVuwfmjrgNLHPwkyk9DjqbfURxoHFQROO0S3XuK5Z
raX3UAy2d+pxVHSmYpL6vi5skjuzZ8wPWIoXnr8wdB/9SpYD6RaA+Djyj1bnAWVl
O13EiH5TJDsJ9IrjAaswsyF3g18g4gm1BK4W9UOz3d3ljoBiVCSEmHRP5l6kKbjg
p3LJp8AJlh2P3ESW3qtkA0Fuq2ot86bN8kYCUktWLc2+D249/DfrdBGTKGHxZNto
DeRsPvtl5YLnL22sD1GAVgzqI92bNBCalVQRPrjLuASaXpF++kLlyDq5myrEXi3W
G6liYvJOT3rScsN0wK9BbO5UZCY6OFoiKLc2QwzMeQGbCShAtRw=
=/0Q+
-----END PGP SIGNATURE-----

--gv3msdy22qpr4hpq--

