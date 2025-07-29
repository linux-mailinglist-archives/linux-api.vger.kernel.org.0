Return-Path: <linux-api+bounces-4262-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B0B14EB7
	for <lists+linux-api@lfdr.de>; Tue, 29 Jul 2025 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287D916FDA4
	for <lists+linux-api@lfdr.de>; Tue, 29 Jul 2025 13:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7351B424F;
	Tue, 29 Jul 2025 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EY7u5Hj7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yjqiiPOw"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2253199385;
	Tue, 29 Jul 2025 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796951; cv=fail; b=JFBtnZRRTwQ5ME+HDTzqdwBg2F5HOMstYvgnbI/DPV3JuQiqyA4mbNuRdUJrTox2PHavqD09TcC+PK3gamhRGND6uVoLaJruHMKMT1h5j5rdYuW4WHsJfiFGaRKYyL9ETRArcCirm6W7cKYlDkVPgTANBbPD5aUOGPPw26dSUuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796951; c=relaxed/simple;
	bh=lnif2uSaPpyvgqJD51dksKL++I/PqbI6Mrkxw28FnJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=doVMcYGgsw5hNBTIi17XEhY8XAQFDJwf+UQRznsXJl2TV8aquO2unkk5tss24nV5HK/AZi8Q5FTZi7aLg5r0dkkc/kuIpbXzRJabvyM39UVpQWTdiCLmxhmJjnaN/EUiSySmyedNZDmpAfZD3/YAlXB+9MPtgjWnkQXNMHX99z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EY7u5Hj7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yjqiiPOw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDg78A027803;
	Tue, 29 Jul 2025 13:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lnif2uSaPpyvgqJD51dksKL++I/PqbI6Mrkxw28FnJY=; b=
	EY7u5Hj7ZJaAaDrp2ppa43neGX6/BPGJS3W9P7KHPBvHjxTq4mBcar8zIoSVSKJo
	jbZGudihzXlHAnqCRW29rFUiwA0TcN4Osj8jxPyl5mi5Q29DlnvpUXpiK8/ABIRy
	n4T80P+7ZVx7egLF8LBhk+LCZqJVCDcdk6o3q94ZB2fnWo5HLnjwVN3F9ZPw2rML
	cJU26teAcKCPOsq2+BjtFlbja9BXU04cPwYGdL502Zshwf1Uxh4h3QM/c1XEbw8g
	bAEuPvYXex6pqdY6jPE76wN9B7CIfGrP34G8Rv8b1erowr8x/01G+D4qv3zCODeZ
	5OnKDXW90uhinGnWa3WoRA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q29qtff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:47:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56TDLWum003097;
	Tue, 29 Jul 2025 13:47:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2084.outbound.protection.outlook.com [40.107.96.84])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9xwqx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 13:47:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POdqsM8MLxdQbhQ7V5m1+PqgS0bv164UVmsCuD/t8RPL5eDjSwBffOe/WcmKd/s5PWuw/SV5sgcR141vzQljC24l9kRJl5SKVdFALR0Iqmqh/DNa3ys//m+NOx6MApYvmbtdanQVXqHE9yDD7pe2eeQw4HIHcTrivWORssT0IF6kGQspLXEqd4xGwkXXWZxf6nFKwWwjRAGszMDxUObEthv1gUVswoNqPazLHwuBO0j4a2AlCwk2lneZ9cHtyXmXBnAV+ms/pH0xJUQqUVpoSouymvi7RO7ecIpeDjeAdSmQnTFCVtXhicOyA9x1MwZnu8fiPvtgynt5i7iXvJFUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnif2uSaPpyvgqJD51dksKL++I/PqbI6Mrkxw28FnJY=;
 b=c8b9kLY7In3cVvLODXNqg7QbxVnuS5SWOdToJPD19yyxETQM8u4gCzzDFwMMBdj2RByS2bsB3h/7n3F/tb7z+QnyDm0bGRbOfpftvEtaqpZnCPGBpGk1YbgpE9dd9/4YbtnZrHos1tZGGMYHE0tvYgQQDl/Vz+/dK9czR7ppXH53+xrxwKMui52rUAdlFkCx4IoCXJFo4rr6Clldxevtcv56QoCgM/1lbnlgY5WXPSENyMIbOUjMbBx89m+FeJ/6OdkHUQaZSjYJouYmnWz44Lz0ZpgcAxl56/jQePqGYa8fW6fdllsNUWUiKK3LLdnaV/ZsyWpVlh7kRKfipJtb4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnif2uSaPpyvgqJD51dksKL++I/PqbI6Mrkxw28FnJY=;
 b=yjqiiPOwnOZiTeRzATgoDrI/LVBxj6HFCxtdnUf9Vwu/SI9O0drQkJjh1cvi3xkxKnr5QcMohHUkZjG+jJBw3QTHaEl8nvazGMpbvDQSRc1qsjXV3xWqGI5kU4Jn+U5YbFMe3fZO62nC2/OMJaAovLcxiMH2FB+5VOgVZdfvGxI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH8PR10MB6525.namprd10.prod.outlook.com (2603:10b6:510:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 13:47:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8989.010; Tue, 29 Jul 2025
 13:47:49 +0000
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
Subject: [PATCH v3 1/2] man/man2/mremap.2: describe multiple mapping move
Date: Tue, 29 Jul 2025 14:47:35 +0100
Message-ID: <1fd0223a6f903ffdd8ba644d0b67820b1921671f.1753795807.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
References: <cover.1753795807.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0103.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH8PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f4ff01-6453-44c8-ad04-08ddcea681b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CQA4IDxTRTt6vOx1REkNJVjbQn1qFlKNDKAXKwoVb+p6EFG6XSjjrhXxyGWo?=
 =?us-ascii?Q?tRMXUOdwYPqOq2WloG0OT25QYkWeBD8ca3/5HOIiQejFtlwEE3fXN46pl4z2?=
 =?us-ascii?Q?jHwg4KLfGerHjgvqnE5c67yY9hZPz2jpG2TMnoGZKBlmdpYKAsWKC6RcjbHg?=
 =?us-ascii?Q?I7vcxiePx/K5BevxinZjF4b+lvoboNLtT2E8B1yHb9r/51TF22i4fFyzzDT0?=
 =?us-ascii?Q?ms2EZYcmhZBoNV4dcBKoJRaSHJLCQjJxbvHDEPm0u+O1BgXC474pNPkSlTTV?=
 =?us-ascii?Q?nX9q/cgDrlmHfxDl88PmqA0uwqKzFIG9RxdwShrNYQeqbTBjRwmQKNeKIiGI?=
 =?us-ascii?Q?HF/P06EdleH35p8T8zioHi6IMO4Tm7TOLDYwv35uYmp3YSpYRfbiXfHXNVgJ?=
 =?us-ascii?Q?XCaGeSb2romD5hxeQsak4LUAW9O/3c/yt03XpAPA79+jqtPFniL0j+scD/Bg?=
 =?us-ascii?Q?l29ALgH1ObjLDQAQ5Nk2xDC67t6xv52200NZNsnocr5xyXoLBzmHWQX5Ygz/?=
 =?us-ascii?Q?9XkINFK4Su7hn+0ynhs+A0akj7iEmh0Zx7b/akV3wgi0/KlsTfwkp2kEpk8y?=
 =?us-ascii?Q?rvK/2qb8Lzp59LF9deBv9QmKIOUH/XAIlmt1jU99Ptr5q4XTQ1cPqYidvEf1?=
 =?us-ascii?Q?I83QEEMHxliQTLtQBT2oS47B1+39Q9zPNn0tvKm+1wm4kM0CzpHt01Rc7dri?=
 =?us-ascii?Q?+hEDw9Sa7AyNK5jaBrXN5fkFWc2dNCK5bQSDd7J59M57XOfkseGInS3EAd9P?=
 =?us-ascii?Q?evRyac+ycVJkiYYfRPDUsePabsE4BYMJ38y1/7Ws/xx7g8Waaw1MckDQdxN3?=
 =?us-ascii?Q?cZSj60x3Rg3lA5qrCv6hU2xoeUktRbtKZ9u2EG6QrWjOUxY3fazxfYQSB9j+?=
 =?us-ascii?Q?+5QHb8+Bgyowjm/hh9C7llFrcU3IpB8NjZf+/Y8YpkUD1UtBh7XOvFko+Er3?=
 =?us-ascii?Q?hI4wEI983XTppJSgyEgtcFcATVTsaFGoWzMA/Z6k5rP05Gs2CnOtBC7k9YSf?=
 =?us-ascii?Q?EsdTrZpCft0eMAomJQzFP7Bk+criuGsRv3n3LfvhACSJVWMqj7MwlXpk4g6X?=
 =?us-ascii?Q?si2sDazA5XZTaeIZX3evMbAkvQeyKreLVNDqyVB4Q9QIr/3iXC9h386G8EuN?=
 =?us-ascii?Q?+RW9JkAhg0HkfbGMiOzFVw/N/dRCEanyY8XacMzDYe9cBKiVGkL1qQO0lV9E?=
 =?us-ascii?Q?IWftXiYI/SVtKp0pr3mj7KWO7KBkENKDlPmSLMC2Q2+/0n8/rpMLD1QWojou?=
 =?us-ascii?Q?CC+ggEKGdAdCV0duNInQA7CY/A/l8XPP5lYwRanmk53pS14c8uJL5AYZUZyu?=
 =?us-ascii?Q?xudRqgHNHmZY6v8mW30bsWPrOOVjOMq+R4O6pDtLmI367NogKaNW2Kiwu1ku?=
 =?us-ascii?Q?l6SaO7Jrij7NDlG9NjET5GXItqgOJMDI7fLLsraz5tPJCn47soceL2MDrmIP?=
 =?us-ascii?Q?90ZuxPykndI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Va+YPTOKAm8UuTq41h9dtfkkxbHFQ1NSJt4EgufHrUWp6+xDNpgPmIa0FbLq?=
 =?us-ascii?Q?wMwldspy6rpli1xk2G0FZxvuJ2qJXHpv2nIMFOGLO2bIsIDN3aHaFyBXCATA?=
 =?us-ascii?Q?sJDJXts7pJd7VArtC4Z71ol2P6dhB6ywVtVTS1I0WVZ1lehua1t+nO+Os21T?=
 =?us-ascii?Q?5DMzPbgcu5gADe7+CyIbhXivdBGu8oZfv5tMsrhdgpPo3arlgha6gqM8uQ/V?=
 =?us-ascii?Q?nXDycW39sT/3wqryxid/7Sjqwwfyr9af4dPZRJ7ha/vwFZATDM5Du2RUrbvu?=
 =?us-ascii?Q?Y2X+T12uHkfmT3f3IbHI5HA0ynK6bsHgHx08HHJhbMEKSC563ZuGDWGCmiJm?=
 =?us-ascii?Q?i1L5fg65EMy59sL2ia9OM1w3UDy8jDZK3RenJN4JfcG++t3Ml0bQVKQG2HOJ?=
 =?us-ascii?Q?v8cTCuz9pD16a3jhbtZ2CkOITBQ0FYtjqBChDBOA8Sr4Gd+Jib/1Iw25Z+I9?=
 =?us-ascii?Q?f+frMdS2ssuWY2A1CFs/73z2GtPa3qg3N3TMkfUnG8bTYN9k4uFzZDlGh9Ao?=
 =?us-ascii?Q?euCBhZnluoSc0fhnY5NlXM6aV5w/MNOKW+MDMSoF1QJC8JLabBhsKf55mpQi?=
 =?us-ascii?Q?+mAds9Z2yg8I7VeooMTCSlytXe55R1Yq8OM74pF8D95CohK62ChYos4sMeM6?=
 =?us-ascii?Q?xZdqT0SktHZZBjmkBxwaJegPAIoOsn9ulRcImJpDbnmbosT04Aw0b96JLmqB?=
 =?us-ascii?Q?B5SAuEjQAKf5yqrXszIjRu3eOr7i6eP14PMrr8ogltvVd+tBr9PT8x6xQaK8?=
 =?us-ascii?Q?CeHS/io5mQ9k4SZnVOsES+DCy5GKipanjUapwHHNEdyLisj0W7AzP1NzYkyh?=
 =?us-ascii?Q?ME5z8M5uC7/xKdejwId1XshX6jL3fTaQBN6snpYFeP6qcZCCnQfPbE8ewV+n?=
 =?us-ascii?Q?izDLumCISrD5Flx0gMIlkj2SCWU/8cK2QRuCPaiSW9Cr0FoZ4Sk0vUTG6Fvr?=
 =?us-ascii?Q?P28hDPhmu8llNpmdjKv9ffO38NMvJZ2N+sqkJBx5jHdJsdrrZMMKbXi+F/M1?=
 =?us-ascii?Q?OvwPpzuOwBnUP960S5KvuBByHX/enMTZ6i1gB1fJBHKSIHTwpOOM6ImjImRU?=
 =?us-ascii?Q?Otrot2BU3GJEhZ7A1MJ4cZUfd4OF2UuQcaGihCjAsG0l/w43NunqKJye6G/N?=
 =?us-ascii?Q?q8yGO9va8KSLN/5BYLTKqYQScTtR1E6Iyroe7VX1AgJFCbZNq5gcLXOtNG6M?=
 =?us-ascii?Q?+mwFeo1a0p7wuhTXtgACd1lIWuK2/yIB3P/peBhIV43YsjqG0Y2U4GBqI4ZK?=
 =?us-ascii?Q?zU2lpqJzZ7TZICQK0lTtEmdH+Ixdmq8yhGwLt4yitKiT3ijFkB2PqFkS8wCa?=
 =?us-ascii?Q?9p9jfeO5sw222fr0HY+g7qnZPT5eN0iJxFOd77Y2/rr1IKatVSdbyu4uyPR5?=
 =?us-ascii?Q?/JUT54x31D7mH8VpCZY814JgxKedo7SNc/5+54gtaIS/vXcKIZZuXsSgrhwE?=
 =?us-ascii?Q?aiF2FBaFWJg9MOqlFdwrUzMWnQV5D19RrD7pafoLqC0LQComL9vZvHTCdERp?=
 =?us-ascii?Q?k0ediFtK7O+grUcI3utNCU+XcnUbbV5ZuqcThZLtkL/6LciqoCAu/PwKz/8g?=
 =?us-ascii?Q?S3/PpDncQtflmFPA0mAEDi8fD5GQFPxVqvM9KuxGytdKzO4YPxg1bJYchGlJ?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LGvLSJOLk0KZsWlK4iO7OwMgMNIvaprcWeP75QOj9z+HjWbSkp/kQasA2bnO7FdC00PLqVPkILZH+OyQRtYkBK9Xqo+ArW2hRlGuCaX+RzuYF4HvaYrG5vHC90qxjos/KOa6Ra2b80dI04l5VAtCeaOgBqM3CFG2/8Go3oXxd6qqH8iiC+gKBz0dtROe9DB4ATOH+k1X93WBgd02HS5A5v1gzMkKFxjk9ET2rSM1x6pdcfmQWh4lBLMkHdNgRRbH9GgmeR+UFzqj4i3OMx/ie573KimgHkzA4rXRhHVspJJPhpiMyIdORkJZiChmGMUPwUAoZMpLPJ58ELTUGm9rcAk9e6a6yzTboIK5APdeBLazf6dekNDnSV4jBV6jHgrKSTXuVfEU9qVNVhqWV15o4pvq9LDdRa3zAUABKns+lMpaQ5c/VBxe/w1FXDDTbn431/PCSKCRxjHpqzuaw+ZbVAPmgEXdyV0g1/D5taeNYrfg3EFWYOlMKczX4UmXbEQuD9NtKAoPnpi7oSwCJVvkIPpJFNf6Tn1yanSbAYvPbPfGvnmwL24/Un28Q4zAeLyZy+UZ2lTMEYcyKDTuZM5ydZNYBMYqRZQBdVNJHn11j40=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f4ff01-6453-44c8-ad04-08ddcea681b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:47:49.3970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IY169/nX8NfvNQINA7TjCoCI+5vBB59FjPbfnW/rV41rrJ+7hD5suEDUn2HjJwLUpFyeM4x1lHapV0Ed1jxOyoXrqcXvrOBVEHm43gIIgCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290106
X-Proofpoint-ORIG-GUID: OpxfeM-Dgp0TnIroA4T0eKScsFGZAcoy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDEwNyBTYWx0ZWRfX3LaZg+V0XLV4
 UUKCsF1a/pimKdf6L5It9e7sSpiTH8mkTKpNIojpjddws7QS3xAwWDzxJewJEm7vpVJBPPGZjBa
 204+5zqgosxqiCj8nnMBrOmz1rnOrA3BRJf4qUQVaEFDRzlrcGfOsou3p2IRRPEU7GzTXP1gFvR
 0Ol1XJIHmnrnGZFY1KYE82wu0FGYD3Q8sXC3WCeCPre6YzWVvjxZlJZimfNRhwwVCMKnn8PMXhO
 MoGZVpzrdoLq7Oh0jHV0BK+HLBh/L1ovlvi01aFUxvI3FLCcsSp+du6OhA6xUEtECe3OB2OBQXf
 cl4RmeZiKHrNbGlZ6Z1Dd6j6bDXpoOdt3i8s+ayQVVUQbWAqzg+dAcTGKC3PJQruuC2xKrVsLaO
 ELX3IJEN3Hq8X98PYBMnoElWJ64TjrXcXDO46svONybsz9hJjcy/hZ4LZ/WL9VZZKwLXjlbf
X-Authority-Analysis: v=2.4 cv=FvIF/3rq c=1 sm=1 tr=0 ts=6888d10a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lKaZF-82tXxBJHMFsfcA:9
X-Proofpoint-GUID: OpxfeM-Dgp0TnIroA4T0eKScsFGZAcoy

Document the new behaviour introduced in Linux 6.17 whereby it is now
possible to move multiple mappings in a single operation, as long as the
operation is simply an MREMAP_FIXED move - that is old_size is equal to
new_size and MREMAP_FIXED is specified.

To make things clearer, also describe this kind of move operation, before
expanding upon it to describe the newly introduced behaviour.

This change also explains the limitations of of this method and the
possibility of partial failure.

Finally, we pluralise language where it makes sense to do so such that the
documentation does not contradict either this new capability nor the
pre-existing edge case.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 man/man2/mremap.2 | 84 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 73 insertions(+), 11 deletions(-)

diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
index 2168ca728..6ba51310c 100644
--- a/man/man2/mremap.2
+++ b/man/man2/mremap.2
@@ -25,18 +25,47 @@ moving it at the same time (controlled by the
 argument and
 the available virtual address space).
 .P
+Mappings can also simply be moved
+(without any resizing)
+by specifying equal
+.I old_size
+and
+.I new_size
+and using the
+.B MREMAP_FIXED
+flag
+(see below).
+Since Linux 6.17,
+while
+.I old_address
+must reside within a mapping,
+.I old_size
+may span multiple mappings
+which do not have to be
+adjacent to one another when
+performing a move like this.
+The
+.B MREMAP_DONTUNMAP
+flag may be specified.
+.P
+If the operation is not
+simply moving mappings,
+then
+.I old_size
+must span only a single mapping.
+.P
 .I old_address
-is the old address of the virtual memory block that you
-want to expand (or shrink).
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
@@ -105,13 +134,43 @@ If
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
@@ -149,13 +208,13 @@ mapped.
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
@@ -188,7 +247,10 @@ virtual memory address for this process.
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

