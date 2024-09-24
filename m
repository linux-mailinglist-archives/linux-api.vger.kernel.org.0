Return-Path: <linux-api+bounces-2331-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AED98445D
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 13:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B331F23C68
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2024 11:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435711A4F3B;
	Tue, 24 Sep 2024 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bfdyvir4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dShjQ8ZN"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55044145FE8;
	Tue, 24 Sep 2024 11:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727176651; cv=fail; b=L4DBBhriV4pdXoQ/ADn4+nwysO+7SLDG7vxg9YHPJbskVduTqP2K2WGA3vuq8GlkzDZLR/0HRWgfdVzDefCJlh5p2W/ZPR/21F8kHQ53YBnYbO40IPhOqF6vcZIyWATlilStmDxfSvuALP4Uow2c1mjZcgZHPtmaUEyoR6mtjww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727176651; c=relaxed/simple;
	bh=Mr5jdeZuiZQ9PP9gj7regh+jwNMO9oOKnxQXKCBYRQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NrLfNKg1hPVR5t7HNefsf5UYdqRUHu+XuaDjpImDFWI30XvcLGQKIadZSXEZybTJmtpII75AQIOBmVSHB8i2TlIsHL92Ks4fkYLAMUd/hU5ND86LGdZcLM6RRS1MMAUgyJv8pJhUJzqJHtjWdgDcwVC/p+HHl1nyTrHW4n5USck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bfdyvir4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dShjQ8ZN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O1N3c9024933;
	Tue, 24 Sep 2024 11:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=3yvYy5mInhuS6TXooJbJBSUzDgPnmQzXOcR1ccPdQcY=; b=
	bfdyvir4/u6L3YaFzHStKCC7BuSw2vfU/JdbqMFhrF6ypVfrRYX4vK9Dd65dx0B+
	CCv7dIuzmIOI5E5bzngOcHkwuBDU9FVI1XSHYjyAoSXv+G9W8KsvWlqs2plZ+yQI
	X5Hp57y+KhBLseHWkxijrBGfzaCaRdUlVwsKAJxQwy73oIjHxNsUC8amL6xG0cPj
	TsyyrmGmgvbrqyj6RNuQMmOGLh3rDcUYwnA52h3VoLgw6IrNsWCyoHyizxUO4/ZI
	iAWDm1ylboUo+UyuT+dkdsoWmSy0yWFbykp5RQWn8j3l4QsF8XnOlkmCM4JFkWJq
	XD0YGrpvNRzykpmeU8yP5g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu740k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:16:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OAp6NB028296;
	Tue, 24 Sep 2024 11:16:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkfb9sg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 11:16:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyOXdGyrNmg/rf0C4WCG2M71u2LE0LRJJtPwbmefapCO82I4ljtx/Si6r3wcU5MTnWvI+UtgP0U0UwxA03T56NLGywWjFsiRgHc8iAPXcv5ty2qrLldTWSW74LNFY+FPm8aLo/qZlvz7sG7NVtk4zfk4Oh45nzUCFpgc4mwlQsY+Bp+Yvzxdlz4L73iQOdu81muM6gvnRX0DOY8DSVvkFIVCqLo8TBJZTOK2g8ZtPKrESKHSm351bdSgXdI9MJhKB8No/8qNB7BEq1hPDPvIxZ4OTJPWgxCFRxFQmU1bit9qhx+VT01TSs3aaY64uEaWUd7gJAs4r7orJLLrWpoQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yvYy5mInhuS6TXooJbJBSUzDgPnmQzXOcR1ccPdQcY=;
 b=Nl9NL2cXL9o3JDjkGVrxMPAiImLhWwUGEZdOT9nsBGnMhO4IZrwPTuRvcirfB0L5Un+5efniZWteK1yA3IJpGePuV41BSimkMlGi4XX5biAx+cWUEX98Lm7nwHUNLx58htHuNzwEpK+ITBE8zcDdh9JmewHnrQA/8ASyHC3mm+Bi8QqYobfzw1FobEaJi8iltv8FYgpJdv4chkN69Hvvx74N0Yb8GyU3q2HS//BcgA8wmQ1ZIM6zabbqFOB8K/nuifythUnVXt9swFu5AvC2Y/TW/pGJCdJcIC9ime0DuCto01ZlW7JaljRLsGnT24ozEJk8zXC/9n4QZOor1Kj90g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yvYy5mInhuS6TXooJbJBSUzDgPnmQzXOcR1ccPdQcY=;
 b=dShjQ8ZNmI6+aEiaj1TPmwvakHAwmZdgMfC/em06+3c7yYshok72OuJn5ttGNWTE048i9G2Og3SJwB9Mxv2hNK+uEEQrEW9cQxyyBVCO9Oga97knfGUtPQ7513maXMnEVRHKOs4TdUItQQu48CjlHZR1JtU6WdiGTwNFiKK2Xvc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW5PR10MB5850.namprd10.prod.outlook.com (2603:10b6:303:190::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.10; Tue, 24 Sep
 2024 11:16:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 11:16:36 +0000
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
Subject: [PATCH v2 1/2] mm/madvise: introduce PR_MADV_SELF flag to process_madvise()
Date: Tue, 24 Sep 2024 12:16:27 +0100
Message-ID: <1ecf2692b3bcdd693ad61d510ce0437abb43a1bd.1727176176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
References: <cover.1727176176.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW5PR10MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d86591-e58b-4f0e-163c-08dcdc8a5a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fu8aq+QXlQpdcuDwElAqmG5F+3DtsF5OUnhoFtiSiKYprOFY9DxSYiuU7SFg?=
 =?us-ascii?Q?Vw9O9djEhHAgb9k7XV8q8OBy6xNjW+VX8nmYfjdYTin7eiL/wbe/FtKP3UUs?=
 =?us-ascii?Q?sbRPS+M57b0vaWJLKkbZZfEm2EVz3h0+SSjP6ShiB4dkaEafZ44Zz/3srxLp?=
 =?us-ascii?Q?EGAbaI3OAzTTUK1gmcZsX/DI5FPIhaTNN0H4QPcolXYc/e9nbahZpCiz5Orm?=
 =?us-ascii?Q?PO6wVm9lShtTAJ42vQ7jdcI9BG8HPJ4WKPVmyeWGsYvkAPIWspTIwyyj78Li?=
 =?us-ascii?Q?QbWznrYxN7BWcF8TR66pgiIcpKmg1lbq/47VmnPZzhAC9Vzm5Q1VQyDR3XH5?=
 =?us-ascii?Q?qndP/mqZCADUUkdgeRWSlE2VWJvxmfWLgmVMTk72Zu3P2ES68FDe0myfvUVK?=
 =?us-ascii?Q?dQV9Sk1MW6kjb/GGko+b1HSByQPJvHzFSkLy62OI2KGNeizFQNtPWcp0IK1j?=
 =?us-ascii?Q?HC9g9ywdvr4o7TvzadSrURMtle8Aveawp4W7MpOtPkiXfsmUDoi83fud64op?=
 =?us-ascii?Q?YonOspCwQ8XXC6iC7IabVMUEbcMu9oz4Cd1SgYjmcxTWqnyR0P5KyGv5NH2k?=
 =?us-ascii?Q?AA/3ZL87GvrA0+WFA4b6esjA2OnCs1tJVohMtpRSifSR4r6LMDlofUxl1GiH?=
 =?us-ascii?Q?efkb0IUfM/rhfDyvqwC5zTas+Gh8n9lC3OkLleaSur+ql7UFaCVsUfxR+sGi?=
 =?us-ascii?Q?9bmvDpCVt0LcGJHkVoAft7nj+7752E9TmXgNJcz6iT38zzeU8MYY/607Vfsp?=
 =?us-ascii?Q?XQ317F4GJveYzbo+AnjSIPIw5IuPlbv3yyfNOZMWFT2AC0DrA0hEK57a06po?=
 =?us-ascii?Q?HjglXM3l2epOP8NSYvCmp6PSEL9vGpKMMGjqd6IVi4C/xHnMWh1OMiXJOky0?=
 =?us-ascii?Q?ShPLEVt9B7VJS6YBgIRKQGpdbTQqDp5W9SxZOVGArhf7qsq2yv2iZEBazk63?=
 =?us-ascii?Q?k7MzlMGCxxj2PATmjpLnR76EGRkV5WikdV+8s/eiQdJXBJUOyKBlrpW+If3u?=
 =?us-ascii?Q?micy9Q7Z92kRetUUulco7sTGb0k8qYRAIGdp8++cGnnLn4EufoWmxq3Jzhgj?=
 =?us-ascii?Q?a2qTskSQwo/ysaKlUaJMOE/ydmeumEMJFQdj6nVA8HiM3sYuYwjT/w1MnaVu?=
 =?us-ascii?Q?WOT5Pcjm2s0/vc8yAEo8zxWmtW1GGsnf+pBU0KbKAN3IJZqUedTQK0C3cmGJ?=
 =?us-ascii?Q?p8BTyt0b7v/OrW1uNhniZyW1C9+mtYAtQnAbgpJ6o8CD+loIcRiZ+QvLjRps?=
 =?us-ascii?Q?RYCtalYYIyNtf/Y4PKeQ4ZfoFfOPWc1HqHragngM3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G8NY7Z6/cMqKaOZ9UZ2gn1d7zTrWnY9rkY5ge2pKXhnPUjvBGiLzBBbO/le0?=
 =?us-ascii?Q?henJC8zDRD76dhD+lbetABYSfI/BXA1mOi7qX9FCxS0s1Wu9nlWyhfBTy21q?=
 =?us-ascii?Q?Yh+kPcVQif4bLDlAn85gY59Sb6gE3cwzp4MmST1/Xq2+P7SEBSCohxKMiswN?=
 =?us-ascii?Q?4doBkQb/ML0o7UDpZ0pN3gMLnU3fctnQgSIhlMGD8YwkZu6+nsg6OQlkRzj/?=
 =?us-ascii?Q?+pChpqZI+EmkiXMClvX4DlQJNMeWjDTKUiPmQuoS52XLzuYQLBserYqRMtmh?=
 =?us-ascii?Q?KR/+5VyETox06fkrVig+ijk90VlPrxlwMoWfMeyI4AXKREs7WijCx0AXyHYh?=
 =?us-ascii?Q?3bdkVLOXF59DUcG1Yon9Mq/uYeXceTK9X5KJKR2NNfqx/8X7xrv9g4iOieXl?=
 =?us-ascii?Q?ZK9VEZhnDzwTEN7RpPK3SnPVO2wS8MXWlo7xrv2iPoHtW80FYnYE7v1dtPzE?=
 =?us-ascii?Q?QjBEkZJAxBJ6l4c7Cp5N4+8rbR4ar3tiu7FCr7paqwtxqo5XeREk3pW3Kg3S?=
 =?us-ascii?Q?92cJ5iPbKNcu2/wTLIV2K4aFoTIQPr5/dIqSRauRQ8eXNQxFrJ4M30SoZDzF?=
 =?us-ascii?Q?ssE9uO9XI5pVUDPzx73JHTeNC59mUifHSShSKFtf2+tlGNW0v+gOVVkkumnJ?=
 =?us-ascii?Q?32uQNzDOmq6WyH0AbK5E488MupyXz2ejoSqsTa6jWf+HfgQlrr8yg+PSqYgm?=
 =?us-ascii?Q?aTqcge2Vqxn3NCNLEXIGaHK4tL3RJthLFRY2rlLmISll7NSqxlyyNX5emB74?=
 =?us-ascii?Q?UmtNUXXTGItQNn3lBRb9mVW9QbXAr6I7G6EJF9wzx230sXMq1nARs/NoGja/?=
 =?us-ascii?Q?Wu5duPZJMrrnHyRGXjBjRjIcOsAPdkdWzFQHh9nYqQzAGlC4apb70eRVxCY1?=
 =?us-ascii?Q?st2Z1bZY9e0PzDuWVU4bD/kdLZVd5KnZKzMzRdyxF7BH4LNueLRdzoZnDFGF?=
 =?us-ascii?Q?cQConlELDnCIcUuhS+yIYwxeL/GCIjlUXDTGQGBLL9DoFG1B9SqAYuXSwIk6?=
 =?us-ascii?Q?+1aro+2TZDDZyfUUKV8G4z0vN3YqAre8oOswo7JcvGUtYgG8TZZVGXBWSVsk?=
 =?us-ascii?Q?LfP+jc04p55DkjNWhhoyLSun4Qzt++VYrS9azc5Ds5LJ1MvM/jf0+twOICNO?=
 =?us-ascii?Q?1OyJDtxdRe44ONmi5N4pZL1Tjk4Iu487I/N4jfaM8ZRTn2KU9j1+1Ac8UEdp?=
 =?us-ascii?Q?V0vzMyb69GJ+oCNcfwLazKedF/Zv63aMnm6HeZmRLbWEAzBVr0GZOsrEqEzb?=
 =?us-ascii?Q?mZk6oSqbpxVm+BghyuOAcTWuH2GyM9s3+7+ab3qE7gaMgkVeGV8fm3DDf83U?=
 =?us-ascii?Q?vNqgXraOsDyc7hFzT8CIDsxuMsDpe5Lp3ItBah4c22BvsEt5doTPNqrSRGnt?=
 =?us-ascii?Q?yX/TLHAti1lwasV+OoYsqH/+nXO8iclKUScR17judwwaN9qkLJ2EEu6SRPOd?=
 =?us-ascii?Q?DLVa9RhSUtbhPqyMFHlN8UNjN10eZ+ZCxnoLuox8O0WUe7Lgtt33q2e7A8Cm?=
 =?us-ascii?Q?hRcWd44qFDgNaewfsSyvKeXiQ+CPahcB8bdBWql6HOjJCc8HdHD0KIBnmAWx?=
 =?us-ascii?Q?nDAZwQKHB5IbqDR7QbNaHaZBblx7YUebLZcpObAz7jayzOdDZIdz8lZotstg?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z3jlcsVz+mAmuFV2AzOQS62JMm1CyED0y4TyB6eQr+jj02XFjy6HYfgj38yjg2qfdM2pyFNoQPwX2+zQQ6oc7VOjAA4CwNXCbPnQXP6G7U5vgKJNbWjsRy1TVVZEzMu00eSla1YN9sjFYaFIF5+KhHQwEnuhcrzLhgMpaDI6VXlzUPLTsJohoJu5LFb5Yr3RuQ1EXbV/s6R4YletdWXGAz86vry57j8WL/1rlsrgOjEFfFxIANJDqCQFTaYJQyjVY34J6IgIx4w1kR0RABB6lwcug3tDfk0cqOk5cE5R2FARs42GNroee/GMcZb2XEP6mUYZjlFnhdK69XW8KmF3H0ScKB3b/cfZdBi1AcAgw1kYwC9YsjefZbD9+fK6esQboZy88UWuuuTwDZiWqgcn6SBAPn9P99XTD3OULPhLZexl8ExjfkuuI7o2HaQr4RiAPpqBXImkPA+jp3awJJIIUodtpGwNwXl88FEYXj7laDAXwHvGwpEF7xKVEFGS65LddRAE0eBkrBlCuZ3Rv2rjZ2k9WEGghRjt6iK3oeLivpStOIlkJ3uJedpWu10OYWo3AxWrRtARTnQUpR8t6nCAdQ5U9/eGSqGpBimqYDgK0+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d86591-e58b-4f0e-163c-08dcdc8a5a79
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 11:16:36.3580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV2eoJWlNR92bBOBfRfMS/NTY8F1mwq+r63PfSErC9oi8IYSawSEeposya+4Sr97P5ux212qyvr8p4thPKW5w/9LvvFK2QHaev4d8Hg6UYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5850
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240079
X-Proofpoint-GUID: 12EY5B6d7nliO3BmNw1VYUuRGwTtFB2p
X-Proofpoint-ORIG-GUID: 12EY5B6d7nliO3BmNw1VYUuRGwTtFB2p

process_madvise() was conceived as a useful means for performing a vector
of madvise() operations on a remote process's address space.

However it's useful to be able to do so on the current process also. It is
currently rather clunky to do this (requiring a pidfd to be opened for the
current process) and introduces unnecessary overhead in incrementing
reference counts for the task and mm.

Avoid all of this by providing a PR_MADV_SELF flag, which causes
process_madvise() to simply ignore the pidfd parameter and instead apply
the operation to the current process.

Since we are operating on our own process, no restrictions need be applied
on behaviors we can perform, so do not limit these in that case.

Also extend the case of a user specifying the current process via pidfd to
not be restricted on behaviors which can be performed.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/alpha/include/uapi/asm/mman.h     |  2 +
 arch/mips/include/uapi/asm/mman.h      |  2 +
 arch/parisc/include/uapi/asm/mman.h    |  2 +
 arch/xtensa/include/uapi/asm/mman.h    |  2 +
 include/uapi/asm-generic/mman-common.h |  2 +
 mm/madvise.c                           | 66 ++++++++++++++++++--------
 6 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
index 763929e814e9..0148e6de35ab 100644
--- a/arch/alpha/include/uapi/asm/mman.h
+++ b/arch/alpha/include/uapi/asm/mman.h
@@ -86,4 +86,6 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+#define PR_MADV_SELF	(1<<0)		/* process_madvise() flag - apply to self */
+
 #endif /* __ALPHA_MMAN_H__ */
diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/asm/mman.h
index 9c48d9a21aa0..acb4c3bc92b2 100644
--- a/arch/mips/include/uapi/asm/mman.h
+++ b/arch/mips/include/uapi/asm/mman.h
@@ -113,4 +113,6 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+#define PR_MADV_SELF	(1<<0)		/* process_madvise() flag - apply to self */
+
 #endif /* _ASM_MMAN_H */
diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/uapi/asm/mman.h
index 68c44f99bc93..0f839b2cad13 100644
--- a/arch/parisc/include/uapi/asm/mman.h
+++ b/arch/parisc/include/uapi/asm/mman.h
@@ -83,4 +83,6 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+#define PR_MADV_SELF	(1<<0)		/* process_madvise() flag - apply to self */
+
 #endif /* __PARISC_MMAN_H__ */
diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index 1ff0c858544f..37dd27d09251 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -121,4 +121,6 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+#define PR_MADV_SELF	(1<<0)		/* process_madvise() flag - apply to self */
+
 #endif /* _XTENSA_MMAN_H */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 6ce1f1ceb432..8f59f23dee09 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -87,4 +87,6 @@
 #define PKEY_ACCESS_MASK	(PKEY_DISABLE_ACCESS |\
 				 PKEY_DISABLE_WRITE)
 
+#define PR_MADV_SELF	(1<<0)		/* process_madvise() flag - apply to self */
+
 #endif /* __ASM_GENERIC_MMAN_COMMON_H */
diff --git a/mm/madvise.c b/mm/madvise.c
index ff139e57cca2..49d12f98b677 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1208,7 +1208,8 @@ madvise_behavior_valid(int behavior)
 	}
 }
 
-static bool process_madvise_behavior_valid(int behavior)
+/* Can we invoke process_madvise() on a remote mm for the specified behavior? */
+static bool process_madvise_remote_valid(int behavior)
 {
 	switch (behavior) {
 	case MADV_COLD:
@@ -1477,6 +1478,28 @@ SYSCALL_DEFINE3(madvise, unsigned long, start, size_t, len_in, int, behavior)
 	return do_madvise(current->mm, start, len_in, behavior);
 }
 
+/* Perform an madvise operation over a vector of addresses and lengths. */
+static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
+			      int behavior)
+{
+	ssize_t ret = 0;
+	size_t total_len;
+
+	total_len = iov_iter_count(iter);
+
+	while (iov_iter_count(iter)) {
+		ret = do_madvise(mm, (unsigned long)iter_iov_addr(iter),
+				 iter_iov_len(iter), behavior);
+		if (ret < 0)
+			break;
+		iov_iter_advance(iter, iter_iov_len(iter));
+	}
+
+	ret = (total_len - iov_iter_count(iter)) ? : ret;
+
+	return ret;
+}
+
 SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		size_t, vlen, int, behavior, unsigned int, flags)
 {
@@ -1486,10 +1509,9 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	struct iov_iter iter;
 	struct task_struct *task;
 	struct mm_struct *mm;
-	size_t total_len;
 	unsigned int f_flags;
 
-	if (flags != 0) {
+	if (flags & ~PR_MADV_SELF) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1498,17 +1520,21 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	if (ret < 0)
 		goto out;
 
+	/*
+	 * Perform an madvise operation on the current process. No restrictions
+	 * need be applied, nor do we need to pin the task or mm_struct.
+	 */
+	if (flags & PR_MADV_SELF) {
+		ret = vector_madvise(current->mm, &iter, behavior);
+		goto free_iov;
+	}
+
 	task = pidfd_get_task(pidfd, &f_flags);
 	if (IS_ERR(task)) {
 		ret = PTR_ERR(task);
 		goto free_iov;
 	}
 
-	if (!process_madvise_behavior_valid(behavior)) {
-		ret = -EINVAL;
-		goto release_task;
-	}
-
 	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (IS_ERR_OR_NULL(mm)) {
@@ -1516,26 +1542,26 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto release_task;
 	}
 
+	/*
+	 * We need only perform this check if we are attempting to manipulate a
+	 * remote process's address space.
+	 */
+	if (mm != current->mm && !process_madvise_remote_valid(behavior)) {
+		ret = -EINVAL;
+		goto release_mm;
+	}
+
 	/*
 	 * Require CAP_SYS_NICE for influencing process performance. Note that
-	 * only non-destructive hints are currently supported.
+	 * only non-destructive hints are currently supported for remote
+	 * processes.
 	 */
 	if (mm != current->mm && !capable(CAP_SYS_NICE)) {
 		ret = -EPERM;
 		goto release_mm;
 	}
 
-	total_len = iov_iter_count(&iter);
-
-	while (iov_iter_count(&iter)) {
-		ret = do_madvise(mm, (unsigned long)iter_iov_addr(&iter),
-					iter_iov_len(&iter), behavior);
-		if (ret < 0)
-			break;
-		iov_iter_advance(&iter, iter_iov_len(&iter));
-	}
-
-	ret = (total_len - iov_iter_count(&iter)) ? : ret;
+	ret = vector_madvise(mm, &iter, behavior);
 
 release_mm:
 	mmput(mm);
-- 
2.46.0


