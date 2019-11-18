Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1485E1009E1
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2019 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfKRRET (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Nov 2019 12:04:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34484 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfKRRET (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Nov 2019 12:04:19 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIGwqKt155782;
        Mon, 18 Nov 2019 17:03:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=KkJBV1OKZEQpd6p0Z4UlW9v/6UWLZWUIedN3euPfzqM=;
 b=iqibYGOOoB0o7db5SbaPW4ndmY3yFGe13+1HRgRhTAVfz4O2tV6i8h3h4w6qcMTVrBw6
 osAzjI5aGVM8zlkS80bq8OmZnppVlznX61Qnkg7RuibiORt4cVoKZq6s204TRbteZn62
 0U58zEHX6UcvLe6ElQfKc7rhtg7CXdmy2Uoq4Drh7WjBInV0DykEPRITnmMf5NT4W9ub
 EMSHZSSMDkNqxpW+eKfh5Lkv9nBLTswlJSbbetQBkK++jCdnoC5nDGZtqDJE1Jh/TEXd
 GnfgXBmUQwgBa1TAYK6/zquTJUNGMRdYozaE3AsSr8ADUI5uyXv36kCLC00Y1bW99gOI oQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wa8hthmsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 17:03:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAIGx0ic137512;
        Mon, 18 Nov 2019 17:03:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2wbxgaqu4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Nov 2019 17:03:48 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xAIH3kbs004795;
        Mon, 18 Nov 2019 17:03:46 GMT
Received: from pp-ThinkCentre-M82.us.oracle.com (/10.132.95.199)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Nov 2019 09:03:46 -0800
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     ebiederm@xmission.com, tglx@linutronix.de, peterz@infradead.org,
        serge@hallyn.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 0/1] CAP_SYS_NICE inside user namespace
Date:   Mon, 18 Nov 2019 09:01:17 -0800
Message-Id: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911180149
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9445 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911180149
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Some of the capabilities(7) which affect system wide resources, are ineffective
inside user namespaces. This restriction applies even to root user( uid 0)
from init namespace mapped into the user namespace. One such capability
is CAP_SYS_NICE which is required to change process priority. As a result of
which the root user cannot perform operations like increase a process priority
using -ve nice value or set RT priority on processes inside the user namespace.
A workaround to deal with this restriction is to use the help of a process /
daemon running outside the user namespace to change process priority, which is
a an inconvenience.

We could allow these restricted capabilities to take effect only for the root
user from init namespace mapped inside a user namespace and limit the effect
with use of cgroups. It would seem reasonable to deal with each of these
restricted capabilities on a case by case basis and address them. This patch
is concerning CAP_SYS_NICE capability. The proposal here is to selectively
allow CAP_SYS_NICE to take effect inside user namespace only for a root user
mapped from init name space. 

Which user id gets to map the root user(uid 0) from init namespace inside its
user namespaces is authorized thru /etc/subuid & /etc/subgid entries. Only
system admin / root user on the system can add these entries.
Therefore any ordinary user cannot simply map the root user(uid 0) into
user namespaces created. Necessary cgroup bandwidth control can be used
to limit cpu usage for such user namespaces.

The capabilities(7) manpage lists all the operations / system calls that are
subject to CAP_SYS_NICE capability check. This patch currently allows
CAP_SYS_NICE to take effect inside a user namespace only for system calls
affecting process priority. For completeness sake should memory
operations(migrate_pages(2), move_pages(2), mbind(2)) mentioned in the
manpage, also be permitted? There are no cgroup controls to limit the effect
of these memory operations.

Looking for feedback on this approach.

Prakash Sangappa (1):
  Selectively allow CAP_SYS_NICE capability inside user namespaces

 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.7.4

