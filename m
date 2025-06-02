Return-Path: <linux-api+bounces-3864-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C99ACB202
	for <lists+linux-api@lfdr.de>; Mon,  2 Jun 2025 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DB165C04
	for <lists+linux-api@lfdr.de>; Mon,  2 Jun 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B223A994;
	Mon,  2 Jun 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CWRM684o";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CWRM684o"
X-Original-To: linux-api@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E9E239E97;
	Mon,  2 Jun 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873458; cv=fail; b=cT5VHuRWHdSOQwotxua7XKxAO60TAhdKd0PADTjPJ4te79b1Ez8oDXCrcHyl313Z8JlaplqH/5p08s6KPxREW4KbnL5wEM4bsCy3IAUcSd2gxcqdrwGHbOxePHIDFvBkegds6h8VIWeOfta/NoeAVZw1SjJq4pMEWiXmCBoNwA0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873458; c=relaxed/simple;
	bh=TLyBkH1ZYdTKmJKIIyHUflXAF065BYGinM2HuoR2k00=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVe0LkiegQeyo3P2gG96ujZQs8a3ksIfs08QzXtNxcOTY3bGi+RlEN2qnx87NiTyDb91/gNmfg92UkdUvwYeg6p+6rpQM0a8TQGNTWZKuomepNEjs1R1cNcoTugYE0U10pVqGfWmuPrUZijXVZ2Z1Goq+EJlDRRQbI9r/LZsHNQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CWRM684o; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CWRM684o; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Gzz44lo6DAvI1Gi0DW63mbBCvfi7XgpfY3rx7NW6Wh++iVirIofc7ddBzy7hTsB1XfiSWCIUaxjoifa6RehIGzHLgSh6o29GBlY7Xgg4aV2O5zfU8vGlEKr2irVaTkaQhU28QBvDeE1r2kL8rFWDrkXrBGxLh7A8pN92YJ7TeJn5lHthQqKy4HeMgBH/PUk3A+1kSfRc3dfGGNIx+mgfU/qmFLjBzZ8Oyu9pTD3Q/pJaI+MePchixTOAdG3Z7LFxABXlfweVQBtofFJ3Szy9Jhi+k6l8czQJrxrONpfE56i5V9YuXNeTYHW+g44CQhnVC3Ub7fatRsYKVM4VgMV8wA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTk9d8dPB7FqS/vhusHWKpPohu/ch37YNaa9xHLlmS8=;
 b=dDQfZ8pYPR1+OEdFs9cU8uUch2pHsUCokrIeiWRh6gP7rJiDiNzva6Sg2K8G/iuNtIlcBuEQrN0Z9b9AsOdWK+sKu6il+X5mNp6QpSLEPUJRuI9uQu7QTk9HiNii7a/82c89uGgGe16E6t/EmpYveG7b16vk5xFp8G3o34AVDDz8b3BdRtejowTLOUEMcEI5e7VyMkcRkNl+fTN5R5ptcEnNGYjZIEeF5iSiim0/CllKzQzj7UgNylKXSM5/B7zOhdRqm+W/Kz/jjbwv8/TjXbhJSCtgn4U6cBpNq0BTg2RjLYPneYOZxjGwKFv58LigFucUCptKhbB2Og3L0Tkjvw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTk9d8dPB7FqS/vhusHWKpPohu/ch37YNaa9xHLlmS8=;
 b=CWRM684o2jSbxpRdcGShwDeZStBrH/T/OpVD5g9VjizRJLgT0dK551oeJ+Vr4Bv3xZY/Kmo9KZNoYkomXkX8G3olz7ts9GkKDsGPVLh2dTjJTWrxZFkJ0kJnEEXlAGH0coSQuXymQG423RuFzJwvbOfo+QU36ND8W5jg87J2j5A=
Received: from PR1P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:346::11)
 by AS8PR08MB6279.eurprd08.prod.outlook.com (2603:10a6:20b:294::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Mon, 2 Jun
 2025 14:10:52 +0000
Received: from AM2PEPF0001C716.eurprd05.prod.outlook.com
 (2603:10a6:102:346:cafe::8e) by PR1P264CA0146.outlook.office365.com
 (2603:10a6:102:346::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Mon,
 2 Jun 2025 14:10:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF0001C716.mail.protection.outlook.com (10.167.16.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.29
 via Frontend Transport; Mon, 2 Jun 2025 14:10:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TafeUAgw/ULbdm4e+IqhABbMuowo4fMOn0MgClSTFc64N2hs9exUBwFJXrD7GZwIny0riF6mrcsLUmmm1BYVlrP3wkxgy9xBrvnIcAkA1nPmRRrJZVzj0j4cDBZeKw9Limrb1eY6P8p0hXfF6fwv3G60jHoParlRUlFT8FzviEetXZBWYxEnEACVrx4zfkj4hiFyf4oxATBXdqs5j7HpTnzUDr0RrKZMLU3s50zmEUNKj1v+/Z5oOKHM9ksOsNzlR4yLX1uSOmX9sj4iZzu7rqBtf82jAM9gWvXd/5hob6d9IqGcIaTc2OpQVpJbNFovfjpt2RQsKr35sQMQ38h5sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTk9d8dPB7FqS/vhusHWKpPohu/ch37YNaa9xHLlmS8=;
 b=xawNOH3D8FH0vW+CDXsZPTPL7wHxXqZWHExil3P3TRLjywkbvccfAXz0GEsmYeXTuOxfdmkrjSSX59oa7gCSZV4WVC8Zo40JEPWFzsX/AfnH1RDGCR6CX/G0nrbt8IrpxWaQ/eCxDAje8lhSud1q7aDP+xWBcQ4qT4+zn5hSHtMsKEKiToFfSi71U9L3hn3BBCDTusCLyWVYMxfXygZQoJngAL1kJMsQ/NITqZuzyuHW+EI4h0LleDTVWyiFcYCrTzk29GKXb9xMUe9VCJb7axQwj+nKrVLLg5dtwwkpqm1q3iUv8KX9JYaJVMs9UfyiSbFE9G+wMWugOLyjLrnx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTk9d8dPB7FqS/vhusHWKpPohu/ch37YNaa9xHLlmS8=;
 b=CWRM684o2jSbxpRdcGShwDeZStBrH/T/OpVD5g9VjizRJLgT0dK551oeJ+Vr4Bv3xZY/Kmo9KZNoYkomXkX8G3olz7ts9GkKDsGPVLh2dTjJTWrxZFkJ0kJnEEXlAGH0coSQuXymQG423RuFzJwvbOfo+QU36ND8W5jg87J2j5A=
Received: from DU2PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:10:3b::25)
 by VI1PR08MB10197.eurprd08.prod.outlook.com (2603:10a6:800:1bc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Mon, 2 Jun
 2025 14:10:17 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:3b:cafe::4c) by DU2PR04CA0020.outlook.office365.com
 (2603:10a6:10:3b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.31 via Frontend Transport; Mon,
 2 Jun 2025 14:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Mon, 2 Jun 2025 14:10:17 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX05.Arm.com
 (10.240.25.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Jun
 2025 14:10:15 +0000
Received: from arm.com (10.1.34.144) by mail.arm.com (10.240.25.134) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Jun 2025 14:10:15 +0000
Date: Mon, 2 Jun 2025 15:10:14 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: <linux-kernel@vger.kernel.org>
CC: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-api@vger.kernel.org>
Subject: Re: Extending clone_args for clone3()
Message-ID: <aD2wxsTweADD4f3Q@arm.com>
References: <aCs65ccRQtJBnZ_5@arm.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aCs65ccRQtJBnZ_5@arm.com>
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB1PEPF000509F0:EE_|VI1PR08MB10197:EE_|AM2PEPF0001C716:EE_|AS8PR08MB6279:EE_
X-MS-Office365-Filtering-Correlation-Id: 62579cd2-e5cd-4e98-7fde-08dda1df47b8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?QZp94p5uqipEXgG7luyAPrgTbdkC25pRs8FiMchHVz31eiQUE7S6wEXimhr7?=
 =?us-ascii?Q?km1AlY3CBlHxDGNrDeqe+hXfdv8Ectl7djQIlBub9dCbGelkTvv2HxkLuWO2?=
 =?us-ascii?Q?HfuI8C7098RJ4gUQxilzI1a19Mt9DuEgEf15Nz9GJfPVThCoBiPqaKdFOFUr?=
 =?us-ascii?Q?6IdnhwiZJoW0/rkNyJVXpBtXPtLbvac23RhcuCi7F/Js02BwU1X4OwwLgG8l?=
 =?us-ascii?Q?+9mdw3Qu0GFlarY/gnDEkETwvr8KSv93rekzb3tLUYw3Hull8SPSu4cfNuMR?=
 =?us-ascii?Q?sfuUcuMHC17tvK8Drpi8prQb8T/lRGsXbtAT97suzmwcKn1X4ay9MZC9XoDV?=
 =?us-ascii?Q?BVo03hl5GuiY+82yg7XSUbZvDCo3A7ezZKcUPt9VcOAxqkdeTkaLmq75+EXP?=
 =?us-ascii?Q?jRVCdkLGy54F0lSpqJcuDPe/Vw+Uuo6wh6ljmfsHbnq5IW7jXzXkLQ4jACi8?=
 =?us-ascii?Q?obXLy2jjsZedhxGijY9QlmrlQ8czFz4VWXDxjEXgwgqa7FKi7x6sViuAWT8A?=
 =?us-ascii?Q?sS/uhEuPR8/H/XlUQ6vfh7hkIZYjUx/xnwFil/wSj/7yIHD16fC8gdVptP1a?=
 =?us-ascii?Q?KgoDF6gw9i3MmAc9c3p5xIZjOJ0P9tionTM8LK2zZVBAtrhz3YNYT5uyY8py?=
 =?us-ascii?Q?uhENFZnYR62omcsHMGNxMmphjdmuxMTRw5aI3G1fpm7aEi4ILyNsRj7IjH3r?=
 =?us-ascii?Q?buemiF3I+JhCDeiJ+d5B7uXN1TV4ZU+PrLKivXbIDWvRzPp6AS6bp17TmSlB?=
 =?us-ascii?Q?1gsri2uFvk3B8gROBg8YFWIrEMOAutn37FgoaktYu1rIMeNSWUTXqTKSAKFF?=
 =?us-ascii?Q?QCUF0uO846luBQxQdC3+NHGMXveiP6N5mZxXCNDipzIetqIrUTS55YOLPrMr?=
 =?us-ascii?Q?lW+UQAAagOzjWz/h7BZERDsm4QLLIZrEKwrGnHRSXkuTbxxo4Y5l7T+k73d6?=
 =?us-ascii?Q?hSrhG5meckg4qKS3UT/3udCbuzhagH+kgxhAx0LTWDb5k7NOfEpUf9uGG0gE?=
 =?us-ascii?Q?kZyM4gBjU53sNgN+r/4cUBC6t9ufaphvkvPy/qbPbSg/zls8TVs2nelz+fsD?=
 =?us-ascii?Q?+689tNUeksWZuzI8lwbJESvqaenw8r9ZimrO+gXt6yTqabaMHEMkeVVbgSJs?=
 =?us-ascii?Q?fH62i3HfPl0MDcmbINntHGCdltT/BggyXqvNsbrD6ImfUgbWz3Ymaa+Jcofv?=
 =?us-ascii?Q?LRkuI5zaU4Ys+KGbaTcM0s/WsR659JO6up0itbK8p6fqNK+kpj0BroRUwehO?=
 =?us-ascii?Q?HGFNK+mVU0p4QHZesXyC6u9IBj9dHlAAs+6OXF7vDJnLNFWN0C7uG8iJsEuQ?=
 =?us-ascii?Q?v1zXKTFxsnlhJWqwyBO9XJVsazuxjHkqE80svHI0iWjuuFpwxcyqK+5gSOpe?=
 =?us-ascii?Q?pl+4rHCMbKMVnYJTV3H48U3e6mxIBgNZK+2H+7RM3+yaqdckNqDrYiHtzsly?=
 =?us-ascii?Q?1O2ddnSLnXLOvUdkblbANk88RcFVyWr7sOJzC7NpibpwEj6lbcLWK0QdXOFR?=
 =?us-ascii?Q?K3CTDfmhRgNARNsi8VqDhlRGf6/E0Tp6uBjs9/e0vZ0MqW0D8lFjrYmFkg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10197
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	eb038632-db97-4dbd-032c-08dda1df33ea
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|82310400026|35042699022|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dYS3qcHOtuuvk+xX6cpMITFlgZe7XENt1I/heWthXEAGytBYMHiKFrCieeMM?=
 =?us-ascii?Q?80Zb3uEbCPT986bV8AZ4SiJ1YvZnxQT3tKZryrqVUPt+/WqFzWqfY4KAbUL+?=
 =?us-ascii?Q?FPICFbMkQnhN3VmtslEULpZKTh4NQiqNGKsFx5pbKKfIM/xFiBFRloarbP8S?=
 =?us-ascii?Q?x5ENQQEfF6etDrxHX8OysCg0zPRQlGc3xhvxgCqU4BLyl9O8pzXEE/PKIlRf?=
 =?us-ascii?Q?wst+7ZaxqHl060c5Das45E4+jv+DtWII6EOFsJpkmBJRwG7BPjLqMoI91Trf?=
 =?us-ascii?Q?v+7usOzBTdOBKnXw7P7SG9Ku/N7KrFhdBchvccY18qD3W8d6n9hTrSAnf4oq?=
 =?us-ascii?Q?Yrn3/wNlejNnl8R+/udsmQcCe0bQsm/o+vV4xvhmM9JX3SoQJpgC4XIt84Uj?=
 =?us-ascii?Q?N1D9Z2DhSANM1l0+1w8FWQ6z8abaSJ+24Rk4ad6Fv7X6Ac/kNO/lsjKZjskY?=
 =?us-ascii?Q?Ge1SlvEsiZV0SRBrStmpxD65wWUVGXY60wXTRJ/Aqh/3q/u+9NZgw7CGPRC5?=
 =?us-ascii?Q?tKETxg2zV47bR9N0SAXjbqHiYU7ZVfePbu9FVnZ0wg1tStu9W5ZU4yUXlXLG?=
 =?us-ascii?Q?NV54z1r3HdVcRUC0h/zbTw9KzXi42R+pH9nhUTK9DUji1mKG+9GKi9uRlvGE?=
 =?us-ascii?Q?gpPo1RO7ojuyOdAAcwH6lCT5iDVFV40pdG+LQs5OwQ2cQfFAj/IXOAphEiIH?=
 =?us-ascii?Q?q1aMmonpAutlDgd93jy+d7u8rGhok2byKTO/qaXDmpyZdiSoD2g3XAIhRPcU?=
 =?us-ascii?Q?PRiTLxcdra+TO481PgDuF+mk0jW4IpS7mwEPB4lClYTjvTOwZFFuwnshsZVs?=
 =?us-ascii?Q?xwDRf032tE2IlVw9Xr53bi5ZgB9vCiM33F1gQslPy1V8B0pUZHmtajGOtN8c?=
 =?us-ascii?Q?d7ZoSjBar5ci4pAqXmeXupQV7+dwVYM/fCdXtVhyUNzXrrc6g34T9Dge15b5?=
 =?us-ascii?Q?imIY3/YJKZ8ArDkqIuhE51COQp8Icnx16PcZr6Fn+RQub1JtV8cBKx5x6zAU?=
 =?us-ascii?Q?utGhDjJ03Dl/+X3G3ilIJgAzRVQZ64oiptH27oc4r4YUrOwtscGNS271M0c4?=
 =?us-ascii?Q?RX7laqdrbXfSk/4MaJ8ynzZVcYDohiemPL5mVs/s7mxgBWKIvQZD8GBKU3be?=
 =?us-ascii?Q?dwuZMSR27qMhZf5e9xTrkV7srKY4bhIxwD+qoGvLod5UyFmF2l6mF0a9yS86?=
 =?us-ascii?Q?AQerlmNiUwcux0hqLDdkD9c0PDwLoh9R5SDudj6BZKGRAWacMlkDGX7DQIca?=
 =?us-ascii?Q?iT6n7d6n76+N9zutq/OosNJng2a+8was1K1zpt6vFTQEj84JK7rCZVgfJg45?=
 =?us-ascii?Q?ptat0wiMGLQvKDOwVDXd6Wtps1X09wRN4yLKhATIC7JlaitSQO95TkMydc49?=
 =?us-ascii?Q?Sn/d38aLHWmS7ijZCYjMNBdXlFzmL3rNhu/uaKUq/Hq8LQHFX0iKeyNo3rXG?=
 =?us-ascii?Q?ysPQr3xQTr2Jgzj/DOirTtJ5aTR3/oAReQWpbcnyqhcNNub0MJQUwCp1BtY2?=
 =?us-ascii?Q?oC4qsI7MvfFl7IsFteHr6vhZQ+qi68OLwosBPqCM60r1PrbH0Dhe9fEqFg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(82310400026)(35042699022)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:10:50.8627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62579cd2-e5cd-4e98-7fde-08dda1df47b8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C716.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6279

Hi everyone,

A gentle ping :)

On Mon, May 19, 2025 at 03:06:29PM +0100, Yury Khrustalev wrote:
> Hi,
> 
> I'm working on an RFC patch for Glibc to make use of the newly added
> shadow_stack_token field in struct clone_args in [1] on arm64 targets.
> 
> I encountered the following problem. Glibc might be built with newer
> version of struct clone_args than the currently running kernel. In
> this case, we may attempt to use a non-zero value in the new field
> in args (and pass size bigger than expected by the kernel) and the
> kernel will reject the syscall with E2BIG error.
> 
> This seems to be due to a fail-early approach. The unexpected non-
> zero values beyond what's supported by the kernel may indicate that
> userspace expects something to happen (and may even have allocated
> some resources). So it's better to indicate a problem rather than
> silently ignore this and have userspace encounter an error later.
> 
> However, it creates difficulty with using extended "versions" of
> the clone3 syscall. AFAIK, there is no way to ask kernel about
> the supported size of struct clone_args except for making syscalls
> with decreasing value of size until we stop getting E2BIG.
> 
> This seems fragile and may call for writing cumbersome code. In essence,
> we will have to have clone30(), clone31(), clone32()... wrappers which
> probably defeats the point of why clone3 was added:
> 
> 
>   if (clone32_supported && clone32(...) == -1 && errno == E2BIG)
>     {
>       clone32_supported = false;
>       /* ... */
>     }
>   else if (clone31_supported && clone31(...) == -1 && errno == E2BIG)
>     {
>       clone12_supported = false;
>       /* ... */
>     }
>  ...
> 
> Is there a neat way to work around this? What was the idea for extending
> clone_args in practice?
> 
> I suppose we can't rely on kernel version because support for extended
> clone_args can be backported. In any case, we'd have to do a syscall
> for this (it would probably be great to have kernel version in auxv).
> 
> I appreciate any advice here.
> 
> Thanks,
> Yury
> 
> 
> [1]: https://lore.kernel.org/all/20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org/
> 

Kind regards,
Yury


