Return-Path: <linux-api+bounces-5895-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMUOANfEpWnEFgAAu9opvQ
	(envelope-from <linux-api+bounces-5895-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 18:11:51 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB7B1DD9A3
	for <lists+linux-api@lfdr.de>; Mon, 02 Mar 2026 18:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10C9B301DBBE
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2026 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4239236D9EC;
	Mon,  2 Mar 2026 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="OA7bL3tl"
X-Original-To: linux-api@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021078.outbound.protection.outlook.com [40.107.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5835220F38;
	Mon,  2 Mar 2026 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470581; cv=fail; b=cUseUOpZm7CZ+p46ILztBwT/M6EeBW6MjrdjXzGiEBFPBthWwcLpjgtxHcO8adHZIgtvh6m35gRKK4vINfyd1PDFBMi18GeRxANxfByHuh+RS77+TM2YIpB2Gk4AQL8zk75qZmAr9lCzc52RLQ5RCwY4QEOT+rIyaUusoES+6AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470581; c=relaxed/simple;
	bh=ypsMwvSGUMstdB6ACabpW4pCNy6/nMc6bpRL0OzJSUo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hUQgVeAnjWqw4lQW1O2F8BUEBn5sW9j9iW8MbonLgBp4uLIAEjmqYaGIlwTzONFF0OyfDwhyqoSY0MfuiSq/IJgETVZesxJO+lM7ZWnJPoek6++p5b83EubYYAhPb+w5rJrV3hHnXRC1tVp3v6sibB1+tynf8/yiZeDkoQxCApc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=OA7bL3tl; arc=fail smtp.client-ip=40.107.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAjcCn9PyoLJwhCg16ohCzVERNjKiUbNOV/yvKoCq7DaE0hkHDQB11Z6GDRBsJ8etJaZ4EXm7VaEK57c8yW8JvdCF2p+3z871bUdhbI+PBnf6qXjMcRcHI6uUVxqLk/ceOkYzHdw2Cd6R0QVKCPpDZ9cTGV0qCwObgc9KIAPVja+9fGVlUvRGiOfvniHpJ5j356NJknTFv/8vxA3zsaXwWB44MZX2x7+ZdCeanZX9qcYWb59OKnUuwGKuS3ezpVvbfs2qSKjJtg+uM1YBWM/BCGtSTSo+wNQXV1Bf0Xz4UK2+X+dmiMv94cdnoqAhh3UO5TxlTBXccVo+HjOD7dc6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut8qEUP1tR9holgGORlkVZCcyGwLd0TZj7L5/kGrnlU=;
 b=oGxwCNS4Z5Dr3I8ZRr4UlvCvsWlmvYwOyc9VsBLfabE1+BYI7bJfAzZWQL27P5IM9tCyVmfb1ehajcsIPk/G9CKZkeYhGdIFJsXr7LwmMRv6a+P988R44t8XEkBqrhlr9YF+VnoZ7ETGhzQLht0zafzZ3TQ3PdlF9fB8Vpq/BogM7TMOjJgy9EKIKZr2kk1kwy3vm1pnWee+eFobg4ALZlaAVpkX+8niijUpaluqAHvgGzU0fzslyBfjHfhECKw49TRx5tO7HrnjFiccKfbhj1UPisGycKf+HfBUwGdpPk0XtlbobZQX84qErk9rsl1PzQJTbKM+GK2uDBH8L1cO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut8qEUP1tR9holgGORlkVZCcyGwLd0TZj7L5/kGrnlU=;
 b=OA7bL3tlBBqNPPSGr92OHf7IIVyM0bUFEN4S0QN8s0FKxcpAuqk02mDkoxgEpZvzN49cMYi3hVm+2npwzEBQKAc8FzdHKmf0De8nHDZhKp6mOxkmlidbDzagrBsGKn9ZVPJaTzUEPeE6Q9XqhIdPtggG0wAirhKagZEj/Ct4NVLVbL9QYhybgz0zJFKiatfAGTCRY/kIIO/orRs6ajHaMChg+MfXdyXnlGThCIMybgNtjsUVEsfAjGO2GN9wDSjFeelyFJktN48UH9UM4qkjZD5sfiQpQQF5hBaCsiWCW0u/mRa2ueFyZOOMVuzF30YFNPRa7IgwvQnKpcS7/5mRjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQYPR01MB11485.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 16:56:16 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 16:56:15 +0000
Message-ID: <de1bfbf6-424f-4d69-afb5-5d0c7600874d@efficios.com>
Date: Mon, 2 Mar 2026 11:56:13 -0500
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
 <3f30f2f0-5173-42e2-aa89-0af9bb391c0e@efficios.com>
 <lhuqzq2chdw.fsf@oldenburg.str.redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <lhuqzq2chdw.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::25) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQYPR01MB11485:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9a4926-db5a-4830-54b2-08de787c9dfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	ts1FX/p59YMX2J0AYhAt7w9B69kGJA52r3SMaTsks80CCv0snJH1iH9F4Srz9h03o1WtH12gBHdoRUxEdCpYlz6i/gVPl9JDCfb1v19pKQpQm9Tii3KiXixeNTsL3txQBdzuSfysDItksDRC4Lqd4uuc/OJ1A6IN0lB8kCWUpqWE4+z5uImbTdFa2JMLv1bdJVOsWrwUwoLYyEo/HL2IOi7ZIhzsxo4IQWgh6PtGoOPgK3KM7gd7TQHzaKijRYnjVPQRezUxq0pyH4EEChyb3hxzXRe8R1UHs1xTHmJA9Oo8X0QrXj0/aIFhNGeG/BsMcs7fi48eD8DJ25yIUYm0cCzZFjGTEsCunByUbczx3EBB8OlYTfJCjFHZZBVjqYZlFcudVrhQTtgWmdYJk4F09siakjYwIfblg1UT8dq388H8zw2F0f5WF/PCRsXWruspHvJCGLlOx6iQQTImkiHi48bxzBqAQ+RUuio1F+Q0FBuRlZH1U49K8u2PwLL70GE6Cwj2SotoVvjmkymSPPKeCfmavGZthwOCfoepPfj9U6W2xQN+Fie4TBrqLZ4XcPoq7FTiFtKJYMVKVBBbk1uweYKrybYI+phE8U9ILquhF/OaEGrFsvGyXAJYhX0Px7VzVOeZdy2GEymWzbmsirLiHNoAIuZ5l8DU79ufx3Xk/fU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlMvV1QwclBCQ0NRS1RzOUNMYkZhREg3YytIN1ZmS21FYnRLbjBMZUZrWldN?=
 =?utf-8?B?bVFmWlJ0blVPQjhjZXdncVBOQmw2a3VpV04veWJ0RzljbDdQZFRwOXRRaXE5?=
 =?utf-8?B?U2w5dGRNZVcxY3gwenBTNCtwL3pOdmx2cDkyWGtXRGh0TWg3UHAvNks5Qmc3?=
 =?utf-8?B?YkxGMmswOVVsbit3T2hiMW9UWFcrMUdVcmVhR1IwaHlOb01SVjRxaFV6Z3g5?=
 =?utf-8?B?TkZrZk9vZ3Vpei92SmxaYTVMUFdXQmZwVTVqKy9yWGpIMGtiYzFmU0FMSFl4?=
 =?utf-8?B?b25WR3RSdWhDN2d0UDNzZXZrZXI4UWRGUzlsdElZWHFMamRqZHFqNkVUSjdu?=
 =?utf-8?B?NXYrcWdxSEthaGxnR3lib01DaWkvUGRZOTI0Vzc2OGFxV3VLZDdKT1RzVmtI?=
 =?utf-8?B?cmdhbHZ2MFBUTEhGV1BzdEV4VWcwdWxKbFU4cVh6ay82blY3bnozVHpJMnhT?=
 =?utf-8?B?djZLRlBPVm5QNVlNNmh0NTE2QXB3TGlCaVY5cW5NT2d6VnIyL25SNFVkNEpH?=
 =?utf-8?B?WkRJK2UraFBOWHdNaW9VNVZRQVFYN0hsT2xUekc1V2swZ0V1bnlVQktEMEZm?=
 =?utf-8?B?cllINGlQR0JtbUU1WmJiZ01Ic1lJOWFja3FDS0ZaTFlTRlFNYXpHenlVRWVx?=
 =?utf-8?B?T0V0WUhGdlJ1VWJVU1dqMHNqNCtVVUcwQnJlV0hZSE55K1dlNlZYRENxWTE1?=
 =?utf-8?B?b2VLSTc2OWNhczdGa1VDN1drdUg1bkJ2WjFrODlDQVdCd0hMeWtNOG9zODM2?=
 =?utf-8?B?TUFpaEF1SjU2RG9Sb29vVGFEcEdNaURLTEJXZWlINFByV1FsSzlGKy8zWWp5?=
 =?utf-8?B?a3hjdkN2YVJKTUJteWtWVkxKdnBjZ1Y2MzRZMWduanpxc1VTQnVNeDBJcVk5?=
 =?utf-8?B?UFdsbEhLQ0RIdGExeC9Bak1DU0VmZ09xa2p3WUZtMVN1WEN6ZVAwRjhTck9K?=
 =?utf-8?B?bjJaQnB0amhubXFLTkpCZHkrMDcrME40SHh0WklxN1NoVy8vMlRyM3h5NHJQ?=
 =?utf-8?B?Z2tPdVBFbHJzRFJOQ2NkZ2FuRFNxcExXQWJkTm42eWxxdGlqT1Z3T0JOdzgx?=
 =?utf-8?B?TkJucEIrTlBGd083VHhHT2hKZ3dRNmlJYmdzQ2UvUStTUFZHallwSEhCUyt4?=
 =?utf-8?B?UjIySXdkQXM0SU1QbDVqNkpHREs5WFgvdmZXcDlrYThjVTk3UkZ1RGpQdkFW?=
 =?utf-8?B?NmhTYXlWSFA4Z0syUVhuTTVEZzFHTGhUTWEvRGtVS2lNenR4SHFLT3BHU0hX?=
 =?utf-8?B?UU9pVWsvRHp2eUY4bFlGU3ZiME5NZlpVWnZxNElkVENPTEJ1WktrbHdyd0VC?=
 =?utf-8?B?TlM4blN4WjhDa2FEWTNzaGxFR2xNSktmMzQvVEptOGx3MFJYczA2SjlCVlE0?=
 =?utf-8?B?SmZHb0xzUzdWY05razZiYUcxRU9DMnJYRDQ3eW9BVFhVU3E5MXRreTN5aVBG?=
 =?utf-8?B?TGdCTXVnUjdBd2EyU045cG9vcE1KMjVLa25RQmUzTUdWVGlNNFlyVlRVOVc4?=
 =?utf-8?B?Y2tmNUxvcW1YeUx3NXljdVMvNi8xd2hMbXNKeUVlNnZEZTY4V2VSTzBGM1Vt?=
 =?utf-8?B?RHVjN1p6b1RzQUJzSVpGbTJjcTN1Q1RhVFRDS21hRitPNS9UTEFqOE5KS3di?=
 =?utf-8?B?aXkyQ0xwNWQxcGRhNmxWZ0gyV1BSOURPbU5PeERPTzlrbFFiaE1tanJXU2Iv?=
 =?utf-8?B?c2ZWeGFDOUlMRGlDWFJtTU9XRERORjhXSGYyeGsrc3FmUlN1bzZ1SWs3N3Nk?=
 =?utf-8?B?Q2hhNVN6V09pT0NFOVduMTN3eWxNcEh3RCtPVXRJblV0UDIrSUExV1FCMkM0?=
 =?utf-8?B?TytKNUtTNzVXQjFFYzgxenNITm5rWVpFTUpwcVA4MHFIdkZwRVR2dzFrOWVV?=
 =?utf-8?B?K21OMGpGVWxScWpTNmFHNzZISkdXbVJKclFqVFpnNXh6bE1uNmlPem9KSnpy?=
 =?utf-8?B?THhWaHBzQnRmSVRPNldYUEorZWdJRnk5aGYrOEEyUlh5TUZFUDBjenhhY3c0?=
 =?utf-8?B?cHRWanFQMzlhVy8yK1FyajFRMm8wd2pld2NQaDduMWw2TEdHaDJzS3l5Vlpi?=
 =?utf-8?B?YnNzQWs2Y3c1WTJEVEoya2tTN2pjYWMveDdnL0FZcVBwZkdRMXhZOUQzdEp4?=
 =?utf-8?B?SHF6eitOaTFmaEJWeUZuYTQ3K0x3bDBZWmFscWJXbGVNcjUxM2dJNlk1NGs2?=
 =?utf-8?B?TUsxR0xwblVJMDRpVTQ2TVZXOG4rNkRWdk4zb2crU2Jod3RoR2p4aDg5ZGFs?=
 =?utf-8?B?QWJMQ0JjRDNJV1ZaVzkxREhiWlQrTlVlMDJ5aHF4Sk0yakhnSVVvWU5tODNW?=
 =?utf-8?B?U204T1U4K3FXVThhYXNWa1dFcUl3RnBpNGUrcW9Pd3pXWkNBaGJhVnRHbWtq?=
 =?utf-8?Q?2RP8oEbFbMeoVxEE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a4926-db5a-4830-54b2-08de787c9dfd
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 16:56:15.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xvTfNH7Ex4HzIyIons4ProkWSsCR58FHNEA24T2tHbhGomH0YtTzZxdgFxwmyRJsuQ/0R7V40bZCEFZgvMEEoBWWAoQ8QRV7AoP5n5z2QVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQYPR01MB11485
X-Rspamd-Queue-Id: 5CB7B1DD9A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5895-lists,linux-api=lfdr.de];
	DKIM_TRACE(0.00)[efficios.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,efficios.com:dkim,efficios.com:url,efficios.com:mid]
X-Rspamd-Action: no action

On 2026-03-02 11:42, Florian Weimer wrote:
> * Mathieu Desnoyers:
[...]
>> AFAIU we don't need to evaluate this on context switch. We only need
>> to evaluate it at:
>>
>> (a) Signal delivery,
>> (b) Process exit.
> 
> Ah, missed that part.  It changes the rules somewhat.
> 
>> Also, the tradeoff here is not clear cut to me: the only thing the rseq
>> flag would prevent is comparisons of the instruction pointer against a
>> vDSO range at (a) and (b), which are not as performance critical as
>> context switches. I'm not sure it would warrant the added complexity of
>> the rseq flag, and coupling with rseq. Moreover, I'm not convinced that
>> loading an extra rseq flag field from userspace would be faster than
>> just comparing with a known range of vDSO addresses.
> 
> It wouldn't work for the signal case anyway.  That would need space in
> rseq for some kind of write-ahead log of the operation before it's being
> carried out, so that it can be completed on signal delivery/process
> exit.

The signal handler case can be dealt with by making sure we clear the
pending ops list on signal delivery. AFAIU with that in place we would
not need a write-ahead log. But even then, I don't think the rseq flag
would bring any benefit over simple vDSO instruction pointer ranges
comparisons.

Also the rseq flag set/clear cannot be done atomically with respect
to the mutex unlock (success) and pending ops clear state transitions,
so we'd need instruction pointer comparisons anyway.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

