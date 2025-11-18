Return-Path: <linux-api+bounces-5370-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB268C6B198
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 19:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8B16828F96
	for <lists+linux-api@lfdr.de>; Tue, 18 Nov 2025 18:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465BC3612CB;
	Tue, 18 Nov 2025 18:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="tH/1GbOn"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A134B1A8;
	Tue, 18 Nov 2025 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489175; cv=none; b=USl6My8QMgXdseBF6MsjKa7ZRYIus8ADniwaTFYNrXPsgI/ZpJBle0kkdLsnGytacaCzYtEm8c8R/9Q7A5q3P4VOuMMGa+3G5QX4ihEuEcj/1BUk64GBzbKvxgoOG74PcldtnKEkDm/Tus1CSS8z8e4yAHBlyGyHA3daNOPkj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489175; c=relaxed/simple;
	bh=GmoW9vGXWaGx6NYxS82Dg18uEeYHjLvLUoCxO4JOIBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9e4ze3QsHfON2puzrPyAo4U+CnpTiU1uCvLOFMW85i6NT7F4Lq9QLSo0EpgYLuUihGwR8po24GHh8u5RGptNjtnrLAfECMP9gjwz8EXczhD4d1vSH+BzWBCwmDG/h2clrEEJ0r1WIhi8Rpng9q+9enzkz8KBs+aZqyVvnOAcJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=tH/1GbOn reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9484:7ccc:663a:75c9:3b5f] ([IPv6:2601:646:8081:9484:7ccc:663a:75c9:3b5f])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AII5q6u957991
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Nov 2025 10:05:55 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AII5q6u957991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1763489161;
	bh=ZDbIEvFyitmcmgYxH/czrNe/thn0yf0mvhEEq3vHaA0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tH/1GbOnhISej+xA1C+w4Qt7bNtKWDKAecsCkdhBZkoJgs+Y8KUBQ+kiK2XOMJsp0
	 S5PBPhnAfTyaabPmsjGgdTj5/fAjQcYT9mCDGCEB8XLL84kGLAbRC3WY7CPY9DkzLJ
	 C/eQrrOKgHk72GZuXfIRpigdNlIv+RuCKPiBwc8DB18yeJSJt0Z20+wopcZuNtGnzw
	 1rtxKawAgnQNhTtQKQ7vEzWowcdCglWBVS/+RAMa8YjujyZcOTlwAkC6oRxhdUXiTC
	 MTPMMv8Evlhncr/HIUg9Y8akz0NgOK2QhTObSUiglh5OwDt9caWWh51liMSQtihPL+
	 Dp2RTuCZ3TaPQ==
Message-ID: <f643f1f6-7e69-4be6-ac8a-7b1a3a9c402d@zytor.com>
Date: Tue, 18 Nov 2025 10:05:47 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
To: Ned Ulbricht <nedu@netscape.net>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Maarten Brock <Maarten.Brock@sttls.nl>,
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
 <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
 <alpine.DEB.2.21.2511141836130.47194@angie.orcam.me.uk>
 <B72D6F71-7C0B-4C5A-8866-25D7946E0932@zytor.com>
 <6c26eea2-6f90-f48a-9488-e7480f086c70@netscape.net>
 <2846db90-fb05-41d2-b8de-c678af75a04b@zytor.com>
 <06279d25-73d6-01f5-dcf8-8667415048d2@netscape.net>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <06279d25-73d6-01f5-dcf8-8667415048d2@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-11-18 08:33, Ned Ulbricht wrote:
>>
>> O_NOCLOBBER looks like an odd in-between between O_EXCL and
>> (O_EXCL|O_NOFOLLOW); stated to be specifically to implement the shell
>> "noclobber" semantic.
> 
> "(O_EXCL|O_NOFOLLOW)" provokes a thought...
> 
> As essential context, fs/open.c build_open_flags() has:
> 
> if (flags & O_CREAT) {
>     op->intent |= LOOKUP_CREATE;
>     if (flags & O_EXCL) {
>         op->intent |= LOOKUP_EXCL;
>         flags |= O_NOFOLLOW;
>     }
> }
> 
> if (!(flags & O_NOFOLLOW))
>     lookup_flags |= LOOKUP_FOLLOW;
> 

Interesting. As far as O_NOCLOBBER is concerned, that is an "O_EXCL unless the
output is a special file (device node, FIFO, etc)"; presumably to allow the
shell to not flip out when doing, say "foo > /dev/ttyS0" when in noclobber mode.

I had missed the bit in the spec that says that O_CREAT|O_EXCL is required to
imply O_NOFOLLOW (as Linux indeed does as seen above.)

O_NOCLOBBER emulation in user space would seem to be possible with a loop;
first try to open O_CREAT|O_EXCL and if that fails with EEXIST then open
without either; if that succeeds test with fstat() to see if it is a regular
file, and if it is, close it and error. However, it is hardly ideal, and I
might have overlooked some mechanism by which this may fail.

	-hpa


