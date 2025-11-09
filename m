Return-Path: <linux-api+bounces-5182-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C085C4372B
	for <lists+linux-api@lfdr.de>; Sun, 09 Nov 2025 03:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B093AF0A2
	for <lists+linux-api@lfdr.de>; Sun,  9 Nov 2025 02:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673CE1A2C04;
	Sun,  9 Nov 2025 02:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qrbLdV0f"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD18F513;
	Sun,  9 Nov 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762655133; cv=none; b=h4gnwAJOvohFDFL64FGt1apXy19z6x0l24c1IgCmZJmrlLuQmzlChI048AMW39YWngvhy2VnoqUN/4MfNhKyF/gyMrnnleqgQqyJhZxnat8LogRYrVZAXOCB0a49jPpLt0IACBcrOvnzd3SIyib8/whZmmbiVDuZIh7PHLMVuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762655133; c=relaxed/simple;
	bh=Rgo5nak4X6I02glekQA0GQfyQg99yzHmwoA3HpCUfZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CZk6fStXcJckU2abdIXzRab4eQFMWh0ryymjt/9slWo4U8EEefCrtxpjvUC20EjxHB7Tgx7kju8AYWaxgx+yd+Zdl0OeOGH6GLtm6rIdJJvVzuoz3bd+Pp+DMxx5ghYW21novdX/nT1DRBVOppP8RWwzdnsqcOO5pHvQzZ7J/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=qrbLdV0f reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:eba1:36e2:da77:817] ([IPv6:2601:646:8081:9484:eba1:36e2:da77:817])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5A92PQm02588294
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 8 Nov 2025 18:25:26 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5A92PQm02588294
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762655126;
	bh=OKmldBxuLNu+sCfjVlaEM1Dh5sKcH/ESV3pdB89A6gY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qrbLdV0fDE7La/B43Xa2XIygqBhTNC4LNMdPpTar7Yo1Xm89tzNOpmMGGqmEN+2/6
	 JcLU/rjIPvCPTzeK22NWazyrbu7cKydU2yV159auDzEb+hyRVREVWoNjcw64o7sOUs
	 d/90QLUNtrS25fOG1jFJ2v9hFJKKXFPnOyqJP4LNXsipINzX6jrpUwWZHoo6D1vskv
	 OF2KwIYxsnAn4e1xM1ycI09IyuK9uNczX8yv065sb3pCPT/ilIVvtkIKylqZFvmBQN
	 IA334CGtSq4IjRHxwvpzrzWtlB1vHWS3CAKvplI6AUA6F/yr7MN3Crxuvbh9L/Uf9L
	 lsQTvyJ8eJ+cA==
Message-ID: <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
Date: Sat, 8 Nov 2025 18:25:20 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-serial@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20251107173743.GA3131573@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-07 09:37, Theodore Ts'o wrote:
> On Thu, Nov 06, 2025 at 11:53:23PM -0800, H. Peter Anvin wrote:
>>
>> I recently ran into a pretty serious issue due to the Unix/Linux
>> (mis)behavior of forcing DTR and RTS asserted when a serial port is
>> set, losing the pre-existing status in the process.
> 
> There's a hidden assumption in your problem statement which is that
> DTR / RTS has a "state" which can be saved when the serial port is not
> active, where active is one or more file descriptors holding the
> serial port open.  There may be certain hardware or drivers where this
> is just not possible, because nothing is defined if the serial port is
> not active.  It might make sense if you are using a 8250 UART, but not
> all the world is the National Semiconductor (or clones) UART.
> 
> Certainly the "state" will not be preserved across boots, since how we
> autodetect the UART is going to mess with UART settings.  So
> *presumably* what you are talking about is you want to be able to open
> the serial port, mess with DTR / RTS, and then be able to close the
> serial port, and then later on, re-open the serial port, have the DTR
> / RTS remain the same.  And it's Too Hard(tm) to have userspace
> keeping a file descriptor open during the whole time?  (Which is
> traditionally how Unix/Linux has required that applications do
> things.)
> 
> Is that a fair summary of the requirements?
> 

Not really.

First of all, obviously virtual serial connections that don't fully emulate
RS232/422/485 obviously may have other requirements, however, the ones that
*do* currently have a problem, see for example:

https://lore.kernel.org/linux-serial/20220531043356.8CAB637401A9@freecalypso.org/

RS232 is rarely used these days with its original purpose, modems (except as a
virtual port for things like GSM), but the ubiquitousness of the interface
means it is used for a ton of other things.

The standard ESP32 configuration for its serial port is that asserting RTS#
even for a moment will cause a device reset, and asserting DTR# during reset
forces the device into boot mode. So even if you execute TIOCMSET immediately
after opening the device, you will have glitched the output, and only the
capacitance of the output will save you, in the best case.

The use of RTS# and DTR# as a reset and/or debug mode entry for embedded
devices is, in fact, extremely common; another example is the Atmel single pin
reset/debug interface.

Another example is when the device is connected to an RS485 interface: in that
case asserting RTS# will activate the transmitter, disrupting traffic on the
bus. The kernel will manage RTS# *once it has been configured*, but until the
kernel has been told that the port is used to drive an RS485 port, it has no
way to know.

Furthermore, *even if* the kernel already knew the state and could have
reported it with TIOCMGET, that state is now lost.

It is not correct that the state cannot be maintained across system reboots
(without power loss.) The hardware may or may not allow the state to be read
back (notably, the USB CDC ACM specification, oddly enough, has a
GET_LINE_CODING command but no GET_CONTROL_LINE_STATE) but again, for *those
that can* it should be possible. For those that cannot, there won't be any way
to get valid data to TIOCMGET, but it is still possible to not send a change
command. Either way, the power up state of write-only devices can generally be
assumed to be RTS# and DTR# deasserted, not asserted.

(USB is also a bit special because it is normal for the USB host to power
cycle the device during bus initialization.)

>> It seems to me that this may very well be a problem beyond ttys, in
>> which case a new open flag to request to a driver that the
>> configuration and (observable) state of the underlying hardware
>> device -- whatever it may be -- should not be disturbed by calling
>> open(). This is of course already the case for many devices, not to
>> mention block and non-devices, in which case this flag is a don't
>> care.
> 
> I think it's going to be a lot simpler to keep this specific to serial
> ports and DTR / RTS, because the concept that the hardware should not
> be changed when the file descriptor is opened may simply not be
> possible.  For example, it might be that until you open it, the there
> might not even be power applied to the device.  The concept that all
> hardware should burn battery power once the machine is booted may not
> make sense, and the assumption that hardware has the extra
> millicent(s) worth of silicon to maintain state when power is dropped
> may again, not be something that we can assume as being possible for
> all devices.

This is actually a great example! One should be able to open a file descriptor
to such a device to configure the driver, without needing to power up the
physical hardware.

However, I intentionally defined this as a best-effort control for two reasons:

1. As you say, the hardware may not be able to do it;
2. It will take time until a significant set of drivers can implement this.

> If that's the case, if you want to have something where DTR and RTS
> stay the same, and for some reason we can't assume that userspace
> can't just keep a process holding the tty device open, my suggestion is to use 
> 
> Given that DTR and RTS are secial port concepts, my suggesiton is to
> set a serial port flag, using setserial(8).  It may be the case that
> for certain types of serial device, the attempt to set the flag may be
> rejected, but that's something which the ioctl used by setserial
> already can do and which userspace applications such as setserial
> understand may be the case.

setserial (TIOCSSERIAL) and termios (TCSETS*) both require file descriptors,
so that is not suitable. The 8250 driver, but *not* other serial drivers,
allows the setserial information to be accessed via sysfs; however, this
functionality is local to the 8250 driver.

(Incidentally: the only way to find out the type of a tty driver in the
current Linux kernel is to parse /proc/tty/drivers. This information is
neither available in sysfs nor via ioctl.

Consider the case of a terminal program wanting to display a list of serial
ports. Right now, some serial drivers -- notably the generic UART driver --
will create device nodes for all available minors, exactly so you would be
able to manually attach a device with TIOCSSERIAL. There is no driver-generic
way to find out if there is a hardware device configured other than opening
the device and calling TCGETS or TIOCMGET (depending on exactly what you are
looking for) and see if you get EIO back.

The problem here really isn't the need for a file descriptor -- file
descriptors are The Unix Way[TM] to refer to almost any kind of entity after
all -- but that the act of obtaining the file descriptor -- open -- causes a
direct action as well as loss of existing state.

Now, we obviously can't disable the classical terminal behavior
unconditionally -- that would break a whole lot of perfectly valid code.

Using a sysfs attribute is reasonable on the surface of it (and is what the
patchset linked to above implements) I believe this is the wrong approach,
because it is modal on the device level, and that makes it racy: one program
comes in, flips the attribute, then another program comes in and tries to open
the same device for whatever reason. This opens up at least three possible
race conditions:

- Process 1 sets the nreset bit;
- Process 2 opens the device, not expecting the nreset bit.

- Process 1 reads the nreset bit, trying to be a good citizen;
- Process 1 sets the nreset bit;
- Process 2 reads the nreset bit, ditto;
- ... other stuff happens ...
- Process 1 restores the nreset bit
- Process 2 restores the nreset bit, incorrectly setting it to 1

- Process 1 sets the nreset bit;
- Process 2 sets the nreset bit;
- Process 1 does its work;
- Process 1 clears the nreset bit;
- Process 2 opens the device.


Oh, yes, let's not forget: you need a file descriptor to lock the device for
exclusive use.

This is why I believe this:

1. Needs to be atomic with open(), as opposed to tied to per-device state;

2. Likely can have applications beyond the serial port space, and it would
   be a good idea to have a uniform interface. We can discuss the proper
   behavior for a device which cannot comply; the best way probably would be
   to refuse the open and return an error, which would also happen on older
   kernels without this functionality.

Does this make more sense?

	-hpa


