Return-Path: <linux-api+bounces-453-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D358245E4
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D8D28719B
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 16:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE624B28;
	Thu,  4 Jan 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TMYAfL00"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE8524A15;
	Thu,  4 Jan 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404G9sF0005983;
	Thu, 4 Jan 2024 16:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=VQpVwSCHnbvnKWNWxBCl5S2+u16kTVoU3W/ugfmMFQ4=;
 b=TMYAfL00aGbl19bHedx4DHtQOSzB00nNhdBJPuMeAhQAPa8nO9QySQvQaFKpYkuI6ltm
 5Rb/LoBn+kH3jgXmAnq2enzrDLAwqkwIXSOIOH1eFYtyWtpGVYH3nQnql5OtbNtUwogZ
 UZDD4chRDjM75kw24znuA6M5VGJ6flN6QAMV/iFIz2lHeY8FJo1LwJDNCbOhaG81j666
 iSo9gsAUNq4LyQ6Ed0YFIoGv17CkXO/94sRpY6qbbwRBnplXEaSMJqedAWmSvpIuw8Mf
 T7xNo2kpp3+u3S/1rdnBS1Fwo5PEegX6/Yui/itdiy5vu0Apd7C7zN1PcLZbzA3cNjEx Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vdyxn806a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404FfF0F039284;
	Thu, 4 Jan 2024 16:10:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdvhudx1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:12 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 404GA9gc026902;
	Thu, 4 Jan 2024 16:10:11 GMT
Received: from localhost.localdomain (dhcp-10-175-55-141.vpn.oracle.com [10.175.55.141])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vdvhudwne-2;
	Thu, 04 Jan 2024 16:10:11 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 2/5] docs: move admin-guide/abi*.rst to userspace-api/
Date: Thu,  4 Jan 2024 17:09:43 +0100
Message-Id: <20240104160946.3450743-2-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: drdPzf2qPsvo7YO5phvwld3WSdA9HaoL
X-Proofpoint-ORIG-GUID: drdPzf2qPsvo7YO5phvwld3WSdA9HaoL

These files describe the kernel <-> userspace ABI and belongs with the
userspace API guide.

The new text was adapted from Documentation/ABI/README.

Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/admin-guide/index.rst                       | 1 -
 .../{admin-guide => userspace-api}/abi-obsolete.rst       | 0
 .../{admin-guide => userspace-api}/abi-removed.rst        | 0
 .../{admin-guide => userspace-api}/abi-stable.rst         | 0
 .../{admin-guide => userspace-api}/abi-testing.rst        | 0
 Documentation/{admin-guide => userspace-api}/abi.rst      | 0
 Documentation/userspace-api/index.rst                     | 8 ++++++++
 7 files changed, 8 insertions(+), 1 deletion(-)
 rename Documentation/{admin-guide => userspace-api}/abi-obsolete.rst (100%)
 rename Documentation/{admin-guide => userspace-api}/abi-removed.rst (100%)
 rename Documentation/{admin-guide => userspace-api}/abi-stable.rst (100%)
 rename Documentation/{admin-guide => userspace-api}/abi-testing.rst (100%)
 rename Documentation/{admin-guide => userspace-api}/abi.rst (100%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index c2b032314a24..fb055d926f6a 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -18,7 +18,6 @@ etc.
    devices
    sysctl/index
 
-   abi
    features
 
 This section describes CPU vulnerabilities and their mitigations.
diff --git a/Documentation/admin-guide/abi-obsolete.rst b/Documentation/userspace-api/abi-obsolete.rst
similarity index 100%
rename from Documentation/admin-guide/abi-obsolete.rst
rename to Documentation/userspace-api/abi-obsolete.rst
diff --git a/Documentation/admin-guide/abi-removed.rst b/Documentation/userspace-api/abi-removed.rst
similarity index 100%
rename from Documentation/admin-guide/abi-removed.rst
rename to Documentation/userspace-api/abi-removed.rst
diff --git a/Documentation/admin-guide/abi-stable.rst b/Documentation/userspace-api/abi-stable.rst
similarity index 100%
rename from Documentation/admin-guide/abi-stable.rst
rename to Documentation/userspace-api/abi-stable.rst
diff --git a/Documentation/admin-guide/abi-testing.rst b/Documentation/userspace-api/abi-testing.rst
similarity index 100%
rename from Documentation/admin-guide/abi-testing.rst
rename to Documentation/userspace-api/abi-testing.rst
diff --git a/Documentation/admin-guide/abi.rst b/Documentation/userspace-api/abi.rst
similarity index 100%
rename from Documentation/admin-guide/abi.rst
rename to Documentation/userspace-api/abi.rst
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 6ce2edf519f6..275f70f3bcbe 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -42,6 +42,14 @@ Subsystem-specific documentation:
    isapnp
    dcdbas
 
+Kernel ABIs: These documents describe the the ABI between the Linux
+kernel and userspace, and the relative stability of these interfaces.
+
+.. toctree::
+   :maxdepth: 2
+
+   abi
+
 .. only::  subproject and html
 
    Indices
-- 
2.34.1


