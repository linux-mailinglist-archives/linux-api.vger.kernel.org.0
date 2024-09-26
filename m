Return-Path: <linux-api+bounces-2342-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 045DE987641
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2BF286C9A
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EF613B7AF;
	Thu, 26 Sep 2024 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wh8Ej3rO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AbrFF/zX"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1881D5AD6;
	Thu, 26 Sep 2024 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363459; cv=fail; b=ZxBRHnzmdHd3bL71LkTsxRlbIS0xzvRpPwec+ya16qY3L/cP1Na/UfffuZ8MkoUrrb4OEFRdm1Y5tl1Fp8usRisZ19N6k3cmlg208A143YcEA3ZPFGVJkFPj1Hpi8ASsARzaka1ywdcWC0E3J16leBLXOJEmYy5PeBw6gArFiFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363459; c=relaxed/simple;
	bh=Ac48Ua4JC05TK6mLwThF5t/vR6TvbV+YDKj7s49dZYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IS/83Rr+ADiBSg7a1ceq2BpuYomlzmTwkUYLFqk4m5CspkKO3l1z5CTKCtR6kSnm3Yc1zyKuc/aLDh+7YB8I4Y+2W6loW6KqZxlVoPSV9TDYirDu5BWxPUd0NYvRHp29Xxf5NnHlZbdixYdzc1fsR9IGqzdw2HYFOceNcdhA5+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wh8Ej3rO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AbrFF/zX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QEXakw027081;
	Thu, 26 Sep 2024 15:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=dx7Ixwkr/KUEau
	1xEFPhQX22TfVClPzx5j37lGF3y8o=; b=Wh8Ej3rOerazPlRBpSGgg8E/FeK60z
	+fGYFlpsvC9mtAPRny21ci6M+RAhaqRaGLxlfND3UcZjGf1BtIJrJOevpNaOsqQs
	rzce20VVyb+C+Ynk7SXluX+yQlAJWlePhGXhCeQrQq6N8DaTuV46VY+mD0wgv3YW
	MX0U+ThzvS5nP3eYjk1ualAoXWaaHpQfYHyJCxvNogToKkSpuezHGhsU+opDAKWg
	ERK5T+fQHcVopxU8Ndi/piNNnliCHSgb+eihmWxF1rcPelGNAjknljc/wjp/KYSV
	KusOc0X1UDufUE4gIupxszmleOXRe0JD3ePPkfCB4O2TFLg0eflKiuaA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjdau12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:10:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QEMFQC025269;
	Thu, 26 Sep 2024 15:10:31 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2045.outbound.protection.outlook.com [104.47.73.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkcafq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 15:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cvi6+DRsggnTrSIN7tgk9aghVN4vEoMOtQL+VvRXr708tkzocKxyMm8ufM+/MAVO5uLbkzMJUtuJjJmMdQhrsMqjDHn4DFnaozV7ybEu9iDRfLopsIW6Q56JtiPICvPN6GsA0xW06WiKGwv1juSD+xQX/JybbcorUn796IoLIa2T80DYkOTNbWLzTvDIphzb/wMxudEqzixErZPf2KSQRmBSN86WmIaHT4GGX0luUExO+1gvH26l3E55jVNyjDgt+O8VMx1SSepQX36yLTW3UjTWk3oTkoIjnLB92zo6Km7LT3A8wIgdPlm8EceKnY7Ty8men5GJPdy19pLKq9cvcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dx7Ixwkr/KUEau1xEFPhQX22TfVClPzx5j37lGF3y8o=;
 b=nIrXz4pvXRcYdxswGq38mBA9i/s4xmiZG87AjalndGi4Xix1DiglOZcdNPMoX2bfo3z4/gVHUIOf6N/J52A0nUCeWHlcpuzUZiUYbLoujXSGNGsIyVlx+Tt5nUArZcNjGKjPDkkSbJHAkhDRZ1RtAzmmJ80XwrdNSw1FmJtuh/zeWG/GAWV+NzEBLsjioBOExfAq89SADllM0R1l6Utmd6JdsO2Mnj5ei2tgo0xBQC3eI/IuwJ8YeVjusxPibfQ0Jw9E8v95b+9Kw6TKEsidQco8KQNrGYTSUUcfMoEeeZuHdGKfsjdtALNEXLQvyOaVh7DKq3ZTRaMRJXiRfjjTwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx7Ixwkr/KUEau1xEFPhQX22TfVClPzx5j37lGF3y8o=;
 b=AbrFF/zXd7dDEZ1J6GX2yUk36i5qlsZErGhDPf4FQ210E6o9mtAPh5AHs8v/dvpGRAmRWbK2rjG1QR5Ap9ra2Mb4aEMMSiM/o+cGvFpHmWIVnr0GieiZRkiJmsu9Wf7uwpPowg9MxqGWtO6VNMDgIY2QMmth02lSxYQoAyHGzms=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7342.namprd10.prod.outlook.com (2603:10b6:8:f9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8; Thu, 26 Sep
 2024 15:10:28 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Thu, 26 Sep 2024
 15:10:28 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>, pedro.falcato@gmail.com
Subject: [PATCH v3] mm/madvise: unrestrict process_madvise() for current process
Date: Thu, 26 Sep 2024 16:10:19 +0100
Message-ID: <20240926151019.82902-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0613.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa983de-3ba8-4a00-9d58-08dcde3d5ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ucp+1kjdmjrR8NiQNY6fMooiHCctOKzxBduaup9iz4vJCXz3Fx2xImynG6cK?=
 =?us-ascii?Q?T+qCuS+H5uyFnwuLyeFVY6ykEEr5pw0/b22EvzfPw/hKZRysgmcjC6PFHyJr?=
 =?us-ascii?Q?I1KnAexgxM12NpPxIeu0dAd0zciuLe9RQWNos93t7xy04UHxZhyERaUn2ZG3?=
 =?us-ascii?Q?mUVH4qQQBXIgyTtoBNbFcIzqdOGj5Mz+awxUQfUqZ6Sk9ARJaFQisGFx2oUz?=
 =?us-ascii?Q?IoPO4L1ZQCb5vtNQ+WOXMSAzmzlJ9JxeTj+h30i2YPyk4PBa+M0aGUxt0FJX?=
 =?us-ascii?Q?IOsw9XBFU4XPa7HW/5SRNkRxVg1Q48/lcW8Y4gZAQ+4B1X7N25aW3dqaxNhv?=
 =?us-ascii?Q?MWO01N5GhOPQsdGPZBOPy2dcI27Qm80crd1rm7/W8bPw3jBfRYiNbCaplHne?=
 =?us-ascii?Q?uvUuapDVG/MH7aUkWcKBrmBVy9PnLexkKRiNKEn7Ga7YGzUSo7HYGeBmHOvm?=
 =?us-ascii?Q?KUJaoAJce9LfenSBiBVKYCHlymahdntYU0IGVtjcUifwm5SPVB15htg+rW6N?=
 =?us-ascii?Q?jnOgnW0PnL7E9LCiQluzkdRH/wz96ke+ttOJcL0DCvFX5VAaqMSOxc2085Uc?=
 =?us-ascii?Q?VLU/M5lhEnpAfWg67fBP+U0Ci3GKNAhkzCJrRmeUKiDQL+g5Xi+E5MysVnN+?=
 =?us-ascii?Q?1SDKkNakE9pJD67rtmgaAvqpzsOcPjuEriJAQ5DkHSv+J2bPZUwk9kZctT8P?=
 =?us-ascii?Q?98kEUTcc7EF8GFQdm+CWTGLKiwKcSHOaHW8iVbnS70FZwH4Z1MdEA9xENTL/?=
 =?us-ascii?Q?YMJhNvW39a4VGpwyBi6S+rcSGU3SVa/DQQVLvOujOuaI5WWafdxElbpRl+EN?=
 =?us-ascii?Q?jUAKf0uciTPwtmdNTQkWm4nvxE9iH3GVVs4RoJaKGrwvsziJE5BvX2iGOlz6?=
 =?us-ascii?Q?wdZciM/yVBbiPCNGviyktYQJOFOxywoJppt5jmWOLgwsnwjxlWROd1xSJygT?=
 =?us-ascii?Q?Tr/aGqpF5dpD9jJyD/EWsHPoUQ4GKlWc1C91IvKb5QsRMY7Wu6aYZq2KTO3S?=
 =?us-ascii?Q?dxla3vWYGX4/hUJO2RPFxLk0xBOjcgmFlSXY5DqX3ajmyZkFsSziLNsKew7m?=
 =?us-ascii?Q?r0dCFL7IA2+m7tMJQD3WjFxmXdckAGAC1vQlHrZaGi5RiYe7VVmiB8+BFHv9?=
 =?us-ascii?Q?9RGeot2hgfh4L7xYbOorRhHCMw/TduqIHteBAHN9k+1awDUyy20lrFX69Ps4?=
 =?us-ascii?Q?FZ0Da5xTBLwerl3i/VFjfwd01X7OVYnZCDoDyoOHrb1ibXUgUOa3aPOzYObD?=
 =?us-ascii?Q?BVujXOVlAu0CG/50PXmW4hEs3v+gz0N0O/Jy/q4SZk8sGi/A6Ax262OhNBuU?=
 =?us-ascii?Q?b/k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qzm5d09xl6NBZG4HppzIJLdqguIszjWDCvT7P0VnLST+e4VfVp61UNFIXTm3?=
 =?us-ascii?Q?rTtmOcXyGPfipNmaqaab/jVfcm+LmxCMjb9dgY6cupdWldKkqDz3PMGueDKC?=
 =?us-ascii?Q?Dh5zZnyoWKWKPXuCv8ZVOZs8927cJTwwSs3QV7JBL1phPtTnAM5tWofTGewb?=
 =?us-ascii?Q?xxmB5Nn7x5hTKENEqzPBo7fZ3MiNjG/m6kMKp5kmz+BuBhomaNL3AZ/TBjG0?=
 =?us-ascii?Q?hTAevl6wvmzIP997GfSpjaqN5sTDrvaAVb5TqETjce2yq8R5BcSUzJCW21G/?=
 =?us-ascii?Q?vkDMS4HXw8PQkxLg4dQe452BeNT9HStrWrRbr6BTcnMLGIsqvK495OfZS7bl?=
 =?us-ascii?Q?3G8apHyOnRpchLE6BBT0l6zlp1pItVlIKLHLCUhIV7pbRpPTjolFbNiWXP3x?=
 =?us-ascii?Q?kAHU9hm2IqN6E/lDofn9eUNyGE25gOPrG3a17EdR4UpouMECpIo5wb/KRSFJ?=
 =?us-ascii?Q?81I2H0r9NN60cjRqgMwqwvlTKcEMLm+Ue3YKRIoUbmqQbLlELQX6I8258Xn1?=
 =?us-ascii?Q?BHUxFtwsbYedlzruVBerjv1X3GbZh1w7gV32XU47MFwA6g+AGu2qyl66SQ1v?=
 =?us-ascii?Q?5OdL6Wpg0ocnNR02bu+yAbIsybVHYQwrW6B0jDGQjHve0P6F+khht57vNMxC?=
 =?us-ascii?Q?y1j5INEzaGCcKwRPIxJ+qi0/Kis+PtU1RaHTb+yYRhFnv2cXKSht3LQzWwLp?=
 =?us-ascii?Q?aqXTjHPwERHmX4NcB2GMe1jn8WvesVM7qm9uptCAmgnD4X3areJ19aW+lEI7?=
 =?us-ascii?Q?HBD4rVSI9eiqVH/RK0wAdpAn/Yxb+xgssAJeAHmIddLzz/G7VS1klRgBh1pa?=
 =?us-ascii?Q?7lyMbDnOVPXw95+StTW76wrRGDxWBo1PfTDhgpq213F1kYgksX+mjvYpp2mU?=
 =?us-ascii?Q?M3R0v4Dto6vYl4rrM2t2oLCw/msaRdeSVzZtuyr1mHUFTeL4RlLqu0ylJJIV?=
 =?us-ascii?Q?fGXHhcYJoWHiID2BY0+oOzO7RA4+bH6D/rt7Os12Aee9xSfbFgJ9gmBx0tMK?=
 =?us-ascii?Q?wU0GCiFisMq04C3H+D61f7qqwXa7UmBF7WT17Ivrho+vUVFTbzZG/D2yU5TP?=
 =?us-ascii?Q?ueQ4i1R2ZLGS3NciGZQx0pwjzXFuB04iDp2ePuQCVI/OdUZJUJG4Se1j/djp?=
 =?us-ascii?Q?HMi8QSxRM+5cdviryu+1WVDTHqu2d9IQESlN3U5pw7EWZBmcI+18+O/ta+4d?=
 =?us-ascii?Q?EKflFaLs+uGp+p1gpx55moLjLR03gyn5ZdFdyvTtqfi0oOiR9bqRJPgK9Kbq?=
 =?us-ascii?Q?9v6PRR8BW8RHQZuLxJ+qoTpSbqJtXSw1hdl2BX0aiZBLa0e+EGnJxhZhq550?=
 =?us-ascii?Q?g2sPmqbWt15+ndJuUnDre7q8qKtkoGKwv+0UXveAZbHWzXr52c+XKQ1nTYKO?=
 =?us-ascii?Q?J0mbLjIi+gSs7vQx68OpC5U8LO1S+gIFe8k2Cn8EWNeWS9LnFNldbufTuGif?=
 =?us-ascii?Q?oZjWHMmYswSw3a9HqEpL8tlbAPAt/TUrmoH4sIV1e6IrZBjqQHUEq+LWjpsy?=
 =?us-ascii?Q?K/+HeI2S3nnFQa4XLv9fZNSNnWoxLEn+Nb67QkC4wj5VThQryfyKJ852Km14?=
 =?us-ascii?Q?Caubm7sFKAv+YO6IUUJSxp6B2wjCGg/9dB+eFaJqSRWWmIhksRBbX3QaYPFs?=
 =?us-ascii?Q?gf28QkpGVIPAmCx4owJC3NY9z8KZI/r9BP+bQeFEcd0mdxI0SI9oqmXBghJl?=
 =?us-ascii?Q?poHw8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c9Gx2M/3k5APJMrFmoyLYULKF3cc5bZnm9cKe2hJEZC7ekFoLIiNqmhl8125XXDPrJefJHoxGhYk9cg+b4GFgZCffpx8QKPxKc5BBZ4DsbASLV0PsVvT2t//aAjYeRMuYqoDLjljYGn8zxdoYdnphwDv2LUDXnDT2eEAq8nCkwh7Das1xLmyXP+rCAxxqMv2LhFamYli06PMlC3VpClH16cafZ7YAEEau9lupCyAeHfYDN6W6b5Br1Y7kRS4kjAQVs+6byn0onhLTqxVc7EnNRzYVNrAgj2tK+icddLT4rH/uMUMgG4d2Hu4z85Bk9x13TRqCFQB7fjr6ljhDcoK737wwY2uUDpIFz9ZfNAh0q3CwQxD9HRe4oNYd4lW/x5o7Oy7hGiWhkt2kzPETu1STpf8iEfhtZUaSiY2kHf26P+DWi5Ty0ZxgQplXtL6JN7ShvV88hgSbQE4qrUUUdnUtoTbIqKLYb39iN2EuzIM/62GPvhb+2JgaH+DH2iWGny4mPjnRGM/X4sGtgC2uqbbmuItQgrl7Q4Kv34sO9UA1S0i3zgCaEXtsuTZuo5IeIwaygpLbp9yUki4cf49DmCgsLrK8yCjeQsglX+SsAYPnjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa983de-3ba8-4a00-9d58-08dcde3d5ada
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 15:10:28.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E03oWH73txup22zxUxwTdSIeRK/f4fiSvky47xoQphbUCInQmGKUKjWfEfiqXSIoeTebHB+NDnZ25SmagguW6CvrGKbd4fWLJQO95t1CVVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409260105
X-Proofpoint-ORIG-GUID: yWo1eSCGuw4RVpK28_4sP2lbvrlF5jKQ
X-Proofpoint-GUID: yWo1eSCGuw4RVpK28_4sP2lbvrlF5jKQ

The process_madvise() call was introduced in commit ecb8ac8b1f14
("mm/madvise: introduce process_madvise() syscall: an external memory
hinting API") as a means of performing madvise() operations on another
process.

However, as it provides the means by which to perform multiple madvise()
operations in a batch via an iovec, it is useful to utilise the same
interface for performing operations on the current process rather than a
remote one.

Commit 22af8caff7d1 ("mm/madvise: process_madvise() drop capability check
if same mm") removed the need for a caller invoking process_madvise() on
its own pidfd to possess the CAP_SYS_NICE capability, however this leaves
the restrictions on operation in place.

Resolve this by only applying the restriction on operations when accessing
a remote process.

Moving forward we plan to implement a simpler means of specifying this
condition other than needing to establish a self pidfd, perhaps in the form
of a sentinel pidfd.

Also take the opportunity to refactor the system call implementation
abstracting the vectorised operation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
v3:
* Avoid introducing PR_MADV_SELF and defer a non-pidfd version until later.

v2:
* Fix silly mistake referencing unassigned mm variable.
* Add PR_MADV_SELF to architecture-specific mman headers.
https://lore.kernel.org/linux-mm/9cf0e96d-287f-4749-ba85-8414c06aa54c@lucifer.local/

v1:
https://lore.kernel.org/all/cover.1727106751.git.lorenzo.stoakes@oracle.com/

 mm/madvise.c | 55 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 50d223ab3894..e871a72a6c32 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1208,7 +1208,8 @@ madvise_behavior_valid(int behavior)
 	}
 }

-static bool process_madvise_behavior_valid(int behavior)
+/* Can we invoke process_madvise() on a remote mm for the specified behavior? */
+static bool process_madvise_remote_valid(int behavior)
 {
 	switch (behavior) {
 	case MADV_COLD:
@@ -1477,6 +1478,28 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }

+/* Perform an madvise operation over a vector of addresses and lengths. */
+static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
+			      int behavior)
+{
+	ssize_t ret = 0;
+	size_t total_len;
+
+	total_len = iov_iter_count(iter);
+
+	while (iov_iter_count(iter)) {
+		ret = do_madvise(mm, (unsigned long)iter_iov_addr(iter),
+				 iter_iov_len(iter), behavior);
+		if (ret < 0)
+			break;
+		iov_iter_advance(iter, iter_iov_len(iter));
+	}
+
+	ret = (total_len - iov_iter_count(iter)) ? : ret;
+
+	return ret;
+}
+
 SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		size_t, vlen, int, behavior, unsigned int, flags)
 {
@@ -1486,7 +1509,6 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct iov_iter iter;
 	struct task_struct *task;
 	struct mm_struct *mm;
-	size_t total_len;
 	unsigned int f_flags;

 	if (flags != 0) {
@@ -1504,11 +1526,6 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto free_iov;
 	}

-	if (!process_madvise_behavior_valid(behavior)) {
-		ret = -EINVAL;
-		goto release_task;
-	}
-
 	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (IS_ERR(mm)) {
@@ -1516,26 +1533,26 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto release_task;
 	}

+	/*
+	 * We need only perform this check if we are attempting to manipulate a
+	 * remote process's address space.
+	 */
+	if (mm != current->mm && !process_madvise_remote_valid(behavior)) {
+		ret = -EINVAL;
+		goto release_mm;
+	}
+
 	/*
 	 * Require CAP_SYS_NICE for influencing process performance. Note that
-	 * only non-destructive hints are currently supported.
+	 * only non-destructive hints are currently supported for remote
+	 * processes.
 	 */
 	if (mm != current->mm && !capable(CAP_SYS_NICE)) {
 		ret = -EPERM;
 		goto release_mm;
 	}

-	total_len = iov_iter_count(&iter);
-
-	while (iov_iter_count(&iter)) {
-		ret = do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
-					iter_iov_len(&iter), behavior);
-		if (ret < 0)
-			break;
-		iov_iter_advance(&iter, iter_iov_len(&iter));
-	}
-
-	ret = (total_len - iov_iter_count(&iter)) ? : ret;
+	ret = vector_madvise(mm, &iter, behavior);

 release_mm:
 	mmput(mm);
--
2.46.0

