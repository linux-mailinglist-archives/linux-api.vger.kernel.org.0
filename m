Return-Path: <linux-api+bounces-450-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A9D8245E0
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 17:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 143ADB23A7D
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8272F24B20;
	Thu,  4 Jan 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z5PvsOq7"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE4E24A01;
	Thu,  4 Jan 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404G9ooQ005861;
	Thu, 4 Jan 2024 16:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=hPsbuDOPQa7mvK/9Tk1ZUbi7L1u3SU56ie9iQcqGShM=;
 b=Z5PvsOq7LqYET87S47xzqWj3KbGSGauv7pl/FA57sBb2K18s2UOvpHbomoFwkvqsHheV
 U+jcrZtDDRgurBmT0WZh+LC/VC0p60gYyVnxYRhZkQZBMpXMqT3YIIEqTbc66h5EV8dc
 PBgN/3oyOTPr1KUPTZt9XgF6OJJstEgLC2CLtCf6JDsTyh++asnxjR5GSVm7YfoLUiZa
 ye7Us+0pf4UHzd6ig8zGu+KUoom//A/ozlkJDXVpMHs8pFdGrzuKqvnVFw8TKofa+5Yl
 YRdMGLt61iwxV61BwmeOTJZ26KGP9goR9tTb6qAZak2UZPXPi1adcsaSsSWH31P+9IWx Ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vdyxn806r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404FecAV039313;
	Thu, 4 Jan 2024 16:10:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdvhudx6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:14 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 404GA9ge026902;
	Thu, 4 Jan 2024 16:10:13 GMT
Received: from localhost.localdomain (dhcp-10-175-55-141.vpn.oracle.com [10.175.55.141])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vdvhudwne-3;
	Thu, 04 Jan 2024 16:10:13 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 3/5] docs: userspace-api: use single toctree level
Date: Thu,  4 Jan 2024 17:09:44 +0100
Message-Id: <20240104160946.3450743-3-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104160946.3450743-1-vegard.nossum@oracle.com>
References: <20240104160946.3450743-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_09,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040127
X-Proofpoint-GUID: 8rMT-XVrRLzZ5GA4lSckn5FH_wKz8SBv
X-Proofpoint-ORIG-GUID: 8rMT-XVrRLzZ5GA4lSckn5FH_wKz8SBv

Having a single toctree level makes this page more readable at a glance.

This also makes it more like the other top-level books (process,
admin-guide, etc.).

We can also consider using proper headings like process/index does, but
this is at least a step in the right direction.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/userspace-api/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 275f70f3bcbe..82f9dbd228f5 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -19,7 +19,7 @@ General documentation:
 Subsystem-specific documentation:
 
 .. toctree::
-   :maxdepth: 2
+   :maxdepth: 1
 
    no_new_privs
    seccomp_filter
-- 
2.34.1


