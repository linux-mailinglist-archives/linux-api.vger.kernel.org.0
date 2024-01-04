Return-Path: <linux-api+bounces-452-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4F8245E1
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 17:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543731F23C2E
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709EC24A01;
	Thu,  4 Jan 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kUnb+XPS"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3ED24A1C;
	Thu,  4 Jan 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404G9JJ2005368;
	Thu, 4 Jan 2024 16:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2023-11-20;
 bh=RtCw0IPDn5unjpahDjI/tOu/RauPDHIT25wTpvo4rZc=;
 b=kUnb+XPSjB8EOyPYkAdUHOmRketJcO6Mghk8bCJnnPGpAAjHvdMZnJLJ2CIlFhnJIfcD
 Go3kbip3AXfL5W5C8Sa5EdLldkarDbFGtIJmqRm2rWYAYNqC9d3D8TLZYmBtA0YhJiUk
 OY4F2EQsmTt94CAATQc2YOhg8DpSqQIZU+vCcJH6xXEjcSHeX7pLD5K5sPKUAeDRaCB+
 YPigNC3RpkzRe/lFU69/BQ/5pFP93rANGVE7atDTWCsKRpj1KtqZPcBxZOT7/FHMAN9K
 sKmmJb2rcETQTHg9tFL5JS++XIcZVq1f5Y1A5HGVWpWelKJRRMNGx0QRCS3HGWYFoF/B hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vdyxn807b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404FfcSx039405;
	Thu, 4 Jan 2024 16:10:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdvhudxbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:16 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 404GA9gg026902;
	Thu, 4 Jan 2024 16:10:16 GMT
Received: from localhost.localdomain (dhcp-10-175-55-141.vpn.oracle.com [10.175.55.141])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vdvhudwne-4;
	Thu, 04 Jan 2024 16:10:15 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 4/5] Documentation/ABI/README: convert to ReST
Date: Thu,  4 Jan 2024 17:09:45 +0100
Message-Id: <20240104160946.3450743-4-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104160946.3450743-1-vegard.nossum@oracle.com>
References: <20240104160946.3450743-1-vegard.nossum@oracle.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_09,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401040127
X-Proofpoint-GUID: 0-T1EmW-J3qsI6xdEv3TxOu_m6ILHOF8
X-Proofpoint-ORIG-GUID: 0-T1EmW-J3qsI6xdEv3TxOu_m6ILHOF8

This file is basically ReST syntax already -- with just a few tweaks we
can include this in the rendered HTML documentation which currently has
no introduction or explanation.

References to this document were found and fixed with some variant of:

  git grep -Pl 'ABI/README(?!\.rst)' | xargs sed -i 's|\(Documentation/ABI/README\)|\1\.rst|g'

plus manual inspection and reflows where necessary.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/ABI/{README => README.rst}      | 36 +++++++++----------
 Documentation/Kconfig                         |  8 ++---
 Documentation/filesystems/sysfs.rst           |  4 +--
 Documentation/process/4.Coding.rst            |  4 +--
 Documentation/process/submit-checklist.rst    |  2 +-
 .../translations/it_IT/process/4.Coding.rst   |  4 +--
 .../it_IT/process/submit-checklist.rst        |  2 +-
 .../translations/ja_JP/SubmitChecklist        |  2 +-
 .../sp_SP/process/submit-checklist.rst        |  2 +-
 .../translations/zh_CN/filesystems/sysfs.txt  |  2 +-
 .../translations/zh_CN/process/4.Coding.rst   |  2 +-
 .../zh_CN/process/submit-checklist.rst        |  2 +-
 .../translations/zh_TW/filesystems/sysfs.txt  |  2 +-
 .../translations/zh_TW/process/4.Coding.rst   |  2 +-
 .../zh_TW/process/submit-checklist.rst        |  2 +-
 15 files changed, 38 insertions(+), 38 deletions(-)
 rename Documentation/ABI/{README => README.rst} (82%)

diff --git a/Documentation/ABI/README b/Documentation/ABI/README.rst
similarity index 82%
rename from Documentation/ABI/README
rename to Documentation/ABI/README.rst
index 8bac9cb09a6d..04f5d05d6caa 100644
--- a/Documentation/ABI/README
+++ b/Documentation/ABI/README.rst
@@ -41,24 +41,24 @@ The different levels of stability are:
 	This directory contains a list of the old interfaces that have
 	been removed from the kernel.
 
-Every file in these directories will contain the following information:
-
-What:		Short description of the interface
-Date:		Date created
-KernelVersion:	Kernel version this feature first showed up in.
-Contact:	Primary contact for this interface (may be a mailing list)
-Description:	Long description of the interface and how to use it.
-Users:		All users of this interface who wish to be notified when
-		it changes.  This is very important for interfaces in
-		the "testing" stage, so that kernel developers can work
-		with userspace developers to ensure that things do not
-		break in ways that are unacceptable.  It is also
-		important to get feedback for these interfaces to make
-		sure they are working in a proper way and do not need to
-		be changed further.
-
-
-Note:
+Every file in these directories will contain the following information::
+
+ What:		Short description of the interface
+ Date:		Date created
+ KernelVersion:	Kernel version this feature first showed up in.
+ Contact:	Primary contact for this interface (may be a mailing list)
+ Description:	Long description of the interface and how to use it.
+ Users:		All users of this interface who wish to be notified when
+ 		it changes.  This is very important for interfaces in
+ 		the "testing" stage, so that kernel developers can work
+ 		with userspace developers to ensure that things do not
+ 		break in ways that are unacceptable.  It is also
+ 		important to get feedback for these interfaces to make
+ 		sure they are working in a proper way and do not need to
+ 		be changed further.
+
+.. note::
+
    The fields should be use a simple notation, compatible with ReST markup.
    Also, the file **should not** have a top-level index, like::
 
diff --git a/Documentation/Kconfig b/Documentation/Kconfig
index 3a0e7ac0c4e3..8e690a4f1a64 100644
--- a/Documentation/Kconfig
+++ b/Documentation/Kconfig
@@ -16,10 +16,10 @@ config WARN_ABI_ERRORS
 	bool "Warn if there are errors at ABI files"
 	help
 	  The files under Documentation/ABI should follow what's
-	  described at Documentation/ABI/README. Yet, as they're manually
-	  written, it would be possible that some of those files would
-	  have errors that would break them for being parsed by
-	  scripts/get_abi.pl. Add a check to verify them.
+	  described at Documentation/ABI/README.rst. Yet, as they're
+	  manually written, it would be possible that some of those
+	  files would have errors that would break them for being parsed
+	  by scripts/get_abi.pl. Add a check to verify them.
 
 	  If unsure, select 'N'.
 
diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index c32993bc83c7..e30694706b15 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -418,5 +418,5 @@ Documentation
 The sysfs directory structure and the attributes in each directory define an
 ABI between the kernel and user space. As for any ABI, it is important that
 this ABI is stable and properly documented. All new sysfs attributes must be
-documented in Documentation/ABI. See also Documentation/ABI/README for more
-information.
+documented in Documentation/ABI. See also Documentation/ABI/README.rst for
+more information.
diff --git a/Documentation/process/4.Coding.rst b/Documentation/process/4.Coding.rst
index 1f0d81f44e14..120d126ee288 100644
--- a/Documentation/process/4.Coding.rst
+++ b/Documentation/process/4.Coding.rst
@@ -347,8 +347,8 @@ information.
 Any code which adds a new user-space interface - including new sysfs or
 /proc files - should include documentation of that interface which enables
 user-space developers to know what they are working with.  See
-Documentation/ABI/README for a description of how this documentation should
-be formatted and what information needs to be provided.
+Documentation/ABI/README.rst for a description of how this documentation
+should be formatted and what information needs to be provided.
 
 The file :ref:`Documentation/admin-guide/kernel-parameters.rst
 <kernelparameters>` describes all of the kernel's boot-time parameters.
diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index b1bc2d37bd0a..7e6198ab368d 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -85,7 +85,7 @@ and elsewhere regarding submitting Linux kernel patches.
 17) All new module parameters are documented with ``MODULE_PARM_DESC()``
 
 18) All new userspace interfaces are documented in ``Documentation/ABI/``.
-    See ``Documentation/ABI/README`` for more information.
+    See ``Documentation/ABI/README.rst`` for more information.
     Patches that change userspace interfaces should be CCed to
     linux-api@vger.kernel.org.
 
diff --git a/Documentation/translations/it_IT/process/4.Coding.rst b/Documentation/translations/it_IT/process/4.Coding.rst
index 54fd255b77d0..631d56ae56dc 100644
--- a/Documentation/translations/it_IT/process/4.Coding.rst
+++ b/Documentation/translations/it_IT/process/4.Coding.rst
@@ -365,8 +365,8 @@ informazione.
 Qualsiasi codice che aggiunge una nuova interfaccia in spazio utente - inclusi
 nuovi file in sysfs o /proc - dovrebbe includere la documentazione di tale
 interfaccia così da permette agli sviluppatori dello spazio utente di sapere
-con cosa stanno lavorando.  Consultate: Documentation/ABI/README per avere una
-descrizione di come questi documenti devono essere impostati e quali
+con cosa stanno lavorando.  Consultate: Documentation/ABI/README.rst per avere
+una descrizione di come questi documenti devono essere impostati e quali
 informazioni devono essere fornite.
 
 Il file :ref:`Documentation/translations/it_IT/admin-guide/kernel-parameters.rst <kernelparameters>`
diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst b/Documentation/translations/it_IT/process/submit-checklist.rst
index 2fc09cc1f0be..828c8f27d492 100644
--- a/Documentation/translations/it_IT/process/submit-checklist.rst
+++ b/Documentation/translations/it_IT/process/submit-checklist.rst
@@ -94,7 +94,7 @@ sottomissione delle patch, in particolare
 18) Tutti i nuovi parametri dei moduli sono documentati con ``MODULE_PARM_DESC()``.
 
 19) Tutte le nuove interfacce verso lo spazio utente sono documentate in
-    ``Documentation/ABI/``.  Leggete ``Documentation/ABI/README`` per maggiori
+    ``Documentation/ABI/``.  Leggete ``Documentation/ABI/README.rst`` per maggiori
     informazioni.  Le patch che modificano le interfacce utente dovrebbero
     essere inviate in copia anche a linux-api@vger.kernel.org.
 
diff --git a/Documentation/translations/ja_JP/SubmitChecklist b/Documentation/translations/ja_JP/SubmitChecklist
index 4429447b0965..87867c47bffd 100644
--- a/Documentation/translations/ja_JP/SubmitChecklist
+++ b/Documentation/translations/ja_JP/SubmitChecklist
@@ -86,7 +86,7 @@ Linux カーネルパッチ投稿者向けチェックリスト
     利用して必ずその説明を記述してください。
 
 18: 新しいuserspaceインタフェースを作成した場合には、Documentation/ABI/ に
-    Documentation/ABI/README を参考にして必ずドキュメントを追加してください。
+    Documentation/ABI/README.rst を参考にして必ずドキュメントを追加してください。
 
 19: 少なくともslabアロケーションとpageアロケーションに失敗した場合の
     挙動について、fault-injectionを利用して確認してください。
diff --git a/Documentation/translations/sp_SP/process/submit-checklist.rst b/Documentation/translations/sp_SP/process/submit-checklist.rst
index 0d6651f9d871..b8072be18532 100644
--- a/Documentation/translations/sp_SP/process/submit-checklist.rst
+++ b/Documentation/translations/sp_SP/process/submit-checklist.rst
@@ -97,7 +97,7 @@ y en otros lugares con respecto al envío de parches del kernel de Linux.
     ``MODULE_PARM_DESC()``.
 
 18) Todas las nuevas interfaces de espacio de usuario están documentadas
-    en ``Documentation/ABI/``. Consulte ``Documentation/ABI/README`` para
+    en ``Documentation/ABI/``. Consulte ``Documentation/ABI/README.rst`` para
     obtener más información. Los parches que cambian las interfaces del
     espacio de usuario deben ser CCed a linux-api@vger.kernel.org.
 
diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Documentation/translations/zh_CN/filesystems/sysfs.txt
index 547062759e60..871fc60aeeca 100644
--- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
@@ -370,4 +370,4 @@ void driver_remove_file(struct device_driver *, const struct driver_attribute *)
 
 sysfs 目录结构以及其中包含的属性定义了一个内核与用户空间之间的 ABI。
 对于任何 ABI，其自身的稳定和适当的文档是非常重要的。所有新的 sysfs
-属性必须在 Documentation/ABI 中有文档。详见 Documentation/ABI/README。
+属性必须在 Documentation/ABI 中有文档。详见 Documentation/ABI/README.rst。
diff --git a/Documentation/translations/zh_CN/process/4.Coding.rst b/Documentation/translations/zh_CN/process/4.Coding.rst
index 7cac9424f5d5..1b752b3bdc8c 100644
--- a/Documentation/translations/zh_CN/process/4.Coding.rst
+++ b/Documentation/translations/zh_CN/process/4.Coding.rst
@@ -244,7 +244,7 @@ scripts/coccinelle目录下已经打包了相当多的内核“语义补丁”
 
 任何添加新用户空间接口的代码——包括新的sysfs或/proc文件——都应该包含该接口
 的文档，该文档使用户空间开发人员能够知道他们在使用什么。请参阅
-Documentation/ABI/README，了解如何此文档格式以及需要提供哪些信息。
+Documentation/ABI/README.rst，了解如何此文档格式以及需要提供哪些信息。
 
 文档 :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
 描述了内核的所有引导时间参数。任何添加新参数的补丁都应该向该文档添加适当的
diff --git a/Documentation/translations/zh_CN/process/submit-checklist.rst b/Documentation/translations/zh_CN/process/submit-checklist.rst
index 3d6ee21c74ae..0942021202a3 100644
--- a/Documentation/translations/zh_CN/process/submit-checklist.rst
+++ b/Documentation/translations/zh_CN/process/submit-checklist.rst
@@ -83,7 +83,7 @@ Linux内核补丁提交检查单
 17) 所有新的模块参数都记录在 ``MODULE_PARM_DESC()``
 
 18) 所有新的用户空间接口都记录在 ``Documentation/ABI/`` 中。有关详细信息，
-    请参阅 ``Documentation/ABI/README`` 。更改用户空间接口的补丁应该抄送
+    请参阅 ``Documentation/ABI/README.rst`` 。更改用户空间接口的补丁应该抄送
     linux-api@vger.kernel.org。
 
 19) 已通过至少注入slab和page分配失败进行检查。请参阅 ``Documentation/fault-injection/`` 。
diff --git a/Documentation/translations/zh_TW/filesystems/sysfs.txt b/Documentation/translations/zh_TW/filesystems/sysfs.txt
index 978462d5fe14..a94e83dcb814 100644
--- a/Documentation/translations/zh_TW/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_TW/filesystems/sysfs.txt
@@ -373,5 +373,5 @@ void driver_remove_file(struct device_driver *, const struct driver_attribute *)
 
 sysfs 目錄結構以及其中包含的屬性定義了一個內核與用戶空間之間的 ABI。
 對於任何 ABI，其自身的穩定和適當的文檔是非常重要的。所有新的 sysfs
-屬性必須在 Documentation/ABI 中有文檔。詳見 Documentation/ABI/README。
+屬性必須在 Documentation/ABI 中有文檔。詳見 Documentation/ABI/README.rst。
 
diff --git a/Documentation/translations/zh_TW/process/4.Coding.rst b/Documentation/translations/zh_TW/process/4.Coding.rst
index bdd2abe4daf4..541e09ae1440 100644
--- a/Documentation/translations/zh_TW/process/4.Coding.rst
+++ b/Documentation/translations/zh_TW/process/4.Coding.rst
@@ -247,7 +247,7 @@ scripts/coccinelle目錄下已經打包了相當多的內核“語義補丁”
 
 任何添加新用戶空間接口的代碼——包括新的sysfs或/proc文件——都應該包含該接口
 的文檔，該文檔使用戶空間開發人員能夠知道他們在使用什麼。請參閱
-Documentation/ABI/README，瞭解如何此文檔格式以及需要提供哪些信息。
+Documentation/ABI/README.rst，瞭解如何此文檔格式以及需要提供哪些信息。
 
 文檔 :ref:`Documentation/admin-guide/kernel-parameters.rst <kernelparameters>`
 描述了內核的所有引導時間參數。任何添加新參數的補丁都應該向該文檔添加適當的
diff --git a/Documentation/translations/zh_TW/process/submit-checklist.rst b/Documentation/translations/zh_TW/process/submit-checklist.rst
index e57ef0f99e0c..efece58cb5b2 100644
--- a/Documentation/translations/zh_TW/process/submit-checklist.rst
+++ b/Documentation/translations/zh_TW/process/submit-checklist.rst
@@ -86,7 +86,7 @@ Linux內核補丁提交檢查單
 17) 所有新的模塊參數都記錄在 ``MODULE_PARM_DESC()``
 
 18) 所有新的用戶空間接口都記錄在 ``Documentation/ABI/`` 中。有關詳細信息，
-    請參閱 ``Documentation/ABI/README`` 。更改用戶空間接口的補丁應該抄送
+    請參閱 ``Documentation/ABI/README.rst`` 。更改用戶空間接口的補丁應該抄送
     linux-api@vger.kernel.org。
 
 19) 已通過至少注入slab和page分配失敗進行檢查。請參閱 ``Documentation/fault-injection/`` 。
-- 
2.34.1


