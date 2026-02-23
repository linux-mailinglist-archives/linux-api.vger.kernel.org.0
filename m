Return-Path: <linux-api+bounces-5874-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNgYKDdYnGkAEQQAu9opvQ
	(envelope-from <linux-api+bounces-5874-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 14:37:59 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C660177031
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 14:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0796303F079
	for <lists+linux-api@lfdr.de>; Mon, 23 Feb 2026 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247520E31C;
	Mon, 23 Feb 2026 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="TQul892E"
X-Original-To: linux-api@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021112.outbound.protection.outlook.com [40.107.192.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571D1E834B;
	Mon, 23 Feb 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853842; cv=fail; b=tIXXlAfCSo5ClTmuLxJvb/f/e/S+90ReLI3ANYvyKOPKcUYuwmicQqI4uisPzAQClRk+gKgFY5xnOkA16E3PLp0F47iNQy8pZwsmUOyQ2Fxo1zCzzFGzpJWSwG3zpa+jDNy1vGd0i9zsITeHTMD12SXBO9XMdWV4RWDSGuhllBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853842; c=relaxed/simple;
	bh=eD+MlBpTm2BWax8bqpXlkTx/LfgNn3Bp+XKIDXQJ6rs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AAO9yPQDNHicP6amwn492mWiupluMnRqwAjHVHFo8/GZ0d8KnOgGuCnhIlQ/fMfKlSa4/srljWBIAbfLPFvlp6YrGk/F1f5fsKxI9KkinwCouuV3Y+3YAltePXoMJnKnEgk4bJJbJfnmNSHQEsxp/2duLzIaMuCl6PjUbIjd6aU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=TQul892E; arc=fail smtp.client-ip=40.107.192.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JN7IOY9IGreoS/fMWDETOgN0y1met8Y2rFg9JrquGDacc0BvCXSSpfvVikjtNzk/nh+HHyN/gjJXk5tjTqevIp2yEX+j6ZmgOuYr7MRtSbaeQDn8ld9nJ1mor5CerBZlG4t5mJdIRE41WPQo0SdPu1MC2vf0DxInMvVnJvuc4WNNRLfjWTpIMZsWuU232Mf0npphqByqx/4Fo/hR4Iu3x171zwKCoXIk2HNlzlTHYoLNwxe4GztmR2JB61fX+RBdYMmNHDIqzpIENnFm+nJJr7M+7kjjAeu4t40JoDEIIYwCUSiHcP03aaQpUMfcpyN9URQyYQUZNBKMn3m520r51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hE+oVbv2RTfRjxwP8rH32zmu2c7nPZ1Oct38ESP5ng=;
 b=Qk8c9/PLce4RbhZ2KR3BNZFZJWby/1xNbA6Zz7LXfwcXiVkxb73k1tDn+DF3HDwuVRdk24C5zJGeLDHvQpznpnpKZDtVCvCAa2L5M/YVJGEqVm4NTcVeP+D4jkhdsOHWwMN/+a16S/PUJcRdiIqlrFbQFRbIiBuMh3u21WyrW2mUiNEg5jFE6EU91YS1hE9bqYYtl3HKmWC85kKS8keZaj959WJHgs4ARf3PibqJzfqOCfTuryKtlsyMaaB5eLosrojq14EVMF5brPJ5fb303OQnVaBQZttbuTuD5c4LX961xk20XTTttWG30pJ8iX+r0wujcJHyT2lldoGxjqQWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hE+oVbv2RTfRjxwP8rH32zmu2c7nPZ1Oct38ESP5ng=;
 b=TQul892E3r7I8ePVqkCZgKyIXR8W19sYpUtROPm0Ra/hvIIuCWTvsUZn2lX18F4jDac3CQ4Cf2ObkC88n4wnDvvAlbB+oN2vxE6LEdswYlATdP8YCFQOceSJh0jjyY0r8J0FQ9jzN9xr8T8s0J7gwDO8SzA3xkO2Jc5PX0m2E1Ar+B+L33AfRHZqvZ9py+WjiCY58ViID4vv4GrDSyobGgMTuBSPdf+2It5JJI8m9NxhH7s3jSULjavJCxx3LyE1mL53E7sdmcL3uODKZ6kBWNs2QK4ABWN/y43oSW53wQ0lVDX4d1/gHvNRgOUHwEd57z+3A7ZOjp3YXwmd2N8v7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9452.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 13:37:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 13:37:16 +0000
Message-ID: <87003e32-eae2-41c8-8b83-2530f084b3c7@efficios.com>
Date: Mon, 23 Feb 2026 08:37:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
To: Florian Weimer <fweimer@redhat.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Carlos O'Donell <carlos@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Rich Felker <dalias@aerifal.cx>,
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, kernel-dev@igalia.com, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
 <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
 <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
 <lhusearzp8o.fsf@oldenburg.str.redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <lhusearzp8o.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0139.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9452:EE_
X-MS-Office365-Filtering-Correlation-Id: 365509f0-a148-44ca-3388-08de72e0a8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG9RUVZ0cFlNdHIrT1V5VVk5NGp4R0xmb2oxN2VFcXU3d3VjeUllMUc4VDJk?=
 =?utf-8?B?WWhYUWNEa3grVWt3QVhxeG82U0dmbGdBZnRwenl0YkROWHdCYXRCYkUzWjFQ?=
 =?utf-8?B?SFlTb09neVhPMUVZQk5US1hxZzU1TG1FVnJEU1IwTmxiY0lNUHA2Qy83Umoz?=
 =?utf-8?B?QlAycHlyL2UyazBIRE5mQXByMEZzWnRWWEt1QVVqbjNvNEVXMkp6eGRlaWN0?=
 =?utf-8?B?eTlsclQxN0ZxK2Q4NHI1U1VZNGk4T0F3TCtDZEFpR0FzUGxnT0NUelhjTUxw?=
 =?utf-8?B?YzlRL2Z1YVFGb1NzYUNtTTdkbnRRM3diSTIzcEVDT09WZlkrNHBGU1RRVW1x?=
 =?utf-8?B?eDMwbnU3OURuYWgraHEyNVZaaWFvVmszT0RPTDBZUGQveU5jbGQwRmtIU2tn?=
 =?utf-8?B?Wnc4bU9ublBQWC95Vk1KOHVWeEthelV4amx2Wi85KzkvdFJYSHJtRWlTa1kr?=
 =?utf-8?B?L2tzWFBTSDhDclJyei9BTVVWZExzWDJDYzh4akgxWUJ1V2FZTW94OElUM1hB?=
 =?utf-8?B?NklGSXRRTlFGMVl0LzJlV3ZmOTlicUszUWtmY21Od3B1VjFsNmVGU2tGQ3dU?=
 =?utf-8?B?UFpPYWczYzRhd3ZVSnNJd0UvTm1SQmZYdGlkaDA5RlRVQnRPU0lvbS9QM0Fr?=
 =?utf-8?B?WEVTREhNUTI0TjhzdExkaVlVYklGUlZNS2pRRWRUQWFCd3NVVUNjci93RkQ2?=
 =?utf-8?B?OHpwR3U3WU14dEI5dVFERytOS3MwL3pMaG4yT21uVjVrL1RjVVpsd2RmbHJw?=
 =?utf-8?B?TTc1TUlCVVR0VXlvRmdMWUlzTEJUbXpIaG04bU1jcVNZZ0NJbWtaVjVudTdv?=
 =?utf-8?B?Zk5Rb3YwQlJER3d6bTRuS2haYy9LblNNQXA2UWNoa2ozUEFxcWVWaElPTDV4?=
 =?utf-8?B?RE5odm5VVTZaSEhUMEQrbjYwQUlUTUNva0dQdkQ0Rk4yK1RNRkJmd2pubTE1?=
 =?utf-8?B?MGtDLzE2RUc0SlRHWlNaN01KcVRCeUJNcllIYXoycnlFdmdpOUNYV1NSR29h?=
 =?utf-8?B?dm5LT0Y5UGM5alMzVU1tL1h1WFg5ZFhtT0NrQitWRXY5MWNybWhNbXk3SWhQ?=
 =?utf-8?B?RDZJSDloMVRzMTRiRm0vN3p3cWlqZSt2aHFRdGZ1SDlFeHZDRXlnOXdhNTND?=
 =?utf-8?B?cHZUK2FxV0hlTjBmRXRBdWh5Y2d6NG5ZeXM0ZTRraitVUk4wZHlURUVmbzdX?=
 =?utf-8?B?Yi9MK3kzOXlocS81SGhpcCs5V05wQXltbmxwME5mWWh2d3pqOUhrWmlqcC9y?=
 =?utf-8?B?aHQ0VTNHRklqVlh3ZFphQ3lYOTdZTVYwNk9RckNzcGxvV3MrbXBBSC9GV1pv?=
 =?utf-8?B?U05SRWlkTW52RE5XaGZpekxPak00Q1F2T0p5K1JQL2Z5SXVuV2oxdlAySnJy?=
 =?utf-8?B?b0tBbXo0dmlLV1ZtNy9uNFUza1lZNDBBRGZSSU9HMEQrSVUvQmFUQmo4TkZG?=
 =?utf-8?B?S0Yxa0swNTcyZHpRSEtJK1FLY2c2bzBvQjlrek1zOG4rb1dDQVlNbE9zNTBi?=
 =?utf-8?B?T2NQK3lnNjZWci90UzlCeklsQTJITkhpRHRoaDBpWXVCZVVKZ0lDQU1rQmpq?=
 =?utf-8?B?blVQVXczalIrNlZSVnJVNmVHajVDVGR1NzVRcExtMm9EeVhuSDZ0Vm5BOWFI?=
 =?utf-8?B?UkVrSGZCR0xYR2taekZ0TDc1S0dDUWVkbTc4OG9ncGlZb3VsUVoweWkwSFZV?=
 =?utf-8?B?Y2hJakhQOVZYUUp2b2EyZDFoYmZJVENYYmJqZE1HbllkdDZ0bmtONjRVZGYw?=
 =?utf-8?B?cWtTTTV6aTZzUEJjQ0EwMndxeUNjMi9ndlZtTXRJTDFuMnl1YzlKcjFvdnQy?=
 =?utf-8?B?NkIzS3drT3RBR2pGNmMvVVFqc2JUZzBRbkNWaDF6M29xTWROWkVGVmNWWjZo?=
 =?utf-8?B?MHV1QXRYSjFzMTVnYWVuWE9XVXBsQlRYRWxaMCtoK0Zhb256ZGNYOFRDMHNv?=
 =?utf-8?B?QjdNTTNobTdMT3NwZHJFZnVFN2RjcnNtT3N1VlpTYXcrOFlHN2RqZGZ6TFJO?=
 =?utf-8?Q?20+BpnbQUzuqZwj8Eccf/IDhOJW+RE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjJQTVM5NXV2eTRiOXczamFXdStEcGwxTTFRenZpeXRieURBRWVqOEk2RTJy?=
 =?utf-8?B?N1JKaEE2bUg4elhMNTFvRTk3MGtQVzErRk1JaDBoRjBJS0RIUnpDNVpCQzhD?=
 =?utf-8?B?cVhWbEt5dU95c2tOM1kzWlRpTDEweTcrRFRkMktHd3I3NkxvaWE1Z0FGdTcz?=
 =?utf-8?B?N0lqSTNnL1dsOWJCWmhzVGdKbm1xNk9uckVEOU1Od3BwTHlYWnRDZk9FZklG?=
 =?utf-8?B?TjRCWFQzd0tweS8rVWRibUNMdjRwN1ppaStvSVY2WFFuM1EzSXlUaFpTdEpQ?=
 =?utf-8?B?NU5jdWhwQUs5L25XMDV0Zm9wTmpoMDdpU08zZ2xwU2VibmJMN1ROd1dUOENI?=
 =?utf-8?B?V1FRS0JKdFZPUTVReGJ6MFg4ajFXanE2RzBBS09QaE9XKzZRRTUxMjBrSVQz?=
 =?utf-8?B?RXlWNXJRUkZ3bkpEalJjOGZQdy9FVVpROGJLcFdpQ2FzZnkvNDNBVllmdkd5?=
 =?utf-8?B?Mk5ra3F6WVFDUm0ycDhEbEhCMEJKeTBMb2RyckpZSnRjTFdhYXZNNlYzbzk1?=
 =?utf-8?B?MDNOLzhlNCtxS2k1SGNkcnFnTE5SVXZ4KzRYYWttUnJxRldFRXo4Q3BnYlpn?=
 =?utf-8?B?NGk0ZTByamZaRU0yNENNUlNjNTNmVHNVUHVjWk9JeVAzd1dqd3lTRmJpaE01?=
 =?utf-8?B?S0pTTVV0WDNEWTJGWm1UajlkTWQ0eUtObXhLcFBsVkFrYVFwZkRDT2dRenhD?=
 =?utf-8?B?N25mVC9MWDhkSThXRTlCYU9LV09TcTA3UWxrdDNsZnZ4VFNRUnNWOU5WcW5q?=
 =?utf-8?B?aVNZb1gyZVJsL0prbUgwRjdKbzN0TStPYnNpN0w2RFhSbmF1NWlUS0h3MS8v?=
 =?utf-8?B?MDRVaU4vMUM2TGNxTmN4NnNtb05mOVRmT2J4TG84WDBFRmJwWHZ2clNxckx4?=
 =?utf-8?B?QjNvYmg0U1NJdnhWRjJOZEc0a3Y1eHh0enp6RStDU2h1OVZyRzdqTno4MjI1?=
 =?utf-8?B?b0JPb3J5RWpZTk1rYzIyS2kxdHgza3g5eU9lcTdmYnkxVkpmVERpdGF3RmJv?=
 =?utf-8?B?Q3l4bmdGRWZGZVpjUW9GNG0wUFlDLzJpQVlXRm0xcWJzaDlPMVNMd1l4akE1?=
 =?utf-8?B?MS8zai9ZSkFteVBHQVMwTk1pU3hneEZrSHgzV2I3ay9UazBMSWNkc29zdFI3?=
 =?utf-8?B?Y3dZdk1xY1VGUjFqMk5paDlxdVVTN0FKa0kyRUk2U050QTdGQjhqbEFXSVIr?=
 =?utf-8?B?eTNEckRWekZBZHpIRllnbVJiN1RYRG93ZWJ6K0FxbVNuQ2E3dTR1SXJ6TnNr?=
 =?utf-8?B?Yld4TzdGSVBrMHFEb1hVRmVUN0hDSC8rUHBEcngxb2xIcjVDcXAxZldZWXY4?=
 =?utf-8?B?M2xwYnNvcUluZU9mcXhudCtyWC9OdXVFUzdFeE40Q1Evc052aVl1djJCZEZF?=
 =?utf-8?B?TU1zOVZZR2U1UXc4Tyttb2IyMTZzQ2ZnUEwrMlEveXRsRkJMWkxZUnVNMlV0?=
 =?utf-8?B?aE1zZG1SR0tFaW9nUVdGL0hDVjB5WXlObTdHczA4WFhxcWU5TXZnd1EyNE1G?=
 =?utf-8?B?TzdCS05zSXdTYU5MbjlBdnh0YWRuaXFZWjJGcytGWnpJVEcyd1FzVkc1c0lY?=
 =?utf-8?B?Z0RlUk1Fc29ielZlWVpRcnNmMmtHNGR5bkx3SGh6N1E2ZFBHeWtrOXJRa2dr?=
 =?utf-8?B?dnFISjh0SHg2SndjbGdqOFhFTG5RbUUyalhJUzZ4VHB3bVA2amlYa2oyaEps?=
 =?utf-8?B?UCtxUWxRT3BEQWtJY01Bdml6Sk5La3Jyd0Y3VDF0VDF2MWJvNngvc3BuaUNI?=
 =?utf-8?B?Z2diY2Z0ZTBwK2FXaWVPQm1LNlhpenF3SWJTRVFIZ3FBRGFqS1JIT1pHdS9X?=
 =?utf-8?B?NnI0cHRObGZydDRwS3V6MTEwVkNvT1N3aTcwS0xkdTdFRVZINzlXTzBqaEFN?=
 =?utf-8?B?YmtVajNldmU3dWFlVXFjRWRtSWN0c2hTODhza3hsdkQ4TWFyQmxmWGlsWlJK?=
 =?utf-8?B?VTNPT015WVhkdHJhbFViRlBKSElrOExVYTJweldYT050QmMyZ2E1YjhacmdH?=
 =?utf-8?B?aDd6LzMwSzlTOVB5MGRiK2I1MTlQL0VJV01wU3BINW5RdGNyNW5YRGRsMmtR?=
 =?utf-8?B?T1p6OG1vV0gzL1J4T1NhMlVsVGJaVzRLenI4RHdQNVRRRGtIUjQvME1PVTcw?=
 =?utf-8?B?Y2hJMm1MNW04Zm1rWTFlbGtmSEZOU3hJdUlCM3dsVlNiTkhYM3lmT1BPWkVa?=
 =?utf-8?B?ZVVKb3c0QktWcWo2VFU4T09wVGEvNnBPbEo1STcyb3RsczBDRkVaRG85NFJl?=
 =?utf-8?B?ZGdZYTExUWVlZHZXMitqNlB0eThuOXY5LzFhYmlYUUxOallGQ2xFWkNXcXUv?=
 =?utf-8?B?OHNvV2JZbWQxWkhRUjVTRDRUN0ZwaC9ubEdhV1ErckV1cVMwUFovUXJmeGY5?=
 =?utf-8?Q?46CyfrPIqHv6eB8D60o6cPUEzZEUKA/awFoKq?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365509f0-a148-44ca-3388-08de72e0a8aa
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 13:37:16.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psOTnbmemxU78L9IDjfNumoHlL6CIDG54LQ8AdCA0D1ZFxiLGik2YDvuKt0Ze3cwpftBKvrcE9eBiNXdWiJnUViHMDLHetOIHibuyxEVU4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9452
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5874-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:mid,efficios.com:url,efficios.com:dkim]
X-Rspamd-Queue-Id: 0C660177031
X-Rspamd-Action: no action

On 2026-02-23 06:13, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> Trying to find a backward compatible way to solve this may be tricky.
>> Here is one possible approach I have in mind: Introduce a new syscall,
>> e.g. sys_cleanup_robust_list(void *addr)
>>
>> This system call would be invoked on pthread_mutex_destroy(3) of
>> robust mutexes, and do the following:
>>
>> - Calculate the offset of @addr within its mapping,
>> - Iterate on all processes which map the backing store which contain
>>    the lock address @addr.
>>    - Iterate on each thread sibling within each of those processes,
>>      - If the thread has a robust list, and its list_op_pending points
>>        to the same offset within the backing store mapping, clear the
>>        list_op_pending pointer.
>>
>> The overhead would be added specifically to pthread_mutex_destroy(3),
>> and only for robust mutexes.
> 
> Would we have to do this for pthread_mutex_destroy only, or also for
> pthread_join?  It is defined to exit a thread with mutexes still locked,
> and the pthread_join call could mean that the application can determine
> by its own logic that the backing store can be deallocated.
Let me try to wrap my head around this scenario.

AFAIU, the https://man7.org/linux/man-pages/man3/pthread_join.3.html
NOTES section states the following for pthread_join(3):

        After a successful call to pthread_join(), the caller is
        guaranteed that the target thread has terminated.  The caller may
        then choose to do any clean-up that is required after termination
        of the thread (e.g., freeing memory or other resources that were
        allocated to the target thread).

What is the behavior when a thread exits with a mutex locked ? I would
expect that this mutex stays locked and the pthread_join(3) caller gets
to release that mutex and eventually calls pthread_mutex_destroy(3) if
the application logic allows it.

But it looks like you are implying that the pthread_mutex_destroy(3) is
somehow implicit to pthread_join, and I really don't understand that
part. Am I missing something ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

