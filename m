Return-Path: <linux-api+bounces-5268-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17788C5C93F
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 11:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 855253A3F54
	for <lists+linux-api@lfdr.de>; Fri, 14 Nov 2025 10:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C909F30FC36;
	Fri, 14 Nov 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="kP/xkAAC"
X-Original-To: linux-api@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023114.outbound.protection.outlook.com [40.107.159.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67292FA0F2;
	Fri, 14 Nov 2025 10:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763116030; cv=fail; b=rfZEK/vRa8lJREDS2J/woo87d0NuLgXXjhsor0C67EwRG18flSmKQmi729CxF32f+uWoov06FxyYAvbiUYEJctQkpTegNGrZwCwYELMulw3uYDxbwIH46gj/GvpsQwPhF8YeSTH1u24Vh9ogcw8auL5yHb+7geUE/Z8Hx3kDnM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763116030; c=relaxed/simple;
	bh=YkJLPNHHUyfEoUwU2UTRjteh5MWTrkv7IKFnEVJ9HbY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n8KlGc9Squ9akMoUVytjbfKG8Dc5VG76pyl67ZYdNIqTm3hCunhp1lAOS/DqwU5MnXzIdDqvEicXC19etmT1FeYZmv50DTv3B0So1LguOzksGU3iHV0gvPnfjBoAdO8q2wEM1UeGOCayUW+3OpappvE6u52yMx82iwVBf/U6hkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=kP/xkAAC; arc=fail smtp.client-ip=40.107.159.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FA7+26nYAPyW2bVBe+LOrpiZa/RAdYJxOc/Z+h+Lk7pWs1NQud02wQOvwqPWwHvs03R89jkZsqn+TWszRKAUAzG2dwCeFgagg92e3r9acCqodaEV4OtqeYThR2QmX/7CWV30zpFqESjzqgCpnZMcaUXCnO15xc65jmT4pnJsiX2VYuMftWopvBFoxKm44jSAnhDcqnkK9alJmtNEqgpyIKAcguxRoNgHDnTx/GpQaPXf79Vq0Jp1AYG6MF4+cbaeBD790CjHwPCvjLJQpkdLuZDZkoiQDjTCGP0K6ZOYo1qnRaZwiq8OzuJBEAORL63YfB4xNlhL4W2toYoRWfIS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkJLPNHHUyfEoUwU2UTRjteh5MWTrkv7IKFnEVJ9HbY=;
 b=qAdH/l8pDEb2GE0S6seEEztwpvttZSFgvConjzZpW/aRkKjFgE++j2i79QSkaBvLSKlNAy19xD1HyfhmRyRNB47dlE9eBiAzfrkjAudqeiwma7oBW2F4ZBfHVfKywCUqKgSyRdFkZ0KIM9F+HFZRZhPrJb20ubue2dXd2jxCeAjgTsq/g5lKPOEodLHQt8obSD7zUhQKNOar/a93ZQemWdKlVw/ZRMB5YswFtoprjgdddET6/sqV0/6nYJzVphnMj86XuMXtPg+ZzOYRkMlEhDMe3CVUCQulz0v7+IXoSRRcKDRGyieMUki8eLazTRQbvZ3IMge0hdS25v5V/N7PxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=zytor.com smtp.mailfrom=sttls.nl; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=sttls.nl; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkJLPNHHUyfEoUwU2UTRjteh5MWTrkv7IKFnEVJ9HbY=;
 b=kP/xkAACGAueJuZNvEFiZi3T/xf5NCOfxKGBsQsdgvJ9AQ6M7Cb/s3wVEsktUXYN08J+VOrEc2uQ/XR82AB+89OEbFjz87/me9HNzOv6FcbVT6PG7RKiiz/DaIhqGl3nyY51TlP2XSLO1RqCG7tf9AR1l8EOVIi9uWiS4WPEovctoLxKaLZZ90upq5G3YkukegporQcy8XM5CvZtS2pzV94X+/SiqSR3mXO4LzwzlgtfTeM+lIA8buaj0LVl8l2BbkX8XoBRf0iMH5IcuuyNFGNvV/jl+swpwbtEuiIbeQwJ0GbnQf1vUu1zRAgjcx3P6FT3W5lFsoIMlEkvBumeeQ==
Received: from AM8P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::24)
 by AM8PR05MB7361.eurprd05.prod.outlook.com (2603:10a6:20b:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 10:27:04 +0000
Received: from AMS0EPF000001AA.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::9e) by AM8P251CA0019.outlook.office365.com
 (2603:10a6:20b:21b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 10:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 AMS0EPF000001AA.mail.protection.outlook.com (10.167.16.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 10:27:03 +0000
Received: from AS8PR07CU003.outbound.protection.outlook.com (40.93.65.54) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 14 Nov 2025 10:27:03 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 (2603:10a6:150:2cf::21) by GV4PR05MB12170.eurprd05.prod.outlook.com
 (2603:10a6:150:2e6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 10:26:59 +0000
Received: from GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89]) by GV2PR05MB11941.eurprd05.prod.outlook.com
 ([fe80::8532:a1ae:4fc1:3b89%3]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 10:26:59 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: "H. Peter Anvin" <hpa@zytor.com>, Greg KH <gregkh@linuxfoundation.org>
CC: Theodore Ts'o <tytso@mit.edu>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-api@vger.kernel.org"
	<linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: RFC: Serial port DTR/RTS - O_<something>
Thread-Topic: RFC: Serial port DTR/RTS - O_<something>
Thread-Index: AQHcVOxzl5OboULYSk6ze2m7hEWXqLTx9lMQ
Date: Fri, 14 Nov 2025 10:26:58 +0000
Message-ID: <GV2PR05MB1194103525B30DCC4D18D59EE83CAA@GV2PR05MB11941.eurprd05.prod.outlook.com>
References: <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
 <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
 <2025111214-doily-anyway-b24b@gregkh>
 <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com>
 <2025111241-domestic-moonstone-f75f@gregkh>
 <DD67C0CF-D330-4D40-B610-FD3EB7AA0218@zytor.com>
 <2025111227-equipment-magnetism-1443@gregkh>
 <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
In-Reply-To: <14b1bc5c-83ac-431f-a53b-14872024b969@zytor.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	GV2PR05MB11941:EE_|GV4PR05MB12170:EE_|AMS0EPF000001AA:EE_|AM8PR05MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: f299fc39-51c7-4e5a-3bef-08de23685aba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZjZqZ0ZEUHNYWWQrOVJGWkRMZVhnVW9oZnhMYkh5UlhXYlNaY0Fxd2M4ZkVC?=
 =?utf-8?B?b3VDMXJvQzIwVkNoSXdMZUtmUnJoNkdOVGxqUmdqc1JPNVZlbWRkMEpSUnIv?=
 =?utf-8?B?bXZTdFpXWTlRcjZQa0N0Y1ZmTjdEV2F6ZzNqUTJHSnp4YjZaWDBsd2tXdWlz?=
 =?utf-8?B?d1ZJSmtyNmd6ZmlLdE1vemFXSlJNQVZ3N0ZsNERNaUpDVG5lN0xJMzlLVzVF?=
 =?utf-8?B?clVFb3JGZkF0QVdoV1Q1YUdPV2F6QnN5ckkxQ2wwV21ZN0M5ZUh1TnhhTlFk?=
 =?utf-8?B?aTF0OHpkZUVhQWZ5NEVTSFZhdEhqMVNlckdybmJjNEJjd290WFdmMDFua3M5?=
 =?utf-8?B?MVZZbm40UndjNTZ2a0orVzcrdWVmQXBlSnZWajBGYUJoQUJLQnhvTXV5ZHlo?=
 =?utf-8?B?R0dpQmtKMk1jVlVCUXlNUlU3NnFBS054Z2RSY3l6MisxSjhvN0wwcmU2QnB2?=
 =?utf-8?B?d2ZmOXcyZDdsbTliVGVOTmZpaUdCcGlpMVJvbWhuRHF5WDZBcnVhaXRpS2lL?=
 =?utf-8?B?Ujc3bjFPeUJHZmJEWERjeUJ0RUtwTmc5WjlnYWdPdU9TVzViU09lbEdmWHg0?=
 =?utf-8?B?bXNSTWJZTnR1L0twcjdMclI1cDQ2aHU0d3AwK3RkaDV3cE9jeHdpV0ZoSHJI?=
 =?utf-8?B?eGxHNnZ1UndDcUxhcXpJTDN2dzlUT3BadXM0ZnBxS1Z5VE1WcXJ6UWdTS1U1?=
 =?utf-8?B?WldLa1FUSGo5NGZ0Q1ZjRjlTaXBtUytyWWVJRnBKa2F6a1dPRzhuLzJFMkN4?=
 =?utf-8?B?Z2NDL1ZCUUs1aEU3WXpWSTFsOHVkMWl2OThvajJBeFY1NlAzZVlNNVZ4N3VN?=
 =?utf-8?B?SUpTbTBrUndEdUZpcmF6czFpZTNIYUlSdnJuVzFzSld0TDRlZlVxbjNBSFN4?=
 =?utf-8?B?b0wycXl2MjMrRkVXbWdOeENkc1B0Y01WZHBNcFdqQ25ybTR1Y2FHWVJzZ3Ja?=
 =?utf-8?B?RGNYWTJqRHF2VTd3dUtBVUZjZUFTVWVJamFyd3N2RWxEbHQvaWQ3bk5PN3Bm?=
 =?utf-8?B?RFhTYXpwSjBTOXZkNDRBem0wM2MyYU9IRXhLOTFldjY1SWZtUzNRU0tneWh6?=
 =?utf-8?B?dCtzcmhNck1qbzdVZzQrT2lCeG9LWTlVdTZOcDlYN1pJN3lLVE5GSENKRDkx?=
 =?utf-8?B?dTNvUXh5SGJ0eUNoYUhoMUZmNVIvNEovMWQ4d1pscmIxMXpjWjJhYzZFNTZZ?=
 =?utf-8?B?N2k2ZmIyM1NHb0pocm5Sa2tzNDNyaWFraW9kK0hTa1l6Wmk4UmdYRTVQVzU0?=
 =?utf-8?B?cm9aakhDNGVUMXdkVi92Sno0WWkwR3Iyd1p4WDYzaXZtUURtamdlY2pDS1VV?=
 =?utf-8?B?SkZJbm91dHdPMHJGa3dyN0FIcjIzbjUybGVkTmZSbm5TNjFUbUtHNnJXak1m?=
 =?utf-8?B?bUtDd3IzM1lSNUxuMW5aN0EwMnBrTXRFWXN6blZqS0g4UXdhVXhTaWZoV0dR?=
 =?utf-8?B?SEpsOUtQa01LZUxSeUFFTXAzY1Jwdi8zOEd4YWp0RjBvRW8yUGU5bWNCWXdS?=
 =?utf-8?B?Qm9qRlVYajBwNHlCWXByODFhMHVXaTQ3dVBqaHVlMFBzeUZnTm1naGQ0MjEw?=
 =?utf-8?B?OGFTMjlqbTVzZWJIUXNmemcyTGdrL051eCs5ZEM5VGQ3aU9Vb1R5ZUt3VTZz?=
 =?utf-8?B?YjJjZHI2cWpqc1hUMG44d3dHWG5aaFh5THpwdWhZOWsrK3YxWElWVUl1UVJY?=
 =?utf-8?B?a2FmVEoxdDgxR0cyajd3SFpMK0RPckpzeVRFSzVDam1wUDNtYWErclNwamVE?=
 =?utf-8?B?empKc2c5bEdYaTNwNGJ2RzNyWjA0d3h6V3BzMzB2ZlFsSVV3VVAvMlNyOENV?=
 =?utf-8?B?ODh3eU9UQ0t0ZlpkcHBMdGNnQW1Rc0huQXZ1TDJZYitFQ0xGNmgxSGZvUFg5?=
 =?utf-8?B?SlVSWnpCMU9SMHdLbWt4N00rbnhqZXM3cDNoMEFNbmxKTm5HVC9kai8wVkpX?=
 =?utf-8?B?YWhaOHhiUFJYOG9DbThtL0lqd05WL1g3YytvRFIya21CWFBORlk5bURzWFR6?=
 =?utf-8?B?Wkc5eURXNllyUXA2bllrZFRjN3pkRzlmUnF2dUhGaDREMmxzTUs5dCt4dTUv?=
 =?utf-8?Q?8PxRDp?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR05MB11941.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR05MB12170
X-CodeTwo-MessageID: 4be74c2f-ecd1-447a-80e8-5df0da836eaf.20251114102703@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	6194f92c-6efc-4378-f0ea-08de23685813
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHNibm9QY3dKYVJkVXJRTzlScCs5SkxsQVk0YStzNHBIc2ZGb3RoK2xqZ3J5?=
 =?utf-8?B?bXhRNFZINEl1Q2JwWExtQU1uSWU0dmF2Y3NYOGUzRGNNVno5b1NtMEZkTlBs?=
 =?utf-8?B?cnl5REpLY1lYRUZtdFFnbUhkd0x1SmlTNjMvSkVDbjVRQ2xDNE51TER1anRU?=
 =?utf-8?B?dTJkaEJ6YVNjSHpMTWFNVnRrMGJIRGRtVzRmNkJjYy9CM0dKVnRLU01zNGtQ?=
 =?utf-8?B?RCtPb2VZelRERklDOXBhZU4xaXdTUmIyemJsNkg3b3JjTm5wVTJiQkJnNTls?=
 =?utf-8?B?VzhOVzc5WnV2QUZXWkpNY2g2dWlkcTdGSG5wVW4zRHFCWXhIREZIVnVkZlBr?=
 =?utf-8?B?ZDkvUDhjTVYvZ3dtaFRFQlV2N1VtQWN0MTRvdWpOSUxZcEZiNitIUlA5TTBi?=
 =?utf-8?B?TFFkZk00RXNwRGVObXBtMEthZ2JrN1VpMzlBTjVlTUN0T2RzbzFSV2VnOEtn?=
 =?utf-8?B?eHdTSERpaUFsMUZzR21KQkdVVUpGSW5aWk9rV2lIYzd0RFVYZFByeGhld3F0?=
 =?utf-8?B?dFVHRFY4Rm1LS2E0REhQMTlBWHVxeEdZL0pKcGppWFhZbWlyZ0IweGxaaFlR?=
 =?utf-8?B?WFhZb3VGUDl0Ryt5eEZvcW1vQ3QzSG04a0VUTmlVR0Y3N0pNUnRDeTluR3JI?=
 =?utf-8?B?VkJXY242L0hESVZPSmJhSTM0RFZPRUpreWZrUUYvVmVXcnBmMHZQV3ZNQlJG?=
 =?utf-8?B?dVRQcXpXcFlHbVB3NUNYcFFYR2JTZWJ2cTdncGlXNGRNUDRuNURTYXRVbnN0?=
 =?utf-8?B?V2xacXZUdzZGV3RLSnZHbkdLaVFJOWtwcysrL1FqMUNGMzBQMkpVUzFWNCtB?=
 =?utf-8?B?ZDArT0VYNktQTktUNHFnQ3dvMGp4VUFUc0RuMVVQUExxOTBQa21uTDMvMHo0?=
 =?utf-8?B?b1R3cWk0U3lrOGQ1MVp0UFkzU2c4SmM0bjFWcExMSXNSWEljOExBaU5IbGQ4?=
 =?utf-8?B?T1hwT2hXeGFDNlYzdEpiVk1aN3ZxU0hpb3JVcHFkR0NRTWtkbktSV0NRWVI3?=
 =?utf-8?B?bXFZZjJid0NaNll1S1hQNnkwMTl5bFVQaEY2YWFqS1d4YXZhcTRZSWZTOGxJ?=
 =?utf-8?B?OEhiT0Z5TVE5bVQ3S0NFc2hPaFZOV2laQ0RieC9sSm9GUXBUK0tPNjJxOEpX?=
 =?utf-8?B?cDhrM3FsQU0wdk1VMlVoTGFsVEVKSTlzKzR2a0FVRUErV2hvUUtlZFpnV1FG?=
 =?utf-8?B?bjBybkgxM3BraGdjZmVicXR1M0tHRkZ0WFBQMGhjeGZlczhnZUp6S3g2MVlF?=
 =?utf-8?B?ZDNQMXVSb3NWUUIzaEhKKy9uRmlVeTI3VCtUV3VKQWpGVmJOMDlOWENWUUhy?=
 =?utf-8?B?N051R3BJczZTWEhMWEZFMGo1RHhDMkNnaUVuU20wTkRMR0xyakIrczBFZkVR?=
 =?utf-8?B?RStOZXJ4WGh0WFpzaE5lV0IxT2V3dE9kL2xOd09IRDJDNDc3OWVJamtGVGxv?=
 =?utf-8?B?Z09lcTRZYjNpSHRoVEtOV3NNdlYyQ05KOCtDcGphZGdFS0hyMW5MdnBjY2Y5?=
 =?utf-8?B?b29qUUgzY0dPOVRHaW5pOS9lRitGaUdWTXg1cytpUTVXVE1aUWhPU0xoS2Y1?=
 =?utf-8?B?SWpmMnA5d3l6aHUrdVRudVZFSFM1ZUc5VWpGOG1wUFJFYVNuQ1NYQmtpUmEw?=
 =?utf-8?B?S3psZWpQNlFzeUk2ZDlKdW83SXppZDJxa3M1cHNORjloZDVhbkR2UlA1QlVL?=
 =?utf-8?B?K0Z1OWxYN1BtRkJtc2JEWmdnd0grclAzM0NFSFBaNkhwbjd6SVpjK3RYbXFk?=
 =?utf-8?B?TW8wWXZQWDlEdmR0TVRsaGFoZmkydFVOODJOUUhmeXRrdzJZbXYyQXhXQi9o?=
 =?utf-8?B?S3ZHMi9DZHVqQkM2MDlPVXVlTmtHOThYdEN3bzVOTnEvbFZCM1YzSjhtOXFw?=
 =?utf-8?B?cEF3WFg1K3IyWXE5bHYrN2srR2FqNk51dGhnSUVaOUxsQWFYRkFmUnlzQVRj?=
 =?utf-8?B?aGRYdUtQdmI3S3paWHFOMWRtL0FVcXNuWWJEdmRsZk1sTFd1djk2M2RFT2tH?=
 =?utf-8?B?U2lOYm1Gb2JMK2wrUFZFdE5ZZkFuVXpUaDhlQkxZQmxCcWZWMCtiaDhqM2dt?=
 =?utf-8?B?WFZyazZ4ZURPeEpBd014NW1WZEFXdW5BM21jT3lIVFBMQTdkWVpIdlpVTnRl?=
 =?utf-8?Q?NNRI=3D?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 10:27:03.8671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f299fc39-51c7-4e5a-3bef-08de23685aba
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AA.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7361

PiA+IEEgbmV3IG9wZW4gZmxhZyAiT19ET19OT1RfVE9VQ0hfQU5ZVEhJTkciIG1pZ2h0IGJlDQo+
ID4gdGhlIHNpbXBsZXN0Pw0KPiA+DQo+IA0KPiBPa2F5LCB0byBJJ20gZ29pbmcgdG8gdG9zcyBv
dXQgYSBjb3VwbGUgc3VnZ2VzdGlvbnMgZm9yIG5hbWluZzoNCj4gDQo+IAlPXyhQUkV8Rk9SfE58
Tk8pPyhJTklUfENPTkZJR3xTVEFSVCkoREVWfEhXfElPKT8NCj4gCU9fKE5PP1JFU0VUfFBSRVBB
UkUpKERFVnxIV3xJTyk/DQo+IAlPX05PP1RPVUNIDQo+IAlPX05ZRVQgKCJub3QgeWV0IikNCj4g
DQo+IEkgdGhpbmsgbXkgcGVyc29uYWwgcHJlZmVyZW5jZSBhdCB0aGUgbW9tZW50IGlzIGVpdGhl
ciBPX05ZRVQgb3IgT19QUkVDT05GSUcNCj4gb3IgT19OWUVUOyBhbHRob3VnaCBpdCBpcyBwZXJo
YXBzIGEgYml0IG1vcmUgInVzZSBjYXNlIGNlbnRyaWMiIHRoYW4gIndoYXQNCj4gYWN0dWFsIGVm
ZmVjdCBpdCBoYXMiIEkgdGhpbmsgaXQgbWlnaHQgYmUgY2xlYXJlci4gIEEgLURFViwgLUhXIG9y
IC1JTyBzdWZmaXgNCj4gd291bGQgc2VlbSB0byBuZWVkbGVzc2x5IHByZWNsdWRlIGl0IGJlaW5n
IHVzZWQgZm9yIGZ1dHVyZSBzaW1pbGFyIHVzZSBjYXNlcw0KPiBmb3IgZmlsZXMgdGhhdCBhcmUg
bm90IGRldmljZSBub2Rlcy4NCj4gDQo+IE9fTllFVCAoIm5vdCB5ZXQiKSBpcyBraW5kIG9mIGF0
dHJhY3RpdmUgYmVjYXVzZSBpdCBoYXMgc29tZSBnZWVraXNoIHNtaXJrDQo+IHZhbHVlLCBkb2Vz
bid0IGhhdmUgIm9idmlvdXMgZW5vdWdoIiBtZWFuaW5nIHRoYXQgaWYgeW91IGRvbid0IGtub3cg
d2hhdCBpdA0KPiBkb2VzIHlvdSdsbCBndWVzcyByYXRoZXIgdGhhbiBsb29raW5nIGl0IHVwLCBi
dXQgb25jZSB5b3Uga25vdyB5b3UgYXJlIG5vdA0KPiBnb2luZyB0byBmb3JnZXQgaXQhICBUaGVy
ZSBpcyBldmVuIHByZWNlZGVudDogVVNCIDIgYWxyZWFkeSBoYXMgdGhlIE5ZRVQNCj4gcGFja2V0
IHR5cGUgbWVhbmluZyBqdXN0ICJub3QgeWV0Ii4gIFRoZSBtb3JlIEknbSB0aGlua2luZyBhYm91
dCBpdCB0aGUgbW9yZQ0KPiBhbSBzdGFydGluZyB0byBsaWtlIGl0Li4uDQoNClBlcnNvbmFsbHks
IEkgZG9uJ3QgbXVjaCBsaWtlIHRoZSBPX05ZRVQgYXMgaXQgc2VlbXMgdG8gZGVzY3JpYmUgbm90
IHRvIG9wZW4NCnRoZSBkZXZpY2UuDQoNCj4gTWFueSBvZiB0aGUgb3RoZXIgY29tYmluYXRpb25z
IGhhdmUgdGhlIHByb2JsZW0gb2Ygc2VlbWluZyB0byBkbyB0aGUgb3Bwb3NpdGUNCj4gb2Ygd2hh
dCB0aGUgdXNlZCB3YW50cyBpbiBzb21lIHVzZSBjYXNlczsgaXQgc2VlbXMgcmF0aGVyIG9kZCB0
byBvcGVuIGEgZGV2aWNlDQo+IG5vZGUgdGhhdCB5b3UgYXJlIGludGVuZGluZyB0byBjb25maWd1
cmUgd2l0aCAiT19OT0NPTkZJRyIuDQoNCkRvbid0IGxpa2UgdGhpcyBvbmUgZWl0aGVyLg0KDQo+
IE9uIHRoZSBvdGhlcg0KPiBoYW5kLCAiT19DT05GSUciIG1pZ2h0IGJlIGEgdmFsaWQgaW5kaWNh
dGlvbiBvZiB0aGUgaW50ZW50IChsaWtlIE9fUkRPTkxZIG9yDQo+IE9fUkRXUiBhcmUgaW5kaWNh
dG9yIG9mIGludGVudCksIGJ1dCBhbHNvIGhhcyB0aGUgaW1wbGljYXRpb24gdGhhdCBpdCAqd2ls
bCoNCj4gY2F1c2UgdGhlIGRldmljZSB0byBjb25maWd1cmUgaXRzZWxmLiAgSXQgYWxzbyB3b3Vs
ZCBzZWVtIHRvIGltcGx5IHRoYXQgdGhlDQo+IHJlc3VsdGluZyBmaWxlIGRlc2NyaXB0b3IgY2Fu
ICpvbmx5KiBiZSB1c2VkIGZvciB0aGF0IHB1cnBvc2UuDQoNCkkgZG8gbGlrZSB0aGUgT19DT05G
SUcgb3IgT19GT1JDT05GSUcgbmFtZXMuDQpJIGFsc28gbGlrZSBPX1BSRUlOSVQgb3IgT19QUkVT
VEFSVC4NCg0KS2luZCBSZWdhcmRzLA0KTWFhcnRlbg0KDQo=

