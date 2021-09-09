Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992DB404204
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbhIIAEA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:04:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3948 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347884AbhIIAD7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:03:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LPmWb025837;
        Thu, 9 Sep 2021 00:02:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=T7qt+ffZm7/P0Iky/kj5vi2cGpJzUlyDDIlvz4sUIKpXPM/CgkelrKKNnyS+GZ+deusP
 2K2LGNeaW2OjSYhcES1jkQL+OygEUmJx/N1/im0aU7Mh1iAnwMaubdZk+AqotyfPmrl8
 IJo3x3mePHMmGjK3VlvSqZ4LCQZ53cP3YPSa6ZRcy9YD9ZzYVypHc4bkED8CkCE/BF8f
 FZh1z8ExLxofLV8zFqpucNR5f7gK4dDD6xhTJXWCvKyl3y2FHMfc+a982wcGhjTXcs4m
 EAa62WrXWjFPquE54WdUoI0cpM5+SZNflvTf4jBtJfJlszQjnkMKt6kuBkt0t6ymVQJv Mg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=m6ePZwoFjFczn7Kn+IKID9HXY5u3aHGPRSo+Jl3gSKDS0T6+tDlY7aC6Kh8bb6Ib4uWw
 Knhzk9je/Hx4i9hh28ZvP/cogVT+qeUc5R4gAHeiQ7G/F/wUKMJWrKo+DVm/Zm7tzzOW
 xrM+1KSWrBYos1WapQFPkt0ksKW1nS6StwBV1xX4eR3FTv75FreHtIGd901jV8jpW9be
 sR+fhyYS+RygsmeQZJ4AQRwTYt6T3W2tBicS9SemjSUHNd6+/ViLfIeSIo6YuoD22OBo
 1c1IPx+UTuzXwne2ijadXiUMI1GBvuIpd9V8BJefVscQ/nbCU25oDvG5pmWITgT2fJkf Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd44vfke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189005DK111123;
        Thu, 9 Sep 2021 00:02:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3020.oracle.com with ESMTP id 3axcpmy4x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDlxRqedwP0n0f1cPIVAq3T2QHc2Sx7xP9t4Nfj2ZdhnQQuNrq17+CjBHjCDWikxBBHvQOOK6BZ3Hw4Sxm6c5MHGMj7vj0ACwvimiFWOi/++Q6t4LrnTrJDU3xonestp1gmNF1qFVFeydeBRcBAOBGib/qYElKzOZqXzo8IctjwoSLQOI1j4ov75etBzLC+gz1F+o1bSH+JRthsM/atDit5dPL2F+K+zfmz3ntAzKhoJat8URSFagnXWEUkr6uTUIK3AMSlStOq7j/9R2jfiK1SOHtBq8M9cTgpXu8+jPzR6KA6A0EIrgDY56vWkxgXTl5U4/0CDdqsfSSFfiIyf+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=oYOe66mwyTBG6vhZNjQqucRc8QR6/PQXP4nuHld6daSUhjwV4KJKnWLCiNRJL3UPM5JoFHaMKG3qU1OAGJUuwiqBAu/Ey3INajMHYqcv+nhs7wqvsUhzrHUUXfoWqHIRfTzOC+ahigGvQILZTSrsY+n9yZq81enKn+QxzfBJ33L4nFGjp9sOpP54f1CCsRDWDnahYX1px1Yfwcij4Q01vogT0tO+R5Yq4gp3Xj0U89pWyssdGVh53dX6CvLxNJkD7yPMYDXepHDJn26gN27/W6B2iWkNGQtqHqoA99nzxTTuXVQyHZ6oVD+Eu7t7yTqnKBSC5Nq+Aj5ftBG8OKANig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=Ba4xOVa6evWIalA4oUKJXwdeILYYInRchMdLc+jxDhxsP1sm3vtZnVrIMyerAyTwxOx6Uv4g2ExPus9FLRaNSxUnAV311SH8/F8xK6ztpLIIRVArkTlUNl+t6a1zExVULzCcy56gFpTQFrgFqnF7CXReMRaQPN472zoH4yJtRbA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5472.namprd10.prod.outlook.com (2603:10b6:a03:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 00:02:46 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:02:46 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     --to=linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 2/3] Publish tasks's scheduler stats thru the shared structure
Date:   Wed,  8 Sep 2021 17:10:24 -0700
Message-Id: <1631146225-13387-3-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
References: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:806:f2::30) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 00:02:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81135b2c-bc79-48ca-1637-08d97325275f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54722CD3D1773F1EB1A51CB7E4D59@SJ0PR10MB5472.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lTCYYvQoJDFXHIJ57PyUxTGccv+KQyAGym//0tFz1t5o8P+Lh+zXEviUSCfvDQziCt7G2xaRUiG+/1Sf6EM1QzeSLFb9Evs73VgvOOO9IY5atz71fuvMne6EwosM0wUA/WZoyHhFWtZM1PzlEeqHswNMa3/O1a49HNXjX3Gl94McCIrdJNK2Hu/VN9OBwPYFaVNMrfXO/cxXuqefaiF5yJ7rKDbFrOqgBgEQPGaEC1m/y4IMsGm4Kco3ctLDHiUhpyVJN50NEjUzefFFMsI7GwOlY9mLOnFsUPwTzfDPangJU6ifh9P8OMHW7FGfN8Gp3GC69d9cG2IlVuXAjLeONhgpYtrfXHgpNvcILmyRPMRUt0AcaF/hJiLwv+yEPfn6BF8jaXSQOPv9ChTZbEbhbnawDRBEJopQIdb3YyhLc8Rsl8ImC1oNlw8/gyeTdzeZRs6CXj97u1w8LJ09WkiEhPGgESuqBjOEEipTJJj1hiYoxtEe/Ta+d/fDkVaLO2exDdhvFNEqpZZpLUMIQRGFQyKr1tXmahVXbDkFSgW/weE18dYkCyj7xlHgq5sH8cuBXAmIfZ0p4c4XCMruUL2lkz3crPXXF6CTI/emZLBLEqWjOu61gbOSrbX4MDtVaRoiSyv8C6hiH+Koql2GFs1+Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(66476007)(36756003)(2906002)(186003)(83380400001)(107886003)(38100700002)(478600001)(44832011)(2616005)(66556008)(4326008)(66946007)(8936002)(86362001)(6486002)(8676002)(6666004)(316002)(7696005)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pV2ZcEIyQGAwfyVbsynt96In0YoiedBUrPo5vLJthlKiGGRUOACNs4rOeVUh?=
 =?us-ascii?Q?1//sAHaFA1Uvn0SHVn0c+PSAxzWrK/pH6XrBj0JDi1tPN/DK9hGqDTDK7u1K?=
 =?us-ascii?Q?oGnvfPshDoaM55TdXY0f/UNLjFXEdb/pb0cgATKam3CHEVpfWyJ9qo++Wnww?=
 =?us-ascii?Q?HhM0yMPvTWBmlyje3ckmIY9A/jf28si6rC7RFTRxzKoBZXQ4mG7TI69iuMcG?=
 =?us-ascii?Q?/qg8qKdsXGJNHulqHPKIqw/UL5huYk3oeFG/TDqE3JQVrKZpBNr4AsI3t84s?=
 =?us-ascii?Q?a1h414ZUKs6WAvf0E47L4EffQUOkIUaK5cW0FzB1K4ah2GrLsfhNLXrbuspo?=
 =?us-ascii?Q?3nOsPNYgiWJAboFZBscbAnv+NQpEnp7zWMBdkWuYW7g8W3ddTb4UGof6qJiI?=
 =?us-ascii?Q?nhR1ozXyiQoIUz+CmbfRWZcBklhYqh5QZAkV/z0MJs+Y4EE0eNPYIbcMOorp?=
 =?us-ascii?Q?Qt8S9V2j1LVrYXoA6MQ0OsiXaIN1a8uCXr35E1vx6WKT3TJ3PH+ahY7CEgtN?=
 =?us-ascii?Q?wdWOEbcOplVBH2sfqt6BPaJq9UpbNSnW3ZAT7wMC+vuhE+/mSr72jdHbk3xD?=
 =?us-ascii?Q?BhmG6d9W88zAc33Z5Wle/XHen/v/JtqwWaTlz9S5iXoZk/nu31meJSjYDHId?=
 =?us-ascii?Q?F10/2aUDeVDCCpn6W+NrOoGPlW3JZEkmYEAFQ0mct6lI7q1tCYm4wVBsHMRD?=
 =?us-ascii?Q?oZPoQjDvtMJJqWDxNg+wEN1gHgCsnMBntGQ0ad0taelfZ0WzSG/NAY0VlLAp?=
 =?us-ascii?Q?fGUqJOmW6nFD9Z5CKqyUJy/ZLQlZGFhbPPa4G2KTeP15B7/jvOosYEFy0tDf?=
 =?us-ascii?Q?1wPAJdinE7vuULy8Bvf//6eVI6lgM1nyygKn73PjKGoUOk4tYnG2/UJ2GSDG?=
 =?us-ascii?Q?5YzTBt6UiuMCl6lXBc4z34KUNrdvNYMTkDCMAh2TuwXeqKlGAdNgPmEIkjPx?=
 =?us-ascii?Q?+Fbmm0Gw1Xz/WMKsSsSnLNW3hnI66COXUcFRk3+zUe8mf1mFlKlQ++mjRIbd?=
 =?us-ascii?Q?9zW6Z1Vj+J+TLAH3GDhiF6LPDsyiMMDwoG2n0nZlAPsUL1w8xVvc0CGxITO6?=
 =?us-ascii?Q?j6XA+qRW7/aqSvSt95v/4bB1keQ/jvWblJswFqjBf+kGLhzNQobmniTKucCw?=
 =?us-ascii?Q?fHgX76e6rrMmCczEqFU6j0DuTNMWQvdRaVe3rLt8rNgV0bW9kJQb5DHsxr0V?=
 =?us-ascii?Q?gf63dn2N2c7ZbQnWy0BWr8/u/CTLUzttmGB8x/T47o2VIOmt8dQvBaTJHWm3?=
 =?us-ascii?Q?X1iJjct3ZPeRlI9blQgIZquKPJ34TXOu3sUASclm19dounkaJbXPh8XLL93k?=
 =?us-ascii?Q?RsEl/alQ96H3jzPuazgtlKMqLyNNkCYQ+TCB9IpwavU86g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81135b2c-bc79-48ca-1637-08d97325275f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:02:46.4161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWq7y89xyiap5aU82tEqjbkAMY21H8IIlAmErvOqbmpwGibtLsijU2QAmnqq5oW52CbOji0sOxEWbNvvIPqDp6qb0eBHLl3Cv1x3+8vb3Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5472
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080150
X-Proofpoint-GUID: 4a2PPRYjBKXQzvkg75pUHbEScxU0YMyM
X-Proofpoint-ORIG-GUID: 4a2PPRYjBKXQzvkg75pUHbEScxU0YMyM
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

