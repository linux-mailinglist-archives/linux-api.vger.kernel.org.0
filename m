Return-Path: <linux-api+bounces-5529-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED245C8BF73
	for <lists+linux-api@lfdr.de>; Wed, 26 Nov 2025 22:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95F924E113C
	for <lists+linux-api@lfdr.de>; Wed, 26 Nov 2025 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474E3225788;
	Wed, 26 Nov 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGW+wM4E"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FE945BE3;
	Wed, 26 Nov 2025 21:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191173; cv=none; b=skMYoldOoMSM676guAImKdjjlPRTesT254MMcoxr8PEDqVkEqaf8c4C2EkTjsfRWOOcoPILttK5TsUP4T36sm1yfbyql52NULslXhC7bzWS909tBvl3WrRFEtOhKhTlZc0F19ld5eS1JoCCsZ1XoTqtGhvba7gBLpakQN8dEdCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191173; c=relaxed/simple;
	bh=chPG1Hq3jMWfISrAyPSZCHkALI6TJRLR7Vx9r3UxTFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cD9zT2FI5/JiI7oW6vuKIMt/4vy72AJSSK9pPQGxcOAXVT/HjuZ1tD3uDhYeytGRS2FlpUdkfMFJkvB65hvY+sZtSB9Pfn8WE1wr07wR6gHJDuj6hAPPlezvAQ5joLA8wW0QEv5HbqGtvsNek4Kyv18OSDRayBXaglhGEDVzXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGW+wM4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B7C4CEF7;
	Wed, 26 Nov 2025 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764191172;
	bh=chPG1Hq3jMWfISrAyPSZCHkALI6TJRLR7Vx9r3UxTFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fGW+wM4Ee9C8LSAJxTH08Vto2qasANX8uSnY5Qkn88+vqbdOBb6+SLMhAhoN+OHow
	 zKHKUXXRbsy/92OyKfOnpkoJ/r4w0fLMa6EEsP0sR8PPB3ibCaHnfwckXxCD/OZzwo
	 76G80nPVcCyWvYBbv+Yjbnk71QyS+saflCu80GW59ejUak7AfpR8PSli1va2+1/mo1
	 8hKx+unf5NeGN9ulrMYRHuMSlxkFCUpLjq4hphWiHYJyPLYlvm7xNQV64UStSEVM/f
	 55IUPvdIpfm6GI5yquusRbs+T4370agbfmlnmnN1hfxZaWd7+rrAR7h24dR/esHBWw
	 3K68zIAvTrrvQ==
Date: Wed, 26 Nov 2025 22:06:08 +0100
From: Alejandro Colomar <alx@kernel.org>
To: dzwdz <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
Message-ID: <yidcan2omaer4aewp7f57oohdogg3l6nvw5udxho5opd2xupfn@5lj7fk4fogon>
References: <cover.1763130571.git.not@dzwdz.net>
 <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
 <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>
 <7zsiwtuwz3ybq6cymwkfbp2fxiliof25ko2zk77cgitfsxxgc6@x5jbr76h3f4s>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gcwjfbgf4cx3opda"
Content-Disposition: inline
In-Reply-To: <7zsiwtuwz3ybq6cymwkfbp2fxiliof25ko2zk77cgitfsxxgc6@x5jbr76h3f4s>


--gcwjfbgf4cx3opda
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: dzwdz <not@dzwdz.net>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, ej@inai.de
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
Message-ID: <yidcan2omaer4aewp7f57oohdogg3l6nvw5udxho5opd2xupfn@5lj7fk4fogon>
References: <cover.1763130571.git.not@dzwdz.net>
 <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
 <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>
 <7zsiwtuwz3ybq6cymwkfbp2fxiliof25ko2zk77cgitfsxxgc6@x5jbr76h3f4s>
MIME-Version: 1.0
In-Reply-To: <7zsiwtuwz3ybq6cymwkfbp2fxiliof25ko2zk77cgitfsxxgc6@x5jbr76h3f4s>

Hi Jakub,

On Tue, Nov 25, 2025 at 01:13:05PM +0100, Alejandro Colomar wrote:
> Hi dzwdz,
>=20
> On Tue, Nov 25, 2025 at 02:50:19AM +0100, dzwdz wrote:
> > On 11/18/25 14:51, Alejandro Colomar wrote:
> > > Do you suggest moving each socket option to a manual page under
> > > man2const/?  I think I agree with that.  There's precedent, and it ma=
kes
> > > the pages more readable.
> >=20
> > In general - yes, definitely!
>=20
> Done.  I've split ip(7) into a large amount of small pages this weekend.
> Please have a look at them and suggest any improvements you consider
> appropriate.  ;)
>=20
> > However, struct in_pktinfo can be passed to sendmsg even if IP_PKTINFO =
isn't
> > set, so I don't think it would make sense to document it in e.g.
> > IP_PKTINFO(2const) - it should probably get its own manpage in man2type.
> > That option, in turn, only makes sense in the context of that struct, s=
o I
> > think it should probably be documented in in_pktinfo(2type).
> >=20
> > This would /kinda/ be like how e.g. PA_INT(3const) points to
> > printf.h(3head), I guess?
> >=20
> > I'd be happy to try writing that manpage if you think this approach mak=
es
> > sense :)
>=20
> Yup, it makes sense.  :)
>=20
> I'll simplify your work by doing some initial changes.  Please wait
> a couple of days before starting, so I can finish doing that.

Done.  Please fetch the latest changes, and do what you consider
appropriate.  :)


Have a lovely night!
Alex

>=20
>=20
> Have a lovely day!
> Alex
>=20
> >=20
> > Thanks,
> > dzwdz
>=20
>=20
>=20
>=20
> --=20
> <https://www.alejandro-colomar.es>
> Use port 80 (that is, <...:80/>).



--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--gcwjfbgf4cx3opda
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmkna8AACgkQ64mZXMKQ
wqmQQRAAsCD1NI2ETqcG06Hbe+v892a+r4VH14oaDwHy79wrOAVbEnAlHJAVwehm
BILEUuS8zSpmv39wA9cucncYzyvZBJNWg66u0S3a6WtiHQyGjzQBCnAPO772i2su
KDeOCfp8jwtjTBYbUznPwo58HTt0jdmiYaF6wkZ2UrZXJzMfLWK0x9PfN8UGquxZ
MBU/qpiEQr5vWBES6ImZ41SnTsmZw3VNbmZCbOTDhMQkZYgezGe0G6szefCwVIhp
nn2rflYRJs4V5DLPk6epA+M8NJ6WoZgwVBWVDOTv+OWmxTBQ1NXINodNW1DI+B1A
xj9hjafMyrWRKsolRbHxh1OEYjp1u66KUfwwlF4V/iksC67Ndwra8Zc+zDBphe4f
uFO7+6B6fMWJqN9LJ9Vn9eFNcSN/+uvkx5dSp/vAMAyUiegLvUUZXYb1z94vlLMP
ZxsQXaSN9g2xDiEiGSuWqfyhxlhHzL7IfBU85/i+g7SC5DQ0R7vl7gk4UMQJf1bn
vx7yOeE/KKYSM1ZD3VqtLA5EmHb6OTpOE++FTGoqrl53rxutAo+RP9JAOoenyEy6
saoOn6xGzZxpZtvwMujXcL5qJEsvs46hU0dbn4OyCTh3/2G1FyhxCOBPi891UVg4
/hYmyejUkDGxWnHRr16ARcSuRTanrBYHLDoQc0JX+KxifxC0eP8=
=Tzgc
-----END PGP SIGNATURE-----

--gcwjfbgf4cx3opda--

