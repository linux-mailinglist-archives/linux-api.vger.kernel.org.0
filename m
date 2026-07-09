Return-Path: <linux-api+bounces-6816-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZS3TIZQFUGoFsAIAu9opvQ
	(envelope-from <linux-api+bounces-6816-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:33:24 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CD773565A
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:33:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=xgJu+NbS;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6816-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6816-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C83EF305FF16
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4E93D25CC;
	Thu,  9 Jul 2026 20:31:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021080.outbound.protection.outlook.com [40.107.208.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A73CD8AC;
	Thu,  9 Jul 2026 20:31:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629098; cv=fail; b=kKdnuyOQKD09limqMLfzWmOFniL7K1yoJ8XCxPn5/8zKbGnV52QCEdIND8i82zt4+VJGPLt6M1IkVr1RPWLS/gPo87B1udameYuSo8YUi3jTKmIEvBT63m/pQrKjWFCfM2CSwhwWe7vdS6ipuy9rsoacmZgMXl4rm7PqjRgMlMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629098; c=relaxed/simple;
	bh=jTy+QYq+SwH5uOFzJYd8kcg4bF9tLu8s7xNAdJGJ+Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajgl/NP56mCbxVE915lS5a/ygieUliu3BQOpgEDHRmaueXLkvF6nvyAiIX57ja8lUWHLxsHoS84yxb7+0e7CWTGIx1RauegC7Nfx6yf+jx5UoyPiijvdBPtUAJNBJGdiqb5xn4sph9KazgpBnQR6jC980hzlfkOBVcTyghia7zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=xgJu+NbS; arc=fail smtp.client-ip=40.107.208.80
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1ZWMXlFdAFO9V+w93vkRgLJpiGjrtCJkbKvFEBXgZC/O7Zyiqnw63H0DLtDwIzRl4kGYoAQ8PulzOKXTbhdZSmHMmoRhiRt53C4hqd08fcBjDL2GFV5DZqb81v4llOCfUqUDI9eDEEujOUZD4Lq2AENYknHNrd9hh1nUOtlfo3Vx14qR9+JfNaE6XXurn9vgFQZSkBIRnqL21JX2XyH6+qUgoYJVaOQCLwV5COr0/+Hy23zqF4z5+adrPqmO1y90V83Tp8ZmFJADhiAIgZHHvYmY2ywueyur4Foi8G7ps2C36ttOAqmXvzrLJh/mTw2zcRuJtEvRAJdBl2KZzsLig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6hZoR/SEkZ/25SYs7GIIJkQS8xyTkHnDduu5TdmROZw=;
 b=XEBtNzkBAbR0bRx2mNvaq2Mc/7IgbqcO3hOrmGnxx5UUktv3RNHCPMzB1NQK7PE4zNTJc0b5IAOlLefvc/dUGYgLq6WvAYYpGKgq/NRYmhVY6BsLaTYXCZLFsNsyeh2e3d0QKpqrpIMtfeCZhl+H/nTLCjs0AspwJ5vlQZWmdLtvYagaFVxN/Z/BxaRMu+8YM6uHxtv66/bb8PbNLOiI6GnC3aevwLShQ38WAtcwtaojmFeURyw3KsBwQoZ5SBMP8lzQAMkFToOdjaMtql8f7TuBufQSxlIxOnL4FYG3afgMz1WVnBtX6Ooj+7/AspUlIgsHVai4xu6RtyZLcppLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hZoR/SEkZ/25SYs7GIIJkQS8xyTkHnDduu5TdmROZw=;
 b=xgJu+NbSH7PTHcvff5Iwm9sDa0GKR3k/f5Vf2NExj8+Cf1H7NgQQ24E/SwXWkbXha4y3yu5LH1tBNRgIqsBJ4Kg8TnLEM0TsTLg5K6Tgf/eI9L1VH91Eziz1BWC7P8igH8pt8tReppUhQEapRONt25mvlYw5H1gykxazg91NGkU0doQ1kMq4+UXACKJbJdlo/iinqbUWnKlL32YTpdmbFJOMT3TfestFbbMwVcpb3aGpQ01qJ/B8pXxpXj/t/fpzAYv87OopbUlnEVqHPX2VEBKeznwbQvRVbIc/V6ezF3JlnO0MkhDXwcr2ynZBeoPcknDgQ8eBnCqfHH49cx8H+w==
Received: from DS1P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::12) by
 PH0PR04MB10218.namprd04.prod.outlook.com (2603:10b6:510:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 20:31:24 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:8:242:cafe::8a) by DS1P221CA0021.outlook.office365.com
 (2603:10b6:8:242::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 20:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:23 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 52449180176E;
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
Subject: [PATCH v2 14/19] crypto: cmh - add ECDH/X25519 kpp
Date: Thu,  9 Jul 2026 13:30:32 -0700
Message-ID: <20260709203037.1884436-15-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|PH0PR04MB10218:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 98c03ece-0114-4fb0-710a-08deddf90b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|23010399003|36860700016|11063799006|5023799004|56012099006|22082099003|18002099003|3023799007|921020;
X-Microsoft-Antispam-Message-Info:
	U3Hydwb7w92jR8t+h2JXEtX8jc1DATyKNNjeWbo303c62XukRTppgO3/RAlNJG733qaCdryVRzvhpFwffyrBP6glxmvrKMcLzsOQL0GlyItlcTqUnxOe3HIOp4jqbEI3fpNbVzQGC8t9oxYHrCMgCnVbwRJNc+8+FHvT0PAHk8qTzlNSnIxr9P92d4ko8gcpxUjFfYd9dRAgokJROhjtMnGa6X9/lbjixPnHf1K9ENX8qcWm2tcxG9SXVvi3PfmmB45iC9pLL+UHAjN0ViicckxAiCgzjEkQL1zzsNUZmPcLS4KeI+Zi34sP57rVvJAVmY42T6TVnvWSDixp+BbX3PLK9pIEp3a3fQClXseq1cQBeO4gq5jiG3h4EnlH9XUlmBiCBsvbMuYzzltc5w9RqbrKP+Rq2zM9834+rnXukVdHZj3IO070y0SZ+0plxeVdS2e5mQWk4uAIMT8KQ1XY6924PDp6R5h/L45Ih8zjxFJZprTHPgsB5mt9Jkb7qVzcpmM7Hkg38elzdU3u2AMIpfOjHS0qM3i/AA6iWGlxWCiQ4blmHy3Kk/6vxxD869sNpe2LiJp52F86ZdjXN+b++pD3L17dUhzcDTvHv8aSUj50U5XKUZzVpnbSyRLfVCUR36d3MmpFvQtJJUwCSwof4EAc6MNTqWw3H8AxGdsCZI2XGUyYvJBrxHzx1YCXQt/AFrQo9U+jPXoYRVg7xI0HPy6WvMVQO1pdOzCBjztBDsV/P0GuvBioRmKdD4TUU0n+
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(23010399003)(36860700016)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003)(3023799007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ooqbwVnzvmH670/u/AyNvCKlZ6TXXIFyhqYsHFz+7Nnynt3Wct1BGr2YhEVR/dOZZkp/wlzBXviJBnlO3b41HvUZ55xrc3Co63pxF8l8MBCfffp91gmXrnQvnNEdSip+nY/otDuynfEi8H41Awn7KTKVfMDE3IlF7dDUpTN0wXpbpGhVSjBMjE5jbt741R69lgqguZ0pmqyupliZSkM4ODa4mgtpAuRWYpUu8o9+9ZU7FNAmRWmr2dsrByNtMIyU3fXe05WW2+wA2i3gpuh08rKg3VTkJximdc9UblmhD5HItYtscUHQmQ9u7iV8Q6CJ3DP0SmuI9pMHq48emCAOmJ9XLG61Nijl0Ho3rPd1itgCCAtT1nI3BaZHPrjOyKW2fUxiVoNO3H3X3FPMi3iq7iyQlZ0mGBOWdtsKjLyGRsO+8K8AhrdXcePpB+p+7g3o
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:23.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c03ece-0114-4fb0-710a-08deddf90b70
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB10218
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
	TAGGED_FROM(0.00)[bounces-6816-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 40CD773565A

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ECDH and X25519 kpp algorithms using the CMH PKE core.
Supports P-256, P-384, and Curve25519 for key agreement.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile       |   3 +-
 drivers/crypto/cmh/cmh_main.c     |   8 +
 drivers/crypto/cmh/cmh_pke_ecdh.c | 698 ++++++++++++++++++++++++++++++
 3 files changed, 708 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_pke_ecdh.c

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index fdbf66b13628..a4cea0a56fc1 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -32,7 +32,8 @@ cmh-y := \
 	cmh_rng.o \
 	cmh_pke_common.o \
 	cmh_pke_rsa.o \
-	cmh_pke_ecdsa.o
+	cmh_pke_ecdsa.o \
+	cmh_pke_ecdh.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 2191682f3d54..dd4e8812c457 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -292,6 +292,11 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pke_ecdsa_register;
 
+	/* Register PKE ECDH/X25519 kpp */
+	ret = cmh_pke_ecdh_register();
+	if (ret)
+		goto err_pke_ecdh_register;
+
 	/* Register key management device (/dev/cmh_mgmt) */
 	ret = cmh_mgmt_register();
 	if (ret)
@@ -304,6 +309,8 @@ static int cmh_probe(struct platform_device *pdev)
 	return 0;
 
 err_mgmt_register:
+	cmh_pke_ecdh_unregister();
+err_pke_ecdh_register:
 	cmh_pke_ecdsa_unregister();
 err_pke_ecdsa_register:
 	cmh_pke_rsa_unregister();
@@ -364,6 +371,7 @@ static void cmh_remove(struct platform_device *pdev)
 	cfg = &dev->config;
 
 	cmh_mgmt_unregister();
+	cmh_pke_ecdh_unregister();
 	cmh_pke_ecdsa_unregister();
 	cmh_pke_rsa_unregister();
 	cmh_ccp_poly_unregister();
diff --git a/drivers/crypto/cmh/cmh_pke_ecdh.c b/drivers/crypto/cmh/cmh_pke_ecdh.c
new file mode 100644
index 000000000000..d8b821cc4217
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pke_ecdh.c
@@ -0,0 +1,698 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- ECDH / X25519 kpp Driver
+ *
+ * Registers "ecdh-nist-p256", "ecdh-nist-p384", and "curve25519"
+ * kpp algorithms with priority 300.
+ *
+ * - set_secret: decodes private key from kpp_secret + ecdh struct
+ *   (NIST curves) or raw 32-byte scalar (Curve25519).
+ *   Stores in cmh_key_ctx: raw keys written via SYS_REF_TEMP.
+ *   Datastore-referenced keys are only reachable through the ioctl
+ *   path (cmh_mgmt.c).
+ *
+ * - generate_public_key: PKE_CMD_ECDH_KEYGEN -> outputs X coordinate
+ *   (NIST Weierstrass) or full public key (Edwards/Montgomery).
+ *   For NIST curves, we generate X||Y by calling ECDSA_PUBGEN instead,
+ *   matching the kernel ecdh.c pattern that outputs uncompressed X||Y.
+ *
+ * - compute_shared_secret: PKE_CMD_ECDH -> shared secret X coordinate.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <crypto/kpp.h>
+#include <crypto/ecdh.h>
+#include <crypto/internal/kpp.h>
+#include <crypto/internal/ecc.h>
+
+#include "cmh_pke.h"
+#include "cmh_sys.h"
+#include "cmh_sys_abi.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+/*
+ * ECDH key format: kpp_secret header + key_size(u16) + key data.
+ * We decode this inline to avoid depending on CONFIG_CRYPTO_ECDH.
+ */
+#define ECDH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + sizeof(unsigned short))
+
+struct cmh_ecdh_tfm_ctx {
+	struct cmh_key_ctx key;
+	u32 curve;		/* PKE_CURVE_* */
+	u32 clen;		/* coordinate length in bytes */
+};
+
+static inline struct cmh_ecdh_tfm_ctx *cmh_ecdh_ctx(struct crypto_kpp *tfm)
+{
+	return kpp_tfm_ctx(tfm);
+}
+
+/*
+ * Per-request context for ECDH/X25519 operations.
+ *
+ * generate_public_key: single-phase async VCQ.
+ * compute_shared_secret: 2-phase async VCQ with callback chaining.
+ *   Phase 1: sys_write(sk) + sys_new(ref) + ecdh(peer) + pflush
+ *            -> phase1 callback reads ref, submits Phase 2.
+ *   Phase 2: sys_data(ref, ss_dma) + sys_flush
+ *            -> phase2 callback extracts shared secret, completes req.
+ *
+ * Both phases target the same mbx_idx so the DS reference remains
+ * valid, since DS objects are MBX-scoped.
+ */
+struct cmh_ecdh_reqctx {
+	/* Buffers */
+	u8 *pk_buf;		/* keygen: output public key */
+	u8 *sk_buf;		/* private key copy */
+	u8 *peer_buf;		/* compute: peer public key */
+	u8 *ss_buf;		/* compute: shared secret output */
+	u64 *ref_buf;		/* compute: DS ref from Phase 1 */
+	/* DMA handles */
+	dma_addr_t pk_dma;
+	dma_addr_t sk_dma;
+	dma_addr_t peer_dma;
+	dma_addr_t ss_dma;
+	dma_addr_t ref_dma;
+	/* Sizes and params for Phase 2 re-submit */
+	u32 out_len;		/* keygen: public key size */
+	u32 clen;
+	u32 peer_len;
+	u32 sk_len;
+	u32 dma_swap;
+	int mbx_idx;		/* pinned MBX for Phase 2 */
+};
+
+/*
+ * set_secret: NIST curves decode kpp_secret + u16 key_size + raw scalar.
+ * Curve25519 uses raw 32-byte scalar directly.
+ */
+static int cmh_ecdh_set_secret_nist(struct crypto_kpp *tfm,
+				    const void *buf, unsigned int len)
+{
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+	const u8 *ptr = buf;
+	struct kpp_secret secret;
+	unsigned short key_size;
+	int ret;
+
+	if (!buf || len < ECDH_KPP_SECRET_MIN_SIZE)
+		return -EINVAL;
+
+	memcpy(&secret, ptr, sizeof(secret));
+	ptr += sizeof(secret);
+
+	if (secret.type != CRYPTO_KPP_SECRET_TYPE_ECDH)
+		return -EINVAL;
+	if (len < secret.len)
+		return -EINVAL;
+
+	memcpy(&key_size, ptr, sizeof(key_size));
+	ptr += sizeof(key_size);
+
+	if (key_size == 0) {
+		/*
+		 * key_size == 0: generate a validated random private key.
+		 * Uses the kernel ECC library (FIPS 186-5 A.2.2) to ensure
+		 * the scalar is in the valid range [2, n-3] for the curve.
+		 */
+		u64 priv[ECC_MAX_DIGITS];
+		unsigned int ndigits = ctx->clen / sizeof(u64);
+		unsigned int curve_id;
+		u8 *rnd;
+
+		if (secret.len != ECDH_KPP_SECRET_MIN_SIZE)
+			return -EINVAL;
+		if (ndigits > ECC_MAX_DIGITS)
+			return -EINVAL;
+		/* Reject non-limb-aligned clen to prevent ndigits truncation */
+		if (ctx->clen % sizeof(u64))
+			return -EINVAL;
+
+		if (ctx->curve == PKE_CURVE_P256)
+			curve_id = ECC_CURVE_NIST_P256;
+		else if (ctx->curve == PKE_CURVE_P384)
+			curve_id = ECC_CURVE_NIST_P384;
+		else
+			return -EINVAL;
+
+		ret = ecc_gen_privkey(curve_id, ndigits, priv);
+		if (ret) {
+			memzero_explicit(priv, sizeof(priv));
+			return ret;
+		}
+
+		rnd = kmalloc(ctx->clen, GFP_KERNEL);
+		if (!rnd) {
+			memzero_explicit(priv, sizeof(priv));
+			return -ENOMEM;
+		}
+
+		/* Convert VLI (native LE-digit-order) to big-endian bytes */
+		ecc_swap_digits(priv, (u64 *)rnd, ndigits);
+		memzero_explicit(priv, sizeof(priv));
+
+		ret = cmh_key_setkey_raw(&ctx->key, rnd, ctx->clen,
+					 CORE_ID_PKE);
+		kfree_sensitive(rnd);
+		return ret;
+	}
+
+	if (key_size != ctx->clen)
+		return -EINVAL;
+
+	if (secret.len != ECDH_KPP_SECRET_MIN_SIZE + key_size)
+		return -EINVAL;
+
+	return cmh_key_setkey_raw(&ctx->key, ptr, key_size, CORE_ID_PKE);
+}
+
+static int cmh_ecdh_set_secret_x25519(struct crypto_kpp *tfm,
+				      const void *buf, unsigned int len)
+{
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+
+	if (len != pke_curve_clen(PKE_CURVE_25519))
+		return -EINVAL;
+
+	return cmh_key_setkey_raw(&ctx->key, buf, len, CORE_ID_PKE);
+}
+
+static void cmh_ecdh_keygen_complete(void *data, int error)
+{
+	struct kpp_request *req = data;
+	struct cmh_ecdh_reqctx *rctx = kpp_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (!cmh_dma_map_error(rctx->sk_dma))
+		cmh_dma_unmap_single(rctx->sk_dma, rctx->sk_len,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->pk_dma))
+		cmh_dma_unmap_single(rctx->pk_dma, rctx->out_len,
+				     DMA_FROM_DEVICE);
+
+	if (!error) {
+		int nents;
+
+		nents = sg_nents_for_len(req->dst, rctx->out_len);
+		if (nents < 0 ||
+		    sg_copy_from_buffer(req->dst, nents,
+					rctx->pk_buf,
+					rctx->out_len) != rctx->out_len)
+			error = -EINVAL;
+		else
+			req->dst_len = rctx->out_len;
+	}
+
+	kfree_sensitive(rctx->sk_buf);
+	rctx->sk_buf = NULL;
+	kfree(rctx->pk_buf);
+	rctx->pk_buf = NULL;
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * generate_public_key: For NIST ECDH, use ECDH_KEYGEN which outputs
+ * the public key X-coordinate.  But the kernel kpp interface expects
+ * uncompressed X||Y, so we use ECDSA_PUBGEN which gives us (X,Y).
+ * For Curve25519, ECDH_KEYGEN gives us the Montgomery u-coordinate
+ * which is the full public key.
+ */
+static int cmh_ecdh_generate_public_key(struct kpp_request *req)
+{
+	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+	struct cmh_ecdh_reqctx *rctx = kpp_request_ctx(req);
+	u32 clen = ctx->clen;
+	bool is_25519 = (ctx->curve == PKE_CURVE_25519);
+	u32 out_len = is_25519 ? clen : 2 * clen;
+	struct vcq_cmd vcq[PKE_VCQ_CMDS_MAX];
+	struct core_dispatch dd;
+	u32 swap, dma_swap;
+	int ret, idx;
+	gfp_t gfp;
+
+	if (ctx->key.mode != CMH_KEY_RAW)
+		return -EINVAL;
+	if (req->dst_len < out_len)
+		return -EINVAL;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->out_len = out_len;
+	rctx->sk_len = ctx->key.raw.len;
+	rctx->pk_dma = DMA_MAPPING_ERROR;
+	rctx->sk_dma = DMA_MAPPING_ERROR;
+
+	rctx->pk_buf = kzalloc(out_len, gfp);
+	if (!rctx->pk_buf)
+		return -ENOMEM;
+
+	rctx->pk_dma = cmh_dma_map_single(rctx->pk_buf, out_len,
+					  DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(rctx->pk_dma)) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	swap = PKE_SWAP_FLAGS;
+	dma_swap = pke_swap_flags(ctx->curve);
+
+	dd = cmh_core_select_instance(CMH_CORE_PKE);
+
+	rctx->sk_buf = kmemdup(ctx->key.raw.data, ctx->key.raw.len, gfp);
+	if (!rctx->sk_buf) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+	rctx->sk_dma = cmh_dma_map_single(rctx->sk_buf, ctx->key.raw.len,
+					  DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->sk_dma)) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MAX);
+	idx = 1;
+	vcq_add_sys_write(&vcq[idx], SYS_REF_TEMP, rctx->sk_dma,
+			  SYS_REF_NONE, ctx->key.raw.len,
+			  ctx->key.raw.sys_type);
+	vcq[idx].id |= dma_swap;
+	idx++;
+	if (is_25519)
+		vcq_add_pke_ecdh_keygen(&vcq[idx++], dd.core_id, ctx->curve,
+					clen, rctx->pk_dma, SYS_REF_TEMP,
+					swap);
+	else
+		vcq_add_pke_ecdsa_pubgen(&vcq[idx++], dd.core_id,
+					 ctx->curve, clen, rctx->pk_dma,
+					 SYS_REF_TEMP, swap);
+	vcq_add_pke_flush(&vcq[idx++], dd.core_id);
+
+	ret = cmh_tm_submit_async(vcq, PKE_VCQ_CMDS_MAX, 1, dd.mbx_idx,
+				  cmh_ecdh_keygen_complete, req,
+				  !!(req->base.flags &
+				     CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (!ret)
+		return -EINPROGRESS;
+
+out_unmap:
+	if (!cmh_dma_map_error(rctx->sk_dma))
+		cmh_dma_unmap_single(rctx->sk_dma, ctx->key.raw.len,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->pk_dma))
+		cmh_dma_unmap_single(rctx->pk_dma, out_len,
+				     DMA_FROM_DEVICE);
+
+out_free:
+	kfree_sensitive(rctx->sk_buf);
+	kfree(rctx->pk_buf);
+	return ret;
+}
+
+static void cmh_ecdh_ss_phase2_complete(void *data, int error)
+{
+	struct kpp_request *req = data;
+	struct cmh_ecdh_reqctx *rctx = kpp_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	if (!cmh_dma_map_error(rctx->ss_dma))
+		cmh_dma_unmap_single(rctx->ss_dma, rctx->clen,
+				     DMA_FROM_DEVICE);
+
+	if (!error) {
+		int nents;
+
+		nents = sg_nents_for_len(req->dst, rctx->clen);
+		if (nents < 0 ||
+		    sg_copy_from_buffer(req->dst, nents,
+					rctx->ss_buf,
+					rctx->clen) != rctx->clen)
+			error = -EINVAL;
+		else
+			req->dst_len = rctx->clen;
+	}
+
+	kfree(rctx->ref_buf);
+	rctx->ref_buf = NULL;
+	kfree_sensitive(rctx->ss_buf);
+	rctx->ss_buf = NULL;
+	cmh_complete(&req->base, error);
+}
+
+static void cmh_ecdh_ss_phase1_complete(void *data, int error)
+{
+	struct kpp_request *req = data;
+	struct cmh_ecdh_reqctx *rctx = kpp_request_ctx(req);
+	struct vcq_cmd vcq[3];
+	int ret;
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	/* Phase 1-only resources: sk, peer -- always clean up */
+	if (!cmh_dma_map_error(rctx->sk_dma))
+		cmh_dma_unmap_single(rctx->sk_dma, rctx->sk_len,
+				     DMA_TO_DEVICE);
+	kfree_sensitive(rctx->sk_buf);
+	rctx->sk_buf = NULL;
+
+	if (!cmh_dma_map_error(rctx->peer_dma))
+		cmh_dma_unmap_single(rctx->peer_dma, rctx->peer_len,
+				     DMA_TO_DEVICE);
+	kfree(rctx->peer_buf);
+	rctx->peer_buf = NULL;
+
+	if (error)
+		goto out_cleanup;
+
+	/* Read the DS reference written by Phase 1 */
+	cmh_dma_sync_for_cpu(rctx->ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+	cmh_dma_unmap_single(rctx->ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+	rctx->ref_dma = DMA_MAPPING_ERROR;
+
+	/* Phase 2: extract shared secret from DS */
+	vcq_set_header(&vcq[0], 3);
+	vcq_add_sys_data(&vcq[1], *rctx->ref_buf, rctx->ss_dma,
+			 rctx->clen);
+	vcq[1].id |= rctx->dma_swap;
+	vcq_add_sys_flush(&vcq[2]);
+
+	ret = cmh_tm_submit_async(vcq, 3, 1, rctx->mbx_idx,
+				  cmh_ecdh_ss_phase2_complete, req,
+				  true, 0);
+	if (ret == -EBUSY || !ret)
+		return;
+
+	error = ret;
+
+out_cleanup:
+	if (!cmh_dma_map_error(rctx->ref_dma))
+		cmh_dma_unmap_single(rctx->ref_dma, sizeof(u64),
+				     DMA_FROM_DEVICE);
+	if (!cmh_dma_map_error(rctx->ss_dma))
+		cmh_dma_unmap_single(rctx->ss_dma, rctx->clen,
+				     DMA_FROM_DEVICE);
+	kfree(rctx->ref_buf);
+	rctx->ref_buf = NULL;
+	kfree_sensitive(rctx->ss_buf);
+	rctx->ss_buf = NULL;
+	cmh_complete(&req->base, error);
+}
+
+/*
+ * compute_shared_secret: PKE_CMD_ECDH.
+ *
+ * req->src = peer public key (X||Y for NIST, raw 32B for Curve25519).
+ * Output = shared secret X coordinate (clen bytes).
+ *
+ * The CMH ECDH command stores the shared secret in a DS object,
+ * not directly to DMA.  We create a DS slot with SYS_CMD_NEW,
+ * reference it via SYS_REF_LAST, then extract the result with a
+ * second VCQ submission using SYS_CMD_DATA with the actual ref.
+ */
+static int cmh_ecdh_compute_shared_secret(struct kpp_request *req)
+{
+	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+	struct cmh_ecdh_reqctx *rctx = kpp_request_ctx(req);
+	u32 clen = ctx->clen;
+	bool is_25519 = (ctx->curve == PKE_CURVE_25519);
+	u32 peer_len = is_25519 ? clen : 2 * clen;
+	u32 ss_type = SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_PKE);
+	struct vcq_cmd vcq[5];
+	struct core_dispatch dd;
+	u32 swap, dma_swap;
+	int ret, idx, nents;
+	gfp_t gfp;
+
+	if (ctx->key.mode != CMH_KEY_RAW)
+		return -EINVAL;
+	if (req->src_len < peer_len || req->dst_len < clen)
+		return -EINVAL;
+
+	gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+	      GFP_KERNEL : GFP_ATOMIC;
+
+	memset(rctx, 0, sizeof(*rctx));
+	rctx->clen = clen;
+	rctx->peer_len = peer_len;
+	rctx->sk_len = ctx->key.raw.len;
+	rctx->pk_dma = DMA_MAPPING_ERROR;
+	rctx->sk_dma = DMA_MAPPING_ERROR;
+	rctx->peer_dma = DMA_MAPPING_ERROR;
+	rctx->ss_dma = DMA_MAPPING_ERROR;
+	rctx->ref_dma = DMA_MAPPING_ERROR;
+
+	rctx->peer_buf = kmalloc(peer_len, gfp);
+	rctx->ss_buf = kzalloc(clen, gfp);
+	rctx->ref_buf = kzalloc_obj(u64, gfp);
+	if (!rctx->peer_buf || !rctx->ss_buf || !rctx->ref_buf) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	nents = sg_nents_for_len(req->src, peer_len);
+	if (nents < 0 ||
+	    sg_pcopy_to_buffer(req->src, nents, rctx->peer_buf,
+			       peer_len, 0) != peer_len) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	rctx->peer_dma = cmh_dma_map_single(rctx->peer_buf, peer_len,
+					    DMA_TO_DEVICE);
+	rctx->ss_dma = cmh_dma_map_single(rctx->ss_buf, clen,
+					  DMA_FROM_DEVICE);
+	rctx->ref_dma = cmh_dma_map_single(rctx->ref_buf, sizeof(u64),
+					   DMA_FROM_DEVICE);
+
+	if (cmh_dma_map_error(rctx->peer_dma) ||
+	    cmh_dma_map_error(rctx->ss_dma) ||
+	    cmh_dma_map_error(rctx->ref_dma)) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	swap = PKE_SWAP_FLAGS;
+	dma_swap = pke_swap_flags(ctx->curve);
+	rctx->dma_swap = dma_swap;
+
+	dd = cmh_core_select_instance(CMH_CORE_PKE);
+	rctx->mbx_idx = dd.mbx_idx;
+
+	rctx->sk_buf = kmemdup(ctx->key.raw.data, ctx->key.raw.len, gfp);
+	if (!rctx->sk_buf) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+	rctx->sk_dma = cmh_dma_map_single(rctx->sk_buf, ctx->key.raw.len,
+					  DMA_TO_DEVICE);
+	if (cmh_dma_map_error(rctx->sk_dma)) {
+		ret = -ENOMEM;
+		goto out_unmap;
+	}
+
+	vcq_set_header(&vcq[0], 5);
+	idx = 1;
+	vcq_add_sys_write(&vcq[idx], SYS_REF_TEMP, rctx->sk_dma,
+			  SYS_REF_NONE, ctx->key.raw.len,
+			  ctx->key.raw.sys_type);
+	vcq[idx].id |= dma_swap;
+	idx++;
+	vcq_add_sys_new(&vcq[idx++], 0, rctx->ref_dma, clen);
+	vcq_add_pke_ecdh(&vcq[idx++], dd.core_id, ctx->curve, clen,
+			 clen, ss_type, rctx->peer_dma,
+			 SYS_REF_TEMP, SYS_REF_LAST, swap);
+	vcq_add_pke_flush(&vcq[idx++], dd.core_id);
+
+	ret = cmh_tm_submit_async(vcq, 5, 1, dd.mbx_idx,
+				  cmh_ecdh_ss_phase1_complete, req,
+				  !!(req->base.flags &
+				     CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (!ret)
+		return -EINPROGRESS;
+
+out_unmap:
+	if (!cmh_dma_map_error(rctx->sk_dma))
+		cmh_dma_unmap_single(rctx->sk_dma, rctx->sk_len,
+				     DMA_TO_DEVICE);
+	if (!cmh_dma_map_error(rctx->ss_dma))
+		cmh_dma_unmap_single(rctx->ss_dma, clen,
+				     DMA_FROM_DEVICE);
+	if (!cmh_dma_map_error(rctx->ref_dma))
+		cmh_dma_unmap_single(rctx->ref_dma, sizeof(u64),
+				     DMA_FROM_DEVICE);
+	if (!cmh_dma_map_error(rctx->peer_dma))
+		cmh_dma_unmap_single(rctx->peer_dma, peer_len,
+				     DMA_TO_DEVICE);
+
+out_free:
+	kfree_sensitive(rctx->sk_buf);
+	kfree(rctx->ref_buf);
+	kfree_sensitive(rctx->ss_buf);
+	kfree(rctx->peer_buf);
+	return ret;
+}
+
+static unsigned int cmh_ecdh_max_size(struct crypto_kpp *tfm)
+{
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+
+	/* Max output = X||Y for generate_public_key (NIST) */
+	return 2 * ctx->clen;
+}
+
+static unsigned int cmh_x25519_max_size(struct crypto_kpp *tfm)
+{
+	return pke_curve_clen(PKE_CURVE_25519); /* single coordinate */
+}
+
+static int cmh_ecdh_p256_init(struct crypto_kpp *tfm)
+{
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->curve = PKE_CURVE_P256;
+	ctx->clen = pke_curve_clen(PKE_CURVE_P256);
+	tfm->reqsize = sizeof(struct cmh_ecdh_reqctx);
+	return 0;
+}
+
+static int cmh_ecdh_p384_init(struct crypto_kpp *tfm)
+{
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->curve = PKE_CURVE_P384;
+	ctx->clen = pke_curve_clen(PKE_CURVE_P384);
+	tfm->reqsize = sizeof(struct cmh_ecdh_reqctx);
+	return 0;
+}
+
+static int cmh_x25519_init(struct crypto_kpp *tfm)
+{
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->curve = PKE_CURVE_25519;
+	ctx->clen = pke_curve_clen(PKE_CURVE_25519);
+	tfm->reqsize = sizeof(struct cmh_ecdh_reqctx);
+	return 0;
+}
+
+static void cmh_ecdh_exit(struct crypto_kpp *tfm)
+{
+	struct cmh_ecdh_tfm_ctx *ctx = cmh_ecdh_ctx(tfm);
+
+	cmh_key_destroy(&ctx->key);
+}
+
+static struct kpp_alg cmh_ecdh_algs[] = {
+	{
+		.set_secret		= cmh_ecdh_set_secret_nist,
+		.generate_public_key	= cmh_ecdh_generate_public_key,
+		.compute_shared_secret	= cmh_ecdh_compute_shared_secret,
+		.max_size		= cmh_ecdh_max_size,
+		.init			= cmh_ecdh_p256_init,
+		.exit			= cmh_ecdh_exit,
+		.base = {
+			.cra_name	  = "ecdh-nist-p256",
+			.cra_driver_name  = "cri-cmh-ecdh-nist-p256",
+			.cra_priority	  = 300,
+			.cra_flags	  = CRYPTO_ALG_ASYNC,
+			.cra_module	  = THIS_MODULE,
+			.cra_ctxsize	  = sizeof(struct cmh_ecdh_tfm_ctx),
+		},
+	},
+	{
+		.set_secret		= cmh_ecdh_set_secret_nist,
+		.generate_public_key	= cmh_ecdh_generate_public_key,
+		.compute_shared_secret	= cmh_ecdh_compute_shared_secret,
+		.max_size		= cmh_ecdh_max_size,
+		.init			= cmh_ecdh_p384_init,
+		.exit			= cmh_ecdh_exit,
+		.base = {
+			.cra_name	  = "ecdh-nist-p384",
+			.cra_driver_name  = "cri-cmh-ecdh-nist-p384",
+			.cra_priority	  = 300,
+			.cra_flags	  = CRYPTO_ALG_ASYNC,
+			.cra_module	  = THIS_MODULE,
+			.cra_ctxsize	  = sizeof(struct cmh_ecdh_tfm_ctx),
+		},
+	},
+	{
+		.set_secret		= cmh_ecdh_set_secret_x25519,
+		.generate_public_key	= cmh_ecdh_generate_public_key,
+		.compute_shared_secret	= cmh_ecdh_compute_shared_secret,
+		.max_size		= cmh_x25519_max_size,
+		.init			= cmh_x25519_init,
+		.exit			= cmh_ecdh_exit,
+		.base = {
+			.cra_name	  = "curve25519",
+			.cra_driver_name  = "cri-cmh-curve25519",
+			.cra_priority	  = 300,
+			.cra_flags	  = CRYPTO_ALG_ASYNC,
+			.cra_module	  = THIS_MODULE,
+			.cra_ctxsize	  = sizeof(struct cmh_ecdh_tfm_ctx),
+		},
+	},
+};
+
+/**
+ * cmh_pke_ecdh_register() - Register ECDH kpp algorithms with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_pke_ecdh_register(void)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(cmh_ecdh_algs); i++) {
+		ret = crypto_register_kpp(&cmh_ecdh_algs[i]);
+		if (ret) {
+			dev_err(cmh_dev(), "cmh: failed to register %s (%d)\n",
+				cmh_ecdh_algs[i].base.cra_name, ret);
+			goto err_unregister;
+		}
+	}
+
+	return 0;
+
+err_unregister:
+	while (i--)
+		crypto_unregister_kpp(&cmh_ecdh_algs[i]);
+	return ret;
+}
+
+/**
+ * cmh_pke_ecdh_unregister() - Unregister ECDH kpp algorithms from the crypto framework
+ */
+void cmh_pke_ecdh_unregister(void)
+{
+	int i = ARRAY_SIZE(cmh_ecdh_algs);
+
+	while (i--)
+		crypto_unregister_kpp(&cmh_ecdh_algs[i]);
+}
-- 
2.43.7


