Return-Path: <linux-api+bounces-6819-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id anY4K8gFUGoYsAIAu9opvQ
	(envelope-from <linux-api+bounces-6819-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6F7735692
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=xPhEHP3W;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6819-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6819-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C056230730D6
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003E73DCD8F;
	Thu,  9 Jul 2026 20:31:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021084.outbound.protection.outlook.com [40.107.208.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBD63CE0A2;
	Thu,  9 Jul 2026 20:31:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629101; cv=fail; b=SBUf3OzBMZAF/cktWecfiHlrNKWfL5CY38m2mQ1QVToCTauQRk5Q6VKM5SR9w8p2/ZlA2XGuCB/9IvH//DSP89V3NPbNRsxVDzkfDTQuNMCyxYQ9+c7GG6EA/HKPdwIsQLZTPGWXnmehCkLjyKESFQp9cl600YrrtE2mverpJ9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629101; c=relaxed/simple;
	bh=b2dOmFfyT3fRisfFBLm04Fp1ID2T95dHsdhSn7Te/BQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZELuCC7CsHaqo1SMxDy5CLU2+2po8FvcXusCMrGfJSQlSVPlvwttWR6garnFhaKqMevCUuXm9O4h0yDEbuH9E2TJcNGRb+tIovzzQY6VUjNG8lV++DJOoF7p23HNypJSv5vQ/X86MvbAjsiPxbJ7Lh6Dqsx7aUOnaYcjt4FTpuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=xPhEHP3W; arc=fail smtp.client-ip=40.107.208.84
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vl6qneo9xalPtFm8YN8fkH5STtpcO09Dk228YuR3tX4vRNnyvAUdA5r8sR93sZM/n5daaeRY2TZoEiZAQzl2jlYEbHFuJ0f+X3SzJ/Jipwjc5Q7I6MGKG/6XtfjYgqWMBhbk2s261p9/0siXPh+x7jj2OFK1XxavM6opO4PPraNNPhVDoqA9n7zueUeO2iC3oa5tBX7ZZJnUFJJA6GGW/XNJACx31Ga2vHNjim1myZ6ODWaeb88TLCzdnWYiZuLrAEHIVn+2cMObJLh+oiSOhb/jzHp+YFAaUeVXe5V4/nHOY/9/68DFc+zOzDXSKjBjghRnpMwTJ0xbL2NiQZVxmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQ506O3Phx7yFT5cN73S+4Au63gKMMkry+mbZTHEDdc=;
 b=iNDKg8YPUm8v3BTMLrWOv0eliqtE5ljM1wjzGRrOeaRIXmRqGAziS62VBjMlJJ5dUgPCaSzH4d0NYsGCnZsH/2NGCE4e5DzN5/8OaRZnF7uNFvv9+PxTgc4SyuqDySOOw5/LFzaQBzkZmrKSZZM6zny/3FBCwHepuOPww+NasHHA2TFk5onlofAYMM+U7J5SvW+2HSYcTjAZlkY/uDssVV3LsmWR+gjvxKfN7LWdHquUlidiC/ZIzkiDxYATN6UE3P/7cyUbM3lCKh5dZlgthrxSq7iNZu4TUdHThiu2a1TqNQtGeXzHVxrLClPDeX+2oOlHK5HE+mz2AKQmMI8oBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQ506O3Phx7yFT5cN73S+4Au63gKMMkry+mbZTHEDdc=;
 b=xPhEHP3Wwj3XXQgjnTcTmSSBtJh+FBHdXCzhFBZ079Hz0aDVXUClppnOHYhO7xrTrwA7wWGpSSLjDPTgTif59uP8cGwnjN3HWQ2KtZzgh7PtjsLx680zJT0QpkeH/6U7It31/UzMXpUaQ1sk9LJABmBuOam5yCgOmc+LLpOe7x1b57KcxGn6fee1U5WRxDiiKDF3Sfrk4hjt/byG4lmqLJ47tJ2FPw4/AnhngEPn/k3M0BJUcxBiN1MlpruNHeq37uqF89lwaQ/pmnoij2x46ch9sZ0BqPurUjKMUmYBHvEdncbgbZw0TFNtKvuaq4A6lEfmBREXMImBRF4AYHQtIw==
Received: from DS7P220CA0116.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25f::13) by
 LV3PR04MB9466.namprd04.prod.outlook.com (2603:10b6:408:284::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 9 Jul 2026 20:31:23 +0000
Received: from DS2PEPF000061C4.namprd02.prod.outlook.com
 (2603:10b6:8:25f:cafe::64) by DS7P220CA0116.outlook.office365.com
 (2603:10b6:8:25f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend
 Transport; Thu, 9 Jul 2026 20:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 DS2PEPF000061C4.mail.protection.outlook.com (10.167.23.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:22 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id E3F10180175A;
	Thu,  9 Jul 2026 20:31:20 +0000 (UTC)
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
Subject: [PATCH v2 08/19] crypto: cmh - add AES skcipher/aead/cmac
Date: Thu,  9 Jul 2026 13:30:26 -0700
Message-ID: <20260709203037.1884436-9-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C4:EE_|LV3PR04MB9466:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8a4d6834-6303-431e-23f7-08deddf90a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|921020|22082099003|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	cEy9oXr2wa0KKALvbT7ou40WP/NKbmqCjk9ZZXbjlWzWmh//ka2aPmDSJIQ1JId3QLWiC94uhd55Ji+B+QuVFnsqyWFCHZ2LvY7hzeZVknvCJGe7G+GoLaV+CYIH62Z1S/lIfRXyab1KOXHP9LnFciWNlEb2F2btEiSHJuuXW94n/HdiaHpmfyiC0gkGLxyqrj6UirQ+DyERMfEBQ25+ihHl3sFRWaGRBQqQMGTYdqLBzeb+Rkj6N2oOKMwcGxrW2rSNcmQqjG9MCDvdiehsR9BLBIVKW8PWKzCNKd/VMHhEafYIYgkXBtlSJR/JMkAl90h24ssAS1RXyVwPgzKo5LKmKFGJxFNbbXnacsZz/NiBSon5iiZBQUOB6QVRHB0wh9tzJdY5nOGeRYOwxctiUTyiZyif0mWCZ81FSdeVP/Jvphbh2XTaMYLOJ3rMGZxtFBJ+HHOkBn78RuFnWoFgkpl/+fJOCJ5JQla2mmIGN11NMiAnrjiJkWNDLTfnf+pmbdI4MXplanqFjCJB7DxB+6+32EhzQTyJMUF2fOkZ9CX0OOvWFaZwraGs1WjtfZ+CiJjN7/YBTdphthYztGPiykpX/xtylGtDRRAnnQBkp9n3PmFQTyGRMIQcOakkNREmbk59ftfsMRgjIJl/o7BpjG0d5I9L8pMg9ybi+5wSspOU0GkxOLUXjkEBXuT3PcDYSyMWU92hhmARn43UmQesynXJo626PxhVOXQTiW0jsbRpelg5eUkHd8NoJJ2+07gF
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(921020)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pRb5hdPSB4sUagVi5h+WdB+11DXse/gxr+VBJJJflcQim6p8vfXXlfzXJYqGm5OuRh0Cdszf2qtsUTHetrJOGcaEo3w3S11K9EMXeazCIbjlDhQzRXaLW/NLJqe0TswXP0Cshp6WdUmghCn0TiBtSCpALV+PIdNb6iv8wYneKHxws84oxiX0LJFvjhPheioV5XgU1DKTBa/23Nrjzn8J+0YaQECPI2mb0qapzlUZwzEw4+uwNSNmbMfMNoOrH3DSuSR0MnpU5fHBIZOeH34eGFxecCQ7+TspqHeoahUuRpUL13aGaK19zzLo0LLzeRoAuEa99uHxzkaeFtaRvTyEFsWg5Gp03tzblmdDFD6RcY83t0sCGvIoRC923IuXtUoktk6+OcAlfMCo5ITDtDGKzYbR7bFdF2Vsqkoj/ihPRQaEIz+8wPtPEySjaCiIjg9w
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:22.5505
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4d6834-6303-431e-23f7-08deddf90a96
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6819-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim,cryptography.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E6F7735692

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register AES algorithms using the CMH AES core (core ID 0x03):
- skcipher: AES-ECB, AES-CBC, AES-CTR, AES-XTS, AES-CFB
- aead: AES-GCM, AES-CCM
- ahash: AES-CMAC

Supports 128, 192, and 256-bit keys.  AEAD algorithms handle
associated data, payload, and authentication tag with correct
encrypt/decrypt separation.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile          |   5 +-
 drivers/crypto/cmh/cmh_aes.c         | 736 ++++++++++++++++++++
 drivers/crypto/cmh/cmh_aes_aead.c    | 987 +++++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_aes_cmac.c    | 537 +++++++++++++++
 drivers/crypto/cmh/cmh_main.c        |  25 +
 drivers/crypto/cmh/include/cmh_aes.h |  24 +
 6 files changed, 2313 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_aes.c
 create mode 100644 drivers/crypto/cmh/cmh_aes_aead.c
 create mode 100644 drivers/crypto/cmh/cmh_aes_cmac.c
 create mode 100644 drivers/crypto/cmh/include/cmh_aes.h

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index b3018fbcf211..ced8d1748e6c 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -19,7 +19,10 @@ cmh-y := \
 	cmh_hmac.o \
 	cmh_cshake.o \
 	cmh_kmac.o \
-	cmh_sm3.o
+	cmh_sm3.o \
+	cmh_aes.o \
+	cmh_aes_aead.o \
+	cmh_aes_cmac.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_aes.c b/drivers/crypto/cmh/cmh_aes.c
new file mode 100644
index 000000000000..b36295763e33
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_aes.c
@@ -0,0 +1,736 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API AES (skcipher) Driver
+ *
+ * Registers skcipher algorithms with the Linux crypto subsystem:
+ *   ecb(aes), cbc(aes), ctr(aes), cfb(aes), xts(aes)
+ *
+ * Uses the CMH AES Core via VCQ commands:
+ *   [SYS_CMD_WRITE] + AES_CMD_INIT + [AES_CMD_UPDATE] + AES_CMD_FINAL
+ *   + VCQ_CMD_FLUSH
+ *
+ * The AES core requires bidirectional DMA -- both input and output
+ * buffers are mapped and passed in a single AES_CMD_FINAL command.
+ *
+ * Raw-key atomicity: SYS_CMD_WRITE to SYS_REF_TEMP is packed into
+ * the same VCQ as AES commands (see cmh_key.h for details).
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/xts.h>
+#include <crypto/scatterwalk.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+
+#include "cmh_aes.h"
+#include "cmh_vcq.h"
+#include "cmh_aes_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+/* Algorithm Table */
+
+struct cmh_aes_alg_info {
+	u32         aes_mode;	/* AES_MODE_* */
+	u32         ivsize;		/* bytes (0 for ECB) */
+	u32         min_keysize;	/* minimum key bytes */
+	u32         max_keysize;	/* maximum key bytes */
+	const char *alg_name;	/* Linux crypto name: "ecb(aes)" */
+	const char *drv_name;	/* driver name: "cri-cmh-ecb-aes" */
+};
+
+static const struct cmh_aes_alg_info aes_algs[] = {
+	{ AES_MODE_ECB, 0,                AES_KEYSIZE_128, AES_KEYSIZE_256,
+	  "ecb(aes)", "cri-cmh-ecb-aes" },
+	{ AES_MODE_CBC, CMH_AES_IV_SIZE,  AES_KEYSIZE_128, AES_KEYSIZE_256,
+	  "cbc(aes)", "cri-cmh-cbc-aes" },
+	{ AES_MODE_CTR, CMH_AES_IV_SIZE,  AES_KEYSIZE_128, AES_KEYSIZE_256,
+	  "ctr(aes)", "cri-cmh-ctr-aes" },
+	{ AES_MODE_CFB, CMH_AES_IV_SIZE,  AES_KEYSIZE_128, AES_KEYSIZE_256,
+	  "cfb(aes)", "cri-cmh-cfb-aes" },
+	{ AES_MODE_XTS, CMH_AES_IV_SIZE,  2 * AES_KEYSIZE_128, 2 * AES_KEYSIZE_256,
+	  "xts(aes)", "cri-cmh-xts-aes" },
+};
+
+/* Per-transform context (allocated by crypto framework) */
+
+struct cmh_aes_tfm_ctx {
+	struct cmh_key_ctx key;
+};
+
+/* Per-request context (lives in skcipher_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + AES_CMD_INIT + [AES_CMD_UPDATE] + AES_CMD_FINAL
+ *   + VCQ_CMD_FLUSH = 5
+ * UPDATE is used for XTS data > 2 blocks (see cmh_aes_crypt).
+ */
+#define CMH_AES_MAX_PAYLOAD	5
+#define CMH_AES_MAX_PACKED	(CMH_AES_MAX_PAYLOAD * 2)
+
+struct cmh_aes_reqctx {
+	dma_addr_t in_dma;
+	dma_addr_t out_dma;
+	dma_addr_t iv_dma;
+	dma_addr_t iv2_dma;
+	dma_addr_t key_dma;
+	u8 *in_buf;
+	u8 *out_buf;
+	u8 *iv_buf;
+	u8 *iv2_buf;
+	u32 cryptlen;
+	u32 ivsize;
+	u32 keylen;
+	u32 aes_mode;
+	u32 aes_op;
+	/* CTR counter-wrap split state */
+	u32 ctr_chunk1_len;
+	u32 core_id;
+	s32 target_mbx;
+	u64 key_ref;
+	struct vcq_cmd packed[CMH_AES_MAX_PACKED];
+};
+
+/* VCQ Builders -- AES-specific */
+
+static void vcq_add_aes_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref, u64 iv_dma,
+			     u32 keylen, u32 ivlen, u32 mode, u32 op,
+			     u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_INIT);
+	slot->hwc.aes.cmd_init.key = key_ref;
+	slot->hwc.aes.cmd_init.iv = iv_dma;
+	slot->hwc.aes.cmd_init.keylen = keylen;
+	slot->hwc.aes.cmd_init.ivlen = ivlen;
+	slot->hwc.aes.cmd_init.mode = mode;
+	slot->hwc.aes.cmd_init.op = op;
+	slot->hwc.aes.cmd_init.aadlen = 0;
+	slot->hwc.aes.cmd_init.iolen = iolen;
+	slot->hwc.aes.cmd_init.taglen = 0;
+}
+
+static void vcq_add_aes_update(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+			       u64 output_dma, u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_UPDATE);
+	slot->hwc.aes.cmd_update.input = input_dma;
+	slot->hwc.aes.cmd_update.output = output_dma;
+	slot->hwc.aes.cmd_update.iolen = iolen;
+}
+
+static void vcq_add_aes_final(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+			      u64 output_dma, u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_FINAL);
+	slot->hwc.aes.cmd_final.input = input_dma;
+	slot->hwc.aes.cmd_final.output = output_dma;
+	slot->hwc.aes.cmd_final.iolen = iolen;
+	slot->hwc.aes.cmd_final.tag = 0;
+	slot->hwc.aes.cmd_final.taglen = 0;
+}
+
+/*
+ * We wrap each skcipher_alg with its info pointer in a compound struct,
+ * then use container_of() in cmh_aes_get_info() to recover it.
+ * This is the same pattern used by hash, hmac, cshake, kmac.
+ */
+struct cmh_aes_alg_drv {
+	struct skcipher_alg             alg;
+	const struct cmh_aes_alg_info  *info;
+};
+
+static bool aes_is_stream_mode(u32 mode)
+{
+	return mode == AES_MODE_CTR || mode == AES_MODE_CFB;
+}
+
+/*
+ * Update req->iv after a successful encrypt/decrypt.
+ *
+ * The Linux skcipher API contract requires that req->iv is updated to
+ * reflect the state needed to continue processing in a chained call:
+ *   CBC encrypt: IV <- last ciphertext block
+ *   CBC decrypt: IV <- last ciphertext block of the *input*
+ *   CTR:         IV <- counter incremented by ceil(cryptlen / blocksize)
+ *   CFB:         IV <- last ciphertext block
+ */
+static void cmh_aes_update_iv(struct skcipher_request *req, u32 mode,
+			      u32 op, const u8 *in_buf, const u8 *out_buf)
+{
+	u32 bs = CMH_AES_BLOCK_SIZE;
+	u32 nblocks;
+
+	switch (mode) {
+	case AES_MODE_CBC:
+		if (op == AES_OP_ENCRYPT)
+			memcpy(req->iv, out_buf + req->cryptlen - bs, bs);
+		else
+			memcpy(req->iv, in_buf + req->cryptlen - bs, bs);
+		break;
+	case AES_MODE_CTR:
+		/*
+		 * Arithmetic big-endian 128-bit counter increment.
+		 * Process from the least-significant byte (index 15)
+		 * upward, carrying as needed.
+		 */
+		nblocks = DIV_ROUND_UP(req->cryptlen, bs);
+		{
+			u8 *iv = req->iv;
+			int i;
+
+			for (i = bs - 1; i >= 0 && nblocks; i--) {
+				u32 sum = (u32)iv[i] + (nblocks & 0xff);
+
+				iv[i] = (u8)sum;
+				nblocks = (nblocks >> 8) + (sum >> 8);
+			}
+		}
+		break;
+	case AES_MODE_CFB:
+		/*
+		 * CFB-128 chains on the last ciphertext block.  On encrypt,
+		 * that is out_buf; on decrypt, it is in_buf.
+		 *
+		 * For sub-block requests (cryptlen < 16), there is no
+		 * complete ciphertext block to chain, so the IV is left
+		 * unchanged -- CFB-128 has no defined chaining semantic
+		 * for partial blocks (shift-register CFB-n is a different
+		 * mode).  Without this guard the pointer arithmetic
+		 * underflows and reads before the buffer.
+		 */
+		if (req->cryptlen >= bs) {
+			if (op == AES_OP_ENCRYPT)
+				memcpy(req->iv, out_buf + req->cryptlen - bs,
+				       bs);
+			else
+				memcpy(req->iv, in_buf + req->cryptlen - bs,
+				       bs);
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+/* skcipher Operations */
+
+static const struct cmh_aes_alg_info *
+cmh_aes_get_info(struct crypto_skcipher *tfm)
+{
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+
+	return container_of(alg, struct cmh_aes_alg_drv, alg)->info;
+}
+
+static int cmh_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			  unsigned int keylen)
+{
+	struct cmh_aes_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	const struct cmh_aes_alg_info *info = cmh_aes_get_info(tfm);
+
+	if (info->aes_mode == AES_MODE_XTS) {
+		int err;
+
+		/* XTS: double key (32, 48, or 64 bytes) */
+		if (keylen != 2 * AES_KEYSIZE_128 &&
+		    keylen != 2 * AES_KEYSIZE_192 &&
+		    keylen != 2 * AES_KEYSIZE_256)
+			return -EINVAL;
+		err = xts_verify_key(tfm, key, keylen);
+		if (err)
+			return err;
+	} else {
+		/* Standard: 16, 24, or 32 bytes */
+		if (keylen != AES_KEYSIZE_128 &&
+		    keylen != AES_KEYSIZE_192 &&
+		    keylen != AES_KEYSIZE_256)
+			return -EINVAL;
+	}
+
+	return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_AES);
+}
+
+static int cmh_aes_init_tfm(struct crypto_skcipher *tfm)
+{
+	struct cmh_aes_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct cmh_aes_reqctx));
+	return 0;
+}
+
+static void cmh_aes_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct cmh_aes_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+
+	cmh_key_destroy(&tctx->key);
+}
+
+#define CMH_AES_MAX_CRYPTLEN	SZ_32M
+
+/* DMA unmap helper */
+static void cmh_aes_unmap_dma(struct cmh_aes_reqctx *rctx)
+{
+	if (rctx->iv2_buf)
+		cmh_dma_unmap_single(rctx->iv2_dma, rctx->ivsize,
+				     DMA_TO_DEVICE);
+	if (rctx->ivsize > 0)
+		cmh_dma_unmap_single(rctx->iv_dma, rctx->ivsize,
+				     DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->out_dma, rctx->cryptlen, DMA_FROM_DEVICE);
+	cmh_dma_unmap_single(rctx->in_dma, rctx->cryptlen, DMA_TO_DEVICE);
+}
+
+static void cmh_aes_free_bufs(struct cmh_aes_reqctx *rctx)
+{
+	kfree(rctx->iv2_buf);
+	rctx->iv2_buf = NULL;
+	kfree(rctx->iv_buf);
+	rctx->iv_buf = NULL;
+	kfree_sensitive(rctx->out_buf);
+	rctx->out_buf = NULL;
+	kfree_sensitive(rctx->in_buf);
+	rctx->in_buf = NULL;
+}
+
+/*
+ * Submit the second CTR chunk after the first completes.
+ * Called from cmh_aes_complete when ctr_chunk1_len > 0.
+ */
+static void cmh_aes_complete(void *data, int error);
+
+static int cmh_aes_ctr_submit_chunk2(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct cmh_aes_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	struct cmh_aes_reqctx *rctx = skcipher_request_ctx(req);
+	struct vcq_cmd cmds[CMH_AES_MAX_PAYLOAD];
+	u32 chunk1 = rctx->ctr_chunk1_len;
+	u32 chunk2 = rctx->cryptlen - chunk1;
+	u64 key_ref;
+	u32 keylen;
+	u32 idx = 0;
+
+	/* Clear split flag so next completion is final */
+	rctx->ctr_chunk1_len = 0;
+
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+			  (u64)rctx->key_dma, SYS_REF_NONE,
+			  tctx->key.raw.len,
+			  tctx->key.raw.sys_type);
+	key_ref = SYS_REF_TEMP;
+	keylen = tctx->key.raw.len;
+
+	vcq_add_aes_init(&cmds[idx++], rctx->core_id, key_ref,
+			 (u64)rctx->iv2_dma, keylen, rctx->ivsize,
+			 rctx->aes_mode, rctx->aes_op, 0);
+	vcq_add_aes_final(&cmds[idx++], rctx->core_id,
+			  (u64)(rctx->in_dma + chunk1),
+			  (u64)(rctx->out_dma + chunk1), chunk2);
+	vcq_add_flush(&cmds[idx++], rctx->core_id);
+
+	return cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					     CMH_AES_MAX_PACKED,
+					     rctx->target_mbx,
+					     cmh_aes_complete, req,
+					     !!(req->base.flags &
+						CRYPTO_TFM_REQ_MAY_BACKLOG),
+					     cmh_tm_async_timeout_jiffies());
+}
+
+/*
+ * Async completion callback -- fires from RH threaded IRQ context.
+ *
+ * Unmaps DMA buffers, copies output to req->dst scatterlist,
+ * updates the IV state, frees temporaries, and completes the request.
+ *
+ * For CTR counter-wrap splits, the first chunk completion chains
+ * into a second VCQ submission rather than finalizing immediately.
+ */
+static void cmh_aes_complete(void *data, int error)
+{
+	struct skcipher_request *req = data;
+	struct cmh_aes_reqctx *rctx = skcipher_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	/*
+	 * CTR counter-wrap: first chunk completed, submit second.
+	 * DMA mappings remain valid (they cover the full buffer).
+	 *
+	 * Recursion depth bounded: chunk2 clears ctr_chunk1_len before
+	 * submission, so the second cmh_aes_complete invocation sees 0
+	 * and finalizes (max depth = 2).
+	 */
+	if (rctx->ctr_chunk1_len && !error) {
+		int ret;
+
+		ret = cmh_aes_ctr_submit_chunk2(req);
+
+		if (!ret || ret == -EBUSY)
+			return;
+		/* Submission failed; clean up below */
+		error = ret;
+	}
+
+	cmh_aes_unmap_dma(rctx);
+
+	if (!error) {
+		scatterwalk_map_and_copy(rctx->out_buf, req->dst,
+					 0, rctx->cryptlen, 1);
+		cmh_aes_update_iv(req, rctx->aes_mode, rctx->aes_op,
+				  rctx->in_buf, rctx->out_buf);
+	}
+
+	cmh_aes_free_bufs(rctx);
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * Core encrypt/decrypt -- builds a VCQ transaction and submits async.
+ *
+ * Returns -EINPROGRESS on successful submission (completion callback
+ * will fire later).  Returns 0 for trivial cases (zero-length).
+ * Returns negative errno on pre-submission errors.
+ */
+static int cmh_aes_crypt(struct skcipher_request *req, u32 aes_op)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct cmh_aes_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	const struct cmh_aes_alg_info *info = cmh_aes_get_info(tfm);
+	struct cmh_aes_reqctx *rctx = skcipher_request_ctx(req);
+	struct vcq_cmd cmds[CMH_AES_MAX_PAYLOAD];
+	u64 key_ref;
+	u32 keylen;
+	struct core_dispatch d;
+	s32 target_mbx;
+	u32 core_id;
+	u32 idx;
+	int ret;
+	gfp_t gfp;
+
+	if (tctx->key.mode == CMH_KEY_NONE)
+		return -ENOKEY;
+
+	if (!req->cryptlen)
+		return 0;
+
+	if (req->cryptlen > CMH_AES_MAX_CRYPTLEN)
+		return -EINVAL;
+
+	switch (info->aes_mode) {
+	case AES_MODE_CTR:
+	case AES_MODE_CFB:
+		break;
+	case AES_MODE_XTS:
+		if (req->cryptlen < CMH_AES_BLOCK_SIZE)
+			return -EINVAL;
+		break;
+	default:
+		if (req->cryptlen & (CMH_AES_BLOCK_SIZE - 1))
+			return -EINVAL;
+		break;
+	}
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	/* Initialise reqctx */
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->cryptlen = req->cryptlen;
+	rctx->ivsize = info->ivsize;
+	rctx->aes_mode = info->aes_mode;
+	rctx->aes_op = aes_op;
+	rctx->iv2_buf = NULL;
+
+	/* Linearise input from scatterlist */
+	rctx->in_buf = kmalloc(req->cryptlen, gfp);
+	if (!rctx->in_buf)
+		return -ENOMEM;
+
+	scatterwalk_map_and_copy(rctx->in_buf, req->src, 0, req->cryptlen, 0);
+
+	rctx->in_dma = cmh_dma_map_single(rctx->in_buf, req->cryptlen,
+					  DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->in_dma)) {
+		ret = -ENOMEM;
+		goto out_free_in;
+	}
+
+	/* Allocate and map output buffer */
+	rctx->out_buf = kmalloc(req->cryptlen, gfp);
+	if (!rctx->out_buf) {
+		ret = -ENOMEM;
+		goto out_unmap_in;
+	}
+
+	rctx->out_dma = cmh_dma_map_single(rctx->out_buf, req->cryptlen,
+					   DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->out_dma)) {
+		ret = -ENOMEM;
+		goto out_free_out;
+	}
+
+	/* Map IV if required */
+	if (info->ivsize > 0) {
+		rctx->iv_buf = kmemdup(req->iv, info->ivsize, gfp);
+		if (!rctx->iv_buf) {
+			ret = -ENOMEM;
+			goto out_unmap_out;
+		}
+		rctx->iv_dma = cmh_dma_map_single(rctx->iv_buf, info->ivsize,
+						  DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->iv_dma)) {
+			ret = -ENOMEM;
+			goto out_free_iv;
+		}
+	}
+
+	/* Resolve key reference */
+	idx = 0;
+
+	rctx->key_dma = tctx->key.raw.dma;
+	rctx->keylen = tctx->key.raw.len;
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+			  (u64)rctx->key_dma, SYS_REF_NONE,
+			  tctx->key.raw.len,
+			  tctx->key.raw.sys_type);
+	key_ref = SYS_REF_TEMP;
+	keylen = tctx->key.raw.len;
+	d = cmh_core_select_instance(CMH_CORE_AES);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/*
+	 * iolen in INIT: XTS needs total length upfront for tweak
+	 * computation; all other modes use 0 (streaming).
+	 */
+	vcq_add_aes_init(&cmds[idx++], core_id, key_ref, (u64)rctx->iv_dma,
+			 keylen, info->ivsize, info->aes_mode, aes_op,
+			 info->aes_mode == AES_MODE_XTS ?
+			 req->cryptlen : 0);
+
+	if (info->aes_mode == AES_MODE_XTS &&
+	    req->cryptlen > 2 * CMH_AES_BLOCK_SIZE) {
+		u32 final_len, update_len;
+
+		if (req->cryptlen & (CMH_AES_BLOCK_SIZE - 1))
+			final_len = CMH_AES_BLOCK_SIZE +
+				    (req->cryptlen & (CMH_AES_BLOCK_SIZE - 1));
+		else
+			final_len = 2 * CMH_AES_BLOCK_SIZE;
+
+		update_len = req->cryptlen - final_len;
+
+		vcq_add_aes_update(&cmds[idx++], core_id,
+				   (u64)rctx->in_dma,
+				   (u64)rctx->out_dma, update_len);
+		vcq_add_aes_final(&cmds[idx++], core_id,
+				  (u64)(rctx->in_dma + update_len),
+				  (u64)(rctx->out_dma + update_len),
+				  final_len);
+	} else if (info->aes_mode == AES_MODE_CTR) {
+		/*
+		 * CTR counter-wrap workaround:
+		 * The AES-SCA hardware uses a 64-bit block counter.
+		 * If the lower 64 bits of the IV would wrap during
+		 * this operation, split into two separate VCQ
+		 * transactions -- the completion callback for the
+		 * first chunk submits the second.
+		 */
+		u64 lower64 = get_unaligned_be64(rctx->iv_buf + 8);
+		u32 nblocks = DIV_ROUND_UP(req->cryptlen,
+					  CMH_AES_BLOCK_SIZE);
+		u64 bwrap = lower64 ? (~lower64 + 1ULL) : U64_MAX;
+
+		if (nblocks > bwrap) {
+			u32 chunk1 = (u32)bwrap * CMH_AES_BLOCK_SIZE;
+			u64 upper64;
+
+			/* Prepare second IV for chained submission */
+			rctx->iv2_buf = kmalloc(info->ivsize, gfp);
+			if (!rctx->iv2_buf) {
+				ret = -ENOMEM;
+				goto out_unmap_iv;
+			}
+			upper64 = get_unaligned_be64(rctx->iv_buf);
+			put_unaligned_be64(upper64 + 1, rctx->iv2_buf);
+			put_unaligned_be64(0, rctx->iv2_buf + 8);
+
+			rctx->iv2_dma =
+				cmh_dma_map_single(rctx->iv2_buf,
+						   info->ivsize,
+						   DMA_TO_DEVICE);
+			if (cmh_dma_map_error(rctx->iv2_dma)) {
+				ret = -ENOMEM;
+				goto out_free_iv2;
+			}
+
+			/* Store state for the chained second submission */
+			rctx->ctr_chunk1_len = chunk1;
+			rctx->core_id = core_id;
+			rctx->target_mbx = target_mbx;
+			rctx->key_ref = key_ref;
+
+			/* First transaction: only chunk1 */
+			vcq_add_aes_final(&cmds[idx++], core_id,
+					  (u64)rctx->in_dma,
+					  (u64)rctx->out_dma, chunk1);
+		} else {
+			/* No wrap: single FINAL with all data */
+			vcq_add_aes_final(&cmds[idx++], core_id,
+					  (u64)rctx->in_dma,
+					  (u64)rctx->out_dma,
+					  req->cryptlen);
+		}
+	} else {
+		vcq_add_aes_final(&cmds[idx++], core_id,
+				  (u64)rctx->in_dma,
+				  (u64)rctx->out_dma, req->cryptlen);
+	}
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_AES_MAX_PACKED, target_mbx,
+					    cmh_aes_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto out_cleanup_all;
+
+	return -EINPROGRESS;
+
+out_cleanup_all:
+	if (rctx->iv2_buf) {
+		cmh_dma_unmap_single(rctx->iv2_dma, info->ivsize,
+				     DMA_TO_DEVICE);
+	}
+out_free_iv2:
+	kfree(rctx->iv2_buf);
+out_unmap_iv:
+	if (info->ivsize > 0)
+		cmh_dma_unmap_single(rctx->iv_dma, info->ivsize,
+				     DMA_TO_DEVICE);
+out_free_iv:
+	kfree(rctx->iv_buf);
+out_unmap_out:
+	cmh_dma_unmap_single(rctx->out_dma, req->cryptlen, DMA_FROM_DEVICE);
+out_free_out:
+	kfree_sensitive(rctx->out_buf);
+out_unmap_in:
+	cmh_dma_unmap_single(rctx->in_dma, req->cryptlen, DMA_TO_DEVICE);
+out_free_in:
+	kfree_sensitive(rctx->in_buf);
+	return ret;
+}
+
+static int cmh_aes_encrypt(struct skcipher_request *req)
+{
+	return cmh_aes_crypt(req, AES_OP_ENCRYPT);
+}
+
+static int cmh_aes_decrypt(struct skcipher_request *req)
+{
+	return cmh_aes_crypt(req, AES_OP_DECRYPT);
+}
+
+/* Registration */
+
+static struct cmh_aes_alg_drv aes_drv_algs[ARRAY_SIZE(aes_algs)];
+
+/**
+ * cmh_aes_register() - Register AES-CBC/CTR/ECB/XTS skcipher algorithms with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_aes_register(void)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(aes_algs); i++) {
+		const struct cmh_aes_alg_info *info = &aes_algs[i];
+		struct cmh_aes_alg_drv *drv = &aes_drv_algs[i];
+		struct skcipher_alg *alg = &drv->alg;
+
+		drv->info = info;
+
+		memset(alg, 0, sizeof(*alg));
+
+		alg->setkey      = cmh_aes_setkey;
+		alg->encrypt     = cmh_aes_encrypt;
+		alg->decrypt     = cmh_aes_decrypt;
+		alg->init        = cmh_aes_init_tfm;
+		alg->exit        = cmh_aes_exit_tfm;
+		alg->min_keysize = info->min_keysize;
+		alg->max_keysize = info->max_keysize;
+		alg->ivsize      = info->ivsize;
+
+		strscpy(alg->base.cra_name, info->alg_name,
+			CRYPTO_MAX_ALG_NAME);
+		strscpy(alg->base.cra_driver_name, info->drv_name,
+			CRYPTO_MAX_ALG_NAME);
+		alg->base.cra_priority  = 300;
+		alg->base.cra_flags     = CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC;
+		alg->base.cra_blocksize = aes_is_stream_mode(info->aes_mode)
+					  ? 1 : CMH_AES_BLOCK_SIZE;
+		alg->base.cra_ctxsize  = sizeof(struct cmh_aes_tfm_ctx);
+		alg->base.cra_module   = THIS_MODULE;
+
+		ret = crypto_register_skcipher(alg);
+		if (ret) {
+			dev_err(cmh_dev(), "cmh_aes: failed to register %s (rc=%d)\n",
+				info->alg_name, ret);
+			goto err_unregister;
+		}
+
+		dev_dbg(cmh_dev(), "cmh_aes: registered %s\n", info->alg_name);
+	}
+
+	return 0;
+
+err_unregister:
+	while (i--)
+		crypto_unregister_skcipher(&aes_drv_algs[i].alg);
+	return ret;
+}
+
+/**
+ * cmh_aes_unregister() - Unregister AES skcipher algorithms from the crypto framework
+ */
+void cmh_aes_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(aes_algs); i++) {
+		crypto_unregister_skcipher(&aes_drv_algs[i].alg);
+		dev_dbg(cmh_dev(), "cmh_aes: unregistered %s\n", aes_algs[i].alg_name);
+	}
+}
diff --git a/drivers/crypto/cmh/cmh_aes_aead.c b/drivers/crypto/cmh/cmh_aes_aead.c
new file mode 100644
index 000000000000..0b59c5f7d474
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_aes_aead.c
@@ -0,0 +1,987 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API AES AEAD Driver (GCM/CCM)
+ *
+ * Registers AEAD algorithms with the Linux crypto subsystem:
+ *   gcm(aes), ccm(aes)
+ *
+ * GCM: AES_CMD_INIT(mode=GCM) + [AAD_FINAL] + AES_CMD_FINAL + FLUSH
+ *   - Standard 12-byte IV (nonce), 16-byte tag
+ *   - AES_CMD_INIT carries aadlen/iolen/taglen
+ *   - AES_CMD_FINAL carries tag DMA for encrypt (produce) / decrypt (verify)
+ *
+ * CCM: AES_CMD_CCM_INIT + [AAD_FINAL] + AES_CMD_FINAL + FLUSH
+ *   - Variable nonce (7--13 bytes), variable tag (4--16 bytes)
+ *   - Uses AES_CMD_CCM_INIT (0x0A) with aes_cmd_init struct
+ *   - Nonce passed via IV field, taglen in init
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/aead.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/scatterwalk.h>
+#include <crypto/utils.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_aes.h"
+#include "cmh_vcq.h"
+#include "cmh_aes_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+/*
+ * GCM IV contract:
+ *
+ * The AES core requires exactly 16 bytes loaded into its IV register.
+ * For standard 96-bit nonce GCM, the driver passes:
+ *
+ *   IV[0..11]  = user-supplied 12-byte nonce
+ *   IV[12..15] = 0x00000000
+ *
+ * The hardware internally sets the last 32 bits to the big-endian
+ * counter value 1 (forming J0 = nonce || 0x00000001) before
+ * processing AAD.  The driver must NOT pre-set the counter.
+ *
+ * If the IV format is incorrect, GCM authentication will fail
+ * (encrypt produces wrong ciphertext/tag, decrypt rejects).
+ */
+#define AES_GCM_IV_SIZE		12U	/* GCM nonce size (standard) */
+#define AES_GCM_HW_IV_SIZE	16U	/* HW requires 16-byte IV buffer */
+#define AES_GCM_TAG_SIZE	16U
+
+/* CCM: callers pass a 16-byte IV in RFC 3610 format:
+ * iv[0] = L-1, iv[1..14-iv[0]] = nonce, rest = counter (zeroed).
+ * Nonce length = 14 - iv[0], range 7..13.
+ */
+#define AES_CCM_IV_SIZE	16U
+
+enum cmh_aes_aead_type {
+	CMH_AES_AEAD_GCM,
+	CMH_AES_AEAD_CCM,
+};
+
+struct cmh_aes_aead_info {
+	enum cmh_aes_aead_type type;
+	u32         aes_mode;	/* AES_MODE_GCM or AES_MODE_CCM */
+	u32         ivsize;
+	u32         maxauthsize;
+	const char *alg_name;
+	const char *drv_name;
+};
+
+static const struct cmh_aes_aead_info aes_aead_algs[] = {
+	{ CMH_AES_AEAD_GCM, AES_MODE_GCM, AES_GCM_IV_SIZE,
+	  AES_GCM_TAG_SIZE, "gcm(aes)", "cri-cmh-gcm-aes" },
+	{ CMH_AES_AEAD_CCM, AES_MODE_CCM, AES_CCM_IV_SIZE,
+	  AES_GCM_TAG_SIZE, "ccm(aes)", "cri-cmh-ccm-aes" },
+};
+
+struct cmh_aes_aead_tfm_ctx {
+	struct cmh_key_ctx key;
+	u32 authsize;		/* tag length set by setauthsize */
+	struct crypto_cipher *sw_cipher;	/* CCM empty-input fallback */
+	struct crypto_aead *fallback;	/* CCM authsize=10 fallback */
+};
+
+/* Per-request context (lives in aead_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + AES_CMD_INIT + AAD_FINAL + AES_CMD_FINAL + FLUSH = 5
+ */
+#define CMH_AES_AEAD_MAX_PAYLOAD	5
+#define CMH_AES_AEAD_MAX_PACKED		(CMH_AES_AEAD_MAX_PAYLOAD * 2)
+
+struct cmh_aes_aead_reqctx {
+	dma_addr_t in_dma;
+	dma_addr_t out_dma;
+	dma_addr_t iv_dma;
+	dma_addr_t key_dma;
+	dma_addr_t aad_dma;
+	dma_addr_t tag_dma;
+	u8 *in_buf;
+	u8 *out_buf;
+	u8 *iv_buf;
+	u8 *aad_buf;
+	u8 *tag_buf;
+	u32 cryptlen;
+	u32 assoclen;
+	u32 authsize;
+	u32 iv_map_len;
+	u32 keylen;
+	bool encrypting;
+	bool empty_gcm_fallback;
+	struct vcq_cmd packed[CMH_AES_AEAD_MAX_PACKED];
+};
+
+struct cmh_aes_aead_drv {
+	struct aead_alg                  alg;
+	const struct cmh_aes_aead_info  *info;
+};
+
+static const struct cmh_aes_aead_info *
+cmh_aes_aead_get_info(struct crypto_aead *tfm)
+{
+	struct aead_alg *alg = crypto_aead_alg(tfm);
+
+	return container_of(alg, struct cmh_aes_aead_drv, alg)->info;
+}
+
+/* VCQ Builders -- AEAD-specific */
+
+static void vcq_add_aes_aead_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref,
+				  u64 iv_dma, u32 keylen, u32 ivlen,
+				  u32 mode, u32 op, u32 aadlen, u32 iolen,
+				  u32 taglen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_INIT);
+	slot->hwc.aes.cmd_init.key = key_ref;
+	slot->hwc.aes.cmd_init.iv = iv_dma;
+	slot->hwc.aes.cmd_init.keylen = keylen;
+	slot->hwc.aes.cmd_init.ivlen = ivlen;
+	slot->hwc.aes.cmd_init.mode = mode;
+	slot->hwc.aes.cmd_init.op = op;
+	slot->hwc.aes.cmd_init.aadlen = aadlen;
+	slot->hwc.aes.cmd_init.iolen = iolen;
+	slot->hwc.aes.cmd_init.taglen = taglen;
+}
+
+static void vcq_add_aes_ccm_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref,
+				 u64 nonce_dma, u32 keylen, u32 noncelen,
+				 u32 op, u32 aadlen, u32 iolen, u32 taglen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_CCM_INIT);
+	slot->hwc.aes.cmd_init.key = key_ref;
+	slot->hwc.aes.cmd_init.iv = nonce_dma;
+	slot->hwc.aes.cmd_init.keylen = keylen;
+	slot->hwc.aes.cmd_init.ivlen = noncelen;
+	slot->hwc.aes.cmd_init.mode = AES_MODE_CCM;
+	slot->hwc.aes.cmd_init.op = op;
+	slot->hwc.aes.cmd_init.aadlen = aadlen;
+	slot->hwc.aes.cmd_init.iolen = iolen;
+	slot->hwc.aes.cmd_init.taglen = taglen;
+}
+
+static void vcq_add_aes_aad_final(struct vcq_cmd *slot, u32 core_id, u64 aad_dma,
+				  u32 aadlen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_AAD_FINAL);
+	slot->hwc.aes.cmd_aad_final.data = aad_dma;
+	slot->hwc.aes.cmd_aad_final.datalen = aadlen;
+}
+
+static void vcq_add_aes_aead_final(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+				   u64 output_dma, u64 tag_dma,
+				   u32 iolen, u32 taglen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_FINAL);
+	slot->hwc.aes.cmd_final.input = input_dma;
+	slot->hwc.aes.cmd_final.output = output_dma;
+	slot->hwc.aes.cmd_final.tag = tag_dma;
+	slot->hwc.aes.cmd_final.iolen = iolen;
+	slot->hwc.aes.cmd_final.taglen = taglen;
+}
+
+/* setkey */
+static int cmh_aes_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+			       unsigned int keylen)
+{
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	if (keylen != 16 && keylen != 24 && keylen != 32)
+		return -EINVAL;
+
+	/* Keep SW fallback ciphers in sync for CCM edge cases */
+	if (tctx->sw_cipher) {
+		ret = crypto_cipher_setkey(tctx->sw_cipher, key, keylen);
+		if (ret)
+			return ret;
+	}
+	if (tctx->fallback) {
+		ret = crypto_aead_setkey(tctx->fallback, key, keylen);
+		if (ret)
+			return ret;
+	}
+
+	ret = cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_AES);
+
+	return ret;
+}
+
+static int cmh_aes_aead_setauthsize(struct crypto_aead *tfm,
+				    unsigned int authsize)
+{
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	const struct cmh_aes_aead_info *info = cmh_aes_aead_get_info(tfm);
+	int ret;
+
+	if (info->type == CMH_AES_AEAD_GCM) {
+		/* GCM: accept 4, 8, 12, 13, 14, 15, 16 per NIST SP 800-38D */
+		if (authsize < 4 || authsize > 16 ||
+		    (authsize > 4 && authsize < 8) ||
+		    (authsize > 8 && authsize < 12))
+			return -EINVAL;
+	} else {
+		/* CCM: accept all RFC 3610 values {4,6,8,10,12,14,16} */
+		if (authsize < 4 || authsize > 16 || (authsize & 1))
+			return -EINVAL;
+		/* Forward to SW fallback for authsize=10 (HW unsupported) */
+		if (tctx->fallback) {
+			ret = crypto_aead_setauthsize(tctx->fallback,
+						      authsize);
+			if (ret)
+				return ret;
+		}
+	}
+
+	tctx->authsize = authsize;
+	return 0;
+}
+
+static int cmh_aes_aead_init_tfm(struct crypto_aead *tfm)
+{
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	const struct cmh_aes_aead_info *info = cmh_aes_aead_get_info(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	tctx->authsize = info->maxauthsize;
+
+	if (info->type == CMH_AES_AEAD_CCM) {
+		struct crypto_aead *fb;
+		struct crypto_cipher *ci;
+
+		ci = crypto_alloc_cipher("aes", 0, 0);
+		if (IS_ERR(ci))
+			return PTR_ERR(ci);
+		tctx->sw_cipher = ci;
+
+		fb = crypto_alloc_aead("ccm(aes)", 0,
+				       CRYPTO_ALG_NEED_FALLBACK);
+		if (IS_ERR(fb)) {
+			crypto_free_cipher(ci);
+			tctx->sw_cipher = NULL;
+			return PTR_ERR(fb);
+		}
+		tctx->fallback = fb;
+
+		/*
+		 * Subreq lives at (rctx + 1).  Alignment is guaranteed
+		 * by the crypto framework's __ctx ALIGN mechanism.
+		 */
+		crypto_aead_set_reqsize(tfm,
+					sizeof(struct cmh_aes_aead_reqctx) +
+					sizeof(struct aead_request) +
+					crypto_aead_reqsize(fb));
+	} else {
+		crypto_aead_set_reqsize(tfm,
+					sizeof(struct cmh_aes_aead_reqctx));
+	}
+
+	return 0;
+}
+
+static void cmh_aes_aead_exit_tfm(struct crypto_aead *tfm)
+{
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	if (tctx->fallback)
+		crypto_free_aead(tctx->fallback);
+	if (tctx->sw_cipher)
+		crypto_free_cipher(tctx->sw_cipher);
+	cmh_key_destroy(&tctx->key);
+}
+
+/* DMA unmap helper */
+static void cmh_aes_aead_unmap_dma(struct cmh_aes_aead_reqctx *rctx)
+{
+	u32 tag_map_len;
+
+	cmh_dma_unmap_single(rctx->iv_dma, rctx->iv_map_len, DMA_TO_DEVICE);
+	/*
+	 * The empty-GCM fallback maps a full AES block (16 bytes) for the
+	 * ECB output regardless of authsize, so unmap with the mapped size.
+	 */
+	tag_map_len = rctx->empty_gcm_fallback ?
+		      AES_GCM_HW_IV_SIZE : rctx->authsize;
+	cmh_dma_unmap_single(rctx->tag_dma, tag_map_len,
+			     (rctx->encrypting || rctx->empty_gcm_fallback) ?
+			      DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	if (rctx->cryptlen > 0) {
+		cmh_dma_unmap_single(rctx->out_dma, rctx->cryptlen,
+				     DMA_FROM_DEVICE);
+		cmh_dma_unmap_single(rctx->in_dma, rctx->cryptlen,
+				     DMA_TO_DEVICE);
+	}
+	if (rctx->assoclen > 0)
+		cmh_dma_unmap_single(rctx->aad_dma, rctx->assoclen,
+				     DMA_TO_DEVICE);
+}
+
+static void cmh_aes_aead_free_bufs(struct cmh_aes_aead_reqctx *rctx)
+{
+	kfree(rctx->iv_buf);
+	rctx->iv_buf = NULL;
+	kfree(rctx->tag_buf);
+	rctx->tag_buf = NULL;
+	kfree_sensitive(rctx->out_buf);
+	rctx->out_buf = NULL;
+	kfree_sensitive(rctx->in_buf);
+	rctx->in_buf = NULL;
+	kfree(rctx->aad_buf);
+	rctx->aad_buf = NULL;
+}
+
+static void cmh_aes_aead_complete(void *data, int error)
+{
+	struct aead_request *req = data;
+	struct cmh_aes_aead_reqctx *rctx = aead_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	cmh_aes_aead_unmap_dma(rctx);
+
+	/*
+	 * Map HW error on decrypt to -EBADMSG.  The eSW AES core uses a
+	 * single error code (-EIO) for both authentication failures and
+	 * other core errors (e.g. DMA timeout), so we cannot distinguish
+	 * them from the MBX_STATUS alone.  In practice the only error
+	 * during a well-formed AEAD decrypt is auth-tag mismatch; a DMA
+	 * timeout would indicate a fatal HW problem where -EBADMSG vs
+	 * -EIO is moot.  The kernel crypto API requires -EBADMSG for
+	 * AEAD authentication failures.
+	 */
+	if (error == -EIO && !rctx->encrypting)
+		error = -EBADMSG;
+
+	if (!error) {
+		/* GCM empty-input decrypt: compare computed tag with expected */
+		if (rctx->empty_gcm_fallback && !rctx->encrypting) {
+			if (crypto_memneq(rctx->tag_buf, rctx->in_buf,
+					  rctx->authsize))
+				error = -EBADMSG;
+		}
+		if (!error && rctx->cryptlen > 0)
+			scatterwalk_map_and_copy(rctx->out_buf, req->dst,
+						 req->assoclen,
+						rctx->cryptlen, 1);
+		if (!error && rctx->encrypting)
+			scatterwalk_map_and_copy(rctx->tag_buf, req->dst,
+						 req->assoclen +
+						rctx->cryptlen,
+						rctx->authsize, 1);
+	}
+
+	cmh_aes_aead_free_bufs(rctx);
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * GCM empty-input fallback.
+ *
+ * When both AAD and plaintext are empty, GCM reduces to:
+ *   tag = E(K, J0) where J0 = nonce || 0x00000001
+ *
+ * The eSW GCM engine rejects this degenerate case, so we compute it
+ * via a single ECB block encryption of J0.
+ *
+ * VCQ: [SYS_CMD_WRITE] + AES_CMD_INIT(ECB) + AES_CMD_FINAL + FLUSH
+ */
+static int cmh_aes_gcm_empty(struct aead_request *req, u32 aes_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	struct cmh_aes_aead_reqctx *rctx = aead_request_ctx(req);
+	struct vcq_cmd cmds[CMH_AES_AEAD_MAX_PAYLOAD];
+	u64 key_ref;
+	u32 keylen, authsize;
+	struct core_dispatch d;
+	s32 target_mbx;
+	u32 core_id;
+	u32 idx;
+	int ret;
+	gfp_t gfp;
+
+	authsize = tctx->authsize;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->cryptlen = 0;
+	rctx->assoclen = 0;
+	rctx->authsize = authsize;
+	rctx->encrypting = (aes_op == AES_OP_ENCRYPT);
+	rctx->empty_gcm_fallback = true;
+
+	/* Build J0 = nonce || 0x00000001 in iv_buf */
+	rctx->iv_buf = kzalloc(AES_GCM_HW_IV_SIZE, gfp);
+	if (!rctx->iv_buf)
+		return -ENOMEM;
+	memcpy(rctx->iv_buf, req->iv, AES_GCM_IV_SIZE);
+	rctx->iv_buf[15] = 0x01; /* big-endian counter = 1 */
+	rctx->iv_map_len = AES_GCM_HW_IV_SIZE;
+
+	rctx->iv_dma = cmh_dma_map_single(rctx->iv_buf, AES_GCM_HW_IV_SIZE,
+					  DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->iv_dma)) {
+		ret = -ENOMEM;
+		goto out_free_iv;
+	}
+
+	/* Tag buffer -- receives E(K, J0) output */
+	rctx->tag_buf = kzalloc(AES_GCM_HW_IV_SIZE, gfp);
+	if (!rctx->tag_buf) {
+		ret = -ENOMEM;
+		goto out_unmap_iv;
+	}
+	rctx->tag_dma = cmh_dma_map_single(rctx->tag_buf, AES_GCM_HW_IV_SIZE,
+					   DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->tag_dma)) {
+		ret = -ENOMEM;
+		goto out_free_tag;
+	}
+
+	/* For decrypt: read expected tag from request for later comparison */
+	if (!rctx->encrypting) {
+		rctx->in_buf = kmalloc(authsize, gfp);
+		if (!rctx->in_buf) {
+			ret = -ENOMEM;
+			goto out_unmap_tag;
+		}
+		scatterwalk_map_and_copy(rctx->in_buf, req->src, 0,
+					 authsize, 0);
+	}
+
+	/* Resolve key */
+	idx = 0;
+	rctx->key_dma = tctx->key.raw.dma;
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+			  (u64)rctx->key_dma, SYS_REF_NONE,
+			  tctx->key.raw.len,
+			  tctx->key.raw.sys_type);
+	key_ref = SYS_REF_TEMP;
+	keylen = tctx->key.raw.len;
+	d = cmh_core_select_instance(CMH_CORE_AES);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/* ECB INIT: single block encryption of J0 */
+	vcq_add_aes_aead_init(&cmds[idx++], core_id, key_ref,
+			      0, keylen, 0, AES_MODE_ECB, AES_OP_ENCRYPT,
+			      0, AES_GCM_HW_IV_SIZE, 0);
+
+	/* FINAL: J0 in, E(K,J0) out */
+	vcq_add_aes_aead_final(&cmds[idx++], core_id,
+			       (u64)rctx->iv_dma, (u64)rctx->tag_dma,
+			       0, AES_GCM_HW_IV_SIZE, 0);
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_AES_AEAD_MAX_PACKED,
+					    target_mbx,
+					    cmh_aes_aead_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto out_free_in;
+
+	return -EINPROGRESS;
+
+out_free_in:
+	kfree_sensitive(rctx->in_buf);
+out_unmap_tag:
+	cmh_dma_unmap_single(rctx->tag_dma, AES_GCM_HW_IV_SIZE,
+			     DMA_FROM_DEVICE);
+out_free_tag:
+	kfree(rctx->tag_buf);
+out_unmap_iv:
+	cmh_dma_unmap_single(rctx->iv_dma, AES_GCM_HW_IV_SIZE, DMA_TO_DEVICE);
+out_free_iv:
+	kfree(rctx->iv_buf);
+	return ret;
+}
+
+/*
+ * CCM empty-input fallback.
+ *
+ * When both AAD and plaintext are empty, CCM reduces to:
+ *   T  = E(K, B0)    -- CBC-MAC of the single formatting block
+ *   S0 = E(K, A0)    -- CTR block zero
+ *   tag = (T XOR S0)[0..authsize-1]
+ *
+ * The eSW rejects this degenerate case, so the driver computes it
+ * synchronously via two crypto_cipher single-block encryptions.
+ */
+static int cmh_aes_ccm_empty(struct aead_request *req, u32 aes_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	u32 authsize = tctx->authsize;
+	u8 b0[CMH_AES_BLOCK_SIZE], a0[CMH_AES_BLOCK_SIZE];
+	u8 t[CMH_AES_BLOCK_SIZE], s0[CMH_AES_BLOCK_SIZE];
+	u8 tag[CMH_AES_BLOCK_SIZE];
+	u8 L;
+	u32 i;
+
+	/* Defense-in-depth: iv[0] = L-1, valid L is 2..8 per RFC 3610 S2.1 */
+	if (WARN_ON_ONCE(req->iv[0] < 1 || req->iv[0] > 7))
+		return -EINVAL;
+
+	L = req->iv[0] + 1;
+
+	if (tctx->key.mode != CMH_KEY_RAW)
+		return -EOPNOTSUPP;
+
+	/* B0: flags || nonce || Q(=0).  Adata=0, t=authsize, q=L. */
+	memset(b0, 0, CMH_AES_BLOCK_SIZE);
+	b0[0] = (u8)(8 * ((authsize - 2) / 2) + (L - 1));
+	memcpy(&b0[1], &req->iv[1], 15 - L);
+
+	/* A0: (L-1) || nonce || counter(=0) */
+	memset(a0, 0, CMH_AES_BLOCK_SIZE);
+	a0[0] = (u8)(L - 1);
+	memcpy(&a0[1], &req->iv[1], 15 - L);
+
+	crypto_cipher_encrypt_one(tctx->sw_cipher, t, b0);
+	crypto_cipher_encrypt_one(tctx->sw_cipher, s0, a0);
+
+	for (i = 0; i < authsize; i++)
+		tag[i] = t[i] ^ s0[i];
+
+	if (aes_op == AES_OP_ENCRYPT) {
+		scatterwalk_map_and_copy(tag, req->dst,
+					 req->assoclen, authsize, 1);
+	} else {
+		u8 expected[CMH_AES_BLOCK_SIZE];
+
+		scatterwalk_map_and_copy(expected, req->src,
+					 req->assoclen, authsize, 0);
+		if (crypto_memneq(tag, expected, authsize))
+			return -EBADMSG;
+	}
+
+	return 0;
+}
+
+/*
+ * CCM authsize=10 fallback.
+ *
+ * The eSW AES CCM core does not support authsize=10 (valid per RFC 3610).
+ * Forward the entire request to the generic CCM implementation.
+ */
+static void cmh_aes_ccm_fb_done(void *data, int err)
+{
+	struct aead_request *req = data;
+
+	cmh_complete(&req->base, err);
+}
+
+static int cmh_aes_ccm_fallback(struct aead_request *req, u32 aes_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	struct cmh_aes_aead_reqctx *rctx = aead_request_ctx(req);
+	struct aead_request *subreq = (void *)(rctx + 1);
+
+	aead_request_set_tfm(subreq, tctx->fallback);
+	aead_request_set_callback(subreq, req->base.flags,
+				  cmh_aes_ccm_fb_done, req);
+	aead_request_set_crypt(subreq, req->src, req->dst,
+			       req->cryptlen, req->iv);
+	aead_request_set_ad(subreq, req->assoclen);
+
+	return (aes_op == AES_OP_ENCRYPT) ?
+		crypto_aead_encrypt(subreq) : crypto_aead_decrypt(subreq);
+}
+
+/*
+ * Core AEAD encrypt/decrypt -- async path.
+ *
+ * Encrypt: plaintext -> ciphertext + tag appended
+ * Decrypt: ciphertext + tag -> plaintext (tag verified by eSW)
+ *
+ * VCQ: [SYS_CMD_WRITE] + INIT/CCM_INIT + [AAD_FINAL] + FINAL + FLUSH
+ */
+static int cmh_aes_aead_crypt(struct aead_request *req, u32 aes_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_aes_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	const struct cmh_aes_aead_info *info = cmh_aes_aead_get_info(tfm);
+	struct cmh_aes_aead_reqctx *rctx = aead_request_ctx(req);
+	struct vcq_cmd cmds[CMH_AES_AEAD_MAX_PAYLOAD];
+	u64 key_ref;
+	u32 keylen, authsize, cryptlen;
+	struct core_dispatch d;
+	s32 target_mbx;
+	u32 core_id;
+	u32 idx;
+	int ret;
+	gfp_t gfp;
+
+	if (tctx->key.mode == CMH_KEY_NONE)
+		return -ENOKEY;
+
+	authsize = tctx->authsize;
+
+	if (aes_op == AES_OP_ENCRYPT) {
+		cryptlen = req->cryptlen;
+	} else {
+		if (req->cryptlen < authsize)
+			return -EINVAL;
+		cryptlen = req->cryptlen - authsize;
+	}
+
+	/*
+	 * Validate CCM IV format early -- the empty-input fallback and
+	 * nonce extraction both depend on iv[0] being in range [1,7].
+	 */
+	if (info->type == CMH_AES_AEAD_CCM) {
+		if (req->iv[0] < 1 || req->iv[0] > 7)
+			return -EINVAL;
+	}
+
+	/*
+	 * The CMH eSW rejects GCM/CCM when both aadlen and iolen are zero.
+	 * For GCM, the tag is simply E(K, J0) -- handle with ECB fallback.
+	 * For CCM, compute tag = E(K,B0) XOR E(K,A0) in software.
+	 */
+	if (cryptlen == 0 && req->assoclen == 0) {
+		if (info->type == CMH_AES_AEAD_GCM)
+			return cmh_aes_gcm_empty(req, aes_op);
+		return cmh_aes_ccm_empty(req, aes_op);
+	}
+
+	/*
+	 * HW does not support authsize=10 for CCM.  Forward the entire
+	 * request to the generic CCM implementation.
+	 */
+	if (info->type == CMH_AES_AEAD_CCM && authsize == 10)
+		return cmh_aes_ccm_fallback(req, aes_op);
+
+	/*
+	 * HW uses a proprietary LLI scatter-gather format that is
+	 * incompatible with struct scatterlist, so the payload is
+	 * linearised into contiguous buffers for DMA.  Cap total
+	 * size to prevent excessive memory consumption.
+	 */
+	if ((u64)cryptlen + req->assoclen > SZ_1M)
+		return -EINVAL;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->cryptlen = cryptlen;
+	rctx->assoclen = req->assoclen;
+	rctx->authsize = authsize;
+	rctx->encrypting = (aes_op == AES_OP_ENCRYPT);
+
+	/* Linearise AAD */
+	if (req->assoclen > 0) {
+		rctx->aad_buf = kmalloc(req->assoclen, gfp);
+		if (!rctx->aad_buf)
+			return -ENOMEM;
+		scatterwalk_map_and_copy(rctx->aad_buf, req->src,
+					 0, req->assoclen, 0);
+		rctx->aad_dma = cmh_dma_map_single(rctx->aad_buf,
+						   req->assoclen,
+						    DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->aad_dma)) {
+			ret = -ENOMEM;
+			goto out_free_aad;
+		}
+	}
+
+	/* Linearise input */
+	if (cryptlen > 0) {
+		rctx->in_buf = kmalloc(cryptlen, gfp);
+		if (!rctx->in_buf) {
+			ret = -ENOMEM;
+			goto out_unmap_aad;
+		}
+		scatterwalk_map_and_copy(rctx->in_buf, req->src,
+					 req->assoclen, cryptlen, 0);
+		rctx->in_dma = cmh_dma_map_single(rctx->in_buf, cryptlen,
+						  DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->in_dma)) {
+			ret = -ENOMEM;
+			goto out_free_in;
+		}
+	}
+
+	/* Allocate output buffer */
+	if (cryptlen > 0) {
+		rctx->out_buf = kmalloc(cryptlen, gfp);
+		if (!rctx->out_buf) {
+			ret = -ENOMEM;
+			goto out_unmap_in;
+		}
+		rctx->out_dma = cmh_dma_map_single(rctx->out_buf, cryptlen,
+						   DMA_FROM_DEVICE);
+		if (cmh_dma_map_error(rctx->out_dma)) {
+			ret = -ENOMEM;
+			goto out_free_out;
+		}
+	}
+
+	/* Tag buffer */
+	rctx->tag_buf = kmalloc(authsize, gfp);
+	if (!rctx->tag_buf) {
+		ret = -ENOMEM;
+		goto out_unmap_out;
+	}
+
+	if (!rctx->encrypting) {
+		scatterwalk_map_and_copy(rctx->tag_buf, req->src,
+					 req->assoclen + cryptlen,
+					authsize, 0);
+	} else {
+		memset(rctx->tag_buf, 0, authsize);
+	}
+
+	rctx->tag_dma = cmh_dma_map_single(rctx->tag_buf, authsize,
+					   rctx->encrypting ?
+					    DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->tag_dma)) {
+		ret = -ENOMEM;
+		goto out_free_tag;
+	}
+
+	/* Map IV/nonce */
+	if (info->type == CMH_AES_AEAD_GCM) {
+		rctx->iv_buf = kzalloc(AES_GCM_HW_IV_SIZE, gfp);
+		if (!rctx->iv_buf) {
+			ret = -ENOMEM;
+			goto out_unmap_tag;
+		}
+		memcpy(rctx->iv_buf, req->iv, AES_GCM_IV_SIZE);
+		rctx->iv_map_len = AES_GCM_HW_IV_SIZE;
+		rctx->iv_dma = cmh_dma_map_single(rctx->iv_buf,
+						  rctx->iv_map_len,
+						   DMA_TO_DEVICE);
+	} else {
+		u32 noncelen;
+
+		if (req->iv[0] < 1 || req->iv[0] > 7) {
+			ret = -EINVAL;
+			goto out_unmap_tag;
+		}
+		noncelen = 14 - req->iv[0];
+
+		rctx->iv_buf = kmemdup(req->iv + 1, noncelen, gfp);
+		if (!rctx->iv_buf) {
+			ret = -ENOMEM;
+			goto out_unmap_tag;
+		}
+		rctx->iv_map_len = noncelen;
+		rctx->iv_dma = cmh_dma_map_single(rctx->iv_buf,
+						  rctx->iv_map_len,
+						   DMA_TO_DEVICE);
+	}
+	if (cmh_dma_map_error(rctx->iv_dma)) {
+		ret = -ENOMEM;
+		goto out_free_iv;
+	}
+
+	/* Resolve key reference */
+	idx = 0;
+
+	rctx->key_dma = tctx->key.raw.dma;
+	rctx->keylen = tctx->key.raw.len;
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+			  (u64)rctx->key_dma, SYS_REF_NONE,
+			  tctx->key.raw.len,
+			  tctx->key.raw.sys_type);
+	key_ref = SYS_REF_TEMP;
+	keylen = tctx->key.raw.len;
+	d = cmh_core_select_instance(CMH_CORE_AES);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/* Build INIT command */
+	if (info->type == CMH_AES_AEAD_CCM) {
+		vcq_add_aes_ccm_init(&cmds[idx++], core_id, key_ref,
+				     (u64)rctx->iv_dma, keylen,
+				     rctx->iv_map_len, aes_op,
+				     req->assoclen, cryptlen, authsize);
+	} else {
+		vcq_add_aes_aead_init(&cmds[idx++], core_id, key_ref,
+				      (u64)rctx->iv_dma, keylen,
+				      AES_GCM_HW_IV_SIZE, info->aes_mode,
+				      aes_op, req->assoclen, cryptlen,
+				      authsize);
+	}
+
+	if (req->assoclen > 0)
+		vcq_add_aes_aad_final(&cmds[idx++], core_id,
+				      (u64)rctx->aad_dma, req->assoclen);
+
+	vcq_add_aes_aead_final(&cmds[idx++], core_id,
+			       cryptlen > 0 ? (u64)rctx->in_dma : 0,
+			       cryptlen > 0 ? (u64)rctx->out_dma : 0,
+			       (u64)rctx->tag_dma, cryptlen, authsize);
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_AES_AEAD_MAX_PACKED,
+					    target_mbx,
+					    cmh_aes_aead_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto out_cleanup_all;
+
+	return -EINPROGRESS;
+
+out_cleanup_all:
+	cmh_dma_unmap_single(rctx->iv_dma, rctx->iv_map_len, DMA_TO_DEVICE);
+out_free_iv:
+	kfree(rctx->iv_buf);
+out_unmap_tag:
+	cmh_dma_unmap_single(rctx->tag_dma, authsize,
+			     rctx->encrypting ? DMA_FROM_DEVICE :
+					       DMA_TO_DEVICE);
+out_free_tag:
+	kfree(rctx->tag_buf);
+out_unmap_out:
+	if (cryptlen > 0)
+		cmh_dma_unmap_single(rctx->out_dma, cryptlen, DMA_FROM_DEVICE);
+out_free_out:
+	kfree_sensitive(rctx->out_buf);
+out_unmap_in:
+	if (cryptlen > 0)
+		cmh_dma_unmap_single(rctx->in_dma, cryptlen, DMA_TO_DEVICE);
+out_free_in:
+	kfree_sensitive(rctx->in_buf);
+out_unmap_aad:
+	if (req->assoclen > 0)
+		cmh_dma_unmap_single(rctx->aad_dma, req->assoclen,
+				     DMA_TO_DEVICE);
+out_free_aad:
+	kfree(rctx->aad_buf);
+	return ret;
+}
+
+static int cmh_aes_aead_encrypt(struct aead_request *req)
+{
+	return cmh_aes_aead_crypt(req, AES_OP_ENCRYPT);
+}
+
+static int cmh_aes_aead_decrypt(struct aead_request *req)
+{
+	return cmh_aes_aead_crypt(req, AES_OP_DECRYPT);
+}
+
+/* Registration */
+
+static struct cmh_aes_aead_drv aes_aead_drv_algs[ARRAY_SIZE(aes_aead_algs)];
+
+/**
+ * cmh_aes_aead_register() - Register AES-GCM/CCM AEAD algorithms with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_aes_aead_register(void)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(aes_aead_algs); i++) {
+		const struct cmh_aes_aead_info *info = &aes_aead_algs[i];
+		struct cmh_aes_aead_drv *drv = &aes_aead_drv_algs[i];
+		struct aead_alg *alg = &drv->alg;
+
+		drv->info = info;
+
+		memset(alg, 0, sizeof(*alg));
+
+		alg->setkey      = cmh_aes_aead_setkey;
+		alg->setauthsize = cmh_aes_aead_setauthsize;
+		alg->encrypt     = cmh_aes_aead_encrypt;
+		alg->decrypt     = cmh_aes_aead_decrypt;
+		alg->init        = cmh_aes_aead_init_tfm;
+		alg->exit        = cmh_aes_aead_exit_tfm;
+		alg->ivsize      = info->ivsize;
+		alg->maxauthsize = info->maxauthsize;
+
+		strscpy(alg->base.cra_name, info->alg_name,
+			CRYPTO_MAX_ALG_NAME);
+		strscpy(alg->base.cra_driver_name, info->drv_name,
+			CRYPTO_MAX_ALG_NAME);
+		alg->base.cra_priority  = 300;
+		alg->base.cra_flags     = CRYPTO_ALG_KERN_DRIVER_ONLY |
+					  CRYPTO_ALG_ASYNC;
+		if (info->type == CMH_AES_AEAD_CCM) {
+			alg->base.cra_flags |= CRYPTO_ALG_NEED_FALLBACK;
+			/*
+			 * Bump priority above 300 so we beat the generic
+			 * ccm_base template instance.  That template inherits
+			 * priority (ctr + cbcmac) / 2 = 300 when both
+			 * constituents are at 300, and list ordering would
+			 * otherwise let it shadow our driver.
+			 */
+			alg->base.cra_priority = 301;
+		}
+		alg->base.cra_blocksize = 1;
+		alg->base.cra_ctxsize  = sizeof(struct cmh_aes_aead_tfm_ctx);
+		alg->base.cra_module   = THIS_MODULE;
+
+		ret = crypto_register_aead(alg);
+		if (ret) {
+			dev_err(cmh_dev(), "cmh_aes_aead: failed to register %s (rc=%d)\n",
+				info->alg_name, ret);
+			goto err_unregister;
+		}
+
+		dev_dbg(cmh_dev(), "cmh_aes_aead: registered %s\n", info->alg_name);
+	}
+
+	return 0;
+
+err_unregister:
+	while (i--)
+		crypto_unregister_aead(&aes_aead_drv_algs[i].alg);
+	return ret;
+}
+
+/**
+ * cmh_aes_aead_unregister() - Unregister AES AEAD algorithms from the crypto framework
+ */
+void cmh_aes_aead_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(aes_aead_algs); i++) {
+		crypto_unregister_aead(&aes_aead_drv_algs[i].alg);
+		dev_dbg(cmh_dev(), "cmh_aes_aead: unregistered %s\n",
+			aes_aead_algs[i].alg_name);
+	}
+}
diff --git a/drivers/crypto/cmh/cmh_aes_cmac.c b/drivers/crypto/cmh/cmh_aes_cmac.c
new file mode 100644
index 000000000000..a711c575398d
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_aes_cmac.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API AES-CMAC (ahash) Driver
+ *
+ * Registers cmac(aes) as an ahash algorithm.
+ *
+ * CMAC produces a 16-byte tag (MAC) from a key and message.
+ * VCQ sequence: [SYS_CMD_WRITE] + AES_CMD_INIT(CMAC) +
+ *               AES_CMD_AAD_FINAL_AUTH + FLUSH
+ *
+ * The ahash interface accumulates data in a kernel buffer via .update(),
+ * then .final() builds and submits the VCQ asynchronously.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/hash.h>
+#include <crypto/scatterwalk.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_aes.h"
+#include "cmh_vcq.h"
+#include "cmh_aes_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+#define AES_CMAC_DIGEST_SIZE	16U
+#define AES_CMAC_BLOCK_SIZE	16U
+
+/*
+ * Maximum accumulated data for CMAC -- driver-imposed, not HW.
+ *
+ * The AES core does not expose external save/restore VCQ commands,
+ * so the driver must accumulate all data in kernel memory via
+ * .update() and submit it atomically in .final().  This cap limits
+ * the per-request kernel allocation.
+ */
+#define AES_CMAC_MAX_DATA	(64 * 1024)
+
+/* Per-transform context */
+struct cmh_aes_cmac_tfm_ctx {
+	struct cmh_key_ctx key;
+	spinlock_t         chunk_lock;  /* protects all_chunks */
+	struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* One chunk per .update() call -- data is embedded via flexible array */
+struct cmh_aes_cmac_chunk {
+	struct list_head list;
+	struct list_head tfm_node; /* per-tfm orphan tracking */
+	u32 len;
+	u8 data[];
+};
+
+/* Per-request context (lives in ahash_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + AES_CMD_INIT + AES_CMD_AAD_FINAL_AUTH + FLUSH = 4
+ */
+#define CMH_AES_CMAC_MAX_PAYLOAD	4
+#define CMH_AES_CMAC_MAX_PACKED		(CMH_AES_CMAC_MAX_PAYLOAD * 2)
+
+struct cmh_aes_cmac_reqctx {
+	struct list_head chunks;
+	u32  total_len;
+	u8  *buf;	/* linearised in final() for DMA */
+	/* DMA state for async final */
+	dma_addr_t key_dma;
+	dma_addr_t in_dma;
+	dma_addr_t tag_dma;
+	u8 *tag_buf;
+	u32 keylen;
+	struct vcq_cmd packed[CMH_AES_CMAC_MAX_PACKED];
+};
+
+/* Flat state for export/import -- holds accumulated input data only */
+struct cmh_aes_cmac_export_state {
+	u32 total_len;
+	u8  data[];
+};
+
+/*
+ * Flat state buffer for export/import.  The CMH AES core does not
+ * support save/restore of intermediate CMAC state, so this driver
+ * accumulates input in SW and serialises the buffer on export.
+ *
+ * PAGE_SIZE (4096) caps the exportable accumulated-data window.
+ * Full-range export is not feasible because the crypto subsystem
+ * pre-allocates statesize bytes per request.  Export returns -EINVAL
+ * if the caller has accumulated more than CMH_AES_CMAC_EXPORT_MAX.
+ */
+#define CMH_AES_CMAC_STATE_SIZE 4096
+#define CMH_AES_CMAC_EXPORT_MAX \
+	(CMH_AES_CMAC_STATE_SIZE - sizeof(struct cmh_aes_cmac_export_state))
+
+/*
+ * Export/import: not supported.
+ *
+ * The AES core lacks external save/restore VCQ commands, so there is
+ * no way to checkpoint intermediate CMAC state to host memory.
+ * Pending eSW ABI extension to add save/restore for the AES core.
+ */
+
+static int cmh_aes_cmac_setkey(struct crypto_ahash *tfm, const u8 *key,
+			       unsigned int keylen)
+{
+	struct cmh_aes_cmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	if (keylen != 16 && keylen != 24 && keylen != 32)
+		return -EINVAL;
+
+	return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_AES);
+}
+
+static void cmh_aes_cmac_free_chunks(struct cmh_aes_cmac_reqctx *rctx,
+				     struct cmh_aes_cmac_tfm_ctx *tctx)
+{
+	struct cmh_aes_cmac_chunk *c, *tmp;
+
+	spin_lock_bh(&tctx->chunk_lock);
+	list_for_each_entry_safe(c, tmp, &rctx->chunks, list) {
+		list_del(&c->list);
+		list_del(&c->tfm_node);
+		kfree_sensitive(c);
+	}
+	spin_unlock_bh(&tctx->chunk_lock);
+	rctx->total_len = 0;
+}
+
+static int cmh_aes_cmac_init(struct ahash_request *req)
+{
+	struct cmh_aes_cmac_reqctx *rctx = ahash_request_ctx(req);
+
+	memset(rctx, 0, sizeof(*rctx));
+	INIT_LIST_HEAD(&rctx->chunks);
+	return 0;
+}
+
+static int cmh_aes_cmac_update(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_aes_cmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_aes_cmac_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_aes_cmac_chunk *chunk;
+	gfp_t gfp;
+	int ret;
+
+	if (!req->nbytes)
+		return 0;
+
+	if (req->nbytes > AES_CMAC_MAX_DATA - rctx->total_len) {
+		ret = -EINVAL;
+		goto err_free_chunks;
+	}
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	chunk = kmalloc(sizeof(*chunk) + req->nbytes, gfp);
+	if (!chunk) {
+		ret = -ENOMEM;
+		goto err_free_chunks;
+	}
+
+	chunk->len = req->nbytes;
+	if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+		memcpy(chunk->data, req->svirt, req->nbytes);
+	else
+		scatterwalk_map_and_copy(chunk->data, req->src,
+					 0, req->nbytes, 0);
+
+	list_add_tail(&chunk->list, &rctx->chunks);
+	spin_lock_bh(&tctx->chunk_lock);
+	list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+	spin_unlock_bh(&tctx->chunk_lock);
+	rctx->total_len += req->nbytes;
+	return 0;
+
+err_free_chunks:
+	/*
+	 * Terminal error -- free all previously accumulated chunks.
+	 * callers may not call .final() on error, so they would leak.
+	 */
+	cmh_aes_cmac_free_chunks(rctx, tctx);
+	return ret;
+}
+
+static void cmh_aes_cmac_complete(void *data, int error)
+{
+	struct ahash_request *req = data;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_aes_cmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_aes_cmac_reqctx *rctx = ahash_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	/* Unmap DMA */
+	if (rctx->total_len > 0)
+		cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+				     DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->tag_dma, AES_CMAC_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+
+	if (!error)
+		memcpy(req->result, rctx->tag_buf, AES_CMAC_DIGEST_SIZE);
+
+	kfree(rctx->tag_buf);
+	rctx->tag_buf = NULL;
+	kfree_sensitive(rctx->buf);
+	rctx->buf = NULL;
+	cmh_aes_cmac_free_chunks(rctx, tctx);
+	cmh_complete(&req->base, error);
+}
+
+static int cmh_aes_cmac_final(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_aes_cmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_aes_cmac_reqctx *rctx = ahash_request_ctx(req);
+	struct vcq_cmd cmds[CMH_AES_CMAC_MAX_PAYLOAD];
+	u64 key_ref;
+	u32 keylen;
+	struct core_dispatch d;
+	s32 target_mbx;
+	u32 core_id;
+	u32 idx;
+	int ret;
+	gfp_t gfp;
+
+	if (tctx->key.mode == CMH_KEY_NONE) {
+		ret = -ENOKEY;
+		goto out_free_buf;
+	}
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	/* Linearise accumulated chunks into a contiguous buffer for DMA */
+	if (rctx->total_len > 0) {
+		struct cmh_aes_cmac_chunk *c;
+		u32 off = 0;
+
+		rctx->buf = kmalloc(rctx->total_len, gfp);
+		if (!rctx->buf) {
+			ret = -ENOMEM;
+			goto out_free_chunks;
+		}
+		list_for_each_entry(c, &rctx->chunks, list) {
+			memcpy(rctx->buf + off, c->data, c->len);
+			off += c->len;
+		}
+	}
+
+	/* Tag output buffer */
+	rctx->tag_buf = kzalloc(AES_CMAC_DIGEST_SIZE, gfp);
+	if (!rctx->tag_buf) {
+		ret = -ENOMEM;
+		goto out_free_buf;
+	}
+
+	rctx->tag_dma = cmh_dma_map_single(rctx->tag_buf,
+					   AES_CMAC_DIGEST_SIZE,
+					    DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->tag_dma)) {
+		ret = -ENOMEM;
+		goto out_free_tag;
+	}
+
+	/* Map input data (may be zero-length for empty CMAC) */
+	if (rctx->total_len > 0) {
+		rctx->in_dma = cmh_dma_map_single(rctx->buf, rctx->total_len,
+						  DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->in_dma)) {
+			ret = -ENOMEM;
+			goto out_unmap_tag;
+		}
+	}
+
+	/* Resolve key */
+	idx = 0;
+
+	rctx->key_dma = tctx->key.raw.dma;
+	rctx->keylen = tctx->key.raw.len;
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+			  (u64)rctx->key_dma, SYS_REF_NONE,
+			  tctx->key.raw.len,
+			  tctx->key.raw.sys_type);
+	key_ref = SYS_REF_TEMP;
+	keylen = tctx->key.raw.len;
+	d = cmh_core_select_instance(CMH_CORE_AES);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/*
+	 * INIT: mode=CMAC, op=ENCRYPT (CMAC always "encrypts")
+	 * CMAC data goes through the AAD path:
+	 *   aadlen = total data length, iolen = 0
+	 */
+	{
+		struct vcq_cmd *slot = &cmds[idx++];
+
+		memset(slot, 0, sizeof(*slot));
+		slot->magic = VCQ_CMD_MAGIC;
+		slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_INIT);
+		slot->hwc.aes.cmd_init.key = key_ref;
+		slot->hwc.aes.cmd_init.iv = 0;
+		slot->hwc.aes.cmd_init.keylen = keylen;
+		slot->hwc.aes.cmd_init.ivlen = 0;
+		slot->hwc.aes.cmd_init.mode = AES_MODE_CMAC;
+		slot->hwc.aes.cmd_init.op = AES_OP_ENCRYPT;
+		slot->hwc.aes.cmd_init.aadlen = rctx->total_len;
+		slot->hwc.aes.cmd_init.iolen = 0;
+		slot->hwc.aes.cmd_init.taglen = AES_CMAC_DIGEST_SIZE;
+	}
+
+	/* AAD_FINAL_AUTH: final AAD + tag extraction in one atomic step */
+	{
+		struct vcq_cmd *slot = &cmds[idx++];
+
+		memset(slot, 0, sizeof(*slot));
+		slot->magic = VCQ_CMD_MAGIC;
+		slot->id = VCQ_CMD_ID(core_id, 0, 1, AES_CMD_AAD_FINAL_AUTH);
+		slot->hwc.aes.cmd_aad_final_auth.data =
+			rctx->total_len > 0 ? (u64)rctx->in_dma : 0;
+		slot->hwc.aes.cmd_aad_final_auth.datalen = rctx->total_len;
+		slot->hwc.aes.cmd_aad_final_auth.tag = (u64)rctx->tag_dma;
+		slot->hwc.aes.cmd_aad_final_auth.taglen = AES_CMAC_DIGEST_SIZE;
+	}
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_AES_CMAC_MAX_PACKED,
+					    target_mbx,
+					    cmh_aes_cmac_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	/* -EBUSY = backlogged; ownership transferred to callback. */
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto out_cleanup_all;
+
+	return -EINPROGRESS;
+
+out_cleanup_all:
+	if (rctx->total_len > 0 && !cmh_dma_map_error(rctx->in_dma))
+		cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+				     DMA_TO_DEVICE);
+out_unmap_tag:
+	cmh_dma_unmap_single(rctx->tag_dma, AES_CMAC_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+out_free_tag:
+	kfree(rctx->tag_buf);
+out_free_buf:
+out_free_chunks:
+	cmh_aes_cmac_free_chunks(rctx, tctx);
+	kfree_sensitive(rctx->buf);
+	rctx->buf = NULL;
+	rctx->total_len = 0;
+	return ret;
+}
+
+/*
+ * ahash .export()/.import(): serialize/deserialize the software
+ * accumulation buffer.  No HW state is involved -- the AES core
+ * does not support save/restore, but we only export the input queue.
+ */
+
+static int cmh_aes_cmac_export(struct ahash_request *req, void *out)
+{
+	struct cmh_aes_cmac_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_aes_cmac_export_state *state = out;
+	struct cmh_aes_cmac_chunk *chunk;
+	u32 offset = 0;
+
+	if (rctx->total_len > CMH_AES_CMAC_EXPORT_MAX)
+		return -ENOSPC;
+
+	state->total_len = rctx->total_len;
+	list_for_each_entry(chunk, &rctx->chunks, list) {
+		memcpy(state->data + offset, chunk->data, chunk->len);
+		offset += chunk->len;
+	}
+	return 0;
+}
+
+static int cmh_aes_cmac_import(struct ahash_request *req, const void *in)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_aes_cmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_aes_cmac_reqctx *rctx = ahash_request_ctx(req);
+	const struct cmh_aes_cmac_export_state *state = in;
+	struct cmh_aes_cmac_chunk *chunk;
+
+	/*
+	 * Do NOT call free_chunks() here: the crypto API does not
+	 * guarantee the request context is in a valid state before
+	 * import(), so the list pointers may be stale or invalid.
+	 * Re-initialize from scratch instead.  Any pre-existing chunks
+	 * are tracked on tctx->all_chunks and freed in exit_tfm.
+	 */
+	memset(rctx, 0, sizeof(*rctx));
+	INIT_LIST_HEAD(&rctx->chunks);
+
+	if (state->total_len > CMH_AES_CMAC_EXPORT_MAX)
+		return -EINVAL;
+
+	if (state->total_len) {
+		chunk = kmalloc(sizeof(*chunk) + state->total_len, GFP_KERNEL);
+		if (!chunk)
+			return -ENOMEM;
+		chunk->len = state->total_len;
+		memcpy(chunk->data, state->data, state->total_len);
+		list_add_tail(&chunk->list, &rctx->chunks);
+		spin_lock_bh(&tctx->chunk_lock);
+		list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+		spin_unlock_bh(&tctx->chunk_lock);
+		rctx->total_len = state->total_len;
+	}
+	return 0;
+}
+
+static int cmh_aes_cmac_finup(struct ahash_request *req)
+{
+	int err;
+
+	err = cmh_aes_cmac_update(req);
+	if (err)
+		return err;
+	return cmh_aes_cmac_final(req);
+}
+
+static int cmh_aes_cmac_digest(struct ahash_request *req)
+{
+	int err;
+
+	err = cmh_aes_cmac_init(req);
+	if (err)
+		return err;
+	return cmh_aes_cmac_finup(req);
+}
+
+static int cmh_aes_cmac_init_tfm(struct crypto_ahash *tfm)
+{
+	struct cmh_aes_cmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	spin_lock_init(&tctx->chunk_lock);
+	INIT_LIST_HEAD(&tctx->all_chunks);
+	crypto_ahash_set_reqsize(tfm, sizeof(struct cmh_aes_cmac_reqctx));
+	return 0;
+}
+
+static void cmh_aes_cmac_exit_tfm(struct crypto_ahash *tfm)
+{
+	struct cmh_aes_cmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_aes_cmac_chunk *c, *tmp;
+
+	/* Free any orphaned chunks (e.g. testmgr export/reimport poison) */
+	spin_lock_bh(&tctx->chunk_lock);
+	list_for_each_entry_safe(c, tmp, &tctx->all_chunks, tfm_node) {
+		list_del(&c->tfm_node);
+		kfree_sensitive(c);
+	}
+	spin_unlock_bh(&tctx->chunk_lock);
+
+	cmh_key_destroy(&tctx->key);
+}
+
+static struct ahash_alg cmh_aes_cmac_alg = {
+	.init		= cmh_aes_cmac_init,
+	.update		= cmh_aes_cmac_update,
+	.final		= cmh_aes_cmac_final,
+	.finup		= cmh_aes_cmac_finup,
+	.digest		= cmh_aes_cmac_digest,
+	.export		= cmh_aes_cmac_export,
+	.import		= cmh_aes_cmac_import,
+	.setkey		= cmh_aes_cmac_setkey,
+	.init_tfm	= cmh_aes_cmac_init_tfm,
+	.exit_tfm	= cmh_aes_cmac_exit_tfm,
+	.halg		= {
+		.digestsize	= AES_CMAC_DIGEST_SIZE,
+		.statesize	= CMH_AES_CMAC_STATE_SIZE,
+		.base		= {
+			.cra_name	 = "cmac(aes)",
+			.cra_driver_name = "cri-cmh-cmac-aes",
+			.cra_priority	 = 300,
+			.cra_flags	 = CRYPTO_ALG_KERN_DRIVER_ONLY |
+					   CRYPTO_ALG_NO_FALLBACK |
+					   CRYPTO_ALG_ASYNC |
+					   CRYPTO_ALG_REQ_VIRT,
+			.cra_blocksize	 = AES_CMAC_BLOCK_SIZE,
+			.cra_ctxsize	 = sizeof(struct cmh_aes_cmac_tfm_ctx),
+			.cra_module	 = THIS_MODULE,
+		},
+	},
+};
+
+/**
+ * cmh_aes_cmac_register() - Register AES-CMAC hash algorithm with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_aes_cmac_register(void)
+{
+	int ret;
+
+	ret = crypto_register_ahash(&cmh_aes_cmac_alg);
+	if (ret)
+		dev_err(cmh_dev(), "cmh_aes_cmac: failed to register cmac(aes) (rc=%d)\n",
+			ret);
+	else
+		dev_dbg(cmh_dev(), "cmh_aes_cmac: registered cmac(aes)\n");
+
+	return ret;
+}
+
+/**
+ * cmh_aes_cmac_unregister() - Unregister AES-CMAC hash algorithm from the crypto framework
+ */
+void cmh_aes_cmac_unregister(void)
+{
+	crypto_unregister_ahash(&cmh_aes_cmac_alg);
+	dev_dbg(cmh_dev(), "cmh_aes_cmac: unregistered cmac(aes)\n");
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index bc326a9d7626..535a6ff551a2 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -34,6 +34,7 @@
 #include "cmh_cshake.h"
 #include "cmh_kmac.h"
 #include "cmh_sm3.h"
+#include "cmh_aes.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -227,6 +228,21 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sm3_register;
 
+	/* Register AES skcipher algorithms */
+	ret = cmh_aes_register();
+	if (ret)
+		goto err_aes_register;
+
+	/* Register AES AEAD algorithms (GCM, CCM) */
+	ret = cmh_aes_aead_register();
+	if (ret)
+		goto err_aes_aead_register;
+
+	/* Register AES CMAC algorithm */
+	ret = cmh_aes_cmac_register();
+	if (ret)
+		goto err_aes_cmac_register;
+
 	/* Register key management device (/dev/cmh_mgmt) */
 	ret = cmh_mgmt_register();
 	if (ret)
@@ -239,6 +255,12 @@ static int cmh_probe(struct platform_device *pdev)
 	return 0;
 
 err_mgmt_register:
+	cmh_aes_cmac_unregister();
+err_aes_cmac_register:
+	cmh_aes_aead_unregister();
+err_aes_aead_register:
+	cmh_aes_unregister();
+err_aes_register:
 	cmh_sm3_unregister();
 err_sm3_register:
 	cmh_kmac_unregister();
@@ -275,6 +297,9 @@ static void cmh_remove(struct platform_device *pdev)
 	cfg = &dev->config;
 
 	cmh_mgmt_unregister();
+	cmh_aes_cmac_unregister();
+	cmh_aes_aead_unregister();
+	cmh_aes_unregister();
 	cmh_sm3_unregister();
 	cmh_kmac_unregister();
 	cmh_cshake_unregister();
diff --git a/drivers/crypto/cmh/include/cmh_aes.h b/drivers/crypto/cmh/include/cmh_aes.h
new file mode 100644
index 000000000000..591afaa36f85
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_aes.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- AES Crypto API Drivers
+ *
+ * Registers AES algorithms with the Linux crypto subsystem:
+ *   skcipher: ecb/cbc/ctr/cfb/xts(aes)
+ *   aead:     gcm/ccm(aes)
+ *   shash:    cmac(aes)
+ */
+
+#ifndef CMH_AES_H
+#define CMH_AES_H
+
+int  cmh_aes_register(void);
+void cmh_aes_unregister(void);
+
+int  cmh_aes_aead_register(void);
+void cmh_aes_aead_unregister(void);
+
+int  cmh_aes_cmac_register(void);
+void cmh_aes_cmac_unregister(void);
+
+#endif /* CMH_AES_H */
-- 
2.43.7


