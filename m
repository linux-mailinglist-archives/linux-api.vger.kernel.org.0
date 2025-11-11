Return-Path: <linux-api+bounces-5200-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1610DC4B60F
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 04:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F533B560F
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 03:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23C231282E;
	Tue, 11 Nov 2025 03:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lceUp8fa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E363081B8;
	Tue, 11 Nov 2025 03:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833452; cv=none; b=ByjD4HLzP55GGDTZwgc4hZ0S5mQ9abHsK8hu1bLI5W/du1/D8IPVXzay2d5Mwd/8Ug0pwHai2ycJIfbPmOalbqI6C2bMl0SqLXf4/f3vXpM40ePklCJXOB7LWGAezX5zBBjcpQBC40RDBCv9iGtBceHUgzz4MhMeoi1yoMa/aaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833452; c=relaxed/simple;
	bh=LQA5on0TxGqgnTuDEC50GZj2rrEzASdsxp2IZR+2/6I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=alit67Ptqfg5TndsRtEpWbXYbckg+XiHiGEulrTzLc7rlNapEjjOJqJUqAABKPzwfZvhieMxX3uQX+gBmTFdH7hUMrYP00GUBiPGPfELxARWYs7H9D9Dzc4p/iD7VtYzmrA85BS/vcHx+xA5Fsid0e8DGOoWCO/DTOw3Or/jIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=lceUp8fa reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AB3vNds4012264
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 10 Nov 2025 19:57:23 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AB3vNds4012264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762833443;
	bh=E/UUmDU8iYSzOACsfPRbXyyUKlSSb8AagEMpFeEUdZs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=lceUp8fa5g8T0bqEAZXBHi93Uraj4C1EkZk/qyfmKPYOoillDOPoq6LTmOOLS75P3
	 iIVYBLJsGAL2yeLYFXyJfrdfklV5xTedMxaJMlYOpbrzZOMWlhRkXrnj2tEJbdTc0P
	 mFZcSMIS9ZLrIOqVoV1rI6y38umDMd99AuXd1D3DgNVu3h2Ks87szAHDB1oF2uL1Pt
	 hhyyMyK5+umpZSuG+07H0DpU541jTFBNouA/4a5VJD4bnXS8ssYfYbl8tFA4MBuo0C
	 lLn1rJXOdXpH3LRvfWj7Uw8W6814D+/MsGC1kuyKYss77UBJnTCoyKQMVqtF1aO1wO
	 VR+KoFrs0ku1w==
Date: Mon, 10 Nov 2025 19:57:22 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Theodore Ts'o" <tytso@mit.edu>
CC: Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
User-Agent: K-9 Mail for Android
In-Reply-To: <20251111035143.GJ2988753@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com> <20251107173743.GA3131573@mit.edu> <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com> <20251110033556.GC2988753@mit.edu> <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com> <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com> <20251110201933.GH2988753@mit.edu> <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com> <20251111035143.GJ2988753@mit.edu>
Message-ID: <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 10, 2025 7:51:43 PM PST, Theodore Ts'o <tytso@mit=2Eedu> wrote:
>On Mon, Nov 10, 2025 at 01:05:55PM -0800, H=2E Peter Anvin wrote:
>>=20
>> The parport driver layer is kind of similar to this, in some ways,
>> but in the tty layer that is mostly handled by line disciplines
>> instead=2E (The parport hardware was generally abused on a much lower
>> level, as a substitute for GPIOs, so even the notion of a byte
>> stream wasn't there=2E)
>
>I'm not an RS-485 expert, but over the years, I've heard all sorts of
>"interesting" timing requirements=2E  For example RTS can only be
>dropped when the UART's shift register has completely drained=2E  That's
>not when the OS has sent the characters to the FIFO (which is why
>tcdrain isn't quite what you want); it's not when the UART has sent
>the transmit interrupt, but when the UART's shift register is *empty*=2E
>Doing this via the termios interface is decidedly non-optimal[1]=2E
>
>[1] https://www=2Emoxa=2Ecom=2Ecn/getmedia/a07808dd-f3d7-473b-9a2f-93b5ce=
673bb1/moxa-the-secrets-of-rs-485-half-duplex-communication-tech-note-v1=2E=
0=2Epdf
>
>It *can* be done, sure, with some strategic usleep()'s, but not
>necessarily optimally, and it is decidedly hacky=2E  From what I can
>tell, it's actually not *that* different from treating RTS as a GPIO
>pin, and really, this ought to be done in the kernel if you want
>optimal control oer the timing of when RTS gets toggeled=2E
>
>> *If* I'm reading the code correctly =E2=80=93 which is a little complic=
ated due to the sheer number of abstraction layers =E2=80=93 hardware initi=
alization is already deferred until first open, which would mean that disab=
ling autoconfiguration (one of the features in TIOCSSERIAL) would again be =
a valid reason for wanting to be able to communicate with a device driver b=
efore requiring that it puts the underlying hardware in the state expected =
for operation *in the mode configured* (catch-22)=2E
>
>Well, part of the problem is that the PC's serial port predates PCI,
>so there's no way we can tell whether or not there is a serial port at
>a particular I/O port except by poking certain I/O ports, and seeing
>if there is something that looks like a UART which responds=2E
>Hopefully this won't accidentaly cause the NSA's thermite-charge
>self-destruct charge from getting set off, and in practice, mainboard
>designers who try to put things at the COM1/2/3/4 generally get weeded
>out thanks to natural selection, hopefully without harming users along
>the way=2E  :-)
>
>Worse, we also wanted to support serial cards that were at
>non-standard ports, or using non-standard interrupts, and so that's
>one of the reason hardware initialization is deferred until after we
>have a chance to configure the serial device's I/O port and interrupt=2E
>
>Now, we are in the 21st century, and just as we are trying to declare
>32-bit i386 dead (to the disappointment of legacy hardware owners
>everywhere who are whining about Debian dropping installer support for
>i386), we could try to declare the ISA bus as dead, and no longer
>being supported, and we could probably drop a bunch of this
>complexity=2E  We probably would need to support COM 1/2/3/4 ports since
>these still tend to be hardwared without a way of detecting it their
>existing via USB or PCI bus discovery mechanisms=2E  And for those, we
>would still need to do UART autoconfiguration=2E  I suppose we could
>just assume that all UART's are 16550A's, and that noone would
>actually use older UART's type --- except (a) I bet there are some
>cheap-skate embedded computer designers who decided to use a 8250
>instead of 16550A for $REASONS$, and because of the extreme timing
>requirements of some RS-485 use cases, I believe I have seen
>recommendations to use setserial to actually force the UART into 8250
>mode, to disable the TX FIFO --- all to satisfying the weird-shit RTS
>timing requirements=2E  (This is where I get my beief that RS-485 !=3D
>RS-232, and if you want to do all of this weird-shit timing
>requirements because you are trying to implemet a multi-node bus which
>is half-duplex, maybe this should be done in the kernel, damn it!)
>
>
>How about this?  If you really don't want to open the device to
>configure it not to assert DTR/RTS, perhaps we could specify on the
>boot command line that one of TTYS[0123] has a different default line
>discipline, and when tty's are opened when the RS-485 line displine,
>the RS-485 rules apply, which would include not messing with DTR/RTS,
>and if you want to play games with RTS getting dropped as soon as the
>last bit has let the transmit shift register, we can get the kernel do
>this in the line discpline, which arguably would be *way* more
>reliable than playing GPIO-style timing games in userspace=2E
>
>	      	      		 	      - Ted

I really think you are looking at this from a very odd point of view, and =
you seem to be very inconsistent=2E Boot time setup? Isn't that what setser=
ial is for? We have the ability to feed this configuration already, but you=
 need a file descriptor=2E=20

Honestly, though, I'm far less interested in what 8250-based hardware does=
 than e=2Eg=2E USB=2E

