Return-Path: <linux-api+bounces-5198-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED2BC495B1
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 22:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E645B4E16E1
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 21:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8EC2F8BD9;
	Mon, 10 Nov 2025 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WY5x0sTK"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058E2F261F;
	Mon, 10 Nov 2025 21:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808766; cv=none; b=dVzcFB0A4mB8dvcskinwLG3UgTHqaXmww3FguYBRXhYmJZWqRXxxFxeJUFALzN5eNSurBQmmkNFNqyoeykgf7/PFOZAYNzbbQfl9FQhMDStaNUyaWdlHAVYyjUawFI57/k3Ui+sQZKhTRrpxCVkyoZ9mVQKOaF8urupDFeL9N4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808766; c=relaxed/simple;
	bh=9cfxn/oUsGlRr4HORwfIBaS2O2MvzZRemJYtt1/icec=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hI2z+0Ir30L/PfFhRK9rkSeDH53NoXMN+w0LenTs70rOl1iSBo+Dt6yyeKM6xr0t5fXUfURT627Z/U5TAOWaCAN1sMLW2AisB47tMPVwu+PQizWmmKWr3HHiklVQltwADyMRm1I6MQLNEp1uBxI0cbq+aKhDv6tgcVOg35edDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WY5x0sTK reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AAL5tBY3818165
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 10 Nov 2025 13:05:56 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AAL5tBY3818165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762808756;
	bh=9T8fcuIV2S3fsjbzreBB9AjatC5kysDZWffRB4veUGk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WY5x0sTKR6Vy5BGK6oSm5iUWbpO6dXlVg8+0v9rKk1wc+Uh/b8Js48FYKxngpaqaC
	 Rrc2+NkMBMniG2FFFcUnWy1VxnP0D9x8szFXk8HiFdlPAy4tKAWm+9u6MVBCxsxjQP
	 wtN4PKbX88cC6/CRQj73ayvrhiavbBA2eoLAf2vz3p7DFeXVWBh2V+NpCTgvKwDpdb
	 +dyu4EF6jjToRLxcMjpxVB3NxCcDyT5f6QlF145fl22LwQYNDD5qsW8yuNsrdD0LvV
	 bP5VCTz/OekOmCBBDQriIkLbbgtEdEx767zOUD7PD5FFjI78jmlTGiuDUaMAnEX8m7
	 wCY1xUvqkB/mg==
Date: Mon, 10 Nov 2025 13:05:55 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Maarten Brock <Maarten.Brock@sttls.nl>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
User-Agent: K-9 Mail for Android
In-Reply-To: <20251110201933.GH2988753@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com> <20251107173743.GA3131573@mit.edu> <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com> <20251110033556.GC2988753@mit.edu> <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com> <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com> <20251110201933.GH2988753@mit.edu>
Message-ID: <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 10, 2025 12:19:33 PM PST, Theodore Ts'o <tytso@mit=2Eedu> wrote=
:
>On Mon, Nov 10, 2025 at 10:06:02AM +0000, Maarten Brock wrote:
>> I fully agree that you cannot expect users that wired something like RS=
485 Driver
>> Enable or a microcontroller reset to RTS or DTR to write their own kern=
el driver=2E
>> And you need to open the port to make the appropriate settings=2E But o=
pening a
>> port should not e=2Eg=2E claim the RS485 bus and mess up whatever commu=
nication
>> was going on there=2E
>
>Again, the existing seral driver code *will* mess with RTS and DTR at
>boot up because that's part of the autoconfiuration code, and that was
>added because it was needed for some number of serial ports=2E
>
>If that's going to "mess up" the RS485 bus, maybe we need accept that
>RS-232 !=3D RS-485 and have a different driver for the two=2E  That's
>going to be a lot simpler than trying to make the same code work for
>both RS-232 and RS-485, and claiming that the existing RS-232 code is
>"fundamentally buggy" when it interacts poorly with something that has
>very different requirements than the historical RS-232 use cases=2E
>
>              	  	     	    - Ted

I didn't say it was fundamentally buggy; if I did or implied it I apologiz=
e=2E It is most definitely not; however, in some cases it is undesired or u=
ndesirable *due to shifts in usage patterns=2E*

This isn't a bug at all but an enormous strength=2E That a 65-year-old sta=
ndard =E2=80=94 both hardware and software =E2=80=94 designed for teletypes=
 and dumb terminals can still be useful today is almost the definition of s=
uccess=2E And, yes, some glitches in that process are going to be inevitabl=
e =E2=80=94 like the mistake of retaining the termio Bxxx emumeration const=
ants in the termios interface=2E But we deal with it by gradual evolution o=
f interfaces=2E=20

One such example is RTS itself: the RS485 definition is, in fact, the orig=
inally intended meaning of RTS: it is a request to the DCE to negotiate tra=
nsmission privilege and activate transmission mode over a half duplex chann=
el, after which it asserts CTS=2E RTS/CTS flow control was a nonstandard ad=
aption to allow for binary transparent flow control over full duplex links =
=E2=80=94 it wasn't formally standardized until 1991, and the signal is for=
mally named RTR when used that way=2E However, RTR and RTS share hardware i=
n nearly all existing implementations, and share pins in the standard =E2=
=80=94 so whether or not you are using RTR or RTS is a property of the DCE,=
 not DTE, and needs to be configured into the DTE=2E

Requiring new drivers for the gajillion different hardware devices already=
 supported and then having the problem of which drivers claim it isn't real=
ly any better of a solution; one could in fact argue it is *exactly* equiva=
lent to being able to indicate to the driver what mode one wants it to oper=
ate in before it does its configuration=2E

The parport driver layer is kind of similar to this, in some ways, but in =
the tty layer that is mostly handled by line disciplines instead=2E (The pa=
rport hardware was generally abused on a much lower level, as a substitute =
for GPIOs, so even the notion of a byte stream wasn't there=2E)

*If* I'm reading the code correctly =E2=80=93 which is a little complicate=
d due to the sheer number of abstraction layers =E2=80=93 hardware initiali=
zation is already deferred until first open, which would mean that disablin=
g autoconfiguration (one of the features in TIOCSSERIAL) would again be a v=
alid reason for wanting to be able to communicate with a device driver befo=
re requiring that it puts the underlying hardware in the state expected for=
 operation *in the mode configured* (catch-22)=2E

As I stated, this is inherently going to be a best effort=2E For some devi=
ces that may mean simply leaving the power on default in place (in this spe=
cific case, presumably, DTR# and RTS# deasserted=2E) However, once the stat=
e is already known to the kernel then there is no such issue for any hardwa=
re=2E=20

As far as naming is concerned: O_RAW is really suboptimal, as it has exact=
ly the same implications as O_DIRECT (I/O goes straight to the device with =
no buffering=2E) I don't like the idea of abusing O_DIRECT at all; I only b=
rought it up as a fallback alternative=2E I genuinely do believe that if we=
 assign a new open flag it will find use cases outside the tty/serial port =
subsystems, and if there is anything Unix has done right it is to generaliz=
e interfaces as much as possible, case in point descriptors=2E=20




