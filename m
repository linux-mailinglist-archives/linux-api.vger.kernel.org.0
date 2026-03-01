Return-Path: <linux-api+bounces-5888-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id selvMAZgpGlpfAUAu9opvQ
	(envelope-from <linux-api+bounces-5888-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 01 Mar 2026 16:49:26 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A51D078A
	for <lists+linux-api@lfdr.de>; Sun, 01 Mar 2026 16:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E3A3012E89
	for <lists+linux-api@lfdr.de>; Sun,  1 Mar 2026 15:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3041E5B64;
	Sun,  1 Mar 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UfU4YU4a"
X-Original-To: linux-api@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021143.outbound.protection.outlook.com [40.107.192.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08C4430BB5;
	Sun,  1 Mar 2026 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772380163; cv=fail; b=ETHZRKQkPEP0nrWzDsvxpHcGVhPLQgkVNautTy7FCsn4UVs8lz9HdUeuZYULa5jKSG/mFkVyyQN/VW6DsuNSk0XV03+56H2zRJGhs+rEjSMiDqHaETOupdusiFdW5xVepIzi1aQaRGUerIYNP7cqnzycEmhdeVSMzkdso/tM1GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772380163; c=relaxed/simple;
	bh=N/uP37HvbzhNZ4/tyokgutBvVOBu5/Fwy4H+GsJZxQs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cLxUhVEMsra91qI7MqyANsvoTVDiL81pjm8aqZOYE0QEKbwmbmzloJIjgrR6NuqX63rW9Dg1zGB5GzOYPCa1QPy/wgyMBHYxg+8FJN49R9fO/Vg6Cxe2CVoNbPPzEZRHGfbIqhmg50RRRrsgghaLbvWCkUw7UZbI7pCbv4wLsNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UfU4YU4a; arc=fail smtp.client-ip=40.107.192.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vMiOZ2cVNZTyWIpg8u6eVFs0vpryR7w428ndzTuLwA5Ds8JZxGOf9iZIuwidt03pmtgrtmfCOcEK7Rhnfh0cZiTL6pZMqwMH3jN5BYiERcymlTZL1eQYoEGP0QEzweBaZ5mx8a/MeUW8Jbxm3ZHKwrRvYVzyPlxJi9urfE4KBu1kkbgGdsvYZvVyUe3F51IYzxkWBLnV4uxrXZcWii2YQ8vGe+mo/lRclXxWTc0ggzowDO/Dd+Y/68x2eBFtv8hUpe8mf1ripsCku4yvbJYSgRw4NNcbUuN1hLLtYTZXLgVHZvGJo0dVlqB4tpTU3B+/SBSwv4KBh178+Nmgw5a62g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQzKreeraUeyf3xUh/vDZjLwZGhR7YSnSooxQZuJbG4=;
 b=cNcL2AwERf1AiyUzpjAaaUIHiyZuR69wZabCXC4b4gEF4ICC/YwZUlvTuJxN1YHTv1VfmmR/97fFtpJwzTH1jzBaYh6flLk3E0KIVV8XUf6ep3UuwjWS9zlFIfZp6Xk+3ROOoUXSal+I5EFpH1QQ0F6wKTJUhBGvpS/xvJ7wR3tV9ZJoHVzcT0wyv+mHU5F/OmYvkxj88dmRAEmshv/eenqZE38zpMCtAhRDfIrmPw0ExTV9IK0TgfYsyc7theSyBJ2eHxUQsatG8VQ2S1B2Utj+t79FpL+vUgZhmczAKuAx3tgXA9JAcYeFsFyVts3CHOuVBmKa/cQDT+VreNa7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQzKreeraUeyf3xUh/vDZjLwZGhR7YSnSooxQZuJbG4=;
 b=UfU4YU4aN0zyR5qhMH7nxTovOyHSqmpMxfb6utBlzy5bMDFsq7Fd1zkxnMTfHCTuXPDGnYu2HolUOIvXr0JvrDV9WcX653uopuBkZEYp+z5Q30jXRNTOT8WP2kGzOS2jELI3+5qtiwbeoid4nQdJEJ1ph5OuCn+Zp/xCg37BXd18SlUqOuubtVot5vccgLKbeaR+keSojCsPcpKDbjqcaXuW2WsUqN20hHWLUkwlGPTDC6kuD3ruWvinHRmzP7JkJs019uMYM0IbQTnAwejqsOPioVfpVvoCqfftREbP6e8EGMpIesb6YkditTX4El1jgPLeopv4KD4+fp+OAXmQqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB8419.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:78::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Sun, 1 Mar
 2026 15:49:18 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.020; Sun, 1 Mar 2026
 15:49:17 +0000
Message-ID: <694424f4-20d1-4473-8955-859acbad466f@efficios.com>
Date: Sun, 1 Mar 2026 10:49:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: kernel-dev@igalia.com, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-api@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Torvald Riegel <triegel@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Rich Felker
 <dalias@aerifal.cx>, Carlos O'Donell <carlos@redhat.com>,
 Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
 libc-alpha <libc-alpha@sourceware.org>, Arnd Bergmann <arnd@arndb.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <0d334517-63ee-46c9-884d-6c2ae8388b87@efficios.com>
 <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
 <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
 <ed918547-1406-4ae6-8a94-4e03712a4923@igalia.com>
 <bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
Content-Language: en-US
In-Reply-To: <bd7a8dd3-8dee-4886-abe6-bdda25fe4a0d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::18) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: ab082585-977f-419d-0011-08de77aa18b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	L5MZuHoD7wipSTL0wcO8qWcS2tZCFQINuZJEAWrCW9/o3YmY5SFmDNoqAipzjKkdvLYOPVIk8nk1th1XLKkjPrVW0tV/4L+7rrcyG3GD1lUSAbmSltawgMshQilcVTYk66xzS6s7kWDsJ8BhxI4mOkjn/UYdgSxVZcAXnPqVWOisuOTAQYpq3BUXuKItqNbLeVW5VpnwvKfvPE80XW3TNHNPbnHyp8sSw3SNbBl1cnYwo/rUqRnwCd4ChUyXCFmhH5NTFuzmoNLK1RA+f37IL89fg4R1xg3FXDH2J3mRARAJ3pbYQDMzAgs3kdBkjLp/HUTNsRZtS6VljlG5hyhM/HHuAcOawtEPZNVspnNYFOVc6fFxLFgcPp+Q8gxzaTin88AkamEzu++UbYbN3sCvmSXTB+iBLg9MEeFi/09oWZuGdkobfQJRs+n3Y/nbOSIW7hOQVYZy4q24MQPCceJp24LhRCM7rdfsOpG3g64F7m0dZwg2GwLQIazqv1Q1AcUXU/8nV68ycCQE9kkGgB4nQEWAt+uOyZzNw7okuHGs75qdBCxMHUO+aoGCWS7KcVrTOa4jz8sw1zhkJCPHA8WTE7Eo1ZNDx8nksvjKKdEfSVtOUeKFpPYzEiepuQZs/NoOEsAC9If+bQPEbXHFA/PfdQANpvJrFNiYzhOo3SqG+xaELQycwk4V5MNCNQRzzYaL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qnc0eHRjTGJETnNzd29XR3dhQWt6Q0FPOWV4SUxlbTFBMU9pZm1uYkVBUnhs?=
 =?utf-8?B?c1lwTkhYaFBrRDFWclJyeVRRNmRIRkQ1VFNJOGdNQlU4SVFiS0YyRGxUL1Fq?=
 =?utf-8?B?RTdSK2RIanR3OGFZS25Dd2tJNlpDQ21JaDd5eXNJS2x5SlFQSzNaaTRjV3NR?=
 =?utf-8?B?TmlQeWdzVG15QU5vbnJETFF1QjVGY0kvMDdVVkwyQ285cXZjZVhWc0JDL0Uv?=
 =?utf-8?B?ZjJTQWZwZDdKeTkyT3RtRUZuM0FZSDZnaFhXRUE1K3FCMWcvdVVkY2xLamds?=
 =?utf-8?B?ZEtZaGpMSGhNc0xvZ2t5VTR3ZnNVN3A5Z1FvRTRPSU0vbzZ5amxOc3BxZWtF?=
 =?utf-8?B?S3NJM25nbWJZYktHOThwTXhmd2VoenFFek0xelViQ0ZZT0lzWnZCM3hRVStU?=
 =?utf-8?B?WFpSMXNsUk11QlR3YkFDYmlqK09pZFlIOS9wZWFuME51ZHJ5aUlrall5WkFW?=
 =?utf-8?B?UUF5Z3NzSTU0UXJhTk41aEFETWxzSDVkUVI0MkM1UVRuZ0VzT3hVZkEwcXFL?=
 =?utf-8?B?R3ZpWFBEQU15d29zUFVldEJ6cUVtVHp2YnNKZHpmSXUxRS9YQnM3eUdWNzlH?=
 =?utf-8?B?Tld1SDdwTmNuQ3lZbGxSYWROVVRveFF1N0FmWUZJRmp0K2x1dlY1NjFGa01X?=
 =?utf-8?B?VDVpRlk3cktHd2ZVdHlYdTd0MWtvUHNiYzZGSHVFS1VrMmtHdU9aSE5vekRF?=
 =?utf-8?B?eVgyWWRkY2JXM1FQVXRhb01ualp4emRudXppUjdUMEhXNC9pZno3N05QN3Rx?=
 =?utf-8?B?ZDAyaURBTnpncmVCamdwTDdxZ09LRHozeXRzYzVGNkZvZEJnZ0F6bDVBV1NC?=
 =?utf-8?B?YkhvWlY1MjBrSFE1K3dpcDRvTFpRRmNQby9LLzVvY3NTS005L1BIVjFnY2Y5?=
 =?utf-8?B?NDdEa2hwbkwzZVZ1b1BoRTdseG5iSnJLK1hJZ0tld1p3bFhyaFlqUXNxaHpa?=
 =?utf-8?B?aEM5OGRjUlVsck50RGVMdzZZTnVpRkJIWXBac0JQSlR3TDNkOUNRU2hndFJU?=
 =?utf-8?B?bm5sUEdMMDNENDNUNEpsQkxrRW1DakFVc3FVU0hFbGZTbnEzOS9Vc280U3E0?=
 =?utf-8?B?bnpITGxsd091blBVRnJTRTBnWVA4Q09jcFVBa2liVDYySER2OC8wUjUra2Fr?=
 =?utf-8?B?dDRycis3VVZEekhQOFJGVlVOUlBPeERYa2FGTEl3MVpYK1NtWnZaaXF1dVA1?=
 =?utf-8?B?NHhuL3B0UStZQmdMa0dUWUoyU2ljcElkQXprbDd3NTE3aVdmcUIvSlVGbjNK?=
 =?utf-8?B?WWdEWjdyd2szckQ4OHJaK3NpYTFTNGpWNk1tdHZnMVlZSWE0S2lsTkdYcDJw?=
 =?utf-8?B?UmJRblU0WU1lUlhKZUZZTzFOdjFvckVzWGFaMDlYWTJGMDFkbE81ZFlQSHRy?=
 =?utf-8?B?cGgxS1ArOElHSUZNLzgwcTNaNENKeDhuekNIY3ZmRVp1L2I4YkpXWDE1ODRU?=
 =?utf-8?B?VFo3NmZJRHJ1YThHZGRIMTVMNVFtdllEd01iUk1RR3dsNnA2bXNhREwrdzFu?=
 =?utf-8?B?S20zb1ZIbUpjU05wSnJvTmNaNHVhcU51ODA2YXR5bzJzcXQ5cmJXbFVYNG0y?=
 =?utf-8?B?QkVORWFsek9GNFdKejNEclc0a2psb2hkWFBqTStGMm5jMTFjUW8wcG1DczhT?=
 =?utf-8?B?RStNT25HWS84MTZLNFptOGZTTkk4WGpMWjRzTy8ydkFHWVlpenRDK1BuMjI3?=
 =?utf-8?B?bXNRMENnYmNRSXg4VTUrK3BrV0VlVVFMODYwY2ZqZ0wwNitHb2lHYXExTVJV?=
 =?utf-8?B?V1VGQ3NEWllYZ1BFcDBxYlJFSDFZRUhUQzVhTGRhUHlkd3JzOTlVTEpmOVB2?=
 =?utf-8?B?VDBPSk40VGFYMitwbXZPeHBSZk96MUhpM1M3Q1laU0hCRis1NzZlc0RJT0FN?=
 =?utf-8?B?RXM0WmhkQjloVXZheFg5U0RydGlEcENuUzJjdVhyNFo0aXpETUkxd3JWUC92?=
 =?utf-8?B?dXBxOHpLZ2xRRUhMOU5rb0J1bUpoenlUOCtMSjhCRWp6WE9hM0Y1a2JFMVpm?=
 =?utf-8?B?cmx3NTcrYUVMNXZvbDdTN24yUExPdmxsZ3RNTCt1L2JLdVoxbDlYV1diTkZF?=
 =?utf-8?B?bkRCTTAyUWFicFZCdmczQzhDWFkrQUNoWWE0MVJFYXdKWmk0NUR6Z0c3VkxP?=
 =?utf-8?B?TDhuVmxIYzdVay9qNFprdDNrTk8xYnZBL2F5aG90dmFyREx6Q1ZLbzhmL1hR?=
 =?utf-8?B?aUpmd0p2WUZLWTJGZFVGZXloWlhFd0tHVmtJQi9DN3BkTjVaQXNPMURJYUcz?=
 =?utf-8?B?dUNHaTBmRUZnUnR5VE1VcnlLQUNsNFBiWWRMNThqdFVyRjFNT1Bnczk0VGI5?=
 =?utf-8?B?UE1BRHdsTEk1VVpWemY4M1U2UzRGVU1GT1BpSzFURS9MeHUxeXNnUXd1NDBs?=
 =?utf-8?Q?XyMHb0gj9qysYfms=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab082585-977f-419d-0011-08de77aa18b9
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 15:49:17.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QupgFweQToIw9tWeXawvMbvFLy9yBUC5x//lG0U62Wg+AKY38KekuXJzPz1UajeeZjOXd3AM/5c/qdDuxh65teNiHspaMe1gsoUTGnHe19c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB8419
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
	TAGGED_FROM(0.00)[bounces-5888-lists,linux-api=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 054A51D078A
X-Rspamd-Action: no action

Hi André,

So it looks like I got a simpler idea on how to solve this at some
point between going to bed and waking up.

Let's extend the rseq system call. Here is how:

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 863c4a00a66b..0592be0c3b32 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -86,6 +86,59 @@ struct rseq_slice_ctrl {
  	};
  };
  
+/**
+ * rseq_rl_cs - Robust list unlock transaction descriptor
+ *
+ * rseq_rl_cs describes a transaction which begins with a successful
+ * robust mutex unlock followed by clearing a robust list pending ops.
+ *
+ * Userspace prepares for a robust_list unlock transaction by storing
+ * the address of a struct rseq_rl_cs descriptor into its per-thread
+ * rseq area rseq_rl_cs field. After the transaction is over, userspace
+ * clears the rseq_rl_cs pointer.
+ *
+ * A thread is considered to be within a rseq_rl_cs transaction if
+ * either of those conditions are true:
+ *
+ * - ip >= post_cond_store_ip && ip < post_success_ip && ll_sc_success(pt_regs)
+ * - ip >= post_success_ip && ip < post_clear_op_pending_ip
+ *
+ * If the kernel terminates a process within an active robust list
+ * unlock transaction, it should consider the robust list op pending
+ * as empty even if it contains an op pending address.
+ */
+struct rseq_rl_cs {
+	/* Version of this structure. */
+	__u32 version;
+	/* Reserved flags. */
+	__u32 flags;
+	/*
+	 * Address immediately after store which unlocks the robust
+	 * mutex. This store is usually implemented with an atomic
+	 * exchange, or linked-load/store-conditional. In case it is
+	 * implemented with ll/sc, the kernel needs to check whether the
+	 * conditional store has succeeded with the appropriate registers
+	 * or flags, as defined by the architecture ABI.
+	 */
+	__u64 post_cond_store_ip;
+	/*
+	 * For architectures implementing atomic exchange as ll/sc,
+	 * a conditional branch is needed to handle failure.
+	 * The unlock success IP is the address immediately after
+	 * the conditional branch instruction after which the kernel
+	 * can assume that the ll/sc has succeeded without checking
+	 * registers or flags. For architectures where the the mutex
+	 * unlock store instruction cannot fail, this address is equal
+	 * to post_cond_store_ip.
+	 */
+	__u64 post_success_ip;
+	/*
+	 * Address after the instruction which clears the op pending
+	 * list. This store is the last instruction of this sequence.
+	 */
+	__u64 post_clear_op_pending_ip;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
  /*
   * struct rseq is aligned on 4 * 8 bytes to ensure it is always
   * contained within a single cache-line.
@@ -180,6 +233,28 @@ struct rseq {
  	 */
  	struct rseq_slice_ctrl slice_ctrl;
  
+	/*
+	 * Restartable sequences rseq_rl_cs field.
+	 *
+	 * Contains NULL when no robust list unlock transaction is
+	 * active for the current thread, or holds a pointer to the
+	 * currently active struct rseq_rl_cs.
+	 *
+	 * Updated by user-space, which sets the address of the currently
+	 * active rseq_rl_cs at some point before the beginning of the
+	 * transaction, and set to NULL by user-space at some point
+	 * after the transaction has completed.
+	 *
+	 * Read by the kernel. Set by user-space with single-copy
+	 * atomicity semantics. This field should only be updated by the
+	 * thread which registered this data structure. Aligned on
+	 * 64-bit.
+	 *
+	 * 32-bit architectures should update the low order bits of the
+	 * rseq_cs field, leaving the high order bits initialized to 0.
+	 */
+	__u64 rseq_rl_cs;
+
  	/*
  	 * Flexible array member at end of structure, after last feature field.
  	 */

Of course, we'd have to implement the whole transaction in assembler for each
architecture.

Feedback is welcome!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

