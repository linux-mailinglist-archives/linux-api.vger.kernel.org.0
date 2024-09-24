Return-Path: <linux-api+bounces-2327-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266BA983FAC
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 09:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D931F2108C
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 07:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE0C4EB38;
	Tue, 24 Sep 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dxelY5Sv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lq+o0JDP"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A94D54FAD;
	Tue, 24 Sep 2024 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164171; cv=fail; b=GhqYHzr8ScrzbRxmeSwZ0rqs5oxniwNqj9V73wcvhqvWf3rM5kJI/X5KCk7sGkACd4dWMwNm1WpUorQirs7M7aFTFFlm83z/lL1bOHb5ceBa/NCUdX2XrFsjMO6ir2OF9regeRE4jItQqiONoVzeByAB9othN1oHnu/2qZL+Z24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164171; c=relaxed/simple;
	bh=Pm1+kRcikMNft6arCkfd6uMhg0Gqrt8igE8OUslebG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F09cLojurO8UKR8sud11UavDY35+eqNl3z/xbQex/m4MTfvTuHyoEVv/2Acd1ohmdS/TzXPcvtiePpm2Mk2amtM12FqhxhLo3vh4Ea0YFW8TGyzrNZdmG5GwcUl3WcMLVNUwqfzUJz+nNIvTMwGKai0HtERCoSX62G+Kr/qlqHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dxelY5Sv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lq+o0JDP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O1Ma9r024695;
	Tue, 24 Sep 2024 07:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=uYrhIkLsjJIdmCA
	+tgyk93hGXw+PSVNZwHkRvzMonuw=; b=dxelY5SvR+MIgoYoUf7WeFmBvLh0HSQ
	dL4/oEafgUf3m+V5l1rQiO3dKqan74zPvA5o3Ql1UU76W86JerFzWUb9/Ice/XM1
	WI3e1jOjc/4jjgM9hxYd+HLSmx4TkgGLHYWt7r7yD8pJyxIq8D1+InWbqQcntUI9
	E5fPpTSIo3f1DoIzgXzDMOMefdlLfC78uZW0SsURc2QRFOtJCW4qVAVyVmmARys1
	E3QkmGoslvd4eH2nDoSR65lQfvt+Zj/OKxGMI0VpoQKBztmBKnRu0aYBYHavpXJz
	tCAZprF/iKRQ3MJYQr1vavlmMonLRS89OZWu65WO9KYC7Rew5+eLc9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu6p2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 07:49:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48O6DLMY031092;
	Tue, 24 Sep 2024 07:49:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkf4ktv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 07:49:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOhygwi26oc96DOts0uBTgN/RfSP6Sc9KKA8uwV7oPMOxhiRMh0SZ/JNSb3U+xDxPyjm2YdKCFL2SiKEFS04CrHgsWXiwB3GPNrO+CCfWoaoWQJcff26x6ylhHkftHQZOXFSl7QgaaRSf36IJ6SCbmWjtRzG7p+Lvb0suAr8M1hh0IhhU4Yyuo1o/oA/fNQubZvpMJSZ7sxT1uUvUKQoVddkdKqk39Wj6mXjbYEr4jziFvj7V779M2I7WlfACsvN+SOPxrkbNc0Ju5ITRz8oCflDXuuU1OYC5NEcvC3baDbS3UNv1Jmyuj8b1xP2/xo4yParQ3/xfBowN5L31C+NWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYrhIkLsjJIdmCA+tgyk93hGXw+PSVNZwHkRvzMonuw=;
 b=Yi0DCT1OZzhmwWacKqWKz89hH3U/s1CdvApLRUQsaywfzKcjwhlsdU97qtxb4dQQdfkS9WIIEWbgNWWj9IPUlsf2ZIHiRZM8CGuqatDXiWp2zOVJwQbh9a1J9lfUYIw4R1elQ3eU3PWc9h2vrTsqiWENZvm61G1cYMKVIhSoFdJDx67bZyPJSeFqu7QUY3bMtaYonnnxAUcLFJLP79eFDcDWTP63VdKd07Cf79pKymfU2hUAD1wPIvbTFnoiqS1oQQoBWa2QhzJKBrlMrKcEGJa1yASzD+tleim6UkA9wcBq6aCK0kaITxD7r2+Upz/UlR4p6/ECUJvYJXjoKoO/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYrhIkLsjJIdmCA+tgyk93hGXw+PSVNZwHkRvzMonuw=;
 b=lq+o0JDPMsJQ0mKK148Lr/AtERESqecLxM9AvCWsAPq66jgg1FlZ44MIVGIb9CV/LbyBrJyDYJ2h+zLOew2t8BIJr2bDOfGABa3VpzHXlRyEXUWT/PuFbJFUPlQoli4tib4CjHmlzL+e0qUbSCoOB/+UmHFfej+T22CwTwKM6i0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BN0PR10MB4902.namprd10.prod.outlook.com (2603:10b6:408:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14; Tue, 24 Sep
 2024 07:49:09 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 07:49:09 +0000
Date: Tue, 24 Sep 2024 08:49:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 1/2] mm/madvise: introduce PR_MADV_SELF flag to
 process_madvise()
Message-ID: <c024c20d-17d0-4b20-9f81-f9934d4f151f@lucifer.local>
References: <cover.1727106751.git.lorenzo.stoakes@oracle.com>
 <077be0d59cb1047870a84c87c62e7b027af1c75d.1727106751.git.lorenzo.stoakes@oracle.com>
 <njjxbroy5nvn2gxmvsvk7m23rrsoyih24nhmbmf7lpd5yzwwk7@ijudgtbiwyq6>
 <c44d373d-d72b-4e62-a613-a746a2c290e7@lucifer.local>
 <337e4359-37e0-4ed7-894d-6c88b3498a42@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <337e4359-37e0-4ed7-894d-6c88b3498a42@app.fastmail.com>
X-ClientProxiedBy: LO2P123CA0030.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::18)
 To SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BN0PR10MB4902:EE_
X-MS-Office365-Filtering-Correlation-Id: add1b559-eb6b-4cf4-beff-08dcdc6d5f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EwIFP9ZV63v3Ql6h1hUSKa3LMpg+tAzGb9MJHY4hLiWAXdExqX9gApanZGWK?=
 =?us-ascii?Q?lNd8KPgPmF1X9CzUlCvmexE+JWLECg5Cqs6m0O0mkB8tBHE0o0/ciFK/Xs47?=
 =?us-ascii?Q?aoKHW+XlDHtakhGHwzcCHfAe9yivFsJy1COVmxte1pSlv5CNC75qsD+4dRlG?=
 =?us-ascii?Q?6Ht4Gf+SJSdkSob9Chsfmc6DFey3FHe8Frxtm0g5GUSd65ydRtotnXGe81xC?=
 =?us-ascii?Q?kq6ZlGISIyBB2NbnD09FkCHbkxq5pDpbpvf0gMei7KYG5eYxjiJlL9IbrKtF?=
 =?us-ascii?Q?M6+FxmvUfvLL0fJ2ZylpSZhH2Y1C+SwdGpPAwyp25ZzKP6Q53iu1HOyDcuQf?=
 =?us-ascii?Q?vDP114VWOgb5baWjhTp3vFN9bUkzBo+svaHQy615aPIWMTsP9cur9WSLPOQ2?=
 =?us-ascii?Q?MgFxqjtvzRBTlp7h1BunxcIk0DRuLOgVEJDq1M6gt4B+PFMwPblFS3vGMALP?=
 =?us-ascii?Q?MsDSKmtv5xlJQjUJuLivBYWZV1aIuX+v/bNBQ4MEGi/+1/cj/vORpMeX7Ia4?=
 =?us-ascii?Q?wfD5K52pss2dskhtlFkZ2pjEOzJ2X9nMkwxxyUN1ekiVbPWFh2j7ecfKsvVD?=
 =?us-ascii?Q?FVOQdW+AI+8CKSgI8HeHjjjKKSPto8jk4sal81suALmnZuw8rqcXW7kfA3Op?=
 =?us-ascii?Q?ybmIj1pGaPxEsZ4lRVTgqhMevSm9A5on/bVBM2alwlBABMSCtFTQnnwxFmri?=
 =?us-ascii?Q?u0zq4r8wG1j13aUWNx/j+IF0mD/7JblP1UNQwFGD7TuYdPG1WyxBn2UKIkHJ?=
 =?us-ascii?Q?wbpFC56VLePfS6ZaNmV7VZE+xNzAP7AUh9RJngEVq1etxEuBrbm1Ap7Cajlm?=
 =?us-ascii?Q?/ffUivnVuYeYVDSX0OqQG/OzT2SObyasXNWQ+1YYTZ9uLVdAcvQbMTnJGZP9?=
 =?us-ascii?Q?WR2xq8jdG8UKmMORIDOdhkbJ5FjDEl7WrwmNY31X0tnS2TZvOanm6aa0TOIH?=
 =?us-ascii?Q?t9gCkIeqsIn9+Ja9dU/UBt4UjOLXNNIU4kEwKf8jn8F7s5lnc+b40iGbI+cL?=
 =?us-ascii?Q?tSFeJpSYKLYeENiK0PJ2Nx7JIY20zNSO96dYfGXBs4wipvRSor6q0G4AU6/u?=
 =?us-ascii?Q?53/a6Zzi3VlGglEDxnhi/Hx0qd1SFDVaE36das4lsz8AoT+GMxMx7sQCPjYi?=
 =?us-ascii?Q?BYkME/jk4Mzp1OnMauZ88pAjXmips/dtAksLr6guBdeKNlnkf8cDJYYp4hfy?=
 =?us-ascii?Q?qTdNHnEinGvH8+TrWTF/R5q2Nei3o1f/jbIjIZCFjqzP3vPC3lJSN1if4Mpm?=
 =?us-ascii?Q?UqHC3VIOFUAg4DjegRX5yzqRONrcjHhLJ6llVpf0zYuO1rnhQIBCWxD8RZ9E?=
 =?us-ascii?Q?/wHu+GL8SUDXo7zPqwQN+z55/kcvlE87kHnAP2i1EBucIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ANpLbNpC5HajHYqC8ZxdF2WR3bdyCw1DmfcCJv4skiTSnitmSaKcIaYhp0jH?=
 =?us-ascii?Q?Ogxrhrhk7HNMzUGlT7G7H7Gen0YfshEkT4tBTw8ZSoOxh0J8WpTw7djbF9rI?=
 =?us-ascii?Q?FQUbuSOVltyu9KEvRYnT7z2FQwSPvnaDPr2dgCqxC6SSykqdvXMUAn/Lb+OU?=
 =?us-ascii?Q?X/pnDoSZZWHBmrOGTF0K+TRBbDx91ScgZ82DTL1PAYdyuYvpZCvXzoYD2tv7?=
 =?us-ascii?Q?a7CTto4KZ/V8BdZmdXtKmIMOhaeJoCuqBaGtwOxPSMBUjPJoo+aKez4ufMCz?=
 =?us-ascii?Q?nFm4hkmTbMhZCPzpGO0P8HehPq6YN+CkvUtTSe+iEGP2FcT6P7tP26STNuUJ?=
 =?us-ascii?Q?ciZy3Lav57NCyJ4QnzhLnkQatQR85Qd+BYR27nEbEjwROJCTYc4AkcgiYiNA?=
 =?us-ascii?Q?cMQtWNJc/fkOrWMtv3YZlXtMFYWxk+izQ7j9hXH4IDTjgc98nCsCSzWPnpIx?=
 =?us-ascii?Q?izCOWmp7oVbPoM+yDrAJMu+5GxCNVXyyODzYteAaScFb+qGbQuBsm1/O63+j?=
 =?us-ascii?Q?0vEQA8Ghq2D79ZFWuCNuNvnyuKFB2J3WVklQDiYJ/M5MAQ43lpqHQ3EvScDL?=
 =?us-ascii?Q?MeUnBSh0iKtFNULGZH+G6/cdsXPWvMUk81U+REMgY7SUwxETKyCS+AqEI8K3?=
 =?us-ascii?Q?T48OSSMlGvwtC8n2aOMAVHr5ZY0Uid/ycvg4zZmTHyDxAIRUhQ1feuP9AZcT?=
 =?us-ascii?Q?Cb2C6XU1GZ0h3Q9DvPj8Oh5SDZ4YCggHeooxmTHk5679kA5dF4W//UO7mV7p?=
 =?us-ascii?Q?KTRQGTR5fIUVC8JvYZj8N3QPkPpRJaBy/ZbYI/Bm0nSbXkvrLy/CsUKRRL0Z?=
 =?us-ascii?Q?FDhnypblnqbF9XnpyKCNK+X+s6WfkH/9RRoG8Q+K4V2AKifubzm6T/q3NFLP?=
 =?us-ascii?Q?4SR6mwYPQDL1TYJwNtVAxSyp1TndqEu3k1JuBxDLtEoofK9bEYDEJb7H5zbc?=
 =?us-ascii?Q?kUCmbicOHOUgMq12K54GsefMYVJ3PHoggpkcDB4sp1qHxuTTEFLLY2JmqeMf?=
 =?us-ascii?Q?UJT2EHiAkNI1iyFuJrz+pHw4EuXqcLIQ96M0ncFRz+iOhWjOhX13kzifyicZ?=
 =?us-ascii?Q?p7wPaFHMTR76e5w0vFH1dqRcRpErvENTTcIff6bCK+2I93u8jR5h0pTh5I0u?=
 =?us-ascii?Q?qL3lnBjhGnwVdZuLFqL/4FluAu6e+e2oWlaI7IVzo9v8BPzK33Xot2ynRvh0?=
 =?us-ascii?Q?rfhybuejKcxuUIvwGRvadL/3XR0ZnP37Ie8YdzKF6tH9RSStu6iJwuk/Ymdb?=
 =?us-ascii?Q?ci7QWUkW22THFiJ7hPx3GJGCF6y6lP5a6nqm9aAS9ZX6jw/X1asD2trqXd0m?=
 =?us-ascii?Q?dWDnSQsQweAMLQZV+lHHx2mWV99ZC9d1rRnKCCNGLDN4GoFNve0z4b6GhQzi?=
 =?us-ascii?Q?w4RciMSeLOB0aiU5B/TdRQZTTxqEdpfH92/fS4jZNbF78QpJSYy3ca9R8MZu?=
 =?us-ascii?Q?sdgBpeHs6+U+DGqnlm4KAT1g0mKwvUrcliB66toETSKIX0BbDs4eVC8k9ocU?=
 =?us-ascii?Q?Fzg8+gjYqQNtGV753cizzDeAES2Dg88IAzIMVeD1+pkNjK8Nyt3OLRNW9rbI?=
 =?us-ascii?Q?XsbGVNcqAnGQWPJaBvhXwjE7ayvvRX790mP0i9IQTLigYpHDMlofJkdkF3As?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I/VcLK+X1pfpGsmHIAo12Rfbsb4slkPb4Jd3LqhlAPu2wOBMQdOaCrh4PC5LFGz2QvoWl6P/UWyvuwKP2WZbc3Q3ZC/lTWO8+7vqM1fpMWPX6IJdqb+LRjJkMrdZ0Ps0HhixlfShPqRQpvMt4RDgrm9mvorXuRF472/F+E+TfRe14yVADzVcn//cQ4NFePHWpATXtEqGcEYNZA16e1NYz+BwLtzvm7xkN+/NdVMMrH2mpfvYsZTq6kyX24IbFx8BFmA2Nr5Xce6URnAa7GjgSeknN1dOiHQXhgpiQAoLRRKpuJ9G8Dy0SVKkx4YDAyV/s8BuDILhfGIcIV3OVk0tiav++lqoBdJMREyXAWjqlcylzSSJQhk4NlcqSCfAsiiEyDIC/LFVUr8uls0iRoVS4VijYBNJyuWH3tm44u8F/7NuON/eAKAF/xrfgltGw4fTPZKSv141Tojs1NKdzT+Y9vjh6/FzymrcCEF0EaIQHdgZrLBkJY5nWdi3fS2ikbgzxUNCqgNUUtCK/Nn6MkPDGZOaAKa5b8SrH6dvxQrUCBMA/DIRXtx2Pw4OupeBLgfM53rjnk1doQZGfkw+FXSsCujr5n+uDq5eRIpNEhuOrCU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add1b559-eb6b-4cf4-beff-08dcdc6d5f8e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 07:49:09.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mlMZhs92VfzZP+svCZbG9mkkUhJ04v+uFwRovjMDjeVN2jkSDinNKKNasosKF1ZXGwXPkSHOzVzQG6mbx3SRRMKTBg9ZJorXxmthKClbwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4902
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=419 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240053
X-Proofpoint-GUID: n7XoX8cd-kXGABeCEfx4iJduKDARRROF
X-Proofpoint-ORIG-GUID: n7XoX8cd-kXGABeCEfx4iJduKDARRROF

On Mon, Sep 23, 2024 at 09:49:43PM GMT, Arnd Bergmann wrote:
> On Mon, Sep 23, 2024, at 19:34, Lorenzo Stoakes wrote:
> > On Mon, Sep 23, 2024 at 11:56:06AM GMT, Shakeel Butt wrote:
> >
> > +	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > +	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > +	if (IS_ERR_OR_NULL(mm)) {
> > +		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > +		goto release_task;
> > +	}
>
> Any chance we can fix mm_access() to not be able to return
> a NULL pointer and an error pointer?  IS_ERR_OR_NULL() is
> usually an indication of a confusing API, and this is
> clearly one of them, given that only one of the
> callers actually wants the NULL value instead of -ESRCH.
>
>     Arnd

Agreed, this should be fixed. I think it'd be a bit out of the scope of
this series so will send something separately for this.

