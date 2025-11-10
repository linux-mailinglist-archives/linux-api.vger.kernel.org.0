Return-Path: <linux-api+bounces-5190-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C1C45D52
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 11:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F78B4EA1DE
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 10:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC1E2FC866;
	Mon, 10 Nov 2025 10:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="BlDRJEdx"
X-Original-To: linux-api@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021126.outbound.protection.outlook.com [52.101.70.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039B8193077;
	Mon, 10 Nov 2025 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762769173; cv=fail; b=M2x7gTE0p6iJwkY9Tmkl5/joZ8KveZ3Fggyug6k0C3WgN/6CnaCD2NgMaE9cNVa1u0jzw0hRfdueHkxwF8nOQ7K5Iv0ISyE2rVQ2CvvXCWmyDlA28xP7FGdu5eHrQWcZ/r3QmK363yT+LYprMQx0SF5JXlvO3NugElNTRNko7zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762769173; c=relaxed/simple;
	bh=HX1fXSjTtLlmhw28kz2idx3fW5Ke9uxV71AJzbZpZB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LtihBp0+joKC4r1oekClgXgeisiJ03Nwd4OKwmX9WQP9x20PEjYmnqRcYwsiWlxebrrI/HgKQbAOa5oQLgoJ8TTCKLSqvH6f4dP+AliKl+0DDlYgiGZWsvBhB4HLvrG3BZNquLB6GVgXGg85xtwLK6XwU8K2zvefvMx0IfbykPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=BlDRJEdx; arc=fail smtp.client-ip=52.101.70.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRH+k2SGVJXo5yNfWKxVVlRAcdTfeumsoi0woCoYFDFhc2vWLlJWF0pi+ElKP4S7DlQ/if9/X3X3tZIUpzgIfUFLvk2or4VVhJUNXaIDPId8ewC9G+Ovk1ROWs4Pjsf6XaNVKJK+JAv9jV4i9GIPLnSZW3TcvwGqCMG8b3i9OWA5jwY9xcrXtT2Gl184r0T7h3wksno5Ui5kimmrGHF5ZMyIEFLB4tkD58HOtc16+57IQTdRKAi46ehvYECWaMkKpSfzbV2DXzAKT7mcHOi0EWMbHQm7NtrT54YKetmwLxXjYK8tjzMvgwa7MXtmj+AZslcsoiT0sd/gZaaJY4MWow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HX1fXSjTtLlmhw28kz2idx3fW5Ke9uxV71AJzbZpZB4=;
 b=JQGITyyoRtVW8A7Cuf4LAer+ZyjEjsdi/vP8jdlW5j87eVUzOwRJFWVPVKXwqqXa7648Wkj4MwYqTrfi5AmqoHloM4QymCysIrnEtwPeJRYCUzrAgWZ8i3+CGgUmuO0kLBGkFuospRTHrk+iHYBdqvHZgwRDDvmAKfO6cOVghzSPgAtmw/M0XMYgRipzNXQEEbBAEBYLQJY9rXMj0rfwvFtYc1tiCQMbzQR/iAHniUHfAACM4rOGgOMT7IzhPncQ+CdL+ieacu8UHk6HqXttaXoLteSIuD/dI5JotLYfC7zA9+hM4SjYR+iiFg3x6WB3VsaNWuBN3Rv97NaIDpEbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=zytor.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HX1fXSjTtLlmhw28kz2idx3fW5Ke9uxV71AJzbZpZB4=;
 b=BlDRJEdxx2PUpLmchG2OxzRbO6/booDTC5eZGFds2jEvMmk2Cyx78JXCxAXzpTeGXI/KL/BOYaGdzQiKsS5XFdNLSDrAi3MAHiigX/AckiTa2VUXaRn5KZI9ZbMz08y3V4N7m3USME/Ti8hyvJxvVYi7iwIf0Ptm/ZiL/021VNghkC5LbJrtEHu6VyDXQhSvtOOi8fdzfB3xaAb1vytIKKFIsEaYLbbEqfrgvVo9Fgx9iMkaw7Ql9skWdJtqtbtYFWoDnbfsxrqVGEj2wzuXjje66ln56j6uF2UCTqHtYGXo52rQ7HLqzaOCvz2CXKq7XHbgpuQu+ru8AQgExA1CXA==
Received: from PAZP264CA0076.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::23)
 by VE1PR05MB7327.eurprd05.prod.outlook.com (2603:10a6:800:1ad::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 10:06:05 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:102:1fa:cafe::ea) by PAZP264CA0076.outlook.office365.com
 (2603:10a6:102:1fa::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 10:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Mon, 10 Nov 2025 10:06:04 +0000
Received: from DUZPR08CU001.outbound.protection.outlook.com (40.93.64.64) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 10 Nov 2025 10:06:04 +0000
Received: from AMBPR05MB11925.eurprd05.prod.outlook.com (2603:10a6:20b:6ee::7)
 by AS2PR05MB9814.eurprd05.prod.outlook.com (2603:10a6:20b:5f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Mon, 10 Nov
 2025 10:06:02 +0000
Received: from AMBPR05MB11925.eurprd05.prod.outlook.com
 ([fe80::fced:b7e5:3955:da18]) by AMBPR05MB11925.eurprd05.prod.outlook.com
 ([fe80::fced:b7e5:3955:da18%6]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 10:06:02 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "H. Peter Anvin" <hpa@zytor.com>, Theodore Ts'o <tytso@mit.edu>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: RE: RFC: Serial port DTR/RTS - O_NRESETDEV
Thread-Topic: RFC: Serial port DTR/RTS - O_NRESETDEV
Thread-Index: AQHcT7uhG+hEZgj7wUKBeliUjNaa5bTnevqAgAIlvwCAAaYOAIAAF5IAgABSP/A=
Date: Mon, 10 Nov 2025 10:06:02 +0000
Message-ID: <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
 <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
 <20251110033556.GC2988753@mit.edu>
 <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
In-Reply-To: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AMBPR05MB11925:EE_|AS2PR05MB9814:EE_|AM4PEPF00025F97:EE_|VE1PR05MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: b07495e0-2f8f-4ae0-5895-08de2040c2b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?MEFualBlTTU2czg3MlZWYXVBN0dHL0Y5UU84SlozVmJjMGo5VnZZNUhTRlV5?=
 =?utf-8?B?aFBxbXVNQXJUV0haSllOTlFKZ296SzNjQmxNTDBWc3g0TlY5VHpReXplYWZP?=
 =?utf-8?B?MTBmaU4xbnVyZXloU3I0aVNWdXhvS3hYL1JGTW1mK0hza2swaTRZSDI2VXhp?=
 =?utf-8?B?ZGN3WFJtbldwRjNYVXBQM0kwZkZKRW02YSsxM2Z3cnBGOFpGSnhSWTFIV1lT?=
 =?utf-8?B?dlYzSGx0WS85b2gwSTRHdGp5b1B2SFQzVnJ1MnFkU2c3NGVUby9scVZqRUxS?=
 =?utf-8?B?U2tJZWtzeEhnMExKaVA4azA1Q2d6VXhtSkRwU0UwYVgwMlZtdWErcGZRaDlT?=
 =?utf-8?B?N0ZtR3hja2s2UWo5UDZQNkpoclBXVHZiVVgxMnY5dVVJOHV5V041NkJQRENy?=
 =?utf-8?B?bFA2T2I5ZzVKdFZRMG96SEVmVjYxek1tbkRFQ2hjeUE4TlhKVi9WY3NGRE0y?=
 =?utf-8?B?Z3pTUWVNb005ZEVCVDBGS1RRd1VYbFJoZ05DUFRqV1VETUhWRklaYUN2NHhi?=
 =?utf-8?B?OG9mVENKN1BnZXNxWThrQVJlTVM2ZU4rOUZhaSt3UXBzM1c1bmZJUHlOSEFm?=
 =?utf-8?B?R0t6eDdidjk3RTVLRG1hMHhrMnhmUUs3T0tBUVdLZ212TkorV0s1RWxmUk81?=
 =?utf-8?B?L3NiSUJaN3JoakkyS1FiYTlrUlpGMlBOUEc2MVF1bFZ1M1hXSXV5clhUaE9n?=
 =?utf-8?B?VTZqY1k2cE9wSHdOWkdGNWtuRCttbXUwc0s4SjFSMjJvVGhPbit0VURDK0Fp?=
 =?utf-8?B?MXM3UitwaEI1aG5IVUtzYlZnbUpPeWw5elJtS0hvcWl1djVvSW11eGNsR3Rq?=
 =?utf-8?B?c2tPdkhpTkloSTdVOU1WbU94REJZTStoRkJOSUNMVm0xRzAxWHpuZHhrZ1dj?=
 =?utf-8?B?M2tlY2Zuak1zcFdQa3hXc1hvbUVhODBPODQvK3k4TFdYamVISitRQVJSbEhQ?=
 =?utf-8?B?U2dVeFc1bjJzS1hEWEFJR2NaMU03YkRGa05XUjZGb2tEdjNZUnpwZHRmVEd1?=
 =?utf-8?B?NHEvZi9raGJjbXlVeHNtRTRkREtUcjhhYzlDZUxqVUs4eCtzTEpjaEtsZTZH?=
 =?utf-8?B?eUN5UStBYlVyY1lmemNWNmJrdlhJWGdYcG9zeG9BV2FCZlZlZjgyTG9WZFVK?=
 =?utf-8?B?MzFpTm5KVWFHM3dUdkc1ZU41ck5oLzc2eHo0cGRPclRkczNlUlErL3Z0eW1B?=
 =?utf-8?B?amFYRHBIcGNBZkFTU0lNdHdJVE5CZnF3bUdjWTlRUWFwM2dnZURWYVhVK0RF?=
 =?utf-8?B?eHduc2pHL1FoMlYzdHF6T2hqTHp3Mkx1czdNUmxxd0RFLzBLS0VUbGpYcmk4?=
 =?utf-8?B?bzVsaE1rb2wySzJkd3orS2dZNVZUdWovYmlkVVFkdDg3MU1QRHZRNXNiNlRo?=
 =?utf-8?B?ank3YkY3ZGg0RktqeUUyVG5GWnQycU1aUzg5ME04SVlaUzRwZzRqQWZYT0hH?=
 =?utf-8?B?TWU4WHBMZmJsa0lLQzNkZVBwRm5SZXJ1QTB5RytHS3dMY0RRQ0JVclR3NkJO?=
 =?utf-8?B?OUJVWjRaQTZGMlRDWkp5VWFlNGFvblJnOVJ1WnlIS1N1dHh1cHhuTnVUa0hR?=
 =?utf-8?B?RlcyUmQyem9OV0FpOURZSEcxVC9Hb3hJdURZR2EzQU9iWjZORmUvZHE5R0hG?=
 =?utf-8?B?RjhtNGZ5K29ZZDNoMDFBaDJuYUVvb1pRRzFNbkRwSEJNelRBcW92MlhEb2FW?=
 =?utf-8?B?QlBKazlMSGp2aGFIRU5kK2lVQ2J6d3VieXpCZlZzWTdYVVlKdUppaGxHNmRl?=
 =?utf-8?B?WWNMMEF1VTczc3BVQXlBUkNMTlg1QW1YbXA2cUlHTjFCcEo5NHEzVmlZaERF?=
 =?utf-8?B?K1R5TytKOXpWTWJ2WERsdEl4dnhlSmJRS1h4MnhPNEVzK1JCbmNYS2VGcjBX?=
 =?utf-8?B?b1RPelFDS3RsWVVQanZJeFgrTGI5MkNVTzRjT0JWWjZVMlNuNStDQ0o2VTQ2?=
 =?utf-8?B?ODN2V2EyYk81NzRNZUNsK210dlBCODlqODBFVGMzeXNiYUFDZVBLM01SOWl2?=
 =?utf-8?B?dG1JclFCMFFDdUFpZE5FRHN2UDVoVUpYbVpWS2RJYkNXb2QyVU1pR3FDS2RZ?=
 =?utf-8?Q?rSfooO?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR05MB11925.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB9814
X-CodeTwo-MessageID: c21987b7-4efb-4bcf-8576-dac04bbc5bd8.20251110100604@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b4353e86-e083-4edd-1dec-08de2040c121
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|14060799003|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUN1ZzczZGpJWnBUcUx6bXBEYVRMYXFGa0swanJzY0hmdkhzTndXRVNsUkpD?=
 =?utf-8?B?eXpvWmRaZEh5ZGRQTEhhMUpYQllxSUlpSWUxcDl1alVoa3NZZDNGMkRRcnVT?=
 =?utf-8?B?eWxndVVVL09LRGNaQ3ArcHc1K2ZGNG5NbEhodTlLS3F2YVJ1ZkRTZ1ZCNG1U?=
 =?utf-8?B?ZStZSkZvUVBkWXByS244M29VdXNTWkgyWnVKamFmSXBtU0M5UER1UFl4QkU3?=
 =?utf-8?B?NlRoczBrbnBoYjM4MlJCeVhGVFkvbE9YaUM4R3ZqQkxrMjZFYzhPZEJWREUr?=
 =?utf-8?B?bXIxR0pOUlc3TitBMldQUWxUL0Qxa0RBdXN2cmxqUUJHNlIwOXh4UEhMMVBW?=
 =?utf-8?B?cmFLS1Y3VHJhOG9seHRMaEpKSFBrZ1I0clRJLzI5SWJHVFVHeGdhZ0MzK1hF?=
 =?utf-8?B?RjBmYU5VWGNWajFDNk96TUFBRExib1VWZXplZFZzNTlPV2grWVZ6a2NrWjAz?=
 =?utf-8?B?Q0VTUFN6SFRYdkw3SG9yYi9hZHRiUWVIeEFNNXd1YUxTYUFiT3lXTm1XdjFZ?=
 =?utf-8?B?ZEtTYzhMQVZxSVRhZVYyZW9yd2xBZVJ5WnFvR2JBSTg3UXMxOW1hU01GQVRG?=
 =?utf-8?B?My80YUpoOUN6SEYxMjdMNFlvTG16Yy9jd0llRHpOMFgvNXFrOHFyZnJOM3JU?=
 =?utf-8?B?MTc2Lzg5YktRK0xmemRPMklOaFVzNktCZWgxYUZiT2d2UklVK0xUeHlHRmFJ?=
 =?utf-8?B?RE0rejR5MThZdDREeFpYZUlNbGNydWl1N09hejVyVkZmczFvR2M4K0Foenh3?=
 =?utf-8?B?N1FRNFBEN1Z4eDE1NGlyYlZFMWdoaGtTbFU5akhGc0Q5MFBzSWkxWkhmUlFy?=
 =?utf-8?B?WFV1eWQzSWFLa0RwOC8xZVI3WlNGaHgwVUR3bFM5Y1JKVjRQUlR1dlNNcm9m?=
 =?utf-8?B?MTJNNXJEUEE2Yi9lRzNWRGw0UWUyQWtmMzU2VTg5eVdCOHpqZEpjRVlpbFg0?=
 =?utf-8?B?SkJUWWt4ZlY3blFuN1BPVFB1U3lDZER6dUtWRHNWbE9JVjdjcW16Qjk1Rjg1?=
 =?utf-8?B?MUg3enUxdUhGMkFYcTNkeDRVTHZGMjUwOWFCcGwvd2hHZE4vd3dPNXdtbDM1?=
 =?utf-8?B?WWdqMnJKaFNZWXQ3RklOdzNyZjZHZmFFOWY4SHZ0MUJ0NWVOMGRKRmhJVHVH?=
 =?utf-8?B?R25aaVpMdzJ5SUhHejRjdGNkNUtra3ZvV0Z2UE9pbDgvNDBYdXRDMXZOazRt?=
 =?utf-8?B?REkzeUNENE5VdTRZL2FJOHR3TzlIcExqcWJzYVJqMG04ZDRjbHI1WTRrK09q?=
 =?utf-8?B?Rk5kaDEzZVhkM2RwWXgwdmVYcmdmeFoybTBCOHdPTWdWcVdhZk9JamtKOTI4?=
 =?utf-8?B?NHNaM0IvbUg3WXcyTkJ0QkxLem5TM1d2R3FwQ0JNNUhRWVRFWWZROGc4anJS?=
 =?utf-8?B?Y2ZyeWNUZGJqUFhMUUZDZ1RRazhaNWNEM2NNZ29ZVHZFWWVTTkMxOXprUE15?=
 =?utf-8?B?cmpNaFlnclNpY2paV05oMWVidjdKUDhjYk4ySWh4NFpDZTNIN2hoMnVCMXkr?=
 =?utf-8?B?UmdxUW5PUU5WRnhYM0lmakRBVTJjMkRhbVhib3hMN292dVJrSm54WmFNay9q?=
 =?utf-8?B?blNwd3lTb1lkbVJUaEU5bitta0JXYUpCRTZudTVCOU9LUnZVdklmUUZQUWND?=
 =?utf-8?B?OFZQK01Pd1lBNklTUldINDh1bHZrN0ZGL1ZRTFpBa3NEQk1YYUJWaHo1YXAy?=
 =?utf-8?B?SUhRemVDbmNxZEdrQ08yek92RFh2V0hZVjlCaUs1NlhEUlpOekVybjViZjdl?=
 =?utf-8?B?aUNkdmVGZjVmdGJjZzQyL2tnOG45cjJUalhGa2YrQXc3YWVKTlc0RXlxUlhl?=
 =?utf-8?B?L3RuQ3MrMEs5YkhPeVV5SkxzdmdQb1ljWHM4UEFrbzJYT2pTc2xrQit1ZkVy?=
 =?utf-8?B?dkZ5VlZGS1l1SHFuOGNNcmc5RVF6Ry8zSkM3UWh1am1Zd0RvZXJGOVhzVms5?=
 =?utf-8?B?OXhHdjBYa1dFMVVha2VubjREYzYxb3ZIZVZtK29UR2tMTmExL09PejIwRzE0?=
 =?utf-8?B?Rm53L0VKaEdraUZ4RCtzcjF3RkNRSU5qL3ZzdVd6aE44TjBkVWFhQTNOcTd2?=
 =?utf-8?B?dWZRSHQ4OHN3Wm5QcVNEdEcwTWQ4OHYxS3E1amJsanQxdW5sbGp4L3hzUXY0?=
 =?utf-8?Q?UCn8=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(14060799003)(35042699022)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 10:06:04.9373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b07495e0-2f8f-4ae0-5895-08de2040c2b1
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR05MB7327

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBILiBQZXRlciBBbnZpbiA8aHBh
QHp5dG9yLmNvbT4NCj4gU2VudDogTW9uZGF5LCAxMCBOb3ZlbWJlciAyMDI1IDA2OjAwDQo+IFRv
OiBUaGVvZG9yZSBUcydvIDx0eXRzb0BtaXQuZWR1Pg0KPiBDYzogbGludXgtc2VyaWFsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtYXBpQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8bGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBSRkM6IFNlcmlhbCBwb3J0IERU
Ui9SVFMgLSBPX05SRVNFVERFVg0KPiANCj4gT24gTm92ZW1iZXIgOSwgMjAyNSA3OjM1OjU2IFBN
IFBTVCwgVGhlb2RvcmUgVHMnbyA8dHl0c29AbWl0LmVkdT4gd3JvdGU6DQo+ID5PbiBTYXQsIE5v
diAwOCwgMjAyNSBhdCAwNjoyNToyMFBNIC0wODAwLCBILiBQZXRlciBBbnZpbiB3cm90ZToNCj4g
Pj4NCj4gPj4gVGhlIHN0YW5kYXJkIEVTUDMyIGNvbmZpZ3VyYXRpb24gZm9yIGl0cyBzZXJpYWwg
cG9ydCBpcyB0aGF0IGFzc2VydGluZyBSVFMjDQo+ID4+IGV2ZW4gZm9yIGEgbW9tZW50IHdpbGwg
Y2F1c2UgYSBkZXZpY2UgcmVzZXQsIGFuZCBhc3NlcnRpbmcgRFRSIyBkdXJpbmcgcmVzZXQNCj4g
Pj4gZm9yY2VzIHRoZSBkZXZpY2UgaW50byBib290IG1vZGUuIFNvIGV2ZW4gaWYgeW91IGV4ZWN1
dGUgVElPQ01TRVQNCj4gaW1tZWRpYXRlbHkNCj4gPj4gYWZ0ZXIgb3BlbmluZyB0aGUgZGV2aWNl
LCB5b3Ugd2lsbCBoYXZlIGdsaXRjaGVkIHRoZSBvdXRwdXQsIGFuZCBvbmx5IHRoZQ0KPiA+PiBj
YXBhY2l0YW5jZSBvZiB0aGUgb3V0cHV0IHdpbGwgc2F2ZSB5b3UsIGluIHRoZSBiZXN0IGNhc2Uu
DQo+ID4NCj4gPklNSE8sIHRoZXNlIG1vcmUgZXNvdGVyaWMgdXNlIGNhc2VzIHNob3VsZCBpbnZv
bHZlIGEgY3VzdG9tIGtlcm5lbA0KPiA+ZHJpdmVyIHdoaWNoIHJlcGxhY2VzIHRoZSBnZW5lcmlj
IHNlcmlhbCBkcml2ZXIuICBJbiBwcmFjdGljZSwgdGhlc2UNCj4gPnRoaW5ncyBhcmVuJ3QgcmVh
bGx5IGEgdHR5LCBidXQgc29tZXRoaXVuZyBlbHNlIHdlaXJkLCBhbmQgdHJ5aW5nIHRvDQo+ID5k
byB0aGlzIGluIHVzZXJzcGFjZSBzZWVtcyByZWFsbHkgYXdrd2FyZC4NCj4gPg0KPiA+PiBzZXRz
ZXJpYWwgKFRJT0NTU0VSSUFMKSBhbmQgdGVybWlvcyAoVENTRVRTKikgYm90aCByZXF1aXJlIGZp
bGUgZGVzY3JpcHRvcnMsDQo+ID4+IHNvIHRoYXQgaXMgbm90IHN1aXRhYmxlLiBUaGUgODI1MCBk
cml2ZXIsIGJ1dCAqbm90KiBvdGhlciBzZXJpYWwgZHJpdmVycywNCj4gPj4gYWxsb3dzIHRoZSBz
ZXRzZXJpYWwgaW5mb3JtYXRpb24gdG8gYmUgYWNjZXNzZWQgdmlhIHN5c2ZzOyBob3dldmVyLCB0
aGlzDQo+ID4+IGZ1bmN0aW9uYWxpdHkgaXMgbG9jYWwgdG8gdGhlIDgyNTAgZHJpdmVyLg0KPiA+
DQo+ID5NeSBzdWdnZXN0aW9uIG9mIHVzaW5nIHNldHNlcmlhbCB0byB0dXJuIG9uIHNvbWUgIm5v
dCByZWFsbHkgYSB0dHk7DQo+ID5idXQgc29tZSB3ZWlyZCBuZXR3b3JraW5nIC8gY2hlYXAgZGVi
dWdnaW5nIGhhY2siIGZsYWcgc2hvdWxkIHdvcmssDQo+ID5iZWNhdXNlIHlvdSB3b3VsZCBkbyB0
aGlzIGF0IGJvb3QgdXAuICBOb3RlIHRoYXQgdGhlIDgyNTANCj4gPmF1dG9jb25maWd1cmF0aW9u
IGNvZGUgKHNlZSBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX3BvcnQuYykgaXMNCj4gPmdv
aW5nIHRvIG1lc3Mgd2l0aCBEVFIgLyBSVFMuICBUaGlzIGlzIHdoeSBJIGFzc2VydGVkIHRoYXQg
dHJ5aW5nIHRvDQo+ID5jbGFpbSB0aGF0IHlvdSBjYW4gcHJlc2VydmUgInN0YXRlIiBhY3Jvc3Mg
cmVib290cyBpcyBKdXN0IE5vdA0KPiA+UG9zc2libGUuDQo+ID4NCj4gPklmIHlvdSBoYXZlIHNv
bWUgd2VpcmQgc2V0dXAgd2hlcmUgRFRSIG9yIFJUUyBpcyB3aWVyZCB0byB0aGUNCj4gPiJkZXRv
bmF0ZSB0aGUgVE5UIiBsaW5lLCBtaWdodCBJIHN1Z2dlc3QgdGhhdCBtYXliZSB3ZSBzaG91bGRu
J3QgYmUNCj4gPnVzaW5nIHRoZSB0dHkgLyA4MjUwIHNlcmlhbCBkcml2ZXIsIGJ1dCBpdCBzaG91
bGQgKioqcmVhbGx5KioqIGJlIGENCj4gPmRlZGljYXRlZCBrZXJuZWwgZHJpdmVyPw0KPiA+DQo+
ID4JCQkJCS0gVGVkDQo+IA0KPiBUaGF0IGlzIGEgY29tcGxldGVseSB1bnJlYWxpc3RpYyBpZGVh
LiBBbmQgeW91IGFyZSBoYXJkbHkgdGhlIGZpcnN0IG9uZSB0byBoYXZlIGl0Lg0KPiBNaWNyb3Nv
ZnQgaGFzIGJlZW4gdHJ5aW5nIHRvIGdldCByaWQgb2Ygc2VyaWFsIGFuZCBwYXJhbGxlbCBwb3J0
cyBzaW5jZSB0aGUgMTk5MHMgZm9yDQo+IHJlYXNvbnMgbGlrZSB0aGlzLg0KPiANCj4gTWljcm9z
b2Z0IGV2ZW4gaGF2ZSBoYWQgdG8gYmFjayBvZmYgdGhlIHJlcXVpcmVtZW50IG9mIGhhdmluZyAu
aW5pIHRleHQgZmlsZQ0KPiAiZHJpdmVycyIgZm9yIEFDTSBzZXJpYWwgcG9ydHMNCj4gDQo+IFll
dCB0aGV5IHByb2JhYmx5IHdpbGwgc3RpbGwgYmUgd2l0aCB1cyB3aGVuIHRoZSAyMm5kIGNlbnR1
cnkgZGF3bnMsIGV4YWN0bHkNCj4gKmJlY2F1c2UqIHRoZXkgYXJlIHViaXF1aXRvdXMsIHN1cHBv
cnRlZCBieSBldmVyeXRoaW5nLCBhbmQgcmVxdWlyZSBubyBzZXBhcmF0ZQ0KPiBrZXJuZWwgZHJp
dmVycy4NCj4gDQo+IEFuZCB0aGVzZSBkYXlzIHRoZXNlIGFyZW4ndCB0aGUgImVzb3RlcmljIiB1
c2UgY2FzZXMgYXQgYWxsLiBUaGV5IGFyZSB0aGUgbm9ybS4NCg0KSSBmdWxseSBhZ3JlZSB0aGF0
IHlvdSBjYW5ub3QgZXhwZWN0IHVzZXJzIHRoYXQgd2lyZWQgc29tZXRoaW5nIGxpa2UgUlM0ODUg
RHJpdmVyDQpFbmFibGUgb3IgYSBtaWNyb2NvbnRyb2xsZXIgcmVzZXQgdG8gUlRTIG9yIERUUiB0
byB3cml0ZSB0aGVpciBvd24ga2VybmVsIGRyaXZlci4NCkFuZCB5b3UgbmVlZCB0byBvcGVuIHRo
ZSBwb3J0IHRvIG1ha2UgdGhlIGFwcHJvcHJpYXRlIHNldHRpbmdzLiBCdXQgb3BlbmluZyBhDQpw
b3J0IHNob3VsZCBub3QgZS5nLiBjbGFpbSB0aGUgUlM0ODUgYnVzIGFuZCBtZXNzIHVwIHdoYXRl
dmVyIGNvbW11bmljYXRpb24NCndhcyBnb2luZyBvbiB0aGVyZS4NCg0KS2luZCByZWdhcmRzLA0K
TWFhcnRlbiBCcm9jaw0K

