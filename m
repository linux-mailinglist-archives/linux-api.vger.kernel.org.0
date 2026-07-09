Return-Path: <linux-api+bounces-6815-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JhSjIWAFUGr0rwIAu9opvQ
	(envelope-from <linux-api+bounces-6815-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:32:32 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9C8735618
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:32:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=4mjS6Cpd;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6815-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6815-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CFAA30461DA
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03B436BCFB;
	Thu,  9 Jul 2026 20:31:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023107.outbound.protection.outlook.com [40.93.201.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB433CD8BB;
	Thu,  9 Jul 2026 20:31:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629097; cv=fail; b=T3tb5/yT8GvpmVZKQl42O9Wo841Pel/CZQm8c4DQ1fhpypWpAKThPU9R8AuzmPFTK1XwafM//hsMUL9Cxht+HpjL07/IiRbr/Fe+l90ubE+VFuJun30+xRz2fDTypb5Fss9f6sTbPtXPsxY3c0iIz4lFlzW9VvnA/wUnAtreLZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629097; c=relaxed/simple;
	bh=RJLsf0iRJh8lbm4M4eZXRt/TXDwaYn6QSUAS7SQziyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYUzaMZJDDxlAgPi+wQSCoSOKtnGSzX4NQNpQu7O1nB6K/reSJ2BX+FdHiyBycDrLCt5jGs0IIgZYcnD3bcJJXUF9HCDTQLAtebHa3paNqOFz3Hwe5CLPBbKW+iuVwD+DNCcgK8z1ZAAAO1HfLIoltoGyTVLNsMYVhbx/93og5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=4mjS6Cpd; arc=fail smtp.client-ip=40.93.201.107
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC1E7kgQRBLqDtWm5CzQBh6AJUsGtseWmfDgpxkPgUe/WJgvZdQP0c79EOZzjBxRY+ezSSJW9li53ItrvUDuACHVOHfiQ0nyhp8iBRGrJjZxysTWK8Fzg6KSSE+9tDc9HRuBg7ue5+sFHmul3XHQlQVNskqlEdFmI/xJBwYf+aS8/A0aI+P9RyFVbIaxj1+WUjRYvrY3nx9a5W/n5SCoVnx7y4jsQVcCqbc/zHkGWOWP3oxto6iqPV5WTHsCz0Xz/dOgjx3oYpetn7Mjlfzo7v5Z4RfLDRpN07IzeK+DISyONU2c0xfwQoP6Tr/WBH7JRUR/7F2q6nFLanxlw6HFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGSWDP9gFWOe7g/b4E80ERO6mVfSzF2yKFJjSYOEKAE=;
 b=Z1ri+/azp4HpgbJYPbQZNHYyLim2zS9zG0R+07RW3c2+g7L1zikDH5u+CuQ3FLZeLMCm1naAlQZlxLfxpgJbGVavvuNKFYKGG4O2b3n7+9UNz9n4XkubhG1ylb0Ykp45P4Ysm/9jJR4CSqo5rtfzBxJ719ZSURgengh/fneFsxdrkCpNL3ePuKMLBc5gT70z/xL7l2rsbJlj8/4250BTCOKKgT68T5HawZgK+xgaH2ecGMRRsXrNVHZP7LoaA+YqoJUe4QIAyV2xCM4n7f8RulcrQK0vUcKmDzGQ2+CM8daAfLZDD4Tj9KVCrOofiqD4enTttpk13wr56eZy8CqAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGSWDP9gFWOe7g/b4E80ERO6mVfSzF2yKFJjSYOEKAE=;
 b=4mjS6CpdIwRSNMvdVXb9lZ1mvECyJ/LPLqtzK8ZTzNE8HizmWckP3Lhzh1M3S+J/H6eL5nw0Udjyv/tpwR+oplSul/dUtxVJ5YUiNDKAABdxNhxV3jdsw2WSGgq9p4EV1UiJm2Ffi5wC5V/GSF/ZITICUqiiMDetKU55DkThTj0Rv8F9qg265DYmqcrxWCrZs6sV8Xn5VxlKJls9VeFF+J9buVXLRpAfdmp84RLhq1eynZZ4zJmssFJ9RlXV35GnMW7RS5YsAQsNUOwuwZQB+YXOTCZrwvsiWzQnCMjy7/aP+7V82fKbHjzLGh3OUzrTM0x/XKJ1WcIhe2BQkb2Aww==
Received: from SJ0PR03CA0165.namprd03.prod.outlook.com (2603:10b6:a03:338::20)
 by PH0PR04MB10016.namprd04.prod.outlook.com (2603:10b6:510:3b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:31:23 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::83) by SJ0PR03CA0165.outlook.office365.com
 (2603:10b6:a03:338::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Thu, 9
 Jul 2026 20:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:23 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 3189B1801766;
	Thu,  9 Jul 2026 20:31:21 +0000 (UTC)
From: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alex Ousherovitch <aousherovitch@rambus.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	devicetree@vger.kernel.org,
	Joel Wittenauer <Joel.Wittenauer@cryptography.com>,
	linux-api@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thi Nguyen <thin@rambus.com>
Subject: [PATCH v2 12/19] crypto: cmh - add RSA akcipher
Date: Thu,  9 Jul 2026 13:30:30 -0700
Message-ID: <20260709203037.1884436-13-skrishnamoorthy@rambus.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
References: <20260709203037.1884436-1-skrishnamoorthy@rambus.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|PH0PR04MB10016:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 44a1d375-6856-4a2a-cb0e-08deddf90ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|3023799007|22082099003|18002099003|6133799003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	kTneR1I8eR3bRFSAnE4xtrn35eY1lFn9gD9grP4RIrC55El/su6XxBaKkxSP83m8uMuF6Lx5o8EHC8zzzPchf5o1C+V7mYH4IFKIy76nn2mGmUW+fG7u9JQMWDYGij75fUiW3xqT5Yp28WHBBxgCb7rANrHEF/YeHPoMDPMMVL4yYKn05w9LMe1pYIHNDVVnEARYj5Tj+K+PJaTQ3EzvxegDfnfrhhKDJ5dAJ4lYOdFYvTHbxePxTtQNRoKA2+cWnATYxZUbpjeiNEHiU1hNNeX6vj1ziNagX8DZtEmr2AnJ82sif1VXJ9XoggmwdagNN+Nr+qhzJwpDHfRHXD9i47zpnzs8M6HEI8ZstQWB3UMU6PtjNGDEw/PSeiyoLsh/WTzzWAoEBMITemftuKrbaOn25sDs+y/pJq9RFv6P5X90zhX6NErIU5Jn6DRMzm0/zyECyc34WcHDF5LRwYWdIGezUPv4C+K9dtlLqfQd4mjGKftvTBzpyyx3Kpoigkxa84NBQBLVJNLjZAPON9Vqy4YVpK5kNXfh/DrUCcTC6qcrefvqcNGWU3pg1XXiCJ75VXZh1vJVz1FWj5AJZZbOLTQWa74388jwaVFwMO0NcSuRqTCA51sn6OFRg+ggxckqo1OX29+kXIDtBUv/irarDI/CQoqCmZOhVS9PDsgQiBY+Z10qhIshVSglDuT94Elq1V6W/ciJGJAWYB/DpLvNcQKhBB6bu0GkYh8tHJPSYfn/UtX/8inZ6x51TcV5I0ZF
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(3023799007)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2FkVI5V4GWFVgdyaOV9vYLUNqI8Bc0fIUJ8yEpvjg06gqjrsahOGlmXtzsAxtHtFPCBjAYkTw8IcUXxrd+QIDuEWVpO6cDetLl525bO26FYqQyZmHhcu9EK4Z99G2kIkkShH7lRTmpGmYsFJairdAkDAg5zZeFWFK6LOjfZnGWrbY7Q4yfen/w8X0GK2gWGyBWNZCXBvFOFRWeuJMzAvM6g3f91qleztwmawFqxVM05rLNTH5dQ+0w6LEIPO1kyte8GJM1XBV/mP359Y1Ev6EhFWRIhRerwW8DfXXswPqUUUyZhrf66QMHtfvNx0pkYocjFTL9tdOcFiF+SYoET0SATpnq6S1R14irIo4vhRNFFSYfYtPQlqK9VRYrilDeAtXJII0y52wlGKllP4Lt8S0PBj+xBwqfgyiXsdqVa3JOb7Fu8WOLT51zMV+4Aa2NFu
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:23.1540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a1d375-6856-4a2a-cb0e-08deddf90ae6
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB10016
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6815-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:skrishnamoorthy@rambus.com,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[rambus.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim,cryptography.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5B9C8735618

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register the RSA akcipher algorithm using the CMH PKE core (core ID
0x0a).  Supports encrypt, decrypt, sign, and verify operations with
2048, 3072, and 4096-bit keys.  512- and 1024-bit keys are also
accepted for legacy/test interoperability.  Includes common PKE
helpers shared by subsequent ECDSA and ECDH patches.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile         |   4 +-
 drivers/crypto/cmh/cmh_main.c       |   9 +
 drivers/crypto/cmh/cmh_pke_common.c | 578 +++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_pke_rsa.c    | 642 ++++++++++++++++++++++++++++
 4 files changed, 1232 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_pke_common.c
 create mode 100644 drivers/crypto/cmh/cmh_pke_rsa.c

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 1c4cb817424c..7afd9852c337 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -29,7 +29,9 @@ cmh-y := \
 	cmh_ccp.o \
 	cmh_ccp_aead.o \
 	cmh_ccp_poly.o \
-	cmh_rng.o
+	cmh_rng.o \
+	cmh_pke_common.o \
+	cmh_pke_rsa.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 40440e2b73b4..07f26b0dd2ef 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -38,6 +38,7 @@
 #include "cmh_aes.h"
 #include "cmh_sm4.h"
 #include "cmh_ccp.h"
+#include "cmh_pke.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -281,6 +282,11 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_ccp_poly_register;
 
+	/* Register PKE RSA akcipher */
+	ret = cmh_pke_rsa_register();
+	if (ret)
+		goto err_pke_rsa_register;
+
 	/* Register key management device (/dev/cmh_mgmt) */
 	ret = cmh_mgmt_register();
 	if (ret)
@@ -293,6 +299,8 @@ static int cmh_probe(struct platform_device *pdev)
 	return 0;
 
 err_mgmt_register:
+	cmh_pke_rsa_unregister();
+err_pke_rsa_register:
 	cmh_ccp_poly_unregister();
 err_ccp_poly_register:
 	cmh_ccp_aead_unregister();
@@ -349,6 +357,7 @@ static void cmh_remove(struct platform_device *pdev)
 	cfg = &dev->config;
 
 	cmh_mgmt_unregister();
+	cmh_pke_rsa_unregister();
 	cmh_ccp_poly_unregister();
 	cmh_ccp_aead_unregister();
 	cmh_ccp_unregister();
diff --git a/drivers/crypto/cmh/cmh_pke_common.c b/drivers/crypto/cmh/cmh_pke_common.c
new file mode 100644
index 000000000000..ab3e2eb7d3f8
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pke_common.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- PKE Common VCQ Builders
+ *
+ * VCQ builder functions for all PKE core commands.  Each builder
+ * populates a single vcq_cmd slot with the appropriate magic,
+ * command ID, byte-swap flags, and command-specific payload.
+ *
+ * RSA commands always use PKE_SWAP_FLAGS (VCQ_FLAG_SWAP_BYTES |
+ * VCQ_FLAG_SWAP_WORDS).  EC Weierstrass curves (NIST P-*, Brainpool,
+ * secp256k1, SM2) use PKE_SWAP_FLAGS; Edwards curves (25519, 448)
+ * use no swap flags.  SM2 commands use per-command flags documented
+ * in the eSW ABI.
+ *
+ * Callers combine these with vcq_set_header() + vcq_add_flush()
+ * and submit via cmh_tm_submit_sync().
+ */
+
+#include <linux/string.h>
+
+#include "cmh_pke.h"
+
+/**
+ * vcq_add_pke_flush() - Add a PKE flush command to a VCQ slot
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ *
+ * Populates @slot with a flush command for the specified PKE core.
+ */
+void vcq_add_pke_flush(struct vcq_cmd *slot, u32 core_id)
+{
+	vcq_add_flush(slot, core_id);
+}
+
+/* RSA */
+
+/**
+ * vcq_add_pke_rsa_enc() - Build a VCQ command for RSA public-key encryption
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @bits: RSA key size in bits
+ * @e_len: Length of the public exponent in bytes
+ * @e_dma: DMA address of public exponent buffer
+ * @n_dma: DMA address of modulus buffer
+ * @m_dma: DMA address of plaintext message buffer
+ * @c_dma: DMA address of ciphertext output buffer
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_rsa_enc(struct vcq_cmd *slot, u32 core_id, u32 bits, u32 e_len,
+			 u64 e_dma, u64 n_dma, u64 m_dma, u64 c_dma,
+			 u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_RSA_ENC);
+	slot->hwc.pke.cmd_rsa_enc.bits = bits;
+	slot->hwc.pke.cmd_rsa_enc.e_len = e_len;
+	slot->hwc.pke.cmd_rsa_enc.e = e_dma;
+	slot->hwc.pke.cmd_rsa_enc.n = n_dma;
+	slot->hwc.pke.cmd_rsa_enc.m = m_dma;
+	slot->hwc.pke.cmd_rsa_enc.c = c_dma;
+}
+
+/**
+ * vcq_add_pke_rsa_dec() - Build a VCQ command for RSA private-key decryption
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @bits: RSA key size in bits
+ * @e_len: Length of the public exponent in bytes
+ * @e_dma: DMA address of public exponent buffer
+ * @n_dma: DMA address of modulus buffer
+ * @c_dma: DMA address of ciphertext input buffer
+ * @m_dma: DMA address of plaintext output buffer
+ * @d_ref: Datastore reference for the private exponent
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_rsa_dec(struct vcq_cmd *slot, u32 core_id, u32 bits, u32 e_len,
+			 u64 e_dma, u64 n_dma, u64 c_dma, u64 m_dma,
+			 u64 d_ref, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_RSA_DEC);
+	slot->hwc.pke.cmd_rsa_dec.bits = bits;
+	slot->hwc.pke.cmd_rsa_dec.e_len = e_len;
+	slot->hwc.pke.cmd_rsa_dec.e = e_dma;
+	slot->hwc.pke.cmd_rsa_dec.n = n_dma;
+	slot->hwc.pke.cmd_rsa_dec.c = c_dma;
+	slot->hwc.pke.cmd_rsa_dec.m = m_dma;
+	slot->hwc.pke.cmd_rsa_dec.d = d_ref;
+}
+
+/**
+ * vcq_add_pke_rsa_crt_dec() - Build a VCQ command for RSA-CRT decryption
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @bits: RSA key size in bits
+ * @e_len: Length of the public exponent in bytes
+ * @e_dma: DMA address of public exponent buffer
+ * @n_dma: DMA address of modulus buffer
+ * @c_dma: DMA address of ciphertext input buffer
+ * @m_dma: DMA address of plaintext output buffer
+ * @crt_ref: Datastore reference for CRT private key components
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_rsa_crt_dec(struct vcq_cmd *slot, u32 core_id, u32 bits, u32 e_len,
+			     u64 e_dma, u64 n_dma, u64 c_dma, u64 m_dma,
+			     u64 crt_ref, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_RSA_CRT_DEC);
+	slot->hwc.pke.cmd_rsa_crt_dec.bits = bits;
+	slot->hwc.pke.cmd_rsa_crt_dec.e_len = e_len;
+	slot->hwc.pke.cmd_rsa_crt_dec.e = e_dma;
+	slot->hwc.pke.cmd_rsa_crt_dec.n = n_dma;
+	slot->hwc.pke.cmd_rsa_crt_dec.c = c_dma;
+	slot->hwc.pke.cmd_rsa_crt_dec.m = m_dma;
+	slot->hwc.pke.cmd_rsa_crt_dec.crt = crt_ref;
+}
+
+/* ECDSA */
+
+/**
+ * vcq_add_pke_ecdsa_verify() - Build a VCQ command for ECDSA signature verification
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @dlen: Digest length in bytes
+ * @pk_dma: DMA address of public key buffer
+ * @dig_dma: DMA address of digest buffer
+ * @sig_dma: DMA address of signature buffer
+ * @rp_dma: DMA address of r-prime verification output buffer
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdsa_verify(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 dlen,
+			      u64 pk_dma, u64 dig_dma, u64 sig_dma,
+			      u64 rp_dma, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_VERIFY);
+	slot->hwc.pke.cmd_ecdsa_verify.curve = curve;
+	slot->hwc.pke.cmd_ecdsa_verify.digest_len = dlen;
+	slot->hwc.pke.cmd_ecdsa_verify.public_key = pk_dma;
+	slot->hwc.pke.cmd_ecdsa_verify.digest = dig_dma;
+	slot->hwc.pke.cmd_ecdsa_verify.signature = sig_dma;
+	slot->hwc.pke.cmd_ecdsa_verify.rprime = rp_dma;
+}
+
+/**
+ * vcq_add_pke_ecdsa_sign() - Build a VCQ command for ECDSA signing
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @sklen: Secret key length in bytes
+ * @dig_dma: DMA address of digest buffer
+ * @sig_dma: DMA address of signature output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @dlen: Digest length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdsa_sign(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sklen,
+			    u64 dig_dma, u64 sig_dma, u64 sk_ref,
+			    u32 dlen, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_SIGN);
+	slot->hwc.pke.cmd_ecdsa_sign.curve = curve;
+	slot->hwc.pke.cmd_ecdsa_sign.secret_key_len = sklen;
+	slot->hwc.pke.cmd_ecdsa_sign.digest = dig_dma;
+	slot->hwc.pke.cmd_ecdsa_sign.signature = sig_dma;
+	slot->hwc.pke.cmd_ecdsa_sign.secret_key = sk_ref;
+	slot->hwc.pke.cmd_ecdsa_sign.digest_len = dlen;
+}
+
+/**
+ * vcq_add_pke_ecdsa_pubgen() - Build a VCQ command for ECDSA public key generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @sklen: Secret key length in bytes
+ * @pk_dma: DMA address of public key output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @flags: VCQ command flags
+ *
+ * Generates the public key from an existing private key stored in the
+ * datastore.
+ */
+void vcq_add_pke_ecdsa_pubgen(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sklen,
+			      u64 pk_dma, u64 sk_ref, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_PUBGEN);
+	slot->hwc.pke.cmd_ecdsa_pubgen.curve = curve;
+	slot->hwc.pke.cmd_ecdsa_pubgen.secret_key_len = sklen;
+	slot->hwc.pke.cmd_ecdsa_pubgen.public_key = pk_dma;
+	slot->hwc.pke.cmd_ecdsa_pubgen.secret_key = sk_ref;
+}
+
+/**
+ * vcq_add_pke_ecdsa_keygen() - Build a VCQ command for ECDSA key pair generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @sklen: Secret key length in bytes
+ * @sk_ref: Datastore reference for the generated secret key
+ * @sk_type: Datastore type for the secret key object
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdsa_keygen(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sklen,
+			      u64 sk_ref, u32 sk_type, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_KEYGEN);
+	slot->hwc.pke.cmd_ecdsa_keygen.curve = curve;
+	slot->hwc.pke.cmd_ecdsa_keygen.secret_key_len = sklen;
+	slot->hwc.pke.cmd_ecdsa_keygen.secret_key = sk_ref;
+	slot->hwc.pke.cmd_ecdsa_keygen.secret_key_type = sk_type;
+}
+
+/* ECDH */
+
+/**
+ * vcq_add_pke_ecdh_keygen() - Build a VCQ command for ECDH key pair generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521, X25519, X448)
+ * @sklen: Secret key length in bytes
+ * @pkx_dma: DMA address of public key X-coordinate output buffer
+ * @sk_ref: Datastore reference for the generated secret key
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdh_keygen(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sklen,
+			     u64 pkx_dma, u64 sk_ref, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDH_KEYGEN);
+	slot->hwc.pke.cmd_ecdh_keygen.curve = curve;
+	slot->hwc.pke.cmd_ecdh_keygen.secret_key_len = sklen;
+	slot->hwc.pke.cmd_ecdh_keygen.public_key_x = pkx_dma;
+	slot->hwc.pke.cmd_ecdh_keygen.secret_key = sk_ref;
+}
+
+/**
+ * vcq_add_pke_ecdh() - Build a VCQ command for ECDH shared secret computation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521, X25519, X448)
+ * @sklen: Secret key length in bytes
+ * @sslen: Shared secret length in bytes
+ * @ss_type: Datastore type for the shared secret object
+ * @peer_dma: DMA address of peer public key buffer
+ * @sk_ref: Datastore reference for the local secret key
+ * @ss_ref: Datastore reference for the computed shared secret
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdh(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sklen,
+		      u32 sslen, u32 ss_type, u64 peer_dma, u64 sk_ref,
+		      u64 ss_ref, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDH);
+	slot->hwc.pke.cmd_ecdh.curve = curve;
+	slot->hwc.pke.cmd_ecdh.secret_key_len = sklen;
+	slot->hwc.pke.cmd_ecdh.shared_secret_len = sslen;
+	slot->hwc.pke.cmd_ecdh.shared_secret_type = ss_type;
+	slot->hwc.pke.cmd_ecdh.peer_key_x = peer_dma;
+	slot->hwc.pke.cmd_ecdh.secret_key = sk_ref;
+	slot->hwc.pke.cmd_ecdh.shared_secret = ss_ref;
+}
+
+/* EdDSA */
+
+/**
+ * vcq_add_pke_eddsa_verify() - Build a VCQ command for EdDSA signature verification
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed25519 or Ed448)
+ * @dlen: Digest (message) length in bytes
+ * @pky_dma: DMA address of public key Y-coordinate buffer
+ * @dig_dma: DMA address of digest buffer
+ * @sig_dma: DMA address of signature buffer
+ * @rp_dma: DMA address of r-prime verification output buffer
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_eddsa_verify(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 dlen,
+			      u64 pky_dma, u64 dig_dma, u64 sig_dma,
+			      u64 rp_dma, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_EDDSA_VERIFY);
+	slot->hwc.pke.cmd_eddsa_verify.curve = curve;
+	slot->hwc.pke.cmd_eddsa_verify.digest_len = dlen;
+	slot->hwc.pke.cmd_eddsa_verify.public_key_y = pky_dma;
+	slot->hwc.pke.cmd_eddsa_verify.digest = dig_dma;
+	slot->hwc.pke.cmd_eddsa_verify.signature = sig_dma;
+	slot->hwc.pke.cmd_eddsa_verify.rprime = rp_dma;
+}
+
+/**
+ * vcq_add_pke_eddsa_sign() - Build a VCQ command for EdDSA signing
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed25519 or Ed448)
+ * @sklen: Secret key length in bytes
+ * @dig_dma: DMA address of digest (message) buffer
+ * @sig_dma: DMA address of signature output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @dlen: Digest (message) length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_eddsa_sign(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sklen,
+			    u64 dig_dma, u64 sig_dma, u64 sk_ref,
+			    u32 dlen, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_EDDSA_SIGN);
+	slot->hwc.pke.cmd_eddsa_sign.curve = curve;
+	slot->hwc.pke.cmd_eddsa_sign.secret_key_len = sklen;
+	slot->hwc.pke.cmd_eddsa_sign.digest = dig_dma;
+	slot->hwc.pke.cmd_eddsa_sign.signature = sig_dma;
+	slot->hwc.pke.cmd_eddsa_sign.secret_key = sk_ref;
+	slot->hwc.pke.cmd_eddsa_sign.digest_len = dlen;
+}
+
+/**
+ * vcq_add_pke_eddsa_pubgen() - Build a VCQ command for EdDSA public key generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed25519 or Ed448)
+ * @sklen: Secret key length in bytes
+ * @pky_dma: DMA address of public key Y-coordinate output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @flags: VCQ command flags
+ *
+ * Generates the public key from an existing private key stored in the
+ * datastore.
+ */
+void vcq_add_pke_eddsa_pubgen(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sklen,
+			      u64 pky_dma, u64 sk_ref, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_EDDSA_PUBGEN);
+	slot->hwc.pke.cmd_eddsa_pubgen.curve = curve;
+	slot->hwc.pke.cmd_eddsa_pubgen.secret_key_len = sklen;
+	slot->hwc.pke.cmd_eddsa_pubgen.public_key_y = pky_dma;
+	slot->hwc.pke.cmd_eddsa_pubgen.secret_key = sk_ref;
+}
+
+/**
+ * vcq_add_pke_eddsa_keygen_sca() - Build a VCQ command for EdDSA SCA key generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed448)
+ * @sk_ref: Datastore reference for the input secret key
+ * @sca_sk_ref: Datastore reference for the SCA-masked output key
+ *
+ * Blinds an Ed448 private key into a side-channel-protected masked
+ * form.  No byte-swap flags are used (CRI reference uses flags=0).
+ */
+void vcq_add_pke_eddsa_keygen_sca(struct vcq_cmd *slot, u32 core_id, u32 curve,
+				  u64 sk_ref, u64 sca_sk_ref)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1,
+			      PKE_CMD_EDDSA_PRIV_KEYGEN_SCA);
+	slot->hwc.pke.cmd_eddsa_keygen_sca.curve = curve;
+	slot->hwc.pke.cmd_eddsa_keygen_sca.secret_key = sk_ref;
+	slot->hwc.pke.cmd_eddsa_keygen_sca.sca_secret_key = sca_sk_ref;
+}
+
+/* SM2 */
+
+/**
+ * vcq_add_pke_sm2_ecdh_keygen() - Build a VCQ command for SM2 ECDH ephemeral key generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @nonce_dma: DMA address of nonce input buffer
+ * @session_key_dma: DMA address of session key output buffer
+ * @nonce_len: Nonce length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_ecdh_keygen(struct vcq_cmd *slot, u32 core_id, u64 nonce_dma,
+				 u64 session_key_dma, u32 nonce_len, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1,
+			      PKE_CMD_SM2_ECDH_KEYGEN);
+	slot->hwc.pke.cmd_sm2_ecdh_keygen.nonce = nonce_dma;
+	slot->hwc.pke.cmd_sm2_ecdh_keygen.session_key = session_key_dma;
+	slot->hwc.pke.cmd_sm2_ecdh_keygen.nonce_len = nonce_len;
+}
+
+/**
+ * vcq_add_pke_sm2_ecdh() - Build a VCQ command for SM2 ECDH shared secret computation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @nonce_len: Nonce length in bytes
+ * @private_key_len: Private key length in bytes
+ * @nonce_dma: DMA address of nonce buffer
+ * @peer_pk_dma: DMA address of peer public key buffer
+ * @peer_sk_dma: DMA address of peer session key buffer
+ * @priv_ref: Datastore reference for the local private key
+ * @sp_ref: Datastore reference for the shared point output
+ * @sp_type: Datastore type for the shared point object
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_ecdh(struct vcq_cmd *slot, u32 core_id, u32 nonce_len,
+			  u32 private_key_len, u64 nonce_dma,
+			  u64 peer_pk_dma, u64 peer_sk_dma,
+			  u64 priv_ref, u64 sp_ref, u32 sp_type, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ECDH);
+	slot->hwc.pke.cmd_sm2_ecdh.nonce_len = nonce_len;
+	slot->hwc.pke.cmd_sm2_ecdh.private_key_len = private_key_len;
+	slot->hwc.pke.cmd_sm2_ecdh.nonce = nonce_dma;
+	slot->hwc.pke.cmd_sm2_ecdh.peer_public_key = peer_pk_dma;
+	slot->hwc.pke.cmd_sm2_ecdh.peer_session_key = peer_sk_dma;
+	slot->hwc.pke.cmd_sm2_ecdh.private_key = priv_ref;
+	slot->hwc.pke.cmd_sm2_ecdh.shared_point = sp_ref;
+	slot->hwc.pke.cmd_sm2_ecdh.shared_point_type = sp_type;
+}
+
+/**
+ * vcq_add_pke_sm2_dec_point() - Build a VCQ command for SM2 decryption point multiplication
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @ct_len: Ciphertext length in bytes
+ * @pk_len: Private key length in bytes
+ * @ct_dma: DMA address of ciphertext input buffer
+ * @dp_dma: DMA address of decryption point output buffer
+ * @priv_ref: Datastore reference for the private key
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_dec_point(struct vcq_cmd *slot, u32 core_id, u32 ct_len,
+			       u32 pk_len, u64 ct_dma, u64 dp_dma,
+			       u64 priv_ref, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_DEC_POINT);
+	slot->hwc.pke.cmd_sm2_dec_point.ciphertext_len = ct_len;
+	slot->hwc.pke.cmd_sm2_dec_point.private_key_len = pk_len;
+	slot->hwc.pke.cmd_sm2_dec_point.ciphertext = ct_dma;
+	slot->hwc.pke.cmd_sm2_dec_point.dec_point = dp_dma;
+	slot->hwc.pke.cmd_sm2_dec_point.private_key = priv_ref;
+}
+
+/**
+ * vcq_add_pke_sm2_enc_point() - Build a VCQ command for SM2 encryption point multiplication
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @nonce_dma: DMA address of nonce buffer
+ * @pk_dma: DMA address of public key buffer
+ * @ct_dma: DMA address of ciphertext header output buffer
+ * @ep_dma: DMA address of encryption point output buffer
+ * @nonce_len: Nonce length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_enc_point(struct vcq_cmd *slot, u32 core_id, u64 nonce_dma,
+			       u64 pk_dma, u64 ct_dma, u64 ep_dma,
+			       u32 nonce_len, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ENC_POINT);
+	slot->hwc.pke.cmd_sm2_enc_point.nonce = nonce_dma;
+	slot->hwc.pke.cmd_sm2_enc_point.public_key = pk_dma;
+	slot->hwc.pke.cmd_sm2_enc_point.ciphertext = ct_dma;
+	slot->hwc.pke.cmd_sm2_enc_point.enc_point = ep_dma;
+	slot->hwc.pke.cmd_sm2_enc_point.nonce_len = nonce_len;
+}
+
+/**
+ * vcq_add_pke_sm2_id_digest() - Build a VCQ command for SM2 identity digest computation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @id_dma: DMA address of identity string buffer
+ * @pk_dma: DMA address of public key buffer
+ * @dig_dma: DMA address of digest output buffer
+ * @id_len: Identity string length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_id_digest(struct vcq_cmd *slot, u32 core_id, u64 id_dma,
+			       u64 pk_dma, u64 dig_dma, u32 id_len,
+			       u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ID_DIGEST);
+	slot->hwc.pke.cmd_sm2_id_digest.id = id_dma;
+	slot->hwc.pke.cmd_sm2_id_digest.public_key = pk_dma;
+	slot->hwc.pke.cmd_sm2_id_digest.digest = dig_dma;
+	slot->hwc.pke.cmd_sm2_id_digest.id_len = id_len;
+}
+
+/**
+ * vcq_add_pke_sm2_ecdh_hash() - Build a VCQ command for SM2 ECDH key derivation hash
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @peer_dig_dma: DMA address of peer identity digest buffer
+ * @dig_dma: DMA address of local identity digest buffer
+ * @sp_ref: Datastore reference for the shared point
+ * @sk_ref: Datastore reference for the derived shared key output
+ * @sk_type: Datastore type for the shared key object
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_ecdh_hash(struct vcq_cmd *slot, u32 core_id, u64 peer_dig_dma,
+			       u64 dig_dma, u64 sp_ref, u64 sk_ref,
+			       u32 sk_type, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ECDH_HASH);
+	slot->hwc.pke.cmd_sm2_ecdh_hash.peer_id_digest = peer_dig_dma;
+	slot->hwc.pke.cmd_sm2_ecdh_hash.id_digest = dig_dma;
+	slot->hwc.pke.cmd_sm2_ecdh_hash.shared_point = sp_ref;
+	slot->hwc.pke.cmd_sm2_ecdh_hash.shared_key = sk_ref;
+	slot->hwc.pke.cmd_sm2_ecdh_hash.shared_key_type = sk_type;
+}
+
+/**
+ * vcq_add_pke_sm2_dec_hash() - Build a VCQ command for SM2 decryption hash verification
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @ct_dma: DMA address of ciphertext input buffer
+ * @dp_dma: DMA address of decryption point buffer
+ * @pt_dma: DMA address of plaintext output buffer
+ * @ct_len: Ciphertext length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_dec_hash(struct vcq_cmd *slot, u32 core_id, u64 ct_dma,
+			      u64 dp_dma, u64 pt_dma, u32 ct_len, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_DEC_HASH);
+	slot->hwc.pke.cmd_sm2_dec_hash.ciphertext = ct_dma;
+	slot->hwc.pke.cmd_sm2_dec_hash.dec_point = dp_dma;
+	slot->hwc.pke.cmd_sm2_dec_hash.plaintext = pt_dma;
+	slot->hwc.pke.cmd_sm2_dec_hash.ciphertext_len = ct_len;
+}
+
+/**
+ * vcq_add_pke_sm2_enc_hash() - Build a VCQ command for SM2 encryption hash computation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @msg_dma: DMA address of plaintext message buffer
+ * @ep_dma: DMA address of encryption point buffer
+ * @ct_dma: DMA address of ciphertext output buffer
+ * @msg_len: Message length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_enc_hash(struct vcq_cmd *slot, u32 core_id, u64 msg_dma,
+			      u64 ep_dma, u64 ct_dma, u32 msg_len, u32 flags)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ENC_HASH);
+	slot->hwc.pke.cmd_sm2_enc_hash.message = msg_dma;
+	slot->hwc.pke.cmd_sm2_enc_hash.enc_point = ep_dma;
+	slot->hwc.pke.cmd_sm2_enc_hash.ciphertext = ct_dma;
+	slot->hwc.pke.cmd_sm2_enc_hash.message_len = msg_len;
+}
diff --git a/drivers/crypto/cmh/cmh_pke_rsa.c b/drivers/crypto/cmh/cmh_pke_rsa.c
new file mode 100644
index 000000000000..010f8bd98f0d
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pke_rsa.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- RSA akcipher Driver
+ *
+ * Registers "rsa" akcipher algorithm with the Linux crypto subsystem
+ * (priority 300, overrides software rsa-generic at 100).
+ *
+ * Raw RSA operations only (m^e mod n / c^d mod n).  The kernel's
+ * pkcs1pad() template wraps this for PKCS#1 v1.5 / PSS / OAEP.
+ *
+ * Key format: DER-encoded ASN.1, parsed by kernel rsa_parse_pub_key()
+ * / rsa_parse_priv_key() helpers.
+ *
+ * Private key via cmh_key_ctx: raw keys written via SYS_REF_TEMP.
+ * Datastore-referenced keys are only reachable through the ioctl
+ * path (cmh_mgmt.c).
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <crypto/akcipher.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+
+#include "cmh_pke.h"
+#include "cmh_sys.h"
+#include "cmh_sys_abi.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+struct cmh_rsa_tfm_ctx {
+	struct cmh_key_ctx key;		/* private key (raw d only) */
+	u8 *n;				/* modulus (big-endian) */
+	u8 *e;				/* public exponent (big-endian) */
+	size_t n_sz;
+	size_t e_sz;
+	u32 bits;			/* key size in bits */
+};
+
+static inline struct cmh_rsa_tfm_ctx *cmh_rsa_ctx(struct crypto_akcipher *tfm)
+{
+	return akcipher_tfm_ctx(tfm);
+}
+
+struct cmh_rsa_reqctx {
+	u8 *e_buf;
+	u8 *n_buf;
+	u8 *m_buf;
+	u8 *c_buf;
+	u8 *d_buf;		/* dec only: private key copy */
+	dma_addr_t e_dma;
+	dma_addr_t n_dma;
+	dma_addr_t m_dma;
+	dma_addr_t c_dma;
+	dma_addr_t d_dma;
+	u32 key_bytes;
+	u32 e_padded;
+	u32 n_sz;
+	u32 d_len;		/* dec only */
+};
+
+static u32 cmh_rsa_key_bits(size_t n_sz)
+{
+	/*
+	 * Only accept exact modulus sizes supported by the hardware.
+	 * The programmed RSA width must match the actual modulus buffer
+	 * length; rounding a shorter modulus up to the next size would
+	 * let the device read past the end of the DMA buffer.
+	 */
+	switch (n_sz) {
+	case 64:
+		return 512;
+	case 128:
+		return 1024;
+	case 256:
+		return 2048;
+	case 384:
+		return 3072;
+	case 512:
+		return 4096;
+	default:
+		return 0;
+	}
+}
+
+static void cmh_rsa_enc_complete(void *data, int error)
+{
+	struct akcipher_request *req = data;
+	struct cmh_rsa_reqctx *rctx = akcipher_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (!cmh_dma_map_error(rctx->c_dma))
+		cmh_dma_unmap_single(rctx->c_dma, rctx->key_bytes,
+				     DMA_FROM_DEVICE);
+	if (!cmh_dma_map_error(rctx->m_dma))
+		cmh_dma_unmap_single(rctx->m_dma, rctx->key_bytes,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->n_dma))
+		cmh_dma_unmap_single(rctx->n_dma, rctx->n_sz,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->e_dma))
+		cmh_dma_unmap_single(rctx->e_dma, rctx->e_padded,
+				     DMA_TO_DEVICE);
+
+	if (!error) {
+		int nents;
+
+		nents = sg_nents_for_len(req->dst, rctx->key_bytes);
+		if (nents < 0 ||
+		    sg_copy_from_buffer(req->dst, nents,
+					rctx->c_buf,
+					rctx->key_bytes) != rctx->key_bytes)
+			error = -EINVAL;
+		else
+			req->dst_len = rctx->key_bytes;
+	}
+
+	kfree(rctx->c_buf);
+	rctx->c_buf = NULL;
+	kfree_sensitive(rctx->m_buf);
+	rctx->m_buf = NULL;
+	kfree(rctx->n_buf);
+	rctx->n_buf = NULL;
+	kfree(rctx->e_buf);
+	rctx->e_buf = NULL;
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * RSA encrypt: c = m^e mod n (public key operation)
+ * Also used for signature verification (verify = encrypt for raw RSA).
+ */
+static int cmh_rsa_enc(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct cmh_rsa_tfm_ctx *ctx = cmh_rsa_ctx(tfm);
+	struct cmh_rsa_reqctx *rctx = akcipher_request_ctx(req);
+	u32 key_bytes = ctx->bits / 8;
+	u32 e_padded = ALIGN(ctx->e_sz, 4);
+	struct core_dispatch d = cmh_core_select_instance(CMH_CORE_PKE);
+	struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+	int ret, nents;
+	gfp_t gfp;
+
+	if (!ctx->n || !ctx->e)
+		return -EINVAL;
+	if (req->src_len > key_bytes || req->dst_len < key_bytes)
+		return -EINVAL;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->key_bytes = key_bytes;
+	rctx->e_padded = e_padded;
+	rctx->n_sz = ctx->n_sz;
+	rctx->e_dma = DMA_MAPPING_ERROR;
+	rctx->n_dma = DMA_MAPPING_ERROR;
+	rctx->m_dma = DMA_MAPPING_ERROR;
+	rctx->c_dma = DMA_MAPPING_ERROR;
+
+	rctx->e_buf = kzalloc(e_padded, gfp);
+	rctx->n_buf = kmemdup(ctx->n, ctx->n_sz, gfp);
+	rctx->m_buf = kzalloc(key_bytes, gfp);
+	rctx->c_buf = kzalloc(key_bytes, gfp);
+	if (!rctx->e_buf || !rctx->n_buf || !rctx->m_buf || !rctx->c_buf) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	memcpy(rctx->e_buf + e_padded - ctx->e_sz, ctx->e, ctx->e_sz);
+
+	nents = sg_nents_for_len(req->src, req->src_len);
+	if (nents < 0 ||
+	    sg_pcopy_to_buffer(req->src, nents,
+			       rctx->m_buf + key_bytes - req->src_len,
+			       req->src_len, 0) != req->src_len) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	rctx->e_dma = cmh_dma_map_single(rctx->e_buf, e_padded,
+					 DMA_TO_DEVICE);
+	rctx->n_dma = cmh_dma_map_single(rctx->n_buf, ctx->n_sz,
+					 DMA_TO_DEVICE);
+	rctx->m_dma = cmh_dma_map_single(rctx->m_buf, key_bytes,
+					 DMA_TO_DEVICE);
+	rctx->c_dma = cmh_dma_map_single(rctx->c_buf, key_bytes,
+					 DMA_FROM_DEVICE);
+
+	if (cmh_dma_map_error(rctx->e_dma) ||
+	    cmh_dma_map_error(rctx->n_dma) ||
+	    cmh_dma_map_error(rctx->m_dma) ||
+	    cmh_dma_map_error(rctx->c_dma)) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+	vcq_add_pke_rsa_enc(&vcq[1], d.core_id, ctx->bits, e_padded,
+			    rctx->e_dma, rctx->n_dma, rctx->m_dma,
+			    rctx->c_dma, PKE_SWAP_FLAGS);
+	vcq_add_pke_flush(&vcq[2], d.core_id);
+
+	ret = cmh_tm_submit_async(vcq, PKE_VCQ_CMDS_MIN, 1, d.mbx_idx,
+				  cmh_rsa_enc_complete, req,
+				  !!(req->base.flags &
+				     CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (!ret)
+		return -EINPROGRESS;
+
+out_unmap:
+	if (!cmh_dma_map_error(rctx->c_dma))
+		cmh_dma_unmap_single(rctx->c_dma, key_bytes,
+				     DMA_FROM_DEVICE);
+	if (!cmh_dma_map_error(rctx->m_dma))
+		cmh_dma_unmap_single(rctx->m_dma, key_bytes,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->n_dma))
+		cmh_dma_unmap_single(rctx->n_dma, ctx->n_sz,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->e_dma))
+		cmh_dma_unmap_single(rctx->e_dma, e_padded,
+				     DMA_TO_DEVICE);
+
+out_free:
+	kfree(rctx->c_buf);
+	kfree_sensitive(rctx->m_buf);
+	kfree(rctx->n_buf);
+	kfree(rctx->e_buf);
+	return ret;
+}
+
+static void cmh_rsa_dec_complete(void *data, int error)
+{
+	struct akcipher_request *req = data;
+	struct cmh_rsa_reqctx *rctx = akcipher_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (!cmh_dma_map_error(rctx->d_dma))
+		cmh_dma_unmap_single(rctx->d_dma, rctx->d_len,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->m_dma))
+		cmh_dma_unmap_single(rctx->m_dma, rctx->key_bytes,
+				     DMA_FROM_DEVICE);
+	if (!cmh_dma_map_error(rctx->c_dma))
+		cmh_dma_unmap_single(rctx->c_dma, rctx->key_bytes,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->n_dma))
+		cmh_dma_unmap_single(rctx->n_dma, rctx->n_sz,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->e_dma))
+		cmh_dma_unmap_single(rctx->e_dma, rctx->e_padded,
+				     DMA_TO_DEVICE);
+
+	if (!error) {
+		int nents;
+
+		nents = sg_nents_for_len(req->dst, rctx->key_bytes);
+		if (nents < 0 ||
+		    sg_copy_from_buffer(req->dst, nents,
+					rctx->m_buf,
+					rctx->key_bytes) != rctx->key_bytes)
+			error = -EINVAL;
+		else
+			req->dst_len = rctx->key_bytes;
+	}
+
+	kfree_sensitive(rctx->d_buf);
+	rctx->d_buf = NULL;
+	kfree_sensitive(rctx->m_buf);
+	rctx->m_buf = NULL;
+	kfree(rctx->c_buf);
+	rctx->c_buf = NULL;
+	kfree(rctx->n_buf);
+	rctx->n_buf = NULL;
+	kfree(rctx->e_buf);
+	rctx->e_buf = NULL;
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * RSA decrypt: m = c^d mod n (private key operation)
+ * Also used for signing (sign = decrypt for raw RSA).
+ *
+ * Private key 'd' is written via SYS_REF_TEMP inline.
+ */
+static int cmh_rsa_dec(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct cmh_rsa_tfm_ctx *ctx = cmh_rsa_ctx(tfm);
+	struct cmh_rsa_reqctx *rctx = akcipher_request_ctx(req);
+	u32 key_bytes = ctx->bits / 8;
+	u32 e_padded = ALIGN(ctx->e_sz, 4);
+	struct vcq_cmd vcq[PKE_VCQ_CMDS_MAX];
+	struct core_dispatch dd;
+	int ret, idx, nents;
+	gfp_t gfp;
+
+	if (ctx->key.mode != CMH_KEY_RAW)
+		return -EINVAL;
+	if (!ctx->n || !ctx->e)
+		return -EINVAL;
+	if (req->src_len > key_bytes || req->dst_len < key_bytes)
+		return -EINVAL;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->key_bytes = key_bytes;
+	rctx->e_padded = e_padded;
+	rctx->n_sz = ctx->n_sz;
+	rctx->e_dma = DMA_MAPPING_ERROR;
+	rctx->n_dma = DMA_MAPPING_ERROR;
+	rctx->m_dma = DMA_MAPPING_ERROR;
+	rctx->c_dma = DMA_MAPPING_ERROR;
+	rctx->d_dma = DMA_MAPPING_ERROR;
+
+	rctx->e_buf = kzalloc(e_padded, gfp);
+	rctx->n_buf = kmemdup(ctx->n, ctx->n_sz, gfp);
+	rctx->c_buf = kzalloc(key_bytes, gfp);
+	rctx->m_buf = kzalloc(key_bytes, gfp);
+	if (!rctx->e_buf || !rctx->n_buf || !rctx->c_buf || !rctx->m_buf) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	memcpy(rctx->e_buf + e_padded - ctx->e_sz, ctx->e, ctx->e_sz);
+
+	nents = sg_nents_for_len(req->src, req->src_len);
+	if (nents < 0 ||
+	    sg_pcopy_to_buffer(req->src, nents,
+			       rctx->c_buf + key_bytes - req->src_len,
+			       req->src_len, 0) != req->src_len) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	rctx->e_dma = cmh_dma_map_single(rctx->e_buf, e_padded,
+					 DMA_TO_DEVICE);
+	rctx->n_dma = cmh_dma_map_single(rctx->n_buf, ctx->n_sz,
+					 DMA_TO_DEVICE);
+	rctx->c_dma = cmh_dma_map_single(rctx->c_buf, key_bytes,
+					 DMA_TO_DEVICE);
+	rctx->m_dma = cmh_dma_map_single(rctx->m_buf, key_bytes,
+					 DMA_FROM_DEVICE);
+
+	if (cmh_dma_map_error(rctx->e_dma) ||
+	    cmh_dma_map_error(rctx->n_dma) ||
+	    cmh_dma_map_error(rctx->c_dma) ||
+	    cmh_dma_map_error(rctx->m_dma)) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	dd = cmh_core_select_instance(CMH_CORE_PKE);
+
+	rctx->d_buf = kmemdup(ctx->key.raw.data, ctx->key.raw.len, gfp);
+	if (!rctx->d_buf) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+	rctx->d_len = ctx->key.raw.len;
+
+	rctx->d_dma = cmh_dma_map_single(rctx->d_buf, ctx->key.raw.len,
+					 DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->d_dma)) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	idx = 1;
+	vcq_add_sys_write(&vcq[idx], SYS_REF_TEMP, rctx->d_dma,
+			  SYS_REF_NONE, ctx->key.raw.len,
+			  ctx->key.raw.sys_type);
+	vcq[idx].id |= PKE_SWAP_FLAGS;
+	idx++;
+	vcq_add_pke_rsa_dec(&vcq[idx++], dd.core_id, ctx->bits, e_padded,
+			    rctx->e_dma, rctx->n_dma, rctx->c_dma,
+			    rctx->m_dma, SYS_REF_TEMP, PKE_SWAP_FLAGS);
+	vcq_add_pke_flush(&vcq[idx++], dd.core_id);
+	vcq_set_header(&vcq[0], idx);
+
+	ret = cmh_tm_submit_async(vcq, idx, 1, dd.mbx_idx,
+				  cmh_rsa_dec_complete, req,
+				  !!(req->base.flags &
+				     CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (!ret)
+		return -EINPROGRESS;
+
+out_unmap:
+	if (!cmh_dma_map_error(rctx->d_dma))
+		cmh_dma_unmap_single(rctx->d_dma, rctx->d_len,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->m_dma))
+		cmh_dma_unmap_single(rctx->m_dma, key_bytes,
+				     DMA_FROM_DEVICE);
+	if (!cmh_dma_map_error(rctx->c_dma))
+		cmh_dma_unmap_single(rctx->c_dma, key_bytes,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->n_dma))
+		cmh_dma_unmap_single(rctx->n_dma, ctx->n_sz,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->e_dma))
+		cmh_dma_unmap_single(rctx->e_dma, e_padded,
+				     DMA_TO_DEVICE);
+
+out_free:
+	kfree_sensitive(rctx->d_buf);
+	kfree_sensitive(rctx->m_buf);
+	kfree(rctx->c_buf);
+	kfree(rctx->n_buf);
+	kfree(rctx->e_buf);
+	return ret;
+}
+
+static int cmh_rsa_set_pub_key(struct crypto_akcipher *tfm,
+			       const void *key, unsigned int keylen)
+{
+	struct cmh_rsa_tfm_ctx *ctx = cmh_rsa_ctx(tfm);
+	struct rsa_key rsa = {};
+	int ret;
+
+	ret = rsa_parse_pub_key(&rsa, key, keylen);
+	if (ret)
+		return ret;
+
+	/* Strip ASN.1 leading zero padding from modulus */
+	while (rsa.n_sz > 0 && rsa.n[0] == 0) {
+		rsa.n++;
+		rsa.n_sz--;
+	}
+
+	ctx->bits = cmh_rsa_key_bits(rsa.n_sz);
+	if (!ctx->bits)
+		return -EINVAL;
+
+	kfree(ctx->n);
+	kfree(ctx->e);
+	ctx->n = NULL;
+	ctx->e = NULL;
+	ctx->n_sz = 0;
+	ctx->e_sz = 0;
+
+	ctx->n = kmemdup(rsa.n, rsa.n_sz, GFP_KERNEL);
+	ctx->e = kmemdup(rsa.e, rsa.e_sz, GFP_KERNEL);
+	if (!ctx->n || !ctx->e) {
+		kfree(ctx->n);
+		kfree(ctx->e);
+		ctx->n = NULL;
+		ctx->e = NULL;
+		return -ENOMEM;
+	}
+
+	ctx->n_sz = rsa.n_sz;
+	ctx->e_sz = rsa.e_sz;
+
+	return 0;
+}
+
+static int cmh_rsa_set_priv_key(struct crypto_akcipher *tfm,
+				const void *key, unsigned int keylen)
+{
+	struct cmh_rsa_tfm_ctx *ctx = cmh_rsa_ctx(tfm);
+	struct rsa_key rsa = {};
+	u32 key_bytes;
+	u8 *d_padded;
+	int ret;
+
+	ret = rsa_parse_priv_key(&rsa, key, keylen);
+	if (ret)
+		return ret;
+
+	/* Strip ASN.1 leading zero padding from modulus */
+	while (rsa.n_sz > 0 && rsa.n[0] == 0) {
+		rsa.n++;
+		rsa.n_sz--;
+	}
+
+	ctx->bits = cmh_rsa_key_bits(rsa.n_sz);
+	if (!ctx->bits || !rsa.d_sz)
+		return -EINVAL;
+
+	key_bytes = ctx->bits / 8;
+
+	/* Strip ASN.1 leading zero padding from private exponent */
+	while (rsa.d_sz > 0 && rsa.d[0] == 0) {
+		rsa.d++;
+		rsa.d_sz--;
+	}
+
+	if (!rsa.d_sz || rsa.d_sz > key_bytes)
+		return -EINVAL;
+
+	kfree(ctx->n);
+	kfree(ctx->e);
+	ctx->n = NULL;
+	ctx->e = NULL;
+	ctx->n_sz = 0;
+	ctx->e_sz = 0;
+
+	ctx->n = kmemdup(rsa.n, rsa.n_sz, GFP_KERNEL);
+	ctx->e = kmemdup(rsa.e, rsa.e_sz, GFP_KERNEL);
+	if (!ctx->n || !ctx->e) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ctx->n_sz = rsa.n_sz;
+	ctx->e_sz = rsa.e_sz;
+
+	/*
+	 * Left-pad d to key_bytes (big-endian alignment).
+	 * The CMH eSW resolves SYS_REF_TEMP by checking
+	 * hdr->len >= key_bytes, so the written buffer must
+	 * be at least key_bytes wide.
+	 */
+	d_padded = kzalloc(key_bytes, GFP_KERNEL);
+	if (!d_padded) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	memcpy(d_padded + key_bytes - rsa.d_sz, rsa.d, rsa.d_sz);
+
+	ret = cmh_key_setkey_raw(&ctx->key, d_padded, key_bytes,
+				 CORE_ID_PKE);
+	kfree_sensitive(d_padded);
+	if (ret)
+		goto err;
+
+	return 0;
+err:
+	kfree(ctx->n);
+	kfree(ctx->e);
+	ctx->n = NULL;
+	ctx->e = NULL;
+	ctx->n_sz = 0;
+	ctx->e_sz = 0;
+	ctx->bits = 0;
+	return ret;
+}
+
+static unsigned int cmh_rsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct cmh_rsa_tfm_ctx *ctx = cmh_rsa_ctx(tfm);
+
+	return ctx->n_sz;
+}
+
+static int cmh_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct cmh_rsa_tfm_ctx *ctx = cmh_rsa_ctx(tfm);
+
+	memset(ctx, 0, sizeof(*ctx));
+	tfm->reqsize = sizeof(struct cmh_rsa_reqctx);
+	return 0;
+}
+
+static void cmh_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct cmh_rsa_tfm_ctx *ctx = cmh_rsa_ctx(tfm);
+
+	cmh_key_destroy(&ctx->key);
+	kfree(ctx->n);
+	kfree(ctx->e);
+	ctx->n = NULL;
+	ctx->e = NULL;
+}
+
+/*
+ * Raw RSA stays as akcipher (encrypt/decrypt only).  The kernel's
+ * rsassa-pkcs1 sig template wraps our akcipher for sign/verify,
+ * matching the upstream split (rsa.c = akcipher,
+ * rsassa-pkcs1.c = sig template).
+ */
+static struct akcipher_alg cmh_rsa_alg = {
+	.encrypt	= cmh_rsa_enc,
+	.decrypt	= cmh_rsa_dec,
+	.set_pub_key	= cmh_rsa_set_pub_key,
+	.set_priv_key	= cmh_rsa_set_priv_key,
+	.max_size	= cmh_rsa_max_size,
+	.init		= cmh_rsa_init_tfm,
+	.exit		= cmh_rsa_exit_tfm,
+	.base = {
+		.cra_name	  = "rsa",
+		.cra_driver_name  = "cri-cmh-rsa",
+		.cra_priority	  = 300,
+		.cra_flags	  = CRYPTO_ALG_ASYNC,
+		.cra_module	  = THIS_MODULE,
+		.cra_ctxsize	  = sizeof(struct cmh_rsa_tfm_ctx),
+	},
+};
+
+static bool cmh_rsa_registered;
+
+/**
+ * cmh_pke_rsa_register() - Register RSA akcipher algorithm with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_pke_rsa_register(void)
+{
+	int ret;
+
+	ret = crypto_register_akcipher(&cmh_rsa_alg);
+	if (ret) {
+		dev_err(cmh_dev(),
+			"cmh: failed to register rsa akcipher (%d)\n",
+			ret);
+		return ret;
+	}
+
+	cmh_rsa_registered = true;
+	return 0;
+}
+
+/**
+ * cmh_pke_rsa_unregister() - Unregister RSA akcipher algorithm from the crypto framework
+ */
+void cmh_pke_rsa_unregister(void)
+{
+	if (cmh_rsa_registered)
+		crypto_unregister_akcipher(&cmh_rsa_alg);
+	cmh_rsa_registered = false;
+}
-- 
2.43.7


