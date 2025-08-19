Return-Path: <linux-api+bounces-4520-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05073B2CE27
	for <lists+linux-api@lfdr.de>; Tue, 19 Aug 2025 22:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BB84E69A6
	for <lists+linux-api@lfdr.de>; Tue, 19 Aug 2025 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99721341ADD;
	Tue, 19 Aug 2025 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SCCzP1tC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="W/M05vGp"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F5B341ABD;
	Tue, 19 Aug 2025 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755635904; cv=fail; b=B11l9EvLWzcKdL5hWTZNzDfKy/c1XvSWKrvaC3mqo/rfwcOTdIYVsmeH1i2v2oHZritWBJn8iShv45b+2z0SpcbYSp50qFkvSyTB61AA4H9UESasbGnOOMITvK2RrWaDkeeQvns/geOSiJFJ/DZB500300hQ7Agiintuu8I3/8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755635904; c=relaxed/simple;
	bh=MofV2gILEmt6LqIh3TWLOyLOhiCN5u6VuPPlOM7zqDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eut24uQPmvVm7xQ4DIU0X2emTKclyM5A47D2iR8LEa+miw2B3BbeAxW6gBHWdmPRavarGB1/hap3v6eRfaIlna4MZGsG6txJUMQ756oO9ytjCeFhs2HAQDFf8nvMUX6sIVoQMtGBciCPEaLY6lkZ5oKHVgFqvrPDrTBwtzJBb4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SCCzP1tC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=W/M05vGp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JICfkv002662;
	Tue, 19 Aug 2025 20:37:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=v2F7MBSAqtVkM9B5Wr
	6dgi+u9XjY0+2NmGkA1Al9mLs=; b=SCCzP1tCVIBSQSVjbqTC8AWVmLBaXlfPh4
	KCdWN3a02yKNJPYCiRCBCcclinw3+AI8R9Ft4K5RUchRTVC6OJy0dMf6QB52owci
	U6WG6U1cs1J2ukezDZNINgMaa1Hc+xvmzMTDHqK9G7mTq2w0kKbJuDvNu5uFgAkA
	DUraTybclL61nXTTDFx1UOq+95LYodlU2RXb7JCedBKYNXnBfe2WDstnxsH8zSBX
	MlgmEOLJnhhVn5kPoR6LZCJLCXGlNIkfG4gRLTkvI3+kr9GYf4E+4lvJ/pzy2bz4
	yoxDjU8g/Ae5vZEmDamTGFdJMgD19qESnnL8S3QBtQBZhOXpcN5A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jhvde6dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 20:37:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57JJ44Sx007235;
	Tue, 19 Aug 2025 20:37:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3pu4pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 20:37:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtGrDjB5k8Hc25ntEsPIgui/73CV87UFsJXcadC4RrMAmEXWEl4pTQlYTzP07szWerHBjAsHoD2TpPUfcf1IOFi1Ig5m3487o+e3qqdGHFi7xPjYmengGfxn2wO3lMU8nEv+seX84QUwFKDBw/WDS+JA3Jhtse1nNmNMs+sg6USXsGe19WgKNkxUF7yvhzWL3e9K5+QlbkZaFy+/YaSXUPYRD4N1YUPbCfO++BxG9hXlT+9pCfnTJ7sr9tMuufOU+dtMEBFFu5moLF1pNI5MUCOXTRXqalx466dhiLpvKpWtWObQUCZwI/H/ACBprKw6htciZld+adhRzpaGqFSIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2F7MBSAqtVkM9B5Wr6dgi+u9XjY0+2NmGkA1Al9mLs=;
 b=my63V6lTrBaqr0YhiyzHY1ffFcPLR8VJrYjlctf7U/1y62M8JGMe86M2U3dsugFv5jhic5jLf6woNBFhA6MndVJED3i22rizk/ObjfgayXn4O139nmxy4/L0jz8RUSFdf3TQ1z/7qkJ5RrMX62qgcCNxwsy9Q2tpOzQ10QRROhf2t+EBG/10ThgdxBzmf/9Hj0yDRAxaN3d449QcMkicq1sEPpJIJQs7sTKPHzQJz1jPXn+B+EW3N26kPZhBY7Cu/w68KmasD5pUA3Whvd7SGmakCPkdSuVhOld+RM0wrp8O11vgMDQnDUL9ICUC6W5oA4/PmDzgyqucRb/o4u/TLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2F7MBSAqtVkM9B5Wr6dgi+u9XjY0+2NmGkA1Al9mLs=;
 b=W/M05vGp2mwFUgFpv7uLhNHS90owVyOeSETBGlL8iNnDhqEzE25GOxLknxMbQ7NCmGzSEm3eue3WtlhCz7VWrWzQT/3NLBGqXrHyCFyVSYIlzOmE6ZKHVjpRN8eX3Pp7wUVpQAKDJruJqV+vPGosIotFJ7Az6rj6bhYpjj4cPpo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8203.namprd10.prod.outlook.com (2603:10b6:408:284::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 20:37:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.024; Tue, 19 Aug 2025
 20:37:42 +0000
Date: Tue, 19 Aug 2025 21:37:39 +0100
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
Subject: Re: [PATCH v5 3/3] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
Message-ID: <fb880acd-25df-4386-a13c-9b68640477ef@lucifer.local>
References: <cover.1754924278.git.lorenzo.stoakes@oracle.com>
 <ab2264d8c29d103d400c028f0417cada002ffc11.1754924278.git.lorenzo.stoakes@oracle.com>
 <uvh2e2jjdk44tdwrhmnd46atwgdzwwmny4kczxqv2vm33gjqpp@63lsupn6y2u6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uvh2e2jjdk44tdwrhmnd46atwgdzwwmny4kczxqv2vm33gjqpp@63lsupn6y2u6>
X-ClientProxiedBy: GVZP280CA0057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 1162ffe2-c991-44d0-beee-08dddf603f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oKlwsQc+5MKU69HLaa1D/6SSoeuLzO5zjKkcp40Jr/CMX86nNDAKXbw8oJs/?=
 =?us-ascii?Q?utHc5MQ2HynDgjJ34VM2o62drpaXssY9DqIFqDbMbVdc97yOqtah7M4+1iro?=
 =?us-ascii?Q?YcwAT2GC5JVmvz5nTIzWK+j1s9f/RLdJPy4vXwUaVE3C9JOPTqP/m7G2AM+I?=
 =?us-ascii?Q?HH8KI0lFGap1LYQp6EVuGM9+ILl20c/QKruOeVc+rdRSREDKM0lSJQUYM4pj?=
 =?us-ascii?Q?/vswNq8zpXhXATs+iST7Cz7boSj6OjVTHMbt58mzAopiKk5q6O1txzBBmN4d?=
 =?us-ascii?Q?rvzC7GysL0iKkY8a0FftnukU7lpCrGIWxiK8fh+Qodrun9canrp18hYWxdm2?=
 =?us-ascii?Q?lAJzL7qcKoSOXwYMaKBlNxX8JWXJYMDM40kl5EAIs8y0H4aC7LCoa+TvbavB?=
 =?us-ascii?Q?0xY9npOL75mNbB4pYer3nIkO2j+oeJmZf9kqEhYV5lCKvKLZMIHFvGcs2QI3?=
 =?us-ascii?Q?t8UjIiLOVujEM7c53Cd/krDp7MHKw3/tz137OVtwVrsqMedCkH/TMT6do5Wz?=
 =?us-ascii?Q?cPkZU7huqYDbvrdWpRPx2tWFHmzQEQ71teSQvABU1Zj1AhYts9yaPy968+lN?=
 =?us-ascii?Q?y6Mei+0QNFLVcSk/z4RHg+85wr0eM5kRB1NsqDMuGYCmn3SostjKQxttg1Ci?=
 =?us-ascii?Q?+rEnQlOQw0PjfZ6lMWZj+7sUs9lZwi6RafKGc9aBUwcZCjxouwyR0SVIwnZH?=
 =?us-ascii?Q?MrxGm19Cu3ljIOpLwAQHPmFQXcVGuveWNdKJOu1Z9hlKQKldtTYekH/xoeLs?=
 =?us-ascii?Q?vZ1eaP7CO7YcDRkE7NHAsjRjMeVZxS5U0VLEweYGE590wtCcb8GNz3YLRW96?=
 =?us-ascii?Q?fvzzhe3FRyTJL6FVLF2CMElSg1VN8lrICG90g7l4CfBxmfnc/MV53qUciU6+?=
 =?us-ascii?Q?67gdBewaBgQD+/oODf4W54hWvoF3nWqaIYD828RqclDpnkCgk/RmAURY6TZo?=
 =?us-ascii?Q?mypakejlJWH6fStJDa1hMOMCavzAP39JPLC3b5Fc3K54DadZDFMpbItQvsiE?=
 =?us-ascii?Q?xSePZIjiwFXCUhpvSKBxJQrgpdwwH76M7F2DS6D0QRpv/qhlf61cKCvdI8Dt?=
 =?us-ascii?Q?Z5j6lL8qw85bQ/7SYP0Yzuc/srDEwVegzQQdjxaDp3odc1KrWYXjt1gwERX6?=
 =?us-ascii?Q?yOr2EdwM7ciE+pyIR9rRmqFZ9rBNastG+IXJTMr9xH1wxrMy+z7gi7SRaNd5?=
 =?us-ascii?Q?o/NDlsUWlnL3K0ffjCoTBRmGcrxPOu3FKkUEtiiK1NruoUCGrpP5zGtiTweH?=
 =?us-ascii?Q?mmjWp3+HUloGnFM5WhV2GTWV9C2qjIOdL05UCLZ5noiP6A00Oe7D/8t/f6S7?=
 =?us-ascii?Q?vFeLx/YGfmgEBYPPHqz+zyn0jqcZHatnhG4IJQDpp0YTlJ5hJNqAlGtU9mwD?=
 =?us-ascii?Q?fugTg8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gkfGDnhjSj/UoQsECqMCxAIS3GJcvfwD+k16tRr/dGhMBK/HeKNhCxjSYlJk?=
 =?us-ascii?Q?xsA7Z61CYbM7nxu4bNXtfJpAeFpelJQa7N1tp8dqk/zKY3WzM8K/2wccNTOI?=
 =?us-ascii?Q?l5txQojApfHzQg7AmN1FvRKTEFJbQJhncEkeES4AFRihGIHZIvB3Ila1TMY5?=
 =?us-ascii?Q?xNAwxVqpjjV1k3EbGRyIpDHoQmCsfElAHhAC/CUFSoViwz47ZHfuvWstuZ6P?=
 =?us-ascii?Q?RGZMzhBMf3Ivz5pFEP40TSlhikYlHXgoIetcwas7s3JdFqb8DKkOazT3PUCT?=
 =?us-ascii?Q?qo1gxvrX0A0cnnylKglpEOSk+pnpmey8B8HbfbGrm/XvIPOWhG7UFys2ABUP?=
 =?us-ascii?Q?kroLzyatXnB25hd66h1mkvfmss8dW1vLq2l1pocP6LT75UEq38zANkpf3d3x?=
 =?us-ascii?Q?/QFahmKyzJwHvpz8bB93fII3/hYo/QdoeT/nA+oFWaizXMXDf+F6JcpbRQLN?=
 =?us-ascii?Q?1SawpziRXM2eYsCtvTRdE7P8qba+3kDxje0hnt6is9ajVAkqSjVo7WGgty24?=
 =?us-ascii?Q?SxTltOmcxJApwyQ51FX/j3uVlSAcUOb7p7SFZCklYlwfVtK1MH6POgBClG++?=
 =?us-ascii?Q?ppYLNt14lKIZCCFFbm3AY+NGbYVJvfDlgdVVqiC9dlimRzodROyg13baMveO?=
 =?us-ascii?Q?U2CAUr8tCaAfRyZHYxbQRnzp7RfMbqMQkgvGUfm0uNh+hXOvAGUk2fob3bh/?=
 =?us-ascii?Q?/DMHqnk1JcMxmTZT+t80Kb8u/zYsnBTpudHBwlaf4I2m7GaquVbU5VBM2Y3e?=
 =?us-ascii?Q?hYZCUHHCUtu1GITrX5sWvNHzO/VwrqOlv096dCya2MmfuYnt3p+oIxQaySrM?=
 =?us-ascii?Q?fX1EdSVPF45tIPVxi7ckS477no57VeOP9XdFMg962O+rIbvxYiJ69NvUHj0w?=
 =?us-ascii?Q?JFnT1F6YWJhBDC6jlQVkCqghjKr4QoypfFk6PDx8nRFHhCQUgBA5Ya1Pp8za?=
 =?us-ascii?Q?5J8VH0oKjCQ6eXvYwhS0+FAoUs1oXDjW64RfvNI8PoLAQAnNolh64qpmTJVT?=
 =?us-ascii?Q?RvXc+fGt8TwOkwLU3YHEUcfBmTzgiY6852qjlBTbyhZh8KV9WyOhrIsVxpdO?=
 =?us-ascii?Q?z0iW5X+itMX4a2ESF2Wrs4Kq+uTZo3mJXzOQYsb+PsbZ06F2sXa1yfKGlN0Y?=
 =?us-ascii?Q?c+aC80LHDfzWXRFkrBqqGVoOpBoTNIeEFGMYwHhJgT6wWgd8AFoLsCQKxT7X?=
 =?us-ascii?Q?d7oaZ9bYOjPwpB/Q5GcP4+mSoanTtN4H9a9k9W+rGSXTv+QpQMYC8CjVBcDD?=
 =?us-ascii?Q?UYUa4RP/BMdszsVC0zEOzPYDqfiysB9tzBu75r4FNrl1aqXWt9EUbsWjUnoc?=
 =?us-ascii?Q?MKBTwLGpMS+MbnThazX1iutkGkoss6An0CZtP+wabLVjUB5kFS7LS0kY9ixE?=
 =?us-ascii?Q?I0pg1cyJkCckqT+wmHUyc2tUj79SrfB87pD/V+ANW0pbbnp+BgrHG32hHADM?=
 =?us-ascii?Q?JYp780fpWbAwzGD0J5ohLo3s3relWo6ZDgwPLVJnWO7jFEdstmBVgUKj4kf6?=
 =?us-ascii?Q?xK/zCB5s0mF6W3DJkzCpdlOMR5ReBFiCvnTgWRun054N2odsAjM3bPOO3cVg?=
 =?us-ascii?Q?g8WdPCHwC1llQUk44PQ1ZqijQpK1nR5Tvlgm4sZiOgKMumnkXlEf52/xnH2L?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lj/Nv6D4ldUoodWvLm9COY/WshUlo5DMgeBfEcnsYkdQGNMdGyK+L71VfRSk7uFYqc82wg+GOAnRR96UG0oTZNJBxqatBDfESLu2En3WKe6DSbxs/5JcY9Uis9YZrpI4DgDTVMWtMPHpPZjbJkF5r6HHmekAh67quImkXdLPV7n9t8Pt2pknQDr7dt9W/xFXo80dqGXlE36P6BT+NDo4knrTxt5oB4VVXKYB9UBvZcvEYVa79REIoElrltgJGMsf1Viyp2CHyaoZ4kiWfQIGcXNA67wiE2ZEIZIGPsBfRiOxZ7MBAenecpj1n/eC3CLT0uP5n5RovKCxJ+mVtFJNOghik2OwKH4QDdT5bFAQpIAbHEkVX2O8pyCbPzzNVU3yxAXL5XxEX9JIWr6bpjUeYZ7S1Xhi+XC9LfzAdxADcdW2Z6Ldtl/+4t3H5sptBJcnJKSv8k2b3JX35igb6/ZRNYjt9rji04Ddy9E89cDoAiyORCp76GJJZx6g7YPIWGWAO/2Fl4dfMn7o7rT1/M1STh6f52JqEwHvsu93vlSQ0+NNgPKhipsEhVuDgbPkz8HsSHfZW/n+kuzDCs+fkvM5u7SLp8XzwtV3Nffx5qGKRvk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1162ffe2-c991-44d0-beee-08dddf603f0e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:37:42.5546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trdeHhDwo0lXos2eEYhbAFu/JQYnqY2L2F0Xynb/LK/oDBv46e7dmQ+AAKMUrhIDXMipBL0LvnTylyL+h1E+/bRHt6lnjWnFxe92URxNzE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_03,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508190191
X-Authority-Analysis: v=2.4 cv=TNZFS0la c=1 sm=1 tr=0 ts=68a4e09a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=MEjK9-KKAAAA:8 a=yPCof4ZbAAAA:8
 a=B66SOjj7lkhIylS07wYA:9 a=CjuIK1q_8ugA:10 a=wDCLW6yMUrMVbYbmd6V3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5MSBTYWx0ZWRfX9Qq5jOH7rrP2
 sygdOWFSLPDrRzELlxAMpvxfc7pzkj4nh70xWyLoTLabhb3oeXOpTVc9h1TXFY6RJ+hnPVtJJzW
 TwY+VZroku8VY7jz0mmDkFH0t0rQrjHv+lnfH8Ki1ZRJLeyHrvQInsDUpvjAezkTXadGCd6Oqyg
 q/1mKxow/v0KKQZUsOZS7UcAy6xp2d0Ib7qRZtJQHLETj638MF3LKSx7KVmvS8268g7giUYVyl0
 Hu9x35S13iCRk3t+QWTzFu94yx17kBIzStxSbb7Y7f93kHIMoFitIMP1aKKMXJkk/GFrxUiuHWB
 4c6AWvQ0pgbraL5ko428F3CCPxUP+M0G+17fiO54dVKXvmfb9sJ6WFj1wyP1LkYMiAgpFHhrKlQ
 sZhuiolauwuU2fuF0EIB9wTsaoEUgIeZritcgc9zgMA1S38ipjbQYHsqNOXJ5MHMMUFho68f
X-Proofpoint-GUID: jCI8rVWt2bujWhFRDSbn8RLa45NwTtP2
X-Proofpoint-ORIG-GUID: jCI8rVWt2bujWhFRDSbn8RLa45NwTtP2

On Fri, Aug 15, 2025 at 11:36:26PM +0200, Alejandro Colomar wrote:
> Hi Lorenzo,
>
> On Mon, Aug 11, 2025 at 03:59:39PM +0100, Lorenzo Stoakes wrote:
> > There is pre-existing logic that appears to be undocumented for an mremap()
> > shrink operation, where it turns out that the usual 'input range must span
> > a single mapping' requirement no longer applies.
> >
> > In fact, it turns out that the input range specified by [old_address,
> > old_address + old_size) may span any number of mappings.
> >
> > If shrinking in-place (that is, neither the MREMAP_FIXED nor
> > MREMAP_DONTUNMAP flags are specified), then the new span may also span any
> > number of VMAs - [old_address, old_address + new_size).
> >
> > If shrinking and moving, the range specified by [old_address, old_address +
> > new_size) must span a single VMA.
> >
> > There must be at least one VMA contained within the [old_address,
> > old_address + old_size) range, and old_address must be within the range of
> > a VMA.
> >
> > Explicitly document this.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  man/man2/mremap.2 | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> > index 6d14bf627..53d4eda29 100644
> > --- a/man/man2/mremap.2
> > +++ b/man/man2/mremap.2
> > @@ -47,8 +47,35 @@ The
> >  .B MREMAP_DONTUNMAP
> >  flag may also be specified.
> >  .P
> > -If the operation is not
> > -simply moving mappings,
> > +Equally, if the operation performs a shrink,
> > +that is if
>
> Missing comma.

Could you fix that up? Thnks!

>
> > +.I old_size
> > +is greater than
> > +.IR new_size ,
> > +then
> > +.I old_size
> > +may also span multiple mappings
> > +which do not have to be
> > +adjacent to one another.
>
> I'm wondering if there's a missing comma or not before 'which'.
> The meaning of the sentence would be different.
>
> So, I should ask:
>
> Does old_size > new_size mean that old_size may span multiple mappings
> and you're commenting that multiple mappings need not be adjacent?

Yes.

>
> Or are multiple mappings always allowed and old_size > new_size allows
> non-adjacent ones?

No.

>
> I suspect it's the former, right?  Then, it's missing a comma, right?

Yes could you fix that up?

>
>
> Other than this, the patch looks good.

Thanks!

>
>
> Have a lovely night!
> Alex
>
> > +If this shrink is performed
> > +in-place,
> > +that is,
> > +neither
> > +.BR MREMAP_FIXED ,
> > +nor
> > +.B MREMAP_DONTUNMAP
> > +are specified,
> > +.I new_size
> > +may also span multiple VMAs.
> > +However, if the range is moved,
> > +then
> > +.I new_size
> > +must span only a single mapping.
> > +.P
> > +If the operation is neither a
> > +.B MREMAP_FIXED
> > +move
> > +nor a shrink,
> >  then
> >  .I old_size
> >  must span only a single mapping.
> > --
> > 2.50.1
> >
>
> --
> <https://www.alejandro-colomar.es/>

