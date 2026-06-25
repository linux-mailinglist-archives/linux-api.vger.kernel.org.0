Return-Path: <linux-api+bounces-6693-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id suLTNl1nPWqN2ggAu9opvQ
	(envelope-from <linux-api+bounces-6693-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:37:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E25B6C7DE1
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 19:37:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=PILasnqH;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6693-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6693-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=rambus.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 322E530F0995
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F08A3EEACE;
	Thu, 25 Jun 2026 17:34:21 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020074.outbound.protection.outlook.com [52.101.56.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32E3ED13F;
	Thu, 25 Jun 2026 17:34:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408861; cv=fail; b=pqhNZkrV3rvbnPfCIFNmUJEjDlyD64nTg/kfi30ghMuh8JmmMfshd5S/hM9mCFh3Cwl+do38tvnj4ch0gSWZ3WsMk5Ik32d3Sf7PasnFAq5oWZonSl72TMZn2TLoZPxtTAq66xm5ooPVn+ZU7wxOlqyxIHSNBYQ6KXxkmLN0cNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408861; c=relaxed/simple;
	bh=xLoeMHfx0MJwDPAF2nMNuDgqQrM/9RnFkn9QgGrDELg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2SrD2CijrjeZnISmJgssRrns5ibgbzIbI8K9LLF+nJV4qkf3cjf4JM3qtM+9V6dmmUiS/d77IHW5k5v2AVriF2kyQmAbdFLG5/vczL9rQxCTSh94LFf2xcc5LAIfEhRTxdEMtZPMOslJm510zmaw6UyXAbWTLJoeNHAXQfjBLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=PILasnqH; arc=fail smtp.client-ip=52.101.56.74
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkjxW+JI/1WFrqo5N47/y1Ta1W5XS2tqEia4NWmjbQCiW0ybllKhEO9d1iPrZhfk8x7Le/YQ6+XwHrexTCd6TEl3+4GrsOaqGuTFpIbA23vk2pAcDJmVbjFxYl0wzG95rp2V3HeuREeHLJ/LSKnQ+YbTDqWM9+jXbWVK0tlvrnp0/i76wW84fAgdFBj3VNvVkgGoQ0drb8M9sNwLnOrGfIhVZbyeddDrRIrx+3EorkPAJk5mGSEmd9PTYTkMKWyoO0cVufny8yC51egifxBMUarTz6JZb024/Sl48UZGSGF2jI4xe0jov1FVhYbBvNxIyt4uovn/Rv8DbeBf2hay2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ocNC4lnov5ZFcyrsgAmb1QwtSldwAfMVDmL8Ugsu6o=;
 b=tVHXCG+pTChNtau+FBzGNRpC5SsWiMIb3CMUSeqjaiWcEDqPLLtTze/FoLQrkpZCWGTakSDO+5XoRkSWA/4UroY13Z7nYNYlhyU740A5UcvsL9sTrYxSdYXGEaqELHdHsoHN4/seCwvG0egiPlxc+Hq3yTmRUXhrth5nR5J7Rrh7x1wJZAOv3sFWc/nsl21QZAtBTZYDhQxlZYA5O1r4W1jTzM6E578Ies8qzOadz1GJamqC2fvGRleXx8XEMaN8rbDw/9n1alDhIpE9fBpIfCIVBdlAZxwzl16kFoLR9UMwmlhlLn6Ca8YdEOJRBNU8/9zBL3Y4WnejEDifDCTNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ocNC4lnov5ZFcyrsgAmb1QwtSldwAfMVDmL8Ugsu6o=;
 b=PILasnqH7/NFcJUl6CB6IxKw362c7MM7ne5jTK5p1MKWRfpZdXEQ4D3C8JD+54cdwyj3xILsmsvm6F1Ayou5FZiARJXLCkk53v59NMlwDJrPflMowchBizcZc8SZezdtcalHqKx5VqcgE+Nh1UczNx+rudLu1n5z9ixQUvd9zbvXyZVX34Cyxzr2wltCFW3cXUdoL340IdinEodSfnt936eAjsuDZ62oR01J8ukhgWUDXS+5YS1joJt+zQwH6lRM/e1xiBB6K0BPGf3vrZDLhzD84foJ3xHnoaLh9lnfcK2SEnGT/wsr5zIHE5lW3Mn/nnvuKoDWrEbkgrCQPWs1CQ==
Received: from PH0PR07CA0112.namprd07.prod.outlook.com (2603:10b6:510:4::27)
 by BN8PR04MB6467.namprd04.prod.outlook.com (2603:10b6:408:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 25 Jun
 2026 17:34:09 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::ad) by PH0PR07CA0112.outlook.office365.com
 (2603:10b6:510:4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 17:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 17:34:08 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 8BBAA1801757;
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
Subject: [PATCH 05/19] crypto: cmh - add HMAC ahash
Date: Thu, 25 Jun 2026 10:33:13 -0700
Message-ID: <20260625173328.1140487-6-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|BN8PR04MB6467:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b5361133-6be9-4af2-ae9b-08ded2dff63a
X-LD-Processed: bd0ba799-c2b9-413c-9c56-5d1731c4827c,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|1800799024|82310400026|22082099003|18002099003|3023799007|921020|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	g4XDQL/eF6+Wdxh/GDy+JLM2VUIfVZAVfY8F+rCE46qKwSSyZJJfMJqm9gFUChq6+bLzBZV7U6ztcQACAGzoJtZCuI4EGhswJ8lun/V1q7bJyEPt/ujsnaEAKJ31VmMbcgF6fr9CgDw/zeYFXfca9FrVevHR7LBDPL8rip66dTdHk9MuvuAGjs1oY2Tmw0lPnaUgZx2KPmr0JbyaJyMXNHhOpHFWvz1rEHTGodMFfotPO5BrQkiVa0PN5qYguNqzfscEzlAUbLSzuDOY8WF/fEAGyESRq8djL0hDFwWhs2pw9k/yRk+64I7qhHQzQAAXSgf/ZgJkVGQruioVbefInfx0v/g9q1cTrZhhYpU6GovuroICNlNkAmM1V0SKDePW38gTAL0KX1mHG6hmwgdUj+fedLP6FWwtWvJo2Lv86hpvrmZuF15nhOyzzYK1i68/sPhCvlPreZZbz4SyHTJVmCdd+3PubI8Mzzv1jNM42zqz+hkOLShVQ1gsfWHRXG5o3xGKWY+C2wXMmPxTEEo5eFS9rzELD5YthOHQNZWCDr+ovHYiQJqwdIFOf98hvmfIXj31xtMiBwfmLJu4SuM1xeh896jEHO8ua45YLGOG0q+NfmcvRDOK/xw7bMYOohvk0ZT6brfO72VPiC0q/qdXqmSL+UocqhF5Q3q/9jCtxKHLj4WYwsmcJkaGD3cKXpKpu3re9v2RlIzpaxByMdeYm/VG4fIYvWlY9gBdyLgqBlRlBYGn1QzKr1egdAYEL+o0
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(1800799024)(82310400026)(22082099003)(18002099003)(3023799007)(921020)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sXuq7Xd8UPptrgquwaqL8Ff0gu9yAZZRAYr+ENf2Eka4ARhs1cvZnjdeLUPvFFXjH7ROkSkERL9YOgfn2eST9nJf4yWYmHecoMm93VCtplGB20wW1FsxtC1fCamH78be83zSygU9nsJ06dClBCXwSBoIekOgTwOKxj0Q3Bg8adExixna31VdaPlOdj+OSFXpw3k/T80V4gmgQFfyfcP6UZBmDtYkcMcZXvZUjHFax6RqPr/s/BSVDzR4q3SJ5oA3iijTq/YD8rKDCXUSWjaN91uF1JXA5A5TBxpnszxuzF9aRpmbanPTTO4nBDsW3++fqAQx21dyzKpYpZSfz5SwQGqvl0egAiGPLbxHgk7zH56Pj+AhuEz1AQ9Q8BP1ABlrjGpF/iP115NXc0x9ZLWJ7kV0m/ewE45HyZKbfoWf0p8yMxSIvuCrvMurAL+zTGDI
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 17:34:08.2107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5361133-6be9-4af2-ae9b-08ded2dff63a
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6467
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
	TAGGED_FROM(0.00)[bounces-6693-lists,linux-api=lfdr.de];
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
X-Rspamd-Queue-Id: 7E25B6C7DE1

From: Alex Ousherovitch <aousherovitch@rambus.com>

Register ahash algorithms for HMAC-SHA-224, HMAC-SHA-256,
HMAC-SHA-384, HMAC-SHA-512, HMAC-SHA3-224, HMAC-SHA3-256,
HMAC-SHA3-384, and HMAC-SHA3-512 using the CMH hash core.

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.co=
m>
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
@@ -15,7 +15,8 @@ cmh-y :=3D \
        cmh_sysfs.o \
        cmh_key.o \
        cmh_sys.o \
-       cmh_hash.o
+       cmh_hash.o \
+       cmh_hmac.o

 # Management ioctl device (/dev/cmh_mgmt): key lifecycle, PKE, PQC ioctls.
 cmh-$(CONFIG_CRYPTO_DEV_CMH_MGMT) +=3D \
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
+#define HMAC_MAX_DATA          (64 * 1024)
+
+/* Algorithm Table */
+
+struct cmh_hmac_alg_info {
+       u32         hc_algo;        /* HC_ALGO_* */
+       u32         digest_size;    /* bytes */
+       u32         block_size;     /* cra_blocksize */
+       const char *alg_name;       /* Linux crypto name: "hmac(sha256)" */
+       const char *drv_name;       /* driver name: "cri-cmh-hmac-sha256" *=
/
+};
+
+static const struct cmh_hmac_alg_info cmh_hmac_algs_info[] =3D {
+       /* HMAC-SHA-2 family */
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_224,
+               .digest_size =3D CMH_SHA224_DIGEST_SIZE,
+               .block_size  =3D 64,
+               .alg_name    =3D "hmac(sha224)",
+               .drv_name    =3D "cri-cmh-hmac-sha224",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_256,
+               .digest_size =3D CMH_SHA256_DIGEST_SIZE,
+               .block_size  =3D 64,
+               .alg_name    =3D "hmac(sha256)",
+               .drv_name    =3D "cri-cmh-hmac-sha256",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_384,
+               .digest_size =3D CMH_SHA384_DIGEST_SIZE,
+               .block_size  =3D 128,
+               .alg_name    =3D "hmac(sha384)",
+               .drv_name    =3D "cri-cmh-hmac-sha384",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA2_512,
+               .digest_size =3D CMH_SHA512_DIGEST_SIZE,
+               .block_size  =3D 128,
+               .alg_name    =3D "hmac(sha512)",
+               .drv_name    =3D "cri-cmh-hmac-sha512",
+       },
+       /* HMAC-SHA-3 family */
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_224,
+               .digest_size =3D CMH_SHA3_224_DIGEST_SIZE,
+               .block_size  =3D 144,
+               .alg_name    =3D "hmac(sha3-224)",
+               .drv_name    =3D "cri-cmh-hmac-sha3-224",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_256,
+               .digest_size =3D CMH_SHA3_256_DIGEST_SIZE,
+               .block_size  =3D 136,
+               .alg_name    =3D "hmac(sha3-256)",
+               .drv_name    =3D "cri-cmh-hmac-sha3-256",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_384,
+               .digest_size =3D CMH_SHA3_384_DIGEST_SIZE,
+               .block_size  =3D 104,
+               .alg_name    =3D "hmac(sha3-384)",
+               .drv_name    =3D "cri-cmh-hmac-sha3-384",
+       },
+       {
+               .hc_algo     =3D HC_ALGO_SHA3_512,
+               .digest_size =3D CMH_SHA3_512_DIGEST_SIZE,
+               .block_size  =3D 72,
+               .alg_name    =3D "hmac(sha3-512)",
+               .drv_name    =3D "cri-cmh-hmac-sha3-512",
+       },
+};
+
+#define CMH_HMAC_ALG_COUNT  ARRAY_SIZE(cmh_hmac_algs_info)
+
+/* Per-Request State */
+
+struct cmh_hmac_chunk {
+       struct list_head  list;
+       struct list_head  tfm_node; /* per-tfm orphan tracking */
+       u32               len;
+       u8                data[];
+};
+
+/*
+ * Maximum payload commands any HMAC transaction can produce:
+ *   [SYS_CMD_WRITE] + HC_CMD_HMAC + [GATHER] + FINAL + FLUSH =3D 5
+ * Worst-case packed output (stride=3D7, 1 payload per VCQ):
+ *   5 VCQs x 2 entries =3D 10
+ */
+#define CMH_HMAC_MAX_PAYLOAD    5
+#define CMH_HMAC_MAX_PACKED     (CMH_HMAC_MAX_PAYLOAD * 2)
+
+struct cmh_hmac_reqctx {
+       const struct cmh_hmac_alg_info *info;
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
+       struct vcq_cmd packed[CMH_HMAC_MAX_PACKED];
+};
+
+/* Flat state for export/import -- holds accumulated input data only */
+struct cmh_hmac_export_state {
+       u32 total_len;
+       u8  data[];
+};
+
+/*
+ * Flat state buffer for export/import.  The CMH hash core does not
+ * support save/restore of intermediate HMAC state, so this driver
+ * accumulates input in SW and serialises the buffer on export.
+ *
+ * PAGE_SIZE (4096) caps the exportable accumulated-data window.
+ * Full-range export (up to HMAC_MAX_DATA =3D 64 KB) is not feasible
+ * because the crypto subsystem pre-allocates statesize bytes per
+ * request.  Export returns -EINVAL if the caller has accumulated
+ * more than CMH_HMAC_EXPORT_MAX.
+ */
+#define CMH_HMAC_STATE_SIZE 4096
+#define CMH_HMAC_EXPORT_MAX (CMH_HMAC_STATE_SIZE - sizeof(struct cmh_hmac_=
export_state))
+
+/* Per-Transform State (carries key across requests) */
+
+struct cmh_hmac_tfm_ctx {
+       struct cmh_key_ctx key;
+       spinlock_t         chunk_lock;  /* protects all_chunks */
+       struct list_head   all_chunks;  /* orphan-safe chunk tracking */
+};
+
+/* VCQ Builders (HMAC-specific; shared builders in cmh_hc_abi.h / cmh_vcq.=
h) */
+
+/* Add an HC_CMD_HMAC entry */
+static void vcq_add_hc_hmac(struct vcq_cmd *slot, u32 core_id, u64 key_ref=
,
+                           u32 keylen, u32 algo)
+{
+       memset(slot, 0, sizeof(*slot));
+       slot->magic =3D VCQ_CMD_MAGIC;
+       slot->id =3D VCQ_CMD_ID(core_id, 0, 1, HC_CMD_HMAC);
+       slot->hwc.hc.cmd_hmac.key =3D key_ref;
+       slot->hwc.hc.cmd_hmac.keylen =3D keylen;
+       slot->hwc.hc.cmd_hmac.algo =3D algo;
+}
+
+/* Request Context Cleanup */
+
+static void cmh_hmac_free_chunks(struct cmh_hmac_reqctx *rctx,
+                                struct cmh_hmac_tfm_ctx *tctx)
+{
+       struct cmh_hmac_chunk *chunk, *tmp;
+
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(chunk, tmp, &rctx->chunks, list) {
+               list_del(&chunk->list);
+               list_del(&chunk->tfm_node);
+               kfree_sensitive(chunk);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+}
+
+/*
+ * Build a DMA-mapped CMH eSW scatter-gather chain from accumulated chunks=
.
+ */
+static struct cmh_sg_map *
+cmh_hmac_build_sg(struct cmh_hmac_reqctx *rctx, gfp_t gfp)
+{
+       struct cmh_dma_buf *bufs;
+       struct cmh_hmac_chunk *chunk;
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
+struct cmh_hmac_alg_drv {
+       struct ahash_alg                  alg;
+       const struct cmh_hmac_alg_info   *info;
+};
+
+static const struct cmh_hmac_alg_info *
+cmh_hmac_get_info(struct crypto_ahash *tfm)
+{
+       struct ahash_alg *alg =3D crypto_ahash_alg(tfm);
+
+       return container_of(alg, struct cmh_hmac_alg_drv, alg)->info;
+}
+
+static int cmh_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
+                          unsigned int keylen)
+{
+       struct cmh_hmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+
+       return cmh_key_setkey_raw(&tctx->key, key, keylen, CORE_ID_HC);
+}
+
+static int cmh_hmac_init(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_hmac_reqctx *rctx =3D ahash_request_ctx(req);
+
+       rctx->info =3D cmh_hmac_get_info(tfm);
+       rctx->error =3D 0;
+       INIT_LIST_HEAD(&rctx->chunks);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+
+       return 0;
+}
+
+static int cmh_hmac_update(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_hmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_hmac_reqctx *rctx =3D ahash_request_ctx(req);
+       struct cmh_hmac_chunk *chunk;
+       int nents;
+
+       if (rctx->error)
+               return rctx->error;
+
+       if (!req->nbytes)
+               return 0;
+
+       if (req->nbytes > HMAC_MAX_DATA - rctx->total_len) {
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
+                       kfree_sensitive(chunk);
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
+        * The crypto API hash path does not call .final()
+        * on error, and hash_sock_destruct has no per-request
+        * destructor, so chunks would be orphaned otherwise.
+        */
+       cmh_hmac_free_chunks(rctx, tctx);
+       return rctx->error;
+}
+
+static void cmh_hmac_complete(void *data, int error)
+{
+       struct ahash_request *req =3D data;
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_hmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_hmac_reqctx *rctx =3D ahash_request_ctx(req);
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
+       cmh_hmac_free_chunks(rctx, tctx);
+       cmh_complete(&req->base, error);
+}
+
+static int cmh_hmac_final(struct ahash_request *req)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_hmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_hmac_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_hmac_alg_info *info =3D rctx->info;
+       struct vcq_cmd cmds[CMH_HMAC_MAX_PAYLOAD];
+       struct cmh_sg_map *sgm =3D NULL;
+       dma_addr_t digest_dma =3D DMA_MAPPING_ERROR, key_dma =3D DMA_MAPPIN=
G_ERROR;
+       u8 *digest_buf;
+       u64 key_ref;
+       u32 keylen;
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
+               sgm =3D cmh_hmac_build_sg(rctx, gfp);
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
+       /*
+        * Raw key: pack SYS_CMD_WRITE(SYS_REF_TEMP) into the
+        * same VCQ so the key write + HMAC are atomic.
+        */
+       key_dma =3D tctx->key.raw.dma;
+       vcq_add_sys_write(&cmds[idx++], SYS_REF_TEMP, (u64)key_dma,
+                         SYS_REF_NONE, tctx->key.raw.len,
+                         tctx->key.raw.sys_type);
+       key_ref =3D SYS_REF_TEMP;
+       keylen =3D tctx->key.raw.len;
+       d =3D cmh_core_select_instance(CMH_CORE_HC);
+
+       target_mbx =3D d.mbx_idx;
+
+       core_id =3D d.core_id;
+
+       vcq_add_hc_hmac(&cmds[idx++], core_id, key_ref, keylen, info->hc_al=
go);
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
+                                           CMH_HMAC_MAX_PACKED,
+                                           target_mbx,
+                                           cmh_hmac_complete, req,
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
+       cmh_hmac_free_chunks(rctx, tctx);
+       return ret;
+}
+
+static int cmh_hmac_finup(struct ahash_request *req)
+{
+       int ret;
+
+       ret =3D cmh_hmac_update(req);
+       if (ret)
+               return ret;
+
+       return cmh_hmac_final(req);
+}
+
+static int cmh_hmac_digest(struct ahash_request *req)
+{
+       int ret;
+
+       ret =3D cmh_hmac_init(req);
+       if (ret)
+               return ret;
+
+       return cmh_hmac_finup(req);
+}
+
+/*
+ * ahash .export()/.import(): serialize/deserialize the software
+ * accumulation buffer.  No HW state is involved.
+ */
+
+static int cmh_hmac_export(struct ahash_request *req, void *out)
+{
+       struct cmh_hmac_reqctx *rctx =3D ahash_request_ctx(req);
+       struct cmh_hmac_export_state *state =3D out;
+       struct cmh_hmac_chunk *chunk;
+       u32 offset =3D 0;
+
+       if (rctx->total_len > CMH_HMAC_EXPORT_MAX)
+               return -ENOSPC;
+
+       state->total_len =3D rctx->total_len;
+       list_for_each_entry(chunk, &rctx->chunks, list) {
+               memcpy(state->data + offset, chunk->data, chunk->len);
+               offset +=3D chunk->len;
+       }
+       return 0;
+}
+
+static int cmh_hmac_import(struct ahash_request *req, const void *in)
+{
+       struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+       struct cmh_hmac_tfm_ctx *tctx =3D crypto_ahash_ctx(tfm);
+       struct cmh_hmac_reqctx *rctx =3D ahash_request_ctx(req);
+       const struct cmh_hmac_export_state *state =3D in;
+       struct cmh_hmac_chunk *chunk;
+
+       /*
+        * Do NOT call free_chunks() here: the crypto API does not
+        * guarantee the request context is in a valid state before
+        * import(), so the list pointers may be stale or invalid.
+        * Re-initialize from scratch instead.  Any pre-existing chunks
+        * are tracked on tctx->all_chunks and freed in cra_exit.
+        */
+       rctx->info =3D cmh_hmac_get_info(tfm);
+       rctx->error =3D 0;
+       INIT_LIST_HEAD(&rctx->chunks);
+       rctx->num_chunks =3D 0;
+       rctx->total_len =3D 0;
+
+       if (state->total_len > CMH_HMAC_EXPORT_MAX)
+               return -EINVAL;
+
+       if (state->total_len) {
+               chunk =3D kmalloc(sizeof(*chunk) + state->total_len, GFP_KE=
RNEL);
+               if (!chunk)
+                       return -ENOMEM;
+               chunk->len =3D state->total_len;
+               memcpy(chunk->data, state->data, state->total_len);
+               list_add_tail(&chunk->list, &rctx->chunks);
+               spin_lock_bh(&tctx->chunk_lock);
+               list_add_tail(&chunk->tfm_node, &tctx->all_chunks);
+               spin_unlock_bh(&tctx->chunk_lock);
+               rctx->num_chunks =3D 1;
+               rctx->total_len =3D state->total_len;
+       }
+       return 0;
+}
+
+/* Transform init/exit (cra_init/cra_exit) */
+
+static int cmh_hmac_cra_init(struct crypto_tfm *tfm)
+{
+       struct cmh_hmac_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+
+       memset(tctx, 0, sizeof(*tctx));
+       tctx->key.mode =3D CMH_KEY_NONE;
+       spin_lock_init(&tctx->chunk_lock);
+       INIT_LIST_HEAD(&tctx->all_chunks);
+       crypto_ahash_set_reqsize(__crypto_ahash_cast(tfm),
+                                sizeof(struct cmh_hmac_reqctx));
+       return 0;
+}
+
+static void cmh_hmac_cra_exit(struct crypto_tfm *tfm)
+{
+       struct cmh_hmac_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+       struct cmh_hmac_chunk *chunk, *tmp;
+
+       /* Free any orphaned chunks (e.g. testmgr export/reimport poison) *=
/
+       spin_lock_bh(&tctx->chunk_lock);
+       list_for_each_entry_safe(chunk, tmp, &tctx->all_chunks, tfm_node) {
+               list_del(&chunk->tfm_node);
+               kfree_sensitive(chunk);
+       }
+       spin_unlock_bh(&tctx->chunk_lock);
+
+       cmh_key_destroy(&tctx->key);
+}
+
+/* Registration */
+
+static struct cmh_hmac_alg_drv cmh_hmac_drvs[CMH_HMAC_ALG_COUNT];
+
+/**
+ * cmh_hmac_register() - Register HMAC-SHA hash algorithms with the crypto=
 framework
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
+int cmh_hmac_register(void)
+{
+       unsigned int i;
+       int ret;
+
+       for (i =3D 0; i < CMH_HMAC_ALG_COUNT; i++) {
+               const struct cmh_hmac_alg_info *info =3D &cmh_hmac_algs_inf=
o[i];
+               struct cmh_hmac_alg_drv *drv =3D &cmh_hmac_drvs[i];
+               struct ahash_alg *alg =3D &drv->alg;
+
+               drv->info =3D info;
+
+               alg->init   =3D cmh_hmac_init;
+               alg->update =3D cmh_hmac_update;
+               alg->final  =3D cmh_hmac_final;
+               alg->finup  =3D cmh_hmac_finup;
+               alg->digest =3D cmh_hmac_digest;
+               alg->export =3D cmh_hmac_export;
+               alg->import =3D cmh_hmac_import;
+               alg->setkey =3D cmh_hmac_setkey;
+
+               alg->halg.digestsize =3D info->digest_size;
+               alg->halg.statesize  =3D CMH_HMAC_STATE_SIZE;
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
+               alg->halg.base.cra_ctxsize     =3D sizeof(struct cmh_hmac_t=
fm_ctx);
+               alg->halg.base.cra_init        =3D cmh_hmac_cra_init;
+               alg->halg.base.cra_exit        =3D cmh_hmac_cra_exit;
+               alg->halg.base.cra_module      =3D THIS_MODULE;
+
+               ret =3D crypto_register_ahash(alg);
+               if (ret) {
+                       dev_err(cmh_dev(), "hmac: failed to register %s (rc=
=3D%d)\n",
+                               info->drv_name, ret);
+                       while (i--)
+                               crypto_unregister_ahash(&cmh_hmac_drvs[i].a=
lg);
+                       return ret;
+               }
+
+               dev_dbg(cmh_dev(), "hmac: registered %s (priority 300)\n",
+                       info->drv_name);
+       }
+
+       dev_info(cmh_dev(), "hmac: %zu algorithm(s) registered\n",
+                CMH_HMAC_ALG_COUNT);
+       return 0;
+}
+
+/**
+ * cmh_hmac_unregister() - Unregister HMAC-SHA hash algorithms from the cr=
ypto framework
+ */
+void cmh_hmac_unregister(void)
+{
+       unsigned int i;
+
+       for (i =3D 0; i < CMH_HMAC_ALG_COUNT; i++) {
+               crypto_unregister_ahash(&cmh_hmac_drvs[i].alg);
+               dev_dbg(cmh_dev(), "hmac: unregistered %s\n",
+                       cmh_hmac_algs_info[i].drv_name);
+       }
+
+       dev_info(cmh_dev(), "hmac: cleaned up\n");
+}
diff --git a/drivers/crypto/cmh/cmh_main.c b/drivers/crypto/cmh/cmh_main.c
index e8e30b893932..c18219197bd8 100644
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
@@ -197,6 +198,11 @@ static int cmh_probe(struct platform_device *pdev)
        if (ret)
                goto err_hash_register;

+       /* Register HMAC hash algorithms */
+       ret =3D cmh_hmac_register();
+       if (ret)
+               goto err_hmac_register;
+
        /* Register key management device (/dev/cmh_mgmt) */
        ret =3D cmh_mgmt_register();
        if (ret)
@@ -209,6 +215,8 @@ static int cmh_probe(struct platform_device *pdev)
        return 0;

 err_mgmt_register:
+       cmh_hmac_unregister();
+err_hmac_register:
        cmh_hash_unregister();
 err_hash_register:
        cmh_rh_cleanup(cfg);
@@ -237,6 +245,7 @@ static void cmh_remove(struct platform_device *pdev)
        cfg =3D &dev->config;

        cmh_mgmt_unregister();
+       cmh_hmac_unregister();
        cmh_hash_unregister();
        cmh_rh_cleanup(cfg);
        cmh_tm_cleanup();
diff --git a/drivers/crypto/cmh/include/cmh_hmac.h b/drivers/crypto/cmh/inc=
lude/cmh_hmac.h
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


** This message and any attachments are for the sole use of the intended re=
cipient(s). It may contain information that is confidential and privileged.=
 If you are not the intended recipient of this message, you are prohibited =
from printing, copying, forwarding or saving it. Please delete the message =
and attachments and notify the sender immediately. **

Rambus Inc.<http://www.rambus.com>

