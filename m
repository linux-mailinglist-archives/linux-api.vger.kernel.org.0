Return-Path: <linux-api+bounces-6823-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BEjFGS0GUGpHsAIAu9opvQ
	(envelope-from <linux-api+bounces-6823-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:35:57 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21DD735714
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:35:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b="eww3yr/H";
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6823-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6823-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C1140304E70D
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E03E0C55;
	Thu,  9 Jul 2026 20:31:48 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F13D1702;
	Thu,  9 Jul 2026 20:31:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629106; cv=fail; b=g/T3/+KBiYjAzmMUr0eqc0exOBajphljazdF0R6IWUAejtHVkKkKV+uV0fiaa0oPU87OMYTYwDYZR9AFTb6tEaAuKX1uJGVaGMYC9BN6jwG2KpL0seIrGefrVIBy9fp9lDIq+QDjopkQcQe01FFBa5kufog1psz52ZvSmm+TKqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629106; c=relaxed/simple;
	bh=PHdMpXyEYIoM9AQByjRbmO3VFtam0/hoi3m5gvMS1Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVlifzBadQGSVObD93AFGfROycvyYFEiOWKMAB2XMA6NMLZMnBOjuIyYhdhYvb+wyLRRG4i2es+DF9/XcbdaFH6UPqu2CN+egbyzABpGBW0ZAlDsB8SL7Rl3nitCBXuSSVmdmsSd/r4nytkkEH5lGcHlrwJy30GdqRHVSFzq8ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=eww3yr/H; arc=fail smtp.client-ip=52.101.193.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFol338xS+PFKBoGA1kyw0Qy20G0yFeX+xPdweoZkhXEU2EsuaBo/2GeXAqHEKUxocMEv/U6buoIV7hPAJ6y00WFysKT6oOlS6QK9RtnkCPI+AheV/DQNnF13KH7/n6Mhx9LGyuRdGypsfF7DZ+RoM9yT81c1T/qDzydLrCI4txtLhQDb/DLnu7cmqKA9R2rRSpwjZ+2y8GhhkFNgIKA3jPP009t6/qVj8dw5SFp4OARNmmDsvx9CtJT43MwIYE7zmTSg+mZli9Uin1TbhOsV00XioggsUiB5SnWvTPDEQJFwKfSkJyF3lGmhF5EZZ0tKITvbeFbli4e9+5ZeRAGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvTNj7OhDJ8QgPbM3tl24E2qStWgmHfH6SWEUgkKIRg=;
 b=y7Bu4C5YT2o6kvw4vE5xlNUI3/+p7gmCXOAiCZlXtK2kU9pqoYQ0kl3+Qq5RT/7ltR3XLtt1SiTOtHf4UHIRMXT7V3p8/kfq4JLPqniVFn+7erRQq9dp54ssNir0SbHkFLn4HLv2pbh0jP/krg9eGntDjNUf/vF4dN136vltMmggoHmmPcs2Y9UAxzpLpaWIorPPU4gMjtPqVaDTHp8tTqSDPRknHV2SK8MGTNe4O97rWb4kC4sScU6JdTF+4ySYcIn9P7CYOqYFwpz85FZtjA1QIERLfg+r9uypCnZBj+Ktus9Qj/C2y4rLTQMlpUWy0TGO4snuZGtsVjNolwY7dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvTNj7OhDJ8QgPbM3tl24E2qStWgmHfH6SWEUgkKIRg=;
 b=eww3yr/H9IAj7ZiyIu9j8XB1gr3dFUNahOzCny1y3puBW4MEGISLRp+u4QCXLZCO0DYwfIrkxBcjymTUnLoaEsS4l45y5v3XSRXbmLJcZxdFP6hE8Sm1ao0QNX86ZXeLqtrL3sDOzj3lrqoSOG7tsDf0BI2s5FpONwtqoFBfGhlCab0aj2uUpt+7mMqIBHFyFCEuJ+n2+H/lLFAX3GSh3oRasOOLCPgrzNnV1kg/fvIVRSYddi1tOMB1+8zy6JfoPCu7douBE58/pzVs1aSure1I8SMHwcZWqYNRlmmit/4EtUDj8mxzGUyNdbsOPoMvIhVyvJzBTHMk1nyeEroorQ==
Received: from BN9P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::30)
 by IA3PR04MB9278.namprd04.prod.outlook.com (2603:10b6:208:528::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:31:23 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::91) by BN9P221CA0008.outlook.office365.com
 (2603:10b6:408:10a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 20:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:22 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id F125C180175B;
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
Subject: [PATCH v2 09/19] crypto: cmh - add SM4 skcipher/aead/cmac/xcbc
Date: Thu,  9 Jul 2026 13:30:27 -0700
Message-ID: <20260709203037.1884436-10-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|IA3PR04MB9278:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6d9f5a8b-8873-4253-70ef-08deddf90ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|7416014|921020|22082099003|18002099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	/jK/6z9yq4eZZp+7zNyz8vPLghhJahur8aarDstR5bQmqyMAEsjD30uwVIxicm4SCGFcQHXaSeEfxICw8McbNnTzSv0Ctex+jpHkiFRtr+hx6z+dd3qUA6XI4OOzqPyMWZ4nEd9ml0yNnwM8QXFH2wc4DEy01lq4G19bIUSwc8+cF1jznsRtVgB/D7STEztc81rrfYv0a11Oq0gh2ktD+1uPCxurj7338KhFAf+ocdG1hf5qI8PAQsPdzD3umVF/v53HYKoXxtVV1/yd2mtCUUFhG5UahuJv6ONbYTtQXkIOflt8a/mv2jkJ3o2uW6Zl/PbIWoOjjXhr6uNrBahILyumNVcsW/hr+b4FsQFLjY4LWq4wlHKOzNr1Uy+PGqiHoX7v/3DZphwbU+hNJZ2bqyphvx5lKzAxtyE5tibjNGKw3EWXLwZHZsKxUPrd/TB8HpTApZEK1Cz1M7yxLNiAnwD53a5Oc5n+N97+Xu5lanxFMKHGLmHaWBpjnaCOtMKjKQ6dfzxKT77nt9mDs1pfWMtsK0K8G6NnFkDQRaxi5wTNdbSRbrgoxfUupBlVU1DbP+/+Jf0MjqeT8xXbpoUvMXwtEUoAXexrEVz+IxbF4XomcdINyOJ/lDYyqB05KAPB5b6aN4Bc1TMT1IP1n/0H+2j9q4X+95vRjSsdruz56oMpPmicFTPKGn1NcJ8FYlKlZRFs5VSxuw/n+UMA3AHRO23ssm8PTaViUM4dB7ofDcoCf0FfB+K9vKtAP0bShrRA
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(7416014)(921020)(22082099003)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	huxqVhQ/P3cYuBlOhbt6CyzyIsWpRcjcP/A701wF/gK08P/tKzy/Xwmjec4I5Fpg1KiRbnZ4/UNAjIE3GaA+wFQzZpmvc/Vu7PcWmsK6azhfttPtOmoY/4E3jjSfwKPAqF2UTqkAFWDIH0VRGFcmWxJFqWGkZN6qHahqLTZAo+VpecwvAIdlKwIj+siONXJVN56uwWGZSiPeXBBctQYXEx1nucGAoZml2TLRHF91RTpKNixrxE3S+aEre22uvZSX6bcfGgN4GkMidJd7IQ3UR5na6wdH7e5bdOgAylvX2nv1drWtofWcHdxXKCUeoSKE/4u0yszhca/PNPrMpaSzaiD3JnmXdG0k7KJChhU/Yf7GCrXqgv0GRGR9MxcwEPoOzwYln/9Vl5VhXwZnhCSpde7fUDFhx8YUJ+yd9E+O9ovDjNqzJ2MrMqL5FZ8ohI1u
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:22.7272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9f5a8b-8873-4253-70ef-08deddf90ab9
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9278
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6823-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A21DD735714

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register SM4 algorithms using the CMH SM4 core (core ID 0x04):
- skcipher: SM4-ECB, SM4-CBC, SM4-CTR, SM4-XTS, SM4-CFB
- aead: SM4-GCM, SM4-CCM
- ahash: SM4-CMAC, SM4-XCBC

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile           |   5 +-
 drivers/crypto/cmh/cmh_main.c         |  25 +
 drivers/crypto/cmh/cmh_sm4_aead.c     | 870 ++++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_sm4_cmac.c     | 754 ++++++++++++++++++++++
 drivers/crypto/cmh/cmh_sm4_skcipher.c | 690 ++++++++++++++++++++
 drivers/crypto/cmh/include/cmh_sm4.h  |  24 +
 6 files changed, 2367 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_sm4_aead.c
 create mode 100644 drivers/crypto/cmh/cmh_sm4_cmac.c
 create mode 100644 drivers/crypto/cmh/cmh_sm4_skcipher.c
 create mode 100644 drivers/crypto/cmh/include/cmh_sm4.h

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index ced8d1748e6c..1f36cd9c0b98 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -22,7 +22,10 @@ cmh-y := \
 	cmh_sm3.o \
 	cmh_aes.o \
 	cmh_aes_aead.o \
-	cmh_aes_cmac.o
+	cmh_aes_cmac.o \
+	cmh_sm4_skcipher.o \
+	cmh_sm4_aead.o \
+	cmh_sm4_cmac.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 535a6ff551a2..0a73964b9785 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -35,6 +35,7 @@
 #include "cmh_kmac.h"
 #include "cmh_sm3.h"
 #include "cmh_aes.h"
+#include "cmh_sm4.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -243,6 +244,21 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_aes_cmac_register;
 
+	/* Register SM4 skcipher algorithms */
+	ret = cmh_sm4_register();
+	if (ret)
+		goto err_sm4_register;
+
+	/* Register SM4 AEAD algorithms (GCM, CCM) */
+	ret = cmh_sm4_aead_register();
+	if (ret)
+		goto err_sm4_aead_register;
+
+	/* Register SM4 CMAC/XCBC algorithms */
+	ret = cmh_sm4_cmac_register();
+	if (ret)
+		goto err_sm4_cmac_register;
+
 	/* Register key management device (/dev/cmh_mgmt) */
 	ret = cmh_mgmt_register();
 	if (ret)
@@ -255,6 +271,12 @@ static int cmh_probe(struct platform_device *pdev)
 	return 0;
 
 err_mgmt_register:
+	cmh_sm4_cmac_unregister();
+err_sm4_cmac_register:
+	cmh_sm4_aead_unregister();
+err_sm4_aead_register:
+	cmh_sm4_unregister();
+err_sm4_register:
 	cmh_aes_cmac_unregister();
 err_aes_cmac_register:
 	cmh_aes_aead_unregister();
@@ -297,6 +319,9 @@ static void cmh_remove(struct platform_device *pdev)
 	cfg = &dev->config;
 
 	cmh_mgmt_unregister();
+	cmh_sm4_cmac_unregister();
+	cmh_sm4_aead_unregister();
+	cmh_sm4_unregister();
 	cmh_aes_cmac_unregister();
 	cmh_aes_aead_unregister();
 	cmh_aes_unregister();
diff --git a/drivers/crypto/cmh/cmh_sm4_aead.c b/drivers/crypto/cmh/cmh_sm4_aead.c
new file mode 100644
index 000000000000..478119bb9c08
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_sm4_aead.c
@@ -0,0 +1,870 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API SM4 AEAD Driver (GCM/CCM)
+ *
+ * Registers AEAD algorithms with the Linux crypto subsystem:
+ *   gcm(sm4), ccm(sm4)
+ *
+ * GCM: SM4_CMD_INIT(mode=GCM) + [AAD_FINAL] + SM4_CMD_FINAL + FLUSH
+ * CCM: SM4_CMD_CCM_INIT + [AAD_FINAL] + SM4_CMD_FINAL + FLUSH
+ *   - SM4 CCM uses a distinct sm4_cmd_ccm_init struct
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
+#include "cmh_sm4.h"
+#include "cmh_vcq.h"
+#include "cmh_sm4_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+/*
+ * GCM IV contract:
+ *
+ * The SM4 core requires exactly 16 bytes loaded into its IV register.
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
+#define SM4_GCM_IV_SIZE		12U	/* GCM nonce size (standard) */
+#define SM4_GCM_HW_IV_SIZE	16U	/* HW requires 16-byte IV buffer */
+#define SM4_GCM_TAG_SIZE	16U
+
+/* CCM: callers pass a 16-byte IV in RFC 3610 format:
+ * iv[0] = L-1, iv[1..14-iv[0]] = nonce, rest = counter (zeroed).
+ * Nonce length = 14 - iv[0], range 7..13.
+ */
+#define SM4_CCM_IV_SIZE	16U
+
+enum cmh_sm4_aead_type {
+	CMH_SM4_AEAD_GCM,
+	CMH_SM4_AEAD_CCM,
+};
+
+struct cmh_sm4_aead_info {
+	enum cmh_sm4_aead_type type;
+	u32         sm4_mode;
+	u32         ivsize;
+	u32         maxauthsize;
+	const char *alg_name;
+	const char *drv_name;
+};
+
+static const struct cmh_sm4_aead_info sm4_aead_algs[] = {
+	{ CMH_SM4_AEAD_GCM, SM4_MODE_GCM, SM4_GCM_IV_SIZE,
+	  SM4_GCM_TAG_SIZE, "gcm(sm4)", "cri-cmh-gcm-sm4" },
+	{ CMH_SM4_AEAD_CCM, SM4_MODE_CCM, SM4_CCM_IV_SIZE,
+	  SM4_GCM_TAG_SIZE, "ccm(sm4)", "cri-cmh-ccm-sm4" },
+};
+
+struct cmh_sm4_aead_tfm_ctx {
+	struct cmh_key_ctx key;
+	u32 authsize;
+	struct crypto_cipher *sw_cipher;	/* CCM empty-input fallback */
+};
+
+/* Per-request context (lives in aead_request::__ctx) */
+
+#define CMH_SM4_AEAD_MAX_PAYLOAD	5
+#define CMH_SM4_AEAD_MAX_PACKED		(CMH_SM4_AEAD_MAX_PAYLOAD * 2)
+
+struct cmh_sm4_aead_reqctx {
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
+	struct vcq_cmd packed[CMH_SM4_AEAD_MAX_PACKED];
+};
+
+struct cmh_sm4_aead_drv {
+	struct aead_alg                  alg;
+	const struct cmh_sm4_aead_info  *info;
+};
+
+static const struct cmh_sm4_aead_info *
+cmh_sm4_aead_get_info(struct crypto_aead *tfm)
+{
+	struct aead_alg *alg = crypto_aead_alg(tfm);
+
+	return container_of(alg, struct cmh_sm4_aead_drv, alg)->info;
+}
+
+/* VCQ Builders -- SM4 AEAD-specific */
+
+static void vcq_add_sm4_aead_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref,
+				  u64 iv_dma, u32 keylen, u32 ivlen,
+				  u32 mode, u32 op, u32 aadlen, u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_INIT);
+	slot->hwc.sm4.cmd_init.key = key_ref;
+	slot->hwc.sm4.cmd_init.iv = iv_dma;
+	slot->hwc.sm4.cmd_init.keylen = keylen;
+	slot->hwc.sm4.cmd_init.ivlen = ivlen;
+	slot->hwc.sm4.cmd_init.mode = mode;
+	slot->hwc.sm4.cmd_init.op = op;
+	slot->hwc.sm4.cmd_init.aadlen = aadlen;
+	slot->hwc.sm4.cmd_init.iolen = iolen;
+}
+
+static void vcq_add_sm4_ccm_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref,
+				 u64 nonce_dma, u32 keylen, u32 noncelen,
+				 u32 op, u32 aadlen, u32 iolen, u32 taglen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_CCM_INIT);
+	slot->hwc.sm4.cmd_ccm_init.key = key_ref;
+	slot->hwc.sm4.cmd_ccm_init.nonce = nonce_dma;
+	slot->hwc.sm4.cmd_ccm_init.keylen = keylen;
+	slot->hwc.sm4.cmd_ccm_init.noncelen = noncelen;
+	slot->hwc.sm4.cmd_ccm_init.op = op;
+	slot->hwc.sm4.cmd_ccm_init.aadlen = aadlen;
+	slot->hwc.sm4.cmd_ccm_init.iolen = iolen;
+	slot->hwc.sm4.cmd_ccm_init.taglen = taglen;
+}
+
+static void vcq_add_sm4_aad_final(struct vcq_cmd *slot, u32 core_id, u64 aad_dma,
+				  u32 aadlen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_AAD_FINAL);
+	slot->hwc.sm4.cmd_aad_final.data = aad_dma;
+	slot->hwc.sm4.cmd_aad_final.datalen = aadlen;
+}
+
+static void vcq_add_sm4_aead_final(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+				   u64 output_dma, u64 tag_dma,
+				   u32 iolen, u32 taglen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_FINAL);
+	slot->hwc.sm4.cmd_final.input = input_dma;
+	slot->hwc.sm4.cmd_final.output = output_dma;
+	slot->hwc.sm4.cmd_final.tag = tag_dma;
+	slot->hwc.sm4.cmd_final.iolen = iolen;
+	slot->hwc.sm4.cmd_final.taglen = taglen;
+}
+
+/* setkey */
+static int cmh_sm4_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+			       unsigned int keylen)
+{
+	struct cmh_sm4_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	/* SM4 always uses 128-bit keys */
+	if (keylen != CMH_SM4_KEY_SIZE)
+		return -EINVAL;
+
+	if (tctx->sw_cipher) {
+		int ret;
+
+		ret = crypto_cipher_setkey(tctx->sw_cipher, key, keylen);
+		if (ret)
+			return ret;
+	}
+
+	return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_SM4);
+}
+
+static int cmh_sm4_aead_setauthsize(struct crypto_aead *tfm,
+				    unsigned int authsize)
+{
+	struct cmh_sm4_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	const struct cmh_sm4_aead_info *info = cmh_sm4_aead_get_info(tfm);
+
+	if (info->type == CMH_SM4_AEAD_GCM) {
+		/* eSW enforces taglen == 16 for SM4 GCM (EIP40_SM4_TAG_SIZE) */
+		if (authsize != 16)
+			return -EINVAL;
+	} else {
+		/* CCM: accept 4, 6, 8, 10, 12, 14, 16 per RFC 3610 */
+		if (authsize < 4 || authsize > 16 || (authsize & 1))
+			return -EINVAL;
+	}
+
+	tctx->authsize = authsize;
+	return 0;
+}
+
+static int cmh_sm4_aead_init_tfm(struct crypto_aead *tfm)
+{
+	struct cmh_sm4_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	const struct cmh_sm4_aead_info *info = cmh_sm4_aead_get_info(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	tctx->authsize = info->maxauthsize;
+
+	if (info->type == CMH_SM4_AEAD_CCM) {
+		struct crypto_cipher *ci;
+
+		ci = crypto_alloc_cipher("sm4", 0, 0);
+		if (IS_ERR(ci))
+			return PTR_ERR(ci);
+		tctx->sw_cipher = ci;
+	}
+
+	crypto_aead_set_reqsize(tfm, sizeof(struct cmh_sm4_aead_reqctx));
+	return 0;
+}
+
+static void cmh_sm4_aead_exit_tfm(struct crypto_aead *tfm)
+{
+	struct cmh_sm4_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+
+	if (tctx->sw_cipher)
+		crypto_free_cipher(tctx->sw_cipher);
+	cmh_key_destroy(&tctx->key);
+}
+
+/* DMA unmap helper */
+static void cmh_sm4_aead_unmap_dma(struct cmh_sm4_aead_reqctx *rctx)
+{
+	u32 tag_map_len;
+
+	cmh_dma_unmap_single(rctx->iv_dma, rctx->iv_map_len, DMA_TO_DEVICE);
+	tag_map_len = rctx->empty_gcm_fallback ?
+		      SM4_GCM_HW_IV_SIZE : rctx->authsize;
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
+static void cmh_sm4_aead_free_bufs(struct cmh_sm4_aead_reqctx *rctx)
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
+static void cmh_sm4_aead_complete(void *data, int error)
+{
+	struct aead_request *req = data;
+	struct cmh_sm4_aead_reqctx *rctx = aead_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	cmh_sm4_aead_unmap_dma(rctx);
+
+	/*
+	 * Map HW error on decrypt to -EBADMSG.  The eSW SM4 core uses a
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
+	cmh_sm4_aead_free_bufs(rctx);
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * GCM empty-input fallback (SM4).
+ *
+ * When both AAD and plaintext are empty, GCM reduces to:
+ *   tag = E(K, J0) where J0 = nonce || 0x00000001
+ *
+ * The eSW GCM engine rejects this degenerate case, so we compute it
+ * via a single ECB block encryption of J0.
+ *
+ * VCQ: [SYS_CMD_WRITE] + SM4_CMD_INIT(ECB) + SM4_CMD_FINAL + FLUSH
+ */
+static int cmh_sm4_gcm_empty(struct aead_request *req, u32 sm4_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_sm4_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	struct cmh_sm4_aead_reqctx *rctx = aead_request_ctx(req);
+	struct vcq_cmd cmds[CMH_SM4_AEAD_MAX_PAYLOAD];
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
+	rctx->encrypting = (sm4_op == SM4_OP_ENCRYPT);
+	rctx->empty_gcm_fallback = true;
+
+	/* Build J0 = nonce || 0x00000001 in iv_buf */
+	rctx->iv_buf = kzalloc(SM4_GCM_HW_IV_SIZE, gfp);
+	if (!rctx->iv_buf)
+		return -ENOMEM;
+	memcpy(rctx->iv_buf, req->iv, SM4_GCM_IV_SIZE);
+	rctx->iv_buf[15] = 0x01;
+	rctx->iv_map_len = SM4_GCM_HW_IV_SIZE;
+
+	rctx->iv_dma = cmh_dma_map_single(rctx->iv_buf, SM4_GCM_HW_IV_SIZE,
+					  DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->iv_dma)) {
+		ret = -ENOMEM;
+		goto out_free_iv;
+	}
+
+	/* Tag buffer -- receives E(K, J0) output */
+	rctx->tag_buf = kzalloc(SM4_GCM_HW_IV_SIZE, gfp);
+	if (!rctx->tag_buf) {
+		ret = -ENOMEM;
+		goto out_unmap_iv;
+	}
+	rctx->tag_dma = cmh_dma_map_single(rctx->tag_buf, SM4_GCM_HW_IV_SIZE,
+					   DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->tag_dma)) {
+		ret = -ENOMEM;
+		goto out_free_tag;
+	}
+
+	/* For decrypt: read expected tag from request */
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
+	d = cmh_core_select_instance(CMH_CORE_SM4);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/* ECB INIT: single block encryption of J0 */
+	vcq_add_sm4_aead_init(&cmds[idx++], core_id, key_ref,
+			      0, keylen, 0, SM4_MODE_ECB, SM4_OP_ENCRYPT,
+			      0, SM4_GCM_HW_IV_SIZE);
+
+	/* FINAL: J0 in, E(K,J0) out */
+	vcq_add_sm4_aead_final(&cmds[idx++], core_id,
+			       (u64)rctx->iv_dma, (u64)rctx->tag_dma,
+			       0, SM4_GCM_HW_IV_SIZE, 0);
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_SM4_AEAD_MAX_PACKED,
+					    target_mbx,
+					    cmh_sm4_aead_complete, req,
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
+	cmh_dma_unmap_single(rctx->tag_dma, SM4_GCM_HW_IV_SIZE,
+			     DMA_FROM_DEVICE);
+out_free_tag:
+	kfree(rctx->tag_buf);
+out_unmap_iv:
+	cmh_dma_unmap_single(rctx->iv_dma, SM4_GCM_HW_IV_SIZE, DMA_TO_DEVICE);
+out_free_iv:
+	kfree(rctx->iv_buf);
+	return ret;
+}
+
+/*
+ * CCM empty-input fallback (SM4).
+ *
+ * When both AAD and plaintext are empty, CCM reduces to:
+ *   T  = E(K, B0)    -- CBC-MAC of the single formatting block
+ *   S0 = E(K, A0)    -- CTR block zero
+ *   tag = (T XOR S0)[0..authsize-1]
+ *
+ * The eSW rejects this degenerate case, so the driver computes it
+ * synchronously via two crypto_cipher single-block encryptions.
+ */
+static int cmh_sm4_ccm_empty(struct aead_request *req, u32 sm4_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_sm4_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	u32 authsize = tctx->authsize;
+	u8 b0[CMH_SM4_BLOCK_SIZE], a0[CMH_SM4_BLOCK_SIZE];
+	u8 t[CMH_SM4_BLOCK_SIZE], s0[CMH_SM4_BLOCK_SIZE];
+	u8 tag[CMH_SM4_BLOCK_SIZE];
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
+	memset(b0, 0, CMH_SM4_BLOCK_SIZE);
+	b0[0] = (u8)(8 * ((authsize - 2) / 2) + (L - 1));
+	memcpy(&b0[1], &req->iv[1], 15 - L);
+
+	/* A0: (L-1) || nonce || counter(=0) */
+	memset(a0, 0, CMH_SM4_BLOCK_SIZE);
+	a0[0] = (u8)(L - 1);
+	memcpy(&a0[1], &req->iv[1], 15 - L);
+
+	crypto_cipher_encrypt_one(tctx->sw_cipher, t, b0);
+	crypto_cipher_encrypt_one(tctx->sw_cipher, s0, a0);
+
+	for (i = 0; i < authsize; i++)
+		tag[i] = t[i] ^ s0[i];
+
+	if (sm4_op == SM4_OP_ENCRYPT) {
+		scatterwalk_map_and_copy(tag, req->dst,
+					 req->assoclen, authsize, 1);
+	} else {
+		u8 expected[CMH_SM4_BLOCK_SIZE];
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
+static int cmh_sm4_aead_crypt(struct aead_request *req, u32 sm4_op)
+{
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	struct cmh_sm4_aead_tfm_ctx *tctx = crypto_aead_ctx(tfm);
+	const struct cmh_sm4_aead_info *info = cmh_sm4_aead_get_info(tfm);
+	struct cmh_sm4_aead_reqctx *rctx = aead_request_ctx(req);
+	struct vcq_cmd cmds[CMH_SM4_AEAD_MAX_PAYLOAD];
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
+	if (sm4_op == SM4_OP_ENCRYPT) {
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
+	if (info->type == CMH_SM4_AEAD_CCM) {
+		if (req->iv[0] < 1 || req->iv[0] > 7)
+			return -EINVAL;
+	}
+
+	/*
+	 * The CMH eSW rejects SM4 GCM/CCM when both aadlen and iolen
+	 * are zero.  For GCM, the tag is simply E(K, J0) -- use ECB
+	 * fallback.  For CCM, compute tag = E(K,B0) XOR E(K,A0) in SW.
+	 */
+	if (cryptlen == 0 && req->assoclen == 0) {
+		if (info->type == CMH_SM4_AEAD_GCM)
+			return cmh_sm4_gcm_empty(req, sm4_op);
+		return cmh_sm4_ccm_empty(req, sm4_op);
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
+	rctx->encrypting = (sm4_op == SM4_OP_ENCRYPT);
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
+	if (info->type == CMH_SM4_AEAD_GCM) {
+		rctx->iv_buf = kzalloc(SM4_GCM_HW_IV_SIZE, gfp);
+		if (!rctx->iv_buf) {
+			ret = -ENOMEM;
+			goto out_unmap_tag;
+		}
+		memcpy(rctx->iv_buf, req->iv, SM4_GCM_IV_SIZE);
+		rctx->iv_map_len = SM4_GCM_HW_IV_SIZE;
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
+	d = cmh_core_select_instance(CMH_CORE_SM4);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/* Build INIT command */
+	if (info->type == CMH_SM4_AEAD_CCM) {
+		vcq_add_sm4_ccm_init(&cmds[idx++], core_id, key_ref,
+				     (u64)rctx->iv_dma, keylen,
+				     rctx->iv_map_len, sm4_op,
+				     req->assoclen, cryptlen, authsize);
+	} else {
+		vcq_add_sm4_aead_init(&cmds[idx++], core_id, key_ref,
+				      (u64)rctx->iv_dma, keylen,
+				      SM4_GCM_HW_IV_SIZE, info->sm4_mode,
+				      sm4_op, req->assoclen, cryptlen);
+	}
+
+	if (req->assoclen > 0)
+		vcq_add_sm4_aad_final(&cmds[idx++], core_id,
+				      (u64)rctx->aad_dma, req->assoclen);
+
+	vcq_add_sm4_aead_final(&cmds[idx++], core_id,
+			       cryptlen > 0 ? (u64)rctx->in_dma : 0,
+			       cryptlen > 0 ? (u64)rctx->out_dma : 0,
+			       (u64)rctx->tag_dma, cryptlen, authsize);
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_SM4_AEAD_MAX_PACKED,
+					    target_mbx,
+					    cmh_sm4_aead_complete, req,
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
+static int cmh_sm4_aead_encrypt(struct aead_request *req)
+{
+	return cmh_sm4_aead_crypt(req, SM4_OP_ENCRYPT);
+}
+
+static int cmh_sm4_aead_decrypt(struct aead_request *req)
+{
+	return cmh_sm4_aead_crypt(req, SM4_OP_DECRYPT);
+}
+
+/* Registration */
+
+static struct cmh_sm4_aead_drv sm4_aead_drv_algs[ARRAY_SIZE(sm4_aead_algs)];
+
+/**
+ * cmh_sm4_aead_register() - Register SM4-GCM/CCM AEAD algorithms with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_sm4_aead_register(void)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(sm4_aead_algs); i++) {
+		const struct cmh_sm4_aead_info *info = &sm4_aead_algs[i];
+		struct cmh_sm4_aead_drv *drv = &sm4_aead_drv_algs[i];
+		struct aead_alg *alg = &drv->alg;
+
+		drv->info = info;
+
+		memset(alg, 0, sizeof(*alg));
+
+		alg->setkey      = cmh_sm4_aead_setkey;
+		alg->setauthsize = cmh_sm4_aead_setauthsize;
+		alg->encrypt     = cmh_sm4_aead_encrypt;
+		alg->decrypt     = cmh_sm4_aead_decrypt;
+		alg->init        = cmh_sm4_aead_init_tfm;
+		alg->exit        = cmh_sm4_aead_exit_tfm;
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
+		alg->base.cra_blocksize = 1;
+		alg->base.cra_ctxsize  = sizeof(struct cmh_sm4_aead_tfm_ctx);
+		alg->base.cra_module   = THIS_MODULE;
+
+		ret = crypto_register_aead(alg);
+		if (ret) {
+			dev_err(cmh_dev(), "cmh_sm4_aead: failed to register %s (rc=%d)\n",
+				info->alg_name, ret);
+			goto err_unregister;
+		}
+
+		dev_dbg(cmh_dev(), "cmh_sm4_aead: registered %s\n", info->alg_name);
+	}
+
+	return 0;
+
+err_unregister:
+	while (i--)
+		crypto_unregister_aead(&sm4_aead_drv_algs[i].alg);
+	return ret;
+}
+
+/**
+ * cmh_sm4_aead_unregister() - Unregister SM4 AEAD algorithms from the crypto framework
+ */
+void cmh_sm4_aead_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sm4_aead_algs); i++) {
+		crypto_unregister_aead(&sm4_aead_drv_algs[i].alg);
+		dev_dbg(cmh_dev(), "cmh_sm4_aead: unregistered %s\n",
+			sm4_aead_algs[i].alg_name);
+	}
+}
diff --git a/drivers/crypto/cmh/cmh_sm4_cmac.c b/drivers/crypto/cmh/cmh_sm4_cmac.c
new file mode 100644
index 000000000000..4ebeea445eb6
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_sm4_cmac.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API SM4-CMAC / SM4-XCBC (ahash) Driver
+ *
+ * Registers cmac(sm4) and xcbc(sm4) as ahash algorithms.
+ *
+ * Both produce a 16-byte tag (MAC) from a key and message.
+ * VCQ sequence: [SYS_CMD_WRITE] + SM4_CMD_INIT(CMAC/XCBC) +
+ *               SM4_CMD_AAD_FINAL + SM4_CMD_FINAL + FLUSH
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/cipher.h>
+#include <crypto/internal/hash.h>
+#include <crypto/scatterwalk.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_sm4.h"
+#include "cmh_vcq.h"
+#include "cmh_sm4_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+#define SM4_MAC_DIGEST_SIZE	16U
+#define SM4_MAC_BLOCK_SIZE	16U
+/*
+ * Maximum accumulated data for SM4 MAC -- driver-imposed, not HW.
+ *
+ * The SM4 core does not expose external save/restore VCQ commands,
+ * so the driver must accumulate all data in kernel memory via
+ * .update() and submit it atomically in .final().  This cap limits
+ * the per-request kernel allocation.
+ */
+#define SM4_MAC_MAX_DATA	(64 * 1024)
+
+struct cmh_sm4_mac_alg_info {
+	u32         sm4_mode;	/* SM4_MODE_CMAC or SM4_MODE_XCBC */
+	const char *alg_name;
+	const char *drv_name;
+};
+
+static const struct cmh_sm4_mac_alg_info sm4_mac_algs[] = {
+	{ SM4_MODE_CMAC, "cmac(sm4)", "cri-cmh-cmac-sm4" },
+	{ SM4_MODE_XCBC, "xcbc(sm4)", "cri-cmh-xcbc-sm4" },
+};
+
+struct cmh_sm4_mac_tfm_ctx {
+	struct cmh_key_ctx key;
+	u32 sm4_mode;
+	struct crypto_cipher *sw_cipher;	/* empty-input fallback (CMAC/XCBC) */
+	/* Cached subkeys (derived at setkey time for concurrency safety) */
+	u8 xcbc_k1[CMH_SM4_BLOCK_SIZE];		/* K1 = E(K, 0x01..01) */
+	u8 xcbc_k3[CMH_SM4_BLOCK_SIZE];		/* K3 = E(K, 0x03..03) */
+	u8 cmac_k2[CMH_SM4_BLOCK_SIZE];		/* K2 = dbl(dbl(E(K, 0))) */
+	bool subkeys_valid;
+	spinlock_t         chunk_lock;  /* protects all_chunks */
+	struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* Per-request context (lives in ahash_request::__ctx) */
+/* Chunk node for O(1) update() appends */
+struct cmh_sm4_mac_chunk {
+	struct list_head list;
+	struct list_head tfm_node; /* per-tfm orphan tracking */
+	u32 len;
+	u8  data[];
+};
+
+/* Per-request context (lives in ahash_request::__ctx) */
+
+#define CMH_SM4_MAC_MAX_PAYLOAD		5
+#define CMH_SM4_MAC_MAX_PACKED		(CMH_SM4_MAC_MAX_PAYLOAD * 2)
+
+struct cmh_sm4_mac_reqctx {
+	struct list_head chunks;
+	u32  total_len;
+	u8  *buf;		/* linearised in final() */
+	/* DMA state for async final */
+	dma_addr_t key_dma;
+	dma_addr_t in_dma;
+	dma_addr_t tag_dma;
+	u8 *tag_buf;
+	u32 keylen;
+	struct vcq_cmd packed[CMH_SM4_MAC_MAX_PACKED];
+};
+
+/* Flat state for export/import -- holds accumulated input data only */
+struct cmh_sm4_mac_export_state {
+	u32 total_len;
+	u8  data[];
+};
+
+/*
+ * Flat state buffer for export/import.  The CMH SM4 core does not
+ * support save/restore of intermediate MAC state, so this driver
+ * accumulates input in SW and serialises the buffer on export.
+ *
+ * PAGE_SIZE (4096) caps the exportable accumulated-data window.
+ * Full-range export is not feasible because the crypto subsystem
+ * pre-allocates statesize bytes per request.  Export returns -EINVAL
+ * if the caller has accumulated more than CMH_SM4_MAC_EXPORT_MAX.
+ */
+#define CMH_SM4_MAC_STATE_SIZE 4096
+#define CMH_SM4_MAC_EXPORT_MAX \
+	(CMH_SM4_MAC_STATE_SIZE - sizeof(struct cmh_sm4_mac_export_state))
+
+struct cmh_sm4_mac_drv {
+	struct ahash_alg                   alg;
+	const struct cmh_sm4_mac_alg_info *info;
+};
+
+/*
+ * GF(2^128) doubling used to derive the CMAC subkeys (NIST SP 800-38B).
+ * Shift the 128-bit big-endian value left by one bit and, if the top bit
+ * was set, reduce with Rb = 0x87.
+ */
+static void cmh_sm4_cmac_dbl(u8 out[CMH_SM4_BLOCK_SIZE],
+			     const u8 in[CMH_SM4_BLOCK_SIZE])
+{
+	u8 carry = in[0] >> 7;
+	unsigned int i;
+
+	for (i = 0; i < CMH_SM4_BLOCK_SIZE - 1; i++)
+		out[i] = (in[i] << 1) | (in[i + 1] >> 7);
+	out[CMH_SM4_BLOCK_SIZE - 1] = (in[CMH_SM4_BLOCK_SIZE - 1] << 1) ^
+				      (carry ? 0x87 : 0x00);
+}
+
+static int cmh_sm4_mac_setkey(struct crypto_ahash *tfm, const u8 *key,
+			      unsigned int keylen)
+{
+	struct cmh_sm4_mac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	int ret;
+
+	if (keylen != CMH_SM4_KEY_SIZE)
+		return -EINVAL;
+
+	if (tctx->sw_cipher && tctx->sm4_mode == SM4_MODE_XCBC) {
+		u8 const1[CMH_SM4_BLOCK_SIZE], const3[CMH_SM4_BLOCK_SIZE];
+
+		ret = crypto_cipher_setkey(tctx->sw_cipher, key, keylen);
+		if (ret)
+			return ret;
+
+		/* Pre-derive XCBC subkeys for concurrent-safe final() */
+		memset(const1, 0x01, CMH_SM4_BLOCK_SIZE);
+		memset(const3, 0x03, CMH_SM4_BLOCK_SIZE);
+		crypto_cipher_encrypt_one(tctx->sw_cipher, tctx->xcbc_k1,
+					  const1);
+		crypto_cipher_encrypt_one(tctx->sw_cipher, tctx->xcbc_k3,
+					  const3);
+
+		/*
+		 * Leave sw_cipher keyed with K1 permanently.
+		 * final() only needs E(K1, block) and never touches the
+		 * original key again, so no re-keying in the hot path
+		 * eliminates the per-tfm concurrency race entirely.
+		 */
+		ret = crypto_cipher_setkey(tctx->sw_cipher, tctx->xcbc_k1,
+					   CMH_SM4_BLOCK_SIZE);
+		if (ret)
+			return ret;
+	} else if (tctx->sw_cipher && tctx->sm4_mode == SM4_MODE_CMAC) {
+		u8 zero[CMH_SM4_BLOCK_SIZE] = { 0 };
+		u8 l[CMH_SM4_BLOCK_SIZE], k1[CMH_SM4_BLOCK_SIZE];
+
+		ret = crypto_cipher_setkey(tctx->sw_cipher, key, keylen);
+		if (ret)
+			return ret;
+
+		/*
+		 * Pre-derive the CMAC subkey K2 for the empty-message
+		 * fallback (NIST SP 800-38B):
+		 *   L = E(K, 0^128); K1 = dbl(L); K2 = dbl(K1)
+		 * sw_cipher is left keyed with the original K, so final()
+		 * computes E(K, K2 ^ pad) with no hot-path re-keying.
+		 */
+		crypto_cipher_encrypt_one(tctx->sw_cipher, l, zero);
+		cmh_sm4_cmac_dbl(k1, l);
+		cmh_sm4_cmac_dbl(tctx->cmac_k2, k1);
+		memzero_explicit(l, sizeof(l));
+		memzero_explicit(k1, sizeof(k1));
+	}
+
+	ret = cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_SM4);
+	if (ret)
+		return ret;
+
+	if (tctx->sw_cipher)
+		tctx->subkeys_valid = true;
+
+	return 0;
+}
+
+static void cmh_sm4_mac_free_chunks(struct cmh_sm4_mac_reqctx *rctx,
+				    struct cmh_sm4_mac_tfm_ctx *tctx)
+{
+	struct cmh_sm4_mac_chunk *c, *tmp;
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
+static int cmh_sm4_mac_init(struct ahash_request *req)
+{
+	struct cmh_sm4_mac_reqctx *rctx = ahash_request_ctx(req);
+
+	memset(rctx, 0, sizeof(*rctx));
+	INIT_LIST_HEAD(&rctx->chunks);
+	return 0;
+}
+
+static int cmh_sm4_mac_update(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_sm4_mac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_sm4_mac_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_sm4_mac_chunk *chunk;
+	gfp_t gfp;
+	int ret;
+
+	if (!req->nbytes)
+		return 0;
+
+	if (req->nbytes > SM4_MAC_MAX_DATA - rctx->total_len) {
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
+	 * callers may not call .final() on error, so they would leak.
+	 */
+	cmh_sm4_mac_free_chunks(rctx, tctx);
+	return ret;
+}
+
+static void cmh_sm4_mac_complete(void *data, int error)
+{
+	struct ahash_request *req = data;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_sm4_mac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_sm4_mac_reqctx *rctx = ahash_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (rctx->total_len > 0)
+		cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+				     DMA_TO_DEVICE);
+	cmh_dma_unmap_single(rctx->tag_dma, SM4_MAC_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+
+	if (!error)
+		memcpy(req->result, rctx->tag_buf, SM4_MAC_DIGEST_SIZE);
+
+	kfree(rctx->tag_buf);
+	rctx->tag_buf = NULL;
+	cmh_sm4_mac_free_chunks(rctx, tctx);
+	kfree_sensitive(rctx->buf);
+	rctx->buf = NULL;
+	rctx->total_len = 0;
+	cmh_complete(&req->base, error);
+}
+
+static int cmh_sm4_mac_final(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_sm4_mac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_sm4_mac_reqctx *rctx = ahash_request_ctx(req);
+	struct vcq_cmd cmds[CMH_SM4_MAC_MAX_PAYLOAD];
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
+		goto out_free_chunks;
+	}
+
+	/*
+	 * XCBC empty-input SW fallback (RFC 3566).
+	 *
+	 * For a zero-length message:
+	 *   K1 = E(K, 0x01010101...)  -- encryption subkey
+	 *   K3 = E(K, 0x03030303...)  -- incomplete-block subkey
+	 *   pad = 0x80 00...00        -- single 1 bit + 127 zero bits
+	 *   tag = E(K1, pad XOR K3)
+	 *
+	 * The eSW produces incorrect output for this case, so the driver
+	 * computes it synchronously using crypto_cipher.
+	 *
+	 * For DS keys we cannot derive subkeys (no raw key material),
+	 * and the HW also cannot handle empty XCBC correctly, so
+	 * return -EOPNOTSUPP.
+	 */
+	if (rctx->total_len == 0 && tctx->sm4_mode == SM4_MODE_XCBC) {
+		u8 block[CMH_SM4_BLOCK_SIZE];
+		u32 i;
+
+		if (tctx->key.mode != CMH_KEY_RAW ||
+		    !tctx->subkeys_valid) {
+			cmh_sm4_mac_free_chunks(rctx, tctx);
+			return -EOPNOTSUPP;
+		}
+
+		/* block = pad XOR K3 */
+		memset(block, 0, CMH_SM4_BLOCK_SIZE);
+		block[0] = 0x80;
+		for (i = 0; i < CMH_SM4_BLOCK_SIZE; i++)
+			block[i] ^= tctx->xcbc_k3[i];
+
+		/*
+		 * tag = E(K1, block)
+		 *
+		 * sw_cipher is permanently keyed with K1 (set at setkey
+		 * time), so this is safe for concurrent requests sharing
+		 * the same tfm -- no re-keying, no race.
+		 */
+		crypto_cipher_encrypt_one(tctx->sw_cipher, req->result,
+					  block);
+
+		cmh_sm4_mac_free_chunks(rctx, tctx);
+		return 0;
+	}
+
+	/*
+	 * CMAC empty-input SW fallback (NIST SP 800-38B).
+	 *
+	 * For a zero-length message the sole block is incomplete, so the
+	 * K2 subkey is used:
+	 *   pad = 0x80 00...00        -- single 1 bit + 127 zero bits
+	 *   tag = E(K, pad XOR K2)
+	 *
+	 * The eSW produces incorrect output for this case, so the driver
+	 * computes it synchronously using crypto_cipher.
+	 *
+	 * For DS keys we cannot derive subkeys (no raw key material),
+	 * and the HW also cannot handle empty CMAC correctly, so
+	 * return -EOPNOTSUPP.
+	 */
+	if (rctx->total_len == 0 && tctx->sm4_mode == SM4_MODE_CMAC) {
+		u8 block[CMH_SM4_BLOCK_SIZE];
+		u32 i;
+
+		if (tctx->key.mode != CMH_KEY_RAW || !tctx->subkeys_valid) {
+			cmh_sm4_mac_free_chunks(rctx, tctx);
+			return -EOPNOTSUPP;
+		}
+
+		/* block = pad XOR K2 */
+		memset(block, 0, CMH_SM4_BLOCK_SIZE);
+		block[0] = 0x80;
+		for (i = 0; i < CMH_SM4_BLOCK_SIZE; i++)
+			block[i] ^= tctx->cmac_k2[i];
+
+		/*
+		 * tag = E(K, block).  sw_cipher is keyed with the original
+		 * key K (set at setkey time, never re-keyed), so this is
+		 * safe for concurrent requests sharing the same tfm.
+		 */
+		crypto_cipher_encrypt_one(tctx->sw_cipher, req->result,
+					  block);
+
+		cmh_sm4_mac_free_chunks(rctx, tctx);
+		return 0;
+	}
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	/* Linearise chunks into a single contiguous buffer for DMA */
+	if (rctx->total_len > 0) {
+		struct cmh_sm4_mac_chunk *c;
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
+	rctx->tag_buf = kzalloc(SM4_MAC_DIGEST_SIZE, gfp);
+	if (!rctx->tag_buf) {
+		ret = -ENOMEM;
+		goto out_free_buf;
+	}
+
+	rctx->tag_dma = cmh_dma_map_single(rctx->tag_buf,
+					   SM4_MAC_DIGEST_SIZE,
+					    DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->tag_dma)) {
+		ret = -ENOMEM;
+		goto out_free_tag;
+	}
+
+	if (rctx->total_len > 0) {
+		rctx->in_dma = cmh_dma_map_single(rctx->buf, rctx->total_len,
+						  DMA_TO_DEVICE);
+		if (cmh_dma_map_error(rctx->in_dma)) {
+			ret = -ENOMEM;
+			goto out_unmap_tag;
+		}
+	}
+
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
+	d = cmh_core_select_instance(CMH_CORE_SM4);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/*
+	 * INIT: mode=CMAC or XCBC
+	 * CMAC/XCBC data goes through the AAD path:
+	 *   aadlen = total data length, iolen = 0
+	 */
+	{
+		struct vcq_cmd *slot = &cmds[idx++];
+
+		memset(slot, 0, sizeof(*slot));
+		slot->magic = VCQ_CMD_MAGIC;
+		slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_INIT);
+		slot->hwc.sm4.cmd_init.key = key_ref;
+		slot->hwc.sm4.cmd_init.iv = 0;
+		slot->hwc.sm4.cmd_init.keylen = keylen;
+		slot->hwc.sm4.cmd_init.ivlen = 0;
+		slot->hwc.sm4.cmd_init.mode = tctx->sm4_mode;
+		slot->hwc.sm4.cmd_init.op = SM4_OP_ENCRYPT;
+		slot->hwc.sm4.cmd_init.aadlen = rctx->total_len;
+		slot->hwc.sm4.cmd_init.iolen = 0;
+	}
+
+	/* AAD_FINAL: send data through the AAD path */
+	if (rctx->total_len > 0) {
+		struct vcq_cmd *slot = &cmds[idx++];
+
+		memset(slot, 0, sizeof(*slot));
+		slot->magic = VCQ_CMD_MAGIC;
+		slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_AAD_FINAL);
+		slot->hwc.sm4.cmd_aad_final.data = (u64)rctx->in_dma;
+		slot->hwc.sm4.cmd_aad_final.datalen = rctx->total_len;
+	}
+
+	/* FINAL: tag extraction only (no data) */
+	{
+		struct vcq_cmd *slot = &cmds[idx++];
+
+		memset(slot, 0, sizeof(*slot));
+		slot->magic = VCQ_CMD_MAGIC;
+		slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_FINAL);
+		slot->hwc.sm4.cmd_final.input = 0;
+		slot->hwc.sm4.cmd_final.output = 0;
+		slot->hwc.sm4.cmd_final.tag = (u64)rctx->tag_dma;
+		slot->hwc.sm4.cmd_final.iolen = 0;
+		slot->hwc.sm4.cmd_final.taglen = SM4_MAC_DIGEST_SIZE;
+	}
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_SM4_MAC_MAX_PACKED,
+					    target_mbx,
+					    cmh_sm4_mac_complete, req,
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
+	if (rctx->total_len > 0 && !cmh_dma_map_error(rctx->in_dma))
+		cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+				     DMA_TO_DEVICE);
+out_unmap_tag:
+	cmh_dma_unmap_single(rctx->tag_dma, SM4_MAC_DIGEST_SIZE,
+			     DMA_FROM_DEVICE);
+out_free_tag:
+	kfree(rctx->tag_buf);
+out_free_buf:
+	kfree_sensitive(rctx->buf);
+	rctx->buf = NULL;
+out_free_chunks:
+	cmh_sm4_mac_free_chunks(rctx, tctx);
+	rctx->total_len = 0;
+	return ret;
+}
+
+/*
+ * ahash .export()/.import(): serialize/deserialize the software
+ * accumulation buffer.  No HW state is involved.
+ */
+
+static int cmh_sm4_mac_export(struct ahash_request *req, void *out)
+{
+	struct cmh_sm4_mac_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_sm4_mac_export_state *state = out;
+	struct cmh_sm4_mac_chunk *chunk;
+	u32 offset = 0;
+
+	if (rctx->total_len > CMH_SM4_MAC_EXPORT_MAX)
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
+static int cmh_sm4_mac_import(struct ahash_request *req, const void *in)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_sm4_mac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_sm4_mac_reqctx *rctx = ahash_request_ctx(req);
+	const struct cmh_sm4_mac_export_state *state = in;
+	struct cmh_sm4_mac_chunk *chunk;
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
+	if (state->total_len > CMH_SM4_MAC_EXPORT_MAX)
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
+static int cmh_sm4_mac_finup(struct ahash_request *req)
+{
+	int err;
+
+	err = cmh_sm4_mac_update(req);
+	if (err)
+		return err;
+	return cmh_sm4_mac_final(req);
+}
+
+static int cmh_sm4_mac_digest(struct ahash_request *req)
+{
+	int err;
+
+	err = cmh_sm4_mac_init(req);
+	if (err)
+		return err;
+	return cmh_sm4_mac_finup(req);
+}
+
+/* Registration */
+
+static struct cmh_sm4_mac_drv sm4_mac_drv_algs[ARRAY_SIZE(sm4_mac_algs)];
+
+static int cmh_sm4_mac_init_tfm(struct crypto_ahash *tfm)
+{
+	struct cmh_sm4_mac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+	struct cmh_sm4_mac_drv *drv =
+		container_of(alg, struct cmh_sm4_mac_drv, alg);
+
+	memset(tctx, 0, sizeof(*tctx));
+	tctx->sm4_mode = drv->info->sm4_mode;
+	spin_lock_init(&tctx->chunk_lock);
+	INIT_LIST_HEAD(&tctx->all_chunks);
+
+	/* Allocate SW cipher for the CMAC/XCBC empty-input fallback */
+	if (tctx->sm4_mode == SM4_MODE_XCBC ||
+	    tctx->sm4_mode == SM4_MODE_CMAC) {
+		struct crypto_cipher *ci;
+
+		ci = crypto_alloc_cipher("sm4", 0, 0);
+		if (IS_ERR(ci))
+			return PTR_ERR(ci);
+		tctx->sw_cipher = ci;
+	}
+
+	crypto_ahash_set_reqsize(tfm, sizeof(struct cmh_sm4_mac_reqctx));
+	return 0;
+}
+
+static void cmh_sm4_mac_exit_tfm(struct crypto_ahash *tfm)
+{
+	struct cmh_sm4_mac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_sm4_mac_chunk *c, *tmp;
+
+	/* Free any orphaned chunks (e.g. testmgr export/reimport poison) */
+	spin_lock_bh(&tctx->chunk_lock);
+	list_for_each_entry_safe(c, tmp, &tctx->all_chunks, tfm_node) {
+		list_del(&c->tfm_node);
+		kfree_sensitive(c);
+	}
+	spin_unlock_bh(&tctx->chunk_lock);
+
+	if (tctx->sw_cipher)
+		crypto_free_cipher(tctx->sw_cipher);
+	memzero_explicit(tctx->xcbc_k1, sizeof(tctx->xcbc_k1));
+	memzero_explicit(tctx->xcbc_k3, sizeof(tctx->xcbc_k3));
+	memzero_explicit(tctx->cmac_k2, sizeof(tctx->cmac_k2));
+	cmh_key_destroy(&tctx->key);
+}
+
+/**
+ * cmh_sm4_cmac_register() - Register SM4-CMAC/XCBC hash algorithms with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_sm4_cmac_register(void)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(sm4_mac_algs); i++) {
+		const struct cmh_sm4_mac_alg_info *info = &sm4_mac_algs[i];
+		struct cmh_sm4_mac_drv *drv = &sm4_mac_drv_algs[i];
+		struct ahash_alg *alg = &drv->alg;
+
+		drv->info = info;
+
+		memset(alg, 0, sizeof(*alg));
+
+		alg->init       = cmh_sm4_mac_init;
+		alg->update     = cmh_sm4_mac_update;
+		alg->final      = cmh_sm4_mac_final;
+		alg->finup      = cmh_sm4_mac_finup;
+		alg->digest     = cmh_sm4_mac_digest;
+		alg->export     = cmh_sm4_mac_export;
+		alg->import     = cmh_sm4_mac_import;
+		alg->setkey     = cmh_sm4_mac_setkey;
+		alg->init_tfm   = cmh_sm4_mac_init_tfm;
+		alg->exit_tfm   = cmh_sm4_mac_exit_tfm;
+
+		alg->halg.digestsize = SM4_MAC_DIGEST_SIZE;
+		alg->halg.statesize = CMH_SM4_MAC_STATE_SIZE;
+
+		strscpy(alg->halg.base.cra_name, info->alg_name,
+			CRYPTO_MAX_ALG_NAME);
+		strscpy(alg->halg.base.cra_driver_name, info->drv_name,
+			CRYPTO_MAX_ALG_NAME);
+		alg->halg.base.cra_priority  = 300;
+		alg->halg.base.cra_flags     = CRYPTO_ALG_KERN_DRIVER_ONLY |
+						CRYPTO_ALG_NO_FALLBACK |
+						CRYPTO_ALG_ASYNC |
+						CRYPTO_ALG_REQ_VIRT;
+		alg->halg.base.cra_blocksize = SM4_MAC_BLOCK_SIZE;
+		alg->halg.base.cra_ctxsize  = sizeof(struct cmh_sm4_mac_tfm_ctx);
+		alg->halg.base.cra_module   = THIS_MODULE;
+
+		ret = crypto_register_ahash(alg);
+		if (ret) {
+			dev_err(cmh_dev(), "cmh_sm4_mac: failed to register %s (rc=%d)\n",
+				info->alg_name, ret);
+			goto err_unregister;
+		}
+
+		dev_dbg(cmh_dev(), "cmh_sm4_mac: registered %s\n",
+			info->alg_name);
+	}
+
+	return 0;
+
+err_unregister:
+	while (i--)
+		crypto_unregister_ahash(&sm4_mac_drv_algs[i].alg);
+	return ret;
+}
+
+/**
+ * cmh_sm4_cmac_unregister() - Unregister SM4 MAC hash algorithms from the crypto framework
+ */
+void cmh_sm4_cmac_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sm4_mac_algs); i++) {
+		crypto_unregister_ahash(&sm4_mac_drv_algs[i].alg);
+		dev_dbg(cmh_dev(), "cmh_sm4_mac: unregistered %s\n",
+			sm4_mac_algs[i].alg_name);
+	}
+}
diff --git a/drivers/crypto/cmh/cmh_sm4_skcipher.c b/drivers/crypto/cmh/cmh_sm4_skcipher.c
new file mode 100644
index 000000000000..8cd76cba9235
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_sm4_skcipher.c
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API SM4 (skcipher) Driver
+ *
+ * Registers skcipher algorithms with the Linux crypto subsystem:
+ *   ecb(sm4), cbc(sm4), ctr(sm4), cfb(sm4), xts(sm4)
+ *
+ * Uses the CMH SM4 Core via VCQ commands:
+ *   [SYS_CMD_WRITE] + SM4_CMD_INIT + SM4_CMD_FINAL + VCQ_CMD_FLUSH
+ *
+ * The SM4 core requires bidirectional DMA -- both input and output
+ * buffers are mapped and passed in a single SM4_CMD_FINAL command.
+ *
+ * Raw-key atomicity: SYS_CMD_WRITE to SYS_REF_TEMP is packed into
+ * the same VCQ as SM4 commands (see cmh_key.h for details).
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/xts.h>
+#include <crypto/scatterwalk.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+
+#include "cmh_sm4.h"
+#include "cmh_vcq.h"
+#include "cmh_sm4_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+/* Algorithm Table */
+
+struct cmh_sm4_alg_info {
+	u32         sm4_mode;	/* SM4_MODE_* */
+	u32         ivsize;	/* bytes (0 for ECB) */
+	u32         min_keysize;
+	u32         max_keysize;
+	const char *alg_name;	/* Linux crypto name: "ecb(sm4)" */
+	const char *drv_name;	/* driver name: "cri-cmh-ecb-sm4" */
+};
+
+static const struct cmh_sm4_alg_info sm4_algs[] = {
+	{ SM4_MODE_ECB, 0,               CMH_SM4_KEY_SIZE, CMH_SM4_KEY_SIZE,
+	  "ecb(sm4)", "cri-cmh-ecb-sm4" },
+	{ SM4_MODE_CBC, CMH_SM4_IV_SIZE, CMH_SM4_KEY_SIZE, CMH_SM4_KEY_SIZE,
+	  "cbc(sm4)", "cri-cmh-cbc-sm4" },
+	{ SM4_MODE_CTR, CMH_SM4_IV_SIZE, CMH_SM4_KEY_SIZE, CMH_SM4_KEY_SIZE,
+	  "ctr(sm4)", "cri-cmh-ctr-sm4" },
+	{ SM4_MODE_CFB, CMH_SM4_IV_SIZE, CMH_SM4_KEY_SIZE, CMH_SM4_KEY_SIZE,
+	  "cfb(sm4)", "cri-cmh-cfb-sm4" },
+	{ SM4_MODE_XTS, CMH_SM4_IV_SIZE, CMH_SM4_KEY_SIZE * 2,
+					 CMH_SM4_KEY_SIZE * 2,
+	  "xts(sm4)", "cri-cmh-xts-sm4" },
+};
+
+/* Per-transform context (allocated by crypto framework) */
+
+struct cmh_sm4_tfm_ctx {
+	struct cmh_key_ctx key;
+};
+
+/* Per-request context (lives in skcipher_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + SM4_CMD_INIT + [SM4_CMD_UPDATE] + SM4_CMD_FINAL
+ *   + VCQ_CMD_FLUSH = 5
+ * UPDATE is used for XTS data > 2 blocks (see cmh_sm4_crypt).
+ */
+#define CMH_SM4_MAX_PAYLOAD	5
+#define CMH_SM4_MAX_PACKED	(CMH_SM4_MAX_PAYLOAD * 2)
+
+struct cmh_sm4_reqctx {
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
+	u32 sm4_mode;
+	u32 sm4_op;
+	/* CTR counter-wrap split state */
+	u32 ctr_chunk1_len;
+	u32 core_id;
+	s32 target_mbx;
+	u64 key_ref;
+	struct vcq_cmd packed[CMH_SM4_MAX_PACKED];
+};
+
+/* VCQ Builders -- SM4-specific */
+
+static void vcq_add_sm4_init(struct vcq_cmd *slot, u32 core_id, u64 key_ref, u64 iv_dma,
+			     u32 keylen, u32 ivlen, u32 mode, u32 op,
+			     u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_INIT);
+	slot->hwc.sm4.cmd_init.key = key_ref;
+	slot->hwc.sm4.cmd_init.iv = iv_dma;
+	slot->hwc.sm4.cmd_init.keylen = keylen;
+	slot->hwc.sm4.cmd_init.ivlen = ivlen;
+	slot->hwc.sm4.cmd_init.mode = mode;
+	slot->hwc.sm4.cmd_init.op = op;
+	slot->hwc.sm4.cmd_init.aadlen = 0;
+	slot->hwc.sm4.cmd_init.iolen = iolen;
+}
+
+static void vcq_add_sm4_update(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+			       u64 output_dma, u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_UPDATE);
+	slot->hwc.sm4.cmd_update.input = input_dma;
+	slot->hwc.sm4.cmd_update.output = output_dma;
+	slot->hwc.sm4.cmd_update.iolen = iolen;
+}
+
+static void vcq_add_sm4_final(struct vcq_cmd *slot, u32 core_id, u64 input_dma,
+			      u64 output_dma, u32 iolen)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, SM4_CMD_FINAL);
+	slot->hwc.sm4.cmd_final.input = input_dma;
+	slot->hwc.sm4.cmd_final.output = output_dma;
+	slot->hwc.sm4.cmd_final.iolen = iolen;
+	slot->hwc.sm4.cmd_final.tag = 0;
+	slot->hwc.sm4.cmd_final.taglen = 0;
+}
+
+/*
+ * We wrap each skcipher_alg with its info pointer in a compound struct,
+ * then use container_of() in cmh_sm4_get_info() to recover it.
+ */
+struct cmh_sm4_alg_drv {
+	struct skcipher_alg              alg;
+	const struct cmh_sm4_alg_info   *info;
+};
+
+static bool sm4_is_stream_mode(u32 mode)
+{
+	return mode == SM4_MODE_CTR || mode == SM4_MODE_CFB;
+}
+
+/*
+ * Update req->iv after a successful encrypt/decrypt.
+ * Same semantics as cmh_aes_update_iv -- see cmh_aes.c.
+ */
+static void cmh_sm4_update_iv(struct skcipher_request *req, u32 mode,
+			      u32 op, const u8 *in_buf, const u8 *out_buf)
+{
+	u32 bs = CMH_SM4_BLOCK_SIZE;
+	u32 nblocks;
+
+	switch (mode) {
+	case SM4_MODE_CBC:
+		if (op == SM4_OP_ENCRYPT)
+			memcpy(req->iv, out_buf + req->cryptlen - bs, bs);
+		else
+			memcpy(req->iv, in_buf + req->cryptlen - bs, bs);
+		break;
+	case SM4_MODE_CTR:
+		/* Arithmetic big-endian 128-bit counter increment */
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
+	case SM4_MODE_CFB:
+		/*
+		 * For sub-block requests (cryptlen < 16), there is no
+		 * complete ciphertext block to chain, so the IV is left
+		 * unchanged -- CFB-128 has no defined chaining semantic
+		 * for partial blocks (shift-register CFB-n is a different
+		 * mode).  Without this guard the pointer arithmetic
+		 * underflows and reads before the buffer.
+		 */
+		if (req->cryptlen >= bs) {
+			if (op == SM4_OP_ENCRYPT)
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
+static const struct cmh_sm4_alg_info *
+cmh_sm4_get_info(struct crypto_skcipher *tfm)
+{
+	struct skcipher_alg *alg = crypto_skcipher_alg(tfm);
+
+	return container_of(alg, struct cmh_sm4_alg_drv, alg)->info;
+}
+
+static int cmh_sm4_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			  unsigned int keylen)
+{
+	struct cmh_sm4_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	const struct cmh_sm4_alg_info *info = cmh_sm4_get_info(tfm);
+
+	if (info->sm4_mode == SM4_MODE_XTS) {
+		int err;
+
+		/* XTS: double key (32 bytes) */
+		if (keylen != CMH_SM4_KEY_SIZE * 2)
+			return -EINVAL;
+		err = xts_verify_key(tfm, key, keylen);
+		if (err)
+			return err;
+	} else {
+		/* SM4 always uses 128-bit (16-byte) keys */
+		if (keylen != CMH_SM4_KEY_SIZE)
+			return -EINVAL;
+	}
+
+	return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_SM4);
+}
+
+static int cmh_sm4_init_tfm(struct crypto_skcipher *tfm)
+{
+	struct cmh_sm4_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct cmh_sm4_reqctx));
+	return 0;
+}
+
+static void cmh_sm4_exit_tfm(struct crypto_skcipher *tfm)
+{
+	struct cmh_sm4_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+
+	cmh_key_destroy(&tctx->key);
+}
+
+#define CMH_SM4_MAX_CRYPTLEN	SZ_32M
+
+/* DMA unmap helper */
+static void cmh_sm4_unmap_dma(struct cmh_sm4_reqctx *rctx)
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
+static void cmh_sm4_free_bufs(struct cmh_sm4_reqctx *rctx)
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
+ * Called from cmh_sm4_complete when ctr_chunk1_len > 0.
+ */
+static int cmh_sm4_ctr_submit_chunk2(struct skcipher_request *req);
+
+static void cmh_sm4_complete(void *data, int error)
+{
+	struct skcipher_request *req = data;
+	struct cmh_sm4_reqctx *rctx = skcipher_request_ctx(req);
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
+	 * submission, so the second cmh_sm4_complete invocation sees 0
+	 * and finalizes (max depth = 2).
+	 */
+	if (rctx->ctr_chunk1_len && !error) {
+		int ret = cmh_sm4_ctr_submit_chunk2(req);
+
+		if (!ret || ret == -EBUSY)
+			return;
+		/* Submission failed; clean up below */
+		error = ret;
+	}
+
+	cmh_sm4_unmap_dma(rctx);
+
+	if (!error) {
+		scatterwalk_map_and_copy(rctx->out_buf, req->dst,
+					 0, rctx->cryptlen, 1);
+		cmh_sm4_update_iv(req, rctx->sm4_mode, rctx->sm4_op,
+				  rctx->in_buf, rctx->out_buf);
+	}
+
+	cmh_sm4_free_bufs(rctx);
+	cmh_complete(&req->base, error);
+}
+
+static int cmh_sm4_ctr_submit_chunk2(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct cmh_sm4_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	struct cmh_sm4_reqctx *rctx = skcipher_request_ctx(req);
+	struct vcq_cmd cmds[CMH_SM4_MAX_PAYLOAD];
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
+	vcq_add_sm4_init(&cmds[idx++], rctx->core_id, key_ref,
+			 (u64)rctx->iv2_dma, keylen, rctx->ivsize,
+			 rctx->sm4_mode, rctx->sm4_op, chunk2);
+	vcq_add_sm4_final(&cmds[idx++], rctx->core_id,
+			  (u64)(rctx->in_dma + chunk1),
+			  (u64)(rctx->out_dma + chunk1), chunk2);
+	vcq_add_flush(&cmds[idx++], rctx->core_id);
+
+	return cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					     CMH_SM4_MAX_PACKED,
+					     rctx->target_mbx,
+					     cmh_sm4_complete, req,
+					     !!(req->base.flags &
+						CRYPTO_TFM_REQ_MAY_BACKLOG),
+					     cmh_tm_async_timeout_jiffies());
+}
+
+static int cmh_sm4_crypt(struct skcipher_request *req, u32 sm4_op)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct cmh_sm4_tfm_ctx *tctx = crypto_skcipher_ctx(tfm);
+	const struct cmh_sm4_alg_info *info = cmh_sm4_get_info(tfm);
+	struct cmh_sm4_reqctx *rctx = skcipher_request_ctx(req);
+	struct vcq_cmd cmds[CMH_SM4_MAX_PAYLOAD];
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
+	if (req->cryptlen > CMH_SM4_MAX_CRYPTLEN)
+		return -EINVAL;
+
+	switch (info->sm4_mode) {
+	case SM4_MODE_CTR:
+	case SM4_MODE_CFB:
+		break;
+	case SM4_MODE_XTS:
+		if (req->cryptlen < CMH_SM4_BLOCK_SIZE)
+			return -EINVAL;
+		break;
+	default:
+		if (req->cryptlen & (CMH_SM4_BLOCK_SIZE - 1))
+			return -EINVAL;
+		break;
+	}
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->cryptlen = req->cryptlen;
+	rctx->ivsize = info->ivsize;
+	rctx->sm4_mode = info->sm4_mode;
+	rctx->sm4_op = sm4_op;
+	rctx->iv2_buf = NULL;
+
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
+	d = cmh_core_select_instance(CMH_CORE_SM4);
+	target_mbx = d.mbx_idx;
+	core_id = d.core_id;
+
+	/*
+	 * iolen in INIT: passed for all modes.  The EIP-40 eSW ignores
+	 * it for CTR (stream cipher), but uses it for XTS/CBC/ECB to
+	 * know the total data length.  Pass cryptlen unconditionally.
+	 */
+	vcq_add_sm4_init(&cmds[idx++], core_id, key_ref, (u64)rctx->iv_dma,
+			 keylen, info->ivsize, info->sm4_mode, sm4_op,
+			 req->cryptlen);
+
+	if (info->sm4_mode == SM4_MODE_XTS &&
+	    req->cryptlen > 2 * CMH_SM4_BLOCK_SIZE) {
+		u32 final_len, update_len;
+
+		if (req->cryptlen & (CMH_SM4_BLOCK_SIZE - 1))
+			final_len = CMH_SM4_BLOCK_SIZE +
+				    (req->cryptlen & (CMH_SM4_BLOCK_SIZE - 1));
+		else
+			final_len = 2 * CMH_SM4_BLOCK_SIZE;
+
+		update_len = req->cryptlen - final_len;
+
+		vcq_add_sm4_update(&cmds[idx++], core_id,
+				   (u64)rctx->in_dma,
+				   (u64)rctx->out_dma, update_len);
+		vcq_add_sm4_final(&cmds[idx++], core_id,
+				  (u64)(rctx->in_dma + update_len),
+				  (u64)(rctx->out_dma + update_len),
+				  final_len);
+	} else if (info->sm4_mode == SM4_MODE_CTR) {
+		/*
+		 * CTR counter-wrap: split at the 64-bit boundary,
+		 * consistent with the AES-SCA driver.  The completion
+		 * callback submits chunk2 with IV = {upper64+1, 0}.
+		 */
+		u64 lower64 = get_unaligned_be64(rctx->iv_buf + 8);
+		u32 nblocks = DIV_ROUND_UP(req->cryptlen,
+					  CMH_SM4_BLOCK_SIZE);
+		u64 bwrap = lower64 ? (~lower64 + 1ULL) : U64_MAX;
+
+		if (nblocks > bwrap) {
+			u32 chunk1 = (u32)bwrap * CMH_SM4_BLOCK_SIZE;
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
+			vcq_add_sm4_final(&cmds[idx++], core_id,
+					  (u64)rctx->in_dma,
+					  (u64)rctx->out_dma, chunk1);
+		} else {
+			/* No wrap: single FINAL with all data */
+			vcq_add_sm4_final(&cmds[idx++], core_id,
+					  (u64)rctx->in_dma,
+					  (u64)rctx->out_dma,
+					  req->cryptlen);
+		}
+	} else {
+		vcq_add_sm4_final(&cmds[idx++], core_id,
+				  (u64)rctx->in_dma,
+				  (u64)rctx->out_dma, req->cryptlen);
+	}
+
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_SM4_MAX_PACKED, target_mbx,
+					    cmh_sm4_complete, req,
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
+static int cmh_sm4_encrypt(struct skcipher_request *req)
+{
+	return cmh_sm4_crypt(req, SM4_OP_ENCRYPT);
+}
+
+static int cmh_sm4_decrypt(struct skcipher_request *req)
+{
+	return cmh_sm4_crypt(req, SM4_OP_DECRYPT);
+}
+
+/* Registration */
+
+static struct cmh_sm4_alg_drv sm4_drv_algs[ARRAY_SIZE(sm4_algs)];
+
+/**
+ * cmh_sm4_register() - Register SM4-CBC/CTR/ECB/XTS skcipher algorithms
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_sm4_register(void)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ARRAY_SIZE(sm4_algs); i++) {
+		const struct cmh_sm4_alg_info *info = &sm4_algs[i];
+		struct cmh_sm4_alg_drv *drv = &sm4_drv_algs[i];
+		struct skcipher_alg *alg = &drv->alg;
+
+		drv->info = info;
+
+		memset(alg, 0, sizeof(*alg));
+
+		alg->setkey      = cmh_sm4_setkey;
+		alg->encrypt     = cmh_sm4_encrypt;
+		alg->decrypt     = cmh_sm4_decrypt;
+		alg->init        = cmh_sm4_init_tfm;
+		alg->exit        = cmh_sm4_exit_tfm;
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
+		alg->base.cra_blocksize = sm4_is_stream_mode(info->sm4_mode)
+					  ? 1 : CMH_SM4_BLOCK_SIZE;
+		alg->base.cra_ctxsize  = sizeof(struct cmh_sm4_tfm_ctx);
+		alg->base.cra_module   = THIS_MODULE;
+
+		ret = crypto_register_skcipher(alg);
+		if (ret) {
+			dev_err(cmh_dev(), "cmh_sm4: failed to register %s (rc=%d)\n",
+				info->alg_name, ret);
+			goto err_unregister;
+		}
+
+		dev_dbg(cmh_dev(), "cmh_sm4: registered %s\n", info->alg_name);
+	}
+
+	return 0;
+
+err_unregister:
+	while (i--)
+		crypto_unregister_skcipher(&sm4_drv_algs[i].alg);
+	return ret;
+}
+
+/**
+ * cmh_sm4_unregister() - Unregister SM4 skcipher algorithms from the crypto framework
+ */
+void cmh_sm4_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sm4_algs); i++) {
+		crypto_unregister_skcipher(&sm4_drv_algs[i].alg);
+		dev_dbg(cmh_dev(), "cmh_sm4: unregistered %s\n", sm4_algs[i].alg_name);
+	}
+}
diff --git a/drivers/crypto/cmh/include/cmh_sm4.h b/drivers/crypto/cmh/include/cmh_sm4.h
new file mode 100644
index 000000000000..9f4b0fb918db
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_sm4.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- SM4 Crypto API Drivers
+ *
+ * Registers SM4 algorithms with the Linux crypto subsystem:
+ *   skcipher: ecb/cbc/ctr/cfb/xts(sm4)
+ *   aead:     gcm/ccm(sm4)
+ *   shash:    cmac/xcbc(sm4)
+ */
+
+#ifndef CMH_SM4_H
+#define CMH_SM4_H
+
+int  cmh_sm4_register(void);
+void cmh_sm4_unregister(void);
+
+int  cmh_sm4_aead_register(void);
+void cmh_sm4_aead_unregister(void);
+
+int  cmh_sm4_cmac_register(void);
+void cmh_sm4_cmac_unregister(void);
+
+#endif /* CMH_SM4_H */
-- 
2.43.7


