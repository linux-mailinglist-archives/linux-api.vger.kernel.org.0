Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8112C775A
	for <lists+linux-api@lfdr.de>; Sun, 29 Nov 2020 04:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgK2DFi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Nov 2020 22:05:38 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:32934 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgK2DFh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Nov 2020 22:05:37 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AT34oVc143863;
        Sun, 29 Nov 2020 03:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gxNaaU/W3FUj48sXjVNEtaJGXcSYRrY8PpuBzT4uXH0=;
 b=kwTcE4UsJrxzCFG1bfoUuleo+uvEJ8tU4pa9JO5LUXq5B+beTxX9QUjPn8qGmGtGEFYP
 Sf/KIFApE8gJ0vUVqb1CFHROeTJ5tGteveMrU9xvBy3cKApTIMEIXc7ivyf5+WoEQO+R
 shs1oNr1IfzJ6O3DnIlOug9Gt19RKf0QXd/UfRNIDmVSVOjb+X7TT7NnKx2QFAQdKS+F
 tyHhkyWbx7fm3KFVmn7SIwL2h/8Ulm7xbLIAEgcc1Qkpopz8IqXulRO5qIESQVL7TWet
 FQYA+JCnRQwlFlkvp1Q95zrt3m40apGiEEPGikRcemjffo5cAU8r1CXDKPsLSc11LjJa /Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 353c2ahmqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 29 Nov 2020 03:04:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AT305Zi138952;
        Sun, 29 Nov 2020 03:04:50 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 3540anwh4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Nov 2020 03:04:50 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AT34jfp006991;
        Sun, 29 Nov 2020 03:04:46 GMT
Received: from oracle.com (/10.129.135.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 28 Nov 2020 19:04:45 -0800
From:   rao.shoaib@oracle.com
To:     hch@lst.de, pabeni@redhat.com, jbi.octave@gmail.com,
        linux-api@vger.kernel.org
Cc:     Rao Shoaib <rao.shoaib@oracle.com>
Subject: [RFC net-next af_unix v1 1/1] af_unix: Allow delivery of SIGURG on AF_UNIX streams socket
Date:   Sat, 28 Nov 2020 18:52:12 -0800
Message-Id: <1606618332-23345-2-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1606618332-23345-1-git-send-email-rao.shoaib@oracle.com>
References: <1606618332-23345-1-git-send-email-rao.shoaib@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011290016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011290017
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

For AF_UNIX stream socket send SIGURG to the peer if
the msg has MSG_OOB flag set.

Signed-off-by: Rao Shoaib <rao.shoaib@oracle.com>
---
 net/unix/af_unix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 92784e5..4f01d74 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1840,8 +1840,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		return err;
 
 	err = -EOPNOTSUPP;
-	if (msg->msg_flags&MSG_OOB)
-		goto out_err;
 
 	if (msg->msg_namelen) {
 		err = sk->sk_state == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
@@ -1906,6 +1904,9 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		sent += size;
 	}
 
+	if (msg->msg_flags & MSG_OOB)
+		sk_send_sigurg(other);
+
 	scm_destroy(&scm);
 
 	return sent;
-- 
1.8.3.1

