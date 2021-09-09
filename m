Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F569404205
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347955AbhIIAEC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:04:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:7648 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347884AbhIIAEB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:04:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LXbo1004863;
        Thu, 9 Sep 2021 00:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=TTFL9TszYXS1B5lzzh1PJkcEkROkHY7Urix6uH4/whZsPTdOSngUuHN0RGbEQT3WBXbv
 ls38B1blmzEQlFJ2Ju7j34r1K+nsOyj67ZTkC2kucqzg1XlAfgMTbrUVDopEicuGmcrG
 27+z3moakCy1pev8E5HkTfNOafixoaTgqiQGfy6ncYnDD+LU47SAeI056UxrmFtmYs+A
 3pPTvktgBHL5qD8CHpvLpe22XfKeBWQO+oU+HDo9z3OVsKlkiScU7o1jjGtxw9vtOdae
 bGz86j4g7/ryXNHDmCONoyOkRCUKy6v3o3rGXH/v3FLnm9ZgUIbT4XfY6h/2aJjU8O5J /w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=XI7HDLXbXFi2YP37uV0A+/9DI2rK0BJo50hzHG9exjfE1gL6/jzwWR5S5UHtuZ2jtG5q
 /B4VdHpaYNF1iXNHRVj0Id5L8RXxGNrG5sBcfL+4Oj0z76PVEAPlXdJPepGOahS3aFQE
 zWa293bbH4XH0H7urcOmC7e2j6leL8ZIdlTg5FZe+i4oukskadOGZf3CUg89IagRyItm
 KoEOMoAZqYt7msojeaohCl7t/gORyQtG55C7tQKk/VgJf5uYjRNmqSbroycM5FjNWIV2
 OIWBJhjRxyhTEwcswBWJ6TIpvFx5n5oVefMttC0pfwtH/AdV9jCQSSgVzYMDfF3GC+QC Ig== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuqccwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:51 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189006BU111232;
        Thu, 9 Sep 2021 00:02:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 3axcpmy4ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjdBRoCPOUYcKDRwDdLwXM0nPEw0MnW1ZVv2j/aCCIrHmljCUC7gLwX1QIvH2AHRRCi6XVqtNsz4vYmBPgVQo+8OwTQajCApRJIT3jzDeNC5Y2Rqlc8q3tIwpb+kTwg45Ktny+g4VrMohvytyMPHncvYQFBlEvYRB3MM80aofyUqRciOU+lq6tO599Ots4eRa2yOgSn3N5yLZgGNOucllo8vqE8vhLp3zFJjSFxre1azKwZB49arxRXbu/OPUkJ/qv7g9suS3gZ8TdQPgh/RFQ3Owgrp6fcuvwhWUhkw72+KmZy7LP6H3teM+pJRPuEdd4JFFkVcfgVzcm2O17rB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=fo1jG6aJC7lEPY4wewS7qNjInm/SEABtVtmA5ZkwkWQdK8xh3oJNPCbwXwSYZM09fGskCWoBex7wVN6oCxMQT5Sx+vTmX/cfF9nUc6eNDe96O3iJ1cOa0S2J5ls5AdlNjRVYWIQoFrXL8wxjhggCk/9L+dcjx4YBYJ2hoEqxXWtZ1vwjC1FAwYU8jGLvU+JrVisW01ws7OPy5/N14n2OoCPtyAiJ0ppN1BJnhicImHmvJQrSh9DE4jINd/O5iOUXRcUWYkn9aXGGokBNNNCdjdA1hJ1uJvAUyGVF03ZRHixpWdm3kOfxH9/5bswec9VchnuZFDQMtLyeVPdGpCR28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=n3oyjkNxLnQO10kZuDqfQJj1v24ZPxLlahpJD/ufJo4ocTdU/fB/sY4vy88VL+OEp3BYE9Rs+RROpyTKBR5+CRA5wtg5ytnlqPF+Msj+iSbbBCe8KFLwOklKs6frAGzpS/mEk8v46xV7fu/6zq97H8q+UA6CfW802XiL49Ob2SM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5472.namprd10.prod.outlook.com (2603:10b6:a03:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 00:02:48 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:02:48 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     --to=linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 3/3] Introduce task's 'off cpu' time
Date:   Wed,  8 Sep 2021 17:10:25 -0700
Message-Id: <1631146225-13387-4-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
References: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:806:f2::30) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 00:02:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 390f4c5e-180e-41da-2624-08d9732528a3
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54727CB520F0653B37604289E4D59@SJ0PR10MB5472.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BEtv3UwFql+K7YSN9OF0Wu9iYZ8JhNNEt32kXLSSmAibSx1Rf+dwXkw6maGjtl9DMcWumQPQTqujSYm7lJ6ZU3chY1q36zTrXH/TBFUyUyZop9HmnQ65KDQDeqRQKCIL0wZvW51xmZxhwmfP4QPAkFEdrFALq6smnuwHD7+vLDEe3TiDNFLsEn8ZWQgSuPhbKuLXsNxCRZM0M26FrDXsMhGklC6z3VrHB9j9uuAWbHX9SUPeBBMyqVGLu+D4MHqKu+CyimnouQEErtHXMQGKLPSY4sg8F9/P4dE+PXGm5H2ODDKMHj3yewpI11uijgGNd7cOZLpfbZV4Qg75S8Eax0EJjuotYPunQCqaBYTc/zF5UikCmwEaEq7v0HsWREL9+LtghZ1br7G6P66UdP820JEILo3odjKbJ1Tt4WjcDegTX7qxmvN3tpWcy+GyDznqrIBjMP/MuOPNlrjuGcruC9+Hoew3vu7kigdRY0rqaMsURSb/HpsQ0R7l/OPDsosR0J9JQao6e01zmE4FXcjoXLfIuU+vDGgPz5rLXqWkILLJdCNJzBHMe9OX0Pxbk7CyDDgnuUKGX5G/Ly+BsdVar06lPoiljX5ij1oIlwTzyfg2Cz0wN0L1P+6AYx6Cx6B1JwtzOGeWsozHzZH2nJf9BA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(66476007)(36756003)(2906002)(186003)(83380400001)(107886003)(38100700002)(478600001)(44832011)(2616005)(66556008)(4326008)(66946007)(8936002)(86362001)(6486002)(8676002)(6666004)(316002)(7696005)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l6eB0l5ZAUW7EdxMa0i2eWic6ZMu5VKX/3B5hpp/VWNnOBV+336jOsplN3va?=
 =?us-ascii?Q?HMk4LCN5qK3rHJJSGFXIpkyqj00TqKsEEPlk62KFZO7GZKjXJs1X71iAN4J+?=
 =?us-ascii?Q?9liBonlUPMf8GnJkXgiXrwj7O+aLKa8kIVE/iRAEwAHvwLNbCAaH3n8BE7yY?=
 =?us-ascii?Q?wNcAHTqRcD3NfxeSdmZh0ZMYyZvB2k1SCkvZhEohMwXChChX5dzEH1R4UplF?=
 =?us-ascii?Q?lQEA1NKvQlH5SWJ5piHiOS8+8zRMP0QYpypAAd2caMZ2id159Of36NzfBcvD?=
 =?us-ascii?Q?Vpq2LuU35u0a2iIVFHwHqiWu4iVrBaZJA6Wdw2Ch7ZftEqG8REbp1Ei81Nf0?=
 =?us-ascii?Q?NSVBYO+SD5CNHziCiIRQGUGNqgZyGHGsSnVvQbdlhylSMoHwH647EjLo0d++?=
 =?us-ascii?Q?TC5Re3Gmt0/hDxpucA9iWXT1viXvIfdNfj+FMljuBbKcT2t3qvjmK/7t1pwz?=
 =?us-ascii?Q?7cmymuS+jAxfBLnk2xJGh86riAZcu4g1qzUVyx46tSff31HgD0LCo3iBYxvg?=
 =?us-ascii?Q?Zgm+gdpRaEon9bwEqnps/7+Q622wiuCFqhf3CvlWK3RfeyfFhHReIlOIKkwe?=
 =?us-ascii?Q?wneAUZbsrVRMbb7BiIUROgFpMKSTIzG9tQK2bJSZLD0rFhAAAC3EDp1XsLvW?=
 =?us-ascii?Q?WDaWT+UKY60ON6YO/5YavK60qLXKwgdor39uH5pmFFuMKWJ7m+VtR6mxo6G4?=
 =?us-ascii?Q?NkUzU6ng8L/Dsg349dWekb0xh9h3YAMCroJyIxSunDOsxQPXmT44ahs+Ac5U?=
 =?us-ascii?Q?9dIQUPI594eWRWXjtGHC4v36BFoAGJxft/I4Tgp537Kkdci2BH3Vvbb5R4x2?=
 =?us-ascii?Q?XFU6IsW4asMfSAKtq/JHmgCTdfgA+19pczXsuqHfgBXyMv+RftkbPvVqBCeL?=
 =?us-ascii?Q?HdJj097TfkgfDW+YR1Jn3VcE2lzUmPbj6AVAWi9hmWxfboSC/6YzRKknqZM7?=
 =?us-ascii?Q?Tl1wOc1AvngYtajoPTs1tTQenAvF6kbb3trInSZsSodsWzWvr3VUHNJsWlef?=
 =?us-ascii?Q?ZIziV2t8SYvFVjTzRRVIKcgB2eGNtwN8r0tar5UR2iDHBWBj4K3KUrjQNDwT?=
 =?us-ascii?Q?IrwcDQQspdxcYpXZwjD0r13o0RxfGYa4brdqa2bq5zddS5zxObbON7YZgpKA?=
 =?us-ascii?Q?b83OOjx242e8DH2ejLSX2ibT6pdKITeF6InciYyxKXCz//ww1+QkQNxuPxCO?=
 =?us-ascii?Q?gspUaWQ6+DBwv6IHABg+KW+t66LjM3LbQpGP+klNzdAxktYmhCB+6djTMfYz?=
 =?us-ascii?Q?XXU+0jgM4XVBJrnfxa1/4HM1jqQp9HhBB1DIR6zVevzaGMCs1RJKPeR2Kr0L?=
 =?us-ascii?Q?s6sfMlgwADP4PExIN4BoFwfcCLXEpFp2mAlqET8h/Ltcfg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390f4c5e-180e-41da-2624-08d9732528a3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:02:48.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxfAmMbMLLZXqr8KXu7G5h5vVfO5V9pbATQk5GyvTDS6oPK/xhFydezkhhDbHg/Sa5DlhqOr6A4tKGr8+2OYnbGOIBnLo8nrrxauCr7E6jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5472
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080150
X-Proofpoint-ORIG-GUID: Q-x2Q2E9KcXNQMwS_IUUybV72I8MwD64
X-Proofpoint-GUID: Q-x2Q2E9KcXNQMwS_IUUybV72I8MwD64
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a task's 'off cpu' time in nanoseconds to sched_info, that represents
accumulated time spent either on run queue or blocked in the kernel.
Publish the off cpu time thru the shared structure. This will be used by
an application to determine cpu time consumed(time executing on a cpu) as
accurately as possible, by taking elapsed time and subtracting off cpu
time.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h            |  6 +++++
 include/linux/task_shared.h      |  2 ++
 include/uapi/linux/task_shared.h |  1 +
 kernel/sched/stats.h             | 56 ++++++++++++++++++++++++++--------------
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 237aa21..a63e447 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -311,6 +311,12 @@ struct sched_info {
 	/* When were we last queued to run? */
 	unsigned long long		last_queued;
 
+	/* When did we last leave cpu */
+	unsigned long long		last_depart;
+
+	/* Time spent off cpu */
+	unsigned long long		off_cpu;
+
 #endif /* CONFIG_SCHED_INFO */
 };
 
diff --git a/include/linux/task_shared.h b/include/linux/task_shared.h
index 62793e4..ce475c4 100644
--- a/include/linux/task_shared.h
+++ b/include/linux/task_shared.h
@@ -70,6 +70,8 @@ struct task_ushrd_struct {
 		if (shrdp != NULL && shrdp->kaddr != NULL) {		\
 			shrdp->kaddr->ts.run_delay =			\
 				 t->sched_info.run_delay;		\
+			shrdp->kaddr->ts.off_cpu =			\
+				 t->sched_info.off_cpu;			\
 			if (p) {					\
 				shrdp->kaddr->ts.pcount =		\
 					 t->sched_info.pcount;		\
diff --git a/include/uapi/linux/task_shared.h b/include/uapi/linux/task_shared.h
index 06a8522..c867c09 100644
--- a/include/uapi/linux/task_shared.h
+++ b/include/uapi/linux/task_shared.h
@@ -18,5 +18,6 @@ struct task_schedstat {
 	volatile u64	sum_exec_runtime;
 	volatile u64	run_delay;
 	volatile u64	pcount;
+	volatile u64	off_cpu;
 };
 #endif
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 6b2d69c..ee59994 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -159,17 +159,24 @@ static inline void psi_sched_switch(struct task_struct *prev,
  */
 static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long delta = 0;
+	unsigned long long now = rq_clock(rq), delta = 0, ddelta = 0;
 
-	if (!t->sched_info.last_queued)
-		return;
+	if (t->sched_info.last_queued) {
+		delta = now - t->sched_info.last_queued;
+		t->sched_info.last_queued = 0;
+		t->sched_info.run_delay += delta;
+
+		rq_sched_info_dequeue(rq, delta);
+	}
 
-	delta = rq_clock(rq) - t->sched_info.last_queued;
-	t->sched_info.last_queued = 0;
-	t->sched_info.run_delay += delta;
-	task_update_runq_stat(t, 0);
+	if (t->sched_info.last_depart) {
+		ddelta = now - t->sched_info.last_depart;
+		t->sched_info.last_depart = 0;
+		t->sched_info.off_cpu += ddelta;
+	}
 
-	rq_sched_info_dequeue(rq, delta);
+	if (delta || ddelta)
+		task_update_runq_stat(t, 0);
 }
 
 /*
@@ -179,20 +186,27 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
  */
 static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long now, delta = 0;
+	unsigned long long now = rq_clock(rq), delta = 0, ddelta = 0;
 
-	if (!t->sched_info.last_queued)
-		return;
+	if (t->sched_info.last_queued) {
+		delta = now - t->sched_info.last_queued;
+		t->sched_info.last_queued = 0;
+		t->sched_info.run_delay += delta;
+		t->sched_info.last_arrival = now;
+		t->sched_info.pcount++;
+
+		rq_sched_info_arrive(rq, delta);
+	}
+
+	if (t->sched_info.last_depart) {
+		ddelta = now - t->sched_info.last_depart;
+		t->sched_info.last_depart = 0;
+		t->sched_info.off_cpu += ddelta;
+	}
 
-	now = rq_clock(rq);
-	delta = now - t->sched_info.last_queued;
-	t->sched_info.last_queued = 0;
-	t->sched_info.run_delay += delta;
-	t->sched_info.last_arrival = now;
-	t->sched_info.pcount++;
-	task_update_runq_stat(t, 1);
+	if (delta || ddelta)
+		task_update_runq_stat(t, 1);
 
-	rq_sched_info_arrive(rq, delta);
 }
 
 /*
@@ -216,10 +230,12 @@ static inline void sched_info_enqueue(struct rq *rq, struct task_struct *t)
  */
 static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long delta = rq_clock(rq) - t->sched_info.last_arrival;
+	unsigned long long delta, now = rq_clock(rq);
 
+	delta = now - t->sched_info.last_arrival;
 	rq_sched_info_depart(rq, delta);
 
+	t->sched_info.last_depart = now;
 	if (task_is_running(t))
 		sched_info_enqueue(rq, t);
 }
-- 
2.7.4

