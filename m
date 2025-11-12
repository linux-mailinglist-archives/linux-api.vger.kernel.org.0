Return-Path: <linux-api+bounces-5254-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 496AAC5458B
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 21:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B9154ED9E7
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906929C33D;
	Wed, 12 Nov 2025 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JGIHrqir"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99382A1AA;
	Wed, 12 Nov 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762977325; cv=none; b=aPAT/B56r83Fb6YxF74KT6X2HH1PnNQgQyYXov3FXE8q1QoajVHJQfWph5bKKpfczJGoPMRWyBbWK7uY2/PKBJW6nn5QfULiI44zrKRF3h27jt5RT7Ue3uLVxry3bpm5zrk5qEv+X4B8TNeWnX/NEajcdkhMj7o8YleDH0COqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762977325; c=relaxed/simple;
	bh=S0S6i5la1txqFrXrKK4JmK43nKCDjYUpJt9MsOa+5vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ldFsksARM+wAGXFmlOa/9ONDYT0iwXQEbjhQeOpyd1cwfw4nGuUkU6mr4NOIHFW7aUXRXS/QiK/48QXDa5YCbe2s1F/8bDVOmmJXS6Hf21Vaa57KjTD+S2lQ3zt0OIx7BJCatD8Cd4CcqWa2HcM4/n5+5vaFUAVbouHJOg1fXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=JGIHrqir reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACJtF0H967651
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 11:55:16 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACJtF0H967651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762977316;
	bh=O5eOHZHTSCCuTP+x7r5i/ost9DTOa3/7C1KRs5Wuqds=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JGIHrqiru7v0UOgMp6ume4jEzr8qZSnGT/SsYaq7pCSziEO8C0zuFi6YRbSpMmOl1
	 1Rp1Ltw1TmOj6q4v6Bf1go5AZ9woSC60TMUiSLTMar32w4iaJzB2dkYUYFXzF6SbCn
	 t02vRK/IshtfBWkSz8iGbSvenByuwoJA8xgFUiyjFeIep06dVeNIs0mpi/0+97DjAx
	 J4i1Rj2bOTh23IATS3eOrIhc1+PMEWHxtgPPD5JjHOQ3Y9xaI5RPXBqqAtCXiZYnNO
	 qyrlFB7llCjqzZYuTy6X8VKusecxpaZyeMWO2IEMRAVRK8vYlWBMoPWwazu8qm58Qn
	 8rGoyjv4j83OQ==
Message-ID: <dcf3c388-0927-4859-92c6-e52a281224cf@zytor.com>
Date: Wed, 12 Nov 2025 11:55:15 -0800
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
> Trimming out stuff to get to the real questions:
> 
> On Wed, Nov 12, 2025 at 11:12:22AM -0800, H. Peter Anvin wrote:
>> Things that I have identified, at least in my opinion:
>>
>> 1. Opening a device for configuration as opposed to data streaming; in the tty case that doesn't just improve the DTR# and RTS# issue but allows setserial, configuring line disciplines and so on.
>>
>> As I have said, this is application-specific intent, which is why I strongly believe that it needs to be part of the open system call. I furthermore believe that it would have use cases beyond ttys and serial ports, which is why I'm proposing a new open flag as opposed to a sysfs attribute, which actually was my initial approach (yes, I have already prototyped some of this, and as referenced before there is an existing patchset that was never merged.)
> 
> I think this is going to be the most difficult.  I don't remember why I
> rejected the old submission, but maybe it would have modified the
> existing behaviour?  A new open flag "O_DO_NOT_TOUCH_ANYTHING" might be
> the simplest?

That was exactly my proposal - see the header of this thread :)

>> 3. The only way to determine the type of a tty driver is reading and parsing /proc/tty/drivers; that information is exported neither through ioctl nor sysfs. Exporting *that* through sysfs is probably the easiest of all the improvements.
> 
> The "type" is interesting.  We keep adding new "types" of serial ports
> to the uapi list, and they don't really show up very well to userspace,
> as you say.  Adding this export to sysfs is fine with me, but we should
> make it a string somehow, and not just a random number like the current
> types are listed as, to give people a chance to keep track of this.
> 
> So yes, this too should be done.

I meant to add this to the previous email -- the obvious choice (and what is
in my prototype) is to use the same string as is currently exposed in
/proc/tty/drivers.

	-hpa


