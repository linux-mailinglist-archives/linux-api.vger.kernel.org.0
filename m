Return-Path: <linux-api+bounces-5248-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9137C53A26
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 18:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C34DD4FF557
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 16:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA9345750;
	Wed, 12 Nov 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gs7yr+ih"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926133F388;
	Wed, 12 Nov 2025 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963805; cv=none; b=iyq02dXakIVvKJJtHjmtZegkvuX+Ki1j13u31GVnbUzH09h0ceU2YCNmWaNljOh4alT6cuYzatYxmtlTCZVQ+u3pp5K/xLIAfu8o0847rTbq4t6Y9xPyr+4zpX0ZOybg2cTenfFRPVwGBWzsrqQGhcinMU2CQPkrIjUHijzIEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963805; c=relaxed/simple;
	bh=6+90iYt8yHn6fLVeRcRMn5yECTpBE605bYsebObkKiA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MmLevz4BdhQsNSb86nYL2h2099Mjk1208FFxj7cquL4QBKGniTpiZOuo4B6lzmo6NH1Js5hBHxCQjE84rCe1+LSjSiN227H4b1Grla6DHJx8Z2+5446WMAjp76I4/lTnwBN4ijXTsyxFzvW+BnfjMXmd6NsMrOS+vFITouBTfJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gs7yr+ih reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net ([172.59.162.180])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5ACG9qKk858789
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 12 Nov 2025 08:09:53 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5ACG9qKk858789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762963794;
	bh=heGREnEy97DJ/3PBLnuPWHyDMClDirtaVhwc7KBGZD8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gs7yr+ihaeLF4QpSBvoh3wuHOzShTiGaY57Urvlxkap6MmKJc1LlzHWO8CyOn61+w
	 gVc4aoheKzEVojPfU+eJLDUTceZKBHKeQA5ZBTuBYuDySrmcBbwp/mTK17UsHdv++V
	 Fc8e9dfkZOfVe39kPFZHq3+01Y/RkFXsU2OFZ7YvJl3/+Ua5mCGyhZn2uoSXiDplg/
	 AgRtj/73RtezqVMns+B4X6//QBzpPZOW7XDloRZquelz0jW8k8ZezvL2jDA8BW6VG5
	 VAvhXF7riHKl4rbJdyHP7LP8Zf7SqAid5Q97nOlBgM/ViIUvT6rQKpFfkDDy+E+U8a
	 TaQxHrwbgkxQA==
Date: Wed, 12 Nov 2025 08:09:45 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Theodore Ts'o" <tytso@mit.edu>, Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
User-Agent: K-9 Mail for Android
In-Reply-To: <2025111214-doily-anyway-b24b@gregkh>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com> <20251107173743.GA3131573@mit.edu> <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com> <20251110033556.GC2988753@mit.edu> <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com> <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com> <20251110201933.GH2988753@mit.edu> <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com> <20251111035143.GJ2988753@mit.edu> <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com> <2025111214-doily-anyway-b24b@gregkh>
Message-ID: <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 12, 2025 3:22:56 AM PST, Greg KH <gregkh@linuxfoundation=2Eorg>=
 wrote:
>On Mon, Nov 10, 2025 at 07:57:22PM -0800, H=2E Peter Anvin wrote:
>> Honestly, though, I'm far less interested in what 8250-based hardware d=
oes than e=2Eg=2E USB=2E
>
>hahahahahahaha {snort}
>
>Hah=2E  that's a good one=2E
>
>Oh, you aren't kidding=2E
>
>Wow, good luck with this=2E  USB-serial adaptors are all over the place,
>some have real uarts in them (and so do buffering in the device, and
>line handling in odd ways when powered up), and some are almost just a
>straight pipe through to the USB host with control line handling ideas
>tacked on to the side as an afterthought, if at all=2E
>
>There is no standard here, they all work differently, and even work
>differently across the same device type with just barely enough hints
>for us to determine what is going on=2E
>
>So don't worry about USB, if you throw that into the mix, all bets are
>off and you should NEVER rely on that=2E
>
>Remeber USB->serial was explicitly rejected by the USB standard group,
>only to have it come back in the "side door" through the spec process
>when it turned out that Microsoft hated having to write a zillion
>different vendor-specific drivers because the vendor provided ones kept
>crashing user's machines=2E  So what we ended up with was "just enough" t=
o
>make it through the spec process, and even then line signals are
>probably never tested so you can't rely on them=2E
>
>good luck!
>
>greg "this brought up too many bad memories" k-h

Ugh=2E

I have made it very clear that I am very aware that there is broken hardwa=
re=2E=20

What I'm trying to do is to deal with the (occasional) case of *non*-broke=
n hardware=2E Right now Linux breaks the non-broken hardware for it, and I =
don't think the existence of broken hardware is a good justification for th=
at=2E


