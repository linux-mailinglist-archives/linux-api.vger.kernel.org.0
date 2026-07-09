Return-Path: <linux-api+bounces-6807-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JEyHCyoFUGrQrwIAu9opvQ
	(envelope-from <linux-api+bounces-6807-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:31:38 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9222B7355A7
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:31:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=5p1fdGvC;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6807-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6807-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87B1E3039256
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937D43CB8FB;
	Thu,  9 Jul 2026 20:31:29 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022089.outbound.protection.outlook.com [40.107.209.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973C3BB690;
	Thu,  9 Jul 2026 20:31:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629089; cv=fail; b=nGV9gpJXR6KGXRw+D4ConboE98V8ALNdeYA6yvNnHlSDHVj9UcVt8cO30/OyNL3mmbBeOd7FYROEteBBJXWaaZIMGjeT4EYw4yNZCLBPJReOtbHSdo/TEc97v62vjKX3JnZFpv99RLTgbFZ7Rd9CrQnyccdm2jPT+SPgyzE/y/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629089; c=relaxed/simple;
	bh=RXH+7StCTr2wb1/D2sV6JgqxomTmuS3kWEDJthweZSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pudvVdzxpcvM2Y09jk2bEitFSMOgKS1fR1ztqF7XFKrqOwrBL9hCBE39eZNRjz3iTdjl7UAMSdyrg5/MmC/HBAJ63nmjpgUjCv0GrDgLeTS/weO64fYuQieYc22/dWwuaPugAA85DtXYL5P/n3emsPt/fy+UekTUoPpKf01YYMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=5p1fdGvC; arc=fail smtp.client-ip=40.107.209.89
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LG9AHbfbP6kitddVFbAGelgYLTUjF6pVNOUgO2NBzYDn1gZrpyqgOpy10AR+pBcxHl/FmdaG95GXtfkqF2IRqulyVVHWur1RgxRUHkaIdp6RCXu4rRqgGTf++fg+Xg1ug7E2QlB3huDawNeF02xQhjB6+DDAQhtQGinfOsCEl/UwFQ9dxmaWR79AOsSYUnK9bBIkRrau06JGllOa0bSMhZALERLj/5y6QcH2n5Xsve0l+cdA8/OEnJ5WwEEunk/+h/SpDwRcHyz3yJb7g0in+/CtyK2KGFEvTn44dyNLkvn0dzFWdeRN0w0U3vWOZQXvFqt+d42gIXDHyOatJE81aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2Gvlj7CPrvOIDQ5v7xoQ92Y6S2eisSDD4WdQ+mG380=;
 b=YY7PDA8jT9REo9rStfMWtGJSo35J2hO+mXrWPLlxQhFHLmr/l+sGfNydiyEDAe7qRFDVdSIj8h2auXhPOoMLVBW8gEauWIHfny19+wt+SPfGJsm8FaKjyWr3aXeR3bM6rXsL4VAZHYh69Tbk16TnB+eUBDW+c4imzYvOS9/Of+THhL2j7cNG0fMlZvp6kEvNQ/ClAna3ifwhtY/TRVl3O+A7FtNBDqdezgqOyzBHT3/+EJrBh1pAj8MwaNoTPKloDwBTw8Gfq1mF/PHZj2/e0RNT8f1rGE5WzoHO24aBlVCfYs5OCfGOUXJ1GaIUFI4qsuIXo/gCTUT2j7bWODGsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2Gvlj7CPrvOIDQ5v7xoQ92Y6S2eisSDD4WdQ+mG380=;
 b=5p1fdGvCgQzlenrQkWz+Jggh/ijxw0yAXOd297hFGLrp0OjI8v3ehkZ9h3g8lVUjX9vhhr2mJDNIoryA2nRaSmNlkbZWhYvC8lSIY0lM6b/LPa+MiNDKPlP1BR1qEjeyjaivputltDJmEAKNHeuQNs3T4zE8rvrhrf03ABRGelyux625X2JcW6mrmxiINuctszZrFxauOicrYEF3YFVEAVFKA529VXjNz66uuKJcxNifyBFJk0PoAcQfk7+7KI2pPpjYlTN/C5UcFASml60CrbgEipzPVGhVUtABiasfCH4JhULuAjgrIWXchiGWelW4SpOT7a4Dt05/x3woxYLR8w==
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by SA6PR04MB9143.namprd04.prod.outlook.com (2603:10b6:806:40e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 20:31:24 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::b7) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Thu, 9
 Jul 2026 20:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:23 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 9026E180177F;
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
Subject: [PATCH v2 19/19] MAINTAINERS: add Rambus CryptoManager Hub (CMH)
Date: Thu,  9 Jul 2026 13:30:37 -0700
Message-ID: <20260709203037.1884436-20-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA6PR04MB9143:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 60c4a879-840a-4e3d-252a-08deddf90b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|7416014|376014|23010399003|82310400026|921020|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	/IVrSLm3X8irf3XyZI2ITGDZe0PIDTPWVxMMvz1NEf5y6tQpkra/8yKLwXSUFp7WD6P0qV2JfuljUOrwCFWY78sn5UgulRNl7cmI7IjkMXTrZE3e3jZ1JEy8JQBjDyf+QdQfIUvrAYwiEypmjOJsV+btETtf6lZuxQ1VIVJJcvy/Gc5gkaRWlTLgcAwy0UDTs77BP4JRavQQz1qoVe42QXmRGHGvxylmOggs23nwFtK9IpGKQjoFeBNQjbRtxXXQ5+4i+e0eIZSmtEtJVBPEI9n2Zw4cvrdp4RbsLZqX/GdAId5tqwOwpgcMZD0bp9o8wcAKYeXkM81l8O4kN7SMixVM34iDx1nhk8AftxAA9WavBQKKh0Y6yl2xnsO35G4rQoO3yGD0rzAn/lCshiDrS5qKc1ZXKyCC/dVFbVmi8vH3kPEvETMjAQVUJTChXpW5B7VAWYMAk1QGjU0H8DeQ/w9H4xzbMntbPoVUXl56JGENy9s5Bb84AMHPv7X4IczCR1HFCQ9eVxS0jvJs91N2svq0pkPs1BJ9fHs7wWArF+fFn/p1DkpHWEsAHiRr2LwOEBW9O9K5t12RRldr7bZVCVqAobwcU40RRZhxih9tYT08vmgZQZP30erXqKcOEmeZ6DsUMXOkpiXDQNjimEwNXO1r0Z1KyzwFIBy8ejUcsRJ6evtMTR93jS+1X4kNN6Ud2Jjv4tz8p4JyPd6ngIA4pCYcReNq+dSSNVyNvP2o2WH554i7GAPs1j6bwoE0GVqR
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(7416014)(376014)(23010399003)(82310400026)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pVzAx6S+dfqiGP25jAsTqStgY6OnMq/1DOrmNefST9qYWcHDJV23aYu6yfiHZ7wL+7aoNp6E01nslYPLzq2e+ZN7+LD1ehzoAoReuPC8X1lrNs3Uagldu6uovEE3P4+znbbMQaBxLjrx9OPYyuDPso7aPPinMbECtNn5QRLzg+dzbdxSjQskB1MBZ78tIupCWr/7vP5T1M3S5F+1u6Z5eNwI2zT0mby0mPY5MIVtvHlOOFqB3Tslae4Ho9miJ/ggGFvqn+bAZ/wmCf1yhR/2T96StxXQ5Beu0xnY1DrWzdcn67G/r/zjbtSvu+VPDgM22BDFri6NCI+xwzIcsxrTLhbM6JozDVMKKxPQ/tW1PPYMroScgL++EYKKwa3bkSIQrO7Gh8HmXRPVvP/+kWCATbJSS7a2EZCHzUU20rMh6Bneebq5sq+/pMkEyU/SKSuM
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:23.9998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c4a879-840a-4e3d-252a-08deddf90b64
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9143
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
	TAGGED_FROM(0.00)[bounces-6807-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9222B7355A7

From: Alex Ousherovitch <aousherovitch@rambus.com>

Add MAINTAINERS entry for the CRI CryptoManager Hub (CMH) hardware
crypto accelerator driver under drivers/crypto/cmh/.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1dbf2f07104..1c153a84f70f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6891,6 +6891,23 @@ F:	kernel/cred.c
 F:	rust/kernel/cred.rs
 F:	Documentation/security/credentials.rst
 
+CRI CRYPTOMANAGER HUB (CMH) HARDWARE CRYPTO ACCELERATOR
+M:	Alex Ousherovitch <aousherovitch@rambus.com>
+M:	Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
+R:	Joel Wittenauer <Joel.Wittenauer@cryptography.com>
+R:	Thi Nguyen <thin@rambus.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/cmh-mgmt
+F:	Documentation/ABI/testing/debugfs-driver-cmh
+F:	Documentation/ABI/testing/sysfs-driver-cmh
+F:	Documentation/crypto/device_drivers/cmh.rst
+F:	Documentation/devicetree/bindings/crypto/cri,cmh.yaml
+F:	Documentation/userspace-api/ioctl/cmh_mgmt.rst
+F:	drivers/crypto/cmh/
+F:	include/uapi/linux/cmh_mgmt_ioctl.h
+F:	tools/testing/selftests/drivers/crypto/cmh/
+
 INTEL CRPS COMMON REDUNDANT PSU DRIVER
 M:	Ninad Palsule <ninad@linux.ibm.com>
 L:	linux-hwmon@vger.kernel.org
-- 
2.43.7


