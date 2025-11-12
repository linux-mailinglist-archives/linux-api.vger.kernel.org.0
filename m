Return-Path: <linux-api+bounces-5253-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DF5C5445F
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 20:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA3E134524C
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1582882D3;
	Wed, 12 Nov 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="jv7fIxo3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473E263C8A;
	Wed, 12 Nov 2025 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977198; cv=none; b=ALrvhsbt6WbGPpqHOlc5sFRdZVUkuT5H2De6A/tSmqZGUGoBQ2v2vogoZMcB3hUy/1C+wk0CKzx6O9EEEQDaNXr+cilg4yzITyIPHa5ed7AIpe7nCmt+T0pvdiMbbapYNPZFA2HZKTN/2KFRiSOtqvyW0Iv80WbNYhG/dNSJTb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977198; c=relaxed/simple;
	bh=fPOItTe4MhWlwM1qZlsETPb1P1Ays8zKdKDNdcBIyXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HaCwC7bQEw+FEzmZRmvstxcv4NXL+Yuk/ZnAk1EnXoyAdI5lkT5OnrLTl01N1AD1wDcw5vxxUIdlkO8zPuVRji8P3I5EvQZgzCfgiAxQT920kNtoLIBbrhOVWnafeaY2yXa4rR53qQdUc6vbHFOP6NSpb+ao0q1EU+nrUxWEGnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=jv7fIxo3 reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACJr8Wl965042
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 11:53:08 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACJr8Wl965042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762977189;
	bh=tzmyj1MRJKjkyUstPNOZ9/5/u7pOY7r+PXviKNRwppQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jv7fIxo3DC98TzFggWI1fO5WO4CiFO+3GBx2ZsTMOcc6y7exswgvw5hp/WiIYIdKp
	 n4Nw5/7tgv+e6z+a0+pqQXPaYjmNPQ7SbC/n9hF0Ij2kP24vaLKYd1BYNmXdaWP6gz
	 tT7sQjSzmcJGRs/mKIlXm+BlyJIJtBPS+lrln2MSV/47B+pAPEY8V02kzhpVGl7/j6
	 lKN5/gJq1FxSxRD2mt4Z+zMU/0yUBINzssHXqyYLKBuG99g9y2vs8ymWdi4plcUMTc
	 0wSRKJ7lbOOyfbOlzCPo/oU5fCluE8ydHnOEVOIoBG5cmtHCPE8wHjnVK0gRKjri5G
	 Dc9bk4uwDePQQ==
Message-ID: <12e5757c-dc07-40a2-b9c5-57d77dfaffac@zytor.com>
Date: Wed, 12 Nov 2025 11:53:08 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Maarten Brock <Maarten.Brock@sttls.nl>,
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
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <2025111227-equipment-magnetism-1443@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-11-12 11:39, Greg KH wrote:
> 
>> 3. The only way to determine the type of a tty driver is reading and parsing /proc/tty/drivers; that information is exported neither through ioctl nor sysfs. Exporting *that* through sysfs is probably the easiest of all the improvements.
> 
> The "type" is interesting.  We keep adding new "types" of serial ports
> to the uapi list, and they don't really show up very well to userspace,
> as you say.  Adding this export to sysfs is fine with me, but we should
> make it a string somehow, and not just a random number like the current
> types are listed as, to give people a chance to keep track of this.
> 
> So yes, this too should be done.
> 

Yes, this one is pretty obvious:

>> 4. There isn't a device-independent way to determine if a device is "real" (configured for hardware) or not without opening it and executing one of the termios ioctls like TCGETS (returns -EIO if there isn't anything behind it.) For a UART port it is possible to come up with an educated guess based on the aforementioned sysfs properties (does it have any kind of address associated with it?), but seriously, should stty -a /dev/ttyS0 really glitch RTS# and DTR# even though there is no intent of using the port for communication? 
> 
> Determining "realness" is going to be hard I think (is a usb-serial
> device real or not?  Some are, some are not, but how do we even know?)
> Does a "real" uart mean that the device is real?  How do you define
> that?  What about virtual ones?  Modem chips that do have full line
> discipline support on USB connections?  There's a lot out there to deal
> with here and I think some "fake" ones do pass TCGETS calls just because
> they lie.)
> 

What I mean with "real" is that the device exists at all, unlike e.g.
/dev/ttyS* device nodes which are *only* available for the purpose of binding.

So "bound to a hardware device" is what I mean, not that it is a device with
RS232 drivers on it (which would be impossible to determine, as you very
correctly point out.)

> And addresses are only the "very old" method, many "real" PCI uarts
> don't have them, same for USB ones.
> 
> And changing 'stty -a' is going to be hard, unless you want to use the
> new flag?

That's exactly the idea: use the new open flag.

> But yes, making this more sane is always good, 2 of your things here
> should be pretty simple to knock up if someone wants to.  The others
> might be more difficult just due to backwards compatibility issues.


Indeed. Which is the whole reason for this RFC thread.

	-hpa


