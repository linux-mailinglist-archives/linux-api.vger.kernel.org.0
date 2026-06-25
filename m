Return-Path: <linux-api+bounces-6687-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zniXE+5mPWpc2ggAu9opvQ
	(envelope-from <linux-api+bounces-6687-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:35:42 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5316C7D5B
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:35:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b="r/S58M/E";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6687-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6687-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD38C3099CFB
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E0C3ED3DA;
	Thu, 25 Jun 2026 17:34:18 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023092.outbound.protection.outlook.com [40.93.196.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1434B66F;
	Thu, 25 Jun 2026 17:34:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408858; cv=fail; b=uO5JCjsYLNIgZ+VSqShlWrzix+VW3zex9Du280wauwgJ9Iaw4SZXT1Io9iXJXfiJ2azyeusPgbrb2U7qPcre5kiMYMP6MYY7KNaPgvkS0OC8OOFBiqRu/qLqAZydGvwVwQQjyyfzk4t/qVqNKeOXXOqEACxxiLnZgq/yu8m+elI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408858; c=relaxed/simple;
	bh=mFD/OW5BW+jXRk5z0oVXGPWlYYBeTO3PKxhiz/2O4zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSQY1khx8UsUfV9GMZbcss7Pc0DaZox/U8YINuFtQA8unX2ldypKwn9xJv04dzGv06CRbkhYR+2XydhY79qjfHB9hOt+uwFXQ5ZKESYpNTl6FOqLJlZXU9B7SjMEo2rKV7q4n2nvP7o2dXBz+9CzxyH5pBaXU3Pr3GPnDYIOj4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=r/S58M/E; arc=fail smtp.client-ip=40.93.196.92
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4xKT23r72TLI42PfYLOeEj75pFW6Pw2qiV0/EJwYEzvwDgsUnqLBXBS1lCGBvkmKtzL5yl8N3q0Mk2v/kCS3MoVdlX9gTYAUQ/JmqDiQ5UmT2dlTqhp2565AhFVRqU3AhnjlaBhwxS+lzgM0zRL1eXp5/oVFsNsC48XxLUXEhbb6Pm9Fkff4R4NUDCDVfwSgHNCRdON+CFwsB3lxSQcK1OREu+/A/mNKSz6ZBeU1fEypzK1pMOO4/XyQGH70KN2pIbxPqmG/1EA9sLM6nmPIkf4CtCxMbwqpa8D4LIX4j3NZIMxRibmdxvVgyRHiog1o3iU8Qwfw+u7bfOXj+wZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjtoRzGXHzndv6VLysNZw6sEln5prRZ9ypYTqukgZwo=;
 b=S+hj4zh1C8ps/HTPLg0pZe3HzgllQ/tVEH5Y3GuUHdEAF7aXmuKrJam7i+bfRMoR7DpxEvo+DG5SgWmbDJVUAzsy/vEPn8TxXmNmZJ7+cGD0YGJt17c60ZIMvYgRnRg1QmLuGHy5JpO3+usjbybM6fnAx2I06UYsaJNuTYle7XjiCptk4OU/ykgmQlrapNA2CJcqPyfNaT/5RqgzIMxHOlxNTJCnKPoXfo06YFIW8ppApNtiwoQYQclJq2bquXLSwpr/JtgkRVXbe/LaFwVmcGqbNwy+cuI5SqDZ5M63D+V7BI3gOx50M0SRFcsiM6qTSDSXwv8ssf6EYztDO3u3EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjtoRzGXHzndv6VLysNZw6sEln5prRZ9ypYTqukgZwo=;
 b=r/S58M/EAM/w3k7EG2Tlii9KG4x8sMd7jnalVnB63nxxU9LBQ0WbgXn/ZDXtJViEbrq4z9y/36LVu8UhUu0jVXTI+u2zGxYTqsEbE0bZbAfrW+tBD1KzOAiM1a77J8nauMOxl646Zqb7ihOlh9HniqzR5NobV66G6LsHo0r8CMIezu29mRKK9aS6aLicC3NKLj+FIbabLT2Ai2oIKgpXMMw6YwGFujnwyzRBsnVjw/xgcuEQRg8O8FWA0Q/UkKLaMoJ8KwPZkX0nBOEgBIPYOnNxnb8hTaDnO3wwD5r1I9ifwVLZi0W6AbL4G8ke1Trk/iRblBH6mp9Emy8Its7yiA==
Received: from BN9PR03CA0868.namprd03.prod.outlook.com (2603:10b6:408:13d::33)
 by DS0PR04MB9686.namprd04.prod.outlook.com (2603:10b6:8:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 17:34:09 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::4e) by BN9PR03CA0868.outlook.office365.com
 (2603:10b6:408:13d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 17:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:08 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id BC0121801762;
	Thu, 25 Jun 2026 17:34:06 +0000 (UTC)
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
	sipsupport@rambus.com,
	Thi Nguyen <thin@rambus.com>
Subject: [PATCH 08/19] crypto: cmh - add AES skcipher/aead/cmac
Date: Thu, 25 Jun 2026 10:33:16 -0700
Message-ID: <20260625173328.1140487-9-skrishnamoorthy@rambus.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
References: <20260625173328.1140487-1-skrishnamoorthy@rambus.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DS0PR04MB9686:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 55cac0b2-3246-426a-2a46-08ded2dff67f
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|921020|22082099003|18002099003|11063799006|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	K/GscFGySad35s28bcurV6+dLKcPW1XvrzclJeEoUS1rp0QiZcjkzeYPfb7HICcq4jTJSBnQhBzrcNzHG+kblb50Auyn1eGOq/i5Z4TbE7clJqii/yjhX5WW+wVLn1KpFdvkwPen9g3QS8/Kpat66C30Qu0ITfL6f094JjaI/Rh/crclLSoX25/FdipUHqyfHUO+ZqUijGyVEKeLhg8sKUFvACoUBl4dy94dTAMmn7j3idSTmp+nJvocZgfsXZ57VDCvnfJbRiXLpf8E6WqPeum6QfrbDOrQsrscpSIS9I3FkOqliLkYlD6V/tDdgL/cp+bCRgkdlorOqpeMU2qfsWlp2tAeXqNYufGoGobeF1eyTaSdUGBn2bw4cY48Q6FTQYW9n2SdZDKlfSgqHI7J9QVOYmaZxxe3OWGNZ0O5svWld5LCTOeZAFujs3LqxHtl7W5UWR4/L8UoYqE82O89atYxlxvs5NPq1ABF1H6PNCHJhAE+r2q811KeWQ4qs7krXqtQKhjFGO/HEQMyIElk6k/ImqOrSu7HtdEFExKM0Y/0j0sAIzUkQax6Wmq8GXY0falSK+JI/lUD9B5JWbHu8W5iGNTtqBK1zMlSmD3rCQT+v2pgA/IPwRD0MBQKJj5VUh2Ei4PoD7vyV2V8hEd4/3EV3upRCS8TmHILUtzRq7BilfRLy0f5Na8q1XC3ohiwBRpCJj57wwKIYVGpOGpC6UGmEScGwBl0NdTXrevEqgRePH3uFuc/RpKVNeOiW+jo
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(921020)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SgIWQ2vjBacvJT48ZYQEUYW45ATTeZPKoQlUw1LQhAi62dEX+PKGTU+xzKX5r6wXmhhpf+SMajBe40UWW/AsPKZsWayT1GZoJM4ZQI7ReAM97BbK1wX7EUwKMHiaka+Ag5JgUpWJtzbMbCI632QaDJntIwLf83ClYewlRtsk1NQjV8TaMkX/TGY1mF/7kMCMjVTNmSbEtSDmZekdJ4CGz+zdgsIO9zKbarrZgfMgutwgRNJ6ALqVlO+KNx1Z3i7VVZM+OlyWgxFUKi+UOdxhNyP9fIcPSuBxtEwuh2GX6g3kTt0SvvnwBV0TXRlwZgCNNefdT+lRBNdKvSd6mINhLKm2MxUNGpI3YdjLnBwm0bFpFIoXAHDuhVdJc9ddglXYZN2fzYMHnf31+N9DNabC8CNH67B087k+Eb3VP26lzdCOMNOXdpY6A01DDAVkdtjU
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:08.5821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cac0b2-3246-426a-2a46-08ded2dff67f
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB9686
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-6687-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aou@eecs.berkeley.edu,m:aousherovitch@rambus.com,m:conor+dt@kernel.org,m:davem@davemloft.net,m:herbert@gondor.apana.org.au,m:corbet@lwn.net,m:krzk+dt@kernel.org,m:palmer@dabbelt.com,m:pjw@kernel.org,m:robh@kernel.org,m:skrishnamoorthy@rambus.com,m:shuah@kernel.org,m:alex@ghiti.fr,m:devicetree@vger.kernel.org,m:Joel.Wittenauer@cryptography.com,m:linux-api@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:skhan@linuxfoundation.org,m:sipsupport@rambus.com,m:thin@rambus.com,m:conor@kernel.org,m:krzk@kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[rambus.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cryptography.com:email,vger.kernel.org:from_smtp,rambus.com:url,rambus.com:from_mime,rambus.com:dkim,rambus.com:email,rambus.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A5316C7D5B

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register AES algorithms using the CMH AES core (core ID 0x03):
- skcipher: AES-ECB, AES-CBC, AES-CTR, AES-XTS, AES-CFB
- aead: AES-GCM, AES-CCM
- ahash: AES-CMAC

Supports 128, 192, and 256-bit keys.  AEAD algorithms handle
associated data, payload, and authentication tag with correct
encrypt/decrypt separation.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
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
@@ -19,7 +19,10 @@ cmh-y :=3D \
        cmh_hmac.o \
        cmh_cshake.o \
        cmh_kmac.o \
-       cmh_sm3.o
+       cmh_sm3.o \
+       cmh_aes.o \
+       cmh_aes_aead.o \
+       cmh_aes_cmac.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
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
+       u32         aes_mode;   /* AES_MODE_* */
+       u32         ivsize;             /* bytes (0 for ECB) */
+       u32         min_keysize;        /* minimum key bytes */
+       u32         max_keysize;        /* maximum key bytes */
+       const char *alg_name;   /* Linux crypto name: "ecb(aes)" */
+       const char *drv_name;   /* driver name: "cri-cmh-ecb-aes" */
+};
+
+static const struct cmh_aes_alg_info aes_algs[] =3D {
+       { AES_MODE_ECB, 0,                AES_KEYSIZE_128, AES_KEYSIZE_256,
+         "ecb(aes)", "cri-cmh-ecb-aes" },
+       { AES_MODE_CBC, CMH_AES_IV_SIZE,  AES_KEYSIZE_128, AES_KEYSIZE_256,
+         "cbc(aes)", "cri-cmh-cbc-aes" },
+       { AES_MODE_CTR, CMH_AES_IV_SIZE,  AES_KEYSIZE_128, AES_KEYSIZE_256,
+         "ctr(aes)", "cri-cmh-ctr-aes" },
+       { AES_MODE_CFB, CMH_AES_IV_SIZE,  AES_KEYSIZE_128, AES_KEYSIZE_256,
+         "cfb(aes)", "cri-cmh-cfb-aes" },
+       { AES_MODE_XTS, CMH_AES_IV_SIZE,  2 * AES_KEYSIZE_128, 2 * AES_KEYS=
IZE_256,
+         "xts(aes)", "cri-cmh-xts-aes" },
+};
+
+/* Per-transform context (allocated by crypto framework) */
+
+struct cmh_aes_tfm_ctx {
+       struct cmh_key_ctx key;
+};
+
+/* Per-request context (lives in skcipher_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + AES_CMD_INIT + [AES_CMD_UPDATE] + AES_CMD_FINAL
+ *   + VCQ_CMD_FLUSH =3D 5
+ * UPDATE is used for XTS data > 2 blocks (see cmh_aes_crypt).
+ */
+#define CMH_AES_MAX_PAYLOAD    5
+#define CMH_AES_MAX_PACKED     (CMH_AES_MAX_PAYLOAD * 2)
+
+struct cmh_aes_reqctx {
+       dma_addr_t in_dma;
+       dma_addr_t out_dma;
+       dma_addr_t iv_dma;
+       dma_addr_t iv2_dma;
+       dma_addr_t key_dma;
+       u8 *in_buf;
+       u8 *out_buf;
+       u8 *iv_buf;
+       u8 *iv2_buf;
+       u32 cryptlen;
+       u32 ivsize;
+       u32 keylen;
+       u32 aes_mode;
+       u32 aes_op;
+       /* CTR counter-wrap split state */
+       u32 ctr_chunk1_len;
+       u32 core_id;
+       s32 target_mbx;
+       u64 key_ref;
+       struct vcq_cmd packed[CMH_AES_MAX_PACKED];
+};
+
+/* VCQ Builders -- AES-specific */
+
+static void vcq_add_aes_init(struct vcq_cmd *slot, u32 core_id, u64 key_re=
f, u64 iv_dma,
+                            u32 keylen, u32 ivlen, u32 mode, u32 op,
+                            u32 iolen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_INIT);
+       slot->hwc.aes.cmd_init.key =3D key_ref;
+       slot->hwc.aes.cmd_init.iv =3D iv_dma;
+       slot->hwc.aes.cmd_init.keylen =3D keylen;
+       slot->hwc.aes.cmd_init.ivlen =3D ivlen;
+       slot->hwc.aes.cmd_init.mode =3D mode;
+       slot->hwc.aes.cmd_init.op =3D op;
+       slot->hwc.aes.cmd_init.aadlen =3D 0;
+       slot->hwc.aes.cmd_init.iolen =3D iolen;
+       slot->hwc.aes.cmd_init.taglen =3D 0;
+}
+
+static void vcq_add_aes_update(struct vcq_cmd *slot, u32 core_id, u64 inpu=
t_dma,
+                              u64 output_dma, u32 iolen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_UPDATE);
+       slot->hwc.aes.cmd_update.input =3D input_dma;
+       slot->hwc.aes.cmd_update.output =3D output_dma;
+       slot->hwc.aes.cmd_update.iolen =3D iolen;
+}
+
+static void vcq_add_aes_final(struct vcq_cmd *slot, u32 core_id, u64 input=
_dma,
+                             u64 output_dma, u32 iolen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_FINAL);
+       slot->hwc.aes.cmd_final.input =3D input_dma;
+       slot->hwc.aes.cmd_final.output =3D output_dma;
+       slot->hwc.aes.cmd_final.iolen =3D iolen;
+       slot->hwc.aes.cmd_final.tag =3D 0;
+       slot->hwc.aes.cmd_final.taglen =3D 0;
+}
+
+/*
+ * We wrap each skcipher_alg with its info pointer in a compound struct,
+ * then use container_of() in cmh_aes_get_info() to recover it.
+ * This is the same pattern used by hash, hmac, cshake, kmac.
+ */
+struct cmh_aes_alg_drv {
+       struct skcipher_alg             alg;
+       const struct cmh_aes_alg_info  *info;
+};
+
+static bool aes_is_stream_mode(u32 mode)
+{
+       return mode =3D=3D AES_MODE_CTR || mode =3D=3D AES_MODE_CFB;
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
+                             u32 op, const u8 *in_buf, const u8 *out_buf)
+{
+       u32 bs =3D CMH_AES_BLOCK_SIZE;
+       u32 nblocks;
+
+       switch (mode) {
+       case AES_MODE_CBC:
+               if (op =3D=3D AES_OP_ENCRYPT)
+                       memcpy(req->iv, out_buf + req->cryptlen - bs, bs);
+               else
+                       memcpy(req->iv, in_buf + req->cryptlen - bs, bs);
+               break;
+       case AES_MODE_CTR:
+               /*
+                * Arithmetic big-endian 128-bit counter increment.
+                * Process from the least-significant byte (index 15)
+                * upward, carrying as needed.
+                */
+               nblocks =3D DIV_ROUND_UP(req->cryptlen, bs);
+               {
+                       u8 *iv =3D req->iv;
+                       int i;
+
+                       for (i =3D bs - 1; i >=3D 0 && nblocks; i--) {
+                               u32 sum =3D (u32)iv[i] + (nblocks & 0xff);
+
+                               iv[i] =3D (u8)sum;
+                               nblocks =3D (nblocks >> 8) + (sum >> 8);
+                       }
+               }
+               break;
+       case AES_MODE_CFB:
+               /*
+                * CFB-128 chains on the last ciphertext block.  On encrypt=
,
+                * that is out_buf; on decrypt, it is in_buf.
+                *
+                * For sub-block requests (cryptlen < 16), there is no
+                * complete ciphertext block to chain, so the IV is left
+                * unchanged -- CFB-128 has no defined chaining semantic
+                * for partial blocks (shift-register CFB-n is a different
+                * mode).  Without this guard the pointer arithmetic
+                * underflows and reads before the buffer.
+                */
+               if (req->cryptlen >=3D bs) {
+                       if (op =3D=3D AES_OP_ENCRYPT)
+                               memcpy(req->iv, out_buf + req->cryptlen - b=
s,
+                                      bs);
+                       else
+                               memcpy(req->iv, in_buf + req->cryptlen - bs=
,
+                                      bs);
+               }
+               break;
+       default:
+               break;
+       }
+}
+
+/* skcipher Operations */
+
+static const struct cmh_aes_alg_info *
+cmh_aes_get_info(struct crypto_skcipher *tfm)
+{
+       struct skcipher_alg *alg =3D crypto_skcipher_alg(tfm);
+
+       return container_of(alg, struct cmh_aes_alg_drv, alg)->info;
+}
+
+static int cmh_aes_setkey(struct crypto_skcipher *tfm, const u8 *key,
+                         unsigned int keylen)
+{
+       struct cmh_aes_tfm_ctx *tctx =3D crypto_skcipher_ctx(tfm);
+       const struct cmh_aes_alg_info *info =3D cmh_aes_get_info(tfm);
+
+       if (info->aes_mode =3D=3D AES_MODE_XTS) {
+               int err;
+
+               /* XTS: double key (32, 48, or 64 bytes) */
+               if (keylen !=3D 2 * AES_KEYSIZE_128 &&
+                   keylen !=3D 2 * AES_KEYSIZE_192 &&
+                   keylen !=3D 2 * AES_KEYSIZE_256)
+                       return -EINVAL;
+               err =3D xts_verify_key(tfm, key, keylen);
+               if (err)
+                       return err;
+       } else {
+               /* Standard: 16, 24, or 32 bytes */
+               if (keylen !=3D AES_KEYSIZE_128 &&
+                   keylen !=3D AES_KEYSIZE_192 &&
+                   keylen !=3D AES_KEYSIZE_256)
+                       return -EINVAL;
+       }
+
+       return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_AES);
+}
+
+static int cmh_aes_init_tfm(struct crypto_skcipher *tfm)
+{
+       struct cmh_aes_tfm_ctx *tctx =3D crypto_skcipher_ctx(tfm);
+
+       memset(tctx, 0, sizeof(*tctx));
+       crypto_skcipher_set_reqsize(tfm, sizeof(struct cmh_aes_reqctx));
+       return 0;
+}
+
+static void cmh_aes_exit_tfm(struct crypto_skcipher *tfm)
+{
+       struct cmh_aes_tfm_ctx *tctx =3D crypto_skcipher_ctx(tfm);
+
+       cmh_key_destroy(&tctx->key);
+}
+
+#define CMH_AES_MAX_CRYPTLEN   SZ_32M
+
+/* DMA unmap helper */
+static void cmh_aes_unmap_dma(struct cmh_aes_reqctx *rctx)
+{
+       if (rctx->iv2_buf)
+               cmh_dma_unmap_single(rctx->iv2_dma, rctx->ivsize,
+                                    DMA_TO_DEVICE);
+       if (rctx->ivsize > 0)
+               cmh_dma_unmap_single(rctx->iv_dma, rctx->ivsize,
+                                    DMA_TO_DEVICE);
+       cmh_dma_unmap_single(rctx->out_dma, rctx->cryptlen, DMA_FROM_DEVICE=
);
+       cmh_dma_unmap_single(rctx->in_dma, rctx->cryptlen, DMA_TO_DEVICE);
+}
+
+static void cmh_aes_free_bufs(struct cmh_aes_reqctx *rctx)
+{
+       kfree(rctx->iv2_buf);
+       rctx->iv2_buf =3D NULL;
+       kfree(rctx->iv_buf);
+       rctx->iv_buf =3D NULL;
+       kfree_sensitive(rctx->out_buf);
+       rctx->out_buf =3D NULL;
+       kfree_sensitive(rctx->in_buf);
+       rctx->in_buf =3D NULL;
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
+       struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
+       struct cmh_aes_tfm_ctx *tctx =3D crypto_skcipher_ctx(tfm);
+       struct cmh_aes_reqctx *rctx =3D skcipher_request_ctx(req);
+       struct vcq_cmd cmds[CMH_AES_MAX_PAYLOAD];
+       u32 chunk1 =3D rctx->ctr_chunk1_len;
+       u32 chunk2 =3D rctx->cryptlen - chunk1;
+       u64 key_ref;
+       u32 keylen;
+       u32 idx =3D 0;
+
+       /* Clear split flag so next completion is final */
+       rctx->ctr_chunk1_len =3D 0;
+
+       vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+                         (u64)rctx->key_dma, SYS_REF_NONE,
+                         tctx->key.raw.len,
+                         tctx->key.raw.sys_type);
+       key_ref =3D SYS_REF_TEMP;
+       keylen =3D tctx->key.raw.len;
+
+       vcq_add_aes_init(&cmds[idx++], rctx->core_id, key_ref,
+                        (u64)rctx->iv2_dma, keylen, rctx->ivsize,
+                        rctx->aes_mode, rctx->aes_op, 0);
+       vcq_add_aes_final(&cmds[idx++], rctx->core_id,
+                         (u64)(rctx->in_dma + chunk1),
+                         (u64)(rctx->out_dma + chunk1), chunk2);
+       vcq_add_flush(&cmds[idx++], rctx->core_id);
+
+       return cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                            CMH_AES_MAX_PACKED,
+                                            rctx->target_mbx,
+                                            cmh_aes_complete, req,
+                                            !!(req->base.flags &
+                                               CRYPTO_TFM_REQ_MAY_BACKLOG)=
,
+                                            cmh_tm_async_timeout_jiffies()=
);
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
+       struct skcipher_request *req =3D data;
+       struct cmh_aes_reqctx *rctx =3D skcipher_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       /*
+        * CTR counter-wrap: first chunk completed, submit second.
+        * DMA mappings remain valid (they cover the full buffer).
+        *
+        * Recursion depth bounded: chunk2 clears ctr_chunk1_len before
+        * submission, so the second cmh_aes_complete invocation sees 0
+        * and finalizes (max depth =3D 2).
+        */
+       if (rctx->ctr_chunk1_len && !error) {
+               int ret;
+
+               ret =3D cmh_aes_ctr_submit_chunk2(req);
+
+               if (!ret || ret =3D=3D -EBUSY)
+                       return;
+               /* Submission failed; clean up below */
+               error =3D ret;
+       }
+
+       cmh_aes_unmap_dma(rctx);
+
+       if (!error) {
+               scatterwalk_map_and_copy(rctx->out_buf, req->dst,
+                                        0, rctx->cryptlen, 1);
+               cmh_aes_update_iv(req, rctx->aes_mode, rctx->aes_op,
+                                 rctx->in_buf, rctx->out_buf);
+       }
+
+       cmh_aes_free_bufs(rctx);
+       cmh_complete(&req->base, error);
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
+       struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
+       struct cmh_aes_tfm_ctx *tctx =3D crypto_skcipher_ctx(tfm);
+       const struct cmh_aes_alg_info *info =3D cmh_aes_get_info(tfm);
+       struct cmh_aes_reqctx *rctx =3D skcipher_request_ctx(req);
+       struct vcq_cmd cmds[CMH_AES_MAX_PAYLOAD];
+       u64 key_ref;
+       u32 keylen;
+       struct core_dispatch d;
+       s32 target_mbx;
+       u32 core_id;
+       u32 idx;
+       int ret;
+       gfp_t gfp;
+
+       if (tctx->key.mode =3D=3D CMH_KEY_NONE)
+               return -ENOKEY;
+
+       if (!req->cryptlen)
+               return 0;
+
+       if (req->cryptlen > CMH_AES_MAX_CRYPTLEN)
+               return -EINVAL;
+
+       switch (info->aes_mode) {
+       case AES_MODE_CTR:
+       case AES_MODE_CFB:
+               break;
+       case AES_MODE_XTS:
+               if (req->cryptlen < CMH_AES_BLOCK_SIZE)
+                       return -EINVAL;
+               break;
+       default:
+               if (req->cryptlen & (CMH_AES_BLOCK_SIZE - 1))
+                       return -EINVAL;
+               break;
+       }
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       /* Initialise reqctx */
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->cryptlen =3D req->cryptlen;
+       rctx->ivsize =3D info->ivsize;
+       rctx->aes_mode =3D info->aes_mode;
+       rctx->aes_op =3D aes_op;
+       rctx->iv2_buf =3D NULL;
+
+       /* Linearise input from scatterlist */
+       rctx->in_buf =3D kmalloc(req->cryptlen, gfp);
+       if (!rctx->in_buf)
+               return -ENOMEM;
+
+       scatterwalk_map_and_copy(rctx->in_buf, req->src, 0, req->cryptlen, =
0);
+
+       rctx->in_dma =3D cmh_dma_map_single(rctx->in_buf, req->cryptlen,
+                                         DMA_TO_DEVICE);
+       if (cmh_dma_map_error(rctx->in_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_in;
+       }
+
+       /* Allocate and map output buffer */
+       rctx->out_buf =3D kmalloc(req->cryptlen, gfp);
+       if (!rctx->out_buf) {
+               ret =3D -ENOMEM;
+               goto out_unmap_in;
+       }
+
+       rctx->out_dma =3D cmh_dma_map_single(rctx->out_buf, req->cryptlen,
+                                          DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(rctx->out_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_out;
+       }
+
+       /* Map IV if required */
+       if (info->ivsize > 0) {
+               rctx->iv_buf =3D kmemdup(req->iv, info->ivsize, gfp);
+               if (!rctx->iv_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_out;
+               }
+               rctx->iv_dma =3D cmh_dma_map_single(rctx->iv_buf, info->ivs=
ize,
+                                                 DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rctx->iv_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_free_iv;
+               }
+       }
+
+       /* Resolve key reference */
+       idx =3D 0;
+
+       rctx->key_dma =3D tctx->key.raw.dma;
+       rctx->keylen =3D tctx->key.raw.len;
+       vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+                         (u64)rctx->key_dma, SYS_REF_NONE,
+                         tctx->key.raw.len,
+                         tctx->key.raw.sys_type);
+       key_ref =3D SYS_REF_TEMP;
+       keylen =3D tctx->key.raw.len;
+       d =3D cmh_core_select_instance(CMH_CORE_AES);
+       target_mbx =3D d.mbx_idx;
+       core_id =3D d.core_id;
+
+       /*
+        * iolen in INIT: XTS needs total length upfront for tweak
+        * computation; all other modes use 0 (streaming).
+        */
+       vcq_add_aes_init(&cmds[idx++], core_id, key_ref, (u64)rctx->iv_dma,
+                        keylen, info->ivsize, info->aes_mode, aes_op,
+                        info->aes_mode =3D=3D AES_MODE_XTS ?
+                        req->cryptlen : 0);
+
+       if (info->aes_mode =3D=3D AES_MODE_XTS &&
+           req->cryptlen > 2 * CMH_AES_BLOCK_SIZE) {
+               u32 final_len, update_len;
+
+               if (req->cryptlen & (CMH_AES_BLOCK_SIZE - 1))
+                       final_len =3D CMH_AES_BLOCK_SIZE +
+                                   (req->cryptlen & (CMH_AES_BLOCK_SIZE - =
1));
+               else
+                       final_len =3D 2 * CMH_AES_BLOCK_SIZE;
+
+               update_len =3D req->cryptlen - final_len;
+
+               vcq_add_aes_update(&cmds[idx++], core_id,
+                                  (u64)rctx->in_dma,
+                                  (u64)rctx->out_dma, update_len);
+               vcq_add_aes_final(&cmds[idx++], core_id,
+                                 (u64)(rctx->in_dma + update_len),
+                                 (u64)(rctx->out_dma + update_len),
+                                 final_len);
+       } else if (info->aes_mode =3D=3D AES_MODE_CTR) {
+               /*
+                * CTR counter-wrap workaround:
+                * The AES-SCA hardware uses a 64-bit block counter.
+                * If the lower 64 bits of the IV would wrap during
+                * this operation, split into two separate VCQ
+                * transactions -- the completion callback for the
+                * first chunk submits the second.
+                */
+               u64 lower64 =3D get_unaligned_be64(rctx->iv_buf + 8);
+               u32 nblocks =3D DIV_ROUND_UP(req->cryptlen,
+                                         CMH_AES_BLOCK_SIZE);
+               u64 bwrap =3D lower64 ? (~lower64 + 1ULL) : U64_MAX;
+
+               if (nblocks > bwrap) {
+                       u32 chunk1 =3D (u32)bwrap * CMH_AES_BLOCK_SIZE;
+                       u64 upper64;
+
+                       /* Prepare second IV for chained submission */
+                       rctx->iv2_buf =3D kmalloc(info->ivsize, gfp);
+                       if (!rctx->iv2_buf) {
+                               ret =3D -ENOMEM;
+                               goto out_unmap_iv;
+                       }
+                       upper64 =3D get_unaligned_be64(rctx->iv_buf);
+                       put_unaligned_be64(upper64 + 1, rctx->iv2_buf);
+                       put_unaligned_be64(0, rctx->iv2_buf + 8);
+
+                       rctx->iv2_dma =3D
+                               cmh_dma_map_single(rctx->iv2_buf,
+                                                  info->ivsize,
+                                                  DMA_TO_DEVICE);
+                       if (cmh_dma_map_error(rctx->iv2_dma)) {
+                               ret =3D -ENOMEM;
+                               goto out_free_iv2;
+                       }
+
+                       /* Store state for the chained second submission */
+                       rctx->ctr_chunk1_len =3D chunk1;
+                       rctx->core_id =3D core_id;
+                       rctx->target_mbx =3D target_mbx;
+                       rctx->key_ref =3D key_ref;
+
+                       /* First transaction: only chunk1 */
+                       vcq_add_aes_final(&cmds[idx++], core_id,
+                                         (u64)rctx->in_dma,
+                                         (u64)rctx->out_dma, chunk1);
+               } else {
+                       /* No wrap: single FINAL with all data */
+                       vcq_add_aes_final(&cmds[idx++], core_id,
+                                         (u64)rctx->in_dma,
+                                         (u64)rctx->out_dma,
+                                         req->cryptlen);
+               }
+       } else {
+               vcq_add_aes_final(&cmds[idx++], core_id,
+                                 (u64)rctx->in_dma,
+                                 (u64)rctx->out_dma, req->cryptlen);
+       }
+
+       vcq_add_flush(&cmds[idx++], core_id);
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_AES_MAX_PACKED, target_mbx,
+                                           cmh_aes_complete, req,
+                                           !!(req->base.flags &
+                                              CRYPTO_TFM_REQ_MAY_BACKLOG),
+                                           cmh_tm_async_timeout_jiffies())=
;
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (ret)
+               goto out_cleanup_all;
+
+       return -EINPROGRESS;
+
+out_cleanup_all:
+       if (rctx->iv2_buf) {
+               cmh_dma_unmap_single(rctx->iv2_dma, info->ivsize,
+                                    DMA_TO_DEVICE);
+       }
+out_free_iv2:
+       kfree(rctx->iv2_buf);
+out_unmap_iv:
+       if (info->ivsize > 0)
+               cmh_dma_unmap_single(rctx->iv_dma, info->ivsize,
+                                    DMA_TO_DEVICE);
+out_free_iv:
+       kfree(rctx->iv_buf);
+out_unmap_out:
+       cmh_dma_unmap_single(rctx->out_dma, req->cryptlen, DMA_FROM_DEVICE)=
;
+out_free_out:
+       kfree_sensitive(rctx->out_buf);
+out_unmap_in:
+       cmh_dma_unmap_single(rctx->in_dma, req->cryptlen, DMA_TO_DEVICE);
+out_free_in:
+       kfree_sensitive(rctx->in_buf);
+       return ret;
+}
+
+static int cmh_aes_encrypt(struct skcipher_request *req)
+{
+       return cmh_aes_crypt(req, AES_OP_ENCRYPT);
+}
+
+static int cmh_aes_decrypt(struct skcipher_request *req)
+{
+       return cmh_aes_crypt(req, AES_OP_DECRYPT);
+}
+
+/* Registration */
+
+static struct cmh_aes_alg_drv aes_drv_algs[ARRAY_SIZE(aes_algs)];
+
+/**
+ * cmh_aes_register() - Register AES-CBC/CTR/ECB/XTS skcipher algorithms w=
ith the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_aes_register(void)
+{
+       unsigned int i;
+       int ret;
+
+       for (i =3D 0; i < ARRAY_SIZE(aes_algs); i++) {
+               const struct cmh_aes_alg_info *info =3D &aes_algs[i];
+               struct cmh_aes_alg_drv *drv =3D &aes_drv_algs[i];
+               struct skcipher_alg *alg =3D &drv->alg;
+
+               drv->info =3D info;
+
+               memset(alg, 0, sizeof(*alg));
+
+               alg->setkey      =3D cmh_aes_setkey;
+               alg->encrypt     =3D cmh_aes_encrypt;
+               alg->decrypt     =3D cmh_aes_decrypt;
+               alg->init        =3D cmh_aes_init_tfm;
+               alg->exit        =3D cmh_aes_exit_tfm;
+               alg->min_keysize =3D info->min_keysize;
+               alg->max_keysize =3D info->max_keysize;
+               alg->ivsize      =3D info->ivsize;
+
+               strscpy(alg->base.cra_name, info->alg_name,
+                       CRYPTO_MAX_ALG_NAME);
+               strscpy(alg->base.cra_driver_name, info->drv_name,
+                       CRYPTO_MAX_ALG_NAME);
+               alg->base.cra_priority  =3D 300;
+               alg->base.cra_flags     =3D CRYPTO_ALG_KERN_DRIVER_ONLY |
+                                         CRYPTO_ALG_ASYNC;
+               alg->base.cra_blocksize =3D aes_is_stream_mode(info->aes_mo=
de)
+                                         ? 1 : CMH_AES_BLOCK_SIZE;
+               alg->base.cra_ctxsize  =3D sizeof(struct cmh_aes_tfm_ctx);
+               alg->base.cra_module   =3D THIS_MODULE;
+
+               ret =3D crypto_register_skcipher(alg);
+               if (ret) {
+                       dev_err(cmh_dev(), "cmh_aes: failed to register %s =
(rc=3D%d)\n",
+                               info->alg_name, ret);
+                       goto err_unregister;
+               }
+
+               dev_dbg(cmh_dev(), "cmh_aes: registered %s\n", info->alg_na=
me);
+       }
+
+       return 0;
+
+err_unregister:
+       while (i--)
+               crypto_unregister_skcipher(&aes_drv_algs[i].alg);
+       return ret;
+}
+
+/**
+ * cmh_aes_unregister() - Unregister AES skcipher algorithms from the cryp=
to framework
+ */
+void cmh_aes_unregister(void)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(aes_algs); i++) {
+               crypto_unregister_skcipher(&aes_drv_algs[i].alg);
+               dev_dbg(cmh_dev(), "cmh_aes: unregistered %s\n", aes_algs[i=
].alg_name);
+       }
+}
diff --git a/drivers/crypto/cmh/cmh_aes_aead.c b/drivers/crypto/cmh/cmh_aes=
_aead.c
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
+ * GCM: AES_CMD_INIT(mode=3DGCM) + [AAD_FINAL] + AES_CMD_FINAL + FLUSH
+ *   - Standard 12-byte IV (nonce), 16-byte tag
+ *   - AES_CMD_INIT carries aadlen/iolen/taglen
+ *   - AES_CMD_FINAL carries tag DMA for encrypt (produce) / decrypt (veri=
fy)
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
+ *   IV[0..11]  =3D user-supplied 12-byte nonce
+ *   IV[12..15] =3D 0x00000000
+ *
+ * The hardware internally sets the last 32 bits to the big-endian
+ * counter value 1 (forming J0 =3D nonce || 0x00000001) before
+ * processing AAD.  The driver must NOT pre-set the counter.
+ *
+ * If the IV format is incorrect, GCM authentication will fail
+ * (encrypt produces wrong ciphertext/tag, decrypt rejects).
+ */
+#define AES_GCM_IV_SIZE                12U     /* GCM nonce size (standard=
) */
+#define AES_GCM_HW_IV_SIZE     16U     /* HW requires 16-byte IV buffer */
+#define AES_GCM_TAG_SIZE       16U
+
+/* CCM: callers pass a 16-byte IV in RFC 3610 format:
+ * iv[0] =3D L-1, iv[1..14-iv[0]] =3D nonce, rest =3D counter (zeroed).
+ * Nonce length =3D 14 - iv[0], range 7..13.
+ */
+#define AES_CCM_IV_SIZE        16U
+
+enum cmh_aes_aead_type {
+       CMH_AES_AEAD_GCM,
+       CMH_AES_AEAD_CCM,
+};
+
+struct cmh_aes_aead_info {
+       enum cmh_aes_aead_type type;
+       u32         aes_mode;   /* AES_MODE_GCM or AES_MODE_CCM */
+       u32         ivsize;
+       u32         maxauthsize;
+       const char *alg_name;
+       const char *drv_name;
+};
+
+static const struct cmh_aes_aead_info aes_aead_algs[] =3D {
+       { CMH_AES_AEAD_GCM, AES_MODE_GCM, AES_GCM_IV_SIZE,
+         AES_GCM_TAG_SIZE, "gcm(aes)", "cri-cmh-gcm-aes" },
+       { CMH_AES_AEAD_CCM, AES_MODE_CCM, AES_CCM_IV_SIZE,
+         AES_GCM_TAG_SIZE, "ccm(aes)", "cri-cmh-ccm-aes" },
+};
+
+struct cmh_aes_aead_tfm_ctx {
+       struct cmh_key_ctx key;
+       u32 authsize;           /* tag length set by setauthsize */
+       struct crypto_cipher *sw_cipher;        /* CCM empty-input fallback=
 */
+       struct crypto_aead *fallback;   /* CCM authsize=3D10 fallback */
+};
+
+/* Per-request context (lives in aead_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + AES_CMD_INIT + AAD_FINAL + AES_CMD_FINAL + FLUSH =
=3D 5
+ */
+#define CMH_AES_AEAD_MAX_PAYLOAD       5
+#define CMH_AES_AEAD_MAX_PACKED                (CMH_AES_AEAD_MAX_PAYLOAD *=
 2)
+
+struct cmh_aes_aead_reqctx {
+       dma_addr_t in_dma;
+       dma_addr_t out_dma;
+       dma_addr_t iv_dma;
+       dma_addr_t key_dma;
+       dma_addr_t aad_dma;
+       dma_addr_t tag_dma;
+       u8 *in_buf;
+       u8 *out_buf;
+       u8 *iv_buf;
+       u8 *aad_buf;
+       u8 *tag_buf;
+       u32 cryptlen;
+       u32 assoclen;
+       u32 authsize;
+       u32 iv_map_len;
+       u32 keylen;
+       bool encrypting;
+       bool empty_gcm_fallback;
+       struct vcq_cmd packed[CMH_AES_AEAD_MAX_PACKED];
+};
+
+struct cmh_aes_aead_drv {
+       struct aead_alg                  alg;
+       const struct cmh_aes_aead_info  *info;
+};
+
+static const struct cmh_aes_aead_info *
+cmh_aes_aead_get_info(struct crypto_aead *tfm)
+{
+       struct aead_alg *alg =3D crypto_aead_alg(tfm);
+
+       return container_of(alg, struct cmh_aes_aead_drv, alg)->info;
+}
+
+/* VCQ Builders -- AEAD-specific */
+
+static void vcq_add_aes_aead_init(struct vcq_cmd *slot, u32 core_id, u64 k=
ey_ref,
+                                 u64 iv_dma, u32 keylen, u32 ivlen,
+                                 u32 mode, u32 op, u32 aadlen, u32 iolen,
+                                 u32 taglen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_INIT);
+       slot->hwc.aes.cmd_init.key =3D key_ref;
+       slot->hwc.aes.cmd_init.iv =3D iv_dma;
+       slot->hwc.aes.cmd_init.keylen =3D keylen;
+       slot->hwc.aes.cmd_init.ivlen =3D ivlen;
+       slot->hwc.aes.cmd_init.mode =3D mode;
+       slot->hwc.aes.cmd_init.op =3D op;
+       slot->hwc.aes.cmd_init.aadlen =3D aadlen;
+       slot->hwc.aes.cmd_init.iolen =3D iolen;
+       slot->hwc.aes.cmd_init.taglen =3D taglen;
+}
+
+static void vcq_add_aes_ccm_init(struct vcq_cmd *slot, u32 core_id, u64 ke=
y_ref,
+                                u64 nonce_dma, u32 keylen, u32 noncelen,
+                                u32 op, u32 aadlen, u32 iolen, u32 taglen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_CCM_INIT);
+       slot->hwc.aes.cmd_init.key =3D key_ref;
+       slot->hwc.aes.cmd_init.iv =3D nonce_dma;
+       slot->hwc.aes.cmd_init.keylen =3D keylen;
+       slot->hwc.aes.cmd_init.ivlen =3D noncelen;
+       slot->hwc.aes.cmd_init.mode =3D AES_MODE_CCM;
+       slot->hwc.aes.cmd_init.op =3D op;
+       slot->hwc.aes.cmd_init.aadlen =3D aadlen;
+       slot->hwc.aes.cmd_init.iolen =3D iolen;
+       slot->hwc.aes.cmd_init.taglen =3D taglen;
+}
+
+static void vcq_add_aes_aad_final(struct vcq_cmd *slot, u32 core_id, u64 a=
ad_dma,
+                                 u32 aadlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_AAD_FINAL);
+       slot->hwc.aes.cmd_aad_final.data =3D aad_dma;
+       slot->hwc.aes.cmd_aad_final.datalen =3D aadlen;
+}
+
+static void vcq_add_aes_aead_final(struct vcq_cmd *slot, u32 core_id, u64 =
input_dma,
+                                  u64 output_dma, u64 tag_dma,
+                                  u32 iolen, u32 taglen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_FINAL);
+       slot->hwc.aes.cmd_final.input =3D input_dma;
+       slot->hwc.aes.cmd_final.output =3D output_dma;
+       slot->hwc.aes.cmd_final.tag =3D tag_dma;
+       slot->hwc.aes.cmd_final.iolen =3D iolen;
+       slot->hwc.aes.cmd_final.taglen =3D taglen;
+}
+
+/* setkey */
+static int cmh_aes_aead_setkey(struct crypto_aead *tfm, const u8 *key,
+                              unsigned int keylen)
+{
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+       int ret;
+
+       if (keylen !=3D 16 && keylen !=3D 24 && keylen !=3D 32)
+               return -EINVAL;
+
+       /* Keep SW fallback ciphers in sync for CCM edge cases */
+       if (tctx->sw_cipher) {
+               ret =3D crypto_cipher_setkey(tctx->sw_cipher, key, keylen);
+               if (ret)
+                       return ret;
+       }
+       if (tctx->fallback) {
+               ret =3D crypto_aead_setkey(tctx->fallback, key, keylen);
+               if (ret)
+                       return ret;
+       }
+
+       ret =3D cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_AES);
+
+       return ret;
+}
+
+static int cmh_aes_aead_setauthsize(struct crypto_aead *tfm,
+                                   unsigned int authsize)
+{
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+       const struct cmh_aes_aead_info *info =3D cmh_aes_aead_get_info(tfm)=
;
+       int ret;
+
+       if (info->type =3D=3D CMH_AES_AEAD_GCM) {
+               /* GCM: accept 4, 8, 12, 13, 14, 15, 16 per NIST SP 800-38D=
 */
+               if (authsize < 4 || authsize > 16 ||
+                   (authsize > 4 && authsize < 8) ||
+                   (authsize > 8 && authsize < 12))
+                       return -EINVAL;
+       } else {
+               /* CCM: accept all RFC 3610 values {4,6,8,10,12,14,16} */
+               if (authsize < 4 || authsize > 16 || (authsize & 1))
+                       return -EINVAL;
+               /* Forward to SW fallback for authsize=3D10 (HW unsupported=
) */
+               if (tctx->fallback) {
+                       ret =3D crypto_aead_setauthsize(tctx->fallback,
+                                                     authsize);
+                       if (ret)
+                               return ret;
+               }
+       }
+
+       tctx->authsize =3D authsize;
+       return 0;
+}
+
+static int cmh_aes_aead_init_tfm(struct crypto_aead *tfm)
+{
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+       const struct cmh_aes_aead_info *info =3D cmh_aes_aead_get_info(tfm)=
;
+
+       memset(tctx, 0, sizeof(*tctx));
+       tctx->authsize =3D info->maxauthsize;
+
+       if (info->type =3D=3D CMH_AES_AEAD_CCM) {
+               struct crypto_aead *fb;
+               struct crypto_cipher *ci;
+
+               ci =3D crypto_alloc_cipher("aes", 0, 0);
+               if (IS_ERR(ci))
+                       return PTR_ERR(ci);
+               tctx->sw_cipher =3D ci;
+
+               fb =3D crypto_alloc_aead("ccm(aes)", 0,
+                                      CRYPTO_ALG_NEED_FALLBACK);
+               if (IS_ERR(fb)) {
+                       crypto_free_cipher(ci);
+                       tctx->sw_cipher =3D NULL;
+                       return PTR_ERR(fb);
+               }
+               tctx->fallback =3D fb;
+
+               /*
+                * Subreq lives at (rctx + 1).  Alignment is guaranteed
+                * by the crypto framework's __ctx ALIGN mechanism.
+                */
+               crypto_aead_set_reqsize(tfm,
+                                       sizeof(struct cmh_aes_aead_reqctx) =
+
+                                       sizeof(struct aead_request) +
+                                       crypto_aead_reqsize(fb));
+       } else {
+               crypto_aead_set_reqsize(tfm,
+                                       sizeof(struct cmh_aes_aead_reqctx))=
;
+       }
+
+       return 0;
+}
+
+static void cmh_aes_aead_exit_tfm(struct crypto_aead *tfm)
+{
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+
+       if (tctx->fallback)
+               crypto_free_aead(tctx->fallback);
+       if (tctx->sw_cipher)
+               crypto_free_cipher(tctx->sw_cipher);
+       cmh_key_destroy(&tctx->key);
+}
+
+/* DMA unmap helper */
+static void cmh_aes_aead_unmap_dma(struct cmh_aes_aead_reqctx *rctx)
+{
+       u32 tag_map_len;
+
+       cmh_dma_unmap_single(rctx->iv_dma, rctx->iv_map_len, DMA_TO_DEVICE)=
;
+       /*
+        * The empty-GCM fallback maps a full AES block (16 bytes) for the
+        * ECB output regardless of authsize, so unmap with the mapped size=
.
+        */
+       tag_map_len =3D rctx->empty_gcm_fallback ?
+                     AES_GCM_HW_IV_SIZE : rctx->authsize;
+       cmh_dma_unmap_single(rctx->tag_dma, tag_map_len,
+                            (rctx->encrypting || rctx->empty_gcm_fallback)=
 ?
+                             DMA_FROM_DEVICE : DMA_TO_DEVICE);
+       if (rctx->cryptlen > 0) {
+               cmh_dma_unmap_single(rctx->out_dma, rctx->cryptlen,
+                                    DMA_FROM_DEVICE);
+               cmh_dma_unmap_single(rctx->in_dma, rctx->cryptlen,
+                                    DMA_TO_DEVICE);
+       }
+       if (rctx->assoclen > 0)
+               cmh_dma_unmap_single(rctx->aad_dma, rctx->assoclen,
+                                    DMA_TO_DEVICE);
+}
+
+static void cmh_aes_aead_free_bufs(struct cmh_aes_aead_reqctx *rctx)
+{
+       kfree(rctx->iv_buf);
+       rctx->iv_buf =3D NULL;
+       kfree(rctx->tag_buf);
+       rctx->tag_buf =3D NULL;
+       kfree_sensitive(rctx->out_buf);
+       rctx->out_buf =3D NULL;
+       kfree_sensitive(rctx->in_buf);
+       rctx->in_buf =3D NULL;
+       kfree(rctx->aad_buf);
+       rctx->aad_buf =3D NULL;
+}
+
+static void cmh_aes_aead_complete(void *data, int error)
+{
+       struct aead_request *req =3D data;
+       struct cmh_aes_aead_reqctx *rctx =3D aead_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       cmh_aes_aead_unmap_dma(rctx);
+
+       /*
+        * Map HW error on decrypt to -EBADMSG.  The eSW AES core uses a
+        * single error code (-EIO) for both authentication failures and
+        * other core errors (e.g. DMA timeout), so we cannot distinguish
+        * them from the MBX_STATUS alone.  In practice the only error
+        * during a well-formed AEAD decrypt is auth-tag mismatch; a DMA
+        * timeout would indicate a fatal HW problem where -EBADMSG vs
+        * -EIO is moot.  The kernel crypto API requires -EBADMSG for
+        * AEAD authentication failures.
+        */
+       if (error =3D=3D -EIO && !rctx->encrypting)
+               error =3D -EBADMSG;
+
+       if (!error) {
+               /* GCM empty-input decrypt: compare computed tag with expec=
ted */
+               if (rctx->empty_gcm_fallback && !rctx->encrypting) {
+                       if (crypto_memneq(rctx->tag_buf, rctx->in_buf,
+                                         rctx->authsize))
+                               error =3D -EBADMSG;
+               }
+               if (!error && rctx->cryptlen > 0)
+                       scatterwalk_map_and_copy(rctx->out_buf, req->dst,
+                                                req->assoclen,
+                                               rctx->cryptlen, 1);
+               if (!error && rctx->encrypting)
+                       scatterwalk_map_and_copy(rctx->tag_buf, req->dst,
+                                                req->assoclen +
+                                               rctx->cryptlen,
+                                               rctx->authsize, 1);
+       }
+
+       cmh_aes_aead_free_bufs(rctx);
+       cmh_complete(&req->base, error);
+}
+
+/*
+ * GCM empty-input fallback.
+ *
+ * When both AAD and plaintext are empty, GCM reduces to:
+ *   tag =3D E(K, J0) where J0 =3D nonce || 0x00000001
+ *
+ * The eSW GCM engine rejects this degenerate case, so we compute it
+ * via a single ECB block encryption of J0.
+ *
+ * VCQ: [SYS_CMD_WRITE] + AES_CMD_INIT(ECB) + AES_CMD_FINAL + FLUSH
+ */
+static int cmh_aes_gcm_empty(struct aead_request *req, u32 aes_op)
+{
+       struct crypto_aead *tfm =3D crypto_aead_reqtfm(req);
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+       struct cmh_aes_aead_reqctx *rctx =3D aead_request_ctx(req);
+       struct vcq_cmd cmds[CMH_AES_AEAD_MAX_PAYLOAD];
+       u64 key_ref;
+       u32 keylen, authsize;
+       struct core_dispatch d;
+       s32 target_mbx;
+       u32 core_id;
+       u32 idx;
+       int ret;
+       gfp_t gfp;
+
+       authsize =3D tctx->authsize;
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->cryptlen =3D 0;
+       rctx->assoclen =3D 0;
+       rctx->authsize =3D authsize;
+       rctx->encrypting =3D (aes_op =3D=3D AES_OP_ENCRYPT);
+       rctx->empty_gcm_fallback =3D true;
+
+       /* Build J0 =3D nonce || 0x00000001 in iv_buf */
+       rctx->iv_buf =3D kzalloc(AES_GCM_HW_IV_SIZE, gfp);
+       if (!rctx->iv_buf)
+               return -ENOMEM;
+       memcpy(rctx->iv_buf, req->iv, AES_GCM_IV_SIZE);
+       rctx->iv_buf[15] =3D 0x01; /* big-endian counter =3D 1 */
+       rctx->iv_map_len =3D AES_GCM_HW_IV_SIZE;
+
+       rctx->iv_dma =3D cmh_dma_map_single(rctx->iv_buf, AES_GCM_HW_IV_SIZ=
E,
+                                         DMA_TO_DEVICE);
+       if (cmh_dma_map_error(rctx->iv_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_iv;
+       }
+
+       /* Tag buffer -- receives E(K, J0) output */
+       rctx->tag_buf =3D kzalloc(AES_GCM_HW_IV_SIZE, gfp);
+       if (!rctx->tag_buf) {
+               ret =3D -ENOMEM;
+               goto out_unmap_iv;
+       }
+       rctx->tag_dma =3D cmh_dma_map_single(rctx->tag_buf, AES_GCM_HW_IV_S=
IZE,
+                                          DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(rctx->tag_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_tag;
+       }
+
+       /* For decrypt: read expected tag from request for later comparison=
 */
+       if (!rctx->encrypting) {
+               rctx->in_buf =3D kmalloc(authsize, gfp);
+               if (!rctx->in_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_tag;
+               }
+               scatterwalk_map_and_copy(rctx->in_buf, req->src, 0,
+                                        authsize, 0);
+       }
+
+       /* Resolve key */
+       idx =3D 0;
+       rctx->key_dma =3D tctx->key.raw.dma;
+       vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+                         (u64)rctx->key_dma, SYS_REF_NONE,
+                         tctx->key.raw.len,
+                         tctx->key.raw.sys_type);
+       key_ref =3D SYS_REF_TEMP;
+       keylen =3D tctx->key.raw.len;
+       d =3D cmh_core_select_instance(CMH_CORE_AES);
+       target_mbx =3D d.mbx_idx;
+       core_id =3D d.core_id;
+
+       /* ECB INIT: single block encryption of J0 */
+       vcq_add_aes_aead_init(&cmds[idx++], core_id, key_ref,
+                             0, keylen, 0, AES_MODE_ECB, AES_OP_ENCRYPT,
+                             0, AES_GCM_HW_IV_SIZE, 0);
+
+       /* FINAL: J0 in, E(K,J0) out */
+       vcq_add_aes_aead_final(&cmds[idx++], core_id,
+                              (u64)rctx->iv_dma, (u64)rctx->tag_dma,
+                              0, AES_GCM_HW_IV_SIZE, 0);
+
+       vcq_add_flush(&cmds[idx++], core_id);
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_AES_AEAD_MAX_PACKED,
+                                           target_mbx,
+                                           cmh_aes_aead_complete, req,
+                                           !!(req->base.flags &
+                                              CRYPTO_TFM_REQ_MAY_BACKLOG),
+                                           cmh_tm_async_timeout_jiffies())=
;
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (ret)
+               goto out_free_in;
+
+       return -EINPROGRESS;
+
+out_free_in:
+       kfree_sensitive(rctx->in_buf);
+out_unmap_tag:
+       cmh_dma_unmap_single(rctx->tag_dma, AES_GCM_HW_IV_SIZE,
+                            DMA_FROM_DEVICE);
+out_free_tag:
+       kfree(rctx->tag_buf);
+out_unmap_iv:
+       cmh_dma_unmap_single(rctx->iv_dma, AES_GCM_HW_IV_SIZE, DMA_TO_DEVIC=
E);
+out_free_iv:
+       kfree(rctx->iv_buf);
+       return ret;
+}
+
+/*
+ * CCM empty-input fallback.
+ *
+ * When both AAD and plaintext are empty, CCM reduces to:
+ *   T  =3D E(K, B0)    -- CBC-MAC of the single formatting block
+ *   S0 =3D E(K, A0)    -- CTR block zero
+ *   tag =3D (T XOR S0)[0..authsize-1]
+ *
+ * The eSW rejects this degenerate case, so the driver computes it
+ * synchronously via two crypto_cipher single-block encryptions.
+ */
+static int cmh_aes_ccm_empty(struct aead_request *req, u32 aes_op)
+{
+       struct crypto_aead *tfm =3D crypto_aead_reqtfm(req);
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+       u32 authsize =3D tctx->authsize;
+       u8 b0[CMH_AES_BLOCK_SIZE], a0[CMH_AES_BLOCK_SIZE];
+       u8 t[CMH_AES_BLOCK_SIZE], s0[CMH_AES_BLOCK_SIZE];
+       u8 tag[CMH_AES_BLOCK_SIZE];
+       u8 L;
+       u32 i;
+
+       /* Defense-in-depth: iv[0] =3D L-1, valid L is 2..8 per RFC 3610 S2=
.1 */
+       if (WARN_ON_ONCE(req->iv[0] < 1 || req->iv[0] > 7))
+               return -EINVAL;
+
+       L =3D req->iv[0] + 1;
+
+       if (tctx->key.mode !=3D CMH_KEY_RAW)
+               return -EOPNOTSUPP;
+
+       /* B0: flags || nonce || Q(=3D0).  Adata=3D0, t=3Dauthsize, q=3DL. =
*/
+       memset(b0, 0, CMH_AES_BLOCK_SIZE);
+       b0[0] =3D (u8)(8 * ((authsize - 2) / 2) + (L - 1));
+       memcpy(&b0[1], &req->iv[1], 15 - L);
+
+       /* A0: (L-1) || nonce || counter(=3D0) */
+       memset(a0, 0, CMH_AES_BLOCK_SIZE);
+       a0[0] =3D (u8)(L - 1);
+       memcpy(&a0[1], &req->iv[1], 15 - L);
+
+       crypto_cipher_encrypt_one(tctx->sw_cipher, t, b0);
+       crypto_cipher_encrypt_one(tctx->sw_cipher, s0, a0);
+
+       for (i =3D 0; i < authsize; i++)
+               tag[i] =3D t[i] ^ s0[i];
+
+       if (aes_op =3D=3D AES_OP_ENCRYPT) {
+               scatterwalk_map_and_copy(tag, req->dst,
+                                        req->assoclen, authsize, 1);
+       } else {
+               u8 expected[CMH_AES_BLOCK_SIZE];
+
+               scatterwalk_map_and_copy(expected, req->src,
+                                        req->assoclen, authsize, 0);
+               if (crypto_memneq(tag, expected, authsize))
+                       return -EBADMSG;
+       }
+
+       return 0;
+}
+
+/*
+ * CCM authsize=3D10 fallback.
+ *
+ * The eSW AES CCM core does not support authsize=3D10 (valid per RFC 3610=
).
+ * Forward the entire request to the generic CCM implementation.
+ */
+static void cmh_aes_ccm_fb_done(void *data, int err)
+{
+       struct aead_request *req =3D data;
+
+       cmh_complete(&req->base, err);
+}
+
+static int cmh_aes_ccm_fallback(struct aead_request *req, u32 aes_op)
+{
+       struct crypto_aead *tfm =3D crypto_aead_reqtfm(req);
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+       struct cmh_aes_aead_reqctx *rctx =3D aead_request_ctx(req);
+       struct aead_request *subreq =3D (void *)(rctx + 1);
+
+       aead_request_set_tfm(subreq, tctx->fallback);
+       aead_request_set_callback(subreq, req->base.flags,
+                                 cmh_aes_ccm_fb_done, req);
+       aead_request_set_crypt(subreq, req->src, req->dst,
+                              req->cryptlen, req->iv);
+       aead_request_set_ad(subreq, req->assoclen);
+
+       return (aes_op =3D=3D AES_OP_ENCRYPT) ?
+               crypto_aead_encrypt(subreq) : crypto_aead_decrypt(subreq);
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
+       struct crypto_aead *tfm =3D crypto_aead_reqtfm(req);
+       struct cmh_aes_aead_tfm_ctx *tctx =3D crypto_aead_ctx(tfm);
+       const struct cmh_aes_aead_info *info =3D cmh_aes_aead_get_info(tfm)=
;
+       struct cmh_aes_aead_reqctx *rctx =3D aead_request_ctx(req);
+       struct vcq_cmd cmds[CMH_AES_AEAD_MAX_PAYLOAD];
+       u64 key_ref;
+       u32 keylen, authsize, cryptlen;
+       struct core_dispatch d;
+       s32 target_mbx;
+       u32 core_id;
+       u32 idx;
+       int ret;
+       gfp_t gfp;
+
+       if (tctx->key.mode =3D=3D CMH_KEY_NONE)
+               return -ENOKEY;
+
+       authsize =3D tctx->authsize;
+
+       if (aes_op =3D=3D AES_OP_ENCRYPT) {
+               cryptlen =3D req->cryptlen;
+       } else {
+               if (req->cryptlen < authsize)
+                       return -EINVAL;
+               cryptlen =3D req->cryptlen - authsize;
+       }
+
+       /*
+        * Validate CCM IV format early -- the empty-input fallback and
+        * nonce extraction both depend on iv[0] being in range [1,7].
+        */
+       if (info->type =3D=3D CMH_AES_AEAD_CCM) {
+               if (req->iv[0] < 1 || req->iv[0] > 7)
+                       return -EINVAL;
+       }
+
+       /*
+        * The CMH eSW rejects GCM/CCM when both aadlen and iolen are zero.
+        * For GCM, the tag is simply E(K, J0) -- handle with ECB fallback.
+        * For CCM, compute tag =3D E(K,B0) XOR E(K,A0) in software.
+        */
+       if (cryptlen =3D=3D 0 && req->assoclen =3D=3D 0) {
+               if (info->type =3D=3D CMH_AES_AEAD_GCM)
+                       return cmh_aes_gcm_empty(req, aes_op);
+               return cmh_aes_ccm_empty(req, aes_op);
+       }
+
+       /*
+        * HW does not support authsize=3D10 for CCM.  Forward the entire
+        * request to the generic CCM implementation.
+        */
+       if (info->type =3D=3D CMH_AES_AEAD_CCM && authsize =3D=3D 10)
+               return cmh_aes_ccm_fallback(req, aes_op);
+
+       /*
+        * HW uses a proprietary LLI scatter-gather format that is
+        * incompatible with struct scatterlist, so the payload is
+        * linearised into contiguous buffers for DMA.  Cap total
+        * size to prevent excessive memory consumption.
+        */
+       if ((u64)cryptlen + req->assoclen > SZ_1M)
+               return -EINVAL;
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->cryptlen =3D cryptlen;
+       rctx->assoclen =3D req->assoclen;
+       rctx->authsize =3D authsize;
+       rctx->encrypting =3D (aes_op =3D=3D AES_OP_ENCRYPT);
+
+       /* Linearise AAD */
+       if (req->assoclen > 0) {
+               rctx->aad_buf =3D kmalloc(req->assoclen, gfp);
+               if (!rctx->aad_buf)
+                       return -ENOMEM;
+               scatterwalk_map_and_copy(rctx->aad_buf, req->src,
+                                        0, req->assoclen, 0);
+               rctx->aad_dma =3D cmh_dma_map_single(rctx->aad_buf,
+                                                  req->assoclen,
+                                                   DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rctx->aad_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_free_aad;
+               }
+       }
+
+       /* Linearise input */
+       if (cryptlen > 0) {
+               rctx->in_buf =3D kmalloc(cryptlen, gfp);
+               if (!rctx->in_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_aad;
+               }
+               scatterwalk_map_and_copy(rctx->in_buf, req->src,
+                                        req->assoclen, cryptlen, 0);
+               rctx->in_dma =3D cmh_dma_map_single(rctx->in_buf, cryptlen,
+                                                 DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rctx->in_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_free_in;
+               }
+       }
+
+       /* Allocate output buffer */
+       if (cryptlen > 0) {
+               rctx->out_buf =3D kmalloc(cryptlen, gfp);
+               if (!rctx->out_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_in;
+               }
+               rctx->out_dma =3D cmh_dma_map_single(rctx->out_buf, cryptle=
n,
+                                                  DMA_FROM_DEVICE);
+               if (cmh_dma_map_error(rctx->out_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_free_out;
+               }
+       }
+
+       /* Tag buffer */
+       rctx->tag_buf =3D kmalloc(authsize, gfp);
+       if (!rctx->tag_buf) {
+               ret =3D -ENOMEM;
+               goto out_unmap_out;
+       }
+
+       if (!rctx->encrypting) {
+               scatterwalk_map_and_copy(rctx->tag_buf, req->src,
+                                        req->assoclen + cryptlen,
+                                       authsize, 0);
+       } else {
+               memset(rctx->tag_buf, 0, authsize);
+       }
+
+       rctx->tag_dma =3D cmh_dma_map_single(rctx->tag_buf, authsize,
+                                          rctx->encrypting ?
+                                           DMA_FROM_DEVICE : DMA_TO_DEVICE=
);
+       if (cmh_dma_map_error(rctx->tag_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_tag;
+       }
+
+       /* Map IV/nonce */
+       if (info->type =3D=3D CMH_AES_AEAD_GCM) {
+               rctx->iv_buf =3D kzalloc(AES_GCM_HW_IV_SIZE, gfp);
+               if (!rctx->iv_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_tag;
+               }
+               memcpy(rctx->iv_buf, req->iv, AES_GCM_IV_SIZE);
+               rctx->iv_map_len =3D AES_GCM_HW_IV_SIZE;
+               rctx->iv_dma =3D cmh_dma_map_single(rctx->iv_buf,
+                                                 rctx->iv_map_len,
+                                                  DMA_TO_DEVICE);
+       } else {
+               u32 noncelen;
+
+               if (req->iv[0] < 1 || req->iv[0] > 7) {
+                       ret =3D -EINVAL;
+                       goto out_unmap_tag;
+               }
+               noncelen =3D 14 - req->iv[0];
+
+               rctx->iv_buf =3D kmemdup(req->iv + 1, noncelen, gfp);
+               if (!rctx->iv_buf) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_tag;
+               }
+               rctx->iv_map_len =3D noncelen;
+               rctx->iv_dma =3D cmh_dma_map_single(rctx->iv_buf,
+                                                 rctx->iv_map_len,
+                                                  DMA_TO_DEVICE);
+       }
+       if (cmh_dma_map_error(rctx->iv_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_iv;
+       }
+
+       /* Resolve key reference */
+       idx =3D 0;
+
+       rctx->key_dma =3D tctx->key.raw.dma;
+       rctx->keylen =3D tctx->key.raw.len;
+       vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+                         (u64)rctx->key_dma, SYS_REF_NONE,
+                         tctx->key.raw.len,
+                         tctx->key.raw.sys_type);
+       key_ref =3D SYS_REF_TEMP;
+       keylen =3D tctx->key.raw.len;
+       d =3D cmh_core_select_instance(CMH_CORE_AES);
+       target_mbx =3D d.mbx_idx;
+       core_id =3D d.core_id;
+
+       /* Build INIT command */
+       if (info->type =3D=3D CMH_AES_AEAD_CCM) {
+               vcq_add_aes_ccm_init(&cmds[idx++], core_id, key_ref,
+                                    (u64)rctx->iv_dma, keylen,
+                                    rctx->iv_map_len, aes_op,
+                                    req->assoclen, cryptlen, authsize);
+       } else {
+               vcq_add_aes_aead_init(&cmds[idx++], core_id, key_ref,
+                                     (u64)rctx->iv_dma, keylen,
+                                     AES_GCM_HW_IV_SIZE, info->aes_mode,
+                                     aes_op, req->assoclen, cryptlen,
+                                     authsize);
+       }
+
+       if (req->assoclen > 0)
+               vcq_add_aes_aad_final(&cmds[idx++], core_id,
+                                     (u64)rctx->aad_dma, req->assoclen);
+
+       vcq_add_aes_aead_final(&cmds[idx++], core_id,
+                              cryptlen > 0 ? (u64)rctx->in_dma : 0,
+                              cryptlen > 0 ? (u64)rctx->out_dma : 0,
+                              (u64)rctx->tag_dma, cryptlen, authsize);
+
+       vcq_add_flush(&cmds[idx++], core_id);
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_AES_AEAD_MAX_PACKED,
+                                           target_mbx,
+                                           cmh_aes_aead_complete, req,
+                                           !!(req->base.flags &
+                                              CRYPTO_TFM_REQ_MAY_BACKLOG),
+                                           cmh_tm_async_timeout_jiffies())=
;
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (ret)
+               goto out_cleanup_all;
+
+       return -EINPROGRESS;
+
+out_cleanup_all:
+       cmh_dma_unmap_single(rctx->iv_dma, rctx->iv_map_len, DMA_TO_DEVICE)=
;
+out_free_iv:
+       kfree(rctx->iv_buf);
+out_unmap_tag:
+       cmh_dma_unmap_single(rctx->tag_dma, authsize,
+                            rctx->encrypting ? DMA_FROM_DEVICE :
+                                              DMA_TO_DEVICE);
+out_free_tag:
+       kfree(rctx->tag_buf);
+out_unmap_out:
+       if (cryptlen > 0)
+               cmh_dma_unmap_single(rctx->out_dma, cryptlen, DMA_FROM_DEVI=
CE);
+out_free_out:
+       kfree_sensitive(rctx->out_buf);
+out_unmap_in:
+       if (cryptlen > 0)
+               cmh_dma_unmap_single(rctx->in_dma, cryptlen, DMA_TO_DEVICE)=
;
+out_free_in:
+       kfree_sensitive(rctx->in_buf);
+out_unmap_aad:
+       if (req->assoclen > 0)
+               cmh_dma_unmap_single(rctx->aad_dma, req->assoclen,
+                                    DMA_TO_DEVICE);
+out_free_aad:
+       kfree(rctx->aad_buf);
+       return ret;
+}
+
+static int cmh_aes_aead_encrypt(struct aead_request *req)
+{
+       return cmh_aes_aead_crypt(req, AES_OP_ENCRYPT);
+}
+
+static int cmh_aes_aead_decrypt(struct aead_request *req)
+{
+       return cmh_aes_aead_crypt(req, AES_OP_DECRYPT);
+}
+
+/* Registration */
+
+static struct cmh_aes_aead_drv aes_aead_drv_algs[ARRAY_SIZE(aes_aead_algs)=
];
+
+/**
+ * cmh_aes_aead_register() - Register AES-GCM/CCM AEAD algorithms with the=
 crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_aes_aead_register(void)
+{
+       unsigned int i;
+       int ret;
+
+       for (i =3D 0; i < ARRAY_SIZE(aes_aead_algs); i++) {
+               const struct cmh_aes_aead_info *info =3D &aes_aead_algs[i];
+               struct cmh_aes_aead_drv *drv =3D &aes_aead_drv_algs[i];
+               struct aead_alg *alg =3D &drv->alg;
+
+               drv->info =3D info;
+
+               memset(alg, 0, sizeof(*alg));
+
+               alg->setkey      =3D cmh_aes_aead_setkey;
+               alg->setauthsize =3D cmh_aes_aead_setauthsize;
+               alg->encrypt     =3D cmh_aes_aead_encrypt;
+               alg->decrypt     =3D cmh_aes_aead_decrypt;
+               alg->init        =3D cmh_aes_aead_init_tfm;
+               alg->exit        =3D cmh_aes_aead_exit_tfm;
+               alg->ivsize      =3D info->ivsize;
+               alg->maxauthsize =3D info->maxauthsize;
+
+               strscpy(alg->base.cra_name, info->alg_name,
+                       CRYPTO_MAX_ALG_NAME);
+               strscpy(alg->base.cra_driver_name, info->drv_name,
+                       CRYPTO_MAX_ALG_NAME);
+               alg->base.cra_priority  =3D 300;
+               alg->base.cra_flags     =3D CRYPTO_ALG_KERN_DRIVER_ONLY |
+                                         CRYPTO_ALG_ASYNC;
+               if (info->type =3D=3D CMH_AES_AEAD_CCM) {
+                       alg->base.cra_flags |=3D CRYPTO_ALG_NEED_FALLBACK;
+                       /*
+                        * Bump priority above 300 so we beat the generic
+                        * ccm_base template instance.  That template inher=
its
+                        * priority (ctr + cbcmac) / 2 =3D 300 when both
+                        * constituents are at 300, and list ordering would
+                        * otherwise let it shadow our driver.
+                        */
+                       alg->base.cra_priority =3D 301;
+               }
+               alg->base.cra_blocksize =3D 1;
+               alg->base.cra_ctxsize  =3D sizeof(struct cmh_aes_aead_tfm_c=
tx);
+               alg->base.cra_module   =3D THIS_MODULE;
+
+               ret =3D crypto_register_aead(alg);
+               if (ret) {
+                       dev_err(cmh_dev(), "cmh_aes_aead: failed to registe=
r %s (rc=3D%d)\n",
+                               info->alg_name, ret);
+                       goto err_unregister;
+               }
+
+               dev_dbg(cmh_dev(), "cmh_aes_aead: registered %s\n", info->a=
lg_name);
+       }
+
+       return 0;
+
+err_unregister:
+       while (i--)
+               crypto_unregister_aead(&aes_aead_drv_algs[i].alg);
+       return ret;
+}
+
+/**
+ * cmh_aes_aead_unregister() - Unregister AES AEAD algorithms from the cry=
pto framework
+ */
+void cmh_aes_aead_unregister(void)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < ARRAY_SIZE(aes_aead_algs); i++) {
+               crypto_unregister_aead(&aes_aead_drv_algs[i].alg);
+               dev_dbg(cmh_dev(), "cmh_aes_aead: unregistered %s\n",
+                       aes_aead_algs[i].alg_name);
+       }
+}
diff --git a/drivers/crypto/cmh/cmh_aes_cmac.c b/drivers/crypto/cmh/cmh_aes=
_cmac.c
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
+#define AES_CMAC_DIGEST_SIZE   16U
+#define AES_CMAC_BLOCK_SIZE    16U
+
+/*
+ * Maximum accumulated data for CMAC -- driver-imposed, not HW.
+ *
+ * The AES core does not expose external save/restore VCQ commands,
+ * so the driver must accumulate all data in kernel memory via
+ * .update() and submit it atomically in .final().  This cap limits
+ * the per-request kernel allocation.
+ */
+#define AES_CMAC_MAX_DATA      (64 * 1024)
+
+/* Per-transform context */
+struct cmh_aes_cmac_tfm_ctx {
+       struct cmh_key_ctx key;
+       spinlock_t         chunk_lock;  /* protects all_chunks */
+       struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* One chunk per .update() call -- data is embedded via flexible array */
+struct cmh_aes_cmac_chunk {
+       struct list_head list;
+       struct list_head tfm_node; /* per-tfm orphan tracking */
+       u32 len;
+       u8 data[];
+};
+
+/* Per-request context (lives in ahash_request::__ctx) */
+
+/*
+ * Maximum payload commands:
+ *   [SYS_CMD_WRITE] + AES_CMD_INIT + AES_CMD_AAD_FINAL_AUTH + FLUSH =3D 4
+ */
+#define CMH_AES_CMAC_MAX_PAYLOAD       4
+#define CMH_AES_CMAC_MAX_PACKED                (CMH_AES_CMAC_MAX_PAYLOAD *=
 2)
+
+struct cmh_aes_cmac_reqctx {
+       struct list_head chunks;
+       u32  total_len;
+       u8  *buf;       /* linearised in final() for DMA */
+       /* DMA state for async final */
+       dma_addr_t key_dma;
+       dma_addr_t in_dma;
+       dma_addr_t tag_dma;
+       u8 *tag_buf;
+       u32 keylen;
+       struct vcq_cmd packed[CMH_AES_CMAC_MAX_PACKED];
+};
+
+/* Flat state for export/import -- holds accumulated input data only */
+struct cmh_aes_cmac_export_state {
+       u32 total_len;
+       u8  data[];
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
+       (CMH_AES_CMAC_STATE_SIZE - sizeof(struct cmh_aes_cmac_export_state)=
)
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
+                              unsigned int keylen)
+{
+       struct cmh_aes_cmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+
+       if (keylen !=3D 16 && keylen !=3D 24 && keylen !=3D 32)
+               return -EINVAL;
+
+       return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_AES);
+}
+
+static void cmh_aes_cmac_free_chunks(struct cmh_aes_cmac_reqctx *rctx,
+                                    struct cmh_aes_cmac_tfm_ctx *tctx)
+{
+       struct cmh_aes_cmac_chunk *c, *tmp;
+
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(c, tmp, &rctx->chunks, list) {
+               list_del(&c->list);
+               list_del(&c->tfm_node);
+               kfree_sensitive(c);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+       rctx->total_len =3D 0;
+}
+
+static int cmh_aes_cmac_init(struct ahash_request *req)
+{
+       struct cmh_aes_cmac_reqctx *rctx =3D ahash_request_ctx(req);
+
+       memset(rctx, 0, sizeof(*rctx));
+       INIT_LIST_HEAD(&rctx->chunks);
+       return 0;
+}
+
+static int cmh_aes_cmac_update(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_aes_cmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_aes_cmac_reqctx *rctx =3D ahash_request_ctx(req);
+       struct cmh_aes_cmac_chunk *chunk;
+       gfp_t gfp;
+       int ret;
+
+       if (!req->nbytes)
+               return 0;
+
+       if (req->nbytes > AES_CMAC_MAX_DATA - rctx->total_len) {
+               ret =3D -EINVAL;
+               goto err_free_chunks;
+       }
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       chunk =3D kmalloc(sizeof(*chunk) + req->nbytes, gfp);
+       if (!chunk) {
+               ret =3D -ENOMEM;
+               goto err_free_chunks;
+       }
+
+       chunk->len =3D req->nbytes;
+       if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+               memcpy(chunk->data, req->svirt, req->nbytes);
+       else
+               scatterwalk_map_and_copy(chunk->data, req->src,
+                                        0, req->nbytes, 0);
+
+       list_add_tail(&chunk->list, &rctx->chunks);
+       spin_lock_bh(&tctx->chunk_lock);
+       list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+       spin_unlock_bh(&tctx->chunk_lock);
+       rctx->total_len +=3D req->nbytes;
+       return 0;
+
+err_free_chunks:
+       /*
+        * Terminal error -- free all previously accumulated chunks.
+        * callers may not call .final() on error, so they would leak.
+        */
+       cmh_aes_cmac_free_chunks(rctx, tctx);
+       return ret;
+}
+
+static void cmh_aes_cmac_complete(void *data, int error)
+{
+       struct ahash_request *req =3D data;
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_aes_cmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_aes_cmac_reqctx *rctx =3D ahash_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       /* Unmap DMA */
+       if (rctx->total_len > 0)
+               cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+                                    DMA_TO_DEVICE);
+       cmh_dma_unmap_single(rctx->tag_dma, AES_CMAC_DIGEST_SIZE,
+                            DMA_FROM_DEVICE);
+
+       if (!error)
+               memcpy(req->result, rctx->tag_buf, AES_CMAC_DIGEST_SIZE);
+
+       kfree(rctx->tag_buf);
+       rctx->tag_buf =3D NULL;
+       kfree_sensitive(rctx->buf);
+       rctx->buf =3D NULL;
+       cmh_aes_cmac_free_chunks(rctx, tctx);
+       cmh_complete(&req->base, error);
+}
+
+static int cmh_aes_cmac_final(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_aes_cmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_aes_cmac_reqctx *rctx =3D ahash_request_ctx(req);
+       struct vcq_cmd cmds[CMH_AES_CMAC_MAX_PAYLOAD];
+       u64 key_ref;
+       u32 keylen;
+       struct core_dispatch d;
+       s32 target_mbx;
+       u32 core_id;
+       u32 idx;
+       int ret;
+       gfp_t gfp;
+
+       if (tctx->key.mode =3D=3D CMH_KEY_NONE) {
+               ret =3D -ENOKEY;
+               goto out_free_buf;
+       }
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       /* Linearise accumulated chunks into a contiguous buffer for DMA */
+       if (rctx->total_len > 0) {
+               struct cmh_aes_cmac_chunk *c;
+               u32 off =3D 0;
+
+               rctx->buf =3D kmalloc(rctx->total_len, gfp);
+               if (!rctx->buf) {
+                       ret =3D -ENOMEM;
+                       goto out_free_chunks;
+               }
+               list_for_each_entry(c, &rctx->chunks, list) {
+                       memcpy(rctx->buf + off, c->data, c->len);
+                       off +=3D c->len;
+               }
+       }
+
+       /* Tag output buffer */
+       rctx->tag_buf =3D kzalloc(AES_CMAC_DIGEST_SIZE, gfp);
+       if (!rctx->tag_buf) {
+               ret =3D -ENOMEM;
+               goto out_free_buf;
+       }
+
+       rctx->tag_dma =3D cmh_dma_map_single(rctx->tag_buf,
+                                          AES_CMAC_DIGEST_SIZE,
+                                           DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(rctx->tag_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_tag;
+       }
+
+       /* Map input data (may be zero-length for empty CMAC) */
+       if (rctx->total_len > 0) {
+               rctx->in_dma =3D cmh_dma_map_single(rctx->buf, rctx->total_=
len,
+                                                 DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rctx->in_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_tag;
+               }
+       }
+
+       /* Resolve key */
+       idx =3D 0;
+
+       rctx->key_dma =3D tctx->key.raw.dma;
+       rctx->keylen =3D tctx->key.raw.len;
+       vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP,
+                         (u64)rctx->key_dma, SYS_REF_NONE,
+                         tctx->key.raw.len,
+                         tctx->key.raw.sys_type);
+       key_ref =3D SYS_REF_TEMP;
+       keylen =3D tctx->key.raw.len;
+       d =3D cmh_core_select_instance(CMH_CORE_AES);
+       target_mbx =3D d.mbx_idx;
+       core_id =3D d.core_id;
+
+       /*
+        * INIT: mode=3DCMAC, op=3DENCRYPT (CMAC always "encrypts")
+        * CMAC data goes through the AAD path:
+        *   aadlen =3D total data length, iolen =3D 0
+        */
+       {
+               struct vcq_cmd *slot =3D &cmds[idx++];
+
+               memset(slot, 0, sizeof(*slot));
+               slot->magic =3D VCQ_CMD_MAGIC;
+               slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_INIT);
+               slot->hwc.aes.cmd_init.key =3D key_ref;
+               slot->hwc.aes.cmd_init.iv =3D 0;
+               slot->hwc.aes.cmd_init.keylen =3D keylen;
+               slot->hwc.aes.cmd_init.ivlen =3D 0;
+               slot->hwc.aes.cmd_init.mode =3D AES_MODE_CMAC;
+               slot->hwc.aes.cmd_init.op =3D AES_OP_ENCRYPT;
+               slot->hwc.aes.cmd_init.aadlen =3D rctx->total_len;
+               slot->hwc.aes.cmd_init.iolen =3D 0;
+               slot->hwc.aes.cmd_init.taglen =3D AES_CMAC_DIGEST_SIZE;
+       }
+
+       /* AAD_FINAL_AUTH: final AAD + tag extraction in one atomic step */
+       {
+               struct vcq_cmd *slot =3D &cmds[idx++];
+
+               memset(slot, 0, sizeof(*slot));
+               slot->magic =3D VCQ_CMD_MAGIC;
+               slot->id =3D VCQ_CMD_ID(core_id, 0, 1, AES_CMD_AAD_FINAL_AU=
TH);
+               slot->hwc.aes.cmd_aad_final_auth.data =3D
+                       rctx->total_len > 0 ? (u64)rctx->in_dma : 0;
+               slot->hwc.aes.cmd_aad_final_auth.datalen =3D rctx->total_le=
n;
+               slot->hwc.aes.cmd_aad_final_auth.tag =3D (u64)rctx->tag_dma=
;
+               slot->hwc.aes.cmd_aad_final_auth.taglen =3D AES_CMAC_DIGEST=
_SIZE;
+       }
+
+       vcq_add_flush(&cmds[idx++], core_id);
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_AES_CMAC_MAX_PACKED,
+                                           target_mbx,
+                                           cmh_aes_cmac_complete, req,
+                                           !!(req->base.flags &
+                                              CRYPTO_TFM_REQ_MAY_BACKLOG),
+                                           cmh_tm_async_timeout_jiffies())=
;
+       /* -EBUSY =3D backlogged; ownership transferred to callback. */
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (ret)
+               goto out_cleanup_all;
+
+       return -EINPROGRESS;
+
+out_cleanup_all:
+       if (rctx->total_len > 0 && !cmh_dma_map_error(rctx->in_dma))
+               cmh_dma_unmap_single(rctx->in_dma, rctx->total_len,
+                                    DMA_TO_DEVICE);
+out_unmap_tag:
+       cmh_dma_unmap_single(rctx->tag_dma, AES_CMAC_DIGEST_SIZE,
+                            DMA_FROM_DEVICE);
+out_free_tag:
+       kfree(rctx->tag_buf);
+out_free_buf:
+out_free_chunks:
+       cmh_aes_cmac_free_chunks(rctx, tctx);
+       kfree_sensitive(rctx->buf);
+       rctx->buf =3D NULL;
+       rctx->total_len =3D 0;
+       return ret;
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
+       struct cmh_aes_cmac_reqctx *rctx =3D ahash_request_ctx(req);
+       struct cmh_aes_cmac_export_state *state =3D out;
+       struct cmh_aes_cmac_chunk *chunk;
+       u32 offset =3D 0;
+
+       if (rctx->total_len > CMH_AES_CMAC_EXPORT_MAX)
+               return -ENOSPC;
+
+       state->total_len =3D rctx->total_len;
+       list_for_each_entry(chunk, &rctx->chunks, list) {
+               memcpy(state->data + offset, chunk->data, chunk->len);
+               offset +=3D chunk->len;
+       }
+       return 0;
+}
+
+static int cmh_aes_cmac_import(struct ahash_request *req, const void *in)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_aes_cmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_aes_cmac_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_aes_cmac_export_state *state =3D in;
+       struct cmh_aes_cmac_chunk *chunk;
+
+       /*
+        * Do NOT call free_chunks() here: the crypto API does not
+        * guarantee the request context is in a valid state before
+        * import(), so the list pointers may be stale or invalid.
+        * Re-initialize from scratch instead.  Any pre-existing chunks
+        * are tracked on tctx->all_chunks and freed in exit_tfm.
+        */
+       memset(rctx, 0, sizeof(*rctx));
+       INIT_LIST_HEAD(&rctx->chunks);
+
+       if (state->total_len > CMH_AES_CMAC_EXPORT_MAX)
+               return -EINVAL;
+
+       if (state->total_len) {
+               chunk =3D kmalloc(sizeof(*chunk) + state->total_len, GFP_KE=
RNEL);
+               if (!chunk)
+                       return -ENOMEM;
+               chunk->len =3D state->total_len;
+               memcpy(chunk->data, state->data, state->total_len);
+               list_add_tail(&chunk->list, &rctx->chunks);
+               spin_lock_bh(&tctx->chunk_lock);
+               list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+               spin_unlock_bh(&tctx->chunk_lock);
+               rctx->total_len =3D state->total_len;
+       }
+       return 0;
+}
+
+static int cmh_aes_cmac_finup(struct ahash_request *req)
+{
+       int err;
+
+       err =3D cmh_aes_cmac_update(req);
+       if (err)
+               return err;
+       return cmh_aes_cmac_final(req);
+}
+
+static int cmh_aes_cmac_digest(struct ahash_request *req)
+{
+       int err;
+
+       err =3D cmh_aes_cmac_init(req);
+       if (err)
+               return err;
+       return cmh_aes_cmac_finup(req);
+}
+
+static int cmh_aes_cmac_init_tfm(struct crypto_ahash *tfm)
+{
+       struct cmh_aes_cmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+
+       memset(tctx, 0, sizeof(*tctx));
+       spin_lock_init(&tctx->chunk_lock);
+       INIT_LIST_HEAD(&tctx->all_chunks);
+       crypto_ahash_set_reqsize(tfm, sizeof(struct cmh_aes_cmac_reqctx));
+       return 0;
+}
+
+static void cmh_aes_cmac_exit_tfm(struct crypto_ahash *tfm)
+{
+       struct cmh_aes_cmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_aes_cmac_chunk *c, *tmp;
+
+       /* Free any orphaned chunks (e.g. testmgr export/reimport poison) *=
/
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(c, tmp, &tctx->all_chunks, tfm_node) {
+               list_del(&c->tfm_node);
+               kfree_sensitive(c);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+
+       cmh_key_destroy(&tctx->key);
+}
+
+static struct ahash_alg cmh_aes_cmac_alg =3D {
+       .init           =3D cmh_aes_cmac_init,
+       .update         =3D cmh_aes_cmac_update,
+       .final          =3D cmh_aes_cmac_final,
+       .finup          =3D cmh_aes_cmac_finup,
+       .digest         =3D cmh_aes_cmac_digest,
+       .export         =3D cmh_aes_cmac_export,
+       .import         =3D cmh_aes_cmac_import,
+       .setkey         =3D cmh_aes_cmac_setkey,
+       .init_tfm       =3D cmh_aes_cmac_init_tfm,
+       .exit_tfm       =3D cmh_aes_cmac_exit_tfm,
+       .halg           =3D {
+               .digestsize     =3D AES_CMAC_DIGEST_SIZE,
+               .statesize      =3D CMH_AES_CMAC_STATE_SIZE,
+               .base           =3D {
+                       .cra_name        =3D "cmac(aes)",
+                       .cra_driver_name =3D "cri-cmh-cmac-aes",
+                       .cra_priority    =3D 300,
+                       .cra_flags       =3D CRYPTO_ALG_KERN_DRIVER_ONLY |
+                                          CRYPTO_ALG_NO_FALLBACK |
+                                          CRYPTO_ALG_ASYNC |
+                                          CRYPTO_ALG_REQ_VIRT,
+                       .cra_blocksize   =3D AES_CMAC_BLOCK_SIZE,
+                       .cra_ctxsize     =3D sizeof(struct cmh_aes_cmac_tfm=
_ctx),
+                       .cra_module      =3D THIS_MODULE,
+               },
+       },
+};
+
+/**
+ * cmh_aes_cmac_register() - Register AES-CMAC hash algorithm with the cry=
pto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_aes_cmac_register(void)
+{
+       int ret;
+
+       ret =3D crypto_register_ahash(&cmh_aes_cmac_alg);
+       if (ret)
+               dev_err(cmh_dev(), "cmh_aes_cmac: failed to register cmac(a=
es) (rc=3D%d)\n",
+                       ret);
+       else
+               dev_dbg(cmh_dev(), "cmh_aes_cmac: registered cmac(aes)\n");
+
+       return ret;
+}
+
+/**
+ * cmh_aes_cmac_unregister() - Unregister AES-CMAC hash algorithm from the=
 crypto framework
+ */
+void cmh_aes_cmac_unregister(void)
+{
+       crypto_unregister_ahash(&cmh_aes_cmac_alg);
+       dev_dbg(cmh_dev(), "cmh_aes_cmac: unregistered cmac(aes)\n");
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 56541e0d4219..1edd8d14c666 100644
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
@@ -221,6 +222,21 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_sm3_register;

+       /* Register AES skcipher algorithms */
+       ret =3D cmh_aes_register();
+       if (ret)
+               goto err_aes_register;
+
+       /* Register AES AEAD algorithms (GCM, CCM) */
+       ret =3D cmh_aes_aead_register();
+       if (ret)
+               goto err_aes_aead_register;
+
+       /* Register AES CMAC algorithm */
+       ret =3D cmh_aes_cmac_register();
+       if (ret)
+               goto err_aes_cmac_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -233,6 +249,12 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_aes_cmac_unregister();
+err_aes_cmac_register:
+       cmh_aes_aead_unregister();
+err_aes_aead_register:
+       cmh_aes_unregister();
+err_aes_register:
        cmh_sm3_unregister();
 err_sm3_register:
        cmh_kmac_unregister();
@@ -269,6 +291,9 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_aes_cmac_unregister();
+       cmh_aes_aead_unregister();
+       cmh_aes_unregister();
        cmh_sm3_unregister();
        cmh_kmac_unregister();
        cmh_cshake_unregister();
diff --git a/drivers/crypto/cmh/include/cmh_aes.h b/drivers/crypto/cmh/incl=
ude/cmh_aes.h
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


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

