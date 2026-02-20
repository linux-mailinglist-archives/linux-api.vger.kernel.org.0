Return-Path: <linux-api+bounces-5869-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPySHLPJmGl7MQMAu9opvQ
	(envelope-from <linux-api+bounces-5869-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:53:07 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C675916ACB6
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 21:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA54303743D
	for <lists+linux-api@lfdr.de>; Fri, 20 Feb 2026 20:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496CF30B51F;
	Fri, 20 Feb 2026 20:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T/6WLuoE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XQQLI/aR"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B22D9EE2;
	Fri, 20 Feb 2026 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771620728; cv=fail; b=cmoU2jSYO4hSSsGTxhm/9tG3/RKJ/t5B01hi2lzvb+2DSOE+DE3rnY9Qt1TR3rSafl3738SYwgH931QpBLaLZ12a04Iuag4q5wWYp3P1VrVHYUUlPpbAJ3JgcXzsvnyZZurg1Xurf+OrJLvMWIYxxwMwknMl6kPMSkQAqwBxFQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771620728; c=relaxed/simple;
	bh=Gd0e7vO8Yga3QJkUg0aPoWhIgEmjrr+CscWF53Nbr/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uas3SdKZnRFThkH1mN6OKT/YbhBWMYXWVvrhMIaAaOnTX5rRRTJR9i+VNs6itaGcUVUbXyfDxQ2R2rA2HbsQOYjH2hx7PfCoblWUd2JMNwk74EtZNv044GtN7iYTWVFAhhNn8KEmIBS5qM9H7TSgWyJX3j9XvxrKa/737FoeMng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T/6WLuoE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XQQLI/aR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KKNYDa1573011;
	Fri, 20 Feb 2026 20:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iEndK3s9770e0Q9TGeYJv3Sr06L3W9GrbsFHjlOjG8M=; b=
	T/6WLuoE/QCLaWf6mNiH1f4ybZMqqauJeIUUf4djEX5x/XPyhKLtUTCYCxg2rWqa
	7LNd6fpfeMoKeEIgnilqnsIHG87pM3hjz78fTgxZ17HbwaVK7GOVj4DV0CxmBKdV
	pyi+mLsnd/QiUGZOv4fKw8l0oRDFFlrAZJL+WC00o1nLS4H9NH+V2ui920qiAS2U
	fSUBKoTL5HuMyL671PIbebzej2rmnkOR8QYj0U+xk+SnADh0rAGyQYiwWj58Zbw8
	7hA0dejYrR/ZeH1PAICqWajgJrhyyRutom8YtvIKX40pJxZFke1K6P8YBNKHo4Dv
	O9Fp5I79SDN+ZzKrHaKo/w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj049y6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 20:51:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61KJEU6d015575;
	Fri, 20 Feb 2026 20:51:07 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ce4ayqsx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 20:51:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ql4DbaKijS9YGGoWvi4ZufVAympgv6me9OZrF8BOSBs5RcJ31aZOrb7eJpKP/EikauOP+Ih0vws3mg+2xIz1CFItCZzwLTlgwqQ24MnAX9+6eF8oaMTkCLgjyIglOCtZcMlAWj3WS8Je9oMoqlJF9Yi5QKUfQG8W1u5DcuGDoMxmkvlzj40fcLn6TOYDCCblneFUJisucajtyoL+6qLgAnLN1rq71B38UERl2Opzast4SGoeTAvqbZFxqoqR1EFGtZ8BQOnhww8JK9Vc3HivxlO7SXjS+Wm0NWy3DPWjWOaf/XEhZ1q1zUAPYlnvH9SmYQnhMb8nBMxr/rdfsrG88w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEndK3s9770e0Q9TGeYJv3Sr06L3W9GrbsFHjlOjG8M=;
 b=lKwvj68etds1CXleSHOu8LWA7VXJS9wMRRLz+UjXMZn31ANeqps/vTNGqlyR2eeAPBUT7unn0LYSTjIAkQiCEjEG/Y3MXpqFjFTKFTOeZkMd5o6iUyX8BXE+VGdmxeGqAdsJxBxFvqtrLIMTteskHlvwozm9ahXrwMoZChsCVb5ats1jWaGldT6XprqaGtOs8o7ucFu75FtGIyf0R1vCaXs7RcddSxyVs+2UA74nRzn19VYaxEO8XkXrOwsBY+SMHpY6vSLgA+U094I9NU0ULesYaaqesCsrwjtuCmmBtfezZfYCcV4J3uZMUW4y49GTTZf4bux0GZzZOctcFrxKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEndK3s9770e0Q9TGeYJv3Sr06L3W9GrbsFHjlOjG8M=;
 b=XQQLI/aRujUwjzgjGrqqiTA9I99sa7ueSkknOo7mN/Z8x9HJurQeiG0RirCFFXJnn9OjHT2rh6zYYChogllBSchkQ7F/7NloO06EFeZXRz/gmEMp+7L/4FkJvfRxfbDCzK3dURuIWKyQzISBtzQV3sz/9sC5Y7+Bd3xwB4CrpzY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4739.namprd10.prod.outlook.com (2603:10b6:303:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 20:51:04 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 20:51:04 +0000
Date: Fri, 20 Feb 2026 15:51:00 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Carlos O'Donell <carlos@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>,
        Torvald Riegel <triegel@redhat.com>,
        Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        kernel-dev@igalia.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/2] futex: how to solve the robust_list race
 condition?
Message-ID: <sn6isqtjcgzix4iwifcg6fy2lq3klfdykezyodzbt7fz7urhcs@dc5sxuzypdoc>
References: <20260220202620.139584-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260220202620.139584-1-andrealmeid@igalia.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4739:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b3dc43-9e20-459c-a947-08de70c1c32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?+D539vVciBhsKU2auBSoum8TX26sAX8cgXkUxFYU9PEgllG70GoyQe49YR?=
 =?iso-8859-1?Q?ITikHvFD9HazKPjksf2vH47QcKi0q5I3FhxGUiCy1xM+ASvk+3OY04OKp0?=
 =?iso-8859-1?Q?r4dofA2+R5LYVPlXzc8pHxavZPqWrgaUZT3GJtqakpm5LEIPJk2xGdqE7h?=
 =?iso-8859-1?Q?CnoCyggQ299b6bRwQ6Qzl7U5KWJ1/1IJtBaFov86mnA8U7Jz9cM4+cPbsU?=
 =?iso-8859-1?Q?dqaIsSt+t70UifyspCX8g6qHppoa+xsIh/f5txgourcev4m6tn94uZUqXP?=
 =?iso-8859-1?Q?99lYn0KYnQNtPItc+1oJLMvbMl0zpvoqOcBK67/Y5D/dVKU3Gp+66caHdN?=
 =?iso-8859-1?Q?xFqqW3xwED4p+PBbBAJpfWKU2p4JEUdCrkLSVUJOjXeBSg9oP3C6Du5s+j?=
 =?iso-8859-1?Q?g+eBnq2fhVbHbas5Y3i3Vz35zENQaLdkA5Niq9qfGuqBLctcqY64Y14m6P?=
 =?iso-8859-1?Q?Nn6qKqxwXHdbf8L+5vdNkFtDtguC9WlR2LaB7TK/PDc2WuFYvbp67vs+Wt?=
 =?iso-8859-1?Q?iGoghFDDs4bRb2KBiMkL+wrkRZmTYIoIdJHLXWBcVZXUaULKnaWarEX7e4?=
 =?iso-8859-1?Q?4UJLGQmkL2jwv6MtNXSNQFEwrQZiuZm3nafHa3/GCS0mOTa5uDKbmdGnGb?=
 =?iso-8859-1?Q?cYvhhlYtOLRoXN71EkyW4819+DWljzHaKaC6rVBrLpLK8+O8ackKn3Wapk?=
 =?iso-8859-1?Q?MQkCfKCPoTG9NIFWfNvhuDhfEE+v4RLvZQCRn/+t5YtcVKiBLWMs6NBEIq?=
 =?iso-8859-1?Q?5GISEdKX3hnF7+VtUezJou3QmuUtsDjQYJCy+vNdGO8mOt3JiluvjIHOsM?=
 =?iso-8859-1?Q?FZVHN8GmvdderNNUHvNNIwXDgQZO1xU1beOjelFe1yyv9zlzb+gFI5Zab8?=
 =?iso-8859-1?Q?Ny27C0o7g252JiZKlY/41bZR718Nj6QFJoM2bvR2fKg0gMjs9CO6+vYy2+?=
 =?iso-8859-1?Q?FqGKYvS67+gibW+du+aaorAoPkhq9ak+qewd7cRx9GmTxh//20ndr59Jv3?=
 =?iso-8859-1?Q?C8USJTFUYWW5pDpIc0mUPFdncqyLUjd4m6XvuM8NTQzK8BE9ac6oLfXRl5?=
 =?iso-8859-1?Q?yJ06/EJk5sibWg3DjfWbsliwTSUfRP66lpnwauZOF+H+29ilr1J0xqBCK8?=
 =?iso-8859-1?Q?bco07gCnKZTrb6DHIh5ykANShLbS0pcvh9IBy1cVoOK25g1SiYz4GDRMEV?=
 =?iso-8859-1?Q?PszTN9uVk7bz+9jFbta1bjQ0CJwQkIG+IVZoj/Ar9hiFKWLlYMPkSWtbvm?=
 =?iso-8859-1?Q?JNcDzfxzFKtsfmKEaLyKmrrt9C0jcpgVV5FMfoIcSddgL0SMdZ592TOkSJ?=
 =?iso-8859-1?Q?w6I2A8YRoGW7b901ge3C44iefZ9bzKEvmAuLrhpfEmubSEaY9IDt7M8P/F?=
 =?iso-8859-1?Q?NnGVgH+7mOkBUfUti2qpGvnH2rkyRxHKkhV7qyxsv7kJZW0DeGqe1bI0c8?=
 =?iso-8859-1?Q?XjU8dusmKq0NdxgnoCk/ROZ1yKCS15O9C+8b/7kR5DFKjAuLdGjQfu6kps?=
 =?iso-8859-1?Q?R/zb+sMENLgmJBtDebRs5DzCntDTwwyzeE/BlCtxZaPi0j75+ILe/mBdxV?=
 =?iso-8859-1?Q?57UcnerJMAYilt8sjoYDefqtJEu0TxG6gGPAeLUPixQjTVthwgS9HkqFue?=
 =?iso-8859-1?Q?8sW+RAQvcW+gTr97l0HbCMiiRVxWGTcI4F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?kjPrL6zkcnAiyQgd0tUffQjsMD8cNG2Z675mHEZkRMyjAfjhyQnGy5qKsK?=
 =?iso-8859-1?Q?tAVKTfen/ceKdeCozkrr96Bf49p1VoZj+pgwIhyLFAUemIDR67MDjrFhWH?=
 =?iso-8859-1?Q?RI1aRByU1kIRgvBwtfukpA905q+dqLk0AGW/BlymlmLetUqGcY9xI1dW3S?=
 =?iso-8859-1?Q?9T5atrYWpO/vnlQao/WfgZkTbNpenq6fnzO0MXtKqA+QOFQjMouyKeazpL?=
 =?iso-8859-1?Q?QpgKQAg899Iu4kswizAVa9Z4Qta5OMzMm8/oP8DMiaeYdYTSQt1c72MXnY?=
 =?iso-8859-1?Q?wnxV3pqLNYSSTbTrByCP79f8D3wX+x6DQMfF1pMv7gMMDsxGhLMJ4dVDYs?=
 =?iso-8859-1?Q?tmFNaTinHVKGAC+sdEc6/+cc3/rgneNzJNlE4CJZwIzeUSScnUcKm5mG6i?=
 =?iso-8859-1?Q?tyycPv59G6Of/xCJ/Und8ZMyqVjV1F/ywVQB1bJoT4r3lLaLsDOQMOF8py?=
 =?iso-8859-1?Q?2cVcnyAnRna8tQtzl8DcWBjiFOhemAF98veK8m9t2Jj8Pzp9m9nsTW3fgW?=
 =?iso-8859-1?Q?u+0Sw2MC+88r3uBuxgq73YoEShQ7++wjNNBhFueO00n7fHUo0wPbHsXigX?=
 =?iso-8859-1?Q?qC7PKvvC8I/kBkoy0kwh/wmOXJ4FyGbkr6ZPaNpr6W8ST3YWT0f80i//PI?=
 =?iso-8859-1?Q?cpkMLlbBMmNTX2Jv+o0JAGHR9IbE2s+VGRH5esVvWaGVq5VFo11EvpdDBU?=
 =?iso-8859-1?Q?3pX/zXsR3NQ88EqEIc8276ZgpmdUcBm4/pS77ESIQzPFBPBxh/j1/HMSmI?=
 =?iso-8859-1?Q?Ft0Hc4B2/CDgwoTk0hMF5GNXObhg6QHxMKEBaemnM5b7E+5ZNFIbmHFkls?=
 =?iso-8859-1?Q?PPILRXkMcMFM5mKwgg+wDmR1KlJoqGD6Y1oBfhxivt+2lr09iPT/qUuok9?=
 =?iso-8859-1?Q?maAXJMzbdPCr1pb9PDNjAnLirRjq/XR0YQuiTCDHkajfYEpxD78sT4/+5q?=
 =?iso-8859-1?Q?iqahb+W3Z3hKAas4UI+hWHhyYFS45AAjwPF8mAcqIP8T+jM18Oj9e2k9t9?=
 =?iso-8859-1?Q?pkOqMqWHMFOfL5iMh1u4yabBdxS/GcJX2sdIfg4rfIEG1VmfGJcBc2Mh5Q?=
 =?iso-8859-1?Q?feDYTkA6t2ntBw6LKaXiLzifI4UF5RvdFRodToWwS724Pg9mS0hVbbtEzf?=
 =?iso-8859-1?Q?pRlYWemj4ZjMRKbiiU3ddwDt4Mo615PhNVc+sesvgbqLzgnjzpz7n5e+wN?=
 =?iso-8859-1?Q?OcOBSSzfWm8CwRKFdbuwsF+JbOqMkCEXPHUjwDZAPaj6VK6ve4/eUnpQtS?=
 =?iso-8859-1?Q?gquoHyqWGWDWqrdAGhzA1nchimVOFwARRi9NVOv5htp68D98Ge/nvnmePn?=
 =?iso-8859-1?Q?dzd/+dS7PKIqwudU8pdVY6ix6vKvNiUHSg4a+d2g7J1P3QmHzwGuw247JI?=
 =?iso-8859-1?Q?9uym/qA0N0f0iKgNyXMGJIwiN0+/IrrasuCKdZI5Y/qJsv7oZIYGXNP+tp?=
 =?iso-8859-1?Q?Ovaolv7oMNpBxGyM6/ZCStsPjSh6kn+PLUbdSM//OMlQiH7Sr3G8YNAsPv?=
 =?iso-8859-1?Q?zbGstWfmF0M5vHvC5QGCQh01J0KrH+Y0sl9RhEsQ7NaZH+jo2CfyhCGV0+?=
 =?iso-8859-1?Q?0IvcpARr7NdhgScA8WizihBsqk8OPe1rUHgYxiyn59UJtuMvWXSUELZgOG?=
 =?iso-8859-1?Q?4Z3dUK1PNAFglwJ5HVffY+oN0EU2IDyvASFP0LZsce2EPswSMH7hIAX6ce?=
 =?iso-8859-1?Q?3bcv8mfph7kQzorQmFP9E2oMl+QENJR6AGnub9iolkN2cObBfFZ13paei3?=
 =?iso-8859-1?Q?glC6JY4BBebUnXFDhy6TCYGldVsen/WHVI8gbrvhai9TrHSCXFeFPlgWVO?=
 =?iso-8859-1?Q?LkQ9wQYnfw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vh2pDjtYB7+jdzqPv/EvosD+4AAWTRUB0gM4ZRDuKJubVTMfQ+aZy9BNVw1EizfNbZi+ivQHHtyPtS4fWglLaR4hZWCC6AWzovz9BrdM4t2yS/TDLDwLkd9wjoOgVjy7y6mbIxuXJ1y+wP12g/QemL4KcBIphXpE1o5/TFAy/9C1VwhbBBJg0Y/xzJILqqqcoWo+NxVRsxHg/U9cA1JO7FCJGPXO7JwvxoBASDRZTZwVGf3BEj9qpJJU0K0c1XTr+Iti1ePrI+cU86K+tdTvwM1knVszdzqyavp5hRoOCKFjyJUEgQdl4hI9uDz5QrTp1TeYvqSyjHAe+mK5KbxY2wP3gaXLe+pDxAqiQpryzfU6doMIsQMDWVoL3DG/02s0chteBX4CaMtucoOPAhBwMfIW9Vgi8eQ9oRwaBi28eOKOzhc+p/CcD1946yj2a8IoyJmHFlXW3IvV9N1WdXY7CWia0/ImcFM4RW/ztNBYwDzpI70ALgSMhVKPng4rQnXkQQuXdptYR1jBhi0KILXW0x4sW7k2xy0Fh7K39eTUxlcjf7EFR0qV2/MKFqQzvd7pi4KVnguSWFSFyr/SWwnlLZgaIQbDYaILK1X8BidhZpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b3dc43-9e20-459c-a947-08de70c1c32b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:51:04.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG3QV/0+UzNCrVKeP0fDV9/43eFPYGQbUmD9NU8Wvvf8Kd/uog40SQAnZLI24mtucuWPZShXmQb/l45Uvld1NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_03,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602200173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE3MyBTYWx0ZWRfX0IVT4/hlgJSU
 mWlK8SvaYcc4yNvTRaLZQbreMxmmeaijrCb4xFKRJyj7Q6yAiZOlffG+q/6fFSurF4Za4U2ZcO9
 owfMUUBGW0ElkhRQIm+9TRGQX8y6r7y8nOX8uiwIJKfpa9/iS/Pqfq2pRQIUP+VFyeVoPOc2/wT
 L3Cd+WAUM3wgxc4DYGXgBR7DTbm7l5BLvC23NEOcqQ71GxAi1suvgkHSbvaj3haWHac20nwiwdQ
 6XnY+tsPjJJgkrlKXTRNg1pYLKeIivsgy6nDsADBoWNjsLYULN8GHao8NdZXwIcPKDW1MIwawce
 Cyn/+8a8aBgg9h5Rad4uM/1WlvR6PGLvFJBg6FuL3Tv9c470pWsavg3LFJTBOWO6AR9EXEvbDRH
 rlbqhIRKYyp8FIESALlkmRrxZhYv4XWr67TYyjhBTE34zdgc3rC9rGqgf3TQo7P+ca/UkcH265/
 2w3mxfc/Nmp9SvGCoPw==
X-Authority-Analysis: v=2.4 cv=O+w0fR9W c=1 sm=1 tr=0 ts=6998c93b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=CCpqsmhAAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=V2sgnzSHAAAA:8 a=OGjWj8McAAAA:8
 a=WsHKUha7AAAA:8 a=EO-kbFN1yMwYzJmxc2cA:9 a=wPNLvfGTeEIA:10
 a=ul9cdbp4aOFLsgKbc677:22 a=Z31ocT7rh6aUJxSkT1EX:22 a=UYjydHh6ynBBc6_pBLvz:22
 a=H4LAKuo8djmI0KOkngUh:22
X-Proofpoint-GUID: P7gVTCeGE7zPzD5FE8vJCYpoiNUFNEoR
X-Proofpoint-ORIG-GUID: P7gVTCeGE7zPzD5FE8vJCYpoiNUFNEoR
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5869-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lpc.events:url,igalia.com:email,oracle.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C675916ACB6
X-Rspamd-Action: no action

+Cc Suren, Lorenzo, and Michal

* Andr=E9 Almeida <andrealmeid@igalia.com> [260220 15:27]:
> During LPC 2025, I presented a session about creating a new syscall for
> robust_list[0][1]. However, most of the session discussion wasn't much re=
lated
> to the new syscall itself, but much more related to an old bug that exist=
s in
> the current robust_list mechanism.

Ah, sorry for hijacking the session, that was not my intention, but this
needs to be addressed before we propagate the issue into the next
iteration.

>=20
> Since at least 2012, there's an open bug reporting a race condition, as
> Carlos O'Donell pointed out:
>=20
>   "File corruption race condition in robust mutex unlocking"
>   https://sourceware.org/bugzilla/show_bug.cgi?id=3D14485
>=20
> To help understand the bug, I've created a reproducer (patch 1/2) and a
> companion kernel hack (patch 2/2) that helps to make the race condition
> more likely. When the bug happens, the reproducer shows a message
> comparing the original memory with the corrupted one:
>=20
>   "Memory was corrupted by the kernel: 8001fe8d8001fe8d vs 8001fe8dc00000=
00"
>=20
> I'm not sure yet what would be the appropriated approach to fix it, so I
> decided to reach the community before moving forward in some direction.
> One suggestion from Peter[2] resolves around serializing the mmap() and t=
he
> robust list exit path, which might cause overheads for the common case,
> where list_op_pending is empty.
>=20
> However, giving that there's a new interface being prepared, this could
> also give the opportunity to rethink how list_op_pending works, and get
> rid of the race condition by design.
>=20
> Feedback is very much welcome.

There was a delay added to the oom reaper for these tasks [1] by commit
e4a38402c36e ("oom_kill.c: futex: delay the OOM reaper to allow time for
proper futex cleanup")

We did discuss marking the vmas as needing to be skipped by the oom
manager, but no clear path forward was clear.  It's also not clear if
that's the only area where such a problem exists.

[1].  https://lore.kernel.org/all/20220414144042.677008-1-npache@redhat.com=
/T/#u

>=20
> Thanks!
> 	Andr=E9
>=20
> [0] https://lore.kernel.org/lkml/20251122-tonyk-robust_futex-v6-0-05fea00=
5a0fd@igalia.com/
> [1] https://lpc.events/event/19/contributions/2108/
> [2] https://lore.kernel.org/lkml/20241219171344.GA26279@noisy.programming=
.kicks-ass.net/
>=20
> Andr=E9 Almeida (2):
>   futex: Create reproducer for robust_list race condition
>   futex: Add debug delays
>=20
>  kernel/futex/core.c |  10 +++
>  robust_bug.c        | 178 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 188 insertions(+)
>  create mode 100644 robust_bug.c
>=20
> --=20
> 2.53.0
>=20

