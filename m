Return-Path: <linux-api+bounces-6691-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c0lNOztnPWp+2ggAu9opvQ
	(envelope-from <linux-api+bounces-6691-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:36:59 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BE16C7DB2
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:36:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=oYA5tyZM;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6691-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6691-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E66030D94F1
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652B63EDE7E;
	Thu, 25 Jun 2026 17:34:20 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99503ED138;
	Thu, 25 Jun 2026 17:34:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408860; cv=fail; b=GK5/0opWkMLCtyRJZZjPGg/4JbrD4KkZjNlPQrPjpbCZ6Goa+CBfM5k78pAFwJ6pFsOwcUGIUfAEfALyLz5ahIjLeAjg5u7ES1O+9gljS3aXVz5dxtGbbcHyI9LMjcXs6kQeW5oRQAt3cPOafJ5JbRq0wtTwhKQaJuOJDkF/kv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408860; c=relaxed/simple;
	bh=UmHFhOHeYV5hnPD+EMle7g8JeBzApZCU+yJ2Ls8RxZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lT8Ly67K5ZYnH3XjNEumwbJ/ECCgI+0N2tUfPcHqJ+3ZzMrdnqyCCMZM3ROZBHecPMr5S0Fnner+dST7T2bReTsLKCwZygJU1G8TXPWDWuptVPw1uy8t9ZT12hXmY/vWt5ExlEBEbDtnqocdHukVrEHQ9ZHXS8QWL6SmpN6XpAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=oYA5tyZM; arc=fail smtp.client-ip=40.93.201.110
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAiAqQ7whctunc7ySmDFB+qFKUvLk7NTiK3ppL/jjiMsH/RW66ZjW+9uldfhGnOjoUI6ofg412tEqdbJ1NE1cV/uutaOqB/lJUE8wMyS5gBO5gWP17ouWpPB5yKF0/ECIT2XG9D6BnV67LLFVg0745sUWqNkH3VH6QFOvlxXLtjxOehODtccEcwAMNnzPPI+aAvISsd6YTbVZGOgGApR5mwhevhFcZc3Se1d/NnA8KnHTUsf7SEZ2QuPdOuRfmjZeygX4gZwBhFoP1GECXfEF62cPnB7fKXqC1UOhtGZrcJZPFzPtRhRpgfXoeobLG1LXWsSaRNV98iaJ9JXv70mpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfpoXOZdTs/2xcTF4Rta1wqOWocmIUwHAHfOL8nSRoY=;
 b=lZmQ4HYQA83huhG6BM+t8mj7GnL34iOExTFOX/J1H5O7Akcr6DzRnw2lG27HnTAcmFluWuY9YwDRrZVnTpxMQxfCG91Lp/fdo5klJZFKF5gSj66WPlyADU+GWXJgk7XUXmNa1wCi+LOqdMALYS7uqc4+f4bQ3j2cI1QzfZOeq/Ny8VdYWgpqqqTn1F7ctUQj3CLYWSuFuMV5SJ/o6ermO/11H4+FLxskk5MjaihEQFnGVmnCiIsOao1SN/L/GUVoNxecAlFRq58pfw0T8F9N7FkxKRBJNlG7yP3wzpk4ReXm53rr623X++VCDYZpMjc74F2HiRHglWWYVVQJrKrgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfpoXOZdTs/2xcTF4Rta1wqOWocmIUwHAHfOL8nSRoY=;
 b=oYA5tyZM0RSYXWKII0fkILad0PRpZxgciHVH5zYV9ShF9pxlTsvyW4/qWqLAptV8hTAHy35+GKUgVmnSC/Ak0W0UeA7b6CCDvEQZKrsSyOT2Oo5VmaVYgAi2C08MjnwzLnKMWIO4MPOfja4PM0spK9s4JQCCW/3Iw80QWfn8653EdVCo/knEXdJzHLMR+zx7EZ+qRJ4wLs7E5MTHhiywXrT2X10uBcY1/jikJrP6R9xtsP5jbOeylpwgjQJQhPLz7Ef9mbuQaaQ3hwJSxQhxcbpoXuyYQAlLqpSBmpDs4w1bJo/QKM2PeewIYyAlztvnInKzwr+Uloqbji6svebezQ==
Received: from BY5PR04CA0023.namprd04.prod.outlook.com (2603:10b6:a03:1d0::33)
 by BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 17:34:10 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::7d) by BY5PR04CA0023.outlook.office365.com
 (2603:10b6:a03:1d0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 17:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:09 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 418861801774;
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
Subject: [PATCH 13/19] crypto: cmh - add ECDSA/SM2 sig
Date: Thu, 25 Jun 2026 10:33:21 -0700
Message-ID: <20260625173328.1140487-14-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|BY5PR04MB6849:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: de16b095-886d-4771-c834-08ded2dff6f5
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|23010399003|376014|921020|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	JWDAYwwAZL8u2k2jRjNxTl4egenaksy27R8uYkaMpFU5w7E8C7Z51K/Aoo90s3aB3kzoZ9gik18jFIn3SYiXezHmKaF2Vq2L6BnAQxPkUi04z6UbNXcK0DoDQll03dNKK1yTmA6eY+U3JCgCsax57jMKz+LtZo+tU641XSbdrqtSr6btr0bK6x9oawYLxUk9VaqnkJTx880v0/slmc9gI9Vqwum2dPIfyrVt8/QKvKmV1zVp1yzEpj1fd8F7dhNUnRRoui8UeCFQuOpG0tPRXz66gwmIimpgqyhqZXi5pPfEd5qoodLw1cqfk7wRZ1Pv7e51yzS0sP6gUowx75VI65lSYj5I7gvjszqQ7ahVhVVWJgnNsqBSbg1bjLIuG3KreVHi+26xKBikReDBW1YjGKIBtmH/GseyCrBeXFalLAXT5S5EWds12dXhcTQKLuMDjLvXfeMdlp5KXPzHTDQVoMkSkcwCpZgWVmTOCAXRQPWjbk5BMLjbVbXBNJpl+r6/MgEW/biBfC+GjmRbkWJoViZICGOOz/X7wMd9qfHmZ+LN21pdQ3BzKkY1X20OMfb7mk9o/doEKEGrU2WWzc2G+XWls7bH1D3f83XH9MSjFX4MsPdoUbdbyhYpnBulDKAiZHwqaEHgWLB9Ei1xgec1qWDztci8kLlmfKkBJQEeRRBK120/2wil6GswNaXYsh0J2rUprNEZdhe9FdQOmRcVnJ2JB3GiPKwy29R4/ONOYpBKxCtS5Qjr4kkDVqZomaE7
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(23010399003)(376014)(921020)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Kc7AeOUMFQ5TbC0nMnwlQUfsbO3DcmNH3NERwrJuqH6b7n1WaUVhtj155w8lBvJrzGOimNcpRTILgT2JtIqEJmxtoZkFxu9jFWsmlQ+UGncEH3YwuxbfztaI/cd00If8aNsbxlZdr9gIVe6cS+s8VmpVhfGcFWXNEssLAQ4pJUoIgWhfL9nGNg9box3ssCS+Q4elQLMAXGDhPZnJ5m7Xdwps17LDJG5iAVGjd4O43S3bPNPprJJ0c/2+LPECwEjVmuO2kCFrUmpcThe8letevobfmwlkMqtm9PzD3zWO+gQnDqdl2REze/OaT8aLYMHzNuu7bcFCf0JhC+sOQej6Ks3wV2J4PuwMTTh446JNx0kZFevXSePq9Sj1qOQqmxLAB+XUdEp3eltjIVmWQSYjuPpW1f63bTR/LhnoSdjBomRtX0dee+HoztBYea6sVqJy
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:09.4899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de16b095-886d-4771-c834-08ded2dff6f5
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6849
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
	TAGGED_FROM(0.00)[bounces-6691-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 84BE16C7DB2

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ECDSA and SM2 sig algorithms using the CMH PKE core.
Supports P-256, P-384, P-521, and SM2 curves for sign and verify
operations.  SM2 is registered as verify-only via the crypto API;
full SM2 operations (encrypt, decrypt, key exchange) are available
through the /dev/cmh_mgmt ioctl interface.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile        |   3 +-
 drivers/crypto/cmh/cmh_main.c      |   8 +
 drivers/crypto/cmh/cmh_pke_ecdsa.c | 575 +++++++++++++++++++++++++++++
 3 files changed, 585 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_pke_ecdsa.c

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 7afd9852c337..fdbf66b13628 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -31,7 +31,8 @@ cmh-y :=3D \
        cmh_ccp_poly.o \
        cmh_rng.o \
        cmh_pke_common.o \
-       cmh_pke_rsa.o
+       cmh_pke_rsa.o \
+       cmh_pke_ecdsa.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 8535453342d7..939ff5007755 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -281,6 +281,11 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_pke_rsa_register;

+       /* Register PKE ECDSA/SM2 sig */
+       ret =3D cmh_pke_ecdsa_register();
+       if (ret)
+               goto err_pke_ecdsa_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -293,6 +298,8 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_pke_ecdsa_unregister();
+err_pke_ecdsa_register:
        cmh_pke_rsa_unregister();
 err_pke_rsa_register:
        cmh_ccp_poly_unregister();
@@ -351,6 +358,7 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_pke_ecdsa_unregister();
        cmh_pke_rsa_unregister();
        cmh_ccp_poly_unregister();
        cmh_ccp_aead_unregister();
diff --git a/drivers/crypto/cmh/cmh_pke_ecdsa.c b/drivers/crypto/cmh/cmh_pk=
e_ecdsa.c
new file mode 100644
index 000000000000..6b65f7fb72cc
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pke_ecdsa.c
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- ECDSA / SM2 Signature Driver (sig_alg, synchronous)
+ *
+ * Registers "ecdsa-nist-p256", "ecdsa-nist-p384", and "ecdsa-nist-p521"
+ * sig algorithms with sign, verify, set_pub_key, and set_priv_key callbac=
ks.
+ * Registers "sm2" as verify-only (set_pub_key + verify); SM2 sign is
+ * provided via the cmh_mgmt ioctl path in cmh_pke_sm2.c.
+ *
+ * In-kernel consumers typically use verify-only (module signatures, IMA),
+ * but we provide sign as well for completeness -- matching the CMH eSW
+ * capability.
+ *
+ * Key format: Public key =3D raw 04 || X || Y (uncompressed).
+ * Signature format: struct ecdsa_raw_sig (two u64[ECC_MAX_DIGITS] arrays
+ * in VLI format -- native byte order, LE digit order) for both sign
+ * output and verify input.  This matches the kernel crypto sig API.
+ *
+ * Private key via cmh_key_ctx: raw keys written via SYS_REF_TEMP.
+ * Datastore-referenced keys are only reachable through the ioctl
+ * path (cmh_mgmt.c).
+ *
+ * SM2 note: The SM2 sig entry is verify-only (no sign/set_priv_key).
+ * SM2 signature verification requires the digest to be SM3(ZA || M)
+ * where ZA =3D SM3(ENTLA || IDA || a || b || xG || yG || xA || yA).
+ * The ZA identity pre-hash is the caller's responsibility; the driver
+ * passes the digest directly to the CMH eSW SM2 verify engine.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <crypto/sha2.h>
+#include <crypto/sig.h>
+#include <crypto/internal/sig.h>
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
+ * Number of ECC digits needed for a given coordinate byte length.
+ * P-256: 4, P-384: 6, P-521/SM2(clen=3D68): 9.
+ */
+static inline unsigned int clen_to_ndigits(u32 clen)
+{
+       return DIV_ROUND_UP(clen, sizeof(u64));
+}
+
+struct cmh_ecdsa_tfm_ctx {
+       struct cmh_key_ctx key;         /* private key (raw only) */
+       u8 *pub_key;                    /* uncompressed (x, y) without 04 p=
refix */
+       u32 pub_key_len;
+       u32 curve;                      /* PKE_CURVE_* */
+       u32 clen;                       /* coordinate length in bytes */
+};
+
+static inline struct cmh_ecdsa_tfm_ctx *cmh_ecdsa_ctx(struct crypto_sig *t=
fm)
+{
+       return crypto_sig_ctx(tfm);
+}
+
+/*
+ * Convert one VLI component (u64 array, LE digit order, native byte order=
)
+ * to big-endian byte array of @out_len bytes.  The VLI value is right-ali=
gned
+ * in the output (leading zero bytes if ndigits*8 > out_len are discarded;
+ * leading zero padding added if ndigits*8 < out_len).
+ */
+static void ecdsa_vli_to_be(const u64 *vli, unsigned int ndigits,
+                           u8 *out, unsigned int out_len)
+{
+       unsigned int full_len =3D ndigits * sizeof(u64);
+       unsigned int i, skip;
+
+       memset(out, 0, out_len);
+
+       if (full_len <=3D out_len) {
+               /* VLI fits entirely -- write at right end of out */
+               u8 *dst =3D out + (out_len - full_len);
+
+               for (i =3D 0; i < ndigits; i++)
+                       put_unaligned_be64(vli[ndigits - 1 - i],
+                                          &dst[i * sizeof(u64)]);
+       } else {
+               /* VLI wider than out -- skip leading (zero) bytes */
+               u8 tmp[ECC_MAX_BYTES];
+
+               for (i =3D 0; i < ndigits; i++)
+                       put_unaligned_be64(vli[ndigits - 1 - i],
+                                          &tmp[i * sizeof(u64)]);
+               skip =3D full_len - out_len;
+               WARN_ON_ONCE(memchr_inv(tmp, 0, skip));
+               memcpy(out, tmp + skip, out_len);
+       }
+}
+
+/*
+ * Convert big-endian byte array to VLI (u64 array, LE digit order).
+ * Output is zero-filled to @max_digits entries.
+ */
+static void ecdsa_be_to_vli(const u8 *in, unsigned int in_len,
+                           u64 *vli, unsigned int max_digits)
+{
+       unsigned int full_len =3D max_digits * sizeof(u64);
+       u8 tmp[ECC_MAX_BYTES];
+       unsigned int i;
+
+       if (WARN_ON_ONCE(max_digits > ECC_MAX_DIGITS))
+               max_digits =3D ECC_MAX_DIGITS;
+
+       memset(tmp, 0, full_len);
+       if (in_len <=3D full_len)
+               memcpy(tmp + (full_len - in_len), in, in_len);
+       else
+               memcpy(tmp, in + (in_len - full_len), full_len);
+
+       for (i =3D 0; i < max_digits; i++) {
+               unsigned int off =3D (max_digits - 1 - i) * sizeof(u64);
+
+               vli[i] =3D get_unaligned_be64(&tmp[off]);
+       }
+}
+
+/*
+ * Extract raw (r || s) big-endian byte arrays from struct ecdsa_raw_sig.
+ * Each component is written as @clen bytes into @raw_rs.
+ */
+static int ecdsa_sig_to_raw(const void *src, unsigned int slen,
+                           u8 *raw_rs, u32 clen)
+{
+       const struct ecdsa_raw_sig *sig =3D src;
+       unsigned int ndigits =3D clen_to_ndigits(clen);
+
+       if (slen !=3D sizeof(struct ecdsa_raw_sig))
+               return -EINVAL;
+
+       ecdsa_vli_to_be(sig->r, ndigits, raw_rs, clen);
+       ecdsa_vli_to_be(sig->s, ndigits, raw_rs + clen, clen);
+       return 0;
+}
+
+/*
+ * Encode raw (r || s) big-endian byte arrays into struct ecdsa_raw_sig.
+ * Returns sizeof(struct ecdsa_raw_sig) on success.
+ */
+static int ecdsa_raw_to_sig(const u8 *raw_rs, u32 clen,
+                           void *dst, unsigned int dlen)
+{
+       struct ecdsa_raw_sig *sig =3D dst;
+
+       if (dlen < sizeof(struct ecdsa_raw_sig))
+               return -ENOSPC;
+
+       memset(sig, 0, sizeof(*sig));
+       ecdsa_be_to_vli(raw_rs, clen, sig->r, ECC_MAX_DIGITS);
+       ecdsa_be_to_vli(raw_rs + clen, clen, sig->s, ECC_MAX_DIGITS);
+       return sizeof(struct ecdsa_raw_sig);
+}
+
+/*
+ * ECDSA verify (synchronous sig_alg)
+ *
+ * @src:    struct ecdsa_raw_sig (VLI format)
+ * @slen:   signature length (must be sizeof(struct ecdsa_raw_sig))
+ * @digest: hash digest
+ * @dlen:   digest length
+ *
+ * Returns 0 on successful verification, negative errno on failure.
+ */
+static int cmh_ecdsa_verify(struct crypto_sig *tfm,
+                           const void *src, unsigned int slen,
+                           const void *digest, unsigned int dlen)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+       u32 clen =3D ctx->clen;
+       u32 sig_raw_len =3D 2 * clen;
+       u32 copy_len =3D min_t(u32, dlen, clen);
+       struct core_dispatch d =3D cmh_core_select_instance(CMH_CORE_PKE);
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MIN];
+       u8 *sig_raw =3D NULL, *dig_buf =3D NULL, *pk_buf =3D NULL, *rp_buf =
=3D NULL;
+       dma_addr_t pk_dma, dig_dma, sig_dma, rp_dma;
+       int ret;
+
+       if (!ctx->pub_key)
+               return -EINVAL;
+
+       sig_raw =3D kzalloc(sig_raw_len, GFP_KERNEL);
+       dig_buf =3D kzalloc(clen, GFP_KERNEL);
+       pk_buf =3D kmemdup(ctx->pub_key, ctx->pub_key_len, GFP_KERNEL);
+       rp_buf =3D kzalloc(clen, GFP_KERNEL);
+       if (!sig_raw || !dig_buf || !pk_buf || !rp_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       /* Extract raw (r, s) big-endian from VLI signature */
+       ret =3D ecdsa_sig_to_raw(src, slen, sig_raw, clen);
+       if (ret)
+               goto out_free;
+
+       /*
+        * Truncate or zero-pad digest to clen bytes, right-aligned.
+        * Matches ECDSA bits2int: use leftmost min(dlen, clen) bytes,
+        * zero-pad on the left when dlen < clen.
+        */
+       memcpy(dig_buf + (clen - copy_len), digest, copy_len);
+
+       pk_dma =3D cmh_dma_map_single(pk_buf, ctx->pub_key_len, DMA_TO_DEVI=
CE);
+       dig_dma =3D cmh_dma_map_single(dig_buf, clen, DMA_TO_DEVICE);
+       sig_dma =3D cmh_dma_map_single(sig_raw, sig_raw_len, DMA_TO_DEVICE)=
;
+       rp_dma =3D cmh_dma_map_single(rp_buf, clen, DMA_FROM_DEVICE);
+
+       if (cmh_dma_map_error(pk_dma) || cmh_dma_map_error(dig_dma) ||
+           cmh_dma_map_error(sig_dma) || cmh_dma_map_error(rp_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], PKE_VCQ_CMDS_MIN);
+       vcq_add_pke_ecdsa_verify(&vcq[1], d.core_id, ctx->curve, clen,
+                                pk_dma, dig_dma, sig_dma, rp_dma,
+                                pke_swap_flags(ctx->curve));
+       vcq_add_pke_flush(&vcq[2], d.core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, PKE_VCQ_CMDS_MIN, 1, d.mbx_idx)=
;
+
+out_unmap:
+       if (!cmh_dma_map_error(rp_dma))
+               cmh_dma_unmap_single(rp_dma, clen, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_raw_len, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(dig_dma))
+               cmh_dma_unmap_single(dig_dma, clen, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(pk_dma))
+               cmh_dma_unmap_single(pk_dma, ctx->pub_key_len, DMA_TO_DEVIC=
E);
+
+out_free:
+       kfree(rp_buf);
+       kfree(pk_buf);
+       kfree(sig_raw);
+       kfree(dig_buf);
+       return ret;
+}
+
+/*
+ * ECDSA sign (synchronous sig_alg)
+ *
+ * @src:  hash digest
+ * @slen: digest length
+ * @dst:  output buffer for struct ecdsa_raw_sig (VLI format)
+ * @dlen: output buffer length
+ *
+ * Returns sizeof(struct ecdsa_raw_sig) on success, negative errno on fail=
ure.
+ */
+static int cmh_ecdsa_sign(struct crypto_sig *tfm,
+                         const void *src, unsigned int slen,
+                         void *dst, unsigned int dlen)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+       u32 clen =3D ctx->clen;
+       u32 sig_raw_len =3D 2 * clen;
+       u32 copy_len =3D min_t(u32, slen, clen);
+       struct core_dispatch dd;
+       struct vcq_cmd vcq[PKE_VCQ_CMDS_MAX];
+       u8 *dig_buf =3D NULL, *sig_buf =3D NULL, *sk_buf =3D NULL;
+       dma_addr_t dig_dma, sig_dma, sk_dma;
+       int ret, idx;
+
+       if (ctx->key.mode !=3D CMH_KEY_RAW)
+               return -EINVAL;
+       if (dlen < sizeof(struct ecdsa_raw_sig))
+               return -EINVAL;
+
+       dig_buf =3D kzalloc(clen, GFP_KERNEL);
+       sig_buf =3D kzalloc(sig_raw_len, GFP_KERNEL);
+       sk_buf =3D kmemdup(ctx->key.raw.data, ctx->key.raw.len, GFP_KERNEL)=
;
+       if (!dig_buf || !sig_buf || !sk_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       /*
+        * Truncate or zero-pad digest to clen bytes, right-aligned.
+        * Matches ECDSA bits2int: use leftmost min(slen, clen) bytes,
+        * zero-pad on the left when slen < clen.
+        */
+       memcpy(dig_buf + (clen - copy_len), src, copy_len);
+
+       dig_dma =3D cmh_dma_map_single(dig_buf, clen, DMA_TO_DEVICE);
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_raw_len, DMA_FROM_DEVIC=
E);
+       sk_dma =3D cmh_dma_map_single(sk_buf, ctx->key.raw.len, DMA_TO_DEVI=
CE);
+
+       if (cmh_dma_map_error(dig_dma) || cmh_dma_map_error(sig_dma) ||
+           cmh_dma_map_error(sk_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       dd =3D cmh_core_select_instance(CMH_CORE_PKE);
+
+       idx =3D 1;
+       vcq_add_sys_write(&vcq[idx], SYS_REF_TEMP, sk_dma,
+                         SYS_REF_NONE, ctx->key.raw.len,
+                         ctx->key.raw.sys_type);
+       vcq[idx].id |=3D pke_swap_flags(ctx->curve);
+       idx++;
+       vcq_add_pke_ecdsa_sign(&vcq[idx++], dd.core_id, ctx->curve, clen,
+                              dig_dma, sig_dma, SYS_REF_TEMP,
+                              clen, pke_swap_flags(ctx->curve));
+       vcq_add_pke_flush(&vcq[idx++], dd.core_id);
+       vcq_set_header(&vcq[0], idx);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, idx, 1, dd.mbx_idx);
+       if (!ret) {
+               /* Sync bounce buffer so CPU sees the DMA-written signature=
 */
+               cmh_dma_sync_for_cpu(sig_dma, sig_raw_len, DMA_FROM_DEVICE)=
;
+
+               /* Encode raw (r||s) into VLI ecdsa_raw_sig for kernel API =
*/
+               ret =3D ecdsa_raw_to_sig(sig_buf, clen, dst, dlen);
+       }
+
+out_unmap:
+       if (!cmh_dma_map_error(sk_dma))
+               cmh_dma_unmap_single(sk_dma, ctx->key.raw.len, DMA_TO_DEVIC=
E);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_raw_len, DMA_FROM_DEVICE)=
;
+       if (!cmh_dma_map_error(dig_dma))
+               cmh_dma_unmap_single(dig_dma, clen, DMA_TO_DEVICE);
+
+out_free:
+       kfree_sensitive(sk_buf);
+       kfree(sig_buf);
+       kfree(dig_buf);
+       return ret;
+}
+
+static int cmh_ecdsa_set_pub_key(struct crypto_sig *tfm,
+                                const void *key, unsigned int keylen)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+       const u8 *d =3D key;
+       u32 clen =3D ctx->clen;
+       u32 raw_clen;
+
+       /* Accept 04 || X || Y (uncompressed point) */
+       if (keylen < 1 || d[0] !=3D 0x04)
+               return -EINVAL;
+       d++;
+       keylen--;
+
+       if (keylen & 1)
+               return -EINVAL;
+       raw_clen =3D keylen / 2;
+
+       /*
+        * Kernel passes ceil(bits/8) per coordinate (e.g. 66 for P-521),
+        * but our HW ABI uses clen (ALIGN(66,4)=3D68 for P-521).
+        * Accept raw_clen <=3D clen and zero-pad on the left.
+        */
+       if (raw_clen > clen || raw_clen =3D=3D 0)
+               return -EINVAL;
+
+       kfree(ctx->pub_key);
+       ctx->pub_key =3D NULL;
+       ctx->pub_key_len =3D 0;
+
+       ctx->pub_key =3D kzalloc(2 * clen, GFP_KERNEL);
+       if (!ctx->pub_key)
+               return -ENOMEM;
+
+       /* Right-align each coordinate to clen bytes */
+       memcpy(ctx->pub_key + (clen - raw_clen), d, raw_clen);
+       memcpy(ctx->pub_key + clen + (clen - raw_clen), d + raw_clen,
+              raw_clen);
+       ctx->pub_key_len =3D 2 * clen;
+       return 0;
+}
+
+static int cmh_ecdsa_set_priv_key(struct crypto_sig *tfm,
+                                 const void *key, unsigned int keylen)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+
+       if (keylen !=3D ctx->clen)
+               return -EINVAL;
+
+       return cmh_key_setkey_raw(&ctx->key, key, keylen, CORE_ID_PKE);
+}
+
+static unsigned int cmh_ecdsa_key_size(struct crypto_sig *tfm)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+
+       /* crypto_sig_keysize() returns bits, not bytes */
+       return pke_curve_bits(ctx->curve);
+}
+
+static unsigned int cmh_ecdsa_max_size(struct crypto_sig *tfm)
+{
+       return sizeof(struct ecdsa_raw_sig);
+}
+
+static unsigned int cmh_ecdsa_digest_size(struct crypto_sig *tfm)
+{
+       /*
+        * Accept digests up to SHA-512 (64 bytes).  Digests longer
+        * than the curve order are truncated per ECDSA bits2int.
+        * Matches kernel ecdsa_digest_size().
+        */
+       return SHA512_DIGEST_SIZE;
+}
+
+static int cmh_ecdsa_p256_init(struct crypto_sig *tfm)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->curve =3D PKE_CURVE_P256;
+       ctx->clen =3D pke_curve_clen(PKE_CURVE_P256);
+       return 0;
+}
+
+static int cmh_ecdsa_p384_init(struct crypto_sig *tfm)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->curve =3D PKE_CURVE_P384;
+       ctx->clen =3D pke_curve_clen(PKE_CURVE_P384);
+       return 0;
+}
+
+static int cmh_ecdsa_p521_init(struct crypto_sig *tfm)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->curve =3D PKE_CURVE_P521;
+       ctx->clen =3D pke_curve_clen(PKE_CURVE_P521);
+       return 0;
+}
+
+static int cmh_sm2_init(struct crypto_sig *tfm)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->curve =3D PKE_CURVE_SM2;
+       ctx->clen =3D pke_curve_clen(PKE_CURVE_SM2);
+       return 0;
+}
+
+static void cmh_ecdsa_exit(struct crypto_sig *tfm)
+{
+       struct cmh_ecdsa_tfm_ctx *ctx =3D cmh_ecdsa_ctx(tfm);
+
+       cmh_key_destroy(&ctx->key);
+       kfree(ctx->pub_key);
+       ctx->pub_key =3D NULL;
+}
+
+static struct sig_alg cmh_ecdsa_algs[] =3D {
+       {
+               .sign           =3D cmh_ecdsa_sign,
+               .verify         =3D cmh_ecdsa_verify,
+               .set_pub_key    =3D cmh_ecdsa_set_pub_key,
+               .set_priv_key   =3D cmh_ecdsa_set_priv_key,
+               .key_size       =3D cmh_ecdsa_key_size,
+               .max_size       =3D cmh_ecdsa_max_size,
+               .digest_size    =3D cmh_ecdsa_digest_size,
+               .init           =3D cmh_ecdsa_p256_init,
+               .exit           =3D cmh_ecdsa_exit,
+               .base =3D {
+                       .cra_name         =3D "ecdsa-nist-p256",
+                       .cra_driver_name  =3D "cri-cmh-ecdsa-nist-p256",
+                       .cra_priority     =3D 300,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_ecdsa_tfm_c=
tx),
+               },
+       },
+       {
+               .sign           =3D cmh_ecdsa_sign,
+               .verify         =3D cmh_ecdsa_verify,
+               .set_pub_key    =3D cmh_ecdsa_set_pub_key,
+               .set_priv_key   =3D cmh_ecdsa_set_priv_key,
+               .key_size       =3D cmh_ecdsa_key_size,
+               .max_size       =3D cmh_ecdsa_max_size,
+               .digest_size    =3D cmh_ecdsa_digest_size,
+               .init           =3D cmh_ecdsa_p384_init,
+               .exit           =3D cmh_ecdsa_exit,
+               .base =3D {
+                       .cra_name         =3D "ecdsa-nist-p384",
+                       .cra_driver_name  =3D "cri-cmh-ecdsa-nist-p384",
+                       .cra_priority     =3D 300,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_ecdsa_tfm_c=
tx),
+               },
+       },
+       {
+               .sign           =3D cmh_ecdsa_sign,
+               .verify         =3D cmh_ecdsa_verify,
+               .set_pub_key    =3D cmh_ecdsa_set_pub_key,
+               .set_priv_key   =3D cmh_ecdsa_set_priv_key,
+               .key_size       =3D cmh_ecdsa_key_size,
+               .max_size       =3D cmh_ecdsa_max_size,
+               .digest_size    =3D cmh_ecdsa_digest_size,
+               .init           =3D cmh_ecdsa_p521_init,
+               .exit           =3D cmh_ecdsa_exit,
+               .base =3D {
+                       .cra_name         =3D "ecdsa-nist-p521",
+                       .cra_driver_name  =3D "cri-cmh-ecdsa-nist-p521",
+                       .cra_priority     =3D 300,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_ecdsa_tfm_c=
tx),
+               },
+       },
+       {
+               .verify         =3D cmh_ecdsa_verify,
+               .set_pub_key    =3D cmh_ecdsa_set_pub_key,
+               .key_size       =3D cmh_ecdsa_key_size,
+               .max_size       =3D cmh_ecdsa_max_size,
+               .digest_size    =3D cmh_ecdsa_digest_size,
+               .init           =3D cmh_sm2_init,
+               .exit           =3D cmh_ecdsa_exit,
+               .base =3D {
+                       .cra_name         =3D "sm2",
+                       .cra_driver_name  =3D "cri-cmh-sm2",
+                       .cra_priority     =3D 300,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_ecdsa_tfm_c=
tx),
+               },
+       },
+};
+
+/**
+ * cmh_pke_ecdsa_register() - Register ECDSA/SM2 sig algorithms with the c=
rypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_pke_ecdsa_register(void)
+{
+       int ret, i;
+
+       for (i =3D 0; i < ARRAY_SIZE(cmh_ecdsa_algs); i++) {
+               ret =3D crypto_register_sig(&cmh_ecdsa_algs[i]);
+               if (ret) {
+                       dev_err(cmh_dev(), "cmh: failed to register %s (%d)=
\n",
+                               cmh_ecdsa_algs[i].base.cra_name, ret);
+                       goto err_unregister;
+               }
+       }
+
+       return 0;
+
+err_unregister:
+       while (i--)
+               crypto_unregister_sig(&cmh_ecdsa_algs[i]);
+       return ret;
+}
+
+/**
+ * cmh_pke_ecdsa_unregister() - Unregister ECDSA/SM2 sig algorithms from t=
he crypto framework
+ */
+void cmh_pke_ecdsa_unregister(void)
+{
+       int i =3D ARRAY_SIZE(cmh_ecdsa_algs);
+
+       while (i--)
+               crypto_unregister_sig(&cmh_ecdsa_algs[i]);
+}
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

