Return-Path: <linux-api+bounces-5252-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B5C544A4
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 20:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 556F94F6CE5
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 19:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCE8350D45;
	Wed, 12 Nov 2025 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpdvedV0"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07E34E767;
	Wed, 12 Nov 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762976346; cv=none; b=TICpFp3NN5qgxYsF3NXdNtfbQxF8QTLX8UovyhSi932uUVO+zLXDhtl9RQXkqWMmevX4HxLrsGzN+JfHzCvUAMdnLRcdNpbHASah6Unry+p8U5/58Roi5AvHmNbccTkWqu5F6TIfG27y9VOGHYMRLA7kBjtZgq4tp0jJ1hKT/Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762976346; c=relaxed/simple;
	bh=k1pexc4a8vypWQvNhaqIbF7+K8FCYfDuX8jXVUTiEsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjzHiQwU0wDnVFEROTrd2B6Tyg+9j6sbAa4ZRJLIuAIJ4zxUimFWsDOJ4ORgi/2Siy/ohp/4xjITPAKQYeeff4HBAk/ZgNc5imjisGP2Xj5UBo+B05YO7CMJW4WVdr0pa0JSlIH5g/Gj9XoBdcZMP5d28Yat3WkumwkJMoo4d9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpdvedV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206ABC4CEF7;
	Wed, 12 Nov 2025 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762976343;
	bh=k1pexc4a8vypWQvNhaqIbF7+K8FCYfDuX8jXVUTiEsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpdvedV06NWmMxjnjOa/4j9U8gnHnp8i4q8qvXTgsyutWVHZBybBZxwUv5K1S/pff
	 GuWGwwsT8a2EpIMX/hxbDJv4l/jGiRUJCVIqSmraQH1VtSVgVVFkA56btpSJL+Qk30
	 L/H9A03pTn8iDYN0VyQQSrkoDsrDaWbF6qLdtvXM=
Date: Wed, 12 Nov 2025 14:39:00 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Maarten Brock <Maarten.Brock@sttls.nl>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <2025111227-equipment-magnetism-1443@gregkh>
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
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com>

Trimming out stuff to get to the real questions:

On Wed, Nov 12, 2025 at 11:12:22AM -0800, H. Peter Anvin wrote:
> Things that I have identified, at least in my opinion:
> 
> 1. Opening a device for configuration as opposed to data streaming; in the tty case that doesn't just improve the DTR# and RTS# issue but allows setserial, configuring line disciplines and so on.
> 
> As I have said, this is application-specific intent, which is why I strongly believe that it needs to be part of the open system call. I furthermore believe that it would have use cases beyond ttys and serial ports, which is why I'm proposing a new open flag as opposed to a sysfs attribute, which actually was my initial approach (yes, I have already prototyped some of this, and as referenced before there is an existing patchset that was never merged.)

I think this is going to be the most difficult.  I don't remember why I
rejected the old submission, but maybe it would have modified the
existing behaviour?  A new open flag "O_DO_NOT_TOUCH_ANYTHING" might be
the simplest?

> 2. Currently the setserial configurables are available in sysfs, but *only* for UARTs, whereas TIOC[GS]SERIAL is at least available to all serial devices. That code should presumably be hoisted into a higher layer; this shouldn't be too difficult.

I agree, this shouldn't be hard, no reason to not do this.

> 3. The only way to determine the type of a tty driver is reading and parsing /proc/tty/drivers; that information is exported neither through ioctl nor sysfs. Exporting *that* through sysfs is probably the easiest of all the improvements.

The "type" is interesting.  We keep adding new "types" of serial ports
to the uapi list, and they don't really show up very well to userspace,
as you say.  Adding this export to sysfs is fine with me, but we should
make it a string somehow, and not just a random number like the current
types are listed as, to give people a chance to keep track of this.

So yes, this too should be done.

> 4. There isn't a device-independent way to determine if a device is "real" (configured for hardware) or not without opening it and executing one of the termios ioctls like TCGETS (returns -EIO if there isn't anything behind it.) For a UART port it is possible to come up with an educated guess based on the aforementioned sysfs properties (does it have any kind of address associated with it?), but seriously, should stty -a /dev/ttyS0 really glitch RTS# and DTR# even though there is no intent of using the port for communication? 

Determining "realness" is going to be hard I think (is a usb-serial
device real or not?  Some are, some are not, but how do we even know?)
Does a "real" uart mean that the device is real?  How do you define
that?  What about virtual ones?  Modem chips that do have full line
discipline support on USB connections?  There's a lot out there to deal
with here and I think some "fake" ones do pass TCGETS calls just because
they lie.)

And addresses are only the "very old" method, many "real" PCI uarts
don't have them, same for USB ones.

And changing 'stty -a' is going to be hard, unless you want to use the
new flag?

But yes, making this more sane is always good, 2 of your things here
should be pretty simple to knock up if someone wants to.  The others
might be more difficult just due to backwards compatibility issues.

thanks,

greg k-h

