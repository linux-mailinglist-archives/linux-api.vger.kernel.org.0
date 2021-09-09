Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B9E404203
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347902AbhIIAD7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:03:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27278 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236059AbhIIAD7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:03:59 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LKhqe016624;
        Thu, 9 Sep 2021 00:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=i+b1i19BZH1OjsTDmwHyDHlPKGkhJr4bITNpaHrZ5hAnOcabcDDWHkpZAQI72y5NSbZ2
 PMDzJa4kfRZWrFsCKDIohShu7zHEaSw8yI7FB6JPSeRq8F1GOGXUYNz7nyXnM0Z8FWtP
 AEeaUJta/4w0PK53UZnAMkJMT8fB+hFnfF+cpxTFlwuD3XOXtA3pZCxVvG3Vhe5dGt5t
 OnGPiHG51sKt2DY+Ulxks6V6v02cb3Jy8dbQ/hJsJ1aTpthKMieizBETV5+2BGeLe4US
 cgfdVvJ6RCbQqaW6tkN1Raa5QsCom/HC00zpZSV3oG/WZLPYsMnUNp9EV3TxLOBBTk6B Kw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=UldOM6WgAOMvX4f91DTqpHbOzl92UCFK9ySA/tiROqaPpWsk8bxZXJX5L7qIP2UAFobG
 5BTu1lbvzEnPzqX5iUdOkyaCP1ltubui1YU+3Khu+kKJiMgR06oxhqMm6tKgCqfpTDgp
 +ydAmHqPkyjDKbmpc9f1eutVh08J0BXni36zgYdUwHkHGzeC/B9bHWSnKzo8Wc1cGuJB
 JOuMYnEziOS4nh7tBksSlMQvBfFTvNw2Gp8q5C8+Wnh8tv7/CxsE+4CnoeSb3nlmCiD1
 F6Kh8zfPzb74UppL/S1V5uGKP80kMG3ad5AFpgrB5YU3PvE5bYffe3T/uqE5eTNtqQ7t jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd7tcfkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18900sUY066616;
        Thu, 9 Sep 2021 00:02:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3axcq24yse-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlGmej9Rhs/w82EukEhkqeuDv/j6nPdMxR+7NA5hOoJWzSuRv3USM48bMmLHVFjnV4JeUQrPzoc7p3NJPk1MdJLe4QucG99Q387hvaARXfR9V5mdurxJ/UPgWLYOOQQOqvDimCe4pldLWWFMGFGAky36C/hx/RDsbClA2ttMatjArZKZMb84WKwAM4r02keUt0plRoJHk6uAOL4sicRtTqO9mZ1Sbb11wj5V87RXKTVzlnF6eboSaq/LKA+8IiTAm6OL2yOpYWRNUSVNyJBpi4NX7iIlZ9sAakQgppln5MbX8fxqe1jmEKqeHh5s0iGaigugvTzTeIv+VE1vNBVrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=dTzeFVopGy3kyoEa3mSM8VGywG4yKTosq2xGdj2blz/mo6l7aDACIkcBtw00OYexq9/OYb9WZomd5akEE4o81L9HsnEvGypC4xtbnVfDz5J74cvmZqPgadKzUJ+srl1VeRsGh4KmndRn0QoFn3jUE2mLcRtuF4SolqVHuu1LlYDU6cKftVDojQ6GzYWxS3S7hbtYr2lTJUWMMuIfF3xxWZ5QR+sFzM/HdzCFcGrwzaBHVZdX3SW74OIyp6klu96LWcO/hZ5R5jHOGh60/cIDveh9EetWvdHZXytjai+N/eNsFTjU422ZhwBB46Jal2v3PcHJbdTcXxy+H+bHPJw+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5fVO95Mmc13d2D5X4wqAJVS16Ftlh8XgO/cI8DDa34=;
 b=Cb8kac8VQ91CDntss5pzkMvONb81svt338uevTpTOLaQkX47tf5OJJwBjrSek7agKMReHzqtRIibENteFGV2UoHfyvcMeqgFR32tK52hTwfSa1ndMq4Bw5CMRHWP4Bvy/xigu5r+bmatDIcb+qkYCzEbNBrjj1x30AdbDr54YB4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5472.namprd10.prod.outlook.com (2603:10b6:a03:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 00:02:45 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:02:45 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     --to=linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared structure
Date:   Wed,  8 Sep 2021 17:10:23 -0700
Message-Id: <1631146225-13387-2-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
References: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:806:f2::30) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 00:02:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a935e6a7-f3a0-41af-c314-08d973252675
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54724B45CF627A2FC553AC4EE4D59@SJ0PR10MB5472.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L7V9/sicU5yZekE+rrKL1G4Kw1sZBUYXBljSt2oR8hErAV+pCOIpUQYLASXYQhmikaj4Y8fk/kS/1mx/lXBgqz42aD/vuyPZzfj8PobvZQUDcLp38Fs294cpm/DjwPokH751aEIButUI9VbK2MFZUR7I+AxB9YOW2qt2f8GiY39ARS9k3BMqoOEsmfTEZWiDReyDCf1n3LRQNITsSxzTweg/BOU4dpuglfLySNoxa+6KFwoiZYi+4SW4eZ+R3MAJdAlbL0jgNAYzUZMC/K7CoPZOzOp3NgtZsjl68hEXKRYDDJcSyvIFxo3lnt9V1Kfcv+BAQwi2nHgLsQn0D1cE/6zToQ9kqng+GEXYLav5T4qCeqGdFmdFXQpnH9kNzJH3grDW1Hu+qcN/0KkbLmQxoVGjNTObvrfsCaN36iXQyMUzA+p8D8gTCu/sCiyIwSXdSYODY7e45WlV05kOecZq6unnMdlYv18ei2t0xD/xhYhU42jqZtX68Jv9Svkf9LbAGb7mZYuyRnTIMpRfI82gF4NvbYUDzLJyDR0QntR+1F8T9PLOozVkyYceFnyaODWOCIxRpqAALDapN7w+ESOgNl5pu4Pp7qTuPCN+YENYCI6t9+nyH1lB2j/gfwgdh5+ffmnghOn38HentaUxNs9Q/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(66476007)(36756003)(2906002)(186003)(83380400001)(107886003)(38100700002)(478600001)(44832011)(2616005)(66556008)(4326008)(30864003)(66946007)(8936002)(86362001)(6486002)(8676002)(6666004)(316002)(7696005)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gbu9hpeBHNS1ly9k1MPjl5IYeHUpq1UWdcsYSK6eU5AImvkTpadlIB4Xn4Sg?=
 =?us-ascii?Q?xwZVQVOA0Qiy0W8UNgGckFiVgytgrcMuq8t0iPlaDpD8xpkvyhdCoyQs8qrU?=
 =?us-ascii?Q?c5fSoifL8cpeNoBrvO1MC3zvyWLy2EimRKodkt9QTRYDA1hAlI13nIjM2w0s?=
 =?us-ascii?Q?6EijJs7Bz74uYsMYalNhvgLE0tyPlYxpk4ReDTAMYB43EOyPW6VAJRf0NLIv?=
 =?us-ascii?Q?sagK8SuwWDDiIbsAN7J57uqcwPJc9CcZx7XOLgfD+RbVe+qmYjoYk855Al32?=
 =?us-ascii?Q?4RL/ic+vPf24gmsv1pyDizo4sOV345H40ykVqOvEWzyyA3Obz0TGCxKSTySH?=
 =?us-ascii?Q?xqsmCoaO/Hx17ISFOvZN8CLv5Ha0uOT3fXTMWxIGCsC/d0J6+cXz8MWO4QBh?=
 =?us-ascii?Q?HAVF+ANgXCwfSpSfjts8Ns88GagLm+wjwkel+ph+4Tb0q9DLQXVlcBizXznf?=
 =?us-ascii?Q?SN8jrwZ/VO+uOkKmYQiPQq0IJ1olLaqcxAjpBS/adHqTaHHbaO96SOB6mKjJ?=
 =?us-ascii?Q?0nXiUy8Ya5AnOvOsyGkid9xiRUYyl1szT9j5KJAs5CtoyomhYSe8FD8RUZty?=
 =?us-ascii?Q?8fVSbNJu3rhEbQbR5LDNHx11Dt5yMJM2yfY9lwBZe8S79RbbmNp92cnLa8Hi?=
 =?us-ascii?Q?q/1kN0d6/uwQfZoDYhnz0MUKybb9yFb/jS147xwZ02x0dkq7od8gMCZtZpBW?=
 =?us-ascii?Q?1qkHSlppCJJa0oFAnNYuqO+e1U+0HODpvDzvgJqOzQlnxnZX95Ez5NB3rmwz?=
 =?us-ascii?Q?pHu3RyBISpOzh6BWdlgRSA8rZ0Ys+iCk9lA7vlvxFA2Zyk23H2ruUT12gAfn?=
 =?us-ascii?Q?e70QfMXSEJwVXtg5JkIYSUOSXZidlq7p3FxSEhxI/fHgOSjO9p82Fg+zSpRu?=
 =?us-ascii?Q?dG6zkxYoRn+iIfmncw76MTXv2NrUjL/DHyjV15VQGO+O4lAWHDAF49IfTEEl?=
 =?us-ascii?Q?22fwyLPEj6w4n2X782eesSg0VFJkxMHft/D/C1bSJGuk3zoYLA+9trD/3PuF?=
 =?us-ascii?Q?xnJd1V+zXr92hiDsSm3RaHxOS3ZTHy6zHWsBmw2/P71dGqW0TPO6uqhsGxTP?=
 =?us-ascii?Q?v5liKNn2lbLgOrcivy1e9cwtLn11PfKniaq6xF4nCh8oG13CNFm4XGYqOfKr?=
 =?us-ascii?Q?PtCOMciJ+5LAHsm/TPWWdpQ3u76npUb3rDOgVjAxo01Z+HairYWf+Kc9iT/V?=
 =?us-ascii?Q?SZV2fPaN5Ddu0UHWcHmBjTVzd1amxifTZD1iGURpGQCjBoTzH2b7r0LzjEv4?=
 =?us-ascii?Q?Vs3Li3T+CgfpOreq3Xe+DYP/Hriw3A8Sj92ug8T0/71sHclhPFIU1UaRWeoY?=
 =?us-ascii?Q?cx1YIU1eR12ctQLRBmDHf3cFUIZ6Pnbr9nfjvAORqGjA3g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a935e6a7-f3a0-41af-c314-08d973252675
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:02:44.9979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TacI/siQGAhMY4wdoFs0VzbXm7tu0jRZVTeKdaP6u7jMRzf3hCeDJX2o506UI1DoGeFtoRC8J5+F69biepypc7rVzuMnH/+0kXCa5jmfNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5472
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080150
X-Proofpoint-GUID: xuwa5zh9HDS-vSp1qiF1MHEVdTGfMHLe
X-Proofpoint-ORIG-GUID: xuwa5zh9HDS-vSp1qiF1MHEVdTGfMHLe
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

