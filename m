Return-Path: <linux-api+bounces-5280-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F5C5EF88
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EBFF335C56D
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58602E1C58;
	Fri, 14 Nov 2025 18:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y+YsTSF1"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877D2E173E;
	Fri, 14 Nov 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146443; cv=none; b=fUzslQdYapqlKexOcD9+RLU/XXXSDXhDn6e2czuRiKi/XGnkN0I6DB/qpRSUo4LKuj1VLWra5iwMFVVkTeFtzPpXna/1/tWItMt4tq8stpJSs7G218gWLTBAzCg00d/hoqCgjJ1VSnCsKk58IOmI9HHc+9WnyuLYBSHMDZO5PUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146443; c=relaxed/simple;
	bh=ns/4BPhfC4b+VZQ1BS3vYOk3YdSC0kE/VU7WiQPJfPg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=BuNU0d8cQC9k5oMMf3Pyu1IbG7mUkie10BDxMLoJcFFxJYQJmMzGBlXbXcBaUBngPerIdvoUoSJKTffae2o37x8trtPUmrYj43W8ZNhSwAKVvEbAJOOLsPmcbLijUPveEP90Dl9PlqzJwMwljAWN0ktCIGGLEeVpGupba9ZTBI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Y+YsTSF1 reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AEIroGA2355525
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 14 Nov 2025 10:53:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AEIroGA2355525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1763146431;
	bh=fhg+W1XJ0qqxqyoUmG4aPIH1yZLyX6nBCeFHRPaVa5U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Y+YsTSF1WjrE2SiXat8LZm/seDwanmzxsubQi/7u8vNQMYN51Yja17vpcw/TBagfN
	 BGbctPi/5LnZw4MHgl0otZe2GgPTf93qup3XhsROnTQZKxEj2VkbxRvIm34biyZJUz
	 CGjxpA6QfMbutmFh3LuNcsZT7bexa1eWiypOeuYNZEPb3CMlspcTSXd61UHAD5gKxI
	 Na8NxRx75WOf8oT+3Px5PHY8MJ674mfbj3AW2YhSL8qtQStPJQiWF6ZXmqK8loMXBt
	 BPoWb+j+Z7kqfeqNbvwPOiHXYdkYQ2u2ML8+uCUPDKw1YG795vuhr546UB/2VtrX4a
	 SmA4e74SeGe+g==
Date: Fri, 14 Nov 2025 10:53:49 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
CC: Greg KH <gregkh@linuxfoundation.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_<something>
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.2511141836130.47194@angie.orcam.me.uk>
References: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com> <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com> <20251110201933.GH2988753@mit.edu> <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com> <20251111035143.GJ2988753@mit.edu> <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com> <2025111214-doily-anyway-b24b@gregkh> <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com> <2025111241-domestic-moonstone-f75f@gregkh> <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com> <2025111227-equipment-magnetism-1443@gregkh> <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com> <alpine.DEB.2.21.2511141836130.47194@angie.orcam.me.uk>
Message-ID: <B72D6F71-7C0B-4C5A-8866-25D7946E0932@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 14, 2025 10:49:09 AM PST, "Maciej W=2E Rozycki" <macro@orcam=2E=
me=2Euk> wrote:
>On Thu, 13 Nov 2025, H=2E Peter Anvin wrote:
>
>> > I think this is going to be the most difficult=2E  I don't remember w=
hy I
>> > rejected the old submission, but maybe it would have modified the
>> > existing behaviour?  A new open flag "O_DO_NOT_TOUCH_ANYTHING" might =
be
>> > the simplest?
>> >=20
>>=20
>> Okay, to I'm going to toss out a couple suggestions for naming:
>>=20
>> 	O_(PRE|FOR|N|NO)?(INIT|CONFIG|START)(DEV|HW|IO)?
>> 	O_(NO?RESET|PREPARE)(DEV|HW|IO)?
>> 	O_NO?TOUCH
>> 	O_NYET ("not yet")
>> =09
>> I think my personal preference at the moment is either O_NYET or O_PREC=
ONFIG
>> or O_NYET; although it is perhaps a bit more "use case centric" than "w=
hat
>> actual effect it has" I think it might be clearer=2E  A -DEV, -HW or -I=
O suffix
>> would seem to needlessly preclude it being used for future similar use =
cases
>> for files that are not device nodes=2E
>
> Hmm, I'm inconvinced about any of these=2E
>
> How about O_FDONLY, to reflect that you are after a file descriptor only=
=20
>with no further actions at open time while avoiding the ambiguity of name=
s=20
>such as CONFIG vs NOCONFIG or speaking more broadly implying any specific=
=20
>intent of use at all such as with CONFIG/INIT/PREPARE/RESET/whatever?
>
> I think O_FDONLY is concise, easy to spell/say/remember, and fits the=20
>purpose=2E  Your call!
>
>  Maciej

Overlaps too much with O_PATH, and implies that communication isn't possib=
le *after* device-dependent setup=2E

