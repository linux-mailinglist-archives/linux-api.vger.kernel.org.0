Return-Path: <linux-api+bounces-6690-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id h93oICVnPWpx2ggAu9opvQ
	(envelope-from <linux-api+bounces-6690-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:36:37 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A886C7D92
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:36:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b="4f/doGob";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6690-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6690-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 039D330C63F9
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71CA3EDE57;
	Thu, 25 Jun 2026 17:34:19 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022095.outbound.protection.outlook.com [40.93.195.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C64C3ED136;
	Thu, 25 Jun 2026 17:34:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408859; cv=fail; b=mi5H0chNlAEIMFcm86qIUAOmH7ElbKhg26s8GMfdZujcURS5rnjHFUpn9ZXJZcl+07c0kqDof5huRfrAvw5Ve9SjB24pwgEz1tFDysnUynOKdKPOpAzJgABvaFBMjAvQ1Ff0+RNyox+zb9F/ISj8GuvPerVVMPXQUNwjodxLhGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408859; c=relaxed/simple;
	bh=y4myAVBbg6tolCO+ichHbgF1lO+HixcJ5MeQMWBW62c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eO+TdDpLq1qoS3SlAlnPfi82ns5sDmVherbWkk+1rH5I7BFDP8whherSTQYqqihDSteiVvhraph2OfyW7VQFN+KdKxtZfCKDX5yCzBRSswYb3f33SZL6wmMFdIlxeuVLkXPlbWQzjocG2Td/oRvGGLZeECPYhuBSbmt21CyOQgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=4f/doGob; arc=fail smtp.client-ip=40.93.195.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wWGooNz0EUBHSNchFYjO1G8tQq0VUaH0EXHpDN3/QJukcrFQ2sD377Kg93GqhObtJr4BHDpUlaXAABTLiTS+OzkMsy00Sr+q1IFf0+42CW5GeyMN9QbYde858tssqe0g3MkYPGuK1EVowRGXYZ7TavAb8aKB3Mj6cC7sj0eqeJPOh1s0qdTsSYgPKA9iMthzeFAfeHIfiOQlatz9ZFpjo0rvBvTFWvY8f1FiubVtHc/DzILaedeEBvWFeueocAeZPX9v/n9bfn9BYKjTFp7FWZcEEDztD9Nyl+KtoYhUbn01f5ksFNtK/URowr3M4Sjz3Ewzz9aPyXziuBak6dnpnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rohtc3LuMw+G1Efka3OAngS4CQk8ACRmH8Q+BThi3pE=;
 b=MCDzO83vHrcLVp1gyY9l/or7lnGcrS0wH0gfTCqHdHiDOhNieo8yH8JP2JxIQf7HXsW3OAXIlr2D2fWXaRd1+6gNP0AK9usbNiMeGz2DBoyWed9xMWZym3b1AYsvg0uJyJcYDdLHN6iqmrkp69BVCCEKbwQy4LOpNoVt+Ymaj0dXnwr17TelKtamB8bmo0bUtn97h0aRWByMgrz83waqFfVzqMzTHNP9yQTs8u9R1YL1fRPFNNWq4WVtDnboNi4CiNgiyr8yh46oaTqunofAxcrea55WM/D6rKzZs31QMyrXJ1OFsQVlAS4vbbOg+J9WL9cB2ZTCsA3TWvZqnJq+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rohtc3LuMw+G1Efka3OAngS4CQk8ACRmH8Q+BThi3pE=;
 b=4f/doGobqR66jRqi0j3kars9LuIMzrCBeZBJI/y3LACYIuyLaneyyV51gmyPBIUtttM1BrjstB1FNlEptLOH/5pAUwCBr1DD7pChH5BIn8bCSu5yiLhWtpR3f3ES0CP9oJYjw/BN3/QxGzJf5Cmc70/MW8LNIeQIxNDdugK5t+WHTlSq4AmhQuXLRqtBUokqk6e9w0it7KGdsV7xkzGOFAA5RZfau1oVmMVndu0CCej/ZAIMpezOpx0a9qjdT1QiyiKPLZ8PQvKx6mjP1L72KbLqJGBq+HdPVMmfVd/Mb+cNC6xnNHIDQcKZtlUrbmtICZ6fqwRo/wDRfzFS0ZcBzg==
Received: from PH0PR07CA0118.namprd07.prod.outlook.com (2603:10b6:510:4::33)
 by DS6PR04MB9939.namprd04.prod.outlook.com (2603:10b6:8:368::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 17:34:10 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::78) by PH0PR07CA0118.outlook.office365.com
 (2603:10b6:510:4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 17:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:09 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 17533180176E;
	Thu, 25 Jun 2026 17:34:07 +0000 (UTC)
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
Subject: [PATCH 11/19] crypto: cmh - add DRBG hwrng
Date: Thu, 25 Jun 2026 10:33:19 -0700
Message-ID: <20260625173328.1140487-12-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|DS6PR04MB9939:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a4764024-d582-4a90-78c1-08ded2dff6f6
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|921020|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2n2WBUZyDQioejsGCPrEJARWdxBI0VPPhP1iDHTaiHCpkBMbYz9RfVNap1jsEOV6FGGtlpM99lyS/+hWaCReETGoRbKZbcEuv/+lhQvu1+qZrRrLdz6ivg95ccegqvpey829xSHYEUR7FGee035GJS6qlO0Xp/+2ExCMnlE8ZSOFpfyyO/mzBzMRt3UyqL4SNLDqgi6rIdwX8RYZrgDTOAmpr16tPkSwOtrEJDxxnmbAXhiPG2h65iryy1+YtyIPNOmaQ5gJEQzxRjdGLJG/ySRePRVf9k55Kn5Kro66G4URyKrnxNXrIqaUwL/oviDZElMx/C1GIKAY6jL49b1qPhWAJeYzQgre7vbzm/Lo7QMjIBYS4CGVPRIee+A92sDVLviNjX7pBHH807ayi41gY42WvjayEVdpZ2j3z1VMvw3pzRA9i23l+Vw1UnVNVLsLj2CCYIo3zhC8VNA3ERVkM8s3adKnOc4ndujLr908m1z/wGuUT6Xgcr65FbqYVRDIdarmK91v+Qjib5ynS/Rwz9908uohJrehv4CHc42zD8omtUEprcl1F7hr2EM0G9b88VJ9y1ft2p92aYzuUlD313ZoIR2Qpyj11B1WkgZeFknW9t2Jnp74mIUE4qP6BEtNj2guCMzKkcvNEtFmdUHIcE6GcH8aUcaCcXQBJ+ZtJLd578eyDtZZZIg6FtGzrzEaZVaHWUsH8qgec83KFiFhFRyVXWYDtg/xcZHqblSAgnG6VoPF3cj9PDZh5Me0e1zc
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(921020)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eIAApoSRY52zOG00XcTgjGJY+xuPSHB6aF2JOQN/gWdwnzhG/6NINJcXYJjCOEWNdQ0v/OFHgbl7PoJ+tFtkdBOwCU8cyuPZDEdW6SzWhDQFRZNMLZdsf3jXKXVSQLlMM3RTqiIpNYLdIPn2OZj+o/hBnkDIfoUHBymvpQB2FSO5V+S4rPto/Kx4Zo2Vew1xQXYnuZTQ2tgYYuJeaD0vJm5v+xxBPi0D97sOJ6z8JTRiTo4SHioDfwh8DR3IPhpVHcXx542+53cGl/tMtrR7snhMoePApSbioybTrdtMtGokfHE82oKJ4jLopLhXwlMSVVVZHgK47dvb7EenfqdWXtf6hRj9uOy3ZxhaYi8Y9iJx9JhJaSAUPHrcPZdqGsfxncUnoqxCB42+EtcN37pJuyJH/RYkDdpD75ZebO4WkKgjs42Zxq3TqY3r2UAJeVPo
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:09.4825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4764024-d582-4a90-78c1-08ded2dff6f6
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR04MB9939
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
	TAGGED_FROM(0.00)[bounces-6690-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 19A886C7D92

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register the CMH DRBG core (core ID 0x0f) as an hwrng provider.
The hardware implements a NIST SP 800-90A compliant DRBG with
automatic self-seeding.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
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
@@ -28,7 +28,8 @@ cmh-y :=3D \
        cmh_sm4_cmac.o \
        cmh_ccp.o \
        cmh_ccp_aead.o \
-       cmh_ccp_poly.o
+       cmh_ccp_poly.o \
+       cmh_rng.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 79df27d43e7e..f31c50168e4a 100644
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
@@ -224,6 +225,11 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_sm3_register;

+       /* Register hwrng backed by DRBG core */
+       ret =3D cmh_rng_register(pdev);
+       if (ret)
+               goto err_rng_register;
+
        /* Register AES skcipher algorithms */
        ret =3D cmh_aes_register();
        if (ret)
@@ -299,6 +305,8 @@ static int cmh_probe(struct platform_device *pdev)
 err_aes_aead_register:
        cmh_aes_unregister();
 err_aes_register:
+       cmh_rng_unregister();
+err_rng_register:
        cmh_sm3_unregister();
 err_sm3_register:
        cmh_kmac_unregister();
@@ -344,6 +352,7 @@ static void cmh_remove(struct platform_device *pdev)
        cmh_aes_cmac_unregister();
        cmh_aes_aead_unregister();
        cmh_aes_unregister();
+       cmh_rng_unregister();
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
+/* VCQ layout for .read(): header + GENERATE + FLUSH =3D 3 entries. */
+#define DRBG_READ_VCQ_CMDS     3
+
+/* VCQ layout for CONFIG: header + RESET + CONFIG + FLUSH =3D 4 entries. *=
/
+#define DRBG_CONFIG_VCQ_CMDS   4
+
+/*
+ * Linux hwrng quality is expressed in bits of entropy per 1024 bits of
+ * input.  The kernel clamps to this maximum; mirror it here so our
+ * MODULE_PARM_DESC and clamp logic stay in sync.
+ */
+#define CMH_HWRNG_QUALITY_MAX  1024
+
+/* Module parameters */
+
+static int hwrng_quality;
+module_param(hwrng_quality, int, 0444);
+MODULE_PARM_DESC(hwrng_quality,
+                "hwrng quality (0=3Dno CRNG seeding, 1-1024=3Denable; defa=
ult: 0)");
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+static char *drbg_config =3D "auto";
+module_param(drbg_config, charp, 0444);
+MODULE_PARM_DESC(drbg_config,
+                "[debug] DRBG config at probe: \"auto\"=3Dattempt CONFIG, =
\"skip\"=3Dassume external (default: auto)");
+#else
+static const char *drbg_config =3D "auto";
+#endif
+
+/*
+ * DRBG parameters -- hardcoded to production defaults.
+ * Entropy ratio 0 =3D 1:1 (full entropy), security strength 0x10 =3D 256-=
bit.
+ */
+#define CMH_DRBG_ENTROPY_RATIO         0
+#define CMH_DRBG_SECURITY_STRENGTH     0x10
+
+static unsigned int drbg_timeout_ms =3D 500;
+
+/* VCQ Builders */
+
+static void vcq_add_drbg_generate(struct vcq_cmd *slot, u64 dst_phys, u32 =
len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(CORE_ID_DRBG, 0, 1, DRBG_CMD_GENERATE);
+       slot->hwc.drbg.cmd_generate.dst =3D dst_phys;
+       slot->hwc.drbg.cmd_generate.len =3D len;
+}
+
+/*
+ * Maximum bytes per DRBG GENERATE request.  The kernel calls .read()
+ * repeatedly to fill larger requests, so capping here is safe.
+ * 32 bytes matches the 256-bit security strength natural output size.
+ */
+#define CMH_DRBG_MAX_GENERATE  32U
+
+/* hwrng .read() callback */
+
+static int cmh_rng_read(struct hwrng *rng, void *data, size_t max, bool wa=
it)
+{
+       struct cmh_dma_orphan *orphan;
+       struct vcq_cmd vcq[DRBG_READ_VCQ_CMDS];
+       dma_addr_t dma_addr;
+       void *dmabuf;
+       size_t nbytes;
+       int ret;
+
+       if (max =3D=3D 0)
+               return 0;
+
+       /*
+        * Our path uses GFP_KERNEL allocations and synchronous VCQ
+        * submission -- both may sleep.  When the caller indicates
+        * non-blocking context (!wait), return 0 ("no data yet") so
+        * the hwrng core retries later.
+        */
+       if (!wait)
+               return 0;
+
+       nbytes =3D min_t(size_t, max, CMH_DRBG_MAX_GENERATE);
+
+       orphan =3D kmalloc_obj(*orphan, GFP_KERNEL);
+       if (!orphan)
+               return -ENOMEM;
+
+       dmabuf =3D kmalloc(nbytes, GFP_KERNEL);
+       if (!dmabuf) {
+               kfree(orphan);
+               return -ENOMEM;
+       }
+
+       dma_addr =3D cmh_dma_map_single(dmabuf, nbytes, DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(dma_addr)) {
+               kfree(dmabuf);
+               kfree(orphan);
+               return -ENOMEM;
+       }
+
+       orphan->buf  =3D dmabuf;
+       orphan->addr =3D dma_addr;
+       orphan->len  =3D nbytes;
+       orphan->dir  =3D DMA_FROM_DEVICE;
+
+       vcq_set_header(&vcq[0], DRBG_READ_VCQ_CMDS);
+       vcq_add_drbg_generate(&vcq[1], dma_addr, nbytes);
+       vcq_add_flush(&vcq[2], CORE_ID_DRBG);
+
+       /*
+        * Use the noabort variant: if the MBX is occupied by a slow
+        * operation (e.g. SLH-DSA sign at 120 s), we must not issue
+        * MBX_COMMAND_ABORT -- that would kill the unrelated in-flight
+        * VCQ.  On timeout with an in-flight VCQ (-EINPROGRESS), the
+        * orphan callback defers DMA cleanup until the RH fires.
+        */
+       ret =3D cmh_tm_submit_sync_noabort(vcq, DRBG_READ_VCQ_CMDS, 1,
+                                        msecs_to_jiffies(drbg_timeout_ms),
+                                        cmh_dma_orphan_free, orphan);
+       if (ret =3D=3D -EINPROGRESS) {
+               /* Orphan callback owns dmabuf -- will free on VCQ completi=
on */
+               return -EAGAIN;
+       }
+
+       /* Normal path or cancelled-from-queue: caller owns DMA */
+       cmh_dma_unmap_single(dma_addr, nbytes, DMA_FROM_DEVICE);
+       kfree(orphan);
+
+       if (ret) {
+               /*
+                * Only translate known transient conditions to -EAGAIN
+                * so the hwrng subsystem retries later.  Propagate
+                * unexpected failures unchanged to avoid masking real
+                * faults and causing indefinite retry loops.
+                */
+               switch (ret) {
+               case -EAGAIN:
+               case -EBUSY:
+               case -ETIMEDOUT:
+               case -EIO:
+               /*
+                * -ENODEV: the TM is not running -- occurs when the
+                * hwrng kthread (PF_NOFREEZE, not frozen during
+                * suspend) calls .read() while the device is suspended.
+                * Treat as transient: the TM restarts on resume.
+                */
+               case -ENODEV:
+                       dev_dbg_ratelimited(cmh_dev(),
+                                           "rng: transient DRBG failure (r=
c=3D%d)\n",
+                                           ret);
+                       kfree(dmabuf);
+                       return -EAGAIN;
+               default:
+                       dev_err_ratelimited(cmh_dev(),
+                                           "rng: DRBG generate failed (rc=
=3D%d)\n",
+                                           ret);
+                       kfree(dmabuf);
+                       return ret;
+               }
+       }
+
+       memcpy(data, dmabuf, nbytes);
+       kfree(dmabuf);
+
+       return nbytes;
+}
+
+/* Registration */
+
+static bool cmh_rng_registered;
+
+static struct hwrng cmh_hwrng =3D {
+       .name =3D "cri-cmh-drbg",
+       .read =3D cmh_rng_read,
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
+       int ret;
+
+       cmh_hwrng.quality =3D hwrng_quality;
+
+       if (cmh_hwrng.quality > CMH_HWRNG_QUALITY_MAX)
+               cmh_hwrng.quality =3D CMH_HWRNG_QUALITY_MAX;
+
+       /*
+        * DRBG CONFIG is a management-host operation.  In "auto" mode,
+        * attempt it -- this succeeds in stateless mode (any host) or
+        * when we are the management host in stateful mode.  On -EPERM
+        * (not management host) we continue without error -- GENERATE
+        * will work once the management host configures the DRBG.
+        *
+        * In "skip" mode, do not issue CONFIG -- assume the management
+        * host has already configured (or will configure) the DRBG.
+        */
+       if (strcmp(drbg_config, "skip") !=3D 0) {
+               struct vcq_cmd cfg_vcq[DRBG_CONFIG_VCQ_CMDS];
+
+               if (strcmp(drbg_config, "auto") !=3D 0)
+                       dev_warn(&pdev->dev,
+                                "rng: unrecognized drbg_config=3D\"%s\", t=
reating as \"auto\"\n",
+                                drbg_config);
+
+               vcq_set_header(&cfg_vcq[0], DRBG_CONFIG_VCQ_CMDS);
+               vcq_add_drbg_reset(&cfg_vcq[1]);
+               vcq_add_drbg_config(&cfg_vcq[2], CMH_DRBG_ENTROPY_RATIO,
+                                   CMH_DRBG_SECURITY_STRENGTH);
+               vcq_add_flush(&cfg_vcq[3], CORE_ID_DRBG);
+               ret =3D cmh_tm_submit_sync(cfg_vcq, DRBG_CONFIG_VCQ_CMDS, 1=
);
+               if (ret =3D=3D -EPERM)
+                       dev_notice(&pdev->dev,
+                                  "rng: DRBG config not permitted (not man=
agement host); assuming external configuration\n");
+               else if (ret)
+                       dev_warn(&pdev->dev,
+                                "rng: DRBG config failed (rc=3D%d)\n", ret=
);
+               else
+                       dev_info(&pdev->dev,
+                                "rng: DRBG configured (ratio=3D%u strength=
=3D0x%02x)\n",
+                                CMH_DRBG_ENTROPY_RATIO,
+                                CMH_DRBG_SECURITY_STRENGTH);
+       } else {
+               dev_info(&pdev->dev,
+                        "rng: DRBG config skipped (drbg_config=3Dskip); as=
suming external configuration\n");
+       }
+
+       ret =3D hwrng_register(&cmh_hwrng);
+       if (ret) {
+               dev_err(&pdev->dev, "rng: hwrng_register failed (rc=3D%d)\n=
",
+                       ret);
+               return ret;
+       }
+
+       dev_info(&pdev->dev,
+                "rng: registered cri-cmh-drbg (quality=3D%d timeout=3D%ums=
)\n",
+                cmh_hwrng.quality, drbg_timeout_ms);
+
+       cmh_rng_registered =3D true;
+       return 0;
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
+       if (!cmh_rng_registered)
+               return;
+       hwrng_unregister(&cmh_hwrng);
+       cmh_rng_registered =3D false;
+       dev_info(cmh_dev(), "rng: unregistered cri-cmh-drbg\n");
+}
+
+/* -- debugfs timeout accessor ------------------------------------------ =
*/
+
+#ifdef CONFIG_CRYPTO_DEV_CMH_DEBUG
+/**
+ * cmh_rng_timeout_drbg_ptr() - Return pointer to drbg_timeout_ms for debu=
gfs
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


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

