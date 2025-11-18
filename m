Return-Path: <linux-api+bounces-5366-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E52C6AF9F
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 18:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 749642CE55
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 17:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447AA2FF666;
	Tue, 18 Nov 2025 17:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i28ESFmx"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94CA31ED97;
	Tue, 18 Nov 2025 17:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763487113; cv=none; b=idwRaCwPEFczZfhMKaYHBT9rjNdvVdYmEXgs8FC65BxyznD8kmR/kHjVDU0TA1APIP20TIlVBU0sXRHTA/a3hVYv6uOhrQX5Ylyjs1B2MKrrmujF0AINpSsmSNtz7n85rE2eDq4K4dWRKUzoVY46yEkq7TAqdpRfHu2fQ/v7yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763487113; c=relaxed/simple;
	bh=C7RdLG0wlPu67ot7KDxMwGOmJEXMl60GDLIGhCKgV4A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QKhoDnmAj8pDLyGIK+01pHa6d6Sfz0ijR598RiauRaJUElVfevvf4KjYlvnrQEBCuLHpkwKtBw8fHN2mbbTiHzQFVnrQuClK8LmmHPCbqRGFeR2Kbdbpmr1u9razDrjnJCz6N6KGaeojT6lyM7hN7N0bGWXm3w3R8w3zBLSHISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=i28ESFmx reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AIHVX9d940936
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Nov 2025 09:31:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AIHVX9d940936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1763487094;
	bh=IXQKSxt11QiWndnOEMEhWq7yTCo3UWo5ce8g2AbNtfU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=i28ESFmxloQxvsRCQbAhZ0d0SFcn69s9IoZKHgG1T8PHsCZq7ZFaHplRKogkdb/gV
	 cIm4efwSSydaaSqKsmbJY/9fzJpOVQhciqHI/d9utlZThQlrn2lZ1Njg8VbRnI/2N7
	 1kG3KqCCTwBV0Mn5ug0edFKTjKQN9lMBlU3wdxrEzRQuin7pP0lS10cFE8Cuxz1XeR
	 Fjtz4tzvebPyCMLGZRcPOB9g7dnLvKM9S+Pd/WUlpvJAEFlTxgzxhDIXwx5QiL07xW
	 S5T94zD7xVNz2WCFBhpDu42cl1o6B2ieWK6I7JGIv5IY+xYncohsatVRSgPRsqnB3Q
	 SnQb/ahLPjV+g==
Date: Tue, 18 Nov 2025 09:31:33 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Ned Ulbricht <nedu@netscape.net>, "Maciej W. Rozycki" <macro@orcam.me.uk>
CC: Greg KH <gregkh@linuxfoundation.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
User-Agent: K-9 Mail for Android
In-Reply-To: <06279d25-73d6-01f5-dcf8-8667415048d2@netscape.net>
References: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com> <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com> <20251110201933.GH2988753@mit.edu> <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com> <20251111035143.GJ2988753@mit.edu> <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com> <2025111214-doily-anyway-b24b@gregkh> <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com> <2025111241-domestic-moonstone-f75f@gregkh> <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com> <2025111227-equipment-magnetism-1443@gregkh> <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com> <alpine.DEB.2.21.2511141836130.47194@angie.orcam.me.uk> <B72D6F71-7C0B-4C5A-8866-25D7946E0932@zytor.com> <6c26eea2-6f90-f48a-9488-e7480f086c70@netscape.net> <2846db90-fb05-41d2-b8de-c678af75a04b@zytor.com> <06279d25-73d6-01f5-dcf8-8667415048d2@netscape.net>
Message-ID: <274BA19A-1432-481F-9BA1-6983DFABD542@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 18, 2025 8:33:07 AM PST, Ned Ulbricht <nedu@netscape=2Enet> wro=
te:
>On 11/15/25 16:47, H=2E Peter Anvin wrote:
>> On 2025-11-15 13:29, Ned Ulbricht wrote:
>>> |
>>> | O_TTY_INIT
>>>=20
>>> https://pubs=2Eopengroup=2Eorg/onlinepubs/9799919799/
>>>=20
>>> That's what motivates my first-glance preference to name this new flag=
,
>>> which will have approximately opposite behavior, as O_TTY_NOINIT=2E
>>>=20
>>> But as a generic abstraction, I more prefer O_KEEP=2E
>>>=20
>>=20
>> O_KEEP seems a little vague, but O_KEEPCONFIG seems like a decent name=
=2E
>>=20
>> It seems like we don't have several new flags:
>>=20
>> 	O_EXEC
>> 	O_SEARCH
>> 	O_CLOFORK
>> 	O_TTY_INIT
>> 	O_RSYNC
>> 	O_NOCLOBBER
>>=20
>> Some of them *may* be possible to construct with existing Linux options=
, I'm
>> not 100% sure; in particular O_SEARCH might be the same as (O_DIRECTORY=
|O_PATH)=2E
>>=20
>> O_NOCLOBBER looks like an odd in-between between O_EXCL and
>> (O_EXCL|O_NOFOLLOW); stated to be specifically to implement the shell
>> "noclobber" semantic=2E
>
>"(O_EXCL|O_NOFOLLOW)" provokes a thought=2E=2E=2E
>
>As essential context, fs/open=2Ec build_open_flags() has:
>
>if (flags & O_CREAT) {
>	op->intent |=3D LOOKUP_CREATE;
>	if (flags & O_EXCL) {
>		op->intent |=3D LOOKUP_EXCL;
>		flags |=3D O_NOFOLLOW;
>	}
>}
>
>if (!(flags & O_NOFOLLOW))
>	lookup_flags |=3D LOOKUP_FOLLOW;
>
>So with that context, just imagine hypothetically implementing both a
>non-zero O_TTY_INIT flag and an O_KEEPCONFIG flag=2E What would
>build_open_flags() look like to handle the case where userspace
>simultaneously asserts both flags?  Even if it's documented, specified
>as unspecified behavior, what would the code actually do?
>
>Or, alternatively, should an hypothetical standardization insist that in
>any implementation, one of O_TTY_INIT, O_KEEPCONFIG must be #define'd 0?
>
>
>Ned

It's not actually a contradiction: it means preserve all configuration *ex=
cept* the minimal termios tweaks required to bring it inside the POSIX comp=
liant envelope, notably setting winsize to "appropriate default parameters=
=2E"

Linux doesn't have a lot of such settings, but I can see at least one *ver=
y useful* one: bringing B19200 and B38400 (EXTA and EXTB), which can be twe=
aked by setserial, back to their proper baud rates=2E

There are even two ways to do that: either keep the B19200/B38400 setting =
and change the baud rate, or keep the baud rate and change termios to match=
 (using BOTHER if necessary; after my changes to glibc 2=2E42+ BOTHER is a =
private interface between glibc and the kernel and thus doesn't break POSIX=
 compliance=2E)

A fairly reasonable implementation would be the first with O_TTY_INIT and =
the second with O_TTY_INIT | O_KEEPCONFIG=2E

Flags in termios that probably should be cleared by O_TTY_INIT are CMSPAR,=
 OLCUC, IUCLC, IMAXBEL, ECHOPRT, ECHOKE, FLUSHO, PENDIN, IEXTEN and EXTPROC=
; I'm not sure about ADDRB, CRTSCTS, IUTF8 or the line discipline; at least=
 with O_KEEPCONFIG at least CRTSCTS ought to be kept I would think, as chan=
ging it would have immediate effect visible to=20

Obviously an application that wants to absolutely minimize changes must no=
t pass O_TTY_INIT=2E

The other (and simpler!) option is to simply declare O_KEEPCONFIG | O_TTY_=
INIT as a reserved bit combination and return -EINVAL until we find a good =
reason to do anything different=2E

