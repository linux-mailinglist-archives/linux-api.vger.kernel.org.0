Return-Path: <linux-api+bounces-5281-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F5C60BED
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 23:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C27D35850B
	for <lists+linux-api@lfdr.de>; Sat, 15 Nov 2025 22:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A9D22D795;
	Sat, 15 Nov 2025 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netscape.net header.i=@netscape.net header.b="JhEN6qDr"
X-Original-To: linux-api@vger.kernel.org
Received: from sonic305-22.consmr.mail.ne1.yahoo.com (sonic305-22.consmr.mail.ne1.yahoo.com [66.163.185.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14575809
	for <linux-api@vger.kernel.org>; Sat, 15 Nov 2025 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.185.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763244576; cv=none; b=T1UvjJa4h+pRPUZzUlKTXHiqq3lbdH+9fcvKLxS2N4cfCjoyetFuuGU5hlLliJpX5dDUQ6HMsvfBWLLIc9+vgIbJM+zwjluamvzkRKoAz3Z9OALUwmZPDOE8DriT5wxtLhzHvCqJMHi6uylZyHWEZQX7h2XWckorXJwPnG9wXBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763244576; c=relaxed/simple;
	bh=/PKaCLLpg6j/lnREXn4FV7D4B4dauY3IadFGFN33JhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osFbD8vrCBQOkjSBxZ3IkfG69t9zpL3P99ciqxgilvvaEoW9NOvtlUwgFZhRGWzRDBDOlZWFpJhy+XbholKKlfg65O30j/KyR5w5HgoxJFcvgMaZ65o0bwCud8G0wmlreBQVzsYAbNq8I2zNrq1sjzn6DmYytRDBrYFmrG2vhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netscape.net; spf=pass smtp.mailfrom=netscape.net; dkim=pass (2048-bit key) header.d=netscape.net header.i=@netscape.net header.b=JhEN6qDr; arc=none smtp.client-ip=66.163.185.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netscape.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netscape.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1763244572; bh=eMb82DusIO9XmHOAiFOavVSCBQDuessK6CK14xPcsrk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=JhEN6qDrTZi+Ep5duZ/tJaz5qYzu8l20s7LmP6hnHgT7etN+9Kz0XlI/1qUAEncIOv4gKQhgGJzo8lDRJs7CpAc1aLBqA661LoPX3TaXpyRQChiWpVZDg9IWUjwFitKvMmyXMiEnVRUZFVz26KKkHLl2neD8sPnBAVDCURigiC6JuRABvYK9UIi1oygO96Ok8BOuVMCORcjQh/hHYXrX/4qKI65z5qT6TJvUr4BXmycRzyyget5ZnIXZK9/nygaUGjwa/RpeJTc9eXeWQ/8UjIVWCHpvwOyVBR9JSeax8OPL8/cC+/Dwx5XwYoM95tAo2HbAY8DOfDVms5uVGTNM9g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1763244572; bh=q6D151/ihlNv16HrnGXSYf+o4Xqb6aMAm96OrqXek9N=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=cDliiP9WrWTsn4KVjjYmn3ahz2WVDYIQFaDvvObe9+51mdlRpIYGJ0pRnVxjOeRjnS3on4LMnDC2ehbKmbjRTfw+fD9qbjjJ9X6cQhijdji3mA2J5sHpclzJbTa05h7Tg22WCtxM0OtgR35XJj5M1Ytr/wFLqb15ZosEpS6oRiTCdD+ihR2eyjaMy4GRglWKWYL30hGIBEgeJ/QpdeBUmcv7m/33q9urpdWeilP8JzTRwJmRjSTWssX8KIoJmm93xOf0LuaJ+h/LO5CIUDcty2ThyngQgA/VufWSqB2308h0Qqs8rtNFqs96jcIRZU/Jt206JUZz1PM2gVtAuU/6eg==
X-YMail-OSG: w1SxcZsVM1kuCJUTwXnWrrpRSDHG.0.hqhhLKLomQYP5QtbHQLJTo95VC5REcBG
 kzCLR4nFvwTB8jxKkswpW_mbOuc1PIJGViYNa24nnefQ.SDuKz3RMFy93nKKofJlN2GAdsqNQImJ
 vmLomR21iDFeKSslYZowlGmYn6I6OWoR4w5adKDyHw0oJ2E9WqAGPxGzgM8uKJG3PyUbjI.FzKN1
 orUGbBsdVUdPjqeHUnb7832Xm8S3GTQIeoL26iQgv0TI1gFUJtAg6.WGFeLaGFuTJpvs_Jo.jSIY
 tDxXjrmdGW.kOJAKJ4r5.qjLejqMC.6GKp_8hdzsDRoHA94Dj2ESW5n8fQHxF9sAaBPR_Zhg3N3.
 AwxtQyTYEfqThyzOI_s6c4WOW0SQcoIiQMugwXHVzI5znUQTFWVZJrIYZzCgNYyG1hZIQSffX2Hz
 _VVTl2mhdqY_FYGlh9zjPZodQBGuZsIm2WyD7xgYe5ogIt0PipGuSdU75FWj5mgq8I5xQipEiBne
 y6FDW9uMeDVuHnBUPQVNNt8kgzvxtCcCDCZSVc5jEV6reshWU2kIiZWzmXPxi_qdquwia3C3hSnG
 YZEp2MEHEO1HAQeovghLy62JJ80DPnlLa_9.tkyQTOUcJ9YS_3Dq6QDuY2yqwkoVfZy0U2Fyy4qk
 yZdj7Gjk_2gvMI54.1sYbk3wvnDadI5mYSP9UctvkR6Hv8G2_ZEn.f7FOrCZM86ETzmQJx3P4vXk
 AKc7TbQnOoaYHsaYPAqiuOdfDPxpP4_rp8fW.fAYaIFFkGcElnIaSPALaRLFCdNgEA31h5jXlbpS
 fFmXpcpiFC7DJIXgzL9yC.LM4TbgqYWGmyWa2i7BquD8jBtYRIdl8yDGqLoPLtGJ6CYBzOFYJeht
 s8cKJJJHR3lONlFZuk_dkewMpnSo8I12aHPLkCGsxlxaGCyWv0dLZQM.uxC1uASPTb5LNH03i7Yk
 DKRYQ7m9g97CqZGhmWLc8lLtu8QkRXZ8f.yOn9bSVBhY2co6_5XuJ5WQnGpMq72Vs2E1.fwwGFZO
 KpnLwsDWIRYGmoubTCq2LVR4zpluKQ0NzuI1WWfsr_Zv1EofS7u9U7i_b1qY143KiJVlVKdWSKb.
 GT0v_OBX2e2DYz0ElaP4p9bam4kjaN9Ckse3kMDs_tg_LSyljynkKY5BWHepFfUPly1gKhid6mBj
 dgV5UtzIt7WKASBsez7KS0TV.LrAjbB2Q4JHwQ5w_2.hrLe_4PqrpUN23aXTiEuUtBY0fkW9fwE_
 ubs6VDPknR_O8tWKnEMVs1JtuN_KT7n1HWvtAAgaczSufDuQvkkJgua9HgOWCmAZvsXNvAJqvkaR
 Mztoc_vG8bBSmwRCNhRj9koVgB1eTBihQH6pZwd.pBaGvwnSCYxLC_9IICTuUeOt6cDQD_x__cHJ
 HbxRLL4ATER3dkDEZBLvZqm64bXOoDDxrdQE4Y5.6_ZShK.NLFrXDT2Txv9hULQ8NDF98FTZXlQY
 5h8kSaoenv9JojuOhm6u1kOwxM9oUFyHK37BqIJgRpzxVS8Nf.9S8D.EN.MIsPq73C7WLQNaoXEt
 k2iWTROTScWjZGIVl4wzXp9W7id9g.4630GA002x.V3ZPwPtwAY3ToTg1cRSnukechkxIh8dv9XN
 e9x9Dg7Szf51m48ju2T7HyPQJ_SoncSQ.2_7lf8NtsSimL8TMO.LxKMFdsBxBc2UgcyOgWKRrTX6
 _iexg76Mic6DnfcN17o0FNFxZt6_hZ3SAS1V5pwvQd9UAg2.Dc6td75uMG0nFa9iGEubug6GIjzI
 rjw48gDSMq9.nWJcxFpweZYkooEeGoMc5hwJBCy7terk_nOhrLSVwaPInG7xGg6b8vgJasFNYgIe
 lgWc_.jSLFEWemnmikqNNhom0VvuqaxgYRfBtQDhdKA2ha.vgYs5JHG8Kzjjul8KlKuqIMVtYjs7
 qIkV3QzB7VunVJk48XgSBHtfDe4N7qtIvJ7r0e3Fr0baiUtVIgAUuwYnffnew6kfsFZxO4y8aedk
 LLdR7n5nzCRypLDECHCWb1Ek99HfU4286sQ5q0D2iPX.JeeLV.6Q_ldTlBipT4DlaQjSbQV0K4c0
 Ek0jCZvSsfW4UM0wap4euwR6zOAw3sKR5vMNtWG0cp05JJyaA7OqYOuINAgn2gAioyPBhwBq4AIP
 Yrk_7JfP6Urp8V6ov.450Sgwfs8.I7VL3ClkF._lTytKIyWpVvaTmLm174t3mCkGwXwUHQx2AUeC
 9L5EepRzJp5ALjzD6zAyDCYmYRg.biLDBuQnJitCi
X-Sonic-MF: <nedu@netscape.net>
X-Sonic-ID: 44e5113b-1556-4686-aafe-43bf8148b5b3
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Sat, 15 Nov 2025 22:09:32 +0000
Received: by hermes--production-gq1-76c986f798-4rrvj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8b42282e344c528a0be615aec6237442;
          Sat, 15 Nov 2025 21:29:02 +0000 (UTC)
Message-ID: <6c26eea2-6f90-f48a-9488-e7480f086c70@netscape.net>
Date: Sat, 15 Nov 2025 13:29:00 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
Content-Language: en-US
To: "H. Peter Anvin" <hpa@zytor.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, Theodore Ts'o <tytso@mit.edu>,
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
From: Ned Ulbricht <nedu@netscape.net>
In-Reply-To: <B72D6F71-7C0B-4C5A-8866-25D7946E0932@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24652 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol

On 11/14/25 10:53, H. Peter Anvin wrote:
> On November 14, 2025 10:49:09 AM PST, "Maciej W. Rozycki" <macro@orcam.me.uk> wrote:
>> On Thu, 13 Nov 2025, H. Peter Anvin wrote:
>>
>>>> I think this is going to be the most difficult.  I don't remember why I
>>>> rejected the old submission, but maybe it would have modified the
>>>> existing behaviour?  A new open flag "O_DO_NOT_TOUCH_ANYTHING" might be
>>>> the simplest?
>>>>
>>>
>>> Okay, to I'm going to toss out a couple suggestions for naming:
>>>
>>> 	O_(PRE|FOR|N|NO)?(INIT|CONFIG|START)(DEV|HW|IO)?
>>> 	O_(NO?RESET|PREPARE)(DEV|HW|IO)?
>>> 	O_NO?TOUCH
>>> 	O_NYET ("not yet")
>>> 	
>>> I think my personal preference at the moment is either O_NYET or O_PRECONFIG
>>> or O_NYET; although it is perhaps a bit more "use case centric" than "what
>>> actual effect it has" I think it might be clearer.  A -DEV, -HW or -IO suffix
>>> would seem to needlessly preclude it being used for future similar use cases
>>> for files that are not device nodes.
>>
>> Hmm, I'm inconvinced about any of these.
>>
>> How about O_FDONLY, to reflect that you are after a file descriptor only [snip]

Hi all,

Resurrecting a (private email) discussion from a few years back now, my
personal preferences are:
(1) O_KEEP
(2) O_TTY_KEEP
(3) O_TTY_NOINIT.

(Of course, naming an open() flag has got to be a paradigmatic
invitation for bike-shedding...)

It's worth pointing out, though, that even though O_TTY_INIT doesn't
generally appear in linux headers, that particular flag is documented in
POSIX to have at least incompatible --perhaps even strictly opposite--
behavior compared with this new proposed flag.

See The Open Group Base Specifications Issue 8 (IEEE Std 1003.1-2024):

| 11.1.1 Opening a Terminal Device File
|
| 3. ... The terminal parameters can be set to values that ensure the
| terminal behaves in a conforming manner by means of the O_TTY_INIT
| open flag....

https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap11.html

| open, openat — open file
|
| O_TTY_INIT

https://pubs.opengroup.org/onlinepubs/9799919799/

That's what motivates my first-glance preference to name this new flag,
which will have approximately opposite behavior, as O_TTY_NOINIT.

But as a generic abstraction, I more prefer O_KEEP.

Ned

