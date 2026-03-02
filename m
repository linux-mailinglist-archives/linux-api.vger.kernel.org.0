Return-Path: <linux-api+bounces-5891-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NCPEtimpWngCwAAu9opvQ
	(envelope-from <linux-api+bounces-5891-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 16:03:52 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD8F1DB5E9
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5767C303419E
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2026 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3144014A6;
	Mon,  2 Mar 2026 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="RGP74ItD"
X-Original-To: linux-api@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020113.outbound.protection.outlook.com [52.101.191.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A53E714D;
	Mon,  2 Mar 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772463446; cv=fail; b=rSaqNwACkeuGXAsfx7iXoND5y8+TVMbLj90iiH80YcpWkYqEII3lTdMjr0NOXJ4FTSNwvppZemdRyd03SeP/+KbHPg3G+AyT6xU8lHiesVtjYM818ajeXrEWIy1Vv3OJsKYYV4Pcp0LIv2OtrZRVBlOmc5+5JRHHbitQp6xfRFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772463446; c=relaxed/simple;
	bh=zKBwrN5X48BCC0BgfcRn/SG7nsx4a00+EnkDuU2pOLI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gsqIUIGUthPJnKpYAkRHXdPrB149qT/HD6OFzdwttTinKxoh/s3g+6V34LPCLAbQB61DfF0cHegpWsG2ivYg5iVVMY1MOhgTuIMIv/lMGmiaRNCqoSwNCF34H/dF1arq9zLVZdn7CG+O27idK5S+58geSIVK0I9gbtQBqc/3tME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=RGP74ItD; arc=fail smtp.client-ip=52.101.191.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zu2uIpCnURt/OX/23CkbqLIrZAlOdWYChbLDbOCw5xq8VWQaKgChLLa4EJoWPJDG8KD9BSw/wt3LcyyLQsbQLSpNsimP31A2D9s+EFxXnh1XcCtYblR4u7Z7gD9g6ghS0RllMI4dxp3XR+tpFgWl5i7WcEfbd+p0qmdWsNm5LnCCVCfIrMcrnIwKF3gQT1Vb+S9F5UjjpFow6Ovwl330LpkpLDunz0s5CbCp/brANGKSTvA3CE9y+t2wFcoqqY59v2MJiP33cu53K52n0uP0gOuqw+ViIQOlx9B6fYz9zY7Cmw3Xgg+EYk5wP2RvZ2mCN/l4rLEXwtivSBYnTlr1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPxwGMXKwqejK2E75ufJL4NGFdsbz31KTxKVzSK3ky4=;
 b=EIXVngaf4hP19mLfpq3pCeoEsdh1sNoMKCPW6wLOY9w+egqxgSNqlyggeAfE8NQY3w9KPgkmEjKC/sFUDxtsOHF8fePquJyc4VURGIRrygP0M3DW0Si0/mZJ5FCiYuggqPM/DDhrBKAKng4XWCQVqUYc6KZkuZ/TOeyv/73VS2R6epXqaoaFjA9Y+1Zlc9wxpojw/92xHMZkGQz6xS58FNr84JhPSkM7xQtSeAa12i4nUjhrsqC6Ihf3yFIcRFHa/9goG/iL5OlMueBmzE3Hn4lcWl3e8wjwNoVOByv0VFdXjK10+7m/DBeyZmsgf17ZbaI6OCELiaKQrhqi7aCnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPxwGMXKwqejK2E75ufJL4NGFdsbz31KTxKVzSK3ky4=;
 b=RGP74ItDSNj29L14xsj2DMJmkuDDUxYiQqb5bBzUdZhqjKzyplzTOrQpDPjIwyJxk0vSYcxnhpSfFZqveW/rU/p1KtX078N7SnA+SHJHte7am3uBTsKmZO5xkwV7EBhQRtXycdoanEUsdMfOHPABlMI4KzRrhTfd26j8qDe6+satAp25OV7bhJJBtRbWhPhL6qKw0iMTfjD8ZsR+DmwEIKTc5uW0PjIHWhfEP5dsqhLT1tO39IhlKh2lNP8C+qsrzwhJr9j5tqO6dgS2MZThbAZHEKsceGFIvnEnNNszXY9faA8uBL52lID0IhmHrTnszUK25NbtV4JAEMuCpQXkow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9280.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 14:57:20 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 14:57:19 +0000
Message-ID: <6bbc7276-4f06-4ec4-ba1a-53425871a6cb@efficios.com>
Date: Mon, 2 Mar 2026 09:57:17 -0500
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <lhufr6ihelv.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0023.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::10) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: b70fae36-99c0-4206-1ab4-08de786c0096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	rvVcDWWa5whlV3NmD/f29jqJEUm5Yxww0EXWqvWEEvgi+QnFdlsYRXUEfuG3gwUG6GQMNhS0O3vlLFsvqz/oi7nFosxYIBupZO1KrdAXeBxg/oMTdOsuIEKBsE7mAA6lAgecVR709etl4u7s5fLYFCglcJ/6jRGDuvSOP8HQo+yBtcQY8efLCmQ1oduguHD3VJkGT05uvLBApSkS8OI0Yx9uk7At/N13PJqYEStYv30T69JJicQyuyyuyFTmSB0HF0JYanKQPf3pSDX3z5dOjxEyDVNKRcs4V5aOaL0CiVLf0N4nBxCp3Rgha/ko0NSTy4zQfSGDpOFMswCVwzTaeCgKOOy3RcBV+2trzLhOmmJk1psnSjwLfRO4Nq5aCESpCPetgwbkgjeg/q9xURVjFxp41fpdej/QDz7y5S9D8kkAMDNzdl/tY34lJJk5Y8glXIlKbF+6lzeScTH/Vyz5Nx7jF6B51GhGGcYq+o2hzkuzo3UquF7YxW3mQnORVEolQBoiD65D3sv7SFHXAOMq5NEsraSxxIzKLX614Wrt5cBP6thf5qAYWobaj4NKwfsxhD3p8d56VJISpnrYgUUyVTlkz2K+uOAHvM/ZfXug1sQ7pEwEFtkXNrisz57ZH0P3eYNerbXCVd1YClEkKzDKoGnVPUc1T62RttFFzMa157/usKyA0tn3t7I8U7xj+EeA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTFDSEZoSTJVZlpxd0pya2NvYVM5eS81OCtoWFIyL1ZpRWpJZktWdnNjb2M5?=
 =?utf-8?B?Tis1M1JBV2N1eHlpcmVldERGSzY2enRLNkZCUFpuL1gyNVZhSlhjYkhoL2dm?=
 =?utf-8?B?L2wwMWU5cDNyTnBCaVNSR3VqVmR6SlI5dlk3SmVnZzRYb00xYkE5RFJwODNl?=
 =?utf-8?B?ai9CREdiWWFWby9zUUYrbWNod05kSFpVSXVwNFNiWTlDTlpKdWE0TDluZHNi?=
 =?utf-8?B?N2FGVFprUDdvaTM4WTVITmVwSlhmN1dEU1gyb1FKVjJnTXFuRm9mbHFLZk5D?=
 =?utf-8?B?V25MdVlrWmRhdE1OZHhLUURvSjJKUVpKMm04c2N0SS9KTlF3OWlBSXNZMUVz?=
 =?utf-8?B?RDgwMjQ3b2srb3dOeXFhSXpIWTZTT2tERUpPYWtRNjY1MGhTTlM1WHZXSTNO?=
 =?utf-8?B?ejZpNFlieEdLbnQrWFFYQ1NBUDFocnpYeVZYNFRJRWpEbVNlUWZTVXVPUFRv?=
 =?utf-8?B?b01YWlNub05TRXFtS2kzRFNTRkxTSlZkTy9zeUg1L1NnM1ZpblNuZEl5cStP?=
 =?utf-8?B?WHlWWmlxbkNWSUlNT1ZpNU9JQjhuL0NiT0ZwVXdLZWlxM3hJZlNHNnlIWUEv?=
 =?utf-8?B?UGZRQWhiL2RKdVEvb3dZUlhpMTh5SFNBM1NDMlExM1hNTWo2bjFzbytKRXBW?=
 =?utf-8?B?VmUxMVB6Vy9uMlVKay9iUWdSSDRIT3NFWTVpU3ZQdHhTdXNHcWVuWnBiNkpP?=
 =?utf-8?B?dW9wV0RtNkV6VlNlQ0FTVXhNSnlCRzQ3c0lWNHQvMGErWThmS1lKVXRncE5o?=
 =?utf-8?B?VERxSUp5aEhXbTBXN3V4THE1clRyTWV0TXArdmx2aXZqckQ3V2JLeUdNWE1W?=
 =?utf-8?B?UEhpRlNrc2pTU0NZNGJKQzJMRnRLNzJHSHp4aCtRVVgvd0NPeUVaZ29GRVhu?=
 =?utf-8?B?Z3pqRktKTnFucnRXSzJLVDQrTjVNVm1rN2liaDRjQWVYVFEzRGdrREZsMVMz?=
 =?utf-8?B?TTB1Z2lFQUhZZEVzamJsbDAyVjN1V2ZYL1BwSFlQSEoxa0RiWjJYR0hUSkVF?=
 =?utf-8?B?YndEMEJBdkF2NUh5cXVZaHl4RmVoUmtnYjBYeEI1TTd4NHg0NFZaVG1jWVJY?=
 =?utf-8?B?MHI5SHB4a1hFNmxqelJlV0dTNUFadjZ4K2FIbG9HQnozKzNiMm50L2lGOHdt?=
 =?utf-8?B?bDlFNndpWDRXako2OS9KaUJVdm45cEo5dzJpZVJBdTkzK21ZV3JGamhLYjM5?=
 =?utf-8?B?OTNVcWZ6bEcreUViZHNabkVnUnhiNTdSdXVOczhkWE1FbW9iM3RDbVNjRUNv?=
 =?utf-8?B?YTNOcnZ4dzBPV2swVWJxSDMyakJGaE5vbHpUd3NEQlppZ3hPOWUvcVBmejFH?=
 =?utf-8?B?aFJTWWFObHRkTEF6UWpOKzI3VWExUGpiejNHdVJsWDRCOXVzMHprbFNqS0tR?=
 =?utf-8?B?U2Y1MmJaVUVIMENZbmo0SG1wTEZjRExHcW4wbGZqQkhCc2gweTdQcEx1U25Z?=
 =?utf-8?B?bVZJMWZZV2JOaUlTZ1NwMVY1aUhhODhjUjl1bENwMFVUUCtXczhwcnZKNzAv?=
 =?utf-8?B?aWdqanpxaDFaS2hKVXU2SENCQ3BRZlgwSTdDU0htRnJXT3FjbjBhTDYwU0ZE?=
 =?utf-8?B?Qk9ROWxxTktoZWlOOHFZS3VlanVyaWpLZHdrZ1lYckRiY3hCbzl4eStVOXpl?=
 =?utf-8?B?dHVjbHI0WXA0YklsQVJaa1RoZ2ZuN1JXN1BoYkdWMkJwa3F5V1NERDBlWmVi?=
 =?utf-8?B?M3ZQUmlEdUI1UVF4UTQvODdxMy9CdVc1RWRQcE0zR1Z2UGZYdE1wbU02eDk4?=
 =?utf-8?B?ZTdMUEkxZXFjemp1eU5TTFFJQ0tFQ3JZTSs1TE5PNFVZZ2ZKc1BSVDFsVStu?=
 =?utf-8?B?eUFoRHlKcUE0NXVvbStLRXN3bkJlUDhIMjJ2UXdwbCtsbS9RbVJHaXFGb0lC?=
 =?utf-8?B?ZWJuR3dYamp0MEFrMmdMNE1qTkhqeUxGcGl3bEhhcVhSRE1MUjVGRUVSTDRD?=
 =?utf-8?B?blZ6TVFZWWNlRExONU1PTE52MDVnWEJUbitwV0U0TTdLUlhPN1FuT1RWbE82?=
 =?utf-8?B?QjZpKytoaW1tcWIzZ1hFQzQ3amQ1dGJtb2xVVVJlV3NKamFFOGhBL3JlQkUw?=
 =?utf-8?B?c2VnTGw3bVJEcTJtaUlqT3lQeS9Rc1g0WEd2QmlPQ1Q1Y2RsWXlvajhQRVVs?=
 =?utf-8?B?dzI3U25NbkJlZnMxVUgrNFBxSW5sWm43QW5ESDFLaE0vYk1HKzJIUEhZVTVk?=
 =?utf-8?B?aFJZb0doWGtNTFBZUFpmdnFKc0w4WjlBMlpsV3l0MVhRa0xzWSs3ZTVhUGlz?=
 =?utf-8?B?aEdGcVEwL01MZ3hpNDJ0OGpzNDRnMWo0UTNJb2ZTdFR5ZjB4RVI3TjdiOURi?=
 =?utf-8?B?RmViU1pnSlNBMkdrcktvOE1CZE9IVWdhbTUzYlNoWEpSWEw4TFQyZHNWaWVD?=
 =?utf-8?Q?PUqvFHDw/MI6mR8I=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70fae36-99c0-4206-1ab4-08de786c0096
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 14:57:19.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uaEYyg5ipWtWZ8GJILvQV+LsRD3MYXl1GZQBG38taEAo7Va0zcOlXmxse+dZxQcmRFrlQXuz0NIaiENHrYoDENB4Gj8ExPhpeX2dT5tIaqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9280
X-Rspamd-Queue-Id: 3CD8F1DB5E9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5891-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[efficios.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,efficios.com:dkim,efficios.com:url,efficios.com:mid]
X-Rspamd-Action: no action

On 2026-03-02 02:31, Florian Weimer wrote:
> * Mathieu Desnoyers:
> 
>> Of course, we'd have to implement the whole transaction in assembler
>> for each architecture.
> 
> Could this be hidden ina vDSO call?

Yes, good idea! I think this approach could work as well and reduce coupling
between kernel and userspace compared to the rseq_rl_cs approach. It's OK
as long as an extra function call on robust mutex unlock is not an issue
performance wise.

> It would have to receive a pointer
> to the rseq area in addition to other arguments that identify the unlock
> operation to be performed.  The advantage is that the kernel would now> the addresses involved, so a single rseq flag should be sufficient.

But if we implement the robust list unlock operation in a vDSO, if we
don't consider signal handlers nesting, then we would not even need a
rseq flag, right ?

Having this in a vDSO makes it so that the kernel knows when it's
terminating a process while it runs specific ranges of instruction
pointers within the vDSO. It even knows about the relevant registers
(e.g. ll/sc success) within specific instruction pointer ranges.

The remaining question is how to handle signal handlers which can
nest over vDSO. When this happens, we can end up terminating a process
while it is running within a signal handler which has been delivered on
top of the vDSO, so the topmost frame's instruction pointer points to
the signal handler code rather than the vDSO.

One possible approach to take care of this would be to add a robust list
pending ops clear on signal delivery. When a signal is delivered
on top of the robust list unlock vDSO range, *and* the mutex is known
to have been successfully unlocked, but the pending ops was not cleared
yet, the signal delivery could clear the pending ops before delivering
the signal.

> It
> could also vary the LL/SC sequence based on architecture capabilities.

Yes. I would be good for selecting dynamically between aarch64 LL/SC vs
LSE atomics.

> 
> The question is whether we can model the unlock operation so that it's
> sufficiently generic.

I suspect the IP ranges and associated store-conditional flags I identified
for the rseq_rl_cs approach are pretty much the key states we need to track.
Architectures which support atomic exchange instructions are even simpler.
We'd just have to keep track of this unlock operations steps internally
between the kernel and the vDSO.

But you mentioned that rseq would be needed for a flag, so what I am
missing ?

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

