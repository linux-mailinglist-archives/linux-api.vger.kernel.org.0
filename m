Return-Path: <linux-api+bounces-6686-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IytwGN5mPWpQ2ggAu9opvQ
	(envelope-from <linux-api+bounces-6686-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:35:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E86C7D38
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:35:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=trUJSLGl;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6686-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6686-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4703091407
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F93ED3A7;
	Thu, 25 Jun 2026 17:34:17 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020083.outbound.protection.outlook.com [52.101.61.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8193EC2DE;
	Thu, 25 Jun 2026 17:34:14 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408857; cv=fail; b=VoYHLT0OHPAB5uDarETAkUc1XwTVR75M9cW+xQGmWy/GHKX5yJ8HB+jVpbsBdrd+irg03bMX4WjBjQuCDB18SRuiIfqYODSPoeDPGc7sJgegRuWqzLglbRJyBPmW56uzpav0BKtO+//sh4Gv+e32GPgd6/jf9GXSd8/FuoQXh+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408857; c=relaxed/simple;
	bh=QQM/9vbC5uArIChxi00TwDx9pmXKjMkssxFLpaUxrAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gm1+BGbymzt+Yp8ULhJsUdgYbiVKvumFbi5o8q5iDZXFRGilYlnKIXFGwdBXbBuJBRQShb4LHSP/swUkgtp9Lrzx7vMur1Du9BoVksIaPLPEBMEC18hDFiz4YSu9P94DJR/I6OF96tUjUt6z/iO4T662nJBUiRd7o1ofzBb4NOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=trUJSLGl; arc=fail smtp.client-ip=52.101.61.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw+VwB9+EZsxe8JJM4hf0U71FDU4oq9PkIiveGaSkAJxubQNctYkzwJL7UP9tpORLOoQdcu4a8CwoYKqbRijvCzSKT/vGD7zNOqa727+QQkNSytkrVm2zBoij43au71yhak/57oeoAcfzq68BfB2nfZ4KQWxaXglRQsxgOSMRWj0/YRnjnpVg5tIrDMv72eha2XE20vqkoh2/tTrN7HGlA+Fks3B305qu5VGvC4hx+z5mVI4jFv50eSc5xfI8e50gL5wXnBcitnHpS/pD5ui1djOJHivlwlo2GPMe27cVISpt9+3d3VZ35iP59ryt88eYdnRJIZZZk+Rz2Fhkp8srA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGaJ9P1evt+n8ganIsu+XvQ8vP0siaJ4KVzukKP9CbU=;
 b=O/wZMVARlEawU0Wj+rin4YA31EIrPNajmC6MeH1HB0g970Yqhn6JqZ5krGlQcQ6eIm12Ep6TS95NEGc1ywsY2GDrm9dUT9eIgI1niWMeAfZTwvef0hyaTWXwxxvn6HzeRInfP+ko2+O0D3xLl4Vjr5obNzBNJ2NANdTeMWqh76pZCwj4Q5tZvcCuEo+ryfiVrcOkBG3XSUFYEgr9hTjE6INx8eNpZRfleix/uVPF+1FycWu4vCYWMomS8IxXxWwMiIUzKTp4fciUV7Cw7lV0nZODfSarc09PiYROr6aKSRt8l+2hflLN0LX0T0eqBeCPEmLvMczfVVlKcbgv4PHU3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGaJ9P1evt+n8ganIsu+XvQ8vP0siaJ4KVzukKP9CbU=;
 b=trUJSLGleJ8SnvDEHOhKvgTTKJ1jZ8BJzu8HHONA+IvC+/yLm1cEoudsVFYPP2GIAPMF1VKJE0lLCv8Z+8m2IY/vz1d0oghS12gySuRdCbQRUQvmZpsTEbKalApfIAHgYK9o2e9logHcg3n4ktSXnGICbA+vhdb8fDqAGxqKwxBIGlQGcxJ+Yqa8DTLO89xwPFgLZEJZSebHhPYfwaqmu6SeimVUT4I0bHIEelcLMHcyOlupq4N2eaKgX+PcXn+ECvFJuQxvtk0910/a/0RgEZ1s8hHgGc2KvQwEaXUM7q52+YnNot2ZZRWhZ/g0BDqOuX+mTroVeKTbSVnQp+R82Q==
Received: from PH8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:2d0::17)
 by PH0PR04MB7366.namprd04.prod.outlook.com (2603:10b6:510:1f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 17:34:10 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::ac) by PH8PR02CA0008.outlook.office365.com
 (2603:10b6:510:2d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 17:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:09 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 5C5A81801777;
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
Subject: [PATCH 14/19] crypto: cmh - add ECDH/X25519 kpp
Date: Thu, 25 Jun 2026 10:33:22 -0700
Message-ID: <20260625173328.1140487-15-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|PH0PR04MB7366:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bcdda411-b00a-443d-31bf-08ded2dff715
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|23010399003|1800799024|921020|22082099003|18002099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	Eq0XXexrMsbekaQNYsfXotEPECnUOucrk7h+5gIUMDaZeW6aYxDPEdcZ5mQuRUJh0aaG71rE6ovz8tY3dlppjYBX5SZsHeSJG0v58JFgeuv2BjQ7Tu5kShoTTD7OstM/0QfxM79pCfepg7hSSuAZZjg6/5D5VFsLnL+9HdFb9mHbTDoyKtDVd75ZV0h1tw9DegvekD7c+/idq4uWGd7wS/K+PGRFhnw9LzkxqPaODGzpUoGZuIACwKyiZrzfey8N5vnMdso4gMkyaWd+t+IjDYQ60bsNiFJCgP5wkO7wcfSCBXEuQqq/b4Ek+2p8K7XkRD7DwkJdwAtwIgs2NccwBb/zcTMGlXJlCD/wp6ETRsMPbk4kghS2oRnpCcd6y9H6+nrmuvnMrRXS4FwXBuDktibXHc7tFTUcm8Ms8gxtVE8ZSQBPNcDodkbl8VS6vE9sc7UB1AAUbX5AYdufBDiKoTZOdEM2DVUB3o5jV5lg/WOtUUBW0f/zQlqi30+qnp2xsF5p9XJo5gBWSyVIJ2oQPGzQz+idPLlL+V9xI5U7OVbZ/uMEDCxEu9jicDz4Qw583JIx4+qrwKFAFDOIXeo42JiZmDHlnC5fH2XpbUS44skbNLcaLHwyQgijgBBRa16l0YJT33Cijf0Zg0OUc5iRaiSfLSaZ9Y3JBG95oO2nu65cmzwmMY8K1w+k7tIG/21SwZLHzpEH9Je0MS1q4TRgslOEjssFOaVriMzDkC/JcYfGEDZ/yK72e+yBZJwTGLWk
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(23010399003)(1800799024)(921020)(22082099003)(18002099003)(3023799007)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u1VvBBZGHzWwXtRSk1unsZcxxaIxTUoPeWK/VCF67RWyovaDPN60w7RcFg7NiaqdH4DAF2emzBmwWtGyctJhov3SgkJu5rF4EYvC6+JMeiDw2WZX0WNZe8CChtgJ7MKC5mDrvo1YnQ4Ia+e00DCIAdB5pWEujSmxENkOLoSwjmjA9ZxYYA1ciSXBjMoWOoRaNIHDi8mVj8zbVUJILcBt0jE7WHevVLZUV+2dVU8P5VOEPS6cT7pqz7/bOdggG+dIG4zJbGB7FDzdNo5FGNw3C9GIi9WWvQ3OMQD4bZLVXXKCycmUuuB8QZfRyinWNtMnBYmgOfe9SK7EzqI4jgSMjvRWy/WNzJT+vbdlnbB3HpRPm3FDxuzIjNUxxHma9VzicLefpRYxblb2enxMxG4t1n3VtRjTI/hxwiPCj96k+gXf+XcHfrVZsEUWy6Gl7wTN
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:09.6427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdda411-b00a-443d-31bf-08ded2dff715
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7366
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
	TAGGED_FROM(0.00)[bounces-6686-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: BC8E86C7D38

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ECDH and X25519 kpp algorithms using the CMH PKE core.
Supports P-256, P-384, and Curve25519 for key agreement.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
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
@@ -32,7 +32,8 @@ cmh-y :=3D \
        cmh_rng.o \
        cmh_pke_common.o \
        cmh_pke_rsa.o \
-       cmh_pke_ecdsa.o
+       cmh_pke_ecdsa.o \
+       cmh_pke_ecdh.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 939ff5007755..ea0f32b941f5 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -286,6 +286,11 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_pke_ecdsa_register;

+       /* Register PKE ECDH/X25519 kpp */
+       ret =3D cmh_pke_ecdh_register();
+       if (ret)
+               goto err_pke_ecdh_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -298,6 +303,8 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_pke_ecdh_unregister();
+err_pke_ecdh_register:
        cmh_pke_ecdsa_unregister();
 err_pke_ecdsa_register:
        cmh_pke_rsa_unregister();
@@ -358,6 +365,7 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_pke_ecdh_unregister();
        cmh_pke_ecdsa_unregister();
        cmh_pke_rsa_unregister();
        cmh_ccp_poly_unregister();
diff --git a/drivers/crypto/cmh/cmh_pke_ecdh.c b/drivers/crypto/cmh/cmh_pke=
_ecdh.c
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
+#define ECDH_KPP_SECRET_MIN_SIZE (sizeof(struct kpp_secret) + sizeof(unsig=
ned short))
+
+struct cmh_ecdh_tfm_ctx {
+       struct cmh_key_ctx key;
+       u32 curve;              /* PKE_CURVE_* */
+       u32 clen;               /* coordinate length in bytes */
+};
+
+static inline struct cmh_ecdh_tfm_ctx *cmh_ecdh_ctx(struct crypto_kpp *tfm=
)
+{
+       return kpp_tfm_ctx(tfm);
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
+       /* Buffers */
+       u8 *pk_buf;             /* keygen: output public key */
+       u8 *sk_buf;             /* private key copy */
+       u8 *peer_buf;           /* compute: peer public key */
+       u8 *ss_buf;             /* compute: shared secret output */
+       u64 *ref_buf;           /* compute: DS ref from Phase 1 */
+       /* DMA handles */
+       dma_addr_t pk_dma;
+       dma_addr_t sk_dma;
+       dma_addr_t peer_dma;
+       dma_addr_t ss_dma;
+       dma_addr_t ref_dma;
+       /* Sizes and params for Phase 2 re-submit */
+       u32 out_len;            /* keygen: public key size */
+       u32 clen;
+       u32 peer_len;
+       u32 sk_len;
+       u32 dma_swap;
+       int mbx_idx;            /* pinned MBX for Phase 2 */
+};
+
+/*
+ * set_secret: NIST curves decode kpp_secret + u16 key_size + raw scalar.
+ * Curve25519 uses raw 32-byte scalar directly.
+ */
+static int cmh_ecdh_set_secret_nist(struct crypto_kpp *tfm,
+                                   const void *buf, unsigned int len)
+{
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+       const u8 *ptr =3D buf;
+       struct kpp_secret secret;
+       unsigned short key_size;
+       int ret;
+
+       if (!buf || len < ECDH_KPP_SECRET_MIN_SIZE)
+               return -EINVAL;
+
+       memcpy(&secret, ptr, sizeof(secret));
+       ptr +=3D sizeof(secret);
+
+       if (secret.type !=3D CRYPTO_KPP_SECRET_TYPE_ECDH)
+               return -EINVAL;
+       if (len < secret.len)
+               return -EINVAL;
+
+       memcpy(&key_size, ptr, sizeof(key_size));
+       ptr +=3D sizeof(key_size);
+
+       if (key_size =3D=3D 0) {
+               /*
+                * key_size =3D=3D 0: generate a validated random private k=
ey.
+                * Uses the kernel ECC library (FIPS 186-5 A.2.2) to ensure
+                * the scalar is in the valid range [2, n-3] for the curve.
+                */
+               u64 priv[ECC_MAX_DIGITS];
+               unsigned int ndigits =3D ctx->clen / sizeof(u64);
+               unsigned int curve_id;
+               u8 *rnd;
+
+               if (secret.len !=3D ECDH_KPP_SECRET_MIN_SIZE)
+                       return -EINVAL;
+               if (ndigits > ECC_MAX_DIGITS)
+                       return -EINVAL;
+               /* Reject non-limb-aligned clen to prevent ndigits truncati=
on */
+               if (ctx->clen % sizeof(u64))
+                       return -EINVAL;
+
+               if (ctx->curve =3D=3D PKE_CURVE_P256)
+                       curve_id =3D ECC_CURVE_NIST_P256;
+               else if (ctx->curve =3D=3D PKE_CURVE_P384)
+                       curve_id =3D ECC_CURVE_NIST_P384;
+               else
+                       return -EINVAL;
+
+               ret =3D ecc_gen_privkey(curve_id, ndigits, priv);
+               if (ret) {
+                       memzero_explicit(priv, sizeof(priv));
+                       return ret;
+               }
+
+               rnd =3D kmalloc(ctx->clen, GFP_KERNEL);
+               if (!rnd) {
+                       memzero_explicit(priv, sizeof(priv));
+                       return -ENOMEM;
+               }
+
+               /* Convert VLI (native LE-digit-order) to big-endian bytes =
*/
+               ecc_swap_digits(priv, (u64 *)rnd, ndigits);
+               memzero_explicit(priv, sizeof(priv));
+
+               ret =3D cmh_key_setkey_raw(&ctx->key, rnd, ctx->clen,
+                                        CORE_ID_PKE);
+               kfree_sensitive(rnd);
+               return ret;
+       }
+
+       if (key_size !=3D ctx->clen)
+               return -EINVAL;
+
+       if (secret.len !=3D ECDH_KPP_SECRET_MIN_SIZE + key_size)
+               return -EINVAL;
+
+       return cmh_key_setkey_raw(&ctx->key, ptr, key_size, CORE_ID_PKE);
+}
+
+static int cmh_ecdh_set_secret_x25519(struct crypto_kpp *tfm,
+                                     const void *buf, unsigned int len)
+{
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+
+       if (len !=3D pke_curve_clen(PKE_CURVE_25519))
+               return -EINVAL;
+
+       return cmh_key_setkey_raw(&ctx->key, buf, len, CORE_ID_PKE);
+}
+
+static void cmh_ecdh_keygen_complete(void *data, int error)
+{
+       struct kpp_request *req =3D data;
+       struct cmh_ecdh_reqctx *rctx =3D kpp_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       if (!cmh_dma_map_error(rctx->sk_dma))
+               cmh_dma_unmap_single(rctx->sk_dma, rctx->sk_len,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->pk_dma))
+               cmh_dma_unmap_single(rctx->pk_dma, rctx->out_len,
+                                    DMA_FROM_DEVICE);
+
+       if (!error) {
+               int nents;
+
+               nents =3D sg_nents_for_len(req->dst, rctx->out_len);
+               if (nents < 0 ||
+                   sg_copy_from_buffer(req->dst, nents,
+                                       rctx->pk_buf,
+                                       rctx->out_len) !=3D rctx->out_len)
+                       error =3D -EINVAL;
+               else
+                       req->dst_len =3D rctx->out_len;
+       }
+
+       kfree_sensitive(rctx->sk_buf);
+       rctx->sk_buf =3D NULL;
+       kfree(rctx->pk_buf);
+       rctx->pk_buf =3D NULL;
+       cmh_complete(&req->base, error);
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
+       struct crypto_kpp *tfm =3D crypto_kpp_reqtfm(req);
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+       struct cmh_ecdh_reqctx *rctx =3D kpp_request_ctx(req);
+       u32 clen =3D ctx->clen;
+       bool is_25519 =3D (ctx->curve =3D=3D PKE_CURVE_25519);
+       u32 out_len =3D is_25519 ? clen : 2 * clen;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MAX];
+       struct core_dispatch dd;
+       u32 swap, dma_swap;
+       int ret, idx;
+       gfp_t gfp;
+
+       if (ctx->key.mode !=3D CMH_KEY_RAW)
+               return -EINVAL;
+       if (req->dst_len < out_len)
+               return -EINVAL;
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->out_len =3D out_len;
+       rctx->sk_len =3D ctx->key.raw.len;
+       rctx->pk_dma =3D DMA_MAPPING_ERROR;
+       rctx->sk_dma =3D DMA_MAPPING_ERROR;
+
+       rctx->pk_buf =3D kzalloc(out_len, gfp);
+       if (!rctx->pk_buf)
+               return -ENOMEM;
+
+       rctx->pk_dma =3D cmh_dma_map_single(rctx->pk_buf, out_len,
+                                         DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(rctx->pk_dma)) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       swap =3D PKE_SWAP_FLAGS;
+       dma_swap =3D pke_swap_flags(ctx->curve);
+
+       dd =3D cmh_core_select_instance(CMH_CORE_PKE);
+
+       rctx->sk_buf =3D kmemdup(ctx->key.raw.data, ctx->key.raw.len, gfp);
+       if (!rctx->sk_buf) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+       rctx->sk_dma =3D cmh_dma_map_single(rctx->sk_buf, ctx->key.raw.len,
+                                         DMA_TO_DEVICE);
+       if (cmh_dma_map_error(rctx->sk_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MAX);
+       idx =3D 1;
+       vcq_add_sys_write(&vcq[idx], SYS_REF_TEMP, rctx->sk_dma,
+                         SYS_REF_NONE, ctx->key.raw.len,
+                         ctx->key.raw.sys_type);
+       vcq[idx].id |=3D dma_swap;
+       idx++;
+       if (is_25519)
+               vcq_add_pke_ecdh_keygen(&vcq[idx++], dd.core_id, ctx->curve=
,
+                                       clen, rctx->pk_dma, SYS_REF_TEMP,
+                                       swap);
+       else
+               vcq_add_pke_ecdsa_pubgen(&vcq[idx++], dd.core_id,
+                                        ctx->curve, clen, rctx->pk_dma,
+                                        SYS_REF_TEMP, swap);
+       vcq_add_pke_flush(&vcq[idx++], dd.core_id);
+
+       ret =3D cmh_tm_submit_async(vcq, PKE_VCQ_CMDS_MAX, 1, dd.mbx_idx,
+                                 cmh_ecdh_keygen_complete, req,
+                                 !!(req->base.flags &
+                                    CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (!ret)
+               return -EINPROGRESS;
+
+out_unmap:
+       if (!cmh_dma_map_error(rctx->sk_dma))
+               cmh_dma_unmap_single(rctx->sk_dma, ctx->key.raw.len,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->pk_dma))
+               cmh_dma_unmap_single(rctx->pk_dma, out_len,
+                                    DMA_FROM_DEVICE);
+
+out_free:
+       kfree_sensitive(rctx->sk_buf);
+       kfree(rctx->pk_buf);
+       return ret;
+}
+
+static void cmh_ecdh_ss_phase2_complete(void *data, int error)
+{
+       struct kpp_request *req =3D data;
+       struct cmh_ecdh_reqctx *rctx =3D kpp_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       if (!cmh_dma_map_error(rctx->ss_dma))
+               cmh_dma_unmap_single(rctx->ss_dma, rctx->clen,
+                                    DMA_FROM_DEVICE);
+
+       if (!error) {
+               int nents;
+
+               nents =3D sg_nents_for_len(req->dst, rctx->clen);
+               if (nents < 0 ||
+                   sg_copy_from_buffer(req->dst, nents,
+                                       rctx->ss_buf,
+                                       rctx->clen) !=3D rctx->clen)
+                       error =3D -EINVAL;
+               else
+                       req->dst_len =3D rctx->clen;
+       }
+
+       kfree(rctx->ref_buf);
+       rctx->ref_buf =3D NULL;
+       kfree_sensitive(rctx->ss_buf);
+       rctx->ss_buf =3D NULL;
+       cmh_complete(&req->base, error);
+}
+
+static void cmh_ecdh_ss_phase1_complete(void *data, int error)
+{
+       struct kpp_request *req =3D data;
+       struct cmh_ecdh_reqctx *rctx =3D kpp_request_ctx(req);
+       struct vcq_cmd vcq[3];
+       int ret;
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       /* Phase 1-only resources: sk, peer -- always clean up */
+       if (!cmh_dma_map_error(rctx->sk_dma))
+               cmh_dma_unmap_single(rctx->sk_dma, rctx->sk_len,
+                                    DMA_TO_DEVICE);
+       kfree_sensitive(rctx->sk_buf);
+       rctx->sk_buf =3D NULL;
+
+       if (!cmh_dma_map_error(rctx->peer_dma))
+               cmh_dma_unmap_single(rctx->peer_dma, rctx->peer_len,
+                                    DMA_TO_DEVICE);
+       kfree(rctx->peer_buf);
+       rctx->peer_buf =3D NULL;
+
+       if (error)
+               goto out_cleanup;
+
+       /* Read the DS reference written by Phase 1 */
+       cmh_dma_sync_for_cpu(rctx->ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+       cmh_dma_unmap_single(rctx->ref_dma, sizeof(u64), DMA_FROM_DEVICE);
+       rctx->ref_dma =3D DMA_MAPPING_ERROR;
+
+       /* Phase 2: extract shared secret from DS */
+       vcq_set_header(&vcq[0], 3);
+       vcq_add_sys_data(&vcq[1], *rctx->ref_buf, rctx->ss_dma,
+                        rctx->clen);
+       vcq[1].id |=3D rctx->dma_swap;
+       vcq_add_sys_flush(&vcq[2]);
+
+       ret =3D cmh_tm_submit_async(vcq, 3, 1, rctx->mbx_idx,
+                                 cmh_ecdh_ss_phase2_complete, req,
+                                 true, 0);
+       if (ret =3D=3D -EBUSY || !ret)
+               return;
+
+       error =3D ret;
+
+out_cleanup:
+       if (!cmh_dma_map_error(rctx->ref_dma))
+               cmh_dma_unmap_single(rctx->ref_dma, sizeof(u64),
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(rctx->ss_dma))
+               cmh_dma_unmap_single(rctx->ss_dma, rctx->clen,
+                                    DMA_FROM_DEVICE);
+       kfree(rctx->ref_buf);
+       rctx->ref_buf =3D NULL;
+       kfree_sensitive(rctx->ss_buf);
+       rctx->ss_buf =3D NULL;
+       cmh_complete(&req->base, error);
+}
+
+/*
+ * compute_shared_secret: PKE_CMD_ECDH.
+ *
+ * req->src =3D peer public key (X||Y for NIST, raw 32B for Curve25519).
+ * Output =3D shared secret X coordinate (clen bytes).
+ *
+ * The CMH ECDH command stores the shared secret in a DS object,
+ * not directly to DMA.  We create a DS slot with SYS_CMD_NEW,
+ * reference it via SYS_REF_LAST, then extract the result with a
+ * second VCQ submission using SYS_CMD_DATA with the actual ref.
+ */
+static int cmh_ecdh_compute_shared_secret(struct kpp_request *req)
+{
+       struct crypto_kpp *tfm =3D crypto_kpp_reqtfm(req);
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+       struct cmh_ecdh_reqctx *rctx =3D kpp_request_ctx(req);
+       u32 clen =3D ctx->clen;
+       bool is_25519 =3D (ctx->curve =3D=3D PKE_CURVE_25519);
+       u32 peer_len =3D is_25519 ? clen : 2 * clen;
+       u32 ss_type =3D SYS_TYPE_SET(SYS_TYPE_FLAG_PT, CORE_ID_PKE);
+       struct vcq_cmd vcq[5];
+       struct core_dispatch dd;
+       u32 swap, dma_swap;
+       int ret, idx, nents;
+       gfp_t gfp;
+
+       if (ctx->key.mode !=3D CMH_KEY_RAW)
+               return -EINVAL;
+       if (req->src_len < peer_len || req->dst_len < clen)
+               return -EINVAL;
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->clen =3D clen;
+       rctx->peer_len =3D peer_len;
+       rctx->sk_len =3D ctx->key.raw.len;
+       rctx->pk_dma =3D DMA_MAPPING_ERROR;
+       rctx->sk_dma =3D DMA_MAPPING_ERROR;
+       rctx->peer_dma =3D DMA_MAPPING_ERROR;
+       rctx->ss_dma =3D DMA_MAPPING_ERROR;
+       rctx->ref_dma =3D DMA_MAPPING_ERROR;
+
+       rctx->peer_buf =3D kmalloc(peer_len, gfp);
+       rctx->ss_buf =3D kzalloc(clen, gfp);
+       rctx->ref_buf =3D kzalloc_obj(u64, gfp);
+       if (!rctx->peer_buf || !rctx->ss_buf || !rctx->ref_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       nents =3D sg_nents_for_len(req->src, peer_len);
+       if (nents < 0 ||
+           sg_pcopy_to_buffer(req->src, nents, rctx->peer_buf,
+                              peer_len, 0) !=3D peer_len) {
+               ret =3D -EINVAL;
+               goto out_free;
+       }
+
+       rctx->peer_dma =3D cmh_dma_map_single(rctx->peer_buf, peer_len,
+                                           DMA_TO_DEVICE);
+       rctx->ss_dma =3D cmh_dma_map_single(rctx->ss_buf, clen,
+                                         DMA_FROM_DEVICE);
+       rctx->ref_dma =3D cmh_dma_map_single(rctx->ref_buf, sizeof(u64),
+                                          DMA_FROM_DEVICE);
+
+       if (cmh_dma_map_error(rctx->peer_dma) ||
+           cmh_dma_map_error(rctx->ss_dma) ||
+           cmh_dma_map_error(rctx->ref_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       swap =3D PKE_SWAP_FLAGS;
+       dma_swap =3D pke_swap_flags(ctx->curve);
+       rctx->dma_swap =3D dma_swap;
+
+       dd =3D cmh_core_select_instance(CMH_CORE_PKE);
+       rctx->mbx_idx =3D dd.mbx_idx;
+
+       rctx->sk_buf =3D kmemdup(ctx->key.raw.data, ctx->key.raw.len, gfp);
+       if (!rctx->sk_buf) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+       rctx->sk_dma =3D cmh_dma_map_single(rctx->sk_buf, ctx->key.raw.len,
+                                         DMA_TO_DEVICE);
+       if (cmh_dma_map_error(rctx->sk_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], 5);
+       idx =3D 1;
+       vcq_add_sys_write(&vcq[idx], SYS_REF_TEMP, rctx->sk_dma,
+                         SYS_REF_NONE, ctx->key.raw.len,
+                         ctx->key.raw.sys_type);
+       vcq[idx].id |=3D dma_swap;
+       idx++;
+       vcq_add_sys_new(&vcq[idx++], 0, rctx->ref_dma, clen);
+       vcq_add_pke_ecdh(&vcq[idx++], dd.core_id, ctx->curve, clen,
+                        clen, ss_type, rctx->peer_dma,
+                        SYS_REF_TEMP, SYS_REF_LAST, swap);
+       vcq_add_pke_flush(&vcq[idx++], dd.core_id);
+
+       ret =3D cmh_tm_submit_async(vcq, 5, 1, dd.mbx_idx,
+                                 cmh_ecdh_ss_phase1_complete, req,
+                                 !!(req->base.flags &
+                                    CRYPTO_TFM_REQ_MAY_BACKLOG), 0);
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (!ret)
+               return -EINPROGRESS;
+
+out_unmap:
+       if (!cmh_dma_map_error(rctx->sk_dma))
+               cmh_dma_unmap_single(rctx->sk_dma, rctx->sk_len,
+                                    DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(rctx->ss_dma))
+               cmh_dma_unmap_single(rctx->ss_dma, clen,
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(rctx->ref_dma))
+               cmh_dma_unmap_single(rctx->ref_dma, sizeof(u64),
+                                    DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(rctx->peer_dma))
+               cmh_dma_unmap_single(rctx->peer_dma, peer_len,
+                                    DMA_TO_DEVICE);
+
+out_free:
+       kfree_sensitive(rctx->sk_buf);
+       kfree(rctx->ref_buf);
+       kfree_sensitive(rctx->ss_buf);
+       kfree(rctx->peer_buf);
+       return ret;
+}
+
+static unsigned int cmh_ecdh_max_size(struct crypto_kpp *tfm)
+{
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+
+       /* Max output =3D X||Y for generate_public_key (NIST) */
+       return 2 * ctx->clen;
+}
+
+static unsigned int cmh_x25519_max_size(struct crypto_kpp *tfm)
+{
+       return pke_curve_clen(PKE_CURVE_25519); /* single coordinate */
+}
+
+static int cmh_ecdh_p256_init(struct crypto_kpp *tfm)
+{
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->curve =3D PKE_CURVE_P256;
+       ctx->clen =3D pke_curve_clen(PKE_CURVE_P256);
+       tfm->reqsize =3D sizeof(struct cmh_ecdh_reqctx);
+       return 0;
+}
+
+static int cmh_ecdh_p384_init(struct crypto_kpp *tfm)
+{
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->curve =3D PKE_CURVE_P384;
+       ctx->clen =3D pke_curve_clen(PKE_CURVE_P384);
+       tfm->reqsize =3D sizeof(struct cmh_ecdh_reqctx);
+       return 0;
+}
+
+static int cmh_x25519_init(struct crypto_kpp *tfm)
+{
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->curve =3D PKE_CURVE_25519;
+       ctx->clen =3D pke_curve_clen(PKE_CURVE_25519);
+       tfm->reqsize =3D sizeof(struct cmh_ecdh_reqctx);
+       return 0;
+}
+
+static void cmh_ecdh_exit(struct crypto_kpp *tfm)
+{
+       struct cmh_ecdh_tfm_ctx *ctx =3D cmh_ecdh_ctx(tfm);
+
+       cmh_key_destroy(&ctx->key);
+}
+
+static struct kpp_alg cmh_ecdh_algs[] =3D {
+       {
+               .set_secret             =3D cmh_ecdh_set_secret_nist,
+               .generate_public_key    =3D cmh_ecdh_generate_public_key,
+               .compute_shared_secret  =3D cmh_ecdh_compute_shared_secret,
+               .max_size               =3D cmh_ecdh_max_size,
+               .init                   =3D cmh_ecdh_p256_init,
+               .exit                   =3D cmh_ecdh_exit,
+               .base =3D {
+                       .cra_name         =3D "ecdh-nist-p256",
+                       .cra_driver_name  =3D "cri-cmh-ecdh-nist-p256",
+                       .cra_priority     =3D 300,
+                       .cra_flags        =3D CRYPTO_ALG_ASYNC,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_ecdh_tfm_ct=
x),
+               },
+       },
+       {
+               .set_secret             =3D cmh_ecdh_set_secret_nist,
+               .generate_public_key    =3D cmh_ecdh_generate_public_key,
+               .compute_shared_secret  =3D cmh_ecdh_compute_shared_secret,
+               .max_size               =3D cmh_ecdh_max_size,
+               .init                   =3D cmh_ecdh_p384_init,
+               .exit                   =3D cmh_ecdh_exit,
+               .base =3D {
+                       .cra_name         =3D "ecdh-nist-p384",
+                       .cra_driver_name  =3D "cri-cmh-ecdh-nist-p384",
+                       .cra_priority     =3D 300,
+                       .cra_flags        =3D CRYPTO_ALG_ASYNC,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_ecdh_tfm_ct=
x),
+               },
+       },
+       {
+               .set_secret             =3D cmh_ecdh_set_secret_x25519,
+               .generate_public_key    =3D cmh_ecdh_generate_public_key,
+               .compute_shared_secret  =3D cmh_ecdh_compute_shared_secret,
+               .max_size               =3D cmh_x25519_max_size,
+               .init                   =3D cmh_x25519_init,
+               .exit                   =3D cmh_ecdh_exit,
+               .base =3D {
+                       .cra_name         =3D "curve25519",
+                       .cra_driver_name  =3D "cri-cmh-curve25519",
+                       .cra_priority     =3D 300,
+                       .cra_flags        =3D CRYPTO_ALG_ASYNC,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_ecdh_tfm_ct=
x),
+               },
+       },
+};
+
+/**
+ * cmh_pke_ecdh_register() - Register ECDH kpp algorithms with the crypto =
framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_pke_ecdh_register(void)
+{
+       int ret, i;
+
+       for (i =3D 0; i < ARRAY_SIZE(cmh_ecdh_algs); i++) {
+               ret =3D crypto_register_kpp(&cmh_ecdh_algs[i]);
+               if (ret) {
+                       dev_err(cmh_dev(), "cmh: failed to register %s (%d)=
\n",
+                               cmh_ecdh_algs[i].base.cra_name, ret);
+                       goto err_unregister;
+               }
+       }
+
+       return 0;
+
+err_unregister:
+       while (i--)
+               crypto_unregister_kpp(&cmh_ecdh_algs[i]);
+       return ret;
+}
+
+/**
+ * cmh_pke_ecdh_unregister() - Unregister ECDH kpp algorithms from the cry=
pto framework
+ */
+void cmh_pke_ecdh_unregister(void)
+{
+       int i =3D ARRAY_SIZE(cmh_ecdh_algs);
+
+       while (i--)
+               crypto_unregister_kpp(&cmh_ecdh_algs[i]);
+}
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

