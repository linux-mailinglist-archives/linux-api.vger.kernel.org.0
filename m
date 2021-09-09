Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D03404228
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348223AbhIIAR3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:17:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42590 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348297AbhIIAR3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:17:29 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LSsGs031115;
        Thu, 9 Sep 2021 00:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=YUluOzNhljjtpvbr4uUZ02WpWLercGp3jENXGJH5NcR2CWJg1yp+XmL/9ACt/fKpDLfG
 rTeY3Gq9ChAhJVy6mr5zCFj0uRt7KWLe2w1znjHWgvnaOEBPULNcTC5GahNvO2z7wqwr
 xSYm9crlYMS++LfrL44bXaLew4IkdVJ+sNZYDEAXPeQIiACTW7RiGKLDlnsnBDyLuEgr
 4zjGoVd9t2tqN1aJzoI+dPrq+H/3EKHiTJPalUPyTEOtV4RBaBd30O2LNXGdzQh45zy2
 miPt9rHcyTfLFGfTgxOQ3IuCZdvoCWTqtP4Ph1HOioMD//bBSOe0Zu8bHNKEzB15NvpU UA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=0UCfco5rdtURO8du+KVQM1g//ngWpBuahVXT9U0XDKCbEdyJk3TDoJRoG8b5PbDTO0Kq
 gcIq7TTVEANbqgCXuefCUprxk3cGOeTu5oB9dwrE6RdVpTg0S3EkqmC35fQwhEy62b7d
 Oo4DU26m0MpDPLbYHgiOBhv4AckrV1TYhuadZ4rVacd0UMuQpWqkgczspvoBxo+mCTh7
 Wh+3W8onvI4AHGRHV9p/OCNujKbv8sw7cfptf9pnGN1xG+zErZPlDp6uCK+HpF/gE44D
 wApWitqQdqX5o+hV931P952EGScqG6KkpcdJgGznBLsm8Hu3G8qdOpWM6xLi7lrq7TJd gQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw6chuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1890GEmY180423;
        Thu, 9 Sep 2021 00:16:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3axcppf5gy-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTaR1DrOeF9qwqhvaVJdO8Q0fSLHZfEq2mXZWowk7iwXj3BtiQ2WUUn54ChicCfYVhT/7mopci/qqFB15kECAbqEZzxPQE7LzQc092BxZwS1YwJM7IVO3QVr1pKQH5FxzhdnFlwhgpCzF3ahqUvqJ0BT+v4k9yN+x53JRumigzB5OQ/uIsUVHsx9vC/ujFWROQv8phK+JWhL1cQ/Hfv++a3l+GtpwzhIzQMKy4OfkA0ZMhQG3dxzeSJ1+OxppxikouIWkTb7tZtAERB1cB7cB/GU1DD5MsAWjU7Xl0dp9XRx8Vgk4gntGKsFo9jNS1lSCOx8BcSju9Sfd9ioOABSxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=LJRrARe+paiDL78Nz2pnLEao3ZwEarcraTFI6V2Uj736YDjyvxf2C1D0Q31RAEbnulC2W4kPQFETcWxaEC/b+QEfd7Y0NAgvpY1S8tQ67yitMIaI/3IzpqO/nTvGGX1CxgQtGYcnA6vXmxftsS4EED5PCdxArAyKim8N/ZN+7dLyL49fdxTZiX+hIta0yaoeq3sV0v8t+Dgyvzp+BZOQQXnjW2ppkm4eyu6oNOq/9PM9WPCGXde4a3fA7N3Fr1yiT3yB7m6QgH0Hzdj6CMDzP2mqbYF9/NrfoQtpqm8xeBE4oiBb/JUJ2ob/F0a5K7HLnRmNihf7PY0FPETfwHG9mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=ArGGsCs3ka2TXiXrrdg212uJVFAXyqxX9u8Whh8MaCfuZsFXp/gmGFO+oFa/tdWD5fz21oB5G/44DGCHD6fzhNCnVTd75Rm4DaVXZ2UY+ORJ0MjBxa5yeZT8unkyOmWZNUaPBe/F6CBmJvoE+n8wDyU0IJdTBAkBagDHuVkbKhU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 9 Sep
 2021 00:16:06 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:16:06 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 2/3] Publish tasks's scheduler stats thru the shared structure
Date:   Wed,  8 Sep 2021 17:23:55 -0700
Message-Id: <1631147036-13597-3-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.16 via Frontend Transport; Thu, 9 Sep 2021 00:16:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb046d4-b4fa-4850-b4f5-08d9732703fd
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2888208489149C50EC1810A5E4D59@BYAPR10MB2888.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dbzwVKGRkqoj+eTyTsZyXij5KcasLMI5z6XpXimvghw0PH3wg6d2WvXqggnnBg8W+C8whRP/mbsEh7wx7E2a7FoLvl054tADj5H3gYf1/jQIcMNOMn+vJX/KZDX8F1JmQM0k437BACbkhBOhpg3zNI0DYZ8f/e0yTIAl0YZimFLadUr3svaebND25+xw51WnsMYaOY3bBx9iGLkoVPZ/CNSwbMrTi90ctsauqL64pVMu32tX5IML9wBPJmWLbPB4fQzBAVsT8m8lcjIZmhy4+M+YbGPVbFitZzVcLe2eYf3x3iZiWUYY0XvaaTytg3oYdeycEBBng9l4qkYHBAVDieLwIr0xFRv8VWr+uk0TPZGO+EGMUjldXk6NTGNwB9Ot7i0LYJnXhGVl3E8QYoDKJUuoUZPq4CVNNM6xyAa7RbqBnnFtQUHXHvI82WJNjr87WDyiTIZNsHPR/nhcdzkjNm1AeoutXLb+5KBROrNdKyQbyq13A/03kiGUxpykVuuI19Tbu1YYQlXXEb8wE5Q6q+FAC58uLFQpGXIjEqX3TE9cTq/roIkSQOJjQvPl7JcfFiYR3GuBVDXjZ3rKF7ugcO1be9dPa4tmxkd2G9E4dHGpMBJOqx5ZWftp598NZnY0m84n4IlRGx8muVoChcaFow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39860400002)(346002)(8676002)(2616005)(8936002)(5660300002)(66476007)(6486002)(83380400001)(6666004)(7696005)(52116002)(44832011)(107886003)(316002)(186003)(66556008)(2906002)(66946007)(36756003)(38100700002)(478600001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cey/rWj6spYNUPe9bPQl88kmLeyCELY43qPS4Qc/lU5v2M8EyUQ28RW3TbZm?=
 =?us-ascii?Q?XMCUgp6SDiEpP47SEz7+92wDKZBtNBq0qppgfHsoxwbogtrzVw+wUSVuO8vO?=
 =?us-ascii?Q?zCqPo04wAseYcUyI77WnnjiwrXnERwBKOuCa3XbAgXnThNMSJLw/o2a0XHI8?=
 =?us-ascii?Q?R0q0MR4C0uOiBh2jCd34pk3Yh6MrymrA1k+1OLLxj1rhp8ZzH1LSWlS6ZHHK?=
 =?us-ascii?Q?GJT1BxKnYlQ2Bq75bwiZqDB/xoKFMyFU5y5a2Fg1U5DA7D8wJ/ByiInMy0Jy?=
 =?us-ascii?Q?bikgQrOXGNmqzaBRhOinSdZYV27Wm4FG2wOa7AsKoJLBhLCwJkpkfWn+Rj8L?=
 =?us-ascii?Q?0uPLIC93cApadsiWWoVxFfEviE+rf8P97YGjz17k3osPYBD9825O5CicSFgE?=
 =?us-ascii?Q?umKCO7yxpJ8R41xYlGB0APQtJaeq4Q+lN0y4t5YBQfggozfmVNJKq85y85jl?=
 =?us-ascii?Q?4XPFzaCdGFuLKWeIv3t3iEGFM26LXFfOahpERFt1IVEMG6v7qI1W9nZnoumE?=
 =?us-ascii?Q?hXi594TlvJLgyvgNZfKS02HRYwH5wO2MlqLvBcKUhpKRecBTTmo+xbwk1o81?=
 =?us-ascii?Q?sUwfsuqIruQOGHCkDUFXcRHjAX4PqAJrRtnd/pQCHXoq7skr8aHspG4Y1+gr?=
 =?us-ascii?Q?MfC5mSTomheAumLW/uoIBz/N8wjLq9xyUju/2IVDDiQ0q+mNUmbdsk3fD6MK?=
 =?us-ascii?Q?kpz8KChxe/TOr9yoyHVZtn1kpcXTL9YjWgujI1J1MnnteUbM7ZmtrymK/qdn?=
 =?us-ascii?Q?CPZuH3khLAUiDgrMe3ucaDFQOuOVIqak8rrEHrBw6Z5dZtAycuHod+awlrN2?=
 =?us-ascii?Q?qNOtABwKKmA3dCXLuVdafrOAcHlxGUyBZKAbwaSco6hX+mJU5l9kZ6EVYEpW?=
 =?us-ascii?Q?lNAAKS7zKqInILrxsb/OIULMe4zGIYimXt5Ryc14qFqxaiACy1yOjlLjlTdY?=
 =?us-ascii?Q?/NXstgShfwZ1RBPR6v/tYcflLa17jIj1yh1w0WU8YFSLjh5YPpdJk3WUZqaq?=
 =?us-ascii?Q?MCRosI6b9m3hgSytWmMesMOJg2GgliR+HFYfH9f4P1rqOvEGV37TbYCMWyVL?=
 =?us-ascii?Q?NCiqcP3Zt0w08AaDszaCe89oIzMMvhkEN31g6BmYT+d6d0g6If/HKljTcaCz?=
 =?us-ascii?Q?9c47slCEc+HKleQla31GwwDpR+iDBHX7FQL3S7sPIS550Rp7HDJ508EXVu9K?=
 =?us-ascii?Q?c8s9epOc93h083SvYIUEV0tvZq5I2ZcOn0ofItGiXeUE28angDevyp9xzR6I?=
 =?us-ascii?Q?1bF177VVeuQzZBCOHIBZaxD5SAGvoqIgFWycijlXMg6VoBRvZbpYr5aohxPA?=
 =?us-ascii?Q?wkIMrEDKmye6t9MPpZGQteYlesQuP8hsILTP7+7t6XPrWQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb046d4-b4fa-4850-b4f5-08d9732703fd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:16:06.0081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucuzCahF/J7uC7AhPq5WdbU7hEVZv5zlyPv8eLRnVJkaJcst4L9if9XRFUbY/vwS+1JyhzpZL2FyG3QRcwUkkZXHCtYwwhZpCj+VN8NHChY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2888
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090000
X-Proofpoint-GUID: efxFCVlFbCjNpJ6mb_Y6P5s5B9OoiQkf
X-Proofpoint-ORIG-GUID: efxFCVlFbCjNpJ6mb_Y6P5s5B9OoiQkf
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Define a 'struct task_schedstat' which contains members corresponding to
scheduler stats that are currently available thru /proc/pid/tasks/pid
/schedstats. Update scheduler stats in this structure in kernel at the
same time stats in the 'struct task_struct' are updated. Add a
TASK_SCHEDSTAT option to task_getshared system call to request these per
thread scheduler stats thru the shared structure.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/task_shared.h      | 35 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/task_shared.h | 22 ++++++++++++++++++++++
 kernel/sched/deadline.c          |  1 +
 kernel/sched/fair.c              |  1 +
 kernel/sched/rt.c                |  1 +
 kernel/sched/sched.h             |  1 +
 kernel/sched/stats.h             |  3 +++
 kernel/sched/stop_task.c         |  1 +
 mm/task_shared.c                 | 13 +++++++++++++
 9 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/task_shared.h

diff --git a/include/linux/task_shared.h b/include/linux/task_shared.h
index de17849..62793e4 100644
--- a/include/linux/task_shared.h
+++ b/include/linux/task_shared.h
@@ -3,6 +3,7 @@
 #define	__TASK_SHARED_H__
 
 #include <linux/mm_types.h>
+#include <uapi/linux/task_shared.h>
 
 /*
  * Track user-kernel shared pages referred by mm_struct
@@ -18,7 +19,7 @@ struct ushared_pages {
  * fast communication.
  */
 struct task_ushared {
-	long version;
+	struct task_schedstat ts;
 };
 
 /*
@@ -52,6 +53,38 @@ struct task_ushrd_struct {
 	struct ushared_pg *upg;
 };
 
+
+#ifdef CONFIG_SCHED_INFO
+
+#define task_update_exec_runtime(t)					\
+	do {								\
+		struct task_ushrd_struct *shrdp = t->task_ushrd;	\
+		if (shrdp != NULL && shrdp->kaddr != NULL)		\
+			shrdp->kaddr->ts.sum_exec_runtime =		\
+				 t->se.sum_exec_runtime;		\
+	} while (0)
+
+#define task_update_runq_stat(t, p)					\
+	do {								\
+		struct task_ushrd_struct *shrdp = t->task_ushrd;	\
+		if (shrdp != NULL && shrdp->kaddr != NULL) {		\
+			shrdp->kaddr->ts.run_delay =			\
+				 t->sched_info.run_delay;		\
+			if (p) {					\
+				shrdp->kaddr->ts.pcount =		\
+					 t->sched_info.pcount;		\
+			}						\
+		}							\
+	} while (0)
+#else
+
+#define task_update_exec_runtime(t)	do { } while (0)
+#define task_update_runq_stat(t, p)	do { } while (0)
+
+#endif
+
+
+
 extern void task_ushared_free(struct task_struct *t);
 extern void mm_ushared_clear(struct mm_struct *mm);
 #endif /* __TASK_SHARED_H__ */
diff --git a/include/uapi/linux/task_shared.h b/include/uapi/linux/task_shared.h
new file mode 100644
index 0000000..06a8522
--- /dev/null
+++ b/include/uapi/linux/task_shared.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef LINUX_TASK_SHARED_H
+#define LINUX_TASK_SHARED_H
+
+/*
+ * Per task user-kernel mapped structure for faster communication.
+ */
+
+/*
+ * Following is the option to request struct task_schedstats shared structure,
+ * in which kernel shares the task's exec time and time on run queue & number
+ * of times it was scheduled to run on a cpu. Requires kernel with
+ * CONFIG_SCHED_INFO enabled.
+ */
+#define TASK_SCHEDSTAT 1
+
+struct task_schedstat {
+	volatile u64	sum_exec_runtime;
+	volatile u64	run_delay;
+	volatile u64	pcount;
+};
+#endif
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aaacd6c..189c74c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1270,6 +1270,7 @@ static void update_curr_dl(struct rq *rq)
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
+	task_update_exec_runtime(curr);
 
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c4520..cbd182b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -817,6 +817,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (entity_is_task(curr)) {
 		struct task_struct *curtask = task_of(curr);
 
+		task_update_exec_runtime(curtask);
 		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3daf42a..61082fc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1014,6 +1014,7 @@ static void update_curr_rt(struct rq *rq)
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
+	task_update_exec_runtime(curr);
 
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a2..4ebbd8f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,6 +67,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/tsacct_kern.h>
+#include <linux/task_shared.h>
 
 #include <asm/tlb.h>
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index d8f8eb0..6b2d69c 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef CONFIG_SCHEDSTATS
+#include <linux/task_shared.h>
 
 /*
  * Expects runqueue lock to be held for atomicity of update
@@ -166,6 +167,7 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 	delta = rq_clock(rq) - t->sched_info.last_queued;
 	t->sched_info.last_queued = 0;
 	t->sched_info.run_delay += delta;
+	task_update_runq_stat(t, 0);
 
 	rq_sched_info_dequeue(rq, delta);
 }
@@ -188,6 +190,7 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 	t->sched_info.run_delay += delta;
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcount++;
+	task_update_runq_stat(t, 1);
 
 	rq_sched_info_arrive(rq, delta);
 }
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index f988ebe..7b9b60f 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -82,6 +82,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 			max(curr->se.statistics.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
+	task_update_exec_runtime(curr);
 	account_group_exec_runtime(curr, delta_exec);
 
 	curr->se.exec_start = rq_clock_task(rq);
diff --git a/mm/task_shared.c b/mm/task_shared.c
index 3ec5eb6..7169ccd 100644
--- a/mm/task_shared.c
+++ b/mm/task_shared.c
@@ -275,6 +275,14 @@ static long task_getshared(u64 opt, u64 flags, void __user *uaddr)
 {
 	struct task_ushrd_struct *ushrd = current->task_ushrd;
 
+	/* Currently only TASK_SCHEDSTAT supported */
+#ifdef CONFIG_SCHED_INFO
+	if (opt != TASK_SCHEDSTAT)
+		return (-EINVAL);
+#else
+	return (-EOPNOTSUPP);
+#endif
+
 	/* We have address, return. */
 	if (ushrd != NULL && ushrd->upg != NULL) {
 		if (copy_to_user(uaddr, &ushrd->uaddr,
@@ -286,6 +294,11 @@ static long task_getshared(u64 opt, u64 flags, void __user *uaddr)
 	task_ushared_alloc();
 	ushrd = current->task_ushrd;
 	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (opt == TASK_SCHEDSTAT) {
+			/* init current values */
+			task_update_exec_runtime(current);
+			task_update_runq_stat(current, 1);
+		}
 		if (copy_to_user(uaddr, &ushrd->uaddr,
 			sizeof(struct task_ushared *)))
 			return (-EFAULT);
-- 
2.7.4

