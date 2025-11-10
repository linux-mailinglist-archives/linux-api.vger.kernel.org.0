Return-Path: <linux-api+bounces-5187-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5437C44FB3
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 06:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BAFA4E4F5A
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 05:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A33B2E8B64;
	Mon, 10 Nov 2025 05:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hmr3x5Vn"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894501A2C25;
	Mon, 10 Nov 2025 05:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752016; cv=none; b=eT7wT8Mh9eNTZQaOpoCcExpOchYM8Q1KBogYIWntRJbHOxm0haaYow0jCeqkRZDfkqPp8UOeAxCOhLvXkxXVgrZGLrvZDgIVzzeGKTb5Mi+uD8ZX8RiVNb7FPUXXGvVJbzt/Kdv791+3lKsb1U8EjpuM0sZK53DoRc8KN6OfiXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752016; c=relaxed/simple;
	bh=WICAjAkBcOzYNQw2QatcrHUjeNQPqwknDKC2jJuGTWY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cGc48tZQyNeYzeBIy83efBCKdnv9LuIaI07GIajDOnsjMVTg9bbOSGvYuFJJRRtjtyh0zGP7ITLYhgcwvA3btd1P5U4gh2pwXQldponoAwfL84719/dUZGd9mI7HKNMDitsLexdW6TEi0JgZM4D/yjSmJ0Et4RymoTGgVQrz4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Hmr3x5Vn reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AA5KAkq3346810
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 9 Nov 2025 21:20:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AA5KAkq3346810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762752011;
	bh=ByLx4ga8mLNebyKIOpvPJefCgzhRahPFj+lLZbpqSnk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Hmr3x5VnB25CC5UOUzv+z4S+ujjkXbglZg8UkHG+meqM4WrueRcjiaLIA5TUshnPJ
	 IvJ6vlC1XFbcc/qy4Jo/1l4DbTwv7tDP/jTAx4ce01xpXAoZFgm7PUppVa7WzH7MWh
	 rdu/sfqZfEeY8ootCdBtAQeDru5aGioX3LRP3CVL+0u8VvHx5ToI07XcQKZ/nRrOdZ
	 UjPlmXesbHXnXx/NbhyuBpMb60NrUfwKT9oueNisLKqqjGuwQFwFlARm3QYen6NU+e
	 74jh+p+WynNdPqeRMGYE7/0FI6gbDvjn3MBwkpRnEqZQwbFexVMRMOqkYn0/Jva1Yo
	 ufSWGkRcLuPbw==
Date: Sun, 09 Nov 2025 21:20:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-serial@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
User-Agent: K-9 Mail for Android
In-Reply-To: <20251107173743.GA3131573@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com> <20251107173743.GA3131573@mit.edu>
Message-ID: <17FF5500-54B4-4456-A870-E43E004589F1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 7, 2025 9:37:43 AM PST, Theodore Ts'o <tytso@mit=2Eedu> wrote:
>On Thu, Nov 06, 2025 at 11:53:23PM -0800, H=2E Peter Anvin wrote:
>>=20
>> I recently ran into a pretty serious issue due to the Unix/Linux
>> (mis)behavior of forcing DTR and RTS asserted when a serial port is
>> set, losing the pre-existing status in the process=2E
>
>There's a hidden assumption in your problem statement which is that
>DTR / RTS has a "state" which can be saved when the serial port is not
>active, where active is one or more file descriptors holding the
>serial port open=2E  There may be certain hardware or drivers where this
>is just not possible, because nothing is defined if the serial port is
>not active=2E  It might make sense if you are using a 8250 UART, but not
>all the world is the National Semiconductor (or clones) UART=2E
>
>Certainly the "state" will not be preserved across boots, since how we
>autodetect the UART is going to mess with UART settings=2E  So
>*presumably* what you are talking about is you want to be able to open
>the serial port, mess with DTR / RTS, and then be able to close the
>serial port, and then later on, re-open the serial port, have the DTR
>/ RTS remain the same=2E  And it's Too Hard(tm) to have userspace
>keeping a file descriptor open during the whole time?  (Which is
>traditionally how Unix/Linux has required that applications do
>things=2E)
>
>Is that a fair summary of the requirements?
>
>> It seems to me that this may very well be a problem beyond ttys, in
>> which case a new open flag to request to a driver that the
>> configuration and (observable) state of the underlying hardware
>> device -- whatever it may be -- should not be disturbed by calling
>> open()=2E This is of course already the case for many devices, not to
>> mention block and non-devices, in which case this flag is a don't
>> care=2E
>
>I think it's going to be a lot simpler to keep this specific to serial
>ports and DTR / RTS, because the concept that the hardware should not
>be changed when the file descriptor is opened may simply not be
>possible=2E  For example, it might be that until you open it, the there
>might not even be power applied to the device=2E  The concept that all
>hardware should burn battery power once the machine is booted may not
>make sense, and the assumption that hardware has the extra
>millicent(s) worth of silicon to maintain state when power is dropped
>may again, not be something that we can assume as being possible for
>all devices=2E
>
>If that's the case, if you want to have something where DTR and RTS
>stay the same, and for some reason we can't assume that userspace
>can't just keep a process holding the tty device open, my suggestion is t=
o use=20
>
>Given that DTR and RTS are secial port concepts, my suggesiton is to
>set a serial port flag, using setserial(8)=2E  It may be the case that
>for certain types of serial device, the attempt to set the flag may be
>rejected, but that's something which the ioctl used by setserial
>already can do and which userspace applications such as setserial
>understand may be the case=2E
>
>Cheers,
>
>						- Ted

So let's separate out a few things here:

1=2E You are taking about using setserial(8), which is really ioctl(TIOCSS=
ERIAL), which requires a file descriptor=2E This is exactly why I believe t=
here should be a mechanism for acquiring a file descriptor which *by that a=
ction itself* should not change whatever state is already available to the =
kernel=2E

2=2E What, if anything, can be done on a device by device basis to improve=
 the situation beyond what currently exists=2E=20



