Return-Path: <linux-api+bounces-6820-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wb7LANcFUGoisAIAu9opvQ
	(envelope-from <linux-api+bounces-6820-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:31 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6513F7356A7
	for <lists+linux-api@lfdr.de>; Thu, 09 Jul 2026 22:34:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rambus.com header.s=selector1 header.b=KbDd4OfA;
	dmarc=pass (policy=reject) header.from=rambus.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6820-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6820-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 607C23049E02
	for <lists+linux-api@lfdr.de>; Thu,  9 Jul 2026 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7AB3DB629;
	Thu,  9 Jul 2026 20:31:43 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020076.outbound.protection.outlook.com [52.101.201.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071113D16FB;
	Thu,  9 Jul 2026 20:31:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629101; cv=fail; b=lZoLse8xaz3gGtd0scYZ4tm/RU+lcR365zHq7E8ccl388cDiFqlFeaFQY1Z4U1XgZ+2Uj4vgdIvVI+GhdEPvN0Olt24Va4c8DfoqvCY+x9gEcxD+y7vXYgjC47oGjBONTx3OLhGlD657jZB9J6ixyJMJnGPOoHTBZvGnAciIADo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629101; c=relaxed/simple;
	bh=65QZ9WWEelIIT+tQDP4EhzBjbLKFiQqts+6Ths/iU/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSRtg2vrj6xHJ1x/R8Z1dwtAQIZ8Tw2izBU83flTbABRtEarlOvWioN2ofB9KbZ0/W9w9k/0E9Vomh/EseofE+t0a+E8+36akrrLAZw2zxSi19XQm8gdVGd1wUgGVkEYczRoBv6txcUos72xzkYbegj4DTaMj+IzWqhbJdpksDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rambus.com; spf=fail smtp.mailfrom=rambus.com; dkim=pass (2048-bit key) header.d=rambus.com header.i=@rambus.com header.b=KbDd4OfA; arc=fail smtp.client-ip=52.101.201.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s35zFpGgGXGD74I2uwdl3HZMAd9WkzJ1HuMc9DNpUS9as7+jsCVRvxP07WOcZyYZ6lwKJHVB+q0R/Gu1dvd7Iv8VSC3pg4T/ejCwCOTApqrdcGSSRT+ZWW5eJ8rFaZl3Tz7/eayL+EcYE8eIWZhVYaVy1qIU4u4JFqYyy8TyWaTcCqhqa1m7dmbGlAyBeSZ0L3LyKBxgm+c1/WhSNbJU7O0RnLQhc8M3PisxDkVF6lYqDBCYkYxN1vI5RbkUjjxUZuZ/UkqoSxLuOSbQhlxw1NiVLJNUHlNrvcLPmzOC/gAzFmnF2bY+/EFKPTck0ItfAXqHau7vBPxP9WhM/ILVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C+YoEHbqPMwyGF6VAIAX8eBgVvLxXHc3kYgNopp1Tk=;
 b=yX13VyhvTR1zmeMDGKGOnciedOkp+GWLXME0PfBAgQgprxqW/DMrcYiVZu4J4ERNHsdr/QhOQ12zGr0S1VxUnDJhjMKKmpnxcugKHYD7Q/5m+NE93xPG2LW/plwULR8Ud7gVaH4drkvhVMnN2MFT1OuwpX5rY523guN2hx43+OclVEchOwaFhoCYQ+KtirJpyByAeF1VcFsDVMS0dT0fhW26VAMOxeejRpX+k1Gx53ryDbX+YZjxYcSSdwT6VwHlkysktrwGa7fDWVqkNEmNa3gN3Snv9xvCDM3YCqfVDI6UWvoDOrxeYV3foxPrVQvhtorPiseGlDEbD7IoDuC/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.86.86.210) smtp.rcpttodomain=cryptography.com smtp.mailfrom=rambus.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=rambus.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C+YoEHbqPMwyGF6VAIAX8eBgVvLxXHc3kYgNopp1Tk=;
 b=KbDd4OfAgj3iMq4aN9BepfBoGYCVgl4SN5HFkUSXekNENz8XDjv55zF5EqEyBbnNf8HZO46o5k/cxQCq3noYokpMtF+wIP/tcHRJJ4gBm6BPYHstvYPxovuROrqc407nyhvVrkFMDcO63lN9jbM3NdlyxlkclcWUHkHHAFvI6Q07FseVkNpBaISx9ipARAAy8LXx9EKOZD6vzlVQoiqW8Rbs3pqxS24/gCrJ+TvjX3d8WZZBeAw5SM+RKT3J4rZfuZLnfejhoz9mEstZnlz9lSeuQBCLQhh4VU+s1KLIsxUxCnminVvt7GEibUsxMGf2a2i5sQa2erOBgh+PT2afAA==
Received: from SJ0PR13CA0082.namprd13.prod.outlook.com (2603:10b6:a03:2c4::27)
 by SN7PR04MB8461.namprd04.prod.outlook.com (2603:10b6:806:323::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 20:31:27 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::f9) by SJ0PR13CA0082.outlook.office365.com
 (2603:10b6:a03:2c4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Thu, 9
 Jul 2026 20:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.86.86.210)
 smtp.mailfrom=rambus.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=rambus.com;
Received-SPF: Pass (protection.outlook.com: domain of rambus.com designates
 192.86.86.210 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.86.86.210; helo=hqxsv-psmtppxy02.rambus.com; pr=C
Received: from hqxsv-psmtppxy02.rambus.com (192.86.86.210) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 9 Jul 2026 20:31:24 +0000
Received: from hqxsv-cmdev3-skrishnamoorthy.rambus.com (hqn-lb-int-float.rambus.com [10.12.20.20])
	by hqxsv-psmtppxy02.rambus.com (Postfix) with ESMTPS id 8117E180177B;
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
Subject: [PATCH v2 18/19] selftests: crypto: cmh - add kselftest for management ioctl
Date: Thu,  9 Jul 2026 13:30:36 -0700
Message-ID: <20260709203037.1884436-19-skrishnamoorthy@rambus.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|SN7PR04MB8461:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c87c0b8e-b751-40d7-9ccc-08deddf90b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|921020|6133799003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2AVVSXgEZ2D5eG7Ez3Eg5rhZ0PH69f5rSgjSIjkvXaB96DwqemBiYlJz1pXFPIs3lsYMorrGe8e/kr/kD2smXkHrX6bx+TvCD/9+J+OgzieuPk2QRYWIaoxvH6kPwlTGbclPH7NZEwZiHA2rfFdG5NMjvSXmkLCyZc0k6nn+jOPmX+zEopcaPPvePTieO+BMpQ2tqwq7dBj8AM2nbKp/XrcbNLovhQPcwINhrFOSnuzXneE7vLqdlbI74SzOwDyLj7e62SJCRisSHyT9Ox9CymRvbVhdgOTAIpKkNVAmgCCpFyzEuWFDgsiEBFXsMuFNMsSHARrti7tIPAk6NM3vl3kwAcbE01CN6gmCbWjsksaBE4fYJm4vRtBwmmemnRHAa2AgMEguw+6pGEA6VBURqM7OTJe3128+2Om+SntP/OLRWFTj2y29/MYcLBCiaJyMJoHoAFn75q+O/eI2iNukorxXMKiwE7GNEf9welQFI+d69f2z7BW/Ss8teKN+NRUmncLQx2K2Ld3lKLd2DAaaPRsoMl4pAB3SAGPSC2g751rX655y0dl6baWm9jdW5mPNdV89Bwo+BbyqLTwhYAa+YyeIncRxW/+it4QpKs39h8JrI8VbrJwKim+euffJoa8JIzTn5kTZUn3TH+B5nymPGiR4UZXMibbXuPTHsWUbcYN2rbSUp2MHoubpLk5moD+UBmNTNSbEJ2sY/JDyEOBeUl2e4+7YqLt7H1FB0MQQWnSeJsUZPlSEnRlucrmxYL6T
X-Forefront-Antispam-Report:
	CIP:192.86.86.210;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hqxsv-psmtppxy02.rambus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(921020)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SGCrY3A89Jc/ug5lM5TdwaZsL155rdgXqFuhBg1C/X0JdUce8Ug43rgGf1AebHfVrxi8jOMdVTgKLUYv/xUdj7DjbCqC9JBG7H5ZOltZvqk3/Qi05mNu/bnJYQZ2F2hFNJHIixXyb3DRpCcd5vEM2fyNx8i3B4VeDa0cs/P+y2GebyWLtg2JjZ+TIJ2URioTx9HPCGnH0xbllaLjy2UDtIlcAOVxOlyGElu9nkKMTP+yRFQ3L0nD+qpzUVbO/CNhLLfl4aMOuqIC5UA5J7AE/ZDGdEhC4VcDzAWPcjAXGAmLeB4qMdgP1Sdn4p6j08q9lh+FkbQZ+qk46yZ9+xshnc74GIYeKI/mzaibjAL+/+zNovyUA6G/SJ8YSUrcoeMqoa16ftijPwhXrKuEP7Nk6xzdyqIW9cPGzyyfdPTnvuiavwNapK3uJSqbvqbj+DjU
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 20:31:24.0694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c87c0b8e-b751-40d7-9ccc-08deddf90b6e
X-MS-Exchange-CrossTenant-Id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bd0ba799-c2b9-413c-9c56-5d1731c4827c;Ip=[192.86.86.210];Helo=[hqxsv-psmtppxy02.rambus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8461
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
	TAGGED_FROM(0.00)[bounces-6820-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[rambus.com:from_mime,rambus.com:email,rambus.com:mid,rambus.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,req.dk:url,cryptography.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6513F7356A7

From: Alex Ousherovitch <aousherovitch@rambus.com>

Add a minimal kselftest exercising the /dev/cmh_mgmt ioctl interface:

  - open/close the device node
  - invalid ioctl returns -ENOTTY
  - bad version field returns -EINVAL
  - KEY_NEW + KEY_DELETE lifecycle
  - KIC HKDF1 key derivation
  - ML-KEM-768 keygen via hardware RNG

Tests use the kselftest_harness.h fixture framework and output TAP.
Tests that require hardware features not present on the device under
test are gracefully skipped (SKIP).

Co-developed-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Saravanakrishnan Krishnamoorthy <skrishnamoorthy@rambus.com>
Signed-off-by: Alex Ousherovitch <aousherovitch@rambus.com>
Reviewed-by: Joel Wittenauer <Joel.Wittenauer@cryptography.com>
Reviewed-by: Thi Nguyen <thin@rambus.com>
---
 .../selftests/drivers/crypto/cmh/Makefile     |   6 +
 .../drivers/crypto/cmh/cmh_mgmt_test.c        | 183 ++++++++++++++++++
 .../selftests/drivers/crypto/cmh/config       |   1 +
 3 files changed, 190 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/crypto/cmh/Makefile
 create mode 100644 tools/testing/selftests/drivers/crypto/cmh/cmh_mgmt_test.c
 create mode 100644 tools/testing/selftests/drivers/crypto/cmh/config

diff --git a/tools/testing/selftests/drivers/crypto/cmh/Makefile b/tools/testing/selftests/drivers/crypto/cmh/Makefile
new file mode 100644
index 000000000000..86cb63839b27
--- /dev/null
+++ b/tools/testing/selftests/drivers/crypto/cmh/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+TEST_GEN_PROGS := cmh_mgmt_test
+
+CFLAGS += -Wall -Wno-misleading-indentation -O2 $(KHDR_INCLUDES)
+
+include ../../../lib.mk
diff --git a/tools/testing/selftests/drivers/crypto/cmh/cmh_mgmt_test.c b/tools/testing/selftests/drivers/crypto/cmh/cmh_mgmt_test.c
new file mode 100644
index 000000000000..4514b5a1349a
--- /dev/null
+++ b/tools/testing/selftests/drivers/crypto/cmh/cmh_mgmt_test.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kselftest for /dev/cmh_mgmt ioctl interface.
+ *
+ * Tests basic ioctl operations on the CRI CryptoManager Hub management
+ * device.  Requires the cmh module loaded on real or emulated hardware.
+ *
+ * Run:  ./cmh_mgmt_test
+ * Output: TAP format (compatible with kselftest harness)
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+
+#include "kselftest_harness.h"
+#include <linux/cmh_mgmt_ioctl.h>
+
+#define CMH_DEV "/dev/cmh_mgmt"
+
+FIXTURE(cmh_mgmt)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(cmh_mgmt)
+{
+	self->fd = open(CMH_DEV, O_RDWR);
+	if (self->fd < 0 && errno == ENOENT)
+		SKIP(return, "Device " CMH_DEV " not present (module not loaded?)");
+	if (self->fd < 0 && errno == EACCES)
+		SKIP(return, "Permission denied -- run as root or with CAP_SYS_ADMIN");
+	ASSERT_GE(self->fd, 0);
+}
+
+FIXTURE_TEARDOWN(cmh_mgmt)
+{
+	if (self->fd >= 0)
+		close(self->fd);
+}
+
+/*
+ * Test 1: open and close succeed.
+ * If we get here, FIXTURE_SETUP already validated the open.
+ */
+TEST_F(cmh_mgmt, open_close)
+{
+	ASSERT_GE(self->fd, 0);
+}
+
+/*
+ * Test 2: invalid ioctl number returns -ENOTTY.
+ */
+TEST_F(cmh_mgmt, invalid_ioctl)
+{
+	int ret;
+	unsigned long bogus_cmd = _IOC(_IOC_READ, 'J', 0xFF, 4);
+
+	ret = ioctl(self->fd, bogus_cmd, NULL);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, ENOTTY);
+}
+
+/*
+ * Test 3: KEY_NEW with bad version field returns -EINVAL.
+ */
+TEST_F(cmh_mgmt, bad_version)
+{
+	struct cmh_ioctl_key_new req;
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	req.version = 0; /* invalid */
+	req.ds_type = CMH_DS_AES_KEY;
+	req.len = 32;
+	req.flags = CMH_FLAG_PT;
+	req.cid = 0xDEAD;
+
+	ret = ioctl(self->fd, CMH_IOCTL_KEY_NEW, &req);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test 4: KEY_NEW creates a key, KEY_DELETE destroys it.
+ */
+TEST_F(cmh_mgmt, key_new_delete)
+{
+	struct cmh_ioctl_key_new new_req;
+	struct cmh_ioctl_key_grant del_req;
+	int ret;
+
+	memset(&new_req, 0, sizeof(new_req));
+	new_req.version = CMH_MGMT_V1;
+	new_req.ds_type = CMH_DS_AES_KEY;
+	new_req.len = 32;
+	new_req.flags = CMH_FLAG_PT;
+	new_req.cid = 0x5E1F7E57ULL; /* "SELFTEST" */
+
+	ret = ioctl(self->fd, CMH_IOCTL_KEY_NEW, &new_req);
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(new_req.ref, (uint64_t)0);
+
+	/* Delete the key */
+	memset(&del_req, 0, sizeof(del_req));
+	del_req.version = CMH_MGMT_V1;
+	del_req.ref = new_req.ref;
+
+	ret = ioctl(self->fd, CMH_IOCTL_KEY_DELETE, &del_req);
+	ASSERT_EQ(ret, 0);
+}
+
+/*
+ * Test 5: KIC HKDF1 key derivation from hardware base key.
+ * Requires at least one KIC base key provisioned (KIC_KEY1).
+ */
+TEST_F(cmh_mgmt, kic_hkdf1)
+{
+	struct cmh_ioctl_kic_hkdf1 req;
+	static const char label[] = "kselftest-label";
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	req.version = CMH_MGMT_V1;
+	req.key_len = 32;
+	req.base_key = CMH_KIC_KEY1;
+	req.cid = 0x4B534C46ULL; /* "KSLF" */
+	req.label = (uint64_t)(uintptr_t)label;
+	req.label_len = sizeof(label) - 1;
+	req.flags = CMH_KIC_FLAG_TEMP;
+
+	ret = ioctl(self->fd, CMH_IOCTL_KIC_HKDF1, &req);
+	if (ret < 0 && errno == EIO)
+		SKIP(return, "KIC base key 1 not provisioned on this device");
+	ASSERT_EQ(ret, 0);
+	ASSERT_NE(req.ref, (uint64_t)0);
+}
+
+/*
+ * Test 6: ML-KEM-768 keygen using hardware RNG.
+ * Verifies the PQC keygen path end-to-end.
+ */
+TEST_F(cmh_mgmt, ml_kem_keygen)
+{
+	struct cmh_ioctl_ml_kem_keygen req;
+	/* ML-KEM-768: ek = 384*3+32 = 1184, dk = 768*3+96 = 2400 */
+	uint8_t ek[1184];
+	uint8_t dk[2400];
+	int ret;
+
+	memset(&req, 0, sizeof(req));
+	req.version = CMH_MGMT_V1;
+	req.k = 3; /* ML-KEM-768 */
+	req.flags = CMH_QSE_FLAG_HW_RNG;
+	req.seed = 0; /* HW RNG */
+	req.z = 0;    /* HW RNG */
+	req.ek = (uint64_t)(uintptr_t)ek;
+	req.dk = (uint64_t)(uintptr_t)dk;
+	req.dk_cid = 0;
+	req.dk_ref = 0;
+
+	memset(ek, 0, sizeof(ek));
+	memset(dk, 0, sizeof(dk));
+
+	ret = ioctl(self->fd, CMH_IOCTL_ML_KEM_KEYGEN, &req);
+	if (ret < 0 && errno == ENODEV)
+		SKIP(return, "QSE core not available on this hardware");
+	ASSERT_EQ(ret, 0);
+
+	/* Verify output is non-zero (extremely unlikely for random keys) */
+	{
+		int i, nonzero = 0;
+
+		for (i = 0; i < 64; i++)
+			nonzero += (ek[i] != 0);
+		ASSERT_GT(nonzero, 0);
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/drivers/crypto/cmh/config b/tools/testing/selftests/drivers/crypto/cmh/config
new file mode 100644
index 000000000000..063c1dd0e23b
--- /dev/null
+++ b/tools/testing/selftests/drivers/crypto/cmh/config
@@ -0,0 +1 @@
+CONFIG_CRYPTO_DEV_CMH=m
-- 
2.43.7


