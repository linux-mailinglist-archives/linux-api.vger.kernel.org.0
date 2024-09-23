Return-Path: <linux-api+bounces-2322-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433A97F137
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 21:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8FFEB212A2
	for <lists+linux-api@lfdr.de>; Mon, 23 Sep 2024 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E9619F42C;
	Mon, 23 Sep 2024 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fb0o4OWR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="neoJKB2w"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2651CA84;
	Mon, 23 Sep 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727120120; cv=fail; b=mkmcSLwPKlUmBia8JM7tPbIfX8ujaJmcMuVOCbuRMEytm3XF8FC459EgPUwFOIAFQHaTBEaTAdoTkoSyTHJD4pXc2FOjt4FR2pcetaH3XOcFRZQ0+kWQEVR5SkTxIpX77+QUGlHqV+I+iXcbf/9R7s9fLaqRSTpWQfvZLdyHbhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727120120; c=relaxed/simple;
	bh=Z3xOT2lJTlMfAAnxfyj7E8xA/XhHolQiAZNyKR4nqiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ooWVV+vrcQYy8Wljp6HbCJsQy6sxiUyDm1UgmZQjN3qiIcv6Ztnma8IWk2LOht8y3POFUmGdnbnexk/6rtzP7vn+8aqlUmUCTOHU4RCe/r13/ec6ZTo+nhCt9f6oP7u7WErmbljtKvCT+95/a9xKoqPzORAJ5yUpR7DANXhsJ90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fb0o4OWR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=neoJKB2w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NIMYkA029675;
	Mon, 23 Sep 2024 19:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=3ODAXj9vw+4XTX6
	d/Y2WlR6oeXfr1gvNn0z49dcmGLA=; b=fb0o4OWRdRfA2FeGzZ5U4ttO8EyJvc4
	ooqvChWORBKj0Ul3dm0k8r9WN780rI50qSkcq0yoI2hy2wljNuVUfmnv8ctfJcJp
	6D0l3Rzt1OJvAPEDAUt7ePt87SXTTxf5e0YvisHKJcvM0dN18FiZouwmUUy7zpQ1
	gswZJ9Rub1DaxW1FUjq57K0Y5ogNkX8gxFFDFbggV07LR+KDpqa5J3cFdAxEXNxS
	1W/FRWDlXYl6kcXsd2VN+vgY6E4O02cXUtMEaZLme+F92bqyFvgYRH/Rf+aHyTpd
	A8VxgWDW3IMKBKsxEvAF3ZhzN81CSAkOjMVuL0nj3O06kthIs52EOZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr15qnf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 19:34:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48NIZRA5004826;
	Mon, 23 Sep 2024 19:34:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk890f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 19:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F60cyX6zFEOJFORwzLn9SCEF9q5UU0yMf6Dp9h51OYaw+xN14Vbp/GiYy38nrukvWwOI3VMUQoighm09FUAeFt6hY3m1YyLW4yvQUzjckhcNKjL1oHVsZB/77GcZ2RR99WLkpy3AA2rlF3a+FTdPeJZ7xncXF93Y1vDmlTnitIVdr1z/CHH/Fn/pQVNJM55eTJMdhl4K8akdZILkj9FMdTIlkoqsmR96tmC9gemh4c4QL+Uo7EVx40ocbS2xaqkrOUJnNS2QUv/RIhMraUL17B8eS2vXquhgZg09zF7Bib9sOkT9QN5eeAvBxzl7Z9UixTldDAWVrpG5AKWRDHzTTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ODAXj9vw+4XTX6d/Y2WlR6oeXfr1gvNn0z49dcmGLA=;
 b=IGUnQrwyDUZAQSYdNhWi5u48eYRF4Ep/sAJ6MsWVl34bV8o1Bb2J4RVS1nFY2BK/aMMqJG7PakPR6lKqNHLlWIaXdeP1o088L8gOf0N6WBHgnlaV5CmNDJIv27CkJSLOhZyAHzjrJ5TlCQiH9QAkWobWiKe4hjrtu/fKb4YRfcw+/bS7F3ne/947QnrerDyv4pjXvqEgbesWgxPUEsZk2eOwjz1TFHKFTHf8JcsylrNY2taXZ4WjJBiBEDF1nRC7uvfYzD1LrT3I6zSf8FioKqHhaYXvm6Ngu9Ch/VVcJoUpj1WprnxLd0Smku+R14vTJMw1WEX5Crw00/nxo7Rljw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ODAXj9vw+4XTX6d/Y2WlR6oeXfr1gvNn0z49dcmGLA=;
 b=neoJKB2wW72rnyXTLNJiv58P4C6cb+hNiA2P5lm77LJyFgOP329MS2pDIEalDY24YsaitebTpKDryVI73KCjq4GN37hjDruLi7xM5XQT+94Jph5ObMtpeGozQDaW6b7FBX+vI7ONu3LqY2wC3WZAxNiO+GBU7fER+NeZLbg0Y0Q=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 19:34:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 19:34:38 +0000
Date: Mon, 23 Sep 2024 20:34:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <c44d373d-d72b-4e62-a613-a746a2c290e7@lucifer.local>
References: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
 <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
 <njjxbroy5nvn2gxmvsvk7m23rrsoyih24nhmbmf7lpd5yzwwk7@ijudgtbiwyq6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <njjxbroy5nvn2gxmvsvk7m23rrsoyih24nhmbmf7lpd5yzwwk7@ijudgtbiwyq6>
X-ClientProxiedBy: LO4P265CA0149.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c2c515-f8eb-4176-f149-08dcdc06c355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HqMzVHIw97aIib8oS/+NYouO83uMM7OvZGSKUzAC7JMPD17paj1+f2nPHx9Q?=
 =?us-ascii?Q?Ve67XApn/izL6kLGBrWxcuBtIPAeR1ACON3gMNeWcmGyRZ7Z6I1SpMTuq2D8?=
 =?us-ascii?Q?f/hkiv8WFIOzxAZSrPjymTDh0ga/NwimhLNCAiYp1oKwS5h/NG7gXK+xum99?=
 =?us-ascii?Q?Q5O9MCtZQOT3RbFjZymsalgNRLrqQy7mTo5dfxeHr7NQTqLiepQzSC8B2MdX?=
 =?us-ascii?Q?Ckbhv1rHaCrQHNN8mD2EBDNz1jPFpBBbWPRznt0v9HJuQWjmowPpVKFOZ3Z8?=
 =?us-ascii?Q?wYj0sbtwGv6Gzb6Z2I/byGlkUEPOZKPsJZTTT1hBNq5ll6T8TueA3n1qXWXI?=
 =?us-ascii?Q?81NtwMSQv8llAq3XPyImYfL3AiaH4sWqeWw+DmAYqMwlDfOmOzaGvmVcMCPU?=
 =?us-ascii?Q?LeNW+WML1cAgYETBZ43JWkqlVx4b6pGjCppE2mBGQ1yHQrHqzRCr0d/3D29Y?=
 =?us-ascii?Q?QyS3b2zecMYDvFzD9D4sgf6IsJZuUN1nRNNHEw7pzhMJLBFLVQL2DwUVURqY?=
 =?us-ascii?Q?cPUYFeMko4x9Te2qS9gwkQ/3w3qx2SDi0oNJIw/1lUAjoYD4scnN1bciL8ld?=
 =?us-ascii?Q?xu7iZYqFhJg9cFvFNA+zTUzuWmum0ksjI+HuZBD+GoPELuLPv7OHxcDtu749?=
 =?us-ascii?Q?Dq6lNSW8zyF1Xr5NZc/HcUpdmvRwlShVLHpXKPB5TXjhwQ+WB+9FzJvih5a0?=
 =?us-ascii?Q?LLjsE23NNpQK8S2S23NjoS1DRX5znq0viV7Q42x9BpU3BKNe0tbdjXqmG9JK?=
 =?us-ascii?Q?rwVkjJ6RPubMZfg7t0Au99Wh38+tl3/2fXKt3jBzuEe4aK+21tNPd6kbP3lb?=
 =?us-ascii?Q?/YYaYXrzPXe20wYH5iX9xE/vFj+bmlmH4nOyc5xD/Cn5aNtq2HDymJV10O/f?=
 =?us-ascii?Q?RMdsAyQnLXSjhzkER2hp8c2EfZVi1hK8W9SNe/Q74rYVxxTqE1WI0XTE68vN?=
 =?us-ascii?Q?paEtgiiTre59ovU+uGjxYWipdt4p/TRcTuP7L8IVz+dlL9UH/lb4tVyp90qx?=
 =?us-ascii?Q?FJXu7ILkFCXlDiqtcpWiGVqcdQrTEbYxWTfEzhVpBFSG3QX/Wbgbh+nq34bk?=
 =?us-ascii?Q?d61dB/YRvIp2O0WNa+5NmqwCK3KcBxz0trVpcwFxBDwgB90VjP66m3jcAFvQ?=
 =?us-ascii?Q?rYpV0ouCEI0KQ/C/ZoobW7fUsqMrFANT0RFrIbSTq8S5UQsjdF7TZeFNp/hv?=
 =?us-ascii?Q?BVZmUjC7ymMtiSfihtCXg9WAJnqe2g0Qod/ekJqsdGJGkG9FwEL2z08TS4Xk?=
 =?us-ascii?Q?M4niQu0l7D0MxxK2AMml3D2PqM7bReA5bcM+bhEB5g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PU6nw8QXed0Q8T6sMmzHhpJi8gPekUd5u62xILNqUk6goCTZFCzrxwnEXg5O?=
 =?us-ascii?Q?a3ATZcxjY12yuh9qhMbNuW/4wwzmD+e9zvmqi1aOLpw1Mm8EDQZTOUwt3miI?=
 =?us-ascii?Q?06UPIUKRbRZKpJT5Pg5CyG9gJPEXoVf6DGsJ+XF+2CMXaN/y6SGXH8KU7Sob?=
 =?us-ascii?Q?3cndAuy4pcBVmhDGluA8VWKZJHxSXoLuGzAQKLFyUtScuWJIIjXMoTTBzPeB?=
 =?us-ascii?Q?zlOLC2DE8DrEaAazkclAeslcOoJoBi/BISJUkUWM6K0N9JhzufqhuIcKF4t4?=
 =?us-ascii?Q?ZNo3VYD36mDd4krISSdhFaeUiI7gvS77xuj3KyKdJyc1EIVpngU/9xzUO8IF?=
 =?us-ascii?Q?wjQ6SLMlOVMiQIJmesUXWM0FoGv5A0Bv9rR8O0XFgR+rUmzo2DJg+aHrq+R4?=
 =?us-ascii?Q?/H2lqDU1s6AM9oNc3TS76jlb1LH813YB08Z8jZLo/6pJENQpuOaxrU+Z1yzO?=
 =?us-ascii?Q?7VhhEulPHrZxKY0/EhitqFWJooA6/7GYlGjiiA8v+9JRSU5B5QME4YOZES43?=
 =?us-ascii?Q?cHC6JTyezOdjYnbBx5KTKq+NXz7/Znj53/RebmNTooWilBRlm6E9wgLpEMVu?=
 =?us-ascii?Q?xhkWjMeH8ul8xFQX1lEwVvJb/eFzEQgKnQWysewubCHDpjMT9as68bivGPP1?=
 =?us-ascii?Q?LFimuR8HxzGzH7YFAUrVZbuVH7vGlKMcYf4FhePC2qOvpPtUUOMW/BZXi+50?=
 =?us-ascii?Q?M87ez2LqnN6RrjeybJtowg6gEvnuwz43S42Kz7V0wURFvLbFlvzQB9rseFNN?=
 =?us-ascii?Q?v6slSf18J4RxCxaXofWFGQRh+6mFgqvopnOnrhUdUnJl1WftCS3mfPEaUZfz?=
 =?us-ascii?Q?Jy8lywB2/lu1N2TADKKESuEWITdh14tbCDnnqW6h//yPvlfIZXys1osBlrIk?=
 =?us-ascii?Q?3KybbNiGWwLn07s00v2MaS2YNC3iXWS44hqEO6qhgWl5+iYUuTGUg82+/0kj?=
 =?us-ascii?Q?kl2/uQVBbwx8wWZp4EumTvLYz4G09PfoeGK5h1PIOFwBZvEvrwVM62W0tPSY?=
 =?us-ascii?Q?Y890WJtvpyCtjkG9BdIVIhd91iWnHy22Kcq2wG8Z0k3kQ43WqXX2HZYxWIPp?=
 =?us-ascii?Q?Jp9dU/aQfZJRH3M9fscYUyzz+s3JYinQEpD+ssq/lmYn6uY3Ben+hB9A0vPT?=
 =?us-ascii?Q?V9kMYWDNaEF93hE+earun46ynro5nfnAfqsgCdV/NaSwZsyVgCFaeAcn/6AY?=
 =?us-ascii?Q?u9Fznw9TdMsYxaiQi1QL9z52e2yO0/+Eimgdva+3veHyLO4yed41Sdaoflq4?=
 =?us-ascii?Q?BuMIlfkz5pcHQg9A3Wd3MGuGb8v2uBECnYQm9lT8lg7ezdo5KxGWf3m648u8?=
 =?us-ascii?Q?U7Yt5RN1sAg468/K6PVTBaPqo4bOD15UGekBST//E7PgUQy9MyCHbbGiqO6B?=
 =?us-ascii?Q?zkqFvx7a7CaHVtr/VVIeq2bGC8L5Pmb+v7EH2VPyP/YAMraRvHdGwroR/3Al?=
 =?us-ascii?Q?l+9gveuL/cF7/NHAP1r8cwqX+zg072l9Sgh30mOZuHDeOMkErd7lxAjXd0jd?=
 =?us-ascii?Q?XzLXzw4C4rXCyYjsE9XjaLywtbgIFoh22ZkIO/DWBs8GRVvAFR+jWCRHhV1J?=
 =?us-ascii?Q?J+u54PVHHXgumnz/pwDtjdKE+Udueg1sm1g9gGi9PcNB6skJEzX5l9bG8f9u?=
 =?us-ascii?Q?bXYPRZfdz966nLr6rkTMmfGwWu6Sp7Y2/DECrejElsFc31AfEwCFaGNGl9FN?=
 =?us-ascii?Q?uYIO6w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WRdNQOj0cW8au7KDiXmeIbRAIOFlSf78UZZhhk9orxGLWJ59nHSIwvzKIjzkYy7bXG0c+bFVs+ALADVp5usChHDcB3IOigXgKYjzRoNa4rmnMr3SHK2HrUiK2zaMiFtQYimUuDfgLaZuHdR6LtkLOQp8Xas7VNvPm7bxgefv5XnE6t+LdZpcYID0C9lbwlEJsfRLD+zrOe1SLpSTXwOPNMLMBKjfE30F6m+uyvLYz9MfOq4Yp4g7jsOg44OmKobQMXiDpqoQmGqzlgMcJszcRhLYEf/ELo8M0JU5bpjTzdBpzoSDdvkBaPUajHUCIDhnwgdlMwk8Ec5xzYDB989j0lu7R/b3J7WpaCZ0gQcqRpb6nl80OE4en7UPtKxFnefRlkgSjSojPusE+7b/kcHrnE7ga2lbmWnrgZD8sD3wYyWQ8ruLPAaEoeXTKRARcamClwbTLDr1v3GkQvsFVfTRBiv4n+Y6P5fjLt/NsDfkBRPSgME5XhglPk+H9SSfr4ZgrTzzaOsquoDhtCVn0+fLk4WJMQ8skIVTjD0+eVUGzrctQaOz69tu79Uqq0rYsuAfRtF5YuDiYBQPzbFzZrnW1Sb07dSc+pcGiXolE3lBhHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c2c515-f8eb-4176-f149-08dcdc06c355
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 19:34:38.5754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gI8YJ1F24hV7cc+XsGZbHHJW0jcm0djfwy/mbQhpOrqAUWFMHMsLFOD7b0DiyEghnNmG/PNeLVEQe/s1wCddDxJOLW3lZ0miNq5VWKg9+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_15,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409230142
X-Proofpoint-ORIG-GUID: d3ebtedczHmlb-RbTjO6SwPE7BEb9Mb9
X-Proofpoint-GUID: d3ebtedczHmlb-RbTjO6SwPE7BEb9Mb9

On Mon, Sep 23, 2024 at 11:56:06AM GMT, Shakeel Butt wrote:
> On Mon, Sep 23, 2024 at 05:03:56PM GMT, Lorenzo Stoakes wrote:
> [...]
> >  SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >  		size_t, vlen, int, behavior, unsigned int, flags)
> >  {
> > @@ -1486,10 +1509,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >  	struct iov_iter iter;
> >  	struct task_struct *task;
> >  	struct mm_struct *mm;
> > -	size_t total_len;
> >  	unsigned int f_flags;
> >
> > -	if (flags != 0) {
> > +	if (flags & ~PR_MADV_SELF) {
> >  		ret = -EINVAL;
> >  		goto out;
> >  	}
> > @@ -1498,13 +1520,26 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> >  	if (ret < 0)
> >  		goto out;
> >
> > +	/*
> > +	 * Perform an madvise operation on the current process. No restrictions
> > +	 * need be applied, nor do we need to pin the task or mm_struct.
> > +	 */
> > +	if (flags & PR_MADV_SELF) {
> > +		ret = vector_madvise(current->mm, &iter, behavior);
> > +		goto free_iov;
> > +	}
> > +
> >  	task = pidfd_get_task(pidfd, &f_flags);
> >  	if (IS_ERR(task)) {
> >  		ret = PTR_ERR(task);
> >  		goto free_iov;
> >  	}
> >
> > -	if (!process_madvise_behavior_valid(behavior)) {
> > +	/*
> > +	 * We need only perform this check if we are attempting to manipulate a
> > +	 * remote process's address space.
> > +	 */
> > +	if (mm != current->mm && !process_madvise_remote_valid(behavior)) {
>
> Move the above check after mm is initialized i.e. mm = mm_access().
>
> Shakeel

Ugh, sorry silly one there! Reflexively put that check in the original position.

Enclose a quick fix-patch for it, will fix on any respin also.

----8<----
From dc09e0edf1cf71a89cc4cfc3ec73fdae3c2ab86c Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Mon, 23 Sep 2024 20:33:07 +0100
Subject: [PATCH] mm/madvise: retrieve mm before checking

---
 mm/madvise.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 549b36d1463c..49d12f98b677 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1535,20 +1535,20 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto free_iov;
 	}

+	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR_OR_NULL(mm)) {
+		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+		goto release_task;
+	}
+
 	/*
 	 * We need only perform this check if we are attempting to manipulate a
 	 * remote process's address space.
 	 */
 	if (mm != current->mm && !process_madvise_remote_valid(behavior)) {
 		ret = -EINVAL;
-		goto release_task;
-	}
-
-	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
-	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm)) {
-		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
-		goto release_task;
+		goto release_mm;
 	}

 	/*
--
2.46.0

