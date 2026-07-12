Return-Path: <linux-api+bounces-6831-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2zPnJISTU2r4bwMAu9opvQ
	(envelope-from <linux-api+bounces-6831-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 12 Jul 2026 15:15:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34180744C3C
	for <lists+linux-api@lfdr.de>; Sun, 12 Jul 2026 15:15:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VNEtcsuL;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6831-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6831-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DF2B301DCD6
	for <lists+linux-api@lfdr.de>; Sun, 12 Jul 2026 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6821257E;
	Sun, 12 Jul 2026 13:15:44 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D4AE56A;
	Sun, 12 Jul 2026 13:15:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783862144; cv=none; b=PI/GVTtH93zRZJYfmlgPE/IPYyeQAfSEW/SpUcD4YS6BlFV/G+qsru23QTHFqEjmRkNeAbTGMKDyDZjKgLaxayhsahR42tTb6Zu5Eu2KBJcWXyLBiJ99tS9bTMy4JyJjfdWNfcGMNXBrSnGj3gv95aGKwUyOyVEyoadVd8QGGYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783862144; c=relaxed/simple;
	bh=Nh88LM8tcn4ASu2ZHG0sNKD7t6K3lGnx5oaEMxt0uO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6+aNsdaNJRfyXo5YywUGhi45NcZbY6n8OQuGXn1HWQWzv5rotvomX4fJxhKzNf2t0ZDaQtIrXoERY8tu7gazfJpZtsxUtcHr6ADLOqdWXHCqrB68BuKiVX3aZnnU9j7n5ExpLul4e3cTVcON1q/bf2s8jXIPFUM6FsT9XoaC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNEtcsuL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923901F000E9;
	Sun, 12 Jul 2026 13:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783862142;
	bh=Nh88LM8tcn4ASu2ZHG0sNKD7t6K3lGnx5oaEMxt0uO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VNEtcsuLTmU2ucIIDm9TU0aOrgLG0PmCJHk9PDUon1AljI1F9FSR9LpQDVRUf+7qk
	 mgoU55c86qZCVDWkmdFQ8EMVU9zzS+lyg39dHwDfuEt0lyiZnIZN1ln2xyKpgaenGB
	 1Y2727IZNQLM6VZGXxCQ61q4lq4S7Lhw8TJAPrzGVverjXFvff/WoZBPjKCiqSd8AB
	 PzO2NVD8dVg2RkiBjK3Ps9x/u8HE9LkND7+WE21L/Zzx5p2saUMs7W5bdC2yyL5AyN
	 QfRmoMiFqPmlhSDsF1SJs8Fa3LmWQlgD+YMkIHm2TPCdqKy1fM9X/zs/nekbo1cyxa
	 9RoBKqvGPRffw==
Date: Sun, 12 Jul 2026 14:15:36 +0100
From: Conor Dooley <conor@kernel.org>
To: "Ousherovitch, Alex" <aousherovitch@rambus.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	"Krishnamoorthy, Saravanakrishnan" <skrishnamoorthy@rambus.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Rob Herring <robh@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Wittenauer, Joel" <Joel.Wittenauer@cryptography.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Nguyen, Thi" <thin@rambus.com>
Subject: Re: [PATCH v2 01/19] dt-bindings: crypto: add Rambus CryptoManager
 Hub
Message-ID: <20260712-washable-clapping-5dfb79d1bdef@spud>
References: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
 <20260709203037.1884436-2-skrishnamoorthy@rambus.com>
 <20260710-siding-unmatched-5e066fbe4c01@wendy>
 <SA3PR04MB9001E7DC9B2D4788EDCE2390D7FD2@SA3PR04MB9001.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pwarKFrPpjCIAVeL"
Content-Disposition: inline
In-Reply-To: <SA3PR04MB9001E7DC9B2D4788EDCE2390D7FD2@SA3PR04MB9001.namprd04.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6831-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:aousherovitch@rambus.com,m:conor.dooley@microchip.com,m:skrishnamoorthy@rambus.com,m:aou@eecs.berkeley.edu,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,linux-api@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 34180744C3C

--pwarKFrPpjCIAVeL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 11:14:11PM +0000, Ousherovitch, Alex wrote:
> On Fri, Jul 10, 2026 at 1:59 AM, Conor Dooley <conor.dooley@microchip.com=
> wrote:
>=20
> > This company no longer exists, you should probably introduce a rambus
> > vendor prefix instead.

Please fix your quoting, you need to retain context beyond what I said
so that people who get 100s of mails per day (me) remember what it was
in response to.

>=20
> Cryptography Research, Inc. does still exist -- it's now a wholly-owned
> subsidiary of Rambus (our co-maintainer is @cryptography.com). The
> prefix names the IP originator, which is consistent with existing
> subsidiary/acquired-vendor prefixes in the tree (e.g. al =3D Annapurna
> Labs under Amazon, mstar noted as acquired by MediaTek, fsl, cavium,
> xlnx). We'd prefer to keep "cri" on that basis, and can annotate the

I'm not sure that these examples actually aid your cause.
al has been replaced by amazon, fsl is not used for new devices, new xlnx
devices use amd (only example for now is the riscv stuff I think),
cavium has had nothing added in donkey's years etc. mstar I don't see
anything new in years either.

> description as "Cryptography Research, Inc. (a Rambus company)" to make
> the ownership explicit. Happy to switch if you feel strongly.
>=20
> > This property seems like it could be replaced by having a reg entry
> > for each mailbox.
>=20
> Agreed -- v3 will make each mailbox a subnode with its own reg window
> and drop cri,mbx-instances.
>=20
> > This looks like it should be deducible from a device-specific
> > compatible. [slots/strides]
>=20
> These aren't fixed per silicon -- they're the per-mailbox layout of the
> VCQ rings in host DMA memory, chosen at platform integration and
> programmed by the driver into the mailbox QUEUE/SLOTS/STRIDE registers.
> They can differ per mailbox on the same silicon, so a compatible can't

I'm not sure. Unless there's more than one instance, this definitely
sounds like something that you can determine from the compatible.
Generally these kinds of accelerators tend not to have multiple
instances though, so each platform will have a different compatible,
and the driver can store an array of mailbox configurations.


> encode them. v3 will keep them as optional, defaulted properties on the
> per-mailbox subnodes.
>=20
> > This whole subnode thing seems like it is only required because you
> > don't have device-specific compatibles [cores].
>=20
> Core presence is actually discoverable at runtime from the CORE_ENABLE
> register, so v3 will drop the per-core child nodes entirely and probe
> for enabled cores -- no per-variant compatible needed.

No, per-variant compatibles (for the devices/socs that this IP is
integrated into) are a requirement. While it would have been handy for
detecting capabilities, it's a requirement for other reasons:
differences between integrations be that functional or enforcing the
correct constraints on properties, issues only present on select
devices, etc.

On that note, I see there's no clocks or resets properties added by your
patch. While the IP may not have a reset (although I suspect it
probably does) there's no way it functions without a clock.

Cheers,
Conor.

>=20
> > this could probably be handled via reg-names? [affinity]
>=20
> Yes -- v3 will express affinity per mailbox (a "role" of a specific core
> type for a dedicated mailbox, or "generic" for the round-robin pool),
> which is the subnode analog of your reg-names idea. One caveat: this
> cleanly covers 1:1 core-to-mailbox dedication plus a shared pool; a
> mailbox dedicated to several specific cores would need multiple role
> tokens.
>=20
> Thanks -- this restructures nicely.

--pwarKFrPpjCIAVeL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalOTdAAKCRB4tDGHoIJi
0lBLAQCfKTJZqqNJen0s99xi2ILKiuhHavFoxTEtPcq0kWgfegEAhX1S0vi0KgKV
HVl4wR7EAY3dKcF5wQElXIiRRSMQVgM=
=gP2T
-----END PGP SIGNATURE-----

--pwarKFrPpjCIAVeL--

