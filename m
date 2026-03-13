Return-Path: <linux-api+bounces-5953-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH1INAsvtGkEigAAu9opvQ
	(envelope-from <linux-api+bounces-5953-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:36:43 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8DA28620D
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125AE3076D8F
	for <lists+linux-api@lfdr.de>; Fri, 13 Mar 2026 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8BE39FCCD;
	Fri, 13 Mar 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hq4a1xrB"
X-Original-To: linux-api@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020142.outbound.protection.outlook.com [52.101.191.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C86336882;
	Fri, 13 Mar 2026 15:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415170; cv=fail; b=XIwOsxctcO8DW0chM7Xssqe3gO2DoM+zh3Y1v+RdApa87EHaSBJU8SI2HfNo9GIr/9SzRXFGpf3CktqJ8//8oF0OIau35JMUTQRpxZwohZIWCQBiw+7g5S1E2loZFAu51eymhwtjODRakYd8rfRCtyhCd4tVs1mmxDnM9hunz3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415170; c=relaxed/simple;
	bh=+dAGZJsJ+VM5Y530+IML112bqkyRlWFZDeIKCEE8cLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SHHDy6/eUX8hKN3PKJa84CqT9167KD/mrM+9dSH0QRvuDvVjc0lRF6AGds4XuNJFJifg9gYw8xEWpRlwrMDJA1oQHzRX6BPfngUkl4z1/WOalwIFGbPcFxKluqerwtVbgsHjLW1pTszKePPHwOmEhqxHumunHuu4FzqqEI7moUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=hq4a1xrB; arc=fail smtp.client-ip=52.101.191.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvKaJM8uq7YSqyFpF/P8LMx27uSBsJ3EVzfxTvdkwZdiEWDygPhqmDfzGZNP8lJLtn7xkdlwPIQ5GbyXZkRGSXf1LbslJzFCm0JBIPfp3YmZL/LScNX+KXLfA9kV7P0QRLdvHSw2NLBW41laobsV/dSvKLKi+MQcpa05WBc1j2NYDoAXbBCdfLEMspVbqF5G/70/l/yQPykcGsKxXHFEiHBItZXIm7n6/D32ecLVO1jFSgjywvCZFbwe50Vs4wHQvY1sq+cdk2LzTi451DIYds2PTjL8cBaDbdNenF2ahSuJqneu+6PrIcoPs3cK65OrKNcra/75empyCkwIiAlN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNYvV2zNYrAlqg8brlj+ZWkTy7QofiCPUkbQ28yQXoA=;
 b=WewVBkjzCpWvwfTJypAPKEMI8LSNZm0sUBnU4E47h2nGF0jg653Ny8WjGv7T4qpBNH9F1Cj9e9IUEjHw8khXdNV7dkSivJRu4dg1xXw9M/2z6HwUW8fHR/bgqGSPS8RuPWOwetm+MjDFovKkU31jZnqkiT+AOApvbALf/bqJNu7zUOVg2eshxAWwi48yDGvQviPxwiifvceNBJjEJrUZhY6Tyq9OicbfJPYdkKh+omjkksdR5u/6uy1kBvI1PMbRyHCCnRhNJtBNKPvB5oTZ5l5k2ABvqE/X2Ks2Z/fJ9PKnSb/C42qezVQjBuHRuWkqGbRT5B2xbnS68j4V6VKVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNYvV2zNYrAlqg8brlj+ZWkTy7QofiCPUkbQ28yQXoA=;
 b=hq4a1xrBduTMJXhM6C39a3EZjMyJaNjlyHgnCKMtJ8Ug+bJ1YQCB/dBrTiVl2k1isvIn6bqYo4GTSKVkIYYB8/R28AbzjROfiaq+ZjjNYUmET9jXskNzuSIk51Ik3UgjX6cFQ2NRzhZKmOvNHCLL2oBRHRIZ3W5be5ukKaJtkzomlmE3F56g8WrDTlJ9jEwMI4wxl2aTWuTFrWPVPYs1r3NlX5lw0DuGSsWHoD3e6cLBuoh5V0BxSdhaQvBA2EsP08DVlhJhhkGbkrYdjITxuarENFw0E4BZQTllQjBywntxs8ohCMCbOPExnVg5Nffs5yTme5nMBKgbXE43mS3PmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 15:19:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9700.017; Fri, 13 Mar 2026
 15:19:18 +0000
Message-ID: <29d24bd3-530d-429b-ae27-4c5f6e5723e1@efficios.com>
Date: Fri, 13 Mar 2026 11:19:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4] futex: Introduce __vdso_robust_futex_unlock and
 __vdso_robust_pi_futex_try_unlock
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 linux-kernel@vger.kernel.org, Carlos O'Donell <carlos@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-api@vger.kernel.org
References: <20260313133903.2202079-1-mathieu.desnoyers@efficios.com>
 <20260313150111-64c38feb-825d-433e-9c71-f4f109b8cbfb@linutronix.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260313150111-64c38feb-825d-433e-9c71-f4f109b8cbfb@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::9) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b88235-d836-408a-a9d7-08de8113e53e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9xhmOhsq+jnnrnHZDGuqhLMVbbSgSgclXXY3tWizpjK6fpNHK663m1amW0bcP7gAQ0hKkSSzf9Gl/PvLok6WtoEYhn4nljJ4KtQmLE327LDTnF2rEcccric02OMirrzCAlCOR3EbKHhH7lhKFZ7F/JhYoxNUR97mpbS6pL1b7JR6vEcbOBAcl7St4aynzE1vIx1q26meDLhZH9bwuqEfh6sMUGKjX7nOihk/eCXPhYNuPHUU3jfeUEnhhKl5ukiQWYUmmI20Hn3SQAbUXpqON0m6emXoH9Ts1lwo9NmOhtGSvxJwisRGQOW5X+SQqu54BnlnUfVgOnRlIpJnGhJUD8FwB3rKLlxzAVCPlyFb9oiIWO1gW7qjhSz3/ztn9JR68kbw+3t83BmolmT0Bh2HmBZwNgMSWVV4LJwB0BrkejplDCjze/CBXkzhbMeX11m1XK3nbjDsOn4i/+c5ZAnWmemh7K7spmCMSjhIxDs5Oh4EMy8EGj4IcpunnSeklPW40KNbU0lWZ9CoYXBIgNkJ+a6hw2Z3fadtP2xHFA6jRKNEm70Vbks6ptiFA+qXP0Es0unzspeIbHglIlRyMsGBg1iT95bZb8QxnRC0y+fmiblagKz0MjGECT7wF+RbTfG1mfT9gdpfPo1I0yHEQpdtdqP4IGeYJ5cNHlPa+Osf2gOYu7jOx3OV+762PyQvD+2m
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjBkeGZkc09vZGN6ZEhpTEwwejU0R29KK01WWnRQYjNMZU8zRGFzL3M2ZDlr?=
 =?utf-8?B?b3pGemkrUFQyRmpyUi9KNk1STHJQQTU2OVBubC9XdGkzMExPRUlsbDRrSitz?=
 =?utf-8?B?VTBpUlZwejB6Zm1EZmNDUElEK1NNSm5iZXZSNmNaeWhmcUZoVzVoU28xdjdn?=
 =?utf-8?B?MGpBMGhud3VXM3E5dmhnNFMyMlBDR1NQNUwwelZXZ2Myb3B6SkxMRlduaEZs?=
 =?utf-8?B?ZElnVWtMeVlLWGxnRkI3eWdGUEVRUjhYbE5LZW5NYXVGWG1lOW9QZnRkSUFM?=
 =?utf-8?B?T2NFazFFTWNHTDlKa3lmOU1XakdXNngvTUpoOXV5OUhqaXZhaDNONkhXL3gy?=
 =?utf-8?B?aHRqTXMrdmtxYi9sZXp5WThvWE1aNW1KN0EvMjhEc09EL3ZaL3B3aHUwT2Jl?=
 =?utf-8?B?eTdYREpVVzRMYUx3WVdaMDgwMSt4MXNRY3ZvQUNSejdkTlJuUnNNZ3lNcU8r?=
 =?utf-8?B?c0xPc1VMaCtVemwvdFpjUTAxMjBZY3cweW9CNU96dXhPOGFsWGVaK0FHSDRn?=
 =?utf-8?B?SlRoOEdUVjZadEsremord2EzbFFUbzd0RWxFc285R3ZNWU1hdFFQeUhsWHBq?=
 =?utf-8?B?Y2wrWlhnNUxGM2Z1dWYwQ1FNcjl3di83d2VkZHltT0JKR25KQTc2S0ExQ1VO?=
 =?utf-8?B?dE9KcU95NDBXRHNCN1U1VjRkUUFvTlpLaFAwWE1LVXJEUXQzU2dwcHIxVjZi?=
 =?utf-8?B?STlBTjdKczJ2ZEJmaWd1cmNWSDBnODNMQXJ0V1gvMnBLbUpkZFlpTmlxdVFm?=
 =?utf-8?B?STlvOHpiaXM5b21IZTJ3MGQ3OHMrUXFqeVZLSGdSbzRPaDVHSzFScGcxR082?=
 =?utf-8?B?SEhuU1RFa21NcmU4cWprQ0kxMC8xTCtncmpsY3U4b0lBNG9oVUNIblJleW9X?=
 =?utf-8?B?eGJNVnhEaWFqNzhXdVlwaXVvYmJCUTR0SWNjK0NmOE94bFArVlNwTUFDMHFn?=
 =?utf-8?B?M0hRZ043R0ZwZ2hrcEsxZ212RlZ0TElFa3k4ZzNvbml5ZDBRQnJJcFNZTEtl?=
 =?utf-8?B?eWhFSHp4bFVLQzBrSGVNR0d0VGNCMXczenYyRkNCZmRXT3YvZ2NsNG01N0p3?=
 =?utf-8?B?LytqeVFKSEZERjUrY3NLZDUrbE9uSmtHS1gyd0JTK0JBK29rQk1ucm0xdWZZ?=
 =?utf-8?B?enJmNzlFNy9NdkxjQ2F6ZlVEQytheWQxd2pGVkJzajIrNFhIdGcreTg5bFRV?=
 =?utf-8?B?QU5kRjhIaGVlUHFINGFsMllZK2JSbjlNNEZadXBLODlXWnFYclViVHk3cytR?=
 =?utf-8?B?eHJjS0FLMCtkeS9GRWNzYkNqdjdtVXMrelJUVkdVeTljdDUxSWo0djlxdG9G?=
 =?utf-8?B?TktTbi91RzJCalVzSkNUN3lETUtabW4rc0l5QXd6aGoyeUpTUzhWem4yS2J1?=
 =?utf-8?B?MXk5YVBVdjR6cjRLbm52Y1kyemkrOElCZ0pjSW4yNVVpdFZreXZ4d1ZBbzJy?=
 =?utf-8?B?RFo2VEF6UmlYeXFPV05haXArN0R1ejc1QjQvczhTbEJpeGdSY2liazFIQ0Jx?=
 =?utf-8?B?Tmh2WlNzL0d1di80VTBUa09CaFZRRnhZRmRvK2c1b3QxQ3pPYXdyNHZ5cHEw?=
 =?utf-8?B?NXRtY0FraDNQV3pUa0lBdjRvVkZXL21HSXFoL0R3ZXNjaWdUSEk3czZNM3Y4?=
 =?utf-8?B?Ri9nZ1MwK1IzT2hQVkhyZG5zMTJVckJJMy9WVVBteXZUZ3ZlalBWNng2TUhh?=
 =?utf-8?B?ME5SeTNROWJ1cm5NK0pDdmNxeWJMNUR4Vmp3TFh6S01JMWJvMVo4SjFxV29y?=
 =?utf-8?B?VFNTbHd4NWVRZnZ6VW1nSlZmazJIMmEwYWVHSVd6NzREWWxMMlRnV3VyMlBK?=
 =?utf-8?B?ck5GTkY0aDhFNHQrcG5jQTl0UHR6MHZUcnRNbTlZSFJSWkM4c0N6cElzM2h0?=
 =?utf-8?B?M2x4Z2FPZFJtTS8zUmFxbVV4MVpTcFdkdVVKQ1ZJeTVHZ0dKWFRJKzRPME5S?=
 =?utf-8?B?OVlOV1FLRy9XTHloVU9iNVUzdkpMOEs3UHliVXlEb0pPWVNJVnNadWkxWTBh?=
 =?utf-8?B?aTFIMEUzZldwTHo2NXFxemw1dnVPR0p4VGlvcEwyTFZQamFtOXBZZjdxVFMz?=
 =?utf-8?B?N0JNV2N1Z2VvZEsrQTB3L3NxN3d5dktrbjZVaFpxMGxaOElaVS81ZnZnM2V5?=
 =?utf-8?B?QUVONkZITTcxWTN6RWMrbjcyT3NHTGpoL1l3YmthZFNzRGxmZ0VvZmRXeUxs?=
 =?utf-8?B?VXJ4R2JWWkFZOXlWQnROa0pPR09UbDBRU00wNElnc2FocHA0YU1ZRnMxY2pi?=
 =?utf-8?B?bWdMWE1BLzFiZnlzUmltS043WW1pWUVMaEkvMHV5QXJDRVBpaGM4NnlqVmxH?=
 =?utf-8?B?a2ZGUG1LSG5sZ1phc2hNODl1L1MxMGI0dW9lNjhIZmp3TWtCbW15ZEVQKzNG?=
 =?utf-8?Q?ACIjBI+6Pg2w5n2Y=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b88235-d836-408a-a9d7-08de8113e53e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 15:19:18.5675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkSpZbsrosWbfrxeevqrrxfxC0PuNYeMauqOsUZ/g/nqPPv3YMexHO1aQ5JKu4YHzODPgR8zkWUTjumnjrhj1pDu+/ShaVkRxaFV+0MHQck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6084
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5953-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,checkpatch.pl:url]
X-Rspamd-Queue-Id: CB8DA28620D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-13 10:24, Thomas Weißschuh wrote:
> Hi Mathieu,
> 
> some small remarks around the vDSO code.
> 
> On Fri, Mar 13, 2026 at 09:39:03AM -0400, Mathieu Desnoyers wrote:
> 
> (...)
> 
>> The approach taken to fix this is to introduce two vDSO and extend the
>> x86 vDSO exception table to track the relevant ip ranges: one for non-PI
>> robust futexes, and one for PI robust futexes.
> 
> One of the central points behind the vDSO so far was that it is only a
> performance optimization. It is never required for correctness.
> What are applications supposed to do when the vDSO is disabled?

Good point!

For non-PI futexes, we'd need to introduce a new robust_futex_unlock
system call to handle the scenario where vDSO is unavailable. This
system call would perform the equivalent of what is done within the
vDSO, but from within the kernel. This comes with a significant
performance overhead, as this would be called on _every_ robust
futex unlock.

For PI futexes, applications could either directly invoke the
futex_unlock_pi system call when the vDSO is not available, or
we could provide a new system call which does the equivalent of
the vDSO within the kernel. The advantage of the new system call
is that we would not hit the hb->lock in the uncontended case.
Another alternative is that we tweak the existing futex_unlock_pi
to handle the case where it is called when there are no waiters more
efficiently.

> 
> (...)
> 
>> diff --git a/arch/x86/entry/vdso/common/vfutex.c b/arch/x86/entry/vdso/common/vfutex.c
>> new file mode 100644
>> index 000000000000..336095b04952
>> --- /dev/null
>> +++ b/arch/x86/entry/vdso/common/vfutex.c
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> + */
>> +#include <linux/types.h>
>> +#include <linux/futex.h>
> 
> This should be uapi/linux/futex.h. Headers from the linux/ namespace should
> not be used in vDSO code. The definitions from them may end up being wrong
> in the compat vDSO. Either use uapi/ or vdso/ headers. (linux/types.h is a bit
> of an exception for historic reasons, it could be replaced by uapi/linux/types.h)

OK, will fix.

> 
>> +#include <vdso/futex.h>
>> +#include "extable.h"
> 
>> +
>> +#ifdef CONFIG_X86_64
> 
> This only works because of the ugly hacks in fake_32bit_build.h.
> Testing for '#ifdef __x86_64__' is simpler and nicer to read.

OK, will fix.

> 
>> +# define ASM_PTR_BIT_SET	"btsq "
>> +# define ASM_PTR_SET		"movq "
>> +#else
>> +# define ASM_PTR_BIT_SET	"btsl "
>> +# define ASM_PTR_SET		"movl "
>> +#endif
>> +
>> +u32 __vdso_robust_futex_unlock(u32 *uaddr, struct robust_list_head *robust_list_head)
>> +{
>> +	u32 val = 0;
>> +
>> +	/*
>> +	 * Within the ip range identified by the futex exception table,
>> +	 * the register "eax" contains the value loaded by xchg. This is
>> +	 * expected by futex_vdso_exception() to check whether waiters
>> +	 * need to be woken up. This register state is transferred to
>> +	 * bit 1 (NEED_ACTION) of *op_pending_addr before the ip range
>> +	 * ends.
>> +	 */
>> +	asm volatile (
>> +		_ASM_VDSO_EXTABLE_FUTEX_HANDLE(1f, 3f)
>> +		/* Exchange uaddr (store-release). */
>> +		"xchg %[uaddr], %[val]\n\t"
>> +		"1:\n\t"
>> +		/* Test if FUTEX_WAITERS (0x80000000) is set. */
>> +		"test %[val], %[val]\n\t"
>> +		"js 2f\n\t"
>> +		/* Clear *op_pending_addr if there are no waiters. */
>> +		ASM_PTR_SET "$0, %[op_pending_addr]\n\t"
>> +		"jmp 3f\n\t"
>> +		"2:\n\t"
>> +		/* Set bit 1 (NEED_ACTION) in *op_pending_addr. */
>> +		ASM_PTR_BIT_SET "$1, %[op_pending_addr]\n\t"
>> +		"3:\n\t"
>> +		: [val] "+a" (val),
>> +		  [uaddr] "+m" (*uaddr)
>> +		: [op_pending_addr] "m" (robust_list_head->list_op_pending)
>> +		: "memory"
>> +	);
>> +	return val;
>> +}
>> +
>> +u32 robust_futex_unlock(u32 *, struct robust_list_head *)
>> +	__attribute__((weak, alias("__vdso_robust_futex_unlock")));
> 
> __weak and __alias() as per checkpatch.pl.

OK, will fix.

> 
> The entries in the linkerscripts are missing.

Good catch, will fix for:

vdso/vdso64/vdsox32.lds.S
vdso/vdso64/vdso64.lds.S
vdso/vdso32/vdso32.lds.S

> 
> (...)
> 
>> --- /dev/null
>> +++ b/include/vdso/futex.h
>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2026 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> + */
>> +
>> +#ifndef _VDSO_FUTEX_H
>> +#define _VDSO_FUTEX_H
>> +
>> +#include <linux/types.h>
>> +#include <linux/futex.h>
> 
> Same remarks about the linux/ namespace as before.

OK, fixed.

> 
>> +/**
>> + * __vdso_robust_futex_unlock - Architecture-specific vDSO implementation of robust futex unlock.
>> + * @uaddr:		Lock address (points to a 32-bit unsigned integer type).
>> + * @robust_list_head:	The thread-specific robust list that has been registered with set_robust_list.
>> + *
>> + * This vDSO unlocks the robust futex by exchanging the content of
>> + * *@uaddr with 0 with a store-release semantic. If the futex has
>> + * waiters, it sets bit 1 of *@robust_list_head->list_op_pending, else
>> + * it clears *@robust_list_head->list_op_pending. Those operations are
>> + * within a code region known by the kernel, making them safe with
>> + * respect to asynchronous program termination either from thread
>> + * context or from a nested signal handler.
>> + *
>> + * Returns:	The old value present at *@uaddr.
>> + *
>> + * Expected use of this vDSO:
>> + *
>> + * robust_list_head is the thread-specific robust list that has been
>> + * registered with set_robust_list.
>> + *
>> + * if ((__vdso_robust_futex_unlock((u32 *) &mutex->__data.__lock, robust_list_head)
>> + *     & FUTEX_WAITERS) != 0)
>> + *         futex_wake((u32 *) &mutex->__data.__lock, 1, private);
>> + * WRITE_ONCE(robust_list_head->list_op_pending, 0);
>> + */
>> +extern u32 __vdso_robust_futex_unlock(u32 *uaddr, struct robust_list_head *robust_list_head);
> 
> Drop the extern.

OK, fixed.

Thanks,

Mathieu

> 
> (...)
> 
>> +#endif /* _VDSO_FUTEX_H */
> 
> (...)


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

