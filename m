Return-Path: <linux-api+bounces-6699-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8RBwM+JmPWpW2ggAu9opvQ
	(envelope-from <linux-api+bounces-6699-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:35:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B86C7D49
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:35:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=mz5OcEpC;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6699-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6699-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ABEA304B649
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12523F076C;
	Thu, 25 Jun 2026 17:34:25 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020134.outbound.protection.outlook.com [52.101.193.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C453EDE68;
	Thu, 25 Jun 2026 17:34:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408865; cv=fail; b=mM+dDTiBENh9JKp7BdWxJRUCeERHd459dLM5ACurI+4kV/ccM2vk2zHGmLQTYiI4T1i8LxSURPWK0RLZcwmeP8fRuUcnuJbARLeTkZf13wjYT+KQNxTNd2J+J2CjtJyWFh3slixwPjRb73FtSHSGMknW8w2UwjJGbwcn3PyPoew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408865; c=relaxed/simple;
	bh=rYfDNqNoLONwmac9cJK5Wuk4Nhjzj5Q7FhXzEQD+Ymw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1XvUM7bXmgQ7DvkGDJxTNjHvMUQV9JcGjUpmRfQwz2olJnW3g9h4we/kmSif3gL+6VXPZs6gy+LOWWucB12jUzXV/4rdMFKdiL2Ub9Ekkd4cacS7h4DUk416yOEn7/kFA7at2oCZ0bYPx6uTZYdgRcQZbJC/KR1sEhSdH9CxYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=mz5OcEpC; arc=fail smtp.client-ip=52.101.193.134
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4NPZ03wTMdZMZQEP1yO7f7HTWElScsFPrxjoj2/K+xZy05rp4Xu1I4aH2ZpUCuSBrYbuPHdnPT8VHGD7UR1X4+mVtNeWY4HsxXGZFD7pWKIV54ndBhdRsyo1zrE2vpTpeWYX6/nMQEUVZLW1kOZd9f19JvdaR7gNaRiObhdK3AIcMjAP7LQkccmc7vSU0YzTORp4jmWAA/zjrzNbeM5rhCXzdm36lqlC4L+VEmiY0tPNfrxyZj2Z+tx7/LHpFxXzqECyhm96ZsQ60IeCPJsd+FsnT/c4ZAxsZLyLNgGTYjsDTj/89nK8GHTr7ndrBwJtUeeNygHQAy14j1X2uLRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txAHUbM7yQq+nQhIjfxH21+NYf/2Gzx4wIQ33eNQQRg=;
 b=GOnvzVJkmNyBRJyIpFogypHMj3CwuasWeVHAEj65f7FG5UHqkAdMJ4pBbEwYJlWe1r8cr9FS+x/rxHJ7+AqI+swE6yiwt2wP8BBfel+NSo03br6OdQfQsPXBFECaWe7LWKWkkcjt0eeHRt2pPR7D6ibfrBIwFnSjNkHGOriv7kwIU2p+iKWqPIoCUBFIlfJi+YV0YSysiAVCR3T96ac6Fvi3NtnpCsbLRhBDZihP5q/Hx4v8VtrWGtFXqx6hWaMbTkY9/quMK/G6vrhbI/klqiz+hrs1RkQToNVcw7MWorEAefE0xcu9OiNaajPXnFY0vwovt6bbhU2ukfAQi8Xf2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txAHUbM7yQq+nQhIjfxH21+NYf/2Gzx4wIQ33eNQQRg=;
 b=mz5OcEpCcgpunwoYa18CQChE5yvKL8tCpGXQjzzItqC6Ut3dHMyjLGivw0n5ZE8ZgQrgtLEChQnuJuxUXBnrwqAxzvyrFb7BO7gmTsFGB25T59+2rCPEkya7nqktzOd+eZoiXtrZV+FSLhzkWNJhmHr5OsoLWNhSCjBAnUJXPdwWQaxhywA6EykO0jnQszre8Ff5DNWQ4p4xY/pVCpl5ZTsfwIqRXab+iWYqS3ayfhiFNr3aU7aSLzARB2+yFMGmaRnWobgA8GY1ah9Bv46pdZ/DuQqRoAQXZgg/NNSqn1FcsZ63LqiC2UJ4HvNarwT1BZ6++k/kZv4OUnPfktD+qw==
Received: from BN9PR03CA0254.namprd03.prod.outlook.com (2603:10b6:408:ff::19)
 by PH0PR04MB7478.namprd04.prod.outlook.com (2603:10b6:510:4e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 17:34:10 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::9) by BN9PR03CA0254.outlook.office365.com
 (2603:10b6:408:ff::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 17:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:09 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 2A6BF1801772;
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
Subject: [PATCH 12/19] crypto: cmh - add RSA akcipher
Date: Thu, 25 Jun 2026 10:33:20 -0700
Message-ID: <20260625173328.1140487-13-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|PH0PR04MB7478:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ea51256f-7f9e-400d-2d4e-08ded2dff724
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|23010399003|1800799024|36860700016|921020|56012099006|11063799006|6133799003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9zPjg9CeHLniMAQY0owb6Ef0KH/ooNCBn09+lKLCSAYO/0orCwl53xzGHj7hX/piItW46E5e9iAnuLpX0ilz9YWuWI3zmSYL7OcU6i8pIECUPOHkhoyIzYRVfNnDMhKkYhuB+eCj+2AkP7AgLLb4bgIKBWu1C2Ck/0/xQA6ucTxiAIDWkd55izrCoTbLXHkMKLbY7N1I2MttMdGKXs5USnFHrLPTIEYWn+NxjTbv4WGTgcu2bqw4ghkkI655jRZcLGL41GSnlkYjyLwuepiiywfN0ZoBGrsQ2S3CU3fTbPbSk6+YbDZllutn0Yz4LLKZf/jjzVcSwLcUm0XR/aYk2dMdCtCYlnnXUI4vuW0++LclktB6OkhX08+VyQ2ZCPdwRtc4WxxL2eepH1zW/tVUDiV9xDy1bCvfxD0jxq/BH4jfCgGmpZipQyEdDKdI+c6UFHVEOgWQVCV0SSHJXXRTiDFflo1Mr+IQ0GBGEtzhQyiInBLr6toNrt+/T5VPVu7PPON4nFAzdC87OldnKoxSm1P6HRNfYcV2sVcC724zeBl+JBjR4u1jIikZHgtXfy5T1aOYSa7cQG/B/YA/uEmMkPXhYZOa+0UzJQ3KHbQgs+ai1x91KnsbZnVNrVHGPg1llIZfzSiNa8qTR9P0R72uaDKWgcrxOkYuLlLvW2s5A/iTwz6aCZadigj2V+6hReQKxT1YoOTKydwZwSr2Dg/xXb12MXCay+ZyAntJ21u6AdTWlstxiY6tafcFbcx0Q7N0
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(23010399003)(1800799024)(36860700016)(921020)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Z59gY+qJBVHa6RaEb9DG2J9nt22NjB0F1AiWpiVv+6V4rJh8c2ot+CKLgsLMDRlwqvHb6q9lwE34b3M39uT8u7ahKBue+uAoL37xzuSwPVvSQQG4vi11xLsf6/PdQv1wRIjowdyda809GSxJqpzXvs9dIHFCJ7aZpraQvSLDwJXcYUP1953axf37FzGkiE2119/Rr9taNJ+F9G/RRMpXJBEBZhRTsO/QXZeRNEm5Wr7XRerp+Fow9jwkFxA0CfQX/thRvV3MxGxwr2yT7nvfmK0/ZWSHW+4ilj1CXvvrS9pxsYIpQ9kxEbMcUNdVSOKUj5ks6WYBrIv/RiiSYCPJ8kl3sO22z760+LmQUFvAEA3t6RadkyPK/m/1Wm9dtAp37QsmbykOrDGy3q76vVi/mROfMQjS3WcskF4T7V3rwOa+MlNzf828/nnXa+A6Sw6v
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:09.6756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea51256f-7f9e-400d-2d4e-08ded2dff724
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7478
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-6699-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cryptography.com:email,vger.kernel.org:from_smtp,rambus.com:url,rambus.com:from_mime,rambus.com:dkim,rambus.com:email,rambus.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B6B86C7D49

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register the RSA akcipher algorithm using the CMH PKE core (core ID
0x0a).  Supports encrypt, decrypt, sign, and verify operations with
2048, 3072, and 4096-bit keys.  512- and 1024-bit keys are also
accepted for legacy/test interoperability.  Includes common PKE
helpers shared by subsequent ECDSA and ECDH patches.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile         |   4 +-
 drivers/crypto/cmh/cmh_main.c       |   9 +
 drivers/crypto/cmh/cmh_pke_common.c | 578 +++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_pke_rsa.c    | 642 ++++++++++++++++++++++++++++
 4 files changed, 1232 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_pke_common.c
 create mode 100644 drivers/crypto/cmh/cmh_pke_rsa.c

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 1c4cb817424c..7afd9852c337 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -29,7 +29,9 @@ cmh-y :=3D \
        cmh_ccp.o \
        cmh_ccp_aead.o \
        cmh_ccp_poly.o \
-       cmh_rng.o
+       cmh_rng.o \
+       cmh_pke_common.o \
+       cmh_pke_rsa.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index f31c50168e4a..8535453342d7 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -38,6 +38,7 @@
 #include "cmh_aes.h"
 #include "cmh_sm4.h"
 #include "cmh_ccp.h"
+#include "cmh_pke.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -275,6 +276,11 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_ccp_poly_register;

+       /* Register PKE RSA akcipher */
+       ret =3D cmh_pke_rsa_register();
+       if (ret)
+               goto err_pke_rsa_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -287,6 +293,8 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_pke_rsa_unregister();
+err_pke_rsa_register:
        cmh_ccp_poly_unregister();
 err_ccp_poly_register:
        cmh_ccp_aead_unregister();
@@ -343,6 +351,7 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_pke_rsa_unregister();
        cmh_ccp_poly_unregister();
        cmh_ccp_aead_unregister();
        cmh_ccp_unregister();
diff --git a/drivers/crypto/cmh/cmh_pke_common.c b/drivers/crypto/cmh/cmh_p=
ke_common.c
new file mode 100644
index 000000000000..ab3e2eb7d3f8
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pke_common.c
@@ -0,0 +1,578 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- PKE Common VCQ Builders
+ *
+ * VCQ builder functions for all PKE core commands.  Each builder
+ * populates a single vcq_cmd slot with the appropriate magic,
+ * command ID, byte-swap flags, and command-specific payload.
+ *
+ * RSA commands always use PKE_SWAP_FLAGS (VCQ_FLAG_SWAP_BYTES |
+ * VCQ_FLAG_SWAP_WORDS).  EC Weierstrass curves (NIST P-*, Brainpool,
+ * secp256k1, SM2) use PKE_SWAP_FLAGS; Edwards curves (25519, 448)
+ * use no swap flags.  SM2 commands use per-command flags documented
+ * in the eSW ABI.
+ *
+ * Callers combine these with vcq_set_header() + vcq_add_flush()
+ * and submit via cmh_tm_submit_sync().
+ */
+
+#include <linux/string.h>
+
+#include "cmh_pke.h"
+
+/**
+ * vcq_add_pke_flush() - Add a PKE flush command to a VCQ slot
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ *
+ * Populates @slot with a flush command for the specified PKE core.
+ */
+void vcq_add_pke_flush(struct vcq_cmd *slot, u32 core_id)
+{
+       vcq_add_flush(slot, core_id);
+}
+
+/* RSA */
+
+/**
+ * vcq_add_pke_rsa_enc() - Build a VCQ command for RSA public-key encrypti=
on
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @bits: RSA key size in bits
+ * @e_len: Length of the public exponent in bytes
+ * @e_dma: DMA address of public exponent buffer
+ * @n_dma: DMA address of modulus buffer
+ * @m_dma: DMA address of plaintext message buffer
+ * @c_dma: DMA address of ciphertext output buffer
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_rsa_enc(struct vcq_cmd *slot, u32 core_id, u32 bits, u32 =
e_len,
+                        u64 e_dma, u64 n_dma, u64 m_dma, u64 c_dma,
+                        u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_RSA_ENC);
+       slot->hwc.pke.cmd_rsa_enc.bits =3D bits;
+       slot->hwc.pke.cmd_rsa_enc.e_len =3D e_len;
+       slot->hwc.pke.cmd_rsa_enc.e =3D e_dma;
+       slot->hwc.pke.cmd_rsa_enc.n =3D n_dma;
+       slot->hwc.pke.cmd_rsa_enc.m =3D m_dma;
+       slot->hwc.pke.cmd_rsa_enc.c =3D c_dma;
+}
+
+/**
+ * vcq_add_pke_rsa_dec() - Build a VCQ command for RSA private-key decrypt=
ion
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @bits: RSA key size in bits
+ * @e_len: Length of the public exponent in bytes
+ * @e_dma: DMA address of public exponent buffer
+ * @n_dma: DMA address of modulus buffer
+ * @c_dma: DMA address of ciphertext input buffer
+ * @m_dma: DMA address of plaintext output buffer
+ * @d_ref: Datastore reference for the private exponent
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_rsa_dec(struct vcq_cmd *slot, u32 core_id, u32 bits, u32 =
e_len,
+                        u64 e_dma, u64 n_dma, u64 c_dma, u64 m_dma,
+                        u64 d_ref, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_RSA_DEC);
+       slot->hwc.pke.cmd_rsa_dec.bits =3D bits;
+       slot->hwc.pke.cmd_rsa_dec.e_len =3D e_len;
+       slot->hwc.pke.cmd_rsa_dec.e =3D e_dma;
+       slot->hwc.pke.cmd_rsa_dec.n =3D n_dma;
+       slot->hwc.pke.cmd_rsa_dec.c =3D c_dma;
+       slot->hwc.pke.cmd_rsa_dec.m =3D m_dma;
+       slot->hwc.pke.cmd_rsa_dec.d =3D d_ref;
+}
+
+/**
+ * vcq_add_pke_rsa_crt_dec() - Build a VCQ command for RSA-CRT decryption
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @bits: RSA key size in bits
+ * @e_len: Length of the public exponent in bytes
+ * @e_dma: DMA address of public exponent buffer
+ * @n_dma: DMA address of modulus buffer
+ * @c_dma: DMA address of ciphertext input buffer
+ * @m_dma: DMA address of plaintext output buffer
+ * @crt_ref: Datastore reference for CRT private key components
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_rsa_crt_dec(struct vcq_cmd *slot, u32 core_id, u32 bits, =
u32 e_len,
+                            u64 e_dma, u64 n_dma, u64 c_dma, u64 m_dma,
+                            u64 crt_ref, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_RSA_CRT_DEC);
+       slot->hwc.pke.cmd_rsa_crt_dec.bits =3D bits;
+       slot->hwc.pke.cmd_rsa_crt_dec.e_len =3D e_len;
+       slot->hwc.pke.cmd_rsa_crt_dec.e =3D e_dma;
+       slot->hwc.pke.cmd_rsa_crt_dec.n =3D n_dma;
+       slot->hwc.pke.cmd_rsa_crt_dec.c =3D c_dma;
+       slot->hwc.pke.cmd_rsa_crt_dec.m =3D m_dma;
+       slot->hwc.pke.cmd_rsa_crt_dec.crt =3D crt_ref;
+}
+
+/* ECDSA */
+
+/**
+ * vcq_add_pke_ecdsa_verify() - Build a VCQ command for ECDSA signature ve=
rification
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @dlen: Digest length in bytes
+ * @pk_dma: DMA address of public key buffer
+ * @dig_dma: DMA address of digest buffer
+ * @sig_dma: DMA address of signature buffer
+ * @rp_dma: DMA address of r-prime verification output buffer
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdsa_verify(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 dlen,
+                             u64 pk_dma, u64 dig_dma, u64 sig_dma,
+                             u64 rp_dma, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_VERIFY);
+       slot->hwc.pke.cmd_ecdsa_verify.curve =3D curve;
+       slot->hwc.pke.cmd_ecdsa_verify.digest_len =3D dlen;
+       slot->hwc.pke.cmd_ecdsa_verify.public_key =3D pk_dma;
+       slot->hwc.pke.cmd_ecdsa_verify.digest =3D dig_dma;
+       slot->hwc.pke.cmd_ecdsa_verify.signature =3D sig_dma;
+       slot->hwc.pke.cmd_ecdsa_verify.rprime =3D rp_dma;
+}
+
+/**
+ * vcq_add_pke_ecdsa_sign() - Build a VCQ command for ECDSA signing
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @sklen: Secret key length in bytes
+ * @dig_dma: DMA address of digest buffer
+ * @sig_dma: DMA address of signature output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @dlen: Digest length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdsa_sign(struct vcq_cmd *slot, u32 core_id, u32 curve, =
u32 sklen,
+                           u64 dig_dma, u64 sig_dma, u64 sk_ref,
+                           u32 dlen, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_SIGN);
+       slot->hwc.pke.cmd_ecdsa_sign.curve =3D curve;
+       slot->hwc.pke.cmd_ecdsa_sign.secret_key_len =3D sklen;
+       slot->hwc.pke.cmd_ecdsa_sign.digest =3D dig_dma;
+       slot->hwc.pke.cmd_ecdsa_sign.signature =3D sig_dma;
+       slot->hwc.pke.cmd_ecdsa_sign.secret_key =3D sk_ref;
+       slot->hwc.pke.cmd_ecdsa_sign.digest_len =3D dlen;
+}
+
+/**
+ * vcq_add_pke_ecdsa_pubgen() - Build a VCQ command for ECDSA public key g=
eneration
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @sklen: Secret key length in bytes
+ * @pk_dma: DMA address of public key output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @flags: VCQ command flags
+ *
+ * Generates the public key from an existing private key stored in the
+ * datastore.
+ */
+void vcq_add_pke_ecdsa_pubgen(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 sklen,
+                             u64 pk_dma, u64 sk_ref, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_PUBGEN);
+       slot->hwc.pke.cmd_ecdsa_pubgen.curve =3D curve;
+       slot->hwc.pke.cmd_ecdsa_pubgen.secret_key_len =3D sklen;
+       slot->hwc.pke.cmd_ecdsa_pubgen.public_key =3D pk_dma;
+       slot->hwc.pke.cmd_ecdsa_pubgen.secret_key =3D sk_ref;
+}
+
+/**
+ * vcq_add_pke_ecdsa_keygen() - Build a VCQ command for ECDSA key pair gen=
eration
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521)
+ * @sklen: Secret key length in bytes
+ * @sk_ref: Datastore reference for the generated secret key
+ * @sk_type: Datastore type for the secret key object
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdsa_keygen(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 sklen,
+                             u64 sk_ref, u32 sk_type, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDSA_KEYGEN);
+       slot->hwc.pke.cmd_ecdsa_keygen.curve =3D curve;
+       slot->hwc.pke.cmd_ecdsa_keygen.secret_key_len =3D sklen;
+       slot->hwc.pke.cmd_ecdsa_keygen.secret_key =3D sk_ref;
+       slot->hwc.pke.cmd_ecdsa_keygen.secret_key_type =3D sk_type;
+}
+
+/* ECDH */
+
+/**
+ * vcq_add_pke_ecdh_keygen() - Build a VCQ command for ECDH key pair gener=
ation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521, X25519, X448)
+ * @sklen: Secret key length in bytes
+ * @pkx_dma: DMA address of public key X-coordinate output buffer
+ * @sk_ref: Datastore reference for the generated secret key
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdh_keygen(struct vcq_cmd *slot, u32 core_id, u32 curve,=
 u32 sklen,
+                            u64 pkx_dma, u64 sk_ref, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDH_KEYGEN);
+       slot->hwc.pke.cmd_ecdh_keygen.curve =3D curve;
+       slot->hwc.pke.cmd_ecdh_keygen.secret_key_len =3D sklen;
+       slot->hwc.pke.cmd_ecdh_keygen.public_key_x =3D pkx_dma;
+       slot->hwc.pke.cmd_ecdh_keygen.secret_key =3D sk_ref;
+}
+
+/**
+ * vcq_add_pke_ecdh() - Build a VCQ command for ECDH shared secret computa=
tion
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (e.g. NIST P-256, P-384, P-521, X25519, X448)
+ * @sklen: Secret key length in bytes
+ * @sslen: Shared secret length in bytes
+ * @ss_type: Datastore type for the shared secret object
+ * @peer_dma: DMA address of peer public key buffer
+ * @sk_ref: Datastore reference for the local secret key
+ * @ss_ref: Datastore reference for the computed shared secret
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_ecdh(struct vcq_cmd *slot, u32 core_id, u32 curve, u32 sk=
len,
+                     u32 sslen, u32 ss_type, u64 peer_dma, u64 sk_ref,
+                     u64 ss_ref, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_ECDH);
+       slot->hwc.pke.cmd_ecdh.curve =3D curve;
+       slot->hwc.pke.cmd_ecdh.secret_key_len =3D sklen;
+       slot->hwc.pke.cmd_ecdh.shared_secret_len =3D sslen;
+       slot->hwc.pke.cmd_ecdh.shared_secret_type =3D ss_type;
+       slot->hwc.pke.cmd_ecdh.peer_key_x =3D peer_dma;
+       slot->hwc.pke.cmd_ecdh.secret_key =3D sk_ref;
+       slot->hwc.pke.cmd_ecdh.shared_secret =3D ss_ref;
+}
+
+/* EdDSA */
+
+/**
+ * vcq_add_pke_eddsa_verify() - Build a VCQ command for EdDSA signature ve=
rification
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed25519 or Ed448)
+ * @dlen: Digest (message) length in bytes
+ * @pky_dma: DMA address of public key Y-coordinate buffer
+ * @dig_dma: DMA address of digest buffer
+ * @sig_dma: DMA address of signature buffer
+ * @rp_dma: DMA address of r-prime verification output buffer
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_eddsa_verify(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 dlen,
+                             u64 pky_dma, u64 dig_dma, u64 sig_dma,
+                             u64 rp_dma, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_EDDSA_VERIFY);
+       slot->hwc.pke.cmd_eddsa_verify.curve =3D curve;
+       slot->hwc.pke.cmd_eddsa_verify.digest_len =3D dlen;
+       slot->hwc.pke.cmd_eddsa_verify.public_key_y =3D pky_dma;
+       slot->hwc.pke.cmd_eddsa_verify.digest =3D dig_dma;
+       slot->hwc.pke.cmd_eddsa_verify.signature =3D sig_dma;
+       slot->hwc.pke.cmd_eddsa_verify.rprime =3D rp_dma;
+}
+
+/**
+ * vcq_add_pke_eddsa_sign() - Build a VCQ command for EdDSA signing
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed25519 or Ed448)
+ * @sklen: Secret key length in bytes
+ * @dig_dma: DMA address of digest (message) buffer
+ * @sig_dma: DMA address of signature output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @dlen: Digest (message) length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_eddsa_sign(struct vcq_cmd *slot, u32 core_id, u32 curve, =
u32 sklen,
+                           u64 dig_dma, u64 sig_dma, u64 sk_ref,
+                           u32 dlen, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_EDDSA_SIGN);
+       slot->hwc.pke.cmd_eddsa_sign.curve =3D curve;
+       slot->hwc.pke.cmd_eddsa_sign.secret_key_len =3D sklen;
+       slot->hwc.pke.cmd_eddsa_sign.digest =3D dig_dma;
+       slot->hwc.pke.cmd_eddsa_sign.signature =3D sig_dma;
+       slot->hwc.pke.cmd_eddsa_sign.secret_key =3D sk_ref;
+       slot->hwc.pke.cmd_eddsa_sign.digest_len =3D dlen;
+}
+
+/**
+ * vcq_add_pke_eddsa_pubgen() - Build a VCQ command for EdDSA public key g=
eneration
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed25519 or Ed448)
+ * @sklen: Secret key length in bytes
+ * @pky_dma: DMA address of public key Y-coordinate output buffer
+ * @sk_ref: Datastore reference for the secret key
+ * @flags: VCQ command flags
+ *
+ * Generates the public key from an existing private key stored in the
+ * datastore.
+ */
+void vcq_add_pke_eddsa_pubgen(struct vcq_cmd *slot, u32 core_id, u32 curve=
, u32 sklen,
+                             u64 pky_dma, u64 sk_ref, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_EDDSA_PUBGEN);
+       slot->hwc.pke.cmd_eddsa_pubgen.curve =3D curve;
+       slot->hwc.pke.cmd_eddsa_pubgen.secret_key_len =3D sklen;
+       slot->hwc.pke.cmd_eddsa_pubgen.public_key_y =3D pky_dma;
+       slot->hwc.pke.cmd_eddsa_pubgen.secret_key =3D sk_ref;
+}
+
+/**
+ * vcq_add_pke_eddsa_keygen_sca() - Build a VCQ command for EdDSA SCA key =
generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @curve: Curve identifier (Ed448)
+ * @sk_ref: Datastore reference for the input secret key
+ * @sca_sk_ref: Datastore reference for the SCA-masked output key
+ *
+ * Blinds an Ed448 private key into a side-channel-protected masked
+ * form.  No byte-swap flags are used (CRI reference uses flags=3D0).
+ */
+void vcq_add_pke_eddsa_keygen_sca(struct vcq_cmd *slot, u32 core_id, u32 c=
urve,
+                                 u64 sk_ref, u64 sca_sk_ref)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1,
+                             PKE_CMD_EDDSA_PRIV_KEYGEN_SCA);
+       slot->hwc.pke.cmd_eddsa_keygen_sca.curve =3D curve;
+       slot->hwc.pke.cmd_eddsa_keygen_sca.secret_key =3D sk_ref;
+       slot->hwc.pke.cmd_eddsa_keygen_sca.sca_secret_key =3D sca_sk_ref;
+}
+
+/* SM2 */
+
+/**
+ * vcq_add_pke_sm2_ecdh_keygen() - Build a VCQ command for SM2 ECDH epheme=
ral key generation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @nonce_dma: DMA address of nonce input buffer
+ * @session_key_dma: DMA address of session key output buffer
+ * @nonce_len: Nonce length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_ecdh_keygen(struct vcq_cmd *slot, u32 core_id, u64 no=
nce_dma,
+                                u64 session_key_dma, u32 nonce_len, u32 fl=
ags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1,
+                             PKE_CMD_SM2_ECDH_KEYGEN);
+       slot->hwc.pke.cmd_sm2_ecdh_keygen.nonce =3D nonce_dma;
+       slot->hwc.pke.cmd_sm2_ecdh_keygen.session_key =3D session_key_dma;
+       slot->hwc.pke.cmd_sm2_ecdh_keygen.nonce_len =3D nonce_len;
+}
+
+/**
+ * vcq_add_pke_sm2_ecdh() - Build a VCQ command for SM2 ECDH shared secret=
 computation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @nonce_len: Nonce length in bytes
+ * @private_key_len: Private key length in bytes
+ * @nonce_dma: DMA address of nonce buffer
+ * @peer_pk_dma: DMA address of peer public key buffer
+ * @peer_sk_dma: DMA address of peer session key buffer
+ * @priv_ref: Datastore reference for the local private key
+ * @sp_ref: Datastore reference for the shared point output
+ * @sp_type: Datastore type for the shared point object
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_ecdh(struct vcq_cmd *slot, u32 core_id, u32 nonce_len=
,
+                         u32 private_key_len, u64 nonce_dma,
+                         u64 peer_pk_dma, u64 peer_sk_dma,
+                         u64 priv_ref, u64 sp_ref, u32 sp_type, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ECDH);
+       slot->hwc.pke.cmd_sm2_ecdh.nonce_len =3D nonce_len;
+       slot->hwc.pke.cmd_sm2_ecdh.private_key_len =3D private_key_len;
+       slot->hwc.pke.cmd_sm2_ecdh.nonce =3D nonce_dma;
+       slot->hwc.pke.cmd_sm2_ecdh.peer_public_key =3D peer_pk_dma;
+       slot->hwc.pke.cmd_sm2_ecdh.peer_session_key =3D peer_sk_dma;
+       slot->hwc.pke.cmd_sm2_ecdh.private_key =3D priv_ref;
+       slot->hwc.pke.cmd_sm2_ecdh.shared_point =3D sp_ref;
+       slot->hwc.pke.cmd_sm2_ecdh.shared_point_type =3D sp_type;
+}
+
+/**
+ * vcq_add_pke_sm2_dec_point() - Build a VCQ command for SM2 decryption po=
int multiplication
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @ct_len: Ciphertext length in bytes
+ * @pk_len: Private key length in bytes
+ * @ct_dma: DMA address of ciphertext input buffer
+ * @dp_dma: DMA address of decryption point output buffer
+ * @priv_ref: Datastore reference for the private key
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_dec_point(struct vcq_cmd *slot, u32 core_id, u32 ct_l=
en,
+                              u32 pk_len, u64 ct_dma, u64 dp_dma,
+                              u64 priv_ref, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_DEC_POINT);
+       slot->hwc.pke.cmd_sm2_dec_point.ciphertext_len =3D ct_len;
+       slot->hwc.pke.cmd_sm2_dec_point.private_key_len =3D pk_len;
+       slot->hwc.pke.cmd_sm2_dec_point.ciphertext =3D ct_dma;
+       slot->hwc.pke.cmd_sm2_dec_point.dec_point =3D dp_dma;
+       slot->hwc.pke.cmd_sm2_dec_point.private_key =3D priv_ref;
+}
+
+/**
+ * vcq_add_pke_sm2_enc_point() - Build a VCQ command for SM2 encryption po=
int multiplication
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @nonce_dma: DMA address of nonce buffer
+ * @pk_dma: DMA address of public key buffer
+ * @ct_dma: DMA address of ciphertext header output buffer
+ * @ep_dma: DMA address of encryption point output buffer
+ * @nonce_len: Nonce length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_enc_point(struct vcq_cmd *slot, u32 core_id, u64 nonc=
e_dma,
+                              u64 pk_dma, u64 ct_dma, u64 ep_dma,
+                              u32 nonce_len, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ENC_POINT);
+       slot->hwc.pke.cmd_sm2_enc_point.nonce =3D nonce_dma;
+       slot->hwc.pke.cmd_sm2_enc_point.public_key =3D pk_dma;
+       slot->hwc.pke.cmd_sm2_enc_point.ciphertext =3D ct_dma;
+       slot->hwc.pke.cmd_sm2_enc_point.enc_point =3D ep_dma;
+       slot->hwc.pke.cmd_sm2_enc_point.nonce_len =3D nonce_len;
+}
+
+/**
+ * vcq_add_pke_sm2_id_digest() - Build a VCQ command for SM2 identity dige=
st computation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @id_dma: DMA address of identity string buffer
+ * @pk_dma: DMA address of public key buffer
+ * @dig_dma: DMA address of digest output buffer
+ * @id_len: Identity string length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_id_digest(struct vcq_cmd *slot, u32 core_id, u64 id_d=
ma,
+                              u64 pk_dma, u64 dig_dma, u32 id_len,
+                              u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ID_DIGEST);
+       slot->hwc.pke.cmd_sm2_id_digest.id =3D id_dma;
+       slot->hwc.pke.cmd_sm2_id_digest.public_key =3D pk_dma;
+       slot->hwc.pke.cmd_sm2_id_digest.digest =3D dig_dma;
+       slot->hwc.pke.cmd_sm2_id_digest.id_len =3D id_len;
+}
+
+/**
+ * vcq_add_pke_sm2_ecdh_hash() - Build a VCQ command for SM2 ECDH key deri=
vation hash
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @peer_dig_dma: DMA address of peer identity digest buffer
+ * @dig_dma: DMA address of local identity digest buffer
+ * @sp_ref: Datastore reference for the shared point
+ * @sk_ref: Datastore reference for the derived shared key output
+ * @sk_type: Datastore type for the shared key object
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_ecdh_hash(struct vcq_cmd *slot, u32 core_id, u64 peer=
_dig_dma,
+                              u64 dig_dma, u64 sp_ref, u64 sk_ref,
+                              u32 sk_type, u32 flags)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ECDH_HASH);
+       slot->hwc.pke.cmd_sm2_ecdh_hash.peer_id_digest =3D peer_dig_dma;
+       slot->hwc.pke.cmd_sm2_ecdh_hash.id_digest =3D dig_dma;
+       slot->hwc.pke.cmd_sm2_ecdh_hash.shared_point =3D sp_ref;
+       slot->hwc.pke.cmd_sm2_ecdh_hash.shared_key =3D sk_ref;
+       slot->hwc.pke.cmd_sm2_ecdh_hash.shared_key_type =3D sk_type;
+}
+
+/**
+ * vcq_add_pke_sm2_dec_hash() - Build a VCQ command for SM2 decryption has=
h verification
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @ct_dma: DMA address of ciphertext input buffer
+ * @dp_dma: DMA address of decryption point buffer
+ * @pt_dma: DMA address of plaintext output buffer
+ * @ct_len: Ciphertext length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_dec_hash(struct vcq_cmd *slot, u32 core_id, u64 ct_dm=
a,
+                             u64 dp_dma, u64 pt_dma, u32 ct_len, u32 flags=
)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_DEC_HASH);
+       slot->hwc.pke.cmd_sm2_dec_hash.ciphertext =3D ct_dma;
+       slot->hwc.pke.cmd_sm2_dec_hash.dec_point =3D dp_dma;
+       slot->hwc.pke.cmd_sm2_dec_hash.plaintext =3D pt_dma;
+       slot->hwc.pke.cmd_sm2_dec_hash.ciphertext_len =3D ct_len;
+}
+
+/**
+ * vcq_add_pke_sm2_enc_hash() - Build a VCQ command for SM2 encryption has=
h computation
+ * @slot: VCQ command slot to populate
+ * @core_id: PKE hardware core ID
+ * @msg_dma: DMA address of plaintext message buffer
+ * @ep_dma: DMA address of encryption point buffer
+ * @ct_dma: DMA address of ciphertext output buffer
+ * @msg_len: Message length in bytes
+ * @flags: VCQ command flags
+ */
+void vcq_add_pke_sm2_enc_hash(struct vcq_cmd *slot, u32 core_id, u64 msg_d=
ma,
+                             u64 ep_dma, u64 ct_dma, u32 msg_len, u32 flag=
s)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, flags, 1, PKE_CMD_SM2_ENC_HASH);
+       slot->hwc.pke.cmd_sm2_enc_hash.message =3D msg_dma;
+       slot->hwc.pke.cmd_sm2_enc_hash.enc_point =3D ep_dma;
+       slot->hwc.pke.cmd_sm2_enc_hash.ciphertext =3D ct_dma;
+       slot->hwc.pke.cmd_sm2_enc_hash.message_len =3D msg_len;
+}
diff --git a/drivers/crypto/cmh/cmh_pke_rsa.c b/drivers/crypto/cmh/cmh_pke_=
rsa.c
new file mode 100644
index 000000000000..010f8bd98f0d
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pke_rsa.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- RSA akcipher Driver
+ *
+ * Registers "rsa" akcipher algorithm with the Linux crypto subsystem
+ * (priority 300, overrides software rsa-generic at 100).
+ *
+ * Raw RSA operations only (m^e mod n / c^d mod n).  The kernel's
+ * pkcs1pad() template wraps this for PKCS#1 v1.5 / PSS / OAEP.
+ *
+ * Key format: DER-encoded ASN.1, parsed by kernel rsa_parse_pub_key()
+ * / rsa_parse_priv_key() helpers.
+ *
+ * Private key via cmh_key_ctx: raw keys written via SYS_REF_TEMP.
+ * Datastore-referenced keys are only reachable through the ioctl
+ * path (cmh_mgmt.c).
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/scatterlist.h>
+#include <crypto/akcipher.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/rsa.h>
+
+#include "cmh_pke.h"
+#include "cmh_sys.h"
+#include "cmh_sys_abi.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+
+struct cmh_rsa_tfm_ctx {
+       struct cmh_key_ctx key;         /* private key (raw d only) */
+       u8 *n;                          /* modulus (big-endian) */
+       u8 *e;                          /* public exponent (big-endian) */
+       size_t n_sz;
+       size_t e_sz;
+       u32 bits;                       /* key size in bits */
+};
+
+static inline struct cmh_rsa_tfm_ctx *cmh_rsa_ctx(struct crypto_akcipher *=
tfm)
+{
+       return akcipher_tfm_ctx(tfm);
+}
+
+struct cmh_rsa_reqctx {
+       u8 *e_buf;
+       u8 *n_buf;
+       u8 *m_buf;
+       u8 *c_buf;
+       u8 *d_buf;              /* dec only: private key copy */
+       dma_addr_t e_dma;
+       dma_addr_t n_dma;
+       dma_addr_t m_dma;
+       dma_addr_t c_dma;
+       dma_addr_t d_dma;
+       u32 key_bytes;
+       u32 e_padded;
+       u32 n_sz;
+       u32 d_len;              /* dec only */
+};
+
+static u32 cmh_rsa_key_bits(size_t n_sz)
+{
+       /*
+        * Only accept exact modulus sizes supported by the hardware.
+        * The programmed RSA width must match the actual modulus buffer
+        * length; rounding a shorter modulus up to the next size would
+        * let the device read past the end of the DMA buffer.
+        */
+       switch (n_sz) {
+       case 64:
+               return 512;
+       case 128:
+               return 1024;
+       case 256:
+               return 2048;
+       case 384:
+               return 3072;
+       case 512:
+               return 4096;
+       default:
+               return 0;
+       }
+}
+
+static void cmh_rsa_enc_complete(void *data, int error)
+{
+       struct akcipher_request *req =3D data;
+       struct cmh_rsa_reqctx *rctx =3D akcipher_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       if (!cmh_dma_map_error(rctx->c_dma))
+               cmh_dma_unmap_single(rctx->c_dma, rctx->key_bytes,
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(rctx->m_dma))
+               cmh_dma_unmap_single(rctx->m_dma, rctx->key_bytes,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->n_dma))
+               cmh_dma_unmap_single(rctx->n_dma, rctx->n_sz,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->e_dma))
+               cmh_dma_unmap_single(rctx->e_dma, rctx->e_padded,
+                                    DMA_TO_DEVICE);
+
+       if (!error) {
+               int nents;
+
+               nents =3D sg_nents_for_len(req->dst, rctx->key_bytes);
+               if (nents < 0 ||
+                   sg_copy_from_buffer(req->dst, nents,
+                                       rctx->c_buf,
+                                       rctx->key_bytes) !=3D rctx->key_byt=
es)
+                       error =3D -EINVAL;
+               else
+                       req->dst_len =3D rctx->key_bytes;
+       }
+
+       kfree(rctx->c_buf);
+       rctx->c_buf =3D NULL;
+       kfree_sensitive(rctx->m_buf);
+       rctx->m_buf =3D NULL;
+       kfree(rctx->n_buf);
+       rctx->n_buf =3D NULL;
+       kfree(rctx->e_buf);
+       rctx->e_buf =3D NULL;
+       cmh_complete(&req->base, error);
+}
+
+/*
+ * RSA encrypt: c =3D m^e mod n (public key operation)
+ * Also used for signature verification (verify =3D encrypt for raw RSA).
+ */
+static int cmh_rsa_enc(struct akcipher_request *req)
+{
+       struct crypto_akcipher *tfm =3D crypto_akcipher_reqtfm(req);
+       struct cmh_rsa_tfm_ctx *ctx =3D cmh_rsa_ctx(tfm);
+       struct cmh_rsa_reqctx *rctx =3D akcipher_request_ctx(req);
+       u32 key_bytes =3D ctx->bits / 8;
+       u32 e_padded =3D ALIGN(ctx->e_sz, 4);
+       struct core_dispatch d =3D cmh_core_select_instance(CMH_CORE_PKE);
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       int ret, nents;
+       gfp_t gfp;
+
+       if (!ctx->n || !ctx->e)
+               return -EINVAL;
+       if (req->src_len > key_bytes || req->dst_len < key_bytes)
+               return -EINVAL;
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->key_bytes =3D key_bytes;
+       rctx->e_padded =3D e_padded;
+       rctx->n_sz =3D ctx->n_sz;
+       rctx->e_dma =3D DMA_MAPPING_ERROR;
+       rctx->n_dma =3D DMA_MAPPING_ERROR;
+       rctx->m_dma =3D DMA_MAPPING_ERROR;
+       rctx->c_dma =3D DMA_MAPPING_ERROR;
+
+       rctx->e_buf =3D kzalloc(e_padded, gfp);
+       rctx->n_buf =3D kmemdup(ctx->n, ctx->n_sz, gfp);
+       rctx->m_buf =3D kzalloc(key_bytes, gfp);
+       rctx->c_buf =3D kzalloc(key_bytes, gfp);
+       if (!rctx->e_buf || !rctx->n_buf || !rctx->m_buf || !rctx->c_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       memcpy(rctx->e_buf + e_padded - ctx->e_sz, ctx->e, ctx->e_sz);
+
+       nents =3D sg_nents_for_len(req->src, req->src_len);
+       if (nents < 0 ||
+           sg_pcopy_to_buffer(req->src, nents,
+                              rctx->m_buf + key_bytes - req->src_len,
+                              req->src_len, 0) !=3D req->src_len) {
+               ret =3D -EINVAL;
+               goto out_free;
+       }
+
+       rctx->e_dma =3D cmh_dma_map_single(rctx->e_buf, e_padded,
+                                        DMA_TO_DEVICE);
+       rctx->n_dma =3D cmh_dma_map_single(rctx->n_buf, ctx->n_sz,
+                                        DMA_TO_DEVICE);
+       rctx->m_dma =3D cmh_dma_map_single(rctx->m_buf, key_bytes,
+                                        DMA_TO_DEVICE);
+       rctx->c_dma =3D cmh_dma_map_single(rctx->c_buf, key_bytes,
+                                        DMA_FROM_DEVICE);
+
+       if (cmh_dma_map_error(rctx->e_dma) ||
+           cmh_dma_map_error(rctx->n_dma) ||
+           cmh_dma_map_error(rctx->m_dma) ||
+           cmh_dma_map_error(rctx->c_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_rsa_enc(&vcq[1], d.core_id, ctx->bits, e_padded,
+                           rctx->e_dma, rctx->n_dma, rctx->m_dma,
+                           rctx->c_dma, PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[2], d.core_id);
+
+       ret =3D cmh_tm_submit_async(vcq, PKE_VCQ_CMDS_MIN, 1, d.mbx_idx,
+                                 cmh_rsa_enc_complete, req,
+                                 !!(req->base.flags &
+                                    CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (!ret)
+               return -EINPROGRESS;
+
+out_unmap:
+       if (!cmh_dma_map_error(rctx->c_dma))
+               cmh_dma_unmap_single(rctx->c_dma, key_bytes,
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(rctx->m_dma))
+               cmh_dma_unmap_single(rctx->m_dma, key_bytes,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->n_dma))
+               cmh_dma_unmap_single(rctx->n_dma, ctx->n_sz,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->e_dma))
+               cmh_dma_unmap_single(rctx->e_dma, e_padded,
+                                    DMA_TO_DEVICE);
+
+out_free:
+       kfree(rctx->c_buf);
+       kfree_sensitive(rctx->m_buf);
+       kfree(rctx->n_buf);
+       kfree(rctx->e_buf);
+       return ret;
+}
+
+static void cmh_rsa_dec_complete(void *data, int error)
+{
+       struct akcipher_request *req =3D data;
+       struct cmh_rsa_reqctx *rctx =3D akcipher_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       if (!cmh_dma_map_error(rctx->d_dma))
+               cmh_dma_unmap_single(rctx->d_dma, rctx->d_len,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->m_dma))
+               cmh_dma_unmap_single(rctx->m_dma, rctx->key_bytes,
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(rctx->c_dma))
+               cmh_dma_unmap_single(rctx->c_dma, rctx->key_bytes,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->n_dma))
+               cmh_dma_unmap_single(rctx->n_dma, rctx->n_sz,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->e_dma))
+               cmh_dma_unmap_single(rctx->e_dma, rctx->e_padded,
+                                    DMA_TO_DEVICE);
+
+       if (!error) {
+               int nents;
+
+               nents =3D sg_nents_for_len(req->dst, rctx->key_bytes);
+               if (nents < 0 ||
+                   sg_copy_from_buffer(req->dst, nents,
+                                       rctx->m_buf,
+                                       rctx->key_bytes) !=3D rctx->key_byt=
es)
+                       error =3D -EINVAL;
+               else
+                       req->dst_len =3D rctx->key_bytes;
+       }
+
+       kfree_sensitive(rctx->d_buf);
+       rctx->d_buf =3D NULL;
+       kfree_sensitive(rctx->m_buf);
+       rctx->m_buf =3D NULL;
+       kfree(rctx->c_buf);
+       rctx->c_buf =3D NULL;
+       kfree(rctx->n_buf);
+       rctx->n_buf =3D NULL;
+       kfree(rctx->e_buf);
+       rctx->e_buf =3D NULL;
+       cmh_complete(&req->base, error);
+}
+
+/*
+ * RSA decrypt: m =3D c^d mod n (private key operation)
+ * Also used for signing (sign =3D decrypt for raw RSA).
+ *
+ * Private key 'd' is written via SYS_REF_TEMP inline.
+ */
+static int cmh_rsa_dec(struct akcipher_request *req)
+{
+       struct crypto_akcipher *tfm =3D crypto_akcipher_reqtfm(req);
+       struct cmh_rsa_tfm_ctx *ctx =3D cmh_rsa_ctx(tfm);
+       struct cmh_rsa_reqctx *rctx =3D akcipher_request_ctx(req);
+       u32 key_bytes =3D ctx->bits / 8;
+       u32 e_padded =3D ALIGN(ctx->e_sz, 4);
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MAX];
+       struct core_dispatch dd;
+       int ret, idx, nents;
+       gfp_t gfp;
+
+       if (ctx->key.mode !=3D CMH_KEY_RAW)
+               return -EINVAL;
+       if (!ctx->n || !ctx->e)
+               return -EINVAL;
+       if (req->src_len > key_bytes || req->dst_len < key_bytes)
+               return -EINVAL;
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->key_bytes =3D key_bytes;
+       rctx->e_padded =3D e_padded;
+       rctx->n_sz =3D ctx->n_sz;
+       rctx->e_dma =3D DMA_MAPPING_ERROR;
+       rctx->n_dma =3D DMA_MAPPING_ERROR;
+       rctx->m_dma =3D DMA_MAPPING_ERROR;
+       rctx->c_dma =3D DMA_MAPPING_ERROR;
+       rctx->d_dma =3D DMA_MAPPING_ERROR;
+
+       rctx->e_buf =3D kzalloc(e_padded, gfp);
+       rctx->n_buf =3D kmemdup(ctx->n, ctx->n_sz, gfp);
+       rctx->c_buf =3D kzalloc(key_bytes, gfp);
+       rctx->m_buf =3D kzalloc(key_bytes, gfp);
+       if (!rctx->e_buf || !rctx->n_buf || !rctx->c_buf || !rctx->m_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       memcpy(rctx->e_buf + e_padded - ctx->e_sz, ctx->e, ctx->e_sz);
+
+       nents =3D sg_nents_for_len(req->src, req->src_len);
+       if (nents < 0 ||
+           sg_pcopy_to_buffer(req->src, nents,
+                              rctx->c_buf + key_bytes - req->src_len,
+                              req->src_len, 0) !=3D req->src_len) {
+               ret =3D -EINVAL;
+               goto out_free;
+       }
+
+       rctx->e_dma =3D cmh_dma_map_single(rctx->e_buf, e_padded,
+                                        DMA_TO_DEVICE);
+       rctx->n_dma =3D cmh_dma_map_single(rctx->n_buf, ctx->n_sz,
+                                        DMA_TO_DEVICE);
+       rctx->c_dma =3D cmh_dma_map_single(rctx->c_buf, key_bytes,
+                                        DMA_TO_DEVICE);
+       rctx->m_dma =3D cmh_dma_map_single(rctx->m_buf, key_bytes,
+                                        DMA_FROM_DEVICE);
+
+       if (cmh_dma_map_error(rctx->e_dma) ||
+           cmh_dma_map_error(rctx->n_dma) ||
+           cmh_dma_map_error(rctx->c_dma) ||
+           cmh_dma_map_error(rctx->m_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       dd =3D cmh_core_select_instance(CMH_CORE_PKE);
+
+       rctx->d_buf =3D kmemdup(ctx->key.raw.data, ctx->key.raw.len, gfp);
+       if (!rctx->d_buf) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+       rctx->d_len =3D ctx->key.raw.len;
+
+       rctx->d_dma =3D cmh_dma_map_single(rctx->d_buf, ctx->key.raw.len,
+                                        DMA_TO_DEVICE);
+       if (cmh_dma_map_error(rctx->d_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       idx =3D 1;
+       vcq_add_sys_write(&vcq[idx], SYS_REF_TEMP, rctx->d_dma,
+                         SYS_REF_NONE, ctx->key.raw.len,
+                         ctx->key.raw.sys_type);
+       vcq[idx].id |=3D PKE_SWAP_FLAGS;
+       idx++;
+       vcq_add_pke_rsa_dec(&vcq[idx++], dd.core_id, ctx->bits, e_padded,
+                           rctx->e_dma, rctx->n_dma, rctx->c_dma,
+                           rctx->m_dma, SYS_REF_TEMP, PKE_SWAP_FLAGS);
+       vcq_add_pke_flush(&vcq[idx++], dd.core_id);
+       vcq_set_header(&vcq[0], idx);
+
+       ret =3D cmh_tm_submit_async(vcq, idx, 1, dd.mbx_idx,
+                                 cmh_rsa_dec_complete, req,
+                                 !!(req->base.flags &
+                                    CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (!ret)
+               return -EINPROGRESS;
+
+out_unmap:
+       if (!cmh_dma_map_error(rctx->d_dma))
+               cmh_dma_unmap_single(rctx->d_dma, rctx->d_len,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->m_dma))
+               cmh_dma_unmap_single(rctx->m_dma, key_bytes,
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(rctx->c_dma))
+               cmh_dma_unmap_single(rctx->c_dma, key_bytes,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->n_dma))
+               cmh_dma_unmap_single(rctx->n_dma, ctx->n_sz,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->e_dma))
+               cmh_dma_unmap_single(rctx->e_dma, e_padded,
+                                    DMA_TO_DEVICE);
+
+out_free:
+       kfree_sensitive(rctx->d_buf);
+       kfree_sensitive(rctx->m_buf);
+       kfree(rctx->c_buf);
+       kfree(rctx->n_buf);
+       kfree(rctx->e_buf);
+       return ret;
+}
+
+static int cmh_rsa_set_pub_key(struct crypto_akcipher *tfm,
+                              const void *key, unsigned int keylen)
+{
+       struct cmh_rsa_tfm_ctx *ctx =3D cmh_rsa_ctx(tfm);
+       struct rsa_key rsa =3D {};
+       int ret;
+
+       ret =3D rsa_parse_pub_key(&rsa, key, keylen);
+       if (ret)
+               return ret;
+
+       /* Strip ASN.1 leading zero padding from modulus */
+       while (rsa.n_sz > 0 && rsa.n[0] =3D=3D 0) {
+               rsa.n++;
+               rsa.n_sz--;
+       }
+
+       ctx->bits =3D cmh_rsa_key_bits(rsa.n_sz);
+       if (!ctx->bits)
+               return -EINVAL;
+
+       kfree(ctx->n);
+       kfree(ctx->e);
+       ctx->n =3D NULL;
+       ctx->e =3D NULL;
+       ctx->n_sz =3D 0;
+       ctx->e_sz =3D 0;
+
+       ctx->n =3D kmemdup(rsa.n, rsa.n_sz, GFP_KERNEL);
+       ctx->e =3D kmemdup(rsa.e, rsa.e_sz, GFP_KERNEL);
+       if (!ctx->n || !ctx->e) {
+               kfree(ctx->n);
+               kfree(ctx->e);
+               ctx->n =3D NULL;
+               ctx->e =3D NULL;
+               return -ENOMEM;
+       }
+
+       ctx->n_sz =3D rsa.n_sz;
+       ctx->e_sz =3D rsa.e_sz;
+
+       return 0;
+}
+
+static int cmh_rsa_set_priv_key(struct crypto_akcipher *tfm,
+                               const void *key, unsigned int keylen)
+{
+       struct cmh_rsa_tfm_ctx *ctx =3D cmh_rsa_ctx(tfm);
+       struct rsa_key rsa =3D {};
+       u32 key_bytes;
+       u8 *d_padded;
+       int ret;
+
+       ret =3D rsa_parse_priv_key(&rsa, key, keylen);
+       if (ret)
+               return ret;
+
+       /* Strip ASN.1 leading zero padding from modulus */
+       while (rsa.n_sz > 0 && rsa.n[0] =3D=3D 0) {
+               rsa.n++;
+               rsa.n_sz--;
+       }
+
+       ctx->bits =3D cmh_rsa_key_bits(rsa.n_sz);
+       if (!ctx->bits || !rsa.d_sz)
+               return -EINVAL;
+
+       key_bytes =3D ctx->bits / 8;
+
+       /* Strip ASN.1 leading zero padding from private exponent */
+       while (rsa.d_sz > 0 && rsa.d[0] =3D=3D 0) {
+               rsa.d++;
+               rsa.d_sz--;
+       }
+
+       if (!rsa.d_sz || rsa.d_sz > key_bytes)
+               return -EINVAL;
+
+       kfree(ctx->n);
+       kfree(ctx->e);
+       ctx->n =3D NULL;
+       ctx->e =3D NULL;
+       ctx->n_sz =3D 0;
+       ctx->e_sz =3D 0;
+
+       ctx->n =3D kmemdup(rsa.n, rsa.n_sz, GFP_KERNEL);
+       ctx->e =3D kmemdup(rsa.e, rsa.e_sz, GFP_KERNEL);
+       if (!ctx->n || !ctx->e) {
+               ret =3D -ENOMEM;
+               goto err;
+       }
+
+       ctx->n_sz =3D rsa.n_sz;
+       ctx->e_sz =3D rsa.e_sz;
+
+       /*
+        * Left-pad d to key_bytes (big-endian alignment).
+        * The CMH eSW resolves SYS_REF_TEMP by checking
+        * hdr->len >=3D key_bytes, so the written buffer must
+        * be at least key_bytes wide.
+        */
+       d_padded =3D kzalloc(key_bytes, GFP_KERNEL);
+       if (!d_padded) {
+               ret =3D -ENOMEM;
+               goto err;
+       }
+       memcpy(d_padded + key_bytes - rsa.d_sz, rsa.d, rsa.d_sz);
+
+       ret =3D cmh_key_setkey_raw(&ctx->key, d_padded, key_bytes,
+                                CORE_ID_PKE);
+       kfree_sensitive(d_padded);
+       if (ret)
+               goto err;
+
+       return 0;
+err:
+       kfree(ctx->n);
+       kfree(ctx->e);
+       ctx->n =3D NULL;
+       ctx->e =3D NULL;
+       ctx->n_sz =3D 0;
+       ctx->e_sz =3D 0;
+       ctx->bits =3D 0;
+       return ret;
+}
+
+static unsigned int cmh_rsa_max_size(struct crypto_akcipher *tfm)
+{
+       struct cmh_rsa_tfm_ctx *ctx =3D cmh_rsa_ctx(tfm);
+
+       return ctx->n_sz;
+}
+
+static int cmh_rsa_init_tfm(struct crypto_akcipher *tfm)
+{
+       struct cmh_rsa_tfm_ctx *ctx =3D cmh_rsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       tfm->reqsize =3D sizeof(struct cmh_rsa_reqctx);
+       return 0;
+}
+
+static void cmh_rsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+       struct cmh_rsa_tfm_ctx *ctx =3D cmh_rsa_ctx(tfm);
+
+       cmh_key_destroy(&ctx->key);
+       kfree(ctx->n);
+       kfree(ctx->e);
+       ctx->n =3D NULL;
+       ctx->e =3D NULL;
+}
+
+/*
+ * Raw RSA stays as akcipher (encrypt/decrypt only).  The kernel's
+ * rsassa-pkcs1 sig template wraps our akcipher for sign/verify,
+ * matching the upstream split (rsa.c =3D akcipher,
+ * rsassa-pkcs1.c =3D sig template).
+ */
+static struct akcipher_alg cmh_rsa_alg =3D {
+       .encrypt        =3D cmh_rsa_enc,
+       .decrypt        =3D cmh_rsa_dec,
+       .set_pub_key    =3D cmh_rsa_set_pub_key,
+       .set_priv_key   =3D cmh_rsa_set_priv_key,
+       .max_size       =3D cmh_rsa_max_size,
+       .init           =3D cmh_rsa_init_tfm,
+       .exit           =3D cmh_rsa_exit_tfm,
+       .base =3D {
+               .cra_name         =3D "rsa",
+               .cra_driver_name  =3D "cri-cmh-rsa",
+               .cra_priority     =3D 300,
+               .cra_flags        =3D CRYPTO_ALG_ASYNC,
+               .cra_module       =3D THIS_MODULE,
+               .cra_ctxsize      =3D sizeof(struct cmh_rsa_tfm_ctx),
+       },
+};
+
+static bool cmh_rsa_registered;
+
+/**
+ * cmh_pke_rsa_register() - Register RSA akcipher algorithm with the crypt=
o framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_pke_rsa_register(void)
+{
+       int ret;
+
+       ret =3D crypto_register_akcipher(&cmh_rsa_alg);
+       if (ret) {
+               dev_err(cmh_dev(),
+                       "cmh: failed to register rsa akcipher (%d)\n",
+                       ret);
+               return ret;
+       }
+
+       cmh_rsa_registered =3D true;
+       return 0;
+}
+
+/**
+ * cmh_pke_rsa_unregister() - Unregister RSA akcipher algorithm from the c=
rypto framework
+ */
+void cmh_pke_rsa_unregister(void)
+{
+       if (cmh_rsa_registered)
+               crypto_unregister_akcipher(&cmh_rsa_alg);
+       cmh_rsa_registered =3D false;
+}
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

