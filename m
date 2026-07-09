Return-Path: <linux-api+bounces-6809-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KnFeJjMFUGrcrwIAu9opvQ
	(envelope-from <linux-api+bounces-6809-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:31:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA207355BB
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:31:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=iNoRa929;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6809-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-api+bounces-6809-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EB983006817
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B603CF675;
	Thu,  9 Jul 2026 20:31:33 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021099.outbound.protection.outlook.com [52.101.52.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344663C8C68;
	Thu,  9 Jul 2026 20:31:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629092; cv=fail; b=qXm4hcGYpsjkZMvQPsS/brDNwZ5VJ4L4KaWno++aG5UX9Nj5xS630Jx4iv/GhvaW8h3xerKOyZdB6MeLLIJE4ug1keloEan48gX9IEUP31pretg7Q2d53QjzZJL+wKSY2EtAg7N6AzrbAhQRQqJiVKpUWkr+OpnjG/gzeMkquno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629092; c=relaxed/simple;
	bh=HsjVVP4OlyQ+8l6F0tyoY6kDvm6htNqJGq0R5X3fI1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwdXCylGSm4J8d4O5FOKaavQ2sLECSZ0qHdJP9JCVCwJ4Uj8oVF0IMO7gw4cxa55HFko0ce1jEh+hnoP47iXKX0a2TbMRLM5T1ri03qsf7zIX7auOB7P69wCbWIHuXyLdsSfYOHcqxNloU20QmGaHpXhZW0KuFSQ7LhnpTcHsRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=iNoRa929; arc=fail smtp.client-ip=52.101.52.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7XCgcKxXpY+NCGvT+qsZLfChJh+aycaCn6tSCghcTiR9vP1zvFZKtH48MBHAYIXqXQIJrOYcOSJr+KVq7+YxL5QxJOYVOBPDFnxFGSsmRknhDpm5aHuCAq0vF378vHyrwTqiUxAdGEKbS25cBUTCoGpTvdiqd+DwnjBp3A5yUD9sk6KWSPUao1lBRqbpeWmRsbUHIstsR7Gmo1MInFHd2H+wfvqxR4FkpussgWHaI7hYA9k42+KhSsTp/3RX7PWzU/q1s0usjElRNox9mCS4e0hEztCY0RQid+W0H8WHbMKLCQdj83iB5g1XK+pwAu2PWMQRxc6d4Vt2tRxaaYn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xERIr27FEvSpPK0NqvMDabzcFHamEbyJWNdIqekPiQ4=;
 b=h5EwdyuanfTUILW1qEerAoYGwepssb8XutEA6JI5YgUHXdBX0ydNlyy0cYVTgYAeW1SJxKAwgf25KlbrJ8V/3JPqHEU76lagslEHNNQtGlZD2m/T/EgsoMGxI7z5+5gDMCm4smntWg9OJqhGIsApblzlVnmvZRT+nWXIp9mK3vyTqSyV2IBpDZZ7wHhP0/uGD7/TL/gaF5C9YjAvWquJua5PsdgAHz1ldicDaZGNg5I5LOS4Qtu1INbgD36Z/meDeOBt583X6aRsYM6i+0Ozb7xbPDVFY3b+waoAKvu8ci4f79dISMvLyNg5GuLUcVk86ZrcqGd+o3L/k0Ex/cgOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xERIr27FEvSpPK0NqvMDabzcFHamEbyJWNdIqekPiQ4=;
 b=iNoRa929+4ASVGAj6jFYX5L47c6yXxOckuZ9KNU+FEb3Xv3LoPAxKikuFvawYphhQQGC7gTCxImJn5INDL+6+7xL1DCca0zNFmnhgJ7jclEqQFVdoe/tVDIpkcZzmB9mkzc7qMLOmocip1ZH7dTyalckoEzL6lh/mYxA7f7LQeAAqftflVOWZi+/TdsePuIVTXAwWWuthv9h0POpySuUMX+5xwC75AEv9GRV4Ixza2At5qM+NzNZAgTBfh8JA5Z6fh5NSv6KjF+KvntTP4oCkiEYpQQq9ea9EuJb+Mc0zrJ7mIo/7XQsb0AWK5V1HeNGUFhCb3thN8upaDjDJhwWYQ==
Received: from DM6PR04CA0017.namprd04.prod.outlook.com (2603:10b6:5:334::22)
 by SJ0PR04MB7567.namprd04.prod.outlook.com (2603:10b6:a03:32d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:31:21 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::12) by DM6PR04CA0017.outlook.office365.com
 (2603:10b6:5:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 20:31:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:21 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id BD9311801755;
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
Subject: [PATCH v2 05/19] crypto: cmh - add HMAC ahash
Date: Thu,  9 Jul 2026 13:30:23 -0700
Message-ID: <20260709203037.1884436-6-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|SJ0PR04MB7567:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5f7e735d-eb5a-4d88-3d81-08deddf909d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|82310400026|1800799024|3023799007|18002099003|22082099003|56012099006|6133799003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	HeOCYZHOcSnkxkYvBAv9PPtWKXMKvMjz6WsMeVuHR+X92qdx3CfT2MxIQPnV6sL+ra6kmM0Yh/yVe7im+pDDgG5IGLQ98pHkLRH3MAx54KdZyezSscFwZunR5oat+5tnm0rL7zEmwQwnugc4xJKfPUBERB6YYYlYNSHehYt5BK+u5U9oOkMdMBdd23Qwzkv1vbY2WEGumMP3CbFSuDNiNONfuF8J23iQ90LN7WVl2dIAI+BZ9Jlm8GV7nVPpoCOYDROtyqvrXGTGW3rQiYWA1RR6JjwazOnUejspeX2RzzBOpwMYOseZV7Xubu0IbvFOkDyJTyNDmbKoDh73TRNZ9md76FyvfNwllQVbaTRXTIdG64EHirU1tjX0+jIiDmP6i3lzFsui9AoScbGfqCl4XBHga21HQ7izel+0wXzRCpQ8D6pM61C7IdjtE8NdFFae/zmStqOjV/pbusvEdpCrUyfURDvLnsXPmvb5iihy0Dg2iz8WtDAYSqc9KiI+sgftSZTcdmN7i8rQ6AW8K9Ha5jfjYf9prlduhocULH0sPQSKTlwqLwd/yb0+p5WKwcRmnc+j0j9Z0oJEXdQHcqnEqC0yxpDJff1muelx4FnBwC5yVr/roKvh7csU0/eai/YY4W0yYTsb1u6my+nb35L07CCgp7EUn03h2BisScqv0z+UlPHQ2AmnsVpptls1MB4ZkAi/QI/NgBIj052raFLhEuZHoNQU60o5IqdXaiEDjwvxi7TleKEp+vJORp9G8gmh
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(82310400026)(1800799024)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c4KAdJ12C1/o1sqtcnpwMbsYoUKpGTCTgn1UyIRTcQ5j00HWskPp/1p2H2Llwy+AOFeQbe1ssTvNRfyyQ2YVspsXM0PJXpdMVgagqhdpCPIwsLC3To+7h2QWINw0L5jALb17bqMdXoalf8qCnLlfDvQG3480ABm4FK3nqt6WAmw5zi89armDMIITEo+M+qbOtydVNCodIdUDIdcIIXXr+lv0TGqMmSKUqnDZUdWueGD/gPYgl2c1hJLIk6TgVk+G1ZIk06GHIRW4OpiEVebKq+u77vep89+MnnZHQC3rI7mqotLLqCoUCD0mEsdxHGGXVXdtuS2PS7qe6XRRCVZkjGOlJ5TRZs819yUsy6Dy+d6Mv/z9Kg4aKOgJBL6uzEmuMqqpbeanKfHFKBkYiuHn3avSKdWaZrtFflE4ZMsme3Xu70+X6oZyYzGEA8B6XqZ9
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:21.2814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7e735d-eb5a-4d88-3d81-08deddf909d3
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7567
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
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-6809-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EA207355BB

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ahash algorithms for HMAC-SHA-224, HMAC-SHA-256,
HMAC-SHA-384, HMAC-SHA-512, HMAC-SHA3-224, HMAC-SHA3-256,
HMAC-SHA3-384, and HMAC-SHA3-512 using the CMH hash core.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 drivers/crypto/cmh/Makefile           |   3 +-
 drivers/crypto/cmh/cmh_hmac.c         | 684 ++++++++++++++++++++++++++
 drivers/crypto/cmh/cmh_main.c         |   9 +
 drivers/crypto/cmh/include/cmh_hmac.h |  16 +
 4 files changed, 711 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/cmh/cmh_hmac.c
 create mode 100644 drivers/crypto/cmh/include/cmh_hmac.h

diff --git a/drivers/crypto/cmh/Makefile b/drivers/crypto/cmh/Makefile
index c0531f416229..1f760c0214ef 100644
--- a/drivers/crypto/cmh/Makefile
+++ b/drivers/crypto/cmh/Makefile
@@ -15,7 +15,8 @@ cmh-y := \
 	cmh_sysfs.o \
 	cmh_key.o \
 	cmh_sys.o \
-	cmh_hash.o
+	cmh_hash.o \
+	cmh_hmac.o
 
 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) += \
diff --git a/drivers/crypto/cmh/cmh_hmac.c b/drivers/crypto/cmh/cmh_hmac.c
new file mode 100644
index 000000000000..1f536088eabf
--- /dev/null
+++ b/drivers/crypto/cmh/cmh_hmac.c
@@ -0,0 +1,684 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API HMAC Driver
+ *
+ * Registers HMAC ahash algorithms with the Linux crypto subsystem.
+ * Supports HMAC-SHA-2 (224/256/384/512) and HMAC-SHA-3 (224/256/384/512)
+ * using the CMH Hash Core (HC) via HC_CMD_HMAC.
+ *
+ * Uses the same self-contained transaction model as cmh_hash.c:
+ *   .setkey() -> store raw key bytes
+ *   .init()   -> software-only: initialize per-request context
+ *   .update() -> software-only: copy SG data into per-call chunk
+ *   .final()  -> [SYS_CMD_WRITE] + HC_CMD_HMAC + [GATHER] + FINAL + FLUSH
+ *
+ * Raw-key atomicity: SYS_CMD_WRITE to SYS_REF_TEMP is packed into
+ * the same VCQ as HC_CMD_HMAC (see cmh_key.h for details).
+ *
+ * ahash .export()/.import() (state cloning): supported at the
+ * software accumulation level only.  The HW hash core does NOT
+ * support save/restore of intermediate HMAC state (SHA3 sponge
+ * invertibility, SHA2 blocked for consistency).  Since this driver
+ * accumulates all input data in kernel memory before submitting
+ * atomically in .final(), export/import simply serializes the
+ * input queue -- no keying material or HW state is exposed.
+ *
+ * All HMAC data is accumulated in kernel memory and capped at
+ * HMAC_MAX_DATA (64 KB).
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/crypto.h>
+#include <crypto/internal/hash.h>
+#include <crypto/hash.h>
+#include <linux/scatterlist.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include "cmh_hmac.h"
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
+ * HMAC save/restore is intentionally unsupported (see file header),
+ * so all data must be buffered in kernel memory and submitted
+ * atomically in .final().  This cap prevents unbounded allocation.
+ */
+#define HMAC_MAX_DATA		(64 * 1024)
+
+/* Algorithm Table */
+
+struct cmh_hmac_alg_info {
+	u32         hc_algo;        /* HC_ALGO_* */
+	u32         digest_size;    /* bytes */
+	u32         block_size;     /* cra_blocksize */
+	const char *alg_name;       /* Linux crypto name: "hmac(sha256)" */
+	const char *drv_name;       /* driver name: "cri-cmh-hmac-sha256" */
+};
+
+static const struct cmh_hmac_alg_info cmh_hmac_algs_info[] = {
+	/* HMAC-SHA-2 family */
+	{
+		.hc_algo     = HC_ALGO_SHA2_224,
+		.digest_size = CMH_SHA224_DIGEST_SIZE,
+		.block_size  = 64,
+		.alg_name    = "hmac(sha224)",
+		.drv_name    = "cri-cmh-hmac-sha224",
+	},
+	{
+		.hc_algo     = HC_ALGO_SHA2_256,
+		.digest_size = CMH_SHA256_DIGEST_SIZE,
+		.block_size  = 64,
+		.alg_name    = "hmac(sha256)",
+		.drv_name    = "cri-cmh-hmac-sha256",
+	},
+	{
+		.hc_algo     = HC_ALGO_SHA2_384,
+		.digest_size = CMH_SHA384_DIGEST_SIZE,
+		.block_size  = 128,
+		.alg_name    = "hmac(sha384)",
+		.drv_name    = "cri-cmh-hmac-sha384",
+	},
+	{
+		.hc_algo     = HC_ALGO_SHA2_512,
+		.digest_size = CMH_SHA512_DIGEST_SIZE,
+		.block_size  = 128,
+		.alg_name    = "hmac(sha512)",
+		.drv_name    = "cri-cmh-hmac-sha512",
+	},
+	/* HMAC-SHA-3 family */
+	{
+		.hc_algo     = HC_ALGO_SHA3_224,
+		.digest_size = CMH_SHA3_224_DIGEST_SIZE,
+		.block_size  = 144,
+		.alg_name    = "hmac(sha3-224)",
+		.drv_name    = "cri-cmh-hmac-sha3-224",
+	},
+	{
+		.hc_algo     = HC_ALGO_SHA3_256,
+		.digest_size = CMH_SHA3_256_DIGEST_SIZE,
+		.block_size  = 136,
+		.alg_name    = "hmac(sha3-256)",
+		.drv_name    = "cri-cmh-hmac-sha3-256",
+	},
+	{
+		.hc_algo     = HC_ALGO_SHA3_384,
+		.digest_size = CMH_SHA3_384_DIGEST_SIZE,
+		.block_size  = 104,
+		.alg_name    = "hmac(sha3-384)",
+		.drv_name    = "cri-cmh-hmac-sha3-384",
+	},
+	{
+		.hc_algo     = HC_ALGO_SHA3_512,
+		.digest_size = CMH_SHA3_512_DIGEST_SIZE,
+		.block_size  = 72,
+		.alg_name    = "hmac(sha3-512)",
+		.drv_name    = "cri-cmh-hmac-sha3-512",
+	},
+};
+
+#define CMH_HMAC_ALG_COUNT  ARRAY_SIZE(cmh_hmac_algs_info)
+
+/* Per-Request State */
+
+struct cmh_hmac_chunk {
+	struct list_head  list;
+	struct list_head  tfm_node; /* per-tfm orphan tracking */
+	u32               len;
+	u8                data[];
+};
+
+/*
+ * Maximum payload commands any HMAC transaction can produce:
+ *   [SYS_CMD_WRITE] + HC_CMD_HMAC + [GATHER] + FINAL + FLUSH = 5
+ * Worst-case packed output (stride=7, 1 payload per VCQ):
+ *   5 VCQs x 2 entries = 10
+ */
+#define CMH_HMAC_MAX_PAYLOAD    5
+#define CMH_HMAC_MAX_PACKED     (CMH_HMAC_MAX_PAYLOAD * 2)
+
+struct cmh_hmac_reqctx {
+	const struct cmh_hmac_alg_info *info;
+	int                             error;
+	struct list_head                chunks;
+	u32                             num_chunks;
+	u32                             total_len;
+	/* DMA state for async final */
+	dma_addr_t                      digest_dma;
+	dma_addr_t                      key_dma;
+	u8                             *digest_buf;
+	struct cmh_sg_map              *sgm;
+	u32                             keylen;
+	struct vcq_cmd packed[CMH_HMAC_MAX_PACKED];
+};
+
+/* Flat state for export/import -- holds accumulated input data only */
+struct cmh_hmac_export_state {
+	u32 total_len;
+	u8  data[];
+};
+
+/*
+ * Flat state buffer for export/import.  The CMH hash core does not
+ * support save/restore of intermediate HMAC state, so this driver
+ * accumulates input in SW and serialises the buffer on export.
+ *
+ * PAGE_SIZE (4096) caps the exportable accumulated-data window.
+ * Full-range export (up to HMAC_MAX_DATA = 64 KB) is not feasible
+ * because the crypto subsystem pre-allocates statesize bytes per
+ * request.  Export returns -EINVAL if the caller has accumulated
+ * more than CMH_HMAC_EXPORT_MAX.
+ */
+#define CMH_HMAC_STATE_SIZE 4096
+#define CMH_HMAC_EXPORT_MAX (CMH_HMAC_STATE_SIZE - sizeof(struct cmh_hmac_export_state))
+
+/* Per-Transform State (carries key across requests) */
+
+struct cmh_hmac_tfm_ctx {
+	struct cmh_key_ctx key;
+	spinlock_t         chunk_lock;  /* protects all_chunks */
+	struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* VCQ Builders (HMAC-specific; shared builders in cmh_hc_abi.h / cmh_vcq.h) */
+
+/* Add an HC_CMD_HMAC entry */
+static void vcq_add_hc_hmac(struct vcq_cmd *slot, u32 core_id, u64 key_ref,
+			    u32 keylen, u32 algo)
+{
+	memset(slot, 0, sizeof(*slot));
+	slot->magic = VCQ_CMD_MAGIC;
+	slot->id = VCQ_CMD_ID(core_id, 0, 1, HC_CMD_HMAC);
+	slot->hwc.hc.cmd_hmac.key = key_ref;
+	slot->hwc.hc.cmd_hmac.keylen = keylen;
+	slot->hwc.hc.cmd_hmac.algo = algo;
+}
+
+/* Request Context Cleanup */
+
+static void cmh_hmac_free_chunks(struct cmh_hmac_reqctx *rctx,
+				 struct cmh_hmac_tfm_ctx *tctx)
+{
+	struct cmh_hmac_chunk *chunk, *tmp;
+
+	spin_lock_bh(&tctx->chunk_lock);
+	list_for_each_entry_safe(chunk, tmp, &rctx->chunks, list) {
+		list_del(&chunk->list);
+		list_del(&chunk->tfm_node);
+		kfree_sensitive(chunk);
+	}
+	spin_unlock_bh(&tctx->chunk_lock);
+	rctx->num_chunks = 0;
+	rctx->total_len = 0;
+}
+
+/*
+ * Build a DMA-mapped CMH eSW scatter-gather chain from accumulated chunks.
+ */
+static struct cmh_sg_map *
+cmh_hmac_build_sg(struct cmh_hmac_reqctx *rctx, gfp_t gfp)
+{
+	struct cmh_dma_buf *bufs;
+	struct cmh_hmac_chunk *chunk;
+	struct cmh_sg_map *sgm;
+	u32 i;
+
+	bufs = kcalloc(rctx->num_chunks, sizeof(*bufs), gfp);
+	if (!bufs)
+		return NULL;
+
+	i = 0;
+	list_for_each_entry(chunk, &rctx->chunks, list) {
+		bufs[i].data = chunk->data;
+		bufs[i].len = chunk->len;
+		i++;
+	}
+
+	sgm = cmh_dma_build_sg(bufs, rctx->num_chunks, gfp);
+	kfree(bufs);
+	return sgm;
+}
+
+/* VCQ Packing + Submit */
+
+/* ahash Operations */
+
+struct cmh_hmac_alg_drv {
+	struct ahash_alg                  alg;
+	const struct cmh_hmac_alg_info   *info;
+};
+
+static const struct cmh_hmac_alg_info *
+cmh_hmac_get_info(struct crypto_ahash *tfm)
+{
+	struct ahash_alg *alg = crypto_ahash_alg(tfm);
+
+	return container_of(alg, struct cmh_hmac_alg_drv, alg)->info;
+}
+
+static int cmh_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
+			   unsigned int keylen)
+{
+	struct cmh_hmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+
+	return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_HC);
+}
+
+static int cmh_hmac_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_hmac_reqctx *rctx = ahash_request_ctx(req);
+
+	rctx->info = cmh_hmac_get_info(tfm);
+	rctx->error = 0;
+	INIT_LIST_HEAD(&rctx->chunks);
+	rctx->num_chunks = 0;
+	rctx->total_len = 0;
+
+	return 0;
+}
+
+static int cmh_hmac_update(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_hmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_hmac_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_hmac_chunk *chunk;
+	int nents;
+
+	if (rctx->error)
+		return rctx->error;
+
+	if (!req->nbytes)
+		return 0;
+
+	if (req->nbytes > HMAC_MAX_DATA - rctx->total_len) {
+		rctx->error = -EINVAL;
+		goto err_free_chunks;
+	}
+
+	chunk = kmalloc(sizeof(*chunk) + req->nbytes,
+			req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+			GFP_KERNEL : GFP_ATOMIC);
+	if (!chunk) {
+		rctx->error = -ENOMEM;
+		goto err_free_chunks;
+	}
+
+	chunk->len = req->nbytes;
+	if (req->base.flags & CRYPTO_AHASH_REQ_VIRT) {
+		memcpy(chunk->data, req->svirt, req->nbytes);
+	} else {
+		nents = sg_nents_for_len(req->src, req->nbytes);
+		if (nents < 0 ||
+		    sg_copy_to_buffer(req->src, nents,
+				      chunk->data, req->nbytes) != req->nbytes) {
+			kfree_sensitive(chunk);
+			rctx->error = -EINVAL;
+			goto err_free_chunks;
+		}
+	}
+
+	list_add_tail(&chunk->list, &rctx->chunks);
+	spin_lock_bh(&tctx->chunk_lock);
+	list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+	spin_unlock_bh(&tctx->chunk_lock);
+	rctx->num_chunks++;
+	rctx->total_len += req->nbytes;
+
+	return 0;
+
+err_free_chunks:
+	/*
+	 * Terminal error -- free all previously accumulated chunks.
+	 * The crypto API hash path does not call .final()
+	 * on error, and hash_sock_destruct has no per-request
+	 * destructor, so chunks would be orphaned otherwise.
+	 */
+	cmh_hmac_free_chunks(rctx, tctx);
+	return rctx->error;
+}
+
+static void cmh_hmac_complete(void *data, int error)
+{
+	struct ahash_request *req = data;
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_hmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_hmac_reqctx *rctx = ahash_request_ctx(req);
+
+	if (error == -EINPROGRESS) {
+		cmh_complete(&req->base, error);
+		return;
+	}
+
+	cmh_dma_unmap_single(rctx->digest_dma, rctx->info->digest_size,
+			     DMA_FROM_DEVICE);
+
+	if (!error)
+		memcpy(req->result, rctx->digest_buf,
+		       rctx->info->digest_size);
+
+	kfree(rctx->digest_buf);
+	rctx->digest_buf = NULL;
+	cmh_dma_free_sg(rctx->sgm);
+	rctx->sgm = NULL;
+	cmh_hmac_free_chunks(rctx, tctx);
+	cmh_complete(&req->base, error);
+}
+
+static int cmh_hmac_final(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_hmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_hmac_reqctx *rctx = ahash_request_ctx(req);
+	const struct cmh_hmac_alg_info *info = rctx->info;
+	struct vcq_cmd cmds[CMH_HMAC_MAX_PAYLOAD];
+	struct cmh_sg_map *sgm = NULL;
+	dma_addr_t digest_dma = DMA_MAPPING_ERROR, key_dma = DMA_MAPPING_ERROR;
+	u8 *digest_buf;
+	u64 key_ref;
+	u32 keylen;
+	struct core_dispatch d;
+	s32 target_mbx;
+	u32 core_id;
+	u32 idx;
+	int ret;
+	gfp_t gfp = req->base.flags & CRYPTO_TFM_REQ_MAY_SLEEP ?
+		   GFP_KERNEL : GFP_ATOMIC;
+
+	if (rctx->error) {
+		ret = rctx->error;
+		goto out_free;
+	}
+
+	if (tctx->key.mode == CMH_KEY_NONE) {
+		ret = -ENOKEY;
+		goto out_free;
+	}
+
+	if (rctx->num_chunks > 0) {
+		sgm = cmh_hmac_build_sg(rctx, gfp);
+		if (!sgm) {
+			ret = -ENOMEM;
+			goto out_free;
+		}
+	}
+
+	digest_buf = kzalloc(info->digest_size, gfp);
+	if (!digest_buf) {
+		ret = -ENOMEM;
+		goto out_free_sg;
+	}
+	digest_dma = cmh_dma_map_single(digest_buf, info->digest_size,
+					DMA_FROM_DEVICE);
+	if (cmh_dma_map_error(digest_dma)) {
+		ret = -ENOMEM;
+		goto out_free_digest;
+	}
+
+	/* Resolve key reference */
+	idx = 0;
+
+	/*
+	 * Raw key: pack SYS_CMD_WRITE(SYS_REF_TEMP) into the
+	 * same VCQ so the key write + HMAC are atomic.
+	 */
+	key_dma = tctx->key.raw.dma;
+	vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP, (u64)key_dma,
+			  SYS_REF_NONE, tctx->key.raw.len,
+			  tctx->key.raw.sys_type);
+	key_ref = SYS_REF_TEMP;
+	keylen = tctx->key.raw.len;
+	d = cmh_core_select_instance(CMH_CORE_HC);
+
+	target_mbx = d.mbx_idx;
+
+	core_id = d.core_id;
+
+	vcq_add_hc_hmac(&cmds[idx++], core_id, key_ref, keylen, info->hc_algo);
+
+	if (sgm)
+		vcq_add_hc_gather(&cmds[idx++], core_id, (u64)sgm->items_dma,
+				  HC_CMD_UPDATE);
+
+	vcq_add_hc_final(&cmds[idx++], core_id, (u64)digest_dma, info->digest_size);
+	vcq_add_flush(&cmds[idx++], core_id);
+
+	rctx->digest_buf = digest_buf;
+	rctx->digest_dma = digest_dma;
+	rctx->sgm = sgm;
+
+	ret = cmh_vcq_pack_and_submit_async(cmds, idx, rctx->packed,
+					    CMH_HMAC_MAX_PACKED,
+					    target_mbx,
+					    cmh_hmac_complete, req,
+					    !!(req->base.flags &
+					       CRYPTO_TFM_REQ_MAY_BACKLOG),
+					    cmh_tm_async_timeout_jiffies());
+	if (ret == -EBUSY)
+		return -EBUSY;
+	if (ret)
+		goto out_cleanup_all;
+
+	return -EINPROGRESS;
+
+out_cleanup_all:
+	cmh_dma_unmap_single(digest_dma, info->digest_size,
+			     DMA_FROM_DEVICE);
+out_free_digest:
+	kfree(digest_buf);
+
+out_free_sg:
+	cmh_dma_free_sg(sgm);
+
+out_free:
+	cmh_hmac_free_chunks(rctx, tctx);
+	return ret;
+}
+
+static int cmh_hmac_finup(struct ahash_request *req)
+{
+	int ret;
+
+	ret = cmh_hmac_update(req);
+	if (ret)
+		return ret;
+
+	return cmh_hmac_final(req);
+}
+
+static int cmh_hmac_digest(struct ahash_request *req)
+{
+	int ret;
+
+	ret = cmh_hmac_init(req);
+	if (ret)
+		return ret;
+
+	return cmh_hmac_finup(req);
+}
+
+/*
+ * ahash .export()/.import(): serialize/deserialize the software
+ * accumulation buffer.  No HW state is involved.
+ */
+
+static int cmh_hmac_export(struct ahash_request *req, void *out)
+{
+	struct cmh_hmac_reqctx *rctx = ahash_request_ctx(req);
+	struct cmh_hmac_export_state *state = out;
+	struct cmh_hmac_chunk *chunk;
+	u32 offset = 0;
+
+	if (rctx->total_len > CMH_HMAC_EXPORT_MAX)
+		return -ENOSPC;
+
+	state->total_len = rctx->total_len;
+	list_for_each_entry(chunk, &rctx->chunks, list) {
+		memcpy(state->data + offset, chunk->data, chunk->len);
+		offset += chunk->len;
+	}
+	return 0;
+}
+
+static int cmh_hmac_import(struct ahash_request *req, const void *in)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct cmh_hmac_tfm_ctx *tctx = crypto_ahash_ctx(tfm);
+	struct cmh_hmac_reqctx *rctx = ahash_request_ctx(req);
+	const struct cmh_hmac_export_state *state = in;
+	struct cmh_hmac_chunk *chunk;
+
+	/*
+	 * Do NOT call free_chunks() here: the crypto API does not
+	 * guarantee the request context is in a valid state before
+	 * import(), so the list pointers may be stale or invalid.
+	 * Re-initialize from scratch instead.  Any pre-existing chunks
+	 * are tracked on tctx->all_chunks and freed in cra_exit.
+	 */
+	rctx->info = cmh_hmac_get_info(tfm);
+	rctx->error = 0;
+	INIT_LIST_HEAD(&rctx->chunks);
+	rctx->num_chunks = 0;
+	rctx->total_len = 0;
+
+	if (state->total_len > CMH_HMAC_EXPORT_MAX)
+		return -EINVAL;
+
+	if (state->total_len) {
+		chunk = kmalloc(sizeof(*chunk) + state->total_len, GFP_KERNEL);
+		if (!chunk)
+			return -ENOMEM;
+		chunk->len = state->total_len;
+		memcpy(chunk->data, state->data, state->total_len);
+		list_add_tail(&chunk->list, &rctx->chunks);
+		spin_lock_bh(&tctx->chunk_lock);
+		list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+		spin_unlock_bh(&tctx->chunk_lock);
+		rctx->num_chunks = 1;
+		rctx->total_len = state->total_len;
+	}
+	return 0;
+}
+
+/* Transform init/exit (cra_init/cra_exit) */
+
+static int cmh_hmac_cra_init(struct crypto_tfm *tfm)
+{
+	struct cmh_hmac_tfm_ctx *tctx = crypto_tfm_ctx(tfm);
+
+	memset(tctx, 0, sizeof(*tctx));
+	tctx->key.mode = CMH_KEY_NONE;
+	spin_lock_init(&tctx->chunk_lock);
+	INIT_LIST_HEAD(&tctx->all_chunks);
+	crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+				 sizeof(struct cmh_hmac_reqctx));
+	return 0;
+}
+
+static void cmh_hmac_cra_exit(struct crypto_tfm *tfm)
+{
+	struct cmh_hmac_tfm_ctx *tctx = crypto_tfm_ctx(tfm);
+	struct cmh_hmac_chunk *chunk, *tmp;
+
+	/* Free any orphaned chunks (e.g. testmgr export/reimport poison) */
+	spin_lock_bh(&tctx->chunk_lock);
+	list_for_each_entry_safe(chunk, tmp, &tctx->all_chunks, tfm_node) {
+		list_del(&chunk->tfm_node);
+		kfree_sensitive(chunk);
+	}
+	spin_unlock_bh(&tctx->chunk_lock);
+
+	cmh_key_destroy(&tctx->key);
+}
+
+/* Registration */
+
+static struct cmh_hmac_alg_drv cmh_hmac_drvs[CMH_HMAC_ALG_COUNT];
+
+/**
+ * cmh_hmac_register() - Register HMAC-SHA hash algorithms with the crypto framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_hmac_register(void)
+{
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < CMH_HMAC_ALG_COUNT; i++) {
+		const struct cmh_hmac_alg_info *info = &cmh_hmac_algs_info[i];
+		struct cmh_hmac_alg_drv *drv = &cmh_hmac_drvs[i];
+		struct ahash_alg *alg = &drv->alg;
+
+		drv->info = info;
+
+		alg->init   = cmh_hmac_init;
+		alg->update = cmh_hmac_update;
+		alg->final  = cmh_hmac_final;
+		alg->finup  = cmh_hmac_finup;
+		alg->digest = cmh_hmac_digest;
+		alg->export = cmh_hmac_export;
+		alg->import = cmh_hmac_import;
+		alg->setkey = cmh_hmac_setkey;
+
+		alg->halg.digestsize = info->digest_size;
+		alg->halg.statesize  = CMH_HMAC_STATE_SIZE;
+
+		strscpy(alg->halg.base.cra_name, info->alg_name,
+			CRYPTO_MAX_ALG_NAME);
+		strscpy(alg->halg.base.cra_driver_name, info->drv_name,
+			CRYPTO_MAX_ALG_NAME);
+		alg->halg.base.cra_priority    = 300;
+		alg->halg.base.cra_flags       = CRYPTO_ALG_KERN_DRIVER_ONLY |
+						 CRYPTO_ALG_NO_FALLBACK |
+						 CRYPTO_ALG_ASYNC |
+						 CRYPTO_ALG_REQ_VIRT;
+		alg->halg.base.cra_blocksize   = info->block_size;
+		alg->halg.base.cra_ctxsize     = sizeof(struct cmh_hmac_tfm_ctx);
+		alg->halg.base.cra_init        = cmh_hmac_cra_init;
+		alg->halg.base.cra_exit        = cmh_hmac_cra_exit;
+		alg->halg.base.cra_module      = THIS_MODULE;
+
+		ret = crypto_register_ahash(alg);
+		if (ret) {
+			dev_err(cmh_dev(), "hmac: failed to register %s (rc=%d)\n",
+				info->drv_name, ret);
+			while (i--)
+				crypto_unregister_ahash(&cmh_hmac_drvs[i].alg);
+			return ret;
+		}
+
+		dev_dbg(cmh_dev(), "hmac: registered %s (priority 300)\n",
+			info->drv_name);
+	}
+
+	dev_info(cmh_dev(), "hmac: %zu algorithm(s) registered\n",
+		 CMH_HMAC_ALG_COUNT);
+	return 0;
+}
+
+/**
+ * cmh_hmac_unregister() - Unregister HMAC-SHA hash algorithms from the crypto framework
+ */
+void cmh_hmac_unregister(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < CMH_HMAC_ALG_COUNT; i++) {
+		crypto_unregister_ahash(&cmh_hmac_drvs[i].alg);
+		dev_dbg(cmh_dev(), "hmac: unregistered %s\n",
+			cmh_hmac_algs_info[i].drv_name);
+	}
+
+	dev_info(cmh_dev(), "hmac: cleaned up\n");
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index dea019346567..618c981e3997 100644
--- a/drivers/crypto/cmh/cmh_main.c
+++ b/drivers/crypto/cmh/cmh_main.c
@@ -30,6 +30,7 @@
 #include "cmh_txn.h"
 #include "cmh_rh.h"
 #include "cmh_hash.h"
+#include "cmh_hmac.h"
 #include "cmh_mgmt.h"
 #include "cmh_registers.h"
 #include "cmh_debugfs.h"
@@ -203,6 +204,11 @@ static int cmh_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_hash_register;
 
+	/* Register HMAC hash algorithms */
+	ret = cmh_hmac_register();
+	if (ret)
+		goto err_hmac_register;
+
 	/* Register key management device (/dev/cmh_mgmt) */
 	ret = cmh_mgmt_register();
 	if (ret)
@@ -215,6 +221,8 @@ static int cmh_probe(struct platform_device *pdev)
 	return 0;
 
 err_mgmt_register:
+	cmh_hmac_unregister();
+err_hmac_register:
 	cmh_hash_unregister();
 err_hash_register:
 	cmh_rh_cleanup(cfg);
@@ -243,6 +251,7 @@ static void cmh_remove(struct platform_device *pdev)
 	cfg = &dev->config;
 
 	cmh_mgmt_unregister();
+	cmh_hmac_unregister();
 	cmh_hash_unregister();
 	cmh_rh_cleanup(cfg);
 	cmh_tm_cleanup();
diff --git a/drivers/crypto/cmh/include/cmh_hmac.h b/drivers/crypto/cmh/include/cmh_hmac.h
new file mode 100644
index 000000000000..fb1a11fb76eb
--- /dev/null
+++ b/drivers/crypto/cmh/include/cmh_hmac.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026 Cryptography Research, Inc. (CRI).
+ * CMH LKM -- Kernel Crypto API HMAC Driver
+ *
+ * Registers HMAC ahash algorithms (HMAC-SHA-2, HMAC-SHA-3) with the
+ * Linux crypto subsystem using HC_CMD_HMAC.
+ */
+
+#ifndef CMH_HMAC_H
+#define CMH_HMAC_H
+
+int  cmh_hmac_register(void);
+void cmh_hmac_unregister(void);
+
+#endif /* CMH_HMAC_H */
-- 
2.43.7


