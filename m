Return-Path: <linux-api+bounces-1776-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4525D911D74
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 09:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A621F20CA6
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 07:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1A16F849;
	Fri, 21 Jun 2024 07:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="BbrROZ5Y"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C014316F281;
	Fri, 21 Jun 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956402; cv=none; b=JcFdtZVC25+mErDpLWwV/kR/r6PAzV0c7+9qXXOwU8BNkUeevFhOlZ5u5WU9TqFu1yL9RGk2Vr/Z5L3uh/B5Vr6hSDAl/9DC/9L+7m+dRwc54AgEq7q61rAzjNRfUp6xzygzaWez9P3kwoaVzKZfmAmt4pAaASO5v82rGHQbejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956402; c=relaxed/simple;
	bh=G6/B8syO5+PEL4vg78bCZhaB/0cgVxzhJly8Yc87OHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkVb7x+M5ph+Z/md19bEgzWwivpz55jmyUd1fVSXWuYG4u505ygKcxiIOg3c+KG5GaTijRAFmUkaGfnmYArE/h1L9+oG0U9xmMxUpvpKVkC74DUMDbIKcUobDJV/LUZMbT/xTbdpFzPyySKJnZ/XvIUDNIybSnHLCwfQNvFW1TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=BbrROZ5Y; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4W58jm51v0z9sRl;
	Fri, 21 Jun 2024 09:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718956396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DJYF0glbYGpdetfYjUqjJgpDNiNFn0QVt9n+HS0D64=;
	b=BbrROZ5YcvbPV5OeWLv5nbDIoRgnTi01FPEkJ5Ile6jHKQhsiKWTzC9WP7uBFgPSAMv+D/
	1eaUR5kvPTJZ1webN/uI239shefjk218vY7lfbKWPfrYF1m385U0SB/KW+nEhdfA7JWHiU
	Vremelk7cag0wFEi8cEa8ApPIeLnInq+JvVTzL2Kq5N4BDij2tp2PYtJfs3Vqd8PedwXdz
	vrZxLZmCSr6n/e8MBIXqzDylQ+irQDy6KVVJ5udjhTGyFXvI3NOws4W8U9sCZsZJj1ElmD
	N5w97D3tAhQ1iyp3eHCfeDCwAnCE11GeaiMH/JiKGUhtC/za6qEdSc2PqIdAmA==
Message-ID: <a0188274-8420-4d10-857a-b0d680e4a989@doubly.so>
Date: Fri, 21 Jun 2024 09:53:14 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] platform/x86: asus-wmi: support newer fan_boost_mode
 dev_id
To: Luke Jones <luke@ljones.dev>, corentin.chary@gmail.com
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240620082223.20178-1-dev@doubly.so>
 <20240620082223.20178-3-dev@doubly.so>
 <19cb366a-e6d8-4608-98c9-0fad389363ee@app.fastmail.com>
Content-Language: en-US
From: Devin Bayer <dev@doubly.so>
In-Reply-To: <19cb366a-e6d8-4608-98c9-0fad389363ee@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 20/06/2024 23.17, Luke Jones wrote:
>  
>> #define ASUS_WMI_FNLOCK_BIOS_DISABLED BIT(0)
>> -#define ASUS_WMI_DEVID_CAMERA_LED 0x00060079
> 
> Be careful not to introduce extraneous changes.

Yes, will do.

> Thank you for the work on this. But I must point out that the same 0x00110019 method has already been submitted as a patch to work with the existing "throttle_thermal" functionality, which itself is also tied to platoform_profile class support.
> 
> See https://lore.kernel.org/platform-driver-x86/20240609144849.2532-1-mohamed.ghanmi@supcom.tn/T/#mcd18e74676084e21d5c15af84bc08d8c6b375fb9

I see that now.

> If you could submit only the first patch instead please?

I'll followup on this topic in the other thread.

~ Dev

