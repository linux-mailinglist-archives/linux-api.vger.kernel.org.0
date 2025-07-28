Return-Path: <linux-api+bounces-4257-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC8B13CA4
	for <lists+linux-api@lfdr.de>; Mon, 28 Jul 2025 16:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2BF189DE62
	for <lists+linux-api@lfdr.de>; Mon, 28 Jul 2025 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F1726D4FB;
	Mon, 28 Jul 2025 14:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hObuJILX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hvrUJVw3"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31626E149;
	Mon, 28 Jul 2025 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711608; cv=fail; b=BmEQTWENVc7wqobkm0o8WRrcKDmZ4k/mZ6X0wAcjbh0WWp8QRBXuFy82CZzM4/mzJFVe++riafHUl0LlxGQL6y+bNLrcH3TXRyXYVSZgmEFKyrZmun/JPRxlDtaXUsKkZ6E988PPPaoIszgMoa9ZVUm0TJH5C5XpAIO/HX8pY1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711608; c=relaxed/simple;
	bh=sh3aAXI0DVmAGiskEYGMXIgdQVg252iQ1FncdKshY7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJUwg8WyqefrpZYDnxtINYLteSenaFWgSN4stN18sEO+d1g6SO6kKwE5hPXMfNRJzyGIV1+2lkMY+tNrJmccCxAOzbqp6xmLdPeYN1JjSGv+B2DZsU2i5fZAu1FPKT93xn5lNmgaZ0M7qlfBGmuPBjks2ZHkPe5x+6JX38S9IBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hObuJILX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hvrUJVw3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SDCRBp014187;
	Mon, 28 Jul 2025 14:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4221I4VavoFlyV5acjuFOmYCRrRWjNh6pea+gFr+11o=; b=
	hObuJILXZlA3V4eNCrnZ9pvSKcIdBVvjAoGSmb0Elm1D2aCX9bfWZSbZW8TA5mup
	9BIVTfohMs96JPbIgBST2uMMVSts8VPvo55ocowKLs2xanYRcT7ByqospVKohuBq
	F94yHk2DdPxJN4KE0Br3w6GaKF4U8Az9UCoWXfm4oIEsNKMNDKOGEAcnvHFpSgPJ
	InAumDYBT1bVQZJllHXSS3/17Qdz1nWXDnbzPxy/EFKV6+NRpHyuT4ig6MBZLE+m
	Gzwq0hYadhSOpJUz06DLPXOaIklTqnP2GdQoG0n/kRh4xH4uBmTVwgRgfM+iVxZ6
	oJK2/vhXb318fxZ4Fs1W9g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e45hr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 14:05:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56SE2MR7034545;
	Mon, 28 Jul 2025 14:05:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf8usby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Jul 2025 14:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A856XQbM9dToKLRSzEkRavjvBomffpeVytX88tS/ObNk6HvXY/0m3KIz71DW/dQPUXaBMQj87/2NKdpDjZTmrkrfWTRyQRuqJ9q57jhWbyktAndORqcbkLDq7n+XteBxM5WGIosT2n9zyqPciIr999ZR8nkk4iYsQUjK6/oAJBccNV2wU/vimsUOX9lWi537XLSzKwlqwEak+GX/gNPgjbzcbiyTDZavTECK/qBFcBqSQZszIxmd39ReFSQmX06T+/mOfG/HCP5C4jtNc9k3/IpsdTwPO7YfoHCqNiMf6m2AJzcoAXfMYUufrh/2ThFq659fX3s+9/bpxTIvgg7QAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4221I4VavoFlyV5acjuFOmYCRrRWjNh6pea+gFr+11o=;
 b=kgs67EHEtoCrwG1HaTvIf3IvuFWXb3VXfENKVYfcA79UblCalCn+oRM5sAq7B8gB6V/9IyFTDsMoTTsH6EPLDV8PMx5isuVnYT2DNDXsrk0D9EMuENPiwNA2dka4QYj14CGTmSlRF2Ip06VjXuR87sU809c9A7euDfdwiFKG5r1KMXmUCgzZLpil9Mxfy3fmjvj5l1WfFtiE8wzf+foJhZm1GLf1bZs0MtmIjo2vnFVmtm/t3CkTbh9W3JmsLWZ+ecrGLYXd2RXNcTJJejUbETyULt0trcyw4BrD/j+i90wrsaplMPfdRihi64S07foCNPYIURXxKDS5Y9DcCxfg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4221I4VavoFlyV5acjuFOmYCRrRWjNh6pea+gFr+11o=;
 b=hvrUJVw387rcmsUp/SVVMHZUslj3P3lq/ndQv/mfPpBoQsmP2QuDJtFjHqJnqwsi+UaqIopFmwgdFTCHeyZvXi2X/cT7db4iYb+xXx6wPRMUW/HEc7QdirKhtX76ysT3Oh5P8wPRM8POKjIMEjSueQyYbRMja2aiHUKG0T5fUpE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB5920.namprd10.prod.outlook.com (2603:10b6:8:af::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.26; Mon, 28 Jul 2025 14:05:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:05:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v2 2/2] man/man2/mremap.2: describe previous undocumented shrink behaviour
Date: Mon, 28 Jul 2025 15:04:51 +0100
Message-ID: <f9b165f911957d5263586f3bb67b8c5b05b6bd52.1753711160.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753711160.git.lorenzo.stoakes@oracle.com>
References: <cover.1753711160.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0086.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB5920:EE_
X-MS-Office365-Filtering-Correlation-Id: dd64f768-4d6e-4be6-d000-08ddcddfc263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbhtkZOvbLtkiFBt/etTE0dsAIDaNBPwsVMNnhNdTcs45p3URIh03hQ6gUYL?=
 =?us-ascii?Q?9k9rsr0/MGQiD8dRWsWOtqDwELaECOxfzEbfF5L+MVL5XXJnmPmRCkh0tLpq?=
 =?us-ascii?Q?HrHL8AR7InQBULu1I5E9+g7jQmPLIma3RSQVcjn+KBXtXdWYh2ezvX3e3ABT?=
 =?us-ascii?Q?719ZpMAo7zHwd7rObZY/wVFSEioWS1rwuZo9UCH0sQmByv6I9gK0Lrvvj6hS?=
 =?us-ascii?Q?TXWkmfgIUFNDnMup0VkCDl4pYpNfzH+VSqeH/EElrauPmqJpfo/DsN1uPrAL?=
 =?us-ascii?Q?O8RyJyLLr5j71GkcBo8Qr6qW+pAjp0IsFWCTGAkPSASJ06jjuGlzUT/S+bxM?=
 =?us-ascii?Q?BTTMW/ZgMOzL0QHvtktJvcruaW8C2ulsRTqa29bQumnmjJrB42hiCQfGE34x?=
 =?us-ascii?Q?Fa9XwR2On18yUgKgkSFalvPk995GRDuE9OIHwfXkLnqDhWl7n3yFboHl1Mf6?=
 =?us-ascii?Q?ESA5EKf8W9vvUbTGNXLiHYChe70OUSKmPWqnbXjJbJV7v36PexJc+GNpSP3C?=
 =?us-ascii?Q?u7AdLO6MCPMblX+SUXmZFOs/HhQtn9TZJXAVZgKSao/BffNd8+m4N5uNZ+uZ?=
 =?us-ascii?Q?bR5CcndlGp+dZMpl/2+6EO1zDAkR+erDc9DiAD8OcR+u0oVroMFEnlogQT2f?=
 =?us-ascii?Q?dmaISyhybPzSXi9mTwV7oybKE6Ea89lSpzjZviBoOPkxskMhAXffG2RsKR/k?=
 =?us-ascii?Q?pclbv8ab4z9mUVv3TkN6cAffUDxjsi/c8c/wLr54h0pl2lJMIvC7W9C7HAWr?=
 =?us-ascii?Q?NavMCQtstO8l0S3sXiqW9jfx0yUWOxko6eQn8ZIDJiXmrMke+AAkiXrLZa1z?=
 =?us-ascii?Q?8EGfKvdWg/QmgW7VnFqWZBPrHE6pTdD1PVJsDOflOx641c792ulfo/DbjyDk?=
 =?us-ascii?Q?CqXN99O5lGzWaxe5RbDuQ/K60zpzyXwyrlQgmL97B8ODE6ZIt4aOVGbMicTz?=
 =?us-ascii?Q?ueQmXgScTzL4RgLmQX8Q0lu96l/ZyVogVQt7AMqeuMa4JIFEQ7jWG1unvY1u?=
 =?us-ascii?Q?tFWa1QEpR1h+hM1sILlW+U4pBoSEYkp+yplEr4aw6w3zURun0Z2oSnBDVm6C?=
 =?us-ascii?Q?y2zwnijFeB/hUP4q57cOnFOXswl07QBMBlrr7pYbKEQwgr1WbI8nPFLF0xT1?=
 =?us-ascii?Q?ZQU7VQ2RCk6v7AUTWRsA75CDzVJlENPduqsdtC9+7kpcWdEgjFng3MxjdMcZ?=
 =?us-ascii?Q?IlIWD8VdDx1FFe/8GUpaae12HD13jy09PBJgDovZldG9lAnsER+2Z+BolaO7?=
 =?us-ascii?Q?J9n2b5a0/+uV1Cgh+cx+hbUMS20O+a/c47RRuJqASaDuwsLj0MIwRzWPIWTB?=
 =?us-ascii?Q?F+SSCSP7OO9N4yvECXmjqIQ7N+NhTKCJRbGDN/rWXErb+1NlGSkt5ShAXH4O?=
 =?us-ascii?Q?kC1E8JPFubhT6wnqp+BK+xLzfSxH2LZpClNgYbfu+Fe8+lNkILvEL24YdyzF?=
 =?us-ascii?Q?2EX+b5Ri3gU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcWgfrZH1UPtfzT2id3qoRm2tk0c9Z1s0sDf83elDLudD6duBDWkLWOYjBYh?=
 =?us-ascii?Q?avlizyGuVfVsaV+nsnZw+MN6cAlosRoCHtT3QhfjVUGqeC5pOgZo/K92YwaX?=
 =?us-ascii?Q?08czaTPast7CydoPcqiAif7HAVSsxPjBjXAuQEyMBEd3qR0jH/+NhtQZc/G5?=
 =?us-ascii?Q?sc0bVCtCDcwvjkDp8i3pz8hTfzwT8/yCz9QqL8LGNWzK4JgwHxWJ9MiP/sE2?=
 =?us-ascii?Q?9ER/mRB8o0aFtc1hLhPG0xPjyPBEDAruuMNm7zSYRYV6LT2D9s/q/bqTB4yl?=
 =?us-ascii?Q?H48QJuV27tmgkgXNRS8K5C/LRMEcrkFS5awWDKNSaxY7ZfYs8kVDoPykoVDZ?=
 =?us-ascii?Q?YbJHSJ7gO+hq9iJ0qr/JS1G81rIIRzW0U1VC8s6WTGA6sokYhEWVbDgNhH07?=
 =?us-ascii?Q?L/F4TANCrkCIW+KWWGIde5FCFU6RGW+1P9IKujcgMUcor00tFthwPWUHo7/e?=
 =?us-ascii?Q?Lh+mRyMsP8OH3q7GRgAE9TX3u0aS9xBQZk97pmLtXQR8tM9oFrX3u9oboxHj?=
 =?us-ascii?Q?EWT2wm6M8S5Eajqu5qAuYJWH13FosMXrcfzLDMYOjc7yYUs0IZN9/vT58v9q?=
 =?us-ascii?Q?aIpmljKrDW/CKefTULuTvCKFwE/VCnUnkDdrjY1mbz0SrL5y7OYLgK/Q/NsB?=
 =?us-ascii?Q?+SiOVE7YAqN7amBHygycPZ6gU29jnewT0m69fyAeZFi2XFV23z5u9KrSW+me?=
 =?us-ascii?Q?/x8b2HEPJt9C+27bvJK4qED2Iu9iXiqcsho0+xPx28F2K+HoXMYxt6WBe8ZN?=
 =?us-ascii?Q?ZM6uHSr1O6CuckafKg6nlboYIhnpk1Sb/XOQIdQHeIFj7n7Mm+36OQjE2vIp?=
 =?us-ascii?Q?P1EA+41c/UAZrRnwjHDRjlC8jsKmsLhqIoF1U7RcLjmbeKNq6XsEyOUO6lk+?=
 =?us-ascii?Q?BprTDEnKF4l19HsrYnsxO4ivFC8SPy8Br7yby//hWla4N2DDIX+QhvT6RzVa?=
 =?us-ascii?Q?Hj/2vjBdFUZn1m/CRS9Pf/nkPdO2ytj9GXTdpGK3CRDzDZR1XvAsV5HM1zGU?=
 =?us-ascii?Q?fV322+2BXjQLcujVxhr2XExEMYpWL8iujFEa0LScScml3gKgbPQzBrhZDAMh?=
 =?us-ascii?Q?EVD26KvoxRFpEMySZgDRlmn2AUa9tptQrv21096qu31rolzGXZWZKmGw85a8?=
 =?us-ascii?Q?QOpT8Gj0BVzQHbvnNrEuEEsfRWAuerXEffOkFqK3yJ64ri7JxX+lypJOHCvp?=
 =?us-ascii?Q?eoJK/LlIxnX+2DePvjKm8wzRiYQbKPJmcYV6V0CsqN0rofJg18s4qxctr0ak?=
 =?us-ascii?Q?f7acDi2JiE7P6/ZVEpaCHZhomcPQYx5OzhtDbtfViebbrUhbus+C2glhD1I8?=
 =?us-ascii?Q?LkEa1NKaa6qmZtE/G6W38mlTHTGed8BsGIDACNL3ReYBqfEE020nsPjgvRaO?=
 =?us-ascii?Q?LDrHwWaWAsCMRdLYirbuOA85TvjbO1O0mLnfAlRwe34Hc3LFMXYw+MvHBv8+?=
 =?us-ascii?Q?bpl6zbrNzlxzdpQl38FLYI0S5R8OOosUIQrNnNcssNPNrDIdVOgoH6yJ9o+0?=
 =?us-ascii?Q?uCiTTy2Owk2bSvW1UZHC3SMg12CtleW7w10Pqw74s4EpTmq1DJKAj2qQ+mf/?=
 =?us-ascii?Q?nIIxXOX0qsClpPvdSye40MOV8iA4o5e9czv3f6FVAyqyjv8P0HLBsj8lJIE2?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O+L3ERlbeTfa05SrnFJj2kqpaDeXafvjpUscZh5GLuhhEgQm/UQAZ8umqqp9jnN/jVF0mJ05PgtRumej8IqCjJr0u471Yey8ChFLTa6a1+mK3zoTuF/Z8y0vsClY/n5PUUVM3R6AkFVdu7QqII/4iPNc5VlTcmi6pM4TNRLbYWiy/mO791E2hAB2GdHngxYTQdk33sGPgDXxJfE+aPtehe0P1BIhUUvZNeZqVIRMXaXRX11Px4eYfvrAkTYoPxPFgBvPBh3gMMBiSrQWLNP1bEOn2bZZhCaOY5wlFL0sZAfIlFMAqB2sHgCZTx2jpGc7ocE3II6dRf1E2dW2RLd6v3FCtS22mJVnyckRWVyx8ofjigbuds5Ps45wo8YjEWIBRPxHbTOmPH27eCUiGavcd/WQ0Gcg+9KPHplY+TZzuE1iboLfkI4434yU7an6IjC2bxevqxLaC4F8WS8NkDjot3LkS6WJ0xN68pVCvwrPe7QYXuG8+rRrQGX0okVy4V5//Wv9ONB57s2tHkDPgK3KSYrvWv25xwUdo/hFKif7f7psAc77nP3w4m7tD6SDwwQHIjBb2RZhNDoZ2PN0gcuX0n+4wmXYafHzh6xiOm5ni5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd64f768-4d6e-4be6-d000-08ddcddfc263
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:05:07.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuxiBuvRbwQ3FITrPob2P+NC4pes0QmlHOu58NJHhSInn7U5VPlrzMqGsOUtNAAB13u481mqGK7tOUACquwJjdSbTK5peZirNvZm4+iX8Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507280103
X-Proofpoint-ORIG-GUID: IB82IvYpJ6Lu4-DXex7k6_v4-i22pD_R
X-Proofpoint-GUID: IB82IvYpJ6Lu4-DXex7k6_v4-i22pD_R
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=68878398 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=O8myZlW8C2RKAW_23OIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDEwMyBTYWx0ZWRfX4EnbZjy1CJQW
 7/2Shoy4YXFpAffDOlf4o8yBRv3oqF8wEF217GqfxroZ36+E7PKy0BoK4dOvZ0KWWm70cTtov4m
 aU5RuRkUJz6B8VqH9toP2V2rjcLaUHOlxdmiehie91SH/Sd91WW+HZ+7c2kMxQm7LajSvmotRFu
 l/Z5L++p5txJqUNiXvfF0+j0fSNU6T+7f0SyiVIEqVzUsH/IcpqpofzRdW1OJTKgJ3/yl0PsUdX
 CqQGF5TnIWoCkybmIQMlY2Nl9pUxa3sssRfpIVhnfcAWPqvAsDwkCBw1ZKwBhKNRHS06G7dE2o0
 1NmWdwyyQ/65nDfKOiJQQAGTkHXD32vfOcK4O1fGV9gE0CxUftIuTWzW4pAy9R/Whc+vkMIAD8G
 3pn7pxcjN89p4eGng955fhvCImv0DmRB60UEXC6Ge2dHEKv9xQOOvjMn5m3nfAx0HQumD1oZ

There is pre-existing logic that appears to be undocumented for an mremap()
shrink operation, where it turns out that the usual 'input range must span
a single mapping' requirement no longer applies.

In fact, it turns out that the input range specified by [old_address,
old_size) may span any number of mappings, as long old_address resides at
or within a mapping and [old_address, new_size) spans only a single
mapping.

Explicitly document this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 man/man2/mremap.2 | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
index cb3412591..c1a9e7397 100644
--- a/man/man2/mremap.2
+++ b/man/man2/mremap.2
@@ -43,7 +43,22 @@ may span multiple mappings
 which do not have to be
 adjacent to one another.
 .P
-If the operation is not a simple move
+Equally, if the operation performs a shrink,
+that is if
+.I old_size
+is greater than
+.IR new_size ,
+then
+.I old_size
+may also span multiple mappings
+which do not have to be
+adjacent to one another.
+However in this case,
+.I new_size
+must span only a single mapping.
+.P
+If the operation is neither a simple move
+nor a shrink,
 then
 .I old_size
 must span only a single mapping.
-- 
2.50.1


