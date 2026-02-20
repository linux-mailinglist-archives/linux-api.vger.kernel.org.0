Return-Path: <linux-api+bounces-5871-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e7BJBxnjmGnINwMAu9opvQ
	(envelope-from <linux-api+bounces-5871-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 23:41:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6292516B46D
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 23:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C01143004236
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 22:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36213115B1;
	Fri, 20 Feb 2026 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JMdJDzGr"
X-Original-To: linux-api@vger.kernel.org
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022130.outbound.protection.outlook.com [40.107.193.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE5C310784;
	Fri, 20 Feb 2026 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627285; cv=fail; b=X9v/O1RqbKuGlJ1GaFmSUmyoJXc+SdKWUlMzkl7UAJKTdg53dslEuhVjv+0LZ1wZtfh+rL5BMjwUT/m4hmGTxfJ2mhQuyhee3xzjx3HJckQDThbs/cWuXu+U+WSkgbCYrGRPNgn2tyfbHIMfTlnZyFnZ0qYxohMHqAowclX/oyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627285; c=relaxed/simple;
	bh=u5m3YGJ3GcXBJXsknUutUy2x5I70TdgDqm8YAYqLQpg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O78gjrbyJi4A7QepRbSeGCopbHaBgI5wfJvalRCNoKaVzTlTiYorZ47fz5wKF48l7emKiGdCJeZla47vHrPNHeEQF2lB9B93kg7ZiX3Nw0r0fChyr6NKtiAGHTrFVbwfXmHvi/Og2lIz9Gpnexnnfg9x0Qf0W881S2wQ1JJwjJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JMdJDzGr; arc=fail smtp.client-ip=40.107.193.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajNxTNVstuOnlCxA09T3RSLItRE+vr32Mt2oKAX6Bw/khCbrWjeUA0s2oHHzqJzEaj6Wy0VWNY17PT6VzWn2YnOqsooPJKX1hvDyZrgZCWgMxUMwyZ6LIkRNla2XMNPkiMDRmQ17H/pF9MZqheO5itofler2LHmxL0iaffA7zNEXIf/ARn4r0VWJmYjhxEWKlRwlvxV5jGQUB/u+wzeyyNsszvWfnRNgfj2GkMn7tsz9Rt4iDsEqOrfk0ybpM/bM0Ck9bxo3KKrJ78EBkbEx+RTgk2nqdO3jT2wfK99PvJhYyZ8IcHwuESApK10JTWqPTbqOClYRmzNfwFp9/IwwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lx7Hpv2Sy0ipOQDTAp6ODAQkSCISG1LNCBE3d7kba2o=;
 b=NwxvQDlvvapXHBdv94gG717425/kYH4DLk4ueHFQEDT/Lcw1I3QNi7Ba6FJWvhQUEW20ZaUovcwKyzH+Ndz73KbaLFeyU/QJlol3jQilZLtFHQIOwruBeaxgQvsy7WrHg6+onQEjSEkE91PxB8ie2roiJi7a/2MQe+1J7bcsZzj0Upd1i6fvUyq7HYftz7QgL2jerXneJQ1dFQ/aTWASOU/iivDEpOQrQrrQwuvdY7+IYfWTnEf5bGUx/agqb3+JyBCVhf8oX4yJgUiYGFs7J660nCM4QhL81ghlkvplG1RLkvD7gpUEAOh80VhyNHBxathB2d19bN66KONrGg04jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx7Hpv2Sy0ipOQDTAp6ODAQkSCISG1LNCBE3d7kba2o=;
 b=JMdJDzGriFzebNXH3QaYIjurQExoFCkVq6VxPlYff8j4U8klwr7w2st4feG3eAIlAL3WVtIoaz0JC5QoIuDAZic6no36n4gi3Wfk4IDDc5Tn0SDb8g9CsIDNy2Wpa3OVVOFapSf4BVL/kY3UV7466lnpAsFAJMQTwTFTDXOiAgBMZXQaGgGaRm/YppFzbhET3gMUbmzVfnITxNP5u+JxiWcTEOH3IFyMc1QR7hZ6Hs/x/jeI9XXJA60mz2Lfb4w7CFHZCMrzLSskMGgZRj0PvtRfujVP1hgvo93PEAHs5gorF/LL5dYuMgNWyL7ZVKv6Hj8vX32bqXlSorsCEUC4Iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8355.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 22:41:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 22:41:18 +0000
Message-ID: <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
Date: Fri, 20 Feb 2026 17:41:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Carlos O'Donell <carlos@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>
Cc: kernel-dev@igalia.com, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
Content-Language: en-US
In-Reply-To: <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0308.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: edcabdd6-5636-4f05-3b5f-08de70d129fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjlXNmtLSlFBUm4vTCsyRWt5d2liWVA1RHNoWjZtS1V2Qkx4WnlnWGpQOFVs?=
 =?utf-8?B?QjBpMXA1cXZHaFpIMEVKNGpPVkZYcElVNTkxZDNTeXJJb0RXbjFUYytvbEFx?=
 =?utf-8?B?SkM4aGNhYzJyWGNHTGlXSWIzSXpYZzgyYlNNNklpZUZOVXZ3MzEvMmZvMllB?=
 =?utf-8?B?TXd0bkdXeWxoMDZOeUVRVzQ0VFpUVnE2STRBeXpNcDArZ0QyeE85eHdiTGJI?=
 =?utf-8?B?YUx1eS9XNk53RWNvcFRuOFhPam1qTlRCb0Evd1Z0ckZLZTlLTytac09sTG9Y?=
 =?utf-8?B?WXRtdTNuMDJxaC9yaHJjUXhxbUJuSjZDbGw4bGcwRWVDSzI3cUYyakhlL3B5?=
 =?utf-8?B?NnlkUUFYNEc1SUhLRSt3VW94bExDcnV0U0hycm1Id25MUE91UEprNWhzYUpX?=
 =?utf-8?B?K0ZHRlA4Y2Q5eTJnRUo0WUNxNzNYL0dnbDl2YXZ0bm8zUjU4Znl5RmFZampS?=
 =?utf-8?B?NU9FM2VPaVl3bzlCR3loQjBGU2NpMUU5aUFoZXNXVEVaNnI0d0FCMGFRV21X?=
 =?utf-8?B?MXJkVm1LaURxUzRxek1mU2RScHJxS01Bb0pyV1VKeEtZS1NFcEhRenBFMDF0?=
 =?utf-8?B?NzhGWHNTbTdWL2VHVE8zWlFiREJDeDliVDZnSFl0NEFsYVdBTXQvbi95VTRy?=
 =?utf-8?B?NXc1bFpLbkIxUGRmYkh2SkFQVGpyVFBhTnFpTENoUWJuN1h4Y1hZUjBkZG8w?=
 =?utf-8?B?UTYwT2poazRrN0E4VGk3K0lkdU0rU2g1SGNJVk5VUUtoV1p3QThVS21jc3gw?=
 =?utf-8?B?YWRYVEhRZFFJMENVVEp1UWhVVzVOL05vNEJNVXpHMmtWMzZyQ1c0aXVNSW1P?=
 =?utf-8?B?b25IN2xabXdiMkNVeFBFN0ljVkliaEFhU2JuVUpGTkRoVGIzS0JhWm5uRlJl?=
 =?utf-8?B?WlpJSUUrbjg5WmFqTFJJUHBCMHBsdmluV1FITU1QQTQzeEZwUmRSYnBJaDRH?=
 =?utf-8?B?OVFxZWJjMzd4MXFQYnVGMSt5eFQyVThaT0Zib3l1K3c3WXF4UTJxNWRBUnc0?=
 =?utf-8?B?SXFUY2cyZWRWNWMvc0xvZ3QyaG1URDRBU1dHWDU1SW1JbTJ1Mnl0aGlLU2Vs?=
 =?utf-8?B?Vm51UktFeEFrMTRvMmZkcEJOMDFCVk5SU0JLSGV2UTg0cnZvZkZ5UytXR1Zj?=
 =?utf-8?B?dE1Ecm4xWGJ2Qjk2aU9VMUFhdytxYWJQT1ljZ2pqRy8zSXZqYUpEdWRkbGlK?=
 =?utf-8?B?NC9SU0daUmxUbDI2RWd3WC9pV3AxdEZUSkdFNTJ0RlUzYUxMYlFocDgvS2xO?=
 =?utf-8?B?L1JmSmYva2RvK1EwRmduZXdNRklIN3diWTB2VVBDdnlydzFkWDBQU1VGV2NZ?=
 =?utf-8?B?NU9mcmZEa21nK1dBbEE4V2lxUzkySC9Hem5CeUYwN2NJU2hRMFdWM2dxWVUz?=
 =?utf-8?B?NlNZOXdxOXlBbExIbFpVQkdnZWxPWm9BZDNoc2YvdGNUcGtSTzZtcTdDMkpk?=
 =?utf-8?B?TERmc2hoR1QwbERDQ3hUU1Z2ZUtRYkxkVnlqWlg5aHIxSUEva3NNazNHR255?=
 =?utf-8?B?Ly8vVU90Nmw3RTdwTFdMSFppWHV0cmZiVllIUVUyekE1ZUFlSjVFMkVhRU9D?=
 =?utf-8?B?eXBlTHRZRTl3MjFOQkVrY1RoSm1VYU9wNXlrUjBLN01oZlJrdDZuQjRFRkJz?=
 =?utf-8?B?ZVIwbjdOQWYwSDBEdUFSUEw4ZFgxTUxmc2NrcVZLaGhpRkZESGdTY2dCbFpO?=
 =?utf-8?B?SExKM3FvTFg2RW96Tk4zVWx2cWl4cWg5Z01MOGVGSCtVWjNSa0JrYXdxaTR5?=
 =?utf-8?B?dWloY3NsbW5tbWJPa1pFYWt0WFhHbERyZjc4WTduenNZNCtwaUhJTWhhc1Qv?=
 =?utf-8?B?V081eEFvZDYzQ1BRamZGTmFraE00Zkp1ZGh4bURiR3ZobkNsdkRMWkFpa3dk?=
 =?utf-8?B?U2g3YkZwRTJDeUdYQVExbjhyYyt3QlQzR2J2UWl4K1NnZytIZFd1VkVDcElH?=
 =?utf-8?B?aEpEZkVRSWxUZFVlU1JTdlJ2M3A4bTRmVUV3dTZLdFBOQkgwNzdJTU5oblBN?=
 =?utf-8?B?SGlYcHlLYVpOWUlJUUJweEVxSG9MVGljVlVKNXU3blJZQWhwSXFIejBucFg5?=
 =?utf-8?B?OG5pTk50aTZINXRzbHh2OWlOS0NVT1MvNWp1bVJLTndyMGVkY08yckZvdkU3?=
 =?utf-8?Q?lim8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHk1aFZIMytyQy9XTHhvenlwK0ViMmI5aG5CMS90Zmdpb3JMZkxkOCtYVDIz?=
 =?utf-8?B?dFN5YUx5M3l3L2hiQWRTaWVVMjhWU3ZpSzN2YlhYOWxEc2xaNVNIWnNFZkRH?=
 =?utf-8?B?d0kwckE3N0xISm9zaXdkd2xPWVQ5SHRJNEJQd0dYUkFpR2JzR3ZWUEpXVllr?=
 =?utf-8?B?QlIzMHRWODg0ckpKTlBaRHFVZ20yZ0dWZTBadUlkSnhSUXNSQ0Q5QlJRK0Js?=
 =?utf-8?B?aEFrbUxIR2ZzenlwM3VBRldCYVpMVFV2U1hBbTg5RXpEdmdqUDdQUEJwTG5Y?=
 =?utf-8?B?L1lNMFMveGtlS3NUanhUcE1rTmZOSDdOajRGQmpaMW5EbFNjRVZJVXRnOUx3?=
 =?utf-8?B?WTNHT3B4VUlTM1FkNHVOdEUzVHJpZ3J5UkJvV2xpL0FMNm0xeXVKT3ZBN0FY?=
 =?utf-8?B?ZEVYdnJUcm00KzM0ODU5aEc5TDkwN3lwZEhWYWFBRU5sbzV3djgrNVArVy9h?=
 =?utf-8?B?SnpqblpZK3lQUCtIaXVjaE9GbkVrczgzK3NidzNMQmRQcVlUMmdMMUFkeWQ3?=
 =?utf-8?B?Um5kYmhaZ2Y3aHhCSEovZzhFQk9oK0llUFZuL1d4d2tmYlgrbmZPQUJtZU5L?=
 =?utf-8?B?NW9vM0FSSXIwbHJwNXZQQXRwdGFQeURoT1VIWUtFZllrOEdZVFBkeG9oNDlH?=
 =?utf-8?B?Unc2VUU2c3BPRnJsR1l5amNtZUJaTC8vS29DU1p1V3dyUXNBMlZ6em0zTVM0?=
 =?utf-8?B?REJuNG45SUlMMlp3Vktjek54d3ZDZzk1WUw2NXZrTTBqSDlkVGd1TG1URmVQ?=
 =?utf-8?B?Q3hxdDVxU3ZZN3JxMjhML0wvY2lEa0tHOTZCQ0FYbFNGNGkvM3ZJSWFRWG5P?=
 =?utf-8?B?Q3FOYlYrZCttT1V0OEc0V1Y4cXV1N0xmYTlISTdVR0l1WWI3ZkowMVNSRitD?=
 =?utf-8?B?aFBtZUNmUGJ0bkNBT3JzVzJVN3p6L2xycVdDK3JhZzdmamloYVFFanV1dGR2?=
 =?utf-8?B?MTgzVUtUYld4Y3daVjFaTEZxazdUb2VPTFVGS0xNZHRvOHVrT05YeUV2bnFI?=
 =?utf-8?B?ZUNyem5sVW1PLzNWRDk0VUFNdWRWdS9JcTJqMXRscjA5QnJUU21HcUZkd05a?=
 =?utf-8?B?a1BTaWhNZkhaTDVpaEJVUnFlbFNvYWY4UzZ6N3BuM0w1bUVUYXdlSVFRMkhT?=
 =?utf-8?B?STF6c1c1RWg2cHl0OHphcGZuaWdOcWtYTWdmREhoakRYM05uUGd2bWRKOWQr?=
 =?utf-8?B?UkxWNnUzeFlCZWxqSzBtUmVrakx0bU9zUDZFK2FRRkZQRnVsNit2bG16dFNH?=
 =?utf-8?B?M2ozeXRTVjJzY0V0M0lYRXNNQzZiU1pWaWlVSE1sNkxCYmx1a21KdllsK2k4?=
 =?utf-8?B?NEc4eENVK3hJQUVrNTFzZEd1L0txUjU1WVVxaEpXMC9oWDgvckFEVmo2dCs1?=
 =?utf-8?B?S0VMK2FKY0dhZk5QUk9hM0JKbkFpOEI2ZnZQbVVoaHdnVzI0Zi9qcE5DdzR4?=
 =?utf-8?B?Yldud280TG8yVUJHN0Vqem1jWEwzcjIvSkZiUGNkQVpyNFdmT3p4dDdJWHhD?=
 =?utf-8?B?aWJxT1FEUkk2eGdISm0xU0F2RWVqMm84QnZZUHFlemNrM1owYWtWWHZ6OFNu?=
 =?utf-8?B?cEZtVXpNTWtuQktORWxLVllYQm50R0pUZDlMNWZDZnhWWlJDVjJPSnZyR1FP?=
 =?utf-8?B?QzRQaHY0bWlFcTJnNmkzOWtkN2RaRE5ybER4a1ZTbWh5YlBzZ0ZsWGQ5V0tY?=
 =?utf-8?B?VzV6REIvTnBJNkxtOGpxQmRsa05YK1RVWWMrekM0L0F5ZVhBdHN1SUR4YUxs?=
 =?utf-8?B?K2pTUVpoOVNmZzhOSEo3N0lMWTNuYmxGbm90WDFSZVcwWWxTNytLVHo2S0ND?=
 =?utf-8?B?TWlUeCt6bVcrUmVVVGUwekw0VW5qZXNQRkdyQkZaNTRUMDN4RlZXRk5PNkk1?=
 =?utf-8?B?TWJoay9zZHdpejZLczZJUis1WDRLTjd6dVA5bmNVMThFcDU0RU5ab3JISTgx?=
 =?utf-8?B?c1kxOHJnSEwrR3ZUaFJVTWFYbktiaHNRTHJLZmRkc0dENGc2Qm1BYmxacE9C?=
 =?utf-8?B?ci9uUzFTa1F6OUVva1pnOEZOQ3dKc05MaUdadTNGVE40ZU8ramFLcU9NVjFy?=
 =?utf-8?B?aVNMUHdjYUNWeGh3Zlovd3c1eWMzdFdtaWhkRDF1NHZLQlljczk0dGhmemxG?=
 =?utf-8?B?NG9DN2lFMnZhdUtIVGN0YzVPUVFSQjljUVROMHM3QkZQMnRWbmx5b1djZ0Mz?=
 =?utf-8?B?WkNGWloyaDJ6dm9ScnJ1T3NUY3dUZ0ppUDIyaUs2ZGt1OHJlbGp2RXNBbU9B?=
 =?utf-8?B?UVhEenlXaXp1bWpVclpxbGpySXlwL1k3SktuakkrNEFJUmd6S1ExSm03RE9M?=
 =?utf-8?B?aHk0MndQQUVIRkxJRlFhb0tIQ3o3MHZjTE1zMEhYSkY0UXZBTUtjNlp4WWd5?=
 =?utf-8?Q?LThOyY1CG1OXYsiw=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcabdd6-5636-4f05-3b5f-08de70d129fa
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 22:41:18.9169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sHDpYxZzGuaszc8RtWYPSk7cTOkxuai6+MqTGOrPeXqTOqa0bpljWAD+pr2hdqMb7dIXEX0shepzPU04zp/NqQSHjeP9zHLQQ2q4CrAh3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8355
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5871-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sourceware.org:url,lpc.events:url,igalia.com:email]
X-Rspamd-Queue-Id: 6292516B46D
X-Rspamd-Action: no action

On 2026-02-20 16:42, Mathieu Desnoyers wrote:
> +CC libc-alpha.
> 
> On 2026-02-20 15:26, André Almeida wrote:
>> During LPC 2025, I presented a session about creating a new syscall for
>> robust_list[0][1]. However, most of the session discussion wasn't much 
>> related
>> to the new syscall itself, but much more related to an old bug that 
>> exists in
>> the current robust_list mechanism.
>>
>> Since at least 2012, there's an open bug reporting a race condition, as
>> Carlos O'Donell pointed out:
>>
>>    "File corruption race condition in robust mutex unlocking"
>>    https://sourceware.org/bugzilla/show_bug.cgi?id=14485
>>
>> To help understand the bug, I've created a reproducer (patch 1/2) and a
>> companion kernel hack (patch 2/2) that helps to make the race condition
>> more likely. When the bug happens, the reproducer shows a message
>> comparing the original memory with the corrupted one:
>>
>>    "Memory was corrupted by the kernel: 8001fe8d8001fe8d vs 
>> 8001fe8dc0000000"
>>
>> I'm not sure yet what would be the appropriated approach to fix it, so I
>> decided to reach the community before moving forward in some direction.
>> One suggestion from Peter[2] resolves around serializing the mmap() 
>> and the
>> robust list exit path, which might cause overheads for the common case,
>> where list_op_pending is empty.
>>
>> However, giving that there's a new interface being prepared, this could
>> also give the opportunity to rethink how list_op_pending works, and get
>> rid of the race condition by design.
>>
>> Feedback is very much welcome.
> 
> Looking at this bug, one thing I'm starting to consider is that it
> appears to be an issue inherent to lack of synchronization between
> pthread_mutex_destroy(3) and the per-thread list_op_pending fields
> and not so much a kernel issue.
> 
> Here is why I think the issue is purely userspace:
> 
> Let's suppose we have a shared memory area across Processes 1 and 
> Process 2,
> which internally have its own custom memory allocator in userspace to
> allocate/free space within that shared memory.
> 
> Process 1, Thread A stumbles through the scenario highlighted by this 
> bug, and
> basically gets preempted at this FIXME in libc 
> __pthread_mutex_unlock_full():
> 
>        if (__glibc_unlikely ((atomic_exchange_release (&mutex- 
>  >__data.__lock, 0)
>                               & FUTEX_WAITERS) != 0))
>          futex_wake ((unsigned int *) &mutex->__data.__lock, 1, private);
> 
>        /* We must clear op_pending after we release the mutex.
>           FIXME However, this violates the mutex destruction requirements
>           because another thread could acquire the mutex, destroy it, and
>           reuse the memory for something else; then, if this thread 
> crashes,
>           and the memory happens to have a value equal to the TID, the 
> kernel
>           will believe it is still related to the mutex (which has been
>           destroyed already) and will modify some other random object.  */
>        __asm ("" ::: "memory");
>        THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
> 
> Then Process 1, Thread B runs, grabs the lock, releases it, and based on
> program state it knows it can pthread_mutex_destroy() this lock, free its
> associated memory through the custom shared memory allocator, and allocate
> it for other purposes. Then we get to the point where Process 1 is
> killed, and where the robust futex kernel code corrupts data in shared
> memory because of the dangling list_op_pending pointer.
> 
> That shared memory data is still observable by Process B, which will get a
> corrupted state.
> 
> Notice how this all happens without any munmap(2)/mmap(2) in the sequence ?
> This is why I think this is purely a userspace issue rather than an issue
> we can solve by adding extra synchronization in the kernel.
> 
> The one point we have in that sequence where I think we can add 
> synchronization
> is pthread_mutex_destroy(3) in libc. One possible "big hammer" solution 
> would be
> to make pthread_mutex_destroy iterate on all other threads list_op_pending
> and busy-wait if it finds that the mutex address is in use. It would of 
> course
> only have to do that for robust futexes.
> 
> If that big hammer solution is not fast enough for many-threaded use-cases,
> then we can think of other approaches such as adding a reference counter
> in the mutex structure, or introducing hazard pointers in userspace to 
> reduce
> synchronization iteration from nr_threads to nr_cpus (or even down to max
> rseq mm_cid).

To make matters even worse, the pthread_mutex_destroy(3) and reallocation
could happen from Process 2 rather than Process 1. So iterating on a
threads from Process 1 is not sufficient. We'd need to synchronize
pthread_mutex_destroy on something within the mutex structure which is
observable from all processes using the lock, for instance a reference count.

Thanks,

Mathieu

> 
> Thoughts ?
> 
> Thanks,
> 
> Mathieu
> 
>>
>> Thanks!
>>     André
>>
>> [0] https://lore.kernel.org/lkml/20251122-tonyk-robust_futex- 
>> v6-0-05fea005a0fd@igalia.com/
>> [1] https://lpc.events/event/19/contributions/2108/
>> [2] https://lore.kernel.org/ 
>> lkml/20241219171344.GA26279@noisy.programming.kicks-ass.net/
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

