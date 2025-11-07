Return-Path: <linux-api+bounces-5155-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9180BC410F5
	for <lists+linux-api@lfdr.de>; Fri, 07 Nov 2025 18:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F4714E6791
	for <lists+linux-api@lfdr.de>; Fri,  7 Nov 2025 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC53358A6;
	Fri,  7 Nov 2025 17:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="PUfHRXJY"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3EF334368
	for <linux-api@vger.kernel.org>; Fri,  7 Nov 2025 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762537077; cv=none; b=c0yQNK765eOPsmAwBjb5tcV3ms6XCqNyp5oHv+ULFka2gQuZ2KTHGWTs2+0v56W6JBzsr9vt1Hdt2rZUdNCnWDjba/BH0esZiCLzteTD1Lquh6vjpC6LdnDrrcDZi36OuPQLGqe0df6nT/SUhm5dcmJ0vY7wmfN9E3gcbOkxIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762537077; c=relaxed/simple;
	bh=H2aWY8pJhwwSmeCbnVjsCQCQhKB/jNwBxQA8GYtab/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8WecvUICFVU/Exy5msXuCeWjt8lKWHKLIzNziYcKhLA+ufFMS/QMiihKE8xCuqdHicn1hZDnMhT28eAKhYqb/+USbf1pw3g65a/JZl1Lu75JtaT+e6GY8+Uf1Kae3NG2xnHmTUa1hV7LpczEIj1FRR4VkIMNp+UKn1p/DOk0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=PUfHRXJY; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-124-240.bstnma.fios.verizon.net [173.48.124.240])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5A7HbhRs009049
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Nov 2025 12:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762537065; bh=PnIy+8sK0+OTDVEtWJptJZPMJBsaqK4vxl8hMBGR68k=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=PUfHRXJYSyFv0d+crtu998+4eUezvQeYmAqf//OWnKmEcLFgPFzMXs9yrmLypwDot
	 uOhMOj76oEFavbi7Qvth68uVOa3BIENBu2Ssyx7jNqAhzx4+9NlDW/zW+BYGqo0PoM
	 AamcYOvZGWnfafPEtbyE71kXZi7RgvwtTMBHt/69+FBGS/grA9Ueid3UaOw04cofaB
	 AyyNwxPhdyvLq8W+0S1U7MQkyJO33iZpqXGvwpeWiJ3x9E2T4R4gM7J0VJzGDLqRKM
	 2axJiNLYY19J3mVYYFRd9Qn/zk6azIfLGAZ/YKi4Wu9iJ8d/cVDDuiqZaKNv/WAyFt
	 /BGwZ0evCX28Q==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0F26F2E00D9; Fri, 07 Nov 2025 12:37:43 -0500 (EST)
Date: Fri, 7 Nov 2025 12:37:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-serial@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <20251107173743.GA3131573@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>

On Thu, Nov 06, 2025 at 11:53:23PM -0800, H. Peter Anvin wrote:
> 
> I recently ran into a pretty serious issue due to the Unix/Linux
> (mis)behavior of forcing DTR and RTS asserted when a serial port is
> set, losing the pre-existing status in the process.

There's a hidden assumption in your problem statement which is that
DTR / RTS has a "state" which can be saved when the serial port is not
active, where active is one or more file descriptors holding the
serial port open.  There may be certain hardware or drivers where this
is just not possible, because nothing is defined if the serial port is
not active.  It might make sense if you are using a 8250 UART, but not
all the world is the National Semiconductor (or clones) UART.

Certainly the "state" will not be preserved across boots, since how we
autodetect the UART is going to mess with UART settings.  So
*presumably* what you are talking about is you want to be able to open
the serial port, mess with DTR / RTS, and then be able to close the
serial port, and then later on, re-open the serial port, have the DTR
/ RTS remain the same.  And it's Too Hard(tm) to have userspace
keeping a file descriptor open during the whole time?  (Which is
traditionally how Unix/Linux has required that applications do
things.)

Is that a fair summary of the requirements?

> It seems to me that this may very well be a problem beyond ttys, in
> which case a new open flag to request to a driver that the
> configuration and (observable) state of the underlying hardware
> device -- whatever it may be -- should not be disturbed by calling
> open(). This is of course already the case for many devices, not to
> mention block and non-devices, in which case this flag is a don't
> care.

I think it's going to be a lot simpler to keep this specific to serial
ports and DTR / RTS, because the concept that the hardware should not
be changed when the file descriptor is opened may simply not be
possible.  For example, it might be that until you open it, the there
might not even be power applied to the device.  The concept that all
hardware should burn battery power once the machine is booted may not
make sense, and the assumption that hardware has the extra
millicent(s) worth of silicon to maintain state when power is dropped
may again, not be something that we can assume as being possible for
all devices.

If that's the case, if you want to have something where DTR and RTS
stay the same, and for some reason we can't assume that userspace
can't just keep a process holding the tty device open, my suggestion is to use 

Given that DTR and RTS are secial port concepts, my suggesiton is to
set a serial port flag, using setserial(8).  It may be the case that
for certain types of serial device, the attempt to set the flag may be
rejected, but that's something which the ioctl used by setserial
already can do and which userspace applications such as setserial
understand may be the case.

Cheers,

						- Ted

