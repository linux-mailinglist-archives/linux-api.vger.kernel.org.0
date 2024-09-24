Return-Path: <linux-api+bounces-2328-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A666984100
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 10:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBAA1C21631
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 08:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9425814F124;
	Tue, 24 Sep 2024 08:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TnYT5fd4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FNwgAjbG"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A4E182A0;
	Tue, 24 Sep 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727167699; cv=fail; b=qb0j+uVjiPZn51k3nozmI9edwS+CmQ4KRX1qhn07fpts5nTrTG41vOSm4KVnJNv5Y4UP+yW2R5+5Q+oB2CcKp7AmiG6SZgnmPUxWkez7oqP4s8npgveDJexr7oif3L8V7nGjSbDFk9FvoqN8e4gRAK53IHtinXGpB38lOtlot2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727167699; c=relaxed/simple;
	bh=c/YHaPbpUQS0587or4ve4vek693pXP1tzmW3QxR7pXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZHVbJC/6zN+77dLMFP+lHv2VU4+Js9oJxJt4SVekGzylB7kgjcQ5rhU26UUHiyh+xWk3u2rsZRqy1GpkV0vCORdoZ4Y98GEtYL+jkhSaykgP3kYYp2yNVvglajVLyxwpa+d6iaZKxO46LgBDQPZavetoD3NHMJG8b0u3jplq1Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TnYT5fd4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FNwgAjbG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O1MZnw021097;
	Tue, 24 Sep 2024 08:47:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=V6Z2v5zehyy00LQ
	t9IQ+zrrYg/eEyqs2LlXbNZ+CsYk=; b=TnYT5fd470jjZ7ikCwtNVLpbOfjY934
	E8sDi/40T60hTytHV8wpiMZLokLVNIrrj9t7iy01GeSZkd2uQMC3Z8SThKQ1EWq7
	BFi0blFQalYI6gXDrD/mQyGGvplOeAn41ltqT9ZTg0bsanglFpBvYhhNFnLzg3q4
	oCU0xEj7S4Bt6nMgcwP3wijYORTIKpBdVEG2AtTpM34TnOsSrbq+ogiJhnlDMoIZ
	lmAOdh1+d574y2SXs7LLseb3L+4yI6n+pfO1CvwiFX39lEiKoWCOPaTfzvY43LLl
	w28pBZ0oH4ulGzpQMlUyvUtSrWHTRWl5Rm8JM4ZHS0J1Xfb5KrkawAQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjd4bv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 08:47:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48O7IuR3000314;
	Tue, 24 Sep 2024 08:47:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk8n46y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 08:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUCmIW2A0U+T6QEgFQiiH7yUXt5R+P4a8/SbQLMOv5AV2I23tkmzmQDzamay8At/8/p9DgzrT2Gf32K2E+o7Eff7Ut8j9pUONR/DqDzlPaBpluDt+XAH7SiNGUNuxAuY9/G+0NGJLNczKLtkcQCnGtIT/xhWQH77Ci6VDLJCPcrBDUCNBP40RfTlFBhl2vRtVARM11a2tQ4t+oBBjnG/6AWR/heydPZXhSR0v1jjFTeJrkh3B4CreLAXeXM+CXzkTCSioCDoDxLYe6cYcSJQLTWMitzeT0A5+lnaFgygWzQrby8uMam7kmJnvCamQrhOnCRuMxg1/wUtYTPvhxW0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6Z2v5zehyy00LQt9IQ+zrrYg/eEyqs2LlXbNZ+CsYk=;
 b=njbVfklXgkkpcB2O8DNebg9nnnKRKIK0U2bYQETMI5KgDG2Va1gFFHATyUsBaFQJIe7pZ76wGKpiv3NCqytf1ps4xYtzEpVdOJsbH+1GAz25gG3WDGg/NeNO73+u1KtBPOI/haEOpotFnBbqJ2QaAUr28Q4cb5Y0JvAbGm7macwsvEX4TBkvrUjlLSj+1F8mzKSP2Qu2LbBtX2ABAbLWw/2lF/toZv2atDE9+rF0euY/P/+pOL36FLlZ62CeBmfXg4RzeMof28bLozPTpz6b70k1vcusk+o5EG8FvZyW0i0/vMkQ83jyWlhj8Fweg/XCtcMo31WyNn2s6VosV1Ze0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6Z2v5zehyy00LQt9IQ+zrrYg/eEyqs2LlXbNZ+CsYk=;
 b=FNwgAjbGvMTJxZFJrc9q/YTCXp35sq4YIXQ+ynsyl06fVHSJDBGicPFUs0VynJ/YHprcwxukcUHPNFKlf7uzd3Lvbsv2bMxyFT2aRig6xvj7pK2MNjZ6VBFwY7YUXv7TnrwymC8RQ3g4oazexs/eS1zOXXtPMvicwKCxFUUKZrw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA6PR10MB8085.namprd10.prod.outlook.com (2603:10b6:806:43e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Tue, 24 Sep
 2024 08:47:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 08:47:46 +0000
Date: Tue, 24 Sep 2024 09:47:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <7bd12185-c873-451a-8976-7735f4982d41@lucifer.local>
References: <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
 <202409241034.6ilzMh4w-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202409241034.6ilzMh4w-lkp@intel.com>
X-ClientProxiedBy: LO6P123CA0056.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA6PR10MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a7cbc1-495e-4c59-536b-08dcdc759007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HMbj1Ykc1H5zpAqcd26XJeLHzeawky7zMbB9qTFllygtIQSR586w5I/Yo6C1?=
 =?us-ascii?Q?yamUi99bNNlTbmwfs3SB7bzqAJVNF7tP05/FaEj2tOrdfuRLjQ4sWf9guYL0?=
 =?us-ascii?Q?KcaQ+rFPuzSEeZA2RGfqsxtJZPwdVuTnIP6tAq6pw6vjzRVYkPIfEL3YK/cw?=
 =?us-ascii?Q?PTa7ZY1OhBx4cVcwNPdircckUicTml+Oriyz6IDsKtXy4N54UjXM9MrmwWpY?=
 =?us-ascii?Q?g6akI1n30XHiwfbBeUIDfliSgNJUMhekVuXZ/Xg+8VUTqBvOUX8BGBEciSaD?=
 =?us-ascii?Q?j8/w2DEBBvTjo8hK8t0CiSVv/R8bBWP+Tk01foNIU+wn9ju001zMAHtEM2+M?=
 =?us-ascii?Q?drpzike7qlLWIfzHOpNR9cID1+1O6tWiTuVBkjIJGHgDpzQP+vV2uNB2M/h2?=
 =?us-ascii?Q?MQmhOszXPNopx+rYUO5b3fDrHtAmmKfY/l2Stuu37AONwwWe1RhX1a7la+cL?=
 =?us-ascii?Q?J6RAzRnkwDUxNcl6t/oPkwJUdU0O0wYomuoNq5pcHhcWtUVs4mTPfeyHTaAb?=
 =?us-ascii?Q?ZgYtLGvjWJwjhUxAz06MAJsCsWnzpkRPaQsnKNsbh8DFR/EfP+/Ll89QCwiw?=
 =?us-ascii?Q?C5ivSDaNwR5RZZEwMUk4eVhOotaVydPIjKIKdvgWXvfgvSayCN7DWKQhOpun?=
 =?us-ascii?Q?Fs0LQ0kkKlwxD3SUsTPu1adXIM71f+QByu1OPgZZCxTnhBpr6fw3I3zCr9g3?=
 =?us-ascii?Q?GC8BWe0RzTFNHfaX1WLdHo9+te8jo1NV8MkhWczvA3Tu5YA/joqNUNkg/aDu?=
 =?us-ascii?Q?Ria6UVExcKo0D4GlURIxm3jpDFsK/EwOojz9Vo6iCNapdEgFsJzLATuEgCco?=
 =?us-ascii?Q?kcDnzG8gSiUOmtI4YNatkJN6Tu7ZFN5b+yd8SdWIZJhbbNZdV+l4gz6+xwjg?=
 =?us-ascii?Q?BqyxS+LOEMeomJQ3JuvbpbeXnLeyodGolZVPr8cBBo6msIFVVAo4FTTUDlG8?=
 =?us-ascii?Q?TS7A1Zbkz+GdPrCLZ3HIMvZ/vZXLRXvpxV7pXbvfmNVq4nqWS0MO8FfUT/mZ?=
 =?us-ascii?Q?h68+ezDXv3F3thEkpQFwJ2l+6cVH1Vk26jbyTpuzKaDyOaoCC6s0wxZGryQp?=
 =?us-ascii?Q?mhjV5C3wweDU0r1L/3XzSidABm+rEvxDzkB+bPQJDPnKymg87bKLqrC0Z0kb?=
 =?us-ascii?Q?2fWXVC9e/YGcfapRYyFx948WXc2LWI3QxKEBOIsslHNc/HG4frh4KjGsQax/?=
 =?us-ascii?Q?asH8opGzHfRK4rWnBbrWu0WsVxu9gsmubFjhr4RudE8W8pyuKpDAtmZAuX9Y?=
 =?us-ascii?Q?3ynEzi1JyJzYzBSflKSSJyWBUsxL1hfYEm8ebRqkqNNJkrsA/uBHhV6Dume7?=
 =?us-ascii?Q?Ndc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GCajX8z8mWbWMbNtduM9V6FQXfXvGk7Gz49PuAtMMK1jkn+mmdAahMWDSq88?=
 =?us-ascii?Q?vyD6cmeJQ7JBH0z17feTrPlp01a4J+kUQwUrJBCgJOytFtB9leDKc8SMHnOb?=
 =?us-ascii?Q?waZ1b2in1rmb1DRSk62QsPcAen1qd296AlcxjpcgTW8vzBu7xR04X9z5LktN?=
 =?us-ascii?Q?v8SG3XfmcVML891d+Oj1dZxy2vPZSvw55jhka5uuncn2bcQjPhydp1G6WnNc?=
 =?us-ascii?Q?y7xBYls9iAiXDtCFVvkMek/lp9usf4ek4pScRwCFcFPtX8htbYz3xqhMufOc?=
 =?us-ascii?Q?KtRqKLZirByC/FNmOghM8t3rvzQWiZF2RfancQQrPrau95uw7tENsXrXWO69?=
 =?us-ascii?Q?SvhKYnlavqWhGBza2WCgmKSel6kpce5L+cVE86wBLsjQAzFS1PdQtkTmTkhC?=
 =?us-ascii?Q?UvzheBVaVH50sI5i57xS6xUSk2MkrvQUUSEs4xwNqsSRzIwdfZEWFHi5xESq?=
 =?us-ascii?Q?Mdcg5wcQjIGpnqHPdCCNjXORO3/+9sQ67kdU6TPdkfUwp3QkWtwhEzj2yzOi?=
 =?us-ascii?Q?Wt3AoXGeAXfM1iCRl2uartxlLviIK1lp8FJml5tLgRoDUnGZQ8uQQuCBRRv4?=
 =?us-ascii?Q?bft4IGrFs1kxsTfFNLox0+KhYBQiBzJBShFzwBg8LQEt/KFVebp9MIlXV7BK?=
 =?us-ascii?Q?aW+Oh67W1ozGKYfJMbGxv72ajKPwxLp6CYnJpMG/9QHoyEQZbc8xpXU+mjsT?=
 =?us-ascii?Q?LlyjFbMf/RC8kbgd+ay3JRNaMThZ4v0hrAGz60bH/VAZo5VQM+E22c0RdJ3c?=
 =?us-ascii?Q?4TawzhMHICqfMe4BAbjZ0sS7st4TNJ2g7n0oOMhBrYNWgl+qP2RO7j/KuE1a?=
 =?us-ascii?Q?z6fk7xYE61YtKRhh/mAmy0W5KxPvkQxK892LoKC7wuWyyimxUTcJlEsfLZTx?=
 =?us-ascii?Q?a/1AH4xAPKCU58ahWw8ct/mkVpAVXKvJeK7iuApqYtgIofFS5ocSLcaTNC2u?=
 =?us-ascii?Q?5a8y4QlRQ+KffJ/J/eCA9fmJggytgkp3Ff4fJWZ6XIWW7oxMS6AVVW75UA02?=
 =?us-ascii?Q?mHKUnQkZ4U+XAkD47Dp34h/lcHIMG7XeRUUG623/FVERY3YhYZ0j3bKd55w5?=
 =?us-ascii?Q?/UMdxGBifFXpzPuMPD1z3sEybRZT1Kp93nA0hT6LAliRwcsX+bcE7YpYrVFi?=
 =?us-ascii?Q?4XRrd8PzO4KKco9SXtElnl6XGhxo1K1C0aQE87Glxf0knMa96xVB0tg+K2y5?=
 =?us-ascii?Q?rKE0ABNV6lcR0+zJ6hmc6IxaTri1k4iaZUbma+//AeRgwos5IVUzulMqECNy?=
 =?us-ascii?Q?xXo/3urRT25s4AW+dhk0KaAcaqufTG/qCMeHAOYYNoiiJBBXE6bHI2tKrNIA?=
 =?us-ascii?Q?aiimL3Iaoq9lsnKerUjRmDSIfbmx2rODO47YP8DJSrmKzBRvueH1BEk4UTIf?=
 =?us-ascii?Q?/pMtSHWt1y/X44QscRLJ2KdJEddJ4ynncTCCrkYqgOsqOCrJKOnSOMA/qvpk?=
 =?us-ascii?Q?GGDCbgG+H4ybYaKvnVlOc5qniH4WWQ7lopjpTTPgyHuNe63VLYRljbOOSxLd?=
 =?us-ascii?Q?39Ug8+tXXaJH/3v2B6RTbS8gBHcl+8vDnsgD4OrpltgUZssucRmO/+obbtYd?=
 =?us-ascii?Q?nZHV64nbkwiJxCYHkjnmuwHULOOqpwOE6h+Ju1lAgcXLG1lht50JoSGbf8Wh?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xQzeItDv1riW9On9PsW05tZovkh0+rEWNmbaLNqCmdkBkasI/FpEfGUrWlFdzI1Fd12Bm5pFe+qWsEJjVrRRsQdGbcQMWVg87TIWboJeGt2rEogeiv6au+t/kaggfctKpGeUf175RKgcccrp2FL9ZQp2lTE3xRB8rRmnBCzmU58ht1QBWn5oWkSJXTdfPm+hYwvwCWSB/MdVXLPKpSybNc4cWAMB2tz5gM3a67EGIRNQr2662MQxLPyTTz1HsrRvukkemrCpna6/L7p/JLoYw5oXCgmtooFbmdQFsx1BnsVkETTNypUxjjLurDhaVMQUl7h087474kuWmSY6Y01/rUpx28uHhmx5rC04woqIYuVsThJuMq606yMXWT3DabWlmEGA6pkdGd7D+Zzt1MSajkT6MEXWEUdySDWp8A6hlPsRQyI71/SVTNQK1sReMvzgCo3fovSisz3mMTicwUgkmB/tvmW4BK0H1A57gUvb0Vmhdlh+om4qHtSxJYVHNNNVfG+6kKNd7/DpjASgQC3BbSEM/Bn1Iaa+QlKGdp5WBNmcyFXuZzK+v5c0wUxsxUwLSDb4T0g6gj1KF51pRY+9yCjySQc2ZIX9VbmwN76Y/Tg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a7cbc1-495e-4c59-536b-08dcdc759007
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 08:47:46.6398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkjhynCT+51gxi+N1X25Fud05EC6OoxPUvOsgNV/3VaZLq453S+tBAmcCGhjxS9iJW/ksXOOWpvStwKusUfff7k3zScCUzAEC4lf5OWHxL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8085
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240060
X-Proofpoint-ORIG-GUID: BDRfLPIuLJBvU40tLaICdINEnvPPNN1p
X-Proofpoint-GUID: BDRfLPIuLJBvU40tLaICdINEnvPPNN1p

On Tue, Sep 24, 2024 at 11:15:17AM GMT, kernel test robot wrote:
> Hi Lorenzo,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on soc/for-next linus/master v6.11 next-20240923]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/mm-madvise-introduce-PR_MADV_SELF-flag-to-process_madvise/20240924-000845
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes%40oracle.com
> patch subject: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
> config: mips-ip32_defconfig (https://download.01.org/0day-ci/archive/20240924/202409241034.6ilzMh4w-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 8663a75fa2f31299ab8d1d90288d9df92aadee88)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240924/202409241034.6ilzMh4w-lkp@intel.com/reproduce)



>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409241034.6ilzMh4w-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from mm/madvise.c:9:
>    In file included from include/linux/mman.h:5:
>    In file included from include/linux/mm.h:2198:
>    include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
>    In file included from mm/madvise.c:21:
>    include/linux/mm_inline.h:47:41: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       47 |         __mod_lruvec_state(lruvec, NR_LRU_BASE + lru, nr_pages);
>          |                                    ~~~~~~~~~~~ ^ ~~~
>    include/linux/mm_inline.h:49:22: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>       49 |                                 NR_ZONE_LRU_BASE + lru, nr_pages);
>          |                                 ~~~~~~~~~~~~~~~~ ^ ~~~
> >> mm/madvise.c:1514:15: error: use of undeclared identifier 'PR_MADV_SELF'
>     1514 |         if (flags & ~PR_MADV_SELF) {
>          |                      ^
>    mm/madvise.c:1527:14: error: use of undeclared identifier 'PR_MADV_SELF'
>     1527 |         if (flags & PR_MADV_SELF) {
>          |                     ^
>    3 warnings and 2 errors generated.

OK looks like mman-common.h is insufficient for some arches, will fix up and send out a v2.

>
>
> vim +/PR_MADV_SELF +1514 mm/madvise.c
>
>   1502
>   1503	SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
>   1504			size_t, vlen, int, behavior, unsigned int, flags)
>   1505	{
>   1506		ssize_t ret;
>   1507		struct iovec iovstack[UIO_FASTIOV];
>   1508		struct iovec *iov = iovstack;
>   1509		struct iov_iter iter;
>   1510		struct task_struct *task;
>   1511		struct mm_struct *mm;
>   1512		unsigned int f_flags;
>   1513
> > 1514		if (flags & ~PR_MADV_SELF) {
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

