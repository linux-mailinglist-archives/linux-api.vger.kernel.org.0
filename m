Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A5F40422B
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348419AbhIIARb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:17:31 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43496 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348315AbhIIAR3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:17:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LgTf6004812;
        Thu, 9 Sep 2021 00:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=nNEKA90GudLCUBcxqErz7wVEiclwguN0YsBvnfRc1o3Z/nv6oviwNl4dkKzmxjVJgQnH
 xa20TLcRDHJrtl9IqfdQDmDYib/jxS4lFnPV5z0+g5GjzXC5RAGveuYVv4jiOqB787j1
 YJHgJaC0bAhkAMh/KbFft/ki80TnFYe9/iYorCysGc8iBd/B/3G9FL4lfWW0j1B6pgOG
 sRuC6N78SkrwiiURreLD8j4cTL44BaxpkrxDCg3hyVSayi6gmK6g7brd8KIOjHsHCtsR
 BqJNGYAHCw4i6osYeZXf1sWWH6k7HRQ3NYm5gHEKkiGVd3p73zOqaMuBe4M1tAhUk8qP 3Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=q+06ntvpd92p07jiMJEvUC7b0iG1F4YarPpQZZSab7qKKhKbohN6WfXET8Ssf/xYJUu4
 iH7Br0ixMV8Y77oYvRX7vfxdRCoJgJT7Fb9PkLcZXdbCk2qiEoTiqUH2Xl5SDQJ/fg//
 0PJy9jSB0onuqXl7kfIuQloeBtc93mEH7pMntxt/qNiBXAd4evitdj5CtGMisoFvvTNt
 K7NVOeCBaOd7uNeniCSfO4J0nnsjYuPmeRdlVrQF51agz+a61arkr2lmVEbg7K6U3zZQ
 6o0oYSGymXTOp5yUit0fHs6bnlmR90w2H0PfVItK+n/uqwovxJi+P5VLBfwNymHbPqJP fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcuqcdtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1890GEma180423;
        Thu, 9 Sep 2021 00:16:19 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3axcppf5gy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3nEMlfFn9PRv8aIlJN+3MCCGS0xH9rAGBC5m6YmiyRZoFajDVaFVhFjUw26jGMgOClHcl8zJZrn7eJHehSR51uph99xj7bVgZJT4J49ni6ARTsvmSvcsKhrxMuRq4EKWz7lOlHM63xjUCxND75Y0J1dXVMJc4JJUYJvcM1gL+1XTJLST42AuPSjhjkloy4jWKt6h/A5MCMdzksJ/onLoaVIwaCZgxwx3iu7AKx6uv9KeJ8NcS9pEj4mW52x7GJLk+89MMtrzaIZIhTPw/BUH0ffC/X+jFzwmeblIR04RwHQ6KfU1VX2jJE9f3KrVvLyytsoYKIIZJBjTKVdxVESnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=JJSt1LR0lwDgTUY4ZTmBd9WzpIByOFW4I6E5hcszFCObYZO7gZZej/AfJrDbdTBXBET8nGZE30vmQXGxC7hjea+AizYsLwKCt+lVj6E0fHaMPcQgGhi38JRIuBco2T3pV1L0+R3h0uBNYf3Si2E9ByCodKExbz+M1cbwWb447+aKh1+OatClCnlQIxqoloEu+pyxMRRvhrSrigYCLeZgSFyE5WfjghzIg/pH7rum5PaWBsVJzbRlbIN1EmHXNr8ObKvzLmnYRkR2byNATcNpsXRfG8I7ZADfbly601yCeB9gzjzcHJ40i5y2nuKLzVzXBA+PN3wXwkEFAuHSNwalrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=LC56otMFMsCMhMOK1GTcD3usKHTBu7YGcvuTAZN6UJrAhk4nDIx1PEIR4j9OGdjfYy5ojI1Ktlfze8CtV5jK8SyPDLqc7RKqts68wFq8cwwBwnu5xPRJgQ7iClW1hdQZJZoDDJ8pqRIXggFRGF/9fMfxBD73LER03qtkErMy0xA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 9 Sep
 2021 00:16:07 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:16:07 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 3/3] Introduce task's 'off cpu' time
Date:   Wed,  8 Sep 2021 17:23:56 -0700
Message-Id: <1631147036-13597-4-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.16 via Frontend Transport; Thu, 9 Sep 2021 00:16:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121546ce-a6b9-4400-943e-08d9732704d4
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB288859CF06A665BBC45C7A08E4D59@BYAPR10MB2888.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZtqJSxHt7K89suobw8YN/tjkuiOJTmiDV1BcWdPWVtr9P0nm3c0zcKYBgYqLJVLTpKD/KNca3YuLpD1eG72P6qNDNa714AMUAV8OqOYiCFjZ+w5jp5ectvT1DEQrwl2NU0Lpk5yJEtbXCLAhA2yBbfja/WM/oq3pyHqU5IR2aT8FD0CayXxb40YcLBwv4ewPcE7U9UYTGqoSmEqdZdzByfkblqqFFCLlS2GvzQzNHHylcBpr3DJ97dLdLKpdHmXcDXwfL6bR2AnkiJ7IsErYD7l7sF4zi6+IXYkdgpKmqxP4QTU2Sv9MOCCoLEu8xU6fvI57QBPzO6Eh2Fn77Ot0WO6Ii6wsMWA8REUH1HfdeOEyfUW+Xc+20yGFKLNCWwN5yHEhDSrdcwwbPRwLkZ9MCtDX0MojupaJ8U7IlLn1cRd07QZIkZ+10/xPKXGE5QMbotMIL9qev2peeZmFcApADW2ycTGreXo0EOQzz+VInBbqYcBH5dqzx8JdDovUvxhaSbKlA1KwAerhv/L3MfdPUAuvXNg7kgP4676LNgVy5syh8+akQQCuiSyKp1YOIHd0u++fIbFfTgMwuXf7Ak9a8eefK+7OM6EgyE3lrGWNUiwx+MkDEXSvNO0WjN4TGw2G0n1HmalUQwJ/2oIKYwABQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39860400002)(346002)(8676002)(2616005)(8936002)(5660300002)(66476007)(6486002)(83380400001)(6666004)(7696005)(52116002)(44832011)(107886003)(316002)(186003)(66556008)(2906002)(66946007)(36756003)(38100700002)(478600001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D46WJjr9Ucmq6Qg8Z6JNw4HPnxnz0GfLikHvcGC/d5DLwafxFqR/+Y6wkZFS?=
 =?us-ascii?Q?zvdcC15cthwCmgAjRjOpiGeY3MyLrWwXnSK/aTEPxA+NvIOxRdSqFC91uF8R?=
 =?us-ascii?Q?VPwZLXSSM4yGbB5Q8IX3IzPcHDE/vX2n0w5re42WL9e01LqNBGVMYwH46Umk?=
 =?us-ascii?Q?wFjSSH4vP4AO1sZmzmCVGM94OT/ucLYmR1bxotMtv3ykiEzYbsJFyLTUTOu/?=
 =?us-ascii?Q?nxK6c8tSVuYe5V6WlJTTm0km+WrP+YRTNeMXeKo6tB0DDE/b6nBhSEZOg86G?=
 =?us-ascii?Q?pG1a13jLecW0H0dpwWjSMYYZ1dnqmccxP+QMHtgfLMHQGw29B7gq+m4GgpQv?=
 =?us-ascii?Q?cO8m5yBsVEOv23NMKjYEEnRUDD0ZSE2tWmdfAI+njNcW6kZeIrEcPGNRM4/w?=
 =?us-ascii?Q?A36k6Dl7A2sRaCNbjdUdlgdqrSuWil+wESYo00IQENK2r90k6TeccbbSt+fk?=
 =?us-ascii?Q?i/Ped1fhRORBC5swwyzmCG0ZECbMsQDOymAVMSLKrNTBs4I6Wae8aiXNQ7LC?=
 =?us-ascii?Q?iRoR6pLkHtaVfqMU0pEJ5gPBKyae6Wy54FbazyncqqptfYcbEHbDms32TsJh?=
 =?us-ascii?Q?rZVDSh01Jw0jXEy1SF/+XoDlh9rUTFApbnZRQrVxhO13BzeGTIXzLQpVY7eS?=
 =?us-ascii?Q?2UKy+fLdAQVfkpYepnGBqrvg2aW9A0iUnqQd6yAyKKABGmQviMPbXYpFdwf7?=
 =?us-ascii?Q?dgp1gl3Z2WqK6aapQwiqhVh8R7yd4OjYSz0l5YQQdsJP44jrmKZig4vs3R3g?=
 =?us-ascii?Q?k3bPntarKuMAbdSWNue9hhgNg8G3fcFptJk3E/yAHi49qkQ3fQwR0nvVh7NE?=
 =?us-ascii?Q?wUACiw2HIsop2vfShLzwsElTjbKTIBnYaLEGnVQnZptaFdOALzBr8TOMZrBh?=
 =?us-ascii?Q?lpi/TOFx2Uauacv/wNzpjHqTBpu7L6AsvPS3j50zKSPn3cDeT7KEmEWQstD4?=
 =?us-ascii?Q?ISwmPVvdQRW/BefgOBo62fUaDoPt772V0nXdtdyoSmc/Y+3NJMVRIqZztF8O?=
 =?us-ascii?Q?EOr/mAY/5QGAR2dsLIX1xUhuAoKs2Y4M/owgbrHfgrmCYOfT7mHqegVGI19b?=
 =?us-ascii?Q?QJP8CTbS3fPYyloroYx5PW5nlkgTgwiJIiam2aLBkoYJ5S4hKEgGy8GzyIJC?=
 =?us-ascii?Q?EsLuya8wcYj56E2Kdt72quXUQqK75FjwHkxuK9n4gJIVmOBu2V6gm+hlj7/x?=
 =?us-ascii?Q?jakLdNvdVDmqMHgmv1kQxMb53VWQwa07yqLT35nBFWBZfcsMRm89gplKYgNv?=
 =?us-ascii?Q?U2zkYksXYQ/u4Wn/ag53O3eRxfIryG5jWskGxoH+9bzOiAwlqWgqqDEjBRdK?=
 =?us-ascii?Q?iViAcJll5/AVTbFBuYf0Kkqeh6l/fgfifWB9WGP7bgh7wjs+LnH2ifBcOSaY?=
 =?us-ascii?Q?OKEjVgw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121546ce-a6b9-4400-943e-08d9732704d4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:16:07.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5SfgjSqweN/bCt5LIEAq79m5s57IC1rKw5vvroUIXZqa28ZBdnTSHLQiSIb0b4dVTNPl9qBUvHfV8FgelKnPW5CUBB1hLVfDncxWb+pQYk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2888
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090000
X-Proofpoint-ORIG-GUID: Rykf8vKh2GWYy6qCEuscNX-C7V8Vx7wC
X-Proofpoint-GUID: Rykf8vKh2GWYy6qCEuscNX-C7V8Vx7wC
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

