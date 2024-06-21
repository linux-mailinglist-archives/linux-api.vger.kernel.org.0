Return-Path: <linux-api+bounces-1775-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC25911D4C
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 09:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E54A4B20E59
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2024 07:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C1A16C6BD;
	Fri, 21 Jun 2024 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="kEsmgYjW"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52867E58D;
	Fri, 21 Jun 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956266; cv=none; b=AqrZd8JCir8YjUKHtDzIMprhoQQKxZfPW25KF06qoZ9+TbRoDD+x2MbMSU2vqwZ78EOFNZYq0yJOVaMZrGlFb+EUKOD5+Fruo/HnQI+HRE6BW5e3kCXkt2MXDMtzY/PDeZmp2bv78N+7u9Hd2PfjZ1qiM9GKz3PGZgNulmgzLPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956266; c=relaxed/simple;
	bh=Pxmox1WHzNqLNTjRZ+wfFdPf6PN5Od+20NDoOX4LdIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKy2cLR2+qzz2aJU61a+kes1NxbQSqg72JdWnslkVZVNrozSVA8VxSyXjLtGImbkzsqQsk9DDU/VtnFoGtBf79QE+cLYjz1pexzR/aBMS2JcTLRcJJ+zDAGMtnU2nEgxQXxvwoWGjzGDM4NewVGjrRagR5v5p28i88zQNP7HeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=kEsmgYjW; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4W58g055qkz9stw;
	Fri, 21 Jun 2024 09:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1718956252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ocU6Wb9xrrpo54+K+ErVA2DXeKsDSMwyOOGzzhERa0=;
	b=kEsmgYjW01NiKeqVOCiKs34hrGQt8owhWaNrxG+CWMlixF7QDGMEaI/T4CgydztYlu6FIp
	YX3CIoDTbpTF1sHOd5hBgU+RQDEx/ai4e90conDdXUdOjnv7vA04Xxb4b/4G0ScCdqmTQu
	2ueKThlCYp138fUKHPJkMCAs+W4/2K8Ch+6AoWrdXtpTBcC2Wju4StWyTzZ6zFTpfMNdF2
	AJlOXMt75AmcFoBulpBQLlLQEoUitPM9U/thEYQ+e9avBMriCkqeHKNA5b179wkaogVQka
	Oyxwb9FDk2CI+Cv6Oa7cjkMih0Xh5haYdUdGtdnEqdYZ7dIWF5wdsp6Zfz/EVA==
Message-ID: <a18c8b3a-90b0-47a7-aff6-a289ecddc2c0@doubly.so>
Date: Fri, 21 Jun 2024 09:50:50 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] platform/x86: asus-wmi: support camera disable LED
To: Luke Jones <luke@ljones.dev>, corentin.chary@gmail.com
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240620082223.20178-1-dev@doubly.so>
 <20240620082223.20178-2-dev@doubly.so>
 <ede8505f-bcf6-403e-bda2-6848cd4ff4c7@app.fastmail.com>
Content-Language: en-US
From: Devin Bayer <dev@doubly.so>
In-Reply-To: <ede8505f-bcf6-403e-bda2-6848cd4ff4c7@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Thanks for the review, Luke.

On 20/06/2024 23.40, Luke Jones wrote:
>>   
>> + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_CAMERA_LED)) {
>> + asus->camera_led.name = "platform::camera";
> 
> What do other devices label their camera LED as? The one I could find appears to use `<vendor>::camera`. So maybe `asus::camera` would be better? This also keeps in line with `asus::kbd_backlight`.

I reasoned it would be better to keep the name generic is so out of the 
box desktops could toggle the camera and the LED when KEY_CAMERA is 
pressed, just like with micmute and mute.

But I'll submit a new version with just this patch and the name change.

~ Dev

