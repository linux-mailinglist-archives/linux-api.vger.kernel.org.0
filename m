Return-Path: <linux-api+bounces-4259-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491B7B14D72
	for <lists+linux-api@lfdr.de>; Tue, 29 Jul 2025 14:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6210F3ABF7D
	for <lists+linux-api@lfdr.de>; Tue, 29 Jul 2025 12:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB25328CF61;
	Tue, 29 Jul 2025 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dn4C65nB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aThpdfRo"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A381E3DF2;
	Tue, 29 Jul 2025 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753791038; cv=fail; b=MKJUepJlw6+vqTKuleM5B2hnoI0s08Di+RQhHIj/OnNEEf0vmD+e1tFwrLcGawmHiQt5GoRr63B6wsm4kDyssO9bDU/eS3T4S+E79W6GkoZBmOKxL54l6+BIiMOOSqWji/Ntj4i/y39J+crSiKnQSQ83c/sQcY7bN5wGBf+JGPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753791038; c=relaxed/simple;
	bh=PNsWxEszfPyGQB7Hy0/FWxkOefjGuVY51JXyyrCOBxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u2od01Y1NVTNgkkFNPLLyt/Rbrf0S6ZQnPNjm8QD3u5JNA29C1AFRxy965EmcDBz4SgjgTXqw82ZVsJLZcjTmuRS27FdYjaRSvd5rQn2WuRHEHZc0lwsY5G2VJMcBtrh5gON4pH5bxycGzDP3JFnF6k5mohAHHMnuCbY0KNcAeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dn4C65nB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aThpdfRo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7gABb021255;
	Tue, 29 Jul 2025 12:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+eTq+ndsoTBeVdV67GVsdho8dyfsVzjN9aReF6TTnR4=; b=
	dn4C65nBGnQzMcGDNvKxtFQX9yTL5pT9xtZpeHvEjzxGc9FKk11LyH4HQV2EKu8V
	sH1SPNtyE5c4WkbC9rPla1XUl2sPqD6EhcdjFpl4kB709hvY3YsKxGP1jGGYktKF
	nKZLIHN30JIRbA6izkZmd3bHuMPjy0d5ewC5u8BS0/AU1DtM8+X9RsDzcxRtHxlH
	/o2ktTUyyCIODrLH31AC/E6t+z/rPhUNOZxbJlAOFqIPS0qekjzqEsVErNbijGbY
	yC1Ui9juF9eDepZSxNIBv+YM6Sj3BW8BAY2bn1ZvDE1gQLNJCEA3aiKi/ossy+Mo
	+JXiyuLFsRANFCVV9Z9OiQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4e7ku1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:10:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TBgP1q035110;
	Tue, 29 Jul 2025 12:09:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfa2d0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 12:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1RU86Xy5aD3RCl7znlrmHimkfgC+fa0yxhQW/dhz/+0QPbtQwLoT6l48ah9viyKwaHMx30U7Q5LMey3hirfV1wr7lCy4l7y3WA4ZntyGKpOc0xGXuTxP211Hyro6M9wV/VUe+tUvhd8HSsPY0VOhc6pLrMm2JlNKhraP7wj0OHqWy9eGkWbd3hCc4QMuRRm3L5stWC0ROkDcjP/oKYX9QpyXJXnK+Td4fkCgQLEYg0vv8DE4ehNpEYA7f+pPt1tlvHQ0rrQiDPJqmGGtPf9z++6GIpdlKPCkIZAyIWgxvfvOn+N2s+oz1PNYc9J9AdcdUUs5gOwPB0BSaDNyRnJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eTq+ndsoTBeVdV67GVsdho8dyfsVzjN9aReF6TTnR4=;
 b=OPfp0wtw2Yek72dkKtxEJu1+zxXwwsGAKtkB3v5Eieel20V2YdtSXJVIM/VppMm7M9yGuWTBWyYgYBeuMJ81yoMQrfwWKBUbAAEP3vndqytY60+oquMkSuCFO7F/r26CCcBRjsMy1hDbOJSLdy4B+sSPKJNAMTeXqYzLPmXhcGt9hJGTnZ6RdZa0bgtkcz5lrnjQUJTZ4WH0tTyEvPTYcKdtim0oSsENQ+xMmi+1G3YH9bpYGD+N5XkFZms6be/H0TNCgmMpwosIeNEnJN1bJy50y4PtXw3/fpsY/XnDxnq+5E+h4VCYQZyRtsMHYS7mAl2SG+ROTIp3emG+CiiEbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eTq+ndsoTBeVdV67GVsdho8dyfsVzjN9aReF6TTnR4=;
 b=aThpdfRoQBBfeWUkyLGU4foQCzJOxeB+EAJJUXNJtU/l5WPPCmwoefzX03i0m+iCDuZlele5PWirfGJi6VmcItVgjcABOw2A4n5hL1lO/4cj6cCksKuAdNp6INwPImbjF15qlxK81/Vxfum++v+FjkILBALdB+qKq+Qro/L/fg0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4590.namprd10.prod.outlook.com (2603:10b6:a03:2d1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 12:09:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 12:09:56 +0000
Date: Tue, 29 Jul 2025 13:09:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Pedro Falcato <pfalcato@suse.de>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <5cd4928c-bd74-4917-862c-122c3dd17bd2@lucifer.local>
References: <cover.1753711160.git.lorenzo.stoakes@oracle.com>
 <386ba8fc99adb7c796d3fc5b867c581d0ad376c7.1753711160.git.lorenzo.stoakes@oracle.com>
 <CAG48ez2rQfWJwnpAspNr8OtLXgPadG55Re0KoK5ovBKqE3AcbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2rQfWJwnpAspNr8OtLXgPadG55Re0KoK5ovBKqE3AcbQ@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0114.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4590:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b4c3d5-2a0b-4f62-b8cc-08ddce98d52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGxiT2dKRHU2dFFCMEFOdVNweFVxZU9QSSthTjlmVWQyMlBYTE1TVzZIMjRB?=
 =?utf-8?B?bXBuZjJ2WGFmKzZTNEU3M2xPbjRpR2FERGdVNCtZeXFuQkhWMlNYNWdGdDh6?=
 =?utf-8?B?TmRwbUtpNk52V0piWU00KzJESGhNd3o3M0hQaUZEZXN4V0J2RWtTcm02eVdP?=
 =?utf-8?B?MDNmZVEzUkp0OWw5UlNOVldkMW1MaFhodHhneVlUUzdrWnppR0tRMzdCSm5w?=
 =?utf-8?B?U2dYZzltRUF6UGYwVktjcGxKdnMwYjFyenlrRXBTRXVjNk9XUjFxZlhXYVZj?=
 =?utf-8?B?cVExb0ZEdTZadUZXcTVydTllc1Z2L3l1MW1ua2gvR0UyOGR4YUQxdTkwRWl4?=
 =?utf-8?B?UWU5YlMrSm1LMzlVenFERUlxK0gxcEgwYzM1NWN3OWVKcDVKM0FxMksvZW1Y?=
 =?utf-8?B?MmdBWFVld0VxTVl5K0ZyVUFSeWhQU2pNRVltczFUL0pIcnNicVBQSGVUNHJU?=
 =?utf-8?B?L2RSalJJQU80S2s0SHM1eTZvZ1duM2MzdzM2aG8vSEtoMm1pWW9hK0xpNCtC?=
 =?utf-8?B?cU5CVmk4ZG1kZ0lxaDgvNkI5TnlDS3ZNTG8rNGFRUEpybG1acGpLaFQ2d1BH?=
 =?utf-8?B?S0RYd1ppNDE3KzliSTJqWEdMSnY5SlJIb3dUUHNjZ0R5TjJVRWF4S05rVVgy?=
 =?utf-8?B?SlMrVFoyTkxCUjRIckpEdFVsSHlMZmZnbzJ6WXdOZWZlWHBLL2RNck82cjV5?=
 =?utf-8?B?Yk5pODd3bkY1MlZVbnVVa3R4TmEwc0NGQ2wzUTB1azVJUmNqTTM4SUpkZjZC?=
 =?utf-8?B?Rks0L29QNTNzUE53RmVkNnZsdWdDcUdDek4rYnptZ2xMUUlMWEkyak5sYVBF?=
 =?utf-8?B?d2krVUZBZzJPdkxWVWdDT05ZVWZ4SDJaWlp2Q1dNQ05sc3BsbkkwMWdPWGFE?=
 =?utf-8?B?d3MxNmE3ZldpaWFWbzZib2Y3TThTdzFJdytMZFdOQzVpNkxqTFFGVDJFMW5z?=
 =?utf-8?B?NFpuNFBqRmlBOHJCcUdBN3Y2RUJQaU9mNVhGM3REZ3QrYitVNXBDcEo4NFZQ?=
 =?utf-8?B?eGNUUFF3S2UrV0hIL0FUSE51WE0yaVZSQ2lhZUExRTlHMlh5NVNQekQ1by9o?=
 =?utf-8?B?UFhTbHlQcFpPdHp4T2RMb2pnUDY0akZXYzhOamppdlAweFNtZHQ4VlEvMExI?=
 =?utf-8?B?ckFBeWtWOVcrMWpPaTNiZzEwWDY4T25uOFNReHRadmlxaStOOFIrc0M2Y0to?=
 =?utf-8?B?dlkvQUF4SkFtem1tMkR1MW5jbzhPeTBNN1lkWlhsRktmWnRxVHF0d21zb1hk?=
 =?utf-8?B?Vy9OZnVjWFdEai9LK2xFcjA2TVRwa0dhbmVJcmlncjJlK2Nja0wyQTdhVDhM?=
 =?utf-8?B?RTdSWkR5bDZHZWRzZHhYWE5xZUF4Q0hITWUvVE9vdllxVjMzS0JTY3ZmeCtu?=
 =?utf-8?B?ZkdWc0NCL001MFRLSjZnMU9qUU8rTGNpWG5oUmhja0MxK0JtMHJTTC9qSGEw?=
 =?utf-8?B?dFd6cFJ1VTM4Q1JoVWpCTjdqWXB2eTB2bFVrUVZHRkdBekxQK2lmdU1RYWZi?=
 =?utf-8?B?dXV5UU9nVXNwbkdSNnIyTmhhd1A5TFJDOHZENkNNbVJWNlFhcUpHQjhKZWQ3?=
 =?utf-8?B?UW5IY1VoUTRKQkVPNmtKTG56NVdLbTVtREowdXNZaGhPUXFLZTZpbHhCNFN4?=
 =?utf-8?B?WTdEV1lXMUIwUTJyeCtJOUMwc2psUVI0dmhsaWlDK0tkRHF2Tm85T1U4ZFNq?=
 =?utf-8?B?WnB2eGZnRk8rcVhaWWp3enFnbVJNczdOdmEwYW9PS2dENkZtMnhCVklwTmNG?=
 =?utf-8?B?RWdUQ0dEU2RCTmg2RU02QURSdWRMRG1uay8ybng5NlR5ZGcvcktaR3JLUjRt?=
 =?utf-8?B?L1JTU25WRTNmaTg0S2FMUEpJOFRYUktzckdsYUlKR1ZQWk55YS9jUlpJRjZX?=
 =?utf-8?B?MGN0WHpFYUJwM0RjYk16OUFmUWFOVmJ4bnZyRlNjRUtIcTNDcXloOUhBcGRC?=
 =?utf-8?Q?UEWPgCgVyqw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnpacXpwTC9VbDVya3VQYTUxdngyZ2Z5cy8xUmc0a0JsUmhqOG43bnVLZ2hI?=
 =?utf-8?B?WThMMUVPbTNrcFZ6WloxN1VPMEtUT0FqTUNzbFJGUVFMUUc1b1o2cURBajFZ?=
 =?utf-8?B?eFU5eHJYa2tyZ1A2cnJ5dW9MaU1DVUQ0NnAyWUxuU200bHNKMFBMZGJ0ZERS?=
 =?utf-8?B?YkZ4QjVzMVpkVVBTWWpNS0dIOWJDSk5iZmtza0NIdzBHTGVDc1gzYS8yZ1Yy?=
 =?utf-8?B?NFdaZnM5dExwZG50Y0JDVllhT2Iza2c4cE54RXA1a0loYWRpOFZlczJzeHJK?=
 =?utf-8?B?d2lyZmtkaWk2Wm1IbW91WFFRd0xFeWJkdTQzVlc4b1dIcmxNcTNlWWIyRHVt?=
 =?utf-8?B?QTFKdThuTTU4aHlENDRMU0t1M0tWdldQK3k2MTF1dk9RbkZIZUVmZDIwS0d3?=
 =?utf-8?B?TVIxbEUzZjB6dkxPWHBHdndxYUZKcktQTTV1NVNlVk5zU2l3bnREdmJFUWhi?=
 =?utf-8?B?YVBOWTloUlpNczc5amZTSXJETG1DNWZ4ZFkvM0s0anBZTjhjSW1RRDlwaE01?=
 =?utf-8?B?L0trN0dNMit5ekZLaExCNHFWWGpmZWNxbHUwOXBmTjBCL1RYb2tRd0l4RXpT?=
 =?utf-8?B?Z2JlV0lvUDluUk1TM3RvVWthWS91MVFBR1RqbkNvVmJoRDl6UmlVMlBGMWVQ?=
 =?utf-8?B?eVNIdklURFVRV3lKSU9WOXZob2tBVTk5QXFMSnFYUktPUWVZRmo1RUVmOTBY?=
 =?utf-8?B?bG8zRkpMWkloRkJrcys3VUgrWUNYU0RTL3NxVFJRK2RvR1N6VE03dWY0WU93?=
 =?utf-8?B?allDZVVaYzNHbHJ5clFoU3RJU3poYXZQSURiRDEwWGZla1F4UGtzWFRpU1dx?=
 =?utf-8?B?NUx3TEJBQVBpTmJsNFZSbzVjcWg2SFJkY1Q1ZEZ2WUJuY2VaSlZ0eEpNSDE3?=
 =?utf-8?B?dXRRU1N3L2daR0h2WlluMWM4S0pzMk9EdEI4MnNHWnlxdlNtNlRwLy9ybmRm?=
 =?utf-8?B?amJpay9tUFkxUEVSc3prbmpzRHRDYmNoOEp6L3pPdy8rQWx2bXZBOEVSWkJ3?=
 =?utf-8?B?SnB2YThJSkJUcVFZMGYxdmtsTnZ5Y3JnMy9SVkxTZFpCaVZBMFRMUW9BbDBG?=
 =?utf-8?B?N1FHaFhldzJoT0cwenQyMnc1NW0vNHdudGltL1YzYzEyRE1aZ1lqaThNMC9T?=
 =?utf-8?B?VW1WcU9KaDZPKzI5U1ZIMGlwSk5NdmVONlRkblF2S21CTVkvYThDdVQ0TE9E?=
 =?utf-8?B?c1ZZc0VCV1hkejBwQjljd1BVZC9DZGdUZ2FJeHQwR1ZEdnJOcnJHRnhzNVMx?=
 =?utf-8?B?ZU84UHdPdE9mdjJ0aXVhdU5MNkFUWkJwSTZhOUErYzd0TlJhenZoSVVIRnBy?=
 =?utf-8?B?YXIvUmVBMkZ3dHFVZVU3ckFwdGdGeXNQcHZ0dlZacnJNQXdaTlhLbDdEaE1r?=
 =?utf-8?B?TFdUNzNqdXU5UlNRb1lHZ3llRTRWNzNwNUpkQVNBWTJJOWx4emR3d212R0wx?=
 =?utf-8?B?ckx3UEhRVjhRQmJ0S3c0NGFFa2l2bitwNTFrZ1RVc1RXQi9LVjk3bWM3eStk?=
 =?utf-8?B?SE5sSlRrWllDbWhXTm9mU3FVQTBEckU5Nldpc0ZFUlBZbEdWeGd1S0lRWVlN?=
 =?utf-8?B?TllHSkNWSE9xRDFuNjVmZ1hCTTRPQzNka0JObTZVVG94L0lJYmZnTVhZRjRp?=
 =?utf-8?B?MTVaK1pubjZBKzVNcVh4eHp1cHZCZVNKQnYxaGcrUEFaTmNDRnZsZHJPRFNY?=
 =?utf-8?B?WmRsRXpXN2dhR2JCUlhBZklmN1JTbFltOHl3SUQvd0liLzI4T1BFR2FsWmpJ?=
 =?utf-8?B?ZDRXTEZJUThXSzg0QXBLWHNCNlVGZG1BSWFFdGdDdGlCMlhzZXVhR3l4Y3Y1?=
 =?utf-8?B?RENOdjZNc3RiTkJCTlVGTWpHVjVHS0VzNGg0N1dOb2F4TGUyUGRvK3A4dFpn?=
 =?utf-8?B?RkN3RFAxM3dpSHVrZWxVTysxNzVZbjgvNlQzaGplK0MrYndWM1NjclJvZGt3?=
 =?utf-8?B?WnlhV0R4VWVEYkRUVktXZ1dERnQ3eHNFdzJYSFA5U2xoeDdpL092WGdHSFJQ?=
 =?utf-8?B?L1JSWmN5VFhISGp5NmN2eWYzUlRqTU9aTGRydGRRVXdOTTdaZTJHLzlBd004?=
 =?utf-8?B?L2k1dmJFY3FLZnZkdUQrNVJCcG04RFRXZWRJRG5iSjRkMU5LYkRaVnJobGNN?=
 =?utf-8?B?SlhRSlBjcWIzc1VmZ05MQ1AwVkFIWUJmSVdBZGNlOWxPWE1TOG5HUTdubTFN?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4YWSaHhyYsCnEJQvDBZs0did//+wZlrFOaKWo2qc8qopivza4PDjc8Pd+SJGT2eVL9zhTj0UtgjM9+GHhxiAJxPSTVG1nSg9fiisd5+iDXrZr8BWsg2Rw9Z5a+uo5YyASQIfKJSbCVk4jSrfzqu6UOz+kLLQaZLidFjuukjaYnkkcy4VC7kbRusoH/E/3f/aJziON6JnMW/ifS5JMlc7adlwflgyjuVZcnyEd99m7khiQHJxEirzXbDFeBhdd1ZeUkEDhzNgSr8A3qauG/J5p1tN2xF899T6yRUtKxbPMGCbFQARf/GmAFWFslNGHPTwyfpLlumptH5LRO3Adertq4N4Zgp/rPUJIPRGNXP27mECG36HKGvDnaKIt773YmZeofnz3SBnumoxvkLpJV8+71bsesiOPlCLodJzQbP7Xm8HFkgRqhAoj3n10SMyXMljTk7qX5ROikMu1cnpvejEcqp3Xn0VExouV2LZMXA3iTdn2527WrKgSlCi2RyZY6dcIklx0xl1Ho8r5Owbr1nCyS0SCJx08AzTjnmeUjBaFW4IndsjuoeSlr/GQ6rwkS+/c3RNDMLdF8iEYNThI3Z81tgyzmM9BaMVhkYSkiZ11BA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b4c3d5-2a0b-4f62-b8cc-08ddce98d52c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 12:09:56.4394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JHAlOorNohAPKUy84RMKGdBcDEMAXqQFuteO6nglYIl7awpQYNWbdnIV5xxGdcS348GWGNrBi5LSlxmtF1uAWzAW98GxRHhnub+5PbUleE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4590
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507290094
X-Proofpoint-ORIG-GUID: aBvbNQ0gjjprbCaE5UmMoo1t4-iHMYbA
X-Proofpoint-GUID: aBvbNQ0gjjprbCaE5UmMoo1t4-iHMYbA
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=6888ba18 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=pp8Ss6zuh42qoB07TY8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA5NCBTYWx0ZWRfXzOB8tOtYQiBp
 Qx+H1Zi7CD3FfuxS4yMb7D862Vt0tDMNRNAA9W9NnY3NdoZHx7jy23Djyv8ctLdQe5fIJjxtt3d
 jYTCNVDB2ZwlfcciUyoDoBsRzRTFlAOSLRMi7rli74JbHVc9UYa7rHLjBUkQJ45a3PFPDCq35kY
 QJiQpoPfjINgEFJaHJpUL4iDbPmB3/Z8IZpo7B3ZRra6/lyV9myveg0S+CXOKPp//lp7WEpKIZH
 MjH9/ifiYDNLkwIkeZLg6cM9Y5LjV7CQ1qW1YgoVa2WOouYOHE/viZ8CEsRKRihPrAsZuA/gKdP
 bWziuEuQvcSLHpjmRa63UOAdFdtwMvQhuOEcd/H6So6drJXRYbf6IywM+qIRhmnU9jiMwwDDF2O
 WDjwpRo4IvpTe5fT85g63u9yoXKLeJVA1v41oZcoA6sfEGRfHgYC5WAH0e81J/4A5jgV+iVy

On Mon, Jul 28, 2025 at 10:34:07PM +0200, Jann Horn wrote:
> On Mon, Jul 28, 2025 at 4:05 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Document the new behaviour introduced in Linux 6.17 whereby it is now
> > possible to move multiple mappings in a single operation, as long as the
> > operation is purely a move, that is old_size is equal to new_size and
> > MREMAP_FIXED is specified.
> >
> > To make things clearer, also describe this 'pure move' operation, before
> > expanding upon it to describe the newly introduced behaviour.
> >
> > This change also explains the limitations of of this method and the
> > possibility of partial failure.
> >
> > Finally, we pluralise language where it makes sense to so the documentation
> > does not contradict either this new capability nor the pre-existing edge
> > case.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  man/man2/mremap.2 | 78 ++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 67 insertions(+), 11 deletions(-)
> >
> > diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> > index 2168ca728..cb3412591 100644
> > --- a/man/man2/mremap.2
> > +++ b/man/man2/mremap.2
> > @@ -25,18 +25,41 @@ moving it at the same time (controlled by the
> >  argument and
> >  the available virtual address space).
> >  .P
> > +Mappings can simply be moved by specifying equal
>
> (Bikeshedding: This "simply" sounds weird to me. If you're trying to
> define a "simple move" with this, the rest of this block is not very
> specific about what exactly that is supposed to be. In my opinion,
> "pure" would also be a nicer word than "simple" if you're looking for
> an expression that means "a move that doesn't do other things".)

Will rephrase, the intent is that I'm saying we can 'simply' perform the
'only move'.

>
> > +.I old_size
> > +and
> > +.I new_size
> > +and specifying
> > +.IR new_address ,
> > +see the description of
> > +.B MREMAP_FIXED
> > +below.
> > +Since Linux 6.17,
> > +while
> > +.I old_address
> > +must reside within a mapping,
> > +.I old_size
> > +may span multiple mappings
> > +which do not have to be
> > +adjacent to one another.
> > +.P
> > +If the operation is not a simple move
> > +then
> > +.I old_size
> > +must span only a single mapping.
>
> I'm reading between the lines that "simple move" is supposed to mean
> "the size is not changing and MREMAP_DONTUNMAP is not set", which then
> implies that in order to actually make anything happen, MREMAP_FIXED
> must be specified?

No, MREMAP_DONTUNMAP can be set, but MREMAP_FIXED must always be set for this to
happen.

Let me rephrase for clarity.

>
> > +.P
> >  .I old_address
> > -is the old address of the virtual memory block that you
> > -want to expand (or shrink).
> > +is the old address of the first virtual memory block that you
> > +want to expand, shrink, and/or move.
> >  Note that
> >  .I old_address
> >  has to be page aligned.
> >  .I old_size
> > -is the old size of the
> > -virtual memory block.
> > +is the size of the range containing
> > +virtual memory blocks to be manipulated.
> >  .I new_size
> >  is the requested size of the
> > -virtual memory block after the resize.
> > +virtual memory blocks after the resize.
> >  An optional fifth argument,
> >  .IR new_address ,
> >  may be provided; see the description of
> > @@ -105,13 +128,43 @@ If
> >  is specified, then
> >  .B MREMAP_MAYMOVE
> >  must also be specified.
> > +.IP
> > +Since Linux 6.17,
> > +if
> > +.I old_size
> > +is equal to
> > +.I new_size
> > +and
> > +.B MREMAP_FIXED
> > +is specified, then
> > +.I old_size
> > +may span beyond the mapping in which
> > +.I old_address
> > +resides.
> > +In this case,
> > +gaps between mappings in the original range
> > +are maintained in the new range.
> > +The whole operation is performed atomically
> > +unless an error arises,
> > +in which case the operation may be partially
> > +completed,
> > +that is,
> > +some mappings may be moved and others not.
>
> This is much clearer to me.

Thanks

