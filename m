Return-Path: <linux-api+bounces-2344-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD99877AE
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654FD1C2281B
	for <lists+linux-api@lfdr.de>; Thu, 26 Sep 2024 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F3B15B103;
	Thu, 26 Sep 2024 16:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I/vVQxrA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uLQT4Mb/"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694414B959;
	Thu, 26 Sep 2024 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727368678; cv=fail; b=ZU4Wc7aAATEdD6wS7eowZySmsme48tM7IOWp0phq+gpkOJJDLyq0vSbwLY9OKjzQri53V0Hk1w8Na4t8du8yRdp/kOdj3AmyVCVCXlKLUADZP5uM9J0qokye62k/M9IbeEJZKadbr48kzL01VUrRKITC4ZstyrYF6hEuLFKAhAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727368678; c=relaxed/simple;
	bh=7IhChAUkQ8I+1riglDVz1qcIeFQKRFpiefUufrx5l80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pXJixCNhqyVBtt7phJ/rSevDJNpmyafN2leuuhSgQLYwzwcHUTqV4Q5SJT+Bf7OOcszIcNrjARnukwZ4zNF5ePCdTR/aMkpGW/75UgWwaQ95vpB8ioxMvGTYFqn4L6hmtAN5RSB+mWZ2zN3R3fpDjWnYPJaJ5VNXjuNFyhrTnM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I/vVQxrA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uLQT4Mb/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFibv6015212;
	Thu, 26 Sep 2024 16:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7IhChAUkQ8I+1ri
	glDVz1qcIeFQKRFpiefUufrx5l80=; b=I/vVQxrAHgFQSG4Bt8PPrPKLAPTFePd
	+mH4dnB1LgTUX2AThIgkx/oCd8Dzist+H6KT2rKU5VFBSVnXtdHpELB84T3qZDaW
	w5WfxMF1GTXyZTQyOgv6Z5nSBKoBS1dhKAxb54fsqe9D7VuJUlHspQrgTUNmGj6k
	uB02UT0M2t4rw5tmsawluDo+EOUR0N7M7I6CnlEPt4XeIk9B6o7d2LvcrIoABdA1
	ThvJpobwnSGSHR4WwyE6FQeL9M/d7hkPKdX7gmAQYGHs0Y16krxVkS0I2iv4B9t9
	pIKJKCGaDsw5LAF5pf15z7PAgmMGqMpcIyYZxY2carJMZPCjhuYtIIA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjdb2ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 16:36:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QFNkd4032475;
	Thu, 26 Sep 2024 16:36:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkjqpn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 16:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkiePwffnkRa/DNgfABYtwcrkYgsP34s0SjCOEiBi81Dn+8h4XQH7PfkmOMckWPwRrRLl9+tRodtEU76YfaTzViOxv5892TGM0PO5MkT4h9jroQ7GAQ/8Zkd5SBtkYHS/gg+Tp8mKCKyDFVlRAOknw9m4wwAMKdUkIaaT+HOB7+tvjvaCOkwjrMNHrsilGWPutDs6k4xD5xZseeZwPKeECEAW1mBFmvA5vT614roitYAbnjPyNbHIPGQQgcyH2bbsMUO7oPichpXxVheYqrB66aTe41PMWh+S9hs2qABv0P3aoBmaajHUxJ8RscknxMegMsZKd7VyAyQ9eUjEisWyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IhChAUkQ8I+1riglDVz1qcIeFQKRFpiefUufrx5l80=;
 b=l2OFTK/Wunr8wEaaBQ3uPao3Z36JVfYGbcZn9s0CU8qHkoyeO6zHlYUCxFVIba+zAo9mKlAUTmYKKWi/UXzWVztAP4UboZcVoWO5EEgxcNUZwclWZdP/D9pyiNwin7PYSZIRSuQsCM0N6tedc95TK0uoO85hx38mlPNSS4hvHu+k+ZAsFcKJtRorX/ASUdBnoTgSFXxNT5y1cAKitietT64l5xoSbLelByQhZFE/AZBx0RK4tvx/afiIAMcbLLf24uCshY/UT7wsz2PwdoRgqPtrunLPnTHJXd740bdjQQZhwxeEXwQA3HPCQdH06wZviyVYuVsUVwo2Clo91bdJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IhChAUkQ8I+1riglDVz1qcIeFQKRFpiefUufrx5l80=;
 b=uLQT4Mb/dXIeN00xpoI0Bv/HfCQoguErrQOti5tIPXKSeWtSKMvYn5lNtiLdvEi6JaocwHnbRr7mxJ+d34LBqKVXWZn9uDawUmeePjChRHqjWaPz9hr9zgz+01NTXtZrGHshuQN/BlklNvhZ4srIeqmFmZlMMdgKcLBxRFBm+HM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5124.namprd10.prod.outlook.com (2603:10b6:208:325::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Thu, 26 Sep
 2024 16:36:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Thu, 26 Sep 2024
 16:36:36 +0000
Date: Thu, 26 Sep 2024 17:36:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>, pedro.falcato@gmail.com
Subject: Re: [PATCH v3] mm/madvise: unrestrict process_madvise() for current
 process
Message-ID: <b04ecc20-3bd2-488a-b8c5-0599acdd0828@lucifer.local>
References: <20240926151019.82902-1-lorenzo.stoakes@oracle.com>
 <xv5qg4hfqvqzooounx57hzl4jzmfefitf3qklcdqzz7a4dufxn@v3r47r7p6ono>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xv5qg4hfqvqzooounx57hzl4jzmfefitf3qklcdqzz7a4dufxn@v3r47r7p6ono>
X-ClientProxiedBy: LO2P265CA0227.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eb42a77-4abb-4b8c-a37f-08dcde496341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y/DZrAholeuBzr67JROa86/DF4bXg23X6GCYOHm3g6qYB2Gy8gCfu5JyFM08?=
 =?us-ascii?Q?GIi1WA4xQhpXV5L+J09uZ8+pVwVJS4Ydw5R01REreiFBqy18njeZ10xD765c?=
 =?us-ascii?Q?MAc5oTccdc8iHVKE1Z1khrW/YH1c+K/3h2/qPmCPV5kDBN59Tdn+CNjLfRKl?=
 =?us-ascii?Q?gZEfiEBMGmDiFzr+qg32BGBr5RGL2cxsGYB16hGwzhEdFrQ9HZLfqJXCNxvw?=
 =?us-ascii?Q?L4FDzzrmBTTWX9Ilcgy8w5yxdVLDPE1Xw74glPaXmjf08SkQUptQR834Sh8F?=
 =?us-ascii?Q?0lSXwrPGUYZsXpPj3QTe8X2bkhK4m2paaFEVv0GYtNEWt5+XFTqXpDqxEFta?=
 =?us-ascii?Q?P1MPaT/dT7tN6LwVbIq8VZyEKbtnOKRF9AjRp4EIjWgmzAmTsLUXKTUiMBpO?=
 =?us-ascii?Q?0DFVBevQbwY/rPMjOZuvsHT6woEcoS1beIxLpQSu/QcCc2asG9TQ2GjC0dka?=
 =?us-ascii?Q?1LALOVD5u9ge1lGsR9LG9KSxj3oHtXiIbvtBmS7++LD1poOf6oFsCDsxtNEt?=
 =?us-ascii?Q?y6mN7qiw6GANKK8thO7MvJEwfdVe1zJ+cvC+uYmZ1XZIzXGahT6ttCLnXNni?=
 =?us-ascii?Q?v4JMJ1yWIZEWU/KaBsE1abc2x1zaTKMU4PmRq29WOAKohK/RWM6Yn/+qEyaF?=
 =?us-ascii?Q?qL9hItmaXshTzXdN7pqJpcNf2mkkEC6E7RY+OG84DDRfFKyne6wEBSJ84T/j?=
 =?us-ascii?Q?bHV7xU+HYq55nUXWbRjdyaBrsokmmPh1hcbHwARvZTXVmUOacNAdN6ipjI0l?=
 =?us-ascii?Q?oWxwJMfoYeQKE2aAYE1HOmiNnZYileSQnDG7fkB/rODJajjxfoIkyGtyiwdh?=
 =?us-ascii?Q?k/RIHNImYTJ68wsOjUXsWXSVY/98tB1thGU4ZD/oFiLSJbyIbkdFb46koUia?=
 =?us-ascii?Q?MvK5/uTwDNMuKzzlhxr4ZMI6vC6oV3JOt0KeeDMDC5bVNvg3OWgI/kCxf/r9?=
 =?us-ascii?Q?7x11ekJGNVvGF2dSYrPK1kIs4GKUiabhoNu3cFuo0CtTet6Gs+uwQSEcsy9e?=
 =?us-ascii?Q?3lIDIKL8I5ZogQsxc3B8HH9gVzeuk6e9LDrBDLKkjR+awG/lPeqnuOKrJVbF?=
 =?us-ascii?Q?1anKwxLaNCoej6LgUrqjcrKgh86wREg38wsskcucNtA/P20t6QilhDIKJuV8?=
 =?us-ascii?Q?deSK31g9Xk7QiH/mk1amZpElk+zXcs42xbVnfOAzYqKO7mkyyMk9TDJwAGGx?=
 =?us-ascii?Q?AB1PYHxs+L1GcRYE1ulz8jPet7RIs9+jq5TvqxcGmiIzq8QTHc54v/gopO/N?=
 =?us-ascii?Q?JO2x7nUx+BrG5czPqQp7WQnxWViV36lNI9ni2ahcARQ3reGWGZbZMfrBrQcP?=
 =?us-ascii?Q?vbR1v6/DcjKhR8NO734wKm364pXjUaVwV5ve0ZbUXEI/fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VcfWnYBrj4aocrdlXODNXCBTAiRFfM9WG5ddJZE1zrccprRWWqSFyMTmChiF?=
 =?us-ascii?Q?4bSlw3XeQPTANyx8Aln0GvO3q9R50ZI+rAJ9fUwpRLlo2FFN1GhX57Ac1LZQ?=
 =?us-ascii?Q?z4+1fXQOEY7NSRTqvLdLMJtdBBk/lzoCHFkgyV6SurS5uCrmUzxUJyqYyfzk?=
 =?us-ascii?Q?pYCuqc+r+yW/usTzU7NWRdVY1ELwHQ7ScGmH7DOnaCx6QgHwWf3vne3DP086?=
 =?us-ascii?Q?6XwZmhpdH4ZBMScy//ItMNGB1KzIrCQMdyy0Q99MHDAuF4lw7V730iTUebgX?=
 =?us-ascii?Q?KLBeHrNOEct3QMTFjuWu0IAiEC7FidPOk+4jDL9GhFBDvqJZ5xh98rs7D2T9?=
 =?us-ascii?Q?BNljpe3zH9yIuFGaMtNJYVcQdOi1vWtM18Cz1NTbXw3FduG3K2LZYvJWO+su?=
 =?us-ascii?Q?kSaUruqu5Z+EhXCeHanL1JXddTBba+W2cmw6UhDHRJ/ectnylVP53lXLqKgM?=
 =?us-ascii?Q?c5GS7mbMeCqV9EXVOZhk4dQUhsp4MZWCuMAqUe6tsd3glNdORrVzeGLSmwfz?=
 =?us-ascii?Q?I6U9b3PU2VfXqSPuhR34twiTnn3hXkjHC6/LBTDYmZv2IsEyfBbE/NcWtC5S?=
 =?us-ascii?Q?xwwLoYSEtjXAZCHbrmmIIM/N6bgmRgK77zNgB4D+becOL3SghXj6unEnJ5LX?=
 =?us-ascii?Q?BUB7M/ch8GVDbCIPALajekbOMjC2/ydHciUCz/DK2V7+ig6eGMKXUjPBGZ33?=
 =?us-ascii?Q?QsyihkObKsxrZARbh2UXSWAaYbtuA6ZxU67eXignqeFe1+PftBwjDxl0Ehrf?=
 =?us-ascii?Q?orwMcFtpU5wippNO6W9oivfeK2juFVH8D2sh2TdePcnuTVC5UPObQaBoBirW?=
 =?us-ascii?Q?rDIisUmmnBjBUjdzJuMApBT+iqhbIAZCma5mNGqv3yCix15rkpR2+Cv7gMAx?=
 =?us-ascii?Q?o5l2H9MsTRSanqjtaPD2JEZFYMO98v8kEVNLOT7+brUvrfZN3u7g2baktyG1?=
 =?us-ascii?Q?HXDLlCkLN3nOFQ+jYIrDkeN+rHqi1JoR4Jc3S7VtlCU9521YL4UR37vFoZGX?=
 =?us-ascii?Q?ieauYzU1JsmjbBNAG9DsNrt1vAq4zDHuoqpcH9zJMfx1KeAKiPCWGAfDIgUI?=
 =?us-ascii?Q?cTpna7yAwBHNPSxoJ9fFaLSi3G3sKFrvTCm79jU+i67ri/QPBlCuTAEEFeOj?=
 =?us-ascii?Q?z9llOZv0o9IJKAIR2OjjyR0DcBDa0enqRdwMBZ648LkSRyRaaj+Lb1Izh/Ou?=
 =?us-ascii?Q?ucV1lYlfzUviNz8Iv4Q9bgFb4Js782mc05Av1RWg7ZRKDr6NdImsDYr0YrD3?=
 =?us-ascii?Q?HmqsEop1tB0MBvwlJ8RepYZeO7NtETSRaI59junMfIbD5dkGRxWGY3w0WE7l?=
 =?us-ascii?Q?lAFAfcqcPzToC2KfC4uB8+kaEcLc6wd/cAeCvO+jgSqAkGp7RG/FNcovvMdf?=
 =?us-ascii?Q?TWjgoMTqu5btrgPvyvI+Ul3DYcUCCZCfycopbv213E7YRH3lnlVRmoZHPY/t?=
 =?us-ascii?Q?3/LmJ5VJ45WcAUquspCwd2cjzCJU4ykI3MrZWNEZCPsv29fQ9C5rNGYVwDmu?=
 =?us-ascii?Q?xXKKjgfoqs2GTFrbAXY8xGQw19Lqb5qFu2xIlkj9oHjLAM1xkOeHxRNSgBE/?=
 =?us-ascii?Q?+vPbYfMHj2QrVNDJec/agftbm+Avx67wb2hybfI8XaGycc6QqaR8pM/P9jwy?=
 =?us-ascii?Q?F5SoVRdzcMgox+/7EjDUsH3vMqK98VX71fHnF8gzxmOrYol+PFc0OM/XCyHf?=
 =?us-ascii?Q?hptQvQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eo8Okd9C3fqe3/n3M0hqssvHiz+43nrHOTov/iU4mzgG6beUD9GtRnOHi/cyQxPcHFdW1I8VgrXXfcMzAZEtCuWEtj+0uFVjy8jq2qUu0QutxldCBGjiBPLhsQ7/xdkRd0EU3jO+0gqM/ZZmIJgo7i93uLJhZ24IBXe048biV5BtcUZC7az4lnfB+B1+OMPeqRRrazsGG31GfKZwPUVPdAQmGDufOqSimRwJO25TpNocqbWB0q2WGiWzask7PXgsj60Uzq4z/oKEP9LxYgRlOwt5EQjw1BmnHL7F+j6U7Lxi2MTttgk+omxrCapVLgsN8Zg2GFi3eo+b9LVfohGSVSPm2u2eChZFeH4oFOBbYl66+ijbgkU2RiRsPek6qqj9cO2ancKkilpBHjzAvR4BzaWHWy1rOyWzUdi/vwWBHArpsozAebvTBG868Gi0HivfBGGaD7UieUpTPeGZ+FUVyRL973dlRL3a+/uENvOWebuSNW1IVOZfSS55tIaGzPlSb3IVSz02WYnmF60Tto4KJcB78eeC2Ncd+ljbmI2qVyTxZVYNx7kpZaFRGZk0hZZE0hW9bZ3db7jD3g9or5AAGjWtG11fMvn+spNJAE0H+PM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb42a77-4abb-4b8c-a37f-08dcde496341
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 16:36:36.0071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFwcX1hoJFh7iuTpL4+94cmZGe+k/AgzSA/UDsg58Mb99h9bd3IBDUBossNDKaZiFMB39dwrAGJMn9Ap3LUh3aP0gORJktphkM/NIBHeqWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409260115
X-Proofpoint-ORIG-GUID: 0v5iJFPlj9ob2XLv0T7QwNsl-VqQfd6B
X-Proofpoint-GUID: 0v5iJFPlj9ob2XLv0T7QwNsl-VqQfd6B

On Thu, Sep 26, 2024 at 08:52:32AM GMT, Shakeel Butt wrote:
> On Thu, Sep 26, 2024 at 04:10:19PM GMT, Lorenzo Stoakes wrote:
> > The process_madvise() call was introduced in commit ecb8ac8b1f14
> > ("mm/madvise: introduce process_madvise() syscall: an external memory
> > hinting API") as a means of performing madvise() operations on another
> > process.
> >
> > However, as it provides the means by which to perform multiple madvise()
> > operations in a batch via an iovec, it is useful to utilise the same
> > interface for performing operations on the current process rather than a
> > remote one.
> >
> > Commit 22af8caff7d1 ("mm/madvise: process_madvise() drop capability check
> > if same mm") removed the need for a caller invoking process_madvise() on
> > its own pidfd to possess the CAP_SYS_NICE capability, however this leaves
> > the restrictions on operation in place.
> >
> > Resolve this by only applying the restriction on operations when accessing
> > a remote process.
> >
> > Moving forward we plan to implement a simpler means of specifying this
> > condition other than needing to establish a self pidfd, perhaps in the form
> > of a sentinel pidfd.
> >
> > Also take the opportunity to refactor the system call implementation
> > abstracting the vectorised operation.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thanks!

>
> > ---
> > v3:
> > * Avoid introducing PR_MADV_SELF and defer a non-pidfd version until later.
>
> Seems like a good plan to decouple this patch from PR_MADV_SELF vs
> PIDFD_SELF decision. I am hoping to see the follow up patch as well.
>
> thanks,
> Shakeel
>

Yes agreed, this gets an important part of the change in, and gives us room
to take our time on that side of things.

Plan right now is I will work on a sentinel solution in parallel to other
stuff and see how that goes, if it integrates well can bring it in in a
separate patch series.

Cheers, Lorenzo

