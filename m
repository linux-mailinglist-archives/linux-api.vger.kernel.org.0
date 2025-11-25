Return-Path: <linux-api+bounces-5492-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 095ECC830D0
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 02:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E94044E4655
	for <lists+linux-api@lfdr.de>; Tue, 25 Nov 2025 01:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEE1A9FAC;
	Tue, 25 Nov 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dzwdz.net header.i=@dzwdz.net header.b="C8hdvPtl"
X-Original-To: linux-api@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075981B4F09
	for <linux-api@vger.kernel.org>; Tue, 25 Nov 2025 01:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764035437; cv=none; b=LoEsXkHU79j50F0xPy3r8aZvdGDy3bjjAc2Y3Rln4lxzC1A6ZybxbBcFQwcK/C8p3pCahXqxt9EGPhNyqNEY/iCSv57V0c1cOPuDTjMl4Tql9cRVk7x350rr5epSTZWnzUUrjVjRntkhR224ul0IM4Xz8fjtsZ+VrW7Q3/eOJxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764035437; c=relaxed/simple;
	bh=tA1EEPB5g8EbWUBOe9hcES3yi9cVRI6Dk1dzCgOHBzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQSHU6VjSdsRjqBxpkMhyi/OXcqNw6IQD73uFmWqxInja4fQN9xgyprxo0SvMgc9/l0KBfHlrIeq8jwFJYNi25NKHRKDLjHHWKPcpsUF/2H8KyYS7K1FV8EagOnucjWg8aYHfwwQMeOnrVeZYW9sNiPxi7K3jDB8kGV7W5xyboQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dzwdz.net; spf=pass smtp.mailfrom=dzwdz.net; dkim=pass (2048-bit key) header.d=dzwdz.net header.i=@dzwdz.net header.b=C8hdvPtl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dzwdz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dzwdz.net
Message-ID: <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dzwdz.net; s=key1;
	t=1764035423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tA1EEPB5g8EbWUBOe9hcES3yi9cVRI6Dk1dzCgOHBzE=;
	b=C8hdvPtlWDGBOasebEMxzjFIyQVXKUgl4ZWE+X+WA1kBiq79zWJMwPDXkjfcQRRYWYOpbl
	BvIAYM/P0qL4HyUfU4f8xQs8LreC50fIODrqPJ6Ix3czg5YPThi6nt38XMa7deTRHW7rtM
	cno45kPlZMQ07hWbLCR5arP1ll4O2Ygoy+nylhuUWfCxdm/PjTyRDQ5b8sFd7gd3z8Oh+v
	jYUBN+vA+mJCVF9xWNw1UcyR/QSV7hwlZ6jXlwpAjwEZ/1ejWBz6+SDqcTbnyg7JF9vtqZ
	TsBAczVnZ0jTJUhWBgFUSP+kS5A7eHw8HqC/16VUt6YN7DnYApSt+2vzo8FFnQ==
Date: Tue, 25 Nov 2025 02:50:19 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, ej@inai.de
References: <cover.1763130571.git.not@dzwdz.net>
 <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
Content-Language: en-US, pl
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: dzwdz <not@dzwdz.net>
Autocrypt: addr=not@dzwdz.net; keydata=
 xjMEaLoI3BYJKwYBBAHaRw8BAQdAz9aX/esCy0Q9BudRG1rXdo+DCQJDFADFKNaYyZnRk/DN
 FWR6d2R6IDxub3RAZHp3ZHoubmV0PsLBPwQTFgoBpwIbAwUJAO1OAAULCQgHAwUVCgkICwUW
 AgMBAAIeAQIXgBYhBOsX9f4IFOdcieO1LSjiaiZRZQv2BQJoujc2QBSAAAAAABAAJ3Byb29m
 QGFyaWFkbmUuaWRodHRwczovL2dpdC5zci5odC9+ZHp3ZHova2V5b3hpZGVfcHJvb2Y0FIAA
 AAAAEAAbcHJvb2ZAYXJpYWRuZS5pZGlyYzovL2lyYy5oYWNraW50Lm9yZy9kendkelcUgAAA
 AAAQAD5wcm9vZkBhcmlhZG5lLmlkaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vZHp3ZHovMGIx
 N2M2ZDk0ZjM2OGJlZDJhM2M2NTk4OTMxNDhlM2UzFIAAAAAAEAAacHJvb2ZAYXJpYWRuZS5p
 ZGRuczpub3QuZHp3ZHoubmV0P3R5cGU9VFhUNBSAAAAAABAAG3Byb29mQGFyaWFkbmUuaWRp
 cmM6Ly9pcmMubGliZXJhLmNoYXQvZHp3ZHoxFIAAAAAAEAAYcHJvb2ZAYXJpYWRuZS5pZGh0
 dHBzOi8vbG9ic3RlLnJzL35kendkegAKCRAo4momUWUL9gZ7AP92NUwydt7PvXE3nJxrzc8z
 zXy7932PUcqWi0EyyL0g6gEA92OwaOXjsJEj9SQT6L2rVs48M6NLTsTWBYeULHt7SQvOOARo
 ugkYEgorBgEEAZdVAQUBAQdAKREKv3RUs0sVu41DJHmRm2BWii+JVkscG4l9YlrL/mkDAQgH
 wn4EGBYKACYWIQTrF/X+CBTnXInjtS0o4momUWUL9gUCaLoJGAIbDAUJAO1OAAAKCRAo4mom
 UWUL9tKpAP4hrnUCmd/w22Huur8UIr1ipOPUbnKOEbNEEroYL4JmJwD+IijYhfW2lQurN3VD
 16zziWtajA+YA/n+hMg9izVgXwc=
In-Reply-To: <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BMTVIp0f79s511iRogKGtTVJ"
X-Migadu-Flow: FLOW_OUT

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BMTVIp0f79s511iRogKGtTVJ
Content-Type: multipart/mixed; boundary="------------c9LgEiEL390hwNGdBfjqf2xe";
 protected-headers="v1"
From: dzwdz <not@dzwdz.net>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, ej@inai.de
Message-ID: <b89c3f75-0b70-4620-b525-b264adb74c7b@dzwdz.net>
Subject: Re: [PATCH 0/2] man7/ip.7: Clarify PKTINFO's docs
References: <cover.1763130571.git.not@dzwdz.net>
 <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>
In-Reply-To: <vbdfw7ecw4mw4jlvcv4evtj7ngeqbxenr5wzxl56sn5d6ducw3@yomryb4vbtr5>

--------------c9LgEiEL390hwNGdBfjqf2xe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEvMTgvMjUgMTQ6NTEsIEFsZWphbmRybyBDb2xvbWFyIHdyb3RlOg0KPiBEbyB5b3Ug
c3VnZ2VzdCBtb3ZpbmcgZWFjaCBzb2NrZXQgb3B0aW9uIHRvIGEgbWFudWFsIHBhZ2UgdW5k
ZXINCj4gbWFuMmNvbnN0Lz8gIEkgdGhpbmsgSSBhZ3JlZSB3aXRoIHRoYXQuICBUaGVyZSdz
IHByZWNlZGVudCwgYW5kIGl0IG1ha2VzDQo+IHRoZSBwYWdlcyBtb3JlIHJlYWRhYmxlLg0K
DQpJbiBnZW5lcmFsIC0geWVzLCBkZWZpbml0ZWx5IQ0KDQpIb3dldmVyLCBzdHJ1Y3QgaW5f
cGt0aW5mbyBjYW4gYmUgcGFzc2VkIHRvIHNlbmRtc2cgZXZlbiBpZiBJUF9QS1RJTkZPIA0K
aXNuJ3Qgc2V0LCBzbyBJIGRvbid0IHRoaW5rIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gZG9j
dW1lbnQgaXQgaW4gZS5nLiANCklQX1BLVElORk8oMmNvbnN0KSAtIGl0IHNob3VsZCBwcm9i
YWJseSBnZXQgaXRzIG93biBtYW5wYWdlIGluIG1hbjJ0eXBlLg0KVGhhdCBvcHRpb24sIGlu
IHR1cm4sIG9ubHkgbWFrZXMgc2Vuc2UgaW4gdGhlIGNvbnRleHQgb2YgdGhhdCBzdHJ1Y3Qs
IHNvIA0KSSB0aGluayBpdCBzaG91bGQgcHJvYmFibHkgYmUgZG9jdW1lbnRlZCBpbiBpbl9w
a3RpbmZvKDJ0eXBlKS4NCg0KVGhpcyB3b3VsZCAva2luZGEvIGJlIGxpa2UgaG93IGUuZy4g
UEFfSU5UKDNjb25zdCkgcG9pbnRzIHRvIA0KcHJpbnRmLmgoM2hlYWQpLCBJIGd1ZXNzPw0K
DQpJJ2QgYmUgaGFwcHkgdG8gdHJ5IHdyaXRpbmcgdGhhdCBtYW5wYWdlIGlmIHlvdSB0aGlu
ayB0aGlzIGFwcHJvYWNoIA0KbWFrZXMgc2Vuc2UgOikNCg0KVGhhbmtzLA0KZHp3ZHoNCg==


--------------c9LgEiEL390hwNGdBfjqf2xe--

--------------BMTVIp0f79s511iRogKGtTVJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQS3V6hRlZD1kB2FLDBjtssx7Ny7DgUCaSULWwUDAAAAAAAKCRBjtssx7Ny7Djd6
AQDxA5T2+kSltw+aQgN4rQO/TPabZivm+CFgOFoLCG9xGgEA9akeqON+TFwT+dEW45DwQL4rvAlf
v+ljgXKbqNf1Ogc=
=SSPn
-----END PGP SIGNATURE-----

--------------BMTVIp0f79s511iRogKGtTVJ--

