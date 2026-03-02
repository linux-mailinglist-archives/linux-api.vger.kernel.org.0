Return-Path: <linux-api+bounces-5893-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLniGWu8pWn8FQAAu9opvQ
	(envelope-from <linux-api+bounces-5893-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 17:35:55 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF23C1DCF8F
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 17:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 368763039830
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2026 16:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0462FD7C3;
	Mon,  2 Mar 2026 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oDRQWVct"
X-Original-To: linux-api@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020118.outbound.protection.outlook.com [52.101.189.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3ED13B284;
	Mon,  2 Mar 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469157; cv=fail; b=TmxOj2iLmvRu42V8RZmSBcEVFnCK5D2KaBvPTEcpyXkA1wgX7a1dr3KdjqNVj4/q7bL/vaF5tbZSX8RXpLsAeYe5i+/+pPxvbtItYB14YGkvd4FALbOa+H564PmHRuV02W1ltDPR9gIMcfz3BsfGrI2S8c8B5+GuSl6J/N2tcYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469157; c=relaxed/simple;
	bh=qfcyMCrDPGCQmildpOZhCp/Nnt1DqFXEStVbCU7VR18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W9HoL7zlmk7pED4tJLCdI35Uc8zIpXztkM4DEKSXsf5nHz/Ks4B51cUnCh5+zgNRBPAnkc4wlDYIhtNwcmhZ2ymlZ0ilAP5edxzMBZugZkxugV4Ze9nJYQWGeeUQgvkeRiJYtCVmueJEC7bfGW04gx7C/aiHEvJVgNTnllRkM7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=oDRQWVct; arc=fail smtp.client-ip=52.101.189.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzwAknVeplPE4CnZgf7e8UZRIBJEGDf/9NYFkpUJpcpthJ27JSTIcmsnQTx9P59envt3kOI+OA9KMX0yAoTV8qsolfbWGy6qkgPZpBsgzpWa4i9cGsj0BCtKmJ8StNi5Zb/T6vMHEvFCC0NQlVjeJqigMm9k6YXie08xsZGPG5hT4eZ6POKMagxtHHCBdtImiOgTbepYkQEtCpruckMda3InHWqdP7sm20O0UIwZVrpMCuv1u8kdM3ImDazbGbmy840j2EhcTz2spqAQPyhOL43v/UnsG8qJNkv/cft/4WCkibOXLy7khrOLUMP0oNlVowF5Jtb+Xh2DEmY/ei/FLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32jnKtgTZ8FSy45Kzj45l3mXXILEyjS8jmqPt9ziRUI=;
 b=iwLik42jrNH9ZdRbCE/5sXgzLi2Pvid7TZqLEh1w+XBVBKV6kA1thvBtExUloOCWqshP09nhXTnABOL3AGcnOlkaYunWkVfmO3BJpzkC6bxPO1rOuVGIjgQg5vSqS3vCnVDHtLuoN5yg8sWeUqmDLBMQkWhJMb/8t+4+G0BVJpMm+v6dtJ/vgtghqoY+jPpaPpJ77IPjfTTWGMb2W3u5NjLTKWg4BQ88jstkdEbZwmNoS2kFrpUMPlmvw+QO4FAEs+k9Ppw7ef3pcRSdbbijnqSHv2LSIGs/1ZPluR5N38zqBTqm400A6LtLLxeO4cvK/qf0qXb4Sa1qDmEcpWxvFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32jnKtgTZ8FSy45Kzj45l3mXXILEyjS8jmqPt9ziRUI=;
 b=oDRQWVct9Q8OkCyJUxUm/iovWIE6g8wDb4ie1QTySBefJePphVi9u1ItAddBP5hbt8zNvGQSvIJIksOzWKi080vC/551Pn9QN0TRloMQKpIZ+qZ9MBmnK0QpLR8in3FPT/by7FqU0lL0sjXC49L+jUtIoh0PQGfFKM66siCb9zlipkWGEdcmptolgDivbJqrW8gXSV8wCVlkmB2GUWF9f6PrJBQDclWO4xYjXa5bs+DjFf4HYtWFdwKP4bcJm1mbWUP8+/F4SFe8xJs7PDSItcZ7/QluwaW3LDpUeUZzj84AL1mJMEmqGMR5LDjD0PA1KbAqMwTghB6IP+qfu9wZSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT6PR01MB11199.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 16:32:29 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:32:29 +0000
Message-ID: <3f30f2f0-5173-42e2-aa89-0af9bb391c0e@efficios.com>
Date: Mon, 2 Mar 2026 11:32:26 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
To: Florian Weimer <fweimer@redhat.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 kernel-dev@igalia.com, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-api@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Torvald Riegel <triegel@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rich Felker
 <dalias@aerifal.cx>, Carlos O'Donell <carlos@redhat.com>,
 Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
 <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
 <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
 <ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
 <bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
 <694424f4-20d1-4473-8955-859acbad466f@efficios.com>
 <lhufr6ihelv.fsf@oldenburg.str.redhat.com>
 <6bbc7276-4f06-4ec4-ba1a-53425871a6cb@efficios.com>
 <lhu5x7edz7r.fsf@oldenburg.str.redhat.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <lhu5x7edz7r.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::43) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT6PR01MB11199:EE_
X-MS-Office365-Filtering-Correlation-Id: 696ab032-e554-4c9e-9000-08de78794b91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	nYRRzFYL+Q1w23ZrEvQZvYADFalhYo9buhsmk/TmsjlHNuxypXTpkckCS8rmvUeK8neb1s7WUvuxle5qNnPBjHNihW0kGyNVQK7CiWO41KdVCJhuzPKntTpTUU4fMGCRFaHQaSiF6hCedOSgMQYBTANk2Dwj1iP+wlxDmGGfyTIi9ejo1ylxdiABSgjLkRqpNGte+zrwWT+sw0061uIE995DBwCldtv9z5P2rU98juLj+q3ggr/Ih2N3a/qEx0HkFqBGj2Gyn/ZuHqncGNFTl0zzopcE77V0QyyJkBHJ1nW+PgEGdiiYpNkYLNNtenLyP3jmagjwFL13PxaGw9PzchQfJNaQTlZWSrF+gZysuB17PYByY1sqFbRArFjYZHiU/c8C1cSPpI+D+tJB/XoWclwt/LVhzZe9uowTmhVYgPYrkQBf9iLa1LjTCReZ+YbIt8buqrNIdXaw4+y4RWX4Vy7UKjllkeEoOsGUJ2dCIPwopZ3tOGTp77vKO446/77N6wiGfpxrWxkLeLSBpr9Zb7DRD5J69j6q76bCIdJQBLWDmHzNC1/2eKgU/ayRWVlcNfQV/b/lBm8Ps9Vh5G1YCjYPfNwp8t/HRg4J1Zunfugi8JrbJsNbMXDSWhp6bdUuOWlpvTQa8fBbt0PJYlh9LVg4DILNhXqd0bBaj8xeD7q2IjaDefdPM1gmZR4Tf7Wu
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODJzMmZWQ09RTmNRYW1SSXpUZWdyclVTc2w4RGZMT1M0bU10QVBCRTVZVGFG?=
 =?utf-8?B?MFRoZ00wTE9OK1VOZGkxdGtSSHBGSFpSWVRxbW5vcm5mZG5LK1dLRndiQVZ1?=
 =?utf-8?B?eW0zVHlGWnJGT1JwRkxCSFN5ZHc1Tkk4U0k5TVhjalBJTEFYK2RlTk1mTjBP?=
 =?utf-8?B?eUkyVDJWS29UY1hWeTk2R1VBMVJhTERZRU52NlhtY1BVcXdNT3NvYjkrQ2FD?=
 =?utf-8?B?Y0Jra1RYc1VWMzJQRVFSaWw0c3FlcGcySnpSNFNKcDc4Sy9BSnB5dXVLZHNF?=
 =?utf-8?B?SXRZQjFtQk1qRzE4ZTl5eUk2bURETEhkbk0xODdBRDVvUkhzQWxWRlZ3WEQr?=
 =?utf-8?B?dm1QOThvOFBOL2VTcGlHQnAwY1pMZC9nZ094YUdSbk5PbkowWm1FRmFobVdP?=
 =?utf-8?B?WEdXS2FWWjNDYTJlbzRPZHpPS2xhUjVla0FDczRpMnA0cDYwenM3OXB3S2RG?=
 =?utf-8?B?cGhhOHI3RE9TM2p3TDMzUHFlZFlURGFLVC9sU2hsUFE1SkZYWm1sVW9RRFJE?=
 =?utf-8?B?RW84TzhvdVVucVJiYVIzanUrOWZ3MWtZUzVJWWFPcCtXNmhTVFlNUENyWnVv?=
 =?utf-8?B?Z3R0WTRVeDZGVkF3cjVNS1diOFpHU2R4dGFiU1FlSGFYbVp4RUdQOWpod0ZE?=
 =?utf-8?B?S3VrRzBnVlJOMkRVM0JidVRnMld0S2luQW5jWjFDN3UraEYzci9CRE9EbDdi?=
 =?utf-8?B?MHFEZ3VYVlRzNmRFdUs4WWROL0NoS1p6U2lyMGRPWWNjTjBlZFRmT3RHbzVP?=
 =?utf-8?B?VVByTVhtVEF5azYwVTM3eXVuVlV2bldEL2ZpQ3RsTlZwMGJPeGJRMXZpekFp?=
 =?utf-8?B?VHR2NUpaK0JLMWt2ZjRXVjRsNVZRd0Rra216TDhTWHhNWUVMc252QUVZOUJh?=
 =?utf-8?B?aUx0YmJsa2x5QkJtdnZFMHA3aGQ2SDdrd1BGZUZtQzRVaGphazJIYkVCSmhR?=
 =?utf-8?B?S2NIR0RJSWR6MFcvb09SSDBhLzVodkg2ZkdyT1p3Si8zTmR5MTg5R0NrRC93?=
 =?utf-8?B?WTBkNVQ0QUVaK1ZiYnRoQVEzMGkwL1Q5YXZjT2lNbThqQUVLQjg5cDIrQzcr?=
 =?utf-8?B?MmxFMXBhbHFjS0NubWpYRk10K3kzaVVrc1h1UDlTd2ozRGNwSXlzU1RDRTBa?=
 =?utf-8?B?WEpENXF0aFVpbk8wdS96dFZDcU80czBiZGpTdW1JMk9zSDBpdzdHR1dWY3Zt?=
 =?utf-8?B?dHAvbk5qcXQ2djNEeS8yUThTaDVwZmJndTlMK21sSW1RaHBua2FheXlhT0pl?=
 =?utf-8?B?bHcwcG8yZVdoY0hHTmVOZmhtQkp5bjZ2RGRhaWk0WWVXYUJnQ09OZVZJT2Nl?=
 =?utf-8?B?RUduUGtaNmdvalVxWHQybEkyMmIwZVRvYmg3bE5ROVpsZm1mUzh1NnBVNGV0?=
 =?utf-8?B?VkhHR0wzQldpZlRQZlVtWHdnODhOQkZveW9xRFhvSjlYY0Y3SlV2YkIyaVE2?=
 =?utf-8?B?VVF6UzVXWHNqYUdyR3lqcmo5cjBoMUdwdm4zQk9qS2p5bFRoNVluQWIrU0FC?=
 =?utf-8?B?cHJMUzhTQ0Y2YnNRdDJydjhCdVBud0hpZnRseWFPVUd6ZWpqRGFuMFpOdExH?=
 =?utf-8?B?ZXVmc01aVVBaUW1MQWN0MEJYa1NoTTRKN2cxOGx2ZHBlTTUySVZjbnY3V1dX?=
 =?utf-8?B?TFdTeTFvUFhHc1Axcm9peW5abS9oZXdNSGdBUFl4bG80RWRIYWJCbExBNVdV?=
 =?utf-8?B?V2FoV2VYRDAwYUJPdGJMeEtBSEVad3VLemFqd0dIdHpZam9YamRJV3hwTWxR?=
 =?utf-8?B?STdkZUlKRFpaeGFBbTRSdkM3d1Z2eG0xYzNnTWt4akR4SG9tcVZlZmoxeVdK?=
 =?utf-8?B?bjZKTnJrMWUvWDhNRmR6cWRVdE9pa0d3MjBFZzd5RHpTZGVqNlo5RmZKT0dN?=
 =?utf-8?B?VkJ6UVZQWXJOQnJ1bUJTenJORm1zS29ZSnJYcURoVlB5cVdyYUdEYnZNNHNM?=
 =?utf-8?B?UjYzNThza293dUpPVmlNbXMxUU5HOGZFYlRGVkI3T0lTSWNlNDhnQU1ZUWdq?=
 =?utf-8?B?TXFVbnlTNzE1N2h2ejNVU0ZjQkt1K1VzWk5mL1ZPTENzK3FBZmszQytnbUJT?=
 =?utf-8?B?UU03QllQZ0NYVE1Edy9vbzlKMkhGTXc1UXJ3QTZlYVlmbnBGVFgrajFnS3ZW?=
 =?utf-8?B?UFI5MGliZHV6c2FxbXJFbGc2VXFHcU5FcHFtbEF4QmV4R2x5b0lrTnVsNlNv?=
 =?utf-8?B?K2VrUmszWTZoYlJVd3N5QkUvM29pWjNWZWdmZXlqTGFtSnhqUTdNd05qUEdS?=
 =?utf-8?B?RTdmQ0FvVlovc3NPcEJNV0VJK3l1WGpXNFZDM29oQjhnQWJ1bHpEeEY5ZGI0?=
 =?utf-8?B?M2hUWEw0NGJEQUVrUTQ2S0l1cExFZmJhSFNlWFlwQmMyMWJ4SVlPMDdKQmlY?=
 =?utf-8?Q?atrCYyvJlsUU5vEE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 696ab032-e554-4c9e-9000-08de78794b91
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:32:28.9651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjS/FRJfgrXnzmAa8qzss1im6m+4yKiDixUMhhs6EQBOuqA1C3SHREddU0uKyc8IMBL+hsDh1cIqzYa8j/cQOy8slmV4jj2R+EjuqOMK8Nk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB11199
X-Rspamd-Queue-Id: BF23C1DCF8F
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[efficios.com:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-5893-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 2026-03-02 10:32, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> On 2026-03-02 02:31, Florian Weimer wrote:
>>> * Mathieu Desnoyers:
>>>
>>>> Of course, we'd have to implement the whole transaction in assembler
>>>> for each architecture.
>>> Could this be hidden ina vDSO call?
>>
[...]
>> I suspect the IP ranges and associated store-conditional flags I identified
>> for the rseq_rl_cs approach are pretty much the key states we need to track.
>> Architectures which support atomic exchange instructions are even simpler.
>> We'd just have to keep track of this unlock operations steps internally
>> between the kernel and the vDSO.
> 
> If the unlock operation is in the vDSO, we need to parameterize it
> somehow, regarding offsets, values written etc., so that it's not
> specific to exactly one robust mutex implementation.

Agreed.

> 
>> But you mentioned that rseq would be needed for a flag, so what I am
>> missing ?
> 
> It's so that you don't have to figure out that the program counter is
> somewhere in the special robust mutex unlock code every time a task gets
> descheduled.

AFAIU we don't need to evaluate this on context switch. We only need
to evaluate it at:

(a) Signal delivery,
(b) Process exit.

Also, the tradeoff here is not clear cut to me: the only thing the rseq
flag would prevent is comparisons of the instruction pointer against a
vDSO range at (a) and (b), which are not as performance critical as
context switches. I'm not sure it would warrant the added complexity of
the rseq flag, and coupling with rseq. Moreover, I'm not convinced that
loading an extra rseq flag field from userspace would be faster than
just comparing with a known range of vDSO addresses.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

