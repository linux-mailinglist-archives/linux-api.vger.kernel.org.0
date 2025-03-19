Return-Path: <linux-api+bounces-3400-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0464DA69280
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 16:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8DEC7AC3FA
	for <lists+linux-api@lfdr.de>; Wed, 19 Mar 2025 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F102054EF;
	Wed, 19 Mar 2025 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NkVO590a";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kW5HT6sC"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E6202979;
	Wed, 19 Mar 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396573; cv=fail; b=bmMCyJVfS6huVhZv65Gbgw1mmA5Vzdv/OyvgkemVmw/oupmMZBZrhToHW880r22lnLDKjP/GmXJSaYjmAC1o5Zst0JUlQP+cKfzsJuVAlbo9QemZXwypGf/DbLibSBkuwoMTUO183CTEHvSRica0dil3d5U2SL7Dk5qC4jJdrEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396573; c=relaxed/simple;
	bh=APqjMNnb/n4npZ9rpzCxsPKNvezgXRucFTy15IeFZ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gFhd15Hz9RFZnBXzH55FA5Q5v4Ti3LcFKiLBh8ozEQaZYrCeGt1BGoXcxNZAOsOGbgn9lVy4B5WuLlCpehPAfhvQFVMRIRt4FQuEvRGPRMoQhBIBSNbTJnJqZDbvmEbkm3fS0Vy/ktzDYqac9iKyawUtkDMPCDJh68VGCFxdybk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NkVO590a; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kW5HT6sC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JE0ocB010400;
	Wed, 19 Mar 2025 15:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=APqjMNnb/n4npZ9rpz
	CxsPKNvezgXRucFTy15IeFZ9k=; b=NkVO590abmmz4Fzk3v8pcTbpdmvKNE/lEa
	OBmWCQVK1roreg+lCCE8wDd2UiF8GVJEsPQWK2v8eQCb1gbjLmNQAsFjQri+TreT
	iF8cijxQw5BDRfFcZDvjjStCQt4CGngFMNc0moLnIVWjRiQdMtaPtKXN8EOFQluZ
	bfc0cG25wIDx7RCwcAutaxTWhdrzAlYtcmxjhaWVQaFopYrkTzflOt04SpGVFQ+A
	LonnF/pafJWbqIURIXSyU9azeGPp5Ui+znl3u64D1bmeRPvZb9bt2yWBJrfyZFTt
	Uq2w3jmM9catProu0pBxJ1ocJq3RFFLuvyqoeU3aMfLly89lTQbw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1m3u86n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 15:02:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JEgpGZ024416;
	Wed, 19 Mar 2025 15:02:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxbk1s2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 15:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ9ezFtjFLvUWJxth6KiJnDh7XnsA+In/zU4at/xFVRFGr9DIoCgvsb/fQ+xoOMqVF8rpTxj/yCk9Re8O/ou9bnVymxI0PaLo9FEErWN8Doa/UU2b9eK8rq4a8f3ORuEEL/8lYDPoCuhA/tQ5QjtSfBIvUhmyT0Bbr7gFk1jIjCWiJWHqNHSNDfQfLfK2nqaijEOAIQGS0UdPHEIlxtzkwD0GlgqLAa7+oUKHqTOBK4FrEYHTxJGbNfhdB9JA67AsqkyxR//Ef7OYKBHyIFe1janjMwWa1AUIhR20XXfMK2bImBsyLc+5oRwM1AgJWRaH55CRRiJhjQeAoZq1wp3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APqjMNnb/n4npZ9rpzCxsPKNvezgXRucFTy15IeFZ9k=;
 b=UZLHVUJ5B6CyvXSDOJZkLH/Wo5xReXSAiL6gg2HpmV6WbOkIODEYmqFnDN5cgnyjGEe2maqzq60pmUYTtZtLmPft0RZj0Kkdk85FOAUdPLl3jHTOA9n6egOTW+4RRZiOky5TqwWouwioGUAbuL6gDgyMSOcDnYUh+CYc7A5aW9u40OsM7u3bbNXJu1wE7Ye0O3Km4WoT6Ol1qTojb2Ss1OAR8CUGo8sNNmf7FIgqSiPAF13AP7ydVJMnBZ2uIviFVV1o5pm8KD0CcNCIaMj5npuYEzg0t5dc6rOQm+nQbrhrr8j8kzcO5TCvDOQr+eNN7OKW+oGXChuz58ox/nf2Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APqjMNnb/n4npZ9rpzCxsPKNvezgXRucFTy15IeFZ9k=;
 b=kW5HT6sCBN6aNTk/P8r9RXCDAhbfwJXmu7ej9+qpNRJa+Zk96S8WX134vDZp/N8nizz09r4WY+egnRwzVdj3ylZn2sUkdmH+5FwgMlH6SBk6SyjUPVIlVJNFT8QJ6s1Nb5grwgBjYSstBjjq/TDT9DB8y9wHsiPUJGYhKMdmBf8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4887.namprd10.prod.outlook.com (2603:10b6:408:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 15:02:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 15:02:11 +0000
Date: Wed, 19 Mar 2025 15:02:06 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, arnd@kernel.org, brauner@kernel.org,
        chris@zankel.net, deller@gmx.de, hch@infradead.org, jannh@google.com,
        jcmvbkbc@gmail.com, jeffxu@chromium.org, jhubbard@nvidia.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mattst88@gmail.com, muchun.song@linux.dev,
        paulmck@kernel.org, richard.henderson@linaro.org, shuah@kernel.org,
        sidhartha.kumar@oracle.com, surenb@google.com,
        tsbogend@alpha.franken.de, vbabka@suse.cz, willy@infradead.org,
        criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [PATCH v4 0/5] implement lightweight guard pages
Message-ID: <23000b6a-8a58-4c38-a032-ad62637d3fa4@lucifer.local>
References: <cover.1730123433.git.lorenzo.stoakes@oracle.com>
 <zihwmp67m2lpuxbfktmztvjdyap7suzd75dowlw4eamu6bhjf3@6euydiqowc7h>
 <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <278393de-2729-4ed0-822c-87f33c7ce27e@redhat.com>
X-ClientProxiedBy: LO4P123CA0214.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4887:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c69fb09-2482-4830-5d5c-08dd66f706d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFEX1o887KawNPDCKRdFcRfGkggujwcFzJRQcAC0AGhqaUhSk5+zLCheW1Qj?=
 =?us-ascii?Q?UMkjwu3V62WhuUYSRCu66NnEXocjUk51ldzUVmP9wuZ2AsNHcwX/kydEKIO2?=
 =?us-ascii?Q?pQJGrjrjrWyUZxWwLGKydu4gjkOhT05rak7EOIc6xU+JnIdnlgx8/zOXDREl?=
 =?us-ascii?Q?G/kxOmLfNWQkBfblIkXKNkgjiERG5PjKoCtP1cWsmEIu3zOLKE01+h4qrY9h?=
 =?us-ascii?Q?lvFuPobOF1uRtB2dl6kYjVc48/st39cm1BQ4IcGktq1bz4CTttB+zFdicsQh?=
 =?us-ascii?Q?DXFxQSaXrm8+SY2HtFWyR9R+RCKnMmsYXqEXmD64jb4ahkJWdxVnvBX1kE3O?=
 =?us-ascii?Q?uY+YhAXFusRVwgM3HMe1PKYl4T9cAYQPfzErYBeqJAWyI/FDYT6cIQT54yrA?=
 =?us-ascii?Q?TzzU43OG9O9+iAa/wBAcZGFUdvppCVoV6Sr/pe2fSrVWuTrfdGBZXR586zNY?=
 =?us-ascii?Q?1mRfHDD9+ETl3qoUxfH3tK9ooQ2Et7mB5bo57q9B5AFiY7havMiPsSbQPgg8?=
 =?us-ascii?Q?zSuAJTKYOmAwes1IG9Z5B5a1gocO4DjiGRayUVndKrYYfrZOEUeG7uEwPyMd?=
 =?us-ascii?Q?H3kbB/prGAnF0q+G/AzRb8LnKi0WQEfc4FszGdZFEmrWKoItuLUIFVDi4tDT?=
 =?us-ascii?Q?V7hQ7LMwGPv9PiIhctqJjY7zlCrdSH00VcjGbvx0RKboST2l4dWPyCqn7O+n?=
 =?us-ascii?Q?je6p40Dya1boLOOnA0uiVM3OrMQ6bKncrdg726SEYsDOwr9n5GaS32Cbpk1+?=
 =?us-ascii?Q?mPq+5PGffcvnh6zXWccTPYDTfSYGm3Hg+NS3jna9zJ2gxIC79hAl2H9D3oRi?=
 =?us-ascii?Q?OHcCGQ9CVf8qyxPN+nB4jN0At39QM3SVLK3TjOyIBJM8EID0I5sO+0Zf/fgv?=
 =?us-ascii?Q?2Tb5up9ZMmZ92gctMYg9tsZPIaN9F27Er1JvDBhqsxTQOeuG9U4h/RqI9Sq9?=
 =?us-ascii?Q?Raity0c+kCfcX2TKKShR+8XZhNUMWbP3Lfd/F8KzKdhl8jA6ASKiL+Jqv9qv?=
 =?us-ascii?Q?ai5qdwYTJDJ5k2TXVy3lnbkPlJO4v/UWXGATI85qF3stNbp7Ve7ILPcwlgYL?=
 =?us-ascii?Q?fsxTl63ZRGiiQswyKzHqR7wj1dqVAQTQI7t6/N5L0YrU0ogJmnM4j3gzY1gM?=
 =?us-ascii?Q?6iwoN0NGPWOBgC1alavzHyTJJppm55NACUryTCig9TaG1cuSDFAoJ/mev00j?=
 =?us-ascii?Q?Y4bVR5uIPWy0wEIUKmZ9WgxOfnEIpIRCc1leFn6VlBh5pIut5b9JVT+E58LS?=
 =?us-ascii?Q?Rm89hD57esv+J3a4LObWa7ktTYXm7mHqc5n0oB0aRRsJCrHxNbXFrb1/YcaS?=
 =?us-ascii?Q?5i62uO0+hn7ywb8GBPV5v9QWCvEKtlFUnguash1cbIi5kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/OUceqm1xA1JkK15QG7m6bqw1lG3Bb32/0PCjcc2nqNiGfE9qzZflWPZLxp?=
 =?us-ascii?Q?bqfd56ZLnWiLI16/SbBtHPMUq75eSlCd8Zhh8VHk4srxxHRU1aVd+iJif0Gj?=
 =?us-ascii?Q?wpEcsLgH3uWYrAEiBFxQNfUcYu3bCwf/o3oyZurmKOE8esb0B5qPZJmfPdkU?=
 =?us-ascii?Q?L5bCvYwQ26HY/Wkprg5msE9aeL59BlpFTLTUq+ivRHK3oknQIx6pWhGk65F0?=
 =?us-ascii?Q?zOwGAwi8VacrnFPci2EWgt5swOPQpgvYehk7YB+nyYd9egP5hgiG7atJPoMQ?=
 =?us-ascii?Q?pBIlkU8rT6oUqLssq7/WUtupkKLzjK1+dA8pWemnHKHYvH0osNpwldjS2Def?=
 =?us-ascii?Q?+r0dUBK1T22nnr2lRMkw8G178F1HSEjt5RfaIJQYy5bMLqKXtAi001lWprqO?=
 =?us-ascii?Q?6ZYP52hoT0Yr7u51Phz8H7vEpLISW9k7OfGXcRm6J7mkgj46BnExXfz9mW01?=
 =?us-ascii?Q?D3FLj6KHH4aLC6oqWBM3ky7c/MvysF3cG3zdvNXrGjfHUIoyvBmZ6E77VHy1?=
 =?us-ascii?Q?jzwRzMGt5hMCsVi4Qa/a0gRR5aphLsHQ1DpBN82sJUwl0ttK3BDY/l4lnSX2?=
 =?us-ascii?Q?+fTRH0aam2emUIccAueIpy9wlqZztZGd4/g0pX8IEzmOLXxQXwaWrdrDP9GP?=
 =?us-ascii?Q?71DrEYmo/yceMHreUcvBePFt4fcRb3KtgjUbF5CQV5ClgF/J1HMGpbxb7fnG?=
 =?us-ascii?Q?0cVcQZb5DeWRy+IonDLaePao3HJsr48oPlqMOXC6ZssWVKI4Rue1WNYy5OZY?=
 =?us-ascii?Q?dvoCs7F8k2zpe9FJdpdQTJyIMlpzCjrhwKDh3xssQiXVcN/1NpR9zKGx/hw7?=
 =?us-ascii?Q?HtALlFAJvFjHv2PYvE2eSVOFibGfWJLk3fa4JPkkevfeLfV3s1cx19EFp0I0?=
 =?us-ascii?Q?C4EUCw6A9V+4KD+aYh3q4fuhHzBlDERbc6eIilae0PEPDu4RtY0LJmfhGS7r?=
 =?us-ascii?Q?RExYJigmjd7G+JFNI/9uKr6XkkdnB2+zcpemLaoSKXB+4XNB7QoLXa9qFoSI?=
 =?us-ascii?Q?zlcgqUynMSbh1kNbANfV4l/FS3SUNDkIzuVnrOU/+41ipTU6L/7+NJt8iTmf?=
 =?us-ascii?Q?qGsbCwObNv+OoozsX6kxHJ1+5ZnBCgmOPT/GRahRwJd1i8mTQY0PI7hoRbdw?=
 =?us-ascii?Q?qqVnj4X0x86b+M5CWTh+knIzL3hpWmVk/qG0KCph9A4noG+yNGbty+uGqzBg?=
 =?us-ascii?Q?pasagGNqxDoHr9m+4UqKnknQlC8TIJ0UKiGnM3nwJyMBpWX49x2vq7tejYEo?=
 =?us-ascii?Q?XpuKPZ5Yv2rnqlj0tY6Jqzl+GyBzK/fZ4qYOXL5PHgy9F7euXhPIL2STTfA6?=
 =?us-ascii?Q?cY/N2KXx+yM87F/tphdvpAwX6M2FYrkDeZP6lTd5VSLxLEecyTZjXhP8jXPU?=
 =?us-ascii?Q?zoAiaEG2wcttC+BCE1eiwvBYd4hSV3ZqmVTDWbwmf3O6vwfijFr38rWN7ycD?=
 =?us-ascii?Q?Q6U9s9jW/fMmoTft91HfObzjO08by+F4edOcTWAWuRE5uk10VXs6sO8Jehfp?=
 =?us-ascii?Q?oprxu03oufZOI0icd04vRRPXJnBeBfJc3oWH22rgQIgzNzHzOAPAB7tVav6C?=
 =?us-ascii?Q?hrJkXdv0B6PYmkxnWUUzK6NzRCpBHf4RYlHmoJGQaMzuDh5VZ/cu8PA5fnG1?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PNSReW3+Ui1g2KCeW9pd8uRxJtg95KrFrzVD76BkZCzv1aE8CLI69IhOB41UATxOiHbQQVcjkDuKuLrsF+8vDtN9xR+OOvngWy9RKQDlCOVxE86nmZWwvC1hTpw4HU/pgBsJIhGQt3ND2qOiQTbahpqQGveZMjKqYsZixn9gjwsu4DRKqRYPRMaztszZhEKg15Eg3+C5oG+E2iql/s1YNJicrb9sSS1cca0+Jixgua9mBvvjQooyXGTG64JAfjfq3BbAp5gynmoCJFvefNLJvUywRdJTYWIjS2r5lsb6blQfDJtaq9xAHYNtYZiUjtUjW+86fv1o+eeCvmVA9bwGAOlUOBUqUVC79jycds1Uxoc4dZZ6/FyHMGfesaYi5ocPyvwOK3QyniNY5+nnO5+Ar4AykyaHN/wRpt99TMkrj1a+4oBL5epyvzzSXz1eMLysCKuwgh1PbrLZCyKigwOleGREcfJjBptr4mZnaevv0hLWGLPx0UJtg6AYmxwovNlsXE8rlUHYpG1lcyUCNF5o0K4NmHDtvXfhZ//cpnu6B37vfxUXa9xH1BLj4kTR5tKURYlBwfpVi3tefjox3L+dYsQ7/4bvT6kbvgpzotE378I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c69fb09-2482-4830-5d5c-08dd66f706d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 15:02:11.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WO5mCXEkHtQiBvzBnL5Us7i25UAPFFIvpoorWCgfDBB8EuuthWQL83ZrdrQ12HPI9zJ+3THAGxOa4qUNAtBBY/oynRdwC8t3hhW1hcOZSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503190101
X-Proofpoint-ORIG-GUID: HTcoIsL7sBEHnn9GGmVBgT0H0XcYbBPH
X-Proofpoint-GUID: HTcoIsL7sBEHnn9GGmVBgT0H0XcYbBPH

On Wed, Mar 19, 2025 at 03:52:56PM +0100, David Hildenbrand wrote:
> On 19.03.25 15:50, Alexander Mikhalitsyn wrote:
> > On Mon, Oct 28, 2024 at 02:13:26PM +0000, Lorenzo Stoakes wrote:

[snip]


> >
> > Dear Lorenzo,
> > Dear colleagues,
> >
> > sorry about raising an old thread.
> >

No worries!

> > It looks like this feature is now used in glibc [1]. And we noticed failures in CRIU [2]
> > CI on Fedora Rawhide userspace. Now a question is how we can properly detect such
> > "guarded" pages from user space. As I can see from MADV_GUARD_INSTALL implementation,
> > it does not modify VMA flags anyhow, but only page tables. It means that /proc/<pid>/maps
> > and /proc/<pid>/smaps interfaces are useless in this case. (Please, correct me if I'm missing
> > anything here.)

Sorry to hear that.

> >
> > I wonder if you have any ideas / suggestions regarding Checkpoint/Restore here. We (CRIU devs) are happy
> > to develop some patches to bring some uAPI to expose MADV_GUARDs, but before going into this we decided
> > to raise this question in LKML.

There's no need.

>
>
> See [1] and [2]
>
> [1]
> https://lkml.kernel.org/r/cover.1740139449.git.lorenzo.stoakes@oracle.com
> [2] https://lwn.net/Articles/1011366/

As per David, there is already a feature heading for 6.15 which will allow
this to be exposed by /proc/$pid/pagemap.

In addition, I plan to add a 'maybe has guard regions' flag that can be
observed in smaps to assist narrowing down which VMAs to check.

However unfortunately due to the nature of the feature there is no getting
around the need to traverse page tables.

That thread (and LWN article :) go into extensive detail as to why. In
essence - it's the basis of its design to express this information at the
page table level only, and any attempt to encode this at the VMA level
(other than a 'maybe' flag) would eliminate the purpose of the feature.

Let me know if there's any way I can help!

Cheers, Lorenzo

>
>
> --
> Cheers,
>
> David / dhildenb
>

