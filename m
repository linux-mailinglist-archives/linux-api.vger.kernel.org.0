Return-Path: <linux-api+bounces-2349-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B5988043
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB541F220E5
	for <lists+linux-api@lfdr.de>; Fri, 27 Sep 2024 08:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D107018990E;
	Fri, 27 Sep 2024 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J2MzhK49";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G82EWpDb"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B118990C;
	Fri, 27 Sep 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727425432; cv=fail; b=gfj9dCbEvkDrl6G8sO8pn3r5T3CpoLvMfBz5BMBOAvhkmAgP43t5TKs8utVcL9/JO1iJkvC6Xwdm2Y6yMJi9MdQyHZP2XFFcY27/soEafQqpT+6tlgY5/y1PF/AdLDOzmNW8Y+lF37rrEWez4/3McjoP4vn0CWDvJhv+uWAsmP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727425432; c=relaxed/simple;
	bh=swZku1yTdBH8y6P/xwv1YVJz2syAMbvL9yv4zh2E5s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OzP8Y4u/JhOFQmiqDz9rSGCjKqy/CXHWXxJkhL48SRh4rHwQsCddGsj1suyfI5ClPANUkw5UP7cD3s6NUKj/u9WCx+sZwXOz0rBVwwIWlB1c8A0iYc5k3lr0Z510LBlZnrTorCD2GKZWnus2zDlzL8PMfAiY8bpxPKXpMVMHvrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J2MzhK49; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G82EWpDb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48R5ge23011491;
	Fri, 27 Sep 2024 08:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=swZku1yTdBH8y6P
	/xwv1YVJz2syAMbvL9yv4zh2E5s4=; b=J2MzhK49LiWfKM2S1vKe2uvRWYFw85k
	e1r9xoo2g4r+NxMWeSy21OYtUeo4JEW3xj2IdfBZMxrRxzm24BUmhIYj90jXAM4c
	jSCJPGxakUq/CcXo4iL/JlV9WOEQsPeFjtBDSCMoDAgx3u8Oc0eSg42m7aUswDJZ
	4ReclsvweXZCPN1pk9uncp1eCO2FBuq0I5D/gJh1VT2A2l6AQ/bW17yoKnmvEDAv
	TKK/QtQlRYwr8tGwDsZ4Sz6pxFuNseiiq881Ya1/hqk645fIXUhAtE5zaTQ1vvVZ
	ORrHgJH/sGFLTgem3Uh4R+8NEBy6VBtQRu+ScZD+82trg7CaH+sdo0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cy80m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 08:23:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48R668HR025243;
	Fri, 27 Sep 2024 08:23:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkd9h77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 08:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/3QMyoOFHPQLGl0+/qpKNHYP0UFheIYLbtudegEqMlZfdNSSh6icFpxZIoLEcjtRfK4QWNFCbeWLDp+J+iBrQgfWa4b7wzvsDZ9ji+/JhPvwEvmvdTpJ2NgTAc/kX2g2TGDm6RBxQ5sn5cm8CLXAu3Qrrm5PcpkcUMdoPUNESlmGhOQBQv7f6wdl7Pzv/zdH2bZr3ITNuTu/RlMXXNkGX5oEVARrfTKgVWfisLNdrPvFa4Gxb+nmUraKYlQT/863c/Mt1f6VcCu3hliM2ocKnkpvqteXvnd5PVnt6SJLyU/Ehugz7DR+NHlHcYe81MK3HWJ2J9UKbKr/+ZGPt3PgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swZku1yTdBH8y6P/xwv1YVJz2syAMbvL9yv4zh2E5s4=;
 b=NN/+tXVER2dhgfk8Az8LpyLT2Kwp4i2Mawu7vPYMNxA9pHZq/NMJHP1kHC0BOxdgvsByeYhc7yb4dFqyFOcUT5KSsBVZ9ZG17wG4RYBgo72VkXo9FUu49rgZ0WFGWI95lxwDTqnbLxFgV0/jWxQ3Ualdrc6+EN7JT0PhuVnmwprIAl86be9MLlul+hv0eF/RsKviREWOpbpWHWHTkdvjCfwk3iU+hPnYQz+UyPPh/VrYb85t9cxT4DTKxTxXFgjWkK7emZwChA7QY8ss9b0Ac5bNIRWOcb1Nhm10ODEmZ3k301OhLq2uKeB0pYfb6EDwpVTyywn3ibc2nA/oVz8b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swZku1yTdBH8y6P/xwv1YVJz2syAMbvL9yv4zh2E5s4=;
 b=G82EWpDb5GbOwEUQXOB1MzQdLDHLqsRiDNsWdrjdlyVeO+ikzS6ChV68hpG6LMc+FeDxJGhuYB+2tCAcO+1h7Vx/Upjg5inND0y+sMtVPPcRKpisCIXA7INjKAI68/eyh1RITKZdQI/ccdqpSDG0xJ0CMMRmU8/V6qo8PAfRnrU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BL3PR10MB6236.namprd10.prod.outlook.com (2603:10b6:208:38f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.9; Fri, 27 Sep
 2024 08:23:30 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.009; Fri, 27 Sep 2024
 08:23:30 +0000
Date: Fri, 27 Sep 2024 09:23:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Shakeel Butt <shakeel.butt@linux.dev>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>, pedro.falcato@gmail.com
Subject: Re: [PATCH v3] mm/madvise: unrestrict process_madvise() for current
 process
Message-ID: <3f8ddbcf-6a13-42fe-88c0-69fe981b6017@lucifer.local>
References: <20240926151019.82902-1-lorenzo.stoakes@oracle.com>
 <c96c4cf6-e007-4a19-a830-4a2a073620e7@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c96c4cf6-e007-4a19-a830-4a2a073620e7@suse.cz>
X-ClientProxiedBy: LO4P123CA0698.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BL3PR10MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: b67cae34-7924-43b0-6306-08dcdecdab36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4RZ5hL0edrepkpA2rFwVOpzAqkvgb5ruS/pFppfEf5zaXJQevBTgmoEvmriU?=
 =?us-ascii?Q?xL4C3ajEKwTz1APjgFQl9sPelwoFqxXfSwDeBSkXOAlHgwh2ytWZjbzAYgCe?=
 =?us-ascii?Q?B9LOGEIQTi3ympyRs4LGavylBVS3GyBRj0hnt+8Ojyqm30m2D54UHP/D3jFP?=
 =?us-ascii?Q?FuDH2y5rOWVjPpTmBTkIT9UZ6M/uZV5nttoo3D+r4RczlOn1+EOG7SnBNdnw?=
 =?us-ascii?Q?fBPXJHDWT6WAyCjWDXK7H1iFdJvByCNY9Y3v7bQGH1UBi1N7AsgKB5o5R9cK?=
 =?us-ascii?Q?MfIxk9vbSeOOLAdx4FjfFh40EZ+YViowmDjUJIBG5vD0oBySPWsTfg/Xgl5F?=
 =?us-ascii?Q?cWwoZx92ZHqCdNXAG55XgRWnK4XRWSJDfCXUiKc62LVZe6T+W6w31a7GBtvm?=
 =?us-ascii?Q?i4SV67r2e/SL5wtEoT9f25CIQZsGrxGajPgKeXJ+8UV4yQU4ZZBvnprXQI3K?=
 =?us-ascii?Q?E3G54iI4zC2VhDx01lyUxwaMkn+jvWUHtqBWcn/zVj6Df0SWK7/OTi/31WCF?=
 =?us-ascii?Q?zhaTzkm+xkq3cS5NSGyEqrFfXnvoZcf4I4YNxT/msDdi1QUU3y4jZEQG6jY8?=
 =?us-ascii?Q?Dinxw+uVcOkS0KBjOFSOaGDWl0UzFiIs42unhtfSFHzK8fQLrqqhSI2pu0iW?=
 =?us-ascii?Q?AlgsnIYiD5O73QCXC0MZTg7VKR8tOAyqq1E8zCc+8PuiTkJLpA0a7bduECa+?=
 =?us-ascii?Q?R/+0MRkUKJh/Fa0khxDDM0b/DNOOLVPn0g5JY77j3XHO4uz91XTpJlY0rF+s?=
 =?us-ascii?Q?bWt5VrI/iZ2QJR7+CDpO6zMo8bQAewmfk+o/qDKHsSQpu6326i4iGglAiZgW?=
 =?us-ascii?Q?ZRv8HbEJ0CgfT2er4Z9v82GIOVaHCc+e66Bka9C5SlS1XfCaG/yPuZddsNVq?=
 =?us-ascii?Q?vTXbZXFL8zNdUybwIHNPKfor+rTXA0x46gfH0l0mqFhqekFGa8/OALdu4Npq?=
 =?us-ascii?Q?wQIwmjwxU4twEsjAY+EyPkHSRQh0A0KK5T6zjdcr3wgorRAFquoJ5hifPyaR?=
 =?us-ascii?Q?YRRJsEVUHczSxP3uPXaxj/jPLWZv//rq91eLmubMlzrBt/iVn3htyftcmuPE?=
 =?us-ascii?Q?HFSo/pXt1mzbM/eHH4qvuPWV2+VZn+kTcLAk/oQ2y3Tk8z8qaE0sveEqWJAB?=
 =?us-ascii?Q?uQpumkwMvDoVvplBeE/kNQA/LeH1kf/Tg+CoXLu7FTzHB/3bRmRFmBsnAJUz?=
 =?us-ascii?Q?BwsbfoQnzq+/nk+XuqIxQuUt90DHbGraEZ3vKAnTQfIOEkf7ghnHNjgyja5Q?=
 =?us-ascii?Q?L5mPrZJNQapT0wCgzesN3iVN4AOiDbp+HKg75h/STw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2QB6X9v+W0M8tuYSnzorZHfTNFXdhKrsKOjBmyVUBkL1iRU2EIUqCo/ND/w?=
 =?us-ascii?Q?Xg28vw6mBweb6DpkVcf0s0WSRzATd6WUb+SzkXG/CnhhTV5jowF9f7xpAkTQ?=
 =?us-ascii?Q?fXJfiOT55+D0q4MJdpQF56MSl+yVHCECBhn6FddELcywL6tim2IwW/ym6Yxl?=
 =?us-ascii?Q?AGbbOL7fr2Tx6q6L33ot2ORBjX4tk9/JIe/P+EbPjJB2cRPYi5Jwgp3Xu9el?=
 =?us-ascii?Q?WmGJ9EE1tCJkzFY315106j6lyjg1YutlnMerOIeE6p/Oamhfdt/U9gWU8Whg?=
 =?us-ascii?Q?CeXD71i1ewDQq1exZS4CfYRCtMov8PcaudaB0SybhVb0FoSVyjlbAOYFgMJO?=
 =?us-ascii?Q?y7SYAAyrRZmADsJH0LN+cQLoFKDcQ2py/q6k3f4Jib5V/7SYBLNBcOvxw9eq?=
 =?us-ascii?Q?woV0QIAhLxJhb5XcLhwLyFDLY0kTC82H8HU2fbBWa5PSZTmKwRdAUE49G1xZ?=
 =?us-ascii?Q?G/GQSPvoVzrY6F9AuiM+wuBZVTfV/HBadnV5GOfw66GuWQ8Vgm64vw8ZaDD2?=
 =?us-ascii?Q?fN8vFZiyogcumgOM0fh2bU9Lju+5AJUo1dAv3B7oRi0NQC0RSEPamYfIsKBJ?=
 =?us-ascii?Q?jdqs01K5HVMyXT9jhGGyyiV/3KtgCaPHAqkTTGe0CsDcgL+vivSDzRQfHYSP?=
 =?us-ascii?Q?RTaAuXIJn6U28TqFEvH6W6BgUJ4dAgy8EIhHbhIFpY9fwaYpPi0bjQHy9E01?=
 =?us-ascii?Q?YKENGi9HIVyYzx/onskyZLRmLotG6wRn45nIldj16EruccLM5nP+zMmOeFR8?=
 =?us-ascii?Q?DeDmdzWKcBv97MBCJoJ0Fu3vUWYFRVe4B0ojtCOTZKFqa05EHVtFQY8o412Q?=
 =?us-ascii?Q?gTvYbTMMeLpZCrzCgLXfB7gWC7QBEW7yiQRm6cRxisAQ2gmfEoXmXKGyFdXD?=
 =?us-ascii?Q?oPkrQgo2IxebkAWJjcMDfCDBvfTSBAFdfIvXtOjZSxz8EMlMthkzFlLBt5zq?=
 =?us-ascii?Q?eSHCHI5PquD8vG1UAIJw9BnlWxXe4sCszTH3oysI3xShK51FEaHubBhpLYNc?=
 =?us-ascii?Q?G0xwkUgm8WlH5RSWcIbA7Ih26lAnbXdn8eJVHRuOBgY6QYylEfW19wWtKRP3?=
 =?us-ascii?Q?bsiywPzY8q4G1MvhEAecsC60EWztoENQgpn7mXFy1S8UbXpp8TSf3Yp6IM3Y?=
 =?us-ascii?Q?XUoB1Nl0422lg60JIiI1ijRRC2MTuC047GmHUiMkLU/9AKYUFOfiZbWtBnq/?=
 =?us-ascii?Q?cTqnB4qChIyVNLE/hD6pQoMZ9zCX0mPw450jCpcmEVzRcu7vPrLfWGCk2TGs?=
 =?us-ascii?Q?PQTqJxBPgJy7IbyXmdfoQnj7RKootMhdd3fz0ZxK3Zj8gzizBgE6wCxhmR4F?=
 =?us-ascii?Q?+7TXv6VP+J/dHrlcAq82zE6f59PLIUSqW6dwApWGZgCc/d/VuMDatnj6coiT?=
 =?us-ascii?Q?DJnUdI9+Vv+8MTo2+1O0pBw9EjEWMgQR2DBJNrVdjrLDmkLa/nWxzon7AGmy?=
 =?us-ascii?Q?teet6EebCkBacb3B0lkT7TTARrsVAlGAOqpFUhaYazNR33TjaHMzZWrq81UD?=
 =?us-ascii?Q?S5yZ+bCDcK/WZpoxFLGCavMT/heWfge6UIWKLfpMpl8OtfnMNdALmezBh2jC?=
 =?us-ascii?Q?ajk7vB2+iJoTRGX3f+N2ENAeIdTu+IGNbdWte74DMQFOavOJmXu38OEwW1km?=
 =?us-ascii?Q?Chvl083Zl5GCCVt4flTjEEwLyilf4bvUHPzqiSwI7w/DLnDUGwiL1PciPic9?=
 =?us-ascii?Q?HNPZ7g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mQZSJA3Bu2U4QZ012TLgMOlraqR3DfYYk7ZswYo9P0dCio8Oxj6+dIGfgpnLsPZ6nyNwmx13ic+SRItNZLljSdbKT5WHREIyjs4BNjnnivj6y+0hGL+lhWD5zO4dd6Xa54ijUT0o1rEjetCsTztPHz+tsue/3LotbIotuaELaG13nToi1Se/v4tuLw43taMEbIlsBCf3OYZnKXf2lXvWwc0llux68G/8r91inwYIg4hdcGWLu/s/kw81WpiDq9AyZdTxXlKAb1lTodxpVNcyRiYWaD7wE0yIgS5XODM3HNqNlFcqGPCim7tPxtV9hGVAMhsDYM+DZ/joQtHd2zodeUqvhhOwsAWxqfKWzBagD3z9uZ/3WvKAjiB9nVrhplSTS2cjiMEj+O0yBqSRlzMlW9P+KM3oUd4RR/H6zjSfz6XazpDysjHkmXNDeHLK5zdNCyk4zXCqiElWyumTgz4JkMLH5z9SNSGmYku28p2PtQYAx5pcnn4iV4nSwMdU/TkPHIxH9V4kbj3qVbm+orRWt1UsfbpTxMAQgfgtXOGIcrfU0gdSey2jvDuvi/da8DzLKzJDqGnH3M1Y2NKEdqQujs7YhaGt9AAar5xmCI3UWkg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67cae34-7924-43b0-6306-08dcdecdab36
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 08:23:30.2674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0wKd/SRTRTR4L5s9BC+mKoOzhnQIXzxuYho0b83Cy5O9mf/Gvm5CvgVGhxyphhloIzNbt0qnrXHBMaIo5kRY7LpBakGFRYCr+7kDU25JOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=967 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409270057
X-Proofpoint-GUID: kwdkBRZ9XK_lxs6D2Kk9swvGN8E9NXXm
X-Proofpoint-ORIG-GUID: kwdkBRZ9XK_lxs6D2Kk9swvGN8E9NXXm

On Fri, Sep 27, 2024 at 10:12:33AM GMT, Vlastimil Babka wrote:
> On 9/26/24 17:10, Lorenzo Stoakes wrote:
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
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Looks like the destructive modes should work with the vectorized version
> too, and with how it returns a partial success.
>

Right yeah, intent is to allow those modes when referring to the current
process. Partial success logic across ranges mirrors how we generally handle
partial success in destructive operations so should all be good.

> We'll need a man page update though, right?
>

Ack, I intend to send a patch for this separately.

