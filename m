Return-Path: <linux-api+bounces-2330-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DC398445B
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 13:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBF91F23967
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 11:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61E1A4F2D;
	Tue, 24 Sep 2024 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PF5o1KOh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kOz/tUou"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71511A270;
	Tue, 24 Sep 2024 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176650; cv=fail; b=IeBiLxEGJyeeuA8D7jPPsIOeiymMY4rUw6qjYY79eIbEjE84t5RPf5q0w2JV7SImj+kJWdiNiSikexQCCvHrgs9rGRlYN1AUod2XStZ3FSX4Q3Y4vQ/nGl2jpXPC8sW4Gs39PewJhnQDUJECH+eaKQ5C8TH2KjUQFhy0qBmZtWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176650; c=relaxed/simple;
	bh=rg3TAgRDLBFS3ZbhpiPvDEe10pTVJyd+IVF5lk3jKgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tgua1fVKK7QsPNq5CgRRgAwebFaLY2qZJ9sEOqH+jTR0Am817P5i7Yi6c8sa7QXCMzkMC0sxZjMOrT8MpuAb9D7lyX4ZgN8Ki45epmWHuvkpvkPW5eWonj+/2+wHa9h7JBK0fGqOouWXHGIfjy86g6j+dsKKo3oxQqI32eoYde0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PF5o1KOh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kOz/tUou; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O1MXVN008712;
	Tue, 24 Sep 2024 11:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=xZeDwn2PWu8UYuFKltEJq/RpzlHL3GN0BRBf7w2ydCY=; b=
	PF5o1KOhcjuZf5tPvXh0jVH+uO297kpbXVx97IVFqu9W362VAr0xgAtXTjwJMnH4
	dEamfyEry8Mkq0hcK4QCIPwGe4rMSZ3W8vT+D0NtIqPbEICoZHebqRwAXEYqfymm
	O25ynheEKETt9VQACt+Kv31gIitOPvOPKWRYDXH91ZfmJqB0Dz556mc2SalPQdEc
	s0clx5Y29gUKr5GYHoN8prKCS4orLkO3sHoolStWYF/TJ/e/hQb56OEx+c4AOJRi
	CO1MO7xJ95wuylGiOmQRSqBqU/KsNgZhOXHcpauZBCM/leep3+5ghHhNwci5AS+1
	rXB9WQ6dJlwMsirxTANXWQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp6ccpqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:16:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAp6NC028296;
	Tue, 24 Sep 2024 11:16:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkfb9sg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvhzeSdy474z9W6MdngidAX9tXDx2LNtU+phJkhWyOsPr9gK2ykxOMuSXXQexm0/R0fcC5fOB0reryI03VszMlIDNbm1FjDNly9yt7RD3Cz4q+eNzHMU+xxgzxPqL5yw6F8G0oiOi8m1hIsWc0hquSL8CMBM2zoQWDuWbvlMUi7n79TmRXvjNYLrE8Ok3e6vaUAz658l00p54BNJc5MOk/h7iBPq2quYJrbZ+mmXSkQ32QD1D2VS9O2mW1iAD/Q0a1acalQWk1s/v8yLIlNm/o9SZ40xnIkFgdiu76IGQwwPPzk2pgbVKGpz+fLen8yExSrQoCcMyBienSsWCSgk0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZeDwn2PWu8UYuFKltEJq/RpzlHL3GN0BRBf7w2ydCY=;
 b=jxibOukJEtID1IxjhqmOx6QESRW44ADbx0gk2S0JSz2wnJV9X35TwbpPO0BKwNb6PiAicd/A7+KFkeNGVgxZcGStQSjF9pJVuYQrY6e+5eJM5ucMqIQibuRoRGSkCqMfW7PtPr43FYvhASFHhYFblPbghzffcfG5Fhdm/rg49+P1phTTdH9Hn3IpNRWEzKmEneTZMGEuGt2q7db29svnEcMS0Q+bByEVwalbs7BQRTSxo96OrksJt8+N/LiIfLczDtTzKCs1zyeUWP6uCi5yI5qOWvqOEhAqzAYIvEAqwHwP4w47Y55KhdRXAEB9FB5KIwqAwQW9NcWcREpR3dYY+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZeDwn2PWu8UYuFKltEJq/RpzlHL3GN0BRBf7w2ydCY=;
 b=kOz/tUouTNsLbg7ykpvhnyAnJ7yZDac5hyTIYOW1PxD11AwTalLI+PgNZxlCqr/Ub8uQZGlRXNnOgKyQG7Qvmi7INhiiqQAEkI443EgylolEY6WGTUXmEakBc00Rg4M0SdwgTGWBNZ1Dr1PeB2M1D6HOQV0YUP1FIuQss4+QJbQ=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW5PR10MB5850.namprd10.prod.outlook.com (2603:10b6:303:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Tue, 24 Sep
 2024 11:16:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 11:16:39 +0000
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
Subject: [PATCH v2 2/2] selftests/mm: add test for process_madvise PR_MADV_SELF flag use
Date: Tue, 24 Sep 2024 12:16:28 +0100
Message-ID: <c155cc65f732705f6bd8436a00a1821b3f2a80c5.1727176176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0171.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW5PR10MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: e146c437-b395-4b50-ca45-08dcdc8a5c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AliNnVuXUqQcL97T2Ed0TUGzGxMRXSR5OCD2oTPGZfTCjk5yWBFCUhWqwH7P?=
 =?us-ascii?Q?bejHymdQJmvMvAVgP/sKSXxMOWE2So3k5vf9ujviJT/LRJvsqds5T5fEQrxZ?=
 =?us-ascii?Q?+WEiv1f8RArrL4wyPR3lXsgRBV5IBoxNArHy3Ri4fkPwI6qk+uzl79jGaDof?=
 =?us-ascii?Q?a0w2J/zSDlaJxTcIs7gSKnmu0hOwth8vsyxM9td3Wwa9e4zaUUzAXsWECut4?=
 =?us-ascii?Q?3otJ1TgdZtv72JSruTPqpJghZoy/Ybmy0njFjG3hmwQcOa6aBtM049TiG6kc?=
 =?us-ascii?Q?z9Yhls0Dwn0YVwnQQ8R5h6GS+QZQIWEA0E5LOF8tCaT4JfymIdSF7rnAtHru?=
 =?us-ascii?Q?PB6rY57pE1sn2ZWOd96bHybxwqCpk0yF+MMtvIRVpWf4VzePDyqjERpLurwI?=
 =?us-ascii?Q?il12UtnGGQ1vWejyftt5Rk3toa/7RJU/5a3Zt5DlujB+rDg1nxQaNxpaUR0L?=
 =?us-ascii?Q?NcDSdYY9t8/V5GfT4o2nAgrQgkP+S6Juyo4Ofcbj5C7e5vISmk05s+8PINah?=
 =?us-ascii?Q?59QPvqoin1zQtxzIXULM0u3ilicfbpXXBb4LoU7eGS6aQZLmdnTXZWk4BFdN?=
 =?us-ascii?Q?cywcX1oGRbY4Gm7eeHQYmFWF+JrtRh/Yair5R7P6XRcjrZz9ZsJ8SyuwYhAX?=
 =?us-ascii?Q?D9uXsmEN0K0j3QHOYH9kjuhFRx8H3u1lGeo160vYYA8xb/gqQqdYAYswx0ts?=
 =?us-ascii?Q?tusS7tWG0fQch5uB/S1TkfuwI1eSKwq2zc90TC7oJXZryazj3M8vzYvVDRZG?=
 =?us-ascii?Q?dSIi79UYZQGSkKAdRB2+DQ0jlmQj+Ep8grPNaY6CVznjp+7052nCVJJfeFKq?=
 =?us-ascii?Q?jMX/zP1DIyHw2N8PmqUjnZRfhQnf6q1ICZqMj7HTQR8GEbhFtx78C45vJgCI?=
 =?us-ascii?Q?9Z/dDDrkB3TMlXl3nljpXQZh67LfpVWdpPMW0j9H5VhhvqyYpfG1Yp6zvX3P?=
 =?us-ascii?Q?gAdpm19hEs80EOcPNWFQFRgf19V6n/qVqXhlaKiGCw2a14g2TXy3p5oFXy+v?=
 =?us-ascii?Q?8CYd2qZL0qeMSkhNb7BWxPFIIkJ5jYb4cD+vKcuM4HYfcip/3DW1BSJE7Mrw?=
 =?us-ascii?Q?V3oKlPo2QLRH4OcAnQISJecUNFhBrdhdOA6FO0H/jLPyNsXjXI2ZLW9vSgzG?=
 =?us-ascii?Q?DIhi+H1Q2fNUX5rbSzvP3Bivm9DeDRZCIQK0aYaM/OCtt2L8EHT9I5xzHFml?=
 =?us-ascii?Q?4hRvaEAj7OaFk0knlzGxzFIseeOv9sKHTHav0Bk1r98NKjV19NwiQuU81xsF?=
 =?us-ascii?Q?FkbYfqMyXJWuDstvPmqm25oZvfTs1yvVr/YR8bRZBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O1ttHJIfeFgOdX43/ecMmexcIReA1KDZyHKrzr84/lbI3mn1rWTOMkRgF6xi?=
 =?us-ascii?Q?YtMIGS7PtuOLYnUYqVkOodcKPF9TP84+6eiYUzSjiK6nfCg8ovtBUifNFv0E?=
 =?us-ascii?Q?A4YMhVU1bC2fbvow+dtrf35sN4dnYLNa6lt45T6LSPUXj31I20R8l8nCIF+o?=
 =?us-ascii?Q?Wn/KUjqQpD8sgO8FLRjsFiLK46ZNplKJb4SEnec9UBB3MSX+FUn7sJtg0ypa?=
 =?us-ascii?Q?g2d6fTXZscFef5Ks3smAQAhyjmiZFkhb0KQOhTQ+eoXTv+eWaW5jxIn4dR9X?=
 =?us-ascii?Q?HZEgqF39W0T/naseyKTtSi8SS8ozYOv5oTMGPCX1JI5sk8aHqp27NVHkXVkS?=
 =?us-ascii?Q?jA4FlcL6IdVPzhS5HOAYp+wDC3FUIUquan3u2NrAkdBqLtq2MCgeWbjqSIDr?=
 =?us-ascii?Q?Wkmutw6W/l6+aYbivrsDhSoQlqRYDC2238dT6+p/ACY+YWQpmn6ZaqC3uNun?=
 =?us-ascii?Q?WNRnfla04lsBDbl/yZQqi2zxPDSsnASlubqaA15VGpjpbmKYgpEftMtU2XtS?=
 =?us-ascii?Q?yZ7Uiy5Oz7+uBYbC58JDwJRch60g6k3RzkheaQgfRvSVD6q1r0WdV8qdXLZD?=
 =?us-ascii?Q?jxAHsRqSs+vGeaZXgnYIEv5x8/m//W26E25rrkUMAYGPC49hjbUdK/jW2+Le?=
 =?us-ascii?Q?FA2m7wtH3opEpD6WUci4Rp1/isGMh2QX8X//abatM8q19Ww1GS4DudoEqIjc?=
 =?us-ascii?Q?V7Bu2wn5x2Umy9J0rDe/NR7QZmqYnXa0xuB5pfoGL35EcHUjAb10WFjyGfyp?=
 =?us-ascii?Q?Qv0RO8WU3JxpLKL2xMK7tZNKX+0OEynaxe0FkhIJEeVbqKnp6E7LmE8suEV4?=
 =?us-ascii?Q?z2xrAW+msqlMRpAYWdi5hAVpPhwIrEPc1fIrkEeoKBVjlsMd9z4nPO/EJHxN?=
 =?us-ascii?Q?SRZGZN1etN0/845IKKBpPucRcgPTHV3GYGnFEtzhGMzCSVqrkEolGPKgC05P?=
 =?us-ascii?Q?zCx7dFqfB1d558fqKkJVH4tVnjuBIUsmBUM0Z82amAh9mH0lWXPuEcalUyrl?=
 =?us-ascii?Q?KJuE/ozRy564NRxkIDFZHCDai+V45H5RzeU9O874bX5LVYsLfuYBMV7m/NBa?=
 =?us-ascii?Q?j22YptFvKf4O9h6jLDDS8+BNxlw6GDegXtJmTt/xsLp7s8j0VRrkqcT0OV1F?=
 =?us-ascii?Q?xBCNUPYAB+DHVsloeS/hfNRKaGN5nzDtt2u9R+IOl2brc2tv+AnV5n+T5p6Z?=
 =?us-ascii?Q?Bdsb5Tg/7KOCaHa1L47kU5Tm8jTzszuCr2yrNx+jHtovob67F8+EVS3YRT1X?=
 =?us-ascii?Q?LVVXbPEz1yAWg4qsgfrJx4BDibsblRX45bdQ1ANZ0E/nuaOWdgfHGHqtmw8x?=
 =?us-ascii?Q?o4vvAZRnLKwuge8PykexbY3YW9732CsSzH89cM6iihJkBwM6CdmtCUMaV+oc?=
 =?us-ascii?Q?7T5t4JxOiwN3NaTMdEVeQ3hXID9vBenJNK6ZrlSWDo01h8YN00XLBDC+VGBw?=
 =?us-ascii?Q?6O8v8UQ8FBkYmIZHf4W4kP38Z6+yhFjhoZXJIyF6+DASCA0KboPFPHEtxRN/?=
 =?us-ascii?Q?vXrG472Xbux9hJoJuPfScqZVW2O6uqm8thwXkHx3SWVjNClKPA7ZqW80XeQF?=
 =?us-ascii?Q?EUHXhTDXC65m4LUyFGKAin4rYu8r0g1vt6biKTeQy8LRAt9YCwgwHMUFpnPc?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CXYyvBcSDjeZN4S+Thb3xFMNng6BPsZT9lt9inDxkREzgjAWitJSoAjF0dN2tlQ0dFBI/rfApHDRW72qwB2coy2oj8E2Kt020SLQqaR+0uiLuHavUn6hVDj7d/6VsZ2YKL7k2FxEAB+3XEXgRYYVPp1UuIp2EHXYXm7qoAz0ltNPOvfAA5Mr8/Q69DA3/vhNLSDBF9Izx4UJWFIM/78jr1NyH7wKVOZvNNz+Lc82j6ZwxTJ7FDAJ7isPNVSTjsPJAhg1wsqfdp4QNzPaKf5Zun++0PNFJLDNi3GCs/XYPPZHFKOS8mPfGKoS0e2PqNsBWnUSCeI4j8VcLXp0lLdAxgqOpMTxDzYF5X6BQ35B9tHT7Jp9x3WGoXkbqNlSct5k9VHSIyNWeqq7+WEhAW9LDXOc54fH/Eoyi+3fI/7+N0rTL7osTSz3qWZ8axHqU4frlfqI/Luc0wtEuxUC3XNFxf384Mza+1f0hwQCcVLgyKvv+siBHtaSYTM6Ud0a25Vzbd7mSjuTiAD58QtzJCm+ky1Mfe0DYjKh3yATW7fYmxlo0G/PR9Q6Woad7u6tclo14SPGqP0mq8vqt98WZzNMPnhU1WtAf0m6AL1tS30vcMs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e146c437-b395-4b50-ca45-08dcdc8a5c1e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 11:16:38.9684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXd0jQzMydvDM476wm0LbQZBCVhX2ik9IdbSWikJmA0SN9o7VjambW/5THuIpi5NbrFVw257KoX8JCdYA2L2sHttk4FRviLGB6SoJd5/vVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240079
X-Proofpoint-GUID: jnqVMxIf9PCCXo1dKuq8xVfg6GIXm__7
X-Proofpoint-ORIG-GUID: jnqVMxIf9PCCXo1dKuq8xVfg6GIXm__7

Add a new process_madvise() selftest, and add a test for the newly
introduced PR_MADV_SELF flag.

Assert that we can perform a vector operation of an operation that would
not be permitted on a remote mm (MADV_DONTNEED in this instance) on ones in
our own mm and that the operation is correctly peformed.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore        |   1 +
 tools/testing/selftests/mm/Makefile          |   1 +
 tools/testing/selftests/mm/process_madvise.c | 115 +++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 tools/testing/selftests/mm/process_madvise.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index da030b43e43b..a875376601b7 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -51,3 +51,4 @@ hugetlb_madv_vs_map
 mseal_test
 seal_elf
 droppable
+process_madvise
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 02e1204971b0..7503ec177cd2 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
 TEST_GEN_FILES += hugetlb_madv_vs_map
 TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
+TEST_GEN_FILES += process_madvise
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/process_madvise.c b/tools/testing/selftests/mm/process_madvise.c
new file mode 100644
index 000000000000..7a29b77d837d
--- /dev/null
+++ b/tools/testing/selftests/mm/process_madvise.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/uio.h>
+
+/* May not be available in host system yet. */
+#ifndef PR_MADV_SELF
+#define PR_MADV_SELF	(1<<0)
+#endif
+
+FIXTURE(process_madvise)
+{
+	unsigned long page_size;
+};
+
+FIXTURE_SETUP(process_madvise)
+{
+	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
+};
+
+FIXTURE_TEARDOWN(process_madvise)
+{
+}
+
+static void populate_range(char *ptr, size_t len)
+{
+	memset(ptr, 'x', len);
+}
+
+static bool is_range_zeroed(char *ptr, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (ptr[i] != '\0')
+			return false;
+	}
+
+	return true;
+}
+
+TEST_F(process_madvise, pr_madv_self)
+{
+	const unsigned long page_size = self->page_size;
+	struct iovec vec[3];
+	char *ptr_region, *ptr, *ptr2, *ptr3;
+
+	/* Establish a region in which to place VMAs. */
+	ptr_region = mmap(NULL, 100 * page_size, PROT_NONE,
+			  MAP_PRIVATE | MAP_ANON, -1, 0);
+	ASSERT_NE(ptr_region, MAP_FAILED);
+
+	/* Place a 5 page mapping offset by one page into the region. */
+	ptr = mmap(&ptr_region[page_size], 5 * page_size,
+		   PROT_READ | PROT_WRITE,
+		   MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	populate_range(ptr, 5 * page_size);
+	vec[0].iov_base = ptr;
+	vec[0].iov_len = 5 * page_size;
+	/* Free the PROT_NONE region before this region. */
+	ASSERT_EQ(munmap(ptr_region, page_size), 0);
+
+	/* Place a 10 page mapping in the middle of the region. */
+	ptr2 = mmap(&ptr_region[50 * page_size], 10 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+	populate_range(ptr2, 10 * page_size);
+	vec[1].iov_base = ptr2;
+	vec[1].iov_len = 10 * page_size;
+	/* Free the PROT_NONE region before this region. */
+	ASSERT_EQ(munmap(&ptr_region[6 * page_size], 44 * page_size), 0);
+
+	/* Place a 3 page mapping at the end of the region, offset by 1. */
+	ptr3 = mmap(&ptr_region[96 * page_size], 3 * page_size,
+		    PROT_READ | PROT_WRITE,
+		    MAP_FIXED | MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(ptr3, MAP_FAILED);
+	populate_range(ptr3, 3 * page_size);
+	vec[2].iov_base = ptr3;
+	vec[2].iov_len = 3 * page_size;
+	/* Free the PROT_NONE region before this region. */
+	ASSERT_EQ(munmap(&ptr_region[60 * page_size], 36 * page_size), 0);
+	/* Free the PROT_NONE region after this region. */
+	ASSERT_EQ(munmap(&ptr_region[99 * page_size], page_size), 0);
+
+	/*
+	 * OK now we should have three distinct regions of memory. Zap
+	 * them with MADV_DONTNEED. This should clear the populated ranges and
+	 * we can then assert on them being zeroed.
+	 *
+	 * The function returns the number of bytes advised, so assert this is
+	 * equal to the total size of the three regions.
+	 */
+	ASSERT_EQ(process_madvise(0, vec, 3, MADV_DONTNEED, PR_MADV_SELF),
+		  (5 + 10 + 3) * page_size);
+
+	/* Make sure these ranges are now zeroed. */
+	ASSERT_TRUE(is_range_zeroed(ptr, 5 * page_size));
+	ASSERT_TRUE(is_range_zeroed(ptr2, 10 * page_size));
+	ASSERT_TRUE(is_range_zeroed(ptr2, 3 * page_size));
+
+	/* Cleanup. */
+	ASSERT_EQ(munmap(ptr, 5 * page_size), 0);
+	ASSERT_EQ(munmap(ptr2, 10 * page_size), 0);
+	ASSERT_EQ(munmap(ptr3, 3 * page_size), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.46.0


