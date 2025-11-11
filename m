Return-Path: <linux-api+bounces-5202-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF39C4D15E
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 11:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA16420AA4
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266B734888C;
	Tue, 11 Nov 2025 10:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="Kc5yAfXO"
X-Original-To: linux-api@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021116.outbound.protection.outlook.com [52.101.65.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91831DD91;
	Tue, 11 Nov 2025 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856484; cv=fail; b=eqEQUmtPtklDJorBJAb7rVO4TR82G7hW25dxw6/rZRWD9SbmeqjGrkaOdJzJZ5BFobnIcRAEfbM0/kHeLSIhLU/XXazAbEg4XNm8RaK60JSzityfG/ByYpEHE+FhQpd60+0jtbocrGnY7TCiVL+JX+XZMHa01a1xeYtM/ghzZQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856484; c=relaxed/simple;
	bh=q9WMaeUggcrUoznQCAZAUvOj052Fgbdz494tjtb4DVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jw4QhO/wKGD2rH5lHBV/BWHoJMBHYkJUhzKl10GyCfZWXzYRk4/6ZZVFmgqtsvwnJIezfQMiWFPH0N5nf9HUMGQo84I0vCraoBeXDaaY9w+YKpLh4o1QTSg4RJnuRYXGb6A44sTd5qhxT+5az4TyviJEnTOzpljbvTw59fYDVuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=Kc5yAfXO; arc=fail smtp.client-ip=52.101.65.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/BtVuIqFG1nV13j1wLgpk88lbTN04jX4iKMv1CSYVtp/iZvH8wZXC2gQ1uRlDluFSMUHHinln5S5XdLHI6dgk6VAKvQzhajYYQqrPMnQREiKRkt2pggX/hMdVMCq4iDRBPb7SyZ9uHf/9IOvKzxDRgjvDNQIyf8nP0F6Gq8IanRQFj9Z/HUxduKqv8TpmyOhty9qRtsUPa4xvDPDZmabpWdmn142Ao/jko3INpESQsbcuMVpqrRPvnbaKT/LM2G7ZXEAFsMQWqlKOUI3ezeTOgSZ61csIcJy26zpzuk11CpIQzT2/E5/Rp2YyrNTS65bME1LpygGv79icb/EwqoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9WMaeUggcrUoznQCAZAUvOj052Fgbdz494tjtb4DVE=;
 b=WeQB2ycYpOk48XwZQhXSZsl++aoCCnIK9GS9A+JqIQ6tOd1W2KjQ5Jl/mNv2Rx9iHd8wNaNokc+eJKqhB2jPem+CUW3PFvpBrg5DHVBckWeiS4KtyLu2+eKIqV2KJMzkfGEZoXgwTvtVlJyB8+eaDuszWTCx2FbOYCVXf9gx3MybV/F8KVfVTXGYyInyoCKikg7wfGlvtKGeGVpFCIHCNANAjmuwnhvZDPjizwJ+VLcQUggaAcCB5VeqPMW0C8JbyqAySXPXu2GKsz7uuyh+m5tTnhb3GGRJBtPcBsUV+QB1rezfhroK2u4cbpJER7XwuF6ZjkBJ/VPGTg2ZEGX3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=mit.edu smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9WMaeUggcrUoznQCAZAUvOj052Fgbdz494tjtb4DVE=;
 b=Kc5yAfXOZOy/FwtZ/AT5Xamv6gMogARaRQooKcxC/8dEwmwUb/aJmn3lr36yQcPrI85qBcL2ckBJ7mqkLYiCCQ01lW5fio1vnAX6vZTgnnW4W4rFMdZf4ObdWWZk87HkqHzg457kLyZuMDp+NF4Sz3KNfGbpFKMg9Cc5ljTo4CxZryx+rXxrTpl9vJpoDw2tjaO8POYjaUYy0yUuOAwbgm0sgaKhOuvXXqWLrrb32slTCF4bXiK4uhV91gX8vMvhvBqf0H19yJAFGj5npQ7C9mGznvKLoq/GonYrDIfY73IF4ptxz8hAj/XLbeBJFDLEB9cKnWQHjoqLueDx0ES9Pg==
Received: from DU7P194CA0005.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::32)
 by GV1PR05MB11588.eurprd05.prod.outlook.com (2603:10a6:150:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:21:16 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::6c) by DU7P194CA0005.outlook.office365.com
 (2603:10a6:10:553::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 10:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 10:21:13 +0000
Received: from AM0PR07CU002.outbound.protection.outlook.com (40.93.65.65) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 11 Nov 2025 10:21:13 +0000
Received: from AMBPR05MB11925.eurprd05.prod.outlook.com (2603:10a6:20b:6ee::7)
 by DBAPR05MB7365.eurprd05.prod.outlook.com (2603:10a6:10:1ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 10:21:11 +0000
Received: from AMBPR05MB11925.eurprd05.prod.outlook.com
 ([fe80::fced:b7e5:3955:da18]) by AMBPR05MB11925.eurprd05.prod.outlook.com
 ([fe80::fced:b7e5:3955:da18%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 10:21:11 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Theodore Ts'o <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: RE: RFC: Serial port DTR/RTS - O_NRESETDEV
Thread-Topic: RFC: Serial port DTR/RTS - O_NRESETDEV
Thread-Index: AQHcT7uhG+hEZgj7wUKBeliUjNaa5bTnevqAgAIlvwCAAaYOAIAAF5IAgABSP/CAAK6XgIAADPWAgABxYYCAAAGUAIAAC16AgABU0yA=
Date: Tue, 11 Nov 2025 10:21:11 +0000
Message-ID: <AMBPR05MB119254795BE95ED921AB042CD83CFA@AMBPR05MB11925.eurprd05.prod.outlook.com>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
 <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
 <20251110033556.GC2988753@mit.edu>
 <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
 <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
 <20251111043803.GK2988753@mit.edu>
In-Reply-To: <20251111043803.GK2988753@mit.edu>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AMBPR05MB11925:EE_|DBAPR05MB7365:EE_|DU6PEPF00009528:EE_|GV1PR05MB11588:EE_
X-MS-Office365-Filtering-Correlation-Id: aebb0e10-dcd3-4f89-a121-08de210c0afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?a1dBRzZwZnVPVmROZk5TNmwxZUo5L2xocm5kV3RiYm9oSEVRYXk0TTEyQlhL?=
 =?utf-8?B?aStPNHNYNGRKeC8ydFdZRlAvZHo5emFSRmx4Z3JhbWdlWmtUU2s0cDZYY1Zm?=
 =?utf-8?B?QnpaRENNSlJRcGMxWVJiNWs0bTgvRXFpd3NNK3g4L1g5U3M0YXVXU2FrYXJE?=
 =?utf-8?B?NlVPQXF3Rm1hWU9HUFNpRXIxQmp3VWVNT0NROXFJcjc4bk9sQ1doOFM1NWVs?=
 =?utf-8?B?VkhIV1dja0NidFRXditKalFKZmpNd0xVZVhPTzc5K0Z2YmFoL2lKYTdUaUtX?=
 =?utf-8?B?OWxnWE44TDZaVjhmOTJsMCtVNGJDVkl5a1lMVk8wM1VMdldEaGtOSlBua2dv?=
 =?utf-8?B?UnFXWER1RVlBVWJ1L0VMT1AwNFRVbE9yd1VYV1dSZy92Ym9EYzJoYmdEZ1dQ?=
 =?utf-8?B?OVVNZVZEdDZFaEZUNWdIcG96ckE3bkw4SDgzM00vWkZnTWRhdUxkcG54eE14?=
 =?utf-8?B?UmpaaHJJVm5HbEtNY2xTZkJSYnBtK214bUFJd1VjckxreUViNnFnaG1xYlpN?=
 =?utf-8?B?RHFEYmdPSkl5RDRqV0ZzYnIycXg0MmU4cWRNdEJ1aW1SRUt5VS9YK05MUzZM?=
 =?utf-8?B?V2xTYTRhcDZjM29mcGVZUHlFR1VQWUVjK3VSTGtoSnN1UUU5b1c1TUFCRzBw?=
 =?utf-8?B?WlZyVlRRZEFSMGNLeENXZDlxTjdySVUzSEU5Ykg0VS9DK001TmsyZjdEbTUz?=
 =?utf-8?B?UUJ2QzBvVTNjdHU2ZnFCMmFhd0lvRGpsNk45aGRoR1R0UGRLTWlma2RYVndq?=
 =?utf-8?B?QnpkSzhBK0g0ZXNHWmJ0Z0tNMHVEc2tEQWVzSllvMTczQ3dFZDVJTk1GQ0xo?=
 =?utf-8?B?cjRLTUZralEvdGcvWnRzekR4OTFGckhETHcyZEhDeXJzNS9GZEp2Q0lBZ0lH?=
 =?utf-8?B?V01ERkh1SG1tSlJzZmZFOWZlaUIvd0tyQ0kyUHlmNEx3MVdiMS9laThYM09F?=
 =?utf-8?B?QzQ3dDVUMnlZUVRsbytOenY4amtaUkRzOXZ1Q1JwaFRudGZhMkZ5TVlwL1Ur?=
 =?utf-8?B?SmhsMnpPQXUxeFBmSFk2WVcybm9tZk9CM3V6cFBCTVNDRGYxN2VSZUdQb1BU?=
 =?utf-8?B?Rnc4VFVydldQZ0FjMDZqSWgzdWI4SFBHOGRqS3hLUElSU2MxV2VFSDN3RmIw?=
 =?utf-8?B?SG41ck5kajlMWWo2QUVFcmxLQ0NoTlh6YWlDT0VBTEVNb1EzZDhaMnlNRk5l?=
 =?utf-8?B?UXBpWEY3TlFubGpKWi92eDR0eG9jdXVpUGJYOXJHWGFjbWhsdE1iY3ZFRmRT?=
 =?utf-8?B?dFlya2ZJNThXMThJZXFML2liMU1BTXk1cGJxa050b0FBWUw3V0Z6enlaeDNL?=
 =?utf-8?B?bnpxaWE5RmpPRFgyb2pQckdZQkVxQWw2aGtPMHdEQzVvNzdyOXNOMDV3L05p?=
 =?utf-8?B?TVduRS9ITDRtRDhDWGRlZG56RVNCSkV5Q3A5djNZUzJkRXdvWURPNGlOVjRC?=
 =?utf-8?B?aFlyUmd3VWxEUC9TWUF0VGZRNGN2eWlleWRKdGRRWlVWS2lkZ3FkbmpJaUVl?=
 =?utf-8?B?OGhHTll2YWl3aUNwQ2MxZnRRd2ZRN3VoMm95cENmOGt5akJjbGRFL2N5UkF2?=
 =?utf-8?B?UlUzTWRaOG1abUxZVVE0RHZVVWdTZDZKUHlvMUFkU3RuSGFYSTR6VkNLWi81?=
 =?utf-8?B?cXc2NE95ZEVFejYyRHZJeE91bXJWSVlEUkt2NXpCeU1wMDZPMS8vSDh5ditq?=
 =?utf-8?B?YU1XNUd0VkYybnRwMDg5STd1d0paL0s5RTdMMGVlcU1wWEg5cU9NSkhTUFlq?=
 =?utf-8?B?ektpaFlkZTFFcFNLNTkwclh5NDE5VTlZcFIxZzc3Ynk4QmRvZ2lZSVVSSWJn?=
 =?utf-8?B?bmJ3ekgvMUFxY1NGQy8xS1IyWW51YnlnWVNrRCsvSS9WTjJoNFlHMy92VWl6?=
 =?utf-8?B?anpSdEhraGpLWENONWZ1NkU5OW1xTnVqbXBBYmpWOXRXTWRkSS9hclp4ZFUy?=
 =?utf-8?B?empEdnNpb1krZnZGeGJRQkFscWkrQ0xzUXdWeS9nVVlGaVZMVlZYSjVkMkFR?=
 =?utf-8?B?SzNOd0JBd0ZLa0VVTlpwRktVcHBVc3AzdXJkOWlEUU1XQkNTci91TndpMnJI?=
 =?utf-8?Q?XSPhqf?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMBPR05MB11925.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR05MB7365
X-CodeTwo-MessageID: 763d3ce6-5716-41c1-a4e6-90fa328dee7e.20251111102113@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e0616d5a-e09b-4583-a714-08de210c0991
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|376014|1800799024|36860700013|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUJBc09yYmtkbWxuYVNLRzFucVJnVWVxRkt5ZzVOY2NidWVidHdrTWJrVnhU?=
 =?utf-8?B?bjRSejF3dk1NbE5NWENaNlZjbmpvYm1KQWxKOWM0SGJoelFUN2toUFczQVIz?=
 =?utf-8?B?MGdVT0JabjROREMvS0FhbzN3bzVpTFVmbFRvODNoSnkxZUlndWx1ZXEzZ0FE?=
 =?utf-8?B?Vmc2N1h2Zk1Kemd3V3p5WmtpcVhmeE1vSlJGbmh4VzcyYkNKZFJ5QTJyLzlP?=
 =?utf-8?B?bTBaZDBnYUdycWFOaFVjcjVKZjF3bS83SmNMd2ZlR2ZnckFjMkRsSCtzQ2d5?=
 =?utf-8?B?SnYwMTJOVC9HMGRzNmRyV1BrTWd2T0lKMXVFQ0UxWVdvMjN2NkZJUDErZUww?=
 =?utf-8?B?ZHpyL3R6eGdReVBaZDdRZXlwdElxWStERjdBcHZ0dVBQWDFqTnRFRnZqSHc4?=
 =?utf-8?B?S1JBcVpEL0tCZVUvbFI3OGFtVWw1cEswWndOWkJKeE9QL1RVazZ1TExQUEpB?=
 =?utf-8?B?TitpbGZrSWc1aDNkbGNrdmhNZC9qNlJDQWxtR1ZPdUZoNXZXU2xDaTd5NzI1?=
 =?utf-8?B?UVBEWnJLUmw1aFpmaU9SZ0FBbXZtaEl1Y1A2cVpVSUlZdFoxc2RWS2pwZWVS?=
 =?utf-8?B?Rk5qUmVIbUVUNk53UjJXTFlqRlFVem5uYS9XS2xXNUt3N01FejREU1FySlF4?=
 =?utf-8?B?ZmpxeVFQbHJPN2o0Z205UDZhTVViM1VqaHdadjJrOFVySTB2NUJSMmZLRDdz?=
 =?utf-8?B?NjJON21COERmRHI0RjZkcHJhaTMwMFlnaURHOGxPV0NuU3VzUzJrNTNjNStl?=
 =?utf-8?B?K1pIcGxGcGJrKzRuWWtxcm9McSsxNDNnQmh0Q1hhYmFqWVM5bndZOUFjQ3dn?=
 =?utf-8?B?RGs5V0l6a2pROUZDamNyV29iYTJUamtzaFRjYUF0OXQ4ek5HS01na3dEUFVZ?=
 =?utf-8?B?aXRRaE9YdVZ1VjV5ZTRtdkZrNjdENW9Qdm42SlNORUJCWXBpSUJxMm9VWDl5?=
 =?utf-8?B?N2xtRDVGcHQ0czNtWUswZ3ZFWXA3OGNrYTFrMkFFcHhFWUlZamtyNG5obytl?=
 =?utf-8?B?RVFzLzB6dlA4THVzQmVLWnNva05pTHZZenZFOUU2OFpwdlNZblJqRXlCRndE?=
 =?utf-8?B?enUrNVc3UTFVS3pGTXJvUCtYaFMzbW1IMjFzalF0VHhVWmIrZnA0UmdZSlFS?=
 =?utf-8?B?eDZWQ3J2WFAwWUtuZjlZNDkwclJ2UVJFSHlhQW90U1dYOXBJYWIyOG1WYlNF?=
 =?utf-8?B?UEhyYmRZaTlFeFZ0TTlLYUtCZk9Pb0Z2a0xYcDFJdGNpYlBlcjlpMjh0bFh1?=
 =?utf-8?B?RytBZzByQjlFc1BiM0d3RFI4YUNxOFhhcHNHU2tBdFRiclZZd1dZT0Y2WXpF?=
 =?utf-8?B?UndUanZLc2lXUllTZk5XdUpDYTJRVWVvSDJjYTNZMzZyc3NiT1ExMnBxSG1B?=
 =?utf-8?B?ZTMvZHJickNhNVZFOW1TbzJzcnVFcVllVW5MZWVEYUhRY2RpTHZYLy9GalZ6?=
 =?utf-8?B?Y3NsTDU5ejJvK0grWUxSTndHN0pmZVdEUTdkTzlUMEF1MWp2VTN1Zk9yMnFP?=
 =?utf-8?B?a0R3LzlaMUpFSkgwTjhveFlQZEZJK1cyQTBTQ2pwbWJIaWhUcVBydUprNXBj?=
 =?utf-8?B?MFNWZ1BEa0RJenA2RkhwZmFOVVVOR211dWxnZHZyQW85MGFML2QwTXhaWEtG?=
 =?utf-8?B?RStkYmE3a3Z4MmVEeFd4YVlWWGtBOFJxQWNJUFMwWEZzK01ueWNjN0JqbStt?=
 =?utf-8?B?MURmUXdXN0tUZ0lKT3hNSTFDNXhHU0dvcDI2dTlOUzFmbllFYmxmMUF4TXdK?=
 =?utf-8?B?OWQzSlJ5bVFQQ1JEM1FPbHU3QkxxQVdIVUd0Qk9IR2JQZWtZRkxlTUFEU0hT?=
 =?utf-8?B?cTFoZnk2dHFGbncxVEd6b3g1YllTenhTU3dYZnVkOXIzZEN2NjVnbVJBanlX?=
 =?utf-8?B?aXY3bG1FN0V3S1BGbFpBVVRsNmhmK3RvVG5ENEJIbmhsRldFOGp5UXFmMXpm?=
 =?utf-8?B?WGhoelF0L2tndEFuRHRmcEp6aGp4UFFCWHF2ZkQyY0dTVUJKczVxc3pSN1Iw?=
 =?utf-8?B?SGNiTElhNTluSit1aGUyRFRWV1ZDSjFoZkpueUJKeGlRUzNhNFgrbVF3LzFs?=
 =?utf-8?B?VEYydHlrMHd5ajNxNGxCNHI2RUQyL1gzODIzaVFoZ1JlN2RqRG1sL3FKSU9m?=
 =?utf-8?Q?Uk3g=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(376014)(1800799024)(36860700013)(35042699022)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 10:21:13.9768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aebb0e10-dcd3-4f89-a121-08de210c0afa
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR05MB11588

VGVkLA0KDQpJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHlvdSBkcmFnIHVzZXJzcGFjZSBpbnRvIHRo
aXMgZGlzY3Vzc2lvbi4NClRoZSBrZXJuZWwgZHJpdmVycyBhbHJlYWR5IHN1cHBvcnQgUlMtNDg1
IG1vZGUgZm9yIG1hbnkvbW9zdA0KVUFSVHMgaW5jbHVkaW5nIHRoZSBiZXN0IHRpbWluZyB0aGV5
IGNhbiBnaXZlLg0KDQpUaGUgcmVhc29uIEkgYnJvdWdodCB1cCBSUy00ODUgaXMgYmVjYXVzZSBv
ZiB0aGUgZm9sbG93aW5nIHNpdHVhdGlvbjoNCk91dCBvZiByZXNldCB0aGUgVUFSVCBoYXMgUlRT
IyBpbmFjdGl2ZS4gQW55IGRlY2VudCBoYXJkd2FyZSBkZXNpZ24NCndpbGwgdHVybiB0aGlzIGlu
dG8gUlMtNDg1IERyaXZlciBFbmFibGUgKERFKSBpbmFjdGl2ZSB3aXRoIHRoZSByZXN1bHQgdGhh
dA0KaXQgZG9lcyBub3QgaW5hZHZlcnRlbnRseSBjbGFpbSB0aGUgYnVzIHVubmVjZXNzYXJpbHku
DQoNCk5vdyBzb21lIHVzZXJzcGFjZSBwcm9ncmFtIHdhbnRzIHRvIG9wZW4gdGhlIHR0eSB0byBz
dGFydCBsaXN0ZW5pbmcNCmFuZCBtYXliZSBsYXRlciBhbHNvIHRvIHN0YXJ0IHRyYW5zbWl0dGlu
Zy4gT3BlbmluZyB0aGUgdHR5IHdpbGwgYWN0aXZhdGUNCnRoZSBSVFMjIGxpbmUgYW5kIHRodXMg
REUgYW5kIHRoZXJlYnkgY2xhaW1pbmcgdGhlIGJ1cy4gQW55IG9uZ29pbmcNCmNvbW11bmljYXRp
b24gd2lsbCBnZXQgZGlzcnVwdGVkLiBIb3cncyB0aGF0IGZvciBnb29kIGJlaGF2aW91cj8NCk9u
bHkgYWZ0ZXIgb3BlbmluZyB0aGUgcG9ydCB0aGUgdXNlcnNwYWNlIHByb2dyYW0gY2FuIHVzZSB0
aGUgZmlsZQ0KZGVzY3JpcHRvciB0byBjb25maWd1cmUgdGhlIHR0eSB0byB1c2UgUlMtNDg1IG1v
ZGUgYW5kIHNpbmNlIGl0IGlzIG5vdA0KdHJhbnNtaXR0aW5nIGl0IHdpbGwgbm93IGRlYWN0aXZh
dGUgUlRTIyBhbmQgREUgYWdhaW4uIEJ1dCB0aGUgcG9zc2libGUNCmRhbWFnZSBoYXMgYmVlbiBk
b25lLg0KDQpMdWNraWx5IGlmIG9uZSBpcyB1c2luZyBhIGRldmljZSB0cmVlIG9uZSBjYW4gYWxy
ZWFkeSB0ZWxsIHNvbWUgZHJpdmVycw0KdGhhdCB0aGV5IG5lZWQgUlMtNDg1IG1vZGUgYW5kIHRo
ZSBnbGl0Y2ggY2FuIGJlIHByZXZlbnRlZC4NCg0KQnV0IGEgZmxhZyB0byBvcGVuIGEgdHR5IHdp
dGhvdXQgdG91Y2hpbmcgdGhlIFJUUyMgYW5kIERUUiMgbGluZXMgd291bGQNCmJyaW5nIHRoZSBv
cHRpb24gb2YgY29uZmlndXJpbmcgdGhlIGRyaXZlciBpbiBSUy00ODUgbW9kZSBpbiBhIHNhZmUg
d2F5Lg0KDQpBbmQgYW5vdGhlciByZWFzb24gd2h5IHlvdSBzaG91bGQgbm90IGhhbmRsZSB0aGlz
IGluIGEgbmV3IGRyaXZlciBpcyB0aGF0DQp0aGVyZSBhcmUgbWFueSBSUy0yMzIgPC0+IFJTLTQ4
NSBjb252ZXJ0ZXJzLiBEbyB5b3UgcmVhbGx5IGV4cGVjdCB1c2Vycw0KdG8gY29tcGlsZSBhbmQg
aW5zdGFsbCBhIG5ldyBrZXJuZWwganVzdCBiZWNhdXNlIHRoZXkgcGx1Z2dlZCBpbiBvciBvdXQN
CnNvbWUgc3VjaCBjb252ZXJ0ZXI/DQoNCk1hYXJ0ZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBUaGVvZG9yZSBUcydvIDx0eXRzb0BtaXQuZWR1Pg0KPiBTZW50OiBU
dWVzZGF5LCAxMSBOb3ZlbWJlciAyMDI1IDA1OjM4DQo+IFRvOiBILiBQZXRlciBBbnZpbiA8aHBh
QHp5dG9yLmNvbT4NCj4gQ2M6IE1hYXJ0ZW4gQnJvY2sgPE1hYXJ0ZW4uQnJvY2tAc3R0bHMubmw+
OyBsaW51eC1zZXJpYWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gYXBpQHZnZXIua2VybmVs
Lm9yZzsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6
IFJGQzogU2VyaWFsIHBvcnQgRFRSL1JUUyAtIE9fTlJFU0VUREVWDQo+IA0KPiBPbiBNb24sIE5v
diAxMCwgMjAyNSBhdCAwNzo1NzoyMlBNIC0wODAwLCBILiBQZXRlciBBbnZpbiB3cm90ZToNCj4g
PiBJIHJlYWxseSB0aGluayB5b3UgYXJlIGxvb2tpbmcgYXQgdGhpcyBmcm9tIGEgdmVyeSBvZGQg
cG9pbnQgb2YNCj4gPiB2aWV3LCBhbmQgeW91IHNlZW0gdG8gYmUgdmVyeSBpbmNvbnNpc3RlbnQu
IEJvb3QgdGltZSBzZXR1cD8gSXNuJ3QNCj4gPiB0aGF0IHdoYXQgc2V0c2VyaWFsIGlzIGZvcj8g
V2UgaGF2ZSB0aGUgYWJpbGl0eSB0byBmZWVkIHRoaXMNCj4gPiBjb25maWd1cmF0aW9uIGFscmVh
ZHksIGJ1dCB5b3UgbmVlZCBhIGZpbGUgZGVzY3JpcHRvci4NCj4gDQo+IEknbSBub3QgcmVhbGx5
IGZvbmQgb2YgYWRkaW5nIHNvbWUgbmV3IG9wZW4gZmxhZyB0aGF0IHRvIG1lIHNlZW1zDQo+ICoq
dmVyeSoqIHNlcmlhbCAvIFJTLTQ4NSBzcGVjaWZpYywgYW5kIHNvIEknbSB0cnlpbmcgdG8gZmlu
ZCBzb21lDQo+IHdheSB0byBhdm9pZCBpdC4NCj4gDQo+IEkgYWxzbyB0aGluayB0aGF0IHRoYXQg
dGhlIEdQSU8gc3R5bGUgdGltaW5nIHJlcXVpcmVtZW50cyBvZiBSVFMNCj4gKipyZWFsbHkqKiBz
aG91bGQgYmUgZG9uZSBhcyBhIGxpbmUgZGlzY3BsaW5lLCBhbmQgbm90IGluIHVzZXJzcGFjZS4N
Cj4gDQo+ID4gSG9uZXN0bHksIHRob3VnaCwgSSdtIGZhciBsZXNzIGludGVyZXN0ZWQgaW4gd2hh
dCA4MjUwLWJhc2VkIGhhcmR3YXJlIGRvZXMgdGhhbg0KPiBlLmcuIFVTQi4NCj4gDQo+IEknbSBx
dWl0ZSBjb25maWRlbnQgdGhhdCBVU0Igd29uJ3QgaGF2ZSAic3RhdGUiIHRoYXQgd2lsbCBiZSBw
cmVzZXJ2ZWQNCj4gYWNyb3NzIGEgcmVib290LCBiZWNhdXNlIHRoZSBkZXZpY2Ugd29uJ3QgZXZl
biBnZXQgcG93ZXJlZCB1cCB1bnRpbA0KPiB0aGUgVVNCIGRldmljZSBpcyBhdHRhY2hlZC4gIEFu
ZCBwYXJ0IG9mIHRoZSBwcm9ibGVtIHdhcyB0aGF0IHRoZQ0KPiByZXF1aXJlbWVudHMgd2VyZW4n
dCBwYXJ0aWN1bGFybHkgY2xlYXIsIGFuZCBnaXZlbiB0aGUgaW5zaXN0ZW5jZSB0aGF0DQo+IHRo
ZSAic3RhdGUiIGJlIHByZXNlcnZlZCBldmVuIGFjcm9zcyByZWJvb3QsIGRlc3BpdGUgdGhlIHNl
cmlhbCBwb3J0DQo+IGF1dG9jb25maWd1cmF0aW9uLCBJIGhhZCBhc3N1bWVkIHlvdSB3ZXJlIHBv
c3RpbmcgdWluZyB0aGUgQ09NIDEvMi8zLzQNCj4gcG9ydHMgd2hlcmUgYXV0b2NvbmZpZ3VyYXRp
b24gaXNuJ3Qgc3RyaWN0eSBzcGVha2luZyBuZWNlc3NhcnkuDQo+IA0KPiBJbiBzb21lIHdheXMs
IFVTQiBwb3J0cyBtaWdodCBiZSBlYXNpZXIsIHNpbmNlIGl0IHNob3VsZCBiZSBwb3NzaWJsZQ0K
PiB0byBzcGVjaWZ5IHVkZXYgcnVsZXMgd2hpY2ggZ2V0IHBhc3NlZCB0byB0aGUgZHJpdmVyIHdo
ZW4gdGhlIFVTQg0KPiBzZXJpYWwgZGV2aWNlIGlzIGluc2VydGVkLCBhbmQgc28gKnRoYXQqIGNh
biBlYXNpbHkgYmUgZG9uZSB3aXRob3V0DQo+IG5lZWRpbmcgYSBmaWxlIGRlc2NyaXB0b3IuDQo+
IA0KPiBBbmQgZm9yIHRoaXMgc29ydCBvZiB0aGluZywgaXQgc2VlbXMgcGVyZmVjdGx5IGZhaXIg
dG8gaGFyZCBjb2RlIHNvbWUNCj4gc3BlY2lmaWMgYmVoYXZpb3IgdXNpbmcgZWl0aGVyIGEgYm9v
dCBjb21tYW5kIGxpbmUgb3IgYSB1ZGV2IHJ1bGUsDQo+IHNpbmNlIHlvdSBzZWVtIHRvIGJlIHBv
c2l0aW5nIHRoYXQgdGhlIHNlcmlhbCBwb3J0IHdpbGwgYmUgZGVkaWNhdGVkDQo+IHRvIHNvbWUg
a2luZCBvZiB3ZWlyZC1zaGl0IFJTLTQ4NSBidXMgZGV2aWNlLCB3aGVyZSBhbnkgdGltZSBSVFMv
RFRSDQo+IGdldHMgcmFpc2VkLCB0aGUgYnVzIHdpbGwgbWFsZnVuY3Rpb24gaW4gd2VpcmQgYW5k
IHdvbmRyb3VzIHdheXMuLi4uDQo+IA0KPiAgICAgIAkgICAgIAkgICAgIAkgIAkgICAgICAJIC0g
VGVkDQo=

