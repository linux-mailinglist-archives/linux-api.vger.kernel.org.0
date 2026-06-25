Return-Path: <linux-api+bounces-6697-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eBK0K/VnPWrL2ggAu9opvQ
	(envelope-from <linux-api+bounces-6697-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:40:05 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEEE6C7E8F
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:40:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=ztYLflYR;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6697-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6697-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E387C31382BE
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98703EFFAE;
	Thu, 25 Jun 2026 17:34:24 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022095.outbound.protection.outlook.com [40.107.200.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0D3EDAD6;
	Thu, 25 Jun 2026 17:34:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408864; cv=fail; b=CVg+KY1Y1WtNwxfp0hO3Ahp3+KvywSbRM45OiXyrkWQle3hqQuDYI9MZMsJiINorsJ8eKX1VA/OgvKR16lG741wbCZCZPlEBhDOwuvbS6R1RyabMdH6Mh9YKh+ZCGW234k/g0SW6EvYFMh3ryY+S93YLM1JsPucnekF+PhR0sjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408864; c=relaxed/simple;
	bh=3qyQFOzB9HDWgy7ej1/4JwnQvepFstqU0JbhMdCSZQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nUxmg6ePUPTQllbcosrX2NwPh+h4P5eIv0wZ4z33wmPmI72xktSYpPmb/MAwLEVC8+3uzuR3ULN/gdg4/mCpmvuiOA4yNrd6H0Nn48HxYANyg3un4c2d1MGkux3H+r8/YrcH267MMPBAHsktO9JlJNijiSSA3Q00/KkHCdWip6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=ztYLflYR; arc=fail smtp.client-ip=40.107.200.95
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lwD0miTsd0hYdJdTwJ/PsOntsFfS7w1TFl49I2Ep1E1A9qK7FJsMta/CTsHTy8d3q7Yaz0wSuyaH8J5EZsI/GDeB+bmfxzBZ5RWryEiNfe86Nfa1Ff6WKlMoyvL0gzMEl1CkL9iN6BkooHqU5pAPr6ZieDD6GT4/sjIvpZRD6BNcNHY5Xp4VU2LjIs1Jzr/Qav3eE6aAr/FKrX1Hn2ELFujziP99JMC4n/xvw0wb+vRIXAgW8JajNokZxnTJEbQeoa1R910m+JTKnvy3v67Tkta9Dunc69P26zTXxufdQ8YbPdm05jPd5x6pQxspSOFzb0oB0+vw8vVm7eN1EqcMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQykzepDbLpRld41bZN4489msDX72HRv9Cp2fWH0g4c=;
 b=UiWk36P7q9AkJe8CdsLnZncVc0d+5AwudjmL/h0L7BfBxk7//5YnZR4j+jm8cQ4RJnYOjWkLXcmMvzGxmOFbXAXQLsW+6rOR1Cgd5rBNKYW4G3Z3d3np0KPfXVlsTzTceakqinB39sGant4ePbaPjJMq0q3BzuBD67CsZEp04sKTw0s207Fc/VZ3SnRPa7nP9haZHR2VYHFLF9T/4AFwYXyKsEupy6Z8X21a8kbsD1faAXRJqQoH35vQFapcPRgeDDpMsQna/WZRIMWX/5wPUq9B/zNWLqkD8SWB0b+js8P0mVMcsWnJq/6xr6TG2i1M0kenoAOvsmhLiAr7nWY66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQykzepDbLpRld41bZN4489msDX72HRv9Cp2fWH0g4c=;
 b=ztYLflYRGoclBYEd30dv2O8TURc3FUR62/r5pvj81t03HCsjNwMNzF9zR2fdINEoRmIogP2w/CJYYNP2zDsBZxywoVHo3YuxaSdvQ4xf87W7Uk48aaD6ZqmzYFrrI5M15WZ1U6s1YkXaDDImYKkb8Q9mDkAQDLuVQ9wJHY7nDoqJH4q6fJQA3TGb9WrAF+iKJs2AfAE2EQDtRZCW4p3vB3EMHzck982OpydJm/V6bDMegYZACi1qIq+Hb9NQ8pp0bIwHl1Z7dIXSqt/o3O6e2//hNIcYYCdYQ0q5+zfA3Oy9qcIqcGzn4i/WWiIPy+OBKw5hQq9M0b+fsVrUetQbEw==
Received: from SN7PR04CA0178.namprd04.prod.outlook.com (2603:10b6:806:125::33)
 by BY5PR04MB6802.namprd04.prod.outlook.com (2603:10b6:a03:22d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Thu, 25 Jun
 2026 17:34:10 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::41) by SN7PR04CA0178.outlook.office365.com
 (2603:10b6:806:125::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 17:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:09 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 69573180177B;
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
Subject: [PATCH 15/19] crypto: cmh - add ML-KEM/ML-DSA (QSE)
Date: Thu, 25 Jun 2026 10:33:23 -0700
Message-ID: <20260625173328.1140487-16-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|BY5PR04MB6802:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 27e17554-2e78-4cf3-722e-08ded2dff742
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|921020|18002099003|22082099003|56012099006|6133799003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	kJzfZoN3lbUwX3vJqm4iNYISzQT7ccWAUfVWbxCfATtLWyEDzC6BSiwlqJzxj+LSrYyHvbOZrFZTurSP35Fm4jN73r0E6FbzGgc+gMYjWb/zTxoIkVL0n090V/lQx8GikmIkU2M4nFkGwK2LyXL3QStSETima7HOHnDdLJBWCTvpV54hG+x7X/pBRxSVoYCLruyYa8Cwr2lFwNWQT49q1uu3Hp5x4xmbuDyFketjU86Zi4GQxcOJ84Mv4kLumbHfVjx4NXSIR9XWcU1ys8zSIgc4mfbc7+pwYqh3kK2hJ95/Ow5CB+UGV7ffDuj85tTgb5t6shQFR7toHXNlAuv8Y3F/a6vDFNQhfQ/dkUxv3LirDnga7KDbRqbRS8rP6WfiHaAj+z9I7EbXj+z86DTQHwJUUzd29OEDRjsdhIEwEla+qNL+umXzgvWMAQhZL5sSRhuap0mUU5mLX1bq0FAmx2D/6KATSU+kfnaS1PFFHOz9xx2xXzIOmLCUHjoqMfNQ1PMY44rh6Gdk6KEGUBRh5X/3BJ9D9QeHyDDTjjPDbEiUIOhCziBZoxlPEt7/hEb9SRST++ujM03JOGM4GsLjpf4hJ4bORjpAqQVHNX0vTiZrAGs5f0GvPrjGTxsNsV9HsDPwqdKvdxohJAz3u+iGflRHe2Wvzem6dI1tq3lDo5F0lHn5OX2b6gO+bCwAlESodUNjpmnI26XAlu/rw0GKRnV+ColqY7FTf0ilXAtAbdkMzC5esbrMcQGkWi8aKlKK
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(921020)(18002099003)(22082099003)(56012099006)(6133799003)(3023799007)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xCDrnj2GntPFmRNxak9IF6ZbTEP+EnkZIknCqnQ1m3FT+SwBN5emSomgZg8Szk9253WTk73wu8JhcBRjEteGJNi8Ro1S64kXzJjEZYZRacF5X/AIcFQHfoAePUEo9QbxVw7TePP/c0Dunp5R1Hsz//AZHiiY2O61tyTMkzodpLaJEjbCelRwYGrFfoLh+jDVFCyQMFEV0Ot3DNbCQVz4EZrqoczhG8ZSsh4hMh+Lb+YojYiu5ZIY+EblsQwIqs0qWRM/hm9mwEoIeO9esma1EyiJZ5awbqSCcjg5Yz2PYnfxeybHesCj90tmB2jFGtdPW7e4mxxOW+q+119DKvlZdbqr4drRbhsmaw4wzHfO4W08VWqIF4iAFW6sGHDQ+CRn2ZRM43e8n28MCdNoQgO9fA8966uw9daTqvCEbcI+FLB4NEsRoWwJeLBEwQ92ijfu
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:09.9370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e17554-2e78-4cf3-722e-08ded2dff742
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6802
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[rambus.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[rambus.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[skrishnamoorthy@rambus.com,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-6697-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3AEEE6C7E8F

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ML-KEM (Kyber) and ML-DSA (Dilithium) algorithms using
the CMH QSE core (core ID 0x09).  ML-KEM is ioctl-only (keygen,
encaps, decaps).  ML-DSA is registered as a sig algorithm with
priority 5001 to override the kernel's verify-only mldsa
implementation at priority 5000.  This follows the established
pattern where hardware drivers override software-only fallbacks
(e.g. ccp at 300 over generic AES at 100, qat similarly).  The
CMH driver provides full HW-accelerated sign + verify vs the
kernel's verify-only software implementation.

Includes cmh_pqc_sizes.c with compile-time tables of PQC key and
signature sizes for all supported parameter sets.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile        |   5 +-
 drivers/crypto/cmh/cmh_main.c      |   9 +
 drivers/crypto/cmh/cmh_pqc_mldsa.c | 394 +++++++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_pqc_sizes.c |  39 +++
 drivers/crypto/cmh/cmh_qse.c       | 211 +++++++++++++++
 5 files changed, 657 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_pqc_mldsa.c
 create mode 100644 drivers/crypto/cmh/cmh_pqc_sizes.c
 create mode 100644 drivers/crypto/cmh/cmh_qse.c

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index a4cea0a56fc1..3425eb65d653 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -33,7 +33,10 @@ cmh-y :=3D \
        cmh_pke_common.o \
        cmh_pke_rsa.o \
        cmh_pke_ecdsa.o \
-       cmh_pke_ecdh.o
+       cmh_pke_ecdh.o \
+       cmh_qse.o \
+       cmh_pqc_mldsa.o \
+       cmh_pqc_sizes.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index ea0f32b941f5..df38f43dc179 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -39,6 +39,7 @@
 #include "cmh_sm4.h"
 #include "cmh_ccp.h"
 #include "cmh_pke.h"
+#include "cmh_pqc.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -291,6 +292,11 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_pke_ecdh_register;

+       /* Register PQC ML-KEM/ML-DSA */
+       ret =3D cmh_pqc_mldsa_register();
+       if (ret)
+               goto err_pqc_mldsa_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -303,6 +309,8 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_pqc_mldsa_unregister();
+err_pqc_mldsa_register:
        cmh_pke_ecdh_unregister();
 err_pke_ecdh_register:
        cmh_pke_ecdsa_unregister();
@@ -365,6 +373,7 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_pqc_mldsa_unregister();
        cmh_pke_ecdh_unregister();
        cmh_pke_ecdsa_unregister();
        cmh_pke_rsa_unregister();
diff --git a/drivers/crypto/cmh/cmh_pqc_mldsa.c b/drivers/crypto/cmh/cmh_pq=
c_mldsa.c
new file mode 100644
index 000000000000..cbe63c34a1c8
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pqc_mldsa.c
@@ -0,0 +1,394 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- ML-DSA Signature Driver (sig_alg, synchronous)
+ *
+ * Registers "mldsa44", "mldsa65", "mldsa87" sig algorithms
+ * with sign, verify, set_pub_key, and set_priv_key callbacks.
+ *
+ * Key format:
+ *   Public key  =3D raw pk bytes (1312 / 1952 / 2592 bytes)
+ *   Private key =3D raw sk bytes (2560 / 4032 / 4896 bytes)
+ *
+ * Sign: src =3D message bytes (up to 10240 bytes), dst =3D raw signature
+ * Verify: src =3D raw signature, digest =3D message bytes
+ *
+ * Non-masked mode only for sig_alg API.
+ * Masked mode available through /dev/cmh_mgmt ioctl.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <crypto/sig.h>
+#include <crypto/internal/sig.h>
+
+#include "cmh_sys.h"
+#include "cmh_qse_abi.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+#include "cmh_key.h"
+#include "cmh_pqc.h"
+
+struct cmh_mldsa_tfm_ctx {
+       struct cmh_key_ctx key;         /* private key (raw only) */
+       u8 *pub_key;
+       u32 pub_key_len;
+       u32 mode;                       /* ML_DSA_MODE_44/65/87 */
+       int mode_idx;                   /* index into size tables */
+};
+
+static inline struct cmh_mldsa_tfm_ctx *cmh_mldsa_ctx(struct crypto_sig *t=
fm)
+{
+       return crypto_sig_ctx(tfm);
+}
+
+/*
+ * ML-DSA sign (synchronous sig_alg)
+ *
+ * @src:  message bytes
+ * @slen: message length
+ * @dst:  signature output buffer
+ * @dlen: output buffer length
+ *
+ * Returns signature length on success, negative errno on failure.
+ */
+static int cmh_mldsa_sign(struct crypto_sig *tfm,
+                         const void *src, unsigned int slen,
+                         void *dst, unsigned int dlen)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+       int mi =3D ctx->mode_idx;
+       u32 sig_size =3D ml_dsa_sig_size[mi];
+       u32 sk_size =3D ml_dsa_sk_size[mi];
+       struct vcq_cmd vcq[QSE_VCQ_CMDS_MIN];
+       struct core_dispatch dd;
+       u8 *m_buf =3D NULL, *sig_buf =3D NULL, *sk_buf =3D NULL;
+       dma_addr_t m_dma =3D DMA_MAPPING_ERROR;
+       dma_addr_t sig_dma =3D DMA_MAPPING_ERROR;
+       dma_addr_t sk_dma =3D DMA_MAPPING_ERROR;
+       int ret, idx;
+
+       if (ctx->key.mode !=3D CMH_KEY_RAW)
+               return -EINVAL;
+       if (dlen < sig_size)
+               return -EINVAL;
+       if (!slen || slen > ML_DSA_MAX_MLEN)
+               return -EINVAL;
+
+       m_buf =3D kmemdup(src, slen, GFP_KERNEL);
+       sig_buf =3D kzalloc(sig_size, GFP_KERNEL);
+       if (!m_buf || !sig_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       if (ctx->key.raw.len !=3D sk_size) {
+               ret =3D -EINVAL;
+               goto out_free;
+       }
+
+       sk_buf =3D kmemdup(ctx->key.raw.data, ctx->key.raw.len, GFP_KERNEL)=
;
+       if (!sk_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       m_dma =3D cmh_dma_map_single(m_buf, slen, DMA_TO_DEVICE);
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_size, DMA_FROM_DEVICE);
+       sk_dma =3D cmh_dma_map_single(sk_buf, sk_size, DMA_TO_DEVICE);
+
+       if (cmh_dma_map_error(m_dma) || cmh_dma_map_error(sig_dma) ||
+           cmh_dma_map_error(sk_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       dd =3D cmh_core_select_instance(CMH_CORE_QSE);
+
+       vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+       idx =3D 1;
+       vcq_add_qse_ml_dsa_sign(&vcq[idx++], dd.core_id, ctx->mode,
+                               QSE_FLAG_USE_RNG,
+                               0, m_dma, sk_dma, sig_dma, slen, false);
+       vcq_add_qse_flush(&vcq[idx++], dd.core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN, 1,
+                                    dd.mbx_idx);
+       if (!ret) {
+               /* Sync bounce buffer so CPU sees the DMA-written signature=
 */
+               cmh_dma_sync_for_cpu(sig_dma, sig_size, DMA_FROM_DEVICE);
+               memcpy(dst, sig_buf, sig_size);
+               ret =3D sig_size;
+       }
+
+out_unmap:
+       if (!cmh_dma_map_error(sk_dma))
+               cmh_dma_unmap_single(sk_dma, sk_size, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_size, DMA_FROM_DEVICE);
+       if (!cmh_dma_map_error(m_dma))
+               cmh_dma_unmap_single(m_dma, slen, DMA_TO_DEVICE);
+
+out_free:
+       kfree_sensitive(sk_buf);
+       kfree(sig_buf);
+       kfree(m_buf);
+       return ret;
+}
+
+/*
+ * ML-DSA verify (synchronous sig_alg)
+ *
+ * @src:    raw signature
+ * @slen:   signature length
+ * @digest: message bytes
+ * @dlen:   message length
+ *
+ * Returns 0 on successful verification, negative errno on failure.
+ */
+static int cmh_mldsa_verify(struct crypto_sig *tfm,
+                           const void *src, unsigned int slen,
+                           const void *digest, unsigned int dlen)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+       int mi =3D ctx->mode_idx;
+       u32 sig_size =3D ml_dsa_sig_size[mi];
+       u32 pk_size =3D ml_dsa_pk_size[mi];
+       struct core_dispatch d =3D cmh_core_select_instance(CMH_CORE_QSE);
+       struct vcq_cmd vcq[QSE_VCQ_CMDS_MIN];
+       u8 *sig_buf =3D NULL, *m_buf =3D NULL, *pk_buf =3D NULL;
+       dma_addr_t sig_dma =3D DMA_MAPPING_ERROR;
+       dma_addr_t m_dma =3D DMA_MAPPING_ERROR;
+       dma_addr_t pk_dma =3D DMA_MAPPING_ERROR;
+       int ret;
+
+       if (!ctx->pub_key)
+               return -EINVAL;
+       if (slen !=3D sig_size)
+               return -EINVAL;
+       if (!dlen || dlen > ML_DSA_MAX_MLEN)
+               return -EINVAL;
+
+       sig_buf =3D kmemdup(src, slen, GFP_KERNEL);
+       m_buf =3D kmemdup(digest, dlen, GFP_KERNEL);
+       pk_buf =3D kmemdup(ctx->pub_key, pk_size, GFP_KERNEL);
+       if (!sig_buf || !m_buf || !pk_buf) {
+               ret =3D -ENOMEM;
+               goto out_free;
+       }
+
+       sig_dma =3D cmh_dma_map_single(sig_buf, sig_size, DMA_TO_DEVICE);
+       m_dma =3D cmh_dma_map_single(m_buf, dlen, DMA_TO_DEVICE);
+       pk_dma =3D cmh_dma_map_single(pk_buf, pk_size, DMA_TO_DEVICE);
+
+       if (cmh_dma_map_error(sig_dma) || cmh_dma_map_error(m_dma) ||
+           cmh_dma_map_error(pk_dma)) {
+               ret =3D -ENOMEM;
+               goto out_unmap;
+       }
+
+       vcq_set_header(&vcq[0], QSE_VCQ_CMDS_MIN);
+       vcq_add_qse_ml_dsa_verify(&vcq[1], d.core_id, ctx->mode, 0,
+                                 m_dma, pk_dma, sig_dma, dlen);
+       vcq_add_qse_flush(&vcq[2], d.core_id);
+
+       ret =3D cmh_tm_submit_sync_mbx(vcq, QSE_VCQ_CMDS_MIN, 1, d.mbx_idx)=
;
+
+out_unmap:
+       if (!cmh_dma_map_error(pk_dma))
+               cmh_dma_unmap_single(pk_dma, pk_size, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(m_dma))
+               cmh_dma_unmap_single(m_dma, dlen, DMA_TO_DEVICE);
+       if (!cmh_dma_map_error(sig_dma))
+               cmh_dma_unmap_single(sig_dma, sig_size, DMA_TO_DEVICE);
+
+out_free:
+       kfree(pk_buf);
+       kfree(m_buf);
+       kfree(sig_buf);
+       return ret;
+}
+
+static int cmh_mldsa_set_pub_key(struct crypto_sig *tfm,
+                                const void *key, unsigned int keylen)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+       u32 expected =3D ml_dsa_pk_size[ctx->mode_idx];
+
+       if (keylen !=3D expected)
+               return -EINVAL;
+
+       kfree(ctx->pub_key);
+       ctx->pub_key =3D NULL;
+       ctx->pub_key_len =3D 0;
+
+       ctx->pub_key =3D kmemdup(key, keylen, GFP_KERNEL);
+       if (!ctx->pub_key)
+               return -ENOMEM;
+
+       ctx->pub_key_len =3D keylen;
+       return 0;
+}
+
+static int cmh_mldsa_set_priv_key(struct crypto_sig *tfm,
+                                 const void *key, unsigned int keylen)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+       u32 expected =3D ml_dsa_sk_size[ctx->mode_idx];
+
+       if (keylen !=3D expected)
+               return -EINVAL;
+
+       return cmh_key_setkey_raw(&ctx->key, key, keylen, CORE_ID_QSE);
+}
+
+static unsigned int cmh_mldsa_key_size(struct crypto_sig *tfm)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+
+       /* crypto_sig_keysize() returns bits, not bytes */
+       return ml_dsa_pk_size[ctx->mode_idx] * 8;
+}
+
+static unsigned int cmh_mldsa_max_size(struct crypto_sig *tfm)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+
+       return ml_dsa_sig_size[ctx->mode_idx];
+}
+
+static int cmh_mldsa_44_init(struct crypto_sig *tfm)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->mode =3D ML_DSA_MODE_44;
+       ctx->mode_idx =3D 0;
+       return 0;
+}
+
+static int cmh_mldsa_65_init(struct crypto_sig *tfm)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->mode =3D ML_DSA_MODE_65;
+       ctx->mode_idx =3D 1;
+       return 0;
+}
+
+static int cmh_mldsa_87_init(struct crypto_sig *tfm)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+
+       memset(ctx, 0, sizeof(*ctx));
+       ctx->mode =3D ML_DSA_MODE_87;
+       ctx->mode_idx =3D 2;
+       return 0;
+}
+
+static void cmh_mldsa_exit(struct crypto_sig *tfm)
+{
+       struct cmh_mldsa_tfm_ctx *ctx =3D cmh_mldsa_ctx(tfm);
+
+       cmh_key_destroy(&ctx->key);
+       kfree(ctx->pub_key);
+       ctx->pub_key =3D NULL;
+}
+
+/*
+ * Priority 5001: the kernel's software ML-DSA (crypto/mldsa.c) registers
+ * at priority 5000 but only implements verify -- sign returns -EOPNOTSUPP=
.
+ * We provide full HW-accelerated sign + verify, so we must override.
+ */
+static struct sig_alg cmh_mldsa_algs[] =3D {
+       {
+               .sign           =3D cmh_mldsa_sign,
+               .verify         =3D cmh_mldsa_verify,
+               .set_pub_key    =3D cmh_mldsa_set_pub_key,
+               .set_priv_key   =3D cmh_mldsa_set_priv_key,
+               .key_size       =3D cmh_mldsa_key_size,
+               .max_size       =3D cmh_mldsa_max_size,
+               .init           =3D cmh_mldsa_44_init,
+               .exit           =3D cmh_mldsa_exit,
+               .base =3D {
+                       .cra_name         =3D "mldsa44",
+                       .cra_driver_name  =3D "cri-cmh-mldsa44",
+                       .cra_priority     =3D 5001,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_mldsa_tfm_c=
tx),
+               },
+       },
+       {
+               .sign           =3D cmh_mldsa_sign,
+               .verify         =3D cmh_mldsa_verify,
+               .set_pub_key    =3D cmh_mldsa_set_pub_key,
+               .set_priv_key   =3D cmh_mldsa_set_priv_key,
+               .key_size       =3D cmh_mldsa_key_size,
+               .max_size       =3D cmh_mldsa_max_size,
+               .init           =3D cmh_mldsa_65_init,
+               .exit           =3D cmh_mldsa_exit,
+               .base =3D {
+                       .cra_name         =3D "mldsa65",
+                       .cra_driver_name  =3D "cri-cmh-mldsa65",
+                       .cra_priority     =3D 5001,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_mldsa_tfm_c=
tx),
+               },
+       },
+       {
+               .sign           =3D cmh_mldsa_sign,
+               .verify         =3D cmh_mldsa_verify,
+               .set_pub_key    =3D cmh_mldsa_set_pub_key,
+               .set_priv_key   =3D cmh_mldsa_set_priv_key,
+               .key_size       =3D cmh_mldsa_key_size,
+               .max_size       =3D cmh_mldsa_max_size,
+               .init           =3D cmh_mldsa_87_init,
+               .exit           =3D cmh_mldsa_exit,
+               .base =3D {
+                       .cra_name         =3D "mldsa87",
+                       .cra_driver_name  =3D "cri-cmh-mldsa87",
+                       .cra_priority     =3D 5001,
+                       .cra_module       =3D THIS_MODULE,
+                       .cra_ctxsize      =3D sizeof(struct cmh_mldsa_tfm_c=
tx),
+               },
+       },
+};
+
+/**
+ * cmh_pqc_mldsa_register() - Register ML-DSA akcipher algorithms with the=
 crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_pqc_mldsa_register(void)
+{
+       int ret, i;
+
+       for (i =3D 0; i < ARRAY_SIZE(cmh_mldsa_algs); i++) {
+               ret =3D crypto_register_sig(&cmh_mldsa_algs[i]);
+               if (ret) {
+                       dev_err(cmh_dev(), "cmh: failed to register %s (%d)=
\n",
+                               cmh_mldsa_algs[i].base.cra_name, ret);
+                       goto err_unregister;
+               }
+       }
+
+       return 0;
+
+err_unregister:
+       while (i--)
+               crypto_unregister_sig(&cmh_mldsa_algs[i]);
+       return ret;
+}
+
+/**
+ * cmh_pqc_mldsa_unregister() - Unregister ML-DSA akcipher algorithms from=
 the crypto framework
+ */
+void cmh_pqc_mldsa_unregister(void)
+{
+       int i =3D ARRAY_SIZE(cmh_mldsa_algs);
+
+       while (i--)
+               crypto_unregister_sig(&cmh_mldsa_algs[i]);
+}
diff --git a/drivers/crypto/cmh/cmh_pqc_sizes.c b/drivers/crypto/cmh/cmh_pq=
c_sizes.c
new file mode 100644
index 000000000000..39e3d56f4312
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_pqc_sizes.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- PQC Algorithm Size Tables
+ *
+ * Centralised ML-DSA and SLH-DSA parameter-size arrays.  Declared
+ * extern in cmh_qse_abi.h / cmh_hcq_abi.h, defined here once to
+ * avoid per-TU duplication.
+ */
+
+#include <linux/build_bug.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+#include "cmh_qse_abi.h"
+#include "cmh_hcq_abi.h"
+
+/* ML-DSA size tables (indexed by ml_dsa_mode_idx()) */
+const u32 ml_dsa_pk_size[3]  =3D { 1312U, 1952U, 2592U };
+const u32 ml_dsa_sk_size[3]  =3D { 2560U, 4032U, 4896U };
+const u32 ml_dsa_sk_size_masked[3] =3D { 3360U, 5472U, 6368U };
+const u32 ml_dsa_sig_size[3] =3D { 2420U, 3309U, 4627U };
+
+static_assert(ARRAY_SIZE(ml_dsa_pk_size) =3D=3D ARRAY_SIZE(ml_dsa_sk_size)=
);
+static_assert(ARRAY_SIZE(ml_dsa_pk_size) =3D=3D ARRAY_SIZE(ml_dsa_sk_size_=
masked));
+static_assert(ARRAY_SIZE(ml_dsa_pk_size) =3D=3D ARRAY_SIZE(ml_dsa_sig_size=
));
+
+/* SLH-DSA n-values and signature sizes (indexed by param_set - 1) */
+const u32 slhdsa_n[12] =3D {
+       16, 16, 24, 24, 32, 32,         /* SHAKE 128s/f, 192s/f, 256s/f */
+       16, 16, 24, 24, 32, 32,         /* SHA2 128s/f, 192s/f, 256s/f */
+};
+
+const u32 slhdsa_sig_size[12] =3D {
+       7856,  17088, 16224, 35664, 29792, 49856,       /* SHAKE */
+       7856,  17088, 16224, 35664, 29792, 49856,       /* SHA2 */
+};
+
+static_assert(ARRAY_SIZE(slhdsa_n) =3D=3D ARRAY_SIZE(slhdsa_sig_size));
diff --git a/drivers/crypto/cmh/cmh_qse.c b/drivers/crypto/cmh/cmh_qse.c
new file mode 100644
index 000000000000..257dc3ee29a8
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_qse.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- QSE Core VCQ Builders
+ *
+ * VCQ builder functions for ML-KEM and ML-DSA commands (plain and masked)=
.
+ * Each function populates a single vcq_cmd slot.  Callers assemble
+ * complete VCQs with header + command(s) + flush, then submit via
+ * cmh_tm_submit_sync().
+ */
+
+#include <linux/string.h>
+
+#include "cmh_sys.h"
+
+/* -- QSE flush -- */
+
+/**
+ * vcq_add_qse_flush() - Build a QSE flush VCQ command
+ * @slot: VCQ command slot to populate
+ * @core_id: Hardware core ID for dispatch
+ */
+void vcq_add_qse_flush(struct vcq_cmd *slot, u32 core_id)
+{
+       vcq_add_flush(slot, core_id);
+}
+
+/* -- ML-KEM -- */
+
+/**
+ * vcq_add_qse_ml_kem_keygen() - Build an ML-KEM key generation VCQ comman=
d
+ * @slot: VCQ command slot to populate
+ * @core_id: Hardware core ID for dispatch
+ * @k: ML-KEM security parameter (k =3D 2, 3, or 4)
+ * @flags: Command flags
+ * @seed: DMA address of seed input buffer
+ * @z: DMA address of implicit rejection value buffer
+ * @ek: DMA address of encapsulation key output buffer
+ * @dk: DMA address of decapsulation key output buffer
+ * @dk_type: Decapsulation key datastore type
+ * @masked: Use masked (side-channel protected) variant
+ */
+void vcq_add_qse_ml_kem_keygen(struct vcq_cmd *slot, u32 core_id, u32 k, u=
32 flags,
+                              u64 seed, u64 z, u64 ek, u64 dk, u32 dk_type=
,
+                              bool masked)
+{
+       u32 cmd_id =3D masked ? QSE_CMD_ML_KEM_KEYGEN_MASKED
+                           : QSE_CMD_ML_KEM_KEYGEN;
+
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, cmd_id);
+       slot->hwc.qse.cmd_ml_kem_keygen.k =3D k;
+       slot->hwc.qse.cmd_ml_kem_keygen.flags =3D flags;
+       slot->hwc.qse.cmd_ml_kem_keygen.seed =3D seed;
+       slot->hwc.qse.cmd_ml_kem_keygen.z =3D z;
+       slot->hwc.qse.cmd_ml_kem_keygen.ek =3D ek;
+       slot->hwc.qse.cmd_ml_kem_keygen.dk =3D dk;
+       slot->hwc.qse.cmd_ml_kem_keygen.dk_type =3D dk_type;
+}
+
+/**
+ * vcq_add_qse_ml_kem_enc() - Build an ML-KEM encapsulation VCQ command
+ * @slot: VCQ command slot to populate
+ * @core_id: Hardware core ID for dispatch
+ * @k: ML-KEM security parameter (k =3D 2, 3, or 4)
+ * @flags: Command flags
+ * @coin: DMA address of encapsulation coin/randomness buffer
+ * @ek: DMA address of encapsulation key input buffer
+ * @ct: DMA address of ciphertext output buffer
+ * @ss: DMA address of shared secret output buffer
+ * @ss_type: Shared secret datastore type
+ * @masked: Use masked (side-channel protected) variant
+ */
+void vcq_add_qse_ml_kem_enc(struct vcq_cmd *slot, u32 core_id, u32 k, u32 =
flags,
+                           u64 coin, u64 ek, u64 ct, u64 ss, u32 ss_type,
+                           bool masked)
+{
+       u32 cmd_id =3D masked ? QSE_CMD_ML_KEM_ENC_MASKED
+                           : QSE_CMD_ML_KEM_ENC;
+
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, cmd_id);
+       slot->hwc.qse.cmd_ml_kem_enc.k =3D k;
+       slot->hwc.qse.cmd_ml_kem_enc.flags =3D flags;
+       slot->hwc.qse.cmd_ml_kem_enc.coin =3D coin;
+       slot->hwc.qse.cmd_ml_kem_enc.ek =3D ek;
+       slot->hwc.qse.cmd_ml_kem_enc.ct =3D ct;
+       slot->hwc.qse.cmd_ml_kem_enc.ss =3D ss;
+       slot->hwc.qse.cmd_ml_kem_enc.ss_type =3D ss_type;
+}
+
+/**
+ * vcq_add_qse_ml_kem_dec() - Build an ML-KEM decapsulation VCQ command
+ * @slot: VCQ command slot to populate
+ * @core_id: Hardware core ID for dispatch
+ * @k: ML-KEM security parameter (k =3D 2, 3, or 4)
+ * @flags: Command flags
+ * @ct: DMA address of ciphertext input buffer
+ * @dk: DMA address of decapsulation key input buffer
+ * @ss: DMA address of shared secret output buffer
+ * @ss_type: Shared secret datastore type
+ * @masked: Use masked (side-channel protected) variant
+ */
+void vcq_add_qse_ml_kem_dec(struct vcq_cmd *slot, u32 core_id, u32 k, u32 =
flags,
+                           u64 ct, u64 dk, u64 ss, u32 ss_type,
+                           bool masked)
+{
+       u32 cmd_id =3D masked ? QSE_CMD_ML_KEM_DEC_MASKED
+                           : QSE_CMD_ML_KEM_DEC;
+
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, cmd_id);
+       slot->hwc.qse.cmd_ml_kem_dec.k =3D k;
+       slot->hwc.qse.cmd_ml_kem_dec.flags =3D flags;
+       slot->hwc.qse.cmd_ml_kem_dec.ct =3D ct;
+       slot->hwc.qse.cmd_ml_kem_dec.dk =3D dk;
+       slot->hwc.qse.cmd_ml_kem_dec.ss =3D ss;
+       slot->hwc.qse.cmd_ml_kem_dec.ss_type =3D ss_type;
+}
+
+/* -- ML-DSA -- */
+
+/**
+ * vcq_add_qse_ml_dsa_keygen() - Build an ML-DSA key generation VCQ comman=
d
+ * @slot: VCQ command slot to populate
+ * @core_id: Hardware core ID for dispatch
+ * @mode: ML-DSA mode (44, 65, or 87)
+ * @flags: Command flags
+ * @seed: DMA address of seed input buffer
+ * @pk: DMA address of public key output buffer
+ * @sk: DMA address of secret key output buffer
+ * @sk_type: Secret key datastore type
+ * @masked: Use masked (side-channel protected) variant
+ */
+void vcq_add_qse_ml_dsa_keygen(struct vcq_cmd *slot, u32 core_id, u32 mode=
, u32 flags,
+                              u64 seed, u64 pk, u64 sk, u32 sk_type,
+                              bool masked)
+{
+       u32 cmd_id =3D masked ? QSE_CMD_ML_DSA_KEYGEN_MASKED
+                           : QSE_CMD_ML_DSA_KEYGEN;
+
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, cmd_id);
+       slot->hwc.qse.cmd_ml_dsa_keygen.mode =3D mode;
+       slot->hwc.qse.cmd_ml_dsa_keygen.flags =3D flags;
+       slot->hwc.qse.cmd_ml_dsa_keygen.seed =3D seed;
+       slot->hwc.qse.cmd_ml_dsa_keygen.pk =3D pk;
+       slot->hwc.qse.cmd_ml_dsa_keygen.sk =3D sk;
+       slot->hwc.qse.cmd_ml_dsa_keygen.sk_type =3D sk_type;
+}
+
+/**
+ * vcq_add_qse_ml_dsa_sign() - Build an ML-DSA signing VCQ command
+ * @slot: VCQ command slot to populate
+ * @core_id: Hardware core ID for dispatch
+ * @mode: ML-DSA mode (44, 65, or 87)
+ * @flags: Command flags
+ * @rnd: DMA address of signing randomness buffer
+ * @m: DMA address of message buffer
+ * @sk: DMA address of secret key buffer
+ * @sig: DMA address of signature output buffer
+ * @mlen: Length of message in bytes
+ * @masked: Use masked (side-channel protected) variant
+ */
+void vcq_add_qse_ml_dsa_sign(struct vcq_cmd *slot, u32 core_id, u32 mode, =
u32 flags,
+                            u64 rnd, u64 m, u64 sk, u64 sig, u32 mlen,
+                            bool masked)
+{
+       u32 cmd_id =3D masked ? QSE_CMD_ML_DSA_SIGN_MASKED
+                           : QSE_CMD_ML_DSA_SIGN;
+
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, cmd_id);
+       slot->hwc.qse.cmd_ml_dsa_sign.mode =3D mode;
+       slot->hwc.qse.cmd_ml_dsa_sign.flags =3D flags;
+       slot->hwc.qse.cmd_ml_dsa_sign.rnd =3D rnd;
+       slot->hwc.qse.cmd_ml_dsa_sign.m =3D m;
+       slot->hwc.qse.cmd_ml_dsa_sign.sk =3D sk;
+       slot->hwc.qse.cmd_ml_dsa_sign.sig =3D sig;
+       slot->hwc.qse.cmd_ml_dsa_sign.mlen =3D mlen;
+}
+
+/**
+ * vcq_add_qse_ml_dsa_verify() - Build an ML-DSA signature verify VCQ comm=
and
+ * @slot: VCQ command slot to populate
+ * @core_id: Hardware core ID for dispatch
+ * @mode: ML-DSA mode (44, 65, or 87)
+ * @flags: Command flags
+ * @m: DMA address of message buffer
+ * @pk: DMA address of public key buffer
+ * @sig: DMA address of signature buffer to verify
+ * @mlen: Length of message in bytes
+ */
+void vcq_add_qse_ml_dsa_verify(struct vcq_cmd *slot, u32 core_id, u32 mode=
, u32 flags,
+                              u64 m, u64 pk, u64 sig, u32 mlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, QSE_CMD_ML_DSA_VERIFY);
+       slot->hwc.qse.cmd_ml_dsa_verify.mode =3D mode;
+       slot->hwc.qse.cmd_ml_dsa_verify.flags =3D flags;
+       slot->hwc.qse.cmd_ml_dsa_verify.m =3D m;
+       slot->hwc.qse.cmd_ml_dsa_verify.pk =3D pk;
+       slot->hwc.qse.cmd_ml_dsa_verify.sig =3D sig;
+       slot->hwc.qse.cmd_ml_dsa_verify.mlen =3D mlen;
+}
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

