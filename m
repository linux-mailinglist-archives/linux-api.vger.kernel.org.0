Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF0F1009E3
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2019 18:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfKRREU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Nov 2019 12:04:20 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKRRET (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Nov 2019 12:04:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIGwxS9155920;
        Mon, 18 Nov 2019 17:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=PTkoEEtcL3+nuIHWxsynGo3Qi7g5cwPRqx/QuAOHMmw=;
 b=DMdl7W9uC9bqWZ/epKz37dhIwooSf9lLNXdhJnsKb/u+bJ7zO6dXZIL52syfwpqlbGRK
 ImsbX6fBSuEV3IUFbeWi2UVJrS9wCncOBAGYJ/6QqiG5fJ2bHK7zxTCOyA98Io55YSc4
 dHDW1KVf9FtvbhqYNVhUOBkrl6Fd21SIlPP/N0AK1wXi2pDVQHRqJ8zH4NwpLKMP08qd
 ly6yLKUrtxVG/16AcSiVOQ3mrq5DzBH7OAI6I8A3sqR3t7AY9w3YRIKkAzXkhdicBtXb
 1zRajWFLm/OIaO8zGwZ4lg9xcv1V3w3FwImA6X+SfjEV7OcKf6OaknOVSh1eh/GUphdE XA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2wa8hthmst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 17:03:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIGwbwK159204;
        Mon, 18 Nov 2019 17:03:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2wbxm2tjtd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 17:03:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIH3ksF022683;
        Mon, 18 Nov 2019 17:03:47 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.95.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 09:03:46 -0800
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     ebiederm@xmission.com, tglx@linutronix.de, peterz@infradead.org,
        serge@hallyn.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 1/1] Selectively allow CAP_SYS_NICE capability inside user namespaces
Date:   Mon, 18 Nov 2019 09:01:18 -0800
Message-Id: <1574096478-11520-2-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=12 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=4
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180149
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Allow CAP_SYS_NICE to take effect for processes having effective uid of a
root user from init namespace.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f..628bd46 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4548,6 +4548,8 @@ int can_nice(const struct task_struct *p, const int nice)
 	int nice_rlim = nice_to_rlimit(nice);
 
 	return (nice_rlim <= task_rlimit(p, RLIMIT_NICE) ||
+		(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
+		uid_eq(current_euid(), GLOBAL_ROOT_UID)) ||
 		capable(CAP_SYS_NICE));
 }
 
@@ -4784,7 +4786,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	/*
 	 * Allow unprivileged RT tasks to decrease priority:
 	 */
-	if (user && !capable(CAP_SYS_NICE)) {
+	if (user && !(ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE) &&
+		uid_eq(current_euid(), GLOBAL_ROOT_UID)) &&
+		!capable(CAP_SYS_NICE)) {
 		if (fair_policy(policy)) {
 			if (attr->sched_nice < task_nice(p) &&
 			    !can_nice(p, attr->sched_nice))
-- 
2.7.4

