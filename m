Return-Path: <linux-api+bounces-4229-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0938B0F98C
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34BC188E0AA
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0D51F4C8B;
	Wed, 23 Jul 2025 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eFcGOuMm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eifhZGGy"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89175C2E0;
	Wed, 23 Jul 2025 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292853; cv=fail; b=oEQKIcmW7eqDAlbBVFt3h5k5KkAbCKyrD4g6Kh9q3KWQoo6guDsYpnaxaKhehMDruK97dRE5dwVr5sntNySgbpxC5uqaaoj+1kxXLgiJcl6KhfMMspNnrKLE2+vlIzpHK+hywsEVWdL4vsNHuGnIRXyLn2OTaSt5vFknw+e6kYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292853; c=relaxed/simple;
	bh=uXZruu9lEvQtAiXzwt5Q5xwLtGOXT8tBa9Twy+PeDXM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D2+HuyhVT+yfZCRHK++RUckG/5HklJbBlYC/2w0h98t5+X2eKtbUpITut7A7OJ7xyNapjirW9pftIQXVEyRmYdM4OkHifQQNDEncjJf/bmEQkEKMPd80PnvyfsD3EvpOiecX5caJHoCHa7aSA9wBsb1mo4ZHxiZSIeWbnkWy1DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eFcGOuMm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eifhZGGy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGQBKK003664;
	Wed, 23 Jul 2025 17:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=FYFHKMMdoalZ8HtT
	x8Ds/PRCJ2aFwRYryN7YI8CdyyE=; b=eFcGOuMm0kXjVJFH2FZtdf3Ak81c0VTU
	SVfLUSMapJxUsGJF9ytVUevDa9QWYPHKZX4v0ac6foo6WuL2UqtFdcHlJDK38mE7
	XbrJuwHHuw7FnYnB2P3raz1+yn5QmFzBa1qwN7jvnrl/L8VZ1Ho+ZNGCXRu227sm
	LMKxKrHJDiblH/vTs4XJqKGIfLcqY0GgC+FPXHI0tKIBbQapnxTzacTsHmtBj0w9
	TlRm8X3yB9CiPWTxAIu0bL2C7LaELcm5fdk1L1fbYMrsQKeNt7HR0Zq+V8Z1t7CN
	sk6fgx3ekvG+O1aAoeutxCAGuYrFg9ekwuFFdTSMOMpt6Jrc7Tu+0g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056eg24n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 17:46:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56NGRGWW006053;
	Wed, 23 Jul 2025 17:46:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801taw3hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 17:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkR2F+udkHZM7BdzcDg7CcflsNX88dScwt2Ckd81QPopvSYFjjRKPY5gORqlQvsSOl+1J/l7qVkZFQxpb4vwIijwQQM5EzFsaJ4CyUV9MXdOpcmG0ZhhIKPD85VNBk3+SzAQBFBukji7WkI2O5J+HT9C8/fYqZg964vs2Cjh7xAPAgnfCe/kGQoI2mdzp2Qa6IGaT0d4rmAvTuEFw03ab2UZmFEPBGhJBGI9FxQbMbI7p+VOrjIzDCW0ooYLUjfSXQhUPI6nakYXZvDZN2VpQJ+RfaZfJTcNtQATz+kWgvUpBj0oRpjYn3PiB/1Uh9+3ozeWintbTT8Cv6cVgcQPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYFHKMMdoalZ8HtTx8Ds/PRCJ2aFwRYryN7YI8CdyyE=;
 b=yDRnRtZPfVI1/y+ilatJZN2LXHEeb5Dd2Q4G1tmuF8ibLUcavEZrLq2R7wQJuonzZ1U1hK2Waxj6bmgrJlJ+miphRYk88n2vsrGr55qNJ4aY8ilrGnhjCLJccEJ0N/8cbHr55ZjMKFsNHZOFw7BEYCBVM4ooExuC+5Gcp+982YawMpUL5STwYOcgTCROEVvdI/f7K+uX+EUGHZaxFHkgWGPa4GyW1sXZAu++ubK6XN43B+w9VVcULL/2yZ0i4DR1A49oz05psDWqdyVMR+bmqlIS+qz64UMNsXCwDfuuYJ/p0wKW8+B90b+ZPGK2IrL/AqcwpcHZSjnrzwbEtB32Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYFHKMMdoalZ8HtTx8Ds/PRCJ2aFwRYryN7YI8CdyyE=;
 b=eifhZGGyxAOGiqQP7rLHkYvEXeGZsXx7n59Nrnx0ZMHlvQtCzzbtZERRJ/ZbRN6z1tSzXt/ku8b0fgJGoB5XfxE3MBm61i8k+4QEAei79rhzAfb1VE7w47gxowGkLf0loOKrnaUei7hXWA7LEjFbyeiP/ziCV3dmYqTxz/FtQ70=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4850.namprd10.prod.outlook.com (2603:10b6:208:324::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:46:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 17:46:49 +0000
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
Subject: [PATCH] man/man2/mremap.2: describe multiple mapping move, shrink
Date: Wed, 23 Jul 2025 18:46:34 +0100
Message-ID: <20250723174634.75054-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4850:EE_
X-MS-Office365-Filtering-Correlation-Id: 53341eaa-a97a-470c-b1bf-08ddca10e6d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Zdsa4ufCbBSZcr3dAChDxI7EgE6xYwhvcg3+unAcGESNQ4CN7WXgvxkqEZ7?=
 =?us-ascii?Q?6TzwxNOv3MNfP1EeC1+JGc6zBq6q0BCrcmlDWlnVau5wwpE7O7nc7ZHLEctI?=
 =?us-ascii?Q?0AWUyiO53lfY7Vk2lKsRxBGX8JnoLDzbM4lVDUDeItXvHu83UERHijw2jeEh?=
 =?us-ascii?Q?e/rGjOMO4uZ792w/RLQ8OJu2i+w11miOyX2Qowu528Ri3El1/H9tYtgHLavz?=
 =?us-ascii?Q?H+bsPCmkOYsLrbWsMv7Spc2PnzCTbV1lUMIkrXHrMxTH3IIZbgm8GhxVcu4T?=
 =?us-ascii?Q?DpGTWn36Lleu9pViMelZggkIW3sAVSuaoB7oI2wsdlah0H/3hQhmedBqWkJP?=
 =?us-ascii?Q?YBjPrMwyrwjzt2zCR6pWlW2hjLVFQGbgd6BTZOWDP0NYIYeC5AnEvUXEh00l?=
 =?us-ascii?Q?GV1Z830eMyJZWaj9kWw9D43UWYclFs9mpSVxpblvRbkXHowyEDJDLDo/QepU?=
 =?us-ascii?Q?cZtzhZLI4fM+LoE973RURyPb7IGM3sJ0k2coIUnhDPoXvwMbpz8XZ3Y7vYId?=
 =?us-ascii?Q?lUx8jJSGQZAiHwGdn7wBogNttb3PnVxd2HcqNzcSY4zEhMyO7ixoQjppInUT?=
 =?us-ascii?Q?OpuRAmdCP0VRbV8UjYRXax+1Erc3OFNnsgi2H8IJdXsQ3JJtwd0zHFOtkg0a?=
 =?us-ascii?Q?43aStnNXxPLGIDv3wepx2OrM7b+SHP5ki4ZsNsdBKXfDpBABmEt5xJmyrJGZ?=
 =?us-ascii?Q?dyboYHjXSvT2yw9SkdxxzK8UQnC3OsHShz4HzAb4ezFhWv/ZFCyzaqEAJJ9P?=
 =?us-ascii?Q?Lm0sgn6VXZRyZLyY0NxIHEE9xZUXTNQd4oaTFddIV7h9DJvczlP4fVHQWMIy?=
 =?us-ascii?Q?8xrsW5pRtXHlxjpkxh5I/bclTNG0iQTFQ1NRbyFx4rr5Jt1OSq4id2Oqc4+O?=
 =?us-ascii?Q?6fHaJG+z/3OfnYfbQSPAJc/N2VL9a5gTVEaAFn+TER6VvoyTwmhyZOjuU7TO?=
 =?us-ascii?Q?FSbmGGRx4/WcEXamFV1GwPvzcu4C+S4i8JhKjbPU1A5d651xbb3oYKOx2rI3?=
 =?us-ascii?Q?+GnAKZJ4nu7EYc2oJfM+q29c639GL4XJQxM4HFNwISP8556KopiJUFyavAlq?=
 =?us-ascii?Q?Qcl4wR0fGk4Kx9taMrFt58bMneWwHwgiOSWIfJ3d00PqhVccJL98qQeaugts?=
 =?us-ascii?Q?ixlFRC+7rGnR0nZWVP+ZPCQg8YNQDPR96B4c/9+u6qXZD3V27Le7MbtGLlPO?=
 =?us-ascii?Q?Ezpcpo+0wnteF6KXU3HXtFHLfsqE1+d67XdYgCyCRVDtmkVhmZ6Ih4i0yzgy?=
 =?us-ascii?Q?i2iax2hbLEV7v+gq3S96KwXVlov2OsUkHOn/uPx3FgPB6KKgF+/qiH6JOXUx?=
 =?us-ascii?Q?Uyq2+g5d7frmdZqiCMZJUEgDotXe3EDLRyMHVZ7t+EtCnyY8mPJHrgNZZsww?=
 =?us-ascii?Q?yRN7mvL6rmfY6cP870bdRaq9SNBrOkGBAd7OR1DQGPEtHnxNAGtZth9lMYFr?=
 =?us-ascii?Q?cbWg9HLkQsE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X4YL0/lxDSBsO2qzDrZU7gme2XiuyrksIuljSQ7pp8clXQFrD5c9TmuihgZQ?=
 =?us-ascii?Q?iLrUDInIEmoHdalZ7xpkgPNIsdVFbNvAbSimfSSZPCr4t5gQCh/ns1bxZqgw?=
 =?us-ascii?Q?bt+r/NBuBA2c9tZniRCzHWJPHD+cRJwrlYgTbUqG+SpgFj0lVsXbE9gC62fh?=
 =?us-ascii?Q?5iyHaW2whQK1sRdUFrXvKp2/8YZEGXp5IPXyWyhttwyK/q/kXpvjnliZjzUs?=
 =?us-ascii?Q?DmNh5nnIShz9CFSTkuCppdru6PE6rd82FznxgemcBjbYgMhc4CFnmpPzQUdO?=
 =?us-ascii?Q?UzJ26eufsCrSjRxWfDgleYv1QSPfvEEUiK+JuN/t8hF7EUNfHd3FTrhO1pei?=
 =?us-ascii?Q?B8S/F+iciresq26Fh71fSfSKjS2UzKc7MzyDG/c6+1HmbXP+e5H4poquRwIP?=
 =?us-ascii?Q?+JYMQzmn0EeiE7lzfl7/tzbDaiIFZ5s27mUqILSc3z/Ec49gEUinYHAc8Vtu?=
 =?us-ascii?Q?nBvJbs1krCatMuoU/qjlLGucV7lqAVoXDDNYKC21IBlMHI6A5Z9CMGecXOfS?=
 =?us-ascii?Q?AEfykziLovJyqZIgcxboNotzicuqqvAYLRteKivLEEQMKn17OhY+1J0qj4et?=
 =?us-ascii?Q?EeALw+GViibBvUYROw5vjqJ7X6tAhFxDByMQv5iHnD6l1MU3GLUaBUMpP7Ql?=
 =?us-ascii?Q?eEtleeN8I1KnivCkqJ0CkoU2B2Rg4kpDTMHY5mHnfaAAQbeCJ0jlLCc50T0E?=
 =?us-ascii?Q?do/Mq194hp7fYMhZEjwzTm4S7Nt0WpkrjimMG4XIXFv93gy+l+dj8PdrK17K?=
 =?us-ascii?Q?8vLQf1QYpg4Mmxv/5TdMzdnNwBYYitum7M1EPZioghpsAisxpo75ceG8FJBx?=
 =?us-ascii?Q?Jwmf9oKw0WXOV61HFin49mFSI5pIaROCGbeUcZ0PwnIY1gjzBHh8ScX0szcq?=
 =?us-ascii?Q?inqYkR6+r7bvp9wlIVrBhEZH5q+ZK/8REdZ4kIdRrOPZMOHoadYqJLINMCFy?=
 =?us-ascii?Q?ppDnoMmXleJ6iYvxdsh+7SYW52TaFpT1jlzhGgDjsHnZbFAB0XiOfPlBVJkE?=
 =?us-ascii?Q?YsSp+ufahTpn/bRunPRAYJI/zvOSnj52yrbaPRCdad/AeBrHcxn6g9gNd7fI?=
 =?us-ascii?Q?a8jQOhVpkVuI9RWmYIMeVCu4t5hB808TPZP9jtMQp/rV8oM6IkFRlbn3QezM?=
 =?us-ascii?Q?ysAhDS7bKgLkVrxuqqsEBOpalxZoCyO+IPUfGdokjtSL3R/SuSF/YAbDAmex?=
 =?us-ascii?Q?Mv1ZE2aKPjFNFEGAI6aNVFTO6iHSCDIhR/LDix4sZOzxkLWw8N6auB5Qkcl8?=
 =?us-ascii?Q?4m6ZjtDTsrXcT8PUdl6vpCM8iJYuszSOJa0EvK/NIUl53wgnETmhW+OyIAZP?=
 =?us-ascii?Q?IPDYPKCn09UwMlDfEom2PQqzp4Pkz/WqlrR3tx8SaZtJVcyPbpzCGthYZMeN?=
 =?us-ascii?Q?FOzp2vFfKiYpBYt8eLUWNRczpxBLx5ZayNCSaG5lWJ79W6w3MTUDCOntWxjh?=
 =?us-ascii?Q?Mfaf8lZkbY/52a/p71FemXNdxlAoKZlhtKdeThmTYS03p4GVkdMp+d6LV/8p?=
 =?us-ascii?Q?f5qba5EDYVxXg10KrtZ609fJCMOYxv7yZ9PWaIK7RBYhOu7LBL+HER4ZkcWU?=
 =?us-ascii?Q?+YhJvGKCSVS1qqwO3CxpsIY/Xt12YHmF2rnx4NPLPjmj4YTKttHNXicCy14Z?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UgwxYssnTYOQtyR1VhhMYzIv4Z7zymU5HO53H2I91UtONPa+Yj4owuUsNkxKhsTSYFd6w23B7AuVikmvYHlR2SqRdAgnjsBbKy5xI3F+ORpNt2CXSqIMmvFR6KQru1hbnZiC+OOMQMZVBNeBBTB8mxw/udNbUXlP9a+pTmh/ds8lrbVsfkkm37LfQpvUme8lcdI+pD4pCQosBkVWhDtrDYDqr5AiAg4BL6HpJmw2z1R+1tvBGG8Oa1iKJYVK5shaXPRRwT64YujgCWZjcfTPg2UJUzbM3KZ1Esoe0DaxXgIhI8QmV6Yo9pyDjDmZMolF8XR9g835+QHycgy+fYexf7MoMSjEZp0HdX5cBkimv+8gPz3cuZkOGOSSk/McnhuE5NAd1NQE/FY2MmYnK0Ug+bBs0kbQDLW/byKCXWylDqksroJVZ5lxphkqfR65a8oDQ6QEtfGZx5pGUaB8ngZt1nYQ2Nt/Y5+E6ghALJQ0XQEHOniXqXkxeQqppldvXtPQRiwZahvfIagzBN+qHEOyx/CteMbCGGRPk3ABbsRcW/1+3cxNqJI+TNX1i+XR9TCshDOiN/50eiSeCaMgO9VDrIWIk4iAsSjOxUfrFEkWoyQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53341eaa-a97a-470c-b1bf-08ddca10e6d6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:46:49.8414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C54Cd2ex0XnZPlqJhC4Bl6shf6zsZzRTy4hR8S3ojHBhCoAfu8VGjkHfguxc1vNah3p6rV8htvk9B8N98F/wlfdF+x7XlVRI4/hbsIdSBwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_03,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507230154
X-Proofpoint-ORIG-GUID: xKK040apBDied59QGxUKieiTA1yU9Llq
X-Proofpoint-GUID: xKK040apBDied59QGxUKieiTA1yU9Llq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE1NCBTYWx0ZWRfX9Ks8RdvykLsc
 pm7uVfvdsH6Vb/duchQRGzTLFJ8X2L1CI+9JjjDSqSjZchQBZoZFRypQZVpLJxDz8sElSC54/kt
 yfaTS7RoA+CWVFIW2pfz4FQcvwwVIpR+AdPseUenfAAVSKPyKkwhVU+JAY0vgvnt6JusLZ6aGbM
 vKDMVQtgeyyac4DGIgQRxcnJuNAsDNzFfI3KjxoVfwRz/Nw2UvI3KuWJybYArDtWfFhyGoqkyd+
 +R5Hs9D5H30yUrW3TmgEPgssQ+7u/le+mkdlL3NvwSZFZAK7jb0dOq/g1iir9+uwuxtjYtyxLSH
 gxiu48bnuWFR2MxRS/qgOZfTXa3qPFKn0aRosPuAe2cmpUTSKt550nZOSqZdqaLOSIgsCUPwFLJ
 ojSvKDoJVowHLt5xAzcooHaMn84Ui9QiSWHv3dAljM9YxLnm6qlN8HTeuy/Sd+PyADTw4IJ1
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=6881200d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=VAqEK11FdZ_IT4zXH1QA:9

There is pre-existing logic that appears to be undocumented for an mremap()
shrink operation, where it turns out that the usual 'input range must span
a single mapping' requirement no longer applies.

In fact, it turns out that the input range specified by [old_address,
old_size) may span any number of mappings, as long old_address resides at
or within a mapping and [old_address, new_size) spans only a single
mapping.

Explicitly document this.

In addition, document the new behaviour introduced in Linux 6.17 whereby it
is now possible to move multiple mappings in a single operation, as long as
the operation is purely a move, that is old_size is equal to new_size and
MREMAP_FIXED is specified.

To make things clearer, also describe this 'pure move' operation, before
expanding upon it to describe the newly introduced behaviour.

This change also explains the limitations of of this method and the
possibility of partial failure.

Finally, we pluralise language where it makes sense to so the documentation
does not contradict either this new capability nor the pre-existing edge
case.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 man/man2/mremap.2 | 93 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
index 2168ca728..c1a9e7397 100644
--- a/man/man2/mremap.2
+++ b/man/man2/mremap.2
@@ -25,18 +25,56 @@ moving it at the same time (controlled by the
 argument and
 the available virtual address space).
 .P
+Mappings can simply be moved by specifying equal
+.I old_size
+and
+.I new_size
+and specifying
+.IR new_address ,
+see the description of
+.B MREMAP_FIXED
+below.
+Since Linux 6.17,
+while
 .I old_address
-is the old address of the virtual memory block that you
-want to expand (or shrink).
+must reside within a mapping,
+.I old_size
+may span multiple mappings
+which do not have to be
+adjacent to one another.
+.P
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
+then
+.I old_size
+must span only a single mapping.
+.P
+.I old_address
+is the old address of the first virtual memory block that you
+want to expand, shrink, and/or move.
 Note that
 .I old_address
 has to be page aligned.
 .I old_size
-is the old size of the
-virtual memory block.
+is the size of the range containing
+virtual memory blocks to be manipulated.
 .I new_size
 is the requested size of the
-virtual memory block after the resize.
+virtual memory blocks after the resize.
 An optional fifth argument,
 .IR new_address ,
 may be provided; see the description of
@@ -105,13 +143,43 @@ If
 is specified, then
 .B MREMAP_MAYMOVE
 must also be specified.
+.IP
+Since Linux 6.17,
+if
+.I old_size
+is equal to
+.I new_size
+and
+.B MREMAP_FIXED
+is specified, then
+.I old_size
+may span beyond the mapping in which
+.I old_address
+resides.
+In this case,
+gaps between mappings in the original range
+are maintained in the new range.
+The whole operation is performed atomically
+unless an error arises,
+in which case the operation may be partially
+completed,
+that is,
+some mappings may be moved and others not.
+.IP
+
+Moving multiple mappings is not permitted if
+any of those mappings have either
+been registered with
+.BR userfaultfd (2) ,
+or map drivers that
+specify their own custom address mapping logic.
 .TP
 .BR MREMAP_DONTUNMAP " (since Linux 5.7)"
 .\" commit e346b3813067d4b17383f975f197a9aa28a3b077
 This flag, which must be used in conjunction with
 .BR MREMAP_MAYMOVE ,
-remaps a mapping to a new address but does not unmap the mapping at
-.IR old_address .
+remaps mappings to a new address but does not unmap them
+from their original address.
 .IP
 The
 .B MREMAP_DONTUNMAP
@@ -149,13 +217,13 @@ mapped.
 See NOTES for some possible applications of
 .BR MREMAP_DONTUNMAP .
 .P
-If the memory segment specified by
+If the memory segments specified by
 .I old_address
 and
 .I old_size
-is locked (using
+are locked (using
 .BR mlock (2)
-or similar), then this lock is maintained when the segment is
+or similar), then this lock is maintained when the segments are
 resized and/or relocated.
 As a consequence, the amount of memory locked by the process may change.
 .SH RETURN VALUE
@@ -188,7 +256,10 @@ virtual memory address for this process.
 You can also get
 .B EFAULT
 even if there exist mappings that cover the
-whole address space requested, but those mappings are of different types.
+whole address space requested, but those mappings are of different types,
+and the
+.BR mremap ()
+operation being performed does not support this.
 .TP
 .B EINVAL
 An invalid argument was given.
-- 
2.50.1


