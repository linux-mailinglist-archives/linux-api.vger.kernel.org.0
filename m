Return-Path: <linux-api+bounces-5229-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86238C4FDAF
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 22:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C850518845AD
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14D326937;
	Tue, 11 Nov 2025 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="mDB9MXB2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046A2868B5;
	Tue, 11 Nov 2025 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896715; cv=none; b=rJUOrwtxkXTI51WjQB9aprG2AtaqZRhQOTVARxEp/tXQYtRANCeGV/+CiEElaDoOHFLhpCv5nIoL+WLj1m5G4Xnd9XVltVTH5m1VE73n1DppL7s83p3NlzjmtkIS2jF58qHsXHI7Z6HOk5C0hz9T8yVWQSPujw3IVmTkDPIUJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896715; c=relaxed/simple;
	bh=6Odj3tYkRiZs6yTQz6IlceMUTLk6AQXtihXfMKVwsFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHMb7T9mIxDQ4hvW4JRHNYeTovNYfsPdBccV/cktxVYioQ/A+ciClR2ni8FlQe5iXp3JPbFRXaffng+szStCp0Yr5HUXe5ZoOqMhFv/wFYsSjK8tOwwpx1cSMsdH4SC9TUNx6YQzTBKpbkiYkwBCWMJE6YAK1pVNMrtPjKa3Wzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=mDB9MXB2 reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ABLSeYS360987
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 11 Nov 2025 13:28:41 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ABLSeYS360987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762896521;
	bh=bzL1y42NUb+51GA1nahiKxPpmYzfoAoFGVxMM1ISNHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mDB9MXB23HIeu2vMp0aP0xjdZH1lztVtNQJ4L0qP3vrvVuQFwBLMzudT8ddRlokNk
	 g3dHPd7GP6uW+pxkSrKHt8S3FfUeFwB4FCXqcnpORWed3Stkbmtw+8Zmu+xgcGI1MM
	 Xge6IcCgniccOK60FAzVdwQUcGnT6/BCqL2FNvbeyjq4TBKJuapFGLZLck+R2gfdBh
	 vsyPS/+RSXAVQsHL14/nDLGQ+xkBUnApWuqFWdzwEHiv6BWJsN4XPiTD+Gs6WHQkyo
	 JNqWoawmdl2ozCEUQtNE3aEYN5lqITkryWFe3s4bYX/iABtBtzgsCBbd8bUtvC/3GW
	 yIvurM9YnVrWw==
Message-ID: <85c9b487-eb18-46a9-babe-6223ae3e05f5@zytor.com>
Date: Tue, 11 Nov 2025 13:28:40 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
 <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
 <20251110033556.GC2988753@mit.edu>
 <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
 <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
 <20251111043803.GK2988753@mit.edu>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20251111043803.GK2988753@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-10 20:38, Theodore Ts'o wrote:
> On Mon, Nov 10, 2025 at 07:57:22PM -0800, H. Peter Anvin wrote:
>> I really think you are looking at this from a very odd point of
>> view, and you seem to be very inconsistent. Boot time setup? Isn't
>> that what setserial is for? We have the ability to feed this
>> configuration already, but you need a file descriptor.
> 
> I'm not really fond of adding some new open flag that to me seems
> **very** serial / RS-485 specific, and so I'm trying to find some
> way to avoid it.
> 

I don't think it is.  "Opening this device for configuration."

> I also think that that the GPIO style timing requirements of RTS
> **really** should be done as a line discpline, and not in userspace.
> 

No disagreement there -- and so it is. What I want to do is a way to *attach*
that line discipline without poking with the serial port itself.  That's what
I keep trying to get at.

>> Honestly, though, I'm far less interested in what 8250-based hardware does than e.g. USB.
> 
> I'm quite confident that USB won't have "state" that will be preserved
> across a reboot, because the device won't even get powered up until
> the USB device is attached.  And part of the problem was that the
> requirements weren't particularly clear, and given the insistence that
> the "state" be preserved even across reboot, despite the serial port
> autoconfiguration, I had assumed you were posting uing the COM 1/2/3/4
> ports where autoconfiguration isn't stricty speaking necessary.
> 
> In some ways, USB ports might be easier, since it should be possible
> to specify udev rules which get passed to the driver when the USB
> serial device is inserted, and so *that* can easily be done without
> needing a file descriptor.
> 
> And for this sort of thing, it seems perfectly fair to hard code some
> specific behavior using either a boot command line or a udev rule,
> since you seem to be positing that the serial port will be dedicated
> to some kind of weird-shit RS-485 bus device, where any time RTS/DTR
> gets raised, the bus will malfunction in weird and wondrous ways....

But again, it is very much a configuration property.  You don't know where
your dynamically assigned serial port will end up -- and you *can't*, because
it is a property of the DCE -- what is plugged *into* the device.

Now you have someone writing a terminal program or something like Arduino and
decide to enumerate serial ports (which, as I stated, you can't actually do
right now without opening the devices).  This is why it makes sense for the
open() caller to declare intent; this is similar to how O_NDELAY replaced
callout devices.

It would be lovely if we could do something like
open("/dev/ttyS0/option-string") and so on, but that is well and truly a far
bigger change to the whole driver API.

	-hpa


