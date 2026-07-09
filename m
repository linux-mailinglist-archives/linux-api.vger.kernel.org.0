Return-Path: <linux-api+bounces-6814-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDdjGXEFUGr3rwIAu9opvQ
	(envelope-from <linux-api+bounces-6814-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:32:49 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A19E735627
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:32:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=YlvLhl2x;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6814-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6814-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C05B33050A28
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72A3D6CCD;
	Thu,  9 Jul 2026 20:31:38 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021115.outbound.protection.outlook.com [40.107.208.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E57B3CF042;
	Thu,  9 Jul 2026 20:31:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629097; cv=fail; b=Sn2ihkvz1WjGeE4rx+d3Q9vCXYqZPCtRx00g180kiHPAwhK42IcN1fzlmfLPeh4yLpI7LNmjggHPA0dfn/iGC8hlGgog47NJNYOmwYOD0fkMulNpORCgHEn+sw3JSbs4qDTW8osP/w6Bp6LHpGs7Ows7dK+/8R7jhi9mbpHxxN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629097; c=relaxed/simple;
	bh=SAcui6CIsut1/6vPxE8JuyCkE0LTR3/SP0Q0d0iYBFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5CmOIU/rdlcASM+ahEgUG8Vr37gS3i4jXISeG4Fl/bPXsMpf4g+NvtvxGR+M99NtZ4vfol2eXmcQmocXS61BSRewMwedq8EIwDLEQz9WFMen6r2SAGC1HncoJvKC59k2LSg9I95LRvIWRt0O77Qc7E/xo/NbfC9V6mPAfLNmWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=YlvLhl2x; arc=fail smtp.client-ip=40.107.208.115
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpR25NGOEr5fdoXKpxQd+4Ut54KBV7YAzG28Zi3vyPPXpC6UQppc4jtl63/iOb4xInIYNN3Gl+N9ejLsZII9xp/0C8tQWYrUm7bsP56uAcfXAJTLtBpGGOQx8+PNZ4jh4l83YYAv+YRGH84MZIbtFRiqHAX5D31tQVjPtoiFSKxIjoqC/S2zyQ+WiW9wlVE1leuiJI4wSXD3LFhSWQrtYnKA382wg46VT8X6evW5z+5Y5sJsa+B6D+Lj/HuqfYs17MYgyFWAk0cDzdoEQBCmNLS2VRGfHQv8LsP7iHbVH22K34qHbDnbolRdhpWUI/tNHqE0ZT4PdZkCDvd9WUh2FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByeLc5VUpJ2UFHqDjzh1lk+KODqdbPfPoAryXVjPJyc=;
 b=v3ZHd1WGfo+kZrofORccqpQ6TMUkkakPv2oXvpfYm+9dv8rlHy0HacEMlqrY/Mj4/5jg0HmghHeLqSnY/kW3Mom/XVpQEjysEq7wXYpeOMgqk2KxFWJZe3ldyOQo6Rlfe/JC1o971+dM8obkJM1zBvzsK7gpGP8uRpk+UIWNW1gvWLoGmzdOX2DgIQojm+9FCgYFp2na6q+h4mPDKnVfgW3nzanG6P9bnLBKckqKgQd5/+hXhD755Iww493aTqGYDmQDtf+uITv4717B7ZwwCsMpB3bMf6p67AG2n5zZYW5uS/yxK+S49NmXNVW5go+q7A/ba5/qu0mkRlDWfxv2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByeLc5VUpJ2UFHqDjzh1lk+KODqdbPfPoAryXVjPJyc=;
 b=YlvLhl2xlf5Hh/OLbrfuAwsmd65DKQHLUlkrycqoNQ1fiJdh4kGt3F2CiSadvBek8hj8IUYIN2oh455OYyYv8AlaGz+pkk0sNc2WJo+4/6rmmt7t+Ysy8O34XGm65ozdoeW1UYNJs6XipU9HDCKnWakito1JUW/W0mHPfP3QuFBGiomllhbphdntg7zO79cNOlF+utq0WSTy0tFB6oTrucPxVgaVrfuzuTCfW7pb3eDDUCTKPukU+qh7ykV+pu8rqKoiaQb8P8jitZZryU0CM09sW32XPWAwFcXZp0LxptNMiQXbn1FUM366F+anjogt4cL0HG4BA/mFl2QmKQ2Rmg==
Received: from LV3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::27)
 by SJ0PR04MB10223.namprd04.prod.outlook.com (2603:10b6:a03:3e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 20:31:23 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:234:cafe::7d) by LV3P220CA0026.outlook.office365.com
 (2603:10b6:408:234::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 20:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:22 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 18D6B1801762;
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
Subject: [PATCH v2 11/19] crypto: cmh - add DRBG hwrng
Date: Thu,  9 Jul 2026 13:30:29 -0700
Message-ID: <20260709203037.1884436-12-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|SJ0PR04MB10223:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b0c9c8cd-3248-4898-4ed9-08deddf90aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|23010399003|3023799007|11063799006|18002099003|56012099006|6133799003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	Z5MZsJMXbmXLLQt0vBknxu2zIJc6gPFaMQIPISgfuyvL3ng8mkUJM/8IE9ij57jC5cFh8KLV3xb8n+fsT6FLHj3SlQFAicsgPjxn+tb9D6URwFah8zkdI5RclwdOPQXzkOKSakWlvlf0U1cumQwSjW4JL28S5KOmK4dV0ILc4osDKIwDyDQXciqrh+yhI0sdXVKHUwjHur6eYsicJsjIUWFyHd/80IAb4wJWl49eoCVxOmc3YH+YjrUguyHIfTy9MMW2WYei50G2dmj0b5Hx6cd3ptqhIGBXojp3xSp6soBRr+XXRmVKhwM+NSVuuf9j3THTqk0TwRHL4kPvsaPfDN1ckeOANXBOFPR14Fbodj7VUd6/AktqDowSadntjpSbYLaiFuzGVt4VFPAb5b//rOZno8kdkQHvZ+ogbXqJPaQMeewaPXm0DO/ZZbDn6HAi8HQQ7G3vyNZlA7zAYBJsa8oOFq50vOOgVdijS4zOHUvUvR5JUb0cl+6t5tMPJEGeVA0+0zt4DGHqz6FIoK3JXbFPRpmG53p9oarcT39oidIWkaCETk2yvpx+UVQQSmjdFVtSgPmC1Sybtva4jsDlHJPMuhq40kWd+odWtFYAy+5XRCkeJ6CRP41+nZvrZ8QvPJBK00lUtdrNHnKXXhhI6g7BLWWLtBFJQFx45rs3APjqHPW76EQOtr/rwgs7dmnHCWwxAFcabG6R+OJz5QZ1VpRpDdIckl5x7c6B3VVQzCWGMTRKl75nxM05ymS/yrSu
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(23010399003)(3023799007)(11063799006)(18002099003)(56012099006)(6133799003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EzGMuESpdKy+3ysx+Bz2eAeQlsS4Q6JHrU6L0j1/oWyBVfHDBaloP0a6w0+pElYuGQcJYb7Xlp9Xv93kA7aPXgvyTxXflRHyzWZAU52KWmGT8Z8kDCMkGv37mpivANgI6k2KnkYns2T2Ar852zRu5lBK3KSfADrkKkVOfZq8yY2U0AqN8AmZ54VQaI/OioeWNV4E5wOhm5j6p/Z38HHPjWmgIH+HJ4mvMnoBzSwYsrY4X+V7s9cSKApwL+q7cmwzzAnoL67fE2g8icWcmpO+uHU+TE52PAWHUbxAf3OA3Li7fXWS2po/jjVQqqi33s7nVh3fQcWaRi9JFdByH23vEBFTLo4w9I02e0JlfsD8H/9IsfTML5/gb4w6J3naLG6NI6clwYnCq/B3TDafCY9Kl3Lcr3j61Ok3yURAf16pSGm9KFE62pCnnJf5sbvtg3fn
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:22.9004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c9c8cd-3248-4898-4ed9-08deddf90aca
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB10223
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
	TAGGED_FROM(0.00)[bounces-6814-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 0A19E735627

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register the CMH DRBG core (core ID 0x0f) as an hwrng provider.
The hardware implements a NIST SP 800-90A compliant DRBG with
automatic self-seeding.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile   |   3 +-
 drivers/crypto/cmh/cmh_main.c |   9 +
 drivers/crypto/cmh/cmh_rng.c  | 316 ++++++++++++++++++++++++++++++++++
 3 files changed, 327 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_rng.c

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 4ebd0e1d10bc..1c4cb817424c 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -28,7 +28,8 @@ cmh-y := \
 	cmh_sm4_cmac.o \
 	cmh_ccp.o \
 	cmh_ccp_aead.o \
-	cmh_ccp_poly.o
+	cmh_ccp_poly.o \
+	cmh_rng.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index e5b2a86c3149..40440e2b73b4 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -34,6 +34,7 @@
 #include "cmh_cshake.h"
 #include "cmh_kmac.h"
 #include "cmh_sm3.h"
+#include "cmh_rng.h"
 #include "cmh_aes.h"
 #include "cmh_sm4.h"
 #include "cmh_ccp.h"
@@ -230,6 +231,11 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sm3_register;
 
+	/* Register hwrng backed by DRBG core */
+	ret = cmh_rng_register(pdev);
+	if (ret)
+		goto err_rng_register;
+
 	/* Register AES skcipher algorithms */
 	ret = cmh_aes_register();
 	if (ret)
@@ -305,6 +311,8 @@ static int cmh_probe(struct platform_device *pdev)
 err_aes_aead_register:
 	cmh_aes_unregister();
 err_aes_register:
+	cmh_rng_unregister();
+err_rng_register:
 	cmh_sm3_unregister();
 err_sm3_register:
 	cmh_kmac_unregister();
@@ -350,6 +358,7 @@ static void cmh_remove(struct platform_device *pdev)
 	cmh_aes_cmac_unregister();
 	cmh_aes_aead_unregister();
 	cmh_aes_unregister();
+	cmh_rng_unregister();
 	cmh_sm3_unregister();
 	cmh_kmac_unregister();
 	cmh_cshake_unregister();
diff --git a/drivers/crypto/cmh/cmh_rng.c b/drivers/crypto/cmh/cmh_rng.c
new file mode 100644
index 000000000000..c9693f6cc360
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_rng.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Hardware RNG (DRBG) Driver
+ *
+ * Implements a Linux hwrng backed by the CMH DRBG core.  Each .read()
+ * builds a 3-entry VCQ (header + GENERATE + FLUSH) and submits it
+ * synchronously through the Transaction Manager.
+ *
+ * DRBG configuration (CONFIG) is a management-host operation in the
+ * CMH security model.  The driver's behaviour is controlled by the
+ * drbg_config setting (debug-only module parameter):
+ *
+ *   "auto" (default) -- attempt CONFIG at probe with the hardcoded
+ *     ratio/strength defaults.  Succeeds in stateless mode (any host may
+ *     CONFIG) or when this host is the management host in stateful
+ *     mode.  On -EPERM the driver logs a notice and continues --
+ *     GENERATE will work once the management host configures the DRBG.
+ *
+ *   "skip" -- do not issue CONFIG; assume an external management host
+ *     will configure the DRBG.  hwrng is still registered; .read()
+ *     returns -EAGAIN until GENERATE succeeds.
+ *
+ * The management host (or any privileged user-space process) can also
+ * reconfigure the DRBG at runtime via CMH_IOCTL_DRBG_CONFIG.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/hw_random.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+
+#include "cmh_rng.h"
+#include "cmh_vcq.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_sys.h"
+#include "cmh_config.h"
+
+/* VCQ layout for .read(): header + GENERATE + FLUSH = 3 entries. */
+#define DRBG_READ_VCQ_CMDS	3
+
+/* VCQ layout for CONFIG: header + RESET + CONFIG + FLUSH = 4 entries. */
+#define DRBG_CONFIG_VCQ_CMDS	4
+
+/*
+ * Linux hwrng quality is expressed in bits of entropy per 1024 bits of
+ * input.  The kernel clamps to this maximum; mirror it here so our
+ * MODULE_PARM_DESC and clamp logic stay in sync.
+ */
+#define CMH_HWRNG_QUALITY_MAX	1024
+
+/* Module parameters */
+
+static int hwrng_quality;
+module_param(hwrng_quality, int, 0444);
+MODULE_PARM_DESC(hwrng_quality,
+		 "hwrng quality (0=no CRNG seeding, 1-1024=enable; default: 0)");
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+static char *drbg_config = "auto";
+module_param(drbg_config, charp, 0444);
+MODULE_PARM_DESC(drbg_config,
+		 "[debug] DRBG config at probe: \"auto\"=attempt CONFIG, \"skip\"=assume external (default: auto)");
+#else
+static const char *drbg_config = "auto";
+#endif
+
+/*
+ * DRBG parameters -- hardcoded to production defaults.
+ * Entropy ratio 0 = 1:1 (full entropy), security strength 0x10 = 256-bit.
+ */
+#define CMH_DRBG_ENTROPY_RATIO		0
+#define CMH_DRBG_SECURITY_STRENGTH	0x10
+
+static unsigned int drbg_timeout_ms = 500;
+
+/* VCQ Builders */
+
+static void vcq_add_drbg_generate(struct vcq_cmd *slot, u64 dst_phys, u32 len)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(CORE_ID_DRBG, 0, 1, DRBG_CMD_GENERATE);
+	slot->hwc.drbg.cmd_generate.dst = dst_phys;
+	slot->hwc.drbg.cmd_generate.len = len;
+}
+
+/*
+ * Maximum bytes per DRBG GENERATE request.  The kernel calls .read()
+ * repeatedly to fill larger requests, so capping here is safe.
+ * 32 bytes matches the 256-bit security strength natural output size.
+ */
+#define CMH_DRBG_MAX_GENERATE	32U
+
+/* hwrng .read() callback */
+
+static int cmh_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
+{
+	struct cmh_dma_orphan *orphan;
+	struct vcq_cmd vcq[DRBG_READ_VCQ_CMDS];
+	dma_addr_t dma_addr;
+	void *dmabuf;
+	size_t nbytes;
+	int ret;
+
+	if (max == 0)
+		return 0;
+
+	/*
+	 * Our path uses GFP_KERNEL allocations and synchronous VCQ
+	 * submission -- both may sleep.  When the caller indicates
+	 * non-blocking context (!wait), return 0 ("no data yet") so
+	 * the hwrng core retries later.
+	 */
+	if (!wait)
+		return 0;
+
+	nbytes = min_t(size_t, max, CMH_DRBG_MAX_GENERATE);
+
+	orphan = kmalloc_obj(*orphan, GFP_KERNEL);
+	if (!orphan)
+		return -ENOMEM;
+
+	dmabuf = kmalloc(nbytes, GFP_KERNEL);
+	if (!dmabuf) {
+		kfree(orphan);
+		return -ENOMEM;
+	}
+
+	dma_addr = cmh_dma_map_single(dmabuf, nbytes, DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(dma_addr)) {
+		kfree(dmabuf);
+		kfree(orphan);
+		return -ENOMEM;
+	}
+
+	orphan->buf  = dmabuf;
+	orphan->addr = dma_addr;
+	orphan->len  = nbytes;
+	orphan->dir  = DMA_FROM_DEVICE;
+
+	vcq_set_header(&vcq[0], DRBG_READ_VCQ_CMDS);
+	vcq_add_drbg_generate(&vcq[1], dma_addr, nbytes);
+	vcq_add_flush(&vcq[2], CORE_ID_DRBG);
+
+	/*
+	 * Use the noabort variant: if the MBX is occupied by a slow
+	 * operation (e.g. SLH-DSA sign at 120 s), we must not issue
+	 * MBX_COMMAND_ABORT -- that would kill the unrelated in-flight
+	 * VCQ.  On timeout with an in-flight VCQ (-EINPROGRESS), the
+	 * orphan callback defers DMA cleanup until the RH fires.
+	 */
+	ret = cmh_tm_submit_sync_noabort(vcq, DRBG_READ_VCQ_CMDS, 1,
+					 msecs_to_jiffies(drbg_timeout_ms),
+					 cmh_dma_orphan_free, orphan);
+	if (ret == -EINPROGRESS) {
+		/* Orphan callback owns dmabuf -- will free on VCQ completion */
+		return -EAGAIN;
+	}
+
+	/* Normal path or cancelled-from-queue: caller owns DMA */
+	cmh_dma_unmap_single(dma_addr, nbytes, DMA_FROM_DEVICE);
+	kfree(orphan);
+
+	if (ret) {
+		/*
+		 * Only translate known transient conditions to -EAGAIN
+		 * so the hwrng subsystem retries later.  Propagate
+		 * unexpected failures unchanged to avoid masking real
+		 * faults and causing indefinite retry loops.
+		 */
+		switch (ret) {
+		case -EAGAIN:
+		case -EBUSY:
+		case -ETIMEDOUT:
+		case -EIO:
+		/*
+		 * -ENODEV: the TM is not running -- occurs when the
+		 * hwrng kthread (PF_NOFREEZE, not frozen during
+		 * suspend) calls .read() while the device is suspended.
+		 * Treat as transient: the TM restarts on resume.
+		 */
+		case -ENODEV:
+			dev_dbg_ratelimited(cmh_dev(),
+					    "rng: transient DRBG failure (rc=%d)\n",
+					    ret);
+			kfree(dmabuf);
+			return -EAGAIN;
+		default:
+			dev_err_ratelimited(cmh_dev(),
+					    "rng: DRBG generate failed (rc=%d)\n",
+					    ret);
+			kfree(dmabuf);
+			return ret;
+		}
+	}
+
+	memcpy(data, dmabuf, nbytes);
+	kfree(dmabuf);
+
+	return nbytes;
+}
+
+/* Registration */
+
+static bool cmh_rng_registered;
+
+static struct hwrng cmh_hwrng = {
+	.name = "cri-cmh-drbg",
+	.read = cmh_rng_read,
+};
+
+/**
+ * cmh_rng_register() - Register the CMH hardware RNG device
+ * @pdev: Platform device for the CMH accelerator
+ *
+ * Reads hwrng quality from device tree and module parameters, validates
+ * DRBG configuration, optionally sends a DRBG CONFIG VCQ to firmware,
+ * and registers the hwrng device with the kernel hwrng framework.
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_rng_register(struct platform_device *pdev)
+{
+	int ret;
+
+	cmh_hwrng.quality = hwrng_quality;
+
+	if (cmh_hwrng.quality > CMH_HWRNG_QUALITY_MAX)
+		cmh_hwrng.quality = CMH_HWRNG_QUALITY_MAX;
+
+	/*
+	 * DRBG CONFIG is a management-host operation.  In "auto" mode,
+	 * attempt it -- this succeeds in stateless mode (any host) or
+	 * when we are the management host in stateful mode.  On -EPERM
+	 * (not management host) we continue without error -- GENERATE
+	 * will work once the management host configures the DRBG.
+	 *
+	 * In "skip" mode, do not issue CONFIG -- assume the management
+	 * host has already configured (or will configure) the DRBG.
+	 */
+	if (strcmp(drbg_config, "skip") != 0) {
+		struct vcq_cmd cfg_vcq[DRBG_CONFIG_VCQ_CMDS];
+
+		if (strcmp(drbg_config, "auto") != 0)
+			dev_warn(&pdev->dev,
+				 "rng: unrecognized drbg_config=\"%s\", treating as \"auto\"\n",
+				 drbg_config);
+
+		vcq_set_header(&cfg_vcq[0], DRBG_CONFIG_VCQ_CMDS);
+		vcq_add_drbg_reset(&cfg_vcq[1]);
+		vcq_add_drbg_config(&cfg_vcq[2], CMH_DRBG_ENTROPY_RATIO,
+				    CMH_DRBG_SECURITY_STRENGTH);
+		vcq_add_flush(&cfg_vcq[3], CORE_ID_DRBG);
+		ret = cmh_tm_submit_sync(cfg_vcq, DRBG_CONFIG_VCQ_CMDS, 1);
+		if (ret == -EPERM)
+			dev_notice(&pdev->dev,
+				   "rng: DRBG config not permitted (not management host); assuming external configuration\n");
+		else if (ret)
+			dev_warn(&pdev->dev,
+				 "rng: DRBG config failed (rc=%d)\n", ret);
+		else
+			dev_info(&pdev->dev,
+				 "rng: DRBG configured (ratio=%u strength=0x%02x)\n",
+				 CMH_DRBG_ENTROPY_RATIO,
+				 CMH_DRBG_SECURITY_STRENGTH);
+	} else {
+		dev_info(&pdev->dev,
+			 "rng: DRBG config skipped (drbg_config=skip); assuming external configuration\n");
+	}
+
+	ret = hwrng_register(&cmh_hwrng);
+	if (ret) {
+		dev_err(&pdev->dev, "rng: hwrng_register failed (rc=%d)\n",
+			ret);
+		return ret;
+	}
+
+	dev_info(&pdev->dev,
+		 "rng: registered cri-cmh-drbg (quality=%d timeout=%ums)\n",
+		 cmh_hwrng.quality, drbg_timeout_ms);
+
+	cmh_rng_registered = true;
+	return 0;
+}
+
+/**
+ * cmh_rng_unregister() - Unregister the CMH hardware RNG device
+ *
+ * Unregisters the hwrng device from the kernel hwrng framework if it
+ * was previously registered.
+ */
+void cmh_rng_unregister(void)
+{
+	if (!cmh_rng_registered)
+		return;
+	hwrng_unregister(&cmh_hwrng);
+	cmh_rng_registered = false;
+	dev_info(cmh_dev(), "rng: unregistered cri-cmh-drbg\n");
+}
+
+/* -- debugfs timeout accessor ------------------------------------------ */
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+/**
+ * cmh_rng_timeout_drbg_ptr() - Return pointer to drbg_timeout_ms for debugfs
+ *
+ * Exposes the DRBG operation timeout for runtime tuning via debugfs
+ * config/ directory.
+ *
+ * Return: pointer to the static drbg_timeout_ms variable.
+ */
+unsigned int *cmh_rng_timeout_drbg_ptr(void) { return &drbg_timeout_ms; }
+#endif
-- 
2.43.7


