Return-Path: <linux-api+bounces-6694-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mmNZEoBnPWqZ2ggAu9opvQ
	(envelope-from <linux-api+bounces-6694-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:38:08 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9412D6C7E06
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:38:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=IttHkvVI;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6694-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6694-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 078063105D91
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215E3EEAFE;
	Thu, 25 Jun 2026 17:34:22 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021105.outbound.protection.outlook.com [40.107.208.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E153ED13B;
	Thu, 25 Jun 2026 17:34:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408861; cv=fail; b=E31olnG+7zhWvb0uR6hBHiBSBgqna/RrQfL+S/InhRGEkrP15WKcGqj9/hEfrmOIGo0D/N0DpqK1Wey9yLNfVlUY8acaas+e4f8ufFHl8flZf0fkKCmGcTy2TXFIrWTcQmlfseNebvfVZNUVfyV5N0zhQ2ba1rBRLrQAHwPt9ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408861; c=relaxed/simple;
	bh=BKXDH00mZ19BwWFKDlgi0+63sbsRgsnp9XCdmMCF/UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVHzySKKySWpMuZ2TKvp7KcSjxbdpCTitrnQpEAhPdLroAsdNwVfsEzwni+RVQjWWuPZGuK+PAtfYmpwSwjjEjVstNUBmpElswbqzU7ucx7IXgODDYQWPhUtVJ4emEpHwGTIgHeChFkpibgPoMBITPaw1TjZE8tgBxfNt03dfvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=IttHkvVI; arc=fail smtp.client-ip=40.107.208.105
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fKKllaeFdBJlAKMIXSXd1part5318G8QjV7oOSDz42ycdKVA13HrUPH5eRgTX7w8awNcChNwhk41lp0DZD+S8ZdwMe6UmZ/5UXzDEYftywlsrDs3XHOiXf7RnXVLy3yjsiPo4OWYn4bP32UBpXkLbJf/cGe7S/Z2yJ5TMYf/vAda7AFDkYyNTliTVsOzhmOkoYssU3vYc/9dMdjEW73NwC2Mve8wBqRVzcsbkf/RWStMNVc5uIET9uA/cunlIV/td5fuyCUqp0iI6LChKWTEejgOmdqdaaDPb2X982zOCTVh1mrD74trl2bOnOCYo0h9kCmy1qlFOYJvLyxfe0zEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCsljxLdwL6cnTNmmqhlTBf0vbVfcOhXxAobwPUpmjk=;
 b=QWcFV9pBAiYP7mc5EFS55ToWw+BHwWrD24PybkGrEW2LHte+tcvVVqia59rOkq6Npa4HfhI0aryRiwAiByrc1h+QvPFE+Z4b8BizpHR+s/kV8wlJDJ3ie31OX2btiOjdfISgu20ecahyK/GIvHL5iy/ZdH/8r5Ae9v/W1AnEmSwveYO0RQmH6V4UKNQLurxMlewyvdctX0H8BLHrSzwfflowu5hi0s1ZAtwfYPUHpGi06EL2PtHzBWSzK7dWoPYMoDq/azx3vTTeAYwr5wYQUlEs+bp7eW8Xfo8anEn/iG3hpm0RcW3VgDsdn8hM1NfzasJ4CNkTgWI/UvhIyMCSRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCsljxLdwL6cnTNmmqhlTBf0vbVfcOhXxAobwPUpmjk=;
 b=IttHkvVI20ETPyWbiTkg5QSIrYVhnU08NfqUgv0hoL9mKKe8aGsOVK0Zq4j+WTiUD+oBwSFiNnN2HCb8yZYnCzRsN9ZfUg+z/h//1qSM/y0B0yKzH5iV6icgTWpAbPx/L7gbcXCAuwqRZ1ueL88AyMURDpRc91krfVlBOrwDLFGR0nw/X/P923+52Iwi4+l3qtHbb7XSFm1zOw4siJ7gs3IcQr/xP9T9L+IkgQH8rbqu1uTvOH7OaxZrNySvrIeBOMOYXR2nJ7Z69s8LPSRs4DSDv/lkfS0WYUKa2CzCmdNiIHuU08EzQt4tFWAQl1KwI6BlVbQAHZE49uAvmzGPZg==
Received: from CYZPR02CA0002.namprd02.prod.outlook.com (2603:10b6:930:a1::26)
 by PH0PR04MB7686.namprd04.prod.outlook.com (2603:10b6:510:5b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 17:34:09 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::72) by CYZPR02CA0002.outlook.office365.com
 (2603:10b6:930:a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 17:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:08 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 9B2B7180175B;
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
Subject: [PATCH 06/19] crypto: cmh - add CSHAKE/KMAC ahash
Date: Thu, 25 Jun 2026 10:33:14 -0700
Message-ID: <20260625173328.1140487-7-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH0PR04MB7686:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4df42d8d-ea03-4138-06f2-08ded2dff63b
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|36860700016|82310400026|921020|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	zAYae3PTc5ScJ5AUnMdRpyEgZDR2lTXTVWGCvv3zAw8YSg106PFrj9sPPK8BzjDmp6FSx4AEUUe0zTvGPr13YR5Smne0UY/CmRJwm1YwrRStLEpkTZrK3cHrcklp3r6bIEYSBSM/5UaltbAgQ1oKYGHF8M+WFGNW+p7YkAXRze7Zuu0twUJ7y3kGcr00BWmgth2DQiFLUpMp7qrmsq6BYIP3x4OsiBXMLAog7DgQNtbHDs7oSdhPyanHQzxb9FXvNyCR9pG+MsWSvTjqrHqmRfhfYTMmwmfYdXsFnpmurRE86Ftv49OueXWss5sCmY1DU5Xa4hudce2bzlvLxEtOkkUKJEiwIbAmNo7yS0k3UqqG/3fhaUMjL9ocE1P+uq/fhNpGlhAPds/11uOCcFrTS5ZIobOGqaJfeV/MvYsp6iLHAJTTFeNHLNeG/d1oh3DnSPSDKYVUS7pFrGPaNtoJzg6FgyD1PciF0fMsEnRCk1gu3UdrxYqoGx4fk7YYi/ErjpwJ5/Dr3A7yFQvdgwpanBhGGFnRxoLWaoZDOTqqftLy7ygXB05ijrAYXeYoMrTiTjyM3mqaCSk9LnwcxMxzMpJWeEsVJJr6cbG+OiPc3MBVhawugBfYHFyhwEvCARHNSNyk3+DoW5L0nbcNsjxCDblIL4gNg1UZuyHG0ajRnro7VLgaay72zoRAxeXtQqusTZQ3XYphfALF6IhENfr/wawpTzAO+q228WfB570R/g0sc4CUFrbbrMZ12OzTjIw0
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(921020)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M6O5oJ0jp9Cn7N+n9fVbvWX11pA1Uhdhbob1NC6a3V23r5i+4sformANh2CecGiLdQhUArRuNMNFX2067VD2oafMHxZ59qiMFU+Pop+oXuocZ8ZMK2/19fU/qSMtos1Dq2XhDmVUlz3cymXcr+F0IZf8MM4rsS/XRIWLxIC40FkeMQhUvravacCvf85qgCeOQqbaCyNssc4BAkoiq5/vlYB0wsZMfXxkoJK5MwZsTzPBmonbVQYzEbdu0T91SYlFuhpPFc2K9XlOuaHHIyo1H5cfamMn/eMZDkDNUuah2lNQVrHmNgfgfN/OrWanO+bQI4Y7bazzHfTincr9JT7H1EyaahQ1DJlnVbAtXSqxcjF55vcq3dEe0C6kyHJm0bwbZZEqUaDdhhdfZ07QNnB/k9a60uoWABEclGm2+fcm6XADNB/Hw3JqIcJv5Bng9W47
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:08.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df42d8d-ea03-4138-06f2-08ded2dff63b
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7686
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
	TAGGED_FROM(0.00)[bounces-6694-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 9412D6C7E06

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ahash algorithms for cSHAKE128, cSHAKE256, KMAC128, and
KMAC256 using the CMH hash core.  cSHAKE supports incremental
update and export/import.  KMAC has a 64KB data cap imposed by the
hardware.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile             |   4 +-
 drivers/crypto/cmh/cmh_cshake.c         | 808 ++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_kmac.c           | 630 ++++++++++++++++++
 drivers/crypto/cmh/cmh_main.c           |  18 +
 drivers/crypto/cmh/include/cmh_cshake.h |  16 +
 drivers/crypto/cmh/include/cmh_kmac.h   |  16 +
 6 files changed, 1491 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_cshake.c
 create mode 100644 drivers/crypto/cmh/cmh_kmac.c
 create mode 100644 drivers/crypto/cmh/include/cmh_cshake.h
 create mode 100644 drivers/crypto/cmh/include/cmh_kmac.h

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 1f760c0214ef..2bb240b97f31 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -16,7 +16,9 @@ cmh-y :=3D \
        cmh_key.o \
        cmh_sys.o \
        cmh_hash.o \
-       cmh_hmac.o
+       cmh_hmac.o \
+       cmh_cshake.o \
+       cmh_kmac.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
diff --git a/drivers/crypto/cmh/cmh_cshake.c b/drivers/crypto/cmh/cmh_cshak=
e.c
new file mode 100644
index 000000000000..02f9b853dd33
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_cshake.c
@@ -0,0 +1,808 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API CSHAKE Driver
+ *
+ * Registers cSHAKE-128 and cSHAKE-256 as ahash algorithms using the
+ * CMH Hash Core (HC) via HC_CMD_CSHAKE.
+ *
+ * CSHAKE (NIST SP 800-185) extends SHAKE with two domain separation
+ * parameters: function name N and customization string S.  When both
+ * are empty, cSHAKE reduces to plain SHAKE -- the driver falls back to
+ * HC_CMD_INIT in that case (per SP 800-185 S6.2).
+ *
+ * N and S are set via .setkey() using a self-describing binary header
+ * (matching the upstream authenc precedent):
+ *
+ *   struct cshake_cfg { __be32 n_len; __be32 s_len; };
+ *   setkey blob: cshake_cfg || N[n_len] || S[s_len]
+ *
+ * If .setkey() is never called, the driver defaults to plain SHAKE
+ * (N=3D"" S=3D"").  .setkey() is per-tfm, not per-request.
+ *
+ * N is embedded inline in the HC_CMD_CSHAKE struct (max 36 bytes).
+ * S is passed as VCQ inline data following the command slot (multi-span).
+ *
+ * Uses the same self-contained transaction model as cmh_hash.c:
+ *   .init()   -> software-only
+ *   .update() -> software-only (accumulate chunks)
+ *   .final()  -> CSHAKE [+ inline S] [+ RESTORE] [+ GATHER] + FINAL + FLU=
SH
+ *   .export() -> CSHAKE [+ inline S] [+ RESTORE] [+ GATHER] + SAVE + FLUS=
H
+ *   .import() -> restore HC context checkpoint (software-only)
+ *
+ * The HC core supports HC_CMD_SAVE / HC_CMD_RESTORE for cSHAKE mode.
+ * The cSHAKE domain-separation prefix (function name N, customization
+ * string S) is absorbed into the Keccak sponge state by HC_CMD_CSHAKE
+ * on the first submission, and preserved through save/restore.
+ * Export/import enables crypto API transform cloning.
+ *
+ * .setkey() here configures public domain-separation parameters (N, S),
+ * not a secret key.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/hash.h>
+#include <linux/scatterlist.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+
+#include "cmh_cshake.h"
+#include "cmh_vcq.h"
+#include "cmh_hc_abi.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+
+/* Algorithm Table */
+
+struct cmh_cshake_alg_info {
+       u32         hc_algo;
+       u32         digest_size;
+       const char *alg_name;
+       const char *drv_name;
+};
+
+static const struct cmh_cshake_alg_info cmh_cshake_algs_info[] =3D {
+       {
+               .hc_algo     =3D HC_ALGO_SHAKE128,
+               .digest_size =3D CMH_SHAKE128_DIGEST_SIZE,
+               .alg_name    =3D "cshake128",
+               .drv_name    =3D "cri-cmh-cshake128",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHAKE256,
+               .digest_size =3D CMH_SHAKE256_DIGEST_SIZE,
+               .alg_name    =3D "cshake256",
+               .drv_name    =3D "cri-cmh-cshake256",
+       },
+};
+
+#define CMH_CSHAKE_ALG_COUNT  ARRAY_SIZE(cmh_cshake_algs_info)
+
+/* Per-Request State */
+
+struct cmh_cshake_chunk {
+       struct list_head  list;
+       struct list_head  tfm_node; /* per-tfm orphan tracking */
+       u32               len;
+       u8                data[];
+};
+
+/*
+ * Max payload slots for CSHAKE:
+ *   CSHAKE (1) + inline S (ceil(S_len/64)) + GATHER (1) + FINAL (1) + FLU=
SH (1)
+ * S can be up to SHAKE-128 block (168 bytes) =3D 3 inline slots.
+ * Conservative: 1 + 3 + 1 + 1 + 1 =3D 7, plus headers.
+ *
+ * Or INIT + GATHER + FINAL + FLUSH =3D 4 (plain SHAKE fallback).
+ */
+#define CMH_CSHAKE_MAX_PAYLOAD   8
+#define CMH_CSHAKE_MAX_PACKED    (CMH_CSHAKE_MAX_PAYLOAD * 2)
+
+/*
+ * Checkpoint embedded inline: the kernel ahash API has no per-request
+ * destructor, so a heap-allocated checkpoint leaks if a request is
+ * abandoned without .final().
+ */
+struct cmh_cshake_reqctx {
+       const struct cmh_cshake_alg_info *info;
+       int                               error;
+       struct list_head                  chunks;
+       u32                               num_chunks;
+       u32                               total_len;
+       u32                               has_checkpoint;
+       u8                                checkpoint[HC_CONTEXT_SIZE];
+       /* DMA state for async final */
+       dma_addr_t                        digest_dma;
+       dma_addr_t                        ckpt_dma;
+       u8                               *digest_buf;
+       struct cmh_sg_map                *sgm;
+       struct vcq_cmd packed[CMH_CSHAKE_MAX_PACKED];
+};
+
+/* Per-Transform State (carries N and S across requests) */
+
+struct cmh_cshake_tfm_ctx {
+       u8  *func_name;     /* N (function name), NULL if empty */
+       u32  func_name_len;
+       u8  *custom;        /* S (customization string), NULL if empty */
+       u32  custom_len;
+       spinlock_t         chunk_lock;  /* protects all_chunks */
+       struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* VCQ Builders */
+
+/* VCQ Builders (cSHAKE-specific; shared builders in cmh_hc_abi.h / cmh_vc=
q.h) */
+
+static void vcq_add_hc_save(struct vcq_cmd *slot, u32 core_id,
+                           u64 output_phys, u32 outlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_SAVE);
+       slot->hwc.hc.cmd_save.output =3D output_phys;
+       slot->hwc.hc.cmd_save.outlen =3D outlen;
+}
+
+static void vcq_add_hc_restore(struct vcq_cmd *slot, u32 core_id,
+                              u64 input_phys, u32 inlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_RESTORE);
+       slot->hwc.hc.cmd_restore.input =3D input_phys;
+       slot->hwc.hc.cmd_restore.inlen =3D inlen;
+}
+
+static void vcq_add_hc_cshake(struct vcq_cmd *slot, u32 core_id, u32 algo,
+                             const u8 *name, u32 namelen,
+                             u32 customlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_CSHAKE);
+       slot->hwc.hc.cmd_cshake.custom =3D 0;  /* inline -- CMH eSW reads f=
rom next slot(s) */
+       slot->hwc.hc.cmd_cshake.customlen =3D customlen;
+       slot->hwc.hc.cmd_cshake.algo =3D algo;
+       slot->hwc.hc.cmd_cshake.namelen =3D namelen;
+       if (namelen > 0 && name)
+               memcpy(slot->hwc.hc.cmd_cshake.name, name,
+                      min_t(u32, namelen, HC_CSHAKE_MAX_NAMELEN));
+}
+
+/* Request Context Cleanup */
+
+static void cmh_cshake_free_chunks(struct cmh_cshake_reqctx *rctx,
+                                  struct cmh_cshake_tfm_ctx *tctx)
+{
+       struct cmh_cshake_chunk *chunk, *tmp;
+
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(chunk, tmp, &rctx->chunks, list) {
+               list_del(&chunk->list);
+               list_del(&chunk->tfm_node);
+               kfree(chunk);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+}
+
+static void cmh_cshake_free_reqctx(struct cmh_cshake_reqctx *rctx,
+                                  struct cmh_cshake_tfm_ctx *tctx)
+{
+       cmh_cshake_free_chunks(rctx, tctx);
+       rctx->has_checkpoint =3D 0;
+}
+
+static struct cmh_sg_map *
+cmh_cshake_build_sg(struct cmh_cshake_reqctx *rctx, gfp_t gfp)
+{
+       struct cmh_dma_buf *bufs;
+       struct cmh_cshake_chunk *chunk;
+       struct cmh_sg_map *sgm;
+       u32 i;
+
+       bufs =3D kcalloc(rctx->num_chunks, sizeof(*bufs), gfp);
+       if (!bufs)
+               return NULL;
+
+       i =3D 0;
+       list_for_each_entry(chunk, &rctx->chunks, list) {
+               bufs[i].data =3D chunk->data;
+               bufs[i].len =3D chunk->len;
+               i++;
+       }
+
+       sgm =3D cmh_dma_build_sg(bufs, rctx->num_chunks, gfp);
+       kfree(bufs);
+       return sgm;
+}
+
+/* VCQ Packing + Submit */
+
+/* ahash Operations */
+
+struct cmh_cshake_alg_drv {
+       struct ahash_alg                   alg;
+       const struct cmh_cshake_alg_info  *info;
+};
+
+static const struct cmh_cshake_alg_info *
+cmh_cshake_get_info(struct crypto_ahash *tfm)
+{
+       struct ahash_alg *alg =3D crypto_ahash_alg(tfm);
+
+       return container_of(alg, struct cmh_cshake_alg_drv, alg)->info;
+}
+
+/*
+ * .setkey() -- parse N and S from the self-describing cshake_cfg header.
+ *
+ * Blob format: cshake_cfg { __be32 n_len; __be32 s_len; } || N || S
+ * If never called, the driver defaults to plain SHAKE (N=3D"" S=3D"").
+ */
+struct cshake_cfg {
+       __be32 n_len;
+       __be32 s_len;
+};
+
+static int cmh_cshake_setkey(struct crypto_ahash *tfm, const u8 *key,
+                            unsigned int keylen)
+{
+       struct cmh_cshake_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cshake_cfg cfg;
+       u32 n_len, s_len;
+       const u8 *ptr;
+
+       if (keylen < sizeof(cfg))
+               return -EINVAL;
+
+       memcpy(&cfg, key, sizeof(cfg));
+       n_len =3D be32_to_cpu(cfg.n_len);
+       s_len =3D be32_to_cpu(cfg.s_len);
+
+       if (keylen !=3D sizeof(cfg) + n_len + s_len)
+               return -EINVAL;
+
+       if (n_len > HC_CSHAKE_MAX_NAMELEN)
+               return -EINVAL;
+
+       if (s_len > HC_CSHAKE_MAX_CUSTOMLEN)
+               return -EINVAL;
+
+       /* Free previous N and S */
+       kfree(tctx->func_name);
+       kfree(tctx->custom);
+       tctx->func_name =3D NULL;
+       tctx->func_name_len =3D 0;
+       tctx->custom =3D NULL;
+       tctx->custom_len =3D 0;
+
+       ptr =3D key + sizeof(cfg);
+
+       if (n_len > 0) {
+               tctx->func_name =3D kmemdup(ptr, n_len, GFP_KERNEL);
+               if (!tctx->func_name)
+                       return -ENOMEM;
+               tctx->func_name_len =3D n_len;
+               ptr +=3D n_len;
+       }
+
+       if (s_len > 0) {
+               tctx->custom =3D kmemdup(ptr, s_len, GFP_KERNEL);
+               if (!tctx->custom) {
+                       kfree(tctx->func_name);
+                       tctx->func_name =3D NULL;
+                       tctx->func_name_len =3D 0;
+                       return -ENOMEM;
+               }
+               tctx->custom_len =3D s_len;
+       }
+
+       return 0;
+}
+
+static int cmh_cshake_init(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_cshake_reqctx *rctx =3D ahash_request_ctx(req);
+
+       rctx->info =3D cmh_cshake_get_info(tfm);
+       rctx->error =3D 0;
+       INIT_LIST_HEAD(&rctx->chunks);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+       rctx->has_checkpoint =3D 0;
+
+       return 0;
+}
+
+static int cmh_cshake_update(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_cshake_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_cshake_reqctx *rctx =3D ahash_request_ctx(req);
+       struct cmh_cshake_chunk *chunk;
+       int nents;
+
+       if (rctx->error)
+               return rctx->error;
+
+       if (!req->nbytes)
+               return 0;
+
+       chunk =3D kmalloc(sizeof(*chunk) + req->nbytes,
+                       req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+                       GFP_KERNEL : GFP_ATOMIC);
+       if (!chunk) {
+               rctx->error =3D -ENOMEM;
+               goto err_free_chunks;
+       }
+
+       chunk->len =3D req->nbytes;
+       if (req->base.flags & CRYPTO_AHASH_REQ_VIRT) {
+               memcpy(chunk->data, req->svirt, req->nbytes);
+       } else {
+               nents =3D sg_nents_for_len(req->src, req->nbytes);
+               if (nents < 0 ||
+                   sg_copy_to_buffer(req->src, nents,
+                                     chunk->data, req->nbytes) !=3D req->n=
bytes) {
+                       kfree(chunk);
+                       rctx->error =3D -EINVAL;
+                       goto err_free_chunks;
+               }
+       }
+
+       list_add_tail(&chunk->list, &rctx->chunks);
+       spin_lock_bh(&tctx->chunk_lock);
+       list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+       spin_unlock_bh(&tctx->chunk_lock);
+       rctx->num_chunks++;
+       rctx->total_len +=3D req->nbytes;
+
+       return 0;
+
+err_free_chunks:
+       /*
+        * Terminal error -- free all previously accumulated chunks.
+        * The crypto API hash path does not call .final() on error,
+        * so chunks would be orphaned otherwise.
+        */
+       cmh_cshake_free_chunks(rctx, tctx);
+       return rctx->error;
+}
+
+static void cmh_cshake_complete(void *data, int error)
+{
+       struct ahash_request *req =3D data;
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_cshake_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_cshake_reqctx *rctx =3D ahash_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       if (rctx->has_checkpoint)
+               cmh_dma_unmap_single(rctx->ckpt_dma, HC_CONTEXT_SIZE,
+                                    DMA_TO_DEVICE);
+       cmh_dma_unmap_single(rctx->digest_dma, rctx->info->digest_size,
+                            DMA_FROM_DEVICE);
+
+       if (!error)
+               memcpy(req->result, rctx->digest_buf,
+                      rctx->info->digest_size);
+
+       kfree(rctx->digest_buf);
+       rctx->digest_buf =3D NULL;
+       cmh_dma_free_sg(rctx->sgm);
+       rctx->sgm =3D NULL;
+       cmh_cshake_free_reqctx(rctx, tctx);
+       cmh_complete(&req->base, error);
+}
+
+static int cmh_cshake_final(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_cshake_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_cshake_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_cshake_alg_info *info =3D rctx->info;
+       struct core_dispatch d;
+       struct vcq_cmd cmds[CMH_CSHAKE_MAX_PAYLOAD];
+       struct cmh_sg_map *sgm =3D NULL;
+       dma_addr_t digest_dma =3D DMA_MAPPING_ERROR;
+       dma_addr_t ckpt_dma =3D DMA_MAPPING_ERROR;
+       u8 *digest_buf;
+       u32 idx;
+       int ret;
+       gfp_t gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+                    GFP_KERNEL : GFP_ATOMIC;
+
+       if (rctx->error) {
+               ret =3D rctx->error;
+               goto out_free;
+       }
+
+       if (rctx->num_chunks > 0) {
+               sgm =3D cmh_cshake_build_sg(rctx, gfp);
+               if (!sgm) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       }
+
+       digest_buf =3D kzalloc(info->digest_size, gfp);
+       if (!digest_buf) {
+               ret =3D -ENOMEM;
+               goto out_free_sg;
+       }
+       digest_dma =3D cmh_dma_map_single(digest_buf, info->digest_size,
+                                       DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(digest_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_digest;
+       }
+
+       /* Map checkpoint buffer if present (CMH eSW reads it) */
+       if (rctx->has_checkpoint) {
+               ckpt_dma =3D cmh_dma_map_single(rctx->checkpoint,
+                                             HC_CONTEXT_SIZE, DMA_TO_DEVIC=
E);
+               if (cmh_dma_map_error(ckpt_dma)) {
+                       ret =3D -ENOMEM;
+                       goto out_unmap_digest;
+               }
+       }
+
+       d =3D cmh_core_select_instance(CMH_CORE_HC);
+       idx =3D 0;
+
+       if (rctx->has_checkpoint) {
+               /*
+                * Resuming from a saved checkpoint (after export/import):
+                * INIT + RESTORE [+ GATHER] + FINAL + FLUSH
+                * The cSHAKE prefix (N,S) is already absorbed in the
+                * saved Keccak state -- no need to replay HC_CMD_CSHAKE.
+                */
+               vcq_add_hc_init(&cmds[idx++], d.core_id, info->hc_algo);
+               vcq_add_hc_restore(&cmds[idx++], d.core_id, (u64)ckpt_dma,
+                                  HC_CONTEXT_SIZE);
+       } else {
+               bool use_cshake =3D (tctx->func_name_len > 0 ||
+                                  tctx->custom_len > 0);
+
+               if (use_cshake) {
+                       u32 span;
+
+                       vcq_add_hc_cshake(&cmds[idx], d.core_id,
+                                         info->hc_algo,
+                                         tctx->func_name,
+                                         tctx->func_name_len,
+                                         tctx->custom_len);
+                       span =3D vcq_add_inline_data(&cmds[idx],
+                                                  tctx->custom,
+                                                  tctx->custom_len);
+                       idx +=3D span;
+               } else {
+                       vcq_add_hc_init(&cmds[idx++], d.core_id,
+                                       info->hc_algo);
+               }
+       }
+
+       if (sgm)
+               vcq_add_hc_gather(&cmds[idx++], d.core_id, (u64)sgm->items_=
dma,
+                                 HC_CMD_UPDATE);
+
+       vcq_add_hc_final(&cmds[idx++], d.core_id, (u64)digest_dma, info->di=
gest_size);
+       vcq_add_flush(&cmds[idx++], d.core_id);
+
+       rctx->digest_buf =3D digest_buf;
+       rctx->digest_dma =3D digest_dma;
+       rctx->ckpt_dma =3D ckpt_dma;
+       rctx->sgm =3D sgm;
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_CSHAKE_MAX_PACKED,
+                                           d.mbx_idx,
+                                           cmh_cshake_complete, req,
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
+       if (rctx->has_checkpoint)
+               cmh_dma_unmap_single(ckpt_dma, HC_CONTEXT_SIZE,
+                                    DMA_TO_DEVICE);
+out_unmap_digest:
+       cmh_dma_unmap_single(digest_dma, info->digest_size,
+                            DMA_FROM_DEVICE);
+out_free_digest:
+       kfree(digest_buf);
+
+out_free_sg:
+       cmh_dma_free_sg(sgm);
+
+out_free:
+       cmh_cshake_free_reqctx(rctx, tctx);
+       return ret;
+}
+
+static int cmh_cshake_finup(struct ahash_request *req)
+{
+       int ret;
+
+       ret =3D cmh_cshake_update(req);
+       if (ret)
+               return ret;
+
+       return cmh_cshake_final(req);
+}
+
+static int cmh_cshake_digest(struct ahash_request *req)
+{
+       int ret;
+
+       ret =3D cmh_cshake_init(req);
+       if (ret)
+               return ret;
+
+       return cmh_cshake_finup(req);
+}
+
+static int cmh_cshake_export(struct ahash_request *req, void *out)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_cshake_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_cshake_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_cshake_alg_info *info =3D rctx->info;
+       struct core_dispatch d;
+       struct vcq_cmd cmds[CMH_CSHAKE_MAX_PAYLOAD];
+       struct cmh_sg_map *sgm =3D NULL;
+       dma_addr_t save_dma =3D DMA_MAPPING_ERROR;
+       dma_addr_t ckpt_dma =3D DMA_MAPPING_ERROR;
+       u8 *save_buf;
+       u32 idx;
+       int ret;
+
+       if (rctx->num_chunks > 0) {
+               sgm =3D cmh_cshake_build_sg(rctx, GFP_KERNEL);
+               if (!sgm)
+                       return -ENOMEM;
+       }
+
+       save_buf =3D kzalloc(HC_CONTEXT_SIZE, GFP_KERNEL);
+       if (!save_buf) {
+               cmh_dma_free_sg(sgm);
+               return -ENOMEM;
+       }
+       save_dma =3D cmh_dma_map_single(save_buf, HC_CONTEXT_SIZE,
+                                     DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(save_dma)) {
+               kfree(save_buf);
+               cmh_dma_free_sg(sgm);
+               return -ENOMEM;
+       }
+
+       /* Map checkpoint buffer if present (CMH eSW reads it) */
+       if (rctx->has_checkpoint) {
+               ckpt_dma =3D cmh_dma_map_single(rctx->checkpoint,
+                                             HC_CONTEXT_SIZE, DMA_TO_DEVIC=
E);
+               if (cmh_dma_map_error(ckpt_dma)) {
+                       cmh_dma_unmap_single(save_dma, HC_CONTEXT_SIZE,
+                                            DMA_FROM_DEVICE);
+                       kfree(save_buf);
+                       cmh_dma_free_sg(sgm);
+                       return -ENOMEM;
+               }
+       }
+
+       d =3D cmh_core_select_instance(CMH_CORE_HC);
+       idx =3D 0;
+
+       if (rctx->has_checkpoint) {
+               /*
+                * Resuming from a saved checkpoint:
+                * INIT + RESTORE [+ GATHER] + SAVE + FLUSH
+                */
+               vcq_add_hc_init(&cmds[idx++], d.core_id, info->hc_algo);
+               vcq_add_hc_restore(&cmds[idx++], d.core_id, (u64)ckpt_dma,
+                                  HC_CONTEXT_SIZE);
+       } else {
+               bool use_cshake =3D (tctx->func_name_len > 0 ||
+                                  tctx->custom_len > 0);
+
+               if (use_cshake) {
+                       u32 span;
+
+                       vcq_add_hc_cshake(&cmds[idx], d.core_id,
+                                         info->hc_algo,
+                                         tctx->func_name,
+                                         tctx->func_name_len,
+                                         tctx->custom_len);
+                       span =3D vcq_add_inline_data(&cmds[idx],
+                                                  tctx->custom,
+                                                  tctx->custom_len);
+                       idx +=3D span;
+               } else {
+                       vcq_add_hc_init(&cmds[idx++], d.core_id,
+                                       info->hc_algo);
+               }
+       }
+
+       if (sgm)
+               vcq_add_hc_gather(&cmds[idx++], d.core_id, (u64)sgm->items_=
dma,
+                                 HC_CMD_UPDATE);
+
+       vcq_add_hc_save(&cmds[idx++], d.core_id, (u64)save_dma,
+                       HC_CONTEXT_SIZE);
+       vcq_add_flush(&cmds[idx++], d.core_id);
+
+       ret =3D cmh_vcq_pack_and_submit(cmds, idx, rctx->packed, CMH_CSHAKE=
_MAX_PACKED,
+                                     d.mbx_idx);
+
+       /* Unmap before CPU read */
+       if (rctx->has_checkpoint)
+               cmh_dma_unmap_single(ckpt_dma, HC_CONTEXT_SIZE, DMA_TO_DEVI=
CE);
+       cmh_dma_unmap_single(save_dma, HC_CONTEXT_SIZE, DMA_FROM_DEVICE);
+
+       if (!ret) {
+               memcpy(out, save_buf, HC_CONTEXT_SIZE);
+               /* Checkpoint now represents all accumulated state */
+               memcpy(rctx->checkpoint, save_buf, HC_CONTEXT_SIZE);
+               rctx->has_checkpoint =3D 1;
+               /* Accumulated chunks are now captured in checkpoint */
+               cmh_cshake_free_chunks(rctx, tctx);
+       }
+
+       kfree(save_buf);
+       cmh_dma_free_sg(sgm);
+       return ret;
+}
+
+static int cmh_cshake_import(struct ahash_request *req, const void *in)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_cshake_reqctx *rctx =3D ahash_request_ctx(req);
+
+       rctx->info =3D cmh_cshake_get_info(tfm);
+       rctx->error =3D 0;
+       INIT_LIST_HEAD(&rctx->chunks);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+
+       memcpy(rctx->checkpoint, in, HC_CONTEXT_SIZE);
+       rctx->has_checkpoint =3D 1;
+
+       return 0;
+}
+
+/* Transform init/exit */
+
+static int cmh_cshake_cra_init(struct crypto_tfm *tfm)
+{
+       struct cmh_cshake_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+
+       tctx->func_name =3D NULL;
+       tctx->func_name_len =3D 0;
+       tctx->custom =3D NULL;
+       tctx->custom_len =3D 0;
+       spin_lock_init(&tctx->chunk_lock);
+       INIT_LIST_HEAD(&tctx->all_chunks);
+       crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+                                sizeof(struct cmh_cshake_reqctx));
+       return 0;
+}
+
+static void cmh_cshake_cra_exit(struct crypto_tfm *tfm)
+{
+       struct cmh_cshake_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+       struct cmh_cshake_chunk *chunk, *tmp;
+
+       /* Free any orphaned chunks (e.g. testmgr export/reimport poison) *=
/
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(chunk, tmp, &tctx->all_chunks, tfm_node) {
+               list_del(&chunk->tfm_node);
+               kfree(chunk);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+
+       kfree(tctx->func_name);
+       kfree(tctx->custom);
+       tctx->func_name =3D NULL;
+       tctx->custom =3D NULL;
+}
+
+/* Registration */
+
+static struct cmh_cshake_alg_drv cmh_cshake_drvs[CMH_CSHAKE_ALG_COUNT];
+
+/**
+ * cmh_cshake_register() - Register cSHAKE-128/256 hash algorithms with th=
e crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_cshake_register(void)
+{
+       unsigned int i;
+       int ret;
+
+       for (i =3D 0; i < CMH_CSHAKE_ALG_COUNT; i++) {
+               const struct cmh_cshake_alg_info *info =3D
+                       &cmh_cshake_algs_info[i];
+               struct cmh_cshake_alg_drv *drv =3D &cmh_cshake_drvs[i];
+               struct ahash_alg *alg =3D &drv->alg;
+
+               drv->info =3D info;
+
+               alg->init   =3D cmh_cshake_init;
+               alg->update =3D cmh_cshake_update;
+               alg->final  =3D cmh_cshake_final;
+               alg->finup  =3D cmh_cshake_finup;
+               alg->digest =3D cmh_cshake_digest;
+               alg->export =3D cmh_cshake_export;
+               alg->import =3D cmh_cshake_import;
+               alg->setkey =3D cmh_cshake_setkey;
+
+               alg->halg.digestsize =3D info->digest_size;
+               alg->halg.statesize  =3D HC_CONTEXT_SIZE;
+
+               strscpy(alg->halg.base.cra_name, info->alg_name,
+                       CRYPTO_MAX_ALG_NAME);
+               strscpy(alg->halg.base.cra_driver_name, info->drv_name,
+                       CRYPTO_MAX_ALG_NAME);
+               alg->halg.base.cra_priority    =3D 300;
+               alg->halg.base.cra_flags       =3D CRYPTO_ALG_KERN_DRIVER_O=
NLY |
+                                                CRYPTO_ALG_NO_FALLBACK |
+                                                CRYPTO_ALG_ASYNC |
+                                                CRYPTO_ALG_OPTIONAL_KEY |
+                                                CRYPTO_ALG_REQ_VIRT;
+               alg->halg.base.cra_blocksize   =3D 1;  /* XOF */
+               alg->halg.base.cra_ctxsize     =3D sizeof(struct cmh_cshake=
_tfm_ctx);
+               alg->halg.base.cra_init        =3D cmh_cshake_cra_init;
+               alg->halg.base.cra_exit        =3D cmh_cshake_cra_exit;
+               alg->halg.base.cra_module      =3D THIS_MODULE;
+
+               ret =3D crypto_register_ahash(alg);
+               if (ret) {
+                       dev_err(cmh_dev(), "cshake: failed to register %s (=
rc=3D%d)\n",
+                               info->drv_name, ret);
+                       while (i--)
+                               crypto_unregister_ahash(&cmh_cshake_drvs[i]=
.alg);
+                       return ret;
+               }
+
+               dev_dbg(cmh_dev(), "cshake: registered %s (priority 300)\n"=
,
+                       info->drv_name);
+       }
+
+       dev_info(cmh_dev(), "cshake: %zu algorithm(s) registered\n",
+                CMH_CSHAKE_ALG_COUNT);
+       return 0;
+}
+
+/**
+ * cmh_cshake_unregister() - Unregister cSHAKE hash algorithms from the cr=
ypto framework
+ */
+void cmh_cshake_unregister(void)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < CMH_CSHAKE_ALG_COUNT; i++) {
+               crypto_unregister_ahash(&cmh_cshake_drvs[i].alg);
+               dev_dbg(cmh_dev(), "cshake: unregistered %s\n",
+                       cmh_cshake_algs_info[i].drv_name);
+       }
+
+       dev_info(cmh_dev(), "cshake: cleaned up\n");
+}
diff --git a/drivers/crypto/cmh/cmh_kmac.c b/drivers/crypto/cmh/cmh_kmac.c
new file mode 100644
index 000000000000..7177a2558e97
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_kmac.c
@@ -0,0 +1,630 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API KMAC Driver
+ *
+ * Registers KMAC-128 and KMAC-256 as keyed ahash algorithms using the
+ * CMH Hash Core (HC) via HC_CMD_KMAC.
+ *
+ * KMAC (NIST SP 800-185) is a keyed variant of cSHAKE.  The function
+ * name N is always "KMAC" (hardcoded by the CMH eSW).  The user sets:
+ *   - A key via .setkey() (raw bytes + optional S)
+ *   - An optional customization string S via the setkey blob
+ *
+ * setkey blob format:
+ *   struct kmac_key_param { __be32 keylen; __be32 s_len; };
+ *   blob: kmac_key_param || key[keylen] || S[s_len]
+ *
+ * Uses the same self-contained transaction model as cmh_hmac.c:
+ *   .setkey() -> store raw key (+ S)
+ *   .init()   -> software-only
+ *   .update() -> software-only (accumulate chunks)
+ *   .final()  -> [SYS_CMD_WRITE] + HC_CMD_KMAC [+ inline S] +
+ *               [GATHER] + FINAL + FLUSH
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/hash.h>
+#include <linux/scatterlist.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <asm/byteorder.h>
+
+#include "cmh_kmac.h"
+#include "cmh_vcq.h"
+#include "cmh_hc_abi.h"
+#include "cmh_sys_abi.h"
+#include "cmh_sys.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+/*
+ * Maximum data that can be accumulated across .update() calls.
+ * The CMH eSW rejects HC_CMD_SAVE when ctx->outlen !=3D 0, which is
+ * always the case for KMAC (eip59_hc_kmac() sets ctx->outlen for
+ * right_encode(outlen) at finalization).  All data must be buffered
+ * in kernel memory and submitted atomically in .final().
+ *
+ * The CMH eSW does not serialize outlen into the external save
+ * context, so HC_CMD_SAVE fails for KMAC mode.
+ */
+#define KMAC_MAX_DATA          (64 * 1024)
+
+/* Algorithm Table */
+
+struct cmh_kmac_alg_info {
+       u32         hc_algo;
+       u32         digest_size;
+       const char *alg_name;
+       const char *drv_name;
+};
+
+static const struct cmh_kmac_alg_info cmh_kmac_algs_info[] =3D {
+       {
+               .hc_algo     =3D HC_ALGO_SHAKE128,
+               .digest_size =3D CMH_SHAKE128_DIGEST_SIZE,
+               .alg_name    =3D "kmac128",
+               .drv_name    =3D "cri-cmh-kmac128",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHAKE256,
+               .digest_size =3D CMH_SHAKE256_DIGEST_SIZE,
+               .alg_name    =3D "kmac256",
+               .drv_name    =3D "cri-cmh-kmac256",
+       },
+};
+
+#define CMH_KMAC_ALG_COUNT  ARRAY_SIZE(cmh_kmac_algs_info)
+
+/* Per-Request State */
+
+struct cmh_kmac_chunk {
+       struct list_head  list;
+       struct list_head  tfm_node; /* per-tfm orphan tracking */
+       u32               len;
+       u8                data[];
+};
+
+/*
+ * Max payload slots for KMAC:
+ *   SYS_CMD_WRITE (1) + KMAC (1) + inline S (3 max) + GATHER (1) +
+ *   FINAL (1) + FLUSH (1) =3D 8
+ */
+#define CMH_KMAC_MAX_PAYLOAD   9
+#define CMH_KMAC_MAX_PACKED    (CMH_KMAC_MAX_PAYLOAD * 2)
+
+struct cmh_kmac_reqctx {
+       const struct cmh_kmac_alg_info *info;
+       int                             error;
+       struct list_head                chunks;
+       u32                             num_chunks;
+       u32                             total_len;
+       /* DMA state for async final */
+       dma_addr_t                      digest_dma;
+       dma_addr_t                      key_dma;
+       u8                             *digest_buf;
+       struct cmh_sg_map              *sgm;
+       u32                             keylen;
+       struct vcq_cmd packed[CMH_KMAC_MAX_PACKED];
+};
+
+/* Per-Transform State (carries key + S across requests) */
+
+struct cmh_kmac_tfm_ctx {
+       struct cmh_key_ctx key;
+       u8  *custom;        /* S (customization string), NULL if empty */
+       u32  custom_len;
+       spinlock_t         chunk_lock;  /* protects all_chunks */
+       struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* VCQ Builders (KMAC-specific; shared builders in cmh_hc_abi.h / cmh_vcq.=
h) */
+
+static void vcq_add_hc_kmac(struct vcq_cmd *slot, u32 core_id, u64 key_ref=
, u32 keylen,
+                           u32 customlen, u32 algo, u32 outlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_KMAC);
+       slot->hwc.hc.cmd_kmac.key =3D key_ref;
+       slot->hwc.hc.cmd_kmac.custom =3D 0;  /* inline */
+       slot->hwc.hc.cmd_kmac.keylen =3D keylen;
+       slot->hwc.hc.cmd_kmac.customlen =3D customlen;
+       slot->hwc.hc.cmd_kmac.algo =3D algo;
+       slot->hwc.hc.cmd_kmac.outlen =3D outlen;
+}
+
+/* Request Context Cleanup */
+
+static void cmh_kmac_free_chunks(struct cmh_kmac_reqctx *rctx,
+                                struct cmh_kmac_tfm_ctx *tctx)
+{
+       struct cmh_kmac_chunk *chunk, *tmp;
+
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(chunk, tmp, &rctx->chunks, list) {
+               list_del(&chunk->list);
+               list_del(&chunk->tfm_node);
+               kfree(chunk);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+}
+
+static struct cmh_sg_map *
+cmh_kmac_build_sg(struct cmh_kmac_reqctx *rctx, gfp_t gfp)
+{
+       struct cmh_dma_buf *bufs;
+       struct cmh_kmac_chunk *chunk;
+       struct cmh_sg_map *sgm;
+       u32 i;
+
+       bufs =3D kcalloc(rctx->num_chunks, sizeof(*bufs), gfp);
+       if (!bufs)
+               return NULL;
+
+       i =3D 0;
+       list_for_each_entry(chunk, &rctx->chunks, list) {
+               bufs[i].data =3D chunk->data;
+               bufs[i].len =3D chunk->len;
+               i++;
+       }
+
+       sgm =3D cmh_dma_build_sg(bufs, rctx->num_chunks, gfp);
+       kfree(bufs);
+       return sgm;
+}
+
+/* VCQ Packing + Submit */
+
+/* ahash Operations */
+
+struct cmh_kmac_alg_drv {
+       struct ahash_alg                 alg;
+       const struct cmh_kmac_alg_info  *info;
+};
+
+static const struct cmh_kmac_alg_info *
+cmh_kmac_get_info(struct crypto_ahash *tfm)
+{
+       struct ahash_alg *alg =3D crypto_ahash_alg(tfm);
+
+       return container_of(alg, struct cmh_kmac_alg_drv, alg)->info;
+}
+
+/*
+ * setkey blob for KMAC (raw key path):
+ *   struct kmac_key_param { __be32 keylen; __be32 s_len; };
+ *   blob: kmac_key_param || key[keylen] || S[s_len]
+ */
+struct kmac_key_param {
+       __be32 keylen;
+       __be32 s_len;
+};
+
+static int cmh_kmac_setkey(struct crypto_ahash *tfm, const u8 *key,
+                          unsigned int keylen)
+{
+       struct cmh_kmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       /* raw key bytes with optional S */
+       {
+               struct kmac_key_param hdr;
+               u32 raw_keylen, s_len;
+               const u8 *ptr;
+
+               if (keylen < sizeof(hdr))
+                       return -EINVAL;
+
+               memcpy(&hdr, key, sizeof(hdr));
+               raw_keylen =3D be32_to_cpu(hdr.keylen);
+               s_len =3D be32_to_cpu(hdr.s_len);
+
+               if (keylen !=3D sizeof(hdr) + raw_keylen + s_len)
+                       return -EINVAL;
+
+               if (raw_keylen =3D=3D 0)
+                       return -EINVAL;
+
+               if (s_len > HC_CSHAKE_MAX_CUSTOMLEN)
+                       return -EINVAL;
+
+               ptr =3D key + sizeof(hdr);
+
+               /* Store raw key */
+               {
+                       int ret =3D cmh_key_setkey_raw(&tctx->key, ptr,
+                                                    raw_keylen, CORE_ID_HC=
);
+                       if (ret)
+                               return ret;
+               }
+               ptr +=3D raw_keylen;
+
+               /* Store S */
+               kfree(tctx->custom);
+               tctx->custom =3D NULL;
+               tctx->custom_len =3D 0;
+
+               if (s_len > 0) {
+                       tctx->custom =3D kmemdup(ptr, s_len, GFP_KERNEL);
+                       if (!tctx->custom) {
+                               cmh_key_destroy(&tctx->key);
+                               return -ENOMEM;
+                       }
+                       tctx->custom_len =3D s_len;
+               }
+
+               return 0;
+       }
+}
+
+static int cmh_kmac_init(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_kmac_reqctx *rctx =3D ahash_request_ctx(req);
+
+       rctx->info =3D cmh_kmac_get_info(tfm);
+       rctx->error =3D 0;
+       INIT_LIST_HEAD(&rctx->chunks);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+
+       return 0;
+}
+
+static int cmh_kmac_update(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_kmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_kmac_reqctx *rctx =3D ahash_request_ctx(req);
+       struct cmh_kmac_chunk *chunk;
+       int nents;
+
+       if (rctx->error)
+               return rctx->error;
+
+       if (!req->nbytes)
+               return 0;
+
+       if (req->nbytes > KMAC_MAX_DATA - rctx->total_len) {
+               rctx->error =3D -EINVAL;
+               goto err_free_chunks;
+       }
+
+       chunk =3D kmalloc(sizeof(*chunk) + req->nbytes,
+                       req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+                       GFP_KERNEL : GFP_ATOMIC);
+       if (!chunk) {
+               rctx->error =3D -ENOMEM;
+               goto err_free_chunks;
+       }
+
+       chunk->len =3D req->nbytes;
+       if (req->base.flags & CRYPTO_AHASH_REQ_VIRT) {
+               memcpy(chunk->data, req->svirt, req->nbytes);
+       } else {
+               nents =3D sg_nents_for_len(req->src, req->nbytes);
+               if (nents < 0 ||
+                   sg_copy_to_buffer(req->src, nents,
+                                     chunk->data, req->nbytes) !=3D req->n=
bytes) {
+                       kfree(chunk);
+                       rctx->error =3D -EINVAL;
+                       goto err_free_chunks;
+               }
+       }
+
+       list_add_tail(&chunk->list, &rctx->chunks);
+       spin_lock_bh(&tctx->chunk_lock);
+       list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+       spin_unlock_bh(&tctx->chunk_lock);
+       rctx->num_chunks++;
+       rctx->total_len +=3D req->nbytes;
+
+       return 0;
+
+err_free_chunks:
+       /*
+        * Terminal error -- free all previously accumulated chunks.
+        * The crypto API hash path does not call .final() on error,
+        * so chunks would be orphaned otherwise.
+        */
+       cmh_kmac_free_chunks(rctx, tctx);
+       return rctx->error;
+}
+
+static void cmh_kmac_complete(void *data, int error)
+{
+       struct ahash_request *req =3D data;
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_kmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_kmac_reqctx *rctx =3D ahash_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       cmh_dma_unmap_single(rctx->digest_dma, rctx->info->digest_size,
+                            DMA_FROM_DEVICE);
+
+       if (!error)
+               memcpy(req->result, rctx->digest_buf,
+                      rctx->info->digest_size);
+
+       kfree(rctx->digest_buf);
+       rctx->digest_buf =3D NULL;
+       cmh_dma_free_sg(rctx->sgm);
+       rctx->sgm =3D NULL;
+       cmh_kmac_free_chunks(rctx, tctx);
+       cmh_complete(&req->base, error);
+}
+
+static int cmh_kmac_final(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_kmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_kmac_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_kmac_alg_info *info =3D rctx->info;
+       struct vcq_cmd cmds[CMH_KMAC_MAX_PAYLOAD];
+       struct cmh_sg_map *sgm =3D NULL;
+       dma_addr_t digest_dma =3D DMA_MAPPING_ERROR, key_dma =3D DMA_MAPPIN=
G_ERROR;
+       u8 *digest_buf;
+       u64 key_ref;
+       u32 key_len;
+       struct core_dispatch d;
+       s32 target_mbx;
+       u32 core_id;
+       u32 idx;
+       int ret;
+       gfp_t gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+                  GFP_KERNEL : GFP_ATOMIC;
+
+       if (rctx->error) {
+               ret =3D rctx->error;
+               goto out_free;
+       }
+
+       if (tctx->key.mode =3D=3D CMH_KEY_NONE) {
+               ret =3D -ENOKEY;
+               goto out_free;
+       }
+
+       if (rctx->num_chunks > 0) {
+               sgm =3D cmh_kmac_build_sg(rctx, gfp);
+               if (!sgm) {
+                       ret =3D -ENOMEM;
+                       goto out_free;
+               }
+       }
+
+       digest_buf =3D kzalloc(info->digest_size, gfp);
+       if (!digest_buf) {
+               ret =3D -ENOMEM;
+               goto out_free_sg;
+       }
+       digest_dma =3D cmh_dma_map_single(digest_buf, info->digest_size,
+                                       DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(digest_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free_digest;
+       }
+
+       /* Resolve key reference */
+       idx =3D 0;
+
+       key_dma =3D tctx->key.raw.dma;
+       vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP, (u64)key_dma,
+                         SYS_REF_NONE, tctx->key.raw.len,
+                         tctx->key.raw.sys_type);
+       key_ref =3D SYS_REF_TEMP;
+       key_len =3D tctx->key.raw.len;
+       d =3D cmh_core_select_instance(CMH_CORE_HC);
+
+       target_mbx =3D d.mbx_idx;
+
+       core_id =3D d.core_id;
+
+       {
+               u32 span;
+
+               vcq_add_hc_kmac(&cmds[idx], core_id, key_ref, key_len,
+                               tctx->custom_len, info->hc_algo,
+                               info->digest_size);
+
+               /* Add inline S data after the KMAC slot */
+               span =3D vcq_add_inline_data(&cmds[idx], tctx->custom,
+                                          tctx->custom_len);
+               idx +=3D span;
+       }
+
+       if (sgm)
+               vcq_add_hc_gather(&cmds[idx++], core_id, (u64)sgm->items_dm=
a,
+                                 HC_CMD_UPDATE);
+
+       vcq_add_hc_final(&cmds[idx++], core_id, (u64)digest_dma, info->dige=
st_size);
+       vcq_add_flush(&cmds[idx++], core_id);
+
+       rctx->digest_buf =3D digest_buf;
+       rctx->digest_dma =3D digest_dma;
+       rctx->sgm =3D sgm;
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_KMAC_MAX_PACKED,
+                                           target_mbx,
+                                           cmh_kmac_complete, req,
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
+       cmh_dma_unmap_single(digest_dma, info->digest_size,
+                            DMA_FROM_DEVICE);
+out_free_digest:
+       kfree(digest_buf);
+
+out_free_sg:
+       cmh_dma_free_sg(sgm);
+
+out_free:
+       cmh_kmac_free_chunks(rctx, tctx);
+       return ret;
+}
+
+static int cmh_kmac_finup(struct ahash_request *req)
+{
+       int ret;
+
+       ret =3D cmh_kmac_update(req);
+       if (ret)
+               return ret;
+
+       return cmh_kmac_final(req);
+}
+
+static int cmh_kmac_digest(struct ahash_request *req)
+{
+       int ret;
+
+       ret =3D cmh_kmac_init(req);
+       if (ret)
+               return ret;
+
+       return cmh_kmac_finup(req);
+}
+
+static int cmh_kmac_export(struct ahash_request *req, void *out)
+{
+       return -EOPNOTSUPP;
+}
+
+static int cmh_kmac_import(struct ahash_request *req, const void *in)
+{
+       return -EOPNOTSUPP;
+}
+
+/* Transform init/exit */
+
+static int cmh_kmac_cra_init(struct crypto_tfm *tfm)
+{
+       struct cmh_kmac_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+
+       tctx->key.mode =3D CMH_KEY_NONE;
+       tctx->custom =3D NULL;
+       tctx->custom_len =3D 0;
+       spin_lock_init(&tctx->chunk_lock);
+       INIT_LIST_HEAD(&tctx->all_chunks);
+       crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+                                sizeof(struct cmh_kmac_reqctx));
+       return 0;
+}
+
+static void cmh_kmac_cra_exit(struct crypto_tfm *tfm)
+{
+       struct cmh_kmac_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+       struct cmh_kmac_chunk *chunk, *tmp;
+
+       /* Free any orphaned chunks (e.g. testmgr export/reimport poison) *=
/
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(chunk, tmp, &tctx->all_chunks, tfm_node) {
+               list_del(&chunk->tfm_node);
+               kfree(chunk);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+
+       cmh_key_destroy(&tctx->key);
+       kfree(tctx->custom);
+       tctx->custom =3D NULL;
+}
+
+/* Registration */
+
+static struct cmh_kmac_alg_drv cmh_kmac_drvs[CMH_KMAC_ALG_COUNT];
+
+/**
+ * cmh_kmac_register() - Register KMAC-128/256 hash algorithms with the cr=
ypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_kmac_register(void)
+{
+       unsigned int i;
+       int ret;
+
+       for (i =3D 0; i < CMH_KMAC_ALG_COUNT; i++) {
+               const struct cmh_kmac_alg_info *info =3D
+                       &cmh_kmac_algs_info[i];
+               struct cmh_kmac_alg_drv *drv =3D &cmh_kmac_drvs[i];
+               struct ahash_alg *alg =3D &drv->alg;
+
+               drv->info =3D info;
+
+               alg->init   =3D cmh_kmac_init;
+               alg->update =3D cmh_kmac_update;
+               alg->final  =3D cmh_kmac_final;
+               alg->finup  =3D cmh_kmac_finup;
+               alg->digest =3D cmh_kmac_digest;
+               alg->export =3D cmh_kmac_export;
+               alg->import =3D cmh_kmac_import;
+               alg->setkey =3D cmh_kmac_setkey;
+
+               alg->halg.digestsize =3D info->digest_size;
+               alg->halg.statesize  =3D sizeof(struct cmh_kmac_reqctx);
+
+               strscpy(alg->halg.base.cra_name, info->alg_name,
+                       CRYPTO_MAX_ALG_NAME);
+               strscpy(alg->halg.base.cra_driver_name, info->drv_name,
+                       CRYPTO_MAX_ALG_NAME);
+               alg->halg.base.cra_priority    =3D 300;
+               alg->halg.base.cra_flags       =3D CRYPTO_ALG_KERN_DRIVER_O=
NLY |
+                                                CRYPTO_ALG_NO_FALLBACK |
+                                                CRYPTO_ALG_ASYNC |
+                                                CRYPTO_ALG_REQ_VIRT;
+               alg->halg.base.cra_blocksize   =3D 1;  /* XOF/keyed XOF */
+               alg->halg.base.cra_ctxsize     =3D sizeof(struct cmh_kmac_t=
fm_ctx);
+               alg->halg.base.cra_init        =3D cmh_kmac_cra_init;
+               alg->halg.base.cra_exit        =3D cmh_kmac_cra_exit;
+               alg->halg.base.cra_module      =3D THIS_MODULE;
+
+               ret =3D crypto_register_ahash(alg);
+               if (ret) {
+                       dev_err(cmh_dev(), "kmac: failed to register %s (rc=
=3D%d)\n",
+                               info->drv_name, ret);
+                       while (i--)
+                               crypto_unregister_ahash(&cmh_kmac_drvs[i].a=
lg);
+                       return ret;
+               }
+
+               dev_dbg(cmh_dev(), "kmac: registered %s (priority 300)\n",
+                       info->drv_name);
+       }
+
+       dev_info(cmh_dev(), "kmac: %zu algorithm(s) registered\n",
+                CMH_KMAC_ALG_COUNT);
+       return 0;
+}
+
+/**
+ * cmh_kmac_unregister() - Unregister KMAC hash algorithms from the crypto=
 framework
+ */
+void cmh_kmac_unregister(void)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < CMH_KMAC_ALG_COUNT; i++) {
+               crypto_unregister_ahash(&cmh_kmac_drvs[i].alg);
+               dev_dbg(cmh_dev(), "kmac: unregistered %s\n",
+                       cmh_kmac_algs_info[i].drv_name);
+       }
+
+       dev_info(cmh_dev(), "kmac: cleaned up\n");
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index c18219197bd8..f04cc6855963 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -31,6 +31,8 @@
 #include "cmh_rh.h"
 #include "cmh_hash.h"
 #include "cmh_hmac.h"
+#include "cmh_cshake.h"
+#include "cmh_kmac.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -203,6 +205,16 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_hmac_register;

+       /* Register CSHAKE hash algorithms */
+       ret =3D cmh_cshake_register();
+       if (ret)
+               goto err_cshake_register;
+
+       /* Register KMAC hash algorithms */
+       ret =3D cmh_kmac_register();
+       if (ret)
+               goto err_kmac_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -215,6 +227,10 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_kmac_unregister();
+err_kmac_register:
+       cmh_cshake_unregister();
+err_cshake_register:
        cmh_hmac_unregister();
 err_hmac_register:
        cmh_hash_unregister();
@@ -245,6 +261,8 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_kmac_unregister();
+       cmh_cshake_unregister();
        cmh_hmac_unregister();
        cmh_hash_unregister();
        cmh_rh_cleanup(cfg);
diff --git a/drivers/crypto/cmh/include/cmh_cshake.h b/drivers/crypto/cmh/i=
nclude/cmh_cshake.h
new file mode 100644
index 000000000000..9bafe0baf52f
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_cshake.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API CSHAKE Driver
+ *
+ * Registers cSHAKE-128 and cSHAKE-256 ahash algorithms using
+ * HC_CMD_CSHAKE with inline customization string S.
+ */
+
+#ifndef CMH_CSHAKE_H
+#define CMH_CSHAKE_H
+
+int  cmh_cshake_register(void);
+void cmh_cshake_unregister(void);
+
+#endif /* CMH_CSHAKE_H */
diff --git a/drivers/crypto/cmh/include/cmh_kmac.h b/drivers/crypto/cmh/inc=
lude/cmh_kmac.h
new file mode 100644
index 000000000000..b3c92d71a0b6
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_kmac.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API KMAC Driver
+ *
+ * Registers KMAC-128 and KMAC-256 ahash algorithms using
+ * HC_CMD_KMAC with inline customization string S.
+ */
+
+#ifndef CMH_KMAC_H
+#define CMH_KMAC_H
+
+int  cmh_kmac_register(void);
+void cmh_kmac_unregister(void);
+
+#endif /* CMH_KMAC_H */
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

