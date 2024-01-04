Return-Path: <linux-api+bounces-451-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A168245DE
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A37C1F233E4
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3724B21;
	Thu,  4 Jan 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YSbRBowg"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB524A1B;
	Thu,  4 Jan 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404G9pk8005867;
	Thu, 4 Jan 2024 16:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=X9vxQbxFR9yiom7tWw8fZfudhH+D0dUZJvMr0Tcyfjc=;
 b=YSbRBowguMf+oYk84lCh45C/wWysUseXr128NrBet+b7PEvPDjw97gDOKsK7IOgVPNw1
 uegk0AJ96Y87dxHwp1HmBxcmX8sO92gqYhSIUMRq5hiWQk5P4bnrAx8eC/7oJZO28PJ1
 PAHvBXiEgWF7IJGPztXkDtJ0Pzls/jCyr66mNedDmrnEqoi0CMChD79uVH1MXvUPc7Aw
 Kr0ME8WWR9H1dvTjJfGl8dfGwh4LjPpfI9EPhOH410Qpz8cKnJ3ck/KoqPWLp7Hok4sK
 Gn6rW0Zc71J2iR86fhu2rJ/5J73tAf/x1mYgbKE9IF4BYAK8lcXnc5TuGs3acg56awSJ Dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vdyxn805r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:10 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404Fdte6039299;
	Thu, 4 Jan 2024 16:10:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdvhudwvg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:09 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 404GA9ga026902;
	Thu, 4 Jan 2024 16:10:09 GMT
Received: from localhost.localdomain (dhcp-10-175-55-141.vpn.oracle.com [10.175.55.141])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vdvhudwne-1;
	Thu, 04 Jan 2024 16:10:09 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 1/5] docs: move admin-guide/sysfs-rules.rst to userspace-api/
Date: Thu,  4 Jan 2024 17:09:42 +0100
Message-Id: <20240104160946.3450743-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: BgxvGfBTOy-6LayscKHEolNaX-clmeK1
X-Proofpoint-ORIG-GUID: BgxvGfBTOy-6LayscKHEolNaX-clmeK1

This file documents how userspace ought to interact with sysfs. It is
clearly intended for applications that access sysfs programmatically,
rather than at users or admins.

Move it to the userspace API guide.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/ABI/stable/sysfs-devices                 |  2 +-
 Documentation/admin-guide/index.rst                    |  9 ---------
 Documentation/userspace-api/index.rst                  | 10 +++++++++-
 .../{admin-guide => userspace-api}/sysfs-rules.rst     |  0
 tools/lib/api/fs/fs.c                                  |  2 +-
 5 files changed, 11 insertions(+), 12 deletions(-)
 rename Documentation/{admin-guide => userspace-api}/sysfs-rules.rst (100%)

diff --git a/Documentation/ABI/stable/sysfs-devices b/Documentation/ABI/stable/sysfs-devices
index 98a8ef99ac5f..7829414cba62 100644
--- a/Documentation/ABI/stable/sysfs-devices
+++ b/Documentation/ABI/stable/sysfs-devices
@@ -1,6 +1,6 @@
 Note:
   This documents additional properties of any device beyond what
-  is documented in Documentation/admin-guide/sysfs-rules.rst
+  is documented in Documentation/userspace-api/sysfs-rules.rst
 
 What:		/sys/devices/*/of_node
 Date:		February 2015
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 43ea35613dfc..c2b032314a24 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -47,15 +47,6 @@ problems and bugs in particular.
    perf/index
    pstore-blk
 
-This is the beginning of a section with information of interest to
-application developers.  Documents covering various aspects of the kernel
-ABI will be found here.
-
-.. toctree::
-   :maxdepth: 1
-
-   sysfs-rules
-
 This is the beginning of a section with information of interest to
 application developers and system integrators doing analysis of the
 Linux kernel for safety critical applications. Documents supporting
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 74bc0716432e..6ce2edf519f6 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -9,8 +9,16 @@ While much of the kernel's user-space API is documented elsewhere
 also be found in the kernel tree itself.  This manual is intended to be the
 place where this information is gathered.
 
+General documentation:
+
+.. toctree::
+   :maxdepth: 1
+
+   sysfs-rules
+
+Subsystem-specific documentation:
+
 .. toctree::
-   :caption: Table of contents
    :maxdepth: 2
 
    no_new_privs
diff --git a/Documentation/admin-guide/sysfs-rules.rst b/Documentation/userspace-api/sysfs-rules.rst
similarity index 100%
rename from Documentation/admin-guide/sysfs-rules.rst
rename to Documentation/userspace-api/sysfs-rules.rst
diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 5cb0eeec2c8a..c35247b6ad81 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -214,7 +214,7 @@ static void mem_toupper(char *f, size_t len)
 
 /*
  * Check for "NAME_PATH" environment variable to override fs location (for
- * testing). This matches the recommendation in Documentation/admin-guide/sysfs-rules.rst
+ * testing). This matches the recommendation in Documentation/userspace-api/sysfs-rules.rst
  * for SYSFS_PATH.
  */
 static bool fs__env_override(struct fs *fs)
-- 
2.34.1


