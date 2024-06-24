Return-Path: <linux-api+bounces-1796-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7F914472
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2024 10:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6811C210B1
	for <lists+linux-api@lfdr.de>; Mon, 24 Jun 2024 08:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B3B49655;
	Mon, 24 Jun 2024 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CdTB7s3j"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7044965D;
	Mon, 24 Jun 2024 08:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217063; cv=none; b=L/zL/P/Pmlf3n0ct9rqC0qgDrIWfefb08pNg912SyxdMeVQzKxr7mPaN8ihWzH+4Afc0cqQJgSZOH4jwoG4eTiWzieOjX6rLQUKPw4Si7+I9+QEAvqUlTJoyc0aZMfzbEr2PmM4hE5/ISq8QgxcSP8sdB9cJBFtSbrSSvgP+S2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217063; c=relaxed/simple;
	bh=6+GHfUnPZAlT+q17Ycp/jdFR/9U3hxnnlC2UC3hGHMo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gS7qeYkHuS3/5TaRgX3Vu+b+JVMP7BQ5ajBdaPY4Zac2m1jQDCoyfzRz5/VyLlbPjtGFL3Xd5+DPuhLthgZowQmgE3niQHi9N3nt7J3IumtQ9wYP7MMo4qdbs8qU+NmmEWWmw1YQdr6jBXqVl7v6OOS6C7LQS8yQVQQQsBDoDDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CdTB7s3j; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719217062; x=1750753062;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=6+GHfUnPZAlT+q17Ycp/jdFR/9U3hxnnlC2UC3hGHMo=;
  b=CdTB7s3j5KVcN/LUne+zxpICVALEA4mMV2BHgelNXc1k/9J3m4p9Cjza
   BlK9IA6iV08gNotvFlPR7ezJkvW2NsX3VJtEbGU/Cd2fOfWGDRKcmxBSv
   gZqBDuCFTA/zhOTdKiuWGIcDOuceMCfd0owLUrjP6zCD9wDnI67t/uX0m
   QIoB0WIo0/xO+gMPKsmqtdYbztlhyeTgBuQ5zWLHDefZSZgeL2+bvRg/Q
   L7sLyOm9Gkmll+h2Iw3anse2lQVXBulnODz8bxDpAUSCeze8q6SDgQV5+
   lS66AMb8X3cA9eGzOPbD2arlCwvUs0lWsXbBlLBaus2u71sL19qAls6n1
   A==;
X-CSE-ConnectionGUID: 2VGsX5TtRlacc09yWvc2+Q==
X-CSE-MsgGUID: kq6QuwA9TKGzNhbrF23y7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="16405083"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="16405083"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:17:42 -0700
X-CSE-ConnectionGUID: AOFchtFWTHm0M2PYlnWh6w==
X-CSE-MsgGUID: FDVFmvu3QO6XWzbGuuYvIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43293208"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.61])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 01:17:39 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 24 Jun 2024 11:17:35 +0300 (EEST)
To: Devin Bayer <dev@doubly.so>
cc: corentin.chary@gmail.com, luke@ljones.dev, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86: asus-wmi: support the disable camera
 LED on F10 of Zenbook 2023
In-Reply-To: <20240621085745.233107-1-dev@doubly.so>
Message-ID: <a80c09f8-e932-722f-8c68-19a254d94633@linux.intel.com>
References: <20240621085745.233107-1-dev@doubly.so>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Jun 2024, Devin Bayer wrote:

> Adds a sysfs entry for the LED on F10 above the crossed out camera icon on 2023 Zenbooks.

Please wrap paragraphs at 72 characters.

> 
> v2
> - Changed name from `platform::camera` to `asus::camera`
> - Separated patch from patchset
> 
> v1
> - https://lore.kernel.org/platform-driver-x86/20240620082223.20178-1-dev@doubly.so/
> 
> Signed-off-by: Devin Bayer <dev@doubly.so>
> ---
>  drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  2 ++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 3f07bbf809ef..20b7ed6a27b5 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -73,6 +73,7 @@ module_param(fnlock_default, bool, 0444);
>  #define NOTIFY_LID_FLIP_ROG		0xbd
>  
>  #define ASUS_WMI_FNLOCK_BIOS_DISABLED	BIT(0)
> +#define ASUS_WMI_DEVID_CAMERA_LED		0x00060079

> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index ab1c7deff118..fb0b00f7d292 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -50,6 +50,8 @@
>  #define ASUS_WMI_DEVID_LED5		0x00020015
>  #define ASUS_WMI_DEVID_LED6		0x00020016
>  #define ASUS_WMI_DEVID_MICMUTE_LED		0x00040017
> +#define ASUS_WMI_DEVID_CAMERA_LED_NEG		0x00060078

This is not used?

> +#define ASUS_WMI_DEVID_CAMERA_LED		0x00060079

Why is ASUS_WMI_DEVID_CAMERA_LED added here and into the .c file?

-- 
 i.


