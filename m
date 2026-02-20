Return-Path: <linux-api+bounces-5872-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VKkxF5vrmGkKOQMAu9opvQ
	(envelope-from <linux-api+bounces-5872-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 21 Feb 2026 00:17:47 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BE64E16B5D1
	for <lists+linux-api@lfdr.de>; Sat, 21 Feb 2026 00:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D4B773008C37
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFFE2DB79F;
	Fri, 20 Feb 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rzj5PZ3J"
X-Original-To: linux-api@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021091.outbound.protection.outlook.com [40.107.192.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924B227BA4;
	Fri, 20 Feb 2026 23:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771629463; cv=fail; b=ViS4r7IP8zU6ujeSDk7HYWmoIgXY69+amHlCnpXnKXJFZAtLCjVKF2Q0lpqNIanNfii0errtMneya5IJYas69zF2yf1zqx18Gj7vN01iJvehx0XTqmGhyaBuswEQ/CzJrQesZpf7hqOIow87wJzwwkvOAeDqJBQMtsT21X5ZJmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771629463; c=relaxed/simple;
	bh=dYnSWGXgGayrAMcnrxf48Yjo+a2Clwpc6k+2EpPlzKE=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aX6BKndkzt2tXsXysjhekOZ0EBlJtVsaXuQRPWEfvTw9rWK9oWFYgyzPnupv74IKQ/2hr1Mfm8UlPELHiqHPKf8XmMQPl1iEC7fpqldETw1yPb9MV+wVzsYFyub5/qCdwvhWOfPmwbgDAyvQbUiDsKfLE7ZUCLuMJ7KdclysRsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rzj5PZ3J; arc=fail smtp.client-ip=40.107.192.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3Y5jYZoarobEd7fH5uWF7/oDME/8/hfQjKTHvUNghTUTXrQM97vxh8VwEx2RE+bxJAXpgl9L8d3i3gtlCnxJdWweTyIBic+/6iucdgimaZYTKNZMP84Plj3W+LaHC1eiwIE7VVB1XGVw9XStMQm1frXekllwAM6TYDKE1xZ6sn4NPwxzqlu19npkjupKw1nmKgykzOvdb/Vjn1nz+iDy3FjdAKf8LGstl1u7GhgBjkFPipqoJ2pp/ZfiTjkA7Ve4TnaQiVO1Z9a+Sr/mycep2q2KXhHZsY9hf/7Mzpba4bmKGwwDr9+Su07HCwZm6qkKc301AwU9Ys6MZy/27LLaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX4T1ZsPZ+xUxW+fI8wHcN0lgvwYyd25TmqWF5lhUxw=;
 b=hFTI9ypg0muV82+ydLQhxJ19H9LQBDy5kFc6FlvsxeAmQOWC5oih0UwV2kqYV0kfrv8DlkjXeAbaF8rSoZhRr7wmoHKBqnLc7SCpatAox2rkVsFM2dakSO2R24CbWadzdChXtMcVCEztGkJuU8PpHBiP/hK9VngcErNXZ8A+foQbvfqpGJ73btUw2e0yGmmaTVoKEHaTZpqe7sWjym/KRuPEqYkMC00IEbjnyeHuRGfwwUQGgFAvyryKugr0IH+04yW7uflclLaHIjy5kWTczUto4MgchuS2OrGC50RGrbfQNr+1s6Rj4/9goN9G4gE3oj3R+Yz/ENIqb+FKzi0nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX4T1ZsPZ+xUxW+fI8wHcN0lgvwYyd25TmqWF5lhUxw=;
 b=rzj5PZ3JYpf7sGiQpu1U/P0lczgLMi1kaFbrsNsMtNV2QJCkf15g3JN+sFmZeN+qNzyDO8sy0NbVQ07mGDzoImsnY9Zax78LIWlTSVMLgByITOYQZAT1DklKhs5dNsRbsDlEUDVL6lhRmy7WTrWcm1nTEK2+3f2gygV5K7Y8bBQnvmyAWPLruHR3UHpJ/OSryQ7M51eVf5asHXr2/MZc9wsRKo55Dwyt2N5mtbU+Frh9gxZbNk2jx2eaHPSW4SDPcb5kaFuZUELeDEKNOiopa0616y6tpohn2KGTMoNyLNJj+l0z81CsaHX60qc3bQz5lSvNprL1wdvVNrxCFnS2ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9963.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 23:17:38 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9632.017; Fri, 20 Feb 2026
 23:17:38 +0000
Message-ID: <a1e24288-6ffc-438d-8a2a-d152134c9555@efficios.com>
Date: Fri, 20 Feb 2026 18:17:36 -0500
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
 <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
Content-Language: en-US
In-Reply-To: <67be0aa1-2241-43ef-aa01-a89ced26c8f6@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0144.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::44) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9963:EE_
X-MS-Office365-Filtering-Correlation-Id: 00573390-5dc9-40a0-2aaf-08de70d63cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWswa0FEa2hjY3dvalc3ZjVKY1hhdStLbXBqa3VFZWE4dW5ESXhFdHBNcndi?=
 =?utf-8?B?THhGbkVXanYwUXEwcnY1d1c1RFJVSW90Tm9Rb0g1UmkxTy9SYk96TVFvYlQr?=
 =?utf-8?B?YlFDMTRBTWZzcUpiRTNSeFpBamE2K2tuYjFnVlVra3U2UGs1cURPL1RQWWdn?=
 =?utf-8?B?S2s1bVRKUWc2UFkrbWpjZXpWS0RCMS8rWWx0YUowN2NTZUR0R2hiUHJYR3VF?=
 =?utf-8?B?OUQrUEk4MHVjL2FtS05iT3hqNTQ2c0Yrd2lLM2JpdzlzT2czY1dLbytSNUxo?=
 =?utf-8?B?b004SThVYkZ0OGk4WGJNczFVV0dKbkY4eGYxOHdDcjgrRG9uV0wwdmNZMTlo?=
 =?utf-8?B?aWRROUNZa2tTRm9TdDVWZk1SL1pKL2QyckVKVDhmWXNSZjUybmp6a2srVVNT?=
 =?utf-8?B?WnZWNzNkaGhWRmRuQlMzZXRRd24yREZnc2w3OWU1eVdMWkMyLzFaa25WUlVG?=
 =?utf-8?B?NEZIVjVGN3A0aXdkbXRuV0t5azRyMGJ4cGtLREQ0Um9JbGQxckJGNHVWNzVJ?=
 =?utf-8?B?Y1k5cktVZXRLMlFKMmhENnNSTVhGamFLbmtTT2wyc0E2Y2ZoNDNwMHdrQllw?=
 =?utf-8?B?QndQWU5tVEY0WjEvWFNUamJxbnNoczJZcURjNlgvSG5mZWdOdy9WeXN0S2JN?=
 =?utf-8?B?dzY2bWxJRnREZUpsT0U4dHFER3Z0Z3JCQ2FOemwyRFduc3dCR3BpY2paMERZ?=
 =?utf-8?B?OFlNcE1RakhUMmw1TUJVb1NMamYzYUlIL2pKOVN0em1zUDRFVjIwZkN4S3RL?=
 =?utf-8?B?L1J1ZDhsRVRRVXpPVGphdzA3S1dtTEhJWTNIanh5bG9ETTRyejBLMU91aURE?=
 =?utf-8?B?QjM2S1Eyb2lvayttZFlMRjFjMGx3YnFGTm5DUTFEeGRES1dYRWhxZ2tKVEc1?=
 =?utf-8?B?Z3JxSjJ1akRib3UzS1pydnpTSnU1cTBsRWNoOHJQdlBQL09Kak9hVGx5R1U4?=
 =?utf-8?B?d212ZEhYUDV4V2pPanZ1WVNTL0hrSk1aQ2hLL29kMXdRN3o0RDRGSzFSM0xR?=
 =?utf-8?B?Q0d1U1VhRFJxK1JvNTB6YTFmWnNuWFZ5U0k4SUUxNWNYNXdnN09qR3hSNWZW?=
 =?utf-8?B?Mks2NHlSV0s5cTZ0OWtpenBHUk01eXV3MFhkdVNiYVNjL1lqMXBKUS9QcXZp?=
 =?utf-8?B?UDQyaGE0K3d6OXJFVmtXR04vd0kxZEFaajhMMEFuWEJML3hjYnA4a1VuT0Mz?=
 =?utf-8?B?bW9EM0Nrdy9MNzJMTm50MFdoU1lCUWRQTklxTnBWV243SEJUZjRpWEZCR3BD?=
 =?utf-8?B?NkNiT3BLRk1EQlF4K0xYUW1HMFYvOEdqa2ZMWXM0K01TSllrZ2hubzBramhB?=
 =?utf-8?B?R2g5Zjl5Q01HZjM4ZHRZQTF1aUc2THVSMHpxYndmQWxqZ3RaYStLbWUxWXV5?=
 =?utf-8?B?N1lCUytVY1VrTVIwZFJGNGJRMklLc3NDOHhycXVub0NVbXh2RlJpQ2ZZNUpS?=
 =?utf-8?B?dDhxVVhNOEZBM3dRUk0vMVRWYjZmZUJGUHgvTU95aFRzSDhiVzVDMlJqM1M0?=
 =?utf-8?B?ZjV6blJBa215R1ZKeG5FRDhjT2lvNEE1MHFrNmprZFhJWFcxMitjdFUrekhC?=
 =?utf-8?B?YThVYUZkRVVoc0piZzhZL0N4U25qWXdEYWJYcDUwajdaVE9BZnBEaTJqQWxp?=
 =?utf-8?B?UDNpVnlneUg5MGpUaEhaanpDcDM1Q0dPc0kvSGlHNjlFYkNxcTAyeDU2NHcv?=
 =?utf-8?B?Z2lIY1FuUEtETXlvaSt2NVlWU2hYTWtnVE55cVJSNlQxbnZIWGFkOHI1cHdG?=
 =?utf-8?B?VFZ1WlRZMm52ZEZBRmpWT0gydHhHVzdaSmEzbm5JR1ZVaEdWQU1VVXlkNk9N?=
 =?utf-8?B?RHl3V1ZlRHNMMExOdGtSYjNpSzUyT1U5M0kwZUExb2hRSXlNN3F5TXpDYm1a?=
 =?utf-8?B?UHU2MDQ1MmpQSGs2U0FxMXE1TWdVQVp0clRXNXNsd2g0VUQ1S2hHa3hoUFAx?=
 =?utf-8?B?VzhNQ3BqMmplVTl2a0lDZXc5NW94WHlUbnB1ajB2Ym1xblM4YU9LQi9jT3dn?=
 =?utf-8?B?dGdoNlAxVmEvdjVTSU03U0V4OEJRSWhaeGE2OFI3c1ZYVkoyZDNxU3JHcit3?=
 =?utf-8?B?TmxBVFdYbmFVQ2Y3Y1M0RVZQR2xKSEtnM3ZMVEgvemdHRGk3KzlJZkpmUlVY?=
 =?utf-8?Q?vmlc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mkw2YzFUd21LdjNhZGpNZW5jSnlLQms1YnNCUHdWekJydDdxcHBtZzBqNzVx?=
 =?utf-8?B?d2FaeEJDc2xoYjFDSkZIZWI4QlhQRkR5RytmdmhuQkZuSWpQTHpVSG5ncWhD?=
 =?utf-8?B?blkzcVRRUytFTjkzejVkYkh2bUx1SzlJQ1A2ZCtqeVlseXVrUEk4OHJqSUVD?=
 =?utf-8?B?Qkt2WllLc1JuL3RjUjJ6OTRsbkFxYjFrMms3eU1qTk5QZjZoU0RqQkk5cVhn?=
 =?utf-8?B?UXRzL0l2cWFaMnFzbGYxR0JJb242UHVPUUZSOWVabEFKeU9QWXRUYjF3bjJs?=
 =?utf-8?B?a1VOdG14QlZZd2tjektpMW45TzVmSTJLMnlocW5waTNsSWdjamxYUjZtUGF2?=
 =?utf-8?B?RWgxSEZpL1hSa3JqalJRMllzS2RxOXBUamdFZ0duRk5MV2JaWFh1TFV4NEtW?=
 =?utf-8?B?TUFzK0gwRkFYRVJJUUtEUzZ6cnk2TkgrUHR3NTZ0UmhUbG1BajJGaVFSTmps?=
 =?utf-8?B?ODFWMy84ajFjQ3Q0aGVSbXF0TlB4RHNHRFN6VFEvSVVNUzlFVGI1b0krVUNa?=
 =?utf-8?B?bWZFQnE1ZmY1NEozSDRDaFpadEtOaGJPZXV2K1pDdHZTN25PVjhzdGF2WjQ1?=
 =?utf-8?B?eG9pTzF5aEYzOFh6bEd3YXJwMVUzS1U2ZzZPMi9RVkxmNHJ4enVwUjVLOW5U?=
 =?utf-8?B?V2EyOVA4Y3E2YXBaYVpJQnlmem1IODFncDFrRTZrT1k4RVBSRkJrdVUvREpQ?=
 =?utf-8?B?KzBLNm5NMGo3aFVtNUtUbDlUNkVlbjY2SVhxT1h1bmpoVCtqSEZCU1VKdVN0?=
 =?utf-8?B?dy9SU0FKeFptYURQNmVmVkdJZzJmTm1aaDgvTnpMVTFudkVkY29jcjNQY1E4?=
 =?utf-8?B?SUk2RTVlUWd4QXlJWDZZdlJVM3lHKzBxeHRpVi92ZzR4QmlDalFNQzcvUmhT?=
 =?utf-8?B?U1ZKMTVPd2hFcFEvaXp0MWZWRVMwWnJoL1orVjBKTEI0Rnd0ZWNSNnNjaTE4?=
 =?utf-8?B?Ym52cXdFVmpiS1dhdmxTRnlEQlNKRUh1dTRabzg1TzhqclhhRjZ6Uy9rOXIr?=
 =?utf-8?B?bW5CZERzSHY1WnVqSnJSako5WUZWZHZOeCs5V3A4dDl2dVlYb09UcUprT0No?=
 =?utf-8?B?azlrQlBScnBVNjkzWXFIVnFISnJDanFyWG5tNFpSWnRtNFowdkRzQlhqTDd0?=
 =?utf-8?B?RUFmL3R6TU1RTTRtRlUyblRYOXhZKy9mRVJMMHlVbC9ncEJMSDZ2dHBQWWVI?=
 =?utf-8?B?bmtYejRxYUZOcVdTLzRsd2ZSYUVCemxYeVEyRlFqeEdXbEQ1Y3lqbkVnUFg0?=
 =?utf-8?B?K0NSLzRSWlUyTzJUUGc2RXphaW1ZOWNyR09QK1MxYmd5QTVndlBEUkRGNENM?=
 =?utf-8?B?Sk1iMEM2OW5HWVdEN28zdmJkQnJ1dDgra0xrVG9tZXcyV0podGZsK3ZrNGlp?=
 =?utf-8?B?TENMeW1HR1JqOXBtSXdNMXZSYzNVQURJYm1vRmpBZ0Npcmo4Zk9hL0kzeEgz?=
 =?utf-8?B?Q2FLUFo2M3VNSEVCMzl1MHlMRldVSWpZd3BwWlhOMVdCT0l3cmZidDVHalJT?=
 =?utf-8?B?R3RuWXYwajh0RDc5U3RpVE1oNFdidmZoWHYxVGtKS0dmNlk2cktpRHVhaVZz?=
 =?utf-8?B?cXRnWHRUcXQxcjBOVWZjZ2VDOVd2c0prb0xqaGUvdFdrN25PcXdyeEsxRzB0?=
 =?utf-8?B?UFZiaDJ5RHBneU5IUEhER0lCSW05c2lWMUhxYTNGc2l3Q3VvbEdFamlSSXVB?=
 =?utf-8?B?VEROVTNiU1I2OHJJWXA0RUt1Q2J1R2J0VHpOaDFYZU1qZWpNZzUvNXlaRldI?=
 =?utf-8?B?UkxDVDAzOTcvYzUySWhhTTZVSDRYWGliRG5kNVBrWk9pYkNmL0IrTEU3SG5Z?=
 =?utf-8?B?dFJKWU5PeXhxS0hHWUJzRXg0b0xiUmRnaU1BSHpSai9wM1grYUNmTWJDL3Qy?=
 =?utf-8?B?cVQ3amhvK2p4U0g2VVhCZmxHZURmVWpFNjJIQ085SVQ0TldMd3kwc3hhOWV1?=
 =?utf-8?B?cGdWTGJaVHJqanl3L0FWeFJqQ2dmVFR5MkYyS3NwOSsyMEZBaVdpdHhCUEJx?=
 =?utf-8?B?eXIzUGg2UkJzU2Viai9BMk9pTzNyc00vdytpenN0OG4ydkRGMDdVUEE1NXZ0?=
 =?utf-8?B?cC9TZDI3ZTBjOVhtUkhHY1hEandLaUwvN2hMd21JU2cxeDlnbHBlWDl5b1hB?=
 =?utf-8?B?Z0o2OUJtSmJmUUgzZDlvZ01oRUMzaVo3dnBBdkt0dnN0aUNHQ1dHbElkVkUr?=
 =?utf-8?B?RlJDQTREWUdqSTlpcXpTWEdkRGZSdGYwQ1ZIU2gzaERqQ3A4WmZ2VkRlTkNC?=
 =?utf-8?B?RmJmUnljYnYxKzlIUUZ0cnJYUS9FUVRiTk9HSzBLa3JuU0hzSGw3TVFNZE53?=
 =?utf-8?B?SFZKd1FEMXJZakx4eHdQSnV5bHMzQzRsWjF3ZEFMQVo5aStVR1FES0c2dVdC?=
 =?utf-8?Q?l+b0NM9DR79BBgiA=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00573390-5dc9-40a0-2aaf-08de70d63cf1
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 23:17:38.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U84ySYSj1c2ivgPrv6wjOqff5arnHh/8MEawyCRuYITd8wBlOgb3aON+CIj3gXbM9CafTjuYWYlnAspd/BWVALf9G68iWWhcRespHhFtOHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9963
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5872-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE64E16B5D1
X-Rspamd-Action: no action

On 2026-02-20 17:41, Mathieu Desnoyers wrote:
> On 2026-02-20 16:42, Mathieu Desnoyers wrote:
>> +CC libc-alpha.
>>
>> On 2026-02-20 15:26, André Almeida wrote:
>>> During LPC 2025, I presented a session about creating a new syscall for
>>> robust_list[0][1]. However, most of the session discussion wasn't 
>>> much related
>>> to the new syscall itself, but much more related to an old bug that 
>>> exists in
>>> the current robust_list mechanism.
>>>
>>> Since at least 2012, there's an open bug reporting a race condition, as
>>> Carlos O'Donell pointed out:
>>>
>>>    "File corruption race condition in robust mutex unlocking"
>>>    https://sourceware.org/bugzilla/show_bug.cgi?id=14485
>>>
>>> To help understand the bug, I've created a reproducer (patch 1/2) and a
>>> companion kernel hack (patch 2/2) that helps to make the race condition
>>> more likely. When the bug happens, the reproducer shows a message
>>> comparing the original memory with the corrupted one:
>>>
>>>    "Memory was corrupted by the kernel: 8001fe8d8001fe8d vs 
>>> 8001fe8dc0000000"
>>>
>>> I'm not sure yet what would be the appropriated approach to fix it, so I
>>> decided to reach the community before moving forward in some direction.
>>> One suggestion from Peter[2] resolves around serializing the mmap() 
>>> and the
>>> robust list exit path, which might cause overheads for the common case,
>>> where list_op_pending is empty.
>>>
>>> However, giving that there's a new interface being prepared, this could
>>> also give the opportunity to rethink how list_op_pending works, and get
>>> rid of the race condition by design.
>>>
>>> Feedback is very much welcome.
>>
>> Looking at this bug, one thing I'm starting to consider is that it
>> appears to be an issue inherent to lack of synchronization between
>> pthread_mutex_destroy(3) and the per-thread list_op_pending fields
>> and not so much a kernel issue.
>>
>> Here is why I think the issue is purely userspace:
>>
>> Let's suppose we have a shared memory area across Processes 1 and 
>> Process 2,
>> which internally have its own custom memory allocator in userspace to
>> allocate/free space within that shared memory.
>>
>> Process 1, Thread A stumbles through the scenario highlighted by this 
>> bug, and
>> basically gets preempted at this FIXME in libc 
>> __pthread_mutex_unlock_full():
>>
>>        if (__glibc_unlikely ((atomic_exchange_release (&mutex- 
>>  >__data.__lock, 0)
>>                               & FUTEX_WAITERS) != 0))
>>          futex_wake ((unsigned int *) &mutex->__data.__lock, 1, private);
>>
>>        /* We must clear op_pending after we release the mutex.
>>           FIXME However, this violates the mutex destruction requirements
>>           because another thread could acquire the mutex, destroy it, and
>>           reuse the memory for something else; then, if this thread 
>> crashes,
>>           and the memory happens to have a value equal to the TID, the 
>> kernel
>>           will believe it is still related to the mutex (which has been
>>           destroyed already) and will modify some other random 
>> object.  */
>>        __asm ("" ::: "memory");
>>        THREAD_SETMEM (THREAD_SELF, robust_head.list_op_pending, NULL);
>>
>> Then Process 1, Thread B runs, grabs the lock, releases it, and based on
>> program state it knows it can pthread_mutex_destroy() this lock, free its
>> associated memory through the custom shared memory allocator, and 
>> allocate
>> it for other purposes. Then we get to the point where Process 1 is
>> killed, and where the robust futex kernel code corrupts data in shared
>> memory because of the dangling list_op_pending pointer.
>>
>> That shared memory data is still observable by Process B, which will 
>> get a
>> corrupted state.
>>
>> Notice how this all happens without any munmap(2)/mmap(2) in the 
>> sequence ?
>> This is why I think this is purely a userspace issue rather than an issue
>> we can solve by adding extra synchronization in the kernel.
>>
>> The one point we have in that sequence where I think we can add 
>> synchronization
>> is pthread_mutex_destroy(3) in libc. One possible "big hammer" 
>> solution would be
>> to make pthread_mutex_destroy iterate on all other threads 
>> list_op_pending
>> and busy-wait if it finds that the mutex address is in use. It would 
>> of course
>> only have to do that for robust futexes.
>>
>> If that big hammer solution is not fast enough for many-threaded use- 
>> cases,
>> then we can think of other approaches such as adding a reference counter
>> in the mutex structure, or introducing hazard pointers in userspace to 
>> reduce
>> synchronization iteration from nr_threads to nr_cpus (or even down to max
>> rseq mm_cid).
> 
> To make matters even worse, the pthread_mutex_destroy(3) and reallocation
> could happen from Process 2 rather than Process 1. So iterating on a
> threads from Process 1 is not sufficient. We'd need to synchronize
> pthread_mutex_destroy on something within the mutex structure which is
> observable from all processes using the lock, for instance a reference 
> count.
Trying to find a backward compatible way to solve this may be tricky.
Here is one possible approach I have in mind: Introduce a new syscall,
e.g. sys_cleanup_robust_list(void *addr)

This system call would be invoked on pthread_mutex_destroy(3) of
robust mutexes, and do the following:

- Calculate the offset of @addr within its mapping,
- Iterate on all processes which map the backing store which contain
   the lock address @addr.
   - Iterate on each thread sibling within each of those processes,
     - If the thread has a robust list, and its list_op_pending points
       to the same offset within the backing store mapping, clear the
       list_op_pending pointer.

The overhead would be added specifically to pthread_mutex_destroy(3),
and only for robust mutexes.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

