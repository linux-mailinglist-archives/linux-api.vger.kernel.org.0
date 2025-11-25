Return-Path: <linux-api+bounces-5495-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FFDC84EEC
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 13:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D878C3B0BA4
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224731B10F;
	Tue, 25 Nov 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSml/tyO"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2706531A810;
	Tue, 25 Nov 2025 12:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764072786; cv=none; b=NkAOsd6e+hvLPbiSdVHL1bL0sx0UGN4GxtGHOO5LtbM0uRMS1/zx3YQDMnUg0Oz76+K6yLV8bG2lmsOmNLipC8XFaikPsBOGWYRweuoMH+iWNOfCsMTQwCWFkfbk79gUtvWV/zzr5N9H8iRqLP7OwRXRlKLJK2p56PmbKNHdZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764072786; c=relaxed/simple;
	bh=4V93kDUAbK6+eRwmPDO7chDm9jGX5qYfwCRXiNTe3G4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/5o5PrtLuJsiTFYY/vK19zixWRc4A1GoQczHc+MYcYQwKJJZQwJZZthQrnVweVFQL5qFh9OZmYbodSk5UGYzuwjT0nhj9wi+v3KHKGZvG6Oen4ZMmxTlhqyrasyHe/oyreGPOkO3Qm1kVrCF0Wv1vc3vOCIdmmDo/XivYccxWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSml/tyO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B515C19425;
	Tue, 25 Nov 2025 12:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764072785;
	bh=4V93kDUAbK6+eRwmPDO7chDm9jGX5qYfwCRXiNTe3G4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSml/tyOcUdFkL0bBzgYDwaeGxykU9GyB/vgRARfBCUWBGJdmlUziatP5dx+T6Mjd
	 xqg7mav8C7TN8mAJ0as//LBuefIXdfkCmrmU36EvYvG7IxUiBNZvJ89Rayu9YepbAw
	 fR5eR6giwKaCKXzacr+yZKNl2u7lyB/RP8IXjRNC8YQatJEeo7QIn+jsToCwuFpTCn
	 /K+bGZ5wbhoJd5/yqexGAs6uNny4a1MfyEMgNlUgJyehFrByq5EKq21w6PsyoIeaaN
	 uZNkVNoxiRUKExSLAvetbAGWh/2Mj2qAKZpaPykzhQOzVww3R4ahJp9nsZPB2yE5iz
	 bLp6mJGvtwJsg==
Date: Tue, 25 Nov 2025 13:13:01 +0100
From: Alejandro Colomar <alx@kernel.org>
To: dzwdz <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
Message-ID: <7zsiwtuwz3ybq6cymwkfbp2fxiliof25ko2zk77cgitfsxxgc6@x5jbr76h3f4s>
References: <cover.1763130571.git.not@dzwdz.net>
 <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
 <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wnpr7bymyat3ijge"
Content-Disposition: inline
In-Reply-To: <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>


--wnpr7bymyat3ijge
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: dzwdz <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
Message-ID: <7zsiwtuwz3ybq6cymwkfbp2fxiliof25ko2zk77cgitfsxxgc6@x5jbr76h3f4s>
References: <cover.1763130571.git.not@dzwdz.net>
 <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
 <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>
MIME-Version: 1.0
In-Reply-To: <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>

Hi dzwdz,

On Tue, Nov 25, 2025 at 02:50:19AM +0100, dzwdz wrote:
> On 11/18/25 14:51, Alejandro Colomar wrote:
> > Do you suggest moving each socket option to a manual page under
> > man2const/?  I think I agree with that.  There's precedent, and it makes
> > the pages more readable.
>=20
> In general - yes, definitely!

Done.  I've split ip(7) into a large amount of small pages this weekend.
Please have a look at them and suggest any improvements you consider
appropriate.  ;)

> However, struct in_pktinfo can be passed to sendmsg even if IP_PKTINFO is=
n't
> set, so I don't think it would make sense to document it in e.g.
> IP_PKTINFO(2const) - it should probably get its own manpage in man2type.
> That option, in turn, only makes sense in the context of that struct, so I
> think it should probably be documented in in_pktinfo(2type).
>=20
> This would /kinda/ be like how e.g. PA_INT(3const) points to
> printf.h(3head), I guess?
>=20
> I'd be happy to try writing that manpage if you think this approach makes
> sense :)

Yup, it makes sense.  :)

I'll simplify your work by doing some initial changes.  Please wait
a couple of days before starting, so I can finish doing that.


Have a lovely day!
Alex

>=20
> Thanks,
> dzwdz




--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--wnpr7bymyat3ijge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmklnU0ACgkQ64mZXMKQ
wqnNBw//XyAhmZvPTB7QRw8YEd/QqON+tSTQ5z8BuICHmQ5v/cj5MtapYcnjOe4m
8T+B5xX9RLbaxS0jdyCUuFsyttLpxK/O6hlQ+N9HLHq21qTvWzjrW/4XiUeeGKqM
ZhgGyQgLrk8OX4FRfAefGLr3Y/bKCe39qylMUMymMFyFChMnlJqFIBlldVNNQ/uW
qsTJzqeYDQSgqVOvPMG0Vzfm75ChmlKXEag10BIJ0IUDLxvTj+cBi+lFwK1bWPrx
dWHZMcTj5ap71yQ4bT46ShO0LnDEqHE2DeUFN5CFA9ekUyOhNx5D77m0SKUkTR/5
7t7HuqvIDoCXwjqRCH9IfsTP4qzi2KcNkgmGqtkyqrcFmjoE/OgASMmiFwD/dzKl
PqRwV1BWWZHoyByIBong7Q+jValSRlsxhBcODvcM94L0mbNyxDYxGyqSimlBAOAQ
UB7OlPjhr9gAdQ3gd4EZvGHcK0gbA3nGMX4+JyDqZVcV3j0rF/CVU3GgXjmhvsBi
qBQzuD2IOUCRv2HjgLd6pDIvCk8tv1QUPl8QfEMiV1Yw1M4CKGlHrC4q5uppdVSv
9JDEmCaTLXls/rRkWLFqg1IZsgPzigji4BmoNYbTG5ee+UZUcqiuKbKJd35HQEcL
JvmQr4QRGK9K7bTghca2qmdhJqzynfnAaVNRSMSeS9eBZzoqvIA=
=RxTj
-----END PGP SIGNATURE-----

--wnpr7bymyat3ijge--

