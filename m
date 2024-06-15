Return-Path: <linux-api+bounces-1748-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D90FF90959A
	for <lists+linux-api@lfdr.de>; Sat, 15 Jun 2024 04:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637AB1F217A4
	for <lists+linux-api@lfdr.de>; Sat, 15 Jun 2024 02:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3688F79F5;
	Sat, 15 Jun 2024 02:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cQXgayq4"
X-Original-To: linux-api@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5202453A7;
	Sat, 15 Jun 2024 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417574; cv=fail; b=iZGP8YF3V5MjCdwvr5f/OlHWHTdg4+GEySs2eEzTKWMwawVGvUDh7fsUgoHbaNd5afol1iJ0+TO3UVG5XFbHzrOY1shTWvnyv5R/tKVQRMc9ksm72mI/A0Oct+TD3FlNF+NaXrzzVpMeAHQyD8JtEDxKYhxHYNTPxaiWJLg6vf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417574; c=relaxed/simple;
	bh=oXR7tGlYORA3ttVLQAjJZs8ODZYxwV6VqEnf+Gq+cgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=leVTebQqjdMie1F6q6iVbCXhrVAy/4X42m1olatvr9rps325nZEM7NvnA5fevZbAh8T9/HA2LjM79tjSCdq8X//aa5NKwFeHrEjpUJGrLauTtqf/dxZhcYdkVPtcOrI/nPmqQ0GY3lLwATkssa8jxQzv66dAwdqiBTIZyxl1B84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cQXgayq4; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mECFMT31zhz90d3yN3pV91Wnm1e0vDByDEHrDIo85oiMxP6E54pwOn6Q7Xy0tUd5gtbuAyrllOWxO2zxjyaEMDMP65S0Vt1eNY402TVOBwYDmGtFasETnbelBz+qdgtu2zyeqXAW/CznVDNazS17JL/0STVuGLQ2e4vWKbs0r+lH+22Zbntd64KkSCHG/6zbneMSX8ThJ23fFdYmWzeU7qDrU+/bxkzGGLWUFTkemw4Me9vboSeNO6DAFTWDIJjgGryI3zGRLJy0QgSukArWyKKwGRuHFv/FyrDhBtID5RtPEu8/A4vjSxUWNgRREUc0gnaN9kWvYzTGKo9uQ0Ucgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjJEAx9EO4Gt1Ifz/cONtMOWbp+QbNQ/gJbZyHqLAEE=;
 b=WzWJZYEfgc6G2m/s5cBDLmXycHsj0MnPx7KJX9c/kpw+W5XvWxkAjwFiTfAosMK24/iGm4ecuO4OuLke/fWQFxpONS4kOV195/JmsHwZmqMXYTv3GB7O2QYE0GB76rL9kHk66Zw6+CcpYZorCeNY7ak6KJl1+9pUj1jImagGl4Y4RNP9V+46E51QKdPpgZyPL1BXAhIhGrXapp/aJM4kc0XKXkhZeR4rybDTfE24qAganxv5VFe10mTeKT7ihhGCXFjYM7VjEPvynvA1xjNc5ZUbE08QPQjVq6h/nKyhCbcAIZKdrBbAEp8xmVbOMm14226aI7+B5k7hdKAsPZZpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=zx2c4.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mjJEAx9EO4Gt1Ifz/cONtMOWbp+QbNQ/gJbZyHqLAEE=;
 b=cQXgayq40oIGNYOWG8Z7PACMY07GPz3tXOgnZG1aKsayV/xk2QJqzptkIJLZ3q/kSWwQjbi5pzgch7+fBZJSbIYDSq+H39aBpt8mEPPKBDOXQ30/ieDSVbTiOEfLqaS47hW37FD9sivX95nSweiZOIdXrD44fY4Qv0LoUrRzXL86P0hsOCA5LJarHz75nuujNPKLFPtTcHOyeE9xstgC6U0t5oKnGEf1droirDqK7OaNO9LR2qpW+h8vPOao9mOW4SnSMhPoIPhz+6cNX5587dD5Vir930jTdATbwPX4DJDrmBg3GMftYmlgmNZAygwWb0Ul9L4txDTlk/UupW1ZGQ==
Received: from SA0PR11CA0171.namprd11.prod.outlook.com (2603:10b6:806:1bb::26)
 by SA1PR12MB7248.namprd12.prod.outlook.com (2603:10b6:806:2be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 15 Jun
 2024 02:12:49 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:1bb:cafe::b5) by SA0PR11CA0171.outlook.office365.com
 (2603:10b6:806:1bb::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Sat, 15 Jun 2024 02:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Sat, 15 Jun 2024 02:12:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:12:37 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 19:12:36 -0700
Message-ID: <722af60d-efde-48f7-b521-657c25f68195@nvidia.com>
Date: Fri, 14 Jun 2024 19:12:36 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, <linux-kernel@vger.kernel.org>,
	<patches@lists.linux.dev>, <tglx@linutronix.de>
CC: <linux-crypto@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<x86@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>, Carlos O'Donell
	<carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>, Arnd Bergmann
	<arnd@arndb.de>, Jann Horn <jannh@google.com>, Christian Brauner
	<brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>,
	<linux-mm@kvack.org>
References: <20240614190646.2081057-1-Jason@zx2c4.com>
 <20240614190646.2081057-2-Jason@zx2c4.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20240614190646.2081057-2-Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|SA1PR12MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0f2220-7528-4c6a-bfac-08dc8ce0a7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q1Y0cjZwclpTOVNSQjhlekREVUhtczZRTGxkaE9IdjROR3pIWnM1TFc3NFBm?=
 =?utf-8?B?MWc0d2h1aXFEWTlzYm85VS9YTWpEdHAvczZnVFBGY2l4c2FSM3NZdHQvU1pr?=
 =?utf-8?B?aDdaZ3FnS2ZCazdWT3ZwQkM2TytDZWd4SE5YSFhFd1pONitUQ2dWY05zNmYr?=
 =?utf-8?B?b1FsR01OZkJ3RkFWeW9kWHRNcEM1NERKQ1dGQmJXM1JvUzBqb2NseWJ4d0hP?=
 =?utf-8?B?SStiWmJJc3FvZkJvS1RSYmg3RmZVSmdoTWdGcU5NckNtTmE1T0pRZlp2aGx6?=
 =?utf-8?B?R25TcVB2bnRhbjYyTkF1T0JsOHJham9JWWZjOWttUWxzVzE5cDRKYjB0OURm?=
 =?utf-8?B?dHlDUTVjNlNwM1B5UU8zL0EwSFdRTHY3K2ZWOWM2eHF6azZjUDdIUDJ0UmFW?=
 =?utf-8?B?dEp5Vzc0UU1xdVhINkVZVHM2MWpPNm5jWEFHdHk4SDBCWDNGRWNYQk9oNW9D?=
 =?utf-8?B?cFAxaEJldDF4U0VNU3VLQUdubUdCYncvY1k4SjJxZnBsUXNRK3psbzZwRUdG?=
 =?utf-8?B?YjdYaEpJZjhGV3dCNnpla0xqVkczakpSdCtHZ1cvRXZqbGd2UFNjTWxiU0Zz?=
 =?utf-8?B?Q1JXeWt1Y2JvZm1UWm5GQ1E0dmxFVTFJVXdTekJJdHpSMHBHcEhtcWRnUzla?=
 =?utf-8?B?OVFZQk10Rlk1MWRkRE1Mc2x6TXVFYTdOSGNkMG1Lck01NmFpWEdyNVFOeDlO?=
 =?utf-8?B?ei9xVVgyYWloS2t1dGw3TXFGWmljRlU1czV4R0JiQkZIYzd3TE13TDd6WGcw?=
 =?utf-8?B?RmJjVVBBRmdmYUtjUkVwNU5lWDhISWdmOTd1dUY5MjNsejRKenBsRDc2aHpD?=
 =?utf-8?B?clU2MThPV0VZSjIvNTdab3JkcWdueXozbnZhYk54SEp0SWlla1MvK0xZTkJh?=
 =?utf-8?B?SmtNM3VicFJ1VTIzb2N1MzhpSDdwNWNZdDBDVTVFbG5MMHlPK3pCeXZjRm1z?=
 =?utf-8?B?V3pkYnlFVnlrVzlWS0E5ekIxaTNqWVV2QndVSUdrOW43dmdCbFJkSlpvRnB1?=
 =?utf-8?B?dDhVYnAreGFIa1B3WUoxaHo0eGFyazVmbEhpMjNLbkxhZ2NkaHBBcTJGNzk3?=
 =?utf-8?B?blh1MVBvU2l2dlFzRHFvNnFId3dsNEFHZjloY3FsZHUxYkw2cEZIM3J6a0l6?=
 =?utf-8?B?YnZ2bDd3eVhqYjlNQjhlTlpjeHBRYTI3eDRUdG5ZSnRSUDJhaHRlb1ZZRW80?=
 =?utf-8?B?WC9IR2d0Qkt5T3FWMGVtVXBmNER2TGpzSHNRL2J6ZEU1QmhnRGV6bVhNM1Zt?=
 =?utf-8?B?V0YvdE80dTZPOVA2NUFoQlREbncvWmFtVVp0bVNYOWVXLy8zT0xJN3lsc09t?=
 =?utf-8?B?U1NpdGFwZWY4aHZCb2dIczM5eE8yUHZNSEEzRU9XaW9ONW5YNjgwZXFCQUZR?=
 =?utf-8?B?c09lYWFRNGlMVHVWOTRBUDI2QWlrTDdBbjBtREE3eDJmSG03dlR2S3RlMFlD?=
 =?utf-8?B?U3FKS2tGNWMyaUUvVUF6b0tUMWJ3dE9IMkxFenhYZTE1SDl1NTVSaVdsR1BR?=
 =?utf-8?B?V2RYTmJaS2JZdEt4SWo3NWZ5NzVWaDZLVUg3QXlwUWpZcjNjdldpcHRZMFAz?=
 =?utf-8?B?M2RuZzlNeTJ5SFU4MzlweUlTbWllQUFlNzFpRnpOak1kbDMxZk1WV3dpdS8v?=
 =?utf-8?B?NjNPeXZVcUlZZVJIdzh2SXYvQlNDaUpGVzlzdWVocDI0ZHI5dzlKa0lHT0JZ?=
 =?utf-8?B?U0VMVy8zbENXQ09lMjM4WUx1dGJVaDRIVGhxS3hMSjAwOFFMb2o4cTZwb0VC?=
 =?utf-8?B?UkZodlVwbEhxLzlwUGkwQkxvMnUwMU1LYlczS2g1Rjh4M2JyZVJFTXdtKy9j?=
 =?utf-8?B?dnZtQm8wbWJQRXVLamlqR2pSUmpLaHZiREc1SThCVE5WUVo0VXF3QWtnUXlo?=
 =?utf-8?B?aDU3c25SRUJ3VEoyV0VvQWtoQjc5YnRmWFk3ckFUMEVOSUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2024 02:12:49.1229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0f2220-7528-4c6a-bfac-08dc8ce0a7a2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7248

On 6/14/24 12:06 PM, Jason A. Donenfeld wrote:
...
> diff --git a/mm/Kconfig b/mm/Kconfig
> index b4cb45255a54..6cd65ea4b3ad 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1056,6 +1056,9 @@ config ARCH_USES_HIGH_VMA_FLAGS
>   	bool
>   config ARCH_HAS_PKEYS
>   	bool
> +config NEED_VM_DROPPABLE
> +	select ARCH_USES_HIGH_VMA_FLAGS

Hi Jason!

The naming and use of NEED_VM_DROPPABLE are a little bit backwards. :)
First of all, the name should probably be:

     HAVE_VM_DROPPABLE

...although that doesn't yet work here. And the reason it doesn't work
yet is that the logic also needs to change: only the arch layers should
be doing this:

     select ARCH_USES_HIGH_VMA_FLAGS

If a feature does it, then the logic and dependency tree gets all weird
and wrong.

So:

a) 64-bit arches should do this part:

     select ARCH_USES_HIGH_VMA_FLAGS (already done, in most cases) select
     HAVE_VM_DROPPABLE

b) VDSO_GETRANDOM should depend on:

     HAVE_VM_DROPPABLE

...and then you'll find that the uses of HAVE_VM_DROPPABLE read more
like the pre-existing cases of other "HAVE_" items, too.



thanks,
-- 
John Hubbard
NVIDIA


