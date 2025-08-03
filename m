Return-Path: <linux-api+bounces-4284-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D495B193D4
	for <lists+linux-api@lfdr.de>; Sun,  3 Aug 2025 13:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108007A6037
	for <lists+linux-api@lfdr.de>; Sun,  3 Aug 2025 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282C3221FC8;
	Sun,  3 Aug 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RLUK6Mab";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OhdaZVGf"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980968F58;
	Sun,  3 Aug 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219769; cv=fail; b=M83fIOocRU6uChyKMIkE3aW3VAbzxfgha2R0tigN1DkoXQ9SyzJ6czCP+hTo0My8M3lm65xIL0dSffPcOuxjf4D0D3JACN+IXRbZBvQiULv+uWvZgwEmtr4Ih/h6iJh2TyCrWvKZ3MLT7CzoYPJCsQZ3nyWkOrJONnM1KsZRHSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219769; c=relaxed/simple;
	bh=t0Yf4cEvEvG5QyfNsLEMKtAoDXTiRoQ8aktCx81Ivjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tmynq5yZpXwub6UdhuoV4BbWREFYZmuIfKHmG3+sa3EXHecnVPyp9qOKIVyiDWKdtn6Tmnllzv6WSkFouoke1OfKfDrwwzcSCkGcTTCsX1MxIjxD33NCfTmtl0JFonf8HaIN7B+/0+Dw9BiRzF/xIwr2iENISbC5GLCIl6kOxSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RLUK6Mab; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OhdaZVGf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5732vqAc023858;
	Sun, 3 Aug 2025 11:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t0Yf4cEvEvG5QyfNsL
	EMKtAoDXTiRoQ8aktCx81Ivjw=; b=RLUK6MabQLbQAiot4nastI2D3u8eQ/URkj
	3d16oLAallqwz+XelRADyjhBg2jK2hfK9j3c5nDVPBu68XOTx2+WqtSM1O6DGCvd
	ny3lXxojhvcCPQMWSGs6n5jwdEjKAfo1+fDEsLbJHoRRZ1NeX3CUibXohT4ezl+B
	NlG9uutLwtnEE8BfxhgMoWB5a+ph5Sn81g+gKqFfT8CJjUeCJmDnh4ObPl6RCwRf
	kjYskbell0JPmZHTm8+X2P3qKBMCnCrm4ls6eKsPcvC03b/q8UrvEZ29xLJcmBPN
	QvKqTDtMbhDApzCWD5OieP9SJT5N4qPWTiplRxFQEkB78LXRam7w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489aqfh8db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 11:15:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5739NZ4g029132;
	Sun, 3 Aug 2025 11:15:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48994dvv40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 11:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXiYIzVISp3oYHcI1pEjdRC2sr6iXpHAm1uqi3vT2rpDTdGw/C2BqJ7h0Th+eYJQLCq0tSbNXHnVkZvnNLHukNTQ4J9VzgZeSksCUPIxyR8VFtNKnYGNjVIbXMftKE2nmouUAnAAkhKCmYkh8ckAMJoyLo7SxXREEsmPpKygGMXGfw76Lb5nbSHH6lHxiv/GAeQKAXzQUhKPwYWTnB7KVxqP1+ssJJ8p3CZrQA4hEoBFYPw1+wT0XMqJyasWXMnvE5Nj2dx1t6sIUacBgbUHRjQvBohUkh6wLFqM/CIlsCvR0XKfVF1z0AcUdmbwzXx/NnylhEdBFgiiwWusIdg54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0Yf4cEvEvG5QyfNsLEMKtAoDXTiRoQ8aktCx81Ivjw=;
 b=Cano8FO5c1It7r+3p/TjLbxY1EvsmZJeEikmOUa+QqnbpwyI2+yodoz2IdTUZwl27gWEfpyBYSE9Emzzw/JsBlpoNWEY9xQ5l+xGRiJHZtmfVAVdmeVyS7JvWhHINmobBOh2F0e3qNwP1rA+KKoP6K9s81RaxODNxgBKE4H7hc81+zV+vTo3B7v93QloqK4UZ5r0bi3GFJtijIIgQcQJaWhxI/PMJ4iLIROh6Q6/JQegWoTt8ndYhtB8I0twQiU4ZACawk3BaEGDX+WEHbLbAUauAkRRTGaOuJC7fK7mDTIhJuBON3mLV4yVt1wR50nm7bRQgAJgbyymx2yevIadJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0Yf4cEvEvG5QyfNsLEMKtAoDXTiRoQ8aktCx81Ivjw=;
 b=OhdaZVGfnvBZik7FJ/DZ/3cAOsksA/ZnS3iAta+TFKgrCxh14ma9WBzPNMj8q5KrOBIoIYgNBL/RWu+6KTm45hz87WsrjHxsYsGgO7LemeHS3x5frqz0rS9dshDTMrHwNyPtTtCEABQUQhhx7XRZpGUSDheu5rk1E+iwSMA/x2Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8732.namprd10.prod.outlook.com (2603:10b6:208:565::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sun, 3 Aug
 2025 11:15:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 11:15:18 +0000
Date: Sun, 3 Aug 2025 12:15:15 +0100
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
Subject: Re: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <0e3d0dd8-994f-4665-969c-6daf332c5b94@lucifer.local>
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
 <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
 <ngytuoex4uvu5epsdqhvhypnhqidkr7cpwmmcxrml6kpftgusb@jo5ql6eko2ir>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ngytuoex4uvu5epsdqhvhypnhqidkr7cpwmmcxrml6kpftgusb@jo5ql6eko2ir>
X-ClientProxiedBy: FR4P281CA0402.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: c9398485-4a2a-4350-f2fd-08ddd27f0724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5BmjsQLX3G6SNNseuAEBfQFY7ocOzhldacVct9Fs+g+1TW7+T5viOPqy74pk?=
 =?us-ascii?Q?HHq8WtMwSudxxoM8ZGB5+66JBrXCkMzfkccKF6bUJfFI19p7y4y/4XLszKEo?=
 =?us-ascii?Q?NWhYyEhuDER6j1yR89dq00AzIo2wbQo6LnjUW0lQaTa0kCaRPgo4xuTu0tBw?=
 =?us-ascii?Q?vupGndctwxglZTu18rWrWz8valocwtpxS4eRAP8MnOQOkJ0XS4Zl6R7+TsyG?=
 =?us-ascii?Q?Dtu3SAbbR3ojZjIfC9OXXiLNFPUWxCyciaoHYU6u90SQtftGDR9sek9J7rcB?=
 =?us-ascii?Q?Azh2lQDdLte9DQvy+HrMKwcRfdwyEM+U0zMMKYVa0FMVEo24vYAZa0NsLKZt?=
 =?us-ascii?Q?/zcg7qC/7ifC3KAvs3+weCVzdFQ3sYZ05IoLDHbd1IlxEwYm0cg6/m37E0aW?=
 =?us-ascii?Q?WP6VkrVUYd2/TC2CshTC09u2AQZVFfBaRnJHyTLDNGc5VQMtRs0z2IDf40p+?=
 =?us-ascii?Q?DbXwKjueNi5qWDJFmm9fJ5E1Nk/YqFgYFppKkwhw642JRM+606QvM3+jvNnb?=
 =?us-ascii?Q?rG/24Z5zOYwZXBqm7EVjUMiR6ORxC0YWLqa3vB4dbv9d2rUEmfMKca8l9mzg?=
 =?us-ascii?Q?lOOSJmAt5yrc5DflL9bARuTj202hFHVR3HOFxJCsFOiE1mEbn5vFiWoQzvs6?=
 =?us-ascii?Q?1GwwQCcBlGSBrfNDIZR8e2kd/0IR0Cq+STHjoAvBCFVoERoaAt4haJ7TOUWh?=
 =?us-ascii?Q?V4eF69l0oqv7sUM3gaBeUz3m48oGF24Y/z2SQ7B0p6rONO0ZS/AX3LOximkf?=
 =?us-ascii?Q?Flzu+2xMs8lAW8r+fHY3pOfgsjyULA5Bn77+iNBEreUWv4HS/l8E7ImEB91X?=
 =?us-ascii?Q?CohcSdYXzmJEzSvVrX2ap7zi38GbOg4wYFOnNCgO3cSsjahqnMfPjZxqNBSd?=
 =?us-ascii?Q?Kuen0+2FhEGapLd2RSFebSpp8w+uDR0SbUTuF/cPXUGzpkQdSPwJFBkKeZ3d?=
 =?us-ascii?Q?sLhLrtX++1JgKSbNN5syX4l39H2c8a3279Hz8cDCndJqF+D6YVcJGixiY9Tu?=
 =?us-ascii?Q?ZmoMg2w+fX3MyWzDRdBB7/dvIFzfD2gqH+cHaA+h63KDEj2iD+w5hHCafIju?=
 =?us-ascii?Q?ZSMyGjp450NU2s/atFLm34fyYQd2Y4bjbB76l7kJJglZWjzkvI8enErFvOXO?=
 =?us-ascii?Q?oEn3Tt3W0uuSqr7W0LmAQpToNPfkZU2/R7cylmOjfVfqw7S141AZmspT13hz?=
 =?us-ascii?Q?Ktj3tElfnxJVdt5AKtIHPwBvYxZSJWF1iKN/it23MC9nYsK999FvUNG0df8k?=
 =?us-ascii?Q?XG0ZV+twggBhuKJYG/Aqm9+TIMDLgSYAYyzL3D1U/b9WfTaKO3YyhQdcuK5M?=
 =?us-ascii?Q?5843BbkMA/i1m6WM0zSj86DOrS3/GZCCnqy4nhBmsV6hP2jw5RSFRcr7p7Dk?=
 =?us-ascii?Q?+87ZamRPhiaCbhyIx7O0a89aLmXqSfxL5G7HZJJB2Woy89f5LmO6zhOWLiuM?=
 =?us-ascii?Q?LjN+7zt7XnY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8f7jF1A6hW5xV/Vax4dOfQ/JgtzaWvbauTdEYiwf9KS7y6BAs3E43e64xv5B?=
 =?us-ascii?Q?xVBvwbt3WG9/dUa/pKWbcfhwpseARiZc0cLcjMlzea9c/M8j+V16rPn0HBVM?=
 =?us-ascii?Q?ENmHRmnIT7XHotFHefTrxOjK74PLy87VwN45QtRls3jRHAhqFPVxI2U3P+/4?=
 =?us-ascii?Q?/r9KkIi7N1Vu6VleOo6b7JL5ZxkoUvkqcVTHUPjcw/LwholgpN35k/DFW6Gy?=
 =?us-ascii?Q?r/8/WFHvX5wpznkTTAw0md99RWe2XWl71LTEyaRlevIWACnGuqz4TxFw+IYf?=
 =?us-ascii?Q?4hU1U4lCedJ3TiLihGx9tMOfdmWhIHqeP7R8VY5mzoz6VRTTK71APawxGWNC?=
 =?us-ascii?Q?8LsUq/3YA0kQynLI7EZFv+vo+KCg02T4VPSSjaURRsmtDU7Hjd0qTWN8IfG4?=
 =?us-ascii?Q?JJCTzBaPH7lMCtaxHtwelsqLeGtXcwlrRtZuhO2O/L/S50+UAzT/6gEXdhqO?=
 =?us-ascii?Q?qIA8cB9IU5/ktlJ+QMRrkIIV/87s2aUwX4UJg/CAENI+P/JMPlBSK8r5jNJw?=
 =?us-ascii?Q?HElkciKyUDguObFGpll9EidisbBXJGQlZFmRxuGcPyX/CP0/vkRqXJTpcwzi?=
 =?us-ascii?Q?vPTgnigTPhhX760/SFSRRLKGRnbhM1Fhj6ivlvphpomScENGJ3jVF5aPg+4K?=
 =?us-ascii?Q?cDjbNOfJYq4fqc4rZvTd5SdhkQgjWv4zoiQhzJnHwLA/6OuIcFbeksNrJ5Pa?=
 =?us-ascii?Q?D2Kbk8MV4ripdbfcOZ3r6kh1pvHo3wYJoyVoFwtNx0x6+9yonkQGXFKcdqTq?=
 =?us-ascii?Q?dhsk12mp56YBnbLWJriFb1tzEfICtZXHicdotJpZS5p8Q+kx+Lp0cl+8fM8R?=
 =?us-ascii?Q?We8UtQquMlQzy+4QaDL5b027LXqETkBGT6OtsC+HKyBYFVLEenY3gfUPpSB7?=
 =?us-ascii?Q?DTenDUJ6cZc25cTE8oAmo90MpiuGI8VxLRpiFzHhMZI+JbE1cJGD/ufNRq7I?=
 =?us-ascii?Q?EgSESuLY2DD424hUziIKcnh32zQBF8VzP7LB3akiLGtxKydwy4GRGMdjKQW7?=
 =?us-ascii?Q?BA/vpY4VPNmc+TCS18O4qA/oHetw+6n1V9GpvGWQkONEStVAgnqEvNxDU8Bh?=
 =?us-ascii?Q?ZpEXJEhNfZJbRZI+r9KGUH8cGzmuziaP7jU2qvK0hpypV6p8bW5Y501zBHVq?=
 =?us-ascii?Q?wfmZVoVdv2l0QjKBCjKy+dhd75tUFCVFDVVFP8/rZm2ZwAh1gTy+BBQG5Tg9?=
 =?us-ascii?Q?Hsm209yIICULq1PjSfK0XGK41VGB660W0IlnhUGM6ddGpK4gQqffGeInRFy1?=
 =?us-ascii?Q?uqNDbWbJZhNpPaYOxd+GZDJIrkNG6GRCu+2tLdzQEwrewn3bECnvi6UoVY6d?=
 =?us-ascii?Q?dlpsV4A1XkjLBVmIZ5k3VG/fJdxosSlhFWyvUWOJTkNdyzpqp0AhmeTbtc48?=
 =?us-ascii?Q?n7+H2Q3Bf5s8UW9i9fzhht8RhoiiF3BiU5QHj4igq88YRVvEtNzS+bmXdIpn?=
 =?us-ascii?Q?LaV03rkKcoZ7JRcsY6/B+kYVIjo8c1c6ixji+3yJ0XRuLXe/35GbBfe4EU5D?=
 =?us-ascii?Q?dluI2hwOaR3Wz4fyAGRxXWZGjrUxdvjPnWlWYnfZKeYMvJZITJCNgyLa1AIl?=
 =?us-ascii?Q?B/fTZNpTsPL1aJJSR/F3q34xRRm2qzL7ilfQ1kZe9uNnXMDj2frIWYuhMnnP?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LuYVsRxF2q1SRDcmPJJuDqRDh2MOueUVNAz9Ir28A+31dujU2NqOdJR6hmv4313miyYAj3VKuuvxWFTCBGljiJ6aN70SomWyj8rPLOs4yVAnbY+YST5TVkdVCjw0oyHrUin3mR2FC02mT/E/VA6Y2cNNUv7AvPx2tdJsbr3LGwP6GCHiHqVC9SzK/0mbjW+kKnOBj7sjFIQHM6QM6gL65i57kb7pYdUiRsQ8hQXjMWzj6EqMRdZbf33mtKQtGAWSN60MeehdZOZm4Z0lBbfzC3MiJKQhljW5yd+lkUDsurTFiNR2daGmNmXjubcnAskjk6YgtqKB69a9QZfLitj+y0npid/C9sAQFsiu3GgmNZMPkka7MOUPXjt1x6Gpsl2ic3kebkE8wP3YvwuID1wkDANMeAeXPfJtF+FLsHB58afK4UIk6LytKzAnnnMaM576g2Wsiw2R0E+E2eLNBGkseoeXCEYmO4II7hTx3isc8C9U2mwXth2HrSMTQdVYI0U5zcWXdZg2X4KsVYj6+0hpYRqoL1DRzVOZZ1axJeXHqNkfw7CJenzLh+KhsX1fdGF9qp95yjN0FLxjOmq4MgjZSp79/I0X0UsZIFmVXZvIMkI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9398485-4a2a-4350-f2fd-08ddd27f0724
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 11:15:17.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ecmPEUbSWZ/iR+WvJW/opVOEUh3HcrSmEHYW8rOtk8PqhZDqxsDPm4tdDIVWPeCmEP9z90uXAM0Q9SWTcvm8HbNceI+r+HW8pvgVeqQMGfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_03,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=986 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2508030077
X-Authority-Analysis: v=2.4 cv=TrvmhCXh c=1 sm=1 tr=0 ts=688f44c9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=D5O8X1eFEiANbPiiLowA:9
 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12065
X-Proofpoint-GUID: Nkrv4m8dbTawlYFA5F86zvpzeEZA-W-W
X-Proofpoint-ORIG-GUID: Nkrv4m8dbTawlYFA5F86zvpzeEZA-W-W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDA3NiBTYWx0ZWRfX90imCXJZs2gd
 d/9fX1ijSOmZycbqqsx8t7ctOyA1+bega4hEgXEs4qUNLr8rwnhILC29woQXtYIkIkhZZLWh7sS
 lukbdLhIZAbpTMiCF2iZL+qO9Zz24fLeBWR4fh5hlSdR31ion8t3DwEwiidJeDMLNyuP3IeNEDw
 stMKSPfMwZllz5829E6vbmHJQfHoOW1w7sGcvDrbRc66cAbTOfJnsXwzSsrP/59AJwASCoD1Sn3
 aLOPLmWs0+0CP/vgBsm1UiFXAPnt4rzWtD5M0SPXRv9aTvXXgJd8/Hm3ph2HGj1UFDy58ToHPFd
 9m1zPw3gEGkViud075MFACr5uwcStS+oeRprZ8KsonYsPqeEgCvHHWKHW8KVR+wh/zOFRB/Ypcz
 /JYlcC25fEe8BCRGvx1OezTn3LvjoS40zuz3kX0y1uDY/Zab0BhlDA72rwnoZefmu7z2w0hr

On Sun, Aug 03, 2025 at 08:47:28AM +0200, Alejandro Colomar wrote:
> Would it be possible to write a small C program that uses this new
> feature?

I could do, but it's an unusual use of mremap() and we don't currently have
example C code for the _general_ usage so I wonder if it might be somewhat
misleading to have example code only for this?

Cheers, Lorenzo

