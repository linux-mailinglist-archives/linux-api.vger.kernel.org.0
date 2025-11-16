Return-Path: <linux-api+bounces-5304-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC177C60E20
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 01:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 514C2361877
	for <lists+linux-api@lfdr.de>; Sun, 16 Nov 2025 00:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497F91E5B88;
	Sun, 16 Nov 2025 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="frRTY50N"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AF2183CC3;
	Sun, 16 Nov 2025 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763254080; cv=none; b=atsV9s6WBsM9OPaZUzXgAF+lmYptzdnQtPBFpGBJ0LJDVMZA87gC5i1/0/AnM9ZSlZ3v7Rz4xPCGG5YKhcs945E1qj9stXGsU4xtgtUDye9qsZ00ikwO3n5oqmlNMT7siX9BQlJjIqJeFzeri/G+TXqJ9dQo4JDG6tzLUzYLL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763254080; c=relaxed/simple;
	bh=4Fm2KFD6qpiUF1onn2drzUH/6heEStbzNEpoDDp5l7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCabIe33ZOLvPkAQCmlKfb15UiCWjRyugqtGNmkqnB2WJalNzhoH2hKz/Ue3QOUG3ltt7xc6I1IT3K71c9Z8PYiLSabfFr3XRPjC9Mz4Xjk13Sa1NnEem8+rjupoml90xSDI35asyaJ/tRpdV2QVzZBdNds9DuR0Cv8cvA1BzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=frRTY50N reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AG0lbca3277012
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 15 Nov 2025 16:47:40 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AG0lbca3277012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1763254066;
	bh=OTohMxDctL+N1RZVFe4ejI/vvpQQqRI7JMQ/mGjWJBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=frRTY50Nf8atDwpW3mateVklpYa0EM01BoooCdH+BxibGWhecyintnjXfjBYid6Cw
	 P7vsQtTBxsLMhe58/a3kVQpnCQLxfMkgfaCcLcpl68BjAovNEIxvyuudxxYjoTwGLO
	 AqxAS+ym/YH0QSEUOw3/Ri2iI6ckiy2UCCNigKsfrcYk2BbQIrqGFIyC/OF7+GZAeB
	 j2kUIw5IQ2GpvxHCjPNOewZYHT9grIv9y8NCd0TbstJUYflVlB9VY2OrS+d1U00MNt
	 SB8DjMXdfjZKn3RNWtATYV0cDSEaARfYKrCubKSFda6oHpskZj0XfPaoGeD5g1SM3w
	 rA7u4cgEfCXtQ==
Message-ID: <2846db90-fb05-41d2-b8de-c678af75a04b@zytor.com>
Date: Sat, 15 Nov 2025 16:47:37 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
To: Ned Ulbricht <nedu@netscape.net>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
 <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
 <2025111214-doily-anyway-b24b@gregkh>
 <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com>
 <2025111241-domestic-moonstone-f75f@gregkh>
 <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com>
 <2025111227-equipment-magnetism-1443@gregkh>
 <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
 <alpine.DEB.2.21.2511141836130.47194@angie.orcam.me.uk>
 <B72D6F71-7C0B-4C5A-8866-25D7946E0932@zytor.com>
 <6c26eea2-6f90-f48a-9488-e7480f086c70@netscape.net>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <6c26eea2-6f90-f48a-9488-e7480f086c70@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-15 13:29, Ned Ulbricht wrote:
> |
> | O_TTY_INIT
> 
> https://pubs.opengroup.org/onlinepubs/9799919799/
> 
> That's what motivates my first-glance preference to name this new flag,
> which will have approximately opposite behavior, as O_TTY_NOINIT.
> 
> But as a generic abstraction, I more prefer O_KEEP.
> 

O_KEEP seems a little vague, but O_KEEPCONFIG seems like a decent name.

It seems like we don't have several new flags:

	O_EXEC
	O_SEARCH
	O_CLOFORK
	O_TTY_INIT
	O_RSYNC
	O_NOCLOBBER

Some of them *may* be possible to construct with existing Linux options, I'm
not 100% sure; in particular O_SEARCH might be the same as (O_DIRECTORY|O_PATH).

O_NOCLOBBER looks like an odd in-between between O_EXCL and
(O_EXCL|O_NOFOLLOW); stated to be specifically to implement the shell
"noclobber" semantic.

	-hpa


