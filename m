Return-Path: <linux-api+bounces-6817-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7T/DH6oFUGoPsAIAu9opvQ
	(envelope-from <linux-api+bounces-6817-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:33:46 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E56A773567A
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=vyBJnjS9;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6817-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6817-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C90EB3067CA2
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ADC3DB33C;
	Thu,  9 Jul 2026 20:31:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021106.outbound.protection.outlook.com [52.101.52.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E3F3CF030;
	Thu,  9 Jul 2026 20:31:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629099; cv=fail; b=lbdKeQIEAPCA7csNfgG+ujOQARsLJgMMVEu5ov6zwiGOaGjoqvyduDXy5rSW+lePQsTUuNgReM210mYTcVaUKS09YUela6DhWhwc1A0WrQynWpYpzyJzOuyW4+FIvAMib8OKPZc5SQXp4jjfL4cHw+IpKTSY4UsjaBOHOAyRw+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629099; c=relaxed/simple;
	bh=+8ldbnnThrgZOGouSbQWv29tZP10MKYQMSFHr05pbEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jU0axs5jtwEg7GIPJoIeMxRn2obOPnv4szyWr+U88Rdsre+4ug7E9Svl+AoEDluh/zn/m5Bpp2qYATss5P54/Ulpi8/Ts3He8E5WMeqZGAuDhMEeNiRON8OK2sypdA2i8d3xqAuMuZk2gq8MRTS3oaTRkpy1jywIb2NPra0lb9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=vyBJnjS9; arc=fail smtp.client-ip=52.101.52.106
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U+2nQSl9njSPPoAQCy4vci9jlUieukkokciP/Pr4OXbp/LeJgCbqfkfQWjwJYJuyRPdRuYxQWxLt76aDBtdaxoMMoPULP5JsLRyNTEFnprHofpsklKvmNF4KGh08LHoRLWGEO7vofRi2RHL0RDEQ0dNapkroUgxCTxxCFchkURdgX17uNAQ0UInr61gkhRMMw7HJtxHCn79N/yUvRrxTbjXxP3wYDY7zM4lADS/6LLoDc8juRkj204JE3mLJ+kOWZqolocupGKh6cvvHA3/3SLvukwZ4F9ASEEFf9nNHOrgopwpy/+IdqKqdbgnj4gTYs+F4xTZMRDKq82usY/7y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0cSpZwkOHfv2tGfvQUSHCdw3BO31XIM9DScq4vBMG0=;
 b=hLm2cHVpujW4JMLpUeB/+MMdYpxspT+FIBIwRQnBWunW81zyWjtfj+rb111k7ykiU5fnzOV4mmwhDqlc/EyEc+ETy8lphmFnj1aViWycC64m3CkJJOnj/BDceqfS1h7jkZDsByCJjyjIFeQDEa9DyudseotJ6GfTk4EEHfefb/7FIprB7v6JLyFq6Fv6On09zAsOmX4ceB+mNMcTdPNpHCae2ZRZVIkF+Us5eb64HYNFURA5elNH4dcdq05KJNZIw8/HFBkZvwKJMVZ3LiGCQ7U67vUZslbBSskzaNxPei5rjChLC4NFOqBNTBG2+SVXwARoKsZzeBlaT3e/fCuqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0cSpZwkOHfv2tGfvQUSHCdw3BO31XIM9DScq4vBMG0=;
 b=vyBJnjS9vRoFoYgrbbm+GCIlrox9P7lFloOkuH7zuVY9rgqEjfxpe5MVOslB1jhqbRSrTmoOyGN7IKaQlyWj8iccBCR8emXbu2BTct8YSyYbUy+7jIUEUzeX4UtbfEB2npAO73+VR7lqQ0ddUD/VBlKdNzVvgwC9iVW9AYkoW8Si/WUMdRSwBbfkMs3jK7mBHxLur5MRfx2lojyW0GTFUlEdZWn4BorZqQ6jBt/feQVLM6uv5o1T4boITwU0/pjah0NDe+VQQWX0b1t+knW8SOZcKULmViGQpnjlF95XiH2ub2hzXQPugZ07aRO5VRdakCCNqrO8ogLwHwJhhgqB7g==
Received: from MW4PR03CA0075.namprd03.prod.outlook.com (2603:10b6:303:b6::20)
 by BN0PR04MB8128.namprd04.prod.outlook.com (2603:10b6:408:144::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:31:23 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:b6:cafe::62) by MW4PR03CA0075.outlook.office365.com
 (2603:10b6:303:b6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 20:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:22 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 0A548180175E;
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
Subject: [PATCH v2 10/19] crypto: cmh - add ChaCha20-Poly1305
Date: Thu,  9 Jul 2026 13:30:28 -0700
Message-ID: <20260709203037.1884436-11-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|BN0PR04MB8128:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e2e25f9f-f467-403e-ce26-08deddf90a82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|36860700016|1800799024|82310400026|921020|22082099003|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	hnqIoK+O7aQKnXTfiJZS6mVUoPMEWBA1ZCV1BcoL+chEsmRd9b2gDsAJ3kF/2X6c8AoWE0x3MWwqlOe2NsLzbs8LNG4vOiXq4NcVklLDxgA4Ut90O7q5EfuVUE0ZHQ7x2a6rxLRKVtWCt0hO0d1C/NFF2gu8167KQCRsk/gKQkZJk09mGbz3NBcBZ3z3r6OlmsCI7nheKdOcJy7lVxKmOWvblQBmq1niJNy+VqcZv0YeBC2t8/1hVnpKMAuMW+2t4Gf6bflqqjW0Bgup13MfoxaqJq4AlyepmisVIP2vx1z+rV/s9MXR0PiboWjf0sdX11bHNrTe+DSa10L6JvmyTHZGcsnbSAR9nH5SVwx+noom9obm164Ro7O2rjQotmDDb7MAfu9fmy0nzGe24rwkK5A8V5dae1PvRi/9OIP6Bt2mBtvbFEcmVUB+n4IacsIdv8CWV2u/TXZYhj4lXGfLR9YB20FAslTPHb7x68moJe78t+tV2cilyGxarUiKBjO3i9fPTcTzbSQdZaBLpEpbnOwJfuBQaUjeScSzcTpcKkgW/qfkhtglK50ueZm/n3Z1HYP9Vd6wp0BVmzxlimtJkMPwaDqXLiCfjQI8y/eDUuQv6PsmzSGIhwZENypKMtSnioGjbUDRxRV5i2hBfg8ZGjXQ0/zOh0vgbbu4DaXLg9O6YN/TzUl12BuBqkopEUQE2ObfQudEpsYK9l9DPxrHhuJWXVayrWAlnBqDQDIvZa11OffDlJb5SqsBReIqpWVg
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(921020)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	A/Ugl2LbmXLVeRKdXclfVwzsGH32OWBc3aZcdS4bKZaiqRcBjuO8T5fHASJObiwJykJ5hiZVv+dEui7HZZ8Thz37HevnPWIOWxbF49UOVJfp2O0YIJ6rhtI7yv79DPKGLNMlyzIZHUj20UhkQn2NofH+LJt+zXWrbaksh5oOCcEps89l077v8XTsMKEaVHdpdRu07lnLVVQ+prOpEGrO2CJyE8inH/h1JXDGL4Ka5fHA4weDylI8l9KFNkD3PdfxPmijR2jntp0dzSPuvUn/EE6VnuPmVkLBhBEDFVvnL32GQY5Rg8Dro9SKf05QXxNt6XTiPDh+Qhu3Zgod1w7yMqDnDIsNubWmgvNPpV0L8x8feVh9553Mcul5bihR50Xqdk+dMOtIB0MFrP/Cto6pYnnA+33iDNY5zxSWE3d9QFzuM83DQ4/y3DUgAFyeISMZ
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:22.5003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e25f9f-f467-403e-ce26-08deddf90a82
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8128
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
	TAGGED_FROM(0.00)[bounces-6817-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: E56A773567A

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ChaCha20-Poly1305 AEAD and ChaCha20 skcipher algorithms
using the CMH CCP core (core ID 0x18).  Also registers the Poly1305
ahash for standalone use.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile          |   5 +-
 drivers/crypto/cmh/cmh_ccp.c         | 364 +++++++++++++++++
 drivers/crypto/cmh/cmh_ccp_aead.c    | 583 +++++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_ccp_poly.c    | 528 ++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_main.c        |  25 ++
 drivers/crypto/cmh/include/cmh_ccp.h |  24 ++
 6 files changed, 1528 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_ccp.c
 create mode 100644 drivers/crypto/cmh/cmh_ccp_aead.c
 create mode 100644 drivers/crypto/cmh/cmh_ccp_poly.c
 create mode 100644 drivers/crypto/cmh/include/cmh_ccp.h

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 1f36cd9c0b98..4ebd0e1d10bc 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -25,7 +25,10 @@ cmh-y := \
 	cmh_aes_cmac.o \
 	cmh_sm4_skcipher.o \
 	cmh_sm4_aead.o \
-	cmh_sm4_cmac.o
+	cmh_sm4_cmac.o \
+	cmh_ccp.o \
+	cmh_ccp_aead.o \
+	cmh_ccp_poly.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_ccp.c b/drivers/crypto/cmh/cmh_ccp.c
new file mode 100644
index 000000000000..deb1db9200f8
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_ccp.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API ChaCha20 (skcipher) Driver
+ *
+ * Registers the "chacha20" skcipher algorithm with the Linux crypto
+ * subsystem, backed by the CMH CCP core.
+ *
+ * VCQ sequence:
+ *   [SYS_CMD_WRITE] + CCP_CMD_CHACHA20_INIT + CCP_CMD_FINAL + CCP_CMD_FLUSH
+ *
+ * The CCP core expects a 16-byte counter+nonce (ctrnonce):
+ *   bytes [0..3]  = 32-bit LE counter
+ *   bytes [4..15] = 12-byte nonce
+ *
+ * The Linux chacha20 skcipher interface passes a 16-byte IV in the
+ * same format, so we forward it directly.
+ *
+ * ChaCha20 is a stream cipher -- arbitrary plaintext lengths are
+ * supported (no block-alignment requirement).
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/scatterwalk.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+
+#include "cmh_ccp.h"
+#include "cmh_vcq.h"
+#include "cmh_ccp_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+/* Per-transform context */
+
+struct cmh_ccp_tfm_ctx {
+	struct cmh_key_ctx key;
+};
+
+/* Per-request context (lives in skcipher_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + CCP_CMD_CHACHA20_INIT + CCP_CMD_FINAL + FLUSH = 4
+ */
+#define CMH_CCP_MAX_PAYLOAD	4
+#define CMH_CCP_MAX_PACKED	(CMH_CCP_MAX_PAYLOAD * 2)
+
+struct cmh_ccp_reqctx {
+	dma_addr_t in_dma;
+	dma_addr_t out_dma;
+	dma_addr_t iv_dma;
+	dma_addr_t key_dma;
+	u8 *in_buf;
+	u8 *out_buf;
+	u8 *iv_buf;
+	u32 cryptlen;
+	u32 keylen;
+	struct vcq_cmd packed[CMH_CCP_MAX_PACKED];
+};
+
+/* VCQ Builders -- ChaCha20-specific */
+
+static void vcq_add_ccp_chacha_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref,
+				    u64 ctrnonce_dma, u32 keylen, u32 op)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, CCP_CMD_CHACHA20_INIT);
+	slot->hwc.ccp.cmd_chacha.key = key_ref;
+	slot->hwc.ccp.cmd_chacha.ctrnonce = ctrnonce_dma;
+	slot->hwc.ccp.cmd_chacha.keylen = keylen;
+	slot->hwc.ccp.cmd_chacha.ctrnoncelen = CCP_CTRNONCE_SIZE;
+	slot->hwc.ccp.cmd_chacha.ctrlen = CCP_CHACHA_CTR_LEN;
+	slot->hwc.ccp.cmd_chacha.op = op;
+}
+
+static void vcq_add_ccp_final(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+			      u64 output_dma, u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, CCP_CMD_FINAL);
+	slot->hwc.ccp.cmd_final.input = input_dma;
+	slot->hwc.ccp.cmd_final.output = output_dma;
+	slot->hwc.ccp.cmd_final.tag = 0;
+	slot->hwc.ccp.cmd_final.iolen = iolen;
+	slot->hwc.ccp.cmd_final.taglen = 0;
+}
+
+/* skcipher Operations */
+static int cmh_ccp_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			  unsigned int keylen)
+{
+	struct cmh_ccp_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	/* ChaCha20 requires 32-byte key per RFC 8439 */
+	if (keylen != 32)
+		return -EINVAL;
+
+	return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_CCP);
+}
+
+static int cmh_ccp_init_tfm(struct crypto_skcipher *tfm)
+{
+	struct cmh_ccp_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct cmh_ccp_reqctx));
+	return 0;
+}
+
+static void cmh_ccp_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct cmh_ccp_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+
+	cmh_key_destroy(&tctx->key);
+}
+
+/* DMA unmap helper */
+static void cmh_ccp_unmap_dma(struct cmh_ccp_reqctx *rctx)
+{
+	cmh_dma_unmap_single(rctx->iv_dma, CCP_CTRNONCE_SIZE, DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->out_dma, rctx->cryptlen, DMA_FROM_DEVICE);
+	cmh_dma_unmap_single(rctx->in_dma, rctx->cryptlen, DMA_TO_DEVICE);
+}
+
+static void cmh_ccp_free_bufs(struct cmh_ccp_reqctx *rctx)
+{
+	kfree(rctx->iv_buf);
+	rctx->iv_buf = NULL;
+	kfree_sensitive(rctx->out_buf);
+	rctx->out_buf = NULL;
+	kfree_sensitive(rctx->in_buf);
+	rctx->in_buf = NULL;
+}
+
+static void cmh_ccp_complete(void *data, int error)
+{
+	struct skcipher_request *req = data;
+	struct cmh_ccp_reqctx *rctx = skcipher_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	cmh_ccp_unmap_dma(rctx);
+
+	if (!error) {
+		u32 counter, nblocks;
+
+		scatterwalk_map_and_copy(rctx->out_buf, req->dst,
+					 0, rctx->cryptlen, 1);
+
+		/*
+		 * Update the 32-bit LE block counter at IV[0..3].
+		 * ChaCha20 processes 64-byte blocks; the nonce at
+		 * IV[4..15] is unchanged.
+		 */
+		counter = get_unaligned_le32(req->iv);
+		nblocks = DIV_ROUND_UP(rctx->cryptlen, 64);
+		put_unaligned_le32(counter + nblocks, req->iv);
+	}
+
+	cmh_ccp_free_bufs(rctx);
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * Core encrypt/decrypt -- builds a VCQ transaction and submits async.
+ *
+ * ChaCha20 is a stream cipher: encrypt and decrypt use the same
+ * underlying XOR operation.
+ */
+static int cmh_ccp_crypt(struct skcipher_request *req, u32 ccp_op)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct cmh_ccp_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	struct cmh_ccp_reqctx *rctx = skcipher_request_ctx(req);
+	struct vcq_cmd cmds[CMH_CCP_MAX_PAYLOAD];
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
+	/* Limit linearisation buffers to avoid large allocations. */
+	if (req->cryptlen > SZ_1M)
+		return -EINVAL;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->cryptlen = req->cryptlen;
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
+	rctx->iv_buf = kmemdup(req->iv, CCP_CTRNONCE_SIZE, gfp);
+	if (!rctx->iv_buf) {
+		ret = -ENOMEM;
+		goto out_unmap_out;
+	}
+
+	rctx->iv_dma = cmh_dma_map_single(rctx->iv_buf, CCP_CTRNONCE_SIZE,
+					  DMA_TO_DEVICE);
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
+	d = cmh_core_select_instance(CMH_CORE_CCP);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	vcq_add_ccp_chacha_init(&cmds[idx++], core_id, key_ref,
+				(u64)rctx->iv_dma, keylen, ccp_op);
+
+	vcq_add_ccp_final(&cmds[idx++], core_id, (u64)rctx->in_dma,
+			  (u64)rctx->out_dma, req->cryptlen);
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_CCP_MAX_PACKED, target_mbx,
+					    cmh_ccp_complete, req,
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
+	cmh_dma_unmap_single(rctx->iv_dma, CCP_CTRNONCE_SIZE, DMA_TO_DEVICE);
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
+static int cmh_ccp_encrypt(struct skcipher_request *req)
+{
+	return cmh_ccp_crypt(req, CCP_OP_ENCRYPT);
+}
+
+static int cmh_ccp_decrypt(struct skcipher_request *req)
+{
+	return cmh_ccp_crypt(req, CCP_OP_DECRYPT);
+}
+
+/* Registration */
+
+static struct skcipher_alg cmh_chacha20_alg = {
+	.setkey      = cmh_ccp_setkey,
+	.encrypt     = cmh_ccp_encrypt,
+	.decrypt     = cmh_ccp_decrypt,
+	.init        = cmh_ccp_init_tfm,
+	.exit        = cmh_ccp_exit_tfm,
+	.min_keysize = 32,
+	.max_keysize = 32,
+	.ivsize      = CCP_CTRNONCE_SIZE,
+	.base        = {
+		.cra_name        = "chacha20",
+		.cra_driver_name = "cri-cmh-chacha20",
+		.cra_priority    = 300,
+		.cra_flags       = CRYPTO_ALG_KERN_DRIVER_ONLY |
+				   CRYPTO_ALG_ASYNC,
+		.cra_blocksize   = 1,	/* stream cipher */
+		.cra_ctxsize     = sizeof(struct cmh_ccp_tfm_ctx),
+		.cra_module      = THIS_MODULE,
+	},
+};
+
+/**
+ * cmh_ccp_register() - Register ChaCha20 skcipher algorithm with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_ccp_register(void)
+{
+	int ret;
+
+	ret = crypto_register_skcipher(&cmh_chacha20_alg);
+	if (ret)
+		dev_err(cmh_dev(), "cmh_ccp: failed to register chacha20 (rc=%d)\n", ret);
+	else
+		dev_dbg(cmh_dev(), "cmh_ccp: registered chacha20\n");
+
+	return ret;
+}
+
+/**
+ * cmh_ccp_unregister() - Unregister ChaCha20 skcipher algorithm from the crypto framework
+ */
+void cmh_ccp_unregister(void)
+{
+	crypto_unregister_skcipher(&cmh_chacha20_alg);
+	dev_dbg(cmh_dev(), "cmh_ccp: unregistered chacha20\n");
+}
diff --git a/drivers/crypto/cmh/cmh_ccp_aead.c b/drivers/crypto/cmh/cmh_ccp_aead.c
new file mode 100644
index 000000000000..20b6f9d1746a
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_ccp_aead.c
@@ -0,0 +1,583 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API ChaCha20-Poly1305 AEAD Driver (RFC 7539)
+ *
+ * Registers "rfc7539(chacha20,poly1305)" as an AEAD algorithm with the
+ * Linux crypto subsystem, backed by the CMH CCP core.
+ *
+ * VCQ sequence:
+ *   [SYS_CMD_WRITE] + CCP_CMD_AEAD_INIT + [CCP_CMD_AAD_FINAL]
+ *   + CCP_CMD_FINAL + CCP_CMD_FLUSH
+ *
+ * The RFC 7539 AEAD interface passes a 12-byte nonce via req->iv.
+ * The CCP core expects a 16-byte ctrnonce (4-byte LE counter + 12-byte
+ * nonce).  We prepend a zero counter (per RFC 7539 S2.8: counter 0
+ * generates the Poly1305 key, counter 1 starts encryption -- the
+ * CMH eSW handles this internally from the initial counter value of 0).
+ *
+ * Tag is always 16 bytes (Poly1305 authenticator).
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/chacha.h>
+#include <crypto/internal/aead.h>
+#include <crypto/scatterwalk.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_ccp.h"
+#include "cmh_vcq.h"
+#include "cmh_ccp_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+#define CCP_AEAD_IV_SIZE	12U	/* RFC 7539 nonce */
+#define CCP_ESP_IV_SIZE		8U	/* RFC 7539 ESP nonce (4-byte salt at setkey) */
+#define CCP_ESP_SALT_SIZE	4U
+#define CCP_AEAD_TAG_SIZE	16U	/* Poly1305 tag */
+
+struct cmh_ccp_aead_tfm_ctx {
+	struct cmh_key_ctx key;
+	u32 authsize;
+	u8 salt[CCP_ESP_SALT_SIZE];	/* ESP salt (unused for rfc7539) */
+};
+
+/* Per-request context (lives in aead_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + CCP_CMD_AEAD_INIT + CCP_CMD_AAD_FINAL
+ *   + CCP_CMD_FINAL + FLUSH = 5
+ */
+#define CMH_CCP_AEAD_MAX_PAYLOAD	5
+#define CMH_CCP_AEAD_MAX_PACKED		(CMH_CCP_AEAD_MAX_PAYLOAD * 2)
+
+struct cmh_ccp_aead_reqctx {
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
+	u32 keylen;
+	bool encrypting;
+	struct vcq_cmd packed[CMH_CCP_AEAD_MAX_PACKED];
+};
+
+/* VCQ Builders -- CCP AEAD-specific */
+
+static void vcq_add_ccp_aead_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref,
+				  u64 ctrnonce_dma, u32 keylen, u32 op)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, CCP_CMD_AEAD_INIT);
+	slot->hwc.ccp.cmd_aead.key = key_ref;
+	slot->hwc.ccp.cmd_aead.ctrnonce = ctrnonce_dma;
+	slot->hwc.ccp.cmd_aead.keylen = keylen;
+	slot->hwc.ccp.cmd_aead.ctrnoncelen = CCP_CTRNONCE_SIZE;
+	slot->hwc.ccp.cmd_aead.op = op;
+}
+
+static void vcq_add_ccp_aad_final(struct vcq_cmd *slot, u32 core_id, u64 aad_dma,
+				  u32 aadlen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, CCP_CMD_AAD_FINAL);
+	slot->hwc.ccp.cmd_aad_final.aad = aad_dma;
+	slot->hwc.ccp.cmd_aad_final.aadlen = aadlen;
+}
+
+static void vcq_add_ccp_aead_final(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+				   u64 output_dma, u64 tag_dma,
+				   u32 iolen, u32 taglen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, CCP_CMD_FINAL);
+	slot->hwc.ccp.cmd_final.input = input_dma;
+	slot->hwc.ccp.cmd_final.output = output_dma;
+	slot->hwc.ccp.cmd_final.tag = tag_dma;
+	slot->hwc.ccp.cmd_final.iolen = iolen;
+	slot->hwc.ccp.cmd_final.taglen = taglen;
+}
+
+/* setkey */
+static int cmh_ccp_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+			       unsigned int keylen)
+{
+	struct cmh_ccp_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	/* RFC 7539 AEAD requires 32-byte key */
+	if (keylen != CHACHA_KEY_SIZE)
+		return -EINVAL;
+
+	return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_CCP);
+}
+
+static int cmh_ccp_aead_setauthsize(struct crypto_aead *tfm,
+				    unsigned int authsize)
+{
+	struct cmh_ccp_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	/* Poly1305 tag is always 16 bytes */
+	if (authsize != CCP_AEAD_TAG_SIZE)
+		return -EINVAL;
+
+	tctx->authsize = authsize;
+	return 0;
+}
+
+static int cmh_ccp_aead_init_tfm(struct crypto_aead *tfm)
+{
+	struct cmh_ccp_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	tctx->authsize = CCP_AEAD_TAG_SIZE;
+	crypto_aead_set_reqsize(tfm, sizeof(struct cmh_ccp_aead_reqctx));
+	return 0;
+}
+
+static void cmh_ccp_aead_exit_tfm(struct crypto_aead *tfm)
+{
+	struct cmh_ccp_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	cmh_key_destroy(&tctx->key);
+}
+
+/* DMA unmap helper */
+static void cmh_ccp_aead_unmap_dma(struct cmh_ccp_aead_reqctx *rctx)
+{
+	cmh_dma_unmap_single(rctx->iv_dma, CCP_CTRNONCE_SIZE, DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->tag_dma, rctx->authsize,
+			     rctx->encrypting ? DMA_FROM_DEVICE :
+					       DMA_TO_DEVICE);
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
+static void cmh_ccp_aead_free_bufs(struct cmh_ccp_aead_reqctx *rctx)
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
+static void cmh_ccp_aead_complete(void *data, int error)
+{
+	struct aead_request *req = data;
+	struct cmh_ccp_aead_reqctx *rctx = aead_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	cmh_ccp_aead_unmap_dma(rctx);
+
+	/*
+	 * Map HW error on decrypt to -EBADMSG.  The eSW CCP core uses a
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
+		if (rctx->cryptlen > 0)
+			scatterwalk_map_and_copy(rctx->out_buf, req->dst,
+						 req->assoclen,
+						rctx->cryptlen, 1);
+		if (rctx->encrypting)
+			scatterwalk_map_and_copy(rctx->tag_buf, req->dst,
+						 req->assoclen +
+						rctx->cryptlen,
+						rctx->authsize, 1);
+	}
+
+	cmh_ccp_aead_free_bufs(rctx);
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * Core AEAD encrypt/decrypt -- async path.
+ *
+ * Encrypt: plaintext -> ciphertext + 16-byte tag
+ * Decrypt: ciphertext + tag -> plaintext (tag verified by CMH eSW)
+ *
+ * VCQ: [SYS_CMD_WRITE] + AEAD_INIT + [AAD_FINAL] + FINAL + FLUSH
+ */
+static int cmh_ccp_aead_crypt(struct aead_request *req, u32 ccp_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_ccp_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	struct cmh_ccp_aead_reqctx *rctx = aead_request_ctx(req);
+	struct vcq_cmd cmds[CMH_CCP_AEAD_MAX_PAYLOAD];
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
+	if (ccp_op == CCP_OP_ENCRYPT) {
+		cryptlen = req->cryptlen;
+	} else {
+		if (req->cryptlen < authsize)
+			return -EINVAL;
+		cryptlen = req->cryptlen - authsize;
+	}
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
+	rctx->encrypting = (ccp_op == CCP_OP_ENCRYPT);
+
+	/*
+	 * rfc7539esp: the last ivsize (8) bytes of the AAD region are the
+	 * IV/nonce, not actual associated data.  Subtract them so HW only
+	 * authenticates the real AAD.
+	 */
+	if (crypto_aead_ivsize(tfm) == CCP_ESP_IV_SIZE) {
+		if (rctx->assoclen < CCP_ESP_IV_SIZE)
+			return -EINVAL;
+		rctx->assoclen -= CCP_ESP_IV_SIZE;
+	}
+
+	/* Linearise AAD */
+	if (rctx->assoclen > 0) {
+		rctx->aad_buf = kmalloc(rctx->assoclen, gfp);
+		if (!rctx->aad_buf)
+			return -ENOMEM;
+		scatterwalk_map_and_copy(rctx->aad_buf, req->src,
+					 0, rctx->assoclen, 0);
+		rctx->aad_dma = cmh_dma_map_single(rctx->aad_buf,
+						   rctx->assoclen,
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
+	/* Build 16-byte ctrnonce: 4-byte zero counter + 12-byte nonce.
+	 * rfc7539:    counter(4) | req->iv(12)
+	 * rfc7539esp: counter(4) | salt(4) | req->iv(8)
+	 */
+	rctx->iv_buf = kzalloc(CCP_CTRNONCE_SIZE, gfp);
+	if (!rctx->iv_buf) {
+		ret = -ENOMEM;
+		goto out_unmap_tag;
+	}
+	if (crypto_aead_ivsize(tfm) == CCP_ESP_IV_SIZE) {
+		memcpy(rctx->iv_buf + CCP_CHACHA_CTR_LEN,
+		       tctx->salt, CCP_ESP_SALT_SIZE);
+		memcpy(rctx->iv_buf + CCP_CHACHA_CTR_LEN + CCP_ESP_SALT_SIZE,
+		       req->iv, CCP_ESP_IV_SIZE);
+	} else {
+		memcpy(rctx->iv_buf + CCP_CHACHA_CTR_LEN,
+		       req->iv, CCP_AEAD_IV_SIZE);
+	}
+
+	rctx->iv_dma = cmh_dma_map_single(rctx->iv_buf, CCP_CTRNONCE_SIZE,
+					  DMA_TO_DEVICE);
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
+	d = cmh_core_select_instance(CMH_CORE_CCP);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/* AEAD_INIT */
+	vcq_add_ccp_aead_init(&cmds[idx++], core_id, key_ref,
+			      (u64)rctx->iv_dma, keylen, ccp_op);
+
+	/* AAD_FINAL if we have associated data */
+	if (rctx->assoclen > 0)
+		vcq_add_ccp_aad_final(&cmds[idx++], core_id,
+				      (u64)rctx->aad_dma, rctx->assoclen);
+
+	/* FINAL with tag */
+	vcq_add_ccp_aead_final(&cmds[idx++], core_id,
+			       cryptlen > 0 ? (u64)rctx->in_dma : 0,
+			       cryptlen > 0 ? (u64)rctx->out_dma : 0,
+			       (u64)rctx->tag_dma, cryptlen, authsize);
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_CCP_AEAD_MAX_PACKED,
+					    target_mbx,
+					    cmh_ccp_aead_complete, req,
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
+	cmh_dma_unmap_single(rctx->iv_dma, CCP_CTRNONCE_SIZE, DMA_TO_DEVICE);
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
+	if (rctx->assoclen > 0)
+		cmh_dma_unmap_single(rctx->aad_dma, rctx->assoclen,
+				     DMA_TO_DEVICE);
+out_free_aad:
+	kfree(rctx->aad_buf);
+	return ret;
+}
+
+static int cmh_ccp_aead_encrypt(struct aead_request *req)
+{
+	return cmh_ccp_aead_crypt(req, CCP_OP_ENCRYPT);
+}
+
+static int cmh_ccp_aead_decrypt(struct aead_request *req)
+{
+	return cmh_ccp_aead_crypt(req, CCP_OP_DECRYPT);
+}
+
+/* -- rfc7539esp: ESP variant with 4-byte salt + 8-byte IV --------------- */
+
+/*
+ * ESP setkey: 36 bytes = 32-byte ChaCha20 key + 4-byte salt.
+ * The salt is prepended to the 8-byte per-packet IV from the ESP header
+ * to form the 12-byte RFC 7539 nonce.
+ */
+static int cmh_ccp_esp_setkey(struct crypto_aead *tfm, const u8 *key,
+			      unsigned int keylen)
+{
+	struct cmh_ccp_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	if (keylen != CHACHA_KEY_SIZE + CCP_ESP_SALT_SIZE)
+		return -EINVAL;
+
+	memcpy(tctx->salt, key + CHACHA_KEY_SIZE, CCP_ESP_SALT_SIZE);
+	return cmh_key_setkey_raw(&tctx->key, key, CHACHA_KEY_SIZE, CORE_ID_CCP);
+}
+
+/* Registration */
+
+static struct aead_alg cmh_rfc7539_alg = {
+	.setkey      = cmh_ccp_aead_setkey,
+	.setauthsize = cmh_ccp_aead_setauthsize,
+	.encrypt     = cmh_ccp_aead_encrypt,
+	.decrypt     = cmh_ccp_aead_decrypt,
+	.init        = cmh_ccp_aead_init_tfm,
+	.exit        = cmh_ccp_aead_exit_tfm,
+	.ivsize      = CCP_AEAD_IV_SIZE,
+	.maxauthsize = CCP_AEAD_TAG_SIZE,
+	.base        = {
+		.cra_name        = "rfc7539(chacha20,poly1305)",
+		.cra_driver_name = "cri-cmh-rfc7539-chacha20-poly1305",
+		.cra_priority    = 300,
+		.cra_flags       = CRYPTO_ALG_KERN_DRIVER_ONLY |
+				   CRYPTO_ALG_ASYNC,
+		.cra_blocksize   = 1,
+		.cra_ctxsize     = sizeof(struct cmh_ccp_aead_tfm_ctx),
+		.cra_module      = THIS_MODULE,
+	},
+};
+
+static struct aead_alg cmh_rfc7539esp_alg = {
+	.setkey      = cmh_ccp_esp_setkey,
+	.setauthsize = cmh_ccp_aead_setauthsize,
+	.encrypt     = cmh_ccp_aead_encrypt,
+	.decrypt     = cmh_ccp_aead_decrypt,
+	.init        = cmh_ccp_aead_init_tfm,
+	.exit        = cmh_ccp_aead_exit_tfm,
+	.ivsize      = CCP_ESP_IV_SIZE,
+	.maxauthsize = CCP_AEAD_TAG_SIZE,
+	.base        = {
+		.cra_name        = "rfc7539esp(chacha20,poly1305)",
+		.cra_driver_name = "cri-cmh-rfc7539esp-chacha20-poly1305",
+		.cra_priority    = 300,
+		.cra_flags       = CRYPTO_ALG_KERN_DRIVER_ONLY |
+				   CRYPTO_ALG_ASYNC,
+		.cra_blocksize   = 1,
+		.cra_ctxsize     = sizeof(struct cmh_ccp_aead_tfm_ctx),
+		.cra_module      = THIS_MODULE,
+	},
+};
+
+/**
+ * cmh_ccp_aead_register() - Register ChaCha20-Poly1305 AEAD algorithm with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_ccp_aead_register(void)
+{
+	int ret;
+
+	ret = crypto_register_aead(&cmh_rfc7539_alg);
+	if (ret) {
+		dev_err(cmh_dev(), "cmh_ccp_aead: failed to register rfc7539 (rc=%d)\n",
+			ret);
+		return ret;
+	}
+	dev_dbg(cmh_dev(), "cmh_ccp_aead: registered rfc7539(chacha20,poly1305)\n");
+
+	ret = crypto_register_aead(&cmh_rfc7539esp_alg);
+	if (ret) {
+		dev_err(cmh_dev(), "cmh_ccp_aead: failed to register rfc7539esp (rc=%d)\n",
+			ret);
+		crypto_unregister_aead(&cmh_rfc7539_alg);
+		return ret;
+	}
+	dev_dbg(cmh_dev(), "cmh_ccp_aead: registered rfc7539esp(chacha20,poly1305)\n");
+
+	return 0;
+}
+
+/**
+ * cmh_ccp_aead_unregister() - Unregister ChaCha20-Poly1305 AEAD algorithms
+ */
+void cmh_ccp_aead_unregister(void)
+{
+	crypto_unregister_aead(&cmh_rfc7539esp_alg);
+	crypto_unregister_aead(&cmh_rfc7539_alg);
+	dev_dbg(cmh_dev(), "cmh_ccp_aead: unregistered rfc7539/rfc7539esp\n");
+}
diff --git a/drivers/crypto/cmh/cmh_ccp_poly.c b/drivers/crypto/cmh/cmh_ccp_poly.c
new file mode 100644
index 000000000000..020a98fbe607
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_ccp_poly.c
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API Poly1305 (ahash) Driver
+ *
+ * Registers "poly1305" as an ahash algorithm with the Linux crypto
+ * subsystem, backed by the CMH CCP core.
+ *
+ * Poly1305 is a one-time authenticator that produces a 16-byte MAC.
+ * It requires two 16-byte keys: r (clamped multiplier) and s (nonce).
+ *
+ * Key format: 32 bytes = r_key[0..15] || s_key[16..31]
+ * This matches the Poly1305 key layout in RFC 7539 S2.5.
+ *
+ * VCQ sequence:
+ *   SYS_CMD_WRITE(s_key) + SYS_CMD_WRITE(r_key)
+ *   + CCP_CMD_POLY1305_INIT + CCP_CMD_FINAL + CCP_CMD_FLUSH
+ *
+ * Both keys are written to SYS_REF_TEMP; the CMH eSW stacks them
+ * so that POLY1305_INIT finds r_key (most recent) as rkey and
+ * s_key (previous) as skey.
+ *
+ * The ahash interface accumulates data via .update() and submits the
+ * full VCQ asynchronously in .final().
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
+#include "cmh_ccp.h"
+#include "cmh_vcq.h"
+#include "cmh_ccp_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+#define POLY1305_DIGEST_SIZE	16U
+#define POLY1305_BLOCK_SIZE	16U
+#define POLY1305_KEY_SIZE	32U	/* r(16) + s(16) */
+
+/*
+ * Maximum accumulated data for Poly1305 -- driver-imposed, not HW.
+ *
+ * The CCP core does not expose external save/restore VCQ commands,
+ * so the driver must accumulate all data in kernel memory via
+ * .update() and submit it atomically in .final().  This cap limits
+ * the per-request kernel allocation.
+ */
+#define POLY_MAX_DATA		(64 * 1024)
+
+/*
+ * Per-transform context -- stores the raw 32-byte key (r || s).
+ *
+ * Only the raw-key path is supported for standalone Poly1305.
+ */
+struct cmh_poly_tfm_ctx {
+	u8  key[POLY1305_KEY_SIZE];
+	dma_addr_t rkey_dma;
+	dma_addr_t skey_dma;
+	u32 keylen;
+	bool has_key;
+	spinlock_t         chunk_lock;  /* protects all_chunks */
+	struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* Chunk node for O(1) update() appends */
+struct cmh_poly_chunk {
+	struct list_head list;
+	struct list_head tfm_node; /* per-tfm orphan tracking */
+	u32 len;
+	u8  data[];
+};
+
+/* Per-request context (lives in ahash_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   SYS_CMD_WRITE(s) + SYS_CMD_WRITE(r) + POLY1305_INIT
+ *   + CCP_CMD_FINAL + FLUSH = 5
+ */
+#define CMH_POLY_MAX_PAYLOAD	5
+#define CMH_POLY_MAX_PACKED	(CMH_POLY_MAX_PAYLOAD * 2)
+
+struct cmh_poly_reqctx {
+	struct list_head chunks;
+	u32  total_len;
+	u8  *buf;		/* linearised in final() */
+	/* DMA state for async final */
+	dma_addr_t in_dma;
+	dma_addr_t tag_dma;
+	u8 *tag_buf;
+	struct vcq_cmd packed[CMH_POLY_MAX_PACKED];
+};
+
+/*
+ * Export/import: not supported.
+ *
+ * The CCP core lacks external save/restore VCQ commands, so there is
+ * no way to checkpoint intermediate Poly1305 state to host memory.
+ * Pending eSW ABI extension to add save/restore for the CCP core.
+ */
+
+static void vcq_add_ccp_poly_init(struct vcq_cmd *slot, u32 core_id,
+				  u64 rkey_ref, u32 rkeylen,
+				  u64 skey_ref, u32 skeylen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, CCP_CMD_POLY1305_INIT);
+	slot->hwc.ccp.cmd_poly.rkey = rkey_ref;
+	slot->hwc.ccp.cmd_poly.rkeylen = rkeylen;
+	slot->hwc.ccp.cmd_poly.skey = skey_ref;
+	slot->hwc.ccp.cmd_poly.skeylen = skeylen;
+}
+
+static void vcq_add_ccp_poly_final(struct vcq_cmd *slot, u32 core_id,
+				   u64 input_dma, u64 tag_dma,
+				   u32 iolen, u32 taglen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, CCP_CMD_FINAL);
+	slot->hwc.ccp.cmd_final.input = input_dma;
+	slot->hwc.ccp.cmd_final.output = 0;
+	slot->hwc.ccp.cmd_final.tag = tag_dma;
+	slot->hwc.ccp.cmd_final.iolen = iolen;
+	slot->hwc.ccp.cmd_final.taglen = taglen;
+}
+
+static int cmh_poly_setkey(struct crypto_ahash *tfm, const u8 *key,
+			   unsigned int keylen)
+{
+	struct cmh_poly_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	/* Poly1305: exactly 32 bytes (r[16] + s[16]) */
+	if (keylen != POLY1305_KEY_SIZE)
+		return -EINVAL;
+
+	/* Unmap old key DMA if re-keying */
+	if (tctx->has_key) {
+		cmh_dma_unmap_single(tctx->rkey_dma, CCP_POLY_KEY_SIZE,
+				     DMA_TO_DEVICE);
+		cmh_dma_unmap_single(tctx->skey_dma, CCP_POLY_KEY_SIZE,
+				     DMA_TO_DEVICE);
+	}
+
+	memcpy(tctx->key, key, POLY1305_KEY_SIZE);
+	tctx->keylen = POLY1305_KEY_SIZE;
+
+	/*
+	 * Pre-map both key halves for DMA.  The key buffer lives in
+	 * the tfm context and is stable until exit_tfm() or re-setkey.
+	 */
+	tctx->skey_dma = cmh_dma_map_single(tctx->key + CCP_POLY_KEY_SIZE,
+					    CCP_POLY_KEY_SIZE,
+					     DMA_TO_DEVICE);
+	if (cmh_dma_map_error(tctx->skey_dma)) {
+		tctx->has_key = false;
+		return -ENOMEM;
+	}
+
+	tctx->rkey_dma = cmh_dma_map_single(tctx->key, CCP_POLY_KEY_SIZE,
+					    DMA_TO_DEVICE);
+	if (cmh_dma_map_error(tctx->rkey_dma)) {
+		cmh_dma_unmap_single(tctx->skey_dma, CCP_POLY_KEY_SIZE,
+				     DMA_TO_DEVICE);
+		tctx->has_key = false;
+		return -ENOMEM;
+	}
+
+	tctx->has_key = true;
+	return 0;
+}
+
+static void cmh_poly_free_chunks(struct cmh_poly_reqctx *rctx,
+				 struct cmh_poly_tfm_ctx *tctx)
+{
+	struct cmh_poly_chunk *c, *tmp;
+
+	spin_lock_bh(&tctx->chunk_lock);
+	list_for_each_entry_safe(c, tmp, &rctx->chunks, list) {
+		list_del(&c->list);
+		list_del(&c->tfm_node);
+		kfree_sensitive(c);
+	}
+	spin_unlock_bh(&tctx->chunk_lock);
+}
+
+static int cmh_poly_init(struct ahash_request *req)
+{
+	struct cmh_poly_reqctx *rctx = ahash_request_ctx(req);
+
+	memset(rctx, 0, sizeof(*rctx));
+	INIT_LIST_HEAD(&rctx->chunks);
+	return 0;
+}
+
+static int cmh_poly_update(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_poly_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_poly_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_poly_chunk *chunk;
+	gfp_t gfp;
+	int ret;
+
+	if (!req->nbytes)
+		return 0;
+
+	if (req->nbytes > POLY_MAX_DATA - rctx->total_len) {
+		ret = -EINVAL;
+		goto err_free_chunks;
+	}
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
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
+	 * Callers may not call .final() on error, so they would leak.
+	 */
+	cmh_poly_free_chunks(rctx, tctx);
+	return ret;
+}
+
+static void cmh_poly_complete(void *data, int error)
+{
+	struct ahash_request *req = data;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_poly_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_poly_reqctx *rctx = ahash_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (rctx->total_len > 0)
+		cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+				     DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->tag_dma, POLY1305_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+
+	if (!error)
+		memcpy(req->result, rctx->tag_buf, POLY1305_DIGEST_SIZE);
+
+	kfree(rctx->tag_buf);
+	rctx->tag_buf = NULL;
+	cmh_poly_free_chunks(rctx, tctx);
+	kfree_sensitive(rctx->buf);
+	rctx->buf = NULL;
+	rctx->total_len = 0;
+	cmh_complete(&req->base, error);
+}
+
+static int cmh_poly_final(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_poly_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_poly_reqctx *rctx = ahash_request_ctx(req);
+	struct vcq_cmd cmds[CMH_POLY_MAX_PAYLOAD];
+	struct core_dispatch d;
+	s32 target_mbx;
+	u32 core_id;
+	u32 idx;
+	int ret;
+	gfp_t gfp;
+
+	if (!tctx->has_key) {
+		ret = -ENOKEY;
+		goto out_free_chunks;
+	}
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	/* Linearise chunks into a single contiguous buffer for DMA */
+	if (rctx->total_len > 0) {
+		struct cmh_poly_chunk *c;
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
+	rctx->tag_buf = kzalloc(POLY1305_DIGEST_SIZE, gfp);
+	if (!rctx->tag_buf) {
+		ret = -ENOMEM;
+		goto out_free_buf;
+	}
+
+	rctx->tag_dma = cmh_dma_map_single(rctx->tag_buf,
+					   POLY1305_DIGEST_SIZE,
+					    DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->tag_dma)) {
+		ret = -ENOMEM;
+		goto out_free_tag;
+	}
+
+	/* Map input data */
+	if (rctx->total_len > 0) {
+		rctx->in_dma = cmh_dma_map_single(rctx->buf, rctx->total_len,
+						  DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->in_dma)) {
+			ret = -ENOMEM;
+			goto out_unmap_tag;
+		}
+	}
+
+	/*
+	 * Key DMA handles are pre-mapped in setkey() and live in
+	 * the tfm context.  Use them directly for the VCQ writes.
+	 */
+
+	d = cmh_core_select_instance(CMH_CORE_CCP);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+	idx = 0;
+
+	/* Write s_key to SYS_REF_TEMP first (bottom of stack) */
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+			  (u64)tctx->skey_dma, SYS_REF_NONE,
+			  CCP_POLY_KEY_SIZE,
+			  SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_CCP));
+
+	/* Write r_key to SYS_REF_TEMP second (top of stack) */
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+			  (u64)tctx->rkey_dma, SYS_REF_NONE,
+			  CCP_POLY_KEY_SIZE,
+			  SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_CCP));
+
+	/* POLY1305_INIT: rkey=TEMP (top), skey=TEMP (next) */
+	vcq_add_ccp_poly_init(&cmds[idx++], core_id, SYS_REF_TEMP,
+			      CCP_POLY_KEY_SIZE, SYS_REF_TEMP,
+			      CCP_POLY_KEY_SIZE);
+
+	/* FINAL: data -> tag */
+	vcq_add_ccp_poly_final(&cmds[idx++], core_id,
+			       rctx->total_len > 0 ? (u64)rctx->in_dma : 0,
+			       (u64)rctx->tag_dma, rctx->total_len,
+			       POLY1305_DIGEST_SIZE);
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_POLY_MAX_PACKED, target_mbx,
+					    cmh_poly_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto out_unmap_in;
+
+	return -EINPROGRESS;
+
+out_unmap_in:
+	if (rctx->total_len > 0 && rctx->in_dma)
+		cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+				     DMA_TO_DEVICE);
+out_unmap_tag:
+	cmh_dma_unmap_single(rctx->tag_dma, POLY1305_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+out_free_tag:
+	kfree(rctx->tag_buf);
+out_free_buf:
+	kfree_sensitive(rctx->buf);
+	rctx->buf = NULL;
+out_free_chunks:
+	cmh_poly_free_chunks(rctx, tctx);
+	rctx->total_len = 0;
+	return ret;
+}
+
+static int cmh_poly_export(struct ahash_request *req, void *out)
+{
+	return -EOPNOTSUPP;
+}
+
+static int cmh_poly_import(struct ahash_request *req, const void *in)
+{
+	return -EOPNOTSUPP;
+}
+
+static int cmh_poly_finup(struct ahash_request *req)
+{
+	int err;
+
+	err = cmh_poly_update(req);
+	if (err)
+		return err;
+	return cmh_poly_final(req);
+}
+
+static int cmh_poly_digest(struct ahash_request *req)
+{
+	int err;
+
+	err = cmh_poly_init(req);
+	if (err)
+		return err;
+	return cmh_poly_finup(req);
+}
+
+static int cmh_poly_init_tfm(struct crypto_ahash *tfm)
+{
+	struct cmh_poly_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	spin_lock_init(&tctx->chunk_lock);
+	INIT_LIST_HEAD(&tctx->all_chunks);
+	crypto_ahash_set_reqsize(tfm, sizeof(struct cmh_poly_reqctx));
+	return 0;
+}
+
+static void cmh_poly_exit_tfm(struct crypto_ahash *tfm)
+{
+	struct cmh_poly_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_poly_chunk *c, *tmp;
+
+	/* Free any orphaned chunks (e.g. testmgr export/reimport poison) */
+	spin_lock_bh(&tctx->chunk_lock);
+	list_for_each_entry_safe(c, tmp, &tctx->all_chunks, tfm_node) {
+		list_del(&c->tfm_node);
+		kfree_sensitive(c);
+	}
+	spin_unlock_bh(&tctx->chunk_lock);
+
+	if (tctx->has_key) {
+		cmh_dma_unmap_single(tctx->rkey_dma, CCP_POLY_KEY_SIZE,
+				     DMA_TO_DEVICE);
+		cmh_dma_unmap_single(tctx->skey_dma, CCP_POLY_KEY_SIZE,
+				     DMA_TO_DEVICE);
+	}
+	memzero_explicit(tctx->key, POLY1305_KEY_SIZE);
+}
+
+static struct ahash_alg cmh_poly1305_alg = {
+	.init		= cmh_poly_init,
+	.update		= cmh_poly_update,
+	.final		= cmh_poly_final,
+	.finup		= cmh_poly_finup,
+	.digest		= cmh_poly_digest,
+	.export		= cmh_poly_export,
+	.import		= cmh_poly_import,
+	.setkey		= cmh_poly_setkey,
+	.init_tfm	= cmh_poly_init_tfm,
+	.exit_tfm	= cmh_poly_exit_tfm,
+	.halg		= {
+		.digestsize	= POLY1305_DIGEST_SIZE,
+		.statesize	= sizeof(struct cmh_poly_reqctx),
+		.base		= {
+			.cra_name	 = "poly1305",
+			.cra_driver_name = "cri-cmh-poly1305",
+			.cra_priority	 = 300,
+			.cra_flags	 = CRYPTO_ALG_KERN_DRIVER_ONLY |
+					   CRYPTO_ALG_NO_FALLBACK |
+					   CRYPTO_ALG_ASYNC |
+					   CRYPTO_ALG_REQ_VIRT,
+			.cra_blocksize	 = POLY1305_BLOCK_SIZE,
+			.cra_ctxsize	 = sizeof(struct cmh_poly_tfm_ctx),
+			.cra_module	 = THIS_MODULE,
+		},
+	},
+};
+
+/**
+ * cmh_ccp_poly_register() - Register Poly1305 hash algorithm with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_ccp_poly_register(void)
+{
+	int ret;
+
+	ret = crypto_register_ahash(&cmh_poly1305_alg);
+	if (ret)
+		dev_err(cmh_dev(), "cmh_ccp_poly: failed to register poly1305 (rc=%d)\n",
+			ret);
+	else
+		dev_dbg(cmh_dev(), "cmh_ccp_poly: registered poly1305\n");
+
+	return ret;
+}
+
+/**
+ * cmh_ccp_poly_unregister() - Unregister Poly1305 hash algorithm from the crypto framework
+ */
+void cmh_ccp_poly_unregister(void)
+{
+	crypto_unregister_ahash(&cmh_poly1305_alg);
+	dev_dbg(cmh_dev(), "cmh_ccp_poly: unregistered poly1305\n");
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 0a73964b9785..e5b2a86c3149 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -36,6 +36,7 @@
 #include "cmh_sm3.h"
 #include "cmh_aes.h"
 #include "cmh_sm4.h"
+#include "cmh_ccp.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -259,6 +260,21 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sm4_cmac_register;
 
+	/* Register CCP ChaCha20 skcipher algorithm */
+	ret = cmh_ccp_register();
+	if (ret)
+		goto err_ccp_register;
+
+	/* Register CCP ChaCha20-Poly1305 AEAD (RFC 7539) */
+	ret = cmh_ccp_aead_register();
+	if (ret)
+		goto err_ccp_aead_register;
+
+	/* Register CCP Poly1305 shash algorithm */
+	ret = cmh_ccp_poly_register();
+	if (ret)
+		goto err_ccp_poly_register;
+
 	/* Register key management device (/dev/cmh_mgmt) */
 	ret = cmh_mgmt_register();
 	if (ret)
@@ -271,6 +287,12 @@ static int cmh_probe(struct platform_device *pdev)
 	return 0;
 
 err_mgmt_register:
+	cmh_ccp_poly_unregister();
+err_ccp_poly_register:
+	cmh_ccp_aead_unregister();
+err_ccp_aead_register:
+	cmh_ccp_unregister();
+err_ccp_register:
 	cmh_sm4_cmac_unregister();
 err_sm4_cmac_register:
 	cmh_sm4_aead_unregister();
@@ -319,6 +341,9 @@ static void cmh_remove(struct platform_device *pdev)
 	cfg = &dev->config;
 
 	cmh_mgmt_unregister();
+	cmh_ccp_poly_unregister();
+	cmh_ccp_aead_unregister();
+	cmh_ccp_unregister();
 	cmh_sm4_cmac_unregister();
 	cmh_sm4_aead_unregister();
 	cmh_sm4_unregister();
diff --git a/drivers/crypto/cmh/include/cmh_ccp.h b/drivers/crypto/cmh/include/cmh_ccp.h
new file mode 100644
index 000000000000..363d208cbceb
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_ccp.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- CCP Crypto API Drivers
+ *
+ * Registers CCP algorithms with the Linux crypto subsystem:
+ *   skcipher: chacha20
+ *   shash:    poly1305
+ *   aead:     rfc7539(chacha20poly1305)
+ */
+
+#ifndef CMH_CCP_H
+#define CMH_CCP_H
+
+int  cmh_ccp_register(void);
+void cmh_ccp_unregister(void);
+
+int  cmh_ccp_aead_register(void);
+void cmh_ccp_aead_unregister(void);
+
+int  cmh_ccp_poly_register(void);
+void cmh_ccp_poly_unregister(void);
+
+#endif /* CMH_CCP_H */
-- 
2.43.7


