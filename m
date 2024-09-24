Return-Path: <linux-api+bounces-2329-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F7984453
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 13:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FB51C20A55
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6975916C6A7;
	Tue, 24 Sep 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFDys2Zj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="L4o9+Pdz"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846BB1C3D;
	Tue, 24 Sep 2024 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176649; cv=fail; b=mjULPO5tJlMqtMKBNibkmg/bA1w7scSqN4Y77hMituvNdFczgGjifK9OiwGkVLt2xuUAi2d2CaAGGZY6zXijwMku4aXmuKQ4znvI56H7j1iPsAOwvTYc3gYQxg361OmjxNApR2EkFEfazl83XVQR2UDhjnmv0fJ9oFaM010EHdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176649; c=relaxed/simple;
	bh=pUfvOoF1p6uhCB0CcISLddLQE++Zatt67PRDsD3ttwo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=b3FawmzVYcT/wS8W96dl+a+Kg6Ws8HFE+88i0B/A17dm7poLQIDVnt1TzNS/VuIcvYcBRqSID/MrEuGnawmxhJkl/SciBp77f/yfYxrTeGCnK594fXcegDTtp1B+CnAa833ODuDTTBxogJXjnZWDayil3DyEst8xbAvyWrT+GC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFDys2Zj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=L4o9+Pdz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OBC10c013368;
	Tue, 24 Sep 2024 11:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=nDG2cqr1qAOTFG
	Wh+0o6e43AVy8HKK7pDJvhtKBfPyo=; b=EFDys2ZjHmf/K8s7iTirfzB5HXRrud
	IO2hOmsHX5E65YQ6zlkaWYguSoaltEnO16jRqjxTD3ojtm18FqCAl9LeAbLKbhkm
	IPDpb8M0a1dwz2hJ5WXQevAdoFcyqs+DRdb6OgJxo4eqfcm9E9rQfjTU1U/OmsXz
	vC8Hk0CxvvSFIJAbxkAlqkMhH4z+J1gLT78C63ZIfPvTNB76MQuo4MwDmy3sy2am
	3Fp1V0lwReISLawKSdTgmMV0ejIP0vDjdbPYNAXNP1G2e+so5JSQEHNyP81H6Be2
	YJLaFTPErZeHNJH7fVSccLw+T8xybkhTIrj/0inTVOXDmsASx1DHWRgw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cq70m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:16:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAp6NA028296;
	Tue, 24 Sep 2024 11:16:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkfb9sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQf2ogMJ5sDNDBmIib3WRCLzUuole8sBCJ+RTPswABQjvkaBGXq34vDTqxRbtBO+2RzrMWLanI/QBbXbote3+6pxSxPG2sgVzFyCj7uM5suKLoYIi7U6Ubvw21WkATLDnF5L8YZxYcDPDq7HsEezgdYw1VmDE+lQ4n9PQ2KvTitXIu34Zc+UcFLFHGkMwKDLmBYG6OCTKZgykY+9FKv60/zoq5FLdzAgb8Y5CPyHpdKrYNycIA/2uu+3kpnJHYeEs/NZCMMiZR3RTIjrNWzEy5CvdJia7Fnq4egzXMoKSsRyMlBnbv1VvSsUJ+3oVywO35f/+bM7rRJ4EjVMEKT/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDG2cqr1qAOTFGWh+0o6e43AVy8HKK7pDJvhtKBfPyo=;
 b=PGsEE9Yww1lHnhab+UkdX3st5/qOtaZOpShgTgAkrcELriNmCkzIkGMvS0U3zapHZ02GvSEa1oXXx3xjD9R0aUf7NMTX/9/VBeOTFwieDd7VzaMpRSt27uW00HGKI6Q3fDpbSAc3UouIg8h3iOSpyZ0nO3QDFTR6GBcJVjXAncSbC99d9xiQKABB2WuAwDKrubgl0v6F4Pf6u+bjEJ4pmDAVQvvuTOUYZI5tyWS3b7eHNdrI4oRvEcROZ00AaIyRGt2ceG7sjs6JP8Dd16dbZrV7nrB71FwsZHKI6uV+3IzsgTHEEBC//nQm/fYjgsbixpx1SFlzm/3814EEG0sEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDG2cqr1qAOTFGWh+0o6e43AVy8HKK7pDJvhtKBfPyo=;
 b=L4o9+PdzVv9ywzkg8S9U+KX5ZNp2jQYO4/dx/nt//vSBGLXzF+D9eUt+Ge6Z2bIgGgABXGl5lSWGpZvO+HxLyfjX89KGhEPlPrcWxUnyp1jvdG5EymDZeYC5MtKjc3HSo5YvXoC2XWSoyqBY/DSv/rwDDpKDpaUMfbOhD90ZsU4=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW5PR10MB5850.namprd10.prod.outlook.com (2603:10b6:303:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Tue, 24 Sep
 2024 11:16:33 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 11:16:33 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 0/2]  unrestrict process_madvise() for current process
Date: Tue, 24 Sep 2024 12:16:26 +0100
Message-ID: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0315.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW5PR10MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a894d0-29cb-4588-72f8-08dcdc8a58bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?80TBrTyecqErFYz+ZH+nDfyt1CAR2GxzLW7kayvghkLBRGwdcpSK6fg7EDIl?=
 =?us-ascii?Q?T2s6bm7KOR1b6eiHc81KmsPNDgFBKyWbury3aKeMpbVDUouybZV+m5Yy4cgo?=
 =?us-ascii?Q?ehhneYZVurDSBbIwjGu112ddsxPpNVTjIF3qGGal+jJ/aKpLaSukKAa2tE6f?=
 =?us-ascii?Q?YHiyV3gr/WniOOUmkawJdAQT6UnjeVUmI8Xq3w7iaifJSlwyZbs8AbZ301kI?=
 =?us-ascii?Q?+5Xspf2264sJrCTcLlYlcvZP5Xie09hQwwY6l4H9LYOSA1TNRSktHa1ksi/6?=
 =?us-ascii?Q?XA913cVNJHEJYfa6+TouhgeXcL24UAKdeBQtjEKW5fDL0+yZt9Pxa6QDsHMZ?=
 =?us-ascii?Q?CAxesyRaOyhAIWBy/ncqSf1iEvdytlyvRbEomEP+w+6kddY/bG7YtICXebdN?=
 =?us-ascii?Q?auNO6Y1lfjBeO41Go1NlVbMR5/2t1yPwsEBlBOO2ybKoSQkhMExFDVgeGtH0?=
 =?us-ascii?Q?+0a/Hkc5xBsv4BGacmsAkkyJ1EN13p05YoZzQhvDrYnvmjPVJhaFiAg0ksxg?=
 =?us-ascii?Q?suaYlSW8yFo7zin4pdknS/p7XU9KsaCQJmL1TE322qwUXbSS5Kp0x9Hn44Cu?=
 =?us-ascii?Q?ZVeZFiLklLll0AhzjXKerdBGld9f/RcM/5vS2mGzAlSk4LzuUZICMJe2fu3A?=
 =?us-ascii?Q?e544bANy3xd85liDCh8XB0+slptIunAMj3u+KeU0uOWSmXYxAeBj1tKul4io?=
 =?us-ascii?Q?Zx+yfllDzePewXvzPraN89CGibxq2MaUalkgkzsM1kxNEL7rOWe/DuNAEzM/?=
 =?us-ascii?Q?RziZ5Xdym22Suh9VxoGTKwv9O9OxcbHgWgXgke5+eIrEUm8eeTUuIBr/ygOt?=
 =?us-ascii?Q?v8dqR385aUlXlNDnTK1edjm8g3VSwJ53ezyezUFI+nhxMJVjMtGt2FkqFqPB?=
 =?us-ascii?Q?g4Ci5/k4miIUCyg+v7QkGxMjl4tTgqAMv8jcAP0a7n1HrIGTpm5YqAQW64rg?=
 =?us-ascii?Q?UEAjPlWL0Z5qZQWGL0eMRNY1p5su4lGmIsICkUlbBEIjfEvhPX0ttBR7JuRa?=
 =?us-ascii?Q?5AKGH+CsJ7uAg6cAiqH9cJM0IHh+l6Un8NuiNXYWaN2qyZOX0narcV+tSUUB?=
 =?us-ascii?Q?vqAu8iv0Tta+QDO91Wf/GJ7VV128Xe64hknubSXq2vXIb7xcMc7JnnFFrPCk?=
 =?us-ascii?Q?P0R7qbChsKqtZKjQ1JeCD5MmvYKDJgqrJiaggyjT7kCK48Nns8CerkOvEBg6?=
 =?us-ascii?Q?JiBWRFTsPhtLZ0sDrIAKHAQyPHEVteAucMFYkP0PPsk+RDXeDEYGmFnQhjEg?=
 =?us-ascii?Q?XfqMCDwtTuHLumSMuBy3ht+lQFM4oeYhMsbscZaVlA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SXS4Asvp+R1VmJOje4rKdQBb2JV2P9dF9T9WJfJ+TCqQU87EaRSK35jiKw1t?=
 =?us-ascii?Q?XUh4+FfNv3HSg89rFl8SYUu6CkGJCmp3LwEzRY67FSXzw7Bo/rs1lcl83S1P?=
 =?us-ascii?Q?5M+ylOLFaPS5vm2G8LvHdhwkfRxX0eBoF/w9jpCADeuMfdPRPxng1poau3/6?=
 =?us-ascii?Q?b9EZYZT92EyJ5kBRe/XRiDUzuKHICotDrVkkH7dna2KQQKskrwzneVo7LOUW?=
 =?us-ascii?Q?BfzJouaK1nfiWpw15ge3OLteXpARiraNV+/rsDAULI2+7ffVjb/q9Iq+hA4/?=
 =?us-ascii?Q?PuaGKxwVtMhq+1XZsYN5phuX6DMa7srExB7yB3A4qp5/2V7y7dwqHnIx3chI?=
 =?us-ascii?Q?+1SqZrhbvuxbtmCU/4SBzVDKnp+o0YP6PH93IZosUZz+yZjCH+meNQpN973H?=
 =?us-ascii?Q?b7VQFl6fV6f6FQkoxKK/rEGVcXNVuVktyP5TuQPeWH2ZEKkomGfAo2e0Hl4o?=
 =?us-ascii?Q?aXM0ktYk0qV5i4DeQrXLfwwHa4PzsWIIo21axZTZmqZdDMgDXKHz5ygqsKj8?=
 =?us-ascii?Q?9oUxs6zsLf9+ZQ4bB4nSStvLjcDxYi5piFeWWXEbnzNmal8sww6GV3lyRjHc?=
 =?us-ascii?Q?ZzsyGyFxPOMtjWPXDpMvyAzU9DEVOSFxua4T3K1A6rv7YxTZ63Y/MnZgtl1N?=
 =?us-ascii?Q?UkJh/tHWh9XqTqYE5msSlIYdy/WXOT5Y0lDDfsPsGyCS8SME+78ZsgarD1XE?=
 =?us-ascii?Q?sIiJ43eZ4vjNGAW6yqRECZeMWku76LV45TkkQLx2aGYpKxF9/K5f0ipdCCn6?=
 =?us-ascii?Q?LAkLEUC149UymbQdflJ0ZR4HwvSryQ5nLDLWUjjP3D4WxDDbia0qguc1YA1J?=
 =?us-ascii?Q?N6d0ADaX5tnk192p+7q2HcoB80GCawLBp3a3ut315tP4R5EIHgAsufSkjXFc?=
 =?us-ascii?Q?lC7uyYkb2YwfJm1Bf3kpWYij8JWaoL25Q8JrKlsS8bQEqJpl9uzoaAdfWJJr?=
 =?us-ascii?Q?QV348iaRtV9nfo9kSZ0pKm9xtX82mXhy42syUOYE7s6zFI41Mat9bASB8KYW?=
 =?us-ascii?Q?nae8dgY8ZUACQzwH8MnfY0JT+zvbH4AFqucRo7nPn7lIFyDq8rDV+UrSUVEU?=
 =?us-ascii?Q?weSSYnDEIldRoJNh+aJAnP9KHSSF3kIl6AYMXzME1Lho6oQFJGQjF+BxiX9P?=
 =?us-ascii?Q?ecJPX7qPZCwUrhpJPTBlHJLodmSRnk+pylsoH/4S4+CmTSgyOG4wdTYOjV7G?=
 =?us-ascii?Q?dQM3Z7V/Wd7Hy+1W45T338NXhc34PyySlpmKPpGeWAGRhgh6Wyj08belx0F0?=
 =?us-ascii?Q?VbqRZuf+/QkKZb6oY3/gS5qYzXSFVxf5FXB+nhtMPEAFuJbwXi6TlrnGSCzD?=
 =?us-ascii?Q?2/yjkWoCQPA+fdB5/6SUO1epeqcgXj9oCP2r5FKrkiLBm/4oXMT0m6SzoFC7?=
 =?us-ascii?Q?AMKeO2X0k9iD6sZq+mARel9qxaBjLRcqYyjg97Sg6DlaTgwXvvRxqBU8j5Nk?=
 =?us-ascii?Q?WYHhtThQBSNEhMofBDUX1nEO9IO7VV5BsPQ7ZCoJ5MTM2oBXL/2TXA3nOdnY?=
 =?us-ascii?Q?MBHcmYJpgzNzPEoztn2Bc06xz+/kplrx5NJKsPJI3E9buPspDViYhakZNq/j?=
 =?us-ascii?Q?H8Z1N1G8AizmydYHU0hVOXoQbEoRHFGB3Vv6kIY0PLorDjiiJqLHRHyWQqQT?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	83dalQb7JRB38M4I34zXLTivJ+2WXLKJBWuHNkjEf+GXkWlNxjJk8czvDqT7BLJUsRwxlBhWSppZihAvHpO92jvMFXx5UF+z7iQVtgTE1x4Ap/WDMTfxWzxHndGQ2Djib7XL8DhmnHTJj940R+Rakd3vCUMnFqNMmnfMG71vPT1ZyeCdsF6BiGso+72YCKZny3sLc/lvc8BJttJZZhXbozzmqxLGydCdSsVtrb5ag2sV5AIzW2pcOMlgPzlEmAXDEUud37BinPtcy9wZ+2hoQPr1YEVHicCCBLUGpAfra08hUROGUF4yYcR4UYGp94OSD21cOHVE+zXSAEDhyw3jBFs/DzlF3KX6iBEwarWWWOQwLSJqYmoZdRVNccsEJOLob8YLn55y6Pr9OXQ0qqU2FFpsfiQi0yqaNCtju7VMUtNGw9ANQSW/9Ev7UI2Suh8ZuqPrLgCMeEIELaLYT0UMlBwSex0MRxANpFv3ynG6X/GhPHQiGV8xk45xy1m2Cl5IMxZPfvsAemIdRfnQeGiz2ZveY201o4e3cXxVVuA6ElF4078hOKQPGaRrbPAZWPhhnu26sdZuZEqEI+90ftGHp+7KESgtggIEfA6UGY9fI4g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a894d0-29cb-4588-72f8-08dcdc8a58bf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 11:16:33.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTWnzS+3eKvWh3fnSYu0CaJAs81sITZI7Kl2hsHgYjEEYiEqRorqIeltMDaauPyGRwaXsvzJBaO1oNJ8GvLUtfr6wccerFH+uKuXapqnxfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=890 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240079
X-Proofpoint-GUID: vC774Z9uf9gj8ntTk5rC5n9r1ugDAjr5
X-Proofpoint-ORIG-GUID: vC774Z9uf9gj8ntTk5rC5n9r1ugDAjr5

The process_madvise() call was introduced in commit ecb8ac8b1f14
("mm/madvise: introduce process_madvise() syscall: an external memory
hinting API") as a means of performing madvise() operations on another
process.

However, as it provides the means by which to perform multiple madvise()
operations in a batch via an iovec, it is useful to utilise the same
interface for performing operations on the current process rather than a
remote one.

Using this interface targeting the current process is cumbersome - a pidfd
needs to be setup for the current pid, and we are limited to only a subset
of madvise() operations, a limitation sensible for manipulating remote
processes but not meaningful when manipulating the current one.

Commit 22af8caff7d1 ("mm/madvise: process_madvise() drop capability check
if same mm") removed the need for a caller invoking process_madvise() on
its own pidfd to possess the CAP_SYS_NICE capability, however this leaves
the restrictions on operation in place and the cumbersome need for a 'self
pidfd'.

This patch series eliminates both limitations:

1. The restriction on permitted operations is removed when operating
   on the current process.

2. A new flag is introduced - PR_MADV_SELF - which eliminates the need for
   a pidfd - if this flag is set, the pidfd argument is ignored and the
   operation is simply applied to the current process.

Therefore a user can simply invoke:

	process_madvise(0, iovec, n, MADV_..., PR_MADV_SELF);

And perform any madvise() operation they like on the n ranges specified by
the iovec parameter.

This series also introduces a series of self-tests for this feature
asserting that the flag functions as expected.

v2:
* Fix silly mistake referencing unassigned mm variable.
* Add PR_MADV_SELF to architecture-specific mman headers.

v1:
https://lore.kernel.org/all/cover.1727106751.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (2):
  mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
  selftests/mm: add test for process_madvise PR_MADV_SELF flag use

 arch/alpha/include/uapi/asm/mman.h           |   2 +
 arch/mips/include/uapi/asm/mman.h            |   2 +
 arch/parisc/include/uapi/asm/mman.h          |   2 +
 arch/xtensa/include/uapi/asm/mman.h          |   2 +
 include/uapi/asm-generic/mman-common.h       |   2 +
 mm/madvise.c                                 |  66 +++++++----
 tools/testing/selftests/mm/.gitignore        |   1 +
 tools/testing/selftests/mm/Makefile          |   1 +
 tools/testing/selftests/mm/process_madvise.c | 115 +++++++++++++++++++
 9 files changed, 173 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/mm/process_madvise.c

--
2.46.0

