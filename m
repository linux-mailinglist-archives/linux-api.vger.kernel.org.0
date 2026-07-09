Return-Path: <linux-api+bounces-6810-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZeIRFzkFUGrerwIAu9opvQ
	(envelope-from <linux-api+bounces-6810-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:31:53 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5C7355C9
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:31:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=XYKVe4Ds;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6810-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6810-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9D7430174CA
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6D3D0BFB;
	Thu,  9 Jul 2026 20:31:34 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11020090.outbound.protection.outlook.com [40.93.198.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FA3CD8A4;
	Thu,  9 Jul 2026 20:31:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629093; cv=fail; b=NJa062oTUS6qx9xqd6wa8JiEigkN2iy45NG6Ao3w7boYH0QOjpPyWqdFatOL58zH0YjdbP0669hfeVAi4Kon6FBLFbPDxtBjuxnD0iJzC5fOdqQRqX3lnMp7DkfilD8Jgaj3XiNfOwJM6kBYT+nsdSWL2ihQMsAGjMHQyhBay4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629093; c=relaxed/simple;
	bh=9DbvGB77imI1MU7JIVaBd9IGQpoEmhXHG8y39Z25Glo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guTrtiqb7KXd7KhXT9FI5QTkLBLmvBxhqDmegI60pGiG79VbdoZp09AGjXdS56KiBJFriRtwW2OR0bo63vLdTN2HNwcUUStSr8CErlKY8mjTCWi5PHlIuFzdWtUkyYMa3JVEk0aLmDNHD93ZaZN/VtYrIkiqNgC4V0U7dg1gEI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=XYKVe4Ds; arc=fail smtp.client-ip=40.93.198.90
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6F8iij4a5vLv5KORVVN/RLPn+2Guh2CAyy6aXxc0BVCb1fItONn+1JRc7Kyr3yAJOuzqif10dWT7ikENu9wooqyrq7vO8tnsRb0a+CDKj+5/DNpnzyTmlbk85uCau2PsQeXY1y2sfpkDVaLQOMDmniEbXNSdj1oyl82Dk8yXIzT+0y5IrKoFGnnVpc6W1j1UEGftbASN30SO2XThYs/q2rZAY/x5eqWp7h3/eyH4vSjMzOzHgpRV5mo5JXaEWL8QPrTi2cPGKBinvxlJfphVYi/2qslmV6xEWWVVrl7o9+TImPQlIzGVVkYxzcI0yZgCeEoxCq0ECaNCwJyWmw2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eAe70nvrSjAG2BNw2BTnhrdhSiYbIbt/hwEX60N7GaU=;
 b=rjHNO1XmMSxTgu3K3scz31SQ6ZzWmD/OrmsyN17a8ZwG5ewlq7+6i/KDVvoS3kwxiqoNiwhM2LZRXF3ZVfKkReg4JDZV3VgdYU6Q15xQxHY8dHsS/5QU213N8BomlYohDVrV6Qzg9H2pjzQMBM72Q0x+Mf4FnmIRRR7Fx/q9zgSJ7sRh+Y+KpIZg8HCt9naBT3ED93m5+Vb/5v05W/fnk4farnTCsq7I/j8DbJgkKZVeSrHejfkbWewC5jaXWPOEXKGYhPjrcqEym90+RhYlZ6hbkun8+y7yzupjxKhNSO9DC6DkTqipsQaCPT38yVANDtCKZM//r5oC1i/vGDCmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAe70nvrSjAG2BNw2BTnhrdhSiYbIbt/hwEX60N7GaU=;
 b=XYKVe4Ds9Cuzt8vcb8MdVHcYSIKA8e2uKWlHCOB7JfhHZ1XchICFZf5+/7oXgY3qZkTm/zEGjOyRpaYczCgPD8gIfz0zjWzV1O9g4F/dXaJE585+rx0x06TBk0p0fiCb9f3kmPs37Bjp7U1C3GmeQH3KdQ8HAgu9/NYuQQmNFu6emgnoR3eL3A4GpoAyTg+cuK/IR7NJ7x3Z8oE4JAwCgiIGhlfUTgft4RpceAjNr+/NBCDjCQgB3BxLZEkg5wGfwwJl+96fLfTN//uEwcSv2IKTjqa2+6lE8OAIv8e9OVc5sFtK9+OrUGt30DxwzDFlPCvkeGqMEBqXcak3uQbrzw==
Received: from BN8PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:d4::30)
 by BY5PR04MB6616.namprd04.prod.outlook.com (2603:10b6:a03:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:31:21 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::15) by BN8PR04CA0056.outlook.office365.com
 (2603:10b6:408:d4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 20:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:20 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 135451801749;
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
Subject: [PATCH v2 01/19] dt-bindings: crypto: add Rambus CryptoManager Hub
Date: Thu,  9 Jul 2026 13:30:19 -0700
Message-ID: <20260709203037.1884436-2-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|BY5PR04MB6616:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a557af88-fc53-4c7d-a0d7-08deddf90985
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|3023799007|921020|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	/f1U9Cql6gOhWRK7hdAtYDoxuIjGUmxTolwYtxGFMA6OIoK7OQeOejkhWqOPCeUrZb335QGTPLzUBzWgZq7JBl2MYZrLDBeQ8K4m6ZEx1gKultDLLw/2B4DSIsHSTFy5uxrszPQQOh+u9RZp1HHzhqH+nLvvyfExQg/DcUISkDYhetA+7Yp75q0uC57EZ5hjVc1wnXmaKf1YOFw/ZAHCzUQUTmnC7gsPHpyNdJVrcAYs0X2CQS0JfX9JePFzZTfR76fBuOUWReffchi2vAgLDAsxLO91ov0P4NgY7VKZAY2BTxA4nWO8uAe77lSJXbeXv726q9nbc0/eNa24FPG05azHv5+189n4DTxPvZBg2kaPct/r2ePLoXHfnQ1xYDXy31/fbseQTEsmbeuk7f7E7YkP/SRkk60/YxTdlmD79OC6EU3Zi9XIdyof0prNKrpLBI+pBXcG0ljoPnmNzmPS9qnA0JEJQWviCmo2RniMDwEkX9jVyYfGA4Czi0LXXBaiybcYVUTlirN0Xh9+kZ4IundA68gIYeY4cjYR9TIIoDPePsp0p0CuGIK4XbbryysF1M71OG3kyd8Ws9F9zDax7HKH/dQI6Yp/zXGbAkEGtY3cBFb0PH0LLyeTHGUujrRPVP2f3LTuoAoEBf6+zz8n38lVzstePS6XyhY41DUyOk50an/pN1chANR2duLZvpE0
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(3023799007)(921020)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QfQeYaRoyvvAO3oH4jmsi04UHxJPVDVVBMVO0EmFGpC499n81XgnO8dBVdXT6zZ0FXHa4iDRvs/1O40r2PTtEQL8YfTKu600Bqof6ByurYNfYk64x8kEmQUmPqdA+TZihfAMnyh1hrTFyBGO+osiN2etN7ZzDGU8Qs1IX4oquqnSiHWAGTMgVLKzSMbQyYwsru6E90TWedKXhfwShXGIWNQQ5dSZdRzWJP9GIIcMcwHq62LIgawt1BeC03IJYUQCizvfosY08xciSPdPoh6VhQRUJW1O7vly5GI9KHqGY8L5XkDpKF49mrdev15dFoos7x9xo/Jif6C9zHnQLLnwu7GepGpkjtj/Ob4QvsSHusfzHQxxRT0nj5ej64RyTKTtimuH7bwnUApfmjo67zWK7Rc9zP079L7CQDLFw4UeC0axt0I+W5V8XaJpPOydQKq3
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:20.7770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a557af88-fc53-4c7d-a0d7-08deddf90985
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6616
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
	TAGGED_FROM(0.00)[bounces-6810-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cryptography.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11D5C7355C9

From: Alex Ousherovitch <aousherovitch@rambus.com>

Add device tree binding schema for the CRI CryptoManager Hub (CMH)
hardware crypto accelerator.  The binding covers the parent SoC-level
node with register region, interrupt, DMA properties, and per-core
child nodes identified by compatible string and unit address.

Register the 'cri' vendor prefix for Cryptography Research, Inc.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 .../devicetree/bindings/crypto/cri,cmh.yaml   | 222 ++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 2 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/cri,cmh.yaml

diff --git a/Documentation/devicetree/bindings/crypto/cri,cmh.yaml b/Documentation/devicetree/bindings/crypto/cri,cmh.yaml
new file mode 100644
index 000000000000..db41132e0591
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/cri,cmh.yaml
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/cri,cmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: CRI CryptoManager Hub (CMH) Hardware Crypto Accelerator
+
+maintainers:
+  - Alex Ousherovitch <aousherovitch@rambus.com>
+  - Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
+  - Joel Wittenauer <Joel.Wittenauer@cryptography.com>
+
+description: |
+  The CRI CryptoManager Hub (CMH) is a hardware cryptographic accelerator accessed
+  via a mailbox-based VCQ (Virtual Command Queue) interface.  The host
+  writes VCQ command sequences into per-mailbox DMA queue buffers and
+  rings a doorbell; the CMH eSW processes them and signals completion
+  via interrupt.
+
+  Supported algorithm families: SHA-2, SHA-3, SM3, AES, SM4,
+  ChaCha20-Poly1305, RSA, ECDSA, EdDSA, ECDH, SM2, ML-KEM, ML-DSA,
+  SLH-DSA, LMS, XMSS, DRBG.
+
+properties:
+  compatible:
+    const: cri,cmh
+
+  reg:
+    maxItems: 1
+    description:
+      SIC (System Interface Controller) MMIO region.  Mailbox instance
+      registers are at offsets N * 0x1000 within this region.
+
+  interrupts:
+    minItems: 1
+    maxItems: 64
+    description:
+      Per-mailbox completion/error interrupts from the CryptoManager Hub,
+      matching the real CMH ch_sys_interrupt_mbx[N-1:0] topology.
+      Entry i corresponds to MBX instance i.  The driver maps each
+      configured mailbox (cri,mbx-instances) to its DT interrupt
+      index and registers a separate threaded IRQ handler per MBX.
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 64
+    items:
+      pattern: '^mbx[0-9]+$'
+    description:
+      Names for each mailbox interrupt, matching the interrupts array.
+      Format is "mbxN" where N is the mailbox instance index.
+
+  cri,mbx-instances:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 64
+    description:
+      Array of 0-based mailbox instance indices to configure.
+      Each index N maps to register offset N * 0x1000 within the
+      SIC region.  If absent, defaults to instances 0 and 1.
+
+  cri,mbx-slots-log2:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 64
+    description:
+      Per-mailbox slot count as log2.  Valid range 1..15.
+      Array length must match cri,mbx-instances.
+      Default is 5 (32 slots).
+
+  cri,mbx-strides-log2:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 64
+    description:
+      Per-mailbox stride (bytes per slot) as log2.  Valid range 7..10.
+      Array length must match cri,mbx-instances.
+      Default is 7 (128 bytes per slot).
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^(hc|aes|sm4|sm3|hcq|qse|pke|drbg|ccp)@[0-9a-f]+$":
+    type: object
+    description:
+      Per-core-type child nodes.  Each child represents one crypto core
+      instance available in the hardware.  The driver enumerates these at
+      probe to discover which algorithm families are present.
+
+    properties:
+      reg:
+        maxItems: 1
+        description:
+          Hardware core ID for this core type (e.g. 0x02 for HC, 0x03 for AES).
+          Must match the CORE_ID_* values defined by the CMH hardware.
+
+      cri,mbx:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Pin this core instance to a specific mailbox instance index.
+          Multiple child nodes of the same core type may each specify a
+          different cri,mbx value to spread instances across mailboxes.
+          When absent, the driver auto-assigns a mailbox via round-robin
+          across the instances listed in cri,mbx-instances.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        crypto@a4800000 {
+            compatible = "cri,cmh";
+            reg = <0x0 0xa4800000 0x0 0x41000>;
+            interrupts = <1 2>;
+            interrupt-names = "mbx0", "mbx1";
+            cri,mbx-instances = <0 1>;
+            cri,mbx-slots-log2 = <5 5>;
+            cri,mbx-strides-log2 = <7 7>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            hc@2 {
+                reg = <0x02>;
+            };
+
+            aes@3 {
+                reg = <0x03>;
+            };
+
+            sm4@4 {
+                reg = <0x04>;
+            };
+
+            sm3@5 {
+                reg = <0x05>;
+            };
+
+            hcq@8 {
+                reg = <0x08>;
+            };
+
+            qse@9 {
+                reg = <0x09>;
+            };
+
+            pke@a {
+                reg = <0x0a>;
+                cri,mbx = <1>;
+            };
+
+            drbg@f {
+                reg = <0x0f>;
+            };
+
+            ccp@18 {
+                reg = <0x18>;
+            };
+        };
+    };
+
+  - |
+    /* Multi-instance: two AES cores on separate MBXes (future eSW support) */
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        crypto@a4800000 {
+            compatible = "cri,cmh";
+            reg = <0x0 0xa4800000 0x0 0x41000>;
+            interrupts = <1 2>;
+            interrupt-names = "mbx0", "mbx1";
+            cri,mbx-instances = <0 1>;
+            cri,mbx-slots-log2 = <5 5>;
+            cri,mbx-strides-log2 = <7 7>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            hc@2 {
+                reg = <0x02>;
+            };
+
+            aes@3 {
+                reg = <0x03>;
+                cri,mbx = <0>;
+            };
+
+            /* Second AES instance at core ID 0x06, pinned to MBX 1 */
+            aes@6 {
+                reg = <0x06>;
+                cri,mbx = <1>;
+            };
+
+            pke@a {
+                reg = <0x0a>;
+                cri,mbx = <1>;
+            };
+
+            drbg@f {
+                reg = <0x0f>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 396044f368e7..8b7187ea0194 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -375,6 +375,8 @@ patternProperties:
     description: Crane Connectivity Solutions
   "^creative,.*":
     description: Creative Technology Ltd
+  "^cri,.*":
+    description: Cryptography Research, Inc.
   "^crystalfontz,.*":
     description: Crystalfontz America, Inc.
   "^csky,.*":
-- 
2.43.7


