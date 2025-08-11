Return-Path: <linux-api+bounces-4431-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FBB1FE95
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 07:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A0B166712
	for <lists+linux-api@lfdr.de>; Mon, 11 Aug 2025 05:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E6216E26;
	Mon, 11 Aug 2025 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cdwo7pQZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ApVBbEzY"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95A210F2;
	Mon, 11 Aug 2025 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890328; cv=fail; b=WjTwcTlXZBjkPk8CLZQxWqxPbac477XElJQY6avge4CbHLPBnxSzlbk8y/vACVu1kEvI4IYjDjZXvD6ocurzFSGcihwEX5jO81KqVWTK5m/XeXwJMOulTIsTcmOTCsChT7PFfbpgZWSCoiN6ViVwKu35AO6DQ73F1z3wX1Hse3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890328; c=relaxed/simple;
	bh=4NTWI3cIbnJ2MBsZP4y0A2ogOhkGYeFwZDG6somfByg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Np1UeOJT0Q5z+Pl61JwF45y7l5OrHRH+j945ubufEDtpmPG8KOFV4cy7oRlwbD2M85Wkyk7XWPP6sGztXdJcxlkN+MbML0GS6n1ZXoOl1PY+tT35XnqJqncu6PcScli9RYNXaY2MbFI2tKKn6Ia+5igAfi6sWWXv6jkYtAEi5jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cdwo7pQZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ApVBbEzY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3NYgc029625;
	Mon, 11 Aug 2025 05:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=pkIIglJgEoJM57vVFl
	0tWXqbY0iAyGqoVLLIya2IqA0=; b=Cdwo7pQZvjs8bhQvbhGOTnkwNI8DoMoke0
	PUIgF5Qa7RE1ZagMPqd3dpa3HwZPo5kpGnVA8MMtX8ojSDPL1Fz2C/Xn0HBTBKCH
	xSX1exRxMqOAkuSN5cQ6T9Ij9ubk2DhhNCw2OL+l9cyD0n8+zDUERuRtOIp9AGh+
	R97Jy0yLylW6+4QyZx5dhqZ8WXfWWUg0obx3zq2tYoUOd/+COTuT1bYtlSMwp/Qx
	GU7n9OinHEY0bvWm0tlAUT94xjlkkORmkCuoWR4ixncxA+ymu0YmheM06qKi5J4G
	g7bn5jvYSsTF8LP9qu0s/X5HRFMakGrfY5mQqUsDX/ETDU4kwvkA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwsp4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:31:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5UiO6030151;
	Mon, 11 Aug 2025 05:31:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs86snd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2pW6uX5uHbXCUtqF+FaQ7X73KA89mBoaVPTn1CJsfpffkxu8vrJElGFQOz5nel7WLy3WTjRdMkRJc4SKN8Ql3s/tfBuo8A2TaJ1hefqhxhVk4lsQclo81wjKnRHr68f6mg7HTcc0e4TUM4Q1sPkSUEk4iOupr0lAR7l7fvsDqmP8db2uznRQmQGM4DZ81dG7TPUJ5NA2CItgay0M03NfWLJn6CceD8/kr9kGUqUGKik1sScRnIfh6SHEy45f5oZKm+YOJ8PC1MY+trbGw4lqFyfuxmKFLa61uaf5RMJi3sKz08V6LdhPFS9VqB1rfbWmeAe/oTr+24n3ryhaEV67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pkIIglJgEoJM57vVFl0tWXqbY0iAyGqoVLLIya2IqA0=;
 b=uQpWT4jhA86XI8n10kQZIJrdlb+WmLfPfpwyiW/GvTkfohetvqDdHut71BDIwmin4PtP8YHAf3UIxZdV/UgSh33fDpVSqdOJQLI6VVCiZjaf3l12LbVmKN7628F6kCgNScwLQYILhHTDjTRzjLcX97dgQlzh9VV8hD2MEEiQq0+bqL17RZuM42JGVHhZ9CBQPrLpztfV8yd8M0mqs2On8ZoVmXJuSbpt6B6IL5+Xh5qG8E4xXcbLEwn0JYYJeB7blcCpa1veqEnlI1F0U6mnb236glzfmzNAzDz8v+5Y8ce2ja9JylK7exSmc8Km2qakqT1ILNEZdAtZ+m+mcj3wmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pkIIglJgEoJM57vVFl0tWXqbY0iAyGqoVLLIya2IqA0=;
 b=ApVBbEzYQJmyscaaQVcweFU5ghml3RN9Nz6r04n8Hgs+uECgaX6KAq0+L+mbhmIM6OPn4l4ZsZ6TIyULOnyPOv3POYsGUi/Yw+zqvwNQGl2AFOFiYb5tB6Ju6uO9r8SQFXT87LDQmjcIaedsyfUrafM9zD2V9vL643J74QMyxqo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6744.namprd10.prod.outlook.com (2603:10b6:8:10c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 05:31:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:31:28 +0000
Date: Mon, 11 Aug 2025 06:31:25 +0100
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
Subject: Re: [PATCH v4 2/2] man/man2/mremap.2: describe previously
 undocumented shrink behaviour
Message-ID: <0b0928a3-03b0-4a36-817b-b75c1f5c78f9@lucifer.local>
References: <cover.1754414738.git.lorenzo.stoakes@oracle.com>
 <c7ba8ba09b1c0b015134c54824788ef4aa47fd46.1754414738.git.lorenzo.stoakes@oracle.com>
 <iolucvrp6is43yjulbluchhw5wy6urq2gtwmcelg5atwuv63se@ovzuthfrup26>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iolucvrp6is43yjulbluchhw5wy6urq2gtwmcelg5atwuv63se@ovzuthfrup26>
X-ClientProxiedBy: MM0P280CA0066.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: f78133ff-5f37-42c8-4972-08ddd898522d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BRnepv+UJKRT+uWPH2J/lNLwnG7af4L9eFsQzHjGjIbn789V+AsZdwOB9e6G?=
 =?us-ascii?Q?kDhb9cGWIl22JShDNM7usdx0YZFw+WRAZB6H03/1e0937+PX3UboYLOD7BPB?=
 =?us-ascii?Q?BhUrhDHVqGtI2JSTjPt0Zbz0xBU9rjKQpGGPlSs4p8vl4C1O83P2GDqnGMZo?=
 =?us-ascii?Q?PLWhVcp8wiG5xJjP9i0yXkAf4NEfv4RNpueTrBoabuy39IIPBttPwnpFh69x?=
 =?us-ascii?Q?zuY/obCDaosm9mahy4N6PAWFC/BSXrPVvloxH+avf9FNx/an/HDalN8+XB45?=
 =?us-ascii?Q?g0bzuJ/843mi6i/GU9Fzo5jCjgvLmo9p8QB9jaHpJY50ExIpNQAGL5OUT9jS?=
 =?us-ascii?Q?JsmFSvn41a6fw4eOoFyhm+/b4GMr+sQN2RGGEKl5S4mFVZy4IHeuq+iR/xrF?=
 =?us-ascii?Q?VYVPAp67kOLb8FT0hkcY7ouMwCU8q74+vzdfoKHu6VLnpGhspsV5EFRVaKsB?=
 =?us-ascii?Q?Aaue4gXZV66HWicUoRWOb1A66vLnypNZQThhh5gvbi4V8f5yWt7l6gp0IlZy?=
 =?us-ascii?Q?O8sNgNmodyZPn4fHf/kHGKkhcM/wep3O5qkfIUtftwr8Hnj8RH9vLYgB3/la?=
 =?us-ascii?Q?qZzX8Wbhz6EpBkXZ0iYDknrOc0GgZdOw4W2avTs4e79kON1MBj0E2anzGgUS?=
 =?us-ascii?Q?HOO+W+uw7TH5IZ8JWzH7ULD760GtDj6j5s91ums8KxL/SmxkQ0/l2CyB5Zm5?=
 =?us-ascii?Q?KOOtkiktyxfGgesaEP0AgPlLGdciq5WLXC7WKb45pSw6zi1m9OFSLS/yB8yb?=
 =?us-ascii?Q?3g0lap2tfQKSmVKDKQe2ZJZQILM5ZGhm1qU8M+coWssY1Vi783mSMQxcRID2?=
 =?us-ascii?Q?1giWSrUE/ZGqkacKs3VzI6w/1WJl8D11Ch2YV7K1JSXm8mCQreAfh2J+cEXi?=
 =?us-ascii?Q?fdMQJ+Vf31muHyOEMme+S/8W3/dnDTMepMcxN9Qx9QqqOWiuPL3/jj4dwVZR?=
 =?us-ascii?Q?V2TmakyHhdYPTxrxgzZl9H1hAKFvIZcUjKVyW7rjCAuM1Skr9HEv1C2tnI7S?=
 =?us-ascii?Q?YlF2J9saj9ZTMi/jCMH55T7JWKDOWVEULehEhEaZCFb9Mljlh3ErNQDbmEE0?=
 =?us-ascii?Q?0G89a6g5Qi2d5GfctGbicR70lPZh0OL52UCTVj8dYheUxHmE/Ervy1JJK7Ut?=
 =?us-ascii?Q?N73Uc8yoVN7Spl29ToAwpvgz61YiHwuX5SUhdSLT+O1lJeokMkqp43TCxIgx?=
 =?us-ascii?Q?mQECEUtsDBQdAdMSno3VisqkAeMD/FDUxTX9UfbL122DQK2mDBOIgQBMSR1R?=
 =?us-ascii?Q?I6k4O89GNnpHo++wJSQ9P0PweX2MITN0Gj63nB8K8Qe8GqGdftc7Ph9wawQd?=
 =?us-ascii?Q?33J7o7qrL/tIRxDQ49V8PYecWvPAEQuwxfXlLn9jIfjOqQGVhpSohe9u6nVk?=
 =?us-ascii?Q?1lxEkXQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssG/3e2ZLasOzgRLXm/MF/b6q+fRxRyEPTqbJvheGlqYkHL1UzAmd152HyTV?=
 =?us-ascii?Q?LzgT8Yk7ab4Pu6kNrkpKs6vmOteDDIvLO69q2T3SQ6s0ErqlwAMkimKWPC34?=
 =?us-ascii?Q?isESIo0EzDD0PzRlEuH/AZPeel3x4db8tD8eimnWLtMNoYLm/ycToVCXBqZN?=
 =?us-ascii?Q?VDKfYQ+r3R1g99yJpuO/nq/Rn0LSnrMGJvTA1rcFZ3YuRk/BdqKzTWbu6wD+?=
 =?us-ascii?Q?4naXGjnUJ+TaEVikW04iSa7JPuEdbpCtZEDM5KMqgizlb1UWfTMTIL6HzL3z?=
 =?us-ascii?Q?HrukenfXEoY0RHG/BmBr5ZctxUSfz3QtjTJiP2u2Ci7TVpxfh3WaaL6ETJuQ?=
 =?us-ascii?Q?fVxe9wTZ26UVeKVdc4GkpFX+uHtMvtAglzG9gtv/AaBXaiR2xlnJckPowBQu?=
 =?us-ascii?Q?gbr9wu2zNbhyqxL1VbvBk1VFUm4xldDXQ6WlP1vinlkfoK76KMiAEpSDsVTP?=
 =?us-ascii?Q?24eaqi+F1/vLdlJ6XJs+eG0bwL2uvODX8qbaeaa0Wm0to8cDm0sptGHVQocU?=
 =?us-ascii?Q?HMNXNEoBzuSPDsgC+xQ1p9P7rbzmA8OeojJZ8Rqm3I3oJEGEW3YFjJMl/rU7?=
 =?us-ascii?Q?W7dkY+VEwR1i4WGLm94XLVdHm9MxKtCsDgxfll3+TVVMxLQbRoU7m4YZJMkS?=
 =?us-ascii?Q?kFKibXuSPEP7FHACwz3MH57kuBfFKchhQQKPRPvGa9uXfupwrTVyxM54WvF0?=
 =?us-ascii?Q?hcLFny7+0cOuL8ZVO9ksbAXAycN6/SEr+bnS8DSVZGI5wLv8jwbvGhloABhu?=
 =?us-ascii?Q?lb0XYVQc5FiUQLha+yowET7E54i/HuIqz06Uc7L/nBt9qhIiMoZaneBxWnYC?=
 =?us-ascii?Q?XCP4ABFky6UuAcqMp8wcsxiED9st3LtVm5s4tEilQAl0BXHf2PDDJZPoJKjz?=
 =?us-ascii?Q?HXFmkH3pJOT3el431iUYb6vtOIkyS6R9fd3unNT6is/xRmmvYGwLA00uNJl5?=
 =?us-ascii?Q?hbGvqCagqomGfycK9mAmCjQyPwnNNQbg7CW0iVLQb1OK1Ud9PrLayQMEwzHb?=
 =?us-ascii?Q?Vv/MiWUhegG0yHLl8yZs7ofYpGn+KKJ9H7xKt/VxhfGxKRpMUsgTfSBez+Ji?=
 =?us-ascii?Q?PCZF0xAuA09B6wEfkYlRCT36mtdNC7WYY8wZoPqDZdvTAOHre0D1z7hFjfD5?=
 =?us-ascii?Q?GuMzEXHS8VnVEioqqZ6TBWP0JwhHYkIj8rddu/oocIgD5SyIXkdigTRuhR1v?=
 =?us-ascii?Q?+Ss2e/vHOjB5nGmU4yDPkKbslmcmVzN1dY56W0snqQF90MJMjcXNe4t9hYyZ?=
 =?us-ascii?Q?z4TIAK/nGWqW+ni33CG1kVxRdrKHwOrN1NqFGKX+4Z6knebdjVpaN6JeYUCa?=
 =?us-ascii?Q?kSrB2dkS4LmJBHel3WRsQUI3Skfi1XTklYaASKEzw1wYnZHt1RB7XsXHhaw8?=
 =?us-ascii?Q?8e89i5wH5VwPcFI21mdaXubnhjY60aPBXtRUwOrfjj0e6rEx6A4wv7Qo6M8c?=
 =?us-ascii?Q?ZHCKuG5NNvmfl1fJYmlf80mE1+1o/q8uDdMz7Ow5VSPwFj2o81Rxkv6373XB?=
 =?us-ascii?Q?tZZzJ+StExus0uS0BKTKSKJcqEenUDCLJvMAC7hVD3PwhKqgY4ed2413vkyM?=
 =?us-ascii?Q?N7kQexXXIDHxRSFwvjWIqGDvxWZUF13kFub0ibqbfS5S48hM3IrF0e4y3qrF?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7fNZ905zskGx1CMOk3CXR4V1dQgKRvM5NOqbS1xQSQuzt26c3cE6JklVPpvxj3oHiHXasqx+iNhJEIDjTYjCfLrYHeloVe/F0fUaiYRdW0KrZqyCC0tlhaWJJ5RfqoQcnkNftw0lxqZJbYVxw08XV18b94Ndwv0BStxJUe1L7a+7h7gJwaKJjmqmr8XeleqvzjwrW7DvqYog4x9ddS3pFjoWS8CwGjVyv1O2rRPJHGwh+UizDrM2zIiREytyvta/wx0ujOgnzluwY6yFrLwGLm31sNh4kZjbkHZ/It13iCb4Mldu/Pq5OzSFuIaajfRmoWamK25pMMw2lTzRCfzOzVjCT3FqW+0RSNc5t+gAVNZ4cpsxv7nqUkBi7NK2i54DU02pRXcFBauTtrdDgxDxH546g38JTQEoGa6BI8hlpKbXq4yPKQ5DBbAGdavKrWj3FR7PNsY6+axQj8MvJW73VpDUFbubrecUaY8UxidHPENTT8b0LmLfi2HkNQJM1lmrN+gh+yh0PENMarlaLBWrdTu4yRQ0bnfIe7NIyg0qKTYuVL9rH/VAP2H7wbnkZmaFplT4ktur4Xq3kogzQ8Y5TpZ5IULnYRvOY84WuR4vOn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78133ff-5f37-42c8-4972-08ddd898522d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:31:28.2529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7/5tc+xGGNwYpHQw+BrklOvwhdhE/FM4M2h21MQG128xHTA59o9zuL5uqMyP05u9/9ifFRkNN8UwDVh/8R1RhU7wsoc/9YGcSU/UI9wyJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110035
X-Proofpoint-GUID: AfDMMvwjagrrUDc9E3S4YsfSwwzEYBAQ
X-Proofpoint-ORIG-GUID: AfDMMvwjagrrUDc9E3S4YsfSwwzEYBAQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAzNSBTYWx0ZWRfX+CUqa6zwWWpg
 QyaVvboHfRLngffwW01wyEDKkII/kWh58WP44B0b2CDxx4pms+BJbPgvpOaprkKDZyWoaXavvxS
 tVEac8rnLpDWwpmggMleQ3hveRus1hO49vWm41hTVfA1zzXJdsoa7+rkad6W3Kywk1FOO43qcJi
 921x0bImIuqgNluqgpYE6X2SxJ1m+2LvciWJPxC2HwLq5ts8Kn95XdbDRP6RU8Pf2bZxNzUaGeF
 A3mGAwEHP8kdu9vWLRZHu90yNv1eGt88xtS/FE3BnUXI2MxuJNKE8/NvHBDmfbRlBHyyJq/u0+a
 TygqsZOfBfWOc97AvBzCjSowYV5w6e9uh0n98+P8pmTwH2FJBTToEWNhBsTHwUxYxCO1HHhenHy
 sEBb2XxXEXftIZSpAV0B+XXH00gdMpRyQ51Co3Rh/jJGm2T4lT2tPIRFaMD4SFLwgq+uPoYZ
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=68998033 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=MEjK9-KKAAAA:8 a=yPCof4ZbAAAA:8
 a=90pfKTq0KNmIT7GwtiUA:9 a=CjuIK1q_8ugA:10 a=wDCLW6yMUrMVbYbmd6V3:22

On Sat, Aug 09, 2025 at 04:33:12PM +0200, Alejandro Colomar wrote:
> Hi Lorenzo,
>
> On Tue, Aug 05, 2025 at 06:31:56PM +0100, Lorenzo Stoakes wrote:
> > There is pre-existing logic that appears to be undocumented for an mremap()
> > shrink operation, where it turns out that the usual 'input range must span
> > a single mapping' requirement no longer applies.
> >
> > In fact, it turns out that the input range specified by [old_address,
> > old_address + old_size) may span any number of mappings.
> >
> > If shrinking in-place (that is, neither the MREMAP_FIXED nor
> > MREMAP_DONTUNMAP flags are specified), then the new span may also span any
> > number of VMAs - [old_address, old_address + new_size).
> >
> > If shrinking and moving, the range specified by [old_address, old_address +
> > new_size) must span a single VMA.
> >
> > There must be at least one VMA contained within the [old_address,
> > old_address + old_size) range, and old_address must be within the range of
> > a VMA.
> >
> > Explicitly document this.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Since this is documenting old behavior, could we have this patch before
> the patch documenting new behavior?  Or do you prefer it in this order?

I think it's fine in this order, it's more convenient for me as it'd be a pain
to re-order otherwise, and we've waited ~20 years (or longer?) to document this
so a delay in ordering is probably fine :P

Cheers, Lorenzo

>
>
> Cheers,
> Alex
>
> > ---
> >  man/man2/mremap.2 | 31 +++++++++++++++++++++++++++++--
> >  1 file changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/man/man2/mremap.2 b/man/man2/mremap.2
> > index 6ba51310c..631c835b8 100644
> > --- a/man/man2/mremap.2
> > +++ b/man/man2/mremap.2
> > @@ -48,8 +48,35 @@ The
> >  .B MREMAP_DONTUNMAP
> >  flag may be specified.
> >  .P
> > -If the operation is not
> > -simply moving mappings,
> > +Equally, if the operation performs a shrink,
> > +that is if
> > +.I old_size
> > +is greater than
> > +.IR new_size ,
> > +then
> > +.I old_size
> > +may also span multiple mappings
> > +which do not have to be
> > +adjacent to one another.
> > +If this shrink is performed
> > +in-place,
> > +that is,
> > +neither
> > +.BR MREMAP_FIXED ,
> > +nor
> > +.B MREMAP_DONTUNMAP
> > +are specified,
> > +.I new_size
> > +may also span multiple VMAs.
> > +However, if the range is moved,
> > +then
> > +.I new_size
> > +must span only a single mapping.
> > +.P
> > +If the operation is neither a
> > +.B MREMAP_FIXED
> > +move
> > +nor a shrink,
> >  then
> >  .I old_size
> >  must span only a single mapping.
> > --
> > 2.50.1
> >
>
> --
> <https://www.alejandro-colomar.es/>

