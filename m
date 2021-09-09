Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF4140422A
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241998AbhIIARa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:17:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42402 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348278AbhIIAR3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:17:29 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LPmYv025837;
        Thu, 9 Sep 2021 00:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=xcgVJTmd8hm5ivEV5MKfWdD93C1OB4J0Nu0uUglHAK/SnTLgVFDb4q0BzbEVUca3kQ4F
 sSAofpSsrzgMz1cfW2dh/X7nxPEypWwR8Sn+rl5YkKJFdoDwYOYmc/N+r/MXqBaootQa
 YiEKulQZQtINHJav4Hi8TxsANA+liBwgq5Au3c9BXlc9IFw/5Mi3O3o3aDrmzt9gNMCd
 C3mK06rDWeNpW4GLD/DJjGnCLqqhAW6ToTTd00VUIyZZJXOoc5ihszjsUUnkd/w6Q/a8
 FYPiUEg4X+RF4rhDryCl0lfKFE334Ge6T61yUGjZmgspcx2L9ldgsMJK2i9z75Ell3dS fg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=YGDWl5WbFZJ4SCZgrM+m1/cfZJ1u1/qmYm+PelDsZFrvoXeKETppq5eGif7Bzt3ogjei
 MWomv/FEncbqRxIICZTxl1gpvE9hLMqDsaIe6r5yV/JmVtiNLmw9oRlIwyhaG/8iWnII
 UDm5SopyKhrPfRlm26z4YE+XIExUDz/yhC6ntcZPOwlEnTwiSdA7q3tRqEfjg2WvEfH9
 S4lHUDoJJcVqTwfUgnXxNb0jaVPDW93kc0+U5uMRMo+Lm9Vr18NjXhPAVJckGoKLBpYV
 MB9AWFK9j7dd4ArcV/m5ibNMKI5FmBuYHtlxcvK2azEm+I9DCnff04a+4xRFMKDL01sC 4Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd44vggs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:18 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1890GEmX180423;
        Thu, 9 Sep 2021 00:16:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3axcppf5gy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeqZxBW3S91uOr9wDseL4B/ASGazWat4Hf3wiBGcvQVzXWm1sB2jZHuSjHKlGGjf1HRYT3MXtrqAbJVbhcSokDfIaPMtG3apuHaeQymHnO+lJ9Zy0nDuqWlKPRHM3g7WwYtt7p6JgE4bzixtkntBfEV+xKLg1LLQDh6dpKiSa6yiLrWCWx0Km0jQ/ZpH96+yC1Jp41f+sqncdr4+3OuEq24fRfubOEzK7FuZM+9CvvU7DQLbdsnUdCdDKbBTpMfoXNOdnK1xbeSOv8wIEmrDZSUDqch9FEXJhuEIpitNMtwneZfaWWoZBqibqrBzjzaoHJNRsLpgOBN71IqyAoBjsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=cWyXhazE2gjsZw38T5Om7lYYFnx0StSJ68NlPI7PqsOsdL2VnD8pWdR8CHuGqwPLJY+OOh3dr3d7ueWgTWAe3f+9K/F7Uy5njFJ6cg1PFKI+L8CPn9JdcO1vIgAL68XCe8g8X5wqf62Hj9BnVgTHjJuULTfN55kTMYOTExo/uh4wxP9SRp6jEjdOhXMaQ29Ph7Yx0Ag6/wDL/Rdh7Yve4nn6+7zYIoCQDBU45Noq671z6RCgfDqeKxI/1RAm4mA1G/v46eSbNSXlaDJN1/UtEORIFGi9HIOymklwcDI+MNEKZ4X+7SzlhE1Xaix1Wq+kV5waxEGV1hVHLOXYmOlv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=ugCPAL7uoHYbq2wbXgL03jS3arsq8dJJXwIxWJoHoF7AfIIg3YygNplTFh70GyYT5YeJgTTdOFIca5YL4LwW4sU2w27fd1HooN5JeuQ9tY8OSgp9cidcsEOAoBsdZlfWrG7yFlYIRrtc8OGT1MRXMsz0B4iQ4xi/PR6My+8ug1c=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 9 Sep
 2021 00:16:04 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:16:04 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared structure
Date:   Wed,  8 Sep 2021 17:23:54 -0700
Message-Id: <1631147036-13597-2-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.16 via Frontend Transport; Thu, 9 Sep 2021 00:16:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 505fcc2e-3e23-4c29-f97b-08d973270316
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2888495272B08E6C1DE3FA3EE4D59@BYAPR10MB2888.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5k0JymnmptPq9mR9v2vF25nodIYMBk932xfn64qEEytGTWve2n6Zx1fW9Qm5F7W+FsDWaFYkvBpxPS4qRIrAMHl4mUS0x6LjTd1HEyPE+sOtuMSYtrrZJ9fKF2qz5JIY7AJazC2+ZCSWS33BC6IByFt/HyiJdwjpeKcaanhL/N5xDZTSNFjZTpRRCq1mAW/5T6wH7IN5EmZTwfnsicbi5Zdfe2N+6sEZ9IcG8Tf968JFarRiI5pUWcubtnMDQoystdys8PhvYfWEKdOR2zCWU2/7odV3eZsdVvqKKSsvufiWERf/PkUANuHIHiDMY5xzlN/nos7GNXB7Sy9pydVG8yx5f+i/D3hjTwkIRGwvyyP9fRcUxSSL9IZn3lFHmk3MLBRY+ZtMRFo1QpdyI0FSnPnkX8141tT0nucxcTuFfwj1eCbeBjsKIH8JQpYf/3/ajY6atW1Bj5R+2T5xPPpauQI43BhzloZfyBF9gXpSUpQDhkDPaooTUnaLFmpX/D9ZgBVp9I4lrczfzHe0mfTW0N+a82L6JTzr3ea0rpTb4kqdNm8Fz3pDrR7zwnSPNSwWpGVgKyD3bxQR4nVmEcCKO6x1+daYSTzsNx5U6x/cWPhg0NQzKKtDVHLP90/5qiYlixgWaWFBnWOYYmBAV4SRfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39860400002)(346002)(8676002)(2616005)(8936002)(5660300002)(66476007)(6486002)(83380400001)(6666004)(7696005)(52116002)(44832011)(107886003)(316002)(186003)(66556008)(2906002)(66946007)(36756003)(30864003)(38100700002)(478600001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Bjbp0SiYLbfiQCsvFsXyqZtkZW7t7n31TSCMAQX2LIcaKobU0xSNJVKD1O1w?=
 =?us-ascii?Q?7B3TlxcympKXqn5oUzfIpi5CTPJtco5MYzAoZZy0m/wigaoMFKe7zLC5i1Jy?=
 =?us-ascii?Q?/aF/Bjx83Ndim0cUIREY1YhAG7g5wtMsF60jZPOf5C7yPyRAYeT7HTQCvFG9?=
 =?us-ascii?Q?955klRV3tIkvJthTU4+qbcdyYI3r1FkjiE1uWxWFcWowZNMdiWJiCsqsOqNJ?=
 =?us-ascii?Q?IKTkQqa6FIktcvL1lSvAUiLVsFgD+eRshgJgMWMf62aEzFORR/ChRfux0SWa?=
 =?us-ascii?Q?t1cUU+SjiAIqPSgR7sAgpYRYMUvZP/6buzUdv3KmryxLdNGOcpnI1XhUCpHU?=
 =?us-ascii?Q?yJWi3YQlFa1WjqIBiGlCVIGpVuxgLKd/wwsA2Tls6S0NFkVCH3L6BA9/9ZfT?=
 =?us-ascii?Q?/wUrhSRUCJ/HwSYttLeqzj0jTzZ1fWxG/aH16vKSIRh5Y7dwBCmyg1GO6eh4?=
 =?us-ascii?Q?I6RKi+M3Opar/JrPE6Mjt94LQW6mGiOvbE12fQ6F/M9aGd3KgWe+nlirwxdA?=
 =?us-ascii?Q?jFwMPYaQe6qnZdY//FG72fXqvqRcaUqn+/Oi9+9+Ka1BRTcT7j54h5ru1uS1?=
 =?us-ascii?Q?zqXgifpHsQNSEcLLnxHkmpC9rqRtjApolvL3wAEoyP/fyXKAIgPy+qPoShl9?=
 =?us-ascii?Q?Dp7J/peYeEwsIg+WEQAac8wsmkeQtv1VbHL9c1SJny2lKr6pe0RZsBn079Q2?=
 =?us-ascii?Q?oQq0NMp5MsLV5J1sepUAlN08p4ixV5OCDyM+iFjzD4mYZuZtFOD/Dku8ncfT?=
 =?us-ascii?Q?zC5W3itfeKYSoYL3pRIYlZUH4jLHIg/+vAiyq9hS+O3xICszaYTBtK49eQqu?=
 =?us-ascii?Q?qqwSbfvEh8bom231PRKDToEa1WoeCC7hmLi76muM3xmC72ednRNwHka7u9xn?=
 =?us-ascii?Q?8iYE278AFvXxEzc4JUpnxYqMcuWL7dFK4dSXvEDbTfaHNQb7As5wDU759jdp?=
 =?us-ascii?Q?lCFVirJRjhSWJL5ixVk3nDwW9KyLObid7P7r1CKuwKd6G6OVjlCtT6I6rhJF?=
 =?us-ascii?Q?HCavXAAKLImCPEf7RuHdoMUxCyXICnhtvGWrQMcr2xZG/1oLfdWSNsx0lBj+?=
 =?us-ascii?Q?13mEkZKme+6aEKRWgHQQDHWDQuPW3Gi9s83+je8SzNvNdAfGFRD9kD0XPm7k?=
 =?us-ascii?Q?+dxqXHFhOeyRtoQM55ELQV4ULtgcpb+pfJZ/99D/3ep/EuMm8N4gZtSYQdU6?=
 =?us-ascii?Q?sSjKDLZrfNBDY3L2CkaoMKBHi3m2rA774tlXeYMmq/4I/+Z4n409HLyfJpdW?=
 =?us-ascii?Q?0mkoT9lK5smEyS9B7ZCZmta+oajpHFQQd+JWZ+emArmhKYEA9vz7+SN1+Heu?=
 =?us-ascii?Q?reSZtLDKl6W3veL3wdVsgLHpJ3HIhAGh27L2DrZfvXzmiw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505fcc2e-3e23-4c29-f97b-08d973270316
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:16:04.6299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXH0nteqJGqw6z1nzqGSiNJgWPPSOq0OtS97NvHH67AynMq2YARegKNX84fJa++SRm1VE5ksPO5SW/xfO11EpDB2XeMAbdG9bQseVthOjxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2888
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090000
X-Proofpoint-GUID: YXbW1rfwm7ZJ7FosocMhotBN-PHIm0f0
X-Proofpoint-ORIG-GUID: YXbW1rfwm7ZJ7FosocMhotBN-PHIm0f0
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

A structure per thread is allocated from a page that is shared mapped
between user space and kernel as means for faster communication. This will
facilitate sharing information, Ex: per thread stats shared between kernel
and user space, that can be read by applications without the need for
making frequent system calls in latency sensitive code path.

A new system call is added, which will allocate the shared structure and
return its mapped user address. Multiple such structures will be allocated
on a page to accommodate requests from different threads of a multithreaded
process. Available space on a page is managed using a bitmap. When a thread
exits, the shared structure is freed and can get reused for another thread
that requests the shared structure. More pages will be allocated and used
as needed based on the number of threads requesting use of shared
structures. These pages are all freed when the process exits.

Each of these shared structures are rounded to 128 bytes. Available space
in this structure can be used to accommodate additional per thread stats,
state etc as needed. In future, if more space beyond 128 bytes, is
needed, multiple such shared structures per thread could be allocated and
managed by the kernel. Although, space in shared structure for sharing any
kind of stats or state should be sparingly used. Therefore shared structure
layout is not exposed to user space. the system call will return the
mapped user address of a specific member or nested structure within the
shared structure corresponding to stats requested, This would allow future
enhancements/changes without breaking the API.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/mm_types.h               |   2 +
 include/linux/sched.h                  |   3 +
 include/linux/syscalls.h               |   2 +
 include/linux/task_shared.h            |  57 +++++++
 include/uapi/asm-generic/unistd.h      |   5 +-
 kernel/fork.c                          |   7 +
 kernel/sys_ni.c                        |   3 +
 mm/Makefile                            |   2 +-
 mm/task_shared.c                       | 301 +++++++++++++++++++++++++++++++++
 11 files changed, 382 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/task_shared.h
 create mode 100644 mm/task_shared.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ce763a1..a194581 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -452,3 +452,4 @@
 445	i386	landlock_add_rule	sys_landlock_add_rule
 446	i386	landlock_restrict_self	sys_landlock_restrict_self
 447	i386	memfd_secret		sys_memfd_secret
+448	i386	task_getshared		sys_task_getshared
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f6b5779..9dda907 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -369,6 +369,7 @@
 445	common	landlock_add_rule	sys_landlock_add_rule
 446	common	landlock_restrict_self	sys_landlock_restrict_self
 447	common	memfd_secret		sys_memfd_secret
+448	common	task_getshared		sys_task_getshared
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 52bbd2b..5ec26ed 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -572,6 +572,8 @@ struct mm_struct {
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
 #endif
+		/* user shared pages */
+		void *usharedpg;
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d..237aa21 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1400,6 +1400,9 @@ struct task_struct {
 	struct llist_head               kretprobe_instances;
 #endif
 
+	/* user shared struct */
+	void *task_ushrd;
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 69c9a70..09680b7 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1052,6 +1052,8 @@ asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type ru
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 asmlinkage long sys_memfd_secret(unsigned int flags);
 
+asmlinkage long sys_task_getshared(long opt, long flags, void __user *uaddr);
+
 /*
  * Architecture-specific system calls
  */
diff --git a/include/linux/task_shared.h b/include/linux/task_shared.h
new file mode 100644
index 0000000..de17849
--- /dev/null
+++ b/include/linux/task_shared.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef	__TASK_SHARED_H__
+#define	__TASK_SHARED_H__
+
+#include <linux/mm_types.h>
+
+/*
+ * Track user-kernel shared pages referred by mm_struct
+ */
+struct ushared_pages {
+	struct list_head plist;
+	struct list_head frlist;
+	unsigned long pcount;
+};
+
+/*
+ * Following is the per task struct shared with kernel for
+ * fast communication.
+ */
+struct task_ushared {
+	long version;
+};
+
+/*
+ * Following is used for cacheline aligned allocations in a page.
+ */
+union  task_shared {
+	struct task_ushared tu;
+	char    s[128];
+};
+
+/*
+ * Struct to track per page slots
+ */
+struct ushared_pg {
+	struct list_head list;
+	struct list_head fr_list;
+	struct page *pages[2];
+	u64 bitmap; /* free slots */
+	int slot_count;
+	unsigned long kaddr;
+	unsigned long vaddr; /* user address */
+	struct vm_special_mapping ushrd_mapping;
+};
+
+/*
+ * Following struct is referred by tast_struct
+ */
+struct task_ushrd_struct {
+	struct task_ushared *kaddr; /* kernel address */
+	struct task_ushared *uaddr; /* user address */
+	struct ushared_pg *upg;
+};
+
+extern void task_ushared_free(struct task_struct *t);
+extern void mm_ushared_clear(struct mm_struct *mm);
+#endif /* __TASK_SHARED_H__ */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a9d6fcd..7c985b1 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -878,8 +878,11 @@ __SYSCALL(__NR_landlock_restrict_self, sys_landlock_restrict_self)
 __SYSCALL(__NR_memfd_secret, sys_memfd_secret)
 #endif
 
+#define __NR_task_getshared 448
+__SYSCALL(__NR_task_getshared, sys_task_getshared)
+
 #undef __NR_syscalls
-#define __NR_syscalls 448
+#define __NR_syscalls 449
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/fork.c b/kernel/fork.c
index bc94b2c..f84bac0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/task_shared.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -903,6 +904,9 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_stack;
 
+	/* task's ushared struct not inherited across fork */
+	tsk->task_ushrd =  NULL;
+
 #ifdef CONFIG_SECCOMP
 	/*
 	 * We must handle setting up seccomp filters once we're under
@@ -1049,6 +1053,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	mm->pmd_huge_pte = NULL;
 #endif
+	mm->usharedpg = NULL;
 	mm_init_uprobes_state(mm);
 
 	if (current->mm) {
@@ -1099,6 +1104,7 @@ static inline void __mmput(struct mm_struct *mm)
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
 	exit_mmap(mm);
+	mm_ushared_clear(mm);
 	mm_put_huge_zero_page(mm);
 	set_mm_exe_file(mm, NULL);
 	if (!list_empty(&mm->mmlist)) {
@@ -1308,6 +1314,7 @@ static int wait_for_vfork_done(struct task_struct *child,
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
 	uprobe_free_utask(tsk);
+	task_ushared_free(tsk);
 
 	/* Get rid of any cached register state */
 	deactivate_mm(tsk, mm);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 30971b1..8fbdc55 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -481,3 +481,6 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+
+/* task shared */
+COND_SYSCALL(task_getshared);
diff --git a/mm/Makefile b/mm/Makefile
index e343674..03f88fe 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o task_shared.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/task_shared.c b/mm/task_shared.c
new file mode 100644
index 0000000..3ec5eb6
--- /dev/null
+++ b/mm/task_shared.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/uio.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/highmem.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/task_shared.h>
+
+/* Shared page */
+
+#define TASK_USHARED_SLOTS (PAGE_SIZE/sizeof(union task_shared))
+
+/*
+ * Called once to init struct ushared_pages pointer.
+ */
+static int init_mm_ushared(struct mm_struct *mm)
+{
+	struct ushared_pages *usharedpg;
+
+	usharedpg = kmalloc(sizeof(struct ushared_pages), GFP_KERNEL);
+	if (usharedpg == NULL)
+		return 1;
+
+	INIT_LIST_HEAD(&usharedpg->plist);
+	INIT_LIST_HEAD(&usharedpg->frlist);
+	usharedpg->pcount = 0;
+	mmap_write_lock(mm);
+	if (mm->usharedpg == NULL) {
+		mm->usharedpg = usharedpg;
+		usharedpg = NULL;
+	}
+	mmap_write_unlock(mm);
+	if (usharedpg != NULL)
+		kfree(usharedpg);
+	return 0;
+}
+
+static int init_task_ushrd(struct task_struct *t)
+{
+	struct task_ushrd_struct *ushrd;
+
+	ushrd = kzalloc(sizeof(struct task_ushrd_struct), GFP_KERNEL);
+	if (ushrd == NULL)
+		return 1;
+
+	mmap_write_lock(t->mm);
+	if (t->task_ushrd == NULL) {
+		t->task_ushrd = ushrd;
+		ushrd = NULL;
+	}
+	mmap_write_unlock(t->mm);
+	if (ushrd != NULL)
+		kfree(ushrd);
+	return 0;
+}
+
+/*
+ * Called from __mmput(), mm is going away
+ */
+void mm_ushared_clear(struct mm_struct *mm)
+{
+	struct ushared_pg *upg;
+	struct ushared_pg *tmp;
+	struct ushared_pages *usharedpg;
+
+	if (mm == NULL || mm->usharedpg == NULL)
+		return;
+
+	usharedpg = mm->usharedpg;
+	if (list_empty(&usharedpg->frlist))
+		goto out;
+
+	list_for_each_entry_safe(upg, tmp, &usharedpg->frlist, fr_list) {
+		list_del(&upg->fr_list);
+		put_page(upg->pages[0]);
+		kfree(upg);
+	}
+out:
+	kfree(mm->usharedpg);
+	mm->usharedpg = NULL;
+
+}
+
+void task_ushared_free(struct task_struct *t)
+{
+	struct task_ushrd_struct *ushrd = t->task_ushrd;
+	struct mm_struct *mm = t->mm;
+	struct ushared_pages *usharedpg;
+	int slot;
+
+	if (mm == NULL || mm->usharedpg == NULL || ushrd == NULL)
+		return;
+
+	usharedpg = mm->usharedpg;
+	mmap_write_lock(mm);
+
+	if (ushrd->upg == NULL)
+		goto out;
+
+	slot = (unsigned long)((unsigned long)ushrd->uaddr
+		 - ushrd->upg->vaddr) / sizeof(union task_shared);
+	clear_bit(slot, (unsigned long *)(&ushrd->upg->bitmap));
+
+	/* move to head */
+	if (ushrd->upg->slot_count == 0) {
+		list_del(&ushrd->upg->fr_list);
+		list_add(&ushrd->upg->fr_list, &usharedpg->frlist);
+	}
+
+	ushrd->upg->slot_count++;
+
+	ushrd->uaddr = ushrd->kaddr = NULL;
+	ushrd->upg = NULL;
+
+out:
+	t->task_ushrd = NULL;
+	mmap_write_unlock(mm);
+	kfree(ushrd);
+}
+
+/* map shared page */
+static int task_shared_add_vma(struct ushared_pg *pg)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm =  current->mm;
+	unsigned long ret = 1;
+
+
+	if (!pg->vaddr) {
+		/* Try to map as high as possible, this is only a hint. */
+		pg->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
+					PAGE_SIZE, 0, 0);
+		if (pg->vaddr & ~PAGE_MASK) {
+			ret = 0;
+			goto fail;
+		}
+	}
+
+	vma = _install_special_mapping(mm, pg->vaddr, PAGE_SIZE,
+			VM_SHARED|VM_READ|VM_MAYREAD|VM_DONTCOPY,
+			&pg->ushrd_mapping);
+	if (IS_ERR(vma)) {
+		ret = 0;
+		pg->vaddr = 0;
+		goto fail;
+	}
+
+	pg->kaddr = (unsigned long)page_address(pg->pages[0]);
+fail:
+	return ret;
+}
+
+/*
+ * Allocate a page, map user address and add to freelist
+ */
+static struct ushared_pg *ushared_allocpg(void)
+{
+
+	struct ushared_pg *pg;
+	struct mm_struct *mm = current->mm;
+	struct ushared_pages *usharedpg = mm->usharedpg;
+
+	if (usharedpg == NULL)
+		return NULL;
+	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
+
+	if (unlikely(!pg))
+		return NULL;
+	pg->ushrd_mapping.name = "[task_shared]";
+	pg->ushrd_mapping.fault = NULL;
+	pg->ushrd_mapping.pages = pg->pages;
+	pg->pages[0] = alloc_page(GFP_KERNEL);
+	if (!pg->pages[0])
+		goto out;
+	pg->pages[1] = NULL;
+	pg->bitmap = 0;
+
+	/*
+	 * page size should be 4096 or 8192
+	 */
+	pg->slot_count = TASK_USHARED_SLOTS;
+
+	mmap_write_lock(mm);
+	if (task_shared_add_vma(pg)) {
+		list_add(&pg->fr_list, &usharedpg->frlist);
+		usharedpg->pcount++;
+		mmap_write_unlock(mm);
+		return pg;
+	}
+	mmap_write_unlock(mm);
+
+out:
+	__free_page(pg->pages[0]);
+	kfree(pg);
+	return NULL;
+}
+
+
+/*
+ * Allocate task_ushared struct for calling thread.
+ */
+static int task_ushared_alloc(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct ushared_pg *ent = NULL;
+	struct task_ushrd_struct *ushrd;
+	struct ushared_pages *usharedpg;
+	int tryalloc = 0;
+	int slot = -1;
+	int ret = -ENOMEM;
+
+	if (mm->usharedpg == NULL && init_mm_ushared(mm))
+		return ret;
+
+	if (current->task_ushrd == NULL && init_task_ushrd(current))
+		return ret;
+
+	usharedpg = mm->usharedpg;
+	ushrd = current->task_ushrd;
+repeat:
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	ent = list_empty(&usharedpg->frlist) ? NULL :
+		list_entry(usharedpg->frlist.next,
+		struct ushared_pg, fr_list);
+
+	if (ent == NULL || ent->slot_count == 0) {
+		if (tryalloc == 0) {
+			mmap_write_unlock(mm);
+			(void)ushared_allocpg();
+			tryalloc = 1;
+			goto repeat;
+		} else {
+			ent = NULL;
+		}
+	}
+
+	if (ent) {
+		slot = find_first_zero_bit((unsigned long *)(&ent->bitmap),
+		  TASK_USHARED_SLOTS);
+		BUG_ON(slot >=  TASK_USHARED_SLOTS);
+
+		set_bit(slot, (unsigned long *)(&ent->bitmap));
+
+		ushrd->uaddr = (struct task_ushared *)(ent->vaddr +
+		  (slot * sizeof(union task_shared)));
+		ushrd->kaddr = (struct task_ushared *)(ent->kaddr +
+		  (slot * sizeof(union task_shared)));
+		ushrd->upg = ent;
+		ent->slot_count--;
+		/* move it to tail */
+		if (ent->slot_count == 0) {
+			list_del(&ent->fr_list);
+			list_add_tail(&ent->fr_list, &usharedpg->frlist);
+		}
+
+	       ret = 0;
+	}
+
+out:
+	mmap_write_unlock(mm);
+	return ret;
+}
+
+
+/*
+ * Task Shared : allocate if needed, and return address of shared struct for
+ * this thread/task.
+ */
+static long task_getshared(u64 opt, u64 flags, void __user *uaddr)
+{
+	struct task_ushrd_struct *ushrd = current->task_ushrd;
+
+	/* We have address, return. */
+	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (copy_to_user(uaddr, &ushrd->uaddr,
+			sizeof(struct task_ushared *)))
+			return (-EFAULT);
+		return 0;
+	}
+
+	task_ushared_alloc();
+	ushrd = current->task_ushrd;
+	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (copy_to_user(uaddr, &ushrd->uaddr,
+			sizeof(struct task_ushared *)))
+			return (-EFAULT);
+		return 0;
+	}
+	return (-ENOMEM);
+}
+
+
+SYSCALL_DEFINE3(task_getshared, u64, opt, u64, flags, void __user *, uaddr)
+{
+	return task_getshared(opt, flags, uaddr);
+}
-- 
2.7.4

