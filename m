Return-Path: <linux-api+bounces-4434-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB64FB2034B
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 11:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E8F3AA67C
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 09:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1672DCF76;
	Mon, 11 Aug 2025 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pB8cm/ku";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qfQU9vvQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6C52DCF73;
	Mon, 11 Aug 2025 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904400; cv=fail; b=sZFaGv/7/X5PC792RN1SfjyzTQNb39HhpOnI0x+swV7/mZibCqgU981ukhSvF9gim9KVPy+z0KuzEjt5Kq7FQesdvyPsdFNObj52CVE3KG03sYexvGkNb8odXf29ljWbqQjI5vmBXlPcvLgZ9Xygf1aXjUBKpmLKESqfkMaDISk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904400; c=relaxed/simple;
	bh=Xk8OFCw1XIbFYBJ5ogPaMgYMwNdMkX4z4x3pJETtq9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NlwvW93KAOYTGUjcUsc3NIonACWJjJ9lowYj0ZJ+mR9cu37WT9/sdqnLXyR2j3xpbatJ4AqMZD8L59FdMZSKTBpbCrCOCCf5s90iSvzzKESm8vlBENoxIfHadhs0zuKCLK7Ui7kFZ3+JfN1cjdFGQigCOYDsz1JiQKOAqQodE6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pB8cm/ku; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qfQU9vvQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uD69028660;
	Mon, 11 Aug 2025 09:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pr0Mu9Z0D7q/24jHc3
	NGDhZFpozOIcgKbGQBOpAMZR4=; b=pB8cm/kuv3V2ep4di/O7umUkc4dRu6HaY8
	Go9RmrKH1xBsUppxughWS8G9HB8wbHBnFkkMEl7yPeskLN452N8lUrIi8QBdQytr
	V5tM5Ljf6Fy55k0cPfmQbH0cx1EPr4y9YAYSru2knJbG3VxH6HuGXVQ52Y0gLU/+
	tcQbeUAfJQGzroBILFykoOKWcKxYyz8RC+JAHwIyq+UGbucX2tYn5QngEJQxRFUD
	bkBaYSoGXytZBvu2gJKfZfAzjL/msRK+lX3Y9BMK/+PZ8rKBB6QvZoKzcoapi9Zk
	23Xj44bYqYZNoAJn+0+a35a2LbhNiFhXsoGvafiXMPvDKbOMKLDg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv22r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 09:26:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B8Zwbv038539;
	Mon, 11 Aug 2025 09:26:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsex6f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 09:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXyBvS0QLeRygYrspEsHPZE4Xt8sSDqept/QR/Y/HCJI0l6Ei/XZUe2LXqHe12S1ugrI5FS1nfSUyBC45gBwKHTbIfcCbC6Z7u9JDVrY5VGQRSUejHwNwPg+UjkyQGbpSI8bC0RHNafdJEgilgWMPwZcjhPcMCcWXvER/mRNHehjLyGCl9oPwb5tsMh2FFsTFag5knzFvt/Yg1wJUuC38FArpJFkEd8AAsV4nK2PBds1rV0agoc36h+lZgEb91SlgpeiGV+/2qKBlhV4obAI1tTT97Tli051xMJMYMtjMynrfKJyiRFNV9i3RXH1jBJ+Do6aWS/1c/vFPx8jMHu7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pr0Mu9Z0D7q/24jHc3NGDhZFpozOIcgKbGQBOpAMZR4=;
 b=Z3qHiKuK7kg2aMhjkFWJUPu4cYJ3apyDRgilIRlPTKXOSN9M3tzsq9h2eIEIT+6pZHRgu4y9bbjiveAHlzYIQqXcmE2MLM9fyBHs7xmz3LcDsAK6uRMi3xyc/P0vcKKMIX+Is3soM2QUxJTHV0vb4R7B63QDtUDkOb2SbG2R4veCK4SyTIBj2pBgvLflRFfslPELqrwvYwWa3fqcepkaSywVlDUKoU2XPWvYH2NDTsUitOsQslZ21CmgrAAu5JL7g7mnrP26w76QILvYORUN5H1sNGTaHeUXh/0+ymSsi9YFEKCE8rtvcpGw3TosXZsFy/MhZCaUyOj1R6ShRz5wDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pr0Mu9Z0D7q/24jHc3NGDhZFpozOIcgKbGQBOpAMZR4=;
 b=qfQU9vvQNbLvSdUJhB/9OCc2V+zNWBo9r5nSLgmgIMMisXUNU9qRV8rK3v5dPkwwTNSV+YkGWmeb555hzHs/ranO/v9n27EcBnBqLE1QQ46FAFNH9NOexPLuCKuqXPafLgZw7IjoO75PP8b9Autom7yoDb8V7hLtvpdKSGbfiA4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6956.namprd10.prod.outlook.com (2603:10b6:806:34a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 09:25:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 09:25:59 +0000
Date: Mon, 11 Aug 2025 10:25:56 +0100
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
Subject: Re: [PATCH v4 1/2] man/man2/mremap.2: describe multiple mapping move
Message-ID: <39fb9e1b-b806-47da-a711-20c6cc12913a@lucifer.local>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <53e4284ffe80a63260c957369ccacea8f5c16adc.1754414738.git.lorenzo.stoakes@oracle.com>
 <ekjakm6zburrawhk34smm3fd43zufzguisfean4hmv7vyjp7fq@uvy6n47qbydl>
 <664b00e3-69a0-498a-a7dd-a3d294c0c188@lucifer.local>
 <iny6ro5f37vcthqwscklqx73jscahodilug5d6umleyzq6a67k@ecoey5ud3aer>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iny6ro5f37vcthqwscklqx73jscahodilug5d6umleyzq6a67k@ecoey5ud3aer>
X-ClientProxiedBy: MM0P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 2328d2a5-3759-46b3-5031-08ddd8b9156b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjqZHplGHKAZakWGxo1jXU/m6fec5MHnSUPULBEcnXOJorzxeRgYPebmxmgi?=
 =?us-ascii?Q?LzL9qirHj6AgA9lhMa43KOfN+FI/eYccJQ6PmM+RgpQFdYk9uWK7P7xGc0Cd?=
 =?us-ascii?Q?D8PeEuygUTt648PUW/M3ny5/psCCH23IwurxUtZm46vtUhGIKql8qmgLGmWA?=
 =?us-ascii?Q?vhuVCZixRRQvq7biPVHloLUPXKrdOBd+wv+GouPE4nFxH6MvS3S1f86mt3xp?=
 =?us-ascii?Q?Vbu3trU3lw7b+Q98k1uFl3KcNNJz1DZynM7nAOGMgI5jRT00tr2h1hBpU1WH?=
 =?us-ascii?Q?FVq52n9mngrBkjj68Q13Mf8LF8YM30Xq7ja0JcuObXlwcMfI4asaDL+zYjae?=
 =?us-ascii?Q?lntAGRFKtHSSBdPGfK/oBbclRQEk49IT04t4ChdOwkju5Rbgf9ivwCxDkJ6Q?=
 =?us-ascii?Q?+feYGVodhtpJvYkyKRAjl8p7htd+1lpMmU/OPOZzLueVg0RHJv/awHQ2EmOQ?=
 =?us-ascii?Q?fH91/+poE7A5u0YKN2i8HtpF4CdvTdpjfTUwJPl+6VPBDi5B+e2eSro2jEwU?=
 =?us-ascii?Q?siJdojwjEP2voqSwWNNDISXcwn+6JOqGiZ+FPoJheCIphY5eqbZVSIThcNQa?=
 =?us-ascii?Q?ASVC48+ve2eRNGf6JkLhRzRqp/TU5vvf6JJGlhILzMIIgzy9xEYJKc+DDHjS?=
 =?us-ascii?Q?+WqQCefEs3nwhyH5jx567eOWs3K4mq9c/Fd5NF+1N+j4oMznNEcvhBNUOObt?=
 =?us-ascii?Q?wCofWl6FY19CYCczwG012K8cCo0sE+vxc8CX8MT4S9qwbDAck4N/nPZPp501?=
 =?us-ascii?Q?vOVQnJyMVLtsHMq65IbtxqJmuVlyt9leN1AYUkiyPwpN/VOwrhpQ2gkz+UcJ?=
 =?us-ascii?Q?fZtJ4oqw0qltHZuCBwEfhRIMcn3PsWdHigp3yaR3xfza7jO1cl51MvG+l9E5?=
 =?us-ascii?Q?P2WsYIrn+UgvHXQzgf+015f9Rz6+JESCyBdUx0+jl9oaS8t3yhqORHfntHfG?=
 =?us-ascii?Q?XcnQCybyoR2gta+b4q1+NziKmmFEX1Bv6X/l+7qRO2JZ93RNnFiWvvBMloa6?=
 =?us-ascii?Q?0QTAJp81ECWtVxlumYDdTqHX1wmRZeBP+Ri7pVwl+6dU9V3UwmGxOBrSGfii?=
 =?us-ascii?Q?f53yPEvnM1gV5mSPdx39t2w7XLF9SSbhJrVnH6ISqbbQQ4i9eWLdeL7NreHP?=
 =?us-ascii?Q?dISIHVqmkO39RYTTG4MdnELCHjxser9w7U01bvTS0O39GNUNjAAzLcvPjzW2?=
 =?us-ascii?Q?IB7CxZkmhxY3w1nlH1ga2WohK3mH0jGOT0gCud8E7opXF1SwPFC1HbviPPQn?=
 =?us-ascii?Q?5ZpOgZHWU8hHsGR8taA6bmqhgFZCjERpoLPTuo5n3ViXe/a2afiXIzceb/d0?=
 =?us-ascii?Q?BrdTcjlp60O7ER3tqrsP2VkoEwNy2isCwCL5ZquPbYb9D7++awYh24gzrmfW?=
 =?us-ascii?Q?ZjXpo98=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j1LVItTAo2fKgL2n8lZlvl59l5+oKz7gqczGvmlOwcCS/cYIF2k855j7zmP+?=
 =?us-ascii?Q?8BhxytgU5jHNo1mulZYuoq3lsLiHQN42+Yxfo+wmmq2jqgbqFgUr2CACfaQz?=
 =?us-ascii?Q?OhXFloqlxG4B3+/LraIenm5m6mmHzuBlUs5xe2xTeEzKgcw5ncuWL0jeUy3m?=
 =?us-ascii?Q?0N9c+ql7HuJZDG0GKUhBFO3hA24+De84ArqZQQuJdsIMcBZWL2EQUQdoScbh?=
 =?us-ascii?Q?c01LqLPAan6xYFYf2cHAX+McMQJKx9KvcTeo4MCABYN09HdyaPnBr7+BhP9u?=
 =?us-ascii?Q?MgqbgUUlld2XB/BP6YjkdY/oTEn6i/Jioqgg9cvIG7L5oXfErYWvGQzfBZT7?=
 =?us-ascii?Q?1vfKzqd7zTKzkympZlNxp65DNGuTonse/4t33Bq6UjHJmCOkNjp99ZD9NEAQ?=
 =?us-ascii?Q?DbTlLA+WphUOc30oEBjVFhc75fgajge5RKqTev8TQJurilf9YBl45kjREyBl?=
 =?us-ascii?Q?2NPMOwBizMve9FcZYvLsW4NcIAeIYSb3YVdxg+UOpfqJkCq3T/Xcv80zBhH2?=
 =?us-ascii?Q?SlcgWoZPwUDIVDXwpbU8wzlHUsIiz1dl94cwCpce/f9ld8PQRebFGDph6lz/?=
 =?us-ascii?Q?0pFeQx8VJ0wTawURfRDlQeaO7YqJOV3CreJMffA1eebsH+zUlA9b0h2dP3Ae?=
 =?us-ascii?Q?zPEfyHCAZxIqSPoB+7YTXDdexjERodaPYgMDP98hSqtA6Ae9rlC7xStUverg?=
 =?us-ascii?Q?mgWtQrxPK9z/m19BT4bHhYBWVLyBWFV8swkx2sJ4amH13Ruoor3idA0pR7Ws?=
 =?us-ascii?Q?Bt6IeJxHxjU6a8PIfBECqV9r2/JnLXtRz1s2NyRs/CNbJPivfN5mlTx/y2TT?=
 =?us-ascii?Q?Sg1+esFVHJkVbIa6qLDy0BcVe9pnu5YWKQ0P9n4JBj9Ie4oZ5BrRMHTdcrih?=
 =?us-ascii?Q?63NlF/3JZ4FXUTUmU3Tbittz8vXVVmg5imXKIxsYoHAMSjSfPm9AXzoh+hZ1?=
 =?us-ascii?Q?GJ9N8J2cj9xocmL0GasGUTpnr/xEDn0bVPh7NtHQelP74Nuj/UgxwQdKN70l?=
 =?us-ascii?Q?+0/YYmbwC3dwirH6f3s7Wg6TvMrDFgWPsGbaBM4zzMvs90F7jAeipLG0yrCp?=
 =?us-ascii?Q?zOlx818ZWhwVf520VPHLIJRJXMBoCsqV83pIdAkJlG8sjiqnK/8xV3gkSmHQ?=
 =?us-ascii?Q?TRasoL1+j2kXWFXSzKpu3VzYj+iARQZhOTztQxwhCQTNY+ARrIhy1xkDVDoT?=
 =?us-ascii?Q?S2Cp+KO+2rCe7n2B6rL2sEO6T56jhjgrl666r+lJX8PVs9ITsSMeoIYGj8M5?=
 =?us-ascii?Q?tMTtR5DGz7x//wlZidFxgzgqpMjhYTGWKva3pxS7+CnxohhE1v+s9uj1w+xM?=
 =?us-ascii?Q?06Bk3geqNvrn5/2VgDR1SyHAIPdnyotb0F1MHbT2k6LjH+vi/2pzBQhcpln8?=
 =?us-ascii?Q?/1LNu1RD/f0nM6sge+Xw2M/liljNP2TSOf7UQRx0PPgb58g8lsWOdQ5/c5UU?=
 =?us-ascii?Q?3EpV4kPEFEQN5X3ouqXSMZChLP6SxsqF+G/5i+5KtRG58RfcVvYisxbPZnJJ?=
 =?us-ascii?Q?BF5fqXGcT2aEYPhGwa3M2COYb1wZycP66aI4oFyvN7GXKSsztMUV8HGV0faM?=
 =?us-ascii?Q?GtSNRv1cQfYxLa6VcaT2LUVDRdiIYAY6AQ/m078WCqq2uqmappgzp+o6GwKE?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UgGzhuLeXaRnxYODTNnW++Dl3D7EXysmGNz5s0zShlYPDRInl4rG+rcqHv2LAAp2qzMM3sl1JmYdVjH8aXf52l6adXFHfxEs4Qk8Z54m18URC9tciUUqTzKHBBIDAQ84SZXnkwEPcNu1hwp5656J9Uv5bushE/20UpDxOFpgFHkGnlTLgil8E7ybY7S79n98Pb1dm9KAsT6Hkwk6tIpO8YPteetkjabQm6R43yVLkHbI1kdCdLezeETaJ1yXJSdy0UH2I8122PLsF8fv4Ar5dQ66qgxcvJNkjaloR0LLDmcUZOGbUENGaz0JhVExKg8CpkgIYQae3M3CD19nOiEh4cnpDbf7E3IBEHyTdyRzXk3jexycRVn7c1UFIkY2nOcaPPn15rBz4Z0JKPe7NXseuBzeTCwgk29hSYj3T31PIlQNZbj0AeNpEy+/5Wz7/MSIhwruOmxI133kN5phpYNi5mC6nufWWkeh6qBy2AnBBCbVEGIzpVTgABWeLqfgG/q3Arh3W1tkCRaMfdvANFLWeNY7BNcmUnRgPjVnMzgQt1jKawgMCTBZxRr0c7MiC7IDoRX5jGRGS30kSkf3pnN36bI9dDide/fzmelZze6qZmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2328d2a5-3759-46b3-5031-08ddd8b9156b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:25:59.7390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDsETTrKAPM81ukrOtGkOdJJNGmD/KQEjMohLS+pgEAIS5dEb+AKbKIXmQibhYia8ivs5am48U7yebGHBP9eiknscOKsiV3DCgAtzdDAILs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=833 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110062
X-Proofpoint-GUID: B9AqwN05GIOoaLtar6DZKGCRDuWe-QZ3
X-Proofpoint-ORIG-GUID: B9AqwN05GIOoaLtar6DZKGCRDuWe-QZ3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2MiBTYWx0ZWRfX7iMojqlJmRdE
 izGwN61WAwHYIsKmSJRJEytofM5PFSU0Kd0bGsE62z3G7o4uap9HVm2Ci3Yu0Eh3T2phMbUjXVM
 CPPgcZq8B2az89dzvQ92G9NCsN1DeFob36jSa6L+fq/oApg5/XujZNbgFfsrjYpFLaKqM1pEGtJ
 R5cajolh72iwaIrOSJXYYlfKb9E0RGDNttsyxIxw1dkvfZDrzpQHdxsE8zbXT95lodRXx+v6Fa3
 C1UTrdXXO4H0gqzFrMpakzM55Rlv1e1L1x/Vv6E1spUbyWkNik4gWCn3ujcn3LPZS+dqMiDm/+w
 sn4QStDHDMW+ySaHlUOmRVkZhVeykHAyEHp6NJ9N9oSganpg3HCYlfneVhasaK4PVAJM7mN6ADA
 PfupRhJnfDV751HMsDjejEYRcGzZEFzgWdXq8MNQCMzwRPHtjvznHvljcFPXPgWURP7fNJNP
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=6899b72a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=MEjK9-KKAAAA:8 a=6TMbYnzrubFj65_4jZgA:9
 a=CjuIK1q_8ugA:10 a=wDCLW6yMUrMVbYbmd6V3:22 cc=ntf awl=host:12070

On Mon, Aug 11, 2025 at 11:20:05AM +0200, Alejandro Colomar wrote:
> Hi Lorenzo,
>
> On Mon, Aug 11, 2025 at 06:30:38AM +0100, Lorenzo Stoakes wrote:
> > > > +Mappings can also simply be moved
> > > > +(without any resizing)
> > > > +by specifying equal
> > > > +.I old_size
> > > > +and
> > > > +.I new_size
> > > > +and using the
> > > > +.B MREMAP_FIXED
> > > > +flag
> > > > +(see below).
> > > > +Since Linux 6.17,
> > > > +while
> > > > +.I old_address
> > > > +must reside within a mapping,
> > >
> > > I don't understand this.  What does it mean that old_address must reside
> > > within a mapping?  It's a point, not a size, so I'm not sure I
> > > understand it.
> >
> > I think if it were a size it would be more confusing no?
> >
> > It's an address, the address must be located within an existing memory mapping.
>
> What I don't understand is: how could you not comply with that?  Could
> you pass some old_address that is in two mappings?  Being a single
> address, that would be impossible, right?

It can be in an unmapped area. It's either in an unmapped area or a mapped one.

I could simply reword this as 'old_address must be mapped'?

>
> > Will replace with 'located' for clarity.
> >
> > >
> > > > +.I old_size
> > > > +may span multiple mappings
> > > > +which do not have to be
> > > > +adjacent to one another when
> > > > +performing a move like this.
>
>
> Have a lovely day!
> Alex
>
> --
> <https://www.alejandro-colomar.es/>

