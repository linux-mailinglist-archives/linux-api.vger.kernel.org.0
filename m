Return-Path: <linux-api+bounces-5267-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11958C5A4FB
	for <lists+linux-api@lfdr.de>; Thu, 13 Nov 2025 23:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D23B74E13DC
	for <lists+linux-api@lfdr.de>; Thu, 13 Nov 2025 22:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13E6325730;
	Thu, 13 Nov 2025 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Uc6OMPRP"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CC931E10B;
	Thu, 13 Nov 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763072741; cv=none; b=bV8dxaBcioCmvPOtPUZ1eX0UumQrcvWjosluryTPVQemQvDhvqs5R/l/QBUQ2o+paDU2VJoLpT/USguejFN2+M6t5zSXudA8rnSEZIvuDkzoyHRf74dgn7O+ZZZQykqPiRWkfn5ScKTxdja1wwl4ZGRMpjnw1BXHIm+tWhN9gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763072741; c=relaxed/simple;
	bh=AOGEdHNVbUMBAq9xdoW+RwF5ebiA9iHBaU1AO4C0fdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDCa1I0e2Ulmna0xx9ky3XrxssVLTmAgjRYLkDvChpalQ5wQtKoLw+FIUGKad6QmTuLJTBaSUkWl7J6NeyI1F/7c7Vuuaw9atb21b74t4/gOr+0KcnPeIWCRPv9bjQP77Q2THQdaiYwAdhV1YE1Y0z7uSGxaEJBluepBjmf/M3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Uc6OMPRP reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ADMOZkH1737854
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 13 Nov 2025 14:24:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ADMOZkH1737854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1763072730;
	bh=Ef7JhnQ0JYtlLyCA3ni98/yw3ogDxsD755XjQ2Ol9X4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uc6OMPRP7fm+SNaoG/EMIYrKq5RqN8DokG7NJ3wsgjcMtcixWAD/Nr6s/cclzHA+a
	 U4+eUsHLIBkLNXEBkzjAgTbe0KfVobxE8apWNCnLJkKSrO4Gs6gELYYSn9TB1SHLRl
	 Re4eE+lk5ru9IVVSIv+OtMDK3m45/72AKOgUKXVMxUjYGrt+NSOu98ZykSX7GABtIe
	 9jCFyxm8QwXIzrgLl6mWEXTbopNmkFVo+ol+KVzEXZJdh5slK71lGGoq69Osf78SwS
	 M4MFRCzWw0eUaKH55UfHPuB9AyNQ7195vwWWqCWOe1L02oLiElRaz9P20jxGgrCSp7
	 LSsPgYtst0qZg==
Message-ID: <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
Date: Thu, 13 Nov 2025 14:24:27 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
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
>>
>> 1. Opening a device for configuration as opposed to data streaming; in the tty case that doesn't just improve the DTR# and RTS# issue but allows setserial, configuring line disciplines and so on.
>>
>> As I have said, this is application-specific intent, which is why I strongly believe that it needs to be part of the open system call. I furthermore believe that it would have use cases beyond ttys and serial ports, which is why I'm proposing a new open flag as opposed to a sysfs attribute, which actually was my initial approach (yes, I have already prototyped some of this, and as referenced before there is an existing patchset that was never merged.)
> 
> I think this is going to be the most difficult.  I don't remember why I
> rejected the old submission, but maybe it would have modified the
> existing behaviour?  A new open flag "O_DO_NOT_TOUCH_ANYTHING" might be
> the simplest?
> 

Okay, to I'm going to toss out a couple suggestions for naming:

	O_(PRE|FOR|N|NO)?(INIT|CONFIG|START)(DEV|HW|IO)?
	O_(NO?RESET|PREPARE)(DEV|HW|IO)?
	O_NO?TOUCH
	O_NYET ("not yet")
	
I think my personal preference at the moment is either O_NYET or O_PRECONFIG
or O_NYET; although it is perhaps a bit more "use case centric" than "what
actual effect it has" I think it might be clearer.  A -DEV, -HW or -IO suffix
would seem to needlessly preclude it being used for future similar use cases
for files that are not device nodes.

O_NYET ("not yet") is kind of attractive because it has some geekish smirk
value, doesn't have "obvious enough" meaning that if you don't know what it
does you'll guess rather than looking it up, but once you know you are not
going to forget it!  There is even precedent: USB 2 already has the NYET
packet type meaning just "not yet".  The more I'm thinking about it the more
am starting to like it...

Many of the other combinations have the problem of seeming to do the opposite
of what the used wants in some use cases; it seems rather odd to open a device
node that you are intending to configure with "O_NOCONFIG".  On the other
hand, "O_CONFIG" might be a valid indication of the intent (like O_RDONLY or
O_RDWR are indicator of intent), but also has the implication that it *will*
cause the device to configure itself.  It also would seem to imply that the
resulting file descriptor can *only* be used for that purpose.

	-hpa


