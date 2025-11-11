Return-Path: <linux-api+bounces-5199-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82450C4B5CD
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 04:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45F7C4E1F6B
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 03:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE9271A94;
	Tue, 11 Nov 2025 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="iKTx0+W8"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFA266B6F
	for <linux-api@vger.kernel.org>; Tue, 11 Nov 2025 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833119; cv=none; b=ffBlMUhjh4s5mBpUoIzGFn0JVD+8+JyXP7siRLhh58CsS+EFj834rOgea+dKbi4VeZtKWLkiq5b+n/xkHI6tkpubj9dov34/Idxa9oPr84fTDleiHaVZgoahvc9/zoAWXO9wvGrjg8ZGSnZLyYXr0HgPjZM7iON1/HHgC5L3G5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833119; c=relaxed/simple;
	bh=EWnsbrhjx9CE8E9O3tAfZpamK18dXAIf00y7wu53fA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg6F6/W6dAng8a5i/b4dLJNx4yMnktnZ/itr87BuEIuKpflQPxCFm3yMJ89fOpqTVJv67Yf88Ytt4xMJeMFlXh1I2rvAyHLl41V3wB0InIZHdnNMU1yl+o4jJPZpwBocmgOs15BmEEekz2U23GIiXFgNLNNXOBJtI3y2oUYyFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=iKTx0+W8; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AB3phHq007802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 22:51:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762833105; bh=T3uUoS64/1g+j1dW9ReEGjN0D7EazGB2spXReUkJcGQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=iKTx0+W8/1TW6Eyvn10+EpRvSGS4jHuwbPmWFfa9DAX6U5luS1kY8kh/2pvzYdHu5
	 O3W7Y0BJVAqTJnii8uWUYDLsPdkCpVa9tGbNsWTJeu4G+bM2u8eL8dr8njtL0DHIE3
	 G4kgfxe86v2dfJvRukAJVTdJZGjA71LLNfmFusDBv/sIqDHRv20xXNYI1V7ojJrQ7Z
	 d7/63gToS3WjZC7psKI4K06Bwb/zvtdBkJ9qAv3YsEpdGBPDn1dYUdcGfIgW/3EXZ6
	 Z3qvjT9Wf6+/+0Skw9fWFBBk1iFkGcQW2mBHGYOgpRgk26ZLPROU0QAQEOAOuiQic8
	 h33FTlHSJVQGg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 941902E00D9; Mon, 10 Nov 2025 22:51:43 -0500 (EST)
Date: Mon, 10 Nov 2025 22:51:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <20251111035143.GJ2988753@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
 <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
 <20251110033556.GC2988753@mit.edu>
 <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>

On Mon, Nov 10, 2025 at 01:05:55PM -0800, H. Peter Anvin wrote:
> 
> The parport driver layer is kind of similar to this, in some ways,
> but in the tty layer that is mostly handled by line disciplines
> instead. (The parport hardware was generally abused on a much lower
> level, as a substitute for GPIOs, so even the notion of a byte
> stream wasn't there.)

I'm not an RS-485 expert, but over the years, I've heard all sorts of
"interesting" timing requirements.  For example RTS can only be
dropped when the UART's shift register has completely drained.  That's
not when the OS has sent the characters to the FIFO (which is why
tcdrain isn't quite what you want); it's not when the UART has sent
the transmit interrupt, but when the UART's shift register is *empty*.
Doing this via the termios interface is decidedly non-optimal[1].

[1] https://www.moxa.com.cn/getmedia/a07808dd-f3d7-473b-9a2f-93b5ce673bb1/moxa-the-secrets-of-rs-485-half-duplex-communication-tech-note-v1.0.pdf

It *can* be done, sure, with some strategic usleep()'s, but not
necessarily optimally, and it is decidedly hacky.  From what I can
tell, it's actually not *that* different from treating RTS as a GPIO
pin, and really, this ought to be done in the kernel if you want
optimal control oer the timing of when RTS gets toggeled.

> *If* I'm reading the code correctly – which is a little complicated due to the sheer number of abstraction layers – hardware initialization is already deferred until first open, which would mean that disabling autoconfiguration (one of the features in TIOCSSERIAL) would again be a valid reason for wanting to be able to communicate with a device driver before requiring that it puts the underlying hardware in the state expected for operation *in the mode configured* (catch-22).

Well, part of the problem is that the PC's serial port predates PCI,
so there's no way we can tell whether or not there is a serial port at
a particular I/O port except by poking certain I/O ports, and seeing
if there is something that looks like a UART which responds.
Hopefully this won't accidentaly cause the NSA's thermite-charge
self-destruct charge from getting set off, and in practice, mainboard
designers who try to put things at the COM1/2/3/4 generally get weeded
out thanks to natural selection, hopefully without harming users along
the way.  :-)

Worse, we also wanted to support serial cards that were at
non-standard ports, or using non-standard interrupts, and so that's
one of the reason hardware initialization is deferred until after we
have a chance to configure the serial device's I/O port and interrupt.

Now, we are in the 21st century, and just as we are trying to declare
32-bit i386 dead (to the disappointment of legacy hardware owners
everywhere who are whining about Debian dropping installer support for
i386), we could try to declare the ISA bus as dead, and no longer
being supported, and we could probably drop a bunch of this
complexity.  We probably would need to support COM 1/2/3/4 ports since
these still tend to be hardwared without a way of detecting it their
existing via USB or PCI bus discovery mechanisms.  And for those, we
would still need to do UART autoconfiguration.  I suppose we could
just assume that all UART's are 16550A's, and that noone would
actually use older UART's type --- except (a) I bet there are some
cheap-skate embedded computer designers who decided to use a 8250
instead of 16550A for $REASONS$, and because of the extreme timing
requirements of some RS-485 use cases, I believe I have seen
recommendations to use setserial to actually force the UART into 8250
mode, to disable the TX FIFO --- all to satisfying the weird-shit RTS
timing requirements.  (This is where I get my beief that RS-485 !=
RS-232, and if you want to do all of this weird-shit timing
requirements because you are trying to implemet a multi-node bus which
is half-duplex, maybe this should be done in the kernel, damn it!)


How about this?  If you really don't want to open the device to
configure it not to assert DTR/RTS, perhaps we could specify on the
boot command line that one of TTYS[0123] has a different default line
discipline, and when tty's are opened when the RS-485 line displine,
the RS-485 rules apply, which would include not messing with DTR/RTS,
and if you want to play games with RTS getting dropped as soon as the
last bit has let the transmit shift register, we can get the kernel do
this in the line discpline, which arguably would be *way* more
reliable than playing GPIO-style timing games in userspace.

	      	      		 	      - Ted

