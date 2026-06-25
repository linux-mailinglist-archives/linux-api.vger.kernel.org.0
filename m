Return-Path: <linux-api+bounces-6689-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2n/EHhpnPWpr2ggAu9opvQ
	(envelope-from <linux-api+bounces-6689-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:36:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CCA6C7D81
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:36:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=FWIhd40n;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6689-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6689-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B3A830BE73D
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F133EDAD1;
	Thu, 25 Jun 2026 17:34:19 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022073.outbound.protection.outlook.com [52.101.48.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969E3ECBED;
	Thu, 25 Jun 2026 17:34:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408859; cv=fail; b=hfhzOnbD2QnEKgh5+qVHFVGOq+4fW8qnIME3M55bp3ryXoRlltUWW+qD67dIZv1FyfkhYwXbTl1/x1Y8SXRW4FJ2wMseRb8aeCfgscnU3IQjiYtmt9PJl0iONcEMXhwA/rt+Blcgzwj4V6yFJmpnV4+jYimXta3kjPBrYFWiNmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408859; c=relaxed/simple;
	bh=eK38R4VZ2oWKMh2JOrA/t2qKu7Id+x9WAMzKFEiB8D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PPJ3307MHu5HFQwQdM7ks58n9SJORSuinJJHAQLFHPYhKiFAV79Z95+aK66enrMjc4sCNSrKmJXGSV6yFTnTMwYQAn56QVJvgHzgsXOYtwIzTtA8DQtRGczPieIZVgxqKm9sAjjLGKtLczAIpUBsT+L7FB6ygab4aGooBPV+Q8k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=FWIhd40n; arc=fail smtp.client-ip=52.101.48.73
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyjJ5k2LK0tVw4155ZPTz7uEa2L+EkhrLRPN2wS5Ejow7QB7hW7va5q6XFtgxZMIOwXQWDbKKeNiO1iz3ERZUmW+twtWw/kyUTDGNiRWq2tNYm/oQWF/WvS1b+avlSXBmNx/keW9r528CA6IZd+IqZMgj6fkX5yxGuf2on6THFVKi07PheL57tc9zTGGT3BcrxJv1is3vfd3f0ayh6NpQ3VDuyX5jnOpNJ34C2/F77AnHp7oZFFgz++RexOlvs1MkAtdgdE5bT3N3ZeN9FRn7Dyd0IeXs8sQZhouDz9Mo0ZOFEH42Ih9ny/xFIEHWjFvzfe4IcTkL5RhyhsrJciYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpRysDKYsu+meCnIUgK7fyxcW5k1rZeVIYgKTUfDxcI=;
 b=YyBF/yW+3pTcw9FUAt8vS3H93QnnUQNxxigoMs0IomnqXtpvUR5zTiCkGfTOasYO5Kp3VkT1ubzskcSdZuT8p86HOuK7565JElheKtf039jvWFt65JI9cwrXLdnejnffJg0Sh+6SFDa4aQJ7Mzk0/1wipf0ocaOkXSaWt+4Y/pFGZhzcdDa9VL71uN4mNouwQ00hwXm4CQIDw/h96mg/OuMbLtSkKVtCaajt9Xh6bwlSpEmyBEHPBCDVmdc5ocByDCVya9WQHB4mE750gIsAjrIzsA9n+hV6y2v8xcGHRwSZKWMsaixq++55r4MpSzzRQnTsAaI8auS62hA3q0ZdJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpRysDKYsu+meCnIUgK7fyxcW5k1rZeVIYgKTUfDxcI=;
 b=FWIhd40ngq/Q/neCl/biw3xvwJlYsnODPsxVeJSQQQ1712c7mcTQePcOBRqqEb5U5glZ5PpnxeES0U5zI6t13+0OYOYSLllCMNxmO5Q4Jm5FBKQkpYLYdhZcSNkX6yzLzOeG6qZeLUUk51KcAPdKZ9x7M1/VEnVQW6uFh8erHQWFrNMGFf5utB2BwXltBW61aXA2OI/6vD7rggvoM2d//Gc6o1OsMtmorCkO/KW5G2jL9fxZog+FaaOnElHHN1ED0yCWu5iwOX8CiL/CEAGH4anPa5H2B4sXjylEW+xSX9lewAq9lk+4JFy9fvFzCmxH2qN1Zomwjt6/ltBo3Xs3bw==
Received: from SA1PR02CA0018.namprd02.prod.outlook.com (2603:10b6:806:2cf::26)
 by CH2PR04MB7015.namprd04.prod.outlook.com (2603:10b6:610:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 17:34:07 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::7b) by SA1PR02CA0018.outlook.office365.com
 (2603:10b6:806:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Thu,
 25 Jun 2026 17:34:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:06 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 7A6D01801756;
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
Subject: [PATCH 04/19] crypto: cmh - add SHA-2/SHA-3/SHAKE ahash
Date: Thu, 25 Jun 2026 10:33:12 -0700
Message-ID: <20260625173328.1140487-5-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CH2PR04MB7015:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bb8dee06-8953-4a03-6179-08ded2dff57f
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|23010399003|1800799024|36860700016|921020|56012099006|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3HMmpm/QXxdUF8wseNbuAaYn2j8f9G1xF3rKMFm4Ug4EDpEwv7miXPh9CZTj26TUFIDjADmqjppzDY84358bamCmnZckUttykW5yYDhYtF4tnTH8TonU0UEpk0XJwddNojDhihoAW+bsmKzN2c1i8ESD5lrM+5dCD8Se/GoDRAm8s41dRqgfgXCSuVj2wzXNcNzu+RRqUcweLmQIsh+372paFpu2gq3DITCtpXtV42a3YV2dxWpVB9oKtjgwSN//fhUbuJiNc20pZxA3oUIj4qevkPEMwp0TvOPsA4f1PzFlb0+GSQMY3bphkrHRVakKo1SurN6RH3phsIFMMCplxJUWK6y4aZycvbBQCrGtuCM33LbFCWLTGqGvi7CpykJ8HKZ7YmCObKJpzkwNqOnz6yZtZuxDmVrhpc8XxiirrkxMlkCG2lFa3qXhmEAURZIS/fg5D2gbDfSspx7XB1nLTVfKh6s2Ry4Krao5LNHHQuNJqBmpTAPyAudJXjGNnk/hwQbuoFe7jO+ocs+9e/u5da89jDyQF48Kb826+dxHdeItT+9FXPeDeB8zz8mWKE08ULeS32Kptx6/GD/DSuSwsS2gPa6tzBP19aZ5hKOqlZb2WHqzgYbSmB4T1GDEOdWB1jZ7lkgrQDL9IUlzbRIsUwSWAHOMUwcSqzfz2W/v+3rpHuv5r1xRfwh7Qa/xSrrrShCkovCVerRzEUp9mhfqd/a2/x9tg1QyESDYn3gFeI//1UZyL1vGzWLbUft2L5yY
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(23010399003)(1800799024)(36860700016)(921020)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+9a7gdEBefYsdvVMbRkV1fgmaOcokA/c6dVEut5LrISgAAY+SVLDii07sdox3FezymzC68zSirSZXhNMNTlVreaY43tQfK7EYok5CoGCSAaXSCwQJYiKXIyB9lOXPCoGVHmGe1DuNq0i1B7XvnL4J9oTodqaist7deLqsfD3A8hQHZZZCXUvzTwrg880yDdqMxqxr8NxEZ0WfqF5W6L7LJHRmtAPrDcpS2kZdS8yMwhoLrWQhxDITflWhy6gJvyI14Le8DXCBgEQJqkY57IWP49HY1Q9bqeNkNd72ZqymgsDbiI4sTbhH3vzRIzqtnk42xKiHiz1dhXGJ78FPWaorg000Pb0prbRvlaMEdRSPWEqSipHV5JFtysj1/5uptgmmoE/fkvjEppv9dSoviAcJrunnJpEO2ld7BvsBHX4OwWKfwTzaX/7DAPkunop80W8
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:06.9798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8dee06-8953-4a03-6179-08ded2dff57f
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7015
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
	TAGGED_FROM(0.00)[bounces-6689-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: E4CCA6C7D81

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ahash algorithms for SHA-224, SHA-256, SHA-384, SHA-512,
SHA3-224, SHA3-256, SHA3-384, SHA3-512, SHAKE128, and SHAKE256
using the CMH hash core (core ID 0x02).

Supports incremental update/finup/final, init/export/import for
request cloning, and the CRYPTO_AHASH_REQ_VIRT flag for zero-copy
from virtual buffers.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile           |   3 +-
 drivers/crypto/cmh/cmh_hash.c         | 860 ++++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_main.c         |   9 +
 drivers/crypto/cmh/include/cmh_hash.h |  26 +
 4 files changed, 897 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_hash.c
 create mode 100644 drivers/crypto/cmh/include/cmh_hash.h

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index 1492e575598c..c0531f416229 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -14,7 +14,8 @@ cmh-y :=3D \
        cmh_dma.o \
        cmh_sysfs.o \
        cmh_key.o \
-       cmh_sys.o
+       cmh_sys.o \
+       cmh_hash.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
diff --git a/drivers/crypto/cmh/cmh_hash.c b/drivers/crypto/cmh/cmh_hash.c
new file mode 100644
index 000000000000..2256bf4314c3
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_hash.c
@@ -0,0 +1,860 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API Hash Driver
+ *
+ * Registers asynchronous hash (ahash) algorithms with the Linux crypto
+ * subsystem.  Implements SHA-2 (224/256/384/512), SHA-3
+ * (224/256/384/512), and SHAKE (128/256) families using the CMH Hash
+ * Core (HC).
+ *
+ * Incremental HW update model -- each .update() with enough data for
+ * at least one full block submits a self-contained VCQ transaction:
+ *
+ *   .init()   -> software-only: zero per-request context
+ *   .update() -> buffer data in holdback; when >=3D block_size bytes:
+ *                INIT [+ RESTORE] + UPDATE(full blocks) + SAVE + FLUSH
+ *                -> return -EINPROGRESS  (else return 0, data in holdback=
)
+ *   .final()  -> INIT [+ RESTORE] [+ UPDATE(residual)] + FINAL + FLUSH
+ *   .finup()  -> linearise holdback + new data, then final path
+ *   .digest() -> INIT + UPDATE + FINAL + FLUSH (single-shot, zero-copy)
+ *   .export() -> software-only: copy checkpoint + holdback to out
+ *   .import() -> software-only: restore checkpoint + holdback from in
+ *
+ * The FLUSH after each .update() releases the HC core, so no lockout.
+ * Two hash sessions interleave fine on the same MBX -- each saves its
+ * own state via SAVE and restores via RESTORE on the next call.
+ *
+ * Export/import is purely software (no HW interaction), enabling
+ * crypto API transform clone for all plain-hash algorithms.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/hash.h>
+#include <crypto/scatterwalk.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_hash.h"
+#include "cmh_vcq.h"
+#include "cmh_txn.h"
+#include "cmh_dma.h"
+
+/* Algorithm Table */
+
+struct cmh_hash_alg_info {
+       u32         hc_algo;        /* HC_ALGO_* (SHA2, SHA3, SHAKE) */
+       u32         digest_size;    /* bytes */
+       u32         block_size;     /* cra_blocksize for Linux crypto API *=
/
+       const char *alg_name;       /* Linux crypto name: "sha256" */
+       const char *drv_name;       /* driver name: "cri-cmh-sha256" */
+};
+
+static const struct cmh_hash_alg_info cmh_hash_algs_info[] =3D {
+       /* SHA-2 family */
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_224,
+               .digest_size =3D CMH_SHA224_DIGEST_SIZE,
+               .block_size  =3D 64,
+               .alg_name    =3D "sha224",
+               .drv_name    =3D "cri-cmh-sha224",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_256,
+               .digest_size =3D CMH_SHA256_DIGEST_SIZE,
+               .block_size  =3D 64,
+               .alg_name    =3D "sha256",
+               .drv_name    =3D "cri-cmh-sha256",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_384,
+               .digest_size =3D CMH_SHA384_DIGEST_SIZE,
+               .block_size  =3D 128,
+               .alg_name    =3D "sha384",
+               .drv_name    =3D "cri-cmh-sha384",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_512,
+               .digest_size =3D CMH_SHA512_DIGEST_SIZE,
+               .block_size  =3D 128,
+               .alg_name    =3D "sha512",
+               .drv_name    =3D "cri-cmh-sha512",
+       },
+       /* SHA-3 family */
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_224,
+               .digest_size =3D CMH_SHA3_224_DIGEST_SIZE,
+               .block_size  =3D 144,  /* rate =3D 1600/8 - 2*224/8 =3D 144=
 */
+               .alg_name    =3D "sha3-224",
+               .drv_name    =3D "cri-cmh-sha3-224",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_256,
+               .digest_size =3D CMH_SHA3_256_DIGEST_SIZE,
+               .block_size  =3D 136,  /* rate =3D 1600/8 - 2*256/8 =3D 136=
 */
+               .alg_name    =3D "sha3-256",
+               .drv_name    =3D "cri-cmh-sha3-256",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_384,
+               .digest_size =3D CMH_SHA3_384_DIGEST_SIZE,
+               .block_size  =3D 104,  /* rate =3D 1600/8 - 2*384/8 =3D 104=
 */
+               .alg_name    =3D "sha3-384",
+               .drv_name    =3D "cri-cmh-sha3-384",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_512,
+               .digest_size =3D CMH_SHA3_512_DIGEST_SIZE,
+               .block_size  =3D 72,   /* rate =3D 1600/8 - 2*512/8 =3D 72 =
*/
+               .alg_name    =3D "sha3-512",
+               .drv_name    =3D "cri-cmh-sha3-512",
+       },
+       /*
+        * SHAKE (XOF) family -- fixed-output ahash registration.
+        *
+        * cra_blocksize =3D 1: SHAKE is a sponge/XOF, not Merkle-Damgaard.
+        * The Keccak rate (168 for SHAKE-128, 136 for SHAKE-256) exceeds
+        * MAX_ALGAPI_BLOCKSIZE (160) on Linux <=3D6.7.  Using 1 signals
+        * "byte-oriented" which is correct for XOF consumers.  The kernel
+        * raised the limit to 208 in 6.8 (commit 2f3a22704889).
+        */
+       {
+               .hc_algo     =3D HC_ALGO_SHAKE128,
+               .digest_size =3D CMH_SHAKE128_DIGEST_SIZE,
+               .block_size  =3D 1,    /* XOF: no meaningful block for cryp=
to API */
+               .alg_name    =3D "shake128",
+               .drv_name    =3D "cri-cmh-shake128",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHAKE256,
+               .digest_size =3D CMH_SHAKE256_DIGEST_SIZE,
+               .block_size  =3D 1,    /* XOF: no meaningful block for cryp=
to API */
+               .alg_name    =3D "shake256",
+               .drv_name    =3D "cri-cmh-shake256",
+       },
+};
+
+#define CMH_HASH_ALG_COUNT  ARRAY_SIZE(cmh_hash_algs_info)
+
+/* Per-Request State */
+
+/* Maximum cra_blocksize across all registered algorithms (SHA3-224) */
+#define CMH_HASH_MAX_BLOCK     144
+
+/*
+ * Exported hash state -- serialised by .export(), deserialised by
+ * .import().  This is what statesize advertises to the crypto subsystem.
+ */
+struct cmh_hash_export_state {
+       u8  checkpoint[HC_CONTEXT_SIZE]; /* HC context from last SAVE */
+       u8  buf[CMH_HASH_MAX_BLOCK];    /* holdback buffer */
+       u32 buf_len;                     /* valid bytes in buf[] */
+       u32 hw_started;                  /* non-zero if checkpoint valid */
+};
+
+/*
+ * Maximum payload commands any hash transaction can produce:
+ *   INIT + RESTORE + UPDATE + SAVE/FINAL + FLUSH =3D 5
+ * Worst-case packed output (stride=3D7, 1 payload per VCQ):
+ *   5 VCQs x 2 entries =3D 10
+ */
+#define CMH_HASH_MAX_PAYLOAD    5
+#define CMH_HASH_MAX_PACKED     (CMH_HASH_MAX_PAYLOAD * 2)
+
+/*
+ * Stored in ahash_request_ctx().  Tracks the algorithm, a holdback
+ * buffer for partial blocks, an HC context checkpoint from the last
+ * SAVE, and DMA state for the current in-flight async operation.
+ *
+ * The checkpoint is embedded inline rather than heap-allocated because
+ * the kernel ahash API has no per-request destructor.  If a request is
+ * abandoned without .final() (e.g. transform freed early), a heap
+ * checkpoint would leak unconditionally.
+ */
+struct cmh_hash_reqctx {
+       const struct cmh_hash_alg_info *info;
+       int    error;
+       u32    hw_started;      /* non-zero after first HW submission */
+       u32    buf_len;         /* bytes in holdback buf[] */
+       u32    has_checkpoint;  /* non-zero if checkpoint[] valid */
+       /* DMA state for current async operation */
+       dma_addr_t ckpt_dma;   /* RESTORE input */
+       dma_addr_t save_dma;   /* SAVE output (update only) */
+       dma_addr_t data_dma;   /* UPDATE input */
+       dma_addr_t digest_dma; /* FINAL output (final/digest only) */
+       u8    *save_buf;       /* SAVE output buffer */
+       u8    *data_buf;       /* linearised data for DMA */
+       u32    data_len;       /* bytes in data_buf */
+       u8    *digest_buf;     /* digest output buffer */
+       u8     buf[CMH_HASH_MAX_BLOCK]; /* holdback for partial block */
+       u8     checkpoint[HC_CONTEXT_SIZE]; /* HC context from last SAVE */
+       struct vcq_cmd packed[CMH_HASH_MAX_PACKED];
+};
+
+/* VCQ Builders (HC-specific; shared builders in cmh_hc_abi.h / cmh_vcq.h)=
 */
+
+/* Add an HC_CMD_UPDATE entry */
+static void vcq_add_hc_update(struct vcq_cmd *slot, u32 core_id, u64 input=
_phys, u32 len)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_UPDATE);
+       slot->hwc.hc.cmd_update.input =3D input_phys;
+       slot->hwc.hc.cmd_update.inlen =3D len;
+}
+
+/* Add an HC_CMD_SAVE entry */
+static void vcq_add_hc_save(struct vcq_cmd *slot, u32 core_id, u64 output_=
phys, u32 outlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_SAVE);
+       slot->hwc.hc.cmd_save.output =3D output_phys;
+       slot->hwc.hc.cmd_save.outlen =3D outlen;
+}
+
+/* Add an HC_CMD_RESTORE entry */
+static void vcq_add_hc_restore(struct vcq_cmd *slot, u32 core_id, u64 inpu=
t_phys, u32 inlen)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_RESTORE);
+       slot->hwc.hc.cmd_restore.input =3D input_phys;
+       slot->hwc.hc.cmd_restore.inlen =3D inlen;
+}
+
+/* Request Context Cleanup */
+
+static void cmh_hash_free_reqctx(struct cmh_hash_reqctx *rctx)
+{
+       rctx->has_checkpoint =3D 0;
+}
+
+/* VCQ Packing + Submit */
+
+/* ahash Operations */
+
+/*
+ * Wrapper struct: embeds ahash_alg + a pointer to our alg_info table
+ * entry so we can recover it in the tfm callbacks.
+ */
+struct cmh_hash_alg_drv {
+       struct ahash_alg                 alg;
+       const struct cmh_hash_alg_info  *info;
+};
+
+/*
+ * Find the cmh_hash_alg_info from the crypto_ahash (embedded in our
+ * registered template).  We stash the info pointer in the algorithm's
+ * driver-private area at registration time (see cmh_hash_register).
+ */
+static const struct cmh_hash_alg_info *
+cmh_hash_get_info(struct crypto_ahash *tfm)
+{
+       struct ahash_alg *alg =3D crypto_ahash_alg(tfm);
+
+       return container_of(alg, struct cmh_hash_alg_drv, alg)->info;
+}
+
+static int cmh_hash_init(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->info =3D cmh_hash_get_info(tfm);
+       return 0;
+}
+
+/*
+ * Update completion -- called from threaded IRQ after SAVE completes.
+ * Takes ownership of save_buf as the new checkpoint.
+ */
+static void cmh_hash_update_complete(void *data, int error)
+{
+       struct ahash_request *req =3D data;
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       /* Unmap DMA buffers */
+       if (rctx->has_checkpoint)
+               cmh_dma_unmap_single(rctx->ckpt_dma, HC_CONTEXT_SIZE,
+                                    DMA_TO_DEVICE);
+       cmh_dma_unmap_single(rctx->save_dma, HC_CONTEXT_SIZE,
+                            DMA_FROM_DEVICE);
+       cmh_dma_unmap_single(rctx->data_dma, rctx->data_len,
+                            DMA_TO_DEVICE);
+
+       if (!error) {
+               memcpy(rctx->checkpoint, rctx->save_buf, HC_CONTEXT_SIZE);
+               rctx->has_checkpoint =3D 1;
+               kfree(rctx->save_buf);
+               rctx->save_buf =3D NULL;
+               rctx->hw_started =3D 1;
+       } else {
+               kfree(rctx->save_buf);
+               rctx->save_buf =3D NULL;
+               rctx->error =3D error;
+       }
+
+       kfree(rctx->data_buf);
+       rctx->data_buf =3D NULL;
+       rctx->data_len =3D 0;
+
+       cmh_complete(&req->base, error);
+}
+
+/*
+ * .update -- buffer incoming data, submit full blocks to HW.
+ *
+ * Maintains a partial-block holdback buffer in rctx->buf[].  When
+ * enough data is available for at least one full block, the full
+ * blocks are linearised and submitted as:
+ *   INIT [+ RESTORE] + UPDATE(full_blocks) + SAVE + FLUSH
+ *
+ * The tail (< block_size) stays in the holdback for the next call.
+ * Returns -EINPROGRESS on HW submission, 0 if only buffering.
+ */
+static int cmh_hash_update(struct ahash_request *req)
+{
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_hash_alg_info *info =3D rctx->info;
+       struct vcq_cmd cmds[CMH_HASH_MAX_PAYLOAD];
+       struct core_dispatch d;
+       u32 block_size =3D info->block_size;
+       u32 total_avail, full_len, tail_len, from_src;
+       u32 idx;
+       int ret;
+       gfp_t gfp;
+
+       if (rctx->error)
+               return rctx->error;
+
+       if (!req->nbytes)
+               return 0;
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       total_avail =3D rctx->buf_len + req->nbytes;
+
+       /* Not enough for a full block -- just buffer */
+       if (total_avail < block_size) {
+               if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+                       memcpy(rctx->buf + rctx->buf_len,
+                              req->svirt, req->nbytes);
+               else
+                       scatterwalk_map_and_copy(rctx->buf + rctx->buf_len,
+                                                req->src, 0,
+                                                req->nbytes, 0);
+               rctx->buf_len =3D total_avail;
+               return 0;
+       }
+
+       /* Have at least one full block -- submit to HW */
+       full_len =3D total_avail - total_avail % block_size;
+       tail_len =3D total_avail - full_len;
+       from_src =3D full_len - rctx->buf_len;
+
+       /* Linearise: holdback prefix + full blocks from scatterlist */
+       rctx->data_buf =3D kmalloc(full_len, gfp);
+       if (!rctx->data_buf)
+               return -ENOMEM;
+
+       if (rctx->buf_len > 0)
+               memcpy(rctx->data_buf, rctx->buf, rctx->buf_len);
+
+       if (from_src > 0) {
+               if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+                       memcpy(rctx->data_buf + rctx->buf_len,
+                              req->svirt, from_src);
+               else
+                       scatterwalk_map_and_copy(rctx->data_buf + rctx->buf=
_len,
+                                                req->src, 0,
+                                                from_src, 0);
+       }
+
+       /* Move tail to holdback */
+       if (tail_len > 0) {
+               if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+                       memcpy(rctx->buf, req->svirt + from_src,
+                              tail_len);
+               else
+                       scatterwalk_map_and_copy(rctx->buf, req->src,
+                                                from_src, tail_len,
+                                                0);
+       }
+       rctx->buf_len =3D tail_len;
+       rctx->data_len =3D full_len;
+
+       /* Allocate SAVE output buffer */
+       rctx->save_buf =3D kzalloc(HC_CONTEXT_SIZE, gfp);
+       if (!rctx->save_buf) {
+               ret =3D -ENOMEM;
+               goto err_free;
+       }
+
+       /* DMA map data, save output, and checkpoint */
+       rctx->data_dma =3D cmh_dma_map_single(rctx->data_buf, full_len,
+                                           DMA_TO_DEVICE);
+       if (cmh_dma_map_error(rctx->data_dma)) {
+               ret =3D -ENOMEM;
+               goto err_free;
+       }
+
+       rctx->save_dma =3D cmh_dma_map_single(rctx->save_buf, HC_CONTEXT_SI=
ZE,
+                                           DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(rctx->save_dma)) {
+               ret =3D -ENOMEM;
+               goto err_unmap_data;
+       }
+
+       rctx->ckpt_dma =3D DMA_MAPPING_ERROR;
+       if (rctx->has_checkpoint) {
+               rctx->ckpt_dma =3D cmh_dma_map_single(rctx->checkpoint,
+                                                   HC_CONTEXT_SIZE,
+                                                    DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rctx->ckpt_dma)) {
+                       ret =3D -ENOMEM;
+                       goto err_unmap_save;
+               }
+       }
+
+       /* Build VCQ: INIT [+ RESTORE] + UPDATE + SAVE + FLUSH */
+       d =3D cmh_core_select_instance(CMH_CORE_HC);
+       idx =3D 0;
+
+       vcq_add_hc_init(&cmds[idx++], d.core_id, info->hc_algo);
+
+       if (rctx->has_checkpoint)
+               vcq_add_hc_restore(&cmds[idx++], d.core_id,
+                                  (u64)rctx->ckpt_dma, HC_CONTEXT_SIZE);
+
+       vcq_add_hc_update(&cmds[idx++], d.core_id,
+                         (u64)rctx->data_dma, full_len);
+
+       vcq_add_hc_save(&cmds[idx++], d.core_id,
+                       (u64)rctx->save_dma, HC_CONTEXT_SIZE);
+
+       vcq_add_flush(&cmds[idx++], d.core_id);
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_HASH_MAX_PACKED,
+                                           d.mbx_idx,
+                                           cmh_hash_update_complete, req,
+                                           !!(req->base.flags &
+                                              CRYPTO_TFM_REQ_MAY_BACKLOG),
+                                           cmh_tm_async_timeout_jiffies())=
;
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (ret)
+               goto err_unmap_ckpt;
+
+       return -EINPROGRESS;
+
+err_unmap_ckpt:
+       if (rctx->has_checkpoint)
+               cmh_dma_unmap_single(rctx->ckpt_dma, HC_CONTEXT_SIZE,
+                                    DMA_TO_DEVICE);
+err_unmap_save:
+       cmh_dma_unmap_single(rctx->save_dma, HC_CONTEXT_SIZE,
+                            DMA_FROM_DEVICE);
+err_unmap_data:
+       cmh_dma_unmap_single(rctx->data_dma, full_len, DMA_TO_DEVICE);
+err_free:
+       kfree(rctx->save_buf);
+       rctx->save_buf =3D NULL;
+       kfree(rctx->data_buf);
+       rctx->data_buf =3D NULL;
+       rctx->data_len =3D 0;
+       return ret;
+}
+
+/*
+ * Final completion -- unmap all DMA, copy digest, signal done.
+ */
+static void cmh_hash_final_complete(void *data, int error)
+{
+       struct ahash_request *req =3D data;
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+
+       if (error =3D=3D -EINPROGRESS) {
+               cmh_complete(&req->base, error);
+               return;
+       }
+
+       if (rctx->has_checkpoint)
+               cmh_dma_unmap_single(rctx->ckpt_dma, HC_CONTEXT_SIZE,
+                                    DMA_TO_DEVICE);
+       if (rctx->data_buf)
+               cmh_dma_unmap_single(rctx->data_dma, rctx->data_len,
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
+       kfree(rctx->data_buf);
+       rctx->data_buf =3D NULL;
+       cmh_hash_free_reqctx(rctx);
+       cmh_complete(&req->base, error);
+}
+
+/*
+ * Submit the final VCQ transaction:
+ *   INIT [+ RESTORE] [+ UPDATE(residual)] + FINAL + FLUSH
+ *
+ * @data_buf: linearised residual data, or NULL for empty-hash.
+ *            Ownership transferred -- callback frees it.
+ * @data_len: bytes in data_buf.
+ */
+static int cmh_hash_submit_final(struct ahash_request *req,
+                                u8 *data_buf, u32 data_len)
+{
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_hash_alg_info *info =3D rctx->info;
+       struct vcq_cmd cmds[CMH_HASH_MAX_PAYLOAD];
+       struct core_dispatch d;
+       u32 idx;
+       int ret;
+       gfp_t gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+                  GFP_KERNEL : GFP_ATOMIC;
+
+       rctx->data_buf =3D data_buf;
+       rctx->data_len =3D data_len;
+
+       /* Allocate digest output buffer */
+       rctx->digest_buf =3D kzalloc(info->digest_size, gfp);
+       if (!rctx->digest_buf) {
+               ret =3D -ENOMEM;
+               goto err_free_data;
+       }
+
+       rctx->digest_dma =3D cmh_dma_map_single(rctx->digest_buf,
+                                             info->digest_size,
+                                              DMA_FROM_DEVICE);
+       if (cmh_dma_map_error(rctx->digest_dma)) {
+               ret =3D -ENOMEM;
+               goto err_free_digest;
+       }
+
+       /* Map residual data for UPDATE */
+       rctx->data_dma =3D DMA_MAPPING_ERROR;
+       if (data_buf && data_len > 0) {
+               rctx->data_dma =3D cmh_dma_map_single(data_buf, data_len,
+                                                   DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rctx->data_dma)) {
+                       ret =3D -ENOMEM;
+                       goto err_unmap_digest;
+               }
+       }
+
+       /* Map checkpoint for RESTORE */
+       rctx->ckpt_dma =3D DMA_MAPPING_ERROR;
+       if (rctx->has_checkpoint) {
+               rctx->ckpt_dma =3D cmh_dma_map_single(rctx->checkpoint,
+                                                   HC_CONTEXT_SIZE,
+                                                    DMA_TO_DEVICE);
+               if (cmh_dma_map_error(rctx->ckpt_dma)) {
+                       ret =3D -ENOMEM;
+                       goto err_unmap_data;
+               }
+       }
+
+       /* Build VCQ: INIT [+ RESTORE] [+ UPDATE] + FINAL + FLUSH */
+       d =3D cmh_core_select_instance(CMH_CORE_HC);
+       idx =3D 0;
+
+       vcq_add_hc_init(&cmds[idx++], d.core_id, info->hc_algo);
+
+       if (rctx->has_checkpoint)
+               vcq_add_hc_restore(&cmds[idx++], d.core_id,
+                                  (u64)rctx->ckpt_dma, HC_CONTEXT_SIZE);
+
+       if (data_buf && data_len > 0)
+               vcq_add_hc_update(&cmds[idx++], d.core_id,
+                                 (u64)rctx->data_dma, data_len);
+
+       vcq_add_hc_final(&cmds[idx++], d.core_id,
+                        (u64)rctx->digest_dma, info->digest_size);
+
+       vcq_add_flush(&cmds[idx++], d.core_id);
+
+       ret =3D cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+                                           CMH_HASH_MAX_PACKED,
+                                           d.mbx_idx,
+                                           cmh_hash_final_complete, req,
+                                           !!(req->base.flags &
+                                              CRYPTO_TFM_REQ_MAY_BACKLOG),
+                                           cmh_tm_async_timeout_jiffies())=
;
+       if (ret =3D=3D -EBUSY)
+               return -EBUSY;
+       if (ret)
+               goto err_unmap_ckpt;
+
+       return -EINPROGRESS;
+
+err_unmap_ckpt:
+       if (rctx->has_checkpoint)
+               cmh_dma_unmap_single(rctx->ckpt_dma, HC_CONTEXT_SIZE,
+                                    DMA_TO_DEVICE);
+err_unmap_data:
+       if (data_buf && data_len > 0)
+               cmh_dma_unmap_single(rctx->data_dma, data_len,
+                                    DMA_TO_DEVICE);
+err_unmap_digest:
+       cmh_dma_unmap_single(rctx->digest_dma, info->digest_size,
+                            DMA_FROM_DEVICE);
+err_free_digest:
+       kfree(rctx->digest_buf);
+       rctx->digest_buf =3D NULL;
+err_free_data:
+       kfree(data_buf);
+       rctx->data_buf =3D NULL;
+       cmh_hash_free_reqctx(rctx);
+       return ret;
+}
+
+static int cmh_hash_final(struct ahash_request *req)
+{
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+       u8 *data_buf =3D NULL;
+       u32 data_len =3D 0;
+       gfp_t gfp;
+
+       if (rctx->error)
+               return rctx->error;
+
+       if (rctx->buf_len > 0) {
+               gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+                     GFP_KERNEL : GFP_ATOMIC;
+               data_buf =3D kmalloc(rctx->buf_len, gfp);
+               if (!data_buf)
+                       return -ENOMEM;
+               memcpy(data_buf, rctx->buf, rctx->buf_len);
+               data_len =3D rctx->buf_len;
+               rctx->buf_len =3D 0;
+       }
+
+       return cmh_hash_submit_final(req, data_buf, data_len);
+}
+
+static int cmh_hash_finup(struct ahash_request *req);
+
+/*
+ * One-shot digest -- delegates to init + finup so that all data is
+ * linearised and mapped through cmh_dma_map_single(), which is the
+ * only DMA mapping path aware of all supported DMA backends.
+ */
+static int cmh_hash_digest(struct ahash_request *req)
+{
+       int ret;
+
+       ret =3D cmh_hash_init(req);
+       if (ret)
+               return ret;
+       return cmh_hash_finup(req);
+}
+
+/*
+ * .finup -- update + final combined into a single transaction.
+ *
+ * Linearises the holdback buffer + new data and submits everything
+ * through the final path.  Avoids the kernel's ahash_def_finup()
+ * which would allocate a subrequest and clone via export/import.
+ */
+static int cmh_hash_finup(struct ahash_request *req)
+{
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+       u32 data_len;
+       u8 *data_buf;
+       gfp_t gfp;
+
+       if (rctx->error)
+               return rctx->error;
+
+       data_len =3D rctx->buf_len + req->nbytes;
+
+       if (data_len =3D=3D 0)
+               return cmh_hash_submit_final(req, NULL, 0);
+
+       gfp =3D req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+             GFP_KERNEL : GFP_ATOMIC;
+
+       data_buf =3D kmalloc(data_len, gfp);
+       if (!data_buf)
+               return -ENOMEM;
+
+       if (rctx->buf_len > 0)
+               memcpy(data_buf, rctx->buf, rctx->buf_len);
+
+       if (req->nbytes > 0) {
+               if (req->base.flags & CRYPTO_AHASH_REQ_VIRT)
+                       memcpy(data_buf + rctx->buf_len,
+                              req->svirt, req->nbytes);
+               else
+                       scatterwalk_map_and_copy(data_buf + rctx->buf_len,
+                                                req->src, 0,
+                                                req->nbytes, 0);
+       }
+
+       rctx->buf_len =3D 0;
+       return cmh_hash_submit_final(req, data_buf, data_len);
+}
+
+/*
+ * Export -- purely software.
+ *
+ * Serialise the HC checkpoint (if any) and holdback buffer into the
+ * export state structure.  No HW interaction needed because the
+ * incremental model keeps checkpoint up-to-date after each .update().
+ */
+static int cmh_hash_export(struct ahash_request *req, void *out)
+{
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+       struct cmh_hash_export_state *state =3D out;
+
+       if (rctx->hw_started && rctx->has_checkpoint)
+               memcpy(state->checkpoint, rctx->checkpoint, HC_CONTEXT_SIZE=
);
+       else
+               memset(state->checkpoint, 0, HC_CONTEXT_SIZE);
+
+       if (rctx->buf_len > 0)
+               memcpy(state->buf, rctx->buf, rctx->buf_len);
+
+       state->buf_len =3D rctx->buf_len;
+       state->hw_started =3D rctx->hw_started;
+
+       return 0;
+}
+
+/*
+ * Import -- purely software.
+ *
+ * Restore checkpoint and holdback from a previously exported state.
+ * The next .update() or .final() will RESTORE the checkpoint into HW.
+ */
+static int cmh_hash_import(struct ahash_request *req, const void *in)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_hash_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_hash_export_state *state =3D in;
+
+       memset(rctx, 0, sizeof(*rctx));
+       rctx->info =3D cmh_hash_get_info(tfm);
+
+       if (state->buf_len > CMH_HASH_MAX_BLOCK)
+               return -EINVAL;
+
+       rctx->hw_started =3D state->hw_started;
+       rctx->buf_len =3D state->buf_len;
+       memcpy(rctx->buf, state->buf, state->buf_len);
+
+       if (state->hw_started) {
+               memcpy(rctx->checkpoint, state->checkpoint, HC_CONTEXT_SIZE=
);
+               rctx->has_checkpoint =3D 1;
+       }
+
+       return 0;
+}
+
+/* Transform init (cra_init) -- set per-request context size */
+
+static int cmh_hash_cra_init(struct crypto_tfm *tfm)
+{
+       crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+                                sizeof(struct cmh_hash_reqctx));
+       return 0;
+}
+
+/* Registration */
+
+static struct cmh_hash_alg_drv cmh_hash_drvs[CMH_HASH_ALG_COUNT];
+
+/**
+ * cmh_hash_register() - Register SHA-256/384/512/3-256/3-384/3-512 hash a=
lgorithms
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_hash_register(void)
+{
+       unsigned int i;
+       int ret;
+
+       for (i =3D 0; i < CMH_HASH_ALG_COUNT; i++) {
+               const struct cmh_hash_alg_info *info =3D &cmh_hash_algs_inf=
o[i];
+               struct cmh_hash_alg_drv *drv =3D &cmh_hash_drvs[i];
+               struct ahash_alg *alg =3D &drv->alg;
+
+               drv->info =3D info;
+
+               alg->init   =3D cmh_hash_init;
+               alg->update =3D cmh_hash_update;
+               alg->final  =3D cmh_hash_final;
+               alg->finup  =3D cmh_hash_finup;
+               alg->digest =3D cmh_hash_digest;
+               alg->export =3D cmh_hash_export;
+               alg->import =3D cmh_hash_import;
+
+               alg->halg.digestsize =3D info->digest_size;
+               alg->halg.statesize  =3D sizeof(struct cmh_hash_export_stat=
e);
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
+               alg->halg.base.cra_blocksize   =3D info->block_size;
+               alg->halg.base.cra_ctxsize     =3D 0;
+               alg->halg.base.cra_init        =3D cmh_hash_cra_init;
+               alg->halg.base.cra_module      =3D THIS_MODULE;
+
+               ret =3D crypto_register_ahash(alg);
+               if (ret) {
+                       dev_err(cmh_dev(), "hash: failed to register %s (rc=
=3D%d)\n",
+                               info->drv_name, ret);
+                       /* Unregister any already-registered algorithms */
+                       while (i--)
+                               crypto_unregister_ahash(&cmh_hash_drvs[i].a=
lg);
+                       return ret;
+               }
+
+               dev_dbg(cmh_dev(), "hash: registered %s (priority 300)\n",
+                       info->drv_name);
+       }
+
+       dev_info(cmh_dev(), "hash: %zu algorithm(s) registered\n",
+                CMH_HASH_ALG_COUNT);
+       return 0;
+}
+
+/**
+ * cmh_hash_unregister() - Unregister SHA hash algorithms from the crypto =
framework
+ */
+void cmh_hash_unregister(void)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < CMH_HASH_ALG_COUNT; i++) {
+               crypto_unregister_ahash(&cmh_hash_drvs[i].alg);
+               dev_dbg(cmh_dev(), "hash: unregistered %s\n",
+                       cmh_hash_algs_info[i].drv_name);
+       }
+
+       dev_info(cmh_dev(), "hash: cleaned up\n");
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index 307bd7dd304b..e8e30b893932 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -29,6 +29,7 @@
 #include "cmh_mqi.h"
 #include "cmh_txn.h"
 #include "cmh_rh.h"
+#include "cmh_hash.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -191,6 +192,11 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_rh_init;

+       /* Register hash algorithms with the kernel crypto API */
+       ret =3D cmh_hash_register();
+       if (ret)
+               goto err_hash_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -203,6 +209,8 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_hash_unregister();
+err_hash_register:
        cmh_rh_cleanup(cfg);
 err_rh_init:
        cmh_tm_cleanup();
@@ -229,6 +237,7 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_hash_unregister();
        cmh_rh_cleanup(cfg);
        cmh_tm_cleanup();
        cmh_mqi_cleanup(cfg);
diff --git a/drivers/crypto/cmh/include/cmh_hash.h b/drivers/crypto/cmh/inc=
lude/cmh_hash.h
new file mode 100644
index 000000000000..bf17d3af7787
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_hash.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API Hash Driver
+ *
+ * Registers ahash algorithms (SHA-2, SHA-3, and SHAKE families) with the
+ * Linux crypto subsystem.  Uses an incremental HW update model:
+ *
+ *   .init()   -> software-only: zero per-request context
+ *   .update() -> holdback partial blocks; submit full blocks via
+ *                INIT [+ RESTORE] + UPDATE + SAVE + FLUSH
+ *   .final()  -> INIT [+ RESTORE] [+ UPDATE(residual)] + FINAL + FLUSH
+ *   .digest() -> INIT + UPDATE + FINAL + FLUSH (single-shot)
+ *   .export() -> software-only: copy checkpoint + holdback
+ *   .import() -> software-only: restore checkpoint + holdback
+ */
+
+#ifndef CMH_HASH_H
+#define CMH_HASH_H
+
+#include "cmh_config.h"
+
+int  cmh_hash_register(void);
+void cmh_hash_unregister(void);
+
+#endif /* CMH_HASH_H */
--
2.43.7


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

