Return-Path: <linux-api+bounces-5282-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75667C60C15
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3392E3B8C59
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 22:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F763238C29;
	Sat, 15 Nov 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PwsSYdSw"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECF1DE4E1;
	Sat, 15 Nov 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763245777; cv=none; b=A9ssK8PpNAR3BAPkGIWQdmSkhTO2iVs0k7foEBuIkBf2kzIxume1sOyK/LkaEAOGGVnvQXfBPZNPj0kF8B2q9Zi4CAmWkBO/2NcS5oADfonVeN1T2meneI6g/DKDkkyL5+JuhbISfVcjhnX2m6Z39NR4BXaaJwUttYdynP9HmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763245777; c=relaxed/simple;
	bh=TmBZ71KtSH+xixCjuLARnjJtxSt1AmGwf28/TRF3fLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USjuh8nizfPT5xmqz/3z00XrVUEM+e2BLyGiYmH0WjZ7LB469RR9E+9dxHIKsnQs/1KTsXc7FCerUlOtllcAkP9OmhL/qaV/T2yz3Acf7oFF4yoaryIGPkTN6O0pK2+PH6pcWn9/7D49a9JQQeCdrTmfqQAHzJu3iCcA91hlnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=PwsSYdSw reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AFMT7dN3213645
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 15 Nov 2025 14:29:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AFMT7dN3213645
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1763245758;
	bh=o6FcQy8d4be39w/3gkzCf13G91XwD08Zmq/c7rYZIi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PwsSYdSwMDIyhv/kdJM/Qq49dgUmKIS329fItwIcIYDiiJE7Ud2NKtr7RurBRoQHU
	 VjxtjEysbgA8oyOvdYXJ2y+aIHlKjeN9r8RjP1cE2ipDX+xt6lOuS+Cj7ylxu87KJ1
	 Ceta8he5Q/qYKvH2fZ3tmZYgvCsjfi/sUxSv0uEBQxg9YOEeEUQfGts0RVbj2q1aJN
	 leRPjxCgH7AH75E6LX1gfgXPg1IN0q6vg/VoPGsuA2K9SMqxR60nf/CtA8xvbQIFNk
	 f/t+C9kjJoOyb/Z8bzn9MnYt75Y5O9Kf8hcQV7MmAvN2A9jeWlrZusyxf2Dlmk13ld
	 LBh/awmbkte3w==
Message-ID: <cd31fbbc-89f3-4130-9566-1e06ed6339d9@zytor.com>
Date: Sat, 15 Nov 2025 14:29:06 -0800
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
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <6c26eea2-6f90-f48a-9488-e7480f086c70@netscape.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-11-15 13:29, Ned Ulbricht wrote:
> On 11/14/25 10:53, H. Peter Anvin wrote:
>> On November 14, 2025 10:49:09 AM PST, "Maciej W. Rozycki"
>> <macro@orcam.me.uk> wrote:
>>> On Thu, 13 Nov 2025, H. Peter Anvin wrote:
>>>
>>>>> I think this is going to be the most difficult.  I don't remember why I
>>>>> rejected the old submission, but maybe it would have modified the
>>>>> existing behaviour?  A new open flag "O_DO_NOT_TOUCH_ANYTHING" might be
>>>>> the simplest?
>>>>>
>>>>
>>>> Okay, to I'm going to toss out a couple suggestions for naming:
>>>>
>>>>     O_(PRE|FOR|N|NO)?(INIT|CONFIG|START)(DEV|HW|IO)?
>>>>     O_(NO?RESET|PREPARE)(DEV|HW|IO)?
>>>>     O_NO?TOUCH
>>>>     O_NYET ("not yet")
>>>>     
>>>> I think my personal preference at the moment is either O_NYET or O_PRECONFIG
>>>> or O_NYET; although it is perhaps a bit more "use case centric" than "what
>>>> actual effect it has" I think it might be clearer.  A -DEV, -HW or -IO suffix
>>>> would seem to needlessly preclude it being used for future similar use cases
>>>> for files that are not device nodes.
>>>
>>> Hmm, I'm inconvinced about any of these.
>>>
>>> How about O_FDONLY, to reflect that you are after a file descriptor only
>>> [snip]
> 
> Hi all,
> 
> Resurrecting a (private email) discussion from a few years back now, my
> personal preferences are:
> (1) O_KEEP
> (2) O_TTY_KEEP
> (3) O_TTY_NOINIT.
> 
> (Of course, naming an open() flag has got to be a paradigmatic
> invitation for bike-shedding...)
> 
> It's worth pointing out, though, that even though O_TTY_INIT doesn't
> generally appear in linux headers, that particular flag is documented in
> POSIX to have at least incompatible --perhaps even strictly opposite--
> behavior compared with this new proposed flag.
> 

I dislike O_TTY_* because restricts it to the TTY use case.

	-hpa


