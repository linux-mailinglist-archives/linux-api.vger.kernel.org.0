Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CEB2C775C
	for <lists+linux-api@lfdr.de>; Sun, 29 Nov 2020 04:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgK2DHi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Nov 2020 22:07:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49452 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgK2DHi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Nov 2020 22:07:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AT355JO023466;
        Sun, 29 Nov 2020 03:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=rZ58Ak60K2QKl3g6LaqpMP90c9f8pGQiHZf7qX3ffyk=;
 b=It5c1HV8sVYopI+eD80hgt6Z4aVnH4wz2jp2R6eEYIQWf38u2vgLylBAMIpQ+QDtFb/1
 mEpYNSCPqjTwYXfs8uzf3Q4gJHglMTVsIWpiwf59aynCD/yFQBrWhD2Y7EX+Ba5Q9JR3
 NNArv1CarTYwTWHkfDiQ/mCCrf2topnoiWZq4hmmpPQeiXw1UQXDZjcUXzZLAcbD3AYT
 lMI2l/PIfYvs/ldfcsmDlj+xCH3xRU4Nvr5ml04FGxDZ7FVgRXD/1CfrC+zm0ePfIr05
 55hmfdH3AOIjMunuiqbJL+3EOaVbFF6lO7appr72PygD8xbZCGEnhpBSQsFEqojXNJ20 Kw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 353dyq9h65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 29 Nov 2020 03:06:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AT319s0188914;
        Sun, 29 Nov 2020 03:04:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3540ftbtur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Nov 2020 03:04:50 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AT34igo015002;
        Sun, 29 Nov 2020 03:04:45 GMT
Received: from oracle.com (/10.129.135.37)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 28 Nov 2020 19:04:44 -0800
From:   rao.shoaib@oracle.com
To:     hch@lst.de, pabeni@redhat.com, jbi.octave@gmail.com,
        linux-api@vger.kernel.org
Cc:     Rao Shoaib <rao.shoaib@oracle.com>
Subject: [RFC net-next af_unix v1 0/1]  Allow delivery of SIGURG on AF_UNIX streams socket
Date:   Sat, 28 Nov 2020 18:52:11 -0800
Message-Id: <1606618332-23345-1-git-send-email-rao.shoaib@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011290016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9819 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011290017
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Rao Shoaib <rao.shoaib@oracle.com>

We have a use case where thousands of processes connect locally to a
database and issue queries that are serviced by a pool of threads.
Communication is done over AF_UNIX sockets. Currently, there is no way
for the submitter to signal the servicing thread about an urgent
condition such as abandoning the query. This patch addresses that
requirement by adding support for MSG_OOB flag for AF_UNIX sockets.
On receipt of such a flag, the kernel sends a SIGURG to the peer.

Rao Shoaib (1):
  af_unix: Allow delivery of SIGURG on AF_UNIX streams socket

 net/unix/af_unix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.3.1

