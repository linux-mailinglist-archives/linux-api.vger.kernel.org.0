Return-Path: <linux-api+bounces-454-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C590F8245E5
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 17:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5AA287529
	for <lists+linux-api@lfdr.de>; Thu,  4 Jan 2024 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E624B30;
	Thu,  4 Jan 2024 16:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QRa/5G+p"
X-Original-To: linux-api@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE27249FF;
	Thu,  4 Jan 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404G9pkI005867;
	Thu, 4 Jan 2024 16:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=JD/4ONISF7ZrqbhDjWLXo/5VfSZH4KYuiMdc2ieY2c8=;
 b=QRa/5G+p2szhW8IpGtiUrh2LBpjaumC2dURnEz8En15ZpXbPblxB9iwRuqsWUmeQ60Gh
 x0n39O5IgOMTMUSd3neyJg7LlpKNNh3hjbp7Md6Cp4GJDvZgEJpvB3iVhFHYAJguFEPO
 rpe58ne/FI9rrwwNQWqCj0XNCSAlomZSgmCvFAjtskHLbfNAEa2H2M65pAsVGqusjUBH
 X9dh6EO53OcqJtWfqbb5qsu3x0A0owZicxyKDygSXhqdBbeUpe4yodfS0rS8rUyEvTVL
 tMcgpxzYjcVmI7mW+F+/4+MJhxASzUE7qirL18DgzzHI/nv2M2Yr/R1KJ5GL65/Ph8p1 gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vdyxn8081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 404Fj8Y6039285;
	Thu, 4 Jan 2024 16:10:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vdvhudxhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jan 2024 16:10:18 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 404GA9gi026902;
	Thu, 4 Jan 2024 16:10:18 GMT
Received: from localhost.localdomain (dhcp-10-175-55-141.vpn.oracle.com [10.175.55.141])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3vdvhudwne-5;
	Thu, 04 Jan 2024 16:10:18 +0000
From: Vegard Nossum <vegard.nossum@oracle.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH 5/5] docs: userspace-api/api: include ABI/README.rst
Date: Thu,  4 Jan 2024 17:09:46 +0100
Message-Id: <20240104160946.3450743-5-vegard.nossum@oracle.com>
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
X-Proofpoint-GUID: Z14QKnsocPu3jWwLQou1MLhpebvG_7jo
X-Proofpoint-ORIG-GUID: Z14QKnsocPu3jWwLQou1MLhpebvG_7jo

The rendered ABI documents currently have no introduction or
explanation, which is a bit jarring.

Documentation/ABI/README is a pretty good introduction, even if it's
aimed more at ABI-description producers (rather than consumers) -- we
can always tweak the language to be clearer about this distinction
later.

Include it in userspace-api/api.rst.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 Documentation/userspace-api/abi.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/userspace-api/abi.rst b/Documentation/userspace-api/abi.rst
index bcab3ef2597c..ea615233a405 100644
--- a/Documentation/userspace-api/abi.rst
+++ b/Documentation/userspace-api/abi.rst
@@ -2,7 +2,10 @@
 Linux ABI description
 =====================
 
+.. include:: ../ABI/README.rst
+
 .. toctree::
+   :caption: Directory
    :maxdepth: 2
 
    abi-stable
-- 
2.34.1


