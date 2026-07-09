Return-Path: <linux-api+bounces-6821-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m82BF0EGUGpPsAIAu9opvQ
	(envelope-from <linux-api+bounces-6821-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:36:17 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD397735730
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:36:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=RL0OUzt+;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6821-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6821-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61AC83080BC6
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2B3D567F;
	Thu,  9 Jul 2026 20:31:43 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022132.outbound.protection.outlook.com [40.107.209.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA93D171F;
	Thu,  9 Jul 2026 20:31:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629102; cv=fail; b=Uve2i0Ghm7Dhye18j0otMPo6tPRSIsFEg3awPniDWJHwQYrnbdJ/DLIFVPjNPxM25NQN71z2LY10+qzKmx/r80k7ioTtWScLi7HrzZaJdAp3AJ6dO6FmsatuuOAqJ9iTNBehv/WDQYSp0eC/nseZ9wCsjGvJs40E3nBwVJwc3MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629102; c=relaxed/simple;
	bh=qSMAGo0Kc2mfQu987TyMomvUjEGRk6t5HadOdCYfE1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5c1BB3YevrOHe6Xaysxft9LlQDPzBVcqbW3WsAX+53+WBYsNE2/mH+TfSViEWBIvY2yXGTGIlLVpOaDhI6SdHnyoVKOmGna3RWZUq51jXnPbjdKyUhcV//AdHPn+Qgg7Nn8g5ti58SJnoUs0hR4Na6g51RvFQhSt8TYdpd+vGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=RL0OUzt+; arc=fail smtp.client-ip=40.107.209.132
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuU6lDwdjvsBsrcyLFs7bz5ku1W5LiLHGS9ljxzpj/wOEDFeiEu4/57/KIHnY3OaVzrA6cz3hhENSjPuSzwok6waeJaHv1BIce+8RQLlXeyvYg6gB/u2JJqSmeXzJW/EeN574ZdLVmV1reWmAkHqquwyyEcfRc7EemLGVpAcTkBY2PP0oB7DoIvw9jxzZ2rsSsQtxWiwiLSO8q0ABv9VBM/78QzpSt8T+MWOMQVLBP2nICH/8To7Mhlg3h9aAmiyP3qVftgviKZz4ipx1TuMEor5Y6oypdT/nu/Uud/ll1HtCKzcxhtoctfjRSCfVpwNH6BEthugqZefnLIhtdqaHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xUHz9501SGIPAG1PPUKdf1Qyb0MiZLMkl+JMiruACk=;
 b=MgmS8w5NuaP/mkN3t6eGlezU3Bhro3jFqWhimYuvdTm7i259rGpgfmY0lGqNvXO7gjvL9UWRGQhj2JJywSiEYQR/LNaJmBG3O4eXet57Yu5ns7KMqnEN6SmBPNKCxIZGGwS1UhjSPTiwh6V1CPDMHa/AW88e4f6L94vK8tmwoyceXhQCsYMpGjVqPKv5I48XkVAzRpHKe5+btbgAphsqFbA4hc4/L/RqUGo+qtqQUBuOR1IoiANeIVkXMOPeFk+0edE/xzcNfTJVEQkFLkej0IEw4+hreLYFWMXYWDRSumB3MxFtU3s+YQM3hWNDTN36N1POLEepP+RW8kdXC+N52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xUHz9501SGIPAG1PPUKdf1Qyb0MiZLMkl+JMiruACk=;
 b=RL0OUzt+qfNjWaN7sY2NC376QKGb5X1Y8ctOvg1OyP5FA7EadgJREq6u2tdAiX7j6Rg/AqDPCv06VYpQWd9sSm03J30Oj+489OJilnxZO2dOMY3IC/RkAhg1pnapmozkgLgdtcsl5PsQeQgnIG4ook38XYpc2PVdM0+tIGKeXQYGIdR9XjMd5YqVQFnFfKAL5swJw8xeoZwDxxUMwKdYqjb/ChUd0hQFTUNd6HrGyZ98YHTd5rJRkWET5GbYaiqbpjiUseqs+yoH4gtRIpL2M+CPeaOhCKrexrPuUZBHgbEfxnEMp+VEm/usbQ2QawJQFYI7+UFbT2SW/Qyys9honw==
Received: from BN9PR03CA0258.namprd03.prod.outlook.com (2603:10b6:408:ff::23)
 by SN7PR04MB8720.namprd04.prod.outlook.com (2603:10b6:806:2e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:31:23 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::34) by BN9PR03CA0258.outlook.office365.com
 (2603:10b6:408:ff::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 20:31:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:22 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id D7EFE1801757;
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
Subject: [PATCH v2 07/19] crypto: cmh - add SM3 ahash
Date: Thu,  9 Jul 2026 13:30:25 -0700
Message-ID: <20260709203037.1884436-8-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|SN7PR04MB8720:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 545a262d-f875-432f-602f-08deddf90aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|36860700016|82310400026|1800799024|56012099006|921020|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	6D0yKkzBkoaqnuNYwJ8ffhgml1LagTVmCND6WOhArTDLr59ZtNNtiWLxm0DCdzLh+zOLR5Y//v1C21aqH+nfLetUZuhG0u7IkWSXlszhJFdbWALuzvR2kYvX+40r8CvEjCs5HY13dN7sgC1dcnmYDqhowy16wi2/axquryo0WVylu758758nKkpE6dIYg4wQF/wxpeku3DU/xU/qv07hmgbxww0IQvbb1l0Re5WYyxoufynTXrf1SUUUNug6SLtUJvGd0Jp7SAP+ujXspsVJPNVMeZMfc5aUTCIK8qoDsdP6ttPi3z/kmB97/LLzGjzx/4RfbLOMPjo5EPLxURlgEtuab4V11wG7IUmkFDrlv1JyPUWtDVoYwj7qw9ZT+HYY+twdA9YV+0Vu/6OMXGWDG67ZiaT1mUOZYZpJmpV14fKRWbWsLRJyXGgRHsw996EG6Cbd1NHFLKDHOHewDiSFrxQeNOmvnWmfujUn+ZDpYFDgxUez4hERJtouadXenKtdFe+0fNxawwtkth+y3G+/BvcOTxBHsa0NhWdtl+Y3p2eCjh2w7gn4eq1i5rlWiViozY7SLJTNpT8YOzEBgiLZ3EnhtgQgFNgab+f3MBro6Iu+7qeJb3990/G9ch6K68QTxxZxGnlNvWAebXBCZ/3EzCMHiDy6WW/pnrSR08JoF1B1ISuaFdqFQIxw9cCg+SetOJ5uur5YnzQBCskwjldN7x278pCH+qw/8r1YErpyZA2nINNvDKOyKHMFLXF8bAuu
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(921020)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U3d4LiLZV9+YmUl6mPHN6DAEjOVa55oiZoqNCFwPAAqK9mwqL3nlXFO8qfkLXytoP0mLhmLqcmrC3fJR8F4fvd8/1gwS8R4AuAA/zUi+aGiOUq6RKiNbYwMN9wc4Cx/LQo44ljeanjHKex/DMYVqaeS3zsvS50kcfZTlms7UNE/qFvdpobaTqgdwj7C0jdUQrczvNu839lhTMPQrP5/ZyCm8jXu0RbENc7HsCHI1oZIUmWKapUuEr8UNQXf4qYALaAf2tudVsATKQcO4D0vk6cvvEhH4tPqrlNcxCqpjvUSg+EW64ZRYX7KU1QVge10Aw71Zllk3kKXtY9+uZkZMOnX09PCdXDvOHS1Sz5sNyJJXTY3+JUrhaUBx0UF1XakL4fhHmdjFRqYki01ZMMPTLunAV56sj8Z1nOx/evkGE2kEKHZFSCV/33gTmnrldQqu
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:22.5922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 545a262d-f875-432f-602f-08deddf90aa3
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8720
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6821-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim,cryptography.com:email,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD397735730

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register the SM3 ahash algorithm using the CMH SM3 core (core ID
0x05).  Supports incremental update/finup/final and export/import.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile          |   3 +-
 drivers/crypto/cmh/cmh_main.c        |   9 +
 drivers/crypto/cmh/cmh_sm3.c         | 651 +++++++++++++++++++++++++++
 drivers/crypto/cmh/include/cmh_sm3.h |  27 ++
 4 files changed, 689 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_sm3.c
 create mode 100644 drivers/crypto/cmh/include/cmh_sm3.h

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 2bb240b97f31..b3018fbcf211 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -18,7 +18,8 @@ cmh-y := \
 	cmh_hash.o \
 	cmh_hmac.o \
 	cmh_cshake.o \
-	cmh_kmac.o
+	cmh_kmac.o \
+	cmh_sm3.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 08d14aae912d..bc326a9d7626 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -33,6 +33,7 @@
 #include "cmh_hmac.h"
 #include "cmh_cshake.h"
 #include "cmh_kmac.h"
+#include "cmh_sm3.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -221,6 +222,11 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_kmac_register;
 
+	/* Register SM3 hash algorithm */
+	ret = cmh_sm3_register();
+	if (ret)
+		goto err_sm3_register;
+
 	/* Register key management device (/dev/cmh_mgmt) */
 	ret = cmh_mgmt_register();
 	if (ret)
@@ -233,6 +239,8 @@ static int cmh_probe(struct platform_device *pdev)
 	return 0;
 
 err_mgmt_register:
+	cmh_sm3_unregister();
+err_sm3_register:
 	cmh_kmac_unregister();
 err_kmac_register:
 	cmh_cshake_unregister();
@@ -267,6 +275,7 @@ static void cmh_remove(struct platform_device *pdev)
 	cfg = &dev->config;
 
 	cmh_mgmt_unregister();
+	cmh_sm3_unregister();
 	cmh_kmac_unregister();
 	cmh_cshake_unregister();
 	cmh_hmac_unregister();
diff --git a/drivers/crypto/cmh/cmh_sm3.c b/drivers/crypto/cmh/cmh_sm3.c
new file mode 100644
index 000000000000..156f93da70af
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_sm3.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SM3 Hash Driver (CORE_ID_SM3)
+ *
+ * Registers an asynchronous hash (ahash) algorithm for SM3
+ * (GB/T 32905-2016) using the CMH SM3 core.  This is a standalone
+ * driver separate from cmh_hash.c (which handles HC-based SHA-2/3/SHAKE)
+ * because SM3 runs on a different hardware core with its own command
+ * IDs and context layout.
+ *
+ * Incremental HW update model (same pattern as cmh_hash.c):
+ *
+ *   .init()   -> software-only: zero per-request context
+ *   .update() -> buffer data in holdback; when >= block_size bytes:
+ *                SM3_CMD_INIT [+ RESTORE] + UPDATE + SAVE + FLUSH
+ *                -> return -EINPROGRESS  (else return 0)
+ *   .final()  -> SM3_CMD_INIT [+ RESTORE] [+ UPDATE] + FINAL + FLUSH
+ *   .finup()  -> linearise holdback + new data, then final path
+ *   .digest() -> INIT + UPDATE + FINAL + FLUSH (single-shot, zero-copy)
+ *   .export() -> software-only: copy checkpoint + holdback to out
+ *   .import() -> software-only: restore checkpoint + holdback from in
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/hash.h>
+#include <crypto/scatterwalk.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_sm3.h"
+#include "cmh_vcq.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+
+/* Per-Request State */
+
+/*
+ * Exported SM3 state -- serialised by .export(), deserialised by
+ * .import().  This is what statesize advertises to the crypto subsystem.
+ */
+struct cmh_sm3_export_state {
+	u8  checkpoint[SM3_CONTEXT_SIZE]; /* SM3 context from last SAVE */
+	u8  buf[CMH_SM3_BLOCK_SIZE];     /* holdback buffer */
+	u32 buf_len;                      /* valid bytes in buf[] */
+	u32 hw_started;                   /* non-zero if checkpoint valid */
+};
+
+#define CMH_SM3_MAX_PAYLOAD    5   /* INIT + RESTORE + UPDATE + FINAL/SAVE + FLUSH */
+#define CMH_SM3_MAX_PACKED     (CMH_SM3_MAX_PAYLOAD * 2)
+
+/*
+ * Checkpoint embedded inline: the kernel ahash API has no per-request
+ * destructor, so a heap-allocated checkpoint leaks if a request is
+ * abandoned without .final().
+ */
+struct cmh_sm3_reqctx {
+	int    error;
+	u32    hw_started;
+	u32    buf_len;
+	u32    has_checkpoint;
+	u8     checkpoint[SM3_CONTEXT_SIZE]; /* SM3 context from last SAVE */
+	/* DMA state for current async operation */
+	dma_addr_t ckpt_dma;
+	dma_addr_t save_dma;
+	dma_addr_t data_dma;
+	dma_addr_t digest_dma;
+	u8    *save_buf;
+	u8    *data_buf;
+	u32    data_len;
+	u8    *digest_buf;
+	u8     buf[CMH_SM3_BLOCK_SIZE]; /* holdback for partial block */
+	struct vcq_cmd packed[CMH_SM3_MAX_PACKED];
+};
+
+/* VCQ Builders -- SM3 core (CORE_ID_SM3); generic flush from cmh_vcq.h */
+
+static void vcq_add_sm3_init(struct vcq_cmd *slot, u32 core_id)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM3_CMD_INIT);
+	/* SM3 has a single algorithm -- no algo selector field */
+}
+
+static void vcq_add_sm3_update(struct vcq_cmd *slot, u32 core_id, u64 input_phys, u32 len)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM3_CMD_UPDATE);
+	slot->hwc.sm3.cmd_update.input = input_phys;
+	slot->hwc.sm3.cmd_update.inlen = len;
+}
+
+static void vcq_add_sm3_final(struct vcq_cmd *slot, u32 core_id, u64 digest_phys, u32 outlen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM3_CMD_FINAL);
+	slot->hwc.sm3.cmd_final.digest = digest_phys;
+	slot->hwc.sm3.cmd_final.outlen = outlen;
+}
+
+static void vcq_add_sm3_save(struct vcq_cmd *slot, u32 core_id, u64 output_phys, u32 outlen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM3_CMD_SAVE);
+	slot->hwc.sm3.cmd_save.output = output_phys;
+	slot->hwc.sm3.cmd_save.outlen = outlen;
+}
+
+static void vcq_add_sm3_restore(struct vcq_cmd *slot, u32 core_id, u64 input_phys, u32 inlen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM3_CMD_RESTORE);
+	slot->hwc.sm3.cmd_restore.input = input_phys;
+	slot->hwc.sm3.cmd_restore.inlen = inlen;
+}
+
+/* Request Context Cleanup */
+
+static void cmh_sm3_free_reqctx(struct cmh_sm3_reqctx *rctx)
+{
+	rctx->has_checkpoint = 0;
+}
+
+/* VCQ Packing + Submit */
+
+/* ahash Operations */
+
+static int cmh_sm3_init(struct ahash_request *req)
+{
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+
+	memset(rctx, 0, sizeof(*rctx));
+	return 0;
+}
+
+/*
+ * Update completion -- takes ownership of save_buf as new checkpoint.
+ */
+static void cmh_sm3_update_complete(void *data, int error)
+{
+	struct ahash_request *req = data;
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (rctx->has_checkpoint)
+		cmh_dma_unmap_single(rctx->ckpt_dma, SM3_CONTEXT_SIZE,
+				     DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->save_dma, SM3_CONTEXT_SIZE,
+			     DMA_FROM_DEVICE);
+	cmh_dma_unmap_single(rctx->data_dma, rctx->data_len,
+			     DMA_TO_DEVICE);
+
+	if (!error) {
+		memcpy(rctx->checkpoint, rctx->save_buf, SM3_CONTEXT_SIZE);
+		rctx->has_checkpoint = 1;
+		kfree(rctx->save_buf);
+		rctx->save_buf = NULL;
+		rctx->hw_started = 1;
+	} else {
+		kfree(rctx->save_buf);
+		rctx->save_buf = NULL;
+		rctx->error = error;
+	}
+
+	kfree(rctx->data_buf);
+	rctx->data_buf = NULL;
+	rctx->data_len = 0;
+
+	cmh_complete(&req->base, error);
+}
+
+static int cmh_sm3_update(struct ahash_request *req)
+{
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+	struct vcq_cmd cmds[CMH_SM3_MAX_PAYLOAD];
+	struct core_dispatch d;
+	u32 total_avail, full_len, tail_len, from_src;
+	u32 idx;
+	int ret;
+	gfp_t gfp;
+
+	if (rctx->error)
+		return rctx->error;
+
+	if (!req->nbytes)
+		return 0;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	total_avail = rctx->buf_len + req->nbytes;
+
+	if (total_avail < CMH_SM3_BLOCK_SIZE) {
+		if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+			memcpy(rctx->buf + rctx->buf_len,
+			       req->svirt, req->nbytes);
+		else
+			scatterwalk_map_and_copy(rctx->buf + rctx->buf_len,
+						 req->src, 0,
+						 req->nbytes, 0);
+		rctx->buf_len = total_avail;
+		return 0;
+	}
+
+	full_len = total_avail - total_avail % CMH_SM3_BLOCK_SIZE;
+	tail_len = total_avail - full_len;
+	from_src = full_len - rctx->buf_len;
+
+	rctx->data_buf = kmalloc(full_len, gfp);
+	if (!rctx->data_buf)
+		return -ENOMEM;
+
+	if (rctx->buf_len > 0)
+		memcpy(rctx->data_buf, rctx->buf, rctx->buf_len);
+
+	if (from_src > 0) {
+		if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+			memcpy(rctx->data_buf + rctx->buf_len,
+			       req->svirt, from_src);
+		else
+			scatterwalk_map_and_copy(rctx->data_buf + rctx->buf_len,
+						 req->src, 0,
+						 from_src, 0);
+	}
+
+	if (tail_len > 0) {
+		if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+			memcpy(rctx->buf, req->svirt + from_src,
+			       tail_len);
+		else
+			scatterwalk_map_and_copy(rctx->buf, req->src,
+						 from_src, tail_len,
+						 0);
+	}
+	rctx->buf_len = tail_len;
+	rctx->data_len = full_len;
+
+	rctx->save_buf = kzalloc(SM3_CONTEXT_SIZE, gfp);
+	if (!rctx->save_buf) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	rctx->data_dma = cmh_dma_map_single(rctx->data_buf, full_len,
+					    DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->data_dma)) {
+		ret = -ENOMEM;
+		goto err_free;
+	}
+
+	rctx->save_dma = cmh_dma_map_single(rctx->save_buf, SM3_CONTEXT_SIZE,
+					    DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->save_dma)) {
+		ret = -ENOMEM;
+		goto err_unmap_data;
+	}
+
+	rctx->ckpt_dma = DMA_MAPPING_ERROR;
+	if (rctx->has_checkpoint) {
+		rctx->ckpt_dma = cmh_dma_map_single(rctx->checkpoint,
+						    SM3_CONTEXT_SIZE,
+						     DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->ckpt_dma)) {
+			ret = -ENOMEM;
+			goto err_unmap_save;
+		}
+	}
+
+	d = cmh_core_select_instance(CMH_CORE_SM3);
+	idx = 0;
+
+	vcq_add_sm3_init(&cmds[idx++], d.core_id);
+
+	if (rctx->has_checkpoint)
+		vcq_add_sm3_restore(&cmds[idx++], d.core_id,
+				    (u64)rctx->ckpt_dma, SM3_CONTEXT_SIZE);
+
+	vcq_add_sm3_update(&cmds[idx++], d.core_id,
+			   (u64)rctx->data_dma, full_len);
+
+	vcq_add_sm3_save(&cmds[idx++], d.core_id,
+			 (u64)rctx->save_dma, SM3_CONTEXT_SIZE);
+
+	vcq_add_flush(&cmds[idx++], d.core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_SM3_MAX_PACKED,
+					    d.mbx_idx,
+					    cmh_sm3_update_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto err_unmap_ckpt;
+
+	return -EINPROGRESS;
+
+err_unmap_ckpt:
+	if (rctx->has_checkpoint)
+		cmh_dma_unmap_single(rctx->ckpt_dma, SM3_CONTEXT_SIZE,
+				     DMA_TO_DEVICE);
+err_unmap_save:
+	cmh_dma_unmap_single(rctx->save_dma, SM3_CONTEXT_SIZE,
+			     DMA_FROM_DEVICE);
+err_unmap_data:
+	cmh_dma_unmap_single(rctx->data_dma, full_len, DMA_TO_DEVICE);
+err_free:
+	kfree(rctx->save_buf);
+	rctx->save_buf = NULL;
+	kfree(rctx->data_buf);
+	rctx->data_buf = NULL;
+	rctx->data_len = 0;
+	return ret;
+}
+
+static void cmh_sm3_final_complete(void *data, int error)
+{
+	struct ahash_request *req = data;
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (rctx->has_checkpoint)
+		cmh_dma_unmap_single(rctx->ckpt_dma, SM3_CONTEXT_SIZE,
+				     DMA_TO_DEVICE);
+	if (rctx->data_buf)
+		cmh_dma_unmap_single(rctx->data_dma, rctx->data_len,
+				     DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->digest_dma, CMH_SM3_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+
+	if (!error)
+		memcpy(req->result, rctx->digest_buf, CMH_SM3_DIGEST_SIZE);
+
+	kfree(rctx->digest_buf);
+	rctx->digest_buf = NULL;
+	kfree(rctx->data_buf);
+	rctx->data_buf = NULL;
+	cmh_sm3_free_reqctx(rctx);
+	cmh_complete(&req->base, error);
+}
+
+static int cmh_sm3_submit_final(struct ahash_request *req,
+				u8 *data_buf, u32 data_len)
+{
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+	struct vcq_cmd cmds[CMH_SM3_MAX_PAYLOAD];
+	struct core_dispatch d;
+	u32 idx;
+	int ret;
+	gfp_t gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+		   GFP_KERNEL : GFP_ATOMIC;
+
+	rctx->data_buf = data_buf;
+	rctx->data_len = data_len;
+
+	rctx->digest_buf = kzalloc(CMH_SM3_DIGEST_SIZE, gfp);
+	if (!rctx->digest_buf) {
+		ret = -ENOMEM;
+		goto err_free_data;
+	}
+
+	rctx->digest_dma = cmh_dma_map_single(rctx->digest_buf,
+					      CMH_SM3_DIGEST_SIZE,
+					       DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->digest_dma)) {
+		ret = -ENOMEM;
+		goto err_free_digest;
+	}
+
+	rctx->data_dma = DMA_MAPPING_ERROR;
+	if (data_buf && data_len > 0) {
+		rctx->data_dma = cmh_dma_map_single(data_buf, data_len,
+						    DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->data_dma)) {
+			ret = -ENOMEM;
+			goto err_unmap_digest;
+		}
+	}
+
+	rctx->ckpt_dma = DMA_MAPPING_ERROR;
+	if (rctx->has_checkpoint) {
+		rctx->ckpt_dma = cmh_dma_map_single(rctx->checkpoint,
+						    SM3_CONTEXT_SIZE,
+						     DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->ckpt_dma)) {
+			ret = -ENOMEM;
+			goto err_unmap_data;
+		}
+	}
+
+	d = cmh_core_select_instance(CMH_CORE_SM3);
+	idx = 0;
+
+	vcq_add_sm3_init(&cmds[idx++], d.core_id);
+
+	if (rctx->has_checkpoint)
+		vcq_add_sm3_restore(&cmds[idx++], d.core_id,
+				    (u64)rctx->ckpt_dma, SM3_CONTEXT_SIZE);
+
+	if (data_buf && data_len > 0)
+		vcq_add_sm3_update(&cmds[idx++], d.core_id,
+				   (u64)rctx->data_dma, data_len);
+
+	vcq_add_sm3_final(&cmds[idx++], d.core_id,
+			  (u64)rctx->digest_dma, CMH_SM3_DIGEST_SIZE);
+
+	vcq_add_flush(&cmds[idx++], d.core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_SM3_MAX_PACKED,
+					    d.mbx_idx,
+					    cmh_sm3_final_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto err_unmap_ckpt;
+
+	return -EINPROGRESS;
+
+err_unmap_ckpt:
+	if (rctx->has_checkpoint)
+		cmh_dma_unmap_single(rctx->ckpt_dma, SM3_CONTEXT_SIZE,
+				     DMA_TO_DEVICE);
+err_unmap_data:
+	if (data_buf && data_len > 0)
+		cmh_dma_unmap_single(rctx->data_dma, data_len,
+				     DMA_TO_DEVICE);
+err_unmap_digest:
+	cmh_dma_unmap_single(rctx->digest_dma, CMH_SM3_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+err_free_digest:
+	kfree(rctx->digest_buf);
+	rctx->digest_buf = NULL;
+err_free_data:
+	kfree(data_buf);
+	rctx->data_buf = NULL;
+	cmh_sm3_free_reqctx(rctx);
+	return ret;
+}
+
+static int cmh_sm3_final(struct ahash_request *req)
+{
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+	u8 *data_buf = NULL;
+	u32 data_len = 0;
+	gfp_t gfp;
+
+	if (rctx->error)
+		return rctx->error;
+
+	if (rctx->buf_len > 0) {
+		gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+		      GFP_KERNEL : GFP_ATOMIC;
+		data_buf = kmalloc(rctx->buf_len, gfp);
+		if (!data_buf)
+			return -ENOMEM;
+		memcpy(data_buf, rctx->buf, rctx->buf_len);
+		data_len = rctx->buf_len;
+		rctx->buf_len = 0;
+	}
+
+	return cmh_sm3_submit_final(req, data_buf, data_len);
+}
+
+static int cmh_sm3_finup(struct ahash_request *req);
+
+/*
+ * One-shot digest -- delegates to init + finup so that all data is
+ * linearised and mapped through cmh_dma_map_single(), which is the
+ * only DMA mapping path aware of all supported DMA backends.
+ */
+static int cmh_sm3_digest(struct ahash_request *req)
+{
+	int ret;
+
+	ret = cmh_sm3_init(req);
+	if (ret)
+		return ret;
+	return cmh_sm3_finup(req);
+}
+
+static int cmh_sm3_finup(struct ahash_request *req)
+{
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+	u32 data_len;
+	u8 *data_buf;
+	gfp_t gfp;
+
+	if (rctx->error)
+		return rctx->error;
+
+	data_len = rctx->buf_len + req->nbytes;
+
+	if (data_len == 0)
+		return cmh_sm3_submit_final(req, NULL, 0);
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	data_buf = kmalloc(data_len, gfp);
+	if (!data_buf)
+		return -ENOMEM;
+
+	if (rctx->buf_len > 0)
+		memcpy(data_buf, rctx->buf, rctx->buf_len);
+
+	if (req->nbytes > 0) {
+		if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+			memcpy(data_buf + rctx->buf_len,
+			       req->svirt, req->nbytes);
+		else
+			scatterwalk_map_and_copy(data_buf + rctx->buf_len,
+						 req->src, 0,
+						 req->nbytes, 0);
+	}
+
+	rctx->buf_len = 0;
+	return cmh_sm3_submit_final(req, data_buf, data_len);
+}
+
+static int cmh_sm3_export(struct ahash_request *req, void *out)
+{
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_sm3_export_state *state = out;
+
+	if (rctx->hw_started && rctx->has_checkpoint)
+		memcpy(state->checkpoint, rctx->checkpoint, SM3_CONTEXT_SIZE);
+	else
+		memset(state->checkpoint, 0, SM3_CONTEXT_SIZE);
+
+	if (rctx->buf_len > 0)
+		memcpy(state->buf, rctx->buf, rctx->buf_len);
+
+	state->buf_len = rctx->buf_len;
+	state->hw_started = rctx->hw_started;
+
+	return 0;
+}
+
+static int cmh_sm3_import(struct ahash_request *req, const void *in)
+{
+	struct cmh_sm3_reqctx *rctx = ahash_request_ctx(req);
+	const struct cmh_sm3_export_state *state = in;
+
+	memset(rctx, 0, sizeof(*rctx));
+
+	if (state->buf_len > CMH_SM3_BLOCK_SIZE)
+		return -EINVAL;
+
+	rctx->hw_started = state->hw_started;
+	rctx->buf_len = state->buf_len;
+	memcpy(rctx->buf, state->buf, state->buf_len);
+
+	if (state->hw_started) {
+		memcpy(rctx->checkpoint, state->checkpoint, SM3_CONTEXT_SIZE);
+		rctx->has_checkpoint = 1;
+	}
+
+	return 0;
+}
+
+/* Transform init (cra_init) */
+
+static int cmh_sm3_cra_init(struct crypto_tfm *tfm)
+{
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct cmh_sm3_reqctx));
+	return 0;
+}
+
+/* Registration */
+
+static struct ahash_alg cmh_sm3_ahash_alg = {
+	.init    = cmh_sm3_init,
+	.update  = cmh_sm3_update,
+	.final   = cmh_sm3_final,
+	.finup   = cmh_sm3_finup,
+	.digest  = cmh_sm3_digest,
+	.export  = cmh_sm3_export,
+	.import  = cmh_sm3_import,
+
+	.halg = {
+		.digestsize = CMH_SM3_DIGEST_SIZE,
+		.statesize  = sizeof(struct cmh_sm3_export_state),
+		.base = {
+			.cra_name        = "sm3",
+			.cra_driver_name = "cri-cmh-sm3",
+			.cra_priority    = 300,
+			.cra_flags       = CRYPTO_ALG_KERN_DRIVER_ONLY |
+					   CRYPTO_ALG_NO_FALLBACK |
+					   CRYPTO_ALG_ASYNC |
+					   CRYPTO_ALG_REQ_VIRT,
+			.cra_blocksize   = CMH_SM3_BLOCK_SIZE,
+			.cra_ctxsize     = 0,
+			.cra_init        = cmh_sm3_cra_init,
+			.cra_module      = THIS_MODULE,
+		},
+	},
+};
+
+/**
+ * cmh_sm3_register() - Register SM3 hash algorithm with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_sm3_register(void)
+{
+	int ret;
+
+	ret = crypto_register_ahash(&cmh_sm3_ahash_alg);
+	if (ret) {
+		dev_err(cmh_dev(), "sm3: failed to register cmh-sm3 (rc=%d)\n",
+			ret);
+		return ret;
+	}
+
+	dev_info(cmh_dev(), "sm3: registered cri-cmh-sm3 (priority 300)\n");
+	dev_info(cmh_dev(), "sm3: 1 algorithm(s) registered\n");
+	return 0;
+}
+
+/**
+ * cmh_sm3_unregister() - Unregister SM3 hash algorithm from the crypto framework
+ */
+void cmh_sm3_unregister(void)
+{
+	crypto_unregister_ahash(&cmh_sm3_ahash_alg);
+	dev_info(cmh_dev(), "sm3: unregistered cri-cmh-sm3\n");
+	dev_info(cmh_dev(), "sm3: cleaned up\n");
+}
diff --git a/drivers/crypto/cmh/include/cmh_sm3.h b/drivers/crypto/cmh/include/cmh_sm3.h
new file mode 100644
index 000000000000..2f73537f9c87
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_sm3.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SM3 Hash Driver
+ *
+ * Registers an ahash algorithm for SM3 (GB/T 32905-2016) with the
+ * Linux crypto subsystem using the CMH SM3 core (CORE_ID_SM3).
+ * Uses the same incremental HW update model as cmh_hash.c:
+ *
+ *   .init()   -> software-only: zero per-request context
+ *   .update() -> holdback partial blocks; submit full blocks via
+ *                SM3_CMD_INIT [+ RESTORE] + UPDATE + SAVE + FLUSH
+ *   .final()  -> SM3_CMD_INIT [+ RESTORE] [+ UPDATE] + FINAL + FLUSH
+ *   .digest() -> INIT + UPDATE + FINAL + FLUSH (single-shot)
+ *   .export() -> software-only: copy checkpoint + holdback
+ *   .import() -> software-only: restore checkpoint + holdback
+ */
+
+#ifndef CMH_SM3_H
+#define CMH_SM3_H
+
+#include "cmh_config.h"
+
+int  cmh_sm3_register(void);
+void cmh_sm3_unregister(void);
+
+#endif /* CMH_SM3_H */
-- 
2.43.7


