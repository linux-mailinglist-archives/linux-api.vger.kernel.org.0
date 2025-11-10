Return-Path: <linux-api+bounces-5186-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7FC44F08
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28DFC3B09A6
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EC2DCF58;
	Mon, 10 Nov 2025 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="uEl/PbS0"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5792DAFB9;
	Mon, 10 Nov 2025 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762750832; cv=none; b=CMiNb995P1rI/O/xaKC9eyB7HHzt5r/cnYyDZtnXNe+H++sy5McQRNa227WxIDui6LrvxBelt8b62eRyPxKZe0ZhqYOLwPa1TgUfIa36YPngHE/BAj4xq2SrYrdNJa/xRNtr4G7ivK1JBuwyQ/STC1/wSAr9joGqcPuA6EUDyEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762750832; c=relaxed/simple;
	bh=3WGfTCS9HxV5AsmfaNFxXV7MG/s7A4+FAIrFYvcWux0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Vgws4UBIBAERqrVbfY3STNsLRxMWYov2E4Y4o6avQcUFFV+bzInukgFgotWhqvjHVhzratDSt6Faa3t5eHRgPsjk7VgA5Qra0udPvKiipXD9RNlNHb6iDDfqxBBGj3jJvkbTGmM1daSZUIQ2vW1MtIL92cfXMNEqcRktG9y7o0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=uEl/PbS0 reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AA50Jku3337053
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sun, 9 Nov 2025 21:00:20 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AA50Jku3337053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1762750820;
	bh=lNNqKYw6kdGWpkMXG8MHJl3KOvc86BBf+kihsnGzXkI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=uEl/PbS0VWLvG94RHvgZJMy/NQ/QGbaxL4ssT+bv79p3jd4TJxIt/FCpu7l7ERQjG
	 3DTSJ2FUpcALRrTeSIRoGVltw9mh7pnj4g3ipw2UhLxBVTyJoJ96UCMpDktoDjxIzU
	 tvfwqRycbKAmymUA03B5FHsLL1HQF48ReX7fNB/l34jMAk4ccuTtk2SiM4x9cVIEVy
	 wGSAS3J/OZWIgPilFgn1d5WGIJYbRFWaoWRnNZBtU2wRT4EL6A2SGAsI7eiv392lZc
	 BpfW9befC2EReGJoSq4g1u3MCXtRGmjbqUmYpUO7abr0YdgJJ+hhwUE9ovZR0HIeI4
	 k4cXstZNLsfPw==
Date: Sun, 09 Nov 2025 21:00:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-serial@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
User-Agent: K-9 Mail for Android
In-Reply-To: <20251110033556.GC2988753@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com> <20251107173743.GA3131573@mit.edu> <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com> <20251110033556.GC2988753@mit.edu>
Message-ID: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 9, 2025 7:35:56 PM PST, Theodore Ts'o <tytso@mit=2Eedu> wrote:
>On Sat, Nov 08, 2025 at 06:25:20PM -0800, H=2E Peter Anvin wrote:
>>=20
>> The standard ESP32 configuration for its serial port is that asserting =
RTS#
>> even for a moment will cause a device reset, and asserting DTR# during =
reset
>> forces the device into boot mode=2E So even if you execute TIOCMSET imm=
ediately
>> after opening the device, you will have glitched the output, and only t=
he
>> capacitance of the output will save you, in the best case=2E
>
>IMHO, these more esoteric use cases should involve a custom kernel
>driver which replaces the generic serial driver=2E  In practice, these
>things aren't really a tty, but somethiung else weird, and trying to
>do this in userspace seems really awkward=2E
>
>> setserial (TIOCSSERIAL) and termios (TCSETS*) both require file descrip=
tors,
>> so that is not suitable=2E The 8250 driver, but *not* other serial driv=
ers,
>> allows the setserial information to be accessed via sysfs; however, thi=
s
>> functionality is local to the 8250 driver=2E
>
>My suggestion of using setserial to turn on some "not really a tty;
>but some weird networking / cheap debugging hack" flag should work,
>because you would do this at boot up=2E  Note that the 8250
>autoconfiguration code (see drivers/tty/serial/8250/8250_port=2Ec) is
>going to mess with DTR / RTS=2E  This is why I asserted that trying to
>claim that you can preserve "state" across reboots is Just Not
>Possible=2E
>
>If you have some weird setup where DTR or RTS is wierd to the
>"detonate the TNT" line, might I suggest that maybe we shouldn't be
>using the tty / 8250 serial driver, but it should ***really*** be a
>dedicated kernel driver?
>
>					- Ted

That is a completely unrealistic idea=2E And you are hardly the first one =
to have it=2E Microsoft has been trying to get rid of serial and parallel p=
orts since the 1990s for reasons like this=2E=20

Microsoft even have had to back off the requirement of having =2Eini text =
file "drivers" for ACM serial ports=20

Yet they probably will still be with us when the 22nd century dawns, exact=
ly *because* they are ubiquitous, supported by everything, and require no s=
eparate kernel drivers=2E

And these days these aren't the "esoteric" use cases at all=2E They are th=
e norm=2E


