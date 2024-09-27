Return-Path: <linux-api+bounces-2348-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D97998802E
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 10:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8321C21946
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 08:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB3F17B515;
	Fri, 27 Sep 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e13v6PkV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0OFcNSA8"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2618C1F;
	Fri, 27 Sep 2024 08:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425296; cv=fail; b=PJl7M52cdwwZZ10bAzRq7cBGcliAj2aVbCL91vIMW/fga1fboCybxFvwPxWD0E2XJ3o6/SgQY/AV7zgkeP06BFqqOUEZcOK42xEz/70epwL0yVQHEVulymw5SxbnyBHAf51F8wbrgB82n+BNOilN2z+1YUaU+7l5b7mU1IfdIZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425296; c=relaxed/simple;
	bh=SaXcMCYbGZa0MKR+pQUAczwsXR1Rwx2t7rSbxlP5dSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yb4NwUrgHiTUCIjRvMOP0LDoBFYmIpN4pVpgmZTI7jNRs+pMpLq4BdWAFglXbAWK8kN4Z7GZ048uRmfweZjkzH8na4ZA1/y9a88fo4TkCN7cz96fo0EjvPJzrSYqeQfZzGaYAFRpzKa+xwpPZdcXjTMqmqSfx+IKHelevAhxZ1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e13v6PkV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0OFcNSA8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5gdxU011480;
	Fri, 27 Sep 2024 08:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=SaXcMCYbGZa0MKR
	+pQUAczwsXR1Rwx2t7rSbxlP5dSM=; b=e13v6PkVnbAhMy412K+rUU9HfWtJrrN
	EikQYnPDvTUpAN5Okrx/a/vSlYUsV/xnOa/+OGYLzse+O1MMwH7M6ndbkP/ZJfNZ
	IuOf/FmnHu7Za7xgxO3aGHBzEcxFMrtqoYCgioDPfhLyS1K6/NdIrmPehYYWcMD2
	tEBhE7EXqFXmGoYOXrjW0QCn3IxSWPJCuuUaEJMI559IxVEMcEyn2LM6w6xFyLVC
	ZlJIf7o6Qm9kDbMcIPk5bdbkGnwM5SfepSf+VZxiXHa+rwus0gIZGLNhawtQTg2m
	OWUM6nKSTDjVtLEXgU0vXBsgQDvKDBrIFcM4U+EJoKHUSlMw7zK+yZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cy7ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 08:21:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48R7eE2T033123;
	Fri, 27 Sep 2024 08:21:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkkj392-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 08:21:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EW5oF+cV3d3677XJgNlmuZspWweJOhJ5R6gqxLBogMVW6fBxam5aRTPHv+/VIauyqzYVLitzolK4bQp5WRTnidSxcScQW0vo42KTdSwiWSpctcPIJygTpqpl7NuxqyaI0FNfyBzdJWoRopUVTgQGukbVs2B8b38OaD4uD5s+Ugk6YzHhZ5eJLOjqkIPA0VXsP56JYUB0nQgpRYt8WkAIgth9K58WucskHUthREaCCeUocb++e1Eq7MZc2lHvremOQNj1S46FzWSCZXf8sYtpjv2jQf0WT5sMZrf1gESvMLZawCVKGzcWr5iv9J1mOdVbcLpkJb9uvfwfYF2zRvbRcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SaXcMCYbGZa0MKR+pQUAczwsXR1Rwx2t7rSbxlP5dSM=;
 b=tdrZu82dQ/N49nvvQEfiQ593E7QsJzdg5WU6avKnXp7j/DVIMV+d9Y4PJXVS9G2pMSg9xzDB3t/BpimU100Ug/dwEpd90/umZy+Gg/7IyUPRhvrRa7evI5bMUe2hTQ2Ji/HH5DLwrjvJMlgRaH9ASBffsH3B9Yyusvmo8XLr8L/GRiW0WqkB9EvMQCpx9cbfJFKcL1yKD+drgQJiacpt4WeMQ/Rf/SpbeNdzcoYK1cnTAkeBUIHdLMCxYTUw0JsPhcG7jOo4nhsFuUgnD5FUKPo0dcGAhCd4Wcc7z3SfzxmBaUAT7OsOWgT0bwfC4kKcvCHHYv4S13xcgppTXzS54Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaXcMCYbGZa0MKR+pQUAczwsXR1Rwx2t7rSbxlP5dSM=;
 b=0OFcNSA85qsvKTxBAx1cGGxj5v0ngYWZANA2hXJbGRWd0csp8ssu0UVDGIAa/73GRRrs9vb9dMAIwXl+b+mTJQwdX9fGymxRXLF3V2PW93+B+FXdcJm5KcIZrSUT5abwWcyQkE2Rns23ABuGAQBavQ1WjcGBChEbzZhmNO977/4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6236.namprd10.prod.outlook.com (2603:10b6:208:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 08:21:07 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 08:21:07 +0000
Date: Fri, 27 Sep 2024 09:21:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        pedro.falcato@gmail.com
Subject: Re: [PATCH v3] mm/madvise: unrestrict process_madvise() for current
 process
Message-ID: <245f73e4-8076-4cdc-a3da-6c90d048dfc9@lucifer.local>
References: <20240926151019.82902-1-lorenzo.stoakes@oracle.com>
 <xv5qg4hfqvqzooounx57hzl4jzmfefitf3qklcdqzz7a4dufxn@v3r47r7p6ono>
 <20240927-holzlatten-karierte-2f1e5c0af19d@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927-holzlatten-karierte-2f1e5c0af19d@brauner>
X-ClientProxiedBy: LO4P265CA0252.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 6650df1f-6136-4cc4-aeff-08dcdecd55f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P0kq8XXy2S3H/tpijgtj0+1fNPvLFGpctha4WVi2M+5zPoO13ksSMhOHZtnH?=
 =?us-ascii?Q?8/pNvgv29A5RMPUZWyOpKUoSvwlSiosbsE2XM6aeiPrBOuTt/cq0/8WBuw3W?=
 =?us-ascii?Q?auE1spYa9sT4fOu9qnwdWzfwhNL8RQKFwUCDXCIHQvLixkSxj1tUnQ0lJ95j?=
 =?us-ascii?Q?H7pyPTZJZagiT447d1dkkYOWGWKaxRoWP9AfSIyoeOkdSHCY6X/1Fr1MxVjr?=
 =?us-ascii?Q?JuMIpj5WE+pUNDBnrdyaZl57j2sIGUNrNIJBWE35/zHkwGYLnYf5yfMR5BEM?=
 =?us-ascii?Q?XwDcbSUIp0d8bSaEgrlYF7fIPa8MkutpIVibXhHMrEMSpr4YrxL7CczmnHAm?=
 =?us-ascii?Q?Tv8HEtYJeVkB3ixrK7wRl++7JVVJuBuWjdeKXqXP2bYcr4T0Arfi5r4wNRXT?=
 =?us-ascii?Q?jn6iVa1kLACITH+11+lLAISei4YwYgVRp+bzs1GKrHD5rulipU6FzhFIxFNG?=
 =?us-ascii?Q?sq6eUxRrBOJtnREJq2p2lb4ZIgKwEncu+JSdBVaHqoXxaill/l87/kqXwah0?=
 =?us-ascii?Q?r3aysPa1rt3rXhU6AdQ34wJ4ZJnuSxML6+WOxAK/Il9Jhf3qBfw3D9e9HE+O?=
 =?us-ascii?Q?ZRVP0QBogaxLkDP1BhSnuOR9ObaFSoxj7PiRyJ6/k5GUpwwQ0qkl2SYuD+V+?=
 =?us-ascii?Q?hFx+tR6BzO1srTOobw2yNmG/ThEIRQEVhRgL3ubalKBJXyhmMGyM7YdzS0/+?=
 =?us-ascii?Q?goaJ+cZjaTuaEeSCjWC2BRSinUajkxPRRnf6kXT1mCKRvHAd0tZoenqRayoy?=
 =?us-ascii?Q?kXKaNhdO+tHV3h1qiBsYD6J2wiaAtLchEo968Q3rISE1h8Rkk65hKy/UOpdy?=
 =?us-ascii?Q?84oxAkRAYNKg4ZaP5TMrsZzRT+Pd8GiAxijZHfctkihl/DLX0gENMO78A52o?=
 =?us-ascii?Q?1Li9VifOwSlnaYoTjObWXLqHDLhVMO6kkHPR+RKOjMPod8M7SP3awuaE0/yU?=
 =?us-ascii?Q?AvRRRw0PBszIqy3cyKVecHGVdI9axPeQDN01P4j7kKoB68hb6yQm2oSVvliZ?=
 =?us-ascii?Q?c2371V14B4XOI6saHuOxR8n98OdC88+ARI21OL6s66u2VXx5jlb1bg/LOCPI?=
 =?us-ascii?Q?nnBUKJrKJh/iHK3529BOFBR2IZQOP9Kj4dV9Pu/sPCmgTVOkQImAD19zMOEn?=
 =?us-ascii?Q?afBp9iAS4sJRl55JX6S12g20GDnKZ/I9Unt7QEayfRsDx27uIU2sLhoOMW8v?=
 =?us-ascii?Q?oqAQF4WKUY8fD6tQj0WWWtWGS9Or8yQTv9Kj8SNXyVlCJeNkg9ZFaEnX2Pi6?=
 =?us-ascii?Q?Vq7e3CNmzTnXAc+1k1NPZ0WjfA7rB4HtNL/jcisBgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XoD4CzmZebQ6s1NjoJ5Ore6SDjwAMYhTxV6Yi1ag8kmZJ3R6A2c+s/Jcdim5?=
 =?us-ascii?Q?gUs8wOnPjABTpsqaPZruUhWCS3dkHesdlfZot3ejSblAbi4RppQ9EEJhcBXg?=
 =?us-ascii?Q?ePoZDrgjM8C56DQnhWqKB5mj0e4gwOSv5LwrooVOYxdQreiVSTpDoKd2iX7R?=
 =?us-ascii?Q?nqiAUXgwUBMaa4rYl/ND1Isgx8wzLpGfaVIH63nt3hacCqeWP0xE/+mMxwLB?=
 =?us-ascii?Q?utaEDX/FrRWCVCbI/uAb0EnXJ9bVNoCW7aUXm/c+R3ZGl7gkOf8FQRPl9lZS?=
 =?us-ascii?Q?PBQQXdErS2P5pxNcF4NnTrsTI3Frq9sJ9He2033+K3WPULh5TOQDRYZxxXPt?=
 =?us-ascii?Q?FUSNU1TJ0gkLuvhnHs57e7VwgotgP7Di9DBH1VHWrRrQekZoVbXn+mtQWExH?=
 =?us-ascii?Q?dB4OnG6xqFHE+fnFnsv/I2Fn4+F0qVOhvWo87i0QOvca0sjNbMdBueJY4hv3?=
 =?us-ascii?Q?KmhisyQP1Goc6/LQjCnPaKQ64MkJ+emRY8R4fHvvAEIoqGJVMzSEWZVBkkcf?=
 =?us-ascii?Q?zYOSQ3UaqAKCfhtryIYkP2R7QDi6HWwHJoVxbJr1H9yQVRPkrYVCBhDbQcr1?=
 =?us-ascii?Q?bXlQ/LU3TTY3j6pJx4gxOnu2WM4EqM92on2uQukI3uJkoydCzgfXq8vBgzFr?=
 =?us-ascii?Q?oTOi17FbBswKS5VONBGcwuzwWf+ttrBgcx6oQSV3C18apkVHJ3eae6jV4hUq?=
 =?us-ascii?Q?YmNmKIrC4in/X/gFE5Rs48zPRhV0v1VZ8YAwdOpQzzSeuSJILu78QQf404ge?=
 =?us-ascii?Q?tb2SNa7bgH8GDbUNECgXjbeW4q2TudZXeAavIpud+2iY/knnVa1sh7CaTMgZ?=
 =?us-ascii?Q?PL1J8dPbqOwyUlAscsI7yxlZsy4g+/IA9RiqEm5LM/XQncK/RP488kOqb4kj?=
 =?us-ascii?Q?F8HpLTYRbeHc8Gcgjt+MPGFBp7bwyAgjG6v6c5dkBQxPPKt8TOr+ujBMaOe2?=
 =?us-ascii?Q?fiCHwfLdjscm6K90W8Ut41AsZ0Vtmsmst4U5Gboj11cyvFl0PshG+w3S/WFl?=
 =?us-ascii?Q?kHxmp629m6q3rvdX7kd/AP7xe+Mgczl45c84ElN32F6Y6NDI/GybihztZpjf?=
 =?us-ascii?Q?i6pjSnBhQz1pHxQRNnlSfndY6+CZaxK5d7Kq2NP4R/XOjZBAHWCQSkyhozeN?=
 =?us-ascii?Q?r3vZl70yvRTgdEGHLvWmoU9gLzmutfcEZMHBwhT/dOV8zfhs4EWHUL/KbQod?=
 =?us-ascii?Q?7cnzKaer1YhIMW65iNFTM/QuBfRHjDS8AG0yvd8ilSyBXr9OqhCLfQiKLiqZ?=
 =?us-ascii?Q?cvQncoH1GpUV8IfphaNRenT1UBB0QzrIn7/7ztFc24MbnDWUHYUJpVFHCNzc?=
 =?us-ascii?Q?8t8NyfP5e6ebJ/ryU1W1YeR76Rh9Myu4ua9+Wo69mjc3UeP2G/bm28lqUKT9?=
 =?us-ascii?Q?227jLbIeA0fSxKZ+5DUrvEVgKfHNnytXG0CyAKtXnHyEafsqYZVPdTzxB/M9?=
 =?us-ascii?Q?rVBBYJyu8U6ZQeK2u7ZieVPGTcUcdkeFD1ilyEV53GxkIAb0b/GjivzpIlUn?=
 =?us-ascii?Q?4fEinpYXdMd7F83oJRx/PF6Ye9wo9gsoot+SQwT8nUemEZhHf6ytn5BuHGiG?=
 =?us-ascii?Q?VdOaYPS216OXBfxGzyYCBsuUjkG6WhyT8k7bBdn/V8b3eBKGM7hCZiJkJOOM?=
 =?us-ascii?Q?4xO8mzE7Vv04Q+STbNVh6mbFlgdRC4+fGZLWMnNBm/LMJjmx/PNtQQLS5imb?=
 =?us-ascii?Q?aGSyOg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8Co94JTbZA42kFqVUvdgs9290W5dpBC8k93/8FQ7LF2vkIOCkI3dxYh+zGxPFbn8H6Xn1SZGbVHXiROzvAi8QRmt8486ehCBahlvnxbhbsbp7gwi6nHQBzK3GimhWyCLP3GpinTKzgSTEw3V3gfTuDGcBaaH88tXwi6eDxlJ35XiBCN5TurrBCxyl9RAw8btpYgolqGQNGxtTmPXpzrbcXfeKpukJzkbz7OKD5BEHFZ28rRFUmiOhxMUu9oZJbYXUIJnY2x8LPYQG451RZEmsnpescRJQTE2auubYlHE2MeXh1NAzkjoNsOgGSUvCmC6lleW+Wjs0YcaNs4Jl84PMLjSV5ZbL1CxwWIxv5WfH3MXa1oHs0JZJEnaz2a2YNFtazXm6nsphZURkZKnLh8fZTj8cMGJO2Mck3Dpqtu6+k9SbdLycVkKurKaDrFODaoHkUfLyCtveexivQmoJ0nvUoTkgElHKJPIsoE1o50pSinTLZkxMH+IG8Bzo2tMWgATmacOqlyoTIkDMyslz6lqCLg5eit1HFrBktmjdSaEzLmJ1XQkWqQX5s6XdbuCl2F2duhoztmTbnhWJMfKxgNWKPemgDQ90ZFEWHvVU9vOdwQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6650df1f-6136-4cc4-aeff-08dcdecd55f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 08:21:07.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZzjdZqJiFkjN2IaxAjXDaRQchVCBx52jxfu/rs58G3xadVf6kqDjo510W9wYXba4BSFvBX+mf4AGHS6xDTpWfesLSSZzBrBsuoDVXBCKH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409270057
X-Proofpoint-GUID: IplASEEe7NAGwf7gEuEr_Ihwzj7WxNpX
X-Proofpoint-ORIG-GUID: IplASEEe7NAGwf7gEuEr_Ihwzj7WxNpX

On Fri, Sep 27, 2024 at 10:04:25AM GMT, Christian Brauner wrote:
> On Thu, Sep 26, 2024 at 08:52:32AM GMT, Shakeel Butt wrote:
> > On Thu, Sep 26, 2024 at 04:10:19PM GMT, Lorenzo Stoakes wrote:
> > > The process_madvise() call was introduced in commit ecb8ac8b1f14
> > > ("mm/madvise: introduce process_madvise() syscall: an external memory
> > > hinting API") as a means of performing madvise() operations on another
> > > process.
> > >
> > > However, as it provides the means by which to perform multiple madvise()
> > > operations in a batch via an iovec, it is useful to utilise the same
> > > interface for performing operations on the current process rather than a
> > > remote one.
> > >
> > > Commit 22af8caff7d1 ("mm/madvise: process_madvise() drop capability check
> > > if same mm") removed the need for a caller invoking process_madvise() on
> > > its own pidfd to possess the CAP_SYS_NICE capability, however this leaves
> > > the restrictions on operation in place.
> > >
> > > Resolve this by only applying the restriction on operations when accessing
> > > a remote process.
> > >
> > > Moving forward we plan to implement a simpler means of specifying this
> > > condition other than needing to establish a self pidfd, perhaps in the form
> > > of a sentinel pidfd.
> > >
> > > Also take the opportunity to refactor the system call implementation
> > > abstracting the vectorised operation.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> >
> > > ---
> > > v3:
> > > * Avoid introducing PR_MADV_SELF and defer a non-pidfd version until later.
> >
> > Seems like a good plan to decouple this patch from PR_MADV_SELF vs
> > PIDFD_SELF decision. I am hoping to see the follow up patch as well.
>
> PIDFD_SELF should absolutely not be a per-system call thing. It should
> be generic across all pidfd based system calls similar to AT_FDCWD.
>
> IOW, that should be in:
>
> include/uapi/linux/pidfd.h
>
> #define PIDFD_SELF -200

Yes this is what I was saying elsewhere in the thread :) this is why it's
important to have this as a separate enterprise.

And indeed this is the intent, I will be working on a separate patch series
to this effect. It also gives us the space to implement it in calls which
use pidfd where it makes sense and to extend testing accordingly.

