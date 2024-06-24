Return-Path: <linux-api+bounces-1797-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635D79144F4
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2024 10:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93FCF1C22441
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2024 08:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF35A4D5;
	Mon, 24 Jun 2024 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b="0jLtP/N5"
X-Original-To: linux-api@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D04D8AD;
	Mon, 24 Jun 2024 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719218051; cv=none; b=RdyafdWvIZ4EqjniDpZp2yMUzwRtkQG+6Qo2EhPZdEPWxfTY4yORvTyhoG5r/og2o/xxi3v5do5lLK4WxMcUBr6Hq9leGzsB+u3FaI4OmH+IAeUqO2JXcxGJ6K565iFDjUTmF6mzNAJRZIhphjWuhMtVd/hu+PSXks99x9oi9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719218051; c=relaxed/simple;
	bh=FOxLOQx8+2xFjNq+Iwiw9qgPgBoY9XM/gsyyRDq7MFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvwgmGy1pfR4xB9aYc0wxpJM9ZEh30LBSvcho6pgSsHZ7ug6/rFqJXIENfywWHy+F/LG1oF8d+/ZN+RtuUFunVGq+HLhrni+SKheHaQMJvi7fGQ5oxOvL/f2ovK/xBXoiCKTgyDDo0iFz4+6FwOYlhMU88juSByA+HZGyPFRMXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so; spf=pass smtp.mailfrom=doubly.so; dkim=pass (2048-bit key) header.d=doubly.so header.i=@doubly.so header.b=0jLtP/N5; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doubly.so
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doubly.so
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4W71TR2sTzz9sTx;
	Mon, 24 Jun 2024 10:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=doubly.so; s=MBO0001;
	t=1719218043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52X+fnSIf84Gm3kes1tBU7tb8Dm/ZjoVWGcCwwEOaYQ=;
	b=0jLtP/N5Gi73mif2jP/CqLqPKB0vwhXyYDW/1Lnq+rJkCPh6Hj66e4l1TU2Ltc275l8Ssy
	GNLFB+xbUWNgQeXFgBp2UdRDHRCb/J6jkkQt1PHyJ/VQkCijNlB1lti9mFhT/HYawl14fX
	vQexIzExQ4qy8D6jTrYLnyJqiwLncWuXRCsDd1HRnqKftnvzX+Zd7pg58c79lEHngn2LZR
	3GR2cIjItjZzFOXQmBPOfwaIj5FlzNKwGe7MryC9o3wMSMPlioe9UsWtR4tXhJ49/inrXN
	EK1lwBNd8qR1QmYOSUzWF95xeAO0Lue52eHs/z+vn0d/Xr6eqxArfCsFh+mF8g==
Message-ID: <0c189a70-f832-44a0-9ea2-44231ee4624c@doubly.so>
Date: Mon, 24 Jun 2024 10:34:00 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] platform/x86: asus-wmi: support the disable camera LED
 on F10 of Zenbook 2023
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corentin.chary@gmail.com, luke@ljones.dev,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
References: <20240621085745.233107-1-dev@doubly.so>
 <a80c09f8-e932-722f-8c68-19a254d94633@linux.intel.com>
From: Devin Bayer <dev@doubly.so>
Content-Language: en-US
In-Reply-To: <a80c09f8-e932-722f-8c68-19a254d94633@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4W71TR2sTzz9sTx



On 24/06/2024 10.17, Ilpo Järvinen wrote:
> On Fri, 21 Jun 2024, Devin Bayer wrote:
> 
>> Adds a sysfs entry for the LED on F10 above the crossed out camera
>> icon on 2023 Zenbooks.
> 
> Please wrap paragraphs at 72 characters.

OK.

>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -50,6 +50,8 @@
>>  #define ASUS_WMI_DEVID_LED5		0x00020015
>>  #define ASUS_WMI_DEVID_LED6		0x00020016
>>  #define ASUS_WMI_DEVID_MICMUTE_LED		0x00040017
>> +#define ASUS_WMI_DEVID_CAMERA_LED_NEG		0x00060078
> 
> This is not used?

No, it does the same as CAMERA_LED but the values are opposite. I
thought it would just be useful as documentation of the WMI functions.

Should I remove it?

>> +#define ASUS_WMI_DEVID_CAMERA_LED		0x00060079
> 
> Why is ASUS_WMI_DEVID_CAMERA_LED added here and into the .c file?

That was a mistake, I used it for testing.

~ Dev

