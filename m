Return-Path: <linux-api+bounces-3812-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC639ABC048
	for <lists+linux-api@lfdr.de>; Mon, 19 May 2025 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AD84188A1F4
	for <lists+linux-api@lfdr.de>; Mon, 19 May 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5505F27CB3D;
	Mon, 19 May 2025 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JzEkLFd8";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JzEkLFd8"
X-Original-To: linux-api@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD026B099;
	Mon, 19 May 2025 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663642; cv=fail; b=dbJfT3AJcnlnYybNwm3LLfJkJ0QiL4x+WrEtLY7H/sIIWkCooSiyKb8HDPDb2Xl60oUDQbkElkoNcvDSPzsjQalCtO3n1RA5lliaVqrdBsEprmfnx/AOtoVLZdlaPSVuleyptsPnJ0Tuur7bUL6KLiuV2h/lfJ6Sv4yZFuM4SVQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663642; c=relaxed/simple;
	bh=FnGdQrwCnG6ws6JLZ/thuJM+j6iMDHroSugOSTbg+VI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jEW7zGFCm6DXJ3G1CIqMYeR5rFNK8ZsX2IiplU8wZ4c9h9/TjYKRCRdgdeioISzxBhzy2jQbJkKapvFxRAAlygIQozIh37eY/5xNIMzwXkOF1vhldDZXdUtUzIW96nPF2kgMIbTVwFuMyll8ghy/ABAwmYtPUYvoZT4Jm/nNPsY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JzEkLFd8; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JzEkLFd8; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ffnr0BqXt7ZCM5gNZQ9CxxBAG3Jnl7QAE6kGBn3t1RYEM8hErRlJMTf6E6QOgeieGILn4lOQYXtAhAHtEF66FvwqW/T5mPrHTN/RK0CLV5P13k3oqZZx1I4dsEuuxme5T5RDDGZayHygfqz3FklTySqZbLh517mc68U7t+B4wMSHyA8Mlvw9j2kixbW8PvKFBs/mzt6LRUPcA8fvqdHXnK6jToUw/oD1/om3Dln3YYa+06qYDyJm3La9YFxKLP8wYxpl9u65vAHoAPnIz26CbbbpSa7SuP4iVW7H7eMDexewnc4MVMMvBWpRXXtgKJhy89yZwxjhDccwHgUwkXYF1Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS2A3XbtIULXnltAFqVAmJx3nCkGDML0+itD4PJp36k=;
 b=N4vFVAqqrYw1dwjc27ngkpqJgDS3WX4whIpJCQp9hTk3WYc/qs+BiV0msNUrg+PM4nKonRhfAq7Xpvg7GrTK0MVbcWNSDY6T7Du3UdP75FFlXzOsNRtPjOKVlDtC0MBjv4x7rDP/Lbmmg20Phyf42BZflxgUP2JDh3D/zqi7cxfZ+cz4DQMzqWEzLVZZy4XNUdHV9X6JNoogtuU3cp6zmnlfIreDiO3P8a7GnKNkP026cMsqEW/G99PwL1T9aWItEmxbhgeWBAatBaZRG4sW9w+XY645bk+Tk9o7VY/Wip4GS3UpW3RyB3q7Al4DnmRpiHFZmE3vGpFpFljPVcvLlg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=0
 ltdi=1)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS2A3XbtIULXnltAFqVAmJx3nCkGDML0+itD4PJp36k=;
 b=JzEkLFd8kFO5e1wt3rrt8G+oKQAgy6VJygHrhHqUq2GO2jNDzkKMlZkD3jMma4LxzD0P66WhQCqT/0Tp8R81L5+rKS0AYVcZce8FMCtghF0XGXWkpeuLFibD6YCEl1cTi3oSuUAKl46lhAcdT+v1mBBTSywQKSQbzyypLC339fw=
Received: from DUZPR01CA0067.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::6) by PA4PR08MB5918.eurprd08.prod.outlook.com
 (2603:10a6:102:e7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 19 May
 2025 14:07:15 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:3c2:cafe::cb) by DUZPR01CA0067.outlook.office365.com
 (2603:10a6:10:3c2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Mon,
 19 May 2025 14:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via
 Frontend Transport; Mon, 19 May 2025 14:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f82dyz6ysk2ZAtUkT0jrV9q7CGp/ptGzS9kWiC08KSxGxkCu5kkAzfu3RCrvMv25SwjB4itYJvCDv0tlquN+PyCLY5yT6TLy3okjpzOPvYwhapFcf6aP923PZDxe63ROjEVmX0ur/7SYX0ehfo7qB8nEe7VStCudukkotJSqdq4CxyKHq4xGg9eNKS8Rm3AOAUZlQ5jTAuYlDQ5sSdZ/gJPjpItdkVd7M13ninOJc1DI6aYYDsxtHICd5YAawsXByE2sviG2H2sDG+9XEQm02PCWU2zhjWop0Xv7JGD8f/WVQ7E6dlLeYPw1yQvdcc7JcqvXlB9oHiIL4FCVqJ6vJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IS2A3XbtIULXnltAFqVAmJx3nCkGDML0+itD4PJp36k=;
 b=eth75n1p+rOecvfT4flWB5DnMHcpBD8XcQ43D5JwyjaUbcLtEUyVaBFjYOs60JJ4PWn7jjyJOSfLxwIpcYdMI+OOMSHa1AFYZfyZcqPdmStmlyjRFqwRpNndpCytFyCEAMdfeFLay8+xQmfDFbLrH3t4Ws19I1jnmC8C1QhXY6IxNkUuFJznQbXqHhhiRlXfhkhoVsCQ+Its7i/vzLGjf/noIxgekAqLEV3uJfUb+j/L2G3zBE91hjv5ztgCZL2xzJBbpdKzhVIgppP1STn9KwuTgZipJLPHHoa/XrEf6Zur9gYd6yBPuo1VgFryFRPgk1/VMpTmCFdE39qeqtAIkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 172.205.89.229) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IS2A3XbtIULXnltAFqVAmJx3nCkGDML0+itD4PJp36k=;
 b=JzEkLFd8kFO5e1wt3rrt8G+oKQAgy6VJygHrhHqUq2GO2jNDzkKMlZkD3jMma4LxzD0P66WhQCqT/0Tp8R81L5+rKS0AYVcZce8FMCtghF0XGXWkpeuLFibD6YCEl1cTi3oSuUAKl46lhAcdT+v1mBBTSywQKSQbzyypLC339fw=
Received: from DU7P195CA0023.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::7) by
 DU0PR08MB8090.eurprd08.prod.outlook.com (2603:10a6:10:3e9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.33; Mon, 19 May 2025 14:06:40 +0000
Received: from DB1PEPF000509E3.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::88) by DU7P195CA0023.outlook.office365.com
 (2603:10a6:10:54d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.30 via Frontend Transport; Mon,
 19 May 2025 14:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 172.205.89.229)
 smtp.mailfrom=arm.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 172.205.89.229 as permitted sender)
 receiver=protection.outlook.com; client-ip=172.205.89.229;
 helo=nebula.arm.com;
Received: from nebula.arm.com (172.205.89.229) by
 DB1PEPF000509E3.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Mon, 19 May 2025 14:06:40 +0000
Received: from AZ-NEU-EX06.Arm.com (10.240.25.134) by AZ-NEU-EX06.Arm.com
 (10.240.25.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 May
 2025 14:06:30 +0000
Received: from arm.com (10.1.32.152) by mail.arm.com (10.240.25.134) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 19 May 2025 14:06:30 +0000
Date: Mon, 19 May 2025 15:06:29 +0100
From: Yury Khrustalev <yury.khrustalev@arm.com>
To: <linux-kernel@vger.kernel.org>
CC: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-api@vger.kernel.org>
Subject: Extending clone_args for clone3()
Message-ID: <aCs65ccRQtJBnZ_5@arm.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic:
	DB1PEPF000509E3:EE_|DU0PR08MB8090:EE_|DU2PEPF0001E9C6:EE_|PA4PR08MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5c3ce0-5156-465b-63e6-08dd96de751e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?FbQeoxtGOKQe33LMkDW3TEYmOemYOQvf4ysQxblcp6R2aC79xF4+mw53wVT8?=
 =?us-ascii?Q?uv2eOfAksQdyGmbFkS1s97C7K7d7fLB5cY4qG/i1qoGcn8uigfqAMSB1fc9J?=
 =?us-ascii?Q?s4eWwaTxoBWCzDGDmXHcwNq6kyWhlKiV0I5pdwWl8/OWtdPEOxe7lra3h4GH?=
 =?us-ascii?Q?iZZawCp9kqf43sb1R4jG1BguPiivx28/Dv9was+mha25N/UQQZ1N8EYI72mS?=
 =?us-ascii?Q?0UNpO0pIxog8uMiSmP5Nb5OYDZ7GNr4IksCBh/24uN7H8D/6nM4c8bordT38?=
 =?us-ascii?Q?h9/nONlWjWg9Ec7dvHq9v/5COIGXyIYacyrjdcIuWHq142oA1ncblBEj+SmO?=
 =?us-ascii?Q?LXvFgbi30K8n2ivxUIqo+zmsnwZqu6i6jzqBjTE5fDaB65TAjjvSvkcySVcf?=
 =?us-ascii?Q?VYVGhfUPgsFJrdhcmUMyKQNQCu1VOgzhSE03L8IfdkxdpJsGHuhZT6gx7HLu?=
 =?us-ascii?Q?+62+8i6lVLaKt0IguQLWwqwVyFKY7Cai+4lZMunXZPUn0ZoRGTitea7AByVI?=
 =?us-ascii?Q?0JJXFU2/eghls8vH73LObLTrnGQe/BtMAvJxi8uWiVkAHFenhPahNa3WUgFw?=
 =?us-ascii?Q?CgMLsrLDXDnDPSRu1NXyproMLjlfR8ozjHA/jL6biia2Z6IUmo6iw+fdg6dI?=
 =?us-ascii?Q?D0EkH4PLZj06zbAMqbOYjTCwTmIqbh/6ZlzpQQA72+zkqif5CpXxbzbsKi47?=
 =?us-ascii?Q?7Ks8PbQw+IxtQMu2Amqlu1f87JGftDSeP2YWVH3cOBPW69+3Y5CguoweGw6+?=
 =?us-ascii?Q?oWIIxCrWh1IqPd371KFx2gOYjCsnRM5V1QyfShniEwbAJPnY675zUiPEDKMA?=
 =?us-ascii?Q?X8HN+zbrffWe1N5pwVbKf6GH3FzSNwi079lW9ddqpLp16w0+19u0E2fSCzAP?=
 =?us-ascii?Q?UYzE+Ma9NMHy+rNlvbm06gOXk0S7PAF5kdtCgdhfnx+oIbtGym9hy8m4qGKf?=
 =?us-ascii?Q?4LcY7tbYbql7LNpW4jxCnM81Ua35UcoV49CYdmhYCQ+a8LypWyZ14qlvPpmi?=
 =?us-ascii?Q?T9ogRR8Ixb6b93P1iWjsWCmj294u9SccpMhceQubibl8WDapsdhWAxWtcyZ9?=
 =?us-ascii?Q?wTW+I8V6uVvYzgJ/XXOa/e4e5pbNZ5fJBBJAYXMb6ZFWhB+5WGtSrh7KvcBa?=
 =?us-ascii?Q?L3Tuk3cpVRyZ85/SBdHjxBNru2Sp8y6KGNOM6w9rhEPF3ZtmKjHnbMXxIItq?=
 =?us-ascii?Q?9HP5Doon5hRl5OQwRh52AHnhu4kv6nmPn0byvJlAJSZIFVN+mbhbeJbaUbNv?=
 =?us-ascii?Q?KrmMnQ7kIizlEe3h1OUIDYc2/IfIzb8X7790+G4CAPlXFEsdaYdYcUUsztdk?=
 =?us-ascii?Q?jyOIMRCPuFUGZXKt6SCTYhSt8vgCvu1pcAf0h5s7xCm7JsE/XMLN+4EsYamG?=
 =?us-ascii?Q?Vj1blEpCVt6n64q7L/peEs9T21lB4F5Pm2kqvScdlDUl58IE+YcdKNVvlgHx?=
 =?us-ascii?Q?82WBZqUSHxfZq405ysFhlL+O3cSBi3NYn2n1KSHQ42YylLyo64MEzXMez8qF?=
 =?us-ascii?Q?dmhdSrDaAFbZsK9kS50SE+o1CKj5wkPGpWqh/NfJHCJvhSzYLTzgUNasaQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:172.205.89.229;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:nebula.arm.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8090
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	00e7e2e4-1b8f-49e0-1e26-08dd96de6072
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|14060799003|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3y/e8jEEPY/anxg2Jveznpv4rdx7zX8oajIdPIc29n+AlhfhZHr2H4tfPsjQ?=
 =?us-ascii?Q?Aaxxa5yTBiwrt3OcyybPDTkGTw/qstxsKWKj2x5q0Ntlh5kJq2g8a122zNNh?=
 =?us-ascii?Q?r3tf+kYK807T2BMP7gjmaeLvEowHKF3N3WUwYMcJ5o2vqOVmaONVFZio+nA6?=
 =?us-ascii?Q?r9yAyZz2joL5rLxJWaEZ+hqS6IlXr41T6dx2z551pITOG6Bx9hBs0P+D4wY9?=
 =?us-ascii?Q?BBX2TRryhGKjTzHxrWbcVwm8jV/Hqc3WY8Z1PQgDCd0uMFbdFFZ/pc+O9XSQ?=
 =?us-ascii?Q?I47tAH05k+mKTB1PfvIV1o3WYJnpLmnliS/PuRE6virM75MhuR1q0EUutFzk?=
 =?us-ascii?Q?fVHCgHKVQyoHSGg9dIZLJcGVNnQYcVbxsp5qGGCP0kPu0x+2P5V0sBMoFPlX?=
 =?us-ascii?Q?2CQQDhjCizpAJDA2McxhlgsTv9Paa/OThpjl+RieTdeBQh64dIi9WcdNjGWs?=
 =?us-ascii?Q?axKIuTNnG7jBDBXewugIdq4sPYrhj566G20UwWsAS2WkplYRay+xStyODB+T?=
 =?us-ascii?Q?QewyOvSnjwueONtpJo7k1vm3WtYy2q3uVhbBIEkJc0xc6yKRvJPQorvCJkJJ?=
 =?us-ascii?Q?GI8x4nZj69upcMCAfgngJZgF3v5+B11AMKNeZ1tkaX6iGtLZH6ukYI7i1c14?=
 =?us-ascii?Q?JQ6lp3vc387BWuTU5H3xftcxdUf/VuqCbt0rr5a++i3UmgPuuGvjf8rq9Hbt?=
 =?us-ascii?Q?qY3HRyrRWsUJGgVblB0jpazXqwf3071M4OANZLWl4QiP984m/pvGwnmY82gJ?=
 =?us-ascii?Q?jYvD5S57PhSVNYuJDSWDjIRma3/o+D7vzo29fWg2e5PYUZt5B+3uuCusbuvL?=
 =?us-ascii?Q?5Ly7TGb0wFHiUKBu+iYedMe7jq/QTFPPRSoQu/oEDQCLWP/APO/AQX1oVoHH?=
 =?us-ascii?Q?5+Qf8lPwVdm/eM0ofpLR8kU7EX1sVQMgA5zsty5LxhMG8qusCcxQfpRbU2QJ?=
 =?us-ascii?Q?L7TRuI00CikQF0mqL//5Nn0oMC7g1czKLmOn+Nug71XXOwbGdNR0XRQIKIxc?=
 =?us-ascii?Q?QSUoCpPcY0o4zMRqUXYDO4x/uh/xVC5hoQ6pryLVRdvE4Ie21pG5ScQ80pt1?=
 =?us-ascii?Q?7QF5W9OKAbSRWdENLMvKumgBjk14srqmlwdayhQBmM120hCD2qwTSlguh7oc?=
 =?us-ascii?Q?1p9EpbNAhmyV8dlUTmgtsMWa9aah6RBj2tWsnJ+l7PkacUmGgeuXfhZKeK65?=
 =?us-ascii?Q?rCQ7OC5707aVAsWzXEyh7yQFGx/Pzlb8hMyDYoqkdydQMv05XfDZjKx+/0c0?=
 =?us-ascii?Q?5z+kPcJU/dCe2qCQjQaEKT0FnTexcKbCx4/OzqIJGblMBirZj9NOPzVq9v2o?=
 =?us-ascii?Q?i6EqgaH64t6HAjc7/5HzgMVRwr+DJWEiRA8idvO/zw84MqnsdvhjwGn3ftkP?=
 =?us-ascii?Q?eexIceXrjBV254lKNl5K8Hlr3qEuyjZrMJFu0RoI5JIxpV3U/IV/P/WdAA4t?=
 =?us-ascii?Q?EO0WVhoKuaGfDpqXM+AQ1XGnLrrU9xNuq3RNxBxLWCUjv3CnLm+T8LS0nFE9?=
 =?us-ascii?Q?witv0h0tJ7N9O2tcLdwG6qFRYS0a1WkVJ4Nn7l/grWSMHISe1emTkJfBAw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(14060799003)(35042699022)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 14:07:14.7256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5c3ce0-5156-465b-63e6-08dd96de751e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5918

Hi,

I'm working on an RFC patch for Glibc to make use of the newly added
shadow_stack_token field in struct clone_args in [1] on arm64 targets.

I encountered the following problem. Glibc might be built with newer
version of struct clone_args than the currently running kernel. In
this case, we may attempt to use a non-zero value in the new field
in args (and pass size bigger than expected by the kernel) and the
kernel will reject the syscall with E2BIG error.

This seems to be due to a fail-early approach. The unexpected non-
zero values beyond what's supported by the kernel may indicate that
userspace expects something to happen (and may even have allocated
some resources). So it's better to indicate a problem rather than
silently ignore this and have userspace encounter an error later.

However, it creates difficulty with using extended "versions" of
the clone3 syscall. AFAIK, there is no way to ask kernel about
the supported size of struct clone_args except for making syscalls
with decreasing value of size until we stop getting E2BIG.

This seems fragile and may call for writing cumbersome code. In essence,
we will have to have clone30(), clone31(), clone32()... wrappers which
probably defeats the point of why clone3 was added:


  if (clone32_supported && clone32(...) == -1 && errno == E2BIG)
    {
      clone32_supported = false;
      /* ... */
    }
  else if (clone31_supported && clone31(...) == -1 && errno == E2BIG)
    {
      clone12_supported = false;
      /* ... */
    }
 ...

Is there a neat way to work around this? What was the idea for extending
clone_args in practice?

I suppose we can't rely on kernel version because support for extended
clone_args can be backported. In any case, we'd have to do a syscall
for this (it would probably be great to have kernel version in auxv).

I appreciate any advice here.

Thanks,
Yury


[1]: https://lore.kernel.org/all/20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org/



